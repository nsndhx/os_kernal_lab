#include <proc.h>
#include <kmalloc.h>
#include <string.h>
#include <sync.h>
#include <pmm.h>
#include <error.h>
#include <sched.h>
#include <elf.h>
#include <vmm.h>
#include <trap.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

/* ------------- process/thread mechanism design&implementation -------------
(an simplified Linux process/thread mechanism )
introduction:
  ucore implements a simple process/thread mechanism. process contains the independent memory sapce, at least one threads
for execution, the kernel data(for management), processor state (for context switch), files(in lab6), etc. ucore needs to
manage all these details efficiently. In ucore, a thread is just a special kind of process(share process's memory).
------------------------------
process state       :     meaning               -- reason
    PROC_UNINIT     :   uninitialized           -- alloc_proc
    PROC_SLEEPING   :   sleeping                -- try_free_pages, do_wait, do_sleep
    PROC_RUNNABLE   :   runnable(maybe running) -- proc_init, wakeup_proc, 
    PROC_ZOMBIE     :   almost dead             -- do_exit

-----------------------------
process state changing:
                                            
  alloc_proc                                 RUNNING
      +                                   +--<----<--+
      +                                   + proc_run +
      V                                   +-->---->--+ 
PROC_UNINIT -- proc_init/wakeup_proc --> PROC_RUNNABLE -- try_free_pages/do_wait/do_sleep --> PROC_SLEEPING --
                                           A      +                                                           +
                                           |      +--- do_exit --> PROC_ZOMBIE                                +
                                           +                                                                  + 
                                           -----------------------wakeup_proc----------------------------------
-----------------------------
process relations
parent:           proc->parent  (proc is children)
children:         proc->cptr    (proc is parent)
older sibling:    proc->optr    (proc is younger sibling)
younger sibling:  proc->yptr    (proc is older sibling)
-----------------------------
related syscall for process:
SYS_exit        : process exit,                           -->do_exit
SYS_fork        : create child process, dup mm            -->do_fork-->wakeup_proc
SYS_wait        : wait process                            -->do_wait
SYS_exec        : after fork, process execute a program   -->load a program and refresh the mm
SYS_clone       : create child thread                     -->do_fork-->wakeup_proc
SYS_yield       : process flag itself need resecheduling, -- proc->need_sched=1, then scheduler will rescheule this process
SYS_sleep       : process sleep                           -->do_sleep 
SYS_kill        : kill process                            -->do_kill-->proc->flags |= PF_EXITING
                                                                 -->wakeup_proc-->do_wait-->do_exit   
SYS_getpid      : get the process's pid

*/

// the process set's list
list_entry_t proc_list;

#define HASH_SHIFT          10
#define HASH_LIST_SIZE      (1 << HASH_SHIFT)
#define pid_hashfn(x)       (hash32(x, HASH_SHIFT))

// has list for process set based on pid
static list_entry_t hash_list[HASH_LIST_SIZE];

// idle proc
struct proc_struct *idleproc = NULL;
// init proc
struct proc_struct *initproc = NULL;
// current proc
struct proc_struct *current = NULL;

static int nr_process = 0;

void kernel_thread_entry(void);
void forkrets(struct trapframe *tf);
void switch_to(struct context *from, struct context *to);

/*
整个分配初始化函数的运行过程为：
1.在堆上分配一块内存空间用来存放进程控制块
2.初始化进程控制块内的各个参数
3.返回分配的进程控制块
*/
// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void) {
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
    if (proc != NULL) {
    //LAB4:EXERCISE1 YOUR CODE
    /*
     * below fields in proc_struct need to be initialized
     *       enum proc_state state;                      // Process state
     *       int pid;                                    // Process ID
     *       int runs;                                   // the running times of Proces
     *       uintptr_t kstack;                           // Process kernel stack
     *       volatile bool need_resched;                 // bool value: need to be rescheduled to release CPU?
     *       struct proc_struct *parent;                 // the parent process
     *       struct mm_struct *mm;                       // Process's memory management field
     *       struct context context;                     // Switch here to run process
     *       struct trapframe *tf;                       // Trap frame for current interrupt
     *       uintptr_t cr3;                              // CR3 register: the base addr of Page Directroy Table(PDT)
     *       uint32_t flags;                             // Process flag
     *       char name[PROC_NAME_LEN + 1];               // Process name
     */
        //因为没有分配物理页，故将线程状态初始为初始状态
        proc->state = PROC_UNINIT;
        proc->pid = -1;//id初始化为-1
        proc->runs = 0;//运行时间为0
        proc->kstack = 0;
        proc->need_resched = 0;//不需要释放CPU，因为还没有分配
        proc->parent = NULL;//当前没有父进程，初始为null
        proc->mm = NULL;//当前未分配内存，初始为null
        //用memset非常方便将context变量中的所有成员变量置为0
        //避免了一一赋值的麻烦。
        memset(&(proc->context), 0, sizeof(struct context));
        proc->tf = NULL;//当前没有中断帧,初始为null
        proc->cr3 = boot_cr3;//内核线程，cr3 等于boot_cr3
        proc->flags = 0;
        memset(proc->name, 0, PROC_NAME_LEN);
    }
    return proc;
}

