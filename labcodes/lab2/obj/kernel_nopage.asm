
bin/kernel_nopage：     文件格式 elf32-i386


Disassembly of section .text:

00100000 <kern_entry>:

.text
.globl kern_entry
kern_entry:
    # load pa of boot pgdir
    movl $REALLOC(__boot_pgdir), %eax
  100000:	b8 00 a0 11 40       	mov    $0x4011a000,%eax
    movl %eax, %cr3
  100005:	0f 22 d8             	mov    %eax,%cr3

    # enable paging
    movl %cr0, %eax
  100008:	0f 20 c0             	mov    %cr0,%eax
    orl $(CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_TS | CR0_EM | CR0_MP), %eax
  10000b:	0d 2f 00 05 80       	or     $0x8005002f,%eax
    andl $~(CR0_TS | CR0_EM), %eax
  100010:	83 e0 f3             	and    $0xfffffff3,%eax
    movl %eax, %cr0
  100013:	0f 22 c0             	mov    %eax,%cr0

    # update eip
    # now, eip = 0x1.....
    leal next, %eax
  100016:	8d 05 1e 00 10 00    	lea    0x10001e,%eax
    # set eip = KERNBASE + 0x1.....
    jmp *%eax
  10001c:	ff e0                	jmp    *%eax

0010001e <next>:
next:

    # unmap va 0 ~ 4M, it's temporary mapping
    xorl %eax, %eax
  10001e:	31 c0                	xor    %eax,%eax
    movl %eax, __boot_pgdir
  100020:	a3 00 a0 11 00       	mov    %eax,0x11a000

    # set ebp, esp
    movl $0x0, %ebp
  100025:	bd 00 00 00 00       	mov    $0x0,%ebp
    # the kernel stack region is from bootstack -- bootstacktop,
    # the kernel stack size is KSTACKSIZE (8KB)defined in memlayout.h
    movl $bootstacktop, %esp
  10002a:	bc 00 90 11 00       	mov    $0x119000,%esp
    # now kernel stack is ready , call the first C function
    call kern_init
  10002f:	e8 02 00 00 00       	call   100036 <kern_init>

00100034 <spin>:

# should never get here
spin:
    jmp spin
  100034:	eb fe                	jmp    100034 <spin>

00100036 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100036:	f3 0f 1e fb          	endbr32 
  10003a:	55                   	push   %ebp
  10003b:	89 e5                	mov    %esp,%ebp
  10003d:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100040:	b8 28 cf 11 00       	mov    $0x11cf28,%eax
  100045:	2d 36 9a 11 00       	sub    $0x119a36,%eax
  10004a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10004e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100055:	00 
  100056:	c7 04 24 36 9a 11 00 	movl   $0x119a36,(%esp)
  10005d:	e8 5f 58 00 00       	call   1058c1 <memset>

    cons_init();                // init the console
  100062:	e8 9d 15 00 00       	call   101604 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100067:	c7 45 f4 00 61 10 00 	movl   $0x106100,-0xc(%ebp)
    cprintf("%s\n\n", message);
  10006e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100071:	89 44 24 04          	mov    %eax,0x4(%esp)
  100075:	c7 04 24 1c 61 10 00 	movl   $0x10611c,(%esp)
  10007c:	e8 48 02 00 00       	call   1002c9 <cprintf>

    print_kerninfo();
  100081:	e8 06 09 00 00       	call   10098c <print_kerninfo>

    grade_backtrace();
  100086:	e8 9a 00 00 00       	call   100125 <grade_backtrace>

    pmm_init();                 // init physical memory management
  10008b:	e8 58 32 00 00       	call   1032e8 <pmm_init>

    pic_init();                 // init interrupt controller
  100090:	e8 ea 16 00 00       	call   10177f <pic_init>
    idt_init();                 // init interrupt descriptor table
  100095:	e8 8f 18 00 00       	call   101929 <idt_init>

    clock_init();               // init clock interrupt
  10009a:	e8 ac 0c 00 00       	call   100d4b <clock_init>
    intr_enable();              // enable irq interrupt
  10009f:	e8 27 18 00 00       	call   1018cb <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  1000a4:	e8 86 01 00 00       	call   10022f <lab1_switch_test>

    /* do nothing */
    while (1);
  1000a9:	eb fe                	jmp    1000a9 <kern_init+0x73>

001000ab <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  1000ab:	f3 0f 1e fb          	endbr32 
  1000af:	55                   	push   %ebp
  1000b0:	89 e5                	mov    %esp,%ebp
  1000b2:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  1000b5:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1000bc:	00 
  1000bd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1000c4:	00 
  1000c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1000cc:	e8 64 0c 00 00       	call   100d35 <mon_backtrace>
}
  1000d1:	90                   	nop
  1000d2:	c9                   	leave  
  1000d3:	c3                   	ret    

001000d4 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  1000d4:	f3 0f 1e fb          	endbr32 
  1000d8:	55                   	push   %ebp
  1000d9:	89 e5                	mov    %esp,%ebp
  1000db:	53                   	push   %ebx
  1000dc:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000df:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  1000e2:	8b 55 0c             	mov    0xc(%ebp),%edx
  1000e5:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000e8:	8b 45 08             	mov    0x8(%ebp),%eax
  1000eb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1000ef:	89 54 24 08          	mov    %edx,0x8(%esp)
  1000f3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1000f7:	89 04 24             	mov    %eax,(%esp)
  1000fa:	e8 ac ff ff ff       	call   1000ab <grade_backtrace2>
}
  1000ff:	90                   	nop
  100100:	83 c4 14             	add    $0x14,%esp
  100103:	5b                   	pop    %ebx
  100104:	5d                   	pop    %ebp
  100105:	c3                   	ret    

00100106 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  100106:	f3 0f 1e fb          	endbr32 
  10010a:	55                   	push   %ebp
  10010b:	89 e5                	mov    %esp,%ebp
  10010d:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  100110:	8b 45 10             	mov    0x10(%ebp),%eax
  100113:	89 44 24 04          	mov    %eax,0x4(%esp)
  100117:	8b 45 08             	mov    0x8(%ebp),%eax
  10011a:	89 04 24             	mov    %eax,(%esp)
  10011d:	e8 b2 ff ff ff       	call   1000d4 <grade_backtrace1>
}
  100122:	90                   	nop
  100123:	c9                   	leave  
  100124:	c3                   	ret    

00100125 <grade_backtrace>:

void
grade_backtrace(void) {
  100125:	f3 0f 1e fb          	endbr32 
  100129:	55                   	push   %ebp
  10012a:	89 e5                	mov    %esp,%ebp
  10012c:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  10012f:	b8 36 00 10 00       	mov    $0x100036,%eax
  100134:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  10013b:	ff 
  10013c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100140:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100147:	e8 ba ff ff ff       	call   100106 <grade_backtrace0>
}
  10014c:	90                   	nop
  10014d:	c9                   	leave  
  10014e:	c3                   	ret    

0010014f <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  10014f:	f3 0f 1e fb          	endbr32 
  100153:	55                   	push   %ebp
  100154:	89 e5                	mov    %esp,%ebp
  100156:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100159:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  10015c:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  10015f:	8c 45 f2             	mov    %es,-0xe(%ebp)
  100162:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100165:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100169:	83 e0 03             	and    $0x3,%eax
  10016c:	89 c2                	mov    %eax,%edx
  10016e:	a1 00 c0 11 00       	mov    0x11c000,%eax
  100173:	89 54 24 08          	mov    %edx,0x8(%esp)
  100177:	89 44 24 04          	mov    %eax,0x4(%esp)
  10017b:	c7 04 24 21 61 10 00 	movl   $0x106121,(%esp)
  100182:	e8 42 01 00 00       	call   1002c9 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100187:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10018b:	89 c2                	mov    %eax,%edx
  10018d:	a1 00 c0 11 00       	mov    0x11c000,%eax
  100192:	89 54 24 08          	mov    %edx,0x8(%esp)
  100196:	89 44 24 04          	mov    %eax,0x4(%esp)
  10019a:	c7 04 24 2f 61 10 00 	movl   $0x10612f,(%esp)
  1001a1:	e8 23 01 00 00       	call   1002c9 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  1001a6:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  1001aa:	89 c2                	mov    %eax,%edx
  1001ac:	a1 00 c0 11 00       	mov    0x11c000,%eax
  1001b1:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001b5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001b9:	c7 04 24 3d 61 10 00 	movl   $0x10613d,(%esp)
  1001c0:	e8 04 01 00 00       	call   1002c9 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  1001c5:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  1001c9:	89 c2                	mov    %eax,%edx
  1001cb:	a1 00 c0 11 00       	mov    0x11c000,%eax
  1001d0:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001d4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001d8:	c7 04 24 4b 61 10 00 	movl   $0x10614b,(%esp)
  1001df:	e8 e5 00 00 00       	call   1002c9 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  1001e4:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001e8:	89 c2                	mov    %eax,%edx
  1001ea:	a1 00 c0 11 00       	mov    0x11c000,%eax
  1001ef:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001f7:	c7 04 24 59 61 10 00 	movl   $0x106159,(%esp)
  1001fe:	e8 c6 00 00 00       	call   1002c9 <cprintf>
    round ++;
  100203:	a1 00 c0 11 00       	mov    0x11c000,%eax
  100208:	40                   	inc    %eax
  100209:	a3 00 c0 11 00       	mov    %eax,0x11c000
}
  10020e:	90                   	nop
  10020f:	c9                   	leave  
  100210:	c3                   	ret    

00100211 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  100211:	f3 0f 1e fb          	endbr32 
  100215:	55                   	push   %ebp
  100216:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
    //中断处理例程处于ring 0,所以内核态发生的中断不发生堆栈切换，因此SS、ESP不会自动压栈;但是是否弹出SS、ESP确实由堆栈上的CS中的特权位决定的。当我们将堆栈中的CS的特权位设置为ring 3时，IRET会误认为中断是从ring 3发生的，执行时会按照发生特权级切换的情况弹出SS、ESP。
    //利用这个特性，只需要手动地将内核堆栈布局设置为发生了特权级转换时的布局，将所有的特权位修改为DPL_USER,保持EIP、ESP不变，IRET执行后就可以切换为应用态。
    //因为从内核态发生中断不压入SS、ESP，所以在中断前手动压入SS、ESP。中断处理过程中会修改tf->tf_esp的值，中断发生前压入的SS实际不会被使用，所以代码中仅仅是压入了%ss占位。
    //为了在切换为应用态后，保存原有堆栈结构不变，确保程序正确运行，栈顶的位置应该被恢复到中断发生前的位置。SS、ESP是通过push指令压栈的，压入SS后，ESP的值已经上移了4个字节，所以在trap_dispatch将ESP下移4字节。
    asm volatile (
  100218:	16                   	push   %ss
  100219:	54                   	push   %esp
  10021a:	cd 78                	int    $0x78
  10021c:	89 ec                	mov    %ebp,%esp
        "int %0 \n"
        "movl %%ebp, %%esp"
        : 
        : "i"(T_SWITCH_TOU)
    );
}
  10021e:	90                   	nop
  10021f:	5d                   	pop    %ebp
  100220:	c3                   	ret    

00100221 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  100221:	f3 0f 1e fb          	endbr32 
  100225:	55                   	push   %ebp
  100226:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
    //在用户态发生中断时堆栈会从用户栈切换到内核栈，并压入SS、ESP等寄存器。在篡改内核堆栈后IRET返回时会误认为没有特权级转换发生，不会把SS、ESP弹出，因此从用户态切换到内核态时需要手动弹出SS、ESP。
    //tf->tf_esp指向发生中断前用户栈栈顶，IRET执行后程序仍处于内核态
    asm volatile (
  100228:	cd 79                	int    $0x79
  10022a:	89 ec                	mov    %ebp,%esp
        "int %0 \n"
        "movl %%ebp, %%esp \n"
        : 
        : "i"(T_SWITCH_TOK)
    );
}
  10022c:	90                   	nop
  10022d:	5d                   	pop    %ebp
  10022e:	c3                   	ret    

0010022f <lab1_switch_test>:

static void
lab1_switch_test(void) {
  10022f:	f3 0f 1e fb          	endbr32 
  100233:	55                   	push   %ebp
  100234:	89 e5                	mov    %esp,%ebp
  100236:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();//print 当前 cs/ss/ds 等寄存器状态
  100239:	e8 11 ff ff ff       	call   10014f <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  10023e:	c7 04 24 68 61 10 00 	movl   $0x106168,(%esp)
  100245:	e8 7f 00 00 00       	call   1002c9 <cprintf>
    lab1_switch_to_user();
  10024a:	e8 c2 ff ff ff       	call   100211 <lab1_switch_to_user>
    lab1_print_cur_status();
  10024f:	e8 fb fe ff ff       	call   10014f <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  100254:	c7 04 24 88 61 10 00 	movl   $0x106188,(%esp)
  10025b:	e8 69 00 00 00       	call   1002c9 <cprintf>
    lab1_switch_to_kernel();
  100260:	e8 bc ff ff ff       	call   100221 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100265:	e8 e5 fe ff ff       	call   10014f <lab1_print_cur_status>
}
  10026a:	90                   	nop
  10026b:	c9                   	leave  
  10026c:	c3                   	ret    

0010026d <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  10026d:	f3 0f 1e fb          	endbr32 
  100271:	55                   	push   %ebp
  100272:	89 e5                	mov    %esp,%ebp
  100274:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  100277:	8b 45 08             	mov    0x8(%ebp),%eax
  10027a:	89 04 24             	mov    %eax,(%esp)
  10027d:	e8 b3 13 00 00       	call   101635 <cons_putc>
    (*cnt) ++;
  100282:	8b 45 0c             	mov    0xc(%ebp),%eax
  100285:	8b 00                	mov    (%eax),%eax
  100287:	8d 50 01             	lea    0x1(%eax),%edx
  10028a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10028d:	89 10                	mov    %edx,(%eax)
}
  10028f:	90                   	nop
  100290:	c9                   	leave  
  100291:	c3                   	ret    

00100292 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  100292:	f3 0f 1e fb          	endbr32 
  100296:	55                   	push   %ebp
  100297:	89 e5                	mov    %esp,%ebp
  100299:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  10029c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  1002a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002a6:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1002aa:	8b 45 08             	mov    0x8(%ebp),%eax
  1002ad:	89 44 24 08          	mov    %eax,0x8(%esp)
  1002b1:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1002b4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1002b8:	c7 04 24 6d 02 10 00 	movl   $0x10026d,(%esp)
  1002bf:	e8 69 59 00 00       	call   105c2d <vprintfmt>
    return cnt;
  1002c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002c7:	c9                   	leave  
  1002c8:	c3                   	ret    

001002c9 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  1002c9:	f3 0f 1e fb          	endbr32 
  1002cd:	55                   	push   %ebp
  1002ce:	89 e5                	mov    %esp,%ebp
  1002d0:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  1002d3:	8d 45 0c             	lea    0xc(%ebp),%eax
  1002d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  1002d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002dc:	89 44 24 04          	mov    %eax,0x4(%esp)
  1002e0:	8b 45 08             	mov    0x8(%ebp),%eax
  1002e3:	89 04 24             	mov    %eax,(%esp)
  1002e6:	e8 a7 ff ff ff       	call   100292 <vcprintf>
  1002eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  1002ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002f1:	c9                   	leave  
  1002f2:	c3                   	ret    

001002f3 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  1002f3:	f3 0f 1e fb          	endbr32 
  1002f7:	55                   	push   %ebp
  1002f8:	89 e5                	mov    %esp,%ebp
  1002fa:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002fd:	8b 45 08             	mov    0x8(%ebp),%eax
  100300:	89 04 24             	mov    %eax,(%esp)
  100303:	e8 2d 13 00 00       	call   101635 <cons_putc>
}
  100308:	90                   	nop
  100309:	c9                   	leave  
  10030a:	c3                   	ret    

0010030b <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  10030b:	f3 0f 1e fb          	endbr32 
  10030f:	55                   	push   %ebp
  100310:	89 e5                	mov    %esp,%ebp
  100312:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100315:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  10031c:	eb 13                	jmp    100331 <cputs+0x26>
        cputch(c, &cnt);
  10031e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  100322:	8d 55 f0             	lea    -0x10(%ebp),%edx
  100325:	89 54 24 04          	mov    %edx,0x4(%esp)
  100329:	89 04 24             	mov    %eax,(%esp)
  10032c:	e8 3c ff ff ff       	call   10026d <cputch>
    while ((c = *str ++) != '\0') {
  100331:	8b 45 08             	mov    0x8(%ebp),%eax
  100334:	8d 50 01             	lea    0x1(%eax),%edx
  100337:	89 55 08             	mov    %edx,0x8(%ebp)
  10033a:	0f b6 00             	movzbl (%eax),%eax
  10033d:	88 45 f7             	mov    %al,-0x9(%ebp)
  100340:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  100344:	75 d8                	jne    10031e <cputs+0x13>
    }
    cputch('\n', &cnt);
  100346:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100349:	89 44 24 04          	mov    %eax,0x4(%esp)
  10034d:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  100354:	e8 14 ff ff ff       	call   10026d <cputch>
    return cnt;
  100359:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  10035c:	c9                   	leave  
  10035d:	c3                   	ret    

0010035e <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  10035e:	f3 0f 1e fb          	endbr32 
  100362:	55                   	push   %ebp
  100363:	89 e5                	mov    %esp,%ebp
  100365:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  100368:	90                   	nop
  100369:	e8 08 13 00 00       	call   101676 <cons_getc>
  10036e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100371:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100375:	74 f2                	je     100369 <getchar+0xb>
        /* do nothing */;
    return c;
  100377:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10037a:	c9                   	leave  
  10037b:	c3                   	ret    

0010037c <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  10037c:	f3 0f 1e fb          	endbr32 
  100380:	55                   	push   %ebp
  100381:	89 e5                	mov    %esp,%ebp
  100383:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  100386:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10038a:	74 13                	je     10039f <readline+0x23>
        cprintf("%s", prompt);
  10038c:	8b 45 08             	mov    0x8(%ebp),%eax
  10038f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100393:	c7 04 24 a7 61 10 00 	movl   $0x1061a7,(%esp)
  10039a:	e8 2a ff ff ff       	call   1002c9 <cprintf>
    }
    int i = 0, c;
  10039f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  1003a6:	e8 b3 ff ff ff       	call   10035e <getchar>
  1003ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  1003ae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1003b2:	79 07                	jns    1003bb <readline+0x3f>
            return NULL;
  1003b4:	b8 00 00 00 00       	mov    $0x0,%eax
  1003b9:	eb 78                	jmp    100433 <readline+0xb7>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  1003bb:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  1003bf:	7e 28                	jle    1003e9 <readline+0x6d>
  1003c1:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  1003c8:	7f 1f                	jg     1003e9 <readline+0x6d>
            cputchar(c);
  1003ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003cd:	89 04 24             	mov    %eax,(%esp)
  1003d0:	e8 1e ff ff ff       	call   1002f3 <cputchar>
            buf[i ++] = c;
  1003d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003d8:	8d 50 01             	lea    0x1(%eax),%edx
  1003db:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1003de:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1003e1:	88 90 20 c0 11 00    	mov    %dl,0x11c020(%eax)
  1003e7:	eb 45                	jmp    10042e <readline+0xb2>
        }
        else if (c == '\b' && i > 0) {
  1003e9:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  1003ed:	75 16                	jne    100405 <readline+0x89>
  1003ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003f3:	7e 10                	jle    100405 <readline+0x89>
            cputchar(c);
  1003f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003f8:	89 04 24             	mov    %eax,(%esp)
  1003fb:	e8 f3 fe ff ff       	call   1002f3 <cputchar>
            i --;
  100400:	ff 4d f4             	decl   -0xc(%ebp)
  100403:	eb 29                	jmp    10042e <readline+0xb2>
        }
        else if (c == '\n' || c == '\r') {
  100405:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  100409:	74 06                	je     100411 <readline+0x95>
  10040b:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  10040f:	75 95                	jne    1003a6 <readline+0x2a>
            cputchar(c);
  100411:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100414:	89 04 24             	mov    %eax,(%esp)
  100417:	e8 d7 fe ff ff       	call   1002f3 <cputchar>
            buf[i] = '\0';
  10041c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10041f:	05 20 c0 11 00       	add    $0x11c020,%eax
  100424:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  100427:	b8 20 c0 11 00       	mov    $0x11c020,%eax
  10042c:	eb 05                	jmp    100433 <readline+0xb7>
        c = getchar();
  10042e:	e9 73 ff ff ff       	jmp    1003a6 <readline+0x2a>
        }
    }
}
  100433:	c9                   	leave  
  100434:	c3                   	ret    

00100435 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  100435:	f3 0f 1e fb          	endbr32 
  100439:	55                   	push   %ebp
  10043a:	89 e5                	mov    %esp,%ebp
  10043c:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  10043f:	a1 20 c4 11 00       	mov    0x11c420,%eax
  100444:	85 c0                	test   %eax,%eax
  100446:	75 5b                	jne    1004a3 <__panic+0x6e>
        goto panic_dead;
    }
    is_panic = 1;
  100448:	c7 05 20 c4 11 00 01 	movl   $0x1,0x11c420
  10044f:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100452:	8d 45 14             	lea    0x14(%ebp),%eax
  100455:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100458:	8b 45 0c             	mov    0xc(%ebp),%eax
  10045b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10045f:	8b 45 08             	mov    0x8(%ebp),%eax
  100462:	89 44 24 04          	mov    %eax,0x4(%esp)
  100466:	c7 04 24 aa 61 10 00 	movl   $0x1061aa,(%esp)
  10046d:	e8 57 fe ff ff       	call   1002c9 <cprintf>
    vcprintf(fmt, ap);
  100472:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100475:	89 44 24 04          	mov    %eax,0x4(%esp)
  100479:	8b 45 10             	mov    0x10(%ebp),%eax
  10047c:	89 04 24             	mov    %eax,(%esp)
  10047f:	e8 0e fe ff ff       	call   100292 <vcprintf>
    cprintf("\n");
  100484:	c7 04 24 c6 61 10 00 	movl   $0x1061c6,(%esp)
  10048b:	e8 39 fe ff ff       	call   1002c9 <cprintf>
    
    cprintf("stack trackback:\n");
  100490:	c7 04 24 c8 61 10 00 	movl   $0x1061c8,(%esp)
  100497:	e8 2d fe ff ff       	call   1002c9 <cprintf>
    print_stackframe();
  10049c:	e8 3d 06 00 00       	call   100ade <print_stackframe>
  1004a1:	eb 01                	jmp    1004a4 <__panic+0x6f>
        goto panic_dead;
  1004a3:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  1004a4:	e8 2e 14 00 00       	call   1018d7 <intr_disable>
    while (1) {
        kmonitor(NULL);
  1004a9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1004b0:	e8 a7 07 00 00       	call   100c5c <kmonitor>
  1004b5:	eb f2                	jmp    1004a9 <__panic+0x74>

001004b7 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  1004b7:	f3 0f 1e fb          	endbr32 
  1004bb:	55                   	push   %ebp
  1004bc:	89 e5                	mov    %esp,%ebp
  1004be:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  1004c1:	8d 45 14             	lea    0x14(%ebp),%eax
  1004c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  1004c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004ca:	89 44 24 08          	mov    %eax,0x8(%esp)
  1004ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1004d1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004d5:	c7 04 24 da 61 10 00 	movl   $0x1061da,(%esp)
  1004dc:	e8 e8 fd ff ff       	call   1002c9 <cprintf>
    vcprintf(fmt, ap);
  1004e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004e8:	8b 45 10             	mov    0x10(%ebp),%eax
  1004eb:	89 04 24             	mov    %eax,(%esp)
  1004ee:	e8 9f fd ff ff       	call   100292 <vcprintf>
    cprintf("\n");
  1004f3:	c7 04 24 c6 61 10 00 	movl   $0x1061c6,(%esp)
  1004fa:	e8 ca fd ff ff       	call   1002c9 <cprintf>
    va_end(ap);
}
  1004ff:	90                   	nop
  100500:	c9                   	leave  
  100501:	c3                   	ret    

00100502 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  100502:	f3 0f 1e fb          	endbr32 
  100506:	55                   	push   %ebp
  100507:	89 e5                	mov    %esp,%ebp
    return is_panic;
  100509:	a1 20 c4 11 00       	mov    0x11c420,%eax
}
  10050e:	5d                   	pop    %ebp
  10050f:	c3                   	ret    

00100510 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  100510:	f3 0f 1e fb          	endbr32 
  100514:	55                   	push   %ebp
  100515:	89 e5                	mov    %esp,%ebp
  100517:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  10051a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10051d:	8b 00                	mov    (%eax),%eax
  10051f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100522:	8b 45 10             	mov    0x10(%ebp),%eax
  100525:	8b 00                	mov    (%eax),%eax
  100527:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10052a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  100531:	e9 ca 00 00 00       	jmp    100600 <stab_binsearch+0xf0>
        int true_m = (l + r) / 2, m = true_m;
  100536:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100539:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10053c:	01 d0                	add    %edx,%eax
  10053e:	89 c2                	mov    %eax,%edx
  100540:	c1 ea 1f             	shr    $0x1f,%edx
  100543:	01 d0                	add    %edx,%eax
  100545:	d1 f8                	sar    %eax
  100547:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10054a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10054d:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100550:	eb 03                	jmp    100555 <stab_binsearch+0x45>
            m --;
  100552:	ff 4d f0             	decl   -0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  100555:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100558:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10055b:	7c 1f                	jl     10057c <stab_binsearch+0x6c>
  10055d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100560:	89 d0                	mov    %edx,%eax
  100562:	01 c0                	add    %eax,%eax
  100564:	01 d0                	add    %edx,%eax
  100566:	c1 e0 02             	shl    $0x2,%eax
  100569:	89 c2                	mov    %eax,%edx
  10056b:	8b 45 08             	mov    0x8(%ebp),%eax
  10056e:	01 d0                	add    %edx,%eax
  100570:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100574:	0f b6 c0             	movzbl %al,%eax
  100577:	39 45 14             	cmp    %eax,0x14(%ebp)
  10057a:	75 d6                	jne    100552 <stab_binsearch+0x42>
        }
        if (m < l) {    // no match in [l, m]
  10057c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10057f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100582:	7d 09                	jge    10058d <stab_binsearch+0x7d>
            l = true_m + 1;
  100584:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100587:	40                   	inc    %eax
  100588:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  10058b:	eb 73                	jmp    100600 <stab_binsearch+0xf0>
        }

        // actual binary search
        any_matches = 1;
  10058d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100594:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100597:	89 d0                	mov    %edx,%eax
  100599:	01 c0                	add    %eax,%eax
  10059b:	01 d0                	add    %edx,%eax
  10059d:	c1 e0 02             	shl    $0x2,%eax
  1005a0:	89 c2                	mov    %eax,%edx
  1005a2:	8b 45 08             	mov    0x8(%ebp),%eax
  1005a5:	01 d0                	add    %edx,%eax
  1005a7:	8b 40 08             	mov    0x8(%eax),%eax
  1005aa:	39 45 18             	cmp    %eax,0x18(%ebp)
  1005ad:	76 11                	jbe    1005c0 <stab_binsearch+0xb0>
            *region_left = m;
  1005af:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005b2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005b5:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  1005b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1005ba:	40                   	inc    %eax
  1005bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1005be:	eb 40                	jmp    100600 <stab_binsearch+0xf0>
        } else if (stabs[m].n_value > addr) {
  1005c0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005c3:	89 d0                	mov    %edx,%eax
  1005c5:	01 c0                	add    %eax,%eax
  1005c7:	01 d0                	add    %edx,%eax
  1005c9:	c1 e0 02             	shl    $0x2,%eax
  1005cc:	89 c2                	mov    %eax,%edx
  1005ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1005d1:	01 d0                	add    %edx,%eax
  1005d3:	8b 40 08             	mov    0x8(%eax),%eax
  1005d6:	39 45 18             	cmp    %eax,0x18(%ebp)
  1005d9:	73 14                	jae    1005ef <stab_binsearch+0xdf>
            *region_right = m - 1;
  1005db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005de:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005e1:	8b 45 10             	mov    0x10(%ebp),%eax
  1005e4:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  1005e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005e9:	48                   	dec    %eax
  1005ea:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1005ed:	eb 11                	jmp    100600 <stab_binsearch+0xf0>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1005ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005f2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005f5:	89 10                	mov    %edx,(%eax)
            l = m;
  1005f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1005fd:	ff 45 18             	incl   0x18(%ebp)
    while (l <= r) {
  100600:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100603:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  100606:	0f 8e 2a ff ff ff    	jle    100536 <stab_binsearch+0x26>
        }
    }

    if (!any_matches) {
  10060c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100610:	75 0f                	jne    100621 <stab_binsearch+0x111>
        *region_right = *region_left - 1;
  100612:	8b 45 0c             	mov    0xc(%ebp),%eax
  100615:	8b 00                	mov    (%eax),%eax
  100617:	8d 50 ff             	lea    -0x1(%eax),%edx
  10061a:	8b 45 10             	mov    0x10(%ebp),%eax
  10061d:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  10061f:	eb 3e                	jmp    10065f <stab_binsearch+0x14f>
        l = *region_right;
  100621:	8b 45 10             	mov    0x10(%ebp),%eax
  100624:	8b 00                	mov    (%eax),%eax
  100626:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  100629:	eb 03                	jmp    10062e <stab_binsearch+0x11e>
  10062b:	ff 4d fc             	decl   -0x4(%ebp)
  10062e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100631:	8b 00                	mov    (%eax),%eax
  100633:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  100636:	7e 1f                	jle    100657 <stab_binsearch+0x147>
  100638:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10063b:	89 d0                	mov    %edx,%eax
  10063d:	01 c0                	add    %eax,%eax
  10063f:	01 d0                	add    %edx,%eax
  100641:	c1 e0 02             	shl    $0x2,%eax
  100644:	89 c2                	mov    %eax,%edx
  100646:	8b 45 08             	mov    0x8(%ebp),%eax
  100649:	01 d0                	add    %edx,%eax
  10064b:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10064f:	0f b6 c0             	movzbl %al,%eax
  100652:	39 45 14             	cmp    %eax,0x14(%ebp)
  100655:	75 d4                	jne    10062b <stab_binsearch+0x11b>
        *region_left = l;
  100657:	8b 45 0c             	mov    0xc(%ebp),%eax
  10065a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  10065d:	89 10                	mov    %edx,(%eax)
}
  10065f:	90                   	nop
  100660:	c9                   	leave  
  100661:	c3                   	ret    

00100662 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100662:	f3 0f 1e fb          	endbr32 
  100666:	55                   	push   %ebp
  100667:	89 e5                	mov    %esp,%ebp
  100669:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  10066c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10066f:	c7 00 f8 61 10 00    	movl   $0x1061f8,(%eax)
    info->eip_line = 0;
  100675:	8b 45 0c             	mov    0xc(%ebp),%eax
  100678:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  10067f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100682:	c7 40 08 f8 61 10 00 	movl   $0x1061f8,0x8(%eax)
    info->eip_fn_namelen = 9;
  100689:	8b 45 0c             	mov    0xc(%ebp),%eax
  10068c:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100693:	8b 45 0c             	mov    0xc(%ebp),%eax
  100696:	8b 55 08             	mov    0x8(%ebp),%edx
  100699:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  10069c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10069f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  1006a6:	c7 45 f4 20 74 10 00 	movl   $0x107420,-0xc(%ebp)
    stab_end = __STAB_END__;
  1006ad:	c7 45 f0 e8 3b 11 00 	movl   $0x113be8,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  1006b4:	c7 45 ec e9 3b 11 00 	movl   $0x113be9,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  1006bb:	c7 45 e8 ee 66 11 00 	movl   $0x1166ee,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  1006c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1006c5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  1006c8:	76 0b                	jbe    1006d5 <debuginfo_eip+0x73>
  1006ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1006cd:	48                   	dec    %eax
  1006ce:	0f b6 00             	movzbl (%eax),%eax
  1006d1:	84 c0                	test   %al,%al
  1006d3:	74 0a                	je     1006df <debuginfo_eip+0x7d>
        return -1;
  1006d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006da:	e9 ab 02 00 00       	jmp    10098a <debuginfo_eip+0x328>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  1006df:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1006e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006e9:	2b 45 f4             	sub    -0xc(%ebp),%eax
  1006ec:	c1 f8 02             	sar    $0x2,%eax
  1006ef:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1006f5:	48                   	dec    %eax
  1006f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1006f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1006fc:	89 44 24 10          	mov    %eax,0x10(%esp)
  100700:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  100707:	00 
  100708:	8d 45 e0             	lea    -0x20(%ebp),%eax
  10070b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10070f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  100712:	89 44 24 04          	mov    %eax,0x4(%esp)
  100716:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100719:	89 04 24             	mov    %eax,(%esp)
  10071c:	e8 ef fd ff ff       	call   100510 <stab_binsearch>
    if (lfile == 0)
  100721:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100724:	85 c0                	test   %eax,%eax
  100726:	75 0a                	jne    100732 <debuginfo_eip+0xd0>
        return -1;
  100728:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10072d:	e9 58 02 00 00       	jmp    10098a <debuginfo_eip+0x328>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  100732:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100735:	89 45 dc             	mov    %eax,-0x24(%ebp)
  100738:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10073b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  10073e:	8b 45 08             	mov    0x8(%ebp),%eax
  100741:	89 44 24 10          	mov    %eax,0x10(%esp)
  100745:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  10074c:	00 
  10074d:	8d 45 d8             	lea    -0x28(%ebp),%eax
  100750:	89 44 24 08          	mov    %eax,0x8(%esp)
  100754:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100757:	89 44 24 04          	mov    %eax,0x4(%esp)
  10075b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10075e:	89 04 24             	mov    %eax,(%esp)
  100761:	e8 aa fd ff ff       	call   100510 <stab_binsearch>

    if (lfun <= rfun) {
  100766:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100769:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10076c:	39 c2                	cmp    %eax,%edx
  10076e:	7f 78                	jg     1007e8 <debuginfo_eip+0x186>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  100770:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100773:	89 c2                	mov    %eax,%edx
  100775:	89 d0                	mov    %edx,%eax
  100777:	01 c0                	add    %eax,%eax
  100779:	01 d0                	add    %edx,%eax
  10077b:	c1 e0 02             	shl    $0x2,%eax
  10077e:	89 c2                	mov    %eax,%edx
  100780:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100783:	01 d0                	add    %edx,%eax
  100785:	8b 10                	mov    (%eax),%edx
  100787:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10078a:	2b 45 ec             	sub    -0x14(%ebp),%eax
  10078d:	39 c2                	cmp    %eax,%edx
  10078f:	73 22                	jae    1007b3 <debuginfo_eip+0x151>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100791:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100794:	89 c2                	mov    %eax,%edx
  100796:	89 d0                	mov    %edx,%eax
  100798:	01 c0                	add    %eax,%eax
  10079a:	01 d0                	add    %edx,%eax
  10079c:	c1 e0 02             	shl    $0x2,%eax
  10079f:	89 c2                	mov    %eax,%edx
  1007a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007a4:	01 d0                	add    %edx,%eax
  1007a6:	8b 10                	mov    (%eax),%edx
  1007a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007ab:	01 c2                	add    %eax,%edx
  1007ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007b0:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  1007b3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1007b6:	89 c2                	mov    %eax,%edx
  1007b8:	89 d0                	mov    %edx,%eax
  1007ba:	01 c0                	add    %eax,%eax
  1007bc:	01 d0                	add    %edx,%eax
  1007be:	c1 e0 02             	shl    $0x2,%eax
  1007c1:	89 c2                	mov    %eax,%edx
  1007c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007c6:	01 d0                	add    %edx,%eax
  1007c8:	8b 50 08             	mov    0x8(%eax),%edx
  1007cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007ce:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  1007d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007d4:	8b 40 10             	mov    0x10(%eax),%eax
  1007d7:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  1007da:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1007dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  1007e0:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1007e3:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1007e6:	eb 15                	jmp    1007fd <debuginfo_eip+0x19b>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1007e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007eb:	8b 55 08             	mov    0x8(%ebp),%edx
  1007ee:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1007f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007f4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1007f7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1007fa:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1007fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  100800:	8b 40 08             	mov    0x8(%eax),%eax
  100803:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  10080a:	00 
  10080b:	89 04 24             	mov    %eax,(%esp)
  10080e:	e8 22 4f 00 00       	call   105735 <strfind>
  100813:	8b 55 0c             	mov    0xc(%ebp),%edx
  100816:	8b 52 08             	mov    0x8(%edx),%edx
  100819:	29 d0                	sub    %edx,%eax
  10081b:	89 c2                	mov    %eax,%edx
  10081d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100820:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  100823:	8b 45 08             	mov    0x8(%ebp),%eax
  100826:	89 44 24 10          	mov    %eax,0x10(%esp)
  10082a:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  100831:	00 
  100832:	8d 45 d0             	lea    -0x30(%ebp),%eax
  100835:	89 44 24 08          	mov    %eax,0x8(%esp)
  100839:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  10083c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100840:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100843:	89 04 24             	mov    %eax,(%esp)
  100846:	e8 c5 fc ff ff       	call   100510 <stab_binsearch>
    if (lline <= rline) {
  10084b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10084e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100851:	39 c2                	cmp    %eax,%edx
  100853:	7f 23                	jg     100878 <debuginfo_eip+0x216>
        info->eip_line = stabs[rline].n_desc;
  100855:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100858:	89 c2                	mov    %eax,%edx
  10085a:	89 d0                	mov    %edx,%eax
  10085c:	01 c0                	add    %eax,%eax
  10085e:	01 d0                	add    %edx,%eax
  100860:	c1 e0 02             	shl    $0x2,%eax
  100863:	89 c2                	mov    %eax,%edx
  100865:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100868:	01 d0                	add    %edx,%eax
  10086a:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  10086e:	89 c2                	mov    %eax,%edx
  100870:	8b 45 0c             	mov    0xc(%ebp),%eax
  100873:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100876:	eb 11                	jmp    100889 <debuginfo_eip+0x227>
        return -1;
  100878:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10087d:	e9 08 01 00 00       	jmp    10098a <debuginfo_eip+0x328>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100882:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100885:	48                   	dec    %eax
  100886:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  100889:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10088c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10088f:	39 c2                	cmp    %eax,%edx
  100891:	7c 56                	jl     1008e9 <debuginfo_eip+0x287>
           && stabs[lline].n_type != N_SOL
  100893:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100896:	89 c2                	mov    %eax,%edx
  100898:	89 d0                	mov    %edx,%eax
  10089a:	01 c0                	add    %eax,%eax
  10089c:	01 d0                	add    %edx,%eax
  10089e:	c1 e0 02             	shl    $0x2,%eax
  1008a1:	89 c2                	mov    %eax,%edx
  1008a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008a6:	01 d0                	add    %edx,%eax
  1008a8:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1008ac:	3c 84                	cmp    $0x84,%al
  1008ae:	74 39                	je     1008e9 <debuginfo_eip+0x287>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  1008b0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008b3:	89 c2                	mov    %eax,%edx
  1008b5:	89 d0                	mov    %edx,%eax
  1008b7:	01 c0                	add    %eax,%eax
  1008b9:	01 d0                	add    %edx,%eax
  1008bb:	c1 e0 02             	shl    $0x2,%eax
  1008be:	89 c2                	mov    %eax,%edx
  1008c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008c3:	01 d0                	add    %edx,%eax
  1008c5:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1008c9:	3c 64                	cmp    $0x64,%al
  1008cb:	75 b5                	jne    100882 <debuginfo_eip+0x220>
  1008cd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008d0:	89 c2                	mov    %eax,%edx
  1008d2:	89 d0                	mov    %edx,%eax
  1008d4:	01 c0                	add    %eax,%eax
  1008d6:	01 d0                	add    %edx,%eax
  1008d8:	c1 e0 02             	shl    $0x2,%eax
  1008db:	89 c2                	mov    %eax,%edx
  1008dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008e0:	01 d0                	add    %edx,%eax
  1008e2:	8b 40 08             	mov    0x8(%eax),%eax
  1008e5:	85 c0                	test   %eax,%eax
  1008e7:	74 99                	je     100882 <debuginfo_eip+0x220>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1008e9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1008ef:	39 c2                	cmp    %eax,%edx
  1008f1:	7c 42                	jl     100935 <debuginfo_eip+0x2d3>
  1008f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008f6:	89 c2                	mov    %eax,%edx
  1008f8:	89 d0                	mov    %edx,%eax
  1008fa:	01 c0                	add    %eax,%eax
  1008fc:	01 d0                	add    %edx,%eax
  1008fe:	c1 e0 02             	shl    $0x2,%eax
  100901:	89 c2                	mov    %eax,%edx
  100903:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100906:	01 d0                	add    %edx,%eax
  100908:	8b 10                	mov    (%eax),%edx
  10090a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10090d:	2b 45 ec             	sub    -0x14(%ebp),%eax
  100910:	39 c2                	cmp    %eax,%edx
  100912:	73 21                	jae    100935 <debuginfo_eip+0x2d3>
        info->eip_file = stabstr + stabs[lline].n_strx;
  100914:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100917:	89 c2                	mov    %eax,%edx
  100919:	89 d0                	mov    %edx,%eax
  10091b:	01 c0                	add    %eax,%eax
  10091d:	01 d0                	add    %edx,%eax
  10091f:	c1 e0 02             	shl    $0x2,%eax
  100922:	89 c2                	mov    %eax,%edx
  100924:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100927:	01 d0                	add    %edx,%eax
  100929:	8b 10                	mov    (%eax),%edx
  10092b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10092e:	01 c2                	add    %eax,%edx
  100930:	8b 45 0c             	mov    0xc(%ebp),%eax
  100933:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  100935:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100938:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10093b:	39 c2                	cmp    %eax,%edx
  10093d:	7d 46                	jge    100985 <debuginfo_eip+0x323>
        for (lline = lfun + 1;
  10093f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100942:	40                   	inc    %eax
  100943:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  100946:	eb 16                	jmp    10095e <debuginfo_eip+0x2fc>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100948:	8b 45 0c             	mov    0xc(%ebp),%eax
  10094b:	8b 40 14             	mov    0x14(%eax),%eax
  10094e:	8d 50 01             	lea    0x1(%eax),%edx
  100951:	8b 45 0c             	mov    0xc(%ebp),%eax
  100954:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  100957:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10095a:	40                   	inc    %eax
  10095b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  10095e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100961:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  100964:	39 c2                	cmp    %eax,%edx
  100966:	7d 1d                	jge    100985 <debuginfo_eip+0x323>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100968:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10096b:	89 c2                	mov    %eax,%edx
  10096d:	89 d0                	mov    %edx,%eax
  10096f:	01 c0                	add    %eax,%eax
  100971:	01 d0                	add    %edx,%eax
  100973:	c1 e0 02             	shl    $0x2,%eax
  100976:	89 c2                	mov    %eax,%edx
  100978:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10097b:	01 d0                	add    %edx,%eax
  10097d:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100981:	3c a0                	cmp    $0xa0,%al
  100983:	74 c3                	je     100948 <debuginfo_eip+0x2e6>
        }
    }
    return 0;
  100985:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10098a:	c9                   	leave  
  10098b:	c3                   	ret    

0010098c <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  10098c:	f3 0f 1e fb          	endbr32 
  100990:	55                   	push   %ebp
  100991:	89 e5                	mov    %esp,%ebp
  100993:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100996:	c7 04 24 02 62 10 00 	movl   $0x106202,(%esp)
  10099d:	e8 27 f9 ff ff       	call   1002c9 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  1009a2:	c7 44 24 04 36 00 10 	movl   $0x100036,0x4(%esp)
  1009a9:	00 
  1009aa:	c7 04 24 1b 62 10 00 	movl   $0x10621b,(%esp)
  1009b1:	e8 13 f9 ff ff       	call   1002c9 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  1009b6:	c7 44 24 04 e5 60 10 	movl   $0x1060e5,0x4(%esp)
  1009bd:	00 
  1009be:	c7 04 24 33 62 10 00 	movl   $0x106233,(%esp)
  1009c5:	e8 ff f8 ff ff       	call   1002c9 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  1009ca:	c7 44 24 04 36 9a 11 	movl   $0x119a36,0x4(%esp)
  1009d1:	00 
  1009d2:	c7 04 24 4b 62 10 00 	movl   $0x10624b,(%esp)
  1009d9:	e8 eb f8 ff ff       	call   1002c9 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  1009de:	c7 44 24 04 28 cf 11 	movl   $0x11cf28,0x4(%esp)
  1009e5:	00 
  1009e6:	c7 04 24 63 62 10 00 	movl   $0x106263,(%esp)
  1009ed:	e8 d7 f8 ff ff       	call   1002c9 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1009f2:	b8 28 cf 11 00       	mov    $0x11cf28,%eax
  1009f7:	2d 36 00 10 00       	sub    $0x100036,%eax
  1009fc:	05 ff 03 00 00       	add    $0x3ff,%eax
  100a01:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  100a07:	85 c0                	test   %eax,%eax
  100a09:	0f 48 c2             	cmovs  %edx,%eax
  100a0c:	c1 f8 0a             	sar    $0xa,%eax
  100a0f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a13:	c7 04 24 7c 62 10 00 	movl   $0x10627c,(%esp)
  100a1a:	e8 aa f8 ff ff       	call   1002c9 <cprintf>
}
  100a1f:	90                   	nop
  100a20:	c9                   	leave  
  100a21:	c3                   	ret    

00100a22 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  100a22:	f3 0f 1e fb          	endbr32 
  100a26:	55                   	push   %ebp
  100a27:	89 e5                	mov    %esp,%ebp
  100a29:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  100a2f:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100a32:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a36:	8b 45 08             	mov    0x8(%ebp),%eax
  100a39:	89 04 24             	mov    %eax,(%esp)
  100a3c:	e8 21 fc ff ff       	call   100662 <debuginfo_eip>
  100a41:	85 c0                	test   %eax,%eax
  100a43:	74 15                	je     100a5a <print_debuginfo+0x38>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100a45:	8b 45 08             	mov    0x8(%ebp),%eax
  100a48:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a4c:	c7 04 24 a6 62 10 00 	movl   $0x1062a6,(%esp)
  100a53:	e8 71 f8 ff ff       	call   1002c9 <cprintf>
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100a58:	eb 6c                	jmp    100ac6 <print_debuginfo+0xa4>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a5a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100a61:	eb 1b                	jmp    100a7e <print_debuginfo+0x5c>
            fnname[j] = info.eip_fn_name[j];
  100a63:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a69:	01 d0                	add    %edx,%eax
  100a6b:	0f b6 10             	movzbl (%eax),%edx
  100a6e:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a74:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a77:	01 c8                	add    %ecx,%eax
  100a79:	88 10                	mov    %dl,(%eax)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a7b:	ff 45 f4             	incl   -0xc(%ebp)
  100a7e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100a81:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100a84:	7c dd                	jl     100a63 <print_debuginfo+0x41>
        fnname[j] = '\0';
  100a86:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100a8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a8f:	01 d0                	add    %edx,%eax
  100a91:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100a94:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100a97:	8b 55 08             	mov    0x8(%ebp),%edx
  100a9a:	89 d1                	mov    %edx,%ecx
  100a9c:	29 c1                	sub    %eax,%ecx
  100a9e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100aa1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100aa4:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  100aa8:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100aae:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100ab2:	89 54 24 08          	mov    %edx,0x8(%esp)
  100ab6:	89 44 24 04          	mov    %eax,0x4(%esp)
  100aba:	c7 04 24 c2 62 10 00 	movl   $0x1062c2,(%esp)
  100ac1:	e8 03 f8 ff ff       	call   1002c9 <cprintf>
}
  100ac6:	90                   	nop
  100ac7:	c9                   	leave  
  100ac8:	c3                   	ret    

00100ac9 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100ac9:	f3 0f 1e fb          	endbr32 
  100acd:	55                   	push   %ebp
  100ace:	89 e5                	mov    %esp,%ebp
  100ad0:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100ad3:	8b 45 04             	mov    0x4(%ebp),%eax
  100ad6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100ad9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100adc:	c9                   	leave  
  100add:	c3                   	ret    

00100ade <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100ade:	f3 0f 1e fb          	endbr32 
  100ae2:	55                   	push   %ebp
  100ae3:	89 e5                	mov    %esp,%ebp
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
}
  100ae5:	90                   	nop
  100ae6:	5d                   	pop    %ebp
  100ae7:	c3                   	ret    

00100ae8 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100ae8:	f3 0f 1e fb          	endbr32 
  100aec:	55                   	push   %ebp
  100aed:	89 e5                	mov    %esp,%ebp
  100aef:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100af2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100af9:	eb 0c                	jmp    100b07 <parse+0x1f>
            *buf ++ = '\0';
  100afb:	8b 45 08             	mov    0x8(%ebp),%eax
  100afe:	8d 50 01             	lea    0x1(%eax),%edx
  100b01:	89 55 08             	mov    %edx,0x8(%ebp)
  100b04:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b07:	8b 45 08             	mov    0x8(%ebp),%eax
  100b0a:	0f b6 00             	movzbl (%eax),%eax
  100b0d:	84 c0                	test   %al,%al
  100b0f:	74 1d                	je     100b2e <parse+0x46>
  100b11:	8b 45 08             	mov    0x8(%ebp),%eax
  100b14:	0f b6 00             	movzbl (%eax),%eax
  100b17:	0f be c0             	movsbl %al,%eax
  100b1a:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b1e:	c7 04 24 54 63 10 00 	movl   $0x106354,(%esp)
  100b25:	e8 d5 4b 00 00       	call   1056ff <strchr>
  100b2a:	85 c0                	test   %eax,%eax
  100b2c:	75 cd                	jne    100afb <parse+0x13>
        }
        if (*buf == '\0') {
  100b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  100b31:	0f b6 00             	movzbl (%eax),%eax
  100b34:	84 c0                	test   %al,%al
  100b36:	74 65                	je     100b9d <parse+0xb5>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100b38:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100b3c:	75 14                	jne    100b52 <parse+0x6a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100b3e:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100b45:	00 
  100b46:	c7 04 24 59 63 10 00 	movl   $0x106359,(%esp)
  100b4d:	e8 77 f7 ff ff       	call   1002c9 <cprintf>
        }
        argv[argc ++] = buf;
  100b52:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b55:	8d 50 01             	lea    0x1(%eax),%edx
  100b58:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100b5b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100b62:	8b 45 0c             	mov    0xc(%ebp),%eax
  100b65:	01 c2                	add    %eax,%edx
  100b67:	8b 45 08             	mov    0x8(%ebp),%eax
  100b6a:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b6c:	eb 03                	jmp    100b71 <parse+0x89>
            buf ++;
  100b6e:	ff 45 08             	incl   0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b71:	8b 45 08             	mov    0x8(%ebp),%eax
  100b74:	0f b6 00             	movzbl (%eax),%eax
  100b77:	84 c0                	test   %al,%al
  100b79:	74 8c                	je     100b07 <parse+0x1f>
  100b7b:	8b 45 08             	mov    0x8(%ebp),%eax
  100b7e:	0f b6 00             	movzbl (%eax),%eax
  100b81:	0f be c0             	movsbl %al,%eax
  100b84:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b88:	c7 04 24 54 63 10 00 	movl   $0x106354,(%esp)
  100b8f:	e8 6b 4b 00 00       	call   1056ff <strchr>
  100b94:	85 c0                	test   %eax,%eax
  100b96:	74 d6                	je     100b6e <parse+0x86>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b98:	e9 6a ff ff ff       	jmp    100b07 <parse+0x1f>
            break;
  100b9d:	90                   	nop
        }
    }
    return argc;
  100b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100ba1:	c9                   	leave  
  100ba2:	c3                   	ret    

00100ba3 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100ba3:	f3 0f 1e fb          	endbr32 
  100ba7:	55                   	push   %ebp
  100ba8:	89 e5                	mov    %esp,%ebp
  100baa:	53                   	push   %ebx
  100bab:	83 ec 64             	sub    $0x64,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100bae:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100bb1:	89 44 24 04          	mov    %eax,0x4(%esp)
  100bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  100bb8:	89 04 24             	mov    %eax,(%esp)
  100bbb:	e8 28 ff ff ff       	call   100ae8 <parse>
  100bc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100bc3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100bc7:	75 0a                	jne    100bd3 <runcmd+0x30>
        return 0;
  100bc9:	b8 00 00 00 00       	mov    $0x0,%eax
  100bce:	e9 83 00 00 00       	jmp    100c56 <runcmd+0xb3>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100bd3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100bda:	eb 5a                	jmp    100c36 <runcmd+0x93>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100bdc:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100bdf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100be2:	89 d0                	mov    %edx,%eax
  100be4:	01 c0                	add    %eax,%eax
  100be6:	01 d0                	add    %edx,%eax
  100be8:	c1 e0 02             	shl    $0x2,%eax
  100beb:	05 00 90 11 00       	add    $0x119000,%eax
  100bf0:	8b 00                	mov    (%eax),%eax
  100bf2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100bf6:	89 04 24             	mov    %eax,(%esp)
  100bf9:	e8 5d 4a 00 00       	call   10565b <strcmp>
  100bfe:	85 c0                	test   %eax,%eax
  100c00:	75 31                	jne    100c33 <runcmd+0x90>
            return commands[i].func(argc - 1, argv + 1, tf);
  100c02:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c05:	89 d0                	mov    %edx,%eax
  100c07:	01 c0                	add    %eax,%eax
  100c09:	01 d0                	add    %edx,%eax
  100c0b:	c1 e0 02             	shl    $0x2,%eax
  100c0e:	05 08 90 11 00       	add    $0x119008,%eax
  100c13:	8b 10                	mov    (%eax),%edx
  100c15:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c18:	83 c0 04             	add    $0x4,%eax
  100c1b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100c1e:	8d 59 ff             	lea    -0x1(%ecx),%ebx
  100c21:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100c24:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100c28:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c2c:	89 1c 24             	mov    %ebx,(%esp)
  100c2f:	ff d2                	call   *%edx
  100c31:	eb 23                	jmp    100c56 <runcmd+0xb3>
    for (i = 0; i < NCOMMANDS; i ++) {
  100c33:	ff 45 f4             	incl   -0xc(%ebp)
  100c36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c39:	83 f8 02             	cmp    $0x2,%eax
  100c3c:	76 9e                	jbe    100bdc <runcmd+0x39>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100c3e:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100c41:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c45:	c7 04 24 77 63 10 00 	movl   $0x106377,(%esp)
  100c4c:	e8 78 f6 ff ff       	call   1002c9 <cprintf>
    return 0;
  100c51:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c56:	83 c4 64             	add    $0x64,%esp
  100c59:	5b                   	pop    %ebx
  100c5a:	5d                   	pop    %ebp
  100c5b:	c3                   	ret    

00100c5c <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100c5c:	f3 0f 1e fb          	endbr32 
  100c60:	55                   	push   %ebp
  100c61:	89 e5                	mov    %esp,%ebp
  100c63:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100c66:	c7 04 24 90 63 10 00 	movl   $0x106390,(%esp)
  100c6d:	e8 57 f6 ff ff       	call   1002c9 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100c72:	c7 04 24 b8 63 10 00 	movl   $0x1063b8,(%esp)
  100c79:	e8 4b f6 ff ff       	call   1002c9 <cprintf>

    if (tf != NULL) {
  100c7e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100c82:	74 0b                	je     100c8f <kmonitor+0x33>
        print_trapframe(tf);
  100c84:	8b 45 08             	mov    0x8(%ebp),%eax
  100c87:	89 04 24             	mov    %eax,(%esp)
  100c8a:	e8 5f 0e 00 00       	call   101aee <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100c8f:	c7 04 24 dd 63 10 00 	movl   $0x1063dd,(%esp)
  100c96:	e8 e1 f6 ff ff       	call   10037c <readline>
  100c9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100c9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100ca2:	74 eb                	je     100c8f <kmonitor+0x33>
            if (runcmd(buf, tf) < 0) {
  100ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  100ca7:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cae:	89 04 24             	mov    %eax,(%esp)
  100cb1:	e8 ed fe ff ff       	call   100ba3 <runcmd>
  100cb6:	85 c0                	test   %eax,%eax
  100cb8:	78 02                	js     100cbc <kmonitor+0x60>
        if ((buf = readline("K> ")) != NULL) {
  100cba:	eb d3                	jmp    100c8f <kmonitor+0x33>
                break;
  100cbc:	90                   	nop
            }
        }
    }
}
  100cbd:	90                   	nop
  100cbe:	c9                   	leave  
  100cbf:	c3                   	ret    

00100cc0 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100cc0:	f3 0f 1e fb          	endbr32 
  100cc4:	55                   	push   %ebp
  100cc5:	89 e5                	mov    %esp,%ebp
  100cc7:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100cca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100cd1:	eb 3d                	jmp    100d10 <mon_help+0x50>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100cd3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100cd6:	89 d0                	mov    %edx,%eax
  100cd8:	01 c0                	add    %eax,%eax
  100cda:	01 d0                	add    %edx,%eax
  100cdc:	c1 e0 02             	shl    $0x2,%eax
  100cdf:	05 04 90 11 00       	add    $0x119004,%eax
  100ce4:	8b 08                	mov    (%eax),%ecx
  100ce6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100ce9:	89 d0                	mov    %edx,%eax
  100ceb:	01 c0                	add    %eax,%eax
  100ced:	01 d0                	add    %edx,%eax
  100cef:	c1 e0 02             	shl    $0x2,%eax
  100cf2:	05 00 90 11 00       	add    $0x119000,%eax
  100cf7:	8b 00                	mov    (%eax),%eax
  100cf9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100cfd:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d01:	c7 04 24 e1 63 10 00 	movl   $0x1063e1,(%esp)
  100d08:	e8 bc f5 ff ff       	call   1002c9 <cprintf>
    for (i = 0; i < NCOMMANDS; i ++) {
  100d0d:	ff 45 f4             	incl   -0xc(%ebp)
  100d10:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d13:	83 f8 02             	cmp    $0x2,%eax
  100d16:	76 bb                	jbe    100cd3 <mon_help+0x13>
    }
    return 0;
  100d18:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d1d:	c9                   	leave  
  100d1e:	c3                   	ret    

00100d1f <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100d1f:	f3 0f 1e fb          	endbr32 
  100d23:	55                   	push   %ebp
  100d24:	89 e5                	mov    %esp,%ebp
  100d26:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100d29:	e8 5e fc ff ff       	call   10098c <print_kerninfo>
    return 0;
  100d2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d33:	c9                   	leave  
  100d34:	c3                   	ret    

00100d35 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100d35:	f3 0f 1e fb          	endbr32 
  100d39:	55                   	push   %ebp
  100d3a:	89 e5                	mov    %esp,%ebp
  100d3c:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100d3f:	e8 9a fd ff ff       	call   100ade <print_stackframe>
    return 0;
  100d44:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d49:	c9                   	leave  
  100d4a:	c3                   	ret    

00100d4b <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100d4b:	f3 0f 1e fb          	endbr32 
  100d4f:	55                   	push   %ebp
  100d50:	89 e5                	mov    %esp,%ebp
  100d52:	83 ec 28             	sub    $0x28,%esp
  100d55:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100d5b:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100d5f:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100d63:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100d67:	ee                   	out    %al,(%dx)
}
  100d68:	90                   	nop
  100d69:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100d6f:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100d73:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100d77:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100d7b:	ee                   	out    %al,(%dx)
}
  100d7c:	90                   	nop
  100d7d:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100d83:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100d87:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100d8b:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100d8f:	ee                   	out    %al,(%dx)
}
  100d90:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100d91:	c7 05 0c cf 11 00 00 	movl   $0x0,0x11cf0c
  100d98:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100d9b:	c7 04 24 ea 63 10 00 	movl   $0x1063ea,(%esp)
  100da2:	e8 22 f5 ff ff       	call   1002c9 <cprintf>
    pic_enable(IRQ_TIMER);
  100da7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100dae:	e8 95 09 00 00       	call   101748 <pic_enable>
}
  100db3:	90                   	nop
  100db4:	c9                   	leave  
  100db5:	c3                   	ret    

00100db6 <__intr_save>:
#include <x86.h>
#include <intr.h>
#include <mmu.h>

static inline bool
__intr_save(void) {
  100db6:	55                   	push   %ebp
  100db7:	89 e5                	mov    %esp,%ebp
  100db9:	83 ec 18             	sub    $0x18,%esp
}

static inline uint32_t
read_eflags(void) {
    uint32_t eflags;
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
  100dbc:	9c                   	pushf  
  100dbd:	58                   	pop    %eax
  100dbe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
  100dc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
  100dc4:	25 00 02 00 00       	and    $0x200,%eax
  100dc9:	85 c0                	test   %eax,%eax
  100dcb:	74 0c                	je     100dd9 <__intr_save+0x23>
        intr_disable();
  100dcd:	e8 05 0b 00 00       	call   1018d7 <intr_disable>
        return 1;
  100dd2:	b8 01 00 00 00       	mov    $0x1,%eax
  100dd7:	eb 05                	jmp    100dde <__intr_save+0x28>
    }
    return 0;
  100dd9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100dde:	c9                   	leave  
  100ddf:	c3                   	ret    

00100de0 <__intr_restore>:

static inline void
__intr_restore(bool flag) {
  100de0:	55                   	push   %ebp
  100de1:	89 e5                	mov    %esp,%ebp
  100de3:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
  100de6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100dea:	74 05                	je     100df1 <__intr_restore+0x11>
        intr_enable();
  100dec:	e8 da 0a 00 00       	call   1018cb <intr_enable>
    }
}
  100df1:	90                   	nop
  100df2:	c9                   	leave  
  100df3:	c3                   	ret    

00100df4 <delay>:
#include <memlayout.h>
#include <sync.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100df4:	f3 0f 1e fb          	endbr32 
  100df8:	55                   	push   %ebp
  100df9:	89 e5                	mov    %esp,%ebp
  100dfb:	83 ec 10             	sub    $0x10,%esp
  100dfe:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  100e04:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e08:	89 c2                	mov    %eax,%edx
  100e0a:	ec                   	in     (%dx),%al
  100e0b:	88 45 f1             	mov    %al,-0xf(%ebp)
  100e0e:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e14:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e18:	89 c2                	mov    %eax,%edx
  100e1a:	ec                   	in     (%dx),%al
  100e1b:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e1e:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e24:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e28:	89 c2                	mov    %eax,%edx
  100e2a:	ec                   	in     (%dx),%al
  100e2b:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e2e:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100e34:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e38:	89 c2                	mov    %eax,%edx
  100e3a:	ec                   	in     (%dx),%al
  100e3b:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e3e:	90                   	nop
  100e3f:	c9                   	leave  
  100e40:	c3                   	ret    

00100e41 <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
  100e41:	f3 0f 1e fb          	endbr32 
  100e45:	55                   	push   %ebp
  100e46:	89 e5                	mov    %esp,%ebp
  100e48:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)(CGA_BUF + KERNBASE);
  100e4b:	c7 45 fc 00 80 0b c0 	movl   $0xc00b8000,-0x4(%ebp)
    uint16_t was = *cp;
  100e52:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e55:	0f b7 00             	movzwl (%eax),%eax
  100e58:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
  100e5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e5f:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
  100e64:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e67:	0f b7 00             	movzwl (%eax),%eax
  100e6a:	0f b7 c0             	movzwl %ax,%eax
  100e6d:	3d 5a a5 00 00       	cmp    $0xa55a,%eax
  100e72:	74 12                	je     100e86 <cga_init+0x45>
        cp = (uint16_t*)(MONO_BUF + KERNBASE);
  100e74:	c7 45 fc 00 00 0b c0 	movl   $0xc00b0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
  100e7b:	66 c7 05 46 c4 11 00 	movw   $0x3b4,0x11c446
  100e82:	b4 03 
  100e84:	eb 13                	jmp    100e99 <cga_init+0x58>
    } else {
        *cp = was;
  100e86:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e89:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100e8d:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
  100e90:	66 c7 05 46 c4 11 00 	movw   $0x3d4,0x11c446
  100e97:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
  100e99:	0f b7 05 46 c4 11 00 	movzwl 0x11c446,%eax
  100ea0:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100ea4:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100ea8:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100eac:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100eb0:	ee                   	out    %al,(%dx)
}
  100eb1:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;
  100eb2:	0f b7 05 46 c4 11 00 	movzwl 0x11c446,%eax
  100eb9:	40                   	inc    %eax
  100eba:	0f b7 c0             	movzwl %ax,%eax
  100ebd:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  100ec1:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  100ec5:	89 c2                	mov    %eax,%edx
  100ec7:	ec                   	in     (%dx),%al
  100ec8:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  100ecb:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100ecf:	0f b6 c0             	movzbl %al,%eax
  100ed2:	c1 e0 08             	shl    $0x8,%eax
  100ed5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100ed8:	0f b7 05 46 c4 11 00 	movzwl 0x11c446,%eax
  100edf:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100ee3:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100ee7:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100eeb:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100eef:	ee                   	out    %al,(%dx)
}
  100ef0:	90                   	nop
    pos |= inb(addr_6845 + 1);
  100ef1:	0f b7 05 46 c4 11 00 	movzwl 0x11c446,%eax
  100ef8:	40                   	inc    %eax
  100ef9:	0f b7 c0             	movzwl %ax,%eax
  100efc:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  100f00:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100f04:	89 c2                	mov    %eax,%edx
  100f06:	ec                   	in     (%dx),%al
  100f07:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  100f0a:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f0e:	0f b6 c0             	movzbl %al,%eax
  100f11:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
  100f14:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f17:	a3 40 c4 11 00       	mov    %eax,0x11c440
    crt_pos = pos;
  100f1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f1f:	0f b7 c0             	movzwl %ax,%eax
  100f22:	66 a3 44 c4 11 00    	mov    %ax,0x11c444
}
  100f28:	90                   	nop
  100f29:	c9                   	leave  
  100f2a:	c3                   	ret    

00100f2b <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f2b:	f3 0f 1e fb          	endbr32 
  100f2f:	55                   	push   %ebp
  100f30:	89 e5                	mov    %esp,%ebp
  100f32:	83 ec 48             	sub    $0x48,%esp
  100f35:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  100f3b:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100f3f:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  100f43:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100f47:	ee                   	out    %al,(%dx)
}
  100f48:	90                   	nop
  100f49:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  100f4f:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100f53:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  100f57:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100f5b:	ee                   	out    %al,(%dx)
}
  100f5c:	90                   	nop
  100f5d:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  100f63:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100f67:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  100f6b:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100f6f:	ee                   	out    %al,(%dx)
}
  100f70:	90                   	nop
  100f71:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100f77:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100f7b:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100f7f:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100f83:	ee                   	out    %al,(%dx)
}
  100f84:	90                   	nop
  100f85:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  100f8b:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100f8f:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100f93:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100f97:	ee                   	out    %al,(%dx)
}
  100f98:	90                   	nop
  100f99:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  100f9f:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100fa3:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100fa7:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100fab:	ee                   	out    %al,(%dx)
}
  100fac:	90                   	nop
  100fad:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100fb3:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  100fb7:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100fbb:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100fbf:	ee                   	out    %al,(%dx)
}
  100fc0:	90                   	nop
  100fc1:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  100fc7:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100fcb:	89 c2                	mov    %eax,%edx
  100fcd:	ec                   	in     (%dx),%al
  100fce:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100fd1:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100fd5:	3c ff                	cmp    $0xff,%al
  100fd7:	0f 95 c0             	setne  %al
  100fda:	0f b6 c0             	movzbl %al,%eax
  100fdd:	a3 48 c4 11 00       	mov    %eax,0x11c448
  100fe2:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  100fe8:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100fec:	89 c2                	mov    %eax,%edx
  100fee:	ec                   	in     (%dx),%al
  100fef:	88 45 f1             	mov    %al,-0xf(%ebp)
  100ff2:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  100ff8:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100ffc:	89 c2                	mov    %eax,%edx
  100ffe:	ec                   	in     (%dx),%al
  100fff:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  101002:	a1 48 c4 11 00       	mov    0x11c448,%eax
  101007:	85 c0                	test   %eax,%eax
  101009:	74 0c                	je     101017 <serial_init+0xec>
        pic_enable(IRQ_COM1);
  10100b:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  101012:	e8 31 07 00 00       	call   101748 <pic_enable>
    }
}
  101017:	90                   	nop
  101018:	c9                   	leave  
  101019:	c3                   	ret    

0010101a <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  10101a:	f3 0f 1e fb          	endbr32 
  10101e:	55                   	push   %ebp
  10101f:	89 e5                	mov    %esp,%ebp
  101021:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101024:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10102b:	eb 08                	jmp    101035 <lpt_putc_sub+0x1b>
        delay();
  10102d:	e8 c2 fd ff ff       	call   100df4 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101032:	ff 45 fc             	incl   -0x4(%ebp)
  101035:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  10103b:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10103f:	89 c2                	mov    %eax,%edx
  101041:	ec                   	in     (%dx),%al
  101042:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101045:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101049:	84 c0                	test   %al,%al
  10104b:	78 09                	js     101056 <lpt_putc_sub+0x3c>
  10104d:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101054:	7e d7                	jle    10102d <lpt_putc_sub+0x13>
    }
    outb(LPTPORT + 0, c);
  101056:	8b 45 08             	mov    0x8(%ebp),%eax
  101059:	0f b6 c0             	movzbl %al,%eax
  10105c:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  101062:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101065:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101069:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10106d:	ee                   	out    %al,(%dx)
}
  10106e:	90                   	nop
  10106f:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  101075:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101079:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10107d:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101081:	ee                   	out    %al,(%dx)
}
  101082:	90                   	nop
  101083:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  101089:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10108d:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101091:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101095:	ee                   	out    %al,(%dx)
}
  101096:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  101097:	90                   	nop
  101098:	c9                   	leave  
  101099:	c3                   	ret    

0010109a <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  10109a:	f3 0f 1e fb          	endbr32 
  10109e:	55                   	push   %ebp
  10109f:	89 e5                	mov    %esp,%ebp
  1010a1:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1010a4:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1010a8:	74 0d                	je     1010b7 <lpt_putc+0x1d>
        lpt_putc_sub(c);
  1010aa:	8b 45 08             	mov    0x8(%ebp),%eax
  1010ad:	89 04 24             	mov    %eax,(%esp)
  1010b0:	e8 65 ff ff ff       	call   10101a <lpt_putc_sub>
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  1010b5:	eb 24                	jmp    1010db <lpt_putc+0x41>
        lpt_putc_sub('\b');
  1010b7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010be:	e8 57 ff ff ff       	call   10101a <lpt_putc_sub>
        lpt_putc_sub(' ');
  1010c3:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1010ca:	e8 4b ff ff ff       	call   10101a <lpt_putc_sub>
        lpt_putc_sub('\b');
  1010cf:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010d6:	e8 3f ff ff ff       	call   10101a <lpt_putc_sub>
}
  1010db:	90                   	nop
  1010dc:	c9                   	leave  
  1010dd:	c3                   	ret    

001010de <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  1010de:	f3 0f 1e fb          	endbr32 
  1010e2:	55                   	push   %ebp
  1010e3:	89 e5                	mov    %esp,%ebp
  1010e5:	53                   	push   %ebx
  1010e6:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  1010e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1010ec:	25 00 ff ff ff       	and    $0xffffff00,%eax
  1010f1:	85 c0                	test   %eax,%eax
  1010f3:	75 07                	jne    1010fc <cga_putc+0x1e>
        c |= 0x0700;
  1010f5:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  1010fc:	8b 45 08             	mov    0x8(%ebp),%eax
  1010ff:	0f b6 c0             	movzbl %al,%eax
  101102:	83 f8 0d             	cmp    $0xd,%eax
  101105:	74 72                	je     101179 <cga_putc+0x9b>
  101107:	83 f8 0d             	cmp    $0xd,%eax
  10110a:	0f 8f a3 00 00 00    	jg     1011b3 <cga_putc+0xd5>
  101110:	83 f8 08             	cmp    $0x8,%eax
  101113:	74 0a                	je     10111f <cga_putc+0x41>
  101115:	83 f8 0a             	cmp    $0xa,%eax
  101118:	74 4c                	je     101166 <cga_putc+0x88>
  10111a:	e9 94 00 00 00       	jmp    1011b3 <cga_putc+0xd5>
    case '\b':
        if (crt_pos > 0) {
  10111f:	0f b7 05 44 c4 11 00 	movzwl 0x11c444,%eax
  101126:	85 c0                	test   %eax,%eax
  101128:	0f 84 af 00 00 00    	je     1011dd <cga_putc+0xff>
            crt_pos --;
  10112e:	0f b7 05 44 c4 11 00 	movzwl 0x11c444,%eax
  101135:	48                   	dec    %eax
  101136:	0f b7 c0             	movzwl %ax,%eax
  101139:	66 a3 44 c4 11 00    	mov    %ax,0x11c444
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  10113f:	8b 45 08             	mov    0x8(%ebp),%eax
  101142:	98                   	cwtl   
  101143:	25 00 ff ff ff       	and    $0xffffff00,%eax
  101148:	98                   	cwtl   
  101149:	83 c8 20             	or     $0x20,%eax
  10114c:	98                   	cwtl   
  10114d:	8b 15 40 c4 11 00    	mov    0x11c440,%edx
  101153:	0f b7 0d 44 c4 11 00 	movzwl 0x11c444,%ecx
  10115a:	01 c9                	add    %ecx,%ecx
  10115c:	01 ca                	add    %ecx,%edx
  10115e:	0f b7 c0             	movzwl %ax,%eax
  101161:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  101164:	eb 77                	jmp    1011dd <cga_putc+0xff>
    case '\n':
        crt_pos += CRT_COLS;
  101166:	0f b7 05 44 c4 11 00 	movzwl 0x11c444,%eax
  10116d:	83 c0 50             	add    $0x50,%eax
  101170:	0f b7 c0             	movzwl %ax,%eax
  101173:	66 a3 44 c4 11 00    	mov    %ax,0x11c444
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101179:	0f b7 1d 44 c4 11 00 	movzwl 0x11c444,%ebx
  101180:	0f b7 0d 44 c4 11 00 	movzwl 0x11c444,%ecx
  101187:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  10118c:	89 c8                	mov    %ecx,%eax
  10118e:	f7 e2                	mul    %edx
  101190:	c1 ea 06             	shr    $0x6,%edx
  101193:	89 d0                	mov    %edx,%eax
  101195:	c1 e0 02             	shl    $0x2,%eax
  101198:	01 d0                	add    %edx,%eax
  10119a:	c1 e0 04             	shl    $0x4,%eax
  10119d:	29 c1                	sub    %eax,%ecx
  10119f:	89 c8                	mov    %ecx,%eax
  1011a1:	0f b7 c0             	movzwl %ax,%eax
  1011a4:	29 c3                	sub    %eax,%ebx
  1011a6:	89 d8                	mov    %ebx,%eax
  1011a8:	0f b7 c0             	movzwl %ax,%eax
  1011ab:	66 a3 44 c4 11 00    	mov    %ax,0x11c444
        break;
  1011b1:	eb 2b                	jmp    1011de <cga_putc+0x100>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1011b3:	8b 0d 40 c4 11 00    	mov    0x11c440,%ecx
  1011b9:	0f b7 05 44 c4 11 00 	movzwl 0x11c444,%eax
  1011c0:	8d 50 01             	lea    0x1(%eax),%edx
  1011c3:	0f b7 d2             	movzwl %dx,%edx
  1011c6:	66 89 15 44 c4 11 00 	mov    %dx,0x11c444
  1011cd:	01 c0                	add    %eax,%eax
  1011cf:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  1011d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1011d5:	0f b7 c0             	movzwl %ax,%eax
  1011d8:	66 89 02             	mov    %ax,(%edx)
        break;
  1011db:	eb 01                	jmp    1011de <cga_putc+0x100>
        break;
  1011dd:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  1011de:	0f b7 05 44 c4 11 00 	movzwl 0x11c444,%eax
  1011e5:	3d cf 07 00 00       	cmp    $0x7cf,%eax
  1011ea:	76 5d                	jbe    101249 <cga_putc+0x16b>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  1011ec:	a1 40 c4 11 00       	mov    0x11c440,%eax
  1011f1:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  1011f7:	a1 40 c4 11 00       	mov    0x11c440,%eax
  1011fc:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  101203:	00 
  101204:	89 54 24 04          	mov    %edx,0x4(%esp)
  101208:	89 04 24             	mov    %eax,(%esp)
  10120b:	e8 f4 46 00 00       	call   105904 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101210:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  101217:	eb 14                	jmp    10122d <cga_putc+0x14f>
            crt_buf[i] = 0x0700 | ' ';
  101219:	a1 40 c4 11 00       	mov    0x11c440,%eax
  10121e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101221:	01 d2                	add    %edx,%edx
  101223:	01 d0                	add    %edx,%eax
  101225:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  10122a:	ff 45 f4             	incl   -0xc(%ebp)
  10122d:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  101234:	7e e3                	jle    101219 <cga_putc+0x13b>
        }
        crt_pos -= CRT_COLS;
  101236:	0f b7 05 44 c4 11 00 	movzwl 0x11c444,%eax
  10123d:	83 e8 50             	sub    $0x50,%eax
  101240:	0f b7 c0             	movzwl %ax,%eax
  101243:	66 a3 44 c4 11 00    	mov    %ax,0x11c444
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101249:	0f b7 05 46 c4 11 00 	movzwl 0x11c446,%eax
  101250:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  101254:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101258:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10125c:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101260:	ee                   	out    %al,(%dx)
}
  101261:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
  101262:	0f b7 05 44 c4 11 00 	movzwl 0x11c444,%eax
  101269:	c1 e8 08             	shr    $0x8,%eax
  10126c:	0f b7 c0             	movzwl %ax,%eax
  10126f:	0f b6 c0             	movzbl %al,%eax
  101272:	0f b7 15 46 c4 11 00 	movzwl 0x11c446,%edx
  101279:	42                   	inc    %edx
  10127a:	0f b7 d2             	movzwl %dx,%edx
  10127d:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  101281:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101284:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101288:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10128c:	ee                   	out    %al,(%dx)
}
  10128d:	90                   	nop
    outb(addr_6845, 15);
  10128e:	0f b7 05 46 c4 11 00 	movzwl 0x11c446,%eax
  101295:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  101299:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10129d:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1012a1:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1012a5:	ee                   	out    %al,(%dx)
}
  1012a6:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
  1012a7:	0f b7 05 44 c4 11 00 	movzwl 0x11c444,%eax
  1012ae:	0f b6 c0             	movzbl %al,%eax
  1012b1:	0f b7 15 46 c4 11 00 	movzwl 0x11c446,%edx
  1012b8:	42                   	inc    %edx
  1012b9:	0f b7 d2             	movzwl %dx,%edx
  1012bc:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  1012c0:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1012c3:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1012c7:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1012cb:	ee                   	out    %al,(%dx)
}
  1012cc:	90                   	nop
}
  1012cd:	90                   	nop
  1012ce:	83 c4 34             	add    $0x34,%esp
  1012d1:	5b                   	pop    %ebx
  1012d2:	5d                   	pop    %ebp
  1012d3:	c3                   	ret    

001012d4 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  1012d4:	f3 0f 1e fb          	endbr32 
  1012d8:	55                   	push   %ebp
  1012d9:	89 e5                	mov    %esp,%ebp
  1012db:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1012de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1012e5:	eb 08                	jmp    1012ef <serial_putc_sub+0x1b>
        delay();
  1012e7:	e8 08 fb ff ff       	call   100df4 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1012ec:	ff 45 fc             	incl   -0x4(%ebp)
  1012ef:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  1012f5:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1012f9:	89 c2                	mov    %eax,%edx
  1012fb:	ec                   	in     (%dx),%al
  1012fc:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1012ff:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101303:	0f b6 c0             	movzbl %al,%eax
  101306:	83 e0 20             	and    $0x20,%eax
  101309:	85 c0                	test   %eax,%eax
  10130b:	75 09                	jne    101316 <serial_putc_sub+0x42>
  10130d:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101314:	7e d1                	jle    1012e7 <serial_putc_sub+0x13>
    }
    outb(COM1 + COM_TX, c);
  101316:	8b 45 08             	mov    0x8(%ebp),%eax
  101319:	0f b6 c0             	movzbl %al,%eax
  10131c:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101322:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101325:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101329:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10132d:	ee                   	out    %al,(%dx)
}
  10132e:	90                   	nop
}
  10132f:	90                   	nop
  101330:	c9                   	leave  
  101331:	c3                   	ret    

00101332 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  101332:	f3 0f 1e fb          	endbr32 
  101336:	55                   	push   %ebp
  101337:	89 e5                	mov    %esp,%ebp
  101339:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  10133c:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101340:	74 0d                	je     10134f <serial_putc+0x1d>
        serial_putc_sub(c);
  101342:	8b 45 08             	mov    0x8(%ebp),%eax
  101345:	89 04 24             	mov    %eax,(%esp)
  101348:	e8 87 ff ff ff       	call   1012d4 <serial_putc_sub>
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  10134d:	eb 24                	jmp    101373 <serial_putc+0x41>
        serial_putc_sub('\b');
  10134f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101356:	e8 79 ff ff ff       	call   1012d4 <serial_putc_sub>
        serial_putc_sub(' ');
  10135b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101362:	e8 6d ff ff ff       	call   1012d4 <serial_putc_sub>
        serial_putc_sub('\b');
  101367:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10136e:	e8 61 ff ff ff       	call   1012d4 <serial_putc_sub>
}
  101373:	90                   	nop
  101374:	c9                   	leave  
  101375:	c3                   	ret    

00101376 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  101376:	f3 0f 1e fb          	endbr32 
  10137a:	55                   	push   %ebp
  10137b:	89 e5                	mov    %esp,%ebp
  10137d:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  101380:	eb 33                	jmp    1013b5 <cons_intr+0x3f>
        if (c != 0) {
  101382:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  101386:	74 2d                	je     1013b5 <cons_intr+0x3f>
            cons.buf[cons.wpos ++] = c;
  101388:	a1 64 c6 11 00       	mov    0x11c664,%eax
  10138d:	8d 50 01             	lea    0x1(%eax),%edx
  101390:	89 15 64 c6 11 00    	mov    %edx,0x11c664
  101396:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101399:	88 90 60 c4 11 00    	mov    %dl,0x11c460(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  10139f:	a1 64 c6 11 00       	mov    0x11c664,%eax
  1013a4:	3d 00 02 00 00       	cmp    $0x200,%eax
  1013a9:	75 0a                	jne    1013b5 <cons_intr+0x3f>
                cons.wpos = 0;
  1013ab:	c7 05 64 c6 11 00 00 	movl   $0x0,0x11c664
  1013b2:	00 00 00 
    while ((c = (*proc)()) != -1) {
  1013b5:	8b 45 08             	mov    0x8(%ebp),%eax
  1013b8:	ff d0                	call   *%eax
  1013ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1013bd:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1013c1:	75 bf                	jne    101382 <cons_intr+0xc>
            }
        }
    }
}
  1013c3:	90                   	nop
  1013c4:	90                   	nop
  1013c5:	c9                   	leave  
  1013c6:	c3                   	ret    

001013c7 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1013c7:	f3 0f 1e fb          	endbr32 
  1013cb:	55                   	push   %ebp
  1013cc:	89 e5                	mov    %esp,%ebp
  1013ce:	83 ec 10             	sub    $0x10,%esp
  1013d1:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  1013d7:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1013db:	89 c2                	mov    %eax,%edx
  1013dd:	ec                   	in     (%dx),%al
  1013de:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1013e1:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  1013e5:	0f b6 c0             	movzbl %al,%eax
  1013e8:	83 e0 01             	and    $0x1,%eax
  1013eb:	85 c0                	test   %eax,%eax
  1013ed:	75 07                	jne    1013f6 <serial_proc_data+0x2f>
        return -1;
  1013ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1013f4:	eb 2a                	jmp    101420 <serial_proc_data+0x59>
  1013f6:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  1013fc:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101400:	89 c2                	mov    %eax,%edx
  101402:	ec                   	in     (%dx),%al
  101403:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  101406:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  10140a:	0f b6 c0             	movzbl %al,%eax
  10140d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101410:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101414:	75 07                	jne    10141d <serial_proc_data+0x56>
        c = '\b';
  101416:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  10141d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101420:	c9                   	leave  
  101421:	c3                   	ret    

00101422 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  101422:	f3 0f 1e fb          	endbr32 
  101426:	55                   	push   %ebp
  101427:	89 e5                	mov    %esp,%ebp
  101429:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  10142c:	a1 48 c4 11 00       	mov    0x11c448,%eax
  101431:	85 c0                	test   %eax,%eax
  101433:	74 0c                	je     101441 <serial_intr+0x1f>
        cons_intr(serial_proc_data);
  101435:	c7 04 24 c7 13 10 00 	movl   $0x1013c7,(%esp)
  10143c:	e8 35 ff ff ff       	call   101376 <cons_intr>
    }
}
  101441:	90                   	nop
  101442:	c9                   	leave  
  101443:	c3                   	ret    

00101444 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  101444:	f3 0f 1e fb          	endbr32 
  101448:	55                   	push   %ebp
  101449:	89 e5                	mov    %esp,%ebp
  10144b:	83 ec 38             	sub    $0x38,%esp
  10144e:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  101454:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101457:	89 c2                	mov    %eax,%edx
  101459:	ec                   	in     (%dx),%al
  10145a:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  10145d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  101461:	0f b6 c0             	movzbl %al,%eax
  101464:	83 e0 01             	and    $0x1,%eax
  101467:	85 c0                	test   %eax,%eax
  101469:	75 0a                	jne    101475 <kbd_proc_data+0x31>
        return -1;
  10146b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101470:	e9 56 01 00 00       	jmp    1015cb <kbd_proc_data+0x187>
  101475:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
  10147b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10147e:	89 c2                	mov    %eax,%edx
  101480:	ec                   	in     (%dx),%al
  101481:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  101484:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  101488:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  10148b:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  10148f:	75 17                	jne    1014a8 <kbd_proc_data+0x64>
        // E0 escape character
        shift |= E0ESC;
  101491:	a1 68 c6 11 00       	mov    0x11c668,%eax
  101496:	83 c8 40             	or     $0x40,%eax
  101499:	a3 68 c6 11 00       	mov    %eax,0x11c668
        return 0;
  10149e:	b8 00 00 00 00       	mov    $0x0,%eax
  1014a3:	e9 23 01 00 00       	jmp    1015cb <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  1014a8:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014ac:	84 c0                	test   %al,%al
  1014ae:	79 45                	jns    1014f5 <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1014b0:	a1 68 c6 11 00       	mov    0x11c668,%eax
  1014b5:	83 e0 40             	and    $0x40,%eax
  1014b8:	85 c0                	test   %eax,%eax
  1014ba:	75 08                	jne    1014c4 <kbd_proc_data+0x80>
  1014bc:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014c0:	24 7f                	and    $0x7f,%al
  1014c2:	eb 04                	jmp    1014c8 <kbd_proc_data+0x84>
  1014c4:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014c8:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  1014cb:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014cf:	0f b6 80 40 90 11 00 	movzbl 0x119040(%eax),%eax
  1014d6:	0c 40                	or     $0x40,%al
  1014d8:	0f b6 c0             	movzbl %al,%eax
  1014db:	f7 d0                	not    %eax
  1014dd:	89 c2                	mov    %eax,%edx
  1014df:	a1 68 c6 11 00       	mov    0x11c668,%eax
  1014e4:	21 d0                	and    %edx,%eax
  1014e6:	a3 68 c6 11 00       	mov    %eax,0x11c668
        return 0;
  1014eb:	b8 00 00 00 00       	mov    $0x0,%eax
  1014f0:	e9 d6 00 00 00       	jmp    1015cb <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  1014f5:	a1 68 c6 11 00       	mov    0x11c668,%eax
  1014fa:	83 e0 40             	and    $0x40,%eax
  1014fd:	85 c0                	test   %eax,%eax
  1014ff:	74 11                	je     101512 <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101501:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101505:	a1 68 c6 11 00       	mov    0x11c668,%eax
  10150a:	83 e0 bf             	and    $0xffffffbf,%eax
  10150d:	a3 68 c6 11 00       	mov    %eax,0x11c668
    }

    shift |= shiftcode[data];
  101512:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101516:	0f b6 80 40 90 11 00 	movzbl 0x119040(%eax),%eax
  10151d:	0f b6 d0             	movzbl %al,%edx
  101520:	a1 68 c6 11 00       	mov    0x11c668,%eax
  101525:	09 d0                	or     %edx,%eax
  101527:	a3 68 c6 11 00       	mov    %eax,0x11c668
    shift ^= togglecode[data];
  10152c:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101530:	0f b6 80 40 91 11 00 	movzbl 0x119140(%eax),%eax
  101537:	0f b6 d0             	movzbl %al,%edx
  10153a:	a1 68 c6 11 00       	mov    0x11c668,%eax
  10153f:	31 d0                	xor    %edx,%eax
  101541:	a3 68 c6 11 00       	mov    %eax,0x11c668

    c = charcode[shift & (CTL | SHIFT)][data];
  101546:	a1 68 c6 11 00       	mov    0x11c668,%eax
  10154b:	83 e0 03             	and    $0x3,%eax
  10154e:	8b 14 85 40 95 11 00 	mov    0x119540(,%eax,4),%edx
  101555:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101559:	01 d0                	add    %edx,%eax
  10155b:	0f b6 00             	movzbl (%eax),%eax
  10155e:	0f b6 c0             	movzbl %al,%eax
  101561:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  101564:	a1 68 c6 11 00       	mov    0x11c668,%eax
  101569:	83 e0 08             	and    $0x8,%eax
  10156c:	85 c0                	test   %eax,%eax
  10156e:	74 22                	je     101592 <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  101570:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  101574:	7e 0c                	jle    101582 <kbd_proc_data+0x13e>
  101576:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  10157a:	7f 06                	jg     101582 <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  10157c:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  101580:	eb 10                	jmp    101592 <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  101582:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  101586:	7e 0a                	jle    101592 <kbd_proc_data+0x14e>
  101588:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  10158c:	7f 04                	jg     101592 <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  10158e:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  101592:	a1 68 c6 11 00       	mov    0x11c668,%eax
  101597:	f7 d0                	not    %eax
  101599:	83 e0 06             	and    $0x6,%eax
  10159c:	85 c0                	test   %eax,%eax
  10159e:	75 28                	jne    1015c8 <kbd_proc_data+0x184>
  1015a0:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1015a7:	75 1f                	jne    1015c8 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  1015a9:	c7 04 24 05 64 10 00 	movl   $0x106405,(%esp)
  1015b0:	e8 14 ed ff ff       	call   1002c9 <cprintf>
  1015b5:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1015bb:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1015bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  1015c3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1015c6:	ee                   	out    %al,(%dx)
}
  1015c7:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  1015c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1015cb:	c9                   	leave  
  1015cc:	c3                   	ret    

001015cd <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  1015cd:	f3 0f 1e fb          	endbr32 
  1015d1:	55                   	push   %ebp
  1015d2:	89 e5                	mov    %esp,%ebp
  1015d4:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  1015d7:	c7 04 24 44 14 10 00 	movl   $0x101444,(%esp)
  1015de:	e8 93 fd ff ff       	call   101376 <cons_intr>
}
  1015e3:	90                   	nop
  1015e4:	c9                   	leave  
  1015e5:	c3                   	ret    

001015e6 <kbd_init>:

static void
kbd_init(void) {
  1015e6:	f3 0f 1e fb          	endbr32 
  1015ea:	55                   	push   %ebp
  1015eb:	89 e5                	mov    %esp,%ebp
  1015ed:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  1015f0:	e8 d8 ff ff ff       	call   1015cd <kbd_intr>
    pic_enable(IRQ_KBD);
  1015f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1015fc:	e8 47 01 00 00       	call   101748 <pic_enable>
}
  101601:	90                   	nop
  101602:	c9                   	leave  
  101603:	c3                   	ret    

00101604 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  101604:	f3 0f 1e fb          	endbr32 
  101608:	55                   	push   %ebp
  101609:	89 e5                	mov    %esp,%ebp
  10160b:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  10160e:	e8 2e f8 ff ff       	call   100e41 <cga_init>
    serial_init();
  101613:	e8 13 f9 ff ff       	call   100f2b <serial_init>
    kbd_init();
  101618:	e8 c9 ff ff ff       	call   1015e6 <kbd_init>
    if (!serial_exists) {
  10161d:	a1 48 c4 11 00       	mov    0x11c448,%eax
  101622:	85 c0                	test   %eax,%eax
  101624:	75 0c                	jne    101632 <cons_init+0x2e>
        cprintf("serial port does not exist!!\n");
  101626:	c7 04 24 11 64 10 00 	movl   $0x106411,(%esp)
  10162d:	e8 97 ec ff ff       	call   1002c9 <cprintf>
    }
}
  101632:	90                   	nop
  101633:	c9                   	leave  
  101634:	c3                   	ret    

00101635 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  101635:	f3 0f 1e fb          	endbr32 
  101639:	55                   	push   %ebp
  10163a:	89 e5                	mov    %esp,%ebp
  10163c:	83 ec 28             	sub    $0x28,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
  10163f:	e8 72 f7 ff ff       	call   100db6 <__intr_save>
  101644:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        lpt_putc(c);
  101647:	8b 45 08             	mov    0x8(%ebp),%eax
  10164a:	89 04 24             	mov    %eax,(%esp)
  10164d:	e8 48 fa ff ff       	call   10109a <lpt_putc>
        cga_putc(c);
  101652:	8b 45 08             	mov    0x8(%ebp),%eax
  101655:	89 04 24             	mov    %eax,(%esp)
  101658:	e8 81 fa ff ff       	call   1010de <cga_putc>
        serial_putc(c);
  10165d:	8b 45 08             	mov    0x8(%ebp),%eax
  101660:	89 04 24             	mov    %eax,(%esp)
  101663:	e8 ca fc ff ff       	call   101332 <serial_putc>
    }
    local_intr_restore(intr_flag);
  101668:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10166b:	89 04 24             	mov    %eax,(%esp)
  10166e:	e8 6d f7 ff ff       	call   100de0 <__intr_restore>
}
  101673:	90                   	nop
  101674:	c9                   	leave  
  101675:	c3                   	ret    

00101676 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  101676:	f3 0f 1e fb          	endbr32 
  10167a:	55                   	push   %ebp
  10167b:	89 e5                	mov    %esp,%ebp
  10167d:	83 ec 28             	sub    $0x28,%esp
    int c = 0;
  101680:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
  101687:	e8 2a f7 ff ff       	call   100db6 <__intr_save>
  10168c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        // poll for any pending input characters,
        // so that this function works even when interrupts are disabled
        // (e.g., when called from the kernel monitor).
        serial_intr();
  10168f:	e8 8e fd ff ff       	call   101422 <serial_intr>
        kbd_intr();
  101694:	e8 34 ff ff ff       	call   1015cd <kbd_intr>

        // grab the next character from the input buffer.
        if (cons.rpos != cons.wpos) {
  101699:	8b 15 60 c6 11 00    	mov    0x11c660,%edx
  10169f:	a1 64 c6 11 00       	mov    0x11c664,%eax
  1016a4:	39 c2                	cmp    %eax,%edx
  1016a6:	74 31                	je     1016d9 <cons_getc+0x63>
            c = cons.buf[cons.rpos ++];
  1016a8:	a1 60 c6 11 00       	mov    0x11c660,%eax
  1016ad:	8d 50 01             	lea    0x1(%eax),%edx
  1016b0:	89 15 60 c6 11 00    	mov    %edx,0x11c660
  1016b6:	0f b6 80 60 c4 11 00 	movzbl 0x11c460(%eax),%eax
  1016bd:	0f b6 c0             	movzbl %al,%eax
  1016c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
            if (cons.rpos == CONSBUFSIZE) {
  1016c3:	a1 60 c6 11 00       	mov    0x11c660,%eax
  1016c8:	3d 00 02 00 00       	cmp    $0x200,%eax
  1016cd:	75 0a                	jne    1016d9 <cons_getc+0x63>
                cons.rpos = 0;
  1016cf:	c7 05 60 c6 11 00 00 	movl   $0x0,0x11c660
  1016d6:	00 00 00 
            }
        }
    }
    local_intr_restore(intr_flag);
  1016d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1016dc:	89 04 24             	mov    %eax,(%esp)
  1016df:	e8 fc f6 ff ff       	call   100de0 <__intr_restore>
    return c;
  1016e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1016e7:	c9                   	leave  
  1016e8:	c3                   	ret    

001016e9 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  1016e9:	f3 0f 1e fb          	endbr32 
  1016ed:	55                   	push   %ebp
  1016ee:	89 e5                	mov    %esp,%ebp
  1016f0:	83 ec 14             	sub    $0x14,%esp
  1016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  1016f6:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  1016fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1016fd:	66 a3 50 95 11 00    	mov    %ax,0x119550
    if (did_init) {
  101703:	a1 6c c6 11 00       	mov    0x11c66c,%eax
  101708:	85 c0                	test   %eax,%eax
  10170a:	74 39                	je     101745 <pic_setmask+0x5c>
        outb(IO_PIC1 + 1, mask);
  10170c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10170f:	0f b6 c0             	movzbl %al,%eax
  101712:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  101718:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10171b:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10171f:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101723:	ee                   	out    %al,(%dx)
}
  101724:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
  101725:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101729:	c1 e8 08             	shr    $0x8,%eax
  10172c:	0f b7 c0             	movzwl %ax,%eax
  10172f:	0f b6 c0             	movzbl %al,%eax
  101732:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  101738:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10173b:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  10173f:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101743:	ee                   	out    %al,(%dx)
}
  101744:	90                   	nop
    }
}
  101745:	90                   	nop
  101746:	c9                   	leave  
  101747:	c3                   	ret    

00101748 <pic_enable>:

void
pic_enable(unsigned int irq) {
  101748:	f3 0f 1e fb          	endbr32 
  10174c:	55                   	push   %ebp
  10174d:	89 e5                	mov    %esp,%ebp
  10174f:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  101752:	8b 45 08             	mov    0x8(%ebp),%eax
  101755:	ba 01 00 00 00       	mov    $0x1,%edx
  10175a:	88 c1                	mov    %al,%cl
  10175c:	d3 e2                	shl    %cl,%edx
  10175e:	89 d0                	mov    %edx,%eax
  101760:	98                   	cwtl   
  101761:	f7 d0                	not    %eax
  101763:	0f bf d0             	movswl %ax,%edx
  101766:	0f b7 05 50 95 11 00 	movzwl 0x119550,%eax
  10176d:	98                   	cwtl   
  10176e:	21 d0                	and    %edx,%eax
  101770:	98                   	cwtl   
  101771:	0f b7 c0             	movzwl %ax,%eax
  101774:	89 04 24             	mov    %eax,(%esp)
  101777:	e8 6d ff ff ff       	call   1016e9 <pic_setmask>
}
  10177c:	90                   	nop
  10177d:	c9                   	leave  
  10177e:	c3                   	ret    

0010177f <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  10177f:	f3 0f 1e fb          	endbr32 
  101783:	55                   	push   %ebp
  101784:	89 e5                	mov    %esp,%ebp
  101786:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  101789:	c7 05 6c c6 11 00 01 	movl   $0x1,0x11c66c
  101790:	00 00 00 
  101793:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  101799:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10179d:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1017a1:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1017a5:	ee                   	out    %al,(%dx)
}
  1017a6:	90                   	nop
  1017a7:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  1017ad:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1017b1:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1017b5:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1017b9:	ee                   	out    %al,(%dx)
}
  1017ba:	90                   	nop
  1017bb:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1017c1:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1017c5:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017c9:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017cd:	ee                   	out    %al,(%dx)
}
  1017ce:	90                   	nop
  1017cf:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  1017d5:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1017d9:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1017dd:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1017e1:	ee                   	out    %al,(%dx)
}
  1017e2:	90                   	nop
  1017e3:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  1017e9:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1017ed:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  1017f1:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  1017f5:	ee                   	out    %al,(%dx)
}
  1017f6:	90                   	nop
  1017f7:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  1017fd:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101801:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101805:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101809:	ee                   	out    %al,(%dx)
}
  10180a:	90                   	nop
  10180b:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  101811:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101815:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101819:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  10181d:	ee                   	out    %al,(%dx)
}
  10181e:	90                   	nop
  10181f:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  101825:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101829:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10182d:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101831:	ee                   	out    %al,(%dx)
}
  101832:	90                   	nop
  101833:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  101839:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10183d:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101841:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101845:	ee                   	out    %al,(%dx)
}
  101846:	90                   	nop
  101847:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  10184d:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101851:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101855:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101859:	ee                   	out    %al,(%dx)
}
  10185a:	90                   	nop
  10185b:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101861:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101865:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101869:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10186d:	ee                   	out    %al,(%dx)
}
  10186e:	90                   	nop
  10186f:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101875:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  101879:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10187d:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101881:	ee                   	out    %al,(%dx)
}
  101882:	90                   	nop
  101883:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  101889:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  10188d:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101891:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101895:	ee                   	out    %al,(%dx)
}
  101896:	90                   	nop
  101897:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  10189d:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
  1018a1:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1018a5:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1018a9:	ee                   	out    %al,(%dx)
}
  1018aa:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1018ab:	0f b7 05 50 95 11 00 	movzwl 0x119550,%eax
  1018b2:	3d ff ff 00 00       	cmp    $0xffff,%eax
  1018b7:	74 0f                	je     1018c8 <pic_init+0x149>
        pic_setmask(irq_mask);
  1018b9:	0f b7 05 50 95 11 00 	movzwl 0x119550,%eax
  1018c0:	89 04 24             	mov    %eax,(%esp)
  1018c3:	e8 21 fe ff ff       	call   1016e9 <pic_setmask>
    }
}
  1018c8:	90                   	nop
  1018c9:	c9                   	leave  
  1018ca:	c3                   	ret    

001018cb <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1018cb:	f3 0f 1e fb          	endbr32 
  1018cf:	55                   	push   %ebp
  1018d0:	89 e5                	mov    %esp,%ebp
    asm volatile ("sti");
  1018d2:	fb                   	sti    
}
  1018d3:	90                   	nop
    sti();
}
  1018d4:	90                   	nop
  1018d5:	5d                   	pop    %ebp
  1018d6:	c3                   	ret    

001018d7 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1018d7:	f3 0f 1e fb          	endbr32 
  1018db:	55                   	push   %ebp
  1018dc:	89 e5                	mov    %esp,%ebp
    asm volatile ("cli" ::: "memory");
  1018de:	fa                   	cli    
}
  1018df:	90                   	nop
    cli();
}
  1018e0:	90                   	nop
  1018e1:	5d                   	pop    %ebp
  1018e2:	c3                   	ret    

001018e3 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  1018e3:	f3 0f 1e fb          	endbr32 
  1018e7:	55                   	push   %ebp
  1018e8:	89 e5                	mov    %esp,%ebp
  1018ea:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  1018ed:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  1018f4:	00 
  1018f5:	c7 04 24 40 64 10 00 	movl   $0x106440,(%esp)
  1018fc:	e8 c8 e9 ff ff       	call   1002c9 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
  101901:	c7 04 24 4a 64 10 00 	movl   $0x10644a,(%esp)
  101908:	e8 bc e9 ff ff       	call   1002c9 <cprintf>
    panic("EOT: kernel seems ok.");
  10190d:	c7 44 24 08 58 64 10 	movl   $0x106458,0x8(%esp)
  101914:	00 
  101915:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
  10191c:	00 
  10191d:	c7 04 24 6e 64 10 00 	movl   $0x10646e,(%esp)
  101924:	e8 0c eb ff ff       	call   100435 <__panic>

00101929 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101929:	f3 0f 1e fb          	endbr32 
  10192d:	55                   	push   %ebp
  10192e:	89 e5                	mov    %esp,%ebp
  101930:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[]; 
    int i;
    for(i=0; i<sizeof(idt)/sizeof(struct gatedesc);i++){
  101933:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10193a:	e9 c4 00 00 00       	jmp    101a03 <idt_init+0xda>
        //由该文件可知，所有中断向量的中断处理函数地址均保存在__vectors数组中，该数组中第i个元素对应第i个中断向量的中断处理函数地址。
        //而且由文件开头可知，中断处理函数属于.text的内容。因此，中断处理函数的段选择子即.text的段选择子GD_KTEXT。
        //从kern / mm / pmm.c可知.text的段基址为0，因此中断处理函数地址的偏移量等于其地址本身。
        //dpl  DPL_KERNEL
        // 除了T_SWITCH_TOK是DPL_USER其他都是DPL_KERNEL。
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);//初始化idt
  10193f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101942:	8b 04 85 e0 95 11 00 	mov    0x1195e0(,%eax,4),%eax
  101949:	0f b7 d0             	movzwl %ax,%edx
  10194c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10194f:	66 89 14 c5 80 c6 11 	mov    %dx,0x11c680(,%eax,8)
  101956:	00 
  101957:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10195a:	66 c7 04 c5 82 c6 11 	movw   $0x8,0x11c682(,%eax,8)
  101961:	00 08 00 
  101964:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101967:	0f b6 14 c5 84 c6 11 	movzbl 0x11c684(,%eax,8),%edx
  10196e:	00 
  10196f:	80 e2 e0             	and    $0xe0,%dl
  101972:	88 14 c5 84 c6 11 00 	mov    %dl,0x11c684(,%eax,8)
  101979:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10197c:	0f b6 14 c5 84 c6 11 	movzbl 0x11c684(,%eax,8),%edx
  101983:	00 
  101984:	80 e2 1f             	and    $0x1f,%dl
  101987:	88 14 c5 84 c6 11 00 	mov    %dl,0x11c684(,%eax,8)
  10198e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101991:	0f b6 14 c5 85 c6 11 	movzbl 0x11c685(,%eax,8),%edx
  101998:	00 
  101999:	80 e2 f0             	and    $0xf0,%dl
  10199c:	80 ca 0e             	or     $0xe,%dl
  10199f:	88 14 c5 85 c6 11 00 	mov    %dl,0x11c685(,%eax,8)
  1019a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019a9:	0f b6 14 c5 85 c6 11 	movzbl 0x11c685(,%eax,8),%edx
  1019b0:	00 
  1019b1:	80 e2 ef             	and    $0xef,%dl
  1019b4:	88 14 c5 85 c6 11 00 	mov    %dl,0x11c685(,%eax,8)
  1019bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019be:	0f b6 14 c5 85 c6 11 	movzbl 0x11c685(,%eax,8),%edx
  1019c5:	00 
  1019c6:	80 e2 9f             	and    $0x9f,%dl
  1019c9:	88 14 c5 85 c6 11 00 	mov    %dl,0x11c685(,%eax,8)
  1019d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019d3:	0f b6 14 c5 85 c6 11 	movzbl 0x11c685(,%eax,8),%edx
  1019da:	00 
  1019db:	80 ca 80             	or     $0x80,%dl
  1019de:	88 14 c5 85 c6 11 00 	mov    %dl,0x11c685(,%eax,8)
  1019e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019e8:	8b 04 85 e0 95 11 00 	mov    0x1195e0(,%eax,4),%eax
  1019ef:	c1 e8 10             	shr    $0x10,%eax
  1019f2:	0f b7 d0             	movzwl %ax,%edx
  1019f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019f8:	66 89 14 c5 86 c6 11 	mov    %dx,0x11c686(,%eax,8)
  1019ff:	00 
    for(i=0; i<sizeof(idt)/sizeof(struct gatedesc);i++){
  101a00:	ff 45 fc             	incl   -0x4(%ebp)
  101a03:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a06:	3d ff 00 00 00       	cmp    $0xff,%eax
  101a0b:	0f 86 2e ff ff ff    	jbe    10193f <idt_init+0x16>
    } 
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);//因为在发生中断时候，我们需要从用户态切换到内核态，所以得留个口让用户态进来
  101a11:	a1 c4 97 11 00       	mov    0x1197c4,%eax
  101a16:	0f b7 c0             	movzwl %ax,%eax
  101a19:	66 a3 48 ca 11 00    	mov    %ax,0x11ca48
  101a1f:	66 c7 05 4a ca 11 00 	movw   $0x8,0x11ca4a
  101a26:	08 00 
  101a28:	0f b6 05 4c ca 11 00 	movzbl 0x11ca4c,%eax
  101a2f:	24 e0                	and    $0xe0,%al
  101a31:	a2 4c ca 11 00       	mov    %al,0x11ca4c
  101a36:	0f b6 05 4c ca 11 00 	movzbl 0x11ca4c,%eax
  101a3d:	24 1f                	and    $0x1f,%al
  101a3f:	a2 4c ca 11 00       	mov    %al,0x11ca4c
  101a44:	0f b6 05 4d ca 11 00 	movzbl 0x11ca4d,%eax
  101a4b:	24 f0                	and    $0xf0,%al
  101a4d:	0c 0e                	or     $0xe,%al
  101a4f:	a2 4d ca 11 00       	mov    %al,0x11ca4d
  101a54:	0f b6 05 4d ca 11 00 	movzbl 0x11ca4d,%eax
  101a5b:	24 ef                	and    $0xef,%al
  101a5d:	a2 4d ca 11 00       	mov    %al,0x11ca4d
  101a62:	0f b6 05 4d ca 11 00 	movzbl 0x11ca4d,%eax
  101a69:	0c 60                	or     $0x60,%al
  101a6b:	a2 4d ca 11 00       	mov    %al,0x11ca4d
  101a70:	0f b6 05 4d ca 11 00 	movzbl 0x11ca4d,%eax
  101a77:	0c 80                	or     $0x80,%al
  101a79:	a2 4d ca 11 00       	mov    %al,0x11ca4d
  101a7e:	a1 c4 97 11 00       	mov    0x1197c4,%eax
  101a83:	c1 e8 10             	shr    $0x10,%eax
  101a86:	0f b7 c0             	movzwl %ax,%eax
  101a89:	66 a3 4e ca 11 00    	mov    %ax,0x11ca4e
  101a8f:	c7 45 f8 60 95 11 00 	movl   $0x119560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd) : "memory");
  101a96:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101a99:	0f 01 18             	lidtl  (%eax)
}
  101a9c:	90                   	nop
    lidt(&idt_pd);
}
  101a9d:	90                   	nop
  101a9e:	c9                   	leave  
  101a9f:	c3                   	ret    

00101aa0 <trapname>:

static const char *
trapname(int trapno) {
  101aa0:	f3 0f 1e fb          	endbr32 
  101aa4:	55                   	push   %ebp
  101aa5:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101aa7:	8b 45 08             	mov    0x8(%ebp),%eax
  101aaa:	83 f8 13             	cmp    $0x13,%eax
  101aad:	77 0c                	ja     101abb <trapname+0x1b>
        return excnames[trapno];
  101aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  101ab2:	8b 04 85 c0 67 10 00 	mov    0x1067c0(,%eax,4),%eax
  101ab9:	eb 18                	jmp    101ad3 <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101abb:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101abf:	7e 0d                	jle    101ace <trapname+0x2e>
  101ac1:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101ac5:	7f 07                	jg     101ace <trapname+0x2e>
        return "Hardware Interrupt";
  101ac7:	b8 7f 64 10 00       	mov    $0x10647f,%eax
  101acc:	eb 05                	jmp    101ad3 <trapname+0x33>
    }
    return "(unknown trap)";
  101ace:	b8 92 64 10 00       	mov    $0x106492,%eax
}
  101ad3:	5d                   	pop    %ebp
  101ad4:	c3                   	ret    

00101ad5 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101ad5:	f3 0f 1e fb          	endbr32 
  101ad9:	55                   	push   %ebp
  101ada:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101adc:	8b 45 08             	mov    0x8(%ebp),%eax
  101adf:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ae3:	83 f8 08             	cmp    $0x8,%eax
  101ae6:	0f 94 c0             	sete   %al
  101ae9:	0f b6 c0             	movzbl %al,%eax
}
  101aec:	5d                   	pop    %ebp
  101aed:	c3                   	ret    

00101aee <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101aee:	f3 0f 1e fb          	endbr32 
  101af2:	55                   	push   %ebp
  101af3:	89 e5                	mov    %esp,%ebp
  101af5:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101af8:	8b 45 08             	mov    0x8(%ebp),%eax
  101afb:	89 44 24 04          	mov    %eax,0x4(%esp)
  101aff:	c7 04 24 d3 64 10 00 	movl   $0x1064d3,(%esp)
  101b06:	e8 be e7 ff ff       	call   1002c9 <cprintf>
    print_regs(&tf->tf_regs);
  101b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  101b0e:	89 04 24             	mov    %eax,(%esp)
  101b11:	e8 8d 01 00 00       	call   101ca3 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101b16:	8b 45 08             	mov    0x8(%ebp),%eax
  101b19:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101b1d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b21:	c7 04 24 e4 64 10 00 	movl   $0x1064e4,(%esp)
  101b28:	e8 9c e7 ff ff       	call   1002c9 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  101b30:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101b34:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b38:	c7 04 24 f7 64 10 00 	movl   $0x1064f7,(%esp)
  101b3f:	e8 85 e7 ff ff       	call   1002c9 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101b44:	8b 45 08             	mov    0x8(%ebp),%eax
  101b47:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101b4b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b4f:	c7 04 24 0a 65 10 00 	movl   $0x10650a,(%esp)
  101b56:	e8 6e e7 ff ff       	call   1002c9 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  101b5e:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101b62:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b66:	c7 04 24 1d 65 10 00 	movl   $0x10651d,(%esp)
  101b6d:	e8 57 e7 ff ff       	call   1002c9 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101b72:	8b 45 08             	mov    0x8(%ebp),%eax
  101b75:	8b 40 30             	mov    0x30(%eax),%eax
  101b78:	89 04 24             	mov    %eax,(%esp)
  101b7b:	e8 20 ff ff ff       	call   101aa0 <trapname>
  101b80:	8b 55 08             	mov    0x8(%ebp),%edx
  101b83:	8b 52 30             	mov    0x30(%edx),%edx
  101b86:	89 44 24 08          	mov    %eax,0x8(%esp)
  101b8a:	89 54 24 04          	mov    %edx,0x4(%esp)
  101b8e:	c7 04 24 30 65 10 00 	movl   $0x106530,(%esp)
  101b95:	e8 2f e7 ff ff       	call   1002c9 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  101b9d:	8b 40 34             	mov    0x34(%eax),%eax
  101ba0:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ba4:	c7 04 24 42 65 10 00 	movl   $0x106542,(%esp)
  101bab:	e8 19 e7 ff ff       	call   1002c9 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  101bb3:	8b 40 38             	mov    0x38(%eax),%eax
  101bb6:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bba:	c7 04 24 51 65 10 00 	movl   $0x106551,(%esp)
  101bc1:	e8 03 e7 ff ff       	call   1002c9 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  101bc9:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101bcd:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bd1:	c7 04 24 60 65 10 00 	movl   $0x106560,(%esp)
  101bd8:	e8 ec e6 ff ff       	call   1002c9 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  101be0:	8b 40 40             	mov    0x40(%eax),%eax
  101be3:	89 44 24 04          	mov    %eax,0x4(%esp)
  101be7:	c7 04 24 73 65 10 00 	movl   $0x106573,(%esp)
  101bee:	e8 d6 e6 ff ff       	call   1002c9 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101bf3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101bfa:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101c01:	eb 3d                	jmp    101c40 <print_trapframe+0x152>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101c03:	8b 45 08             	mov    0x8(%ebp),%eax
  101c06:	8b 50 40             	mov    0x40(%eax),%edx
  101c09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c0c:	21 d0                	and    %edx,%eax
  101c0e:	85 c0                	test   %eax,%eax
  101c10:	74 28                	je     101c3a <print_trapframe+0x14c>
  101c12:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c15:	8b 04 85 80 95 11 00 	mov    0x119580(,%eax,4),%eax
  101c1c:	85 c0                	test   %eax,%eax
  101c1e:	74 1a                	je     101c3a <print_trapframe+0x14c>
            cprintf("%s,", IA32flags[i]);
  101c20:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c23:	8b 04 85 80 95 11 00 	mov    0x119580(,%eax,4),%eax
  101c2a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c2e:	c7 04 24 82 65 10 00 	movl   $0x106582,(%esp)
  101c35:	e8 8f e6 ff ff       	call   1002c9 <cprintf>
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c3a:	ff 45 f4             	incl   -0xc(%ebp)
  101c3d:	d1 65 f0             	shll   -0x10(%ebp)
  101c40:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c43:	83 f8 17             	cmp    $0x17,%eax
  101c46:	76 bb                	jbe    101c03 <print_trapframe+0x115>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101c48:	8b 45 08             	mov    0x8(%ebp),%eax
  101c4b:	8b 40 40             	mov    0x40(%eax),%eax
  101c4e:	c1 e8 0c             	shr    $0xc,%eax
  101c51:	83 e0 03             	and    $0x3,%eax
  101c54:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c58:	c7 04 24 86 65 10 00 	movl   $0x106586,(%esp)
  101c5f:	e8 65 e6 ff ff       	call   1002c9 <cprintf>

    if (!trap_in_kernel(tf)) {
  101c64:	8b 45 08             	mov    0x8(%ebp),%eax
  101c67:	89 04 24             	mov    %eax,(%esp)
  101c6a:	e8 66 fe ff ff       	call   101ad5 <trap_in_kernel>
  101c6f:	85 c0                	test   %eax,%eax
  101c71:	75 2d                	jne    101ca0 <print_trapframe+0x1b2>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101c73:	8b 45 08             	mov    0x8(%ebp),%eax
  101c76:	8b 40 44             	mov    0x44(%eax),%eax
  101c79:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c7d:	c7 04 24 8f 65 10 00 	movl   $0x10658f,(%esp)
  101c84:	e8 40 e6 ff ff       	call   1002c9 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101c89:	8b 45 08             	mov    0x8(%ebp),%eax
  101c8c:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101c90:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c94:	c7 04 24 9e 65 10 00 	movl   $0x10659e,(%esp)
  101c9b:	e8 29 e6 ff ff       	call   1002c9 <cprintf>
    }
}
  101ca0:	90                   	nop
  101ca1:	c9                   	leave  
  101ca2:	c3                   	ret    

00101ca3 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101ca3:	f3 0f 1e fb          	endbr32 
  101ca7:	55                   	push   %ebp
  101ca8:	89 e5                	mov    %esp,%ebp
  101caa:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101cad:	8b 45 08             	mov    0x8(%ebp),%eax
  101cb0:	8b 00                	mov    (%eax),%eax
  101cb2:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cb6:	c7 04 24 b1 65 10 00 	movl   $0x1065b1,(%esp)
  101cbd:	e8 07 e6 ff ff       	call   1002c9 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  101cc5:	8b 40 04             	mov    0x4(%eax),%eax
  101cc8:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ccc:	c7 04 24 c0 65 10 00 	movl   $0x1065c0,(%esp)
  101cd3:	e8 f1 e5 ff ff       	call   1002c9 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  101cdb:	8b 40 08             	mov    0x8(%eax),%eax
  101cde:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ce2:	c7 04 24 cf 65 10 00 	movl   $0x1065cf,(%esp)
  101ce9:	e8 db e5 ff ff       	call   1002c9 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101cee:	8b 45 08             	mov    0x8(%ebp),%eax
  101cf1:	8b 40 0c             	mov    0xc(%eax),%eax
  101cf4:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cf8:	c7 04 24 de 65 10 00 	movl   $0x1065de,(%esp)
  101cff:	e8 c5 e5 ff ff       	call   1002c9 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101d04:	8b 45 08             	mov    0x8(%ebp),%eax
  101d07:	8b 40 10             	mov    0x10(%eax),%eax
  101d0a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d0e:	c7 04 24 ed 65 10 00 	movl   $0x1065ed,(%esp)
  101d15:	e8 af e5 ff ff       	call   1002c9 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  101d1d:	8b 40 14             	mov    0x14(%eax),%eax
  101d20:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d24:	c7 04 24 fc 65 10 00 	movl   $0x1065fc,(%esp)
  101d2b:	e8 99 e5 ff ff       	call   1002c9 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101d30:	8b 45 08             	mov    0x8(%ebp),%eax
  101d33:	8b 40 18             	mov    0x18(%eax),%eax
  101d36:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d3a:	c7 04 24 0b 66 10 00 	movl   $0x10660b,(%esp)
  101d41:	e8 83 e5 ff ff       	call   1002c9 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101d46:	8b 45 08             	mov    0x8(%ebp),%eax
  101d49:	8b 40 1c             	mov    0x1c(%eax),%eax
  101d4c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d50:	c7 04 24 1a 66 10 00 	movl   $0x10661a,(%esp)
  101d57:	e8 6d e5 ff ff       	call   1002c9 <cprintf>
}
  101d5c:	90                   	nop
  101d5d:	c9                   	leave  
  101d5e:	c3                   	ret    

00101d5f <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101d5f:	f3 0f 1e fb          	endbr32 
  101d63:	55                   	push   %ebp
  101d64:	89 e5                	mov    %esp,%ebp
  101d66:	83 ec 28             	sub    $0x28,%esp
    char c;

    switch (tf->tf_trapno) {
  101d69:	8b 45 08             	mov    0x8(%ebp),%eax
  101d6c:	8b 40 30             	mov    0x30(%eax),%eax
  101d6f:	83 f8 79             	cmp    $0x79,%eax
  101d72:	0f 84 44 01 00 00    	je     101ebc <trap_dispatch+0x15d>
  101d78:	83 f8 79             	cmp    $0x79,%eax
  101d7b:	0f 87 7c 01 00 00    	ja     101efd <trap_dispatch+0x19e>
  101d81:	83 f8 78             	cmp    $0x78,%eax
  101d84:	0f 84 d0 00 00 00    	je     101e5a <trap_dispatch+0xfb>
  101d8a:	83 f8 78             	cmp    $0x78,%eax
  101d8d:	0f 87 6a 01 00 00    	ja     101efd <trap_dispatch+0x19e>
  101d93:	83 f8 2f             	cmp    $0x2f,%eax
  101d96:	0f 87 61 01 00 00    	ja     101efd <trap_dispatch+0x19e>
  101d9c:	83 f8 2e             	cmp    $0x2e,%eax
  101d9f:	0f 83 8d 01 00 00    	jae    101f32 <trap_dispatch+0x1d3>
  101da5:	83 f8 24             	cmp    $0x24,%eax
  101da8:	74 5e                	je     101e08 <trap_dispatch+0xa9>
  101daa:	83 f8 24             	cmp    $0x24,%eax
  101dad:	0f 87 4a 01 00 00    	ja     101efd <trap_dispatch+0x19e>
  101db3:	83 f8 20             	cmp    $0x20,%eax
  101db6:	74 0a                	je     101dc2 <trap_dispatch+0x63>
  101db8:	83 f8 21             	cmp    $0x21,%eax
  101dbb:	74 74                	je     101e31 <trap_dispatch+0xd2>
  101dbd:	e9 3b 01 00 00       	jmp    101efd <trap_dispatch+0x19e>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks++;
  101dc2:	a1 0c cf 11 00       	mov    0x11cf0c,%eax
  101dc7:	40                   	inc    %eax
  101dc8:	a3 0c cf 11 00       	mov    %eax,0x11cf0c
        if(ticks%TICK_NUM==0){
  101dcd:	8b 0d 0c cf 11 00    	mov    0x11cf0c,%ecx
  101dd3:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101dd8:	89 c8                	mov    %ecx,%eax
  101dda:	f7 e2                	mul    %edx
  101ddc:	c1 ea 05             	shr    $0x5,%edx
  101ddf:	89 d0                	mov    %edx,%eax
  101de1:	c1 e0 02             	shl    $0x2,%eax
  101de4:	01 d0                	add    %edx,%eax
  101de6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  101ded:	01 d0                	add    %edx,%eax
  101def:	c1 e0 02             	shl    $0x2,%eax
  101df2:	29 c1                	sub    %eax,%ecx
  101df4:	89 ca                	mov    %ecx,%edx
  101df6:	85 d2                	test   %edx,%edx
  101df8:	0f 85 37 01 00 00    	jne    101f35 <trap_dispatch+0x1d6>
            print_ticks();
  101dfe:	e8 e0 fa ff ff       	call   1018e3 <print_ticks>
        }
        break;
  101e03:	e9 2d 01 00 00       	jmp    101f35 <trap_dispatch+0x1d6>
    case IRQ_OFFSET + IRQ_COM1://若中断号是IRQ_OFFSET + IRQ_COM1 为串口中断，则显示收到的字符
        c = cons_getc();
  101e08:	e8 69 f8 ff ff       	call   101676 <cons_getc>
  101e0d:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101e10:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e14:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e18:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e1c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e20:	c7 04 24 29 66 10 00 	movl   $0x106629,(%esp)
  101e27:	e8 9d e4 ff ff       	call   1002c9 <cprintf>
        break;
  101e2c:	e9 0b 01 00 00       	jmp    101f3c <trap_dispatch+0x1dd>
    case IRQ_OFFSET + IRQ_KBD://若中断号是IRQ_OFFSET + IRQ_KBD 为 键盘中断，则显示收到的字符
        c = cons_getc();
  101e31:	e8 40 f8 ff ff       	call   101676 <cons_getc>
  101e36:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101e39:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e3d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e41:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e45:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e49:	c7 04 24 3b 66 10 00 	movl   $0x10663b,(%esp)
  101e50:	e8 74 e4 ff ff       	call   1002c9 <cprintf>
        break;
  101e55:	e9 e2 00 00 00       	jmp    101f3c <trap_dispatch+0x1dd>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    //tf trapframe  栈帧结构体
    case T_SWITCH_TOU://内核→用户
        //panic("T_SWITCH_USER ??\n");
    	if (tf->tf_cs != USER_CS) {
  101e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  101e5d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e61:	83 f8 1b             	cmp    $0x1b,%eax
  101e64:	0f 84 ce 00 00 00    	je     101f38 <trap_dispatch+0x1d9>
            tf->tf_cs = USER_CS;
  101e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  101e6d:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
            tf->tf_ds = tf->tf_es = tf->tf_ss = USER_DS;
  101e73:	8b 45 08             	mov    0x8(%ebp),%eax
  101e76:	66 c7 40 48 23 00    	movw   $0x23,0x48(%eax)
  101e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  101e7f:	0f b7 50 48          	movzwl 0x48(%eax),%edx
  101e83:	8b 45 08             	mov    0x8(%ebp),%eax
  101e86:	66 89 50 28          	mov    %dx,0x28(%eax)
  101e8a:	8b 45 08             	mov    0x8(%ebp),%eax
  101e8d:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101e91:	8b 45 08             	mov    0x8(%ebp),%eax
  101e94:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_esp += 4;
  101e98:	8b 45 08             	mov    0x8(%ebp),%eax
  101e9b:	8b 40 44             	mov    0x44(%eax),%eax
  101e9e:	8d 50 04             	lea    0x4(%eax),%edx
  101ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ea4:	89 50 44             	mov    %edx,0x44(%eax)
            tf->tf_eflags |= FL_IOPL_MASK;
  101ea7:	8b 45 08             	mov    0x8(%ebp),%eax
  101eaa:	8b 40 40             	mov    0x40(%eax),%eax
  101ead:	0d 00 30 00 00       	or     $0x3000,%eax
  101eb2:	89 c2                	mov    %eax,%edx
  101eb4:	8b 45 08             	mov    0x8(%ebp),%eax
  101eb7:	89 50 40             	mov    %edx,0x40(%eax)
        }
        break;
  101eba:	eb 7c                	jmp    101f38 <trap_dispatch+0x1d9>
    case T_SWITCH_TOK://用户→内核
        //panic("T_SWITCH_KERNEL ??\n");
        if (tf->tf_cs != KERNEL_CS) {
  101ebc:	8b 45 08             	mov    0x8(%ebp),%eax
  101ebf:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ec3:	83 f8 08             	cmp    $0x8,%eax
  101ec6:	74 73                	je     101f3b <trap_dispatch+0x1dc>
            tf->tf_cs = KERNEL_CS;
  101ec8:	8b 45 08             	mov    0x8(%ebp),%eax
  101ecb:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  101ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ed4:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101eda:	8b 45 08             	mov    0x8(%ebp),%eax
  101edd:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ee4:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  101ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  101eeb:	8b 40 40             	mov    0x40(%eax),%eax
  101eee:	25 ff cf ff ff       	and    $0xffffcfff,%eax
  101ef3:	89 c2                	mov    %eax,%edx
  101ef5:	8b 45 08             	mov    0x8(%ebp),%eax
  101ef8:	89 50 40             	mov    %edx,0x40(%eax)
        }
        break;
  101efb:	eb 3e                	jmp    101f3b <trap_dispatch+0x1dc>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101efd:	8b 45 08             	mov    0x8(%ebp),%eax
  101f00:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101f04:	83 e0 03             	and    $0x3,%eax
  101f07:	85 c0                	test   %eax,%eax
  101f09:	75 31                	jne    101f3c <trap_dispatch+0x1dd>
            print_trapframe(tf);
  101f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  101f0e:	89 04 24             	mov    %eax,(%esp)
  101f11:	e8 d8 fb ff ff       	call   101aee <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101f16:	c7 44 24 08 4a 66 10 	movl   $0x10664a,0x8(%esp)
  101f1d:	00 
  101f1e:	c7 44 24 04 d1 00 00 	movl   $0xd1,0x4(%esp)
  101f25:	00 
  101f26:	c7 04 24 6e 64 10 00 	movl   $0x10646e,(%esp)
  101f2d:	e8 03 e5 ff ff       	call   100435 <__panic>
        break;
  101f32:	90                   	nop
  101f33:	eb 07                	jmp    101f3c <trap_dispatch+0x1dd>
        break;
  101f35:	90                   	nop
  101f36:	eb 04                	jmp    101f3c <trap_dispatch+0x1dd>
        break;
  101f38:	90                   	nop
  101f39:	eb 01                	jmp    101f3c <trap_dispatch+0x1dd>
        break;
  101f3b:	90                   	nop
        }
    }
}
  101f3c:	90                   	nop
  101f3d:	c9                   	leave  
  101f3e:	c3                   	ret    

00101f3f <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101f3f:	f3 0f 1e fb          	endbr32 
  101f43:	55                   	push   %ebp
  101f44:	89 e5                	mov    %esp,%ebp
  101f46:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101f49:	8b 45 08             	mov    0x8(%ebp),%eax
  101f4c:	89 04 24             	mov    %eax,(%esp)
  101f4f:	e8 0b fe ff ff       	call   101d5f <trap_dispatch>
}
  101f54:	90                   	nop
  101f55:	c9                   	leave  
  101f56:	c3                   	ret    

00101f57 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101f57:	6a 00                	push   $0x0
  pushl $0
  101f59:	6a 00                	push   $0x0
  jmp __alltraps
  101f5b:	e9 69 0a 00 00       	jmp    1029c9 <__alltraps>

00101f60 <vector1>:
.globl vector1
vector1:
  pushl $0
  101f60:	6a 00                	push   $0x0
  pushl $1
  101f62:	6a 01                	push   $0x1
  jmp __alltraps
  101f64:	e9 60 0a 00 00       	jmp    1029c9 <__alltraps>

00101f69 <vector2>:
.globl vector2
vector2:
  pushl $0
  101f69:	6a 00                	push   $0x0
  pushl $2
  101f6b:	6a 02                	push   $0x2
  jmp __alltraps
  101f6d:	e9 57 0a 00 00       	jmp    1029c9 <__alltraps>

00101f72 <vector3>:
.globl vector3
vector3:
  pushl $0
  101f72:	6a 00                	push   $0x0
  pushl $3
  101f74:	6a 03                	push   $0x3
  jmp __alltraps
  101f76:	e9 4e 0a 00 00       	jmp    1029c9 <__alltraps>

00101f7b <vector4>:
.globl vector4
vector4:
  pushl $0
  101f7b:	6a 00                	push   $0x0
  pushl $4
  101f7d:	6a 04                	push   $0x4
  jmp __alltraps
  101f7f:	e9 45 0a 00 00       	jmp    1029c9 <__alltraps>

00101f84 <vector5>:
.globl vector5
vector5:
  pushl $0
  101f84:	6a 00                	push   $0x0
  pushl $5
  101f86:	6a 05                	push   $0x5
  jmp __alltraps
  101f88:	e9 3c 0a 00 00       	jmp    1029c9 <__alltraps>

00101f8d <vector6>:
.globl vector6
vector6:
  pushl $0
  101f8d:	6a 00                	push   $0x0
  pushl $6
  101f8f:	6a 06                	push   $0x6
  jmp __alltraps
  101f91:	e9 33 0a 00 00       	jmp    1029c9 <__alltraps>

00101f96 <vector7>:
.globl vector7
vector7:
  pushl $0
  101f96:	6a 00                	push   $0x0
  pushl $7
  101f98:	6a 07                	push   $0x7
  jmp __alltraps
  101f9a:	e9 2a 0a 00 00       	jmp    1029c9 <__alltraps>

00101f9f <vector8>:
.globl vector8
vector8:
  pushl $8
  101f9f:	6a 08                	push   $0x8
  jmp __alltraps
  101fa1:	e9 23 0a 00 00       	jmp    1029c9 <__alltraps>

00101fa6 <vector9>:
.globl vector9
vector9:
  pushl $0
  101fa6:	6a 00                	push   $0x0
  pushl $9
  101fa8:	6a 09                	push   $0x9
  jmp __alltraps
  101faa:	e9 1a 0a 00 00       	jmp    1029c9 <__alltraps>

00101faf <vector10>:
.globl vector10
vector10:
  pushl $10
  101faf:	6a 0a                	push   $0xa
  jmp __alltraps
  101fb1:	e9 13 0a 00 00       	jmp    1029c9 <__alltraps>

00101fb6 <vector11>:
.globl vector11
vector11:
  pushl $11
  101fb6:	6a 0b                	push   $0xb
  jmp __alltraps
  101fb8:	e9 0c 0a 00 00       	jmp    1029c9 <__alltraps>

00101fbd <vector12>:
.globl vector12
vector12:
  pushl $12
  101fbd:	6a 0c                	push   $0xc
  jmp __alltraps
  101fbf:	e9 05 0a 00 00       	jmp    1029c9 <__alltraps>

00101fc4 <vector13>:
.globl vector13
vector13:
  pushl $13
  101fc4:	6a 0d                	push   $0xd
  jmp __alltraps
  101fc6:	e9 fe 09 00 00       	jmp    1029c9 <__alltraps>

00101fcb <vector14>:
.globl vector14
vector14:
  pushl $14
  101fcb:	6a 0e                	push   $0xe
  jmp __alltraps
  101fcd:	e9 f7 09 00 00       	jmp    1029c9 <__alltraps>

00101fd2 <vector15>:
.globl vector15
vector15:
  pushl $0
  101fd2:	6a 00                	push   $0x0
  pushl $15
  101fd4:	6a 0f                	push   $0xf
  jmp __alltraps
  101fd6:	e9 ee 09 00 00       	jmp    1029c9 <__alltraps>

00101fdb <vector16>:
.globl vector16
vector16:
  pushl $0
  101fdb:	6a 00                	push   $0x0
  pushl $16
  101fdd:	6a 10                	push   $0x10
  jmp __alltraps
  101fdf:	e9 e5 09 00 00       	jmp    1029c9 <__alltraps>

00101fe4 <vector17>:
.globl vector17
vector17:
  pushl $17
  101fe4:	6a 11                	push   $0x11
  jmp __alltraps
  101fe6:	e9 de 09 00 00       	jmp    1029c9 <__alltraps>

00101feb <vector18>:
.globl vector18
vector18:
  pushl $0
  101feb:	6a 00                	push   $0x0
  pushl $18
  101fed:	6a 12                	push   $0x12
  jmp __alltraps
  101fef:	e9 d5 09 00 00       	jmp    1029c9 <__alltraps>

00101ff4 <vector19>:
.globl vector19
vector19:
  pushl $0
  101ff4:	6a 00                	push   $0x0
  pushl $19
  101ff6:	6a 13                	push   $0x13
  jmp __alltraps
  101ff8:	e9 cc 09 00 00       	jmp    1029c9 <__alltraps>

00101ffd <vector20>:
.globl vector20
vector20:
  pushl $0
  101ffd:	6a 00                	push   $0x0
  pushl $20
  101fff:	6a 14                	push   $0x14
  jmp __alltraps
  102001:	e9 c3 09 00 00       	jmp    1029c9 <__alltraps>

00102006 <vector21>:
.globl vector21
vector21:
  pushl $0
  102006:	6a 00                	push   $0x0
  pushl $21
  102008:	6a 15                	push   $0x15
  jmp __alltraps
  10200a:	e9 ba 09 00 00       	jmp    1029c9 <__alltraps>

0010200f <vector22>:
.globl vector22
vector22:
  pushl $0
  10200f:	6a 00                	push   $0x0
  pushl $22
  102011:	6a 16                	push   $0x16
  jmp __alltraps
  102013:	e9 b1 09 00 00       	jmp    1029c9 <__alltraps>

00102018 <vector23>:
.globl vector23
vector23:
  pushl $0
  102018:	6a 00                	push   $0x0
  pushl $23
  10201a:	6a 17                	push   $0x17
  jmp __alltraps
  10201c:	e9 a8 09 00 00       	jmp    1029c9 <__alltraps>

00102021 <vector24>:
.globl vector24
vector24:
  pushl $0
  102021:	6a 00                	push   $0x0
  pushl $24
  102023:	6a 18                	push   $0x18
  jmp __alltraps
  102025:	e9 9f 09 00 00       	jmp    1029c9 <__alltraps>

0010202a <vector25>:
.globl vector25
vector25:
  pushl $0
  10202a:	6a 00                	push   $0x0
  pushl $25
  10202c:	6a 19                	push   $0x19
  jmp __alltraps
  10202e:	e9 96 09 00 00       	jmp    1029c9 <__alltraps>

00102033 <vector26>:
.globl vector26
vector26:
  pushl $0
  102033:	6a 00                	push   $0x0
  pushl $26
  102035:	6a 1a                	push   $0x1a
  jmp __alltraps
  102037:	e9 8d 09 00 00       	jmp    1029c9 <__alltraps>

0010203c <vector27>:
.globl vector27
vector27:
  pushl $0
  10203c:	6a 00                	push   $0x0
  pushl $27
  10203e:	6a 1b                	push   $0x1b
  jmp __alltraps
  102040:	e9 84 09 00 00       	jmp    1029c9 <__alltraps>

00102045 <vector28>:
.globl vector28
vector28:
  pushl $0
  102045:	6a 00                	push   $0x0
  pushl $28
  102047:	6a 1c                	push   $0x1c
  jmp __alltraps
  102049:	e9 7b 09 00 00       	jmp    1029c9 <__alltraps>

0010204e <vector29>:
.globl vector29
vector29:
  pushl $0
  10204e:	6a 00                	push   $0x0
  pushl $29
  102050:	6a 1d                	push   $0x1d
  jmp __alltraps
  102052:	e9 72 09 00 00       	jmp    1029c9 <__alltraps>

00102057 <vector30>:
.globl vector30
vector30:
  pushl $0
  102057:	6a 00                	push   $0x0
  pushl $30
  102059:	6a 1e                	push   $0x1e
  jmp __alltraps
  10205b:	e9 69 09 00 00       	jmp    1029c9 <__alltraps>

00102060 <vector31>:
.globl vector31
vector31:
  pushl $0
  102060:	6a 00                	push   $0x0
  pushl $31
  102062:	6a 1f                	push   $0x1f
  jmp __alltraps
  102064:	e9 60 09 00 00       	jmp    1029c9 <__alltraps>

00102069 <vector32>:
.globl vector32
vector32:
  pushl $0
  102069:	6a 00                	push   $0x0
  pushl $32
  10206b:	6a 20                	push   $0x20
  jmp __alltraps
  10206d:	e9 57 09 00 00       	jmp    1029c9 <__alltraps>

00102072 <vector33>:
.globl vector33
vector33:
  pushl $0
  102072:	6a 00                	push   $0x0
  pushl $33
  102074:	6a 21                	push   $0x21
  jmp __alltraps
  102076:	e9 4e 09 00 00       	jmp    1029c9 <__alltraps>

0010207b <vector34>:
.globl vector34
vector34:
  pushl $0
  10207b:	6a 00                	push   $0x0
  pushl $34
  10207d:	6a 22                	push   $0x22
  jmp __alltraps
  10207f:	e9 45 09 00 00       	jmp    1029c9 <__alltraps>

00102084 <vector35>:
.globl vector35
vector35:
  pushl $0
  102084:	6a 00                	push   $0x0
  pushl $35
  102086:	6a 23                	push   $0x23
  jmp __alltraps
  102088:	e9 3c 09 00 00       	jmp    1029c9 <__alltraps>

0010208d <vector36>:
.globl vector36
vector36:
  pushl $0
  10208d:	6a 00                	push   $0x0
  pushl $36
  10208f:	6a 24                	push   $0x24
  jmp __alltraps
  102091:	e9 33 09 00 00       	jmp    1029c9 <__alltraps>

00102096 <vector37>:
.globl vector37
vector37:
  pushl $0
  102096:	6a 00                	push   $0x0
  pushl $37
  102098:	6a 25                	push   $0x25
  jmp __alltraps
  10209a:	e9 2a 09 00 00       	jmp    1029c9 <__alltraps>

0010209f <vector38>:
.globl vector38
vector38:
  pushl $0
  10209f:	6a 00                	push   $0x0
  pushl $38
  1020a1:	6a 26                	push   $0x26
  jmp __alltraps
  1020a3:	e9 21 09 00 00       	jmp    1029c9 <__alltraps>

001020a8 <vector39>:
.globl vector39
vector39:
  pushl $0
  1020a8:	6a 00                	push   $0x0
  pushl $39
  1020aa:	6a 27                	push   $0x27
  jmp __alltraps
  1020ac:	e9 18 09 00 00       	jmp    1029c9 <__alltraps>

001020b1 <vector40>:
.globl vector40
vector40:
  pushl $0
  1020b1:	6a 00                	push   $0x0
  pushl $40
  1020b3:	6a 28                	push   $0x28
  jmp __alltraps
  1020b5:	e9 0f 09 00 00       	jmp    1029c9 <__alltraps>

001020ba <vector41>:
.globl vector41
vector41:
  pushl $0
  1020ba:	6a 00                	push   $0x0
  pushl $41
  1020bc:	6a 29                	push   $0x29
  jmp __alltraps
  1020be:	e9 06 09 00 00       	jmp    1029c9 <__alltraps>

001020c3 <vector42>:
.globl vector42
vector42:
  pushl $0
  1020c3:	6a 00                	push   $0x0
  pushl $42
  1020c5:	6a 2a                	push   $0x2a
  jmp __alltraps
  1020c7:	e9 fd 08 00 00       	jmp    1029c9 <__alltraps>

001020cc <vector43>:
.globl vector43
vector43:
  pushl $0
  1020cc:	6a 00                	push   $0x0
  pushl $43
  1020ce:	6a 2b                	push   $0x2b
  jmp __alltraps
  1020d0:	e9 f4 08 00 00       	jmp    1029c9 <__alltraps>

001020d5 <vector44>:
.globl vector44
vector44:
  pushl $0
  1020d5:	6a 00                	push   $0x0
  pushl $44
  1020d7:	6a 2c                	push   $0x2c
  jmp __alltraps
  1020d9:	e9 eb 08 00 00       	jmp    1029c9 <__alltraps>

001020de <vector45>:
.globl vector45
vector45:
  pushl $0
  1020de:	6a 00                	push   $0x0
  pushl $45
  1020e0:	6a 2d                	push   $0x2d
  jmp __alltraps
  1020e2:	e9 e2 08 00 00       	jmp    1029c9 <__alltraps>

001020e7 <vector46>:
.globl vector46
vector46:
  pushl $0
  1020e7:	6a 00                	push   $0x0
  pushl $46
  1020e9:	6a 2e                	push   $0x2e
  jmp __alltraps
  1020eb:	e9 d9 08 00 00       	jmp    1029c9 <__alltraps>

001020f0 <vector47>:
.globl vector47
vector47:
  pushl $0
  1020f0:	6a 00                	push   $0x0
  pushl $47
  1020f2:	6a 2f                	push   $0x2f
  jmp __alltraps
  1020f4:	e9 d0 08 00 00       	jmp    1029c9 <__alltraps>

001020f9 <vector48>:
.globl vector48
vector48:
  pushl $0
  1020f9:	6a 00                	push   $0x0
  pushl $48
  1020fb:	6a 30                	push   $0x30
  jmp __alltraps
  1020fd:	e9 c7 08 00 00       	jmp    1029c9 <__alltraps>

00102102 <vector49>:
.globl vector49
vector49:
  pushl $0
  102102:	6a 00                	push   $0x0
  pushl $49
  102104:	6a 31                	push   $0x31
  jmp __alltraps
  102106:	e9 be 08 00 00       	jmp    1029c9 <__alltraps>

0010210b <vector50>:
.globl vector50
vector50:
  pushl $0
  10210b:	6a 00                	push   $0x0
  pushl $50
  10210d:	6a 32                	push   $0x32
  jmp __alltraps
  10210f:	e9 b5 08 00 00       	jmp    1029c9 <__alltraps>

00102114 <vector51>:
.globl vector51
vector51:
  pushl $0
  102114:	6a 00                	push   $0x0
  pushl $51
  102116:	6a 33                	push   $0x33
  jmp __alltraps
  102118:	e9 ac 08 00 00       	jmp    1029c9 <__alltraps>

0010211d <vector52>:
.globl vector52
vector52:
  pushl $0
  10211d:	6a 00                	push   $0x0
  pushl $52
  10211f:	6a 34                	push   $0x34
  jmp __alltraps
  102121:	e9 a3 08 00 00       	jmp    1029c9 <__alltraps>

00102126 <vector53>:
.globl vector53
vector53:
  pushl $0
  102126:	6a 00                	push   $0x0
  pushl $53
  102128:	6a 35                	push   $0x35
  jmp __alltraps
  10212a:	e9 9a 08 00 00       	jmp    1029c9 <__alltraps>

0010212f <vector54>:
.globl vector54
vector54:
  pushl $0
  10212f:	6a 00                	push   $0x0
  pushl $54
  102131:	6a 36                	push   $0x36
  jmp __alltraps
  102133:	e9 91 08 00 00       	jmp    1029c9 <__alltraps>

00102138 <vector55>:
.globl vector55
vector55:
  pushl $0
  102138:	6a 00                	push   $0x0
  pushl $55
  10213a:	6a 37                	push   $0x37
  jmp __alltraps
  10213c:	e9 88 08 00 00       	jmp    1029c9 <__alltraps>

00102141 <vector56>:
.globl vector56
vector56:
  pushl $0
  102141:	6a 00                	push   $0x0
  pushl $56
  102143:	6a 38                	push   $0x38
  jmp __alltraps
  102145:	e9 7f 08 00 00       	jmp    1029c9 <__alltraps>

0010214a <vector57>:
.globl vector57
vector57:
  pushl $0
  10214a:	6a 00                	push   $0x0
  pushl $57
  10214c:	6a 39                	push   $0x39
  jmp __alltraps
  10214e:	e9 76 08 00 00       	jmp    1029c9 <__alltraps>

00102153 <vector58>:
.globl vector58
vector58:
  pushl $0
  102153:	6a 00                	push   $0x0
  pushl $58
  102155:	6a 3a                	push   $0x3a
  jmp __alltraps
  102157:	e9 6d 08 00 00       	jmp    1029c9 <__alltraps>

0010215c <vector59>:
.globl vector59
vector59:
  pushl $0
  10215c:	6a 00                	push   $0x0
  pushl $59
  10215e:	6a 3b                	push   $0x3b
  jmp __alltraps
  102160:	e9 64 08 00 00       	jmp    1029c9 <__alltraps>

00102165 <vector60>:
.globl vector60
vector60:
  pushl $0
  102165:	6a 00                	push   $0x0
  pushl $60
  102167:	6a 3c                	push   $0x3c
  jmp __alltraps
  102169:	e9 5b 08 00 00       	jmp    1029c9 <__alltraps>

0010216e <vector61>:
.globl vector61
vector61:
  pushl $0
  10216e:	6a 00                	push   $0x0
  pushl $61
  102170:	6a 3d                	push   $0x3d
  jmp __alltraps
  102172:	e9 52 08 00 00       	jmp    1029c9 <__alltraps>

00102177 <vector62>:
.globl vector62
vector62:
  pushl $0
  102177:	6a 00                	push   $0x0
  pushl $62
  102179:	6a 3e                	push   $0x3e
  jmp __alltraps
  10217b:	e9 49 08 00 00       	jmp    1029c9 <__alltraps>

00102180 <vector63>:
.globl vector63
vector63:
  pushl $0
  102180:	6a 00                	push   $0x0
  pushl $63
  102182:	6a 3f                	push   $0x3f
  jmp __alltraps
  102184:	e9 40 08 00 00       	jmp    1029c9 <__alltraps>

00102189 <vector64>:
.globl vector64
vector64:
  pushl $0
  102189:	6a 00                	push   $0x0
  pushl $64
  10218b:	6a 40                	push   $0x40
  jmp __alltraps
  10218d:	e9 37 08 00 00       	jmp    1029c9 <__alltraps>

00102192 <vector65>:
.globl vector65
vector65:
  pushl $0
  102192:	6a 00                	push   $0x0
  pushl $65
  102194:	6a 41                	push   $0x41
  jmp __alltraps
  102196:	e9 2e 08 00 00       	jmp    1029c9 <__alltraps>

0010219b <vector66>:
.globl vector66
vector66:
  pushl $0
  10219b:	6a 00                	push   $0x0
  pushl $66
  10219d:	6a 42                	push   $0x42
  jmp __alltraps
  10219f:	e9 25 08 00 00       	jmp    1029c9 <__alltraps>

001021a4 <vector67>:
.globl vector67
vector67:
  pushl $0
  1021a4:	6a 00                	push   $0x0
  pushl $67
  1021a6:	6a 43                	push   $0x43
  jmp __alltraps
  1021a8:	e9 1c 08 00 00       	jmp    1029c9 <__alltraps>

001021ad <vector68>:
.globl vector68
vector68:
  pushl $0
  1021ad:	6a 00                	push   $0x0
  pushl $68
  1021af:	6a 44                	push   $0x44
  jmp __alltraps
  1021b1:	e9 13 08 00 00       	jmp    1029c9 <__alltraps>

001021b6 <vector69>:
.globl vector69
vector69:
  pushl $0
  1021b6:	6a 00                	push   $0x0
  pushl $69
  1021b8:	6a 45                	push   $0x45
  jmp __alltraps
  1021ba:	e9 0a 08 00 00       	jmp    1029c9 <__alltraps>

001021bf <vector70>:
.globl vector70
vector70:
  pushl $0
  1021bf:	6a 00                	push   $0x0
  pushl $70
  1021c1:	6a 46                	push   $0x46
  jmp __alltraps
  1021c3:	e9 01 08 00 00       	jmp    1029c9 <__alltraps>

001021c8 <vector71>:
.globl vector71
vector71:
  pushl $0
  1021c8:	6a 00                	push   $0x0
  pushl $71
  1021ca:	6a 47                	push   $0x47
  jmp __alltraps
  1021cc:	e9 f8 07 00 00       	jmp    1029c9 <__alltraps>

001021d1 <vector72>:
.globl vector72
vector72:
  pushl $0
  1021d1:	6a 00                	push   $0x0
  pushl $72
  1021d3:	6a 48                	push   $0x48
  jmp __alltraps
  1021d5:	e9 ef 07 00 00       	jmp    1029c9 <__alltraps>

001021da <vector73>:
.globl vector73
vector73:
  pushl $0
  1021da:	6a 00                	push   $0x0
  pushl $73
  1021dc:	6a 49                	push   $0x49
  jmp __alltraps
  1021de:	e9 e6 07 00 00       	jmp    1029c9 <__alltraps>

001021e3 <vector74>:
.globl vector74
vector74:
  pushl $0
  1021e3:	6a 00                	push   $0x0
  pushl $74
  1021e5:	6a 4a                	push   $0x4a
  jmp __alltraps
  1021e7:	e9 dd 07 00 00       	jmp    1029c9 <__alltraps>

001021ec <vector75>:
.globl vector75
vector75:
  pushl $0
  1021ec:	6a 00                	push   $0x0
  pushl $75
  1021ee:	6a 4b                	push   $0x4b
  jmp __alltraps
  1021f0:	e9 d4 07 00 00       	jmp    1029c9 <__alltraps>

001021f5 <vector76>:
.globl vector76
vector76:
  pushl $0
  1021f5:	6a 00                	push   $0x0
  pushl $76
  1021f7:	6a 4c                	push   $0x4c
  jmp __alltraps
  1021f9:	e9 cb 07 00 00       	jmp    1029c9 <__alltraps>

001021fe <vector77>:
.globl vector77
vector77:
  pushl $0
  1021fe:	6a 00                	push   $0x0
  pushl $77
  102200:	6a 4d                	push   $0x4d
  jmp __alltraps
  102202:	e9 c2 07 00 00       	jmp    1029c9 <__alltraps>

00102207 <vector78>:
.globl vector78
vector78:
  pushl $0
  102207:	6a 00                	push   $0x0
  pushl $78
  102209:	6a 4e                	push   $0x4e
  jmp __alltraps
  10220b:	e9 b9 07 00 00       	jmp    1029c9 <__alltraps>

00102210 <vector79>:
.globl vector79
vector79:
  pushl $0
  102210:	6a 00                	push   $0x0
  pushl $79
  102212:	6a 4f                	push   $0x4f
  jmp __alltraps
  102214:	e9 b0 07 00 00       	jmp    1029c9 <__alltraps>

00102219 <vector80>:
.globl vector80
vector80:
  pushl $0
  102219:	6a 00                	push   $0x0
  pushl $80
  10221b:	6a 50                	push   $0x50
  jmp __alltraps
  10221d:	e9 a7 07 00 00       	jmp    1029c9 <__alltraps>

00102222 <vector81>:
.globl vector81
vector81:
  pushl $0
  102222:	6a 00                	push   $0x0
  pushl $81
  102224:	6a 51                	push   $0x51
  jmp __alltraps
  102226:	e9 9e 07 00 00       	jmp    1029c9 <__alltraps>

0010222b <vector82>:
.globl vector82
vector82:
  pushl $0
  10222b:	6a 00                	push   $0x0
  pushl $82
  10222d:	6a 52                	push   $0x52
  jmp __alltraps
  10222f:	e9 95 07 00 00       	jmp    1029c9 <__alltraps>

00102234 <vector83>:
.globl vector83
vector83:
  pushl $0
  102234:	6a 00                	push   $0x0
  pushl $83
  102236:	6a 53                	push   $0x53
  jmp __alltraps
  102238:	e9 8c 07 00 00       	jmp    1029c9 <__alltraps>

0010223d <vector84>:
.globl vector84
vector84:
  pushl $0
  10223d:	6a 00                	push   $0x0
  pushl $84
  10223f:	6a 54                	push   $0x54
  jmp __alltraps
  102241:	e9 83 07 00 00       	jmp    1029c9 <__alltraps>

00102246 <vector85>:
.globl vector85
vector85:
  pushl $0
  102246:	6a 00                	push   $0x0
  pushl $85
  102248:	6a 55                	push   $0x55
  jmp __alltraps
  10224a:	e9 7a 07 00 00       	jmp    1029c9 <__alltraps>

0010224f <vector86>:
.globl vector86
vector86:
  pushl $0
  10224f:	6a 00                	push   $0x0
  pushl $86
  102251:	6a 56                	push   $0x56
  jmp __alltraps
  102253:	e9 71 07 00 00       	jmp    1029c9 <__alltraps>

00102258 <vector87>:
.globl vector87
vector87:
  pushl $0
  102258:	6a 00                	push   $0x0
  pushl $87
  10225a:	6a 57                	push   $0x57
  jmp __alltraps
  10225c:	e9 68 07 00 00       	jmp    1029c9 <__alltraps>

00102261 <vector88>:
.globl vector88
vector88:
  pushl $0
  102261:	6a 00                	push   $0x0
  pushl $88
  102263:	6a 58                	push   $0x58
  jmp __alltraps
  102265:	e9 5f 07 00 00       	jmp    1029c9 <__alltraps>

0010226a <vector89>:
.globl vector89
vector89:
  pushl $0
  10226a:	6a 00                	push   $0x0
  pushl $89
  10226c:	6a 59                	push   $0x59
  jmp __alltraps
  10226e:	e9 56 07 00 00       	jmp    1029c9 <__alltraps>

00102273 <vector90>:
.globl vector90
vector90:
  pushl $0
  102273:	6a 00                	push   $0x0
  pushl $90
  102275:	6a 5a                	push   $0x5a
  jmp __alltraps
  102277:	e9 4d 07 00 00       	jmp    1029c9 <__alltraps>

0010227c <vector91>:
.globl vector91
vector91:
  pushl $0
  10227c:	6a 00                	push   $0x0
  pushl $91
  10227e:	6a 5b                	push   $0x5b
  jmp __alltraps
  102280:	e9 44 07 00 00       	jmp    1029c9 <__alltraps>

00102285 <vector92>:
.globl vector92
vector92:
  pushl $0
  102285:	6a 00                	push   $0x0
  pushl $92
  102287:	6a 5c                	push   $0x5c
  jmp __alltraps
  102289:	e9 3b 07 00 00       	jmp    1029c9 <__alltraps>

0010228e <vector93>:
.globl vector93
vector93:
  pushl $0
  10228e:	6a 00                	push   $0x0
  pushl $93
  102290:	6a 5d                	push   $0x5d
  jmp __alltraps
  102292:	e9 32 07 00 00       	jmp    1029c9 <__alltraps>

00102297 <vector94>:
.globl vector94
vector94:
  pushl $0
  102297:	6a 00                	push   $0x0
  pushl $94
  102299:	6a 5e                	push   $0x5e
  jmp __alltraps
  10229b:	e9 29 07 00 00       	jmp    1029c9 <__alltraps>

001022a0 <vector95>:
.globl vector95
vector95:
  pushl $0
  1022a0:	6a 00                	push   $0x0
  pushl $95
  1022a2:	6a 5f                	push   $0x5f
  jmp __alltraps
  1022a4:	e9 20 07 00 00       	jmp    1029c9 <__alltraps>

001022a9 <vector96>:
.globl vector96
vector96:
  pushl $0
  1022a9:	6a 00                	push   $0x0
  pushl $96
  1022ab:	6a 60                	push   $0x60
  jmp __alltraps
  1022ad:	e9 17 07 00 00       	jmp    1029c9 <__alltraps>

001022b2 <vector97>:
.globl vector97
vector97:
  pushl $0
  1022b2:	6a 00                	push   $0x0
  pushl $97
  1022b4:	6a 61                	push   $0x61
  jmp __alltraps
  1022b6:	e9 0e 07 00 00       	jmp    1029c9 <__alltraps>

001022bb <vector98>:
.globl vector98
vector98:
  pushl $0
  1022bb:	6a 00                	push   $0x0
  pushl $98
  1022bd:	6a 62                	push   $0x62
  jmp __alltraps
  1022bf:	e9 05 07 00 00       	jmp    1029c9 <__alltraps>

001022c4 <vector99>:
.globl vector99
vector99:
  pushl $0
  1022c4:	6a 00                	push   $0x0
  pushl $99
  1022c6:	6a 63                	push   $0x63
  jmp __alltraps
  1022c8:	e9 fc 06 00 00       	jmp    1029c9 <__alltraps>

001022cd <vector100>:
.globl vector100
vector100:
  pushl $0
  1022cd:	6a 00                	push   $0x0
  pushl $100
  1022cf:	6a 64                	push   $0x64
  jmp __alltraps
  1022d1:	e9 f3 06 00 00       	jmp    1029c9 <__alltraps>

001022d6 <vector101>:
.globl vector101
vector101:
  pushl $0
  1022d6:	6a 00                	push   $0x0
  pushl $101
  1022d8:	6a 65                	push   $0x65
  jmp __alltraps
  1022da:	e9 ea 06 00 00       	jmp    1029c9 <__alltraps>

001022df <vector102>:
.globl vector102
vector102:
  pushl $0
  1022df:	6a 00                	push   $0x0
  pushl $102
  1022e1:	6a 66                	push   $0x66
  jmp __alltraps
  1022e3:	e9 e1 06 00 00       	jmp    1029c9 <__alltraps>

001022e8 <vector103>:
.globl vector103
vector103:
  pushl $0
  1022e8:	6a 00                	push   $0x0
  pushl $103
  1022ea:	6a 67                	push   $0x67
  jmp __alltraps
  1022ec:	e9 d8 06 00 00       	jmp    1029c9 <__alltraps>

001022f1 <vector104>:
.globl vector104
vector104:
  pushl $0
  1022f1:	6a 00                	push   $0x0
  pushl $104
  1022f3:	6a 68                	push   $0x68
  jmp __alltraps
  1022f5:	e9 cf 06 00 00       	jmp    1029c9 <__alltraps>

001022fa <vector105>:
.globl vector105
vector105:
  pushl $0
  1022fa:	6a 00                	push   $0x0
  pushl $105
  1022fc:	6a 69                	push   $0x69
  jmp __alltraps
  1022fe:	e9 c6 06 00 00       	jmp    1029c9 <__alltraps>

00102303 <vector106>:
.globl vector106
vector106:
  pushl $0
  102303:	6a 00                	push   $0x0
  pushl $106
  102305:	6a 6a                	push   $0x6a
  jmp __alltraps
  102307:	e9 bd 06 00 00       	jmp    1029c9 <__alltraps>

0010230c <vector107>:
.globl vector107
vector107:
  pushl $0
  10230c:	6a 00                	push   $0x0
  pushl $107
  10230e:	6a 6b                	push   $0x6b
  jmp __alltraps
  102310:	e9 b4 06 00 00       	jmp    1029c9 <__alltraps>

00102315 <vector108>:
.globl vector108
vector108:
  pushl $0
  102315:	6a 00                	push   $0x0
  pushl $108
  102317:	6a 6c                	push   $0x6c
  jmp __alltraps
  102319:	e9 ab 06 00 00       	jmp    1029c9 <__alltraps>

0010231e <vector109>:
.globl vector109
vector109:
  pushl $0
  10231e:	6a 00                	push   $0x0
  pushl $109
  102320:	6a 6d                	push   $0x6d
  jmp __alltraps
  102322:	e9 a2 06 00 00       	jmp    1029c9 <__alltraps>

00102327 <vector110>:
.globl vector110
vector110:
  pushl $0
  102327:	6a 00                	push   $0x0
  pushl $110
  102329:	6a 6e                	push   $0x6e
  jmp __alltraps
  10232b:	e9 99 06 00 00       	jmp    1029c9 <__alltraps>

00102330 <vector111>:
.globl vector111
vector111:
  pushl $0
  102330:	6a 00                	push   $0x0
  pushl $111
  102332:	6a 6f                	push   $0x6f
  jmp __alltraps
  102334:	e9 90 06 00 00       	jmp    1029c9 <__alltraps>

00102339 <vector112>:
.globl vector112
vector112:
  pushl $0
  102339:	6a 00                	push   $0x0
  pushl $112
  10233b:	6a 70                	push   $0x70
  jmp __alltraps
  10233d:	e9 87 06 00 00       	jmp    1029c9 <__alltraps>

00102342 <vector113>:
.globl vector113
vector113:
  pushl $0
  102342:	6a 00                	push   $0x0
  pushl $113
  102344:	6a 71                	push   $0x71
  jmp __alltraps
  102346:	e9 7e 06 00 00       	jmp    1029c9 <__alltraps>

0010234b <vector114>:
.globl vector114
vector114:
  pushl $0
  10234b:	6a 00                	push   $0x0
  pushl $114
  10234d:	6a 72                	push   $0x72
  jmp __alltraps
  10234f:	e9 75 06 00 00       	jmp    1029c9 <__alltraps>

00102354 <vector115>:
.globl vector115
vector115:
  pushl $0
  102354:	6a 00                	push   $0x0
  pushl $115
  102356:	6a 73                	push   $0x73
  jmp __alltraps
  102358:	e9 6c 06 00 00       	jmp    1029c9 <__alltraps>

0010235d <vector116>:
.globl vector116
vector116:
  pushl $0
  10235d:	6a 00                	push   $0x0
  pushl $116
  10235f:	6a 74                	push   $0x74
  jmp __alltraps
  102361:	e9 63 06 00 00       	jmp    1029c9 <__alltraps>

00102366 <vector117>:
.globl vector117
vector117:
  pushl $0
  102366:	6a 00                	push   $0x0
  pushl $117
  102368:	6a 75                	push   $0x75
  jmp __alltraps
  10236a:	e9 5a 06 00 00       	jmp    1029c9 <__alltraps>

0010236f <vector118>:
.globl vector118
vector118:
  pushl $0
  10236f:	6a 00                	push   $0x0
  pushl $118
  102371:	6a 76                	push   $0x76
  jmp __alltraps
  102373:	e9 51 06 00 00       	jmp    1029c9 <__alltraps>

00102378 <vector119>:
.globl vector119
vector119:
  pushl $0
  102378:	6a 00                	push   $0x0
  pushl $119
  10237a:	6a 77                	push   $0x77
  jmp __alltraps
  10237c:	e9 48 06 00 00       	jmp    1029c9 <__alltraps>

00102381 <vector120>:
.globl vector120
vector120:
  pushl $0
  102381:	6a 00                	push   $0x0
  pushl $120
  102383:	6a 78                	push   $0x78
  jmp __alltraps
  102385:	e9 3f 06 00 00       	jmp    1029c9 <__alltraps>

0010238a <vector121>:
.globl vector121
vector121:
  pushl $0
  10238a:	6a 00                	push   $0x0
  pushl $121
  10238c:	6a 79                	push   $0x79
  jmp __alltraps
  10238e:	e9 36 06 00 00       	jmp    1029c9 <__alltraps>

00102393 <vector122>:
.globl vector122
vector122:
  pushl $0
  102393:	6a 00                	push   $0x0
  pushl $122
  102395:	6a 7a                	push   $0x7a
  jmp __alltraps
  102397:	e9 2d 06 00 00       	jmp    1029c9 <__alltraps>

0010239c <vector123>:
.globl vector123
vector123:
  pushl $0
  10239c:	6a 00                	push   $0x0
  pushl $123
  10239e:	6a 7b                	push   $0x7b
  jmp __alltraps
  1023a0:	e9 24 06 00 00       	jmp    1029c9 <__alltraps>

001023a5 <vector124>:
.globl vector124
vector124:
  pushl $0
  1023a5:	6a 00                	push   $0x0
  pushl $124
  1023a7:	6a 7c                	push   $0x7c
  jmp __alltraps
  1023a9:	e9 1b 06 00 00       	jmp    1029c9 <__alltraps>

001023ae <vector125>:
.globl vector125
vector125:
  pushl $0
  1023ae:	6a 00                	push   $0x0
  pushl $125
  1023b0:	6a 7d                	push   $0x7d
  jmp __alltraps
  1023b2:	e9 12 06 00 00       	jmp    1029c9 <__alltraps>

001023b7 <vector126>:
.globl vector126
vector126:
  pushl $0
  1023b7:	6a 00                	push   $0x0
  pushl $126
  1023b9:	6a 7e                	push   $0x7e
  jmp __alltraps
  1023bb:	e9 09 06 00 00       	jmp    1029c9 <__alltraps>

001023c0 <vector127>:
.globl vector127
vector127:
  pushl $0
  1023c0:	6a 00                	push   $0x0
  pushl $127
  1023c2:	6a 7f                	push   $0x7f
  jmp __alltraps
  1023c4:	e9 00 06 00 00       	jmp    1029c9 <__alltraps>

001023c9 <vector128>:
.globl vector128
vector128:
  pushl $0
  1023c9:	6a 00                	push   $0x0
  pushl $128
  1023cb:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  1023d0:	e9 f4 05 00 00       	jmp    1029c9 <__alltraps>

001023d5 <vector129>:
.globl vector129
vector129:
  pushl $0
  1023d5:	6a 00                	push   $0x0
  pushl $129
  1023d7:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  1023dc:	e9 e8 05 00 00       	jmp    1029c9 <__alltraps>

001023e1 <vector130>:
.globl vector130
vector130:
  pushl $0
  1023e1:	6a 00                	push   $0x0
  pushl $130
  1023e3:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  1023e8:	e9 dc 05 00 00       	jmp    1029c9 <__alltraps>

001023ed <vector131>:
.globl vector131
vector131:
  pushl $0
  1023ed:	6a 00                	push   $0x0
  pushl $131
  1023ef:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  1023f4:	e9 d0 05 00 00       	jmp    1029c9 <__alltraps>

001023f9 <vector132>:
.globl vector132
vector132:
  pushl $0
  1023f9:	6a 00                	push   $0x0
  pushl $132
  1023fb:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102400:	e9 c4 05 00 00       	jmp    1029c9 <__alltraps>

00102405 <vector133>:
.globl vector133
vector133:
  pushl $0
  102405:	6a 00                	push   $0x0
  pushl $133
  102407:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  10240c:	e9 b8 05 00 00       	jmp    1029c9 <__alltraps>

00102411 <vector134>:
.globl vector134
vector134:
  pushl $0
  102411:	6a 00                	push   $0x0
  pushl $134
  102413:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  102418:	e9 ac 05 00 00       	jmp    1029c9 <__alltraps>

0010241d <vector135>:
.globl vector135
vector135:
  pushl $0
  10241d:	6a 00                	push   $0x0
  pushl $135
  10241f:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  102424:	e9 a0 05 00 00       	jmp    1029c9 <__alltraps>

00102429 <vector136>:
.globl vector136
vector136:
  pushl $0
  102429:	6a 00                	push   $0x0
  pushl $136
  10242b:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102430:	e9 94 05 00 00       	jmp    1029c9 <__alltraps>

00102435 <vector137>:
.globl vector137
vector137:
  pushl $0
  102435:	6a 00                	push   $0x0
  pushl $137
  102437:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  10243c:	e9 88 05 00 00       	jmp    1029c9 <__alltraps>

00102441 <vector138>:
.globl vector138
vector138:
  pushl $0
  102441:	6a 00                	push   $0x0
  pushl $138
  102443:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  102448:	e9 7c 05 00 00       	jmp    1029c9 <__alltraps>

0010244d <vector139>:
.globl vector139
vector139:
  pushl $0
  10244d:	6a 00                	push   $0x0
  pushl $139
  10244f:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102454:	e9 70 05 00 00       	jmp    1029c9 <__alltraps>

00102459 <vector140>:
.globl vector140
vector140:
  pushl $0
  102459:	6a 00                	push   $0x0
  pushl $140
  10245b:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  102460:	e9 64 05 00 00       	jmp    1029c9 <__alltraps>

00102465 <vector141>:
.globl vector141
vector141:
  pushl $0
  102465:	6a 00                	push   $0x0
  pushl $141
  102467:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  10246c:	e9 58 05 00 00       	jmp    1029c9 <__alltraps>

00102471 <vector142>:
.globl vector142
vector142:
  pushl $0
  102471:	6a 00                	push   $0x0
  pushl $142
  102473:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  102478:	e9 4c 05 00 00       	jmp    1029c9 <__alltraps>

0010247d <vector143>:
.globl vector143
vector143:
  pushl $0
  10247d:	6a 00                	push   $0x0
  pushl $143
  10247f:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102484:	e9 40 05 00 00       	jmp    1029c9 <__alltraps>

00102489 <vector144>:
.globl vector144
vector144:
  pushl $0
  102489:	6a 00                	push   $0x0
  pushl $144
  10248b:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  102490:	e9 34 05 00 00       	jmp    1029c9 <__alltraps>

00102495 <vector145>:
.globl vector145
vector145:
  pushl $0
  102495:	6a 00                	push   $0x0
  pushl $145
  102497:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  10249c:	e9 28 05 00 00       	jmp    1029c9 <__alltraps>

001024a1 <vector146>:
.globl vector146
vector146:
  pushl $0
  1024a1:	6a 00                	push   $0x0
  pushl $146
  1024a3:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1024a8:	e9 1c 05 00 00       	jmp    1029c9 <__alltraps>

001024ad <vector147>:
.globl vector147
vector147:
  pushl $0
  1024ad:	6a 00                	push   $0x0
  pushl $147
  1024af:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1024b4:	e9 10 05 00 00       	jmp    1029c9 <__alltraps>

001024b9 <vector148>:
.globl vector148
vector148:
  pushl $0
  1024b9:	6a 00                	push   $0x0
  pushl $148
  1024bb:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  1024c0:	e9 04 05 00 00       	jmp    1029c9 <__alltraps>

001024c5 <vector149>:
.globl vector149
vector149:
  pushl $0
  1024c5:	6a 00                	push   $0x0
  pushl $149
  1024c7:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  1024cc:	e9 f8 04 00 00       	jmp    1029c9 <__alltraps>

001024d1 <vector150>:
.globl vector150
vector150:
  pushl $0
  1024d1:	6a 00                	push   $0x0
  pushl $150
  1024d3:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  1024d8:	e9 ec 04 00 00       	jmp    1029c9 <__alltraps>

001024dd <vector151>:
.globl vector151
vector151:
  pushl $0
  1024dd:	6a 00                	push   $0x0
  pushl $151
  1024df:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  1024e4:	e9 e0 04 00 00       	jmp    1029c9 <__alltraps>

001024e9 <vector152>:
.globl vector152
vector152:
  pushl $0
  1024e9:	6a 00                	push   $0x0
  pushl $152
  1024eb:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  1024f0:	e9 d4 04 00 00       	jmp    1029c9 <__alltraps>

001024f5 <vector153>:
.globl vector153
vector153:
  pushl $0
  1024f5:	6a 00                	push   $0x0
  pushl $153
  1024f7:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  1024fc:	e9 c8 04 00 00       	jmp    1029c9 <__alltraps>

00102501 <vector154>:
.globl vector154
vector154:
  pushl $0
  102501:	6a 00                	push   $0x0
  pushl $154
  102503:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  102508:	e9 bc 04 00 00       	jmp    1029c9 <__alltraps>

0010250d <vector155>:
.globl vector155
vector155:
  pushl $0
  10250d:	6a 00                	push   $0x0
  pushl $155
  10250f:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102514:	e9 b0 04 00 00       	jmp    1029c9 <__alltraps>

00102519 <vector156>:
.globl vector156
vector156:
  pushl $0
  102519:	6a 00                	push   $0x0
  pushl $156
  10251b:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102520:	e9 a4 04 00 00       	jmp    1029c9 <__alltraps>

00102525 <vector157>:
.globl vector157
vector157:
  pushl $0
  102525:	6a 00                	push   $0x0
  pushl $157
  102527:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  10252c:	e9 98 04 00 00       	jmp    1029c9 <__alltraps>

00102531 <vector158>:
.globl vector158
vector158:
  pushl $0
  102531:	6a 00                	push   $0x0
  pushl $158
  102533:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  102538:	e9 8c 04 00 00       	jmp    1029c9 <__alltraps>

0010253d <vector159>:
.globl vector159
vector159:
  pushl $0
  10253d:	6a 00                	push   $0x0
  pushl $159
  10253f:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  102544:	e9 80 04 00 00       	jmp    1029c9 <__alltraps>

00102549 <vector160>:
.globl vector160
vector160:
  pushl $0
  102549:	6a 00                	push   $0x0
  pushl $160
  10254b:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102550:	e9 74 04 00 00       	jmp    1029c9 <__alltraps>

00102555 <vector161>:
.globl vector161
vector161:
  pushl $0
  102555:	6a 00                	push   $0x0
  pushl $161
  102557:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  10255c:	e9 68 04 00 00       	jmp    1029c9 <__alltraps>

00102561 <vector162>:
.globl vector162
vector162:
  pushl $0
  102561:	6a 00                	push   $0x0
  pushl $162
  102563:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  102568:	e9 5c 04 00 00       	jmp    1029c9 <__alltraps>

0010256d <vector163>:
.globl vector163
vector163:
  pushl $0
  10256d:	6a 00                	push   $0x0
  pushl $163
  10256f:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  102574:	e9 50 04 00 00       	jmp    1029c9 <__alltraps>

00102579 <vector164>:
.globl vector164
vector164:
  pushl $0
  102579:	6a 00                	push   $0x0
  pushl $164
  10257b:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  102580:	e9 44 04 00 00       	jmp    1029c9 <__alltraps>

00102585 <vector165>:
.globl vector165
vector165:
  pushl $0
  102585:	6a 00                	push   $0x0
  pushl $165
  102587:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  10258c:	e9 38 04 00 00       	jmp    1029c9 <__alltraps>

00102591 <vector166>:
.globl vector166
vector166:
  pushl $0
  102591:	6a 00                	push   $0x0
  pushl $166
  102593:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  102598:	e9 2c 04 00 00       	jmp    1029c9 <__alltraps>

0010259d <vector167>:
.globl vector167
vector167:
  pushl $0
  10259d:	6a 00                	push   $0x0
  pushl $167
  10259f:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1025a4:	e9 20 04 00 00       	jmp    1029c9 <__alltraps>

001025a9 <vector168>:
.globl vector168
vector168:
  pushl $0
  1025a9:	6a 00                	push   $0x0
  pushl $168
  1025ab:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1025b0:	e9 14 04 00 00       	jmp    1029c9 <__alltraps>

001025b5 <vector169>:
.globl vector169
vector169:
  pushl $0
  1025b5:	6a 00                	push   $0x0
  pushl $169
  1025b7:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  1025bc:	e9 08 04 00 00       	jmp    1029c9 <__alltraps>

001025c1 <vector170>:
.globl vector170
vector170:
  pushl $0
  1025c1:	6a 00                	push   $0x0
  pushl $170
  1025c3:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  1025c8:	e9 fc 03 00 00       	jmp    1029c9 <__alltraps>

001025cd <vector171>:
.globl vector171
vector171:
  pushl $0
  1025cd:	6a 00                	push   $0x0
  pushl $171
  1025cf:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  1025d4:	e9 f0 03 00 00       	jmp    1029c9 <__alltraps>

001025d9 <vector172>:
.globl vector172
vector172:
  pushl $0
  1025d9:	6a 00                	push   $0x0
  pushl $172
  1025db:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  1025e0:	e9 e4 03 00 00       	jmp    1029c9 <__alltraps>

001025e5 <vector173>:
.globl vector173
vector173:
  pushl $0
  1025e5:	6a 00                	push   $0x0
  pushl $173
  1025e7:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  1025ec:	e9 d8 03 00 00       	jmp    1029c9 <__alltraps>

001025f1 <vector174>:
.globl vector174
vector174:
  pushl $0
  1025f1:	6a 00                	push   $0x0
  pushl $174
  1025f3:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  1025f8:	e9 cc 03 00 00       	jmp    1029c9 <__alltraps>

001025fd <vector175>:
.globl vector175
vector175:
  pushl $0
  1025fd:	6a 00                	push   $0x0
  pushl $175
  1025ff:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102604:	e9 c0 03 00 00       	jmp    1029c9 <__alltraps>

00102609 <vector176>:
.globl vector176
vector176:
  pushl $0
  102609:	6a 00                	push   $0x0
  pushl $176
  10260b:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102610:	e9 b4 03 00 00       	jmp    1029c9 <__alltraps>

00102615 <vector177>:
.globl vector177
vector177:
  pushl $0
  102615:	6a 00                	push   $0x0
  pushl $177
  102617:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  10261c:	e9 a8 03 00 00       	jmp    1029c9 <__alltraps>

00102621 <vector178>:
.globl vector178
vector178:
  pushl $0
  102621:	6a 00                	push   $0x0
  pushl $178
  102623:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  102628:	e9 9c 03 00 00       	jmp    1029c9 <__alltraps>

0010262d <vector179>:
.globl vector179
vector179:
  pushl $0
  10262d:	6a 00                	push   $0x0
  pushl $179
  10262f:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  102634:	e9 90 03 00 00       	jmp    1029c9 <__alltraps>

00102639 <vector180>:
.globl vector180
vector180:
  pushl $0
  102639:	6a 00                	push   $0x0
  pushl $180
  10263b:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102640:	e9 84 03 00 00       	jmp    1029c9 <__alltraps>

00102645 <vector181>:
.globl vector181
vector181:
  pushl $0
  102645:	6a 00                	push   $0x0
  pushl $181
  102647:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  10264c:	e9 78 03 00 00       	jmp    1029c9 <__alltraps>

00102651 <vector182>:
.globl vector182
vector182:
  pushl $0
  102651:	6a 00                	push   $0x0
  pushl $182
  102653:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  102658:	e9 6c 03 00 00       	jmp    1029c9 <__alltraps>

0010265d <vector183>:
.globl vector183
vector183:
  pushl $0
  10265d:	6a 00                	push   $0x0
  pushl $183
  10265f:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102664:	e9 60 03 00 00       	jmp    1029c9 <__alltraps>

00102669 <vector184>:
.globl vector184
vector184:
  pushl $0
  102669:	6a 00                	push   $0x0
  pushl $184
  10266b:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  102670:	e9 54 03 00 00       	jmp    1029c9 <__alltraps>

00102675 <vector185>:
.globl vector185
vector185:
  pushl $0
  102675:	6a 00                	push   $0x0
  pushl $185
  102677:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  10267c:	e9 48 03 00 00       	jmp    1029c9 <__alltraps>

00102681 <vector186>:
.globl vector186
vector186:
  pushl $0
  102681:	6a 00                	push   $0x0
  pushl $186
  102683:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102688:	e9 3c 03 00 00       	jmp    1029c9 <__alltraps>

0010268d <vector187>:
.globl vector187
vector187:
  pushl $0
  10268d:	6a 00                	push   $0x0
  pushl $187
  10268f:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102694:	e9 30 03 00 00       	jmp    1029c9 <__alltraps>

00102699 <vector188>:
.globl vector188
vector188:
  pushl $0
  102699:	6a 00                	push   $0x0
  pushl $188
  10269b:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1026a0:	e9 24 03 00 00       	jmp    1029c9 <__alltraps>

001026a5 <vector189>:
.globl vector189
vector189:
  pushl $0
  1026a5:	6a 00                	push   $0x0
  pushl $189
  1026a7:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1026ac:	e9 18 03 00 00       	jmp    1029c9 <__alltraps>

001026b1 <vector190>:
.globl vector190
vector190:
  pushl $0
  1026b1:	6a 00                	push   $0x0
  pushl $190
  1026b3:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1026b8:	e9 0c 03 00 00       	jmp    1029c9 <__alltraps>

001026bd <vector191>:
.globl vector191
vector191:
  pushl $0
  1026bd:	6a 00                	push   $0x0
  pushl $191
  1026bf:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  1026c4:	e9 00 03 00 00       	jmp    1029c9 <__alltraps>

001026c9 <vector192>:
.globl vector192
vector192:
  pushl $0
  1026c9:	6a 00                	push   $0x0
  pushl $192
  1026cb:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  1026d0:	e9 f4 02 00 00       	jmp    1029c9 <__alltraps>

001026d5 <vector193>:
.globl vector193
vector193:
  pushl $0
  1026d5:	6a 00                	push   $0x0
  pushl $193
  1026d7:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  1026dc:	e9 e8 02 00 00       	jmp    1029c9 <__alltraps>

001026e1 <vector194>:
.globl vector194
vector194:
  pushl $0
  1026e1:	6a 00                	push   $0x0
  pushl $194
  1026e3:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  1026e8:	e9 dc 02 00 00       	jmp    1029c9 <__alltraps>

001026ed <vector195>:
.globl vector195
vector195:
  pushl $0
  1026ed:	6a 00                	push   $0x0
  pushl $195
  1026ef:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  1026f4:	e9 d0 02 00 00       	jmp    1029c9 <__alltraps>

001026f9 <vector196>:
.globl vector196
vector196:
  pushl $0
  1026f9:	6a 00                	push   $0x0
  pushl $196
  1026fb:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102700:	e9 c4 02 00 00       	jmp    1029c9 <__alltraps>

00102705 <vector197>:
.globl vector197
vector197:
  pushl $0
  102705:	6a 00                	push   $0x0
  pushl $197
  102707:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  10270c:	e9 b8 02 00 00       	jmp    1029c9 <__alltraps>

00102711 <vector198>:
.globl vector198
vector198:
  pushl $0
  102711:	6a 00                	push   $0x0
  pushl $198
  102713:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102718:	e9 ac 02 00 00       	jmp    1029c9 <__alltraps>

0010271d <vector199>:
.globl vector199
vector199:
  pushl $0
  10271d:	6a 00                	push   $0x0
  pushl $199
  10271f:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102724:	e9 a0 02 00 00       	jmp    1029c9 <__alltraps>

00102729 <vector200>:
.globl vector200
vector200:
  pushl $0
  102729:	6a 00                	push   $0x0
  pushl $200
  10272b:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102730:	e9 94 02 00 00       	jmp    1029c9 <__alltraps>

00102735 <vector201>:
.globl vector201
vector201:
  pushl $0
  102735:	6a 00                	push   $0x0
  pushl $201
  102737:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  10273c:	e9 88 02 00 00       	jmp    1029c9 <__alltraps>

00102741 <vector202>:
.globl vector202
vector202:
  pushl $0
  102741:	6a 00                	push   $0x0
  pushl $202
  102743:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  102748:	e9 7c 02 00 00       	jmp    1029c9 <__alltraps>

0010274d <vector203>:
.globl vector203
vector203:
  pushl $0
  10274d:	6a 00                	push   $0x0
  pushl $203
  10274f:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102754:	e9 70 02 00 00       	jmp    1029c9 <__alltraps>

00102759 <vector204>:
.globl vector204
vector204:
  pushl $0
  102759:	6a 00                	push   $0x0
  pushl $204
  10275b:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102760:	e9 64 02 00 00       	jmp    1029c9 <__alltraps>

00102765 <vector205>:
.globl vector205
vector205:
  pushl $0
  102765:	6a 00                	push   $0x0
  pushl $205
  102767:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  10276c:	e9 58 02 00 00       	jmp    1029c9 <__alltraps>

00102771 <vector206>:
.globl vector206
vector206:
  pushl $0
  102771:	6a 00                	push   $0x0
  pushl $206
  102773:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  102778:	e9 4c 02 00 00       	jmp    1029c9 <__alltraps>

0010277d <vector207>:
.globl vector207
vector207:
  pushl $0
  10277d:	6a 00                	push   $0x0
  pushl $207
  10277f:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102784:	e9 40 02 00 00       	jmp    1029c9 <__alltraps>

00102789 <vector208>:
.globl vector208
vector208:
  pushl $0
  102789:	6a 00                	push   $0x0
  pushl $208
  10278b:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  102790:	e9 34 02 00 00       	jmp    1029c9 <__alltraps>

00102795 <vector209>:
.globl vector209
vector209:
  pushl $0
  102795:	6a 00                	push   $0x0
  pushl $209
  102797:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  10279c:	e9 28 02 00 00       	jmp    1029c9 <__alltraps>

001027a1 <vector210>:
.globl vector210
vector210:
  pushl $0
  1027a1:	6a 00                	push   $0x0
  pushl $210
  1027a3:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1027a8:	e9 1c 02 00 00       	jmp    1029c9 <__alltraps>

001027ad <vector211>:
.globl vector211
vector211:
  pushl $0
  1027ad:	6a 00                	push   $0x0
  pushl $211
  1027af:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1027b4:	e9 10 02 00 00       	jmp    1029c9 <__alltraps>

001027b9 <vector212>:
.globl vector212
vector212:
  pushl $0
  1027b9:	6a 00                	push   $0x0
  pushl $212
  1027bb:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  1027c0:	e9 04 02 00 00       	jmp    1029c9 <__alltraps>

001027c5 <vector213>:
.globl vector213
vector213:
  pushl $0
  1027c5:	6a 00                	push   $0x0
  pushl $213
  1027c7:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  1027cc:	e9 f8 01 00 00       	jmp    1029c9 <__alltraps>

001027d1 <vector214>:
.globl vector214
vector214:
  pushl $0
  1027d1:	6a 00                	push   $0x0
  pushl $214
  1027d3:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  1027d8:	e9 ec 01 00 00       	jmp    1029c9 <__alltraps>

001027dd <vector215>:
.globl vector215
vector215:
  pushl $0
  1027dd:	6a 00                	push   $0x0
  pushl $215
  1027df:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  1027e4:	e9 e0 01 00 00       	jmp    1029c9 <__alltraps>

001027e9 <vector216>:
.globl vector216
vector216:
  pushl $0
  1027e9:	6a 00                	push   $0x0
  pushl $216
  1027eb:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  1027f0:	e9 d4 01 00 00       	jmp    1029c9 <__alltraps>

001027f5 <vector217>:
.globl vector217
vector217:
  pushl $0
  1027f5:	6a 00                	push   $0x0
  pushl $217
  1027f7:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  1027fc:	e9 c8 01 00 00       	jmp    1029c9 <__alltraps>

00102801 <vector218>:
.globl vector218
vector218:
  pushl $0
  102801:	6a 00                	push   $0x0
  pushl $218
  102803:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102808:	e9 bc 01 00 00       	jmp    1029c9 <__alltraps>

0010280d <vector219>:
.globl vector219
vector219:
  pushl $0
  10280d:	6a 00                	push   $0x0
  pushl $219
  10280f:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102814:	e9 b0 01 00 00       	jmp    1029c9 <__alltraps>

00102819 <vector220>:
.globl vector220
vector220:
  pushl $0
  102819:	6a 00                	push   $0x0
  pushl $220
  10281b:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102820:	e9 a4 01 00 00       	jmp    1029c9 <__alltraps>

00102825 <vector221>:
.globl vector221
vector221:
  pushl $0
  102825:	6a 00                	push   $0x0
  pushl $221
  102827:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  10282c:	e9 98 01 00 00       	jmp    1029c9 <__alltraps>

00102831 <vector222>:
.globl vector222
vector222:
  pushl $0
  102831:	6a 00                	push   $0x0
  pushl $222
  102833:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  102838:	e9 8c 01 00 00       	jmp    1029c9 <__alltraps>

0010283d <vector223>:
.globl vector223
vector223:
  pushl $0
  10283d:	6a 00                	push   $0x0
  pushl $223
  10283f:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102844:	e9 80 01 00 00       	jmp    1029c9 <__alltraps>

00102849 <vector224>:
.globl vector224
vector224:
  pushl $0
  102849:	6a 00                	push   $0x0
  pushl $224
  10284b:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102850:	e9 74 01 00 00       	jmp    1029c9 <__alltraps>

00102855 <vector225>:
.globl vector225
vector225:
  pushl $0
  102855:	6a 00                	push   $0x0
  pushl $225
  102857:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  10285c:	e9 68 01 00 00       	jmp    1029c9 <__alltraps>

00102861 <vector226>:
.globl vector226
vector226:
  pushl $0
  102861:	6a 00                	push   $0x0
  pushl $226
  102863:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102868:	e9 5c 01 00 00       	jmp    1029c9 <__alltraps>

0010286d <vector227>:
.globl vector227
vector227:
  pushl $0
  10286d:	6a 00                	push   $0x0
  pushl $227
  10286f:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102874:	e9 50 01 00 00       	jmp    1029c9 <__alltraps>

00102879 <vector228>:
.globl vector228
vector228:
  pushl $0
  102879:	6a 00                	push   $0x0
  pushl $228
  10287b:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102880:	e9 44 01 00 00       	jmp    1029c9 <__alltraps>

00102885 <vector229>:
.globl vector229
vector229:
  pushl $0
  102885:	6a 00                	push   $0x0
  pushl $229
  102887:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  10288c:	e9 38 01 00 00       	jmp    1029c9 <__alltraps>

00102891 <vector230>:
.globl vector230
vector230:
  pushl $0
  102891:	6a 00                	push   $0x0
  pushl $230
  102893:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  102898:	e9 2c 01 00 00       	jmp    1029c9 <__alltraps>

0010289d <vector231>:
.globl vector231
vector231:
  pushl $0
  10289d:	6a 00                	push   $0x0
  pushl $231
  10289f:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  1028a4:	e9 20 01 00 00       	jmp    1029c9 <__alltraps>

001028a9 <vector232>:
.globl vector232
vector232:
  pushl $0
  1028a9:	6a 00                	push   $0x0
  pushl $232
  1028ab:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  1028b0:	e9 14 01 00 00       	jmp    1029c9 <__alltraps>

001028b5 <vector233>:
.globl vector233
vector233:
  pushl $0
  1028b5:	6a 00                	push   $0x0
  pushl $233
  1028b7:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  1028bc:	e9 08 01 00 00       	jmp    1029c9 <__alltraps>

001028c1 <vector234>:
.globl vector234
vector234:
  pushl $0
  1028c1:	6a 00                	push   $0x0
  pushl $234
  1028c3:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  1028c8:	e9 fc 00 00 00       	jmp    1029c9 <__alltraps>

001028cd <vector235>:
.globl vector235
vector235:
  pushl $0
  1028cd:	6a 00                	push   $0x0
  pushl $235
  1028cf:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  1028d4:	e9 f0 00 00 00       	jmp    1029c9 <__alltraps>

001028d9 <vector236>:
.globl vector236
vector236:
  pushl $0
  1028d9:	6a 00                	push   $0x0
  pushl $236
  1028db:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  1028e0:	e9 e4 00 00 00       	jmp    1029c9 <__alltraps>

001028e5 <vector237>:
.globl vector237
vector237:
  pushl $0
  1028e5:	6a 00                	push   $0x0
  pushl $237
  1028e7:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  1028ec:	e9 d8 00 00 00       	jmp    1029c9 <__alltraps>

001028f1 <vector238>:
.globl vector238
vector238:
  pushl $0
  1028f1:	6a 00                	push   $0x0
  pushl $238
  1028f3:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  1028f8:	e9 cc 00 00 00       	jmp    1029c9 <__alltraps>

001028fd <vector239>:
.globl vector239
vector239:
  pushl $0
  1028fd:	6a 00                	push   $0x0
  pushl $239
  1028ff:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102904:	e9 c0 00 00 00       	jmp    1029c9 <__alltraps>

00102909 <vector240>:
.globl vector240
vector240:
  pushl $0
  102909:	6a 00                	push   $0x0
  pushl $240
  10290b:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102910:	e9 b4 00 00 00       	jmp    1029c9 <__alltraps>

00102915 <vector241>:
.globl vector241
vector241:
  pushl $0
  102915:	6a 00                	push   $0x0
  pushl $241
  102917:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  10291c:	e9 a8 00 00 00       	jmp    1029c9 <__alltraps>

00102921 <vector242>:
.globl vector242
vector242:
  pushl $0
  102921:	6a 00                	push   $0x0
  pushl $242
  102923:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102928:	e9 9c 00 00 00       	jmp    1029c9 <__alltraps>

0010292d <vector243>:
.globl vector243
vector243:
  pushl $0
  10292d:	6a 00                	push   $0x0
  pushl $243
  10292f:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102934:	e9 90 00 00 00       	jmp    1029c9 <__alltraps>

00102939 <vector244>:
.globl vector244
vector244:
  pushl $0
  102939:	6a 00                	push   $0x0
  pushl $244
  10293b:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102940:	e9 84 00 00 00       	jmp    1029c9 <__alltraps>

00102945 <vector245>:
.globl vector245
vector245:
  pushl $0
  102945:	6a 00                	push   $0x0
  pushl $245
  102947:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  10294c:	e9 78 00 00 00       	jmp    1029c9 <__alltraps>

00102951 <vector246>:
.globl vector246
vector246:
  pushl $0
  102951:	6a 00                	push   $0x0
  pushl $246
  102953:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  102958:	e9 6c 00 00 00       	jmp    1029c9 <__alltraps>

0010295d <vector247>:
.globl vector247
vector247:
  pushl $0
  10295d:	6a 00                	push   $0x0
  pushl $247
  10295f:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102964:	e9 60 00 00 00       	jmp    1029c9 <__alltraps>

00102969 <vector248>:
.globl vector248
vector248:
  pushl $0
  102969:	6a 00                	push   $0x0
  pushl $248
  10296b:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102970:	e9 54 00 00 00       	jmp    1029c9 <__alltraps>

00102975 <vector249>:
.globl vector249
vector249:
  pushl $0
  102975:	6a 00                	push   $0x0
  pushl $249
  102977:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  10297c:	e9 48 00 00 00       	jmp    1029c9 <__alltraps>

00102981 <vector250>:
.globl vector250
vector250:
  pushl $0
  102981:	6a 00                	push   $0x0
  pushl $250
  102983:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102988:	e9 3c 00 00 00       	jmp    1029c9 <__alltraps>

0010298d <vector251>:
.globl vector251
vector251:
  pushl $0
  10298d:	6a 00                	push   $0x0
  pushl $251
  10298f:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102994:	e9 30 00 00 00       	jmp    1029c9 <__alltraps>

00102999 <vector252>:
.globl vector252
vector252:
  pushl $0
  102999:	6a 00                	push   $0x0
  pushl $252
  10299b:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  1029a0:	e9 24 00 00 00       	jmp    1029c9 <__alltraps>

001029a5 <vector253>:
.globl vector253
vector253:
  pushl $0
  1029a5:	6a 00                	push   $0x0
  pushl $253
  1029a7:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  1029ac:	e9 18 00 00 00       	jmp    1029c9 <__alltraps>

001029b1 <vector254>:
.globl vector254
vector254:
  pushl $0
  1029b1:	6a 00                	push   $0x0
  pushl $254
  1029b3:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  1029b8:	e9 0c 00 00 00       	jmp    1029c9 <__alltraps>

001029bd <vector255>:
.globl vector255
vector255:
  pushl $0
  1029bd:	6a 00                	push   $0x0
  pushl $255
  1029bf:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  1029c4:	e9 00 00 00 00       	jmp    1029c9 <__alltraps>

001029c9 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  1029c9:	1e                   	push   %ds
    pushl %es
  1029ca:	06                   	push   %es
    pushl %fs
  1029cb:	0f a0                	push   %fs
    pushl %gs
  1029cd:	0f a8                	push   %gs
    pushal
  1029cf:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  1029d0:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  1029d5:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  1029d7:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  1029d9:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  1029da:	e8 60 f5 ff ff       	call   101f3f <trap>

    # pop the pushed stack pointer
    popl %esp
  1029df:	5c                   	pop    %esp

001029e0 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  1029e0:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  1029e1:	0f a9                	pop    %gs
    popl %fs
  1029e3:	0f a1                	pop    %fs
    popl %es
  1029e5:	07                   	pop    %es
    popl %ds
  1029e6:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  1029e7:	83 c4 08             	add    $0x8,%esp
    iret
  1029ea:	cf                   	iret   

001029eb <page2ppn>:

extern struct Page *pages;
extern size_t npage;

static inline ppn_t
page2ppn(struct Page *page) {
  1029eb:	55                   	push   %ebp
  1029ec:	89 e5                	mov    %esp,%ebp
    return page - pages;
  1029ee:	a1 18 cf 11 00       	mov    0x11cf18,%eax
  1029f3:	8b 55 08             	mov    0x8(%ebp),%edx
  1029f6:	29 c2                	sub    %eax,%edx
  1029f8:	89 d0                	mov    %edx,%eax
  1029fa:	c1 f8 02             	sar    $0x2,%eax
  1029fd:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
  102a03:	5d                   	pop    %ebp
  102a04:	c3                   	ret    

00102a05 <page2pa>:

static inline uintptr_t
page2pa(struct Page *page) {
  102a05:	55                   	push   %ebp
  102a06:	89 e5                	mov    %esp,%ebp
  102a08:	83 ec 04             	sub    $0x4,%esp
    return page2ppn(page) << PGSHIFT;
  102a0b:	8b 45 08             	mov    0x8(%ebp),%eax
  102a0e:	89 04 24             	mov    %eax,(%esp)
  102a11:	e8 d5 ff ff ff       	call   1029eb <page2ppn>
  102a16:	c1 e0 0c             	shl    $0xc,%eax
}
  102a19:	c9                   	leave  
  102a1a:	c3                   	ret    

00102a1b <pa2page>:

static inline struct Page *
pa2page(uintptr_t pa) {
  102a1b:	55                   	push   %ebp
  102a1c:	89 e5                	mov    %esp,%ebp
  102a1e:	83 ec 18             	sub    $0x18,%esp
    if (PPN(pa) >= npage) {
  102a21:	8b 45 08             	mov    0x8(%ebp),%eax
  102a24:	c1 e8 0c             	shr    $0xc,%eax
  102a27:	89 c2                	mov    %eax,%edx
  102a29:	a1 80 ce 11 00       	mov    0x11ce80,%eax
  102a2e:	39 c2                	cmp    %eax,%edx
  102a30:	72 1c                	jb     102a4e <pa2page+0x33>
        panic("pa2page called with invalid pa");
  102a32:	c7 44 24 08 10 68 10 	movl   $0x106810,0x8(%esp)
  102a39:	00 
  102a3a:	c7 44 24 04 5a 00 00 	movl   $0x5a,0x4(%esp)
  102a41:	00 
  102a42:	c7 04 24 2f 68 10 00 	movl   $0x10682f,(%esp)
  102a49:	e8 e7 d9 ff ff       	call   100435 <__panic>
    }
    return &pages[PPN(pa)];
  102a4e:	8b 0d 18 cf 11 00    	mov    0x11cf18,%ecx
  102a54:	8b 45 08             	mov    0x8(%ebp),%eax
  102a57:	c1 e8 0c             	shr    $0xc,%eax
  102a5a:	89 c2                	mov    %eax,%edx
  102a5c:	89 d0                	mov    %edx,%eax
  102a5e:	c1 e0 02             	shl    $0x2,%eax
  102a61:	01 d0                	add    %edx,%eax
  102a63:	c1 e0 02             	shl    $0x2,%eax
  102a66:	01 c8                	add    %ecx,%eax
}
  102a68:	c9                   	leave  
  102a69:	c3                   	ret    

00102a6a <page2kva>:

static inline void *
page2kva(struct Page *page) {
  102a6a:	55                   	push   %ebp
  102a6b:	89 e5                	mov    %esp,%ebp
  102a6d:	83 ec 28             	sub    $0x28,%esp
    return KADDR(page2pa(page));
  102a70:	8b 45 08             	mov    0x8(%ebp),%eax
  102a73:	89 04 24             	mov    %eax,(%esp)
  102a76:	e8 8a ff ff ff       	call   102a05 <page2pa>
  102a7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102a7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a81:	c1 e8 0c             	shr    $0xc,%eax
  102a84:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102a87:	a1 80 ce 11 00       	mov    0x11ce80,%eax
  102a8c:	39 45 f0             	cmp    %eax,-0x10(%ebp)
  102a8f:	72 23                	jb     102ab4 <page2kva+0x4a>
  102a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a94:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102a98:	c7 44 24 08 40 68 10 	movl   $0x106840,0x8(%esp)
  102a9f:	00 
  102aa0:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  102aa7:	00 
  102aa8:	c7 04 24 2f 68 10 00 	movl   $0x10682f,(%esp)
  102aaf:	e8 81 d9 ff ff       	call   100435 <__panic>
  102ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102ab7:	2d 00 00 00 40       	sub    $0x40000000,%eax
}
  102abc:	c9                   	leave  
  102abd:	c3                   	ret    

00102abe <pte2page>:
kva2page(void *kva) {
    return pa2page(PADDR(kva));
}

static inline struct Page *
pte2page(pte_t pte) {
  102abe:	55                   	push   %ebp
  102abf:	89 e5                	mov    %esp,%ebp
  102ac1:	83 ec 18             	sub    $0x18,%esp
    if (!(pte & PTE_P)) {
  102ac4:	8b 45 08             	mov    0x8(%ebp),%eax
  102ac7:	83 e0 01             	and    $0x1,%eax
  102aca:	85 c0                	test   %eax,%eax
  102acc:	75 1c                	jne    102aea <pte2page+0x2c>
        panic("pte2page called with invalid pte");
  102ace:	c7 44 24 08 64 68 10 	movl   $0x106864,0x8(%esp)
  102ad5:	00 
  102ad6:	c7 44 24 04 6c 00 00 	movl   $0x6c,0x4(%esp)
  102add:	00 
  102ade:	c7 04 24 2f 68 10 00 	movl   $0x10682f,(%esp)
  102ae5:	e8 4b d9 ff ff       	call   100435 <__panic>
    }
    return pa2page(PTE_ADDR(pte));
  102aea:	8b 45 08             	mov    0x8(%ebp),%eax
  102aed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  102af2:	89 04 24             	mov    %eax,(%esp)
  102af5:	e8 21 ff ff ff       	call   102a1b <pa2page>
}
  102afa:	c9                   	leave  
  102afb:	c3                   	ret    

00102afc <pde2page>:

static inline struct Page *
pde2page(pde_t pde) {
  102afc:	55                   	push   %ebp
  102afd:	89 e5                	mov    %esp,%ebp
  102aff:	83 ec 18             	sub    $0x18,%esp
    return pa2page(PDE_ADDR(pde));
  102b02:	8b 45 08             	mov    0x8(%ebp),%eax
  102b05:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  102b0a:	89 04 24             	mov    %eax,(%esp)
  102b0d:	e8 09 ff ff ff       	call   102a1b <pa2page>
}
  102b12:	c9                   	leave  
  102b13:	c3                   	ret    

00102b14 <page_ref>:

static inline int
page_ref(struct Page *page) {
  102b14:	55                   	push   %ebp
  102b15:	89 e5                	mov    %esp,%ebp
    return page->ref;
  102b17:	8b 45 08             	mov    0x8(%ebp),%eax
  102b1a:	8b 00                	mov    (%eax),%eax
}
  102b1c:	5d                   	pop    %ebp
  102b1d:	c3                   	ret    

00102b1e <set_page_ref>:

static inline void
set_page_ref(struct Page *page, int val) {
  102b1e:	55                   	push   %ebp
  102b1f:	89 e5                	mov    %esp,%ebp
    page->ref = val;
  102b21:	8b 45 08             	mov    0x8(%ebp),%eax
  102b24:	8b 55 0c             	mov    0xc(%ebp),%edx
  102b27:	89 10                	mov    %edx,(%eax)
}
  102b29:	90                   	nop
  102b2a:	5d                   	pop    %ebp
  102b2b:	c3                   	ret    

00102b2c <page_ref_inc>:

static inline int
page_ref_inc(struct Page *page) {
  102b2c:	55                   	push   %ebp
  102b2d:	89 e5                	mov    %esp,%ebp
    page->ref += 1;
  102b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  102b32:	8b 00                	mov    (%eax),%eax
  102b34:	8d 50 01             	lea    0x1(%eax),%edx
  102b37:	8b 45 08             	mov    0x8(%ebp),%eax
  102b3a:	89 10                	mov    %edx,(%eax)
    return page->ref;
  102b3c:	8b 45 08             	mov    0x8(%ebp),%eax
  102b3f:	8b 00                	mov    (%eax),%eax
}
  102b41:	5d                   	pop    %ebp
  102b42:	c3                   	ret    

00102b43 <page_ref_dec>:

static inline int
page_ref_dec(struct Page *page) {
  102b43:	55                   	push   %ebp
  102b44:	89 e5                	mov    %esp,%ebp
    page->ref -= 1;
  102b46:	8b 45 08             	mov    0x8(%ebp),%eax
  102b49:	8b 00                	mov    (%eax),%eax
  102b4b:	8d 50 ff             	lea    -0x1(%eax),%edx
  102b4e:	8b 45 08             	mov    0x8(%ebp),%eax
  102b51:	89 10                	mov    %edx,(%eax)
    return page->ref;
  102b53:	8b 45 08             	mov    0x8(%ebp),%eax
  102b56:	8b 00                	mov    (%eax),%eax
}
  102b58:	5d                   	pop    %ebp
  102b59:	c3                   	ret    

00102b5a <__intr_save>:
__intr_save(void) {
  102b5a:	55                   	push   %ebp
  102b5b:	89 e5                	mov    %esp,%ebp
  102b5d:	83 ec 18             	sub    $0x18,%esp
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
  102b60:	9c                   	pushf  
  102b61:	58                   	pop    %eax
  102b62:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
  102b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
  102b68:	25 00 02 00 00       	and    $0x200,%eax
  102b6d:	85 c0                	test   %eax,%eax
  102b6f:	74 0c                	je     102b7d <__intr_save+0x23>
        intr_disable();
  102b71:	e8 61 ed ff ff       	call   1018d7 <intr_disable>
        return 1;
  102b76:	b8 01 00 00 00       	mov    $0x1,%eax
  102b7b:	eb 05                	jmp    102b82 <__intr_save+0x28>
    return 0;
  102b7d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102b82:	c9                   	leave  
  102b83:	c3                   	ret    

00102b84 <__intr_restore>:
__intr_restore(bool flag) {
  102b84:	55                   	push   %ebp
  102b85:	89 e5                	mov    %esp,%ebp
  102b87:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
  102b8a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  102b8e:	74 05                	je     102b95 <__intr_restore+0x11>
        intr_enable();
  102b90:	e8 36 ed ff ff       	call   1018cb <intr_enable>
}
  102b95:	90                   	nop
  102b96:	c9                   	leave  
  102b97:	c3                   	ret    

00102b98 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102b98:	55                   	push   %ebp
  102b99:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  102b9e:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102ba1:	b8 23 00 00 00       	mov    $0x23,%eax
  102ba6:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102ba8:	b8 23 00 00 00       	mov    $0x23,%eax
  102bad:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102baf:	b8 10 00 00 00       	mov    $0x10,%eax
  102bb4:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102bb6:	b8 10 00 00 00       	mov    $0x10,%eax
  102bbb:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102bbd:	b8 10 00 00 00       	mov    $0x10,%eax
  102bc2:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102bc4:	ea cb 2b 10 00 08 00 	ljmp   $0x8,$0x102bcb
}
  102bcb:	90                   	nop
  102bcc:	5d                   	pop    %ebp
  102bcd:	c3                   	ret    

00102bce <load_esp0>:
 * load_esp0 - change the ESP0 in default task state segment,
 * so that we can use different kernel stack when we trap frame
 * user to kernel.
 * */
void
load_esp0(uintptr_t esp0) {
  102bce:	f3 0f 1e fb          	endbr32 
  102bd2:	55                   	push   %ebp
  102bd3:	89 e5                	mov    %esp,%ebp
    ts.ts_esp0 = esp0;
  102bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  102bd8:	a3 a4 ce 11 00       	mov    %eax,0x11cea4
}
  102bdd:	90                   	nop
  102bde:	5d                   	pop    %ebp
  102bdf:	c3                   	ret    

00102be0 <gdt_init>:

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102be0:	f3 0f 1e fb          	endbr32 
  102be4:	55                   	push   %ebp
  102be5:	89 e5                	mov    %esp,%ebp
  102be7:	83 ec 14             	sub    $0x14,%esp
    // set boot kernel stack and default SS0
    load_esp0((uintptr_t)bootstacktop);
  102bea:	b8 00 90 11 00       	mov    $0x119000,%eax
  102bef:	89 04 24             	mov    %eax,(%esp)
  102bf2:	e8 d7 ff ff ff       	call   102bce <load_esp0>
    ts.ts_ss0 = KERNEL_DS;
  102bf7:	66 c7 05 a8 ce 11 00 	movw   $0x10,0x11cea8
  102bfe:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEGTSS(STS_T32A, (uintptr_t)&ts, sizeof(ts), DPL_KERNEL);
  102c00:	66 c7 05 28 9a 11 00 	movw   $0x68,0x119a28
  102c07:	68 00 
  102c09:	b8 a0 ce 11 00       	mov    $0x11cea0,%eax
  102c0e:	0f b7 c0             	movzwl %ax,%eax
  102c11:	66 a3 2a 9a 11 00    	mov    %ax,0x119a2a
  102c17:	b8 a0 ce 11 00       	mov    $0x11cea0,%eax
  102c1c:	c1 e8 10             	shr    $0x10,%eax
  102c1f:	a2 2c 9a 11 00       	mov    %al,0x119a2c
  102c24:	0f b6 05 2d 9a 11 00 	movzbl 0x119a2d,%eax
  102c2b:	24 f0                	and    $0xf0,%al
  102c2d:	0c 09                	or     $0x9,%al
  102c2f:	a2 2d 9a 11 00       	mov    %al,0x119a2d
  102c34:	0f b6 05 2d 9a 11 00 	movzbl 0x119a2d,%eax
  102c3b:	24 ef                	and    $0xef,%al
  102c3d:	a2 2d 9a 11 00       	mov    %al,0x119a2d
  102c42:	0f b6 05 2d 9a 11 00 	movzbl 0x119a2d,%eax
  102c49:	24 9f                	and    $0x9f,%al
  102c4b:	a2 2d 9a 11 00       	mov    %al,0x119a2d
  102c50:	0f b6 05 2d 9a 11 00 	movzbl 0x119a2d,%eax
  102c57:	0c 80                	or     $0x80,%al
  102c59:	a2 2d 9a 11 00       	mov    %al,0x119a2d
  102c5e:	0f b6 05 2e 9a 11 00 	movzbl 0x119a2e,%eax
  102c65:	24 f0                	and    $0xf0,%al
  102c67:	a2 2e 9a 11 00       	mov    %al,0x119a2e
  102c6c:	0f b6 05 2e 9a 11 00 	movzbl 0x119a2e,%eax
  102c73:	24 ef                	and    $0xef,%al
  102c75:	a2 2e 9a 11 00       	mov    %al,0x119a2e
  102c7a:	0f b6 05 2e 9a 11 00 	movzbl 0x119a2e,%eax
  102c81:	24 df                	and    $0xdf,%al
  102c83:	a2 2e 9a 11 00       	mov    %al,0x119a2e
  102c88:	0f b6 05 2e 9a 11 00 	movzbl 0x119a2e,%eax
  102c8f:	0c 40                	or     $0x40,%al
  102c91:	a2 2e 9a 11 00       	mov    %al,0x119a2e
  102c96:	0f b6 05 2e 9a 11 00 	movzbl 0x119a2e,%eax
  102c9d:	24 7f                	and    $0x7f,%al
  102c9f:	a2 2e 9a 11 00       	mov    %al,0x119a2e
  102ca4:	b8 a0 ce 11 00       	mov    $0x11cea0,%eax
  102ca9:	c1 e8 18             	shr    $0x18,%eax
  102cac:	a2 2f 9a 11 00       	mov    %al,0x119a2f

    // reload all segment registers
    lgdt(&gdt_pd);
  102cb1:	c7 04 24 30 9a 11 00 	movl   $0x119a30,(%esp)
  102cb8:	e8 db fe ff ff       	call   102b98 <lgdt>
  102cbd:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("ltr %0" :: "r" (sel) : "memory");
  102cc3:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102cc7:	0f 00 d8             	ltr    %ax
}
  102cca:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102ccb:	90                   	nop
  102ccc:	c9                   	leave  
  102ccd:	c3                   	ret    

00102cce <init_pmm_manager>:

//init_pmm_manager - initialize a pmm_manager instance
static void
init_pmm_manager(void) {
  102cce:	f3 0f 1e fb          	endbr32 
  102cd2:	55                   	push   %ebp
  102cd3:	89 e5                	mov    %esp,%ebp
  102cd5:	83 ec 18             	sub    $0x18,%esp
    pmm_manager = &default_pmm_manager;
  102cd8:	c7 05 10 cf 11 00 08 	movl   $0x107208,0x11cf10
  102cdf:	72 10 00 
    cprintf("memory management: %s\n", pmm_manager->name);
  102ce2:	a1 10 cf 11 00       	mov    0x11cf10,%eax
  102ce7:	8b 00                	mov    (%eax),%eax
  102ce9:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ced:	c7 04 24 90 68 10 00 	movl   $0x106890,(%esp)
  102cf4:	e8 d0 d5 ff ff       	call   1002c9 <cprintf>
    pmm_manager->init();
  102cf9:	a1 10 cf 11 00       	mov    0x11cf10,%eax
  102cfe:	8b 40 04             	mov    0x4(%eax),%eax
  102d01:	ff d0                	call   *%eax
}
  102d03:	90                   	nop
  102d04:	c9                   	leave  
  102d05:	c3                   	ret    

00102d06 <init_memmap>:

//init_memmap - call pmm->init_memmap to build Page struct for free memory  
static void
init_memmap(struct Page *base, size_t n) {
  102d06:	f3 0f 1e fb          	endbr32 
  102d0a:	55                   	push   %ebp
  102d0b:	89 e5                	mov    %esp,%ebp
  102d0d:	83 ec 18             	sub    $0x18,%esp
    pmm_manager->init_memmap(base, n);
  102d10:	a1 10 cf 11 00       	mov    0x11cf10,%eax
  102d15:	8b 40 08             	mov    0x8(%eax),%eax
  102d18:	8b 55 0c             	mov    0xc(%ebp),%edx
  102d1b:	89 54 24 04          	mov    %edx,0x4(%esp)
  102d1f:	8b 55 08             	mov    0x8(%ebp),%edx
  102d22:	89 14 24             	mov    %edx,(%esp)
  102d25:	ff d0                	call   *%eax
}
  102d27:	90                   	nop
  102d28:	c9                   	leave  
  102d29:	c3                   	ret    

00102d2a <alloc_pages>:

//alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE memory 
struct Page *
alloc_pages(size_t n) {
  102d2a:	f3 0f 1e fb          	endbr32 
  102d2e:	55                   	push   %ebp
  102d2f:	89 e5                	mov    %esp,%ebp
  102d31:	83 ec 28             	sub    $0x28,%esp
    struct Page *page=NULL;
  102d34:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
  102d3b:	e8 1a fe ff ff       	call   102b5a <__intr_save>
  102d40:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        page = pmm_manager->alloc_pages(n);
  102d43:	a1 10 cf 11 00       	mov    0x11cf10,%eax
  102d48:	8b 40 0c             	mov    0xc(%eax),%eax
  102d4b:	8b 55 08             	mov    0x8(%ebp),%edx
  102d4e:	89 14 24             	mov    %edx,(%esp)
  102d51:	ff d0                	call   *%eax
  102d53:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    local_intr_restore(intr_flag);
  102d56:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d59:	89 04 24             	mov    %eax,(%esp)
  102d5c:	e8 23 fe ff ff       	call   102b84 <__intr_restore>
    return page;
  102d61:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  102d64:	c9                   	leave  
  102d65:	c3                   	ret    

00102d66 <free_pages>:

//free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory 
void
free_pages(struct Page *base, size_t n) {
  102d66:	f3 0f 1e fb          	endbr32 
  102d6a:	55                   	push   %ebp
  102d6b:	89 e5                	mov    %esp,%ebp
  102d6d:	83 ec 28             	sub    $0x28,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
  102d70:	e8 e5 fd ff ff       	call   102b5a <__intr_save>
  102d75:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        pmm_manager->free_pages(base, n);
  102d78:	a1 10 cf 11 00       	mov    0x11cf10,%eax
  102d7d:	8b 40 10             	mov    0x10(%eax),%eax
  102d80:	8b 55 0c             	mov    0xc(%ebp),%edx
  102d83:	89 54 24 04          	mov    %edx,0x4(%esp)
  102d87:	8b 55 08             	mov    0x8(%ebp),%edx
  102d8a:	89 14 24             	mov    %edx,(%esp)
  102d8d:	ff d0                	call   *%eax
    }
    local_intr_restore(intr_flag);
  102d8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102d92:	89 04 24             	mov    %eax,(%esp)
  102d95:	e8 ea fd ff ff       	call   102b84 <__intr_restore>
}
  102d9a:	90                   	nop
  102d9b:	c9                   	leave  
  102d9c:	c3                   	ret    

00102d9d <nr_free_pages>:

//nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE) 
//of current free memory
size_t
nr_free_pages(void) {
  102d9d:	f3 0f 1e fb          	endbr32 
  102da1:	55                   	push   %ebp
  102da2:	89 e5                	mov    %esp,%ebp
  102da4:	83 ec 28             	sub    $0x28,%esp
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
  102da7:	e8 ae fd ff ff       	call   102b5a <__intr_save>
  102dac:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        ret = pmm_manager->nr_free_pages();
  102daf:	a1 10 cf 11 00       	mov    0x11cf10,%eax
  102db4:	8b 40 14             	mov    0x14(%eax),%eax
  102db7:	ff d0                	call   *%eax
  102db9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    local_intr_restore(intr_flag);
  102dbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102dbf:	89 04 24             	mov    %eax,(%esp)
  102dc2:	e8 bd fd ff ff       	call   102b84 <__intr_restore>
    return ret;
  102dc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  102dca:	c9                   	leave  
  102dcb:	c3                   	ret    

00102dcc <page_init>:

/* pmm_init - initialize the physical memory management */
static void
page_init(void) {
  102dcc:	f3 0f 1e fb          	endbr32 
  102dd0:	55                   	push   %ebp
  102dd1:	89 e5                	mov    %esp,%ebp
  102dd3:	57                   	push   %edi
  102dd4:	56                   	push   %esi
  102dd5:	53                   	push   %ebx
  102dd6:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
    struct e820map *memmap = (struct e820map *)(0x8000 + KERNBASE);
  102ddc:	c7 45 c4 00 80 00 c0 	movl   $0xc0008000,-0x3c(%ebp)
    uint64_t maxpa = 0;
  102de3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  102dea:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

    cprintf("e820map:\n");
  102df1:	c7 04 24 a7 68 10 00 	movl   $0x1068a7,(%esp)
  102df8:	e8 cc d4 ff ff       	call   1002c9 <cprintf>
    int i;
    for (i = 0; i < memmap->nr_map; i ++) {
  102dfd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102e04:	e9 1a 01 00 00       	jmp    102f23 <page_init+0x157>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
  102e09:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  102e0c:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102e0f:	89 d0                	mov    %edx,%eax
  102e11:	c1 e0 02             	shl    $0x2,%eax
  102e14:	01 d0                	add    %edx,%eax
  102e16:	c1 e0 02             	shl    $0x2,%eax
  102e19:	01 c8                	add    %ecx,%eax
  102e1b:	8b 50 08             	mov    0x8(%eax),%edx
  102e1e:	8b 40 04             	mov    0x4(%eax),%eax
  102e21:	89 45 a0             	mov    %eax,-0x60(%ebp)
  102e24:	89 55 a4             	mov    %edx,-0x5c(%ebp)
  102e27:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  102e2a:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102e2d:	89 d0                	mov    %edx,%eax
  102e2f:	c1 e0 02             	shl    $0x2,%eax
  102e32:	01 d0                	add    %edx,%eax
  102e34:	c1 e0 02             	shl    $0x2,%eax
  102e37:	01 c8                	add    %ecx,%eax
  102e39:	8b 48 0c             	mov    0xc(%eax),%ecx
  102e3c:	8b 58 10             	mov    0x10(%eax),%ebx
  102e3f:	8b 45 a0             	mov    -0x60(%ebp),%eax
  102e42:	8b 55 a4             	mov    -0x5c(%ebp),%edx
  102e45:	01 c8                	add    %ecx,%eax
  102e47:	11 da                	adc    %ebx,%edx
  102e49:	89 45 98             	mov    %eax,-0x68(%ebp)
  102e4c:	89 55 9c             	mov    %edx,-0x64(%ebp)
        cprintf("  memory: %08llx, [%08llx, %08llx], type = %d.\n",
  102e4f:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  102e52:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102e55:	89 d0                	mov    %edx,%eax
  102e57:	c1 e0 02             	shl    $0x2,%eax
  102e5a:	01 d0                	add    %edx,%eax
  102e5c:	c1 e0 02             	shl    $0x2,%eax
  102e5f:	01 c8                	add    %ecx,%eax
  102e61:	83 c0 14             	add    $0x14,%eax
  102e64:	8b 00                	mov    (%eax),%eax
  102e66:	89 45 84             	mov    %eax,-0x7c(%ebp)
  102e69:	8b 45 98             	mov    -0x68(%ebp),%eax
  102e6c:	8b 55 9c             	mov    -0x64(%ebp),%edx
  102e6f:	83 c0 ff             	add    $0xffffffff,%eax
  102e72:	83 d2 ff             	adc    $0xffffffff,%edx
  102e75:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
  102e7b:	89 95 7c ff ff ff    	mov    %edx,-0x84(%ebp)
  102e81:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  102e84:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102e87:	89 d0                	mov    %edx,%eax
  102e89:	c1 e0 02             	shl    $0x2,%eax
  102e8c:	01 d0                	add    %edx,%eax
  102e8e:	c1 e0 02             	shl    $0x2,%eax
  102e91:	01 c8                	add    %ecx,%eax
  102e93:	8b 48 0c             	mov    0xc(%eax),%ecx
  102e96:	8b 58 10             	mov    0x10(%eax),%ebx
  102e99:	8b 55 84             	mov    -0x7c(%ebp),%edx
  102e9c:	89 54 24 1c          	mov    %edx,0x1c(%esp)
  102ea0:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
  102ea6:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
  102eac:	89 44 24 14          	mov    %eax,0x14(%esp)
  102eb0:	89 54 24 18          	mov    %edx,0x18(%esp)
  102eb4:	8b 45 a0             	mov    -0x60(%ebp),%eax
  102eb7:	8b 55 a4             	mov    -0x5c(%ebp),%edx
  102eba:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102ebe:	89 54 24 10          	mov    %edx,0x10(%esp)
  102ec2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  102ec6:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  102eca:	c7 04 24 b4 68 10 00 	movl   $0x1068b4,(%esp)
  102ed1:	e8 f3 d3 ff ff       	call   1002c9 <cprintf>
                memmap->map[i].size, begin, end - 1, memmap->map[i].type);
        if (memmap->map[i].type == E820_ARM) {
  102ed6:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  102ed9:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102edc:	89 d0                	mov    %edx,%eax
  102ede:	c1 e0 02             	shl    $0x2,%eax
  102ee1:	01 d0                	add    %edx,%eax
  102ee3:	c1 e0 02             	shl    $0x2,%eax
  102ee6:	01 c8                	add    %ecx,%eax
  102ee8:	83 c0 14             	add    $0x14,%eax
  102eeb:	8b 00                	mov    (%eax),%eax
  102eed:	83 f8 01             	cmp    $0x1,%eax
  102ef0:	75 2e                	jne    102f20 <page_init+0x154>
            if (maxpa < end && begin < KMEMSIZE) {
  102ef2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102ef5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102ef8:	3b 45 98             	cmp    -0x68(%ebp),%eax
  102efb:	89 d0                	mov    %edx,%eax
  102efd:	1b 45 9c             	sbb    -0x64(%ebp),%eax
  102f00:	73 1e                	jae    102f20 <page_init+0x154>
  102f02:	ba ff ff ff 37       	mov    $0x37ffffff,%edx
  102f07:	b8 00 00 00 00       	mov    $0x0,%eax
  102f0c:	3b 55 a0             	cmp    -0x60(%ebp),%edx
  102f0f:	1b 45 a4             	sbb    -0x5c(%ebp),%eax
  102f12:	72 0c                	jb     102f20 <page_init+0x154>
                maxpa = end;
  102f14:	8b 45 98             	mov    -0x68(%ebp),%eax
  102f17:	8b 55 9c             	mov    -0x64(%ebp),%edx
  102f1a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102f1d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    for (i = 0; i < memmap->nr_map; i ++) {
  102f20:	ff 45 dc             	incl   -0x24(%ebp)
  102f23:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  102f26:	8b 00                	mov    (%eax),%eax
  102f28:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  102f2b:	0f 8c d8 fe ff ff    	jl     102e09 <page_init+0x3d>
            }
        }
    }
    if (maxpa > KMEMSIZE) {
  102f31:	ba 00 00 00 38       	mov    $0x38000000,%edx
  102f36:	b8 00 00 00 00       	mov    $0x0,%eax
  102f3b:	3b 55 e0             	cmp    -0x20(%ebp),%edx
  102f3e:	1b 45 e4             	sbb    -0x1c(%ebp),%eax
  102f41:	73 0e                	jae    102f51 <page_init+0x185>
        maxpa = KMEMSIZE;
  102f43:	c7 45 e0 00 00 00 38 	movl   $0x38000000,-0x20(%ebp)
  102f4a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    }

    extern char end[];

    npage = maxpa / PGSIZE;
  102f51:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102f54:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102f57:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
  102f5b:	c1 ea 0c             	shr    $0xc,%edx
  102f5e:	a3 80 ce 11 00       	mov    %eax,0x11ce80
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
  102f63:	c7 45 c0 00 10 00 00 	movl   $0x1000,-0x40(%ebp)
  102f6a:	b8 28 cf 11 00       	mov    $0x11cf28,%eax
  102f6f:	8d 50 ff             	lea    -0x1(%eax),%edx
  102f72:	8b 45 c0             	mov    -0x40(%ebp),%eax
  102f75:	01 d0                	add    %edx,%eax
  102f77:	89 45 bc             	mov    %eax,-0x44(%ebp)
  102f7a:	8b 45 bc             	mov    -0x44(%ebp),%eax
  102f7d:	ba 00 00 00 00       	mov    $0x0,%edx
  102f82:	f7 75 c0             	divl   -0x40(%ebp)
  102f85:	8b 45 bc             	mov    -0x44(%ebp),%eax
  102f88:	29 d0                	sub    %edx,%eax
  102f8a:	a3 18 cf 11 00       	mov    %eax,0x11cf18

    for (i = 0; i < npage; i ++) {
  102f8f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102f96:	eb 2f                	jmp    102fc7 <page_init+0x1fb>
        SetPageReserved(pages + i);
  102f98:	8b 0d 18 cf 11 00    	mov    0x11cf18,%ecx
  102f9e:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102fa1:	89 d0                	mov    %edx,%eax
  102fa3:	c1 e0 02             	shl    $0x2,%eax
  102fa6:	01 d0                	add    %edx,%eax
  102fa8:	c1 e0 02             	shl    $0x2,%eax
  102fab:	01 c8                	add    %ecx,%eax
  102fad:	83 c0 04             	add    $0x4,%eax
  102fb0:	c7 45 94 00 00 00 00 	movl   $0x0,-0x6c(%ebp)
  102fb7:	89 45 90             	mov    %eax,-0x70(%ebp)
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void
set_bit(int nr, volatile void *addr) {
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  102fba:	8b 45 90             	mov    -0x70(%ebp),%eax
  102fbd:	8b 55 94             	mov    -0x6c(%ebp),%edx
  102fc0:	0f ab 10             	bts    %edx,(%eax)
}
  102fc3:	90                   	nop
    for (i = 0; i < npage; i ++) {
  102fc4:	ff 45 dc             	incl   -0x24(%ebp)
  102fc7:	8b 55 dc             	mov    -0x24(%ebp),%edx
  102fca:	a1 80 ce 11 00       	mov    0x11ce80,%eax
  102fcf:	39 c2                	cmp    %eax,%edx
  102fd1:	72 c5                	jb     102f98 <page_init+0x1cc>
    }

    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * npage);
  102fd3:	8b 15 80 ce 11 00    	mov    0x11ce80,%edx
  102fd9:	89 d0                	mov    %edx,%eax
  102fdb:	c1 e0 02             	shl    $0x2,%eax
  102fde:	01 d0                	add    %edx,%eax
  102fe0:	c1 e0 02             	shl    $0x2,%eax
  102fe3:	89 c2                	mov    %eax,%edx
  102fe5:	a1 18 cf 11 00       	mov    0x11cf18,%eax
  102fea:	01 d0                	add    %edx,%eax
  102fec:	89 45 b8             	mov    %eax,-0x48(%ebp)
  102fef:	81 7d b8 ff ff ff bf 	cmpl   $0xbfffffff,-0x48(%ebp)
  102ff6:	77 23                	ja     10301b <page_init+0x24f>
  102ff8:	8b 45 b8             	mov    -0x48(%ebp),%eax
  102ffb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102fff:	c7 44 24 08 e4 68 10 	movl   $0x1068e4,0x8(%esp)
  103006:	00 
  103007:	c7 44 24 04 dc 00 00 	movl   $0xdc,0x4(%esp)
  10300e:	00 
  10300f:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103016:	e8 1a d4 ff ff       	call   100435 <__panic>
  10301b:	8b 45 b8             	mov    -0x48(%ebp),%eax
  10301e:	05 00 00 00 40       	add    $0x40000000,%eax
  103023:	89 45 b4             	mov    %eax,-0x4c(%ebp)

    for (i = 0; i < memmap->nr_map; i ++) {
  103026:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  10302d:	e9 4b 01 00 00       	jmp    10317d <page_init+0x3b1>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
  103032:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  103035:	8b 55 dc             	mov    -0x24(%ebp),%edx
  103038:	89 d0                	mov    %edx,%eax
  10303a:	c1 e0 02             	shl    $0x2,%eax
  10303d:	01 d0                	add    %edx,%eax
  10303f:	c1 e0 02             	shl    $0x2,%eax
  103042:	01 c8                	add    %ecx,%eax
  103044:	8b 50 08             	mov    0x8(%eax),%edx
  103047:	8b 40 04             	mov    0x4(%eax),%eax
  10304a:	89 45 d0             	mov    %eax,-0x30(%ebp)
  10304d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  103050:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  103053:	8b 55 dc             	mov    -0x24(%ebp),%edx
  103056:	89 d0                	mov    %edx,%eax
  103058:	c1 e0 02             	shl    $0x2,%eax
  10305b:	01 d0                	add    %edx,%eax
  10305d:	c1 e0 02             	shl    $0x2,%eax
  103060:	01 c8                	add    %ecx,%eax
  103062:	8b 48 0c             	mov    0xc(%eax),%ecx
  103065:	8b 58 10             	mov    0x10(%eax),%ebx
  103068:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10306b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10306e:	01 c8                	add    %ecx,%eax
  103070:	11 da                	adc    %ebx,%edx
  103072:	89 45 c8             	mov    %eax,-0x38(%ebp)
  103075:	89 55 cc             	mov    %edx,-0x34(%ebp)
        if (memmap->map[i].type == E820_ARM) {
  103078:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
  10307b:	8b 55 dc             	mov    -0x24(%ebp),%edx
  10307e:	89 d0                	mov    %edx,%eax
  103080:	c1 e0 02             	shl    $0x2,%eax
  103083:	01 d0                	add    %edx,%eax
  103085:	c1 e0 02             	shl    $0x2,%eax
  103088:	01 c8                	add    %ecx,%eax
  10308a:	83 c0 14             	add    $0x14,%eax
  10308d:	8b 00                	mov    (%eax),%eax
  10308f:	83 f8 01             	cmp    $0x1,%eax
  103092:	0f 85 e2 00 00 00    	jne    10317a <page_init+0x3ae>
            if (begin < freemem) {
  103098:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  10309b:	ba 00 00 00 00       	mov    $0x0,%edx
  1030a0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  1030a3:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  1030a6:	19 d1                	sbb    %edx,%ecx
  1030a8:	73 0d                	jae    1030b7 <page_init+0x2eb>
                begin = freemem;
  1030aa:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  1030ad:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1030b0:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
            }
            if (end > KMEMSIZE) {
  1030b7:	ba 00 00 00 38       	mov    $0x38000000,%edx
  1030bc:	b8 00 00 00 00       	mov    $0x0,%eax
  1030c1:	3b 55 c8             	cmp    -0x38(%ebp),%edx
  1030c4:	1b 45 cc             	sbb    -0x34(%ebp),%eax
  1030c7:	73 0e                	jae    1030d7 <page_init+0x30b>
                end = KMEMSIZE;
  1030c9:	c7 45 c8 00 00 00 38 	movl   $0x38000000,-0x38(%ebp)
  1030d0:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
            }
            if (begin < end) {
  1030d7:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1030da:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1030dd:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  1030e0:	89 d0                	mov    %edx,%eax
  1030e2:	1b 45 cc             	sbb    -0x34(%ebp),%eax
  1030e5:	0f 83 8f 00 00 00    	jae    10317a <page_init+0x3ae>
                begin = ROUNDUP(begin, PGSIZE);
  1030eb:	c7 45 b0 00 10 00 00 	movl   $0x1000,-0x50(%ebp)
  1030f2:	8b 55 d0             	mov    -0x30(%ebp),%edx
  1030f5:	8b 45 b0             	mov    -0x50(%ebp),%eax
  1030f8:	01 d0                	add    %edx,%eax
  1030fa:	48                   	dec    %eax
  1030fb:	89 45 ac             	mov    %eax,-0x54(%ebp)
  1030fe:	8b 45 ac             	mov    -0x54(%ebp),%eax
  103101:	ba 00 00 00 00       	mov    $0x0,%edx
  103106:	f7 75 b0             	divl   -0x50(%ebp)
  103109:	8b 45 ac             	mov    -0x54(%ebp),%eax
  10310c:	29 d0                	sub    %edx,%eax
  10310e:	ba 00 00 00 00       	mov    $0x0,%edx
  103113:	89 45 d0             	mov    %eax,-0x30(%ebp)
  103116:	89 55 d4             	mov    %edx,-0x2c(%ebp)
                end = ROUNDDOWN(end, PGSIZE);
  103119:	8b 45 c8             	mov    -0x38(%ebp),%eax
  10311c:	89 45 a8             	mov    %eax,-0x58(%ebp)
  10311f:	8b 45 a8             	mov    -0x58(%ebp),%eax
  103122:	ba 00 00 00 00       	mov    $0x0,%edx
  103127:	89 c3                	mov    %eax,%ebx
  103129:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  10312f:	89 de                	mov    %ebx,%esi
  103131:	89 d0                	mov    %edx,%eax
  103133:	83 e0 00             	and    $0x0,%eax
  103136:	89 c7                	mov    %eax,%edi
  103138:	89 75 c8             	mov    %esi,-0x38(%ebp)
  10313b:	89 7d cc             	mov    %edi,-0x34(%ebp)
                if (begin < end) {
  10313e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  103141:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103144:	3b 45 c8             	cmp    -0x38(%ebp),%eax
  103147:	89 d0                	mov    %edx,%eax
  103149:	1b 45 cc             	sbb    -0x34(%ebp),%eax
  10314c:	73 2c                	jae    10317a <page_init+0x3ae>
                    init_memmap(pa2page(begin), (end - begin) / PGSIZE);
  10314e:	8b 45 c8             	mov    -0x38(%ebp),%eax
  103151:	8b 55 cc             	mov    -0x34(%ebp),%edx
  103154:	2b 45 d0             	sub    -0x30(%ebp),%eax
  103157:	1b 55 d4             	sbb    -0x2c(%ebp),%edx
  10315a:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
  10315e:	c1 ea 0c             	shr    $0xc,%edx
  103161:	89 c3                	mov    %eax,%ebx
  103163:	8b 45 d0             	mov    -0x30(%ebp),%eax
  103166:	89 04 24             	mov    %eax,(%esp)
  103169:	e8 ad f8 ff ff       	call   102a1b <pa2page>
  10316e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  103172:	89 04 24             	mov    %eax,(%esp)
  103175:	e8 8c fb ff ff       	call   102d06 <init_memmap>
    for (i = 0; i < memmap->nr_map; i ++) {
  10317a:	ff 45 dc             	incl   -0x24(%ebp)
  10317d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  103180:	8b 00                	mov    (%eax),%eax
  103182:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  103185:	0f 8c a7 fe ff ff    	jl     103032 <page_init+0x266>
                }
            }
        }
    }
}
  10318b:	90                   	nop
  10318c:	90                   	nop
  10318d:	81 c4 9c 00 00 00    	add    $0x9c,%esp
  103193:	5b                   	pop    %ebx
  103194:	5e                   	pop    %esi
  103195:	5f                   	pop    %edi
  103196:	5d                   	pop    %ebp
  103197:	c3                   	ret    

00103198 <boot_map_segment>:
//  la:   linear address of this memory need to map (after x86 segment map)
//  size: memory size
//  pa:   physical address of this memory
//  perm: permission of this memory  
static void
boot_map_segment(pde_t *pgdir, uintptr_t la, size_t size, uintptr_t pa, uint32_t perm) {
  103198:	f3 0f 1e fb          	endbr32 
  10319c:	55                   	push   %ebp
  10319d:	89 e5                	mov    %esp,%ebp
  10319f:	83 ec 38             	sub    $0x38,%esp
    assert(PGOFF(la) == PGOFF(pa));
  1031a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031a5:	33 45 14             	xor    0x14(%ebp),%eax
  1031a8:	25 ff 0f 00 00       	and    $0xfff,%eax
  1031ad:	85 c0                	test   %eax,%eax
  1031af:	74 24                	je     1031d5 <boot_map_segment+0x3d>
  1031b1:	c7 44 24 0c 16 69 10 	movl   $0x106916,0xc(%esp)
  1031b8:	00 
  1031b9:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  1031c0:	00 
  1031c1:	c7 44 24 04 fa 00 00 	movl   $0xfa,0x4(%esp)
  1031c8:	00 
  1031c9:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  1031d0:	e8 60 d2 ff ff       	call   100435 <__panic>
    size_t n = ROUNDUP(size + PGOFF(la), PGSIZE) / PGSIZE;
  1031d5:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
  1031dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031df:	25 ff 0f 00 00       	and    $0xfff,%eax
  1031e4:	89 c2                	mov    %eax,%edx
  1031e6:	8b 45 10             	mov    0x10(%ebp),%eax
  1031e9:	01 c2                	add    %eax,%edx
  1031eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031ee:	01 d0                	add    %edx,%eax
  1031f0:	48                   	dec    %eax
  1031f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1031f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1031f7:	ba 00 00 00 00       	mov    $0x0,%edx
  1031fc:	f7 75 f0             	divl   -0x10(%ebp)
  1031ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103202:	29 d0                	sub    %edx,%eax
  103204:	c1 e8 0c             	shr    $0xc,%eax
  103207:	89 45 f4             	mov    %eax,-0xc(%ebp)
    la = ROUNDDOWN(la, PGSIZE);
  10320a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10320d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103210:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103213:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  103218:	89 45 0c             	mov    %eax,0xc(%ebp)
    pa = ROUNDDOWN(pa, PGSIZE);
  10321b:	8b 45 14             	mov    0x14(%ebp),%eax
  10321e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103221:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103224:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  103229:	89 45 14             	mov    %eax,0x14(%ebp)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
  10322c:	eb 68                	jmp    103296 <boot_map_segment+0xfe>
        pte_t *ptep = get_pte(pgdir, la, 1);
  10322e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  103235:	00 
  103236:	8b 45 0c             	mov    0xc(%ebp),%eax
  103239:	89 44 24 04          	mov    %eax,0x4(%esp)
  10323d:	8b 45 08             	mov    0x8(%ebp),%eax
  103240:	89 04 24             	mov    %eax,(%esp)
  103243:	e8 8a 01 00 00       	call   1033d2 <get_pte>
  103248:	89 45 e0             	mov    %eax,-0x20(%ebp)
        assert(ptep != NULL);
  10324b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  10324f:	75 24                	jne    103275 <boot_map_segment+0xdd>
  103251:	c7 44 24 0c 42 69 10 	movl   $0x106942,0xc(%esp)
  103258:	00 
  103259:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103260:	00 
  103261:	c7 44 24 04 00 01 00 	movl   $0x100,0x4(%esp)
  103268:	00 
  103269:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103270:	e8 c0 d1 ff ff       	call   100435 <__panic>
        *ptep = pa | PTE_P | perm;
  103275:	8b 45 14             	mov    0x14(%ebp),%eax
  103278:	0b 45 18             	or     0x18(%ebp),%eax
  10327b:	83 c8 01             	or     $0x1,%eax
  10327e:	89 c2                	mov    %eax,%edx
  103280:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103283:	89 10                	mov    %edx,(%eax)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
  103285:	ff 4d f4             	decl   -0xc(%ebp)
  103288:	81 45 0c 00 10 00 00 	addl   $0x1000,0xc(%ebp)
  10328f:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  103296:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10329a:	75 92                	jne    10322e <boot_map_segment+0x96>
    }
}
  10329c:	90                   	nop
  10329d:	90                   	nop
  10329e:	c9                   	leave  
  10329f:	c3                   	ret    

001032a0 <boot_alloc_page>:

//boot_alloc_page - allocate one page using pmm->alloc_pages(1) 
// return value: the kernel virtual address of this allocated page
//note: this function is used to get the memory for PDT(Page Directory Table)&PT(Page Table)
static void *
boot_alloc_page(void) {
  1032a0:	f3 0f 1e fb          	endbr32 
  1032a4:	55                   	push   %ebp
  1032a5:	89 e5                	mov    %esp,%ebp
  1032a7:	83 ec 28             	sub    $0x28,%esp
    struct Page *p = alloc_page();
  1032aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1032b1:	e8 74 fa ff ff       	call   102d2a <alloc_pages>
  1032b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == NULL) {
  1032b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1032bd:	75 1c                	jne    1032db <boot_alloc_page+0x3b>
        panic("boot_alloc_page failed.\n");
  1032bf:	c7 44 24 08 4f 69 10 	movl   $0x10694f,0x8(%esp)
  1032c6:	00 
  1032c7:	c7 44 24 04 0c 01 00 	movl   $0x10c,0x4(%esp)
  1032ce:	00 
  1032cf:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  1032d6:	e8 5a d1 ff ff       	call   100435 <__panic>
    }
    return page2kva(p);
  1032db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1032de:	89 04 24             	mov    %eax,(%esp)
  1032e1:	e8 84 f7 ff ff       	call   102a6a <page2kva>
}
  1032e6:	c9                   	leave  
  1032e7:	c3                   	ret    

001032e8 <pmm_init>:

//pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup paging mechanism 
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void
pmm_init(void) {
  1032e8:	f3 0f 1e fb          	endbr32 
  1032ec:	55                   	push   %ebp
  1032ed:	89 e5                	mov    %esp,%ebp
  1032ef:	83 ec 38             	sub    $0x38,%esp
    // We've already enabled paging
    boot_cr3 = PADDR(boot_pgdir);
  1032f2:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  1032f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1032fa:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
  103301:	77 23                	ja     103326 <pmm_init+0x3e>
  103303:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103306:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10330a:	c7 44 24 08 e4 68 10 	movl   $0x1068e4,0x8(%esp)
  103311:	00 
  103312:	c7 44 24 04 16 01 00 	movl   $0x116,0x4(%esp)
  103319:	00 
  10331a:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103321:	e8 0f d1 ff ff       	call   100435 <__panic>
  103326:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103329:	05 00 00 00 40       	add    $0x40000000,%eax
  10332e:	a3 14 cf 11 00       	mov    %eax,0x11cf14
    //We need to alloc/free the physical memory (granularity is 4KB or other size). 
    //So a framework of physical memory manager (struct pmm_manager)is defined in pmm.h
    //First we should init a physical memory manager(pmm) based on the framework.
    //Then pmm can alloc/free the physical memory. 
    //Now the first_fit/best_fit/worst_fit/buddy_system pmm are available.
    init_pmm_manager();
  103333:	e8 96 f9 ff ff       	call   102cce <init_pmm_manager>

    // detect physical memory space, reserve already used memory,
    // then use pmm->init_memmap to create free page list
    page_init();
  103338:	e8 8f fa ff ff       	call   102dcc <page_init>

    //use pmm->check to verify the correctness of the alloc/free function in a pmm
    check_alloc_page();
  10333d:	e8 f3 03 00 00       	call   103735 <check_alloc_page>

    check_pgdir();
  103342:	e8 11 04 00 00       	call   103758 <check_pgdir>

    static_assert(KERNBASE % PTSIZE == 0 && KERNTOP % PTSIZE == 0);

    // recursively insert boot_pgdir in itself
    // to form a virtual page table at virtual address VPT
    boot_pgdir[PDX(VPT)] = PADDR(boot_pgdir) | PTE_P | PTE_W;
  103347:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  10334c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10334f:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
  103356:	77 23                	ja     10337b <pmm_init+0x93>
  103358:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10335b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10335f:	c7 44 24 08 e4 68 10 	movl   $0x1068e4,0x8(%esp)
  103366:	00 
  103367:	c7 44 24 04 2c 01 00 	movl   $0x12c,0x4(%esp)
  10336e:	00 
  10336f:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103376:	e8 ba d0 ff ff       	call   100435 <__panic>
  10337b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10337e:	8d 90 00 00 00 40    	lea    0x40000000(%eax),%edx
  103384:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103389:	05 ac 0f 00 00       	add    $0xfac,%eax
  10338e:	83 ca 03             	or     $0x3,%edx
  103391:	89 10                	mov    %edx,(%eax)

    // map all physical memory to linear memory with base linear addr KERNBASE
    // linear_addr KERNBASE ~ KERNBASE + KMEMSIZE = phy_addr 0 ~ KMEMSIZE
    boot_map_segment(boot_pgdir, KERNBASE, KMEMSIZE, 0, PTE_W);
  103393:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103398:	c7 44 24 10 02 00 00 	movl   $0x2,0x10(%esp)
  10339f:	00 
  1033a0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  1033a7:	00 
  1033a8:	c7 44 24 08 00 00 00 	movl   $0x38000000,0x8(%esp)
  1033af:	38 
  1033b0:	c7 44 24 04 00 00 00 	movl   $0xc0000000,0x4(%esp)
  1033b7:	c0 
  1033b8:	89 04 24             	mov    %eax,(%esp)
  1033bb:	e8 d8 fd ff ff       	call   103198 <boot_map_segment>

    // Since we are using bootloader's GDT,
    // we should reload gdt (second time, the last time) to get user segments and the TSS
    // map virtual_addr 0 ~ 4G = linear_addr 0 ~ 4G
    // then set kernel stack (ss:esp) in TSS, setup TSS in gdt, load TSS
    gdt_init();
  1033c0:	e8 1b f8 ff ff       	call   102be0 <gdt_init>

    //now the basic virtual memory map(see memalyout.h) is established.
    //check the correctness of the basic virtual memory map.
    check_boot_pgdir();
  1033c5:	e8 2e 0a 00 00       	call   103df8 <check_boot_pgdir>

    print_pgdir();
  1033ca:	e8 b3 0e 00 00       	call   104282 <print_pgdir>

}
  1033cf:	90                   	nop
  1033d0:	c9                   	leave  
  1033d1:	c3                   	ret    

001033d2 <get_pte>:
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
//此函数找到一个虚地址对应的二级页表项的内核虚地址，如果此二级页表项不存在，则分配一个包含此项的二级页表。
pte_t *
get_pte(pde_t *pgdir, uintptr_t la, bool create) {
  1033d2:	f3 0f 1e fb          	endbr32 
  1033d6:	55                   	push   %ebp
  1033d7:	89 e5                	mov    %esp,%ebp
  1033d9:	83 ec 38             	sub    $0x38,%esp

PTE_U 0x004 表示可以读取对应地址的物理内存页内容
*/

//#if 0
    pde_t *pdep = &pgdir[PDX(la)];   // (1) find page directory entry
  1033dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033df:	c1 e8 16             	shr    $0x16,%eax
  1033e2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  1033e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1033ec:	01 d0                	add    %edx,%eax
  1033ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(!(*pdep & PTE_P)){
  1033f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1033f4:	8b 00                	mov    (%eax),%eax
  1033f6:	83 e0 01             	and    $0x1,%eax
  1033f9:	85 c0                	test   %eax,%eax
  1033fb:	0f 85 af 00 00 00    	jne    1034b0 <get_pte+0xde>
        struct Page *page;
		if (!create || (page = alloc_page()) == NULL) {
  103401:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103405:	74 15                	je     10341c <get_pte+0x4a>
  103407:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10340e:	e8 17 f9 ff ff       	call   102d2a <alloc_pages>
  103413:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103416:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10341a:	75 0a                	jne    103426 <get_pte+0x54>
		// (2) check if entry is not present
        // (3) check if creating is needed, then alloc page for page table
			return NULL;  // CAUTION: this page is used for page table, not for common data page
  10341c:	b8 00 00 00 00       	mov    $0x0,%eax
  103421:	e9 e7 00 00 00       	jmp    10350d <get_pte+0x13b>
		}
        set_page_ref(page, 1);  // (4) set page reference
  103426:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10342d:	00 
  10342e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103431:	89 04 24             	mov    %eax,(%esp)
  103434:	e8 e5 f6 ff ff       	call   102b1e <set_page_ref>
        uintptr_t pa = page2pa(page); // (5) get linear address of page
  103439:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10343c:	89 04 24             	mov    %eax,(%esp)
  10343f:	e8 c1 f5 ff ff       	call   102a05 <page2pa>
  103444:	89 45 ec             	mov    %eax,-0x14(%ebp)
        memset(KADDR(pa), 0, PGSIZE); // (6) clear page content using memset
  103447:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10344a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10344d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103450:	c1 e8 0c             	shr    $0xc,%eax
  103453:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103456:	a1 80 ce 11 00       	mov    0x11ce80,%eax
  10345b:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
  10345e:	72 23                	jb     103483 <get_pte+0xb1>
  103460:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103463:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103467:	c7 44 24 08 40 68 10 	movl   $0x106840,0x8(%esp)
  10346e:	00 
  10346f:	c7 44 24 04 7f 01 00 	movl   $0x17f,0x4(%esp)
  103476:	00 
  103477:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  10347e:	e8 b2 cf ff ff       	call   100435 <__panic>
  103483:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103486:	2d 00 00 00 40       	sub    $0x40000000,%eax
  10348b:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  103492:	00 
  103493:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10349a:	00 
  10349b:	89 04 24             	mov    %eax,(%esp)
  10349e:	e8 1e 24 00 00       	call   1058c1 <memset>
        *pdep = pa | PTE_U | PTE_W | PTE_P; // (7) set page directory entry's permission
  1034a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1034a6:	83 c8 07             	or     $0x7,%eax
  1034a9:	89 c2                	mov    %eax,%edx
  1034ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1034ae:	89 10                	mov    %edx,(%eax)
    }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep)))[PTX(la)]; // (8) return page table entry
  1034b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1034b3:	8b 00                	mov    (%eax),%eax
  1034b5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  1034ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1034bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034c0:	c1 e8 0c             	shr    $0xc,%eax
  1034c3:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1034c6:	a1 80 ce 11 00       	mov    0x11ce80,%eax
  1034cb:	39 45 dc             	cmp    %eax,-0x24(%ebp)
  1034ce:	72 23                	jb     1034f3 <get_pte+0x121>
  1034d0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034d3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1034d7:	c7 44 24 08 40 68 10 	movl   $0x106840,0x8(%esp)
  1034de:	00 
  1034df:	c7 44 24 04 82 01 00 	movl   $0x182,0x4(%esp)
  1034e6:	00 
  1034e7:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  1034ee:	e8 42 cf ff ff       	call   100435 <__panic>
  1034f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034f6:	2d 00 00 00 40       	sub    $0x40000000,%eax
  1034fb:	89 c2                	mov    %eax,%edx
  1034fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  103500:	c1 e8 0c             	shr    $0xc,%eax
  103503:	25 ff 03 00 00       	and    $0x3ff,%eax
  103508:	c1 e0 02             	shl    $0x2,%eax
  10350b:	01 d0                	add    %edx,%eax
//#endif
    
    
        
    
}
  10350d:	c9                   	leave  
  10350e:	c3                   	ret    

0010350f <get_page>:

//get_page - get related Page struct for linear address la using PDT pgdir
struct Page *
get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store) {
  10350f:	f3 0f 1e fb          	endbr32 
  103513:	55                   	push   %ebp
  103514:	89 e5                	mov    %esp,%ebp
  103516:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
  103519:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  103520:	00 
  103521:	8b 45 0c             	mov    0xc(%ebp),%eax
  103524:	89 44 24 04          	mov    %eax,0x4(%esp)
  103528:	8b 45 08             	mov    0x8(%ebp),%eax
  10352b:	89 04 24             	mov    %eax,(%esp)
  10352e:	e8 9f fe ff ff       	call   1033d2 <get_pte>
  103533:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep_store != NULL) {
  103536:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10353a:	74 08                	je     103544 <get_page+0x35>
        *ptep_store = ptep;
  10353c:	8b 45 10             	mov    0x10(%ebp),%eax
  10353f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103542:	89 10                	mov    %edx,(%eax)
    }
    if (ptep != NULL && *ptep & PTE_P) {
  103544:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103548:	74 1b                	je     103565 <get_page+0x56>
  10354a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10354d:	8b 00                	mov    (%eax),%eax
  10354f:	83 e0 01             	and    $0x1,%eax
  103552:	85 c0                	test   %eax,%eax
  103554:	74 0f                	je     103565 <get_page+0x56>
        return pte2page(*ptep);
  103556:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103559:	8b 00                	mov    (%eax),%eax
  10355b:	89 04 24             	mov    %eax,(%esp)
  10355e:	e8 5b f5 ff ff       	call   102abe <pte2page>
  103563:	eb 05                	jmp    10356a <get_page+0x5b>
    }
    return NULL;
  103565:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10356a:	c9                   	leave  
  10356b:	c3                   	ret    

0010356c <page_remove_pte>:

//page_remove_pte - free an Page sturct which is related linear address la
//                - and clean(invalidate) pte which is related linear address la
//note: PT is changed, so the TLB need to be invalidate 
static inline void
page_remove_pte(pde_t *pgdir, uintptr_t la, pte_t *ptep) {
  10356c:	55                   	push   %ebp
  10356d:	89 e5                	mov    %esp,%ebp
  10356f:	83 ec 28             	sub    $0x28,%esp
     *                        edited are the ones currently in use by the processor.
     * DEFINEs:
     *   PTE_P           0x001                   // page table/directory entry flags bit : Present
     */
//#if 0
    if (*ptep & PTE_P) {                      //(1) check if this page table entry is present
  103572:	8b 45 10             	mov    0x10(%ebp),%eax
  103575:	8b 00                	mov    (%eax),%eax
  103577:	83 e0 01             	and    $0x1,%eax
  10357a:	85 c0                	test   %eax,%eax
  10357c:	74 4d                	je     1035cb <page_remove_pte+0x5f>
        struct Page *page = pte2page(*ptep); //(2) find corresponding page to pte
  10357e:	8b 45 10             	mov    0x10(%ebp),%eax
  103581:	8b 00                	mov    (%eax),%eax
  103583:	89 04 24             	mov    %eax,(%esp)
  103586:	e8 33 f5 ff ff       	call   102abe <pte2page>
  10358b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (page_ref_dec(page) == 0) { //(3) decrease page reference
  10358e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103591:	89 04 24             	mov    %eax,(%esp)
  103594:	e8 aa f5 ff ff       	call   102b43 <page_ref_dec>
  103599:	85 c0                	test   %eax,%eax
  10359b:	75 13                	jne    1035b0 <page_remove_pte+0x44>
            free_page(page); ////(4) and free this page when page reference reachs 0
  10359d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1035a4:	00 
  1035a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1035a8:	89 04 24             	mov    %eax,(%esp)
  1035ab:	e8 b6 f7 ff ff       	call   102d66 <free_pages>
		}
		*ptep = 0; //(5) clear second page table entry
  1035b0:	8b 45 10             	mov    0x10(%ebp),%eax
  1035b3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
         tlb_invalidate(pgdir, la); //(6) flush tlb
  1035b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035bc:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035c0:	8b 45 08             	mov    0x8(%ebp),%eax
  1035c3:	89 04 24             	mov    %eax,(%esp)
  1035c6:	e8 09 01 00 00       	call   1036d4 <tlb_invalidate>
    }
//#endif
}
  1035cb:	90                   	nop
  1035cc:	c9                   	leave  
  1035cd:	c3                   	ret    

001035ce <page_remove>:

//page_remove - free an Page which is related linear address la and has an validated pte
void
page_remove(pde_t *pgdir, uintptr_t la) {
  1035ce:	f3 0f 1e fb          	endbr32 
  1035d2:	55                   	push   %ebp
  1035d3:	89 e5                	mov    %esp,%ebp
  1035d5:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
  1035d8:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1035df:	00 
  1035e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035e3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035e7:	8b 45 08             	mov    0x8(%ebp),%eax
  1035ea:	89 04 24             	mov    %eax,(%esp)
  1035ed:	e8 e0 fd ff ff       	call   1033d2 <get_pte>
  1035f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep != NULL) {
  1035f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1035f9:	74 19                	je     103614 <page_remove+0x46>
        page_remove_pte(pgdir, la, ptep);
  1035fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1035fe:	89 44 24 08          	mov    %eax,0x8(%esp)
  103602:	8b 45 0c             	mov    0xc(%ebp),%eax
  103605:	89 44 24 04          	mov    %eax,0x4(%esp)
  103609:	8b 45 08             	mov    0x8(%ebp),%eax
  10360c:	89 04 24             	mov    %eax,(%esp)
  10360f:	e8 58 ff ff ff       	call   10356c <page_remove_pte>
    }
}
  103614:	90                   	nop
  103615:	c9                   	leave  
  103616:	c3                   	ret    

00103617 <page_insert>:
//  la:    the linear address need to map
//  perm:  the permission of this Page which is setted in related pte
// return value: always 0
//note: PT is changed, so the TLB need to be invalidate 
int
page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
  103617:	f3 0f 1e fb          	endbr32 
  10361b:	55                   	push   %ebp
  10361c:	89 e5                	mov    %esp,%ebp
  10361e:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep = get_pte(pgdir, la, 1);
  103621:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  103628:	00 
  103629:	8b 45 10             	mov    0x10(%ebp),%eax
  10362c:	89 44 24 04          	mov    %eax,0x4(%esp)
  103630:	8b 45 08             	mov    0x8(%ebp),%eax
  103633:	89 04 24             	mov    %eax,(%esp)
  103636:	e8 97 fd ff ff       	call   1033d2 <get_pte>
  10363b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep == NULL) {
  10363e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  103642:	75 0a                	jne    10364e <page_insert+0x37>
        return -E_NO_MEM;
  103644:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
  103649:	e9 84 00 00 00       	jmp    1036d2 <page_insert+0xbb>
    }
    page_ref_inc(page);
  10364e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103651:	89 04 24             	mov    %eax,(%esp)
  103654:	e8 d3 f4 ff ff       	call   102b2c <page_ref_inc>
    if (*ptep & PTE_P) {
  103659:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10365c:	8b 00                	mov    (%eax),%eax
  10365e:	83 e0 01             	and    $0x1,%eax
  103661:	85 c0                	test   %eax,%eax
  103663:	74 3e                	je     1036a3 <page_insert+0x8c>
        struct Page *p = pte2page(*ptep);
  103665:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103668:	8b 00                	mov    (%eax),%eax
  10366a:	89 04 24             	mov    %eax,(%esp)
  10366d:	e8 4c f4 ff ff       	call   102abe <pte2page>
  103672:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (p == page) {
  103675:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103678:	3b 45 0c             	cmp    0xc(%ebp),%eax
  10367b:	75 0d                	jne    10368a <page_insert+0x73>
            page_ref_dec(page);
  10367d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103680:	89 04 24             	mov    %eax,(%esp)
  103683:	e8 bb f4 ff ff       	call   102b43 <page_ref_dec>
  103688:	eb 19                	jmp    1036a3 <page_insert+0x8c>
        }
        else {
            page_remove_pte(pgdir, la, ptep);
  10368a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10368d:	89 44 24 08          	mov    %eax,0x8(%esp)
  103691:	8b 45 10             	mov    0x10(%ebp),%eax
  103694:	89 44 24 04          	mov    %eax,0x4(%esp)
  103698:	8b 45 08             	mov    0x8(%ebp),%eax
  10369b:	89 04 24             	mov    %eax,(%esp)
  10369e:	e8 c9 fe ff ff       	call   10356c <page_remove_pte>
        }
    }
    *ptep = page2pa(page) | PTE_P | perm;
  1036a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1036a6:	89 04 24             	mov    %eax,(%esp)
  1036a9:	e8 57 f3 ff ff       	call   102a05 <page2pa>
  1036ae:	0b 45 14             	or     0x14(%ebp),%eax
  1036b1:	83 c8 01             	or     $0x1,%eax
  1036b4:	89 c2                	mov    %eax,%edx
  1036b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1036b9:	89 10                	mov    %edx,(%eax)
    tlb_invalidate(pgdir, la);
  1036bb:	8b 45 10             	mov    0x10(%ebp),%eax
  1036be:	89 44 24 04          	mov    %eax,0x4(%esp)
  1036c2:	8b 45 08             	mov    0x8(%ebp),%eax
  1036c5:	89 04 24             	mov    %eax,(%esp)
  1036c8:	e8 07 00 00 00       	call   1036d4 <tlb_invalidate>
    return 0;
  1036cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1036d2:	c9                   	leave  
  1036d3:	c3                   	ret    

001036d4 <tlb_invalidate>:

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void
tlb_invalidate(pde_t *pgdir, uintptr_t la) {
  1036d4:	f3 0f 1e fb          	endbr32 
  1036d8:	55                   	push   %ebp
  1036d9:	89 e5                	mov    %esp,%ebp
  1036db:	83 ec 28             	sub    $0x28,%esp
}

static inline uintptr_t
rcr3(void) {
    uintptr_t cr3;
    asm volatile ("mov %%cr3, %0" : "=r" (cr3) :: "memory");
  1036de:	0f 20 d8             	mov    %cr3,%eax
  1036e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    return cr3;
  1036e4:	8b 55 f0             	mov    -0x10(%ebp),%edx
    if (rcr3() == PADDR(pgdir)) {
  1036e7:	8b 45 08             	mov    0x8(%ebp),%eax
  1036ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1036ed:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
  1036f4:	77 23                	ja     103719 <tlb_invalidate+0x45>
  1036f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1036f9:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1036fd:	c7 44 24 08 e4 68 10 	movl   $0x1068e4,0x8(%esp)
  103704:	00 
  103705:	c7 44 24 04 e2 01 00 	movl   $0x1e2,0x4(%esp)
  10370c:	00 
  10370d:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103714:	e8 1c cd ff ff       	call   100435 <__panic>
  103719:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10371c:	05 00 00 00 40       	add    $0x40000000,%eax
  103721:	39 d0                	cmp    %edx,%eax
  103723:	75 0d                	jne    103732 <tlb_invalidate+0x5e>
        invlpg((void *)la);
  103725:	8b 45 0c             	mov    0xc(%ebp),%eax
  103728:	89 45 ec             	mov    %eax,-0x14(%ebp)
}

static inline void
invlpg(void *addr) {
    asm volatile ("invlpg (%0)" :: "r" (addr) : "memory");
  10372b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10372e:	0f 01 38             	invlpg (%eax)
}
  103731:	90                   	nop
    }
}
  103732:	90                   	nop
  103733:	c9                   	leave  
  103734:	c3                   	ret    

00103735 <check_alloc_page>:

static void
check_alloc_page(void) {
  103735:	f3 0f 1e fb          	endbr32 
  103739:	55                   	push   %ebp
  10373a:	89 e5                	mov    %esp,%ebp
  10373c:	83 ec 18             	sub    $0x18,%esp
    pmm_manager->check();
  10373f:	a1 10 cf 11 00       	mov    0x11cf10,%eax
  103744:	8b 40 18             	mov    0x18(%eax),%eax
  103747:	ff d0                	call   *%eax
    cprintf("check_alloc_page() succeeded!\n");
  103749:	c7 04 24 68 69 10 00 	movl   $0x106968,(%esp)
  103750:	e8 74 cb ff ff       	call   1002c9 <cprintf>
}
  103755:	90                   	nop
  103756:	c9                   	leave  
  103757:	c3                   	ret    

00103758 <check_pgdir>:

static void
check_pgdir(void) {
  103758:	f3 0f 1e fb          	endbr32 
  10375c:	55                   	push   %ebp
  10375d:	89 e5                	mov    %esp,%ebp
  10375f:	83 ec 38             	sub    $0x38,%esp
    assert(npage <= KMEMSIZE / PGSIZE);
  103762:	a1 80 ce 11 00       	mov    0x11ce80,%eax
  103767:	3d 00 80 03 00       	cmp    $0x38000,%eax
  10376c:	76 24                	jbe    103792 <check_pgdir+0x3a>
  10376e:	c7 44 24 0c 87 69 10 	movl   $0x106987,0xc(%esp)
  103775:	00 
  103776:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  10377d:	00 
  10377e:	c7 44 24 04 ef 01 00 	movl   $0x1ef,0x4(%esp)
  103785:	00 
  103786:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  10378d:	e8 a3 cc ff ff       	call   100435 <__panic>
    assert(boot_pgdir != NULL && (uint32_t)PGOFF(boot_pgdir) == 0);
  103792:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103797:	85 c0                	test   %eax,%eax
  103799:	74 0e                	je     1037a9 <check_pgdir+0x51>
  10379b:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  1037a0:	25 ff 0f 00 00       	and    $0xfff,%eax
  1037a5:	85 c0                	test   %eax,%eax
  1037a7:	74 24                	je     1037cd <check_pgdir+0x75>
  1037a9:	c7 44 24 0c a4 69 10 	movl   $0x1069a4,0xc(%esp)
  1037b0:	00 
  1037b1:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  1037b8:	00 
  1037b9:	c7 44 24 04 f0 01 00 	movl   $0x1f0,0x4(%esp)
  1037c0:	00 
  1037c1:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  1037c8:	e8 68 cc ff ff       	call   100435 <__panic>
    assert(get_page(boot_pgdir, 0x0, NULL) == NULL);
  1037cd:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  1037d2:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  1037d9:	00 
  1037da:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  1037e1:	00 
  1037e2:	89 04 24             	mov    %eax,(%esp)
  1037e5:	e8 25 fd ff ff       	call   10350f <get_page>
  1037ea:	85 c0                	test   %eax,%eax
  1037ec:	74 24                	je     103812 <check_pgdir+0xba>
  1037ee:	c7 44 24 0c dc 69 10 	movl   $0x1069dc,0xc(%esp)
  1037f5:	00 
  1037f6:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  1037fd:	00 
  1037fe:	c7 44 24 04 f1 01 00 	movl   $0x1f1,0x4(%esp)
  103805:	00 
  103806:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  10380d:	e8 23 cc ff ff       	call   100435 <__panic>

    struct Page *p1, *p2;
    p1 = alloc_page();
  103812:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  103819:	e8 0c f5 ff ff       	call   102d2a <alloc_pages>
  10381e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    assert(page_insert(boot_pgdir, p1, 0x0, 0) == 0);
  103821:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103826:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  10382d:	00 
  10382e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  103835:	00 
  103836:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103839:	89 54 24 04          	mov    %edx,0x4(%esp)
  10383d:	89 04 24             	mov    %eax,(%esp)
  103840:	e8 d2 fd ff ff       	call   103617 <page_insert>
  103845:	85 c0                	test   %eax,%eax
  103847:	74 24                	je     10386d <check_pgdir+0x115>
  103849:	c7 44 24 0c 04 6a 10 	movl   $0x106a04,0xc(%esp)
  103850:	00 
  103851:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103858:	00 
  103859:	c7 44 24 04 f5 01 00 	movl   $0x1f5,0x4(%esp)
  103860:	00 
  103861:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103868:	e8 c8 cb ff ff       	call   100435 <__panic>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir, 0x0, 0)) != NULL);
  10386d:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103872:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  103879:	00 
  10387a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103881:	00 
  103882:	89 04 24             	mov    %eax,(%esp)
  103885:	e8 48 fb ff ff       	call   1033d2 <get_pte>
  10388a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10388d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103891:	75 24                	jne    1038b7 <check_pgdir+0x15f>
  103893:	c7 44 24 0c 30 6a 10 	movl   $0x106a30,0xc(%esp)
  10389a:	00 
  10389b:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  1038a2:	00 
  1038a3:	c7 44 24 04 f8 01 00 	movl   $0x1f8,0x4(%esp)
  1038aa:	00 
  1038ab:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  1038b2:	e8 7e cb ff ff       	call   100435 <__panic>
    assert(pte2page(*ptep) == p1);
  1038b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1038ba:	8b 00                	mov    (%eax),%eax
  1038bc:	89 04 24             	mov    %eax,(%esp)
  1038bf:	e8 fa f1 ff ff       	call   102abe <pte2page>
  1038c4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  1038c7:	74 24                	je     1038ed <check_pgdir+0x195>
  1038c9:	c7 44 24 0c 5d 6a 10 	movl   $0x106a5d,0xc(%esp)
  1038d0:	00 
  1038d1:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  1038d8:	00 
  1038d9:	c7 44 24 04 f9 01 00 	movl   $0x1f9,0x4(%esp)
  1038e0:	00 
  1038e1:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  1038e8:	e8 48 cb ff ff       	call   100435 <__panic>
    assert(page_ref(p1) == 1);
  1038ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1038f0:	89 04 24             	mov    %eax,(%esp)
  1038f3:	e8 1c f2 ff ff       	call   102b14 <page_ref>
  1038f8:	83 f8 01             	cmp    $0x1,%eax
  1038fb:	74 24                	je     103921 <check_pgdir+0x1c9>
  1038fd:	c7 44 24 0c 73 6a 10 	movl   $0x106a73,0xc(%esp)
  103904:	00 
  103905:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  10390c:	00 
  10390d:	c7 44 24 04 fa 01 00 	movl   $0x1fa,0x4(%esp)
  103914:	00 
  103915:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  10391c:	e8 14 cb ff ff       	call   100435 <__panic>

    ptep = &((pte_t *)KADDR(PDE_ADDR(boot_pgdir[0])))[1];
  103921:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103926:	8b 00                	mov    (%eax),%eax
  103928:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  10392d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103930:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103933:	c1 e8 0c             	shr    $0xc,%eax
  103936:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103939:	a1 80 ce 11 00       	mov    0x11ce80,%eax
  10393e:	39 45 e8             	cmp    %eax,-0x18(%ebp)
  103941:	72 23                	jb     103966 <check_pgdir+0x20e>
  103943:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103946:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10394a:	c7 44 24 08 40 68 10 	movl   $0x106840,0x8(%esp)
  103951:	00 
  103952:	c7 44 24 04 fc 01 00 	movl   $0x1fc,0x4(%esp)
  103959:	00 
  10395a:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103961:	e8 cf ca ff ff       	call   100435 <__panic>
  103966:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103969:	2d 00 00 00 40       	sub    $0x40000000,%eax
  10396e:	83 c0 04             	add    $0x4,%eax
  103971:	89 45 f0             	mov    %eax,-0x10(%ebp)
    assert(get_pte(boot_pgdir, PGSIZE, 0) == ptep);
  103974:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103979:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  103980:	00 
  103981:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  103988:	00 
  103989:	89 04 24             	mov    %eax,(%esp)
  10398c:	e8 41 fa ff ff       	call   1033d2 <get_pte>
  103991:	39 45 f0             	cmp    %eax,-0x10(%ebp)
  103994:	74 24                	je     1039ba <check_pgdir+0x262>
  103996:	c7 44 24 0c 88 6a 10 	movl   $0x106a88,0xc(%esp)
  10399d:	00 
  10399e:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  1039a5:	00 
  1039a6:	c7 44 24 04 fd 01 00 	movl   $0x1fd,0x4(%esp)
  1039ad:	00 
  1039ae:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  1039b5:	e8 7b ca ff ff       	call   100435 <__panic>

    p2 = alloc_page();
  1039ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1039c1:	e8 64 f3 ff ff       	call   102d2a <alloc_pages>
  1039c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    assert(page_insert(boot_pgdir, p2, PGSIZE, PTE_U | PTE_W) == 0);
  1039c9:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  1039ce:	c7 44 24 0c 06 00 00 	movl   $0x6,0xc(%esp)
  1039d5:	00 
  1039d6:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  1039dd:	00 
  1039de:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1039e1:	89 54 24 04          	mov    %edx,0x4(%esp)
  1039e5:	89 04 24             	mov    %eax,(%esp)
  1039e8:	e8 2a fc ff ff       	call   103617 <page_insert>
  1039ed:	85 c0                	test   %eax,%eax
  1039ef:	74 24                	je     103a15 <check_pgdir+0x2bd>
  1039f1:	c7 44 24 0c b0 6a 10 	movl   $0x106ab0,0xc(%esp)
  1039f8:	00 
  1039f9:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103a00:	00 
  103a01:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
  103a08:	00 
  103a09:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103a10:	e8 20 ca ff ff       	call   100435 <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
  103a15:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103a1a:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  103a21:	00 
  103a22:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  103a29:	00 
  103a2a:	89 04 24             	mov    %eax,(%esp)
  103a2d:	e8 a0 f9 ff ff       	call   1033d2 <get_pte>
  103a32:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103a35:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103a39:	75 24                	jne    103a5f <check_pgdir+0x307>
  103a3b:	c7 44 24 0c e8 6a 10 	movl   $0x106ae8,0xc(%esp)
  103a42:	00 
  103a43:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103a4a:	00 
  103a4b:	c7 44 24 04 01 02 00 	movl   $0x201,0x4(%esp)
  103a52:	00 
  103a53:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103a5a:	e8 d6 c9 ff ff       	call   100435 <__panic>
    assert(*ptep & PTE_U);
  103a5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103a62:	8b 00                	mov    (%eax),%eax
  103a64:	83 e0 04             	and    $0x4,%eax
  103a67:	85 c0                	test   %eax,%eax
  103a69:	75 24                	jne    103a8f <check_pgdir+0x337>
  103a6b:	c7 44 24 0c 18 6b 10 	movl   $0x106b18,0xc(%esp)
  103a72:	00 
  103a73:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103a7a:	00 
  103a7b:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  103a82:	00 
  103a83:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103a8a:	e8 a6 c9 ff ff       	call   100435 <__panic>
    assert(*ptep & PTE_W);
  103a8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103a92:	8b 00                	mov    (%eax),%eax
  103a94:	83 e0 02             	and    $0x2,%eax
  103a97:	85 c0                	test   %eax,%eax
  103a99:	75 24                	jne    103abf <check_pgdir+0x367>
  103a9b:	c7 44 24 0c 26 6b 10 	movl   $0x106b26,0xc(%esp)
  103aa2:	00 
  103aa3:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103aaa:	00 
  103aab:	c7 44 24 04 03 02 00 	movl   $0x203,0x4(%esp)
  103ab2:	00 
  103ab3:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103aba:	e8 76 c9 ff ff       	call   100435 <__panic>
    assert(boot_pgdir[0] & PTE_U);
  103abf:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103ac4:	8b 00                	mov    (%eax),%eax
  103ac6:	83 e0 04             	and    $0x4,%eax
  103ac9:	85 c0                	test   %eax,%eax
  103acb:	75 24                	jne    103af1 <check_pgdir+0x399>
  103acd:	c7 44 24 0c 34 6b 10 	movl   $0x106b34,0xc(%esp)
  103ad4:	00 
  103ad5:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103adc:	00 
  103add:	c7 44 24 04 04 02 00 	movl   $0x204,0x4(%esp)
  103ae4:	00 
  103ae5:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103aec:	e8 44 c9 ff ff       	call   100435 <__panic>
    assert(page_ref(p2) == 1);
  103af1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103af4:	89 04 24             	mov    %eax,(%esp)
  103af7:	e8 18 f0 ff ff       	call   102b14 <page_ref>
  103afc:	83 f8 01             	cmp    $0x1,%eax
  103aff:	74 24                	je     103b25 <check_pgdir+0x3cd>
  103b01:	c7 44 24 0c 4a 6b 10 	movl   $0x106b4a,0xc(%esp)
  103b08:	00 
  103b09:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103b10:	00 
  103b11:	c7 44 24 04 05 02 00 	movl   $0x205,0x4(%esp)
  103b18:	00 
  103b19:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103b20:	e8 10 c9 ff ff       	call   100435 <__panic>

    assert(page_insert(boot_pgdir, p1, PGSIZE, 0) == 0);
  103b25:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103b2a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
  103b31:	00 
  103b32:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
  103b39:	00 
  103b3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103b3d:	89 54 24 04          	mov    %edx,0x4(%esp)
  103b41:	89 04 24             	mov    %eax,(%esp)
  103b44:	e8 ce fa ff ff       	call   103617 <page_insert>
  103b49:	85 c0                	test   %eax,%eax
  103b4b:	74 24                	je     103b71 <check_pgdir+0x419>
  103b4d:	c7 44 24 0c 5c 6b 10 	movl   $0x106b5c,0xc(%esp)
  103b54:	00 
  103b55:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103b5c:	00 
  103b5d:	c7 44 24 04 07 02 00 	movl   $0x207,0x4(%esp)
  103b64:	00 
  103b65:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103b6c:	e8 c4 c8 ff ff       	call   100435 <__panic>
    assert(page_ref(p1) == 2);
  103b71:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103b74:	89 04 24             	mov    %eax,(%esp)
  103b77:	e8 98 ef ff ff       	call   102b14 <page_ref>
  103b7c:	83 f8 02             	cmp    $0x2,%eax
  103b7f:	74 24                	je     103ba5 <check_pgdir+0x44d>
  103b81:	c7 44 24 0c 88 6b 10 	movl   $0x106b88,0xc(%esp)
  103b88:	00 
  103b89:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103b90:	00 
  103b91:	c7 44 24 04 08 02 00 	movl   $0x208,0x4(%esp)
  103b98:	00 
  103b99:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103ba0:	e8 90 c8 ff ff       	call   100435 <__panic>
    assert(page_ref(p2) == 0);
  103ba5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103ba8:	89 04 24             	mov    %eax,(%esp)
  103bab:	e8 64 ef ff ff       	call   102b14 <page_ref>
  103bb0:	85 c0                	test   %eax,%eax
  103bb2:	74 24                	je     103bd8 <check_pgdir+0x480>
  103bb4:	c7 44 24 0c 9a 6b 10 	movl   $0x106b9a,0xc(%esp)
  103bbb:	00 
  103bbc:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103bc3:	00 
  103bc4:	c7 44 24 04 09 02 00 	movl   $0x209,0x4(%esp)
  103bcb:	00 
  103bcc:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103bd3:	e8 5d c8 ff ff       	call   100435 <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
  103bd8:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103bdd:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  103be4:	00 
  103be5:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  103bec:	00 
  103bed:	89 04 24             	mov    %eax,(%esp)
  103bf0:	e8 dd f7 ff ff       	call   1033d2 <get_pte>
  103bf5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103bf8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103bfc:	75 24                	jne    103c22 <check_pgdir+0x4ca>
  103bfe:	c7 44 24 0c e8 6a 10 	movl   $0x106ae8,0xc(%esp)
  103c05:	00 
  103c06:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103c0d:	00 
  103c0e:	c7 44 24 04 0a 02 00 	movl   $0x20a,0x4(%esp)
  103c15:	00 
  103c16:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103c1d:	e8 13 c8 ff ff       	call   100435 <__panic>
    assert(pte2page(*ptep) == p1);
  103c22:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103c25:	8b 00                	mov    (%eax),%eax
  103c27:	89 04 24             	mov    %eax,(%esp)
  103c2a:	e8 8f ee ff ff       	call   102abe <pte2page>
  103c2f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  103c32:	74 24                	je     103c58 <check_pgdir+0x500>
  103c34:	c7 44 24 0c 5d 6a 10 	movl   $0x106a5d,0xc(%esp)
  103c3b:	00 
  103c3c:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103c43:	00 
  103c44:	c7 44 24 04 0b 02 00 	movl   $0x20b,0x4(%esp)
  103c4b:	00 
  103c4c:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103c53:	e8 dd c7 ff ff       	call   100435 <__panic>
    assert((*ptep & PTE_U) == 0);
  103c58:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103c5b:	8b 00                	mov    (%eax),%eax
  103c5d:	83 e0 04             	and    $0x4,%eax
  103c60:	85 c0                	test   %eax,%eax
  103c62:	74 24                	je     103c88 <check_pgdir+0x530>
  103c64:	c7 44 24 0c ac 6b 10 	movl   $0x106bac,0xc(%esp)
  103c6b:	00 
  103c6c:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103c73:	00 
  103c74:	c7 44 24 04 0c 02 00 	movl   $0x20c,0x4(%esp)
  103c7b:	00 
  103c7c:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103c83:	e8 ad c7 ff ff       	call   100435 <__panic>

    page_remove(boot_pgdir, 0x0);
  103c88:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103c8d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  103c94:	00 
  103c95:	89 04 24             	mov    %eax,(%esp)
  103c98:	e8 31 f9 ff ff       	call   1035ce <page_remove>
    assert(page_ref(p1) == 1);
  103c9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103ca0:	89 04 24             	mov    %eax,(%esp)
  103ca3:	e8 6c ee ff ff       	call   102b14 <page_ref>
  103ca8:	83 f8 01             	cmp    $0x1,%eax
  103cab:	74 24                	je     103cd1 <check_pgdir+0x579>
  103cad:	c7 44 24 0c 73 6a 10 	movl   $0x106a73,0xc(%esp)
  103cb4:	00 
  103cb5:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103cbc:	00 
  103cbd:	c7 44 24 04 0f 02 00 	movl   $0x20f,0x4(%esp)
  103cc4:	00 
  103cc5:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103ccc:	e8 64 c7 ff ff       	call   100435 <__panic>
    assert(page_ref(p2) == 0);
  103cd1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103cd4:	89 04 24             	mov    %eax,(%esp)
  103cd7:	e8 38 ee ff ff       	call   102b14 <page_ref>
  103cdc:	85 c0                	test   %eax,%eax
  103cde:	74 24                	je     103d04 <check_pgdir+0x5ac>
  103ce0:	c7 44 24 0c 9a 6b 10 	movl   $0x106b9a,0xc(%esp)
  103ce7:	00 
  103ce8:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103cef:	00 
  103cf0:	c7 44 24 04 10 02 00 	movl   $0x210,0x4(%esp)
  103cf7:	00 
  103cf8:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103cff:	e8 31 c7 ff ff       	call   100435 <__panic>

    page_remove(boot_pgdir, PGSIZE);
  103d04:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103d09:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
  103d10:	00 
  103d11:	89 04 24             	mov    %eax,(%esp)
  103d14:	e8 b5 f8 ff ff       	call   1035ce <page_remove>
    assert(page_ref(p1) == 0);
  103d19:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103d1c:	89 04 24             	mov    %eax,(%esp)
  103d1f:	e8 f0 ed ff ff       	call   102b14 <page_ref>
  103d24:	85 c0                	test   %eax,%eax
  103d26:	74 24                	je     103d4c <check_pgdir+0x5f4>
  103d28:	c7 44 24 0c c1 6b 10 	movl   $0x106bc1,0xc(%esp)
  103d2f:	00 
  103d30:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103d37:	00 
  103d38:	c7 44 24 04 13 02 00 	movl   $0x213,0x4(%esp)
  103d3f:	00 
  103d40:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103d47:	e8 e9 c6 ff ff       	call   100435 <__panic>
    assert(page_ref(p2) == 0);
  103d4c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103d4f:	89 04 24             	mov    %eax,(%esp)
  103d52:	e8 bd ed ff ff       	call   102b14 <page_ref>
  103d57:	85 c0                	test   %eax,%eax
  103d59:	74 24                	je     103d7f <check_pgdir+0x627>
  103d5b:	c7 44 24 0c 9a 6b 10 	movl   $0x106b9a,0xc(%esp)
  103d62:	00 
  103d63:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103d6a:	00 
  103d6b:	c7 44 24 04 14 02 00 	movl   $0x214,0x4(%esp)
  103d72:	00 
  103d73:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103d7a:	e8 b6 c6 ff ff       	call   100435 <__panic>

    assert(page_ref(pde2page(boot_pgdir[0])) == 1);
  103d7f:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103d84:	8b 00                	mov    (%eax),%eax
  103d86:	89 04 24             	mov    %eax,(%esp)
  103d89:	e8 6e ed ff ff       	call   102afc <pde2page>
  103d8e:	89 04 24             	mov    %eax,(%esp)
  103d91:	e8 7e ed ff ff       	call   102b14 <page_ref>
  103d96:	83 f8 01             	cmp    $0x1,%eax
  103d99:	74 24                	je     103dbf <check_pgdir+0x667>
  103d9b:	c7 44 24 0c d4 6b 10 	movl   $0x106bd4,0xc(%esp)
  103da2:	00 
  103da3:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103daa:	00 
  103dab:	c7 44 24 04 16 02 00 	movl   $0x216,0x4(%esp)
  103db2:	00 
  103db3:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103dba:	e8 76 c6 ff ff       	call   100435 <__panic>
    free_page(pde2page(boot_pgdir[0]));
  103dbf:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103dc4:	8b 00                	mov    (%eax),%eax
  103dc6:	89 04 24             	mov    %eax,(%esp)
  103dc9:	e8 2e ed ff ff       	call   102afc <pde2page>
  103dce:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  103dd5:	00 
  103dd6:	89 04 24             	mov    %eax,(%esp)
  103dd9:	e8 88 ef ff ff       	call   102d66 <free_pages>
    boot_pgdir[0] = 0;
  103dde:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103de3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_pgdir() succeeded!\n");
  103de9:	c7 04 24 fb 6b 10 00 	movl   $0x106bfb,(%esp)
  103df0:	e8 d4 c4 ff ff       	call   1002c9 <cprintf>
}
  103df5:	90                   	nop
  103df6:	c9                   	leave  
  103df7:	c3                   	ret    

00103df8 <check_boot_pgdir>:

static void
check_boot_pgdir(void) {
  103df8:	f3 0f 1e fb          	endbr32 
  103dfc:	55                   	push   %ebp
  103dfd:	89 e5                	mov    %esp,%ebp
  103dff:	83 ec 38             	sub    $0x38,%esp
    pte_t *ptep;
    int i;
    for (i = 0; i < npage; i += PGSIZE) {
  103e02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  103e09:	e9 ca 00 00 00       	jmp    103ed8 <check_boot_pgdir+0xe0>
        assert((ptep = get_pte(boot_pgdir, (uintptr_t)KADDR(i), 0)) != NULL);
  103e0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103e11:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103e14:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103e17:	c1 e8 0c             	shr    $0xc,%eax
  103e1a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103e1d:	a1 80 ce 11 00       	mov    0x11ce80,%eax
  103e22:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  103e25:	72 23                	jb     103e4a <check_boot_pgdir+0x52>
  103e27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103e2a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103e2e:	c7 44 24 08 40 68 10 	movl   $0x106840,0x8(%esp)
  103e35:	00 
  103e36:	c7 44 24 04 22 02 00 	movl   $0x222,0x4(%esp)
  103e3d:	00 
  103e3e:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103e45:	e8 eb c5 ff ff       	call   100435 <__panic>
  103e4a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103e4d:	2d 00 00 00 40       	sub    $0x40000000,%eax
  103e52:	89 c2                	mov    %eax,%edx
  103e54:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103e59:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  103e60:	00 
  103e61:	89 54 24 04          	mov    %edx,0x4(%esp)
  103e65:	89 04 24             	mov    %eax,(%esp)
  103e68:	e8 65 f5 ff ff       	call   1033d2 <get_pte>
  103e6d:	89 45 dc             	mov    %eax,-0x24(%ebp)
  103e70:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  103e74:	75 24                	jne    103e9a <check_boot_pgdir+0xa2>
  103e76:	c7 44 24 0c 18 6c 10 	movl   $0x106c18,0xc(%esp)
  103e7d:	00 
  103e7e:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103e85:	00 
  103e86:	c7 44 24 04 22 02 00 	movl   $0x222,0x4(%esp)
  103e8d:	00 
  103e8e:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103e95:	e8 9b c5 ff ff       	call   100435 <__panic>
        assert(PTE_ADDR(*ptep) == i);
  103e9a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103e9d:	8b 00                	mov    (%eax),%eax
  103e9f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  103ea4:	89 c2                	mov    %eax,%edx
  103ea6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103ea9:	39 c2                	cmp    %eax,%edx
  103eab:	74 24                	je     103ed1 <check_boot_pgdir+0xd9>
  103ead:	c7 44 24 0c 55 6c 10 	movl   $0x106c55,0xc(%esp)
  103eb4:	00 
  103eb5:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103ebc:	00 
  103ebd:	c7 44 24 04 23 02 00 	movl   $0x223,0x4(%esp)
  103ec4:	00 
  103ec5:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103ecc:	e8 64 c5 ff ff       	call   100435 <__panic>
    for (i = 0; i < npage; i += PGSIZE) {
  103ed1:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
  103ed8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103edb:	a1 80 ce 11 00       	mov    0x11ce80,%eax
  103ee0:	39 c2                	cmp    %eax,%edx
  103ee2:	0f 82 26 ff ff ff    	jb     103e0e <check_boot_pgdir+0x16>
    }

    assert(PDE_ADDR(boot_pgdir[PDX(VPT)]) == PADDR(boot_pgdir));
  103ee8:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103eed:	05 ac 0f 00 00       	add    $0xfac,%eax
  103ef2:	8b 00                	mov    (%eax),%eax
  103ef4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  103ef9:	89 c2                	mov    %eax,%edx
  103efb:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103f00:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103f03:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
  103f0a:	77 23                	ja     103f2f <check_boot_pgdir+0x137>
  103f0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103f0f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103f13:	c7 44 24 08 e4 68 10 	movl   $0x1068e4,0x8(%esp)
  103f1a:	00 
  103f1b:	c7 44 24 04 26 02 00 	movl   $0x226,0x4(%esp)
  103f22:	00 
  103f23:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103f2a:	e8 06 c5 ff ff       	call   100435 <__panic>
  103f2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103f32:	05 00 00 00 40       	add    $0x40000000,%eax
  103f37:	39 d0                	cmp    %edx,%eax
  103f39:	74 24                	je     103f5f <check_boot_pgdir+0x167>
  103f3b:	c7 44 24 0c 6c 6c 10 	movl   $0x106c6c,0xc(%esp)
  103f42:	00 
  103f43:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103f4a:	00 
  103f4b:	c7 44 24 04 26 02 00 	movl   $0x226,0x4(%esp)
  103f52:	00 
  103f53:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103f5a:	e8 d6 c4 ff ff       	call   100435 <__panic>

    assert(boot_pgdir[0] == 0);
  103f5f:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103f64:	8b 00                	mov    (%eax),%eax
  103f66:	85 c0                	test   %eax,%eax
  103f68:	74 24                	je     103f8e <check_boot_pgdir+0x196>
  103f6a:	c7 44 24 0c a0 6c 10 	movl   $0x106ca0,0xc(%esp)
  103f71:	00 
  103f72:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103f79:	00 
  103f7a:	c7 44 24 04 28 02 00 	movl   $0x228,0x4(%esp)
  103f81:	00 
  103f82:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103f89:	e8 a7 c4 ff ff       	call   100435 <__panic>

    struct Page *p;
    p = alloc_page();
  103f8e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  103f95:	e8 90 ed ff ff       	call   102d2a <alloc_pages>
  103f9a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert(page_insert(boot_pgdir, p, 0x100, PTE_W) == 0);
  103f9d:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  103fa2:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
  103fa9:	00 
  103faa:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
  103fb1:	00 
  103fb2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103fb5:	89 54 24 04          	mov    %edx,0x4(%esp)
  103fb9:	89 04 24             	mov    %eax,(%esp)
  103fbc:	e8 56 f6 ff ff       	call   103617 <page_insert>
  103fc1:	85 c0                	test   %eax,%eax
  103fc3:	74 24                	je     103fe9 <check_boot_pgdir+0x1f1>
  103fc5:	c7 44 24 0c b4 6c 10 	movl   $0x106cb4,0xc(%esp)
  103fcc:	00 
  103fcd:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  103fd4:	00 
  103fd5:	c7 44 24 04 2c 02 00 	movl   $0x22c,0x4(%esp)
  103fdc:	00 
  103fdd:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  103fe4:	e8 4c c4 ff ff       	call   100435 <__panic>
    assert(page_ref(p) == 1);
  103fe9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103fec:	89 04 24             	mov    %eax,(%esp)
  103fef:	e8 20 eb ff ff       	call   102b14 <page_ref>
  103ff4:	83 f8 01             	cmp    $0x1,%eax
  103ff7:	74 24                	je     10401d <check_boot_pgdir+0x225>
  103ff9:	c7 44 24 0c e2 6c 10 	movl   $0x106ce2,0xc(%esp)
  104000:	00 
  104001:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  104008:	00 
  104009:	c7 44 24 04 2d 02 00 	movl   $0x22d,0x4(%esp)
  104010:	00 
  104011:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  104018:	e8 18 c4 ff ff       	call   100435 <__panic>
    assert(page_insert(boot_pgdir, p, 0x100 + PGSIZE, PTE_W) == 0);
  10401d:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  104022:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
  104029:	00 
  10402a:	c7 44 24 08 00 11 00 	movl   $0x1100,0x8(%esp)
  104031:	00 
  104032:	8b 55 ec             	mov    -0x14(%ebp),%edx
  104035:	89 54 24 04          	mov    %edx,0x4(%esp)
  104039:	89 04 24             	mov    %eax,(%esp)
  10403c:	e8 d6 f5 ff ff       	call   103617 <page_insert>
  104041:	85 c0                	test   %eax,%eax
  104043:	74 24                	je     104069 <check_boot_pgdir+0x271>
  104045:	c7 44 24 0c f4 6c 10 	movl   $0x106cf4,0xc(%esp)
  10404c:	00 
  10404d:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  104054:	00 
  104055:	c7 44 24 04 2e 02 00 	movl   $0x22e,0x4(%esp)
  10405c:	00 
  10405d:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  104064:	e8 cc c3 ff ff       	call   100435 <__panic>
    assert(page_ref(p) == 2);
  104069:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10406c:	89 04 24             	mov    %eax,(%esp)
  10406f:	e8 a0 ea ff ff       	call   102b14 <page_ref>
  104074:	83 f8 02             	cmp    $0x2,%eax
  104077:	74 24                	je     10409d <check_boot_pgdir+0x2a5>
  104079:	c7 44 24 0c 2b 6d 10 	movl   $0x106d2b,0xc(%esp)
  104080:	00 
  104081:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  104088:	00 
  104089:	c7 44 24 04 2f 02 00 	movl   $0x22f,0x4(%esp)
  104090:	00 
  104091:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  104098:	e8 98 c3 ff ff       	call   100435 <__panic>

    const char *str = "ucore: Hello world!!";
  10409d:	c7 45 e8 3c 6d 10 00 	movl   $0x106d3c,-0x18(%ebp)
    strcpy((void *)0x100, str);
  1040a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1040a7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1040ab:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
  1040b2:	e8 26 15 00 00       	call   1055dd <strcpy>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
  1040b7:	c7 44 24 04 00 11 00 	movl   $0x1100,0x4(%esp)
  1040be:	00 
  1040bf:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
  1040c6:	e8 90 15 00 00       	call   10565b <strcmp>
  1040cb:	85 c0                	test   %eax,%eax
  1040cd:	74 24                	je     1040f3 <check_boot_pgdir+0x2fb>
  1040cf:	c7 44 24 0c 54 6d 10 	movl   $0x106d54,0xc(%esp)
  1040d6:	00 
  1040d7:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  1040de:	00 
  1040df:	c7 44 24 04 33 02 00 	movl   $0x233,0x4(%esp)
  1040e6:	00 
  1040e7:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  1040ee:	e8 42 c3 ff ff       	call   100435 <__panic>

    *(char *)(page2kva(p) + 0x100) = '\0';
  1040f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1040f6:	89 04 24             	mov    %eax,(%esp)
  1040f9:	e8 6c e9 ff ff       	call   102a6a <page2kva>
  1040fe:	05 00 01 00 00       	add    $0x100,%eax
  104103:	c6 00 00             	movb   $0x0,(%eax)
    assert(strlen((const char *)0x100) == 0);
  104106:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
  10410d:	e8 6d 14 00 00       	call   10557f <strlen>
  104112:	85 c0                	test   %eax,%eax
  104114:	74 24                	je     10413a <check_boot_pgdir+0x342>
  104116:	c7 44 24 0c 8c 6d 10 	movl   $0x106d8c,0xc(%esp)
  10411d:	00 
  10411e:	c7 44 24 08 2d 69 10 	movl   $0x10692d,0x8(%esp)
  104125:	00 
  104126:	c7 44 24 04 36 02 00 	movl   $0x236,0x4(%esp)
  10412d:	00 
  10412e:	c7 04 24 08 69 10 00 	movl   $0x106908,(%esp)
  104135:	e8 fb c2 ff ff       	call   100435 <__panic>

    free_page(p);
  10413a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  104141:	00 
  104142:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104145:	89 04 24             	mov    %eax,(%esp)
  104148:	e8 19 ec ff ff       	call   102d66 <free_pages>
    free_page(pde2page(boot_pgdir[0]));
  10414d:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  104152:	8b 00                	mov    (%eax),%eax
  104154:	89 04 24             	mov    %eax,(%esp)
  104157:	e8 a0 e9 ff ff       	call   102afc <pde2page>
  10415c:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  104163:	00 
  104164:	89 04 24             	mov    %eax,(%esp)
  104167:	e8 fa eb ff ff       	call   102d66 <free_pages>
    boot_pgdir[0] = 0;
  10416c:	a1 e0 99 11 00       	mov    0x1199e0,%eax
  104171:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_boot_pgdir() succeeded!\n");
  104177:	c7 04 24 b0 6d 10 00 	movl   $0x106db0,(%esp)
  10417e:	e8 46 c1 ff ff       	call   1002c9 <cprintf>
}
  104183:	90                   	nop
  104184:	c9                   	leave  
  104185:	c3                   	ret    

00104186 <perm2str>:

//perm2str - use string 'u,r,w,-' to present the permission
static const char *
perm2str(int perm) {
  104186:	f3 0f 1e fb          	endbr32 
  10418a:	55                   	push   %ebp
  10418b:	89 e5                	mov    %esp,%ebp
    static char str[4];
    str[0] = (perm & PTE_U) ? 'u' : '-';
  10418d:	8b 45 08             	mov    0x8(%ebp),%eax
  104190:	83 e0 04             	and    $0x4,%eax
  104193:	85 c0                	test   %eax,%eax
  104195:	74 04                	je     10419b <perm2str+0x15>
  104197:	b0 75                	mov    $0x75,%al
  104199:	eb 02                	jmp    10419d <perm2str+0x17>
  10419b:	b0 2d                	mov    $0x2d,%al
  10419d:	a2 08 cf 11 00       	mov    %al,0x11cf08
    str[1] = 'r';
  1041a2:	c6 05 09 cf 11 00 72 	movb   $0x72,0x11cf09
    str[2] = (perm & PTE_W) ? 'w' : '-';
  1041a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1041ac:	83 e0 02             	and    $0x2,%eax
  1041af:	85 c0                	test   %eax,%eax
  1041b1:	74 04                	je     1041b7 <perm2str+0x31>
  1041b3:	b0 77                	mov    $0x77,%al
  1041b5:	eb 02                	jmp    1041b9 <perm2str+0x33>
  1041b7:	b0 2d                	mov    $0x2d,%al
  1041b9:	a2 0a cf 11 00       	mov    %al,0x11cf0a
    str[3] = '\0';
  1041be:	c6 05 0b cf 11 00 00 	movb   $0x0,0x11cf0b
    return str;
  1041c5:	b8 08 cf 11 00       	mov    $0x11cf08,%eax
}
  1041ca:	5d                   	pop    %ebp
  1041cb:	c3                   	ret    

001041cc <get_pgtable_items>:
//  table:       the beginning addr of table
//  left_store:  the pointer of the high side of table's next range
//  right_store: the pointer of the low side of table's next range
// return value: 0 - not a invalid item range, perm - a valid item range with perm permission 
static int
get_pgtable_items(size_t left, size_t right, size_t start, uintptr_t *table, size_t *left_store, size_t *right_store) {
  1041cc:	f3 0f 1e fb          	endbr32 
  1041d0:	55                   	push   %ebp
  1041d1:	89 e5                	mov    %esp,%ebp
  1041d3:	83 ec 10             	sub    $0x10,%esp
    if (start >= right) {
  1041d6:	8b 45 10             	mov    0x10(%ebp),%eax
  1041d9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  1041dc:	72 0d                	jb     1041eb <get_pgtable_items+0x1f>
        return 0;
  1041de:	b8 00 00 00 00       	mov    $0x0,%eax
  1041e3:	e9 98 00 00 00       	jmp    104280 <get_pgtable_items+0xb4>
    }
    while (start < right && !(table[start] & PTE_P)) {
        start ++;
  1041e8:	ff 45 10             	incl   0x10(%ebp)
    while (start < right && !(table[start] & PTE_P)) {
  1041eb:	8b 45 10             	mov    0x10(%ebp),%eax
  1041ee:	3b 45 0c             	cmp    0xc(%ebp),%eax
  1041f1:	73 18                	jae    10420b <get_pgtable_items+0x3f>
  1041f3:	8b 45 10             	mov    0x10(%ebp),%eax
  1041f6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  1041fd:	8b 45 14             	mov    0x14(%ebp),%eax
  104200:	01 d0                	add    %edx,%eax
  104202:	8b 00                	mov    (%eax),%eax
  104204:	83 e0 01             	and    $0x1,%eax
  104207:	85 c0                	test   %eax,%eax
  104209:	74 dd                	je     1041e8 <get_pgtable_items+0x1c>
    }
    if (start < right) {
  10420b:	8b 45 10             	mov    0x10(%ebp),%eax
  10420e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  104211:	73 68                	jae    10427b <get_pgtable_items+0xaf>
        if (left_store != NULL) {
  104213:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
  104217:	74 08                	je     104221 <get_pgtable_items+0x55>
            *left_store = start;
  104219:	8b 45 18             	mov    0x18(%ebp),%eax
  10421c:	8b 55 10             	mov    0x10(%ebp),%edx
  10421f:	89 10                	mov    %edx,(%eax)
        }
        int perm = (table[start ++] & PTE_USER);
  104221:	8b 45 10             	mov    0x10(%ebp),%eax
  104224:	8d 50 01             	lea    0x1(%eax),%edx
  104227:	89 55 10             	mov    %edx,0x10(%ebp)
  10422a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  104231:	8b 45 14             	mov    0x14(%ebp),%eax
  104234:	01 d0                	add    %edx,%eax
  104236:	8b 00                	mov    (%eax),%eax
  104238:	83 e0 07             	and    $0x7,%eax
  10423b:	89 45 fc             	mov    %eax,-0x4(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
  10423e:	eb 03                	jmp    104243 <get_pgtable_items+0x77>
            start ++;
  104240:	ff 45 10             	incl   0x10(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
  104243:	8b 45 10             	mov    0x10(%ebp),%eax
  104246:	3b 45 0c             	cmp    0xc(%ebp),%eax
  104249:	73 1d                	jae    104268 <get_pgtable_items+0x9c>
  10424b:	8b 45 10             	mov    0x10(%ebp),%eax
  10424e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  104255:	8b 45 14             	mov    0x14(%ebp),%eax
  104258:	01 d0                	add    %edx,%eax
  10425a:	8b 00                	mov    (%eax),%eax
  10425c:	83 e0 07             	and    $0x7,%eax
  10425f:	89 c2                	mov    %eax,%edx
  104261:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104264:	39 c2                	cmp    %eax,%edx
  104266:	74 d8                	je     104240 <get_pgtable_items+0x74>
        }
        if (right_store != NULL) {
  104268:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  10426c:	74 08                	je     104276 <get_pgtable_items+0xaa>
            *right_store = start;
  10426e:	8b 45 1c             	mov    0x1c(%ebp),%eax
  104271:	8b 55 10             	mov    0x10(%ebp),%edx
  104274:	89 10                	mov    %edx,(%eax)
        }
        return perm;
  104276:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104279:	eb 05                	jmp    104280 <get_pgtable_items+0xb4>
    }
    return 0;
  10427b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  104280:	c9                   	leave  
  104281:	c3                   	ret    

00104282 <print_pgdir>:

//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
  104282:	f3 0f 1e fb          	endbr32 
  104286:	55                   	push   %ebp
  104287:	89 e5                	mov    %esp,%ebp
  104289:	57                   	push   %edi
  10428a:	56                   	push   %esi
  10428b:	53                   	push   %ebx
  10428c:	83 ec 4c             	sub    $0x4c,%esp
    cprintf("-------------------- BEGIN --------------------\n");
  10428f:	c7 04 24 d0 6d 10 00 	movl   $0x106dd0,(%esp)
  104296:	e8 2e c0 ff ff       	call   1002c9 <cprintf>
    size_t left, right = 0, perm;
  10429b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
  1042a2:	e9 fa 00 00 00       	jmp    1043a1 <print_pgdir+0x11f>
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
  1042a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1042aa:	89 04 24             	mov    %eax,(%esp)
  1042ad:	e8 d4 fe ff ff       	call   104186 <perm2str>
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
  1042b2:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  1042b5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1042b8:	29 d1                	sub    %edx,%ecx
  1042ba:	89 ca                	mov    %ecx,%edx
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
  1042bc:	89 d6                	mov    %edx,%esi
  1042be:	c1 e6 16             	shl    $0x16,%esi
  1042c1:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1042c4:	89 d3                	mov    %edx,%ebx
  1042c6:	c1 e3 16             	shl    $0x16,%ebx
  1042c9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1042cc:	89 d1                	mov    %edx,%ecx
  1042ce:	c1 e1 16             	shl    $0x16,%ecx
  1042d1:	8b 7d dc             	mov    -0x24(%ebp),%edi
  1042d4:	8b 55 e0             	mov    -0x20(%ebp),%edx
  1042d7:	29 d7                	sub    %edx,%edi
  1042d9:	89 fa                	mov    %edi,%edx
  1042db:	89 44 24 14          	mov    %eax,0x14(%esp)
  1042df:	89 74 24 10          	mov    %esi,0x10(%esp)
  1042e3:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1042e7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1042eb:	89 54 24 04          	mov    %edx,0x4(%esp)
  1042ef:	c7 04 24 01 6e 10 00 	movl   $0x106e01,(%esp)
  1042f6:	e8 ce bf ff ff       	call   1002c9 <cprintf>
        size_t l, r = left * NPTEENTRY;
  1042fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1042fe:	c1 e0 0a             	shl    $0xa,%eax
  104301:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
  104304:	eb 54                	jmp    10435a <print_pgdir+0xd8>
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
  104306:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104309:	89 04 24             	mov    %eax,(%esp)
  10430c:	e8 75 fe ff ff       	call   104186 <perm2str>
                    l * PGSIZE, r * PGSIZE, (r - l) * PGSIZE, perm2str(perm));
  104311:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  104314:	8b 55 d8             	mov    -0x28(%ebp),%edx
  104317:	29 d1                	sub    %edx,%ecx
  104319:	89 ca                	mov    %ecx,%edx
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
  10431b:	89 d6                	mov    %edx,%esi
  10431d:	c1 e6 0c             	shl    $0xc,%esi
  104320:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  104323:	89 d3                	mov    %edx,%ebx
  104325:	c1 e3 0c             	shl    $0xc,%ebx
  104328:	8b 55 d8             	mov    -0x28(%ebp),%edx
  10432b:	89 d1                	mov    %edx,%ecx
  10432d:	c1 e1 0c             	shl    $0xc,%ecx
  104330:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  104333:	8b 55 d8             	mov    -0x28(%ebp),%edx
  104336:	29 d7                	sub    %edx,%edi
  104338:	89 fa                	mov    %edi,%edx
  10433a:	89 44 24 14          	mov    %eax,0x14(%esp)
  10433e:	89 74 24 10          	mov    %esi,0x10(%esp)
  104342:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  104346:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  10434a:	89 54 24 04          	mov    %edx,0x4(%esp)
  10434e:	c7 04 24 20 6e 10 00 	movl   $0x106e20,(%esp)
  104355:	e8 6f bf ff ff       	call   1002c9 <cprintf>
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
  10435a:	be 00 00 c0 fa       	mov    $0xfac00000,%esi
  10435f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  104362:	8b 55 dc             	mov    -0x24(%ebp),%edx
  104365:	89 d3                	mov    %edx,%ebx
  104367:	c1 e3 0a             	shl    $0xa,%ebx
  10436a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  10436d:	89 d1                	mov    %edx,%ecx
  10436f:	c1 e1 0a             	shl    $0xa,%ecx
  104372:	8d 55 d4             	lea    -0x2c(%ebp),%edx
  104375:	89 54 24 14          	mov    %edx,0x14(%esp)
  104379:	8d 55 d8             	lea    -0x28(%ebp),%edx
  10437c:	89 54 24 10          	mov    %edx,0x10(%esp)
  104380:	89 74 24 0c          	mov    %esi,0xc(%esp)
  104384:	89 44 24 08          	mov    %eax,0x8(%esp)
  104388:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  10438c:	89 0c 24             	mov    %ecx,(%esp)
  10438f:	e8 38 fe ff ff       	call   1041cc <get_pgtable_items>
  104394:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  104397:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10439b:	0f 85 65 ff ff ff    	jne    104306 <print_pgdir+0x84>
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
  1043a1:	b9 00 b0 fe fa       	mov    $0xfafeb000,%ecx
  1043a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1043a9:	8d 55 dc             	lea    -0x24(%ebp),%edx
  1043ac:	89 54 24 14          	mov    %edx,0x14(%esp)
  1043b0:	8d 55 e0             	lea    -0x20(%ebp),%edx
  1043b3:	89 54 24 10          	mov    %edx,0x10(%esp)
  1043b7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1043bb:	89 44 24 08          	mov    %eax,0x8(%esp)
  1043bf:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
  1043c6:	00 
  1043c7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1043ce:	e8 f9 fd ff ff       	call   1041cc <get_pgtable_items>
  1043d3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1043d6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  1043da:	0f 85 c7 fe ff ff    	jne    1042a7 <print_pgdir+0x25>
        }
    }
    cprintf("--------------------- END ---------------------\n");
  1043e0:	c7 04 24 44 6e 10 00 	movl   $0x106e44,(%esp)
  1043e7:	e8 dd be ff ff       	call   1002c9 <cprintf>
}
  1043ec:	90                   	nop
  1043ed:	83 c4 4c             	add    $0x4c,%esp
  1043f0:	5b                   	pop    %ebx
  1043f1:	5e                   	pop    %esi
  1043f2:	5f                   	pop    %edi
  1043f3:	5d                   	pop    %ebp
  1043f4:	c3                   	ret    

001043f5 <page2ppn>:
page2ppn(struct Page *page) {
  1043f5:	55                   	push   %ebp
  1043f6:	89 e5                	mov    %esp,%ebp
    return page - pages;
  1043f8:	a1 18 cf 11 00       	mov    0x11cf18,%eax
  1043fd:	8b 55 08             	mov    0x8(%ebp),%edx
  104400:	29 c2                	sub    %eax,%edx
  104402:	89 d0                	mov    %edx,%eax
  104404:	c1 f8 02             	sar    $0x2,%eax
  104407:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
  10440d:	5d                   	pop    %ebp
  10440e:	c3                   	ret    

0010440f <page2pa>:
page2pa(struct Page *page) {
  10440f:	55                   	push   %ebp
  104410:	89 e5                	mov    %esp,%ebp
  104412:	83 ec 04             	sub    $0x4,%esp
    return page2ppn(page) << PGSHIFT;
  104415:	8b 45 08             	mov    0x8(%ebp),%eax
  104418:	89 04 24             	mov    %eax,(%esp)
  10441b:	e8 d5 ff ff ff       	call   1043f5 <page2ppn>
  104420:	c1 e0 0c             	shl    $0xc,%eax
}
  104423:	c9                   	leave  
  104424:	c3                   	ret    

00104425 <page_ref>:
page_ref(struct Page *page) {
  104425:	55                   	push   %ebp
  104426:	89 e5                	mov    %esp,%ebp
    return page->ref;
  104428:	8b 45 08             	mov    0x8(%ebp),%eax
  10442b:	8b 00                	mov    (%eax),%eax
}
  10442d:	5d                   	pop    %ebp
  10442e:	c3                   	ret    

0010442f <set_page_ref>:
set_page_ref(struct Page *page, int val) {
  10442f:	55                   	push   %ebp
  104430:	89 e5                	mov    %esp,%ebp
    page->ref = val;
  104432:	8b 45 08             	mov    0x8(%ebp),%eax
  104435:	8b 55 0c             	mov    0xc(%ebp),%edx
  104438:	89 10                	mov    %edx,(%eax)
}
  10443a:	90                   	nop
  10443b:	5d                   	pop    %ebp
  10443c:	c3                   	ret    

0010443d <default_init>:
#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

//实现:将双向链表初始化，同时将空闲页总数nr_free初始化为0
static void
default_init(void) {
  10443d:	f3 0f 1e fb          	endbr32 
  104441:	55                   	push   %ebp
  104442:	89 e5                	mov    %esp,%ebp
  104444:	83 ec 10             	sub    $0x10,%esp
  104447:	c7 45 fc 1c cf 11 00 	movl   $0x11cf1c,-0x4(%ebp)
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
  10444e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104451:	8b 55 fc             	mov    -0x4(%ebp),%edx
  104454:	89 50 04             	mov    %edx,0x4(%eax)
  104457:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10445a:	8b 50 04             	mov    0x4(%eax),%edx
  10445d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  104460:	89 10                	mov    %edx,(%eax)
}
  104462:	90                   	nop
    list_init(&free_list);
    nr_free = 0;
  104463:	c7 05 24 cf 11 00 00 	movl   $0x0,0x11cf24
  10446a:	00 00 00 
}
  10446d:	90                   	nop
  10446e:	c9                   	leave  
  10446f:	c3                   	ret    

00104470 <default_init_memmap>:
综上，具体流程为：遍历块内所有空闲物理页的Page结构，将各个flags置为0以标记物理页帧有效，将property成员置零，使用 SetPageProperty宏置PG_Property标志位来标记各个页有效（具体而言，如果一页的该位为1，则对应页应是一个空闲块的块首页；若为0，则对应页要么是一个已分配块的块首页，要么不是块中首页；另一个标志位PG_Reserved在pmm_init函数里已被置位，这里用于确认对应页不是被OS内核占用的保留页，因而可用于用户程序的分配和回收），清空各物理页的引用计数ref；最后再将首页Page结构的property置为块内总页数，将全局总页数nr_free加上块内总页数，并用page_link这个双链表结点指针集合将块首页连接到空闲块链表里。
*/
//Page:返回传入参数pa开始的第一个物理页，也就是基地址base
//n:代表物理页的个数
static void
default_init_memmap(struct Page *base, size_t n) {
  104470:	f3 0f 1e fb          	endbr32 
  104474:	55                   	push   %ebp
  104475:	89 e5                	mov    %esp,%ebp
  104477:	83 ec 48             	sub    $0x48,%esp
    assert(n > 0); //判断n是否大于0
  10447a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10447e:	75 24                	jne    1044a4 <default_init_memmap+0x34>
  104480:	c7 44 24 0c 78 6e 10 	movl   $0x106e78,0xc(%esp)
  104487:	00 
  104488:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  10448f:	00 
  104490:	c7 44 24 04 84 00 00 	movl   $0x84,0x4(%esp)
  104497:	00 
  104498:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  10449f:	e8 91 bf ff ff       	call   100435 <__panic>
    struct Page *p = base;
  1044a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1044a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) { //初始化n块物理页
  1044aa:	e9 e1 00 00 00       	jmp    104590 <default_init_memmap+0x120>
        assert(PageReserved(p)); //检查此页是否为保留页
  1044af:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1044b2:	83 c0 04             	add    $0x4,%eax
  1044b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  1044bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  1044bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1044c2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1044c5:	0f a3 10             	bt     %edx,(%eax)
  1044c8:	19 c0                	sbb    %eax,%eax
  1044ca:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return oldbit != 0;
  1044cd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1044d1:	0f 95 c0             	setne  %al
  1044d4:	0f b6 c0             	movzbl %al,%eax
  1044d7:	85 c0                	test   %eax,%eax
  1044d9:	75 24                	jne    1044ff <default_init_memmap+0x8f>
  1044db:	c7 44 24 0c a9 6e 10 	movl   $0x106ea9,0xc(%esp)
  1044e2:	00 
  1044e3:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  1044ea:	00 
  1044eb:	c7 44 24 04 87 00 00 	movl   $0x87,0x4(%esp)
  1044f2:	00 
  1044f3:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  1044fa:	e8 36 bf ff ff       	call   100435 <__panic>
        p->flags = p->property = 0; //标志位清0
  1044ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104502:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  104509:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10450c:	8b 50 08             	mov    0x8(%eax),%edx
  10450f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104512:	89 50 04             	mov    %edx,0x4(%eax)
        SetPageProperty(p);       //设置标志位为1 //p->flags should be set bit PG_property (means this page is valid. In pmm_init fun (in pmm.c)
  104515:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104518:	83 c0 04             	add    $0x4,%eax
  10451b:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
  104522:	89 45 cc             	mov    %eax,-0x34(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  104525:	8b 45 cc             	mov    -0x34(%ebp),%eax
  104528:	8b 55 d0             	mov    -0x30(%ebp),%edx
  10452b:	0f ab 10             	bts    %edx,(%eax)
}
  10452e:	90                   	nop
        set_page_ref(p, 0); //清除引用此页的虚拟页的个数
  10452f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104536:	00 
  104537:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10453a:	89 04 24             	mov    %eax,(%esp)
  10453d:	e8 ed fe ff ff       	call   10442f <set_page_ref>
        //加入空闲链表
        list_add_before(&free_list, &(p->page_link)); 
  104542:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104545:	83 c0 0c             	add    $0xc,%eax
  104548:	c7 45 e4 1c cf 11 00 	movl   $0x11cf1c,-0x1c(%ebp)
  10454f:	89 45 e0             	mov    %eax,-0x20(%ebp)
 * Insert the new element @elm *before* the element @listelm which
 * is already in the list.
 * */
static inline void
list_add_before(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm->prev, listelm);
  104552:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104555:	8b 00                	mov    (%eax),%eax
  104557:	8b 55 e0             	mov    -0x20(%ebp),%edx
  10455a:	89 55 dc             	mov    %edx,-0x24(%ebp)
  10455d:	89 45 d8             	mov    %eax,-0x28(%ebp)
  104560:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104563:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
  104566:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  104569:	8b 55 dc             	mov    -0x24(%ebp),%edx
  10456c:	89 10                	mov    %edx,(%eax)
  10456e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  104571:	8b 10                	mov    (%eax),%edx
  104573:	8b 45 d8             	mov    -0x28(%ebp),%eax
  104576:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
  104579:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10457c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10457f:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
  104582:	8b 45 dc             	mov    -0x24(%ebp),%eax
  104585:	8b 55 d8             	mov    -0x28(%ebp),%edx
  104588:	89 10                	mov    %edx,(%eax)
}
  10458a:	90                   	nop
}
  10458b:	90                   	nop
    for (; p != base + n; p ++) { //初始化n块物理页
  10458c:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
  104590:	8b 55 0c             	mov    0xc(%ebp),%edx
  104593:	89 d0                	mov    %edx,%eax
  104595:	c1 e0 02             	shl    $0x2,%eax
  104598:	01 d0                	add    %edx,%eax
  10459a:	c1 e0 02             	shl    $0x2,%eax
  10459d:	89 c2                	mov    %eax,%edx
  10459f:	8b 45 08             	mov    0x8(%ebp),%eax
  1045a2:	01 d0                	add    %edx,%eax
  1045a4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  1045a7:	0f 85 02 ff ff ff    	jne    1044af <default_init_memmap+0x3f>
    }
    nr_free += n; //计算空闲页总数
  1045ad:	8b 15 24 cf 11 00    	mov    0x11cf24,%edx
  1045b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1045b6:	01 d0                	add    %edx,%eax
  1045b8:	a3 24 cf 11 00       	mov    %eax,0x11cf24
    base->property = n; //修改base的连续空页值为n
  1045bd:	8b 45 08             	mov    0x8(%ebp),%eax
  1045c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  1045c3:	89 50 08             	mov    %edx,0x8(%eax)
    //SetPageProperty(base);
    //nr_free += n;
    //list_add(&free_list, &(base->page_link));
}
  1045c6:	90                   	nop
  1045c7:	c9                   	leave  
  1045c8:	c3                   	ret    

001045c9 <default_alloc_pages>:

//实现
static struct Page *
default_alloc_pages(size_t n) {
  1045c9:	f3 0f 1e fb          	endbr32 
  1045cd:	55                   	push   %ebp
  1045ce:	89 e5                	mov    %esp,%ebp
  1045d0:	83 ec 68             	sub    $0x68,%esp
    assert(n > 0); //判断n是否大于0
  1045d3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1045d7:	75 24                	jne    1045fd <default_alloc_pages+0x34>
  1045d9:	c7 44 24 0c 78 6e 10 	movl   $0x106e78,0xc(%esp)
  1045e0:	00 
  1045e1:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  1045e8:	00 
  1045e9:	c7 44 24 04 98 00 00 	movl   $0x98,0x4(%esp)
  1045f0:	00 
  1045f1:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  1045f8:	e8 38 be ff ff       	call   100435 <__panic>
    if (n > nr_free) { //需要分配页的个数大于空闲页的总数,直接返回
  1045fd:	a1 24 cf 11 00       	mov    0x11cf24,%eax
  104602:	39 45 08             	cmp    %eax,0x8(%ebp)
  104605:	76 0a                	jbe    104611 <default_alloc_pages+0x48>
        return NULL;
  104607:	b8 00 00 00 00       	mov    $0x0,%eax
  10460c:	e9 3c 01 00 00       	jmp    10474d <default_alloc_pages+0x184>
    }
    //struct Page *page = NULL;
    //list_entry_t *le = &free_list;
    list_entry_t *le, *len; //空闲链表的头部和长度
    le = &free_list;  //空闲链表的头部
  104611:	c7 45 f4 1c cf 11 00 	movl   $0x11cf1c,-0xc(%ebp)
    
    while ((le = list_next(le)) != &free_list) { //遍历整个空闲链表
  104618:	e9 0f 01 00 00       	jmp    10472c <default_alloc_pages+0x163>
        struct Page *p = le2page(le, page_link); //转换为页结构
  10461d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104620:	83 e8 0c             	sub    $0xc,%eax
  104623:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if (p->property >= n) { //找到合适的空闲页
  104626:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104629:	8b 40 08             	mov    0x8(%eax),%eax
  10462c:	39 45 08             	cmp    %eax,0x8(%ebp)
  10462f:	0f 87 f7 00 00 00    	ja     10472c <default_alloc_pages+0x163>
            //page = p;
            //break;
            int i;
            for(i=0;i<n;i++){
  104635:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  10463c:	eb 7f                	jmp    1046bd <default_alloc_pages+0xf4>
  10463e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104641:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return listelm->next;
  104644:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  104647:	8b 40 04             	mov    0x4(%eax),%eax
                len = list_next(le); 
  10464a:	89 45 e8             	mov    %eax,-0x18(%ebp)
                struct Page *pp = le2page(le, page_link); //转换页结构
  10464d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104650:	83 e8 0c             	sub    $0xc,%eax
  104653:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                SetPageReserved(pp); //设置每一页的标志位
  104656:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104659:	83 c0 04             	add    $0x4,%eax
  10465c:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
  104663:	89 45 c8             	mov    %eax,-0x38(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  104666:	8b 45 c8             	mov    -0x38(%ebp),%eax
  104669:	8b 55 cc             	mov    -0x34(%ebp),%edx
  10466c:	0f ab 10             	bts    %edx,(%eax)
}
  10466f:	90                   	nop
                ClearPageProperty(pp); 
  104670:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104673:	83 c0 04             	add    $0x4,%eax
  104676:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
  10467d:	89 45 d0             	mov    %eax,-0x30(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  104680:	8b 45 d0             	mov    -0x30(%ebp),%eax
  104683:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  104686:	0f b3 10             	btr    %edx,(%eax)
}
  104689:	90                   	nop
  10468a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10468d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    __list_del(listelm->prev, listelm->next);
  104690:	8b 45 e0             	mov    -0x20(%ebp),%eax
  104693:	8b 40 04             	mov    0x4(%eax),%eax
  104696:	8b 55 e0             	mov    -0x20(%ebp),%edx
  104699:	8b 12                	mov    (%edx),%edx
  10469b:	89 55 dc             	mov    %edx,-0x24(%ebp)
  10469e:	89 45 d8             	mov    %eax,-0x28(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
  1046a1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1046a4:	8b 55 d8             	mov    -0x28(%ebp),%edx
  1046a7:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
  1046aa:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1046ad:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1046b0:	89 10                	mov    %edx,(%eax)
}
  1046b2:	90                   	nop
}
  1046b3:	90                   	nop
                list_del(le); //将此页从free_list中清除
                le = len;
  1046b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1046b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
            for(i=0;i<n;i++){
  1046ba:	ff 45 f0             	incl   -0x10(%ebp)
  1046bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1046c0:	39 45 08             	cmp    %eax,0x8(%ebp)
  1046c3:	0f 87 75 ff ff ff    	ja     10463e <default_alloc_pages+0x75>
            }
            if(p->property>n){ //如果页块大小大于所需大小，分割页块
  1046c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1046cc:	8b 40 08             	mov    0x8(%eax),%eax
  1046cf:	39 45 08             	cmp    %eax,0x8(%ebp)
  1046d2:	73 12                	jae    1046e6 <default_alloc_pages+0x11d>
                (le2page(le,page_link))->property = p->property-n;
  1046d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1046d7:	8b 40 08             	mov    0x8(%eax),%eax
  1046da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1046dd:	83 ea 0c             	sub    $0xc,%edx
  1046e0:	2b 45 08             	sub    0x8(%ebp),%eax
  1046e3:	89 42 08             	mov    %eax,0x8(%edx)
            }
            ClearPageProperty(p);
  1046e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1046e9:	83 c0 04             	add    $0x4,%eax
  1046ec:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
  1046f3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  1046f6:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  1046f9:	8b 55 b8             	mov    -0x48(%ebp),%edx
  1046fc:	0f b3 10             	btr    %edx,(%eax)
}
  1046ff:	90                   	nop
            SetPageReserved(p);
  104700:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104703:	83 c0 04             	add    $0x4,%eax
  104706:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
  10470d:	89 45 bc             	mov    %eax,-0x44(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  104710:	8b 45 bc             	mov    -0x44(%ebp),%eax
  104713:	8b 55 c0             	mov    -0x40(%ebp),%edx
  104716:	0f ab 10             	bts    %edx,(%eax)
}
  104719:	90                   	nop
            nr_free -= n; //减去已经分配的页块大小
  10471a:	a1 24 cf 11 00       	mov    0x11cf24,%eax
  10471f:	2b 45 08             	sub    0x8(%ebp),%eax
  104722:	a3 24 cf 11 00       	mov    %eax,0x11cf24
            return p;
  104727:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10472a:	eb 21                	jmp    10474d <default_alloc_pages+0x184>
  10472c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10472f:	89 45 b0             	mov    %eax,-0x50(%ebp)
    return listelm->next;
  104732:	8b 45 b0             	mov    -0x50(%ebp),%eax
  104735:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) { //遍历整个空闲链表
  104738:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10473b:	81 7d f4 1c cf 11 00 	cmpl   $0x11cf1c,-0xc(%ebp)
  104742:	0f 85 d5 fe ff ff    	jne    10461d <default_alloc_pages+0x54>
        nr_free -= n;
        ClearPageProperty(page);
    }
    return page;
    */
    return NULL;
  104748:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10474d:	c9                   	leave  
  10474e:	c3                   	ret    

0010474f <default_free_pages>:

//实现
static void
default_free_pages(struct Page *base, size_t n) {
  10474f:	f3 0f 1e fb          	endbr32 
  104753:	55                   	push   %ebp
  104754:	89 e5                	mov    %esp,%ebp
  104756:	83 ec 68             	sub    $0x68,%esp
    assert(n > 0);
  104759:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10475d:	75 24                	jne    104783 <default_free_pages+0x34>
  10475f:	c7 44 24 0c 78 6e 10 	movl   $0x106e78,0xc(%esp)
  104766:	00 
  104767:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  10476e:	00 
  10476f:	c7 44 24 04 cb 00 00 	movl   $0xcb,0x4(%esp)
  104776:	00 
  104777:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  10477e:	e8 b2 bc ff ff       	call   100435 <__panic>
    assert(PageReserved(base));    //检查需要释放的页块是否已经被分配
  104783:	8b 45 08             	mov    0x8(%ebp),%eax
  104786:	83 c0 04             	add    $0x4,%eax
  104789:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  104790:	89 45 e8             	mov    %eax,-0x18(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  104793:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104796:	8b 55 ec             	mov    -0x14(%ebp),%edx
  104799:	0f a3 10             	bt     %edx,(%eax)
  10479c:	19 c0                	sbb    %eax,%eax
  10479e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return oldbit != 0;
  1047a1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  1047a5:	0f 95 c0             	setne  %al
  1047a8:	0f b6 c0             	movzbl %al,%eax
  1047ab:	85 c0                	test   %eax,%eax
  1047ad:	75 24                	jne    1047d3 <default_free_pages+0x84>
  1047af:	c7 44 24 0c b9 6e 10 	movl   $0x106eb9,0xc(%esp)
  1047b6:	00 
  1047b7:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  1047be:	00 
  1047bf:	c7 44 24 04 cc 00 00 	movl   $0xcc,0x4(%esp)
  1047c6:	00 
  1047c7:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  1047ce:	e8 62 bc ff ff       	call   100435 <__panic>
    list_entry_t *le = &free_list; 
  1047d3:	c7 45 f4 1c cf 11 00 	movl   $0x11cf1c,-0xc(%ebp)
    }
    base->property = n;
    SetPageProperty(base);
    list_entry_t *le = list_next(&free_list);
    */
    while((le=list_next(le)) != &free_list) {    //寻找合适的位置
  1047da:	eb 11                	jmp    1047ed <default_free_pages+0x9e>
        p = le2page(le, page_link); //获取链表对应的Page
  1047dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1047df:	83 e8 0c             	sub    $0xc,%eax
  1047e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if(p>base){    
  1047e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1047e8:	3b 45 08             	cmp    0x8(%ebp),%eax
  1047eb:	77 1a                	ja     104807 <default_free_pages+0xb8>
  1047ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1047f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1047f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1047f6:	8b 40 04             	mov    0x4(%eax),%eax
    while((le=list_next(le)) != &free_list) {    //寻找合适的位置
  1047f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1047fc:	81 7d f4 1c cf 11 00 	cmpl   $0x11cf1c,-0xc(%ebp)
  104803:	75 d7                	jne    1047dc <default_free_pages+0x8d>
  104805:	eb 01                	jmp    104808 <default_free_pages+0xb9>
            break;
  104807:	90                   	nop
        }
    } 
    for(p=base;p<base+n;p++){              
  104808:	8b 45 08             	mov    0x8(%ebp),%eax
  10480b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10480e:	eb 4d                	jmp    10485d <default_free_pages+0x10e>
        list_add_before(le, &(p->page_link)); //将每一空闲块对应的链表插入空闲链表中
  104810:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104813:	8d 50 0c             	lea    0xc(%eax),%edx
  104816:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104819:	89 45 dc             	mov    %eax,-0x24(%ebp)
  10481c:	89 55 d8             	mov    %edx,-0x28(%ebp)
    __list_add(elm, listelm->prev, listelm);
  10481f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  104822:	8b 00                	mov    (%eax),%eax
  104824:	8b 55 d8             	mov    -0x28(%ebp),%edx
  104827:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  10482a:	89 45 d0             	mov    %eax,-0x30(%ebp)
  10482d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  104830:	89 45 cc             	mov    %eax,-0x34(%ebp)
    prev->next = next->prev = elm;
  104833:	8b 45 cc             	mov    -0x34(%ebp),%eax
  104836:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  104839:	89 10                	mov    %edx,(%eax)
  10483b:	8b 45 cc             	mov    -0x34(%ebp),%eax
  10483e:	8b 10                	mov    (%eax),%edx
  104840:	8b 45 d0             	mov    -0x30(%ebp),%eax
  104843:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
  104846:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  104849:	8b 55 cc             	mov    -0x34(%ebp),%edx
  10484c:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
  10484f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  104852:	8b 55 d0             	mov    -0x30(%ebp),%edx
  104855:	89 10                	mov    %edx,(%eax)
}
  104857:	90                   	nop
}
  104858:	90                   	nop
    for(p=base;p<base+n;p++){              
  104859:	83 45 f0 14          	addl   $0x14,-0x10(%ebp)
  10485d:	8b 55 0c             	mov    0xc(%ebp),%edx
  104860:	89 d0                	mov    %edx,%eax
  104862:	c1 e0 02             	shl    $0x2,%eax
  104865:	01 d0                	add    %edx,%eax
  104867:	c1 e0 02             	shl    $0x2,%eax
  10486a:	89 c2                	mov    %eax,%edx
  10486c:	8b 45 08             	mov    0x8(%ebp),%eax
  10486f:	01 d0                	add    %edx,%eax
  104871:	39 45 f0             	cmp    %eax,-0x10(%ebp)
  104874:	72 9a                	jb     104810 <default_free_pages+0xc1>
    } 
    base->flags = 0;         //修改标志位
  104876:	8b 45 08             	mov    0x8(%ebp),%eax
  104879:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    set_page_ref(base, 0);    
  104880:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  104887:	00 
  104888:	8b 45 08             	mov    0x8(%ebp),%eax
  10488b:	89 04 24             	mov    %eax,(%esp)
  10488e:	e8 9c fb ff ff       	call   10442f <set_page_ref>
    ClearPageProperty(base);
  104893:	8b 45 08             	mov    0x8(%ebp),%eax
  104896:	83 c0 04             	add    $0x4,%eax
  104899:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  1048a0:	89 45 bc             	mov    %eax,-0x44(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  1048a3:	8b 45 bc             	mov    -0x44(%ebp),%eax
  1048a6:	8b 55 c0             	mov    -0x40(%ebp),%edx
  1048a9:	0f b3 10             	btr    %edx,(%eax)
}
  1048ac:	90                   	nop
    SetPageProperty(base);
  1048ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1048b0:	83 c0 04             	add    $0x4,%eax
  1048b3:	c7 45 c8 01 00 00 00 	movl   $0x1,-0x38(%ebp)
  1048ba:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
  1048bd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  1048c0:	8b 55 c8             	mov    -0x38(%ebp),%edx
  1048c3:	0f ab 10             	bts    %edx,(%eax)
}
  1048c6:	90                   	nop
    base->property = n;      //设置连续大小为n
  1048c7:	8b 45 08             	mov    0x8(%ebp),%eax
  1048ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  1048cd:	89 50 08             	mov    %edx,0x8(%eax)
    //如果是高位，则向高地址合并
    p = le2page(le,page_link) ;
  1048d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1048d3:	83 e8 0c             	sub    $0xc,%eax
  1048d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if( base+n == p ){
  1048d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  1048dc:	89 d0                	mov    %edx,%eax
  1048de:	c1 e0 02             	shl    $0x2,%eax
  1048e1:	01 d0                	add    %edx,%eax
  1048e3:	c1 e0 02             	shl    $0x2,%eax
  1048e6:	89 c2                	mov    %eax,%edx
  1048e8:	8b 45 08             	mov    0x8(%ebp),%eax
  1048eb:	01 d0                	add    %edx,%eax
  1048ed:	39 45 f0             	cmp    %eax,-0x10(%ebp)
  1048f0:	75 1e                	jne    104910 <default_free_pages+0x1c1>
        base->property += p->property;
  1048f2:	8b 45 08             	mov    0x8(%ebp),%eax
  1048f5:	8b 50 08             	mov    0x8(%eax),%edx
  1048f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1048fb:	8b 40 08             	mov    0x8(%eax),%eax
  1048fe:	01 c2                	add    %eax,%edx
  104900:	8b 45 08             	mov    0x8(%ebp),%eax
  104903:	89 50 08             	mov    %edx,0x8(%eax)
        p->property = 0;
  104906:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104909:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    }
     //如果是低位且在范围内，则向低地址合并
    le = list_prev(&(base->page_link));
  104910:	8b 45 08             	mov    0x8(%ebp),%eax
  104913:	83 c0 0c             	add    $0xc,%eax
  104916:	89 45 b8             	mov    %eax,-0x48(%ebp)
    return listelm->prev;
  104919:	8b 45 b8             	mov    -0x48(%ebp),%eax
  10491c:	8b 00                	mov    (%eax),%eax
  10491e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    p = le2page(le, page_link);
  104921:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104924:	83 e8 0c             	sub    $0xc,%eax
  104927:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(le!=&free_list && p==base-1){ //满足条件，未分配则合并
  10492a:	81 7d f4 1c cf 11 00 	cmpl   $0x11cf1c,-0xc(%ebp)
  104931:	74 57                	je     10498a <default_free_pages+0x23b>
  104933:	8b 45 08             	mov    0x8(%ebp),%eax
  104936:	83 e8 14             	sub    $0x14,%eax
  104939:	39 45 f0             	cmp    %eax,-0x10(%ebp)
  10493c:	75 4c                	jne    10498a <default_free_pages+0x23b>
        while(le!=&free_list){
  10493e:	eb 41                	jmp    104981 <default_free_pages+0x232>
            if(p->property){ //连续
  104940:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104943:	8b 40 08             	mov    0x8(%eax),%eax
  104946:	85 c0                	test   %eax,%eax
  104948:	74 20                	je     10496a <default_free_pages+0x21b>
                p->property += base->property;
  10494a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10494d:	8b 50 08             	mov    0x8(%eax),%edx
  104950:	8b 45 08             	mov    0x8(%ebp),%eax
  104953:	8b 40 08             	mov    0x8(%eax),%eax
  104956:	01 c2                	add    %eax,%edx
  104958:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10495b:	89 50 08             	mov    %edx,0x8(%eax)
                base->property = 0;
  10495e:	8b 45 08             	mov    0x8(%ebp),%eax
  104961:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
            break;
  104968:	eb 20                	jmp    10498a <default_free_pages+0x23b>
  10496a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10496d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  104970:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  104973:	8b 00                	mov    (%eax),%eax
            }
            le = list_prev(le);
  104975:	89 45 f4             	mov    %eax,-0xc(%ebp)
            p = le2page(le,page_link);
  104978:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10497b:	83 e8 0c             	sub    $0xc,%eax
  10497e:	89 45 f0             	mov    %eax,-0x10(%ebp)
        while(le!=&free_list){
  104981:	81 7d f4 1c cf 11 00 	cmpl   $0x11cf1c,-0xc(%ebp)
  104988:	75 b6                	jne    104940 <default_free_pages+0x1f1>
        }
    }

    nr_free += n;
  10498a:	8b 15 24 cf 11 00    	mov    0x11cf24,%edx
  104990:	8b 45 0c             	mov    0xc(%ebp),%eax
  104993:	01 d0                	add    %edx,%eax
  104995:	a3 24 cf 11 00       	mov    %eax,0x11cf24
    return ;
  10499a:	90                   	nop
        }
    }
    nr_free += n;
    list_add(&free_list, &(base->page_link));
    */
}
  10499b:	c9                   	leave  
  10499c:	c3                   	ret    

0010499d <default_nr_free_pages>:

static size_t
default_nr_free_pages(void) {
  10499d:	f3 0f 1e fb          	endbr32 
  1049a1:	55                   	push   %ebp
  1049a2:	89 e5                	mov    %esp,%ebp
    return nr_free;
  1049a4:	a1 24 cf 11 00       	mov    0x11cf24,%eax
}
  1049a9:	5d                   	pop    %ebp
  1049aa:	c3                   	ret    

001049ab <basic_check>:

static void
basic_check(void) {
  1049ab:	f3 0f 1e fb          	endbr32 
  1049af:	55                   	push   %ebp
  1049b0:	89 e5                	mov    %esp,%ebp
  1049b2:	83 ec 48             	sub    $0x48,%esp
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
  1049b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1049bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1049bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1049c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1049c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert((p0 = alloc_page()) != NULL);
  1049c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1049cf:	e8 56 e3 ff ff       	call   102d2a <alloc_pages>
  1049d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1049d7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  1049db:	75 24                	jne    104a01 <basic_check+0x56>
  1049dd:	c7 44 24 0c cc 6e 10 	movl   $0x106ecc,0xc(%esp)
  1049e4:	00 
  1049e5:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  1049ec:	00 
  1049ed:	c7 44 24 04 1d 01 00 	movl   $0x11d,0x4(%esp)
  1049f4:	00 
  1049f5:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  1049fc:	e8 34 ba ff ff       	call   100435 <__panic>
    assert((p1 = alloc_page()) != NULL);
  104a01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104a08:	e8 1d e3 ff ff       	call   102d2a <alloc_pages>
  104a0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  104a10:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  104a14:	75 24                	jne    104a3a <basic_check+0x8f>
  104a16:	c7 44 24 0c e8 6e 10 	movl   $0x106ee8,0xc(%esp)
  104a1d:	00 
  104a1e:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104a25:	00 
  104a26:	c7 44 24 04 1e 01 00 	movl   $0x11e,0x4(%esp)
  104a2d:	00 
  104a2e:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104a35:	e8 fb b9 ff ff       	call   100435 <__panic>
    assert((p2 = alloc_page()) != NULL);
  104a3a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104a41:	e8 e4 e2 ff ff       	call   102d2a <alloc_pages>
  104a46:	89 45 f4             	mov    %eax,-0xc(%ebp)
  104a49:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  104a4d:	75 24                	jne    104a73 <basic_check+0xc8>
  104a4f:	c7 44 24 0c 04 6f 10 	movl   $0x106f04,0xc(%esp)
  104a56:	00 
  104a57:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104a5e:	00 
  104a5f:	c7 44 24 04 1f 01 00 	movl   $0x11f,0x4(%esp)
  104a66:	00 
  104a67:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104a6e:	e8 c2 b9 ff ff       	call   100435 <__panic>

    assert(p0 != p1 && p0 != p2 && p1 != p2);
  104a73:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104a76:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  104a79:	74 10                	je     104a8b <basic_check+0xe0>
  104a7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104a7e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  104a81:	74 08                	je     104a8b <basic_check+0xe0>
  104a83:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104a86:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  104a89:	75 24                	jne    104aaf <basic_check+0x104>
  104a8b:	c7 44 24 0c 20 6f 10 	movl   $0x106f20,0xc(%esp)
  104a92:	00 
  104a93:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104a9a:	00 
  104a9b:	c7 44 24 04 21 01 00 	movl   $0x121,0x4(%esp)
  104aa2:	00 
  104aa3:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104aaa:	e8 86 b9 ff ff       	call   100435 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
  104aaf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104ab2:	89 04 24             	mov    %eax,(%esp)
  104ab5:	e8 6b f9 ff ff       	call   104425 <page_ref>
  104aba:	85 c0                	test   %eax,%eax
  104abc:	75 1e                	jne    104adc <basic_check+0x131>
  104abe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104ac1:	89 04 24             	mov    %eax,(%esp)
  104ac4:	e8 5c f9 ff ff       	call   104425 <page_ref>
  104ac9:	85 c0                	test   %eax,%eax
  104acb:	75 0f                	jne    104adc <basic_check+0x131>
  104acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104ad0:	89 04 24             	mov    %eax,(%esp)
  104ad3:	e8 4d f9 ff ff       	call   104425 <page_ref>
  104ad8:	85 c0                	test   %eax,%eax
  104ada:	74 24                	je     104b00 <basic_check+0x155>
  104adc:	c7 44 24 0c 44 6f 10 	movl   $0x106f44,0xc(%esp)
  104ae3:	00 
  104ae4:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104aeb:	00 
  104aec:	c7 44 24 04 22 01 00 	movl   $0x122,0x4(%esp)
  104af3:	00 
  104af4:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104afb:	e8 35 b9 ff ff       	call   100435 <__panic>

    assert(page2pa(p0) < npage * PGSIZE);
  104b00:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104b03:	89 04 24             	mov    %eax,(%esp)
  104b06:	e8 04 f9 ff ff       	call   10440f <page2pa>
  104b0b:	8b 15 80 ce 11 00    	mov    0x11ce80,%edx
  104b11:	c1 e2 0c             	shl    $0xc,%edx
  104b14:	39 d0                	cmp    %edx,%eax
  104b16:	72 24                	jb     104b3c <basic_check+0x191>
  104b18:	c7 44 24 0c 80 6f 10 	movl   $0x106f80,0xc(%esp)
  104b1f:	00 
  104b20:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104b27:	00 
  104b28:	c7 44 24 04 24 01 00 	movl   $0x124,0x4(%esp)
  104b2f:	00 
  104b30:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104b37:	e8 f9 b8 ff ff       	call   100435 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
  104b3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104b3f:	89 04 24             	mov    %eax,(%esp)
  104b42:	e8 c8 f8 ff ff       	call   10440f <page2pa>
  104b47:	8b 15 80 ce 11 00    	mov    0x11ce80,%edx
  104b4d:	c1 e2 0c             	shl    $0xc,%edx
  104b50:	39 d0                	cmp    %edx,%eax
  104b52:	72 24                	jb     104b78 <basic_check+0x1cd>
  104b54:	c7 44 24 0c 9d 6f 10 	movl   $0x106f9d,0xc(%esp)
  104b5b:	00 
  104b5c:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104b63:	00 
  104b64:	c7 44 24 04 25 01 00 	movl   $0x125,0x4(%esp)
  104b6b:	00 
  104b6c:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104b73:	e8 bd b8 ff ff       	call   100435 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
  104b78:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104b7b:	89 04 24             	mov    %eax,(%esp)
  104b7e:	e8 8c f8 ff ff       	call   10440f <page2pa>
  104b83:	8b 15 80 ce 11 00    	mov    0x11ce80,%edx
  104b89:	c1 e2 0c             	shl    $0xc,%edx
  104b8c:	39 d0                	cmp    %edx,%eax
  104b8e:	72 24                	jb     104bb4 <basic_check+0x209>
  104b90:	c7 44 24 0c ba 6f 10 	movl   $0x106fba,0xc(%esp)
  104b97:	00 
  104b98:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104b9f:	00 
  104ba0:	c7 44 24 04 26 01 00 	movl   $0x126,0x4(%esp)
  104ba7:	00 
  104ba8:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104baf:	e8 81 b8 ff ff       	call   100435 <__panic>

    list_entry_t free_list_store = free_list;
  104bb4:	a1 1c cf 11 00       	mov    0x11cf1c,%eax
  104bb9:	8b 15 20 cf 11 00    	mov    0x11cf20,%edx
  104bbf:	89 45 d0             	mov    %eax,-0x30(%ebp)
  104bc2:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  104bc5:	c7 45 dc 1c cf 11 00 	movl   $0x11cf1c,-0x24(%ebp)
    elm->prev = elm->next = elm;
  104bcc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  104bcf:	8b 55 dc             	mov    -0x24(%ebp),%edx
  104bd2:	89 50 04             	mov    %edx,0x4(%eax)
  104bd5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  104bd8:	8b 50 04             	mov    0x4(%eax),%edx
  104bdb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  104bde:	89 10                	mov    %edx,(%eax)
}
  104be0:	90                   	nop
  104be1:	c7 45 e0 1c cf 11 00 	movl   $0x11cf1c,-0x20(%ebp)
    return list->next == list;
  104be8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  104beb:	8b 40 04             	mov    0x4(%eax),%eax
  104bee:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  104bf1:	0f 94 c0             	sete   %al
  104bf4:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
  104bf7:	85 c0                	test   %eax,%eax
  104bf9:	75 24                	jne    104c1f <basic_check+0x274>
  104bfb:	c7 44 24 0c d7 6f 10 	movl   $0x106fd7,0xc(%esp)
  104c02:	00 
  104c03:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104c0a:	00 
  104c0b:	c7 44 24 04 2a 01 00 	movl   $0x12a,0x4(%esp)
  104c12:	00 
  104c13:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104c1a:	e8 16 b8 ff ff       	call   100435 <__panic>

    unsigned int nr_free_store = nr_free;
  104c1f:	a1 24 cf 11 00       	mov    0x11cf24,%eax
  104c24:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nr_free = 0;
  104c27:	c7 05 24 cf 11 00 00 	movl   $0x0,0x11cf24
  104c2e:	00 00 00 

    assert(alloc_page() == NULL);
  104c31:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104c38:	e8 ed e0 ff ff       	call   102d2a <alloc_pages>
  104c3d:	85 c0                	test   %eax,%eax
  104c3f:	74 24                	je     104c65 <basic_check+0x2ba>
  104c41:	c7 44 24 0c ee 6f 10 	movl   $0x106fee,0xc(%esp)
  104c48:	00 
  104c49:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104c50:	00 
  104c51:	c7 44 24 04 2f 01 00 	movl   $0x12f,0x4(%esp)
  104c58:	00 
  104c59:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104c60:	e8 d0 b7 ff ff       	call   100435 <__panic>

    free_page(p0);
  104c65:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  104c6c:	00 
  104c6d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104c70:	89 04 24             	mov    %eax,(%esp)
  104c73:	e8 ee e0 ff ff       	call   102d66 <free_pages>
    free_page(p1);
  104c78:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  104c7f:	00 
  104c80:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104c83:	89 04 24             	mov    %eax,(%esp)
  104c86:	e8 db e0 ff ff       	call   102d66 <free_pages>
    free_page(p2);
  104c8b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  104c92:	00 
  104c93:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104c96:	89 04 24             	mov    %eax,(%esp)
  104c99:	e8 c8 e0 ff ff       	call   102d66 <free_pages>
    assert(nr_free == 3);
  104c9e:	a1 24 cf 11 00       	mov    0x11cf24,%eax
  104ca3:	83 f8 03             	cmp    $0x3,%eax
  104ca6:	74 24                	je     104ccc <basic_check+0x321>
  104ca8:	c7 44 24 0c 03 70 10 	movl   $0x107003,0xc(%esp)
  104caf:	00 
  104cb0:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104cb7:	00 
  104cb8:	c7 44 24 04 34 01 00 	movl   $0x134,0x4(%esp)
  104cbf:	00 
  104cc0:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104cc7:	e8 69 b7 ff ff       	call   100435 <__panic>

    assert((p0 = alloc_page()) != NULL);
  104ccc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104cd3:	e8 52 e0 ff ff       	call   102d2a <alloc_pages>
  104cd8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  104cdb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  104cdf:	75 24                	jne    104d05 <basic_check+0x35a>
  104ce1:	c7 44 24 0c cc 6e 10 	movl   $0x106ecc,0xc(%esp)
  104ce8:	00 
  104ce9:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104cf0:	00 
  104cf1:	c7 44 24 04 36 01 00 	movl   $0x136,0x4(%esp)
  104cf8:	00 
  104cf9:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104d00:	e8 30 b7 ff ff       	call   100435 <__panic>
    assert((p1 = alloc_page()) != NULL);
  104d05:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104d0c:	e8 19 e0 ff ff       	call   102d2a <alloc_pages>
  104d11:	89 45 f0             	mov    %eax,-0x10(%ebp)
  104d14:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  104d18:	75 24                	jne    104d3e <basic_check+0x393>
  104d1a:	c7 44 24 0c e8 6e 10 	movl   $0x106ee8,0xc(%esp)
  104d21:	00 
  104d22:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104d29:	00 
  104d2a:	c7 44 24 04 37 01 00 	movl   $0x137,0x4(%esp)
  104d31:	00 
  104d32:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104d39:	e8 f7 b6 ff ff       	call   100435 <__panic>
    assert((p2 = alloc_page()) != NULL);
  104d3e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104d45:	e8 e0 df ff ff       	call   102d2a <alloc_pages>
  104d4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  104d4d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  104d51:	75 24                	jne    104d77 <basic_check+0x3cc>
  104d53:	c7 44 24 0c 04 6f 10 	movl   $0x106f04,0xc(%esp)
  104d5a:	00 
  104d5b:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104d62:	00 
  104d63:	c7 44 24 04 38 01 00 	movl   $0x138,0x4(%esp)
  104d6a:	00 
  104d6b:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104d72:	e8 be b6 ff ff       	call   100435 <__panic>

    assert(alloc_page() == NULL);
  104d77:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104d7e:	e8 a7 df ff ff       	call   102d2a <alloc_pages>
  104d83:	85 c0                	test   %eax,%eax
  104d85:	74 24                	je     104dab <basic_check+0x400>
  104d87:	c7 44 24 0c ee 6f 10 	movl   $0x106fee,0xc(%esp)
  104d8e:	00 
  104d8f:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104d96:	00 
  104d97:	c7 44 24 04 3a 01 00 	movl   $0x13a,0x4(%esp)
  104d9e:	00 
  104d9f:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104da6:	e8 8a b6 ff ff       	call   100435 <__panic>

    free_page(p0);
  104dab:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  104db2:	00 
  104db3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104db6:	89 04 24             	mov    %eax,(%esp)
  104db9:	e8 a8 df ff ff       	call   102d66 <free_pages>
  104dbe:	c7 45 d8 1c cf 11 00 	movl   $0x11cf1c,-0x28(%ebp)
  104dc5:	8b 45 d8             	mov    -0x28(%ebp),%eax
  104dc8:	8b 40 04             	mov    0x4(%eax),%eax
  104dcb:	39 45 d8             	cmp    %eax,-0x28(%ebp)
  104dce:	0f 94 c0             	sete   %al
  104dd1:	0f b6 c0             	movzbl %al,%eax
    assert(!list_empty(&free_list));
  104dd4:	85 c0                	test   %eax,%eax
  104dd6:	74 24                	je     104dfc <basic_check+0x451>
  104dd8:	c7 44 24 0c 10 70 10 	movl   $0x107010,0xc(%esp)
  104ddf:	00 
  104de0:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104de7:	00 
  104de8:	c7 44 24 04 3d 01 00 	movl   $0x13d,0x4(%esp)
  104def:	00 
  104df0:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104df7:	e8 39 b6 ff ff       	call   100435 <__panic>

    struct Page *p;
    assert((p = alloc_page()) == p0);
  104dfc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104e03:	e8 22 df ff ff       	call   102d2a <alloc_pages>
  104e08:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  104e0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104e0e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  104e11:	74 24                	je     104e37 <basic_check+0x48c>
  104e13:	c7 44 24 0c 28 70 10 	movl   $0x107028,0xc(%esp)
  104e1a:	00 
  104e1b:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104e22:	00 
  104e23:	c7 44 24 04 40 01 00 	movl   $0x140,0x4(%esp)
  104e2a:	00 
  104e2b:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104e32:	e8 fe b5 ff ff       	call   100435 <__panic>
    assert(alloc_page() == NULL);
  104e37:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  104e3e:	e8 e7 de ff ff       	call   102d2a <alloc_pages>
  104e43:	85 c0                	test   %eax,%eax
  104e45:	74 24                	je     104e6b <basic_check+0x4c0>
  104e47:	c7 44 24 0c ee 6f 10 	movl   $0x106fee,0xc(%esp)
  104e4e:	00 
  104e4f:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104e56:	00 
  104e57:	c7 44 24 04 41 01 00 	movl   $0x141,0x4(%esp)
  104e5e:	00 
  104e5f:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104e66:	e8 ca b5 ff ff       	call   100435 <__panic>

    assert(nr_free == 0);
  104e6b:	a1 24 cf 11 00       	mov    0x11cf24,%eax
  104e70:	85 c0                	test   %eax,%eax
  104e72:	74 24                	je     104e98 <basic_check+0x4ed>
  104e74:	c7 44 24 0c 41 70 10 	movl   $0x107041,0xc(%esp)
  104e7b:	00 
  104e7c:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104e83:	00 
  104e84:	c7 44 24 04 43 01 00 	movl   $0x143,0x4(%esp)
  104e8b:	00 
  104e8c:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104e93:	e8 9d b5 ff ff       	call   100435 <__panic>
    free_list = free_list_store;
  104e98:	8b 45 d0             	mov    -0x30(%ebp),%eax
  104e9b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  104e9e:	a3 1c cf 11 00       	mov    %eax,0x11cf1c
  104ea3:	89 15 20 cf 11 00    	mov    %edx,0x11cf20
    nr_free = nr_free_store;
  104ea9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  104eac:	a3 24 cf 11 00       	mov    %eax,0x11cf24

    free_page(p);
  104eb1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  104eb8:	00 
  104eb9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  104ebc:	89 04 24             	mov    %eax,(%esp)
  104ebf:	e8 a2 de ff ff       	call   102d66 <free_pages>
    free_page(p1);
  104ec4:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  104ecb:	00 
  104ecc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104ecf:	89 04 24             	mov    %eax,(%esp)
  104ed2:	e8 8f de ff ff       	call   102d66 <free_pages>
    free_page(p2);
  104ed7:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  104ede:	00 
  104edf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  104ee2:	89 04 24             	mov    %eax,(%esp)
  104ee5:	e8 7c de ff ff       	call   102d66 <free_pages>
}
  104eea:	90                   	nop
  104eeb:	c9                   	leave  
  104eec:	c3                   	ret    

00104eed <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
  104eed:	f3 0f 1e fb          	endbr32 
  104ef1:	55                   	push   %ebp
  104ef2:	89 e5                	mov    %esp,%ebp
  104ef4:	81 ec 98 00 00 00    	sub    $0x98,%esp
    int count = 0, total = 0;
  104efa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  104f01:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    list_entry_t *le = &free_list;
  104f08:	c7 45 ec 1c cf 11 00 	movl   $0x11cf1c,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
  104f0f:	eb 6a                	jmp    104f7b <default_check+0x8e>
        struct Page *p = le2page(le, page_link);
  104f11:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104f14:	83 e8 0c             	sub    $0xc,%eax
  104f17:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        assert(PageProperty(p));
  104f1a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  104f1d:	83 c0 04             	add    $0x4,%eax
  104f20:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
  104f27:	89 45 cc             	mov    %eax,-0x34(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  104f2a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  104f2d:	8b 55 d0             	mov    -0x30(%ebp),%edx
  104f30:	0f a3 10             	bt     %edx,(%eax)
  104f33:	19 c0                	sbb    %eax,%eax
  104f35:	89 45 c8             	mov    %eax,-0x38(%ebp)
    return oldbit != 0;
  104f38:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
  104f3c:	0f 95 c0             	setne  %al
  104f3f:	0f b6 c0             	movzbl %al,%eax
  104f42:	85 c0                	test   %eax,%eax
  104f44:	75 24                	jne    104f6a <default_check+0x7d>
  104f46:	c7 44 24 0c 4e 70 10 	movl   $0x10704e,0xc(%esp)
  104f4d:	00 
  104f4e:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104f55:	00 
  104f56:	c7 44 24 04 54 01 00 	movl   $0x154,0x4(%esp)
  104f5d:	00 
  104f5e:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104f65:	e8 cb b4 ff ff       	call   100435 <__panic>
        count ++, total += p->property;
  104f6a:	ff 45 f4             	incl   -0xc(%ebp)
  104f6d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  104f70:	8b 50 08             	mov    0x8(%eax),%edx
  104f73:	8b 45 f0             	mov    -0x10(%ebp),%eax
  104f76:	01 d0                	add    %edx,%eax
  104f78:	89 45 f0             	mov    %eax,-0x10(%ebp)
  104f7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  104f7e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return listelm->next;
  104f81:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  104f84:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
  104f87:	89 45 ec             	mov    %eax,-0x14(%ebp)
  104f8a:	81 7d ec 1c cf 11 00 	cmpl   $0x11cf1c,-0x14(%ebp)
  104f91:	0f 85 7a ff ff ff    	jne    104f11 <default_check+0x24>
    }
    assert(total == nr_free_pages());
  104f97:	e8 01 de ff ff       	call   102d9d <nr_free_pages>
  104f9c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  104f9f:	39 d0                	cmp    %edx,%eax
  104fa1:	74 24                	je     104fc7 <default_check+0xda>
  104fa3:	c7 44 24 0c 5e 70 10 	movl   $0x10705e,0xc(%esp)
  104faa:	00 
  104fab:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104fb2:	00 
  104fb3:	c7 44 24 04 57 01 00 	movl   $0x157,0x4(%esp)
  104fba:	00 
  104fbb:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  104fc2:	e8 6e b4 ff ff       	call   100435 <__panic>

    basic_check();
  104fc7:	e8 df f9 ff ff       	call   1049ab <basic_check>

    struct Page *p0 = alloc_pages(5), *p1, *p2;
  104fcc:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  104fd3:	e8 52 dd ff ff       	call   102d2a <alloc_pages>
  104fd8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    assert(p0 != NULL);
  104fdb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  104fdf:	75 24                	jne    105005 <default_check+0x118>
  104fe1:	c7 44 24 0c 77 70 10 	movl   $0x107077,0xc(%esp)
  104fe8:	00 
  104fe9:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  104ff0:	00 
  104ff1:	c7 44 24 04 5c 01 00 	movl   $0x15c,0x4(%esp)
  104ff8:	00 
  104ff9:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  105000:	e8 30 b4 ff ff       	call   100435 <__panic>
    assert(!PageProperty(p0));
  105005:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105008:	83 c0 04             	add    $0x4,%eax
  10500b:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  105012:	89 45 bc             	mov    %eax,-0x44(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  105015:	8b 45 bc             	mov    -0x44(%ebp),%eax
  105018:	8b 55 c0             	mov    -0x40(%ebp),%edx
  10501b:	0f a3 10             	bt     %edx,(%eax)
  10501e:	19 c0                	sbb    %eax,%eax
  105020:	89 45 b8             	mov    %eax,-0x48(%ebp)
    return oldbit != 0;
  105023:	83 7d b8 00          	cmpl   $0x0,-0x48(%ebp)
  105027:	0f 95 c0             	setne  %al
  10502a:	0f b6 c0             	movzbl %al,%eax
  10502d:	85 c0                	test   %eax,%eax
  10502f:	74 24                	je     105055 <default_check+0x168>
  105031:	c7 44 24 0c 82 70 10 	movl   $0x107082,0xc(%esp)
  105038:	00 
  105039:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  105040:	00 
  105041:	c7 44 24 04 5d 01 00 	movl   $0x15d,0x4(%esp)
  105048:	00 
  105049:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  105050:	e8 e0 b3 ff ff       	call   100435 <__panic>

    list_entry_t free_list_store = free_list;
  105055:	a1 1c cf 11 00       	mov    0x11cf1c,%eax
  10505a:	8b 15 20 cf 11 00    	mov    0x11cf20,%edx
  105060:	89 45 80             	mov    %eax,-0x80(%ebp)
  105063:	89 55 84             	mov    %edx,-0x7c(%ebp)
  105066:	c7 45 b0 1c cf 11 00 	movl   $0x11cf1c,-0x50(%ebp)
    elm->prev = elm->next = elm;
  10506d:	8b 45 b0             	mov    -0x50(%ebp),%eax
  105070:	8b 55 b0             	mov    -0x50(%ebp),%edx
  105073:	89 50 04             	mov    %edx,0x4(%eax)
  105076:	8b 45 b0             	mov    -0x50(%ebp),%eax
  105079:	8b 50 04             	mov    0x4(%eax),%edx
  10507c:	8b 45 b0             	mov    -0x50(%ebp),%eax
  10507f:	89 10                	mov    %edx,(%eax)
}
  105081:	90                   	nop
  105082:	c7 45 b4 1c cf 11 00 	movl   $0x11cf1c,-0x4c(%ebp)
    return list->next == list;
  105089:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  10508c:	8b 40 04             	mov    0x4(%eax),%eax
  10508f:	39 45 b4             	cmp    %eax,-0x4c(%ebp)
  105092:	0f 94 c0             	sete   %al
  105095:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
  105098:	85 c0                	test   %eax,%eax
  10509a:	75 24                	jne    1050c0 <default_check+0x1d3>
  10509c:	c7 44 24 0c d7 6f 10 	movl   $0x106fd7,0xc(%esp)
  1050a3:	00 
  1050a4:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  1050ab:	00 
  1050ac:	c7 44 24 04 61 01 00 	movl   $0x161,0x4(%esp)
  1050b3:	00 
  1050b4:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  1050bb:	e8 75 b3 ff ff       	call   100435 <__panic>
    assert(alloc_page() == NULL);
  1050c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1050c7:	e8 5e dc ff ff       	call   102d2a <alloc_pages>
  1050cc:	85 c0                	test   %eax,%eax
  1050ce:	74 24                	je     1050f4 <default_check+0x207>
  1050d0:	c7 44 24 0c ee 6f 10 	movl   $0x106fee,0xc(%esp)
  1050d7:	00 
  1050d8:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  1050df:	00 
  1050e0:	c7 44 24 04 62 01 00 	movl   $0x162,0x4(%esp)
  1050e7:	00 
  1050e8:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  1050ef:	e8 41 b3 ff ff       	call   100435 <__panic>

    unsigned int nr_free_store = nr_free;
  1050f4:	a1 24 cf 11 00       	mov    0x11cf24,%eax
  1050f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nr_free = 0;
  1050fc:	c7 05 24 cf 11 00 00 	movl   $0x0,0x11cf24
  105103:	00 00 00 

    free_pages(p0 + 2, 3);
  105106:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105109:	83 c0 28             	add    $0x28,%eax
  10510c:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  105113:	00 
  105114:	89 04 24             	mov    %eax,(%esp)
  105117:	e8 4a dc ff ff       	call   102d66 <free_pages>
    assert(alloc_pages(4) == NULL);
  10511c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  105123:	e8 02 dc ff ff       	call   102d2a <alloc_pages>
  105128:	85 c0                	test   %eax,%eax
  10512a:	74 24                	je     105150 <default_check+0x263>
  10512c:	c7 44 24 0c 94 70 10 	movl   $0x107094,0xc(%esp)
  105133:	00 
  105134:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  10513b:	00 
  10513c:	c7 44 24 04 68 01 00 	movl   $0x168,0x4(%esp)
  105143:	00 
  105144:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  10514b:	e8 e5 b2 ff ff       	call   100435 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
  105150:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105153:	83 c0 28             	add    $0x28,%eax
  105156:	83 c0 04             	add    $0x4,%eax
  105159:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
  105160:	89 45 a8             	mov    %eax,-0x58(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  105163:	8b 45 a8             	mov    -0x58(%ebp),%eax
  105166:	8b 55 ac             	mov    -0x54(%ebp),%edx
  105169:	0f a3 10             	bt     %edx,(%eax)
  10516c:	19 c0                	sbb    %eax,%eax
  10516e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    return oldbit != 0;
  105171:	83 7d a4 00          	cmpl   $0x0,-0x5c(%ebp)
  105175:	0f 95 c0             	setne  %al
  105178:	0f b6 c0             	movzbl %al,%eax
  10517b:	85 c0                	test   %eax,%eax
  10517d:	74 0e                	je     10518d <default_check+0x2a0>
  10517f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105182:	83 c0 28             	add    $0x28,%eax
  105185:	8b 40 08             	mov    0x8(%eax),%eax
  105188:	83 f8 03             	cmp    $0x3,%eax
  10518b:	74 24                	je     1051b1 <default_check+0x2c4>
  10518d:	c7 44 24 0c ac 70 10 	movl   $0x1070ac,0xc(%esp)
  105194:	00 
  105195:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  10519c:	00 
  10519d:	c7 44 24 04 69 01 00 	movl   $0x169,0x4(%esp)
  1051a4:	00 
  1051a5:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  1051ac:	e8 84 b2 ff ff       	call   100435 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
  1051b1:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
  1051b8:	e8 6d db ff ff       	call   102d2a <alloc_pages>
  1051bd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1051c0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  1051c4:	75 24                	jne    1051ea <default_check+0x2fd>
  1051c6:	c7 44 24 0c d8 70 10 	movl   $0x1070d8,0xc(%esp)
  1051cd:	00 
  1051ce:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  1051d5:	00 
  1051d6:	c7 44 24 04 6a 01 00 	movl   $0x16a,0x4(%esp)
  1051dd:	00 
  1051de:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  1051e5:	e8 4b b2 ff ff       	call   100435 <__panic>
    assert(alloc_page() == NULL);
  1051ea:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  1051f1:	e8 34 db ff ff       	call   102d2a <alloc_pages>
  1051f6:	85 c0                	test   %eax,%eax
  1051f8:	74 24                	je     10521e <default_check+0x331>
  1051fa:	c7 44 24 0c ee 6f 10 	movl   $0x106fee,0xc(%esp)
  105201:	00 
  105202:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  105209:	00 
  10520a:	c7 44 24 04 6b 01 00 	movl   $0x16b,0x4(%esp)
  105211:	00 
  105212:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  105219:	e8 17 b2 ff ff       	call   100435 <__panic>
    assert(p0 + 2 == p1);
  10521e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105221:	83 c0 28             	add    $0x28,%eax
  105224:	39 45 e0             	cmp    %eax,-0x20(%ebp)
  105227:	74 24                	je     10524d <default_check+0x360>
  105229:	c7 44 24 0c f6 70 10 	movl   $0x1070f6,0xc(%esp)
  105230:	00 
  105231:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  105238:	00 
  105239:	c7 44 24 04 6c 01 00 	movl   $0x16c,0x4(%esp)
  105240:	00 
  105241:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  105248:	e8 e8 b1 ff ff       	call   100435 <__panic>

    p2 = p0 + 1;
  10524d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105250:	83 c0 14             	add    $0x14,%eax
  105253:	89 45 dc             	mov    %eax,-0x24(%ebp)
    free_page(p0);
  105256:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10525d:	00 
  10525e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105261:	89 04 24             	mov    %eax,(%esp)
  105264:	e8 fd da ff ff       	call   102d66 <free_pages>
    free_pages(p1, 3);
  105269:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  105270:	00 
  105271:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105274:	89 04 24             	mov    %eax,(%esp)
  105277:	e8 ea da ff ff       	call   102d66 <free_pages>
    assert(PageProperty(p0) && p0->property == 1);
  10527c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10527f:	83 c0 04             	add    $0x4,%eax
  105282:	c7 45 a0 01 00 00 00 	movl   $0x1,-0x60(%ebp)
  105289:	89 45 9c             	mov    %eax,-0x64(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  10528c:	8b 45 9c             	mov    -0x64(%ebp),%eax
  10528f:	8b 55 a0             	mov    -0x60(%ebp),%edx
  105292:	0f a3 10             	bt     %edx,(%eax)
  105295:	19 c0                	sbb    %eax,%eax
  105297:	89 45 98             	mov    %eax,-0x68(%ebp)
    return oldbit != 0;
  10529a:	83 7d 98 00          	cmpl   $0x0,-0x68(%ebp)
  10529e:	0f 95 c0             	setne  %al
  1052a1:	0f b6 c0             	movzbl %al,%eax
  1052a4:	85 c0                	test   %eax,%eax
  1052a6:	74 0b                	je     1052b3 <default_check+0x3c6>
  1052a8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1052ab:	8b 40 08             	mov    0x8(%eax),%eax
  1052ae:	83 f8 01             	cmp    $0x1,%eax
  1052b1:	74 24                	je     1052d7 <default_check+0x3ea>
  1052b3:	c7 44 24 0c 04 71 10 	movl   $0x107104,0xc(%esp)
  1052ba:	00 
  1052bb:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  1052c2:	00 
  1052c3:	c7 44 24 04 71 01 00 	movl   $0x171,0x4(%esp)
  1052ca:	00 
  1052cb:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  1052d2:	e8 5e b1 ff ff       	call   100435 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
  1052d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1052da:	83 c0 04             	add    $0x4,%eax
  1052dd:	c7 45 94 01 00 00 00 	movl   $0x1,-0x6c(%ebp)
  1052e4:	89 45 90             	mov    %eax,-0x70(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
  1052e7:	8b 45 90             	mov    -0x70(%ebp),%eax
  1052ea:	8b 55 94             	mov    -0x6c(%ebp),%edx
  1052ed:	0f a3 10             	bt     %edx,(%eax)
  1052f0:	19 c0                	sbb    %eax,%eax
  1052f2:	89 45 8c             	mov    %eax,-0x74(%ebp)
    return oldbit != 0;
  1052f5:	83 7d 8c 00          	cmpl   $0x0,-0x74(%ebp)
  1052f9:	0f 95 c0             	setne  %al
  1052fc:	0f b6 c0             	movzbl %al,%eax
  1052ff:	85 c0                	test   %eax,%eax
  105301:	74 0b                	je     10530e <default_check+0x421>
  105303:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105306:	8b 40 08             	mov    0x8(%eax),%eax
  105309:	83 f8 03             	cmp    $0x3,%eax
  10530c:	74 24                	je     105332 <default_check+0x445>
  10530e:	c7 44 24 0c 2c 71 10 	movl   $0x10712c,0xc(%esp)
  105315:	00 
  105316:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  10531d:	00 
  10531e:	c7 44 24 04 72 01 00 	movl   $0x172,0x4(%esp)
  105325:	00 
  105326:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  10532d:	e8 03 b1 ff ff       	call   100435 <__panic>

    assert((p0 = alloc_page()) == p2 - 1);
  105332:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  105339:	e8 ec d9 ff ff       	call   102d2a <alloc_pages>
  10533e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  105341:	8b 45 dc             	mov    -0x24(%ebp),%eax
  105344:	83 e8 14             	sub    $0x14,%eax
  105347:	39 45 e8             	cmp    %eax,-0x18(%ebp)
  10534a:	74 24                	je     105370 <default_check+0x483>
  10534c:	c7 44 24 0c 52 71 10 	movl   $0x107152,0xc(%esp)
  105353:	00 
  105354:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  10535b:	00 
  10535c:	c7 44 24 04 74 01 00 	movl   $0x174,0x4(%esp)
  105363:	00 
  105364:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  10536b:	e8 c5 b0 ff ff       	call   100435 <__panic>
    free_page(p0);
  105370:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  105377:	00 
  105378:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10537b:	89 04 24             	mov    %eax,(%esp)
  10537e:	e8 e3 d9 ff ff       	call   102d66 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
  105383:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  10538a:	e8 9b d9 ff ff       	call   102d2a <alloc_pages>
  10538f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  105392:	8b 45 dc             	mov    -0x24(%ebp),%eax
  105395:	83 c0 14             	add    $0x14,%eax
  105398:	39 45 e8             	cmp    %eax,-0x18(%ebp)
  10539b:	74 24                	je     1053c1 <default_check+0x4d4>
  10539d:	c7 44 24 0c 70 71 10 	movl   $0x107170,0xc(%esp)
  1053a4:	00 
  1053a5:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  1053ac:	00 
  1053ad:	c7 44 24 04 76 01 00 	movl   $0x176,0x4(%esp)
  1053b4:	00 
  1053b5:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  1053bc:	e8 74 b0 ff ff       	call   100435 <__panic>

    free_pages(p0, 2);
  1053c1:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  1053c8:	00 
  1053c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1053cc:	89 04 24             	mov    %eax,(%esp)
  1053cf:	e8 92 d9 ff ff       	call   102d66 <free_pages>
    free_page(p2);
  1053d4:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  1053db:	00 
  1053dc:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1053df:	89 04 24             	mov    %eax,(%esp)
  1053e2:	e8 7f d9 ff ff       	call   102d66 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
  1053e7:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  1053ee:	e8 37 d9 ff ff       	call   102d2a <alloc_pages>
  1053f3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1053f6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1053fa:	75 24                	jne    105420 <default_check+0x533>
  1053fc:	c7 44 24 0c 90 71 10 	movl   $0x107190,0xc(%esp)
  105403:	00 
  105404:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  10540b:	00 
  10540c:	c7 44 24 04 7b 01 00 	movl   $0x17b,0x4(%esp)
  105413:	00 
  105414:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  10541b:	e8 15 b0 ff ff       	call   100435 <__panic>
    assert(alloc_page() == NULL);
  105420:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  105427:	e8 fe d8 ff ff       	call   102d2a <alloc_pages>
  10542c:	85 c0                	test   %eax,%eax
  10542e:	74 24                	je     105454 <default_check+0x567>
  105430:	c7 44 24 0c ee 6f 10 	movl   $0x106fee,0xc(%esp)
  105437:	00 
  105438:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  10543f:	00 
  105440:	c7 44 24 04 7c 01 00 	movl   $0x17c,0x4(%esp)
  105447:	00 
  105448:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  10544f:	e8 e1 af ff ff       	call   100435 <__panic>

    assert(nr_free == 0);
  105454:	a1 24 cf 11 00       	mov    0x11cf24,%eax
  105459:	85 c0                	test   %eax,%eax
  10545b:	74 24                	je     105481 <default_check+0x594>
  10545d:	c7 44 24 0c 41 70 10 	movl   $0x107041,0xc(%esp)
  105464:	00 
  105465:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  10546c:	00 
  10546d:	c7 44 24 04 7e 01 00 	movl   $0x17e,0x4(%esp)
  105474:	00 
  105475:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  10547c:	e8 b4 af ff ff       	call   100435 <__panic>
    nr_free = nr_free_store;
  105481:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  105484:	a3 24 cf 11 00       	mov    %eax,0x11cf24

    free_list = free_list_store;
  105489:	8b 45 80             	mov    -0x80(%ebp),%eax
  10548c:	8b 55 84             	mov    -0x7c(%ebp),%edx
  10548f:	a3 1c cf 11 00       	mov    %eax,0x11cf1c
  105494:	89 15 20 cf 11 00    	mov    %edx,0x11cf20
    free_pages(p0, 5);
  10549a:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
  1054a1:	00 
  1054a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1054a5:	89 04 24             	mov    %eax,(%esp)
  1054a8:	e8 b9 d8 ff ff       	call   102d66 <free_pages>

    le = &free_list;
  1054ad:	c7 45 ec 1c cf 11 00 	movl   $0x11cf1c,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
  1054b4:	eb 5a                	jmp    105510 <default_check+0x623>
        assert(le->next->prev == le && le->prev->next == le);
  1054b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1054b9:	8b 40 04             	mov    0x4(%eax),%eax
  1054bc:	8b 00                	mov    (%eax),%eax
  1054be:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  1054c1:	75 0d                	jne    1054d0 <default_check+0x5e3>
  1054c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1054c6:	8b 00                	mov    (%eax),%eax
  1054c8:	8b 40 04             	mov    0x4(%eax),%eax
  1054cb:	39 45 ec             	cmp    %eax,-0x14(%ebp)
  1054ce:	74 24                	je     1054f4 <default_check+0x607>
  1054d0:	c7 44 24 0c b0 71 10 	movl   $0x1071b0,0xc(%esp)
  1054d7:	00 
  1054d8:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  1054df:	00 
  1054e0:	c7 44 24 04 86 01 00 	movl   $0x186,0x4(%esp)
  1054e7:	00 
  1054e8:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  1054ef:	e8 41 af ff ff       	call   100435 <__panic>
        struct Page *p = le2page(le, page_link);
  1054f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1054f7:	83 e8 0c             	sub    $0xc,%eax
  1054fa:	89 45 d8             	mov    %eax,-0x28(%ebp)
        count --, total -= p->property;
  1054fd:	ff 4d f4             	decl   -0xc(%ebp)
  105500:	8b 55 f0             	mov    -0x10(%ebp),%edx
  105503:	8b 45 d8             	mov    -0x28(%ebp),%eax
  105506:	8b 40 08             	mov    0x8(%eax),%eax
  105509:	29 c2                	sub    %eax,%edx
  10550b:	89 d0                	mov    %edx,%eax
  10550d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105510:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105513:	89 45 88             	mov    %eax,-0x78(%ebp)
    return listelm->next;
  105516:	8b 45 88             	mov    -0x78(%ebp),%eax
  105519:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
  10551c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10551f:	81 7d ec 1c cf 11 00 	cmpl   $0x11cf1c,-0x14(%ebp)
  105526:	75 8e                	jne    1054b6 <default_check+0x5c9>
    }
    assert(count == 0);
  105528:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10552c:	74 24                	je     105552 <default_check+0x665>
  10552e:	c7 44 24 0c dd 71 10 	movl   $0x1071dd,0xc(%esp)
  105535:	00 
  105536:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  10553d:	00 
  10553e:	c7 44 24 04 8a 01 00 	movl   $0x18a,0x4(%esp)
  105545:	00 
  105546:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  10554d:	e8 e3 ae ff ff       	call   100435 <__panic>
    assert(total == 0);
  105552:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  105556:	74 24                	je     10557c <default_check+0x68f>
  105558:	c7 44 24 0c e8 71 10 	movl   $0x1071e8,0xc(%esp)
  10555f:	00 
  105560:	c7 44 24 08 7e 6e 10 	movl   $0x106e7e,0x8(%esp)
  105567:	00 
  105568:	c7 44 24 04 8b 01 00 	movl   $0x18b,0x4(%esp)
  10556f:	00 
  105570:	c7 04 24 93 6e 10 00 	movl   $0x106e93,(%esp)
  105577:	e8 b9 ae ff ff       	call   100435 <__panic>
}
  10557c:	90                   	nop
  10557d:	c9                   	leave  
  10557e:	c3                   	ret    

0010557f <strlen>:
 * @s:      the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  10557f:	f3 0f 1e fb          	endbr32 
  105583:	55                   	push   %ebp
  105584:	89 e5                	mov    %esp,%ebp
  105586:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  105589:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  105590:	eb 03                	jmp    105595 <strlen+0x16>
        cnt ++;
  105592:	ff 45 fc             	incl   -0x4(%ebp)
    while (*s ++ != '\0') {
  105595:	8b 45 08             	mov    0x8(%ebp),%eax
  105598:	8d 50 01             	lea    0x1(%eax),%edx
  10559b:	89 55 08             	mov    %edx,0x8(%ebp)
  10559e:	0f b6 00             	movzbl (%eax),%eax
  1055a1:	84 c0                	test   %al,%al
  1055a3:	75 ed                	jne    105592 <strlen+0x13>
    }
    return cnt;
  1055a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1055a8:	c9                   	leave  
  1055a9:	c3                   	ret    

001055aa <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  1055aa:	f3 0f 1e fb          	endbr32 
  1055ae:	55                   	push   %ebp
  1055af:	89 e5                	mov    %esp,%ebp
  1055b1:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  1055b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  1055bb:	eb 03                	jmp    1055c0 <strnlen+0x16>
        cnt ++;
  1055bd:	ff 45 fc             	incl   -0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  1055c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1055c3:	3b 45 0c             	cmp    0xc(%ebp),%eax
  1055c6:	73 10                	jae    1055d8 <strnlen+0x2e>
  1055c8:	8b 45 08             	mov    0x8(%ebp),%eax
  1055cb:	8d 50 01             	lea    0x1(%eax),%edx
  1055ce:	89 55 08             	mov    %edx,0x8(%ebp)
  1055d1:	0f b6 00             	movzbl (%eax),%eax
  1055d4:	84 c0                	test   %al,%al
  1055d6:	75 e5                	jne    1055bd <strnlen+0x13>
    }
    return cnt;
  1055d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1055db:	c9                   	leave  
  1055dc:	c3                   	ret    

001055dd <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  1055dd:	f3 0f 1e fb          	endbr32 
  1055e1:	55                   	push   %ebp
  1055e2:	89 e5                	mov    %esp,%ebp
  1055e4:	57                   	push   %edi
  1055e5:	56                   	push   %esi
  1055e6:	83 ec 20             	sub    $0x20,%esp
  1055e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1055ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1055ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  1055f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  1055f5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1055f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1055fb:	89 d1                	mov    %edx,%ecx
  1055fd:	89 c2                	mov    %eax,%edx
  1055ff:	89 ce                	mov    %ecx,%esi
  105601:	89 d7                	mov    %edx,%edi
  105603:	ac                   	lods   %ds:(%esi),%al
  105604:	aa                   	stos   %al,%es:(%edi)
  105605:	84 c0                	test   %al,%al
  105607:	75 fa                	jne    105603 <strcpy+0x26>
  105609:	89 fa                	mov    %edi,%edx
  10560b:	89 f1                	mov    %esi,%ecx
  10560d:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  105610:	89 55 e8             	mov    %edx,-0x18(%ebp)
  105613:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        "stosb;"
        "testb %%al, %%al;"
        "jne 1b;"
        : "=&S" (d0), "=&D" (d1), "=&a" (d2)
        : "0" (src), "1" (dst) : "memory");
    return dst;
  105616:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  105619:	83 c4 20             	add    $0x20,%esp
  10561c:	5e                   	pop    %esi
  10561d:	5f                   	pop    %edi
  10561e:	5d                   	pop    %ebp
  10561f:	c3                   	ret    

00105620 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  105620:	f3 0f 1e fb          	endbr32 
  105624:	55                   	push   %ebp
  105625:	89 e5                	mov    %esp,%ebp
  105627:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  10562a:	8b 45 08             	mov    0x8(%ebp),%eax
  10562d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  105630:	eb 1e                	jmp    105650 <strncpy+0x30>
        if ((*p = *src) != '\0') {
  105632:	8b 45 0c             	mov    0xc(%ebp),%eax
  105635:	0f b6 10             	movzbl (%eax),%edx
  105638:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10563b:	88 10                	mov    %dl,(%eax)
  10563d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  105640:	0f b6 00             	movzbl (%eax),%eax
  105643:	84 c0                	test   %al,%al
  105645:	74 03                	je     10564a <strncpy+0x2a>
            src ++;
  105647:	ff 45 0c             	incl   0xc(%ebp)
        }
        p ++, len --;
  10564a:	ff 45 fc             	incl   -0x4(%ebp)
  10564d:	ff 4d 10             	decl   0x10(%ebp)
    while (len > 0) {
  105650:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  105654:	75 dc                	jne    105632 <strncpy+0x12>
    }
    return dst;
  105656:	8b 45 08             	mov    0x8(%ebp),%eax
}
  105659:	c9                   	leave  
  10565a:	c3                   	ret    

0010565b <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  10565b:	f3 0f 1e fb          	endbr32 
  10565f:	55                   	push   %ebp
  105660:	89 e5                	mov    %esp,%ebp
  105662:	57                   	push   %edi
  105663:	56                   	push   %esi
  105664:	83 ec 20             	sub    $0x20,%esp
  105667:	8b 45 08             	mov    0x8(%ebp),%eax
  10566a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10566d:	8b 45 0c             	mov    0xc(%ebp),%eax
  105670:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  105673:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105676:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105679:	89 d1                	mov    %edx,%ecx
  10567b:	89 c2                	mov    %eax,%edx
  10567d:	89 ce                	mov    %ecx,%esi
  10567f:	89 d7                	mov    %edx,%edi
  105681:	ac                   	lods   %ds:(%esi),%al
  105682:	ae                   	scas   %es:(%edi),%al
  105683:	75 08                	jne    10568d <strcmp+0x32>
  105685:	84 c0                	test   %al,%al
  105687:	75 f8                	jne    105681 <strcmp+0x26>
  105689:	31 c0                	xor    %eax,%eax
  10568b:	eb 04                	jmp    105691 <strcmp+0x36>
  10568d:	19 c0                	sbb    %eax,%eax
  10568f:	0c 01                	or     $0x1,%al
  105691:	89 fa                	mov    %edi,%edx
  105693:	89 f1                	mov    %esi,%ecx
  105695:	89 45 ec             	mov    %eax,-0x14(%ebp)
  105698:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  10569b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  10569e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  1056a1:	83 c4 20             	add    $0x20,%esp
  1056a4:	5e                   	pop    %esi
  1056a5:	5f                   	pop    %edi
  1056a6:	5d                   	pop    %ebp
  1056a7:	c3                   	ret    

001056a8 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  1056a8:	f3 0f 1e fb          	endbr32 
  1056ac:	55                   	push   %ebp
  1056ad:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  1056af:	eb 09                	jmp    1056ba <strncmp+0x12>
        n --, s1 ++, s2 ++;
  1056b1:	ff 4d 10             	decl   0x10(%ebp)
  1056b4:	ff 45 08             	incl   0x8(%ebp)
  1056b7:	ff 45 0c             	incl   0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  1056ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1056be:	74 1a                	je     1056da <strncmp+0x32>
  1056c0:	8b 45 08             	mov    0x8(%ebp),%eax
  1056c3:	0f b6 00             	movzbl (%eax),%eax
  1056c6:	84 c0                	test   %al,%al
  1056c8:	74 10                	je     1056da <strncmp+0x32>
  1056ca:	8b 45 08             	mov    0x8(%ebp),%eax
  1056cd:	0f b6 10             	movzbl (%eax),%edx
  1056d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1056d3:	0f b6 00             	movzbl (%eax),%eax
  1056d6:	38 c2                	cmp    %al,%dl
  1056d8:	74 d7                	je     1056b1 <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  1056da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1056de:	74 18                	je     1056f8 <strncmp+0x50>
  1056e0:	8b 45 08             	mov    0x8(%ebp),%eax
  1056e3:	0f b6 00             	movzbl (%eax),%eax
  1056e6:	0f b6 d0             	movzbl %al,%edx
  1056e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1056ec:	0f b6 00             	movzbl (%eax),%eax
  1056ef:	0f b6 c0             	movzbl %al,%eax
  1056f2:	29 c2                	sub    %eax,%edx
  1056f4:	89 d0                	mov    %edx,%eax
  1056f6:	eb 05                	jmp    1056fd <strncmp+0x55>
  1056f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1056fd:	5d                   	pop    %ebp
  1056fe:	c3                   	ret    

001056ff <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  1056ff:	f3 0f 1e fb          	endbr32 
  105703:	55                   	push   %ebp
  105704:	89 e5                	mov    %esp,%ebp
  105706:	83 ec 04             	sub    $0x4,%esp
  105709:	8b 45 0c             	mov    0xc(%ebp),%eax
  10570c:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  10570f:	eb 13                	jmp    105724 <strchr+0x25>
        if (*s == c) {
  105711:	8b 45 08             	mov    0x8(%ebp),%eax
  105714:	0f b6 00             	movzbl (%eax),%eax
  105717:	38 45 fc             	cmp    %al,-0x4(%ebp)
  10571a:	75 05                	jne    105721 <strchr+0x22>
            return (char *)s;
  10571c:	8b 45 08             	mov    0x8(%ebp),%eax
  10571f:	eb 12                	jmp    105733 <strchr+0x34>
        }
        s ++;
  105721:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  105724:	8b 45 08             	mov    0x8(%ebp),%eax
  105727:	0f b6 00             	movzbl (%eax),%eax
  10572a:	84 c0                	test   %al,%al
  10572c:	75 e3                	jne    105711 <strchr+0x12>
    }
    return NULL;
  10572e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  105733:	c9                   	leave  
  105734:	c3                   	ret    

00105735 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  105735:	f3 0f 1e fb          	endbr32 
  105739:	55                   	push   %ebp
  10573a:	89 e5                	mov    %esp,%ebp
  10573c:	83 ec 04             	sub    $0x4,%esp
  10573f:	8b 45 0c             	mov    0xc(%ebp),%eax
  105742:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  105745:	eb 0e                	jmp    105755 <strfind+0x20>
        if (*s == c) {
  105747:	8b 45 08             	mov    0x8(%ebp),%eax
  10574a:	0f b6 00             	movzbl (%eax),%eax
  10574d:	38 45 fc             	cmp    %al,-0x4(%ebp)
  105750:	74 0f                	je     105761 <strfind+0x2c>
            break;
        }
        s ++;
  105752:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  105755:	8b 45 08             	mov    0x8(%ebp),%eax
  105758:	0f b6 00             	movzbl (%eax),%eax
  10575b:	84 c0                	test   %al,%al
  10575d:	75 e8                	jne    105747 <strfind+0x12>
  10575f:	eb 01                	jmp    105762 <strfind+0x2d>
            break;
  105761:	90                   	nop
    }
    return (char *)s;
  105762:	8b 45 08             	mov    0x8(%ebp),%eax
}
  105765:	c9                   	leave  
  105766:	c3                   	ret    

00105767 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  105767:	f3 0f 1e fb          	endbr32 
  10576b:	55                   	push   %ebp
  10576c:	89 e5                	mov    %esp,%ebp
  10576e:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  105771:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  105778:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  10577f:	eb 03                	jmp    105784 <strtol+0x1d>
        s ++;
  105781:	ff 45 08             	incl   0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  105784:	8b 45 08             	mov    0x8(%ebp),%eax
  105787:	0f b6 00             	movzbl (%eax),%eax
  10578a:	3c 20                	cmp    $0x20,%al
  10578c:	74 f3                	je     105781 <strtol+0x1a>
  10578e:	8b 45 08             	mov    0x8(%ebp),%eax
  105791:	0f b6 00             	movzbl (%eax),%eax
  105794:	3c 09                	cmp    $0x9,%al
  105796:	74 e9                	je     105781 <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
  105798:	8b 45 08             	mov    0x8(%ebp),%eax
  10579b:	0f b6 00             	movzbl (%eax),%eax
  10579e:	3c 2b                	cmp    $0x2b,%al
  1057a0:	75 05                	jne    1057a7 <strtol+0x40>
        s ++;
  1057a2:	ff 45 08             	incl   0x8(%ebp)
  1057a5:	eb 14                	jmp    1057bb <strtol+0x54>
    }
    else if (*s == '-') {
  1057a7:	8b 45 08             	mov    0x8(%ebp),%eax
  1057aa:	0f b6 00             	movzbl (%eax),%eax
  1057ad:	3c 2d                	cmp    $0x2d,%al
  1057af:	75 0a                	jne    1057bb <strtol+0x54>
        s ++, neg = 1;
  1057b1:	ff 45 08             	incl   0x8(%ebp)
  1057b4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  1057bb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1057bf:	74 06                	je     1057c7 <strtol+0x60>
  1057c1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  1057c5:	75 22                	jne    1057e9 <strtol+0x82>
  1057c7:	8b 45 08             	mov    0x8(%ebp),%eax
  1057ca:	0f b6 00             	movzbl (%eax),%eax
  1057cd:	3c 30                	cmp    $0x30,%al
  1057cf:	75 18                	jne    1057e9 <strtol+0x82>
  1057d1:	8b 45 08             	mov    0x8(%ebp),%eax
  1057d4:	40                   	inc    %eax
  1057d5:	0f b6 00             	movzbl (%eax),%eax
  1057d8:	3c 78                	cmp    $0x78,%al
  1057da:	75 0d                	jne    1057e9 <strtol+0x82>
        s += 2, base = 16;
  1057dc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  1057e0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  1057e7:	eb 29                	jmp    105812 <strtol+0xab>
    }
    else if (base == 0 && s[0] == '0') {
  1057e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1057ed:	75 16                	jne    105805 <strtol+0x9e>
  1057ef:	8b 45 08             	mov    0x8(%ebp),%eax
  1057f2:	0f b6 00             	movzbl (%eax),%eax
  1057f5:	3c 30                	cmp    $0x30,%al
  1057f7:	75 0c                	jne    105805 <strtol+0x9e>
        s ++, base = 8;
  1057f9:	ff 45 08             	incl   0x8(%ebp)
  1057fc:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  105803:	eb 0d                	jmp    105812 <strtol+0xab>
    }
    else if (base == 0) {
  105805:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  105809:	75 07                	jne    105812 <strtol+0xab>
        base = 10;
  10580b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  105812:	8b 45 08             	mov    0x8(%ebp),%eax
  105815:	0f b6 00             	movzbl (%eax),%eax
  105818:	3c 2f                	cmp    $0x2f,%al
  10581a:	7e 1b                	jle    105837 <strtol+0xd0>
  10581c:	8b 45 08             	mov    0x8(%ebp),%eax
  10581f:	0f b6 00             	movzbl (%eax),%eax
  105822:	3c 39                	cmp    $0x39,%al
  105824:	7f 11                	jg     105837 <strtol+0xd0>
            dig = *s - '0';
  105826:	8b 45 08             	mov    0x8(%ebp),%eax
  105829:	0f b6 00             	movzbl (%eax),%eax
  10582c:	0f be c0             	movsbl %al,%eax
  10582f:	83 e8 30             	sub    $0x30,%eax
  105832:	89 45 f4             	mov    %eax,-0xc(%ebp)
  105835:	eb 48                	jmp    10587f <strtol+0x118>
        }
        else if (*s >= 'a' && *s <= 'z') {
  105837:	8b 45 08             	mov    0x8(%ebp),%eax
  10583a:	0f b6 00             	movzbl (%eax),%eax
  10583d:	3c 60                	cmp    $0x60,%al
  10583f:	7e 1b                	jle    10585c <strtol+0xf5>
  105841:	8b 45 08             	mov    0x8(%ebp),%eax
  105844:	0f b6 00             	movzbl (%eax),%eax
  105847:	3c 7a                	cmp    $0x7a,%al
  105849:	7f 11                	jg     10585c <strtol+0xf5>
            dig = *s - 'a' + 10;
  10584b:	8b 45 08             	mov    0x8(%ebp),%eax
  10584e:	0f b6 00             	movzbl (%eax),%eax
  105851:	0f be c0             	movsbl %al,%eax
  105854:	83 e8 57             	sub    $0x57,%eax
  105857:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10585a:	eb 23                	jmp    10587f <strtol+0x118>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  10585c:	8b 45 08             	mov    0x8(%ebp),%eax
  10585f:	0f b6 00             	movzbl (%eax),%eax
  105862:	3c 40                	cmp    $0x40,%al
  105864:	7e 3b                	jle    1058a1 <strtol+0x13a>
  105866:	8b 45 08             	mov    0x8(%ebp),%eax
  105869:	0f b6 00             	movzbl (%eax),%eax
  10586c:	3c 5a                	cmp    $0x5a,%al
  10586e:	7f 31                	jg     1058a1 <strtol+0x13a>
            dig = *s - 'A' + 10;
  105870:	8b 45 08             	mov    0x8(%ebp),%eax
  105873:	0f b6 00             	movzbl (%eax),%eax
  105876:	0f be c0             	movsbl %al,%eax
  105879:	83 e8 37             	sub    $0x37,%eax
  10587c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  10587f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105882:	3b 45 10             	cmp    0x10(%ebp),%eax
  105885:	7d 19                	jge    1058a0 <strtol+0x139>
            break;
        }
        s ++, val = (val * base) + dig;
  105887:	ff 45 08             	incl   0x8(%ebp)
  10588a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10588d:	0f af 45 10          	imul   0x10(%ebp),%eax
  105891:	89 c2                	mov    %eax,%edx
  105893:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105896:	01 d0                	add    %edx,%eax
  105898:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  10589b:	e9 72 ff ff ff       	jmp    105812 <strtol+0xab>
            break;
  1058a0:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  1058a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1058a5:	74 08                	je     1058af <strtol+0x148>
        *endptr = (char *) s;
  1058a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1058aa:	8b 55 08             	mov    0x8(%ebp),%edx
  1058ad:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  1058af:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  1058b3:	74 07                	je     1058bc <strtol+0x155>
  1058b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1058b8:	f7 d8                	neg    %eax
  1058ba:	eb 03                	jmp    1058bf <strtol+0x158>
  1058bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  1058bf:	c9                   	leave  
  1058c0:	c3                   	ret    

001058c1 <memset>:
 * @n:      number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  1058c1:	f3 0f 1e fb          	endbr32 
  1058c5:	55                   	push   %ebp
  1058c6:	89 e5                	mov    %esp,%ebp
  1058c8:	57                   	push   %edi
  1058c9:	83 ec 24             	sub    $0x24,%esp
  1058cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1058cf:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  1058d2:	0f be 55 d8          	movsbl -0x28(%ebp),%edx
  1058d6:	8b 45 08             	mov    0x8(%ebp),%eax
  1058d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1058dc:	88 55 f7             	mov    %dl,-0x9(%ebp)
  1058df:	8b 45 10             	mov    0x10(%ebp),%eax
  1058e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  1058e5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  1058e8:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  1058ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
  1058ef:	89 d7                	mov    %edx,%edi
  1058f1:	f3 aa                	rep stos %al,%es:(%edi)
  1058f3:	89 fa                	mov    %edi,%edx
  1058f5:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  1058f8:	89 55 e8             	mov    %edx,-0x18(%ebp)
        "rep; stosb;"
        : "=&c" (d0), "=&D" (d1)
        : "0" (n), "a" (c), "1" (s)
        : "memory");
    return s;
  1058fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  1058fe:	83 c4 24             	add    $0x24,%esp
  105901:	5f                   	pop    %edi
  105902:	5d                   	pop    %ebp
  105903:	c3                   	ret    

00105904 <memmove>:
 * @n:      number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  105904:	f3 0f 1e fb          	endbr32 
  105908:	55                   	push   %ebp
  105909:	89 e5                	mov    %esp,%ebp
  10590b:	57                   	push   %edi
  10590c:	56                   	push   %esi
  10590d:	53                   	push   %ebx
  10590e:	83 ec 30             	sub    $0x30,%esp
  105911:	8b 45 08             	mov    0x8(%ebp),%eax
  105914:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105917:	8b 45 0c             	mov    0xc(%ebp),%eax
  10591a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10591d:	8b 45 10             	mov    0x10(%ebp),%eax
  105920:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  105923:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105926:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  105929:	73 42                	jae    10596d <memmove+0x69>
  10592b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10592e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  105931:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105934:	89 45 e0             	mov    %eax,-0x20(%ebp)
  105937:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10593a:	89 45 dc             	mov    %eax,-0x24(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  10593d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  105940:	c1 e8 02             	shr    $0x2,%eax
  105943:	89 c1                	mov    %eax,%ecx
    asm volatile (
  105945:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  105948:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10594b:	89 d7                	mov    %edx,%edi
  10594d:	89 c6                	mov    %eax,%esi
  10594f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  105951:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  105954:	83 e1 03             	and    $0x3,%ecx
  105957:	74 02                	je     10595b <memmove+0x57>
  105959:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  10595b:	89 f0                	mov    %esi,%eax
  10595d:	89 fa                	mov    %edi,%edx
  10595f:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  105962:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  105965:	89 45 d0             	mov    %eax,-0x30(%ebp)
        : "memory");
    return dst;
  105968:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  10596b:	eb 36                	jmp    1059a3 <memmove+0x9f>
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  10596d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105970:	8d 50 ff             	lea    -0x1(%eax),%edx
  105973:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105976:	01 c2                	add    %eax,%edx
  105978:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10597b:	8d 48 ff             	lea    -0x1(%eax),%ecx
  10597e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105981:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  105984:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105987:	89 c1                	mov    %eax,%ecx
  105989:	89 d8                	mov    %ebx,%eax
  10598b:	89 d6                	mov    %edx,%esi
  10598d:	89 c7                	mov    %eax,%edi
  10598f:	fd                   	std    
  105990:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  105992:	fc                   	cld    
  105993:	89 f8                	mov    %edi,%eax
  105995:	89 f2                	mov    %esi,%edx
  105997:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  10599a:	89 55 c8             	mov    %edx,-0x38(%ebp)
  10599d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  1059a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  1059a3:	83 c4 30             	add    $0x30,%esp
  1059a6:	5b                   	pop    %ebx
  1059a7:	5e                   	pop    %esi
  1059a8:	5f                   	pop    %edi
  1059a9:	5d                   	pop    %ebp
  1059aa:	c3                   	ret    

001059ab <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  1059ab:	f3 0f 1e fb          	endbr32 
  1059af:	55                   	push   %ebp
  1059b0:	89 e5                	mov    %esp,%ebp
  1059b2:	57                   	push   %edi
  1059b3:	56                   	push   %esi
  1059b4:	83 ec 20             	sub    $0x20,%esp
  1059b7:	8b 45 08             	mov    0x8(%ebp),%eax
  1059ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1059bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1059c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1059c3:	8b 45 10             	mov    0x10(%ebp),%eax
  1059c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  1059c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1059cc:	c1 e8 02             	shr    $0x2,%eax
  1059cf:	89 c1                	mov    %eax,%ecx
    asm volatile (
  1059d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1059d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1059d7:	89 d7                	mov    %edx,%edi
  1059d9:	89 c6                	mov    %eax,%esi
  1059db:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1059dd:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  1059e0:	83 e1 03             	and    $0x3,%ecx
  1059e3:	74 02                	je     1059e7 <memcpy+0x3c>
  1059e5:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1059e7:	89 f0                	mov    %esi,%eax
  1059e9:	89 fa                	mov    %edi,%edx
  1059eb:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  1059ee:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  1059f1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  1059f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  1059f7:	83 c4 20             	add    $0x20,%esp
  1059fa:	5e                   	pop    %esi
  1059fb:	5f                   	pop    %edi
  1059fc:	5d                   	pop    %ebp
  1059fd:	c3                   	ret    

001059fe <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  1059fe:	f3 0f 1e fb          	endbr32 
  105a02:	55                   	push   %ebp
  105a03:	89 e5                	mov    %esp,%ebp
  105a05:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  105a08:	8b 45 08             	mov    0x8(%ebp),%eax
  105a0b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  105a0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  105a11:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  105a14:	eb 2e                	jmp    105a44 <memcmp+0x46>
        if (*s1 != *s2) {
  105a16:	8b 45 fc             	mov    -0x4(%ebp),%eax
  105a19:	0f b6 10             	movzbl (%eax),%edx
  105a1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  105a1f:	0f b6 00             	movzbl (%eax),%eax
  105a22:	38 c2                	cmp    %al,%dl
  105a24:	74 18                	je     105a3e <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  105a26:	8b 45 fc             	mov    -0x4(%ebp),%eax
  105a29:	0f b6 00             	movzbl (%eax),%eax
  105a2c:	0f b6 d0             	movzbl %al,%edx
  105a2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  105a32:	0f b6 00             	movzbl (%eax),%eax
  105a35:	0f b6 c0             	movzbl %al,%eax
  105a38:	29 c2                	sub    %eax,%edx
  105a3a:	89 d0                	mov    %edx,%eax
  105a3c:	eb 18                	jmp    105a56 <memcmp+0x58>
        }
        s1 ++, s2 ++;
  105a3e:	ff 45 fc             	incl   -0x4(%ebp)
  105a41:	ff 45 f8             	incl   -0x8(%ebp)
    while (n -- > 0) {
  105a44:	8b 45 10             	mov    0x10(%ebp),%eax
  105a47:	8d 50 ff             	lea    -0x1(%eax),%edx
  105a4a:	89 55 10             	mov    %edx,0x10(%ebp)
  105a4d:	85 c0                	test   %eax,%eax
  105a4f:	75 c5                	jne    105a16 <memcmp+0x18>
    }
    return 0;
  105a51:	b8 00 00 00 00       	mov    $0x0,%eax
}
  105a56:	c9                   	leave  
  105a57:	c3                   	ret    

00105a58 <printnum>:
 * @width:      maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:       character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  105a58:	f3 0f 1e fb          	endbr32 
  105a5c:	55                   	push   %ebp
  105a5d:	89 e5                	mov    %esp,%ebp
  105a5f:	83 ec 58             	sub    $0x58,%esp
  105a62:	8b 45 10             	mov    0x10(%ebp),%eax
  105a65:	89 45 d0             	mov    %eax,-0x30(%ebp)
  105a68:	8b 45 14             	mov    0x14(%ebp),%eax
  105a6b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  105a6e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  105a71:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  105a74:	89 45 e8             	mov    %eax,-0x18(%ebp)
  105a77:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  105a7a:	8b 45 18             	mov    0x18(%ebp),%eax
  105a7d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  105a80:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105a83:	8b 55 ec             	mov    -0x14(%ebp),%edx
  105a86:	89 45 e0             	mov    %eax,-0x20(%ebp)
  105a89:	89 55 f0             	mov    %edx,-0x10(%ebp)
  105a8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105a8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  105a92:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  105a96:	74 1c                	je     105ab4 <printnum+0x5c>
  105a98:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105a9b:	ba 00 00 00 00       	mov    $0x0,%edx
  105aa0:	f7 75 e4             	divl   -0x1c(%ebp)
  105aa3:	89 55 f4             	mov    %edx,-0xc(%ebp)
  105aa6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105aa9:	ba 00 00 00 00       	mov    $0x0,%edx
  105aae:	f7 75 e4             	divl   -0x1c(%ebp)
  105ab1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105ab4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105ab7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105aba:	f7 75 e4             	divl   -0x1c(%ebp)
  105abd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  105ac0:	89 55 dc             	mov    %edx,-0x24(%ebp)
  105ac3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105ac6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  105ac9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  105acc:	89 55 ec             	mov    %edx,-0x14(%ebp)
  105acf:	8b 45 dc             	mov    -0x24(%ebp),%eax
  105ad2:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  105ad5:	8b 45 18             	mov    0x18(%ebp),%eax
  105ad8:	ba 00 00 00 00       	mov    $0x0,%edx
  105add:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  105ae0:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  105ae3:	19 d1                	sbb    %edx,%ecx
  105ae5:	72 4c                	jb     105b33 <printnum+0xdb>
        printnum(putch, putdat, result, base, width - 1, padc);
  105ae7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  105aea:	8d 50 ff             	lea    -0x1(%eax),%edx
  105aed:	8b 45 20             	mov    0x20(%ebp),%eax
  105af0:	89 44 24 18          	mov    %eax,0x18(%esp)
  105af4:	89 54 24 14          	mov    %edx,0x14(%esp)
  105af8:	8b 45 18             	mov    0x18(%ebp),%eax
  105afb:	89 44 24 10          	mov    %eax,0x10(%esp)
  105aff:	8b 45 e8             	mov    -0x18(%ebp),%eax
  105b02:	8b 55 ec             	mov    -0x14(%ebp),%edx
  105b05:	89 44 24 08          	mov    %eax,0x8(%esp)
  105b09:	89 54 24 0c          	mov    %edx,0xc(%esp)
  105b0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  105b10:	89 44 24 04          	mov    %eax,0x4(%esp)
  105b14:	8b 45 08             	mov    0x8(%ebp),%eax
  105b17:	89 04 24             	mov    %eax,(%esp)
  105b1a:	e8 39 ff ff ff       	call   105a58 <printnum>
  105b1f:	eb 1b                	jmp    105b3c <printnum+0xe4>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  105b21:	8b 45 0c             	mov    0xc(%ebp),%eax
  105b24:	89 44 24 04          	mov    %eax,0x4(%esp)
  105b28:	8b 45 20             	mov    0x20(%ebp),%eax
  105b2b:	89 04 24             	mov    %eax,(%esp)
  105b2e:	8b 45 08             	mov    0x8(%ebp),%eax
  105b31:	ff d0                	call   *%eax
        while (-- width > 0)
  105b33:	ff 4d 1c             	decl   0x1c(%ebp)
  105b36:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  105b3a:	7f e5                	jg     105b21 <printnum+0xc9>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  105b3c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  105b3f:	05 a4 72 10 00       	add    $0x1072a4,%eax
  105b44:	0f b6 00             	movzbl (%eax),%eax
  105b47:	0f be c0             	movsbl %al,%eax
  105b4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  105b4d:	89 54 24 04          	mov    %edx,0x4(%esp)
  105b51:	89 04 24             	mov    %eax,(%esp)
  105b54:	8b 45 08             	mov    0x8(%ebp),%eax
  105b57:	ff d0                	call   *%eax
}
  105b59:	90                   	nop
  105b5a:	c9                   	leave  
  105b5b:	c3                   	ret    

00105b5c <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  105b5c:	f3 0f 1e fb          	endbr32 
  105b60:	55                   	push   %ebp
  105b61:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  105b63:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  105b67:	7e 14                	jle    105b7d <getuint+0x21>
        return va_arg(*ap, unsigned long long);
  105b69:	8b 45 08             	mov    0x8(%ebp),%eax
  105b6c:	8b 00                	mov    (%eax),%eax
  105b6e:	8d 48 08             	lea    0x8(%eax),%ecx
  105b71:	8b 55 08             	mov    0x8(%ebp),%edx
  105b74:	89 0a                	mov    %ecx,(%edx)
  105b76:	8b 50 04             	mov    0x4(%eax),%edx
  105b79:	8b 00                	mov    (%eax),%eax
  105b7b:	eb 30                	jmp    105bad <getuint+0x51>
    }
    else if (lflag) {
  105b7d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  105b81:	74 16                	je     105b99 <getuint+0x3d>
        return va_arg(*ap, unsigned long);
  105b83:	8b 45 08             	mov    0x8(%ebp),%eax
  105b86:	8b 00                	mov    (%eax),%eax
  105b88:	8d 48 04             	lea    0x4(%eax),%ecx
  105b8b:	8b 55 08             	mov    0x8(%ebp),%edx
  105b8e:	89 0a                	mov    %ecx,(%edx)
  105b90:	8b 00                	mov    (%eax),%eax
  105b92:	ba 00 00 00 00       	mov    $0x0,%edx
  105b97:	eb 14                	jmp    105bad <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
  105b99:	8b 45 08             	mov    0x8(%ebp),%eax
  105b9c:	8b 00                	mov    (%eax),%eax
  105b9e:	8d 48 04             	lea    0x4(%eax),%ecx
  105ba1:	8b 55 08             	mov    0x8(%ebp),%edx
  105ba4:	89 0a                	mov    %ecx,(%edx)
  105ba6:	8b 00                	mov    (%eax),%eax
  105ba8:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  105bad:	5d                   	pop    %ebp
  105bae:	c3                   	ret    

00105baf <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  105baf:	f3 0f 1e fb          	endbr32 
  105bb3:	55                   	push   %ebp
  105bb4:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  105bb6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  105bba:	7e 14                	jle    105bd0 <getint+0x21>
        return va_arg(*ap, long long);
  105bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  105bbf:	8b 00                	mov    (%eax),%eax
  105bc1:	8d 48 08             	lea    0x8(%eax),%ecx
  105bc4:	8b 55 08             	mov    0x8(%ebp),%edx
  105bc7:	89 0a                	mov    %ecx,(%edx)
  105bc9:	8b 50 04             	mov    0x4(%eax),%edx
  105bcc:	8b 00                	mov    (%eax),%eax
  105bce:	eb 28                	jmp    105bf8 <getint+0x49>
    }
    else if (lflag) {
  105bd0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  105bd4:	74 12                	je     105be8 <getint+0x39>
        return va_arg(*ap, long);
  105bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  105bd9:	8b 00                	mov    (%eax),%eax
  105bdb:	8d 48 04             	lea    0x4(%eax),%ecx
  105bde:	8b 55 08             	mov    0x8(%ebp),%edx
  105be1:	89 0a                	mov    %ecx,(%edx)
  105be3:	8b 00                	mov    (%eax),%eax
  105be5:	99                   	cltd   
  105be6:	eb 10                	jmp    105bf8 <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
  105be8:	8b 45 08             	mov    0x8(%ebp),%eax
  105beb:	8b 00                	mov    (%eax),%eax
  105bed:	8d 48 04             	lea    0x4(%eax),%ecx
  105bf0:	8b 55 08             	mov    0x8(%ebp),%edx
  105bf3:	89 0a                	mov    %ecx,(%edx)
  105bf5:	8b 00                	mov    (%eax),%eax
  105bf7:	99                   	cltd   
    }
}
  105bf8:	5d                   	pop    %ebp
  105bf9:	c3                   	ret    

00105bfa <printfmt>:
 * @putch:      specified putch function, print a single character
 * @putdat:     used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  105bfa:	f3 0f 1e fb          	endbr32 
  105bfe:	55                   	push   %ebp
  105bff:	89 e5                	mov    %esp,%ebp
  105c01:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  105c04:	8d 45 14             	lea    0x14(%ebp),%eax
  105c07:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  105c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  105c0d:	89 44 24 0c          	mov    %eax,0xc(%esp)
  105c11:	8b 45 10             	mov    0x10(%ebp),%eax
  105c14:	89 44 24 08          	mov    %eax,0x8(%esp)
  105c18:	8b 45 0c             	mov    0xc(%ebp),%eax
  105c1b:	89 44 24 04          	mov    %eax,0x4(%esp)
  105c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  105c22:	89 04 24             	mov    %eax,(%esp)
  105c25:	e8 03 00 00 00       	call   105c2d <vprintfmt>
    va_end(ap);
}
  105c2a:	90                   	nop
  105c2b:	c9                   	leave  
  105c2c:	c3                   	ret    

00105c2d <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  105c2d:	f3 0f 1e fb          	endbr32 
  105c31:	55                   	push   %ebp
  105c32:	89 e5                	mov    %esp,%ebp
  105c34:	56                   	push   %esi
  105c35:	53                   	push   %ebx
  105c36:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  105c39:	eb 17                	jmp    105c52 <vprintfmt+0x25>
            if (ch == '\0') {
  105c3b:	85 db                	test   %ebx,%ebx
  105c3d:	0f 84 c0 03 00 00    	je     106003 <vprintfmt+0x3d6>
                return;
            }
            putch(ch, putdat);
  105c43:	8b 45 0c             	mov    0xc(%ebp),%eax
  105c46:	89 44 24 04          	mov    %eax,0x4(%esp)
  105c4a:	89 1c 24             	mov    %ebx,(%esp)
  105c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  105c50:	ff d0                	call   *%eax
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  105c52:	8b 45 10             	mov    0x10(%ebp),%eax
  105c55:	8d 50 01             	lea    0x1(%eax),%edx
  105c58:	89 55 10             	mov    %edx,0x10(%ebp)
  105c5b:	0f b6 00             	movzbl (%eax),%eax
  105c5e:	0f b6 d8             	movzbl %al,%ebx
  105c61:	83 fb 25             	cmp    $0x25,%ebx
  105c64:	75 d5                	jne    105c3b <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
  105c66:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  105c6a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  105c71:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  105c74:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  105c77:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  105c7e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  105c81:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  105c84:	8b 45 10             	mov    0x10(%ebp),%eax
  105c87:	8d 50 01             	lea    0x1(%eax),%edx
  105c8a:	89 55 10             	mov    %edx,0x10(%ebp)
  105c8d:	0f b6 00             	movzbl (%eax),%eax
  105c90:	0f b6 d8             	movzbl %al,%ebx
  105c93:	8d 43 dd             	lea    -0x23(%ebx),%eax
  105c96:	83 f8 55             	cmp    $0x55,%eax
  105c99:	0f 87 38 03 00 00    	ja     105fd7 <vprintfmt+0x3aa>
  105c9f:	8b 04 85 c8 72 10 00 	mov    0x1072c8(,%eax,4),%eax
  105ca6:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  105ca9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  105cad:	eb d5                	jmp    105c84 <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  105caf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  105cb3:	eb cf                	jmp    105c84 <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  105cb5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  105cbc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  105cbf:	89 d0                	mov    %edx,%eax
  105cc1:	c1 e0 02             	shl    $0x2,%eax
  105cc4:	01 d0                	add    %edx,%eax
  105cc6:	01 c0                	add    %eax,%eax
  105cc8:	01 d8                	add    %ebx,%eax
  105cca:	83 e8 30             	sub    $0x30,%eax
  105ccd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  105cd0:	8b 45 10             	mov    0x10(%ebp),%eax
  105cd3:	0f b6 00             	movzbl (%eax),%eax
  105cd6:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  105cd9:	83 fb 2f             	cmp    $0x2f,%ebx
  105cdc:	7e 38                	jle    105d16 <vprintfmt+0xe9>
  105cde:	83 fb 39             	cmp    $0x39,%ebx
  105ce1:	7f 33                	jg     105d16 <vprintfmt+0xe9>
            for (precision = 0; ; ++ fmt) {
  105ce3:	ff 45 10             	incl   0x10(%ebp)
                precision = precision * 10 + ch - '0';
  105ce6:	eb d4                	jmp    105cbc <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  105ce8:	8b 45 14             	mov    0x14(%ebp),%eax
  105ceb:	8d 50 04             	lea    0x4(%eax),%edx
  105cee:	89 55 14             	mov    %edx,0x14(%ebp)
  105cf1:	8b 00                	mov    (%eax),%eax
  105cf3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  105cf6:	eb 1f                	jmp    105d17 <vprintfmt+0xea>

        case '.':
            if (width < 0)
  105cf8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105cfc:	79 86                	jns    105c84 <vprintfmt+0x57>
                width = 0;
  105cfe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  105d05:	e9 7a ff ff ff       	jmp    105c84 <vprintfmt+0x57>

        case '#':
            altflag = 1;
  105d0a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  105d11:	e9 6e ff ff ff       	jmp    105c84 <vprintfmt+0x57>
            goto process_precision;
  105d16:	90                   	nop

        process_precision:
            if (width < 0)
  105d17:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105d1b:	0f 89 63 ff ff ff    	jns    105c84 <vprintfmt+0x57>
                width = precision, precision = -1;
  105d21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  105d24:	89 45 e8             	mov    %eax,-0x18(%ebp)
  105d27:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  105d2e:	e9 51 ff ff ff       	jmp    105c84 <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  105d33:	ff 45 e0             	incl   -0x20(%ebp)
            goto reswitch;
  105d36:	e9 49 ff ff ff       	jmp    105c84 <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  105d3b:	8b 45 14             	mov    0x14(%ebp),%eax
  105d3e:	8d 50 04             	lea    0x4(%eax),%edx
  105d41:	89 55 14             	mov    %edx,0x14(%ebp)
  105d44:	8b 00                	mov    (%eax),%eax
  105d46:	8b 55 0c             	mov    0xc(%ebp),%edx
  105d49:	89 54 24 04          	mov    %edx,0x4(%esp)
  105d4d:	89 04 24             	mov    %eax,(%esp)
  105d50:	8b 45 08             	mov    0x8(%ebp),%eax
  105d53:	ff d0                	call   *%eax
            break;
  105d55:	e9 a4 02 00 00       	jmp    105ffe <vprintfmt+0x3d1>

        // error message
        case 'e':
            err = va_arg(ap, int);
  105d5a:	8b 45 14             	mov    0x14(%ebp),%eax
  105d5d:	8d 50 04             	lea    0x4(%eax),%edx
  105d60:	89 55 14             	mov    %edx,0x14(%ebp)
  105d63:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  105d65:	85 db                	test   %ebx,%ebx
  105d67:	79 02                	jns    105d6b <vprintfmt+0x13e>
                err = -err;
  105d69:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  105d6b:	83 fb 06             	cmp    $0x6,%ebx
  105d6e:	7f 0b                	jg     105d7b <vprintfmt+0x14e>
  105d70:	8b 34 9d 88 72 10 00 	mov    0x107288(,%ebx,4),%esi
  105d77:	85 f6                	test   %esi,%esi
  105d79:	75 23                	jne    105d9e <vprintfmt+0x171>
                printfmt(putch, putdat, "error %d", err);
  105d7b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  105d7f:	c7 44 24 08 b5 72 10 	movl   $0x1072b5,0x8(%esp)
  105d86:	00 
  105d87:	8b 45 0c             	mov    0xc(%ebp),%eax
  105d8a:	89 44 24 04          	mov    %eax,0x4(%esp)
  105d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  105d91:	89 04 24             	mov    %eax,(%esp)
  105d94:	e8 61 fe ff ff       	call   105bfa <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  105d99:	e9 60 02 00 00       	jmp    105ffe <vprintfmt+0x3d1>
                printfmt(putch, putdat, "%s", p);
  105d9e:	89 74 24 0c          	mov    %esi,0xc(%esp)
  105da2:	c7 44 24 08 be 72 10 	movl   $0x1072be,0x8(%esp)
  105da9:	00 
  105daa:	8b 45 0c             	mov    0xc(%ebp),%eax
  105dad:	89 44 24 04          	mov    %eax,0x4(%esp)
  105db1:	8b 45 08             	mov    0x8(%ebp),%eax
  105db4:	89 04 24             	mov    %eax,(%esp)
  105db7:	e8 3e fe ff ff       	call   105bfa <printfmt>
            break;
  105dbc:	e9 3d 02 00 00       	jmp    105ffe <vprintfmt+0x3d1>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  105dc1:	8b 45 14             	mov    0x14(%ebp),%eax
  105dc4:	8d 50 04             	lea    0x4(%eax),%edx
  105dc7:	89 55 14             	mov    %edx,0x14(%ebp)
  105dca:	8b 30                	mov    (%eax),%esi
  105dcc:	85 f6                	test   %esi,%esi
  105dce:	75 05                	jne    105dd5 <vprintfmt+0x1a8>
                p = "(null)";
  105dd0:	be c1 72 10 00       	mov    $0x1072c1,%esi
            }
            if (width > 0 && padc != '-') {
  105dd5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105dd9:	7e 76                	jle    105e51 <vprintfmt+0x224>
  105ddb:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  105ddf:	74 70                	je     105e51 <vprintfmt+0x224>
                for (width -= strnlen(p, precision); width > 0; width --) {
  105de1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  105de4:	89 44 24 04          	mov    %eax,0x4(%esp)
  105de8:	89 34 24             	mov    %esi,(%esp)
  105deb:	e8 ba f7 ff ff       	call   1055aa <strnlen>
  105df0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  105df3:	29 c2                	sub    %eax,%edx
  105df5:	89 d0                	mov    %edx,%eax
  105df7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  105dfa:	eb 16                	jmp    105e12 <vprintfmt+0x1e5>
                    putch(padc, putdat);
  105dfc:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  105e00:	8b 55 0c             	mov    0xc(%ebp),%edx
  105e03:	89 54 24 04          	mov    %edx,0x4(%esp)
  105e07:	89 04 24             	mov    %eax,(%esp)
  105e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  105e0d:	ff d0                	call   *%eax
                for (width -= strnlen(p, precision); width > 0; width --) {
  105e0f:	ff 4d e8             	decl   -0x18(%ebp)
  105e12:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105e16:	7f e4                	jg     105dfc <vprintfmt+0x1cf>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  105e18:	eb 37                	jmp    105e51 <vprintfmt+0x224>
                if (altflag && (ch < ' ' || ch > '~')) {
  105e1a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  105e1e:	74 1f                	je     105e3f <vprintfmt+0x212>
  105e20:	83 fb 1f             	cmp    $0x1f,%ebx
  105e23:	7e 05                	jle    105e2a <vprintfmt+0x1fd>
  105e25:	83 fb 7e             	cmp    $0x7e,%ebx
  105e28:	7e 15                	jle    105e3f <vprintfmt+0x212>
                    putch('?', putdat);
  105e2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  105e2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  105e31:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  105e38:	8b 45 08             	mov    0x8(%ebp),%eax
  105e3b:	ff d0                	call   *%eax
  105e3d:	eb 0f                	jmp    105e4e <vprintfmt+0x221>
                }
                else {
                    putch(ch, putdat);
  105e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  105e42:	89 44 24 04          	mov    %eax,0x4(%esp)
  105e46:	89 1c 24             	mov    %ebx,(%esp)
  105e49:	8b 45 08             	mov    0x8(%ebp),%eax
  105e4c:	ff d0                	call   *%eax
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  105e4e:	ff 4d e8             	decl   -0x18(%ebp)
  105e51:	89 f0                	mov    %esi,%eax
  105e53:	8d 70 01             	lea    0x1(%eax),%esi
  105e56:	0f b6 00             	movzbl (%eax),%eax
  105e59:	0f be d8             	movsbl %al,%ebx
  105e5c:	85 db                	test   %ebx,%ebx
  105e5e:	74 27                	je     105e87 <vprintfmt+0x25a>
  105e60:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  105e64:	78 b4                	js     105e1a <vprintfmt+0x1ed>
  105e66:	ff 4d e4             	decl   -0x1c(%ebp)
  105e69:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  105e6d:	79 ab                	jns    105e1a <vprintfmt+0x1ed>
                }
            }
            for (; width > 0; width --) {
  105e6f:	eb 16                	jmp    105e87 <vprintfmt+0x25a>
                putch(' ', putdat);
  105e71:	8b 45 0c             	mov    0xc(%ebp),%eax
  105e74:	89 44 24 04          	mov    %eax,0x4(%esp)
  105e78:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  105e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  105e82:	ff d0                	call   *%eax
            for (; width > 0; width --) {
  105e84:	ff 4d e8             	decl   -0x18(%ebp)
  105e87:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  105e8b:	7f e4                	jg     105e71 <vprintfmt+0x244>
            }
            break;
  105e8d:	e9 6c 01 00 00       	jmp    105ffe <vprintfmt+0x3d1>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  105e92:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105e95:	89 44 24 04          	mov    %eax,0x4(%esp)
  105e99:	8d 45 14             	lea    0x14(%ebp),%eax
  105e9c:	89 04 24             	mov    %eax,(%esp)
  105e9f:	e8 0b fd ff ff       	call   105baf <getint>
  105ea4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105ea7:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  105eaa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105ead:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105eb0:	85 d2                	test   %edx,%edx
  105eb2:	79 26                	jns    105eda <vprintfmt+0x2ad>
                putch('-', putdat);
  105eb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  105eb7:	89 44 24 04          	mov    %eax,0x4(%esp)
  105ebb:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  105ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  105ec5:	ff d0                	call   *%eax
                num = -(long long)num;
  105ec7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105eca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105ecd:	f7 d8                	neg    %eax
  105ecf:	83 d2 00             	adc    $0x0,%edx
  105ed2:	f7 da                	neg    %edx
  105ed4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105ed7:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  105eda:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  105ee1:	e9 a8 00 00 00       	jmp    105f8e <vprintfmt+0x361>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  105ee6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105ee9:	89 44 24 04          	mov    %eax,0x4(%esp)
  105eed:	8d 45 14             	lea    0x14(%ebp),%eax
  105ef0:	89 04 24             	mov    %eax,(%esp)
  105ef3:	e8 64 fc ff ff       	call   105b5c <getuint>
  105ef8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105efb:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  105efe:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  105f05:	e9 84 00 00 00       	jmp    105f8e <vprintfmt+0x361>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  105f0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105f0d:	89 44 24 04          	mov    %eax,0x4(%esp)
  105f11:	8d 45 14             	lea    0x14(%ebp),%eax
  105f14:	89 04 24             	mov    %eax,(%esp)
  105f17:	e8 40 fc ff ff       	call   105b5c <getuint>
  105f1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105f1f:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  105f22:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  105f29:	eb 63                	jmp    105f8e <vprintfmt+0x361>

        // pointer
        case 'p':
            putch('0', putdat);
  105f2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  105f2e:	89 44 24 04          	mov    %eax,0x4(%esp)
  105f32:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  105f39:	8b 45 08             	mov    0x8(%ebp),%eax
  105f3c:	ff d0                	call   *%eax
            putch('x', putdat);
  105f3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  105f41:	89 44 24 04          	mov    %eax,0x4(%esp)
  105f45:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  105f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  105f4f:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  105f51:	8b 45 14             	mov    0x14(%ebp),%eax
  105f54:	8d 50 04             	lea    0x4(%eax),%edx
  105f57:	89 55 14             	mov    %edx,0x14(%ebp)
  105f5a:	8b 00                	mov    (%eax),%eax
  105f5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105f5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  105f66:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  105f6d:	eb 1f                	jmp    105f8e <vprintfmt+0x361>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  105f6f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  105f72:	89 44 24 04          	mov    %eax,0x4(%esp)
  105f76:	8d 45 14             	lea    0x14(%ebp),%eax
  105f79:	89 04 24             	mov    %eax,(%esp)
  105f7c:	e8 db fb ff ff       	call   105b5c <getuint>
  105f81:	89 45 f0             	mov    %eax,-0x10(%ebp)
  105f84:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  105f87:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  105f8e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  105f92:	8b 45 ec             	mov    -0x14(%ebp),%eax
  105f95:	89 54 24 18          	mov    %edx,0x18(%esp)
  105f99:	8b 55 e8             	mov    -0x18(%ebp),%edx
  105f9c:	89 54 24 14          	mov    %edx,0x14(%esp)
  105fa0:	89 44 24 10          	mov    %eax,0x10(%esp)
  105fa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  105fa7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  105faa:	89 44 24 08          	mov    %eax,0x8(%esp)
  105fae:	89 54 24 0c          	mov    %edx,0xc(%esp)
  105fb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  105fb5:	89 44 24 04          	mov    %eax,0x4(%esp)
  105fb9:	8b 45 08             	mov    0x8(%ebp),%eax
  105fbc:	89 04 24             	mov    %eax,(%esp)
  105fbf:	e8 94 fa ff ff       	call   105a58 <printnum>
            break;
  105fc4:	eb 38                	jmp    105ffe <vprintfmt+0x3d1>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  105fc6:	8b 45 0c             	mov    0xc(%ebp),%eax
  105fc9:	89 44 24 04          	mov    %eax,0x4(%esp)
  105fcd:	89 1c 24             	mov    %ebx,(%esp)
  105fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  105fd3:	ff d0                	call   *%eax
            break;
  105fd5:	eb 27                	jmp    105ffe <vprintfmt+0x3d1>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  105fd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  105fda:	89 44 24 04          	mov    %eax,0x4(%esp)
  105fde:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  105fe5:	8b 45 08             	mov    0x8(%ebp),%eax
  105fe8:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  105fea:	ff 4d 10             	decl   0x10(%ebp)
  105fed:	eb 03                	jmp    105ff2 <vprintfmt+0x3c5>
  105fef:	ff 4d 10             	decl   0x10(%ebp)
  105ff2:	8b 45 10             	mov    0x10(%ebp),%eax
  105ff5:	48                   	dec    %eax
  105ff6:	0f b6 00             	movzbl (%eax),%eax
  105ff9:	3c 25                	cmp    $0x25,%al
  105ffb:	75 f2                	jne    105fef <vprintfmt+0x3c2>
                /* do nothing */;
            break;
  105ffd:	90                   	nop
    while (1) {
  105ffe:	e9 36 fc ff ff       	jmp    105c39 <vprintfmt+0xc>
                return;
  106003:	90                   	nop
        }
    }
}
  106004:	83 c4 40             	add    $0x40,%esp
  106007:	5b                   	pop    %ebx
  106008:	5e                   	pop    %esi
  106009:	5d                   	pop    %ebp
  10600a:	c3                   	ret    

0010600b <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:         the character will be printed
 * @b:          the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  10600b:	f3 0f 1e fb          	endbr32 
  10600f:	55                   	push   %ebp
  106010:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  106012:	8b 45 0c             	mov    0xc(%ebp),%eax
  106015:	8b 40 08             	mov    0x8(%eax),%eax
  106018:	8d 50 01             	lea    0x1(%eax),%edx
  10601b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10601e:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  106021:	8b 45 0c             	mov    0xc(%ebp),%eax
  106024:	8b 10                	mov    (%eax),%edx
  106026:	8b 45 0c             	mov    0xc(%ebp),%eax
  106029:	8b 40 04             	mov    0x4(%eax),%eax
  10602c:	39 c2                	cmp    %eax,%edx
  10602e:	73 12                	jae    106042 <sprintputch+0x37>
        *b->buf ++ = ch;
  106030:	8b 45 0c             	mov    0xc(%ebp),%eax
  106033:	8b 00                	mov    (%eax),%eax
  106035:	8d 48 01             	lea    0x1(%eax),%ecx
  106038:	8b 55 0c             	mov    0xc(%ebp),%edx
  10603b:	89 0a                	mov    %ecx,(%edx)
  10603d:	8b 55 08             	mov    0x8(%ebp),%edx
  106040:	88 10                	mov    %dl,(%eax)
    }
}
  106042:	90                   	nop
  106043:	5d                   	pop    %ebp
  106044:	c3                   	ret    

00106045 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:       the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  106045:	f3 0f 1e fb          	endbr32 
  106049:	55                   	push   %ebp
  10604a:	89 e5                	mov    %esp,%ebp
  10604c:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  10604f:	8d 45 14             	lea    0x14(%ebp),%eax
  106052:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  106055:	8b 45 f0             	mov    -0x10(%ebp),%eax
  106058:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10605c:	8b 45 10             	mov    0x10(%ebp),%eax
  10605f:	89 44 24 08          	mov    %eax,0x8(%esp)
  106063:	8b 45 0c             	mov    0xc(%ebp),%eax
  106066:	89 44 24 04          	mov    %eax,0x4(%esp)
  10606a:	8b 45 08             	mov    0x8(%ebp),%eax
  10606d:	89 04 24             	mov    %eax,(%esp)
  106070:	e8 08 00 00 00       	call   10607d <vsnprintf>
  106075:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  106078:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10607b:	c9                   	leave  
  10607c:	c3                   	ret    

0010607d <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  10607d:	f3 0f 1e fb          	endbr32 
  106081:	55                   	push   %ebp
  106082:	89 e5                	mov    %esp,%ebp
  106084:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  106087:	8b 45 08             	mov    0x8(%ebp),%eax
  10608a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10608d:	8b 45 0c             	mov    0xc(%ebp),%eax
  106090:	8d 50 ff             	lea    -0x1(%eax),%edx
  106093:	8b 45 08             	mov    0x8(%ebp),%eax
  106096:	01 d0                	add    %edx,%eax
  106098:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10609b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  1060a2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1060a6:	74 0a                	je     1060b2 <vsnprintf+0x35>
  1060a8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1060ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1060ae:	39 c2                	cmp    %eax,%edx
  1060b0:	76 07                	jbe    1060b9 <vsnprintf+0x3c>
        return -E_INVAL;
  1060b2:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  1060b7:	eb 2a                	jmp    1060e3 <vsnprintf+0x66>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  1060b9:	8b 45 14             	mov    0x14(%ebp),%eax
  1060bc:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1060c0:	8b 45 10             	mov    0x10(%ebp),%eax
  1060c3:	89 44 24 08          	mov    %eax,0x8(%esp)
  1060c7:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1060ca:	89 44 24 04          	mov    %eax,0x4(%esp)
  1060ce:	c7 04 24 0b 60 10 00 	movl   $0x10600b,(%esp)
  1060d5:	e8 53 fb ff ff       	call   105c2d <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  1060da:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1060dd:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1060e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1060e3:	c9                   	leave  
  1060e4:	c3                   	ret    
