#ifndef __KERN_PROCESS_PROC_H__
#define __KERN_PROCESS_PROC_H__

#include <defs.h>
#include <list.h>
#include <trap.h>
#include <memlayout.h>


// process's state in his life cycle
enum proc_state {
    PROC_UNINIT = 0,  // uninitialized
    PROC_SLEEPING,    // sleeping
    PROC_RUNNABLE,    // runnable(maybe running)
    PROC_ZOMBIE,      // almost dead, and wait parent proc to reclaim his resource
};

// Saved registers for kernel context switches.
// Don't need to save all the %fs etc. segment registers,
// because they are constant across kernel contexts.
// Save all the regular registers so we don't need to care
// which are caller save, but not the return register %eax.
// (Not saving %eax just simplifies the switching code.)
// The layout of context must match code in switch.S.
struct context {
    uint32_t eip;
    uint32_t esp;
    uint32_t ebx;
    uint32_t ecx;
    uint32_t edx;
    uint32_t esi;
    uint32_t edi;
    uint32_t ebp;
};

#define PROC_NAME_LEN               15
#define MAX_PROCESS                 4096
#define MAX_PID                     (MAX_PROCESS * 2)

extern list_entry_t proc_list;

struct proc_struct {
    /*
    state：进程所处的状态。
        PROC_UNINIT // 未初始状态
        PROC_SLEEPING // 睡眠（阻塞）状态
        PROC_RUNNABLE // 运行与就绪态
        PROC_ZOMBIE // 僵死状态
    */
    enum proc_state state;                      // Process state
    int pid;                                    // Process ID 进程 id 号。
    //运行时间
    int runs;                                   // the running times of Proces
    //内核栈位置 记录了分配给该进程/线程的内核桟的位置。
    uintptr_t kstack;                           // Process kernel stack
    //是否需要调度
    volatile bool need_resched;                 // bool value: need to be rescheduled to release CPU?
    //用户进程的父进程
    struct proc_struct *parent;                 // the parent process
    //即实验三中的描述进程虚拟内存的结构体
    struct mm_struct *mm;                       // Process's memory management field
    //进程的上下文，用于进程切换
    /*
    context作用：
        进程的上下文，用于进程切换。
        主要保存了前一个进程的现场（各个寄存器的状态）。
        在uCore中，所有的进程在内核中也是相对独立的。
        使用context 保存寄存器的目的就在于在内核态中能够进行上下文之间的切换。
        实际利用context进行上下文切换的函数是在kern/process/switch.S中定义switch_to。
    */
    struct context context;                     // Switch here to run process
    //中断帧的指针，总是指向内核栈的某个位置。中断帧记录了进程在被中断前的状态。
    /*
    tf作用：
        中断帧的指针，总是指向内核栈的某个位置：
        当进程从用户空间跳到内核空间时，中断帧记录了进程在被中断前的状态。
        当内核需要跳回用户空间时，需要调整中断帧以恢复让进程继续执行的各寄存器值。
        除此之外，uCore内核允许嵌套中断。
        因此为了保证嵌套中断发生时tf 总是能够指向当前的trapframe，uCore 在内核栈上维护了 tf 的链。
    */
    struct trapframe *tf;                       // Trap frame for current interrupt
    //记录了当前使用的页表的地址
    uintptr_t cr3;                              // CR3 register: the base addr of Page Directroy Table(PDT)
    //进程
    uint32_t flags;                             // Process flag
    //进程名字
    char name[PROC_NAME_LEN + 1];               // Process name
    //进程链表
    list_entry_t list_link;                     // Process link list 
    //进程哈希表
    list_entry_t hash_link;                     // Process hash list
};

#define le2proc(le, member)         \
    to_struct((le), struct proc_struct, member)

extern struct proc_struct *idleproc, *initproc, *current;

void proc_init(void);
void proc_run(struct proc_struct *proc);
int kernel_thread(int (*fn)(void *), void *arg, uint32_t clone_flags);

char *set_proc_name(struct proc_struct *proc, const char *name);
char *get_proc_name(struct proc_struct *proc);
void cpu_idle(void) __attribute__((noreturn));

struct proc_struct *find_proc(int pid);
int do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf);
int do_exit(int error_code);

#endif /* !__KERN_PROCESS_PROC_H__ */