// set_proc_name - set the name of proc
char *
set_proc_name(struct proc_struct *proc, const char *name) {
    memset(proc->name, 0, sizeof(proc->name));
    return memcpy(proc->name, name, PROC_NAME_LEN);
}

// get_proc_name - get the name of proc
char *
get_proc_name(struct proc_struct *proc) {
    static char name[PROC_NAME_LEN + 1];
    memset(name, 0, sizeof(name));
    return memcpy(name, proc->name, PROC_NAME_LEN);
}

// get_pid - alloc a unique pid for process
static int
get_pid(void) {
    static_assert(MAX_PID > MAX_PROCESS);
    struct proc_struct *proc;
    list_entry_t *list = &proc_list, *le;
    static int next_safe = MAX_PID, last_pid = MAX_PID;
    if (++ last_pid >= MAX_PID) {
        last_pid = 1;
        goto inside;
    }
    if (last_pid >= next_safe) {
    inside:
        next_safe = MAX_PID;
    repeat:
        le = list;
        while ((le = list_next(le)) != list) {
            proc = le2proc(le, list_link);
            if (proc->pid == last_pid) {
                if (++ last_pid >= next_safe) {
                    if (last_pid >= MAX_PID) {
                        last_pid = 1;
                    }
                    next_safe = MAX_PID;
                    goto repeat;
                }
            }
            else if (proc->pid > last_pid && next_safe > proc->pid) {
                next_safe = proc->pid;
            }
        }
    }
    return last_pid;
}

// proc_run - make process "proc" running on cpu
// NOTE: before call switch_to, should load  base addr of "proc"'s new PDT
void
proc_run(struct proc_struct *proc) {
    if (proc != current) {
        bool intr_flag;
        struct proc_struct *prev = current, *next = proc;
        local_intr_save(intr_flag);
        {
            current = proc;
            load_esp0(next->kstack + KSTACKSIZE);
            lcr3(next->cr3);
            switch_to(&(prev->context), &(next->context));
        }
        local_intr_restore(intr_flag);
    }
}

// forkret -- the first kernel entry point of a new thread/process
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void) {
    forkrets(current->tf);
}

// hash_proc - add proc into proc hash_list
static void
hash_proc(struct proc_struct *proc) {
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
}

// find_proc - find proc frome proc hash_list according to pid
struct proc_struct *
find_proc(int pid) {
    if (0 < pid && pid < MAX_PID) {
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
        while ((le = list_next(le)) != list) {
            struct proc_struct *proc = le2proc(le, hash_link);
            if (proc->pid == pid) {
                return proc;
            }
        }
    }
    return NULL;
}

// kernel_thread - create a kernel thread using "fn" function
// NOTE: the contents of temp trapframe tf will be copied to 
//       proc->tf in do_fork-->copy_thread function
//创建一个内核线程，并执行参数fn函数，arg作为fn的参数
//调用kernel_thread函数时，需要指定线程的执行入口(例如：init_main)，
//入口函数的参数(例如："Hello world!")，
//以及指定是否需要采取写时复制的机制进行fork时父子进程的内存映射。
int
kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags) {
    struct trapframe tf;
    // 构建一个临时的中断栈帧tf，用于do_fork中的copy_thread函数(因为线程的创建和切换是需要利用CPU中断返回机制的)
    memset(&tf, 0, sizeof(struct trapframe));
    // 设置tf的值
    tf.tf_cs = KERNEL_CS;
    tf.tf_cs = KERNEL_CS; // 内核线程，设置中断栈帧中的代码段寄存器CS指向内核代码段
    tf.tf_ds = tf.tf_es = tf.tf_ss = KERNEL_DS; // 内核线程，设置中断栈帧中的数据段寄存器指向内核数据段
    tf.tf_regs.reg_ebx = (uint32_t)fn; // 设置中断栈帧中的ebx指向fn的地址
    tf.tf_regs.reg_edx = (uint32_t)arg; // 设置中断栈帧中的edx指向arg的起始地址
    tf.tf_eip = (uint32_t)kernel_thread_entry; // 设置tf.eip指向kernel_thread_entry这一统一的初始化的内核线程入口地址
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
}

// setup_kstack - alloc pages with size KSTACKPAGE as process kernel stack
static int
setup_kstack(struct proc_struct *proc) {
    struct Page *page = alloc_pages(KSTACKPAGE);
    if (page != NULL) {
        proc->kstack = (uintptr_t)page2kva(page);
        return 0;
    }
    return -E_NO_MEM;
}

// put_kstack - free the memory space of process kernel stack
static void
put_kstack(struct proc_struct *proc) {
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
}

// copy_mm - process "proc" duplicate OR share process "current"'s mm according clone_flags
//         - if clone_flags & CLONE_VM, then "share" ; else "duplicate"
static int
copy_mm(uint32_t clone_flags, struct proc_struct *proc) {
    assert(current->mm == NULL);
    /* do nothing in this project */
    return 0;
}

// copy_thread - setup the trapframe on the  process's kernel stack top and
//             - setup the kernel entry point and stack of process
static void
copy_thread(struct proc_struct *proc, uintptr_t esp, struct trapframe *tf) {
    // 令proc-tf 指向proc内核栈顶向下偏移一个struct trapframe大小的位置
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
    // 将参数tf中的结构体数据复制填入上述proc->tf指向的位置(正好是上面struct trapframe指针-1腾出来的那部分空间)
    *(proc->tf) = *tf;
    proc->tf->tf_regs.reg_eax = 0;
    proc->tf->tf_esp = esp;
    proc->tf->tf_eflags |= FL_IF;

    // 令proc上下文中的eip指向forkret,切换恢复上下文后，新线程proc便会跳转至forkret
    proc->context.eip = (uintptr_t)forkret;
    // 令proc上下文中的esp指向proc->tf，指向中断返回时的中断栈帧
    proc->context.esp = (uintptr_t)(proc->tf);
}

/* do_fork -     parent process for a new child process
 * @clone_flags: used to guide how to clone the child process
 * @stack:       the parent's user stack pointer. if stack==0, It means to fork a kernel thread.
 * @tf:          the trapframe info, which will be copied to child process's proc->tf
 */
/*
创建一个内核线程需要分配和设置好很多资源。
kernel_thread函数通过调用do_fork函数完成具体内核线程的创建工作。
do_kernel函数会调用alloc_proc函数来分配并初始化一个进程控制块，
但alloc_proc只是找到了一小块内存用以记录进程的必要信息，并没有实际分配这些资源。
ucore一般通过do_fork实际创建新的内核线程。
do_fork的作用是，创建当前内核线程的一个副本，它们的执行上下文、代码、数据都一样，但是存储位置不同。
在这个过程中，需要给新内核线程分配资源，并且复制原进程的状态。
你需要完成在kern/process/proc.c中的do_fork函数中的处理过程。
它的大致执行步骤包括：
    ·调用alloc_proc，首先获得一块用户信息块。
    ·为进程分配一个内核栈。
    ·复制原进程的内存管理信息到新进程（但内核线程不必做此事）
    ·复制原进程上下文到新进程
    ·将新进程添加到进程列表
    ·唤醒新进程
    ·返回新进程号
*/
/*
//创建一个proc并初始化所有成员变量
void alloc_proc(void) 
//为一个内核线程分配物理页
static int setup_kstack(struct proc_struct *proc)
//暂时未看出其用处，可能是之后的lab会用到
static int copy_mm(uint32_t clone_flags, struct proc_struct *proc)
//复制原进程上下文到新进程
static void copy_thread(struct proc_struct *proc, uintptr_t esp, struct trapframe *tf)
//返回一个pid
static int get_pid(void)
//将proc加入到hash_list
static void hash_proc(struct proc_struct *proc)
// 唤醒该线程，即将该线程的状态设置为可以运行
void wakeup_proc(struct proc_struct *proc);
*/
int
do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf) {
    int ret = -E_NO_FREE_PROC;
    struct proc_struct *proc;
    if (nr_process >= MAX_PROCESS) {
        goto fork_out;
    }
    ret = -E_NO_MEM;
    //LAB4:EXERCISE2 YOUR CODE
    /*
     * Some Useful MACROs, Functions and DEFINEs, you can use them in below implementation.
     * MACROs or Functions:
     *   alloc_proc:   create a proc struct and init fields (lab4:exercise1)
     *   setup_kstack: alloc pages with size KSTACKPAGE as process kernel stack
     *   copy_mm:      process "proc" duplicate OR share process "current"'s mm according clone_flags
     *                 if clone_flags & CLONE_VM, then "share" ; else "duplicate"
     *   copy_thread:  setup the trapframe on the  process's kernel stack top and
     *                 setup the kernel entry point and stack of process
     *   hash_proc:    add proc into proc hash_list
     *   get_pid:      alloc a unique pid for process
     *   wakeup_proc:  set proc->state = PROC_RUNNABLE
     * VARIABLES:
     *   proc_list:    the process set's list
     *   nr_process:   the number of process set
     */

    //    1. call alloc_proc to allocate a proc_struct
    //    2. call setup_kstack to allocate a kernel stack for child process
    //    3. call copy_mm to dup OR share mm according clone_flag
    //    4. call copy_thread to setup tf & context in proc_struct
    //    5. insert proc_struct into hash_list && proc_list
    //    6. call wakeup_proc to make the new child process RUNNABLE
    //    7. set ret vaule using child proc's pid

    // 分配一个未初始化的线程控制块
    if ((proc = alloc_proc()) == NULL) {
        goto fork_out;
    }
    // 其父进程属于current当前进程
    proc->parent = current;

    // 设置，分配新线程的内核栈
    if (setup_kstack(proc) != 0) {
        // 分配失败，回滚释放之前所分配的内存
        goto bad_fork_cleanup_proc;
    }
    // 由于是fork，因此fork的一瞬间父子线程的内存空间是一致的（clone_flags决定是否采用写时复制）
    if (copy_mm(clone_flags, proc) != 0) {
        // 分配失败，回滚释放之前所分配的内存
        goto bad_fork_cleanup_kstack;
    }
    // 复制proc线程时，设置proc的上下文信息
    copy_thread(proc, stack, tf);

    bool intr_flag;
    local_intr_save(intr_flag);
    {
        // 生成并设置新的pid
        proc->pid = get_pid();
        // 加入全局线程控制块哈希表
        hash_proc(proc);
        // 加入全局线程控制块双向链表
        list_add(&proc_list, &(proc->list_link));
        nr_process ++;
    }
    local_intr_restore(intr_flag);
    // 唤醒proc，令其处于就绪态PROC_RUNNABLE
    wakeup_proc(proc);

    ret = proc->pid;
fork_out:
    return ret;

bad_fork_cleanup_kstack:
    put_kstack(proc);
bad_fork_cleanup_proc:
    kfree(proc);
    goto fork_out;
}

// do_exit - called by sys_exit
//   1. call exit_mmap & put_pgdir & mm_destroy to free the almost all memory space of process
//   2. set process' state as PROC_ZOMBIE, then call wakeup_proc(parent) to ask parent reclaim itself.
//   3. call scheduler to switch to other process
int
do_exit(int error_code) {
    panic("process exit!!.\n");
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg) {
    cprintf("this initproc, pid = %d, name = \"%s\"\n", current->pid, get_proc_name(current));
    cprintf("To U: \"%s\".\n", (const char *)arg);
    cprintf("To U: \"en.., Bye, Bye. :)\"\n");
    return 0;
}

// proc_init - set up the first kernel thread idleproc "idle" by itself and 
//           - create the second kernel thread init_main
// 初始化第一个内核线程 idle线程、第二个内核线程 init_main线程
//ucore中要创建一个新的内核线程(init_proc)，是通过kernel_thread实现的。
//创建内核线程时，新线程相当于是current当前线程fork出的一个子线程。
void
proc_init(void) {
    int i;

    // 初始化全局的线程控制块双向链表
    list_init(&proc_list);
    // 初始化全局的线程控制块hash表
    for (i = 0; i < HASH_LIST_SIZE; i ++) {
        list_init(hash_list + i);
    }

    // 分配idle线程结构
    if ((idleproc = alloc_proc()) == NULL) {
        panic("cannot alloc idleproc.\n");
    }

    // 为idle线程进行初始化
    idleproc->pid = 0;// idle线程pid作为第一个内核线程，其不会被销毁，pid为0
    idleproc->state = PROC_RUNNABLE;// idle线程被初始化时是就绪状态的
    idleproc->kstack = (uintptr_t)bootstack;// idle线程是第一个线程，其内核栈指向bootstack
    idleproc->need_resched = 1;// idle线程被初始化后，需要马上被调度
    // 设置idle线程的名称
    set_proc_name(idleproc, "idle");
    nr_process ++;

    // current当前执行线程指向idleproc
    current = idleproc;

    // 初始化第二个内核线程initproc， 用于执行init_main函数，参数为"Hello world!!"
    int pid = kernel_thread(init_main, "Hello world!!", 0);
    if (pid <= 0) {
        // 创建init_main线程失败
        panic("create init_main failed.\n");
    }

    // 获得initproc线程控制块
    initproc = find_proc(pid);
    // 设置initproc线程的名称
    set_proc_name(initproc, "init");

    assert(idleproc != NULL && idleproc->pid == 0);
    assert(initproc != NULL && initproc->pid == 1);
}

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void
cpu_idle(void) {
    while (1) {
        if (current->need_resched) {
            schedule();
        }
    }
}

