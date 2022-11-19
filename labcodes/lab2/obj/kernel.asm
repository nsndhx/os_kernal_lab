
bin/kernel：     文件格式 elf32-i386


Disassembly of section .text:

c0100000 <kern_entry>:

.text
.globl kern_entry
kern_entry:
    # load pa of boot pgdir
    movl $REALLOC(__boot_pgdir), %eax
c0100000:	b8 00 a0 11 00       	mov    $0x11a000,%eax
    movl %eax, %cr3
c0100005:	0f 22 d8             	mov    %eax,%cr3

    # enable paging
    movl %cr0, %eax
c0100008:	0f 20 c0             	mov    %cr0,%eax
    orl $(CR0_PE | CR0_PG | CR0_AM | CR0_WP | CR0_NE | CR0_TS | CR0_EM | CR0_MP), %eax
c010000b:	0d 2f 00 05 80       	or     $0x8005002f,%eax
    andl $~(CR0_TS | CR0_EM), %eax
c0100010:	83 e0 f3             	and    $0xfffffff3,%eax
    movl %eax, %cr0
c0100013:	0f 22 c0             	mov    %eax,%cr0

    # update eip
    # now, eip = 0x1.....
    leal next, %eax
c0100016:	8d 05 1e 00 10 c0    	lea    0xc010001e,%eax
    # set eip = KERNBASE + 0x1.....
    jmp *%eax
c010001c:	ff e0                	jmp    *%eax

c010001e <next>:
next:

    # unmap va 0 ~ 4M, it's temporary mapping
    xorl %eax, %eax
c010001e:	31 c0                	xor    %eax,%eax
    movl %eax, __boot_pgdir
c0100020:	a3 00 a0 11 c0       	mov    %eax,0xc011a000

    # set ebp, esp
    movl $0x0, %ebp
c0100025:	bd 00 00 00 00       	mov    $0x0,%ebp
    # the kernel stack region is from bootstack -- bootstacktop,
    # the kernel stack size is KSTACKSIZE (8KB)defined in memlayout.h
    movl $bootstacktop, %esp
c010002a:	bc 00 90 11 c0       	mov    $0xc0119000,%esp
    # now kernel stack is ready , call the first C function
    call kern_init
c010002f:	e8 02 00 00 00       	call   c0100036 <kern_init>

c0100034 <spin>:

# should never get here
spin:
    jmp spin
c0100034:	eb fe                	jmp    c0100034 <spin>

c0100036 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
c0100036:	f3 0f 1e fb          	endbr32 
c010003a:	55                   	push   %ebp
c010003b:	89 e5                	mov    %esp,%ebp
c010003d:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
c0100040:	b8 28 cf 11 c0       	mov    $0xc011cf28,%eax
c0100045:	2d 00 c0 11 c0       	sub    $0xc011c000,%eax
c010004a:	89 44 24 08          	mov    %eax,0x8(%esp)
c010004e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0100055:	00 
c0100056:	c7 04 24 00 c0 11 c0 	movl   $0xc011c000,(%esp)
c010005d:	e8 5f 58 00 00       	call   c01058c1 <memset>

    cons_init();                // init the console
c0100062:	e8 9d 15 00 00       	call   c0101604 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
c0100067:	c7 45 f4 00 61 10 c0 	movl   $0xc0106100,-0xc(%ebp)
    cprintf("%s\n\n", message);
c010006e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100071:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100075:	c7 04 24 1c 61 10 c0 	movl   $0xc010611c,(%esp)
c010007c:	e8 48 02 00 00       	call   c01002c9 <cprintf>

    print_kerninfo();
c0100081:	e8 06 09 00 00       	call   c010098c <print_kerninfo>

    grade_backtrace();
c0100086:	e8 9a 00 00 00       	call   c0100125 <grade_backtrace>

    pmm_init();                 // init physical memory management
c010008b:	e8 58 32 00 00       	call   c01032e8 <pmm_init>

    pic_init();                 // init interrupt controller
c0100090:	e8 ea 16 00 00       	call   c010177f <pic_init>
    idt_init();                 // init interrupt descriptor table
c0100095:	e8 8f 18 00 00       	call   c0101929 <idt_init>

    clock_init();               // init clock interrupt
c010009a:	e8 ac 0c 00 00       	call   c0100d4b <clock_init>
    intr_enable();              // enable irq interrupt
c010009f:	e8 27 18 00 00       	call   c01018cb <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
c01000a4:	e8 86 01 00 00       	call   c010022f <lab1_switch_test>

    /* do nothing */
    while (1);
c01000a9:	eb fe                	jmp    c01000a9 <kern_init+0x73>

c01000ab <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
c01000ab:	f3 0f 1e fb          	endbr32 
c01000af:	55                   	push   %ebp
c01000b0:	89 e5                	mov    %esp,%ebp
c01000b2:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
c01000b5:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c01000bc:	00 
c01000bd:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c01000c4:	00 
c01000c5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
c01000cc:	e8 64 0c 00 00       	call   c0100d35 <mon_backtrace>
}
c01000d1:	90                   	nop
c01000d2:	c9                   	leave  
c01000d3:	c3                   	ret    

c01000d4 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
c01000d4:	f3 0f 1e fb          	endbr32 
c01000d8:	55                   	push   %ebp
c01000d9:	89 e5                	mov    %esp,%ebp
c01000db:	53                   	push   %ebx
c01000dc:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
c01000df:	8d 4d 0c             	lea    0xc(%ebp),%ecx
c01000e2:	8b 55 0c             	mov    0xc(%ebp),%edx
c01000e5:	8d 5d 08             	lea    0x8(%ebp),%ebx
c01000e8:	8b 45 08             	mov    0x8(%ebp),%eax
c01000eb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
c01000ef:	89 54 24 08          	mov    %edx,0x8(%esp)
c01000f3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
c01000f7:	89 04 24             	mov    %eax,(%esp)
c01000fa:	e8 ac ff ff ff       	call   c01000ab <grade_backtrace2>
}
c01000ff:	90                   	nop
c0100100:	83 c4 14             	add    $0x14,%esp
c0100103:	5b                   	pop    %ebx
c0100104:	5d                   	pop    %ebp
c0100105:	c3                   	ret    

c0100106 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
c0100106:	f3 0f 1e fb          	endbr32 
c010010a:	55                   	push   %ebp
c010010b:	89 e5                	mov    %esp,%ebp
c010010d:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
c0100110:	8b 45 10             	mov    0x10(%ebp),%eax
c0100113:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100117:	8b 45 08             	mov    0x8(%ebp),%eax
c010011a:	89 04 24             	mov    %eax,(%esp)
c010011d:	e8 b2 ff ff ff       	call   c01000d4 <grade_backtrace1>
}
c0100122:	90                   	nop
c0100123:	c9                   	leave  
c0100124:	c3                   	ret    

c0100125 <grade_backtrace>:

void
grade_backtrace(void) {
c0100125:	f3 0f 1e fb          	endbr32 
c0100129:	55                   	push   %ebp
c010012a:	89 e5                	mov    %esp,%ebp
c010012c:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
c010012f:	b8 36 00 10 c0       	mov    $0xc0100036,%eax
c0100134:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
c010013b:	ff 
c010013c:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100140:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
c0100147:	e8 ba ff ff ff       	call   c0100106 <grade_backtrace0>
}
c010014c:	90                   	nop
c010014d:	c9                   	leave  
c010014e:	c3                   	ret    

c010014f <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
c010014f:	f3 0f 1e fb          	endbr32 
c0100153:	55                   	push   %ebp
c0100154:	89 e5                	mov    %esp,%ebp
c0100156:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
c0100159:	8c 4d f6             	mov    %cs,-0xa(%ebp)
c010015c:	8c 5d f4             	mov    %ds,-0xc(%ebp)
c010015f:	8c 45 f2             	mov    %es,-0xe(%ebp)
c0100162:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
c0100165:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0100169:	83 e0 03             	and    $0x3,%eax
c010016c:	89 c2                	mov    %eax,%edx
c010016e:	a1 00 c0 11 c0       	mov    0xc011c000,%eax
c0100173:	89 54 24 08          	mov    %edx,0x8(%esp)
c0100177:	89 44 24 04          	mov    %eax,0x4(%esp)
c010017b:	c7 04 24 21 61 10 c0 	movl   $0xc0106121,(%esp)
c0100182:	e8 42 01 00 00       	call   c01002c9 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
c0100187:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c010018b:	89 c2                	mov    %eax,%edx
c010018d:	a1 00 c0 11 c0       	mov    0xc011c000,%eax
c0100192:	89 54 24 08          	mov    %edx,0x8(%esp)
c0100196:	89 44 24 04          	mov    %eax,0x4(%esp)
c010019a:	c7 04 24 2f 61 10 c0 	movl   $0xc010612f,(%esp)
c01001a1:	e8 23 01 00 00       	call   c01002c9 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
c01001a6:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
c01001aa:	89 c2                	mov    %eax,%edx
c01001ac:	a1 00 c0 11 c0       	mov    0xc011c000,%eax
c01001b1:	89 54 24 08          	mov    %edx,0x8(%esp)
c01001b5:	89 44 24 04          	mov    %eax,0x4(%esp)
c01001b9:	c7 04 24 3d 61 10 c0 	movl   $0xc010613d,(%esp)
c01001c0:	e8 04 01 00 00       	call   c01002c9 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
c01001c5:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c01001c9:	89 c2                	mov    %eax,%edx
c01001cb:	a1 00 c0 11 c0       	mov    0xc011c000,%eax
c01001d0:	89 54 24 08          	mov    %edx,0x8(%esp)
c01001d4:	89 44 24 04          	mov    %eax,0x4(%esp)
c01001d8:	c7 04 24 4b 61 10 c0 	movl   $0xc010614b,(%esp)
c01001df:	e8 e5 00 00 00       	call   c01002c9 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
c01001e4:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
c01001e8:	89 c2                	mov    %eax,%edx
c01001ea:	a1 00 c0 11 c0       	mov    0xc011c000,%eax
c01001ef:	89 54 24 08          	mov    %edx,0x8(%esp)
c01001f3:	89 44 24 04          	mov    %eax,0x4(%esp)
c01001f7:	c7 04 24 59 61 10 c0 	movl   $0xc0106159,(%esp)
c01001fe:	e8 c6 00 00 00       	call   c01002c9 <cprintf>
    round ++;
c0100203:	a1 00 c0 11 c0       	mov    0xc011c000,%eax
c0100208:	40                   	inc    %eax
c0100209:	a3 00 c0 11 c0       	mov    %eax,0xc011c000
}
c010020e:	90                   	nop
c010020f:	c9                   	leave  
c0100210:	c3                   	ret    

c0100211 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
c0100211:	f3 0f 1e fb          	endbr32 
c0100215:	55                   	push   %ebp
c0100216:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
    //中断处理例程处于ring 0,所以内核态发生的中断不发生堆栈切换，因此SS、ESP不会自动压栈;但是是否弹出SS、ESP确实由堆栈上的CS中的特权位决定的。当我们将堆栈中的CS的特权位设置为ring 3时，IRET会误认为中断是从ring 3发生的，执行时会按照发生特权级切换的情况弹出SS、ESP。
    //利用这个特性，只需要手动地将内核堆栈布局设置为发生了特权级转换时的布局，将所有的特权位修改为DPL_USER,保持EIP、ESP不变，IRET执行后就可以切换为应用态。
    //因为从内核态发生中断不压入SS、ESP，所以在中断前手动压入SS、ESP。中断处理过程中会修改tf->tf_esp的值，中断发生前压入的SS实际不会被使用，所以代码中仅仅是压入了%ss占位。
    //为了在切换为应用态后，保存原有堆栈结构不变，确保程序正确运行，栈顶的位置应该被恢复到中断发生前的位置。SS、ESP是通过push指令压栈的，压入SS后，ESP的值已经上移了4个字节，所以在trap_dispatch将ESP下移4字节。
    asm volatile (
c0100218:	16                   	push   %ss
c0100219:	54                   	push   %esp
c010021a:	cd 78                	int    $0x78
c010021c:	89 ec                	mov    %ebp,%esp
        "int %0 \n"
        "movl %%ebp, %%esp"
        : 
        : "i"(T_SWITCH_TOU)
    );
}
c010021e:	90                   	nop
c010021f:	5d                   	pop    %ebp
c0100220:	c3                   	ret    

c0100221 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
c0100221:	f3 0f 1e fb          	endbr32 
c0100225:	55                   	push   %ebp
c0100226:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
    //在用户态发生中断时堆栈会从用户栈切换到内核栈，并压入SS、ESP等寄存器。在篡改内核堆栈后IRET返回时会误认为没有特权级转换发生，不会把SS、ESP弹出，因此从用户态切换到内核态时需要手动弹出SS、ESP。
    //tf->tf_esp指向发生中断前用户栈栈顶，IRET执行后程序仍处于内核态
    asm volatile (
c0100228:	cd 79                	int    $0x79
c010022a:	89 ec                	mov    %ebp,%esp
        "int %0 \n"
        "movl %%ebp, %%esp \n"
        : 
        : "i"(T_SWITCH_TOK)
    );
}
c010022c:	90                   	nop
c010022d:	5d                   	pop    %ebp
c010022e:	c3                   	ret    

c010022f <lab1_switch_test>:

static void
lab1_switch_test(void) {
c010022f:	f3 0f 1e fb          	endbr32 
c0100233:	55                   	push   %ebp
c0100234:	89 e5                	mov    %esp,%ebp
c0100236:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();//print 当前 cs/ss/ds 等寄存器状态
c0100239:	e8 11 ff ff ff       	call   c010014f <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
c010023e:	c7 04 24 68 61 10 c0 	movl   $0xc0106168,(%esp)
c0100245:	e8 7f 00 00 00       	call   c01002c9 <cprintf>
    lab1_switch_to_user();
c010024a:	e8 c2 ff ff ff       	call   c0100211 <lab1_switch_to_user>
    lab1_print_cur_status();
c010024f:	e8 fb fe ff ff       	call   c010014f <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
c0100254:	c7 04 24 88 61 10 c0 	movl   $0xc0106188,(%esp)
c010025b:	e8 69 00 00 00       	call   c01002c9 <cprintf>
    lab1_switch_to_kernel();
c0100260:	e8 bc ff ff ff       	call   c0100221 <lab1_switch_to_kernel>
    lab1_print_cur_status();
c0100265:	e8 e5 fe ff ff       	call   c010014f <lab1_print_cur_status>
}
c010026a:	90                   	nop
c010026b:	c9                   	leave  
c010026c:	c3                   	ret    

c010026d <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
c010026d:	f3 0f 1e fb          	endbr32 
c0100271:	55                   	push   %ebp
c0100272:	89 e5                	mov    %esp,%ebp
c0100274:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
c0100277:	8b 45 08             	mov    0x8(%ebp),%eax
c010027a:	89 04 24             	mov    %eax,(%esp)
c010027d:	e8 b3 13 00 00       	call   c0101635 <cons_putc>
    (*cnt) ++;
c0100282:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100285:	8b 00                	mov    (%eax),%eax
c0100287:	8d 50 01             	lea    0x1(%eax),%edx
c010028a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010028d:	89 10                	mov    %edx,(%eax)
}
c010028f:	90                   	nop
c0100290:	c9                   	leave  
c0100291:	c3                   	ret    

c0100292 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
c0100292:	f3 0f 1e fb          	endbr32 
c0100296:	55                   	push   %ebp
c0100297:	89 e5                	mov    %esp,%ebp
c0100299:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
c010029c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
c01002a3:	8b 45 0c             	mov    0xc(%ebp),%eax
c01002a6:	89 44 24 0c          	mov    %eax,0xc(%esp)
c01002aa:	8b 45 08             	mov    0x8(%ebp),%eax
c01002ad:	89 44 24 08          	mov    %eax,0x8(%esp)
c01002b1:	8d 45 f4             	lea    -0xc(%ebp),%eax
c01002b4:	89 44 24 04          	mov    %eax,0x4(%esp)
c01002b8:	c7 04 24 6d 02 10 c0 	movl   $0xc010026d,(%esp)
c01002bf:	e8 69 59 00 00       	call   c0105c2d <vprintfmt>
    return cnt;
c01002c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01002c7:	c9                   	leave  
c01002c8:	c3                   	ret    

c01002c9 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
c01002c9:	f3 0f 1e fb          	endbr32 
c01002cd:	55                   	push   %ebp
c01002ce:	89 e5                	mov    %esp,%ebp
c01002d0:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
c01002d3:	8d 45 0c             	lea    0xc(%ebp),%eax
c01002d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
c01002d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01002dc:	89 44 24 04          	mov    %eax,0x4(%esp)
c01002e0:	8b 45 08             	mov    0x8(%ebp),%eax
c01002e3:	89 04 24             	mov    %eax,(%esp)
c01002e6:	e8 a7 ff ff ff       	call   c0100292 <vcprintf>
c01002eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
c01002ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01002f1:	c9                   	leave  
c01002f2:	c3                   	ret    

c01002f3 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
c01002f3:	f3 0f 1e fb          	endbr32 
c01002f7:	55                   	push   %ebp
c01002f8:	89 e5                	mov    %esp,%ebp
c01002fa:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
c01002fd:	8b 45 08             	mov    0x8(%ebp),%eax
c0100300:	89 04 24             	mov    %eax,(%esp)
c0100303:	e8 2d 13 00 00       	call   c0101635 <cons_putc>
}
c0100308:	90                   	nop
c0100309:	c9                   	leave  
c010030a:	c3                   	ret    

c010030b <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
c010030b:	f3 0f 1e fb          	endbr32 
c010030f:	55                   	push   %ebp
c0100310:	89 e5                	mov    %esp,%ebp
c0100312:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
c0100315:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
c010031c:	eb 13                	jmp    c0100331 <cputs+0x26>
        cputch(c, &cnt);
c010031e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
c0100322:	8d 55 f0             	lea    -0x10(%ebp),%edx
c0100325:	89 54 24 04          	mov    %edx,0x4(%esp)
c0100329:	89 04 24             	mov    %eax,(%esp)
c010032c:	e8 3c ff ff ff       	call   c010026d <cputch>
    while ((c = *str ++) != '\0') {
c0100331:	8b 45 08             	mov    0x8(%ebp),%eax
c0100334:	8d 50 01             	lea    0x1(%eax),%edx
c0100337:	89 55 08             	mov    %edx,0x8(%ebp)
c010033a:	0f b6 00             	movzbl (%eax),%eax
c010033d:	88 45 f7             	mov    %al,-0x9(%ebp)
c0100340:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
c0100344:	75 d8                	jne    c010031e <cputs+0x13>
    }
    cputch('\n', &cnt);
c0100346:	8d 45 f0             	lea    -0x10(%ebp),%eax
c0100349:	89 44 24 04          	mov    %eax,0x4(%esp)
c010034d:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
c0100354:	e8 14 ff ff ff       	call   c010026d <cputch>
    return cnt;
c0100359:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
c010035c:	c9                   	leave  
c010035d:	c3                   	ret    

c010035e <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
c010035e:	f3 0f 1e fb          	endbr32 
c0100362:	55                   	push   %ebp
c0100363:	89 e5                	mov    %esp,%ebp
c0100365:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
c0100368:	90                   	nop
c0100369:	e8 08 13 00 00       	call   c0101676 <cons_getc>
c010036e:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0100371:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100375:	74 f2                	je     c0100369 <getchar+0xb>
        /* do nothing */;
    return c;
c0100377:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c010037a:	c9                   	leave  
c010037b:	c3                   	ret    

c010037c <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
c010037c:	f3 0f 1e fb          	endbr32 
c0100380:	55                   	push   %ebp
c0100381:	89 e5                	mov    %esp,%ebp
c0100383:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
c0100386:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c010038a:	74 13                	je     c010039f <readline+0x23>
        cprintf("%s", prompt);
c010038c:	8b 45 08             	mov    0x8(%ebp),%eax
c010038f:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100393:	c7 04 24 a7 61 10 c0 	movl   $0xc01061a7,(%esp)
c010039a:	e8 2a ff ff ff       	call   c01002c9 <cprintf>
    }
    int i = 0, c;
c010039f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
c01003a6:	e8 b3 ff ff ff       	call   c010035e <getchar>
c01003ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
c01003ae:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c01003b2:	79 07                	jns    c01003bb <readline+0x3f>
            return NULL;
c01003b4:	b8 00 00 00 00       	mov    $0x0,%eax
c01003b9:	eb 78                	jmp    c0100433 <readline+0xb7>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
c01003bb:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
c01003bf:	7e 28                	jle    c01003e9 <readline+0x6d>
c01003c1:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
c01003c8:	7f 1f                	jg     c01003e9 <readline+0x6d>
            cputchar(c);
c01003ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01003cd:	89 04 24             	mov    %eax,(%esp)
c01003d0:	e8 1e ff ff ff       	call   c01002f3 <cputchar>
            buf[i ++] = c;
c01003d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01003d8:	8d 50 01             	lea    0x1(%eax),%edx
c01003db:	89 55 f4             	mov    %edx,-0xc(%ebp)
c01003de:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01003e1:	88 90 20 c0 11 c0    	mov    %dl,-0x3fee3fe0(%eax)
c01003e7:	eb 45                	jmp    c010042e <readline+0xb2>
        }
        else if (c == '\b' && i > 0) {
c01003e9:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
c01003ed:	75 16                	jne    c0100405 <readline+0x89>
c01003ef:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01003f3:	7e 10                	jle    c0100405 <readline+0x89>
            cputchar(c);
c01003f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01003f8:	89 04 24             	mov    %eax,(%esp)
c01003fb:	e8 f3 fe ff ff       	call   c01002f3 <cputchar>
            i --;
c0100400:	ff 4d f4             	decl   -0xc(%ebp)
c0100403:	eb 29                	jmp    c010042e <readline+0xb2>
        }
        else if (c == '\n' || c == '\r') {
c0100405:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
c0100409:	74 06                	je     c0100411 <readline+0x95>
c010040b:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
c010040f:	75 95                	jne    c01003a6 <readline+0x2a>
            cputchar(c);
c0100411:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100414:	89 04 24             	mov    %eax,(%esp)
c0100417:	e8 d7 fe ff ff       	call   c01002f3 <cputchar>
            buf[i] = '\0';
c010041c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010041f:	05 20 c0 11 c0       	add    $0xc011c020,%eax
c0100424:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
c0100427:	b8 20 c0 11 c0       	mov    $0xc011c020,%eax
c010042c:	eb 05                	jmp    c0100433 <readline+0xb7>
        c = getchar();
c010042e:	e9 73 ff ff ff       	jmp    c01003a6 <readline+0x2a>
        }
    }
}
c0100433:	c9                   	leave  
c0100434:	c3                   	ret    

c0100435 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
c0100435:	f3 0f 1e fb          	endbr32 
c0100439:	55                   	push   %ebp
c010043a:	89 e5                	mov    %esp,%ebp
c010043c:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
c010043f:	a1 20 c4 11 c0       	mov    0xc011c420,%eax
c0100444:	85 c0                	test   %eax,%eax
c0100446:	75 5b                	jne    c01004a3 <__panic+0x6e>
        goto panic_dead;
    }
    is_panic = 1;
c0100448:	c7 05 20 c4 11 c0 01 	movl   $0x1,0xc011c420
c010044f:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
c0100452:	8d 45 14             	lea    0x14(%ebp),%eax
c0100455:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
c0100458:	8b 45 0c             	mov    0xc(%ebp),%eax
c010045b:	89 44 24 08          	mov    %eax,0x8(%esp)
c010045f:	8b 45 08             	mov    0x8(%ebp),%eax
c0100462:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100466:	c7 04 24 aa 61 10 c0 	movl   $0xc01061aa,(%esp)
c010046d:	e8 57 fe ff ff       	call   c01002c9 <cprintf>
    vcprintf(fmt, ap);
c0100472:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100475:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100479:	8b 45 10             	mov    0x10(%ebp),%eax
c010047c:	89 04 24             	mov    %eax,(%esp)
c010047f:	e8 0e fe ff ff       	call   c0100292 <vcprintf>
    cprintf("\n");
c0100484:	c7 04 24 c6 61 10 c0 	movl   $0xc01061c6,(%esp)
c010048b:	e8 39 fe ff ff       	call   c01002c9 <cprintf>
    
    cprintf("stack trackback:\n");
c0100490:	c7 04 24 c8 61 10 c0 	movl   $0xc01061c8,(%esp)
c0100497:	e8 2d fe ff ff       	call   c01002c9 <cprintf>
    print_stackframe();
c010049c:	e8 3d 06 00 00       	call   c0100ade <print_stackframe>
c01004a1:	eb 01                	jmp    c01004a4 <__panic+0x6f>
        goto panic_dead;
c01004a3:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
c01004a4:	e8 2e 14 00 00       	call   c01018d7 <intr_disable>
    while (1) {
        kmonitor(NULL);
c01004a9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
c01004b0:	e8 a7 07 00 00       	call   c0100c5c <kmonitor>
c01004b5:	eb f2                	jmp    c01004a9 <__panic+0x74>

c01004b7 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
c01004b7:	f3 0f 1e fb          	endbr32 
c01004bb:	55                   	push   %ebp
c01004bc:	89 e5                	mov    %esp,%ebp
c01004be:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
c01004c1:	8d 45 14             	lea    0x14(%ebp),%eax
c01004c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
c01004c7:	8b 45 0c             	mov    0xc(%ebp),%eax
c01004ca:	89 44 24 08          	mov    %eax,0x8(%esp)
c01004ce:	8b 45 08             	mov    0x8(%ebp),%eax
c01004d1:	89 44 24 04          	mov    %eax,0x4(%esp)
c01004d5:	c7 04 24 da 61 10 c0 	movl   $0xc01061da,(%esp)
c01004dc:	e8 e8 fd ff ff       	call   c01002c9 <cprintf>
    vcprintf(fmt, ap);
c01004e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01004e4:	89 44 24 04          	mov    %eax,0x4(%esp)
c01004e8:	8b 45 10             	mov    0x10(%ebp),%eax
c01004eb:	89 04 24             	mov    %eax,(%esp)
c01004ee:	e8 9f fd ff ff       	call   c0100292 <vcprintf>
    cprintf("\n");
c01004f3:	c7 04 24 c6 61 10 c0 	movl   $0xc01061c6,(%esp)
c01004fa:	e8 ca fd ff ff       	call   c01002c9 <cprintf>
    va_end(ap);
}
c01004ff:	90                   	nop
c0100500:	c9                   	leave  
c0100501:	c3                   	ret    

c0100502 <is_kernel_panic>:

bool
is_kernel_panic(void) {
c0100502:	f3 0f 1e fb          	endbr32 
c0100506:	55                   	push   %ebp
c0100507:	89 e5                	mov    %esp,%ebp
    return is_panic;
c0100509:	a1 20 c4 11 c0       	mov    0xc011c420,%eax
}
c010050e:	5d                   	pop    %ebp
c010050f:	c3                   	ret    

c0100510 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
c0100510:	f3 0f 1e fb          	endbr32 
c0100514:	55                   	push   %ebp
c0100515:	89 e5                	mov    %esp,%ebp
c0100517:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
c010051a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010051d:	8b 00                	mov    (%eax),%eax
c010051f:	89 45 fc             	mov    %eax,-0x4(%ebp)
c0100522:	8b 45 10             	mov    0x10(%ebp),%eax
c0100525:	8b 00                	mov    (%eax),%eax
c0100527:	89 45 f8             	mov    %eax,-0x8(%ebp)
c010052a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
c0100531:	e9 ca 00 00 00       	jmp    c0100600 <stab_binsearch+0xf0>
        int true_m = (l + r) / 2, m = true_m;
c0100536:	8b 55 fc             	mov    -0x4(%ebp),%edx
c0100539:	8b 45 f8             	mov    -0x8(%ebp),%eax
c010053c:	01 d0                	add    %edx,%eax
c010053e:	89 c2                	mov    %eax,%edx
c0100540:	c1 ea 1f             	shr    $0x1f,%edx
c0100543:	01 d0                	add    %edx,%eax
c0100545:	d1 f8                	sar    %eax
c0100547:	89 45 ec             	mov    %eax,-0x14(%ebp)
c010054a:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010054d:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
c0100550:	eb 03                	jmp    c0100555 <stab_binsearch+0x45>
            m --;
c0100552:	ff 4d f0             	decl   -0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
c0100555:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0100558:	3b 45 fc             	cmp    -0x4(%ebp),%eax
c010055b:	7c 1f                	jl     c010057c <stab_binsearch+0x6c>
c010055d:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0100560:	89 d0                	mov    %edx,%eax
c0100562:	01 c0                	add    %eax,%eax
c0100564:	01 d0                	add    %edx,%eax
c0100566:	c1 e0 02             	shl    $0x2,%eax
c0100569:	89 c2                	mov    %eax,%edx
c010056b:	8b 45 08             	mov    0x8(%ebp),%eax
c010056e:	01 d0                	add    %edx,%eax
c0100570:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c0100574:	0f b6 c0             	movzbl %al,%eax
c0100577:	39 45 14             	cmp    %eax,0x14(%ebp)
c010057a:	75 d6                	jne    c0100552 <stab_binsearch+0x42>
        }
        if (m < l) {    // no match in [l, m]
c010057c:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010057f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
c0100582:	7d 09                	jge    c010058d <stab_binsearch+0x7d>
            l = true_m + 1;
c0100584:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0100587:	40                   	inc    %eax
c0100588:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
c010058b:	eb 73                	jmp    c0100600 <stab_binsearch+0xf0>
        }

        // actual binary search
        any_matches = 1;
c010058d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
c0100594:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0100597:	89 d0                	mov    %edx,%eax
c0100599:	01 c0                	add    %eax,%eax
c010059b:	01 d0                	add    %edx,%eax
c010059d:	c1 e0 02             	shl    $0x2,%eax
c01005a0:	89 c2                	mov    %eax,%edx
c01005a2:	8b 45 08             	mov    0x8(%ebp),%eax
c01005a5:	01 d0                	add    %edx,%eax
c01005a7:	8b 40 08             	mov    0x8(%eax),%eax
c01005aa:	39 45 18             	cmp    %eax,0x18(%ebp)
c01005ad:	76 11                	jbe    c01005c0 <stab_binsearch+0xb0>
            *region_left = m;
c01005af:	8b 45 0c             	mov    0xc(%ebp),%eax
c01005b2:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01005b5:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
c01005b7:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01005ba:	40                   	inc    %eax
c01005bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
c01005be:	eb 40                	jmp    c0100600 <stab_binsearch+0xf0>
        } else if (stabs[m].n_value > addr) {
c01005c0:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01005c3:	89 d0                	mov    %edx,%eax
c01005c5:	01 c0                	add    %eax,%eax
c01005c7:	01 d0                	add    %edx,%eax
c01005c9:	c1 e0 02             	shl    $0x2,%eax
c01005cc:	89 c2                	mov    %eax,%edx
c01005ce:	8b 45 08             	mov    0x8(%ebp),%eax
c01005d1:	01 d0                	add    %edx,%eax
c01005d3:	8b 40 08             	mov    0x8(%eax),%eax
c01005d6:	39 45 18             	cmp    %eax,0x18(%ebp)
c01005d9:	73 14                	jae    c01005ef <stab_binsearch+0xdf>
            *region_right = m - 1;
c01005db:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01005de:	8d 50 ff             	lea    -0x1(%eax),%edx
c01005e1:	8b 45 10             	mov    0x10(%ebp),%eax
c01005e4:	89 10                	mov    %edx,(%eax)
            r = m - 1;
c01005e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01005e9:	48                   	dec    %eax
c01005ea:	89 45 f8             	mov    %eax,-0x8(%ebp)
c01005ed:	eb 11                	jmp    c0100600 <stab_binsearch+0xf0>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
c01005ef:	8b 45 0c             	mov    0xc(%ebp),%eax
c01005f2:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01005f5:	89 10                	mov    %edx,(%eax)
            l = m;
c01005f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01005fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
c01005fd:	ff 45 18             	incl   0x18(%ebp)
    while (l <= r) {
c0100600:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100603:	3b 45 f8             	cmp    -0x8(%ebp),%eax
c0100606:	0f 8e 2a ff ff ff    	jle    c0100536 <stab_binsearch+0x26>
        }
    }

    if (!any_matches) {
c010060c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100610:	75 0f                	jne    c0100621 <stab_binsearch+0x111>
        *region_right = *region_left - 1;
c0100612:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100615:	8b 00                	mov    (%eax),%eax
c0100617:	8d 50 ff             	lea    -0x1(%eax),%edx
c010061a:	8b 45 10             	mov    0x10(%ebp),%eax
c010061d:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
c010061f:	eb 3e                	jmp    c010065f <stab_binsearch+0x14f>
        l = *region_right;
c0100621:	8b 45 10             	mov    0x10(%ebp),%eax
c0100624:	8b 00                	mov    (%eax),%eax
c0100626:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
c0100629:	eb 03                	jmp    c010062e <stab_binsearch+0x11e>
c010062b:	ff 4d fc             	decl   -0x4(%ebp)
c010062e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100631:	8b 00                	mov    (%eax),%eax
c0100633:	39 45 fc             	cmp    %eax,-0x4(%ebp)
c0100636:	7e 1f                	jle    c0100657 <stab_binsearch+0x147>
c0100638:	8b 55 fc             	mov    -0x4(%ebp),%edx
c010063b:	89 d0                	mov    %edx,%eax
c010063d:	01 c0                	add    %eax,%eax
c010063f:	01 d0                	add    %edx,%eax
c0100641:	c1 e0 02             	shl    $0x2,%eax
c0100644:	89 c2                	mov    %eax,%edx
c0100646:	8b 45 08             	mov    0x8(%ebp),%eax
c0100649:	01 d0                	add    %edx,%eax
c010064b:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c010064f:	0f b6 c0             	movzbl %al,%eax
c0100652:	39 45 14             	cmp    %eax,0x14(%ebp)
c0100655:	75 d4                	jne    c010062b <stab_binsearch+0x11b>
        *region_left = l;
c0100657:	8b 45 0c             	mov    0xc(%ebp),%eax
c010065a:	8b 55 fc             	mov    -0x4(%ebp),%edx
c010065d:	89 10                	mov    %edx,(%eax)
}
c010065f:	90                   	nop
c0100660:	c9                   	leave  
c0100661:	c3                   	ret    

c0100662 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
c0100662:	f3 0f 1e fb          	endbr32 
c0100666:	55                   	push   %ebp
c0100667:	89 e5                	mov    %esp,%ebp
c0100669:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
c010066c:	8b 45 0c             	mov    0xc(%ebp),%eax
c010066f:	c7 00 f8 61 10 c0    	movl   $0xc01061f8,(%eax)
    info->eip_line = 0;
c0100675:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100678:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
c010067f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100682:	c7 40 08 f8 61 10 c0 	movl   $0xc01061f8,0x8(%eax)
    info->eip_fn_namelen = 9;
c0100689:	8b 45 0c             	mov    0xc(%ebp),%eax
c010068c:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
c0100693:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100696:	8b 55 08             	mov    0x8(%ebp),%edx
c0100699:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
c010069c:	8b 45 0c             	mov    0xc(%ebp),%eax
c010069f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
c01006a6:	c7 45 f4 20 74 10 c0 	movl   $0xc0107420,-0xc(%ebp)
    stab_end = __STAB_END__;
c01006ad:	c7 45 f0 e8 3b 11 c0 	movl   $0xc0113be8,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
c01006b4:	c7 45 ec e9 3b 11 c0 	movl   $0xc0113be9,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
c01006bb:	c7 45 e8 ee 66 11 c0 	movl   $0xc01166ee,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
c01006c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01006c5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c01006c8:	76 0b                	jbe    c01006d5 <debuginfo_eip+0x73>
c01006ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01006cd:	48                   	dec    %eax
c01006ce:	0f b6 00             	movzbl (%eax),%eax
c01006d1:	84 c0                	test   %al,%al
c01006d3:	74 0a                	je     c01006df <debuginfo_eip+0x7d>
        return -1;
c01006d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c01006da:	e9 ab 02 00 00       	jmp    c010098a <debuginfo_eip+0x328>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
c01006df:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
c01006e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01006e9:	2b 45 f4             	sub    -0xc(%ebp),%eax
c01006ec:	c1 f8 02             	sar    $0x2,%eax
c01006ef:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
c01006f5:	48                   	dec    %eax
c01006f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
c01006f9:	8b 45 08             	mov    0x8(%ebp),%eax
c01006fc:	89 44 24 10          	mov    %eax,0x10(%esp)
c0100700:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
c0100707:	00 
c0100708:	8d 45 e0             	lea    -0x20(%ebp),%eax
c010070b:	89 44 24 08          	mov    %eax,0x8(%esp)
c010070f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
c0100712:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100716:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100719:	89 04 24             	mov    %eax,(%esp)
c010071c:	e8 ef fd ff ff       	call   c0100510 <stab_binsearch>
    if (lfile == 0)
c0100721:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0100724:	85 c0                	test   %eax,%eax
c0100726:	75 0a                	jne    c0100732 <debuginfo_eip+0xd0>
        return -1;
c0100728:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c010072d:	e9 58 02 00 00       	jmp    c010098a <debuginfo_eip+0x328>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
c0100732:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0100735:	89 45 dc             	mov    %eax,-0x24(%ebp)
c0100738:	8b 45 e0             	mov    -0x20(%ebp),%eax
c010073b:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
c010073e:	8b 45 08             	mov    0x8(%ebp),%eax
c0100741:	89 44 24 10          	mov    %eax,0x10(%esp)
c0100745:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
c010074c:	00 
c010074d:	8d 45 d8             	lea    -0x28(%ebp),%eax
c0100750:	89 44 24 08          	mov    %eax,0x8(%esp)
c0100754:	8d 45 dc             	lea    -0x24(%ebp),%eax
c0100757:	89 44 24 04          	mov    %eax,0x4(%esp)
c010075b:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010075e:	89 04 24             	mov    %eax,(%esp)
c0100761:	e8 aa fd ff ff       	call   c0100510 <stab_binsearch>

    if (lfun <= rfun) {
c0100766:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0100769:	8b 45 d8             	mov    -0x28(%ebp),%eax
c010076c:	39 c2                	cmp    %eax,%edx
c010076e:	7f 78                	jg     c01007e8 <debuginfo_eip+0x186>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
c0100770:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100773:	89 c2                	mov    %eax,%edx
c0100775:	89 d0                	mov    %edx,%eax
c0100777:	01 c0                	add    %eax,%eax
c0100779:	01 d0                	add    %edx,%eax
c010077b:	c1 e0 02             	shl    $0x2,%eax
c010077e:	89 c2                	mov    %eax,%edx
c0100780:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100783:	01 d0                	add    %edx,%eax
c0100785:	8b 10                	mov    (%eax),%edx
c0100787:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010078a:	2b 45 ec             	sub    -0x14(%ebp),%eax
c010078d:	39 c2                	cmp    %eax,%edx
c010078f:	73 22                	jae    c01007b3 <debuginfo_eip+0x151>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
c0100791:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100794:	89 c2                	mov    %eax,%edx
c0100796:	89 d0                	mov    %edx,%eax
c0100798:	01 c0                	add    %eax,%eax
c010079a:	01 d0                	add    %edx,%eax
c010079c:	c1 e0 02             	shl    $0x2,%eax
c010079f:	89 c2                	mov    %eax,%edx
c01007a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01007a4:	01 d0                	add    %edx,%eax
c01007a6:	8b 10                	mov    (%eax),%edx
c01007a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01007ab:	01 c2                	add    %eax,%edx
c01007ad:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007b0:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
c01007b3:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01007b6:	89 c2                	mov    %eax,%edx
c01007b8:	89 d0                	mov    %edx,%eax
c01007ba:	01 c0                	add    %eax,%eax
c01007bc:	01 d0                	add    %edx,%eax
c01007be:	c1 e0 02             	shl    $0x2,%eax
c01007c1:	89 c2                	mov    %eax,%edx
c01007c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01007c6:	01 d0                	add    %edx,%eax
c01007c8:	8b 50 08             	mov    0x8(%eax),%edx
c01007cb:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007ce:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
c01007d1:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007d4:	8b 40 10             	mov    0x10(%eax),%eax
c01007d7:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
c01007da:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01007dd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
c01007e0:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01007e3:	89 45 d0             	mov    %eax,-0x30(%ebp)
c01007e6:	eb 15                	jmp    c01007fd <debuginfo_eip+0x19b>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
c01007e8:	8b 45 0c             	mov    0xc(%ebp),%eax
c01007eb:	8b 55 08             	mov    0x8(%ebp),%edx
c01007ee:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
c01007f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01007f4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
c01007f7:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01007fa:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
c01007fd:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100800:	8b 40 08             	mov    0x8(%eax),%eax
c0100803:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
c010080a:	00 
c010080b:	89 04 24             	mov    %eax,(%esp)
c010080e:	e8 22 4f 00 00       	call   c0105735 <strfind>
c0100813:	8b 55 0c             	mov    0xc(%ebp),%edx
c0100816:	8b 52 08             	mov    0x8(%edx),%edx
c0100819:	29 d0                	sub    %edx,%eax
c010081b:	89 c2                	mov    %eax,%edx
c010081d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100820:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
c0100823:	8b 45 08             	mov    0x8(%ebp),%eax
c0100826:	89 44 24 10          	mov    %eax,0x10(%esp)
c010082a:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
c0100831:	00 
c0100832:	8d 45 d0             	lea    -0x30(%ebp),%eax
c0100835:	89 44 24 08          	mov    %eax,0x8(%esp)
c0100839:	8d 45 d4             	lea    -0x2c(%ebp),%eax
c010083c:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100840:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100843:	89 04 24             	mov    %eax,(%esp)
c0100846:	e8 c5 fc ff ff       	call   c0100510 <stab_binsearch>
    if (lline <= rline) {
c010084b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010084e:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0100851:	39 c2                	cmp    %eax,%edx
c0100853:	7f 23                	jg     c0100878 <debuginfo_eip+0x216>
        info->eip_line = stabs[rline].n_desc;
c0100855:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0100858:	89 c2                	mov    %eax,%edx
c010085a:	89 d0                	mov    %edx,%eax
c010085c:	01 c0                	add    %eax,%eax
c010085e:	01 d0                	add    %edx,%eax
c0100860:	c1 e0 02             	shl    $0x2,%eax
c0100863:	89 c2                	mov    %eax,%edx
c0100865:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100868:	01 d0                	add    %edx,%eax
c010086a:	0f b7 40 06          	movzwl 0x6(%eax),%eax
c010086e:	89 c2                	mov    %eax,%edx
c0100870:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100873:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
c0100876:	eb 11                	jmp    c0100889 <debuginfo_eip+0x227>
        return -1;
c0100878:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c010087d:	e9 08 01 00 00       	jmp    c010098a <debuginfo_eip+0x328>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
c0100882:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100885:	48                   	dec    %eax
c0100886:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
c0100889:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010088c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c010088f:	39 c2                	cmp    %eax,%edx
c0100891:	7c 56                	jl     c01008e9 <debuginfo_eip+0x287>
           && stabs[lline].n_type != N_SOL
c0100893:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100896:	89 c2                	mov    %eax,%edx
c0100898:	89 d0                	mov    %edx,%eax
c010089a:	01 c0                	add    %eax,%eax
c010089c:	01 d0                	add    %edx,%eax
c010089e:	c1 e0 02             	shl    $0x2,%eax
c01008a1:	89 c2                	mov    %eax,%edx
c01008a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01008a6:	01 d0                	add    %edx,%eax
c01008a8:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c01008ac:	3c 84                	cmp    $0x84,%al
c01008ae:	74 39                	je     c01008e9 <debuginfo_eip+0x287>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
c01008b0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01008b3:	89 c2                	mov    %eax,%edx
c01008b5:	89 d0                	mov    %edx,%eax
c01008b7:	01 c0                	add    %eax,%eax
c01008b9:	01 d0                	add    %edx,%eax
c01008bb:	c1 e0 02             	shl    $0x2,%eax
c01008be:	89 c2                	mov    %eax,%edx
c01008c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01008c3:	01 d0                	add    %edx,%eax
c01008c5:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c01008c9:	3c 64                	cmp    $0x64,%al
c01008cb:	75 b5                	jne    c0100882 <debuginfo_eip+0x220>
c01008cd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01008d0:	89 c2                	mov    %eax,%edx
c01008d2:	89 d0                	mov    %edx,%eax
c01008d4:	01 c0                	add    %eax,%eax
c01008d6:	01 d0                	add    %edx,%eax
c01008d8:	c1 e0 02             	shl    $0x2,%eax
c01008db:	89 c2                	mov    %eax,%edx
c01008dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01008e0:	01 d0                	add    %edx,%eax
c01008e2:	8b 40 08             	mov    0x8(%eax),%eax
c01008e5:	85 c0                	test   %eax,%eax
c01008e7:	74 99                	je     c0100882 <debuginfo_eip+0x220>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
c01008e9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01008ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01008ef:	39 c2                	cmp    %eax,%edx
c01008f1:	7c 42                	jl     c0100935 <debuginfo_eip+0x2d3>
c01008f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c01008f6:	89 c2                	mov    %eax,%edx
c01008f8:	89 d0                	mov    %edx,%eax
c01008fa:	01 c0                	add    %eax,%eax
c01008fc:	01 d0                	add    %edx,%eax
c01008fe:	c1 e0 02             	shl    $0x2,%eax
c0100901:	89 c2                	mov    %eax,%edx
c0100903:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100906:	01 d0                	add    %edx,%eax
c0100908:	8b 10                	mov    (%eax),%edx
c010090a:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010090d:	2b 45 ec             	sub    -0x14(%ebp),%eax
c0100910:	39 c2                	cmp    %eax,%edx
c0100912:	73 21                	jae    c0100935 <debuginfo_eip+0x2d3>
        info->eip_file = stabstr + stabs[lline].n_strx;
c0100914:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0100917:	89 c2                	mov    %eax,%edx
c0100919:	89 d0                	mov    %edx,%eax
c010091b:	01 c0                	add    %eax,%eax
c010091d:	01 d0                	add    %edx,%eax
c010091f:	c1 e0 02             	shl    $0x2,%eax
c0100922:	89 c2                	mov    %eax,%edx
c0100924:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100927:	01 d0                	add    %edx,%eax
c0100929:	8b 10                	mov    (%eax),%edx
c010092b:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010092e:	01 c2                	add    %eax,%edx
c0100930:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100933:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
c0100935:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0100938:	8b 45 d8             	mov    -0x28(%ebp),%eax
c010093b:	39 c2                	cmp    %eax,%edx
c010093d:	7d 46                	jge    c0100985 <debuginfo_eip+0x323>
        for (lline = lfun + 1;
c010093f:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100942:	40                   	inc    %eax
c0100943:	89 45 d4             	mov    %eax,-0x2c(%ebp)
c0100946:	eb 16                	jmp    c010095e <debuginfo_eip+0x2fc>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
c0100948:	8b 45 0c             	mov    0xc(%ebp),%eax
c010094b:	8b 40 14             	mov    0x14(%eax),%eax
c010094e:	8d 50 01             	lea    0x1(%eax),%edx
c0100951:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100954:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
c0100957:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010095a:	40                   	inc    %eax
c010095b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
c010095e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0100961:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
c0100964:	39 c2                	cmp    %eax,%edx
c0100966:	7d 1d                	jge    c0100985 <debuginfo_eip+0x323>
             lline < rfun && stabs[lline].n_type == N_PSYM;
c0100968:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c010096b:	89 c2                	mov    %eax,%edx
c010096d:	89 d0                	mov    %edx,%eax
c010096f:	01 c0                	add    %eax,%eax
c0100971:	01 d0                	add    %edx,%eax
c0100973:	c1 e0 02             	shl    $0x2,%eax
c0100976:	89 c2                	mov    %eax,%edx
c0100978:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010097b:	01 d0                	add    %edx,%eax
c010097d:	0f b6 40 04          	movzbl 0x4(%eax),%eax
c0100981:	3c a0                	cmp    $0xa0,%al
c0100983:	74 c3                	je     c0100948 <debuginfo_eip+0x2e6>
        }
    }
    return 0;
c0100985:	b8 00 00 00 00       	mov    $0x0,%eax
}
c010098a:	c9                   	leave  
c010098b:	c3                   	ret    

c010098c <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
c010098c:	f3 0f 1e fb          	endbr32 
c0100990:	55                   	push   %ebp
c0100991:	89 e5                	mov    %esp,%ebp
c0100993:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
c0100996:	c7 04 24 02 62 10 c0 	movl   $0xc0106202,(%esp)
c010099d:	e8 27 f9 ff ff       	call   c01002c9 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
c01009a2:	c7 44 24 04 36 00 10 	movl   $0xc0100036,0x4(%esp)
c01009a9:	c0 
c01009aa:	c7 04 24 1b 62 10 c0 	movl   $0xc010621b,(%esp)
c01009b1:	e8 13 f9 ff ff       	call   c01002c9 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
c01009b6:	c7 44 24 04 e5 60 10 	movl   $0xc01060e5,0x4(%esp)
c01009bd:	c0 
c01009be:	c7 04 24 33 62 10 c0 	movl   $0xc0106233,(%esp)
c01009c5:	e8 ff f8 ff ff       	call   c01002c9 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
c01009ca:	c7 44 24 04 00 c0 11 	movl   $0xc011c000,0x4(%esp)
c01009d1:	c0 
c01009d2:	c7 04 24 4b 62 10 c0 	movl   $0xc010624b,(%esp)
c01009d9:	e8 eb f8 ff ff       	call   c01002c9 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
c01009de:	c7 44 24 04 28 cf 11 	movl   $0xc011cf28,0x4(%esp)
c01009e5:	c0 
c01009e6:	c7 04 24 63 62 10 c0 	movl   $0xc0106263,(%esp)
c01009ed:	e8 d7 f8 ff ff       	call   c01002c9 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
c01009f2:	b8 28 cf 11 c0       	mov    $0xc011cf28,%eax
c01009f7:	2d 36 00 10 c0       	sub    $0xc0100036,%eax
c01009fc:	05 ff 03 00 00       	add    $0x3ff,%eax
c0100a01:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
c0100a07:	85 c0                	test   %eax,%eax
c0100a09:	0f 48 c2             	cmovs  %edx,%eax
c0100a0c:	c1 f8 0a             	sar    $0xa,%eax
c0100a0f:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100a13:	c7 04 24 7c 62 10 c0 	movl   $0xc010627c,(%esp)
c0100a1a:	e8 aa f8 ff ff       	call   c01002c9 <cprintf>
}
c0100a1f:	90                   	nop
c0100a20:	c9                   	leave  
c0100a21:	c3                   	ret    

c0100a22 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
c0100a22:	f3 0f 1e fb          	endbr32 
c0100a26:	55                   	push   %ebp
c0100a27:	89 e5                	mov    %esp,%ebp
c0100a29:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
c0100a2f:	8d 45 dc             	lea    -0x24(%ebp),%eax
c0100a32:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100a36:	8b 45 08             	mov    0x8(%ebp),%eax
c0100a39:	89 04 24             	mov    %eax,(%esp)
c0100a3c:	e8 21 fc ff ff       	call   c0100662 <debuginfo_eip>
c0100a41:	85 c0                	test   %eax,%eax
c0100a43:	74 15                	je     c0100a5a <print_debuginfo+0x38>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
c0100a45:	8b 45 08             	mov    0x8(%ebp),%eax
c0100a48:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100a4c:	c7 04 24 a6 62 10 c0 	movl   $0xc01062a6,(%esp)
c0100a53:	e8 71 f8 ff ff       	call   c01002c9 <cprintf>
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
c0100a58:	eb 6c                	jmp    c0100ac6 <print_debuginfo+0xa4>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
c0100a5a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100a61:	eb 1b                	jmp    c0100a7e <print_debuginfo+0x5c>
            fnname[j] = info.eip_fn_name[j];
c0100a63:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0100a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a69:	01 d0                	add    %edx,%eax
c0100a6b:	0f b6 10             	movzbl (%eax),%edx
c0100a6e:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
c0100a74:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a77:	01 c8                	add    %ecx,%eax
c0100a79:	88 10                	mov    %dl,(%eax)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
c0100a7b:	ff 45 f4             	incl   -0xc(%ebp)
c0100a7e:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0100a81:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0100a84:	7c dd                	jl     c0100a63 <print_debuginfo+0x41>
        fnname[j] = '\0';
c0100a86:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
c0100a8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100a8f:	01 d0                	add    %edx,%eax
c0100a91:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
c0100a94:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
c0100a97:	8b 55 08             	mov    0x8(%ebp),%edx
c0100a9a:	89 d1                	mov    %edx,%ecx
c0100a9c:	29 c1                	sub    %eax,%ecx
c0100a9e:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0100aa1:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0100aa4:	89 4c 24 10          	mov    %ecx,0x10(%esp)
c0100aa8:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
c0100aae:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
c0100ab2:	89 54 24 08          	mov    %edx,0x8(%esp)
c0100ab6:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100aba:	c7 04 24 c2 62 10 c0 	movl   $0xc01062c2,(%esp)
c0100ac1:	e8 03 f8 ff ff       	call   c01002c9 <cprintf>
}
c0100ac6:	90                   	nop
c0100ac7:	c9                   	leave  
c0100ac8:	c3                   	ret    

c0100ac9 <read_eip>:

static __noinline uint32_t
read_eip(void) {
c0100ac9:	f3 0f 1e fb          	endbr32 
c0100acd:	55                   	push   %ebp
c0100ace:	89 e5                	mov    %esp,%ebp
c0100ad0:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
c0100ad3:	8b 45 04             	mov    0x4(%ebp),%eax
c0100ad6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
c0100ad9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c0100adc:	c9                   	leave  
c0100add:	c3                   	ret    

c0100ade <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
c0100ade:	f3 0f 1e fb          	endbr32 
c0100ae2:	55                   	push   %ebp
c0100ae3:	89 e5                	mov    %esp,%ebp
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
}
c0100ae5:	90                   	nop
c0100ae6:	5d                   	pop    %ebp
c0100ae7:	c3                   	ret    

c0100ae8 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
c0100ae8:	f3 0f 1e fb          	endbr32 
c0100aec:	55                   	push   %ebp
c0100aed:	89 e5                	mov    %esp,%ebp
c0100aef:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
c0100af2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100af9:	eb 0c                	jmp    c0100b07 <parse+0x1f>
            *buf ++ = '\0';
c0100afb:	8b 45 08             	mov    0x8(%ebp),%eax
c0100afe:	8d 50 01             	lea    0x1(%eax),%edx
c0100b01:	89 55 08             	mov    %edx,0x8(%ebp)
c0100b04:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100b07:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b0a:	0f b6 00             	movzbl (%eax),%eax
c0100b0d:	84 c0                	test   %al,%al
c0100b0f:	74 1d                	je     c0100b2e <parse+0x46>
c0100b11:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b14:	0f b6 00             	movzbl (%eax),%eax
c0100b17:	0f be c0             	movsbl %al,%eax
c0100b1a:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100b1e:	c7 04 24 54 63 10 c0 	movl   $0xc0106354,(%esp)
c0100b25:	e8 d5 4b 00 00       	call   c01056ff <strchr>
c0100b2a:	85 c0                	test   %eax,%eax
c0100b2c:	75 cd                	jne    c0100afb <parse+0x13>
        }
        if (*buf == '\0') {
c0100b2e:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b31:	0f b6 00             	movzbl (%eax),%eax
c0100b34:	84 c0                	test   %al,%al
c0100b36:	74 65                	je     c0100b9d <parse+0xb5>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
c0100b38:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
c0100b3c:	75 14                	jne    c0100b52 <parse+0x6a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
c0100b3e:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
c0100b45:	00 
c0100b46:	c7 04 24 59 63 10 c0 	movl   $0xc0106359,(%esp)
c0100b4d:	e8 77 f7 ff ff       	call   c01002c9 <cprintf>
        }
        argv[argc ++] = buf;
c0100b52:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100b55:	8d 50 01             	lea    0x1(%eax),%edx
c0100b58:	89 55 f4             	mov    %edx,-0xc(%ebp)
c0100b5b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0100b62:	8b 45 0c             	mov    0xc(%ebp),%eax
c0100b65:	01 c2                	add    %eax,%edx
c0100b67:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b6a:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
c0100b6c:	eb 03                	jmp    c0100b71 <parse+0x89>
            buf ++;
c0100b6e:	ff 45 08             	incl   0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
c0100b71:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b74:	0f b6 00             	movzbl (%eax),%eax
c0100b77:	84 c0                	test   %al,%al
c0100b79:	74 8c                	je     c0100b07 <parse+0x1f>
c0100b7b:	8b 45 08             	mov    0x8(%ebp),%eax
c0100b7e:	0f b6 00             	movzbl (%eax),%eax
c0100b81:	0f be c0             	movsbl %al,%eax
c0100b84:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100b88:	c7 04 24 54 63 10 c0 	movl   $0xc0106354,(%esp)
c0100b8f:	e8 6b 4b 00 00       	call   c01056ff <strchr>
c0100b94:	85 c0                	test   %eax,%eax
c0100b96:	74 d6                	je     c0100b6e <parse+0x86>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
c0100b98:	e9 6a ff ff ff       	jmp    c0100b07 <parse+0x1f>
            break;
c0100b9d:	90                   	nop
        }
    }
    return argc;
c0100b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0100ba1:	c9                   	leave  
c0100ba2:	c3                   	ret    

c0100ba3 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
c0100ba3:	f3 0f 1e fb          	endbr32 
c0100ba7:	55                   	push   %ebp
c0100ba8:	89 e5                	mov    %esp,%ebp
c0100baa:	53                   	push   %ebx
c0100bab:	83 ec 64             	sub    $0x64,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
c0100bae:	8d 45 b0             	lea    -0x50(%ebp),%eax
c0100bb1:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100bb5:	8b 45 08             	mov    0x8(%ebp),%eax
c0100bb8:	89 04 24             	mov    %eax,(%esp)
c0100bbb:	e8 28 ff ff ff       	call   c0100ae8 <parse>
c0100bc0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
c0100bc3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0100bc7:	75 0a                	jne    c0100bd3 <runcmd+0x30>
        return 0;
c0100bc9:	b8 00 00 00 00       	mov    $0x0,%eax
c0100bce:	e9 83 00 00 00       	jmp    c0100c56 <runcmd+0xb3>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
c0100bd3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100bda:	eb 5a                	jmp    c0100c36 <runcmd+0x93>
        if (strcmp(commands[i].name, argv[0]) == 0) {
c0100bdc:	8b 4d b0             	mov    -0x50(%ebp),%ecx
c0100bdf:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100be2:	89 d0                	mov    %edx,%eax
c0100be4:	01 c0                	add    %eax,%eax
c0100be6:	01 d0                	add    %edx,%eax
c0100be8:	c1 e0 02             	shl    $0x2,%eax
c0100beb:	05 00 90 11 c0       	add    $0xc0119000,%eax
c0100bf0:	8b 00                	mov    (%eax),%eax
c0100bf2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
c0100bf6:	89 04 24             	mov    %eax,(%esp)
c0100bf9:	e8 5d 4a 00 00       	call   c010565b <strcmp>
c0100bfe:	85 c0                	test   %eax,%eax
c0100c00:	75 31                	jne    c0100c33 <runcmd+0x90>
            return commands[i].func(argc - 1, argv + 1, tf);
c0100c02:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100c05:	89 d0                	mov    %edx,%eax
c0100c07:	01 c0                	add    %eax,%eax
c0100c09:	01 d0                	add    %edx,%eax
c0100c0b:	c1 e0 02             	shl    $0x2,%eax
c0100c0e:	05 08 90 11 c0       	add    $0xc0119008,%eax
c0100c13:	8b 10                	mov    (%eax),%edx
c0100c15:	8d 45 b0             	lea    -0x50(%ebp),%eax
c0100c18:	83 c0 04             	add    $0x4,%eax
c0100c1b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
c0100c1e:	8d 59 ff             	lea    -0x1(%ecx),%ebx
c0100c21:	8b 4d 0c             	mov    0xc(%ebp),%ecx
c0100c24:	89 4c 24 08          	mov    %ecx,0x8(%esp)
c0100c28:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100c2c:	89 1c 24             	mov    %ebx,(%esp)
c0100c2f:	ff d2                	call   *%edx
c0100c31:	eb 23                	jmp    c0100c56 <runcmd+0xb3>
    for (i = 0; i < NCOMMANDS; i ++) {
c0100c33:	ff 45 f4             	incl   -0xc(%ebp)
c0100c36:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100c39:	83 f8 02             	cmp    $0x2,%eax
c0100c3c:	76 9e                	jbe    c0100bdc <runcmd+0x39>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
c0100c3e:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0100c41:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100c45:	c7 04 24 77 63 10 c0 	movl   $0xc0106377,(%esp)
c0100c4c:	e8 78 f6 ff ff       	call   c01002c9 <cprintf>
    return 0;
c0100c51:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100c56:	83 c4 64             	add    $0x64,%esp
c0100c59:	5b                   	pop    %ebx
c0100c5a:	5d                   	pop    %ebp
c0100c5b:	c3                   	ret    

c0100c5c <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
c0100c5c:	f3 0f 1e fb          	endbr32 
c0100c60:	55                   	push   %ebp
c0100c61:	89 e5                	mov    %esp,%ebp
c0100c63:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
c0100c66:	c7 04 24 90 63 10 c0 	movl   $0xc0106390,(%esp)
c0100c6d:	e8 57 f6 ff ff       	call   c01002c9 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
c0100c72:	c7 04 24 b8 63 10 c0 	movl   $0xc01063b8,(%esp)
c0100c79:	e8 4b f6 ff ff       	call   c01002c9 <cprintf>

    if (tf != NULL) {
c0100c7e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0100c82:	74 0b                	je     c0100c8f <kmonitor+0x33>
        print_trapframe(tf);
c0100c84:	8b 45 08             	mov    0x8(%ebp),%eax
c0100c87:	89 04 24             	mov    %eax,(%esp)
c0100c8a:	e8 5f 0e 00 00       	call   c0101aee <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
c0100c8f:	c7 04 24 dd 63 10 c0 	movl   $0xc01063dd,(%esp)
c0100c96:	e8 e1 f6 ff ff       	call   c010037c <readline>
c0100c9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0100c9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0100ca2:	74 eb                	je     c0100c8f <kmonitor+0x33>
            if (runcmd(buf, tf) < 0) {
c0100ca4:	8b 45 08             	mov    0x8(%ebp),%eax
c0100ca7:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100cab:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100cae:	89 04 24             	mov    %eax,(%esp)
c0100cb1:	e8 ed fe ff ff       	call   c0100ba3 <runcmd>
c0100cb6:	85 c0                	test   %eax,%eax
c0100cb8:	78 02                	js     c0100cbc <kmonitor+0x60>
        if ((buf = readline("K> ")) != NULL) {
c0100cba:	eb d3                	jmp    c0100c8f <kmonitor+0x33>
                break;
c0100cbc:	90                   	nop
            }
        }
    }
}
c0100cbd:	90                   	nop
c0100cbe:	c9                   	leave  
c0100cbf:	c3                   	ret    

c0100cc0 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
c0100cc0:	f3 0f 1e fb          	endbr32 
c0100cc4:	55                   	push   %ebp
c0100cc5:	89 e5                	mov    %esp,%ebp
c0100cc7:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
c0100cca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0100cd1:	eb 3d                	jmp    c0100d10 <mon_help+0x50>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
c0100cd3:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100cd6:	89 d0                	mov    %edx,%eax
c0100cd8:	01 c0                	add    %eax,%eax
c0100cda:	01 d0                	add    %edx,%eax
c0100cdc:	c1 e0 02             	shl    $0x2,%eax
c0100cdf:	05 04 90 11 c0       	add    $0xc0119004,%eax
c0100ce4:	8b 08                	mov    (%eax),%ecx
c0100ce6:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0100ce9:	89 d0                	mov    %edx,%eax
c0100ceb:	01 c0                	add    %eax,%eax
c0100ced:	01 d0                	add    %edx,%eax
c0100cef:	c1 e0 02             	shl    $0x2,%eax
c0100cf2:	05 00 90 11 c0       	add    $0xc0119000,%eax
c0100cf7:	8b 00                	mov    (%eax),%eax
c0100cf9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
c0100cfd:	89 44 24 04          	mov    %eax,0x4(%esp)
c0100d01:	c7 04 24 e1 63 10 c0 	movl   $0xc01063e1,(%esp)
c0100d08:	e8 bc f5 ff ff       	call   c01002c9 <cprintf>
    for (i = 0; i < NCOMMANDS; i ++) {
c0100d0d:	ff 45 f4             	incl   -0xc(%ebp)
c0100d10:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100d13:	83 f8 02             	cmp    $0x2,%eax
c0100d16:	76 bb                	jbe    c0100cd3 <mon_help+0x13>
    }
    return 0;
c0100d18:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100d1d:	c9                   	leave  
c0100d1e:	c3                   	ret    

c0100d1f <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
c0100d1f:	f3 0f 1e fb          	endbr32 
c0100d23:	55                   	push   %ebp
c0100d24:	89 e5                	mov    %esp,%ebp
c0100d26:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
c0100d29:	e8 5e fc ff ff       	call   c010098c <print_kerninfo>
    return 0;
c0100d2e:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100d33:	c9                   	leave  
c0100d34:	c3                   	ret    

c0100d35 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
c0100d35:	f3 0f 1e fb          	endbr32 
c0100d39:	55                   	push   %ebp
c0100d3a:	89 e5                	mov    %esp,%ebp
c0100d3c:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
c0100d3f:	e8 9a fd ff ff       	call   c0100ade <print_stackframe>
    return 0;
c0100d44:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100d49:	c9                   	leave  
c0100d4a:	c3                   	ret    

c0100d4b <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
c0100d4b:	f3 0f 1e fb          	endbr32 
c0100d4f:	55                   	push   %ebp
c0100d50:	89 e5                	mov    %esp,%ebp
c0100d52:	83 ec 28             	sub    $0x28,%esp
c0100d55:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
c0100d5b:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
        : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100d5f:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0100d63:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0100d67:	ee                   	out    %al,(%dx)
}
c0100d68:	90                   	nop
c0100d69:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
c0100d6f:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100d73:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0100d77:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0100d7b:	ee                   	out    %al,(%dx)
}
c0100d7c:	90                   	nop
c0100d7d:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
c0100d83:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100d87:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c0100d8b:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c0100d8f:	ee                   	out    %al,(%dx)
}
c0100d90:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
c0100d91:	c7 05 0c cf 11 c0 00 	movl   $0x0,0xc011cf0c
c0100d98:	00 00 00 

    cprintf("++ setup timer interrupts\n");
c0100d9b:	c7 04 24 ea 63 10 c0 	movl   $0xc01063ea,(%esp)
c0100da2:	e8 22 f5 ff ff       	call   c01002c9 <cprintf>
    pic_enable(IRQ_TIMER);
c0100da7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
c0100dae:	e8 95 09 00 00       	call   c0101748 <pic_enable>
}
c0100db3:	90                   	nop
c0100db4:	c9                   	leave  
c0100db5:	c3                   	ret    

c0100db6 <__intr_save>:
#include <x86.h>
#include <intr.h>
#include <mmu.h>

static inline bool
__intr_save(void) {
c0100db6:	55                   	push   %ebp
c0100db7:	89 e5                	mov    %esp,%ebp
c0100db9:	83 ec 18             	sub    $0x18,%esp
}

static inline uint32_t
read_eflags(void) {
    uint32_t eflags;
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
c0100dbc:	9c                   	pushf  
c0100dbd:	58                   	pop    %eax
c0100dbe:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
c0100dc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
c0100dc4:	25 00 02 00 00       	and    $0x200,%eax
c0100dc9:	85 c0                	test   %eax,%eax
c0100dcb:	74 0c                	je     c0100dd9 <__intr_save+0x23>
        intr_disable();
c0100dcd:	e8 05 0b 00 00       	call   c01018d7 <intr_disable>
        return 1;
c0100dd2:	b8 01 00 00 00       	mov    $0x1,%eax
c0100dd7:	eb 05                	jmp    c0100dde <__intr_save+0x28>
    }
    return 0;
c0100dd9:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0100dde:	c9                   	leave  
c0100ddf:	c3                   	ret    

c0100de0 <__intr_restore>:

static inline void
__intr_restore(bool flag) {
c0100de0:	55                   	push   %ebp
c0100de1:	89 e5                	mov    %esp,%ebp
c0100de3:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
c0100de6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0100dea:	74 05                	je     c0100df1 <__intr_restore+0x11>
        intr_enable();
c0100dec:	e8 da 0a 00 00       	call   c01018cb <intr_enable>
    }
}
c0100df1:	90                   	nop
c0100df2:	c9                   	leave  
c0100df3:	c3                   	ret    

c0100df4 <delay>:
#include <memlayout.h>
#include <sync.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
c0100df4:	f3 0f 1e fb          	endbr32 
c0100df8:	55                   	push   %ebp
c0100df9:	89 e5                	mov    %esp,%ebp
c0100dfb:	83 ec 10             	sub    $0x10,%esp
c0100dfe:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100e04:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0100e08:	89 c2                	mov    %eax,%edx
c0100e0a:	ec                   	in     (%dx),%al
c0100e0b:	88 45 f1             	mov    %al,-0xf(%ebp)
c0100e0e:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
c0100e14:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0100e18:	89 c2                	mov    %eax,%edx
c0100e1a:	ec                   	in     (%dx),%al
c0100e1b:	88 45 f5             	mov    %al,-0xb(%ebp)
c0100e1e:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
c0100e24:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c0100e28:	89 c2                	mov    %eax,%edx
c0100e2a:	ec                   	in     (%dx),%al
c0100e2b:	88 45 f9             	mov    %al,-0x7(%ebp)
c0100e2e:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
c0100e34:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
c0100e38:	89 c2                	mov    %eax,%edx
c0100e3a:	ec                   	in     (%dx),%al
c0100e3b:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
c0100e3e:	90                   	nop
c0100e3f:	c9                   	leave  
c0100e40:	c3                   	ret    

c0100e41 <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
c0100e41:	f3 0f 1e fb          	endbr32 
c0100e45:	55                   	push   %ebp
c0100e46:	89 e5                	mov    %esp,%ebp
c0100e48:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)(CGA_BUF + KERNBASE);
c0100e4b:	c7 45 fc 00 80 0b c0 	movl   $0xc00b8000,-0x4(%ebp)
    uint16_t was = *cp;
c0100e52:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100e55:	0f b7 00             	movzwl (%eax),%eax
c0100e58:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
c0100e5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100e5f:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
c0100e64:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100e67:	0f b7 00             	movzwl (%eax),%eax
c0100e6a:	0f b7 c0             	movzwl %ax,%eax
c0100e6d:	3d 5a a5 00 00       	cmp    $0xa55a,%eax
c0100e72:	74 12                	je     c0100e86 <cga_init+0x45>
        cp = (uint16_t*)(MONO_BUF + KERNBASE);
c0100e74:	c7 45 fc 00 00 0b c0 	movl   $0xc00b0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
c0100e7b:	66 c7 05 46 c4 11 c0 	movw   $0x3b4,0xc011c446
c0100e82:	b4 03 
c0100e84:	eb 13                	jmp    c0100e99 <cga_init+0x58>
    } else {
        *cp = was;
c0100e86:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100e89:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c0100e8d:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
c0100e90:	66 c7 05 46 c4 11 c0 	movw   $0x3d4,0xc011c446
c0100e97:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
c0100e99:	0f b7 05 46 c4 11 c0 	movzwl 0xc011c446,%eax
c0100ea0:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
c0100ea4:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100ea8:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c0100eac:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0100eb0:	ee                   	out    %al,(%dx)
}
c0100eb1:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;
c0100eb2:	0f b7 05 46 c4 11 c0 	movzwl 0xc011c446,%eax
c0100eb9:	40                   	inc    %eax
c0100eba:	0f b7 c0             	movzwl %ax,%eax
c0100ebd:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100ec1:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
c0100ec5:	89 c2                	mov    %eax,%edx
c0100ec7:	ec                   	in     (%dx),%al
c0100ec8:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
c0100ecb:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0100ecf:	0f b6 c0             	movzbl %al,%eax
c0100ed2:	c1 e0 08             	shl    $0x8,%eax
c0100ed5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
c0100ed8:	0f b7 05 46 c4 11 c0 	movzwl 0xc011c446,%eax
c0100edf:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
c0100ee3:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100ee7:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0100eeb:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0100eef:	ee                   	out    %al,(%dx)
}
c0100ef0:	90                   	nop
    pos |= inb(addr_6845 + 1);
c0100ef1:	0f b7 05 46 c4 11 c0 	movzwl 0xc011c446,%eax
c0100ef8:	40                   	inc    %eax
c0100ef9:	0f b7 c0             	movzwl %ax,%eax
c0100efc:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100f00:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0100f04:	89 c2                	mov    %eax,%edx
c0100f06:	ec                   	in     (%dx),%al
c0100f07:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
c0100f0a:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0100f0e:	0f b6 c0             	movzbl %al,%eax
c0100f11:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
c0100f14:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0100f17:	a3 40 c4 11 c0       	mov    %eax,0xc011c440
    crt_pos = pos;
c0100f1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0100f1f:	0f b7 c0             	movzwl %ax,%eax
c0100f22:	66 a3 44 c4 11 c0    	mov    %ax,0xc011c444
}
c0100f28:	90                   	nop
c0100f29:	c9                   	leave  
c0100f2a:	c3                   	ret    

c0100f2b <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
c0100f2b:	f3 0f 1e fb          	endbr32 
c0100f2f:	55                   	push   %ebp
c0100f30:	89 e5                	mov    %esp,%ebp
c0100f32:	83 ec 48             	sub    $0x48,%esp
c0100f35:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
c0100f3b:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100f3f:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
c0100f43:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
c0100f47:	ee                   	out    %al,(%dx)
}
c0100f48:	90                   	nop
c0100f49:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
c0100f4f:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100f53:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
c0100f57:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
c0100f5b:	ee                   	out    %al,(%dx)
}
c0100f5c:	90                   	nop
c0100f5d:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
c0100f63:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100f67:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
c0100f6b:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
c0100f6f:	ee                   	out    %al,(%dx)
}
c0100f70:	90                   	nop
c0100f71:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
c0100f77:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100f7b:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
c0100f7f:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
c0100f83:	ee                   	out    %al,(%dx)
}
c0100f84:	90                   	nop
c0100f85:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
c0100f8b:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100f8f:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
c0100f93:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
c0100f97:	ee                   	out    %al,(%dx)
}
c0100f98:	90                   	nop
c0100f99:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
c0100f9f:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100fa3:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c0100fa7:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0100fab:	ee                   	out    %al,(%dx)
}
c0100fac:	90                   	nop
c0100fad:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
c0100fb3:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0100fb7:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0100fbb:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c0100fbf:	ee                   	out    %al,(%dx)
}
c0100fc0:	90                   	nop
c0100fc1:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100fc7:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
c0100fcb:	89 c2                	mov    %eax,%edx
c0100fcd:	ec                   	in     (%dx),%al
c0100fce:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
c0100fd1:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
c0100fd5:	3c ff                	cmp    $0xff,%al
c0100fd7:	0f 95 c0             	setne  %al
c0100fda:	0f b6 c0             	movzbl %al,%eax
c0100fdd:	a3 48 c4 11 c0       	mov    %eax,0xc011c448
c0100fe2:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0100fe8:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
c0100fec:	89 c2                	mov    %eax,%edx
c0100fee:	ec                   	in     (%dx),%al
c0100fef:	88 45 f1             	mov    %al,-0xf(%ebp)
c0100ff2:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
c0100ff8:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0100ffc:	89 c2                	mov    %eax,%edx
c0100ffe:	ec                   	in     (%dx),%al
c0100fff:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
c0101002:	a1 48 c4 11 c0       	mov    0xc011c448,%eax
c0101007:	85 c0                	test   %eax,%eax
c0101009:	74 0c                	je     c0101017 <serial_init+0xec>
        pic_enable(IRQ_COM1);
c010100b:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
c0101012:	e8 31 07 00 00       	call   c0101748 <pic_enable>
    }
}
c0101017:	90                   	nop
c0101018:	c9                   	leave  
c0101019:	c3                   	ret    

c010101a <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
c010101a:	f3 0f 1e fb          	endbr32 
c010101e:	55                   	push   %ebp
c010101f:	89 e5                	mov    %esp,%ebp
c0101021:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
c0101024:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c010102b:	eb 08                	jmp    c0101035 <lpt_putc_sub+0x1b>
        delay();
c010102d:	e8 c2 fd ff ff       	call   c0100df4 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
c0101032:	ff 45 fc             	incl   -0x4(%ebp)
c0101035:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
c010103b:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c010103f:	89 c2                	mov    %eax,%edx
c0101041:	ec                   	in     (%dx),%al
c0101042:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c0101045:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c0101049:	84 c0                	test   %al,%al
c010104b:	78 09                	js     c0101056 <lpt_putc_sub+0x3c>
c010104d:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
c0101054:	7e d7                	jle    c010102d <lpt_putc_sub+0x13>
    }
    outb(LPTPORT + 0, c);
c0101056:	8b 45 08             	mov    0x8(%ebp),%eax
c0101059:	0f b6 c0             	movzbl %al,%eax
c010105c:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
c0101062:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101065:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0101069:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c010106d:	ee                   	out    %al,(%dx)
}
c010106e:	90                   	nop
c010106f:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
c0101075:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101079:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c010107d:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c0101081:	ee                   	out    %al,(%dx)
}
c0101082:	90                   	nop
c0101083:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
c0101089:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010108d:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c0101091:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c0101095:	ee                   	out    %al,(%dx)
}
c0101096:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
c0101097:	90                   	nop
c0101098:	c9                   	leave  
c0101099:	c3                   	ret    

c010109a <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
c010109a:	f3 0f 1e fb          	endbr32 
c010109e:	55                   	push   %ebp
c010109f:	89 e5                	mov    %esp,%ebp
c01010a1:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
c01010a4:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
c01010a8:	74 0d                	je     c01010b7 <lpt_putc+0x1d>
        lpt_putc_sub(c);
c01010aa:	8b 45 08             	mov    0x8(%ebp),%eax
c01010ad:	89 04 24             	mov    %eax,(%esp)
c01010b0:	e8 65 ff ff ff       	call   c010101a <lpt_putc_sub>
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
c01010b5:	eb 24                	jmp    c01010db <lpt_putc+0x41>
        lpt_putc_sub('\b');
c01010b7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
c01010be:	e8 57 ff ff ff       	call   c010101a <lpt_putc_sub>
        lpt_putc_sub(' ');
c01010c3:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
c01010ca:	e8 4b ff ff ff       	call   c010101a <lpt_putc_sub>
        lpt_putc_sub('\b');
c01010cf:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
c01010d6:	e8 3f ff ff ff       	call   c010101a <lpt_putc_sub>
}
c01010db:	90                   	nop
c01010dc:	c9                   	leave  
c01010dd:	c3                   	ret    

c01010de <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
c01010de:	f3 0f 1e fb          	endbr32 
c01010e2:	55                   	push   %ebp
c01010e3:	89 e5                	mov    %esp,%ebp
c01010e5:	53                   	push   %ebx
c01010e6:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
c01010e9:	8b 45 08             	mov    0x8(%ebp),%eax
c01010ec:	25 00 ff ff ff       	and    $0xffffff00,%eax
c01010f1:	85 c0                	test   %eax,%eax
c01010f3:	75 07                	jne    c01010fc <cga_putc+0x1e>
        c |= 0x0700;
c01010f5:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
c01010fc:	8b 45 08             	mov    0x8(%ebp),%eax
c01010ff:	0f b6 c0             	movzbl %al,%eax
c0101102:	83 f8 0d             	cmp    $0xd,%eax
c0101105:	74 72                	je     c0101179 <cga_putc+0x9b>
c0101107:	83 f8 0d             	cmp    $0xd,%eax
c010110a:	0f 8f a3 00 00 00    	jg     c01011b3 <cga_putc+0xd5>
c0101110:	83 f8 08             	cmp    $0x8,%eax
c0101113:	74 0a                	je     c010111f <cga_putc+0x41>
c0101115:	83 f8 0a             	cmp    $0xa,%eax
c0101118:	74 4c                	je     c0101166 <cga_putc+0x88>
c010111a:	e9 94 00 00 00       	jmp    c01011b3 <cga_putc+0xd5>
    case '\b':
        if (crt_pos > 0) {
c010111f:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c0101126:	85 c0                	test   %eax,%eax
c0101128:	0f 84 af 00 00 00    	je     c01011dd <cga_putc+0xff>
            crt_pos --;
c010112e:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c0101135:	48                   	dec    %eax
c0101136:	0f b7 c0             	movzwl %ax,%eax
c0101139:	66 a3 44 c4 11 c0    	mov    %ax,0xc011c444
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
c010113f:	8b 45 08             	mov    0x8(%ebp),%eax
c0101142:	98                   	cwtl   
c0101143:	25 00 ff ff ff       	and    $0xffffff00,%eax
c0101148:	98                   	cwtl   
c0101149:	83 c8 20             	or     $0x20,%eax
c010114c:	98                   	cwtl   
c010114d:	8b 15 40 c4 11 c0    	mov    0xc011c440,%edx
c0101153:	0f b7 0d 44 c4 11 c0 	movzwl 0xc011c444,%ecx
c010115a:	01 c9                	add    %ecx,%ecx
c010115c:	01 ca                	add    %ecx,%edx
c010115e:	0f b7 c0             	movzwl %ax,%eax
c0101161:	66 89 02             	mov    %ax,(%edx)
        }
        break;
c0101164:	eb 77                	jmp    c01011dd <cga_putc+0xff>
    case '\n':
        crt_pos += CRT_COLS;
c0101166:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c010116d:	83 c0 50             	add    $0x50,%eax
c0101170:	0f b7 c0             	movzwl %ax,%eax
c0101173:	66 a3 44 c4 11 c0    	mov    %ax,0xc011c444
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
c0101179:	0f b7 1d 44 c4 11 c0 	movzwl 0xc011c444,%ebx
c0101180:	0f b7 0d 44 c4 11 c0 	movzwl 0xc011c444,%ecx
c0101187:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
c010118c:	89 c8                	mov    %ecx,%eax
c010118e:	f7 e2                	mul    %edx
c0101190:	c1 ea 06             	shr    $0x6,%edx
c0101193:	89 d0                	mov    %edx,%eax
c0101195:	c1 e0 02             	shl    $0x2,%eax
c0101198:	01 d0                	add    %edx,%eax
c010119a:	c1 e0 04             	shl    $0x4,%eax
c010119d:	29 c1                	sub    %eax,%ecx
c010119f:	89 c8                	mov    %ecx,%eax
c01011a1:	0f b7 c0             	movzwl %ax,%eax
c01011a4:	29 c3                	sub    %eax,%ebx
c01011a6:	89 d8                	mov    %ebx,%eax
c01011a8:	0f b7 c0             	movzwl %ax,%eax
c01011ab:	66 a3 44 c4 11 c0    	mov    %ax,0xc011c444
        break;
c01011b1:	eb 2b                	jmp    c01011de <cga_putc+0x100>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
c01011b3:	8b 0d 40 c4 11 c0    	mov    0xc011c440,%ecx
c01011b9:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c01011c0:	8d 50 01             	lea    0x1(%eax),%edx
c01011c3:	0f b7 d2             	movzwl %dx,%edx
c01011c6:	66 89 15 44 c4 11 c0 	mov    %dx,0xc011c444
c01011cd:	01 c0                	add    %eax,%eax
c01011cf:	8d 14 01             	lea    (%ecx,%eax,1),%edx
c01011d2:	8b 45 08             	mov    0x8(%ebp),%eax
c01011d5:	0f b7 c0             	movzwl %ax,%eax
c01011d8:	66 89 02             	mov    %ax,(%edx)
        break;
c01011db:	eb 01                	jmp    c01011de <cga_putc+0x100>
        break;
c01011dd:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
c01011de:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c01011e5:	3d cf 07 00 00       	cmp    $0x7cf,%eax
c01011ea:	76 5d                	jbe    c0101249 <cga_putc+0x16b>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
c01011ec:	a1 40 c4 11 c0       	mov    0xc011c440,%eax
c01011f1:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
c01011f7:	a1 40 c4 11 c0       	mov    0xc011c440,%eax
c01011fc:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
c0101203:	00 
c0101204:	89 54 24 04          	mov    %edx,0x4(%esp)
c0101208:	89 04 24             	mov    %eax,(%esp)
c010120b:	e8 f4 46 00 00       	call   c0105904 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
c0101210:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
c0101217:	eb 14                	jmp    c010122d <cga_putc+0x14f>
            crt_buf[i] = 0x0700 | ' ';
c0101219:	a1 40 c4 11 c0       	mov    0xc011c440,%eax
c010121e:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0101221:	01 d2                	add    %edx,%edx
c0101223:	01 d0                	add    %edx,%eax
c0101225:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
c010122a:	ff 45 f4             	incl   -0xc(%ebp)
c010122d:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
c0101234:	7e e3                	jle    c0101219 <cga_putc+0x13b>
        }
        crt_pos -= CRT_COLS;
c0101236:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c010123d:	83 e8 50             	sub    $0x50,%eax
c0101240:	0f b7 c0             	movzwl %ax,%eax
c0101243:	66 a3 44 c4 11 c0    	mov    %ax,0xc011c444
    }

    // move that little blinky thing
    outb(addr_6845, 14);
c0101249:	0f b7 05 46 c4 11 c0 	movzwl 0xc011c446,%eax
c0101250:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
c0101254:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101258:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c010125c:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0101260:	ee                   	out    %al,(%dx)
}
c0101261:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
c0101262:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c0101269:	c1 e8 08             	shr    $0x8,%eax
c010126c:	0f b7 c0             	movzwl %ax,%eax
c010126f:	0f b6 c0             	movzbl %al,%eax
c0101272:	0f b7 15 46 c4 11 c0 	movzwl 0xc011c446,%edx
c0101279:	42                   	inc    %edx
c010127a:	0f b7 d2             	movzwl %dx,%edx
c010127d:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
c0101281:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101284:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0101288:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c010128c:	ee                   	out    %al,(%dx)
}
c010128d:	90                   	nop
    outb(addr_6845, 15);
c010128e:	0f b7 05 46 c4 11 c0 	movzwl 0xc011c446,%eax
c0101295:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
c0101299:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010129d:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c01012a1:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c01012a5:	ee                   	out    %al,(%dx)
}
c01012a6:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
c01012a7:	0f b7 05 44 c4 11 c0 	movzwl 0xc011c444,%eax
c01012ae:	0f b6 c0             	movzbl %al,%eax
c01012b1:	0f b7 15 46 c4 11 c0 	movzwl 0xc011c446,%edx
c01012b8:	42                   	inc    %edx
c01012b9:	0f b7 d2             	movzwl %dx,%edx
c01012bc:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
c01012c0:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01012c3:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c01012c7:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c01012cb:	ee                   	out    %al,(%dx)
}
c01012cc:	90                   	nop
}
c01012cd:	90                   	nop
c01012ce:	83 c4 34             	add    $0x34,%esp
c01012d1:	5b                   	pop    %ebx
c01012d2:	5d                   	pop    %ebp
c01012d3:	c3                   	ret    

c01012d4 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
c01012d4:	f3 0f 1e fb          	endbr32 
c01012d8:	55                   	push   %ebp
c01012d9:	89 e5                	mov    %esp,%ebp
c01012db:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
c01012de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c01012e5:	eb 08                	jmp    c01012ef <serial_putc_sub+0x1b>
        delay();
c01012e7:	e8 08 fb ff ff       	call   c0100df4 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
c01012ec:	ff 45 fc             	incl   -0x4(%ebp)
c01012ef:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c01012f5:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c01012f9:	89 c2                	mov    %eax,%edx
c01012fb:	ec                   	in     (%dx),%al
c01012fc:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c01012ff:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c0101303:	0f b6 c0             	movzbl %al,%eax
c0101306:	83 e0 20             	and    $0x20,%eax
c0101309:	85 c0                	test   %eax,%eax
c010130b:	75 09                	jne    c0101316 <serial_putc_sub+0x42>
c010130d:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
c0101314:	7e d1                	jle    c01012e7 <serial_putc_sub+0x13>
    }
    outb(COM1 + COM_TX, c);
c0101316:	8b 45 08             	mov    0x8(%ebp),%eax
c0101319:	0f b6 c0             	movzbl %al,%eax
c010131c:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
c0101322:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101325:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c0101329:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c010132d:	ee                   	out    %al,(%dx)
}
c010132e:	90                   	nop
}
c010132f:	90                   	nop
c0101330:	c9                   	leave  
c0101331:	c3                   	ret    

c0101332 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
c0101332:	f3 0f 1e fb          	endbr32 
c0101336:	55                   	push   %ebp
c0101337:	89 e5                	mov    %esp,%ebp
c0101339:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
c010133c:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
c0101340:	74 0d                	je     c010134f <serial_putc+0x1d>
        serial_putc_sub(c);
c0101342:	8b 45 08             	mov    0x8(%ebp),%eax
c0101345:	89 04 24             	mov    %eax,(%esp)
c0101348:	e8 87 ff ff ff       	call   c01012d4 <serial_putc_sub>
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
c010134d:	eb 24                	jmp    c0101373 <serial_putc+0x41>
        serial_putc_sub('\b');
c010134f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
c0101356:	e8 79 ff ff ff       	call   c01012d4 <serial_putc_sub>
        serial_putc_sub(' ');
c010135b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
c0101362:	e8 6d ff ff ff       	call   c01012d4 <serial_putc_sub>
        serial_putc_sub('\b');
c0101367:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
c010136e:	e8 61 ff ff ff       	call   c01012d4 <serial_putc_sub>
}
c0101373:	90                   	nop
c0101374:	c9                   	leave  
c0101375:	c3                   	ret    

c0101376 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
c0101376:	f3 0f 1e fb          	endbr32 
c010137a:	55                   	push   %ebp
c010137b:	89 e5                	mov    %esp,%ebp
c010137d:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
c0101380:	eb 33                	jmp    c01013b5 <cons_intr+0x3f>
        if (c != 0) {
c0101382:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0101386:	74 2d                	je     c01013b5 <cons_intr+0x3f>
            cons.buf[cons.wpos ++] = c;
c0101388:	a1 64 c6 11 c0       	mov    0xc011c664,%eax
c010138d:	8d 50 01             	lea    0x1(%eax),%edx
c0101390:	89 15 64 c6 11 c0    	mov    %edx,0xc011c664
c0101396:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0101399:	88 90 60 c4 11 c0    	mov    %dl,-0x3fee3ba0(%eax)
            if (cons.wpos == CONSBUFSIZE) {
c010139f:	a1 64 c6 11 c0       	mov    0xc011c664,%eax
c01013a4:	3d 00 02 00 00       	cmp    $0x200,%eax
c01013a9:	75 0a                	jne    c01013b5 <cons_intr+0x3f>
                cons.wpos = 0;
c01013ab:	c7 05 64 c6 11 c0 00 	movl   $0x0,0xc011c664
c01013b2:	00 00 00 
    while ((c = (*proc)()) != -1) {
c01013b5:	8b 45 08             	mov    0x8(%ebp),%eax
c01013b8:	ff d0                	call   *%eax
c01013ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01013bd:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
c01013c1:	75 bf                	jne    c0101382 <cons_intr+0xc>
            }
        }
    }
}
c01013c3:	90                   	nop
c01013c4:	90                   	nop
c01013c5:	c9                   	leave  
c01013c6:	c3                   	ret    

c01013c7 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
c01013c7:	f3 0f 1e fb          	endbr32 
c01013cb:	55                   	push   %ebp
c01013cc:	89 e5                	mov    %esp,%ebp
c01013ce:	83 ec 10             	sub    $0x10,%esp
c01013d1:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c01013d7:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
c01013db:	89 c2                	mov    %eax,%edx
c01013dd:	ec                   	in     (%dx),%al
c01013de:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
c01013e1:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
c01013e5:	0f b6 c0             	movzbl %al,%eax
c01013e8:	83 e0 01             	and    $0x1,%eax
c01013eb:	85 c0                	test   %eax,%eax
c01013ed:	75 07                	jne    c01013f6 <serial_proc_data+0x2f>
        return -1;
c01013ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c01013f4:	eb 2a                	jmp    c0101420 <serial_proc_data+0x59>
c01013f6:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c01013fc:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
c0101400:	89 c2                	mov    %eax,%edx
c0101402:	ec                   	in     (%dx),%al
c0101403:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
c0101406:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
c010140a:	0f b6 c0             	movzbl %al,%eax
c010140d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
c0101410:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
c0101414:	75 07                	jne    c010141d <serial_proc_data+0x56>
        c = '\b';
c0101416:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
c010141d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c0101420:	c9                   	leave  
c0101421:	c3                   	ret    

c0101422 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
c0101422:	f3 0f 1e fb          	endbr32 
c0101426:	55                   	push   %ebp
c0101427:	89 e5                	mov    %esp,%ebp
c0101429:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
c010142c:	a1 48 c4 11 c0       	mov    0xc011c448,%eax
c0101431:	85 c0                	test   %eax,%eax
c0101433:	74 0c                	je     c0101441 <serial_intr+0x1f>
        cons_intr(serial_proc_data);
c0101435:	c7 04 24 c7 13 10 c0 	movl   $0xc01013c7,(%esp)
c010143c:	e8 35 ff ff ff       	call   c0101376 <cons_intr>
    }
}
c0101441:	90                   	nop
c0101442:	c9                   	leave  
c0101443:	c3                   	ret    

c0101444 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
c0101444:	f3 0f 1e fb          	endbr32 
c0101448:	55                   	push   %ebp
c0101449:	89 e5                	mov    %esp,%ebp
c010144b:	83 ec 38             	sub    $0x38,%esp
c010144e:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c0101454:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0101457:	89 c2                	mov    %eax,%edx
c0101459:	ec                   	in     (%dx),%al
c010145a:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
c010145d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
c0101461:	0f b6 c0             	movzbl %al,%eax
c0101464:	83 e0 01             	and    $0x1,%eax
c0101467:	85 c0                	test   %eax,%eax
c0101469:	75 0a                	jne    c0101475 <kbd_proc_data+0x31>
        return -1;
c010146b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
c0101470:	e9 56 01 00 00       	jmp    c01015cb <kbd_proc_data+0x187>
c0101475:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port) : "memory");
c010147b:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010147e:	89 c2                	mov    %eax,%edx
c0101480:	ec                   	in     (%dx),%al
c0101481:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
c0101484:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
c0101488:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
c010148b:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
c010148f:	75 17                	jne    c01014a8 <kbd_proc_data+0x64>
        // E0 escape character
        shift |= E0ESC;
c0101491:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c0101496:	83 c8 40             	or     $0x40,%eax
c0101499:	a3 68 c6 11 c0       	mov    %eax,0xc011c668
        return 0;
c010149e:	b8 00 00 00 00       	mov    $0x0,%eax
c01014a3:	e9 23 01 00 00       	jmp    c01015cb <kbd_proc_data+0x187>
    } else if (data & 0x80) {
c01014a8:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01014ac:	84 c0                	test   %al,%al
c01014ae:	79 45                	jns    c01014f5 <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
c01014b0:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c01014b5:	83 e0 40             	and    $0x40,%eax
c01014b8:	85 c0                	test   %eax,%eax
c01014ba:	75 08                	jne    c01014c4 <kbd_proc_data+0x80>
c01014bc:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01014c0:	24 7f                	and    $0x7f,%al
c01014c2:	eb 04                	jmp    c01014c8 <kbd_proc_data+0x84>
c01014c4:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01014c8:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
c01014cb:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c01014cf:	0f b6 80 40 90 11 c0 	movzbl -0x3fee6fc0(%eax),%eax
c01014d6:	0c 40                	or     $0x40,%al
c01014d8:	0f b6 c0             	movzbl %al,%eax
c01014db:	f7 d0                	not    %eax
c01014dd:	89 c2                	mov    %eax,%edx
c01014df:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c01014e4:	21 d0                	and    %edx,%eax
c01014e6:	a3 68 c6 11 c0       	mov    %eax,0xc011c668
        return 0;
c01014eb:	b8 00 00 00 00       	mov    $0x0,%eax
c01014f0:	e9 d6 00 00 00       	jmp    c01015cb <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
c01014f5:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c01014fa:	83 e0 40             	and    $0x40,%eax
c01014fd:	85 c0                	test   %eax,%eax
c01014ff:	74 11                	je     c0101512 <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
c0101501:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
c0101505:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c010150a:	83 e0 bf             	and    $0xffffffbf,%eax
c010150d:	a3 68 c6 11 c0       	mov    %eax,0xc011c668
    }

    shift |= shiftcode[data];
c0101512:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101516:	0f b6 80 40 90 11 c0 	movzbl -0x3fee6fc0(%eax),%eax
c010151d:	0f b6 d0             	movzbl %al,%edx
c0101520:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c0101525:	09 d0                	or     %edx,%eax
c0101527:	a3 68 c6 11 c0       	mov    %eax,0xc011c668
    shift ^= togglecode[data];
c010152c:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101530:	0f b6 80 40 91 11 c0 	movzbl -0x3fee6ec0(%eax),%eax
c0101537:	0f b6 d0             	movzbl %al,%edx
c010153a:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c010153f:	31 d0                	xor    %edx,%eax
c0101541:	a3 68 c6 11 c0       	mov    %eax,0xc011c668

    c = charcode[shift & (CTL | SHIFT)][data];
c0101546:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c010154b:	83 e0 03             	and    $0x3,%eax
c010154e:	8b 14 85 40 95 11 c0 	mov    -0x3fee6ac0(,%eax,4),%edx
c0101555:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
c0101559:	01 d0                	add    %edx,%eax
c010155b:	0f b6 00             	movzbl (%eax),%eax
c010155e:	0f b6 c0             	movzbl %al,%eax
c0101561:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
c0101564:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c0101569:	83 e0 08             	and    $0x8,%eax
c010156c:	85 c0                	test   %eax,%eax
c010156e:	74 22                	je     c0101592 <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
c0101570:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
c0101574:	7e 0c                	jle    c0101582 <kbd_proc_data+0x13e>
c0101576:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
c010157a:	7f 06                	jg     c0101582 <kbd_proc_data+0x13e>
            c += 'A' - 'a';
c010157c:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
c0101580:	eb 10                	jmp    c0101592 <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
c0101582:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
c0101586:	7e 0a                	jle    c0101592 <kbd_proc_data+0x14e>
c0101588:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
c010158c:	7f 04                	jg     c0101592 <kbd_proc_data+0x14e>
            c += 'a' - 'A';
c010158e:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
c0101592:	a1 68 c6 11 c0       	mov    0xc011c668,%eax
c0101597:	f7 d0                	not    %eax
c0101599:	83 e0 06             	and    $0x6,%eax
c010159c:	85 c0                	test   %eax,%eax
c010159e:	75 28                	jne    c01015c8 <kbd_proc_data+0x184>
c01015a0:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
c01015a7:	75 1f                	jne    c01015c8 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
c01015a9:	c7 04 24 05 64 10 c0 	movl   $0xc0106405,(%esp)
c01015b0:	e8 14 ed ff ff       	call   c01002c9 <cprintf>
c01015b5:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
c01015bb:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01015bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
c01015c3:	8b 55 e8             	mov    -0x18(%ebp),%edx
c01015c6:	ee                   	out    %al,(%dx)
}
c01015c7:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
c01015c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01015cb:	c9                   	leave  
c01015cc:	c3                   	ret    

c01015cd <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
c01015cd:	f3 0f 1e fb          	endbr32 
c01015d1:	55                   	push   %ebp
c01015d2:	89 e5                	mov    %esp,%ebp
c01015d4:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
c01015d7:	c7 04 24 44 14 10 c0 	movl   $0xc0101444,(%esp)
c01015de:	e8 93 fd ff ff       	call   c0101376 <cons_intr>
}
c01015e3:	90                   	nop
c01015e4:	c9                   	leave  
c01015e5:	c3                   	ret    

c01015e6 <kbd_init>:

static void
kbd_init(void) {
c01015e6:	f3 0f 1e fb          	endbr32 
c01015ea:	55                   	push   %ebp
c01015eb:	89 e5                	mov    %esp,%ebp
c01015ed:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
c01015f0:	e8 d8 ff ff ff       	call   c01015cd <kbd_intr>
    pic_enable(IRQ_KBD);
c01015f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c01015fc:	e8 47 01 00 00       	call   c0101748 <pic_enable>
}
c0101601:	90                   	nop
c0101602:	c9                   	leave  
c0101603:	c3                   	ret    

c0101604 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
c0101604:	f3 0f 1e fb          	endbr32 
c0101608:	55                   	push   %ebp
c0101609:	89 e5                	mov    %esp,%ebp
c010160b:	83 ec 18             	sub    $0x18,%esp
    cga_init();
c010160e:	e8 2e f8 ff ff       	call   c0100e41 <cga_init>
    serial_init();
c0101613:	e8 13 f9 ff ff       	call   c0100f2b <serial_init>
    kbd_init();
c0101618:	e8 c9 ff ff ff       	call   c01015e6 <kbd_init>
    if (!serial_exists) {
c010161d:	a1 48 c4 11 c0       	mov    0xc011c448,%eax
c0101622:	85 c0                	test   %eax,%eax
c0101624:	75 0c                	jne    c0101632 <cons_init+0x2e>
        cprintf("serial port does not exist!!\n");
c0101626:	c7 04 24 11 64 10 c0 	movl   $0xc0106411,(%esp)
c010162d:	e8 97 ec ff ff       	call   c01002c9 <cprintf>
    }
}
c0101632:	90                   	nop
c0101633:	c9                   	leave  
c0101634:	c3                   	ret    

c0101635 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
c0101635:	f3 0f 1e fb          	endbr32 
c0101639:	55                   	push   %ebp
c010163a:	89 e5                	mov    %esp,%ebp
c010163c:	83 ec 28             	sub    $0x28,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
c010163f:	e8 72 f7 ff ff       	call   c0100db6 <__intr_save>
c0101644:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        lpt_putc(c);
c0101647:	8b 45 08             	mov    0x8(%ebp),%eax
c010164a:	89 04 24             	mov    %eax,(%esp)
c010164d:	e8 48 fa ff ff       	call   c010109a <lpt_putc>
        cga_putc(c);
c0101652:	8b 45 08             	mov    0x8(%ebp),%eax
c0101655:	89 04 24             	mov    %eax,(%esp)
c0101658:	e8 81 fa ff ff       	call   c01010de <cga_putc>
        serial_putc(c);
c010165d:	8b 45 08             	mov    0x8(%ebp),%eax
c0101660:	89 04 24             	mov    %eax,(%esp)
c0101663:	e8 ca fc ff ff       	call   c0101332 <serial_putc>
    }
    local_intr_restore(intr_flag);
c0101668:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010166b:	89 04 24             	mov    %eax,(%esp)
c010166e:	e8 6d f7 ff ff       	call   c0100de0 <__intr_restore>
}
c0101673:	90                   	nop
c0101674:	c9                   	leave  
c0101675:	c3                   	ret    

c0101676 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
c0101676:	f3 0f 1e fb          	endbr32 
c010167a:	55                   	push   %ebp
c010167b:	89 e5                	mov    %esp,%ebp
c010167d:	83 ec 28             	sub    $0x28,%esp
    int c = 0;
c0101680:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
c0101687:	e8 2a f7 ff ff       	call   c0100db6 <__intr_save>
c010168c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        // poll for any pending input characters,
        // so that this function works even when interrupts are disabled
        // (e.g., when called from the kernel monitor).
        serial_intr();
c010168f:	e8 8e fd ff ff       	call   c0101422 <serial_intr>
        kbd_intr();
c0101694:	e8 34 ff ff ff       	call   c01015cd <kbd_intr>

        // grab the next character from the input buffer.
        if (cons.rpos != cons.wpos) {
c0101699:	8b 15 60 c6 11 c0    	mov    0xc011c660,%edx
c010169f:	a1 64 c6 11 c0       	mov    0xc011c664,%eax
c01016a4:	39 c2                	cmp    %eax,%edx
c01016a6:	74 31                	je     c01016d9 <cons_getc+0x63>
            c = cons.buf[cons.rpos ++];
c01016a8:	a1 60 c6 11 c0       	mov    0xc011c660,%eax
c01016ad:	8d 50 01             	lea    0x1(%eax),%edx
c01016b0:	89 15 60 c6 11 c0    	mov    %edx,0xc011c660
c01016b6:	0f b6 80 60 c4 11 c0 	movzbl -0x3fee3ba0(%eax),%eax
c01016bd:	0f b6 c0             	movzbl %al,%eax
c01016c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
            if (cons.rpos == CONSBUFSIZE) {
c01016c3:	a1 60 c6 11 c0       	mov    0xc011c660,%eax
c01016c8:	3d 00 02 00 00       	cmp    $0x200,%eax
c01016cd:	75 0a                	jne    c01016d9 <cons_getc+0x63>
                cons.rpos = 0;
c01016cf:	c7 05 60 c6 11 c0 00 	movl   $0x0,0xc011c660
c01016d6:	00 00 00 
            }
        }
    }
    local_intr_restore(intr_flag);
c01016d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01016dc:	89 04 24             	mov    %eax,(%esp)
c01016df:	e8 fc f6 ff ff       	call   c0100de0 <__intr_restore>
    return c;
c01016e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01016e7:	c9                   	leave  
c01016e8:	c3                   	ret    

c01016e9 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
c01016e9:	f3 0f 1e fb          	endbr32 
c01016ed:	55                   	push   %ebp
c01016ee:	89 e5                	mov    %esp,%ebp
c01016f0:	83 ec 14             	sub    $0x14,%esp
c01016f3:	8b 45 08             	mov    0x8(%ebp),%eax
c01016f6:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
c01016fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01016fd:	66 a3 50 95 11 c0    	mov    %ax,0xc0119550
    if (did_init) {
c0101703:	a1 6c c6 11 c0       	mov    0xc011c66c,%eax
c0101708:	85 c0                	test   %eax,%eax
c010170a:	74 39                	je     c0101745 <pic_setmask+0x5c>
        outb(IO_PIC1 + 1, mask);
c010170c:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010170f:	0f b6 c0             	movzbl %al,%eax
c0101712:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
c0101718:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010171b:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c010171f:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c0101723:	ee                   	out    %al,(%dx)
}
c0101724:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
c0101725:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
c0101729:	c1 e8 08             	shr    $0x8,%eax
c010172c:	0f b7 c0             	movzwl %ax,%eax
c010172f:	0f b6 c0             	movzbl %al,%eax
c0101732:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
c0101738:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010173b:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
c010173f:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
c0101743:	ee                   	out    %al,(%dx)
}
c0101744:	90                   	nop
    }
}
c0101745:	90                   	nop
c0101746:	c9                   	leave  
c0101747:	c3                   	ret    

c0101748 <pic_enable>:

void
pic_enable(unsigned int irq) {
c0101748:	f3 0f 1e fb          	endbr32 
c010174c:	55                   	push   %ebp
c010174d:	89 e5                	mov    %esp,%ebp
c010174f:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
c0101752:	8b 45 08             	mov    0x8(%ebp),%eax
c0101755:	ba 01 00 00 00       	mov    $0x1,%edx
c010175a:	88 c1                	mov    %al,%cl
c010175c:	d3 e2                	shl    %cl,%edx
c010175e:	89 d0                	mov    %edx,%eax
c0101760:	98                   	cwtl   
c0101761:	f7 d0                	not    %eax
c0101763:	0f bf d0             	movswl %ax,%edx
c0101766:	0f b7 05 50 95 11 c0 	movzwl 0xc0119550,%eax
c010176d:	98                   	cwtl   
c010176e:	21 d0                	and    %edx,%eax
c0101770:	98                   	cwtl   
c0101771:	0f b7 c0             	movzwl %ax,%eax
c0101774:	89 04 24             	mov    %eax,(%esp)
c0101777:	e8 6d ff ff ff       	call   c01016e9 <pic_setmask>
}
c010177c:	90                   	nop
c010177d:	c9                   	leave  
c010177e:	c3                   	ret    

c010177f <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
c010177f:	f3 0f 1e fb          	endbr32 
c0101783:	55                   	push   %ebp
c0101784:	89 e5                	mov    %esp,%ebp
c0101786:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
c0101789:	c7 05 6c c6 11 c0 01 	movl   $0x1,0xc011c66c
c0101790:	00 00 00 
c0101793:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
c0101799:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010179d:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
c01017a1:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
c01017a5:	ee                   	out    %al,(%dx)
}
c01017a6:	90                   	nop
c01017a7:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
c01017ad:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01017b1:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
c01017b5:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
c01017b9:	ee                   	out    %al,(%dx)
}
c01017ba:	90                   	nop
c01017bb:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
c01017c1:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01017c5:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
c01017c9:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
c01017cd:	ee                   	out    %al,(%dx)
}
c01017ce:	90                   	nop
c01017cf:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
c01017d5:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01017d9:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
c01017dd:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
c01017e1:	ee                   	out    %al,(%dx)
}
c01017e2:	90                   	nop
c01017e3:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
c01017e9:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01017ed:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
c01017f1:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
c01017f5:	ee                   	out    %al,(%dx)
}
c01017f6:	90                   	nop
c01017f7:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
c01017fd:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101801:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
c0101805:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
c0101809:	ee                   	out    %al,(%dx)
}
c010180a:	90                   	nop
c010180b:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
c0101811:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101815:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
c0101819:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
c010181d:	ee                   	out    %al,(%dx)
}
c010181e:	90                   	nop
c010181f:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
c0101825:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101829:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
c010182d:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
c0101831:	ee                   	out    %al,(%dx)
}
c0101832:	90                   	nop
c0101833:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
c0101839:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010183d:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
c0101841:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
c0101845:	ee                   	out    %al,(%dx)
}
c0101846:	90                   	nop
c0101847:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
c010184d:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101851:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
c0101855:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
c0101859:	ee                   	out    %al,(%dx)
}
c010185a:	90                   	nop
c010185b:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
c0101861:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101865:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
c0101869:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
c010186d:	ee                   	out    %al,(%dx)
}
c010186e:	90                   	nop
c010186f:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
c0101875:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c0101879:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
c010187d:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
c0101881:	ee                   	out    %al,(%dx)
}
c0101882:	90                   	nop
c0101883:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
c0101889:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c010188d:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
c0101891:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
c0101895:	ee                   	out    %al,(%dx)
}
c0101896:	90                   	nop
c0101897:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
c010189d:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port) : "memory");
c01018a1:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
c01018a5:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
c01018a9:	ee                   	out    %al,(%dx)
}
c01018aa:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
c01018ab:	0f b7 05 50 95 11 c0 	movzwl 0xc0119550,%eax
c01018b2:	3d ff ff 00 00       	cmp    $0xffff,%eax
c01018b7:	74 0f                	je     c01018c8 <pic_init+0x149>
        pic_setmask(irq_mask);
c01018b9:	0f b7 05 50 95 11 c0 	movzwl 0xc0119550,%eax
c01018c0:	89 04 24             	mov    %eax,(%esp)
c01018c3:	e8 21 fe ff ff       	call   c01016e9 <pic_setmask>
    }
}
c01018c8:	90                   	nop
c01018c9:	c9                   	leave  
c01018ca:	c3                   	ret    

c01018cb <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
c01018cb:	f3 0f 1e fb          	endbr32 
c01018cf:	55                   	push   %ebp
c01018d0:	89 e5                	mov    %esp,%ebp
    asm volatile ("sti");
c01018d2:	fb                   	sti    
}
c01018d3:	90                   	nop
    sti();
}
c01018d4:	90                   	nop
c01018d5:	5d                   	pop    %ebp
c01018d6:	c3                   	ret    

c01018d7 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
c01018d7:	f3 0f 1e fb          	endbr32 
c01018db:	55                   	push   %ebp
c01018dc:	89 e5                	mov    %esp,%ebp
    asm volatile ("cli" ::: "memory");
c01018de:	fa                   	cli    
}
c01018df:	90                   	nop
    cli();
}
c01018e0:	90                   	nop
c01018e1:	5d                   	pop    %ebp
c01018e2:	c3                   	ret    

c01018e3 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
c01018e3:	f3 0f 1e fb          	endbr32 
c01018e7:	55                   	push   %ebp
c01018e8:	89 e5                	mov    %esp,%ebp
c01018ea:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
c01018ed:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
c01018f4:	00 
c01018f5:	c7 04 24 40 64 10 c0 	movl   $0xc0106440,(%esp)
c01018fc:	e8 c8 e9 ff ff       	call   c01002c9 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
c0101901:	c7 04 24 4a 64 10 c0 	movl   $0xc010644a,(%esp)
c0101908:	e8 bc e9 ff ff       	call   c01002c9 <cprintf>
    panic("EOT: kernel seems ok.");
c010190d:	c7 44 24 08 58 64 10 	movl   $0xc0106458,0x8(%esp)
c0101914:	c0 
c0101915:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
c010191c:	00 
c010191d:	c7 04 24 6e 64 10 c0 	movl   $0xc010646e,(%esp)
c0101924:	e8 0c eb ff ff       	call   c0100435 <__panic>

c0101929 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
c0101929:	f3 0f 1e fb          	endbr32 
c010192d:	55                   	push   %ebp
c010192e:	89 e5                	mov    %esp,%ebp
c0101930:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[]; 
    int i;
    for(i=0; i<sizeof(idt)/sizeof(struct gatedesc);i++){
c0101933:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
c010193a:	e9 c4 00 00 00       	jmp    c0101a03 <idt_init+0xda>
        //由该文件可知，所有中断向量的中断处理函数地址均保存在__vectors数组中，该数组中第i个元素对应第i个中断向量的中断处理函数地址。
        //而且由文件开头可知，中断处理函数属于.text的内容。因此，中断处理函数的段选择子即.text的段选择子GD_KTEXT。
        //从kern / mm / pmm.c可知.text的段基址为0，因此中断处理函数地址的偏移量等于其地址本身。
        //dpl  DPL_KERNEL
        // 除了T_SWITCH_TOK是DPL_USER其他都是DPL_KERNEL。
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);//初始化idt
c010193f:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101942:	8b 04 85 e0 95 11 c0 	mov    -0x3fee6a20(,%eax,4),%eax
c0101949:	0f b7 d0             	movzwl %ax,%edx
c010194c:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010194f:	66 89 14 c5 80 c6 11 	mov    %dx,-0x3fee3980(,%eax,8)
c0101956:	c0 
c0101957:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010195a:	66 c7 04 c5 82 c6 11 	movw   $0x8,-0x3fee397e(,%eax,8)
c0101961:	c0 08 00 
c0101964:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101967:	0f b6 14 c5 84 c6 11 	movzbl -0x3fee397c(,%eax,8),%edx
c010196e:	c0 
c010196f:	80 e2 e0             	and    $0xe0,%dl
c0101972:	88 14 c5 84 c6 11 c0 	mov    %dl,-0x3fee397c(,%eax,8)
c0101979:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010197c:	0f b6 14 c5 84 c6 11 	movzbl -0x3fee397c(,%eax,8),%edx
c0101983:	c0 
c0101984:	80 e2 1f             	and    $0x1f,%dl
c0101987:	88 14 c5 84 c6 11 c0 	mov    %dl,-0x3fee397c(,%eax,8)
c010198e:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101991:	0f b6 14 c5 85 c6 11 	movzbl -0x3fee397b(,%eax,8),%edx
c0101998:	c0 
c0101999:	80 e2 f0             	and    $0xf0,%dl
c010199c:	80 ca 0e             	or     $0xe,%dl
c010199f:	88 14 c5 85 c6 11 c0 	mov    %dl,-0x3fee397b(,%eax,8)
c01019a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019a9:	0f b6 14 c5 85 c6 11 	movzbl -0x3fee397b(,%eax,8),%edx
c01019b0:	c0 
c01019b1:	80 e2 ef             	and    $0xef,%dl
c01019b4:	88 14 c5 85 c6 11 c0 	mov    %dl,-0x3fee397b(,%eax,8)
c01019bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019be:	0f b6 14 c5 85 c6 11 	movzbl -0x3fee397b(,%eax,8),%edx
c01019c5:	c0 
c01019c6:	80 e2 9f             	and    $0x9f,%dl
c01019c9:	88 14 c5 85 c6 11 c0 	mov    %dl,-0x3fee397b(,%eax,8)
c01019d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019d3:	0f b6 14 c5 85 c6 11 	movzbl -0x3fee397b(,%eax,8),%edx
c01019da:	c0 
c01019db:	80 ca 80             	or     $0x80,%dl
c01019de:	88 14 c5 85 c6 11 c0 	mov    %dl,-0x3fee397b(,%eax,8)
c01019e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019e8:	8b 04 85 e0 95 11 c0 	mov    -0x3fee6a20(,%eax,4),%eax
c01019ef:	c1 e8 10             	shr    $0x10,%eax
c01019f2:	0f b7 d0             	movzwl %ax,%edx
c01019f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01019f8:	66 89 14 c5 86 c6 11 	mov    %dx,-0x3fee397a(,%eax,8)
c01019ff:	c0 
    for(i=0; i<sizeof(idt)/sizeof(struct gatedesc);i++){
c0101a00:	ff 45 fc             	incl   -0x4(%ebp)
c0101a03:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0101a06:	3d ff 00 00 00       	cmp    $0xff,%eax
c0101a0b:	0f 86 2e ff ff ff    	jbe    c010193f <idt_init+0x16>
    } 
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);//因为在发生中断时候，我们需要从用户态切换到内核态，所以得留个口让用户态进来
c0101a11:	a1 c4 97 11 c0       	mov    0xc01197c4,%eax
c0101a16:	0f b7 c0             	movzwl %ax,%eax
c0101a19:	66 a3 48 ca 11 c0    	mov    %ax,0xc011ca48
c0101a1f:	66 c7 05 4a ca 11 c0 	movw   $0x8,0xc011ca4a
c0101a26:	08 00 
c0101a28:	0f b6 05 4c ca 11 c0 	movzbl 0xc011ca4c,%eax
c0101a2f:	24 e0                	and    $0xe0,%al
c0101a31:	a2 4c ca 11 c0       	mov    %al,0xc011ca4c
c0101a36:	0f b6 05 4c ca 11 c0 	movzbl 0xc011ca4c,%eax
c0101a3d:	24 1f                	and    $0x1f,%al
c0101a3f:	a2 4c ca 11 c0       	mov    %al,0xc011ca4c
c0101a44:	0f b6 05 4d ca 11 c0 	movzbl 0xc011ca4d,%eax
c0101a4b:	24 f0                	and    $0xf0,%al
c0101a4d:	0c 0e                	or     $0xe,%al
c0101a4f:	a2 4d ca 11 c0       	mov    %al,0xc011ca4d
c0101a54:	0f b6 05 4d ca 11 c0 	movzbl 0xc011ca4d,%eax
c0101a5b:	24 ef                	and    $0xef,%al
c0101a5d:	a2 4d ca 11 c0       	mov    %al,0xc011ca4d
c0101a62:	0f b6 05 4d ca 11 c0 	movzbl 0xc011ca4d,%eax
c0101a69:	0c 60                	or     $0x60,%al
c0101a6b:	a2 4d ca 11 c0       	mov    %al,0xc011ca4d
c0101a70:	0f b6 05 4d ca 11 c0 	movzbl 0xc011ca4d,%eax
c0101a77:	0c 80                	or     $0x80,%al
c0101a79:	a2 4d ca 11 c0       	mov    %al,0xc011ca4d
c0101a7e:	a1 c4 97 11 c0       	mov    0xc01197c4,%eax
c0101a83:	c1 e8 10             	shr    $0x10,%eax
c0101a86:	0f b7 c0             	movzwl %ax,%eax
c0101a89:	66 a3 4e ca 11 c0    	mov    %ax,0xc011ca4e
c0101a8f:	c7 45 f8 60 95 11 c0 	movl   $0xc0119560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd) : "memory");
c0101a96:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0101a99:	0f 01 18             	lidtl  (%eax)
}
c0101a9c:	90                   	nop
    lidt(&idt_pd);
}
c0101a9d:	90                   	nop
c0101a9e:	c9                   	leave  
c0101a9f:	c3                   	ret    

c0101aa0 <trapname>:

static const char *
trapname(int trapno) {
c0101aa0:	f3 0f 1e fb          	endbr32 
c0101aa4:	55                   	push   %ebp
c0101aa5:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
c0101aa7:	8b 45 08             	mov    0x8(%ebp),%eax
c0101aaa:	83 f8 13             	cmp    $0x13,%eax
c0101aad:	77 0c                	ja     c0101abb <trapname+0x1b>
        return excnames[trapno];
c0101aaf:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ab2:	8b 04 85 c0 67 10 c0 	mov    -0x3fef9840(,%eax,4),%eax
c0101ab9:	eb 18                	jmp    c0101ad3 <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
c0101abb:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
c0101abf:	7e 0d                	jle    c0101ace <trapname+0x2e>
c0101ac1:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
c0101ac5:	7f 07                	jg     c0101ace <trapname+0x2e>
        return "Hardware Interrupt";
c0101ac7:	b8 7f 64 10 c0       	mov    $0xc010647f,%eax
c0101acc:	eb 05                	jmp    c0101ad3 <trapname+0x33>
    }
    return "(unknown trap)";
c0101ace:	b8 92 64 10 c0       	mov    $0xc0106492,%eax
}
c0101ad3:	5d                   	pop    %ebp
c0101ad4:	c3                   	ret    

c0101ad5 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
c0101ad5:	f3 0f 1e fb          	endbr32 
c0101ad9:	55                   	push   %ebp
c0101ada:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
c0101adc:	8b 45 08             	mov    0x8(%ebp),%eax
c0101adf:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101ae3:	83 f8 08             	cmp    $0x8,%eax
c0101ae6:	0f 94 c0             	sete   %al
c0101ae9:	0f b6 c0             	movzbl %al,%eax
}
c0101aec:	5d                   	pop    %ebp
c0101aed:	c3                   	ret    

c0101aee <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
c0101aee:	f3 0f 1e fb          	endbr32 
c0101af2:	55                   	push   %ebp
c0101af3:	89 e5                	mov    %esp,%ebp
c0101af5:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
c0101af8:	8b 45 08             	mov    0x8(%ebp),%eax
c0101afb:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101aff:	c7 04 24 d3 64 10 c0 	movl   $0xc01064d3,(%esp)
c0101b06:	e8 be e7 ff ff       	call   c01002c9 <cprintf>
    print_regs(&tf->tf_regs);
c0101b0b:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b0e:	89 04 24             	mov    %eax,(%esp)
c0101b11:	e8 8d 01 00 00       	call   c0101ca3 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
c0101b16:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b19:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
c0101b1d:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101b21:	c7 04 24 e4 64 10 c0 	movl   $0xc01064e4,(%esp)
c0101b28:	e8 9c e7 ff ff       	call   c01002c9 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
c0101b2d:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b30:	0f b7 40 28          	movzwl 0x28(%eax),%eax
c0101b34:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101b38:	c7 04 24 f7 64 10 c0 	movl   $0xc01064f7,(%esp)
c0101b3f:	e8 85 e7 ff ff       	call   c01002c9 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
c0101b44:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b47:	0f b7 40 24          	movzwl 0x24(%eax),%eax
c0101b4b:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101b4f:	c7 04 24 0a 65 10 c0 	movl   $0xc010650a,(%esp)
c0101b56:	e8 6e e7 ff ff       	call   c01002c9 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
c0101b5b:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b5e:	0f b7 40 20          	movzwl 0x20(%eax),%eax
c0101b62:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101b66:	c7 04 24 1d 65 10 c0 	movl   $0xc010651d,(%esp)
c0101b6d:	e8 57 e7 ff ff       	call   c01002c9 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
c0101b72:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b75:	8b 40 30             	mov    0x30(%eax),%eax
c0101b78:	89 04 24             	mov    %eax,(%esp)
c0101b7b:	e8 20 ff ff ff       	call   c0101aa0 <trapname>
c0101b80:	8b 55 08             	mov    0x8(%ebp),%edx
c0101b83:	8b 52 30             	mov    0x30(%edx),%edx
c0101b86:	89 44 24 08          	mov    %eax,0x8(%esp)
c0101b8a:	89 54 24 04          	mov    %edx,0x4(%esp)
c0101b8e:	c7 04 24 30 65 10 c0 	movl   $0xc0106530,(%esp)
c0101b95:	e8 2f e7 ff ff       	call   c01002c9 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
c0101b9a:	8b 45 08             	mov    0x8(%ebp),%eax
c0101b9d:	8b 40 34             	mov    0x34(%eax),%eax
c0101ba0:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101ba4:	c7 04 24 42 65 10 c0 	movl   $0xc0106542,(%esp)
c0101bab:	e8 19 e7 ff ff       	call   c01002c9 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
c0101bb0:	8b 45 08             	mov    0x8(%ebp),%eax
c0101bb3:	8b 40 38             	mov    0x38(%eax),%eax
c0101bb6:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101bba:	c7 04 24 51 65 10 c0 	movl   $0xc0106551,(%esp)
c0101bc1:	e8 03 e7 ff ff       	call   c01002c9 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
c0101bc6:	8b 45 08             	mov    0x8(%ebp),%eax
c0101bc9:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101bcd:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101bd1:	c7 04 24 60 65 10 c0 	movl   $0xc0106560,(%esp)
c0101bd8:	e8 ec e6 ff ff       	call   c01002c9 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
c0101bdd:	8b 45 08             	mov    0x8(%ebp),%eax
c0101be0:	8b 40 40             	mov    0x40(%eax),%eax
c0101be3:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101be7:	c7 04 24 73 65 10 c0 	movl   $0xc0106573,(%esp)
c0101bee:	e8 d6 e6 ff ff       	call   c01002c9 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
c0101bf3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0101bfa:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
c0101c01:	eb 3d                	jmp    c0101c40 <print_trapframe+0x152>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
c0101c03:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c06:	8b 50 40             	mov    0x40(%eax),%edx
c0101c09:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0101c0c:	21 d0                	and    %edx,%eax
c0101c0e:	85 c0                	test   %eax,%eax
c0101c10:	74 28                	je     c0101c3a <print_trapframe+0x14c>
c0101c12:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101c15:	8b 04 85 80 95 11 c0 	mov    -0x3fee6a80(,%eax,4),%eax
c0101c1c:	85 c0                	test   %eax,%eax
c0101c1e:	74 1a                	je     c0101c3a <print_trapframe+0x14c>
            cprintf("%s,", IA32flags[i]);
c0101c20:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101c23:	8b 04 85 80 95 11 c0 	mov    -0x3fee6a80(,%eax,4),%eax
c0101c2a:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101c2e:	c7 04 24 82 65 10 c0 	movl   $0xc0106582,(%esp)
c0101c35:	e8 8f e6 ff ff       	call   c01002c9 <cprintf>
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
c0101c3a:	ff 45 f4             	incl   -0xc(%ebp)
c0101c3d:	d1 65 f0             	shll   -0x10(%ebp)
c0101c40:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0101c43:	83 f8 17             	cmp    $0x17,%eax
c0101c46:	76 bb                	jbe    c0101c03 <print_trapframe+0x115>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
c0101c48:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c4b:	8b 40 40             	mov    0x40(%eax),%eax
c0101c4e:	c1 e8 0c             	shr    $0xc,%eax
c0101c51:	83 e0 03             	and    $0x3,%eax
c0101c54:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101c58:	c7 04 24 86 65 10 c0 	movl   $0xc0106586,(%esp)
c0101c5f:	e8 65 e6 ff ff       	call   c01002c9 <cprintf>

    if (!trap_in_kernel(tf)) {
c0101c64:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c67:	89 04 24             	mov    %eax,(%esp)
c0101c6a:	e8 66 fe ff ff       	call   c0101ad5 <trap_in_kernel>
c0101c6f:	85 c0                	test   %eax,%eax
c0101c71:	75 2d                	jne    c0101ca0 <print_trapframe+0x1b2>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
c0101c73:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c76:	8b 40 44             	mov    0x44(%eax),%eax
c0101c79:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101c7d:	c7 04 24 8f 65 10 c0 	movl   $0xc010658f,(%esp)
c0101c84:	e8 40 e6 ff ff       	call   c01002c9 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
c0101c89:	8b 45 08             	mov    0x8(%ebp),%eax
c0101c8c:	0f b7 40 48          	movzwl 0x48(%eax),%eax
c0101c90:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101c94:	c7 04 24 9e 65 10 c0 	movl   $0xc010659e,(%esp)
c0101c9b:	e8 29 e6 ff ff       	call   c01002c9 <cprintf>
    }
}
c0101ca0:	90                   	nop
c0101ca1:	c9                   	leave  
c0101ca2:	c3                   	ret    

c0101ca3 <print_regs>:

void
print_regs(struct pushregs *regs) {
c0101ca3:	f3 0f 1e fb          	endbr32 
c0101ca7:	55                   	push   %ebp
c0101ca8:	89 e5                	mov    %esp,%ebp
c0101caa:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
c0101cad:	8b 45 08             	mov    0x8(%ebp),%eax
c0101cb0:	8b 00                	mov    (%eax),%eax
c0101cb2:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101cb6:	c7 04 24 b1 65 10 c0 	movl   $0xc01065b1,(%esp)
c0101cbd:	e8 07 e6 ff ff       	call   c01002c9 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
c0101cc2:	8b 45 08             	mov    0x8(%ebp),%eax
c0101cc5:	8b 40 04             	mov    0x4(%eax),%eax
c0101cc8:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101ccc:	c7 04 24 c0 65 10 c0 	movl   $0xc01065c0,(%esp)
c0101cd3:	e8 f1 e5 ff ff       	call   c01002c9 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
c0101cd8:	8b 45 08             	mov    0x8(%ebp),%eax
c0101cdb:	8b 40 08             	mov    0x8(%eax),%eax
c0101cde:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101ce2:	c7 04 24 cf 65 10 c0 	movl   $0xc01065cf,(%esp)
c0101ce9:	e8 db e5 ff ff       	call   c01002c9 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
c0101cee:	8b 45 08             	mov    0x8(%ebp),%eax
c0101cf1:	8b 40 0c             	mov    0xc(%eax),%eax
c0101cf4:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101cf8:	c7 04 24 de 65 10 c0 	movl   $0xc01065de,(%esp)
c0101cff:	e8 c5 e5 ff ff       	call   c01002c9 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
c0101d04:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d07:	8b 40 10             	mov    0x10(%eax),%eax
c0101d0a:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101d0e:	c7 04 24 ed 65 10 c0 	movl   $0xc01065ed,(%esp)
c0101d15:	e8 af e5 ff ff       	call   c01002c9 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
c0101d1a:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d1d:	8b 40 14             	mov    0x14(%eax),%eax
c0101d20:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101d24:	c7 04 24 fc 65 10 c0 	movl   $0xc01065fc,(%esp)
c0101d2b:	e8 99 e5 ff ff       	call   c01002c9 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
c0101d30:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d33:	8b 40 18             	mov    0x18(%eax),%eax
c0101d36:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101d3a:	c7 04 24 0b 66 10 c0 	movl   $0xc010660b,(%esp)
c0101d41:	e8 83 e5 ff ff       	call   c01002c9 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
c0101d46:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d49:	8b 40 1c             	mov    0x1c(%eax),%eax
c0101d4c:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101d50:	c7 04 24 1a 66 10 c0 	movl   $0xc010661a,(%esp)
c0101d57:	e8 6d e5 ff ff       	call   c01002c9 <cprintf>
}
c0101d5c:	90                   	nop
c0101d5d:	c9                   	leave  
c0101d5e:	c3                   	ret    

c0101d5f <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
c0101d5f:	f3 0f 1e fb          	endbr32 
c0101d63:	55                   	push   %ebp
c0101d64:	89 e5                	mov    %esp,%ebp
c0101d66:	83 ec 28             	sub    $0x28,%esp
    char c;

    switch (tf->tf_trapno) {
c0101d69:	8b 45 08             	mov    0x8(%ebp),%eax
c0101d6c:	8b 40 30             	mov    0x30(%eax),%eax
c0101d6f:	83 f8 79             	cmp    $0x79,%eax
c0101d72:	0f 84 44 01 00 00    	je     c0101ebc <trap_dispatch+0x15d>
c0101d78:	83 f8 79             	cmp    $0x79,%eax
c0101d7b:	0f 87 7c 01 00 00    	ja     c0101efd <trap_dispatch+0x19e>
c0101d81:	83 f8 78             	cmp    $0x78,%eax
c0101d84:	0f 84 d0 00 00 00    	je     c0101e5a <trap_dispatch+0xfb>
c0101d8a:	83 f8 78             	cmp    $0x78,%eax
c0101d8d:	0f 87 6a 01 00 00    	ja     c0101efd <trap_dispatch+0x19e>
c0101d93:	83 f8 2f             	cmp    $0x2f,%eax
c0101d96:	0f 87 61 01 00 00    	ja     c0101efd <trap_dispatch+0x19e>
c0101d9c:	83 f8 2e             	cmp    $0x2e,%eax
c0101d9f:	0f 83 8d 01 00 00    	jae    c0101f32 <trap_dispatch+0x1d3>
c0101da5:	83 f8 24             	cmp    $0x24,%eax
c0101da8:	74 5e                	je     c0101e08 <trap_dispatch+0xa9>
c0101daa:	83 f8 24             	cmp    $0x24,%eax
c0101dad:	0f 87 4a 01 00 00    	ja     c0101efd <trap_dispatch+0x19e>
c0101db3:	83 f8 20             	cmp    $0x20,%eax
c0101db6:	74 0a                	je     c0101dc2 <trap_dispatch+0x63>
c0101db8:	83 f8 21             	cmp    $0x21,%eax
c0101dbb:	74 74                	je     c0101e31 <trap_dispatch+0xd2>
c0101dbd:	e9 3b 01 00 00       	jmp    c0101efd <trap_dispatch+0x19e>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks++;
c0101dc2:	a1 0c cf 11 c0       	mov    0xc011cf0c,%eax
c0101dc7:	40                   	inc    %eax
c0101dc8:	a3 0c cf 11 c0       	mov    %eax,0xc011cf0c
        if(ticks%TICK_NUM==0){
c0101dcd:	8b 0d 0c cf 11 c0    	mov    0xc011cf0c,%ecx
c0101dd3:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
c0101dd8:	89 c8                	mov    %ecx,%eax
c0101dda:	f7 e2                	mul    %edx
c0101ddc:	c1 ea 05             	shr    $0x5,%edx
c0101ddf:	89 d0                	mov    %edx,%eax
c0101de1:	c1 e0 02             	shl    $0x2,%eax
c0101de4:	01 d0                	add    %edx,%eax
c0101de6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0101ded:	01 d0                	add    %edx,%eax
c0101def:	c1 e0 02             	shl    $0x2,%eax
c0101df2:	29 c1                	sub    %eax,%ecx
c0101df4:	89 ca                	mov    %ecx,%edx
c0101df6:	85 d2                	test   %edx,%edx
c0101df8:	0f 85 37 01 00 00    	jne    c0101f35 <trap_dispatch+0x1d6>
            print_ticks();
c0101dfe:	e8 e0 fa ff ff       	call   c01018e3 <print_ticks>
        }
        break;
c0101e03:	e9 2d 01 00 00       	jmp    c0101f35 <trap_dispatch+0x1d6>
    case IRQ_OFFSET + IRQ_COM1://若中断号是IRQ_OFFSET + IRQ_COM1 为串口中断，则显示收到的字符
        c = cons_getc();
c0101e08:	e8 69 f8 ff ff       	call   c0101676 <cons_getc>
c0101e0d:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
c0101e10:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
c0101e14:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
c0101e18:	89 54 24 08          	mov    %edx,0x8(%esp)
c0101e1c:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101e20:	c7 04 24 29 66 10 c0 	movl   $0xc0106629,(%esp)
c0101e27:	e8 9d e4 ff ff       	call   c01002c9 <cprintf>
        break;
c0101e2c:	e9 0b 01 00 00       	jmp    c0101f3c <trap_dispatch+0x1dd>
    case IRQ_OFFSET + IRQ_KBD://若中断号是IRQ_OFFSET + IRQ_KBD 为 键盘中断，则显示收到的字符
        c = cons_getc();
c0101e31:	e8 40 f8 ff ff       	call   c0101676 <cons_getc>
c0101e36:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
c0101e39:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
c0101e3d:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
c0101e41:	89 54 24 08          	mov    %edx,0x8(%esp)
c0101e45:	89 44 24 04          	mov    %eax,0x4(%esp)
c0101e49:	c7 04 24 3b 66 10 c0 	movl   $0xc010663b,(%esp)
c0101e50:	e8 74 e4 ff ff       	call   c01002c9 <cprintf>
        break;
c0101e55:	e9 e2 00 00 00       	jmp    c0101f3c <trap_dispatch+0x1dd>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    //tf trapframe  栈帧结构体
    case T_SWITCH_TOU://内核→用户
        //panic("T_SWITCH_USER ??\n");
    	if (tf->tf_cs != USER_CS) {
c0101e5a:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e5d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101e61:	83 f8 1b             	cmp    $0x1b,%eax
c0101e64:	0f 84 ce 00 00 00    	je     c0101f38 <trap_dispatch+0x1d9>
            tf->tf_cs = USER_CS;
c0101e6a:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e6d:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
            tf->tf_ds = tf->tf_es = tf->tf_ss = USER_DS;
c0101e73:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e76:	66 c7 40 48 23 00    	movw   $0x23,0x48(%eax)
c0101e7c:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e7f:	0f b7 50 48          	movzwl 0x48(%eax),%edx
c0101e83:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e86:	66 89 50 28          	mov    %dx,0x28(%eax)
c0101e8a:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e8d:	0f b7 50 28          	movzwl 0x28(%eax),%edx
c0101e91:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e94:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_esp += 4;
c0101e98:	8b 45 08             	mov    0x8(%ebp),%eax
c0101e9b:	8b 40 44             	mov    0x44(%eax),%eax
c0101e9e:	8d 50 04             	lea    0x4(%eax),%edx
c0101ea1:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ea4:	89 50 44             	mov    %edx,0x44(%eax)
            tf->tf_eflags |= FL_IOPL_MASK;
c0101ea7:	8b 45 08             	mov    0x8(%ebp),%eax
c0101eaa:	8b 40 40             	mov    0x40(%eax),%eax
c0101ead:	0d 00 30 00 00       	or     $0x3000,%eax
c0101eb2:	89 c2                	mov    %eax,%edx
c0101eb4:	8b 45 08             	mov    0x8(%ebp),%eax
c0101eb7:	89 50 40             	mov    %edx,0x40(%eax)
        }
        break;
c0101eba:	eb 7c                	jmp    c0101f38 <trap_dispatch+0x1d9>
    case T_SWITCH_TOK://用户→内核
        //panic("T_SWITCH_KERNEL ??\n");
        if (tf->tf_cs != KERNEL_CS) {
c0101ebc:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ebf:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101ec3:	83 f8 08             	cmp    $0x8,%eax
c0101ec6:	74 73                	je     c0101f3b <trap_dispatch+0x1dc>
            tf->tf_cs = KERNEL_CS;
c0101ec8:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ecb:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
c0101ed1:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ed4:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
c0101eda:	8b 45 08             	mov    0x8(%ebp),%eax
c0101edd:	0f b7 50 28          	movzwl 0x28(%eax),%edx
c0101ee1:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ee4:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
c0101ee8:	8b 45 08             	mov    0x8(%ebp),%eax
c0101eeb:	8b 40 40             	mov    0x40(%eax),%eax
c0101eee:	25 ff cf ff ff       	and    $0xffffcfff,%eax
c0101ef3:	89 c2                	mov    %eax,%edx
c0101ef5:	8b 45 08             	mov    0x8(%ebp),%eax
c0101ef8:	89 50 40             	mov    %edx,0x40(%eax)
        }
        break;
c0101efb:	eb 3e                	jmp    c0101f3b <trap_dispatch+0x1dc>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
c0101efd:	8b 45 08             	mov    0x8(%ebp),%eax
c0101f00:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
c0101f04:	83 e0 03             	and    $0x3,%eax
c0101f07:	85 c0                	test   %eax,%eax
c0101f09:	75 31                	jne    c0101f3c <trap_dispatch+0x1dd>
            print_trapframe(tf);
c0101f0b:	8b 45 08             	mov    0x8(%ebp),%eax
c0101f0e:	89 04 24             	mov    %eax,(%esp)
c0101f11:	e8 d8 fb ff ff       	call   c0101aee <print_trapframe>
            panic("unexpected trap in kernel.\n");
c0101f16:	c7 44 24 08 4a 66 10 	movl   $0xc010664a,0x8(%esp)
c0101f1d:	c0 
c0101f1e:	c7 44 24 04 d1 00 00 	movl   $0xd1,0x4(%esp)
c0101f25:	00 
c0101f26:	c7 04 24 6e 64 10 c0 	movl   $0xc010646e,(%esp)
c0101f2d:	e8 03 e5 ff ff       	call   c0100435 <__panic>
        break;
c0101f32:	90                   	nop
c0101f33:	eb 07                	jmp    c0101f3c <trap_dispatch+0x1dd>
        break;
c0101f35:	90                   	nop
c0101f36:	eb 04                	jmp    c0101f3c <trap_dispatch+0x1dd>
        break;
c0101f38:	90                   	nop
c0101f39:	eb 01                	jmp    c0101f3c <trap_dispatch+0x1dd>
        break;
c0101f3b:	90                   	nop
        }
    }
}
c0101f3c:	90                   	nop
c0101f3d:	c9                   	leave  
c0101f3e:	c3                   	ret    

c0101f3f <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
c0101f3f:	f3 0f 1e fb          	endbr32 
c0101f43:	55                   	push   %ebp
c0101f44:	89 e5                	mov    %esp,%ebp
c0101f46:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
c0101f49:	8b 45 08             	mov    0x8(%ebp),%eax
c0101f4c:	89 04 24             	mov    %eax,(%esp)
c0101f4f:	e8 0b fe ff ff       	call   c0101d5f <trap_dispatch>
}
c0101f54:	90                   	nop
c0101f55:	c9                   	leave  
c0101f56:	c3                   	ret    

c0101f57 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
c0101f57:	6a 00                	push   $0x0
  pushl $0
c0101f59:	6a 00                	push   $0x0
  jmp __alltraps
c0101f5b:	e9 69 0a 00 00       	jmp    c01029c9 <__alltraps>

c0101f60 <vector1>:
.globl vector1
vector1:
  pushl $0
c0101f60:	6a 00                	push   $0x0
  pushl $1
c0101f62:	6a 01                	push   $0x1
  jmp __alltraps
c0101f64:	e9 60 0a 00 00       	jmp    c01029c9 <__alltraps>

c0101f69 <vector2>:
.globl vector2
vector2:
  pushl $0
c0101f69:	6a 00                	push   $0x0
  pushl $2
c0101f6b:	6a 02                	push   $0x2
  jmp __alltraps
c0101f6d:	e9 57 0a 00 00       	jmp    c01029c9 <__alltraps>

c0101f72 <vector3>:
.globl vector3
vector3:
  pushl $0
c0101f72:	6a 00                	push   $0x0
  pushl $3
c0101f74:	6a 03                	push   $0x3
  jmp __alltraps
c0101f76:	e9 4e 0a 00 00       	jmp    c01029c9 <__alltraps>

c0101f7b <vector4>:
.globl vector4
vector4:
  pushl $0
c0101f7b:	6a 00                	push   $0x0
  pushl $4
c0101f7d:	6a 04                	push   $0x4
  jmp __alltraps
c0101f7f:	e9 45 0a 00 00       	jmp    c01029c9 <__alltraps>

c0101f84 <vector5>:
.globl vector5
vector5:
  pushl $0
c0101f84:	6a 00                	push   $0x0
  pushl $5
c0101f86:	6a 05                	push   $0x5
  jmp __alltraps
c0101f88:	e9 3c 0a 00 00       	jmp    c01029c9 <__alltraps>

c0101f8d <vector6>:
.globl vector6
vector6:
  pushl $0
c0101f8d:	6a 00                	push   $0x0
  pushl $6
c0101f8f:	6a 06                	push   $0x6
  jmp __alltraps
c0101f91:	e9 33 0a 00 00       	jmp    c01029c9 <__alltraps>

c0101f96 <vector7>:
.globl vector7
vector7:
  pushl $0
c0101f96:	6a 00                	push   $0x0
  pushl $7
c0101f98:	6a 07                	push   $0x7
  jmp __alltraps
c0101f9a:	e9 2a 0a 00 00       	jmp    c01029c9 <__alltraps>

c0101f9f <vector8>:
.globl vector8
vector8:
  pushl $8
c0101f9f:	6a 08                	push   $0x8
  jmp __alltraps
c0101fa1:	e9 23 0a 00 00       	jmp    c01029c9 <__alltraps>

c0101fa6 <vector9>:
.globl vector9
vector9:
  pushl $0
c0101fa6:	6a 00                	push   $0x0
  pushl $9
c0101fa8:	6a 09                	push   $0x9
  jmp __alltraps
c0101faa:	e9 1a 0a 00 00       	jmp    c01029c9 <__alltraps>

c0101faf <vector10>:
.globl vector10
vector10:
  pushl $10
c0101faf:	6a 0a                	push   $0xa
  jmp __alltraps
c0101fb1:	e9 13 0a 00 00       	jmp    c01029c9 <__alltraps>

c0101fb6 <vector11>:
.globl vector11
vector11:
  pushl $11
c0101fb6:	6a 0b                	push   $0xb
  jmp __alltraps
c0101fb8:	e9 0c 0a 00 00       	jmp    c01029c9 <__alltraps>

c0101fbd <vector12>:
.globl vector12
vector12:
  pushl $12
c0101fbd:	6a 0c                	push   $0xc
  jmp __alltraps
c0101fbf:	e9 05 0a 00 00       	jmp    c01029c9 <__alltraps>

c0101fc4 <vector13>:
.globl vector13
vector13:
  pushl $13
c0101fc4:	6a 0d                	push   $0xd
  jmp __alltraps
c0101fc6:	e9 fe 09 00 00       	jmp    c01029c9 <__alltraps>

c0101fcb <vector14>:
.globl vector14
vector14:
  pushl $14
c0101fcb:	6a 0e                	push   $0xe
  jmp __alltraps
c0101fcd:	e9 f7 09 00 00       	jmp    c01029c9 <__alltraps>

c0101fd2 <vector15>:
.globl vector15
vector15:
  pushl $0
c0101fd2:	6a 00                	push   $0x0
  pushl $15
c0101fd4:	6a 0f                	push   $0xf
  jmp __alltraps
c0101fd6:	e9 ee 09 00 00       	jmp    c01029c9 <__alltraps>

c0101fdb <vector16>:
.globl vector16
vector16:
  pushl $0
c0101fdb:	6a 00                	push   $0x0
  pushl $16
c0101fdd:	6a 10                	push   $0x10
  jmp __alltraps
c0101fdf:	e9 e5 09 00 00       	jmp    c01029c9 <__alltraps>

c0101fe4 <vector17>:
.globl vector17
vector17:
  pushl $17
c0101fe4:	6a 11                	push   $0x11
  jmp __alltraps
c0101fe6:	e9 de 09 00 00       	jmp    c01029c9 <__alltraps>

c0101feb <vector18>:
.globl vector18
vector18:
  pushl $0
c0101feb:	6a 00                	push   $0x0
  pushl $18
c0101fed:	6a 12                	push   $0x12
  jmp __alltraps
c0101fef:	e9 d5 09 00 00       	jmp    c01029c9 <__alltraps>

c0101ff4 <vector19>:
.globl vector19
vector19:
  pushl $0
c0101ff4:	6a 00                	push   $0x0
  pushl $19
c0101ff6:	6a 13                	push   $0x13
  jmp __alltraps
c0101ff8:	e9 cc 09 00 00       	jmp    c01029c9 <__alltraps>

c0101ffd <vector20>:
.globl vector20
vector20:
  pushl $0
c0101ffd:	6a 00                	push   $0x0
  pushl $20
c0101fff:	6a 14                	push   $0x14
  jmp __alltraps
c0102001:	e9 c3 09 00 00       	jmp    c01029c9 <__alltraps>

c0102006 <vector21>:
.globl vector21
vector21:
  pushl $0
c0102006:	6a 00                	push   $0x0
  pushl $21
c0102008:	6a 15                	push   $0x15
  jmp __alltraps
c010200a:	e9 ba 09 00 00       	jmp    c01029c9 <__alltraps>

c010200f <vector22>:
.globl vector22
vector22:
  pushl $0
c010200f:	6a 00                	push   $0x0
  pushl $22
c0102011:	6a 16                	push   $0x16
  jmp __alltraps
c0102013:	e9 b1 09 00 00       	jmp    c01029c9 <__alltraps>

c0102018 <vector23>:
.globl vector23
vector23:
  pushl $0
c0102018:	6a 00                	push   $0x0
  pushl $23
c010201a:	6a 17                	push   $0x17
  jmp __alltraps
c010201c:	e9 a8 09 00 00       	jmp    c01029c9 <__alltraps>

c0102021 <vector24>:
.globl vector24
vector24:
  pushl $0
c0102021:	6a 00                	push   $0x0
  pushl $24
c0102023:	6a 18                	push   $0x18
  jmp __alltraps
c0102025:	e9 9f 09 00 00       	jmp    c01029c9 <__alltraps>

c010202a <vector25>:
.globl vector25
vector25:
  pushl $0
c010202a:	6a 00                	push   $0x0
  pushl $25
c010202c:	6a 19                	push   $0x19
  jmp __alltraps
c010202e:	e9 96 09 00 00       	jmp    c01029c9 <__alltraps>

c0102033 <vector26>:
.globl vector26
vector26:
  pushl $0
c0102033:	6a 00                	push   $0x0
  pushl $26
c0102035:	6a 1a                	push   $0x1a
  jmp __alltraps
c0102037:	e9 8d 09 00 00       	jmp    c01029c9 <__alltraps>

c010203c <vector27>:
.globl vector27
vector27:
  pushl $0
c010203c:	6a 00                	push   $0x0
  pushl $27
c010203e:	6a 1b                	push   $0x1b
  jmp __alltraps
c0102040:	e9 84 09 00 00       	jmp    c01029c9 <__alltraps>

c0102045 <vector28>:
.globl vector28
vector28:
  pushl $0
c0102045:	6a 00                	push   $0x0
  pushl $28
c0102047:	6a 1c                	push   $0x1c
  jmp __alltraps
c0102049:	e9 7b 09 00 00       	jmp    c01029c9 <__alltraps>

c010204e <vector29>:
.globl vector29
vector29:
  pushl $0
c010204e:	6a 00                	push   $0x0
  pushl $29
c0102050:	6a 1d                	push   $0x1d
  jmp __alltraps
c0102052:	e9 72 09 00 00       	jmp    c01029c9 <__alltraps>

c0102057 <vector30>:
.globl vector30
vector30:
  pushl $0
c0102057:	6a 00                	push   $0x0
  pushl $30
c0102059:	6a 1e                	push   $0x1e
  jmp __alltraps
c010205b:	e9 69 09 00 00       	jmp    c01029c9 <__alltraps>

c0102060 <vector31>:
.globl vector31
vector31:
  pushl $0
c0102060:	6a 00                	push   $0x0
  pushl $31
c0102062:	6a 1f                	push   $0x1f
  jmp __alltraps
c0102064:	e9 60 09 00 00       	jmp    c01029c9 <__alltraps>

c0102069 <vector32>:
.globl vector32
vector32:
  pushl $0
c0102069:	6a 00                	push   $0x0
  pushl $32
c010206b:	6a 20                	push   $0x20
  jmp __alltraps
c010206d:	e9 57 09 00 00       	jmp    c01029c9 <__alltraps>

c0102072 <vector33>:
.globl vector33
vector33:
  pushl $0
c0102072:	6a 00                	push   $0x0
  pushl $33
c0102074:	6a 21                	push   $0x21
  jmp __alltraps
c0102076:	e9 4e 09 00 00       	jmp    c01029c9 <__alltraps>

c010207b <vector34>:
.globl vector34
vector34:
  pushl $0
c010207b:	6a 00                	push   $0x0
  pushl $34
c010207d:	6a 22                	push   $0x22
  jmp __alltraps
c010207f:	e9 45 09 00 00       	jmp    c01029c9 <__alltraps>

c0102084 <vector35>:
.globl vector35
vector35:
  pushl $0
c0102084:	6a 00                	push   $0x0
  pushl $35
c0102086:	6a 23                	push   $0x23
  jmp __alltraps
c0102088:	e9 3c 09 00 00       	jmp    c01029c9 <__alltraps>

c010208d <vector36>:
.globl vector36
vector36:
  pushl $0
c010208d:	6a 00                	push   $0x0
  pushl $36
c010208f:	6a 24                	push   $0x24
  jmp __alltraps
c0102091:	e9 33 09 00 00       	jmp    c01029c9 <__alltraps>

c0102096 <vector37>:
.globl vector37
vector37:
  pushl $0
c0102096:	6a 00                	push   $0x0
  pushl $37
c0102098:	6a 25                	push   $0x25
  jmp __alltraps
c010209a:	e9 2a 09 00 00       	jmp    c01029c9 <__alltraps>

c010209f <vector38>:
.globl vector38
vector38:
  pushl $0
c010209f:	6a 00                	push   $0x0
  pushl $38
c01020a1:	6a 26                	push   $0x26
  jmp __alltraps
c01020a3:	e9 21 09 00 00       	jmp    c01029c9 <__alltraps>

c01020a8 <vector39>:
.globl vector39
vector39:
  pushl $0
c01020a8:	6a 00                	push   $0x0
  pushl $39
c01020aa:	6a 27                	push   $0x27
  jmp __alltraps
c01020ac:	e9 18 09 00 00       	jmp    c01029c9 <__alltraps>

c01020b1 <vector40>:
.globl vector40
vector40:
  pushl $0
c01020b1:	6a 00                	push   $0x0
  pushl $40
c01020b3:	6a 28                	push   $0x28
  jmp __alltraps
c01020b5:	e9 0f 09 00 00       	jmp    c01029c9 <__alltraps>

c01020ba <vector41>:
.globl vector41
vector41:
  pushl $0
c01020ba:	6a 00                	push   $0x0
  pushl $41
c01020bc:	6a 29                	push   $0x29
  jmp __alltraps
c01020be:	e9 06 09 00 00       	jmp    c01029c9 <__alltraps>

c01020c3 <vector42>:
.globl vector42
vector42:
  pushl $0
c01020c3:	6a 00                	push   $0x0
  pushl $42
c01020c5:	6a 2a                	push   $0x2a
  jmp __alltraps
c01020c7:	e9 fd 08 00 00       	jmp    c01029c9 <__alltraps>

c01020cc <vector43>:
.globl vector43
vector43:
  pushl $0
c01020cc:	6a 00                	push   $0x0
  pushl $43
c01020ce:	6a 2b                	push   $0x2b
  jmp __alltraps
c01020d0:	e9 f4 08 00 00       	jmp    c01029c9 <__alltraps>

c01020d5 <vector44>:
.globl vector44
vector44:
  pushl $0
c01020d5:	6a 00                	push   $0x0
  pushl $44
c01020d7:	6a 2c                	push   $0x2c
  jmp __alltraps
c01020d9:	e9 eb 08 00 00       	jmp    c01029c9 <__alltraps>

c01020de <vector45>:
.globl vector45
vector45:
  pushl $0
c01020de:	6a 00                	push   $0x0
  pushl $45
c01020e0:	6a 2d                	push   $0x2d
  jmp __alltraps
c01020e2:	e9 e2 08 00 00       	jmp    c01029c9 <__alltraps>

c01020e7 <vector46>:
.globl vector46
vector46:
  pushl $0
c01020e7:	6a 00                	push   $0x0
  pushl $46
c01020e9:	6a 2e                	push   $0x2e
  jmp __alltraps
c01020eb:	e9 d9 08 00 00       	jmp    c01029c9 <__alltraps>

c01020f0 <vector47>:
.globl vector47
vector47:
  pushl $0
c01020f0:	6a 00                	push   $0x0
  pushl $47
c01020f2:	6a 2f                	push   $0x2f
  jmp __alltraps
c01020f4:	e9 d0 08 00 00       	jmp    c01029c9 <__alltraps>

c01020f9 <vector48>:
.globl vector48
vector48:
  pushl $0
c01020f9:	6a 00                	push   $0x0
  pushl $48
c01020fb:	6a 30                	push   $0x30
  jmp __alltraps
c01020fd:	e9 c7 08 00 00       	jmp    c01029c9 <__alltraps>

c0102102 <vector49>:
.globl vector49
vector49:
  pushl $0
c0102102:	6a 00                	push   $0x0
  pushl $49
c0102104:	6a 31                	push   $0x31
  jmp __alltraps
c0102106:	e9 be 08 00 00       	jmp    c01029c9 <__alltraps>

c010210b <vector50>:
.globl vector50
vector50:
  pushl $0
c010210b:	6a 00                	push   $0x0
  pushl $50
c010210d:	6a 32                	push   $0x32
  jmp __alltraps
c010210f:	e9 b5 08 00 00       	jmp    c01029c9 <__alltraps>

c0102114 <vector51>:
.globl vector51
vector51:
  pushl $0
c0102114:	6a 00                	push   $0x0
  pushl $51
c0102116:	6a 33                	push   $0x33
  jmp __alltraps
c0102118:	e9 ac 08 00 00       	jmp    c01029c9 <__alltraps>

c010211d <vector52>:
.globl vector52
vector52:
  pushl $0
c010211d:	6a 00                	push   $0x0
  pushl $52
c010211f:	6a 34                	push   $0x34
  jmp __alltraps
c0102121:	e9 a3 08 00 00       	jmp    c01029c9 <__alltraps>

c0102126 <vector53>:
.globl vector53
vector53:
  pushl $0
c0102126:	6a 00                	push   $0x0
  pushl $53
c0102128:	6a 35                	push   $0x35
  jmp __alltraps
c010212a:	e9 9a 08 00 00       	jmp    c01029c9 <__alltraps>

c010212f <vector54>:
.globl vector54
vector54:
  pushl $0
c010212f:	6a 00                	push   $0x0
  pushl $54
c0102131:	6a 36                	push   $0x36
  jmp __alltraps
c0102133:	e9 91 08 00 00       	jmp    c01029c9 <__alltraps>

c0102138 <vector55>:
.globl vector55
vector55:
  pushl $0
c0102138:	6a 00                	push   $0x0
  pushl $55
c010213a:	6a 37                	push   $0x37
  jmp __alltraps
c010213c:	e9 88 08 00 00       	jmp    c01029c9 <__alltraps>

c0102141 <vector56>:
.globl vector56
vector56:
  pushl $0
c0102141:	6a 00                	push   $0x0
  pushl $56
c0102143:	6a 38                	push   $0x38
  jmp __alltraps
c0102145:	e9 7f 08 00 00       	jmp    c01029c9 <__alltraps>

c010214a <vector57>:
.globl vector57
vector57:
  pushl $0
c010214a:	6a 00                	push   $0x0
  pushl $57
c010214c:	6a 39                	push   $0x39
  jmp __alltraps
c010214e:	e9 76 08 00 00       	jmp    c01029c9 <__alltraps>

c0102153 <vector58>:
.globl vector58
vector58:
  pushl $0
c0102153:	6a 00                	push   $0x0
  pushl $58
c0102155:	6a 3a                	push   $0x3a
  jmp __alltraps
c0102157:	e9 6d 08 00 00       	jmp    c01029c9 <__alltraps>

c010215c <vector59>:
.globl vector59
vector59:
  pushl $0
c010215c:	6a 00                	push   $0x0
  pushl $59
c010215e:	6a 3b                	push   $0x3b
  jmp __alltraps
c0102160:	e9 64 08 00 00       	jmp    c01029c9 <__alltraps>

c0102165 <vector60>:
.globl vector60
vector60:
  pushl $0
c0102165:	6a 00                	push   $0x0
  pushl $60
c0102167:	6a 3c                	push   $0x3c
  jmp __alltraps
c0102169:	e9 5b 08 00 00       	jmp    c01029c9 <__alltraps>

c010216e <vector61>:
.globl vector61
vector61:
  pushl $0
c010216e:	6a 00                	push   $0x0
  pushl $61
c0102170:	6a 3d                	push   $0x3d
  jmp __alltraps
c0102172:	e9 52 08 00 00       	jmp    c01029c9 <__alltraps>

c0102177 <vector62>:
.globl vector62
vector62:
  pushl $0
c0102177:	6a 00                	push   $0x0
  pushl $62
c0102179:	6a 3e                	push   $0x3e
  jmp __alltraps
c010217b:	e9 49 08 00 00       	jmp    c01029c9 <__alltraps>

c0102180 <vector63>:
.globl vector63
vector63:
  pushl $0
c0102180:	6a 00                	push   $0x0
  pushl $63
c0102182:	6a 3f                	push   $0x3f
  jmp __alltraps
c0102184:	e9 40 08 00 00       	jmp    c01029c9 <__alltraps>

c0102189 <vector64>:
.globl vector64
vector64:
  pushl $0
c0102189:	6a 00                	push   $0x0
  pushl $64
c010218b:	6a 40                	push   $0x40
  jmp __alltraps
c010218d:	e9 37 08 00 00       	jmp    c01029c9 <__alltraps>

c0102192 <vector65>:
.globl vector65
vector65:
  pushl $0
c0102192:	6a 00                	push   $0x0
  pushl $65
c0102194:	6a 41                	push   $0x41
  jmp __alltraps
c0102196:	e9 2e 08 00 00       	jmp    c01029c9 <__alltraps>

c010219b <vector66>:
.globl vector66
vector66:
  pushl $0
c010219b:	6a 00                	push   $0x0
  pushl $66
c010219d:	6a 42                	push   $0x42
  jmp __alltraps
c010219f:	e9 25 08 00 00       	jmp    c01029c9 <__alltraps>

c01021a4 <vector67>:
.globl vector67
vector67:
  pushl $0
c01021a4:	6a 00                	push   $0x0
  pushl $67
c01021a6:	6a 43                	push   $0x43
  jmp __alltraps
c01021a8:	e9 1c 08 00 00       	jmp    c01029c9 <__alltraps>

c01021ad <vector68>:
.globl vector68
vector68:
  pushl $0
c01021ad:	6a 00                	push   $0x0
  pushl $68
c01021af:	6a 44                	push   $0x44
  jmp __alltraps
c01021b1:	e9 13 08 00 00       	jmp    c01029c9 <__alltraps>

c01021b6 <vector69>:
.globl vector69
vector69:
  pushl $0
c01021b6:	6a 00                	push   $0x0
  pushl $69
c01021b8:	6a 45                	push   $0x45
  jmp __alltraps
c01021ba:	e9 0a 08 00 00       	jmp    c01029c9 <__alltraps>

c01021bf <vector70>:
.globl vector70
vector70:
  pushl $0
c01021bf:	6a 00                	push   $0x0
  pushl $70
c01021c1:	6a 46                	push   $0x46
  jmp __alltraps
c01021c3:	e9 01 08 00 00       	jmp    c01029c9 <__alltraps>

c01021c8 <vector71>:
.globl vector71
vector71:
  pushl $0
c01021c8:	6a 00                	push   $0x0
  pushl $71
c01021ca:	6a 47                	push   $0x47
  jmp __alltraps
c01021cc:	e9 f8 07 00 00       	jmp    c01029c9 <__alltraps>

c01021d1 <vector72>:
.globl vector72
vector72:
  pushl $0
c01021d1:	6a 00                	push   $0x0
  pushl $72
c01021d3:	6a 48                	push   $0x48
  jmp __alltraps
c01021d5:	e9 ef 07 00 00       	jmp    c01029c9 <__alltraps>

c01021da <vector73>:
.globl vector73
vector73:
  pushl $0
c01021da:	6a 00                	push   $0x0
  pushl $73
c01021dc:	6a 49                	push   $0x49
  jmp __alltraps
c01021de:	e9 e6 07 00 00       	jmp    c01029c9 <__alltraps>

c01021e3 <vector74>:
.globl vector74
vector74:
  pushl $0
c01021e3:	6a 00                	push   $0x0
  pushl $74
c01021e5:	6a 4a                	push   $0x4a
  jmp __alltraps
c01021e7:	e9 dd 07 00 00       	jmp    c01029c9 <__alltraps>

c01021ec <vector75>:
.globl vector75
vector75:
  pushl $0
c01021ec:	6a 00                	push   $0x0
  pushl $75
c01021ee:	6a 4b                	push   $0x4b
  jmp __alltraps
c01021f0:	e9 d4 07 00 00       	jmp    c01029c9 <__alltraps>

c01021f5 <vector76>:
.globl vector76
vector76:
  pushl $0
c01021f5:	6a 00                	push   $0x0
  pushl $76
c01021f7:	6a 4c                	push   $0x4c
  jmp __alltraps
c01021f9:	e9 cb 07 00 00       	jmp    c01029c9 <__alltraps>

c01021fe <vector77>:
.globl vector77
vector77:
  pushl $0
c01021fe:	6a 00                	push   $0x0
  pushl $77
c0102200:	6a 4d                	push   $0x4d
  jmp __alltraps
c0102202:	e9 c2 07 00 00       	jmp    c01029c9 <__alltraps>

c0102207 <vector78>:
.globl vector78
vector78:
  pushl $0
c0102207:	6a 00                	push   $0x0
  pushl $78
c0102209:	6a 4e                	push   $0x4e
  jmp __alltraps
c010220b:	e9 b9 07 00 00       	jmp    c01029c9 <__alltraps>

c0102210 <vector79>:
.globl vector79
vector79:
  pushl $0
c0102210:	6a 00                	push   $0x0
  pushl $79
c0102212:	6a 4f                	push   $0x4f
  jmp __alltraps
c0102214:	e9 b0 07 00 00       	jmp    c01029c9 <__alltraps>

c0102219 <vector80>:
.globl vector80
vector80:
  pushl $0
c0102219:	6a 00                	push   $0x0
  pushl $80
c010221b:	6a 50                	push   $0x50
  jmp __alltraps
c010221d:	e9 a7 07 00 00       	jmp    c01029c9 <__alltraps>

c0102222 <vector81>:
.globl vector81
vector81:
  pushl $0
c0102222:	6a 00                	push   $0x0
  pushl $81
c0102224:	6a 51                	push   $0x51
  jmp __alltraps
c0102226:	e9 9e 07 00 00       	jmp    c01029c9 <__alltraps>

c010222b <vector82>:
.globl vector82
vector82:
  pushl $0
c010222b:	6a 00                	push   $0x0
  pushl $82
c010222d:	6a 52                	push   $0x52
  jmp __alltraps
c010222f:	e9 95 07 00 00       	jmp    c01029c9 <__alltraps>

c0102234 <vector83>:
.globl vector83
vector83:
  pushl $0
c0102234:	6a 00                	push   $0x0
  pushl $83
c0102236:	6a 53                	push   $0x53
  jmp __alltraps
c0102238:	e9 8c 07 00 00       	jmp    c01029c9 <__alltraps>

c010223d <vector84>:
.globl vector84
vector84:
  pushl $0
c010223d:	6a 00                	push   $0x0
  pushl $84
c010223f:	6a 54                	push   $0x54
  jmp __alltraps
c0102241:	e9 83 07 00 00       	jmp    c01029c9 <__alltraps>

c0102246 <vector85>:
.globl vector85
vector85:
  pushl $0
c0102246:	6a 00                	push   $0x0
  pushl $85
c0102248:	6a 55                	push   $0x55
  jmp __alltraps
c010224a:	e9 7a 07 00 00       	jmp    c01029c9 <__alltraps>

c010224f <vector86>:
.globl vector86
vector86:
  pushl $0
c010224f:	6a 00                	push   $0x0
  pushl $86
c0102251:	6a 56                	push   $0x56
  jmp __alltraps
c0102253:	e9 71 07 00 00       	jmp    c01029c9 <__alltraps>

c0102258 <vector87>:
.globl vector87
vector87:
  pushl $0
c0102258:	6a 00                	push   $0x0
  pushl $87
c010225a:	6a 57                	push   $0x57
  jmp __alltraps
c010225c:	e9 68 07 00 00       	jmp    c01029c9 <__alltraps>

c0102261 <vector88>:
.globl vector88
vector88:
  pushl $0
c0102261:	6a 00                	push   $0x0
  pushl $88
c0102263:	6a 58                	push   $0x58
  jmp __alltraps
c0102265:	e9 5f 07 00 00       	jmp    c01029c9 <__alltraps>

c010226a <vector89>:
.globl vector89
vector89:
  pushl $0
c010226a:	6a 00                	push   $0x0
  pushl $89
c010226c:	6a 59                	push   $0x59
  jmp __alltraps
c010226e:	e9 56 07 00 00       	jmp    c01029c9 <__alltraps>

c0102273 <vector90>:
.globl vector90
vector90:
  pushl $0
c0102273:	6a 00                	push   $0x0
  pushl $90
c0102275:	6a 5a                	push   $0x5a
  jmp __alltraps
c0102277:	e9 4d 07 00 00       	jmp    c01029c9 <__alltraps>

c010227c <vector91>:
.globl vector91
vector91:
  pushl $0
c010227c:	6a 00                	push   $0x0
  pushl $91
c010227e:	6a 5b                	push   $0x5b
  jmp __alltraps
c0102280:	e9 44 07 00 00       	jmp    c01029c9 <__alltraps>

c0102285 <vector92>:
.globl vector92
vector92:
  pushl $0
c0102285:	6a 00                	push   $0x0
  pushl $92
c0102287:	6a 5c                	push   $0x5c
  jmp __alltraps
c0102289:	e9 3b 07 00 00       	jmp    c01029c9 <__alltraps>

c010228e <vector93>:
.globl vector93
vector93:
  pushl $0
c010228e:	6a 00                	push   $0x0
  pushl $93
c0102290:	6a 5d                	push   $0x5d
  jmp __alltraps
c0102292:	e9 32 07 00 00       	jmp    c01029c9 <__alltraps>

c0102297 <vector94>:
.globl vector94
vector94:
  pushl $0
c0102297:	6a 00                	push   $0x0
  pushl $94
c0102299:	6a 5e                	push   $0x5e
  jmp __alltraps
c010229b:	e9 29 07 00 00       	jmp    c01029c9 <__alltraps>

c01022a0 <vector95>:
.globl vector95
vector95:
  pushl $0
c01022a0:	6a 00                	push   $0x0
  pushl $95
c01022a2:	6a 5f                	push   $0x5f
  jmp __alltraps
c01022a4:	e9 20 07 00 00       	jmp    c01029c9 <__alltraps>

c01022a9 <vector96>:
.globl vector96
vector96:
  pushl $0
c01022a9:	6a 00                	push   $0x0
  pushl $96
c01022ab:	6a 60                	push   $0x60
  jmp __alltraps
c01022ad:	e9 17 07 00 00       	jmp    c01029c9 <__alltraps>

c01022b2 <vector97>:
.globl vector97
vector97:
  pushl $0
c01022b2:	6a 00                	push   $0x0
  pushl $97
c01022b4:	6a 61                	push   $0x61
  jmp __alltraps
c01022b6:	e9 0e 07 00 00       	jmp    c01029c9 <__alltraps>

c01022bb <vector98>:
.globl vector98
vector98:
  pushl $0
c01022bb:	6a 00                	push   $0x0
  pushl $98
c01022bd:	6a 62                	push   $0x62
  jmp __alltraps
c01022bf:	e9 05 07 00 00       	jmp    c01029c9 <__alltraps>

c01022c4 <vector99>:
.globl vector99
vector99:
  pushl $0
c01022c4:	6a 00                	push   $0x0
  pushl $99
c01022c6:	6a 63                	push   $0x63
  jmp __alltraps
c01022c8:	e9 fc 06 00 00       	jmp    c01029c9 <__alltraps>

c01022cd <vector100>:
.globl vector100
vector100:
  pushl $0
c01022cd:	6a 00                	push   $0x0
  pushl $100
c01022cf:	6a 64                	push   $0x64
  jmp __alltraps
c01022d1:	e9 f3 06 00 00       	jmp    c01029c9 <__alltraps>

c01022d6 <vector101>:
.globl vector101
vector101:
  pushl $0
c01022d6:	6a 00                	push   $0x0
  pushl $101
c01022d8:	6a 65                	push   $0x65
  jmp __alltraps
c01022da:	e9 ea 06 00 00       	jmp    c01029c9 <__alltraps>

c01022df <vector102>:
.globl vector102
vector102:
  pushl $0
c01022df:	6a 00                	push   $0x0
  pushl $102
c01022e1:	6a 66                	push   $0x66
  jmp __alltraps
c01022e3:	e9 e1 06 00 00       	jmp    c01029c9 <__alltraps>

c01022e8 <vector103>:
.globl vector103
vector103:
  pushl $0
c01022e8:	6a 00                	push   $0x0
  pushl $103
c01022ea:	6a 67                	push   $0x67
  jmp __alltraps
c01022ec:	e9 d8 06 00 00       	jmp    c01029c9 <__alltraps>

c01022f1 <vector104>:
.globl vector104
vector104:
  pushl $0
c01022f1:	6a 00                	push   $0x0
  pushl $104
c01022f3:	6a 68                	push   $0x68
  jmp __alltraps
c01022f5:	e9 cf 06 00 00       	jmp    c01029c9 <__alltraps>

c01022fa <vector105>:
.globl vector105
vector105:
  pushl $0
c01022fa:	6a 00                	push   $0x0
  pushl $105
c01022fc:	6a 69                	push   $0x69
  jmp __alltraps
c01022fe:	e9 c6 06 00 00       	jmp    c01029c9 <__alltraps>

c0102303 <vector106>:
.globl vector106
vector106:
  pushl $0
c0102303:	6a 00                	push   $0x0
  pushl $106
c0102305:	6a 6a                	push   $0x6a
  jmp __alltraps
c0102307:	e9 bd 06 00 00       	jmp    c01029c9 <__alltraps>

c010230c <vector107>:
.globl vector107
vector107:
  pushl $0
c010230c:	6a 00                	push   $0x0
  pushl $107
c010230e:	6a 6b                	push   $0x6b
  jmp __alltraps
c0102310:	e9 b4 06 00 00       	jmp    c01029c9 <__alltraps>

c0102315 <vector108>:
.globl vector108
vector108:
  pushl $0
c0102315:	6a 00                	push   $0x0
  pushl $108
c0102317:	6a 6c                	push   $0x6c
  jmp __alltraps
c0102319:	e9 ab 06 00 00       	jmp    c01029c9 <__alltraps>

c010231e <vector109>:
.globl vector109
vector109:
  pushl $0
c010231e:	6a 00                	push   $0x0
  pushl $109
c0102320:	6a 6d                	push   $0x6d
  jmp __alltraps
c0102322:	e9 a2 06 00 00       	jmp    c01029c9 <__alltraps>

c0102327 <vector110>:
.globl vector110
vector110:
  pushl $0
c0102327:	6a 00                	push   $0x0
  pushl $110
c0102329:	6a 6e                	push   $0x6e
  jmp __alltraps
c010232b:	e9 99 06 00 00       	jmp    c01029c9 <__alltraps>

c0102330 <vector111>:
.globl vector111
vector111:
  pushl $0
c0102330:	6a 00                	push   $0x0
  pushl $111
c0102332:	6a 6f                	push   $0x6f
  jmp __alltraps
c0102334:	e9 90 06 00 00       	jmp    c01029c9 <__alltraps>

c0102339 <vector112>:
.globl vector112
vector112:
  pushl $0
c0102339:	6a 00                	push   $0x0
  pushl $112
c010233b:	6a 70                	push   $0x70
  jmp __alltraps
c010233d:	e9 87 06 00 00       	jmp    c01029c9 <__alltraps>

c0102342 <vector113>:
.globl vector113
vector113:
  pushl $0
c0102342:	6a 00                	push   $0x0
  pushl $113
c0102344:	6a 71                	push   $0x71
  jmp __alltraps
c0102346:	e9 7e 06 00 00       	jmp    c01029c9 <__alltraps>

c010234b <vector114>:
.globl vector114
vector114:
  pushl $0
c010234b:	6a 00                	push   $0x0
  pushl $114
c010234d:	6a 72                	push   $0x72
  jmp __alltraps
c010234f:	e9 75 06 00 00       	jmp    c01029c9 <__alltraps>

c0102354 <vector115>:
.globl vector115
vector115:
  pushl $0
c0102354:	6a 00                	push   $0x0
  pushl $115
c0102356:	6a 73                	push   $0x73
  jmp __alltraps
c0102358:	e9 6c 06 00 00       	jmp    c01029c9 <__alltraps>

c010235d <vector116>:
.globl vector116
vector116:
  pushl $0
c010235d:	6a 00                	push   $0x0
  pushl $116
c010235f:	6a 74                	push   $0x74
  jmp __alltraps
c0102361:	e9 63 06 00 00       	jmp    c01029c9 <__alltraps>

c0102366 <vector117>:
.globl vector117
vector117:
  pushl $0
c0102366:	6a 00                	push   $0x0
  pushl $117
c0102368:	6a 75                	push   $0x75
  jmp __alltraps
c010236a:	e9 5a 06 00 00       	jmp    c01029c9 <__alltraps>

c010236f <vector118>:
.globl vector118
vector118:
  pushl $0
c010236f:	6a 00                	push   $0x0
  pushl $118
c0102371:	6a 76                	push   $0x76
  jmp __alltraps
c0102373:	e9 51 06 00 00       	jmp    c01029c9 <__alltraps>

c0102378 <vector119>:
.globl vector119
vector119:
  pushl $0
c0102378:	6a 00                	push   $0x0
  pushl $119
c010237a:	6a 77                	push   $0x77
  jmp __alltraps
c010237c:	e9 48 06 00 00       	jmp    c01029c9 <__alltraps>

c0102381 <vector120>:
.globl vector120
vector120:
  pushl $0
c0102381:	6a 00                	push   $0x0
  pushl $120
c0102383:	6a 78                	push   $0x78
  jmp __alltraps
c0102385:	e9 3f 06 00 00       	jmp    c01029c9 <__alltraps>

c010238a <vector121>:
.globl vector121
vector121:
  pushl $0
c010238a:	6a 00                	push   $0x0
  pushl $121
c010238c:	6a 79                	push   $0x79
  jmp __alltraps
c010238e:	e9 36 06 00 00       	jmp    c01029c9 <__alltraps>

c0102393 <vector122>:
.globl vector122
vector122:
  pushl $0
c0102393:	6a 00                	push   $0x0
  pushl $122
c0102395:	6a 7a                	push   $0x7a
  jmp __alltraps
c0102397:	e9 2d 06 00 00       	jmp    c01029c9 <__alltraps>

c010239c <vector123>:
.globl vector123
vector123:
  pushl $0
c010239c:	6a 00                	push   $0x0
  pushl $123
c010239e:	6a 7b                	push   $0x7b
  jmp __alltraps
c01023a0:	e9 24 06 00 00       	jmp    c01029c9 <__alltraps>

c01023a5 <vector124>:
.globl vector124
vector124:
  pushl $0
c01023a5:	6a 00                	push   $0x0
  pushl $124
c01023a7:	6a 7c                	push   $0x7c
  jmp __alltraps
c01023a9:	e9 1b 06 00 00       	jmp    c01029c9 <__alltraps>

c01023ae <vector125>:
.globl vector125
vector125:
  pushl $0
c01023ae:	6a 00                	push   $0x0
  pushl $125
c01023b0:	6a 7d                	push   $0x7d
  jmp __alltraps
c01023b2:	e9 12 06 00 00       	jmp    c01029c9 <__alltraps>

c01023b7 <vector126>:
.globl vector126
vector126:
  pushl $0
c01023b7:	6a 00                	push   $0x0
  pushl $126
c01023b9:	6a 7e                	push   $0x7e
  jmp __alltraps
c01023bb:	e9 09 06 00 00       	jmp    c01029c9 <__alltraps>

c01023c0 <vector127>:
.globl vector127
vector127:
  pushl $0
c01023c0:	6a 00                	push   $0x0
  pushl $127
c01023c2:	6a 7f                	push   $0x7f
  jmp __alltraps
c01023c4:	e9 00 06 00 00       	jmp    c01029c9 <__alltraps>

c01023c9 <vector128>:
.globl vector128
vector128:
  pushl $0
c01023c9:	6a 00                	push   $0x0
  pushl $128
c01023cb:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
c01023d0:	e9 f4 05 00 00       	jmp    c01029c9 <__alltraps>

c01023d5 <vector129>:
.globl vector129
vector129:
  pushl $0
c01023d5:	6a 00                	push   $0x0
  pushl $129
c01023d7:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
c01023dc:	e9 e8 05 00 00       	jmp    c01029c9 <__alltraps>

c01023e1 <vector130>:
.globl vector130
vector130:
  pushl $0
c01023e1:	6a 00                	push   $0x0
  pushl $130
c01023e3:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
c01023e8:	e9 dc 05 00 00       	jmp    c01029c9 <__alltraps>

c01023ed <vector131>:
.globl vector131
vector131:
  pushl $0
c01023ed:	6a 00                	push   $0x0
  pushl $131
c01023ef:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
c01023f4:	e9 d0 05 00 00       	jmp    c01029c9 <__alltraps>

c01023f9 <vector132>:
.globl vector132
vector132:
  pushl $0
c01023f9:	6a 00                	push   $0x0
  pushl $132
c01023fb:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
c0102400:	e9 c4 05 00 00       	jmp    c01029c9 <__alltraps>

c0102405 <vector133>:
.globl vector133
vector133:
  pushl $0
c0102405:	6a 00                	push   $0x0
  pushl $133
c0102407:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
c010240c:	e9 b8 05 00 00       	jmp    c01029c9 <__alltraps>

c0102411 <vector134>:
.globl vector134
vector134:
  pushl $0
c0102411:	6a 00                	push   $0x0
  pushl $134
c0102413:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
c0102418:	e9 ac 05 00 00       	jmp    c01029c9 <__alltraps>

c010241d <vector135>:
.globl vector135
vector135:
  pushl $0
c010241d:	6a 00                	push   $0x0
  pushl $135
c010241f:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
c0102424:	e9 a0 05 00 00       	jmp    c01029c9 <__alltraps>

c0102429 <vector136>:
.globl vector136
vector136:
  pushl $0
c0102429:	6a 00                	push   $0x0
  pushl $136
c010242b:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
c0102430:	e9 94 05 00 00       	jmp    c01029c9 <__alltraps>

c0102435 <vector137>:
.globl vector137
vector137:
  pushl $0
c0102435:	6a 00                	push   $0x0
  pushl $137
c0102437:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
c010243c:	e9 88 05 00 00       	jmp    c01029c9 <__alltraps>

c0102441 <vector138>:
.globl vector138
vector138:
  pushl $0
c0102441:	6a 00                	push   $0x0
  pushl $138
c0102443:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
c0102448:	e9 7c 05 00 00       	jmp    c01029c9 <__alltraps>

c010244d <vector139>:
.globl vector139
vector139:
  pushl $0
c010244d:	6a 00                	push   $0x0
  pushl $139
c010244f:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
c0102454:	e9 70 05 00 00       	jmp    c01029c9 <__alltraps>

c0102459 <vector140>:
.globl vector140
vector140:
  pushl $0
c0102459:	6a 00                	push   $0x0
  pushl $140
c010245b:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
c0102460:	e9 64 05 00 00       	jmp    c01029c9 <__alltraps>

c0102465 <vector141>:
.globl vector141
vector141:
  pushl $0
c0102465:	6a 00                	push   $0x0
  pushl $141
c0102467:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
c010246c:	e9 58 05 00 00       	jmp    c01029c9 <__alltraps>

c0102471 <vector142>:
.globl vector142
vector142:
  pushl $0
c0102471:	6a 00                	push   $0x0
  pushl $142
c0102473:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
c0102478:	e9 4c 05 00 00       	jmp    c01029c9 <__alltraps>

c010247d <vector143>:
.globl vector143
vector143:
  pushl $0
c010247d:	6a 00                	push   $0x0
  pushl $143
c010247f:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
c0102484:	e9 40 05 00 00       	jmp    c01029c9 <__alltraps>

c0102489 <vector144>:
.globl vector144
vector144:
  pushl $0
c0102489:	6a 00                	push   $0x0
  pushl $144
c010248b:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
c0102490:	e9 34 05 00 00       	jmp    c01029c9 <__alltraps>

c0102495 <vector145>:
.globl vector145
vector145:
  pushl $0
c0102495:	6a 00                	push   $0x0
  pushl $145
c0102497:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
c010249c:	e9 28 05 00 00       	jmp    c01029c9 <__alltraps>

c01024a1 <vector146>:
.globl vector146
vector146:
  pushl $0
c01024a1:	6a 00                	push   $0x0
  pushl $146
c01024a3:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
c01024a8:	e9 1c 05 00 00       	jmp    c01029c9 <__alltraps>

c01024ad <vector147>:
.globl vector147
vector147:
  pushl $0
c01024ad:	6a 00                	push   $0x0
  pushl $147
c01024af:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
c01024b4:	e9 10 05 00 00       	jmp    c01029c9 <__alltraps>

c01024b9 <vector148>:
.globl vector148
vector148:
  pushl $0
c01024b9:	6a 00                	push   $0x0
  pushl $148
c01024bb:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
c01024c0:	e9 04 05 00 00       	jmp    c01029c9 <__alltraps>

c01024c5 <vector149>:
.globl vector149
vector149:
  pushl $0
c01024c5:	6a 00                	push   $0x0
  pushl $149
c01024c7:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
c01024cc:	e9 f8 04 00 00       	jmp    c01029c9 <__alltraps>

c01024d1 <vector150>:
.globl vector150
vector150:
  pushl $0
c01024d1:	6a 00                	push   $0x0
  pushl $150
c01024d3:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
c01024d8:	e9 ec 04 00 00       	jmp    c01029c9 <__alltraps>

c01024dd <vector151>:
.globl vector151
vector151:
  pushl $0
c01024dd:	6a 00                	push   $0x0
  pushl $151
c01024df:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
c01024e4:	e9 e0 04 00 00       	jmp    c01029c9 <__alltraps>

c01024e9 <vector152>:
.globl vector152
vector152:
  pushl $0
c01024e9:	6a 00                	push   $0x0
  pushl $152
c01024eb:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
c01024f0:	e9 d4 04 00 00       	jmp    c01029c9 <__alltraps>

c01024f5 <vector153>:
.globl vector153
vector153:
  pushl $0
c01024f5:	6a 00                	push   $0x0
  pushl $153
c01024f7:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
c01024fc:	e9 c8 04 00 00       	jmp    c01029c9 <__alltraps>

c0102501 <vector154>:
.globl vector154
vector154:
  pushl $0
c0102501:	6a 00                	push   $0x0
  pushl $154
c0102503:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
c0102508:	e9 bc 04 00 00       	jmp    c01029c9 <__alltraps>

c010250d <vector155>:
.globl vector155
vector155:
  pushl $0
c010250d:	6a 00                	push   $0x0
  pushl $155
c010250f:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
c0102514:	e9 b0 04 00 00       	jmp    c01029c9 <__alltraps>

c0102519 <vector156>:
.globl vector156
vector156:
  pushl $0
c0102519:	6a 00                	push   $0x0
  pushl $156
c010251b:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
c0102520:	e9 a4 04 00 00       	jmp    c01029c9 <__alltraps>

c0102525 <vector157>:
.globl vector157
vector157:
  pushl $0
c0102525:	6a 00                	push   $0x0
  pushl $157
c0102527:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
c010252c:	e9 98 04 00 00       	jmp    c01029c9 <__alltraps>

c0102531 <vector158>:
.globl vector158
vector158:
  pushl $0
c0102531:	6a 00                	push   $0x0
  pushl $158
c0102533:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
c0102538:	e9 8c 04 00 00       	jmp    c01029c9 <__alltraps>

c010253d <vector159>:
.globl vector159
vector159:
  pushl $0
c010253d:	6a 00                	push   $0x0
  pushl $159
c010253f:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
c0102544:	e9 80 04 00 00       	jmp    c01029c9 <__alltraps>

c0102549 <vector160>:
.globl vector160
vector160:
  pushl $0
c0102549:	6a 00                	push   $0x0
  pushl $160
c010254b:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
c0102550:	e9 74 04 00 00       	jmp    c01029c9 <__alltraps>

c0102555 <vector161>:
.globl vector161
vector161:
  pushl $0
c0102555:	6a 00                	push   $0x0
  pushl $161
c0102557:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
c010255c:	e9 68 04 00 00       	jmp    c01029c9 <__alltraps>

c0102561 <vector162>:
.globl vector162
vector162:
  pushl $0
c0102561:	6a 00                	push   $0x0
  pushl $162
c0102563:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
c0102568:	e9 5c 04 00 00       	jmp    c01029c9 <__alltraps>

c010256d <vector163>:
.globl vector163
vector163:
  pushl $0
c010256d:	6a 00                	push   $0x0
  pushl $163
c010256f:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
c0102574:	e9 50 04 00 00       	jmp    c01029c9 <__alltraps>

c0102579 <vector164>:
.globl vector164
vector164:
  pushl $0
c0102579:	6a 00                	push   $0x0
  pushl $164
c010257b:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
c0102580:	e9 44 04 00 00       	jmp    c01029c9 <__alltraps>

c0102585 <vector165>:
.globl vector165
vector165:
  pushl $0
c0102585:	6a 00                	push   $0x0
  pushl $165
c0102587:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
c010258c:	e9 38 04 00 00       	jmp    c01029c9 <__alltraps>

c0102591 <vector166>:
.globl vector166
vector166:
  pushl $0
c0102591:	6a 00                	push   $0x0
  pushl $166
c0102593:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
c0102598:	e9 2c 04 00 00       	jmp    c01029c9 <__alltraps>

c010259d <vector167>:
.globl vector167
vector167:
  pushl $0
c010259d:	6a 00                	push   $0x0
  pushl $167
c010259f:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
c01025a4:	e9 20 04 00 00       	jmp    c01029c9 <__alltraps>

c01025a9 <vector168>:
.globl vector168
vector168:
  pushl $0
c01025a9:	6a 00                	push   $0x0
  pushl $168
c01025ab:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
c01025b0:	e9 14 04 00 00       	jmp    c01029c9 <__alltraps>

c01025b5 <vector169>:
.globl vector169
vector169:
  pushl $0
c01025b5:	6a 00                	push   $0x0
  pushl $169
c01025b7:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
c01025bc:	e9 08 04 00 00       	jmp    c01029c9 <__alltraps>

c01025c1 <vector170>:
.globl vector170
vector170:
  pushl $0
c01025c1:	6a 00                	push   $0x0
  pushl $170
c01025c3:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
c01025c8:	e9 fc 03 00 00       	jmp    c01029c9 <__alltraps>

c01025cd <vector171>:
.globl vector171
vector171:
  pushl $0
c01025cd:	6a 00                	push   $0x0
  pushl $171
c01025cf:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
c01025d4:	e9 f0 03 00 00       	jmp    c01029c9 <__alltraps>

c01025d9 <vector172>:
.globl vector172
vector172:
  pushl $0
c01025d9:	6a 00                	push   $0x0
  pushl $172
c01025db:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
c01025e0:	e9 e4 03 00 00       	jmp    c01029c9 <__alltraps>

c01025e5 <vector173>:
.globl vector173
vector173:
  pushl $0
c01025e5:	6a 00                	push   $0x0
  pushl $173
c01025e7:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
c01025ec:	e9 d8 03 00 00       	jmp    c01029c9 <__alltraps>

c01025f1 <vector174>:
.globl vector174
vector174:
  pushl $0
c01025f1:	6a 00                	push   $0x0
  pushl $174
c01025f3:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
c01025f8:	e9 cc 03 00 00       	jmp    c01029c9 <__alltraps>

c01025fd <vector175>:
.globl vector175
vector175:
  pushl $0
c01025fd:	6a 00                	push   $0x0
  pushl $175
c01025ff:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
c0102604:	e9 c0 03 00 00       	jmp    c01029c9 <__alltraps>

c0102609 <vector176>:
.globl vector176
vector176:
  pushl $0
c0102609:	6a 00                	push   $0x0
  pushl $176
c010260b:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
c0102610:	e9 b4 03 00 00       	jmp    c01029c9 <__alltraps>

c0102615 <vector177>:
.globl vector177
vector177:
  pushl $0
c0102615:	6a 00                	push   $0x0
  pushl $177
c0102617:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
c010261c:	e9 a8 03 00 00       	jmp    c01029c9 <__alltraps>

c0102621 <vector178>:
.globl vector178
vector178:
  pushl $0
c0102621:	6a 00                	push   $0x0
  pushl $178
c0102623:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
c0102628:	e9 9c 03 00 00       	jmp    c01029c9 <__alltraps>

c010262d <vector179>:
.globl vector179
vector179:
  pushl $0
c010262d:	6a 00                	push   $0x0
  pushl $179
c010262f:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
c0102634:	e9 90 03 00 00       	jmp    c01029c9 <__alltraps>

c0102639 <vector180>:
.globl vector180
vector180:
  pushl $0
c0102639:	6a 00                	push   $0x0
  pushl $180
c010263b:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
c0102640:	e9 84 03 00 00       	jmp    c01029c9 <__alltraps>

c0102645 <vector181>:
.globl vector181
vector181:
  pushl $0
c0102645:	6a 00                	push   $0x0
  pushl $181
c0102647:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
c010264c:	e9 78 03 00 00       	jmp    c01029c9 <__alltraps>

c0102651 <vector182>:
.globl vector182
vector182:
  pushl $0
c0102651:	6a 00                	push   $0x0
  pushl $182
c0102653:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
c0102658:	e9 6c 03 00 00       	jmp    c01029c9 <__alltraps>

c010265d <vector183>:
.globl vector183
vector183:
  pushl $0
c010265d:	6a 00                	push   $0x0
  pushl $183
c010265f:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
c0102664:	e9 60 03 00 00       	jmp    c01029c9 <__alltraps>

c0102669 <vector184>:
.globl vector184
vector184:
  pushl $0
c0102669:	6a 00                	push   $0x0
  pushl $184
c010266b:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
c0102670:	e9 54 03 00 00       	jmp    c01029c9 <__alltraps>

c0102675 <vector185>:
.globl vector185
vector185:
  pushl $0
c0102675:	6a 00                	push   $0x0
  pushl $185
c0102677:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
c010267c:	e9 48 03 00 00       	jmp    c01029c9 <__alltraps>

c0102681 <vector186>:
.globl vector186
vector186:
  pushl $0
c0102681:	6a 00                	push   $0x0
  pushl $186
c0102683:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
c0102688:	e9 3c 03 00 00       	jmp    c01029c9 <__alltraps>

c010268d <vector187>:
.globl vector187
vector187:
  pushl $0
c010268d:	6a 00                	push   $0x0
  pushl $187
c010268f:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
c0102694:	e9 30 03 00 00       	jmp    c01029c9 <__alltraps>

c0102699 <vector188>:
.globl vector188
vector188:
  pushl $0
c0102699:	6a 00                	push   $0x0
  pushl $188
c010269b:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
c01026a0:	e9 24 03 00 00       	jmp    c01029c9 <__alltraps>

c01026a5 <vector189>:
.globl vector189
vector189:
  pushl $0
c01026a5:	6a 00                	push   $0x0
  pushl $189
c01026a7:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
c01026ac:	e9 18 03 00 00       	jmp    c01029c9 <__alltraps>

c01026b1 <vector190>:
.globl vector190
vector190:
  pushl $0
c01026b1:	6a 00                	push   $0x0
  pushl $190
c01026b3:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
c01026b8:	e9 0c 03 00 00       	jmp    c01029c9 <__alltraps>

c01026bd <vector191>:
.globl vector191
vector191:
  pushl $0
c01026bd:	6a 00                	push   $0x0
  pushl $191
c01026bf:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
c01026c4:	e9 00 03 00 00       	jmp    c01029c9 <__alltraps>

c01026c9 <vector192>:
.globl vector192
vector192:
  pushl $0
c01026c9:	6a 00                	push   $0x0
  pushl $192
c01026cb:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
c01026d0:	e9 f4 02 00 00       	jmp    c01029c9 <__alltraps>

c01026d5 <vector193>:
.globl vector193
vector193:
  pushl $0
c01026d5:	6a 00                	push   $0x0
  pushl $193
c01026d7:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
c01026dc:	e9 e8 02 00 00       	jmp    c01029c9 <__alltraps>

c01026e1 <vector194>:
.globl vector194
vector194:
  pushl $0
c01026e1:	6a 00                	push   $0x0
  pushl $194
c01026e3:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
c01026e8:	e9 dc 02 00 00       	jmp    c01029c9 <__alltraps>

c01026ed <vector195>:
.globl vector195
vector195:
  pushl $0
c01026ed:	6a 00                	push   $0x0
  pushl $195
c01026ef:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
c01026f4:	e9 d0 02 00 00       	jmp    c01029c9 <__alltraps>

c01026f9 <vector196>:
.globl vector196
vector196:
  pushl $0
c01026f9:	6a 00                	push   $0x0
  pushl $196
c01026fb:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
c0102700:	e9 c4 02 00 00       	jmp    c01029c9 <__alltraps>

c0102705 <vector197>:
.globl vector197
vector197:
  pushl $0
c0102705:	6a 00                	push   $0x0
  pushl $197
c0102707:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
c010270c:	e9 b8 02 00 00       	jmp    c01029c9 <__alltraps>

c0102711 <vector198>:
.globl vector198
vector198:
  pushl $0
c0102711:	6a 00                	push   $0x0
  pushl $198
c0102713:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
c0102718:	e9 ac 02 00 00       	jmp    c01029c9 <__alltraps>

c010271d <vector199>:
.globl vector199
vector199:
  pushl $0
c010271d:	6a 00                	push   $0x0
  pushl $199
c010271f:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
c0102724:	e9 a0 02 00 00       	jmp    c01029c9 <__alltraps>

c0102729 <vector200>:
.globl vector200
vector200:
  pushl $0
c0102729:	6a 00                	push   $0x0
  pushl $200
c010272b:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
c0102730:	e9 94 02 00 00       	jmp    c01029c9 <__alltraps>

c0102735 <vector201>:
.globl vector201
vector201:
  pushl $0
c0102735:	6a 00                	push   $0x0
  pushl $201
c0102737:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
c010273c:	e9 88 02 00 00       	jmp    c01029c9 <__alltraps>

c0102741 <vector202>:
.globl vector202
vector202:
  pushl $0
c0102741:	6a 00                	push   $0x0
  pushl $202
c0102743:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
c0102748:	e9 7c 02 00 00       	jmp    c01029c9 <__alltraps>

c010274d <vector203>:
.globl vector203
vector203:
  pushl $0
c010274d:	6a 00                	push   $0x0
  pushl $203
c010274f:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
c0102754:	e9 70 02 00 00       	jmp    c01029c9 <__alltraps>

c0102759 <vector204>:
.globl vector204
vector204:
  pushl $0
c0102759:	6a 00                	push   $0x0
  pushl $204
c010275b:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
c0102760:	e9 64 02 00 00       	jmp    c01029c9 <__alltraps>

c0102765 <vector205>:
.globl vector205
vector205:
  pushl $0
c0102765:	6a 00                	push   $0x0
  pushl $205
c0102767:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
c010276c:	e9 58 02 00 00       	jmp    c01029c9 <__alltraps>

c0102771 <vector206>:
.globl vector206
vector206:
  pushl $0
c0102771:	6a 00                	push   $0x0
  pushl $206
c0102773:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
c0102778:	e9 4c 02 00 00       	jmp    c01029c9 <__alltraps>

c010277d <vector207>:
.globl vector207
vector207:
  pushl $0
c010277d:	6a 00                	push   $0x0
  pushl $207
c010277f:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
c0102784:	e9 40 02 00 00       	jmp    c01029c9 <__alltraps>

c0102789 <vector208>:
.globl vector208
vector208:
  pushl $0
c0102789:	6a 00                	push   $0x0
  pushl $208
c010278b:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
c0102790:	e9 34 02 00 00       	jmp    c01029c9 <__alltraps>

c0102795 <vector209>:
.globl vector209
vector209:
  pushl $0
c0102795:	6a 00                	push   $0x0
  pushl $209
c0102797:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
c010279c:	e9 28 02 00 00       	jmp    c01029c9 <__alltraps>

c01027a1 <vector210>:
.globl vector210
vector210:
  pushl $0
c01027a1:	6a 00                	push   $0x0
  pushl $210
c01027a3:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
c01027a8:	e9 1c 02 00 00       	jmp    c01029c9 <__alltraps>

c01027ad <vector211>:
.globl vector211
vector211:
  pushl $0
c01027ad:	6a 00                	push   $0x0
  pushl $211
c01027af:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
c01027b4:	e9 10 02 00 00       	jmp    c01029c9 <__alltraps>

c01027b9 <vector212>:
.globl vector212
vector212:
  pushl $0
c01027b9:	6a 00                	push   $0x0
  pushl $212
c01027bb:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
c01027c0:	e9 04 02 00 00       	jmp    c01029c9 <__alltraps>

c01027c5 <vector213>:
.globl vector213
vector213:
  pushl $0
c01027c5:	6a 00                	push   $0x0
  pushl $213
c01027c7:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
c01027cc:	e9 f8 01 00 00       	jmp    c01029c9 <__alltraps>

c01027d1 <vector214>:
.globl vector214
vector214:
  pushl $0
c01027d1:	6a 00                	push   $0x0
  pushl $214
c01027d3:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
c01027d8:	e9 ec 01 00 00       	jmp    c01029c9 <__alltraps>

c01027dd <vector215>:
.globl vector215
vector215:
  pushl $0
c01027dd:	6a 00                	push   $0x0
  pushl $215
c01027df:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
c01027e4:	e9 e0 01 00 00       	jmp    c01029c9 <__alltraps>

c01027e9 <vector216>:
.globl vector216
vector216:
  pushl $0
c01027e9:	6a 00                	push   $0x0
  pushl $216
c01027eb:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
c01027f0:	e9 d4 01 00 00       	jmp    c01029c9 <__alltraps>

c01027f5 <vector217>:
.globl vector217
vector217:
  pushl $0
c01027f5:	6a 00                	push   $0x0
  pushl $217
c01027f7:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
c01027fc:	e9 c8 01 00 00       	jmp    c01029c9 <__alltraps>

c0102801 <vector218>:
.globl vector218
vector218:
  pushl $0
c0102801:	6a 00                	push   $0x0
  pushl $218
c0102803:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
c0102808:	e9 bc 01 00 00       	jmp    c01029c9 <__alltraps>

c010280d <vector219>:
.globl vector219
vector219:
  pushl $0
c010280d:	6a 00                	push   $0x0
  pushl $219
c010280f:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
c0102814:	e9 b0 01 00 00       	jmp    c01029c9 <__alltraps>

c0102819 <vector220>:
.globl vector220
vector220:
  pushl $0
c0102819:	6a 00                	push   $0x0
  pushl $220
c010281b:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
c0102820:	e9 a4 01 00 00       	jmp    c01029c9 <__alltraps>

c0102825 <vector221>:
.globl vector221
vector221:
  pushl $0
c0102825:	6a 00                	push   $0x0
  pushl $221
c0102827:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
c010282c:	e9 98 01 00 00       	jmp    c01029c9 <__alltraps>

c0102831 <vector222>:
.globl vector222
vector222:
  pushl $0
c0102831:	6a 00                	push   $0x0
  pushl $222
c0102833:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
c0102838:	e9 8c 01 00 00       	jmp    c01029c9 <__alltraps>

c010283d <vector223>:
.globl vector223
vector223:
  pushl $0
c010283d:	6a 00                	push   $0x0
  pushl $223
c010283f:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
c0102844:	e9 80 01 00 00       	jmp    c01029c9 <__alltraps>

c0102849 <vector224>:
.globl vector224
vector224:
  pushl $0
c0102849:	6a 00                	push   $0x0
  pushl $224
c010284b:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
c0102850:	e9 74 01 00 00       	jmp    c01029c9 <__alltraps>

c0102855 <vector225>:
.globl vector225
vector225:
  pushl $0
c0102855:	6a 00                	push   $0x0
  pushl $225
c0102857:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
c010285c:	e9 68 01 00 00       	jmp    c01029c9 <__alltraps>

c0102861 <vector226>:
.globl vector226
vector226:
  pushl $0
c0102861:	6a 00                	push   $0x0
  pushl $226
c0102863:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
c0102868:	e9 5c 01 00 00       	jmp    c01029c9 <__alltraps>

c010286d <vector227>:
.globl vector227
vector227:
  pushl $0
c010286d:	6a 00                	push   $0x0
  pushl $227
c010286f:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
c0102874:	e9 50 01 00 00       	jmp    c01029c9 <__alltraps>

c0102879 <vector228>:
.globl vector228
vector228:
  pushl $0
c0102879:	6a 00                	push   $0x0
  pushl $228
c010287b:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
c0102880:	e9 44 01 00 00       	jmp    c01029c9 <__alltraps>

c0102885 <vector229>:
.globl vector229
vector229:
  pushl $0
c0102885:	6a 00                	push   $0x0
  pushl $229
c0102887:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
c010288c:	e9 38 01 00 00       	jmp    c01029c9 <__alltraps>

c0102891 <vector230>:
.globl vector230
vector230:
  pushl $0
c0102891:	6a 00                	push   $0x0
  pushl $230
c0102893:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
c0102898:	e9 2c 01 00 00       	jmp    c01029c9 <__alltraps>

c010289d <vector231>:
.globl vector231
vector231:
  pushl $0
c010289d:	6a 00                	push   $0x0
  pushl $231
c010289f:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
c01028a4:	e9 20 01 00 00       	jmp    c01029c9 <__alltraps>

c01028a9 <vector232>:
.globl vector232
vector232:
  pushl $0
c01028a9:	6a 00                	push   $0x0
  pushl $232
c01028ab:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
c01028b0:	e9 14 01 00 00       	jmp    c01029c9 <__alltraps>

c01028b5 <vector233>:
.globl vector233
vector233:
  pushl $0
c01028b5:	6a 00                	push   $0x0
  pushl $233
c01028b7:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
c01028bc:	e9 08 01 00 00       	jmp    c01029c9 <__alltraps>

c01028c1 <vector234>:
.globl vector234
vector234:
  pushl $0
c01028c1:	6a 00                	push   $0x0
  pushl $234
c01028c3:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
c01028c8:	e9 fc 00 00 00       	jmp    c01029c9 <__alltraps>

c01028cd <vector235>:
.globl vector235
vector235:
  pushl $0
c01028cd:	6a 00                	push   $0x0
  pushl $235
c01028cf:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
c01028d4:	e9 f0 00 00 00       	jmp    c01029c9 <__alltraps>

c01028d9 <vector236>:
.globl vector236
vector236:
  pushl $0
c01028d9:	6a 00                	push   $0x0
  pushl $236
c01028db:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
c01028e0:	e9 e4 00 00 00       	jmp    c01029c9 <__alltraps>

c01028e5 <vector237>:
.globl vector237
vector237:
  pushl $0
c01028e5:	6a 00                	push   $0x0
  pushl $237
c01028e7:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
c01028ec:	e9 d8 00 00 00       	jmp    c01029c9 <__alltraps>

c01028f1 <vector238>:
.globl vector238
vector238:
  pushl $0
c01028f1:	6a 00                	push   $0x0
  pushl $238
c01028f3:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
c01028f8:	e9 cc 00 00 00       	jmp    c01029c9 <__alltraps>

c01028fd <vector239>:
.globl vector239
vector239:
  pushl $0
c01028fd:	6a 00                	push   $0x0
  pushl $239
c01028ff:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
c0102904:	e9 c0 00 00 00       	jmp    c01029c9 <__alltraps>

c0102909 <vector240>:
.globl vector240
vector240:
  pushl $0
c0102909:	6a 00                	push   $0x0
  pushl $240
c010290b:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
c0102910:	e9 b4 00 00 00       	jmp    c01029c9 <__alltraps>

c0102915 <vector241>:
.globl vector241
vector241:
  pushl $0
c0102915:	6a 00                	push   $0x0
  pushl $241
c0102917:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
c010291c:	e9 a8 00 00 00       	jmp    c01029c9 <__alltraps>

c0102921 <vector242>:
.globl vector242
vector242:
  pushl $0
c0102921:	6a 00                	push   $0x0
  pushl $242
c0102923:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
c0102928:	e9 9c 00 00 00       	jmp    c01029c9 <__alltraps>

c010292d <vector243>:
.globl vector243
vector243:
  pushl $0
c010292d:	6a 00                	push   $0x0
  pushl $243
c010292f:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
c0102934:	e9 90 00 00 00       	jmp    c01029c9 <__alltraps>

c0102939 <vector244>:
.globl vector244
vector244:
  pushl $0
c0102939:	6a 00                	push   $0x0
  pushl $244
c010293b:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
c0102940:	e9 84 00 00 00       	jmp    c01029c9 <__alltraps>

c0102945 <vector245>:
.globl vector245
vector245:
  pushl $0
c0102945:	6a 00                	push   $0x0
  pushl $245
c0102947:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
c010294c:	e9 78 00 00 00       	jmp    c01029c9 <__alltraps>

c0102951 <vector246>:
.globl vector246
vector246:
  pushl $0
c0102951:	6a 00                	push   $0x0
  pushl $246
c0102953:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
c0102958:	e9 6c 00 00 00       	jmp    c01029c9 <__alltraps>

c010295d <vector247>:
.globl vector247
vector247:
  pushl $0
c010295d:	6a 00                	push   $0x0
  pushl $247
c010295f:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
c0102964:	e9 60 00 00 00       	jmp    c01029c9 <__alltraps>

c0102969 <vector248>:
.globl vector248
vector248:
  pushl $0
c0102969:	6a 00                	push   $0x0
  pushl $248
c010296b:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
c0102970:	e9 54 00 00 00       	jmp    c01029c9 <__alltraps>

c0102975 <vector249>:
.globl vector249
vector249:
  pushl $0
c0102975:	6a 00                	push   $0x0
  pushl $249
c0102977:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
c010297c:	e9 48 00 00 00       	jmp    c01029c9 <__alltraps>

c0102981 <vector250>:
.globl vector250
vector250:
  pushl $0
c0102981:	6a 00                	push   $0x0
  pushl $250
c0102983:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
c0102988:	e9 3c 00 00 00       	jmp    c01029c9 <__alltraps>

c010298d <vector251>:
.globl vector251
vector251:
  pushl $0
c010298d:	6a 00                	push   $0x0
  pushl $251
c010298f:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
c0102994:	e9 30 00 00 00       	jmp    c01029c9 <__alltraps>

c0102999 <vector252>:
.globl vector252
vector252:
  pushl $0
c0102999:	6a 00                	push   $0x0
  pushl $252
c010299b:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
c01029a0:	e9 24 00 00 00       	jmp    c01029c9 <__alltraps>

c01029a5 <vector253>:
.globl vector253
vector253:
  pushl $0
c01029a5:	6a 00                	push   $0x0
  pushl $253
c01029a7:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
c01029ac:	e9 18 00 00 00       	jmp    c01029c9 <__alltraps>

c01029b1 <vector254>:
.globl vector254
vector254:
  pushl $0
c01029b1:	6a 00                	push   $0x0
  pushl $254
c01029b3:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
c01029b8:	e9 0c 00 00 00       	jmp    c01029c9 <__alltraps>

c01029bd <vector255>:
.globl vector255
vector255:
  pushl $0
c01029bd:	6a 00                	push   $0x0
  pushl $255
c01029bf:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
c01029c4:	e9 00 00 00 00       	jmp    c01029c9 <__alltraps>

c01029c9 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
c01029c9:	1e                   	push   %ds
    pushl %es
c01029ca:	06                   	push   %es
    pushl %fs
c01029cb:	0f a0                	push   %fs
    pushl %gs
c01029cd:	0f a8                	push   %gs
    pushal
c01029cf:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
c01029d0:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
c01029d5:	8e d8                	mov    %eax,%ds
    movw %ax, %es
c01029d7:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
c01029d9:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
c01029da:	e8 60 f5 ff ff       	call   c0101f3f <trap>

    # pop the pushed stack pointer
    popl %esp
c01029df:	5c                   	pop    %esp

c01029e0 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
c01029e0:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
c01029e1:	0f a9                	pop    %gs
    popl %fs
c01029e3:	0f a1                	pop    %fs
    popl %es
c01029e5:	07                   	pop    %es
    popl %ds
c01029e6:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
c01029e7:	83 c4 08             	add    $0x8,%esp
    iret
c01029ea:	cf                   	iret   

c01029eb <page2ppn>:

extern struct Page *pages;
extern size_t npage;

static inline ppn_t
page2ppn(struct Page *page) {
c01029eb:	55                   	push   %ebp
c01029ec:	89 e5                	mov    %esp,%ebp
    return page - pages;
c01029ee:	a1 18 cf 11 c0       	mov    0xc011cf18,%eax
c01029f3:	8b 55 08             	mov    0x8(%ebp),%edx
c01029f6:	29 c2                	sub    %eax,%edx
c01029f8:	89 d0                	mov    %edx,%eax
c01029fa:	c1 f8 02             	sar    $0x2,%eax
c01029fd:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
c0102a03:	5d                   	pop    %ebp
c0102a04:	c3                   	ret    

c0102a05 <page2pa>:

static inline uintptr_t
page2pa(struct Page *page) {
c0102a05:	55                   	push   %ebp
c0102a06:	89 e5                	mov    %esp,%ebp
c0102a08:	83 ec 04             	sub    $0x4,%esp
    return page2ppn(page) << PGSHIFT;
c0102a0b:	8b 45 08             	mov    0x8(%ebp),%eax
c0102a0e:	89 04 24             	mov    %eax,(%esp)
c0102a11:	e8 d5 ff ff ff       	call   c01029eb <page2ppn>
c0102a16:	c1 e0 0c             	shl    $0xc,%eax
}
c0102a19:	c9                   	leave  
c0102a1a:	c3                   	ret    

c0102a1b <pa2page>:

static inline struct Page *
pa2page(uintptr_t pa) {
c0102a1b:	55                   	push   %ebp
c0102a1c:	89 e5                	mov    %esp,%ebp
c0102a1e:	83 ec 18             	sub    $0x18,%esp
    if (PPN(pa) >= npage) {
c0102a21:	8b 45 08             	mov    0x8(%ebp),%eax
c0102a24:	c1 e8 0c             	shr    $0xc,%eax
c0102a27:	89 c2                	mov    %eax,%edx
c0102a29:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c0102a2e:	39 c2                	cmp    %eax,%edx
c0102a30:	72 1c                	jb     c0102a4e <pa2page+0x33>
        panic("pa2page called with invalid pa");
c0102a32:	c7 44 24 08 10 68 10 	movl   $0xc0106810,0x8(%esp)
c0102a39:	c0 
c0102a3a:	c7 44 24 04 5a 00 00 	movl   $0x5a,0x4(%esp)
c0102a41:	00 
c0102a42:	c7 04 24 2f 68 10 c0 	movl   $0xc010682f,(%esp)
c0102a49:	e8 e7 d9 ff ff       	call   c0100435 <__panic>
    }
    return &pages[PPN(pa)];
c0102a4e:	8b 0d 18 cf 11 c0    	mov    0xc011cf18,%ecx
c0102a54:	8b 45 08             	mov    0x8(%ebp),%eax
c0102a57:	c1 e8 0c             	shr    $0xc,%eax
c0102a5a:	89 c2                	mov    %eax,%edx
c0102a5c:	89 d0                	mov    %edx,%eax
c0102a5e:	c1 e0 02             	shl    $0x2,%eax
c0102a61:	01 d0                	add    %edx,%eax
c0102a63:	c1 e0 02             	shl    $0x2,%eax
c0102a66:	01 c8                	add    %ecx,%eax
}
c0102a68:	c9                   	leave  
c0102a69:	c3                   	ret    

c0102a6a <page2kva>:

static inline void *
page2kva(struct Page *page) {
c0102a6a:	55                   	push   %ebp
c0102a6b:	89 e5                	mov    %esp,%ebp
c0102a6d:	83 ec 28             	sub    $0x28,%esp
    return KADDR(page2pa(page));
c0102a70:	8b 45 08             	mov    0x8(%ebp),%eax
c0102a73:	89 04 24             	mov    %eax,(%esp)
c0102a76:	e8 8a ff ff ff       	call   c0102a05 <page2pa>
c0102a7b:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0102a7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102a81:	c1 e8 0c             	shr    $0xc,%eax
c0102a84:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0102a87:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c0102a8c:	39 45 f0             	cmp    %eax,-0x10(%ebp)
c0102a8f:	72 23                	jb     c0102ab4 <page2kva+0x4a>
c0102a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102a94:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0102a98:	c7 44 24 08 40 68 10 	movl   $0xc0106840,0x8(%esp)
c0102a9f:	c0 
c0102aa0:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
c0102aa7:	00 
c0102aa8:	c7 04 24 2f 68 10 c0 	movl   $0xc010682f,(%esp)
c0102aaf:	e8 81 d9 ff ff       	call   c0100435 <__panic>
c0102ab4:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102ab7:	2d 00 00 00 40       	sub    $0x40000000,%eax
}
c0102abc:	c9                   	leave  
c0102abd:	c3                   	ret    

c0102abe <pte2page>:
kva2page(void *kva) {
    return pa2page(PADDR(kva));
}

static inline struct Page *
pte2page(pte_t pte) {
c0102abe:	55                   	push   %ebp
c0102abf:	89 e5                	mov    %esp,%ebp
c0102ac1:	83 ec 18             	sub    $0x18,%esp
    if (!(pte & PTE_P)) {
c0102ac4:	8b 45 08             	mov    0x8(%ebp),%eax
c0102ac7:	83 e0 01             	and    $0x1,%eax
c0102aca:	85 c0                	test   %eax,%eax
c0102acc:	75 1c                	jne    c0102aea <pte2page+0x2c>
        panic("pte2page called with invalid pte");
c0102ace:	c7 44 24 08 64 68 10 	movl   $0xc0106864,0x8(%esp)
c0102ad5:	c0 
c0102ad6:	c7 44 24 04 6c 00 00 	movl   $0x6c,0x4(%esp)
c0102add:	00 
c0102ade:	c7 04 24 2f 68 10 c0 	movl   $0xc010682f,(%esp)
c0102ae5:	e8 4b d9 ff ff       	call   c0100435 <__panic>
    }
    return pa2page(PTE_ADDR(pte));
c0102aea:	8b 45 08             	mov    0x8(%ebp),%eax
c0102aed:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0102af2:	89 04 24             	mov    %eax,(%esp)
c0102af5:	e8 21 ff ff ff       	call   c0102a1b <pa2page>
}
c0102afa:	c9                   	leave  
c0102afb:	c3                   	ret    

c0102afc <pde2page>:

static inline struct Page *
pde2page(pde_t pde) {
c0102afc:	55                   	push   %ebp
c0102afd:	89 e5                	mov    %esp,%ebp
c0102aff:	83 ec 18             	sub    $0x18,%esp
    return pa2page(PDE_ADDR(pde));
c0102b02:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b05:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0102b0a:	89 04 24             	mov    %eax,(%esp)
c0102b0d:	e8 09 ff ff ff       	call   c0102a1b <pa2page>
}
c0102b12:	c9                   	leave  
c0102b13:	c3                   	ret    

c0102b14 <page_ref>:

static inline int
page_ref(struct Page *page) {
c0102b14:	55                   	push   %ebp
c0102b15:	89 e5                	mov    %esp,%ebp
    return page->ref;
c0102b17:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b1a:	8b 00                	mov    (%eax),%eax
}
c0102b1c:	5d                   	pop    %ebp
c0102b1d:	c3                   	ret    

c0102b1e <set_page_ref>:

static inline void
set_page_ref(struct Page *page, int val) {
c0102b1e:	55                   	push   %ebp
c0102b1f:	89 e5                	mov    %esp,%ebp
    page->ref = val;
c0102b21:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b24:	8b 55 0c             	mov    0xc(%ebp),%edx
c0102b27:	89 10                	mov    %edx,(%eax)
}
c0102b29:	90                   	nop
c0102b2a:	5d                   	pop    %ebp
c0102b2b:	c3                   	ret    

c0102b2c <page_ref_inc>:

static inline int
page_ref_inc(struct Page *page) {
c0102b2c:	55                   	push   %ebp
c0102b2d:	89 e5                	mov    %esp,%ebp
    page->ref += 1;
c0102b2f:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b32:	8b 00                	mov    (%eax),%eax
c0102b34:	8d 50 01             	lea    0x1(%eax),%edx
c0102b37:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b3a:	89 10                	mov    %edx,(%eax)
    return page->ref;
c0102b3c:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b3f:	8b 00                	mov    (%eax),%eax
}
c0102b41:	5d                   	pop    %ebp
c0102b42:	c3                   	ret    

c0102b43 <page_ref_dec>:

static inline int
page_ref_dec(struct Page *page) {
c0102b43:	55                   	push   %ebp
c0102b44:	89 e5                	mov    %esp,%ebp
    page->ref -= 1;
c0102b46:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b49:	8b 00                	mov    (%eax),%eax
c0102b4b:	8d 50 ff             	lea    -0x1(%eax),%edx
c0102b4e:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b51:	89 10                	mov    %edx,(%eax)
    return page->ref;
c0102b53:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b56:	8b 00                	mov    (%eax),%eax
}
c0102b58:	5d                   	pop    %ebp
c0102b59:	c3                   	ret    

c0102b5a <__intr_save>:
__intr_save(void) {
c0102b5a:	55                   	push   %ebp
c0102b5b:	89 e5                	mov    %esp,%ebp
c0102b5d:	83 ec 18             	sub    $0x18,%esp
    asm volatile ("pushfl; popl %0" : "=r" (eflags));
c0102b60:	9c                   	pushf  
c0102b61:	58                   	pop    %eax
c0102b62:	89 45 f4             	mov    %eax,-0xc(%ebp)
    return eflags;
c0102b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    if (read_eflags() & FL_IF) {
c0102b68:	25 00 02 00 00       	and    $0x200,%eax
c0102b6d:	85 c0                	test   %eax,%eax
c0102b6f:	74 0c                	je     c0102b7d <__intr_save+0x23>
        intr_disable();
c0102b71:	e8 61 ed ff ff       	call   c01018d7 <intr_disable>
        return 1;
c0102b76:	b8 01 00 00 00       	mov    $0x1,%eax
c0102b7b:	eb 05                	jmp    c0102b82 <__intr_save+0x28>
    return 0;
c0102b7d:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0102b82:	c9                   	leave  
c0102b83:	c3                   	ret    

c0102b84 <__intr_restore>:
__intr_restore(bool flag) {
c0102b84:	55                   	push   %ebp
c0102b85:	89 e5                	mov    %esp,%ebp
c0102b87:	83 ec 08             	sub    $0x8,%esp
    if (flag) {
c0102b8a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c0102b8e:	74 05                	je     c0102b95 <__intr_restore+0x11>
        intr_enable();
c0102b90:	e8 36 ed ff ff       	call   c01018cb <intr_enable>
}
c0102b95:	90                   	nop
c0102b96:	c9                   	leave  
c0102b97:	c3                   	ret    

c0102b98 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
c0102b98:	55                   	push   %ebp
c0102b99:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
c0102b9b:	8b 45 08             	mov    0x8(%ebp),%eax
c0102b9e:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
c0102ba1:	b8 23 00 00 00       	mov    $0x23,%eax
c0102ba6:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
c0102ba8:	b8 23 00 00 00       	mov    $0x23,%eax
c0102bad:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
c0102baf:	b8 10 00 00 00       	mov    $0x10,%eax
c0102bb4:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
c0102bb6:	b8 10 00 00 00       	mov    $0x10,%eax
c0102bbb:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
c0102bbd:	b8 10 00 00 00       	mov    $0x10,%eax
c0102bc2:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
c0102bc4:	ea cb 2b 10 c0 08 00 	ljmp   $0x8,$0xc0102bcb
}
c0102bcb:	90                   	nop
c0102bcc:	5d                   	pop    %ebp
c0102bcd:	c3                   	ret    

c0102bce <load_esp0>:
 * load_esp0 - change the ESP0 in default task state segment,
 * so that we can use different kernel stack when we trap frame
 * user to kernel.
 * */
void
load_esp0(uintptr_t esp0) {
c0102bce:	f3 0f 1e fb          	endbr32 
c0102bd2:	55                   	push   %ebp
c0102bd3:	89 e5                	mov    %esp,%ebp
    ts.ts_esp0 = esp0;
c0102bd5:	8b 45 08             	mov    0x8(%ebp),%eax
c0102bd8:	a3 a4 ce 11 c0       	mov    %eax,0xc011cea4
}
c0102bdd:	90                   	nop
c0102bde:	5d                   	pop    %ebp
c0102bdf:	c3                   	ret    

c0102be0 <gdt_init>:

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
c0102be0:	f3 0f 1e fb          	endbr32 
c0102be4:	55                   	push   %ebp
c0102be5:	89 e5                	mov    %esp,%ebp
c0102be7:	83 ec 14             	sub    $0x14,%esp
    // set boot kernel stack and default SS0
    load_esp0((uintptr_t)bootstacktop);
c0102bea:	b8 00 90 11 c0       	mov    $0xc0119000,%eax
c0102bef:	89 04 24             	mov    %eax,(%esp)
c0102bf2:	e8 d7 ff ff ff       	call   c0102bce <load_esp0>
    ts.ts_ss0 = KERNEL_DS;
c0102bf7:	66 c7 05 a8 ce 11 c0 	movw   $0x10,0xc011cea8
c0102bfe:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEGTSS(STS_T32A, (uintptr_t)&ts, sizeof(ts), DPL_KERNEL);
c0102c00:	66 c7 05 28 9a 11 c0 	movw   $0x68,0xc0119a28
c0102c07:	68 00 
c0102c09:	b8 a0 ce 11 c0       	mov    $0xc011cea0,%eax
c0102c0e:	0f b7 c0             	movzwl %ax,%eax
c0102c11:	66 a3 2a 9a 11 c0    	mov    %ax,0xc0119a2a
c0102c17:	b8 a0 ce 11 c0       	mov    $0xc011cea0,%eax
c0102c1c:	c1 e8 10             	shr    $0x10,%eax
c0102c1f:	a2 2c 9a 11 c0       	mov    %al,0xc0119a2c
c0102c24:	0f b6 05 2d 9a 11 c0 	movzbl 0xc0119a2d,%eax
c0102c2b:	24 f0                	and    $0xf0,%al
c0102c2d:	0c 09                	or     $0x9,%al
c0102c2f:	a2 2d 9a 11 c0       	mov    %al,0xc0119a2d
c0102c34:	0f b6 05 2d 9a 11 c0 	movzbl 0xc0119a2d,%eax
c0102c3b:	24 ef                	and    $0xef,%al
c0102c3d:	a2 2d 9a 11 c0       	mov    %al,0xc0119a2d
c0102c42:	0f b6 05 2d 9a 11 c0 	movzbl 0xc0119a2d,%eax
c0102c49:	24 9f                	and    $0x9f,%al
c0102c4b:	a2 2d 9a 11 c0       	mov    %al,0xc0119a2d
c0102c50:	0f b6 05 2d 9a 11 c0 	movzbl 0xc0119a2d,%eax
c0102c57:	0c 80                	or     $0x80,%al
c0102c59:	a2 2d 9a 11 c0       	mov    %al,0xc0119a2d
c0102c5e:	0f b6 05 2e 9a 11 c0 	movzbl 0xc0119a2e,%eax
c0102c65:	24 f0                	and    $0xf0,%al
c0102c67:	a2 2e 9a 11 c0       	mov    %al,0xc0119a2e
c0102c6c:	0f b6 05 2e 9a 11 c0 	movzbl 0xc0119a2e,%eax
c0102c73:	24 ef                	and    $0xef,%al
c0102c75:	a2 2e 9a 11 c0       	mov    %al,0xc0119a2e
c0102c7a:	0f b6 05 2e 9a 11 c0 	movzbl 0xc0119a2e,%eax
c0102c81:	24 df                	and    $0xdf,%al
c0102c83:	a2 2e 9a 11 c0       	mov    %al,0xc0119a2e
c0102c88:	0f b6 05 2e 9a 11 c0 	movzbl 0xc0119a2e,%eax
c0102c8f:	0c 40                	or     $0x40,%al
c0102c91:	a2 2e 9a 11 c0       	mov    %al,0xc0119a2e
c0102c96:	0f b6 05 2e 9a 11 c0 	movzbl 0xc0119a2e,%eax
c0102c9d:	24 7f                	and    $0x7f,%al
c0102c9f:	a2 2e 9a 11 c0       	mov    %al,0xc0119a2e
c0102ca4:	b8 a0 ce 11 c0       	mov    $0xc011cea0,%eax
c0102ca9:	c1 e8 18             	shr    $0x18,%eax
c0102cac:	a2 2f 9a 11 c0       	mov    %al,0xc0119a2f

    // reload all segment registers
    lgdt(&gdt_pd);
c0102cb1:	c7 04 24 30 9a 11 c0 	movl   $0xc0119a30,(%esp)
c0102cb8:	e8 db fe ff ff       	call   c0102b98 <lgdt>
c0102cbd:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("ltr %0" :: "r" (sel) : "memory");
c0102cc3:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
c0102cc7:	0f 00 d8             	ltr    %ax
}
c0102cca:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
c0102ccb:	90                   	nop
c0102ccc:	c9                   	leave  
c0102ccd:	c3                   	ret    

c0102cce <init_pmm_manager>:

//init_pmm_manager - initialize a pmm_manager instance
static void
init_pmm_manager(void) {
c0102cce:	f3 0f 1e fb          	endbr32 
c0102cd2:	55                   	push   %ebp
c0102cd3:	89 e5                	mov    %esp,%ebp
c0102cd5:	83 ec 18             	sub    $0x18,%esp
    pmm_manager = &default_pmm_manager;
c0102cd8:	c7 05 10 cf 11 c0 08 	movl   $0xc0107208,0xc011cf10
c0102cdf:	72 10 c0 
    cprintf("memory management: %s\n", pmm_manager->name);
c0102ce2:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c0102ce7:	8b 00                	mov    (%eax),%eax
c0102ce9:	89 44 24 04          	mov    %eax,0x4(%esp)
c0102ced:	c7 04 24 90 68 10 c0 	movl   $0xc0106890,(%esp)
c0102cf4:	e8 d0 d5 ff ff       	call   c01002c9 <cprintf>
    pmm_manager->init();
c0102cf9:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c0102cfe:	8b 40 04             	mov    0x4(%eax),%eax
c0102d01:	ff d0                	call   *%eax
}
c0102d03:	90                   	nop
c0102d04:	c9                   	leave  
c0102d05:	c3                   	ret    

c0102d06 <init_memmap>:

//init_memmap - call pmm->init_memmap to build Page struct for free memory  
static void
init_memmap(struct Page *base, size_t n) {
c0102d06:	f3 0f 1e fb          	endbr32 
c0102d0a:	55                   	push   %ebp
c0102d0b:	89 e5                	mov    %esp,%ebp
c0102d0d:	83 ec 18             	sub    $0x18,%esp
    pmm_manager->init_memmap(base, n);
c0102d10:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c0102d15:	8b 40 08             	mov    0x8(%eax),%eax
c0102d18:	8b 55 0c             	mov    0xc(%ebp),%edx
c0102d1b:	89 54 24 04          	mov    %edx,0x4(%esp)
c0102d1f:	8b 55 08             	mov    0x8(%ebp),%edx
c0102d22:	89 14 24             	mov    %edx,(%esp)
c0102d25:	ff d0                	call   *%eax
}
c0102d27:	90                   	nop
c0102d28:	c9                   	leave  
c0102d29:	c3                   	ret    

c0102d2a <alloc_pages>:

//alloc_pages - call pmm->alloc_pages to allocate a continuous n*PAGESIZE memory 
struct Page *
alloc_pages(size_t n) {
c0102d2a:	f3 0f 1e fb          	endbr32 
c0102d2e:	55                   	push   %ebp
c0102d2f:	89 e5                	mov    %esp,%ebp
c0102d31:	83 ec 28             	sub    $0x28,%esp
    struct Page *page=NULL;
c0102d34:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    bool intr_flag;
    local_intr_save(intr_flag);
c0102d3b:	e8 1a fe ff ff       	call   c0102b5a <__intr_save>
c0102d40:	89 45 f0             	mov    %eax,-0x10(%ebp)
    {
        page = pmm_manager->alloc_pages(n);
c0102d43:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c0102d48:	8b 40 0c             	mov    0xc(%eax),%eax
c0102d4b:	8b 55 08             	mov    0x8(%ebp),%edx
c0102d4e:	89 14 24             	mov    %edx,(%esp)
c0102d51:	ff d0                	call   *%eax
c0102d53:	89 45 f4             	mov    %eax,-0xc(%ebp)
    }
    local_intr_restore(intr_flag);
c0102d56:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0102d59:	89 04 24             	mov    %eax,(%esp)
c0102d5c:	e8 23 fe ff ff       	call   c0102b84 <__intr_restore>
    return page;
c0102d61:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c0102d64:	c9                   	leave  
c0102d65:	c3                   	ret    

c0102d66 <free_pages>:

//free_pages - call pmm->free_pages to free a continuous n*PAGESIZE memory 
void
free_pages(struct Page *base, size_t n) {
c0102d66:	f3 0f 1e fb          	endbr32 
c0102d6a:	55                   	push   %ebp
c0102d6b:	89 e5                	mov    %esp,%ebp
c0102d6d:	83 ec 28             	sub    $0x28,%esp
    bool intr_flag;
    local_intr_save(intr_flag);
c0102d70:	e8 e5 fd ff ff       	call   c0102b5a <__intr_save>
c0102d75:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        pmm_manager->free_pages(base, n);
c0102d78:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c0102d7d:	8b 40 10             	mov    0x10(%eax),%eax
c0102d80:	8b 55 0c             	mov    0xc(%ebp),%edx
c0102d83:	89 54 24 04          	mov    %edx,0x4(%esp)
c0102d87:	8b 55 08             	mov    0x8(%ebp),%edx
c0102d8a:	89 14 24             	mov    %edx,(%esp)
c0102d8d:	ff d0                	call   *%eax
    }
    local_intr_restore(intr_flag);
c0102d8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102d92:	89 04 24             	mov    %eax,(%esp)
c0102d95:	e8 ea fd ff ff       	call   c0102b84 <__intr_restore>
}
c0102d9a:	90                   	nop
c0102d9b:	c9                   	leave  
c0102d9c:	c3                   	ret    

c0102d9d <nr_free_pages>:

//nr_free_pages - call pmm->nr_free_pages to get the size (nr*PAGESIZE) 
//of current free memory
size_t
nr_free_pages(void) {
c0102d9d:	f3 0f 1e fb          	endbr32 
c0102da1:	55                   	push   %ebp
c0102da2:	89 e5                	mov    %esp,%ebp
c0102da4:	83 ec 28             	sub    $0x28,%esp
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
c0102da7:	e8 ae fd ff ff       	call   c0102b5a <__intr_save>
c0102dac:	89 45 f4             	mov    %eax,-0xc(%ebp)
    {
        ret = pmm_manager->nr_free_pages();
c0102daf:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c0102db4:	8b 40 14             	mov    0x14(%eax),%eax
c0102db7:	ff d0                	call   *%eax
c0102db9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    }
    local_intr_restore(intr_flag);
c0102dbc:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0102dbf:	89 04 24             	mov    %eax,(%esp)
c0102dc2:	e8 bd fd ff ff       	call   c0102b84 <__intr_restore>
    return ret;
c0102dc7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
c0102dca:	c9                   	leave  
c0102dcb:	c3                   	ret    

c0102dcc <page_init>:

/* pmm_init - initialize the physical memory management */
static void
page_init(void) {
c0102dcc:	f3 0f 1e fb          	endbr32 
c0102dd0:	55                   	push   %ebp
c0102dd1:	89 e5                	mov    %esp,%ebp
c0102dd3:	57                   	push   %edi
c0102dd4:	56                   	push   %esi
c0102dd5:	53                   	push   %ebx
c0102dd6:	81 ec 9c 00 00 00    	sub    $0x9c,%esp
    struct e820map *memmap = (struct e820map *)(0x8000 + KERNBASE);
c0102ddc:	c7 45 c4 00 80 00 c0 	movl   $0xc0008000,-0x3c(%ebp)
    uint64_t maxpa = 0;
c0102de3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
c0102dea:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

    cprintf("e820map:\n");
c0102df1:	c7 04 24 a7 68 10 c0 	movl   $0xc01068a7,(%esp)
c0102df8:	e8 cc d4 ff ff       	call   c01002c9 <cprintf>
    int i;
    for (i = 0; i < memmap->nr_map; i ++) {
c0102dfd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0102e04:	e9 1a 01 00 00       	jmp    c0102f23 <page_init+0x157>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
c0102e09:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102e0c:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102e0f:	89 d0                	mov    %edx,%eax
c0102e11:	c1 e0 02             	shl    $0x2,%eax
c0102e14:	01 d0                	add    %edx,%eax
c0102e16:	c1 e0 02             	shl    $0x2,%eax
c0102e19:	01 c8                	add    %ecx,%eax
c0102e1b:	8b 50 08             	mov    0x8(%eax),%edx
c0102e1e:	8b 40 04             	mov    0x4(%eax),%eax
c0102e21:	89 45 a0             	mov    %eax,-0x60(%ebp)
c0102e24:	89 55 a4             	mov    %edx,-0x5c(%ebp)
c0102e27:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102e2a:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102e2d:	89 d0                	mov    %edx,%eax
c0102e2f:	c1 e0 02             	shl    $0x2,%eax
c0102e32:	01 d0                	add    %edx,%eax
c0102e34:	c1 e0 02             	shl    $0x2,%eax
c0102e37:	01 c8                	add    %ecx,%eax
c0102e39:	8b 48 0c             	mov    0xc(%eax),%ecx
c0102e3c:	8b 58 10             	mov    0x10(%eax),%ebx
c0102e3f:	8b 45 a0             	mov    -0x60(%ebp),%eax
c0102e42:	8b 55 a4             	mov    -0x5c(%ebp),%edx
c0102e45:	01 c8                	add    %ecx,%eax
c0102e47:	11 da                	adc    %ebx,%edx
c0102e49:	89 45 98             	mov    %eax,-0x68(%ebp)
c0102e4c:	89 55 9c             	mov    %edx,-0x64(%ebp)
        cprintf("  memory: %08llx, [%08llx, %08llx], type = %d.\n",
c0102e4f:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102e52:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102e55:	89 d0                	mov    %edx,%eax
c0102e57:	c1 e0 02             	shl    $0x2,%eax
c0102e5a:	01 d0                	add    %edx,%eax
c0102e5c:	c1 e0 02             	shl    $0x2,%eax
c0102e5f:	01 c8                	add    %ecx,%eax
c0102e61:	83 c0 14             	add    $0x14,%eax
c0102e64:	8b 00                	mov    (%eax),%eax
c0102e66:	89 45 84             	mov    %eax,-0x7c(%ebp)
c0102e69:	8b 45 98             	mov    -0x68(%ebp),%eax
c0102e6c:	8b 55 9c             	mov    -0x64(%ebp),%edx
c0102e6f:	83 c0 ff             	add    $0xffffffff,%eax
c0102e72:	83 d2 ff             	adc    $0xffffffff,%edx
c0102e75:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
c0102e7b:	89 95 7c ff ff ff    	mov    %edx,-0x84(%ebp)
c0102e81:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102e84:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102e87:	89 d0                	mov    %edx,%eax
c0102e89:	c1 e0 02             	shl    $0x2,%eax
c0102e8c:	01 d0                	add    %edx,%eax
c0102e8e:	c1 e0 02             	shl    $0x2,%eax
c0102e91:	01 c8                	add    %ecx,%eax
c0102e93:	8b 48 0c             	mov    0xc(%eax),%ecx
c0102e96:	8b 58 10             	mov    0x10(%eax),%ebx
c0102e99:	8b 55 84             	mov    -0x7c(%ebp),%edx
c0102e9c:	89 54 24 1c          	mov    %edx,0x1c(%esp)
c0102ea0:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
c0102ea6:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
c0102eac:	89 44 24 14          	mov    %eax,0x14(%esp)
c0102eb0:	89 54 24 18          	mov    %edx,0x18(%esp)
c0102eb4:	8b 45 a0             	mov    -0x60(%ebp),%eax
c0102eb7:	8b 55 a4             	mov    -0x5c(%ebp),%edx
c0102eba:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0102ebe:	89 54 24 10          	mov    %edx,0x10(%esp)
c0102ec2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
c0102ec6:	89 5c 24 08          	mov    %ebx,0x8(%esp)
c0102eca:	c7 04 24 b4 68 10 c0 	movl   $0xc01068b4,(%esp)
c0102ed1:	e8 f3 d3 ff ff       	call   c01002c9 <cprintf>
                memmap->map[i].size, begin, end - 1, memmap->map[i].type);
        if (memmap->map[i].type == E820_ARM) {
c0102ed6:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0102ed9:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102edc:	89 d0                	mov    %edx,%eax
c0102ede:	c1 e0 02             	shl    $0x2,%eax
c0102ee1:	01 d0                	add    %edx,%eax
c0102ee3:	c1 e0 02             	shl    $0x2,%eax
c0102ee6:	01 c8                	add    %ecx,%eax
c0102ee8:	83 c0 14             	add    $0x14,%eax
c0102eeb:	8b 00                	mov    (%eax),%eax
c0102eed:	83 f8 01             	cmp    $0x1,%eax
c0102ef0:	75 2e                	jne    c0102f20 <page_init+0x154>
            if (maxpa < end && begin < KMEMSIZE) {
c0102ef2:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0102ef5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0102ef8:	3b 45 98             	cmp    -0x68(%ebp),%eax
c0102efb:	89 d0                	mov    %edx,%eax
c0102efd:	1b 45 9c             	sbb    -0x64(%ebp),%eax
c0102f00:	73 1e                	jae    c0102f20 <page_init+0x154>
c0102f02:	ba ff ff ff 37       	mov    $0x37ffffff,%edx
c0102f07:	b8 00 00 00 00       	mov    $0x0,%eax
c0102f0c:	3b 55 a0             	cmp    -0x60(%ebp),%edx
c0102f0f:	1b 45 a4             	sbb    -0x5c(%ebp),%eax
c0102f12:	72 0c                	jb     c0102f20 <page_init+0x154>
                maxpa = end;
c0102f14:	8b 45 98             	mov    -0x68(%ebp),%eax
c0102f17:	8b 55 9c             	mov    -0x64(%ebp),%edx
c0102f1a:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0102f1d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    for (i = 0; i < memmap->nr_map; i ++) {
c0102f20:	ff 45 dc             	incl   -0x24(%ebp)
c0102f23:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0102f26:	8b 00                	mov    (%eax),%eax
c0102f28:	39 45 dc             	cmp    %eax,-0x24(%ebp)
c0102f2b:	0f 8c d8 fe ff ff    	jl     c0102e09 <page_init+0x3d>
            }
        }
    }
    if (maxpa > KMEMSIZE) {
c0102f31:	ba 00 00 00 38       	mov    $0x38000000,%edx
c0102f36:	b8 00 00 00 00       	mov    $0x0,%eax
c0102f3b:	3b 55 e0             	cmp    -0x20(%ebp),%edx
c0102f3e:	1b 45 e4             	sbb    -0x1c(%ebp),%eax
c0102f41:	73 0e                	jae    c0102f51 <page_init+0x185>
        maxpa = KMEMSIZE;
c0102f43:	c7 45 e0 00 00 00 38 	movl   $0x38000000,-0x20(%ebp)
c0102f4a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    }

    extern char end[];

    npage = maxpa / PGSIZE;
c0102f51:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0102f54:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0102f57:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
c0102f5b:	c1 ea 0c             	shr    $0xc,%edx
c0102f5e:	a3 80 ce 11 c0       	mov    %eax,0xc011ce80
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
c0102f63:	c7 45 c0 00 10 00 00 	movl   $0x1000,-0x40(%ebp)
c0102f6a:	b8 28 cf 11 c0       	mov    $0xc011cf28,%eax
c0102f6f:	8d 50 ff             	lea    -0x1(%eax),%edx
c0102f72:	8b 45 c0             	mov    -0x40(%ebp),%eax
c0102f75:	01 d0                	add    %edx,%eax
c0102f77:	89 45 bc             	mov    %eax,-0x44(%ebp)
c0102f7a:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0102f7d:	ba 00 00 00 00       	mov    $0x0,%edx
c0102f82:	f7 75 c0             	divl   -0x40(%ebp)
c0102f85:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0102f88:	29 d0                	sub    %edx,%eax
c0102f8a:	a3 18 cf 11 c0       	mov    %eax,0xc011cf18

    for (i = 0; i < npage; i ++) {
c0102f8f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0102f96:	eb 2f                	jmp    c0102fc7 <page_init+0x1fb>
        SetPageReserved(pages + i);
c0102f98:	8b 0d 18 cf 11 c0    	mov    0xc011cf18,%ecx
c0102f9e:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102fa1:	89 d0                	mov    %edx,%eax
c0102fa3:	c1 e0 02             	shl    $0x2,%eax
c0102fa6:	01 d0                	add    %edx,%eax
c0102fa8:	c1 e0 02             	shl    $0x2,%eax
c0102fab:	01 c8                	add    %ecx,%eax
c0102fad:	83 c0 04             	add    $0x4,%eax
c0102fb0:	c7 45 94 00 00 00 00 	movl   $0x0,-0x6c(%ebp)
c0102fb7:	89 45 90             	mov    %eax,-0x70(%ebp)
 * Note that @nr may be almost arbitrarily large; this function is not
 * restricted to acting on a single-word quantity.
 * */
static inline void
set_bit(int nr, volatile void *addr) {
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0102fba:	8b 45 90             	mov    -0x70(%ebp),%eax
c0102fbd:	8b 55 94             	mov    -0x6c(%ebp),%edx
c0102fc0:	0f ab 10             	bts    %edx,(%eax)
}
c0102fc3:	90                   	nop
    for (i = 0; i < npage; i ++) {
c0102fc4:	ff 45 dc             	incl   -0x24(%ebp)
c0102fc7:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0102fca:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c0102fcf:	39 c2                	cmp    %eax,%edx
c0102fd1:	72 c5                	jb     c0102f98 <page_init+0x1cc>
    }

    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * npage);
c0102fd3:	8b 15 80 ce 11 c0    	mov    0xc011ce80,%edx
c0102fd9:	89 d0                	mov    %edx,%eax
c0102fdb:	c1 e0 02             	shl    $0x2,%eax
c0102fde:	01 d0                	add    %edx,%eax
c0102fe0:	c1 e0 02             	shl    $0x2,%eax
c0102fe3:	89 c2                	mov    %eax,%edx
c0102fe5:	a1 18 cf 11 c0       	mov    0xc011cf18,%eax
c0102fea:	01 d0                	add    %edx,%eax
c0102fec:	89 45 b8             	mov    %eax,-0x48(%ebp)
c0102fef:	81 7d b8 ff ff ff bf 	cmpl   $0xbfffffff,-0x48(%ebp)
c0102ff6:	77 23                	ja     c010301b <page_init+0x24f>
c0102ff8:	8b 45 b8             	mov    -0x48(%ebp),%eax
c0102ffb:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0102fff:	c7 44 24 08 e4 68 10 	movl   $0xc01068e4,0x8(%esp)
c0103006:	c0 
c0103007:	c7 44 24 04 dc 00 00 	movl   $0xdc,0x4(%esp)
c010300e:	00 
c010300f:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103016:	e8 1a d4 ff ff       	call   c0100435 <__panic>
c010301b:	8b 45 b8             	mov    -0x48(%ebp),%eax
c010301e:	05 00 00 00 40       	add    $0x40000000,%eax
c0103023:	89 45 b4             	mov    %eax,-0x4c(%ebp)

    for (i = 0; i < memmap->nr_map; i ++) {
c0103026:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c010302d:	e9 4b 01 00 00       	jmp    c010317d <page_init+0x3b1>
        uint64_t begin = memmap->map[i].addr, end = begin + memmap->map[i].size;
c0103032:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0103035:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0103038:	89 d0                	mov    %edx,%eax
c010303a:	c1 e0 02             	shl    $0x2,%eax
c010303d:	01 d0                	add    %edx,%eax
c010303f:	c1 e0 02             	shl    $0x2,%eax
c0103042:	01 c8                	add    %ecx,%eax
c0103044:	8b 50 08             	mov    0x8(%eax),%edx
c0103047:	8b 40 04             	mov    0x4(%eax),%eax
c010304a:	89 45 d0             	mov    %eax,-0x30(%ebp)
c010304d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c0103050:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c0103053:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0103056:	89 d0                	mov    %edx,%eax
c0103058:	c1 e0 02             	shl    $0x2,%eax
c010305b:	01 d0                	add    %edx,%eax
c010305d:	c1 e0 02             	shl    $0x2,%eax
c0103060:	01 c8                	add    %ecx,%eax
c0103062:	8b 48 0c             	mov    0xc(%eax),%ecx
c0103065:	8b 58 10             	mov    0x10(%eax),%ebx
c0103068:	8b 45 d0             	mov    -0x30(%ebp),%eax
c010306b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010306e:	01 c8                	add    %ecx,%eax
c0103070:	11 da                	adc    %ebx,%edx
c0103072:	89 45 c8             	mov    %eax,-0x38(%ebp)
c0103075:	89 55 cc             	mov    %edx,-0x34(%ebp)
        if (memmap->map[i].type == E820_ARM) {
c0103078:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
c010307b:	8b 55 dc             	mov    -0x24(%ebp),%edx
c010307e:	89 d0                	mov    %edx,%eax
c0103080:	c1 e0 02             	shl    $0x2,%eax
c0103083:	01 d0                	add    %edx,%eax
c0103085:	c1 e0 02             	shl    $0x2,%eax
c0103088:	01 c8                	add    %ecx,%eax
c010308a:	83 c0 14             	add    $0x14,%eax
c010308d:	8b 00                	mov    (%eax),%eax
c010308f:	83 f8 01             	cmp    $0x1,%eax
c0103092:	0f 85 e2 00 00 00    	jne    c010317a <page_init+0x3ae>
            if (begin < freemem) {
c0103098:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c010309b:	ba 00 00 00 00       	mov    $0x0,%edx
c01030a0:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
c01030a3:	39 45 d0             	cmp    %eax,-0x30(%ebp)
c01030a6:	19 d1                	sbb    %edx,%ecx
c01030a8:	73 0d                	jae    c01030b7 <page_init+0x2eb>
                begin = freemem;
c01030aa:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c01030ad:	89 45 d0             	mov    %eax,-0x30(%ebp)
c01030b0:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
            }
            if (end > KMEMSIZE) {
c01030b7:	ba 00 00 00 38       	mov    $0x38000000,%edx
c01030bc:	b8 00 00 00 00       	mov    $0x0,%eax
c01030c1:	3b 55 c8             	cmp    -0x38(%ebp),%edx
c01030c4:	1b 45 cc             	sbb    -0x34(%ebp),%eax
c01030c7:	73 0e                	jae    c01030d7 <page_init+0x30b>
                end = KMEMSIZE;
c01030c9:	c7 45 c8 00 00 00 38 	movl   $0x38000000,-0x38(%ebp)
c01030d0:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
            }
            if (begin < end) {
c01030d7:	8b 45 d0             	mov    -0x30(%ebp),%eax
c01030da:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c01030dd:	3b 45 c8             	cmp    -0x38(%ebp),%eax
c01030e0:	89 d0                	mov    %edx,%eax
c01030e2:	1b 45 cc             	sbb    -0x34(%ebp),%eax
c01030e5:	0f 83 8f 00 00 00    	jae    c010317a <page_init+0x3ae>
                begin = ROUNDUP(begin, PGSIZE);
c01030eb:	c7 45 b0 00 10 00 00 	movl   $0x1000,-0x50(%ebp)
c01030f2:	8b 55 d0             	mov    -0x30(%ebp),%edx
c01030f5:	8b 45 b0             	mov    -0x50(%ebp),%eax
c01030f8:	01 d0                	add    %edx,%eax
c01030fa:	48                   	dec    %eax
c01030fb:	89 45 ac             	mov    %eax,-0x54(%ebp)
c01030fe:	8b 45 ac             	mov    -0x54(%ebp),%eax
c0103101:	ba 00 00 00 00       	mov    $0x0,%edx
c0103106:	f7 75 b0             	divl   -0x50(%ebp)
c0103109:	8b 45 ac             	mov    -0x54(%ebp),%eax
c010310c:	29 d0                	sub    %edx,%eax
c010310e:	ba 00 00 00 00       	mov    $0x0,%edx
c0103113:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0103116:	89 55 d4             	mov    %edx,-0x2c(%ebp)
                end = ROUNDDOWN(end, PGSIZE);
c0103119:	8b 45 c8             	mov    -0x38(%ebp),%eax
c010311c:	89 45 a8             	mov    %eax,-0x58(%ebp)
c010311f:	8b 45 a8             	mov    -0x58(%ebp),%eax
c0103122:	ba 00 00 00 00       	mov    $0x0,%edx
c0103127:	89 c3                	mov    %eax,%ebx
c0103129:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
c010312f:	89 de                	mov    %ebx,%esi
c0103131:	89 d0                	mov    %edx,%eax
c0103133:	83 e0 00             	and    $0x0,%eax
c0103136:	89 c7                	mov    %eax,%edi
c0103138:	89 75 c8             	mov    %esi,-0x38(%ebp)
c010313b:	89 7d cc             	mov    %edi,-0x34(%ebp)
                if (begin < end) {
c010313e:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0103141:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0103144:	3b 45 c8             	cmp    -0x38(%ebp),%eax
c0103147:	89 d0                	mov    %edx,%eax
c0103149:	1b 45 cc             	sbb    -0x34(%ebp),%eax
c010314c:	73 2c                	jae    c010317a <page_init+0x3ae>
                    init_memmap(pa2page(begin), (end - begin) / PGSIZE);
c010314e:	8b 45 c8             	mov    -0x38(%ebp),%eax
c0103151:	8b 55 cc             	mov    -0x34(%ebp),%edx
c0103154:	2b 45 d0             	sub    -0x30(%ebp),%eax
c0103157:	1b 55 d4             	sbb    -0x2c(%ebp),%edx
c010315a:	0f ac d0 0c          	shrd   $0xc,%edx,%eax
c010315e:	c1 ea 0c             	shr    $0xc,%edx
c0103161:	89 c3                	mov    %eax,%ebx
c0103163:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0103166:	89 04 24             	mov    %eax,(%esp)
c0103169:	e8 ad f8 ff ff       	call   c0102a1b <pa2page>
c010316e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
c0103172:	89 04 24             	mov    %eax,(%esp)
c0103175:	e8 8c fb ff ff       	call   c0102d06 <init_memmap>
    for (i = 0; i < memmap->nr_map; i ++) {
c010317a:	ff 45 dc             	incl   -0x24(%ebp)
c010317d:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0103180:	8b 00                	mov    (%eax),%eax
c0103182:	39 45 dc             	cmp    %eax,-0x24(%ebp)
c0103185:	0f 8c a7 fe ff ff    	jl     c0103032 <page_init+0x266>
                }
            }
        }
    }
}
c010318b:	90                   	nop
c010318c:	90                   	nop
c010318d:	81 c4 9c 00 00 00    	add    $0x9c,%esp
c0103193:	5b                   	pop    %ebx
c0103194:	5e                   	pop    %esi
c0103195:	5f                   	pop    %edi
c0103196:	5d                   	pop    %ebp
c0103197:	c3                   	ret    

c0103198 <boot_map_segment>:
//  la:   linear address of this memory need to map (after x86 segment map)
//  size: memory size
//  pa:   physical address of this memory
//  perm: permission of this memory  
static void
boot_map_segment(pde_t *pgdir, uintptr_t la, size_t size, uintptr_t pa, uint32_t perm) {
c0103198:	f3 0f 1e fb          	endbr32 
c010319c:	55                   	push   %ebp
c010319d:	89 e5                	mov    %esp,%ebp
c010319f:	83 ec 38             	sub    $0x38,%esp
    assert(PGOFF(la) == PGOFF(pa));
c01031a2:	8b 45 0c             	mov    0xc(%ebp),%eax
c01031a5:	33 45 14             	xor    0x14(%ebp),%eax
c01031a8:	25 ff 0f 00 00       	and    $0xfff,%eax
c01031ad:	85 c0                	test   %eax,%eax
c01031af:	74 24                	je     c01031d5 <boot_map_segment+0x3d>
c01031b1:	c7 44 24 0c 16 69 10 	movl   $0xc0106916,0xc(%esp)
c01031b8:	c0 
c01031b9:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c01031c0:	c0 
c01031c1:	c7 44 24 04 fa 00 00 	movl   $0xfa,0x4(%esp)
c01031c8:	00 
c01031c9:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c01031d0:	e8 60 d2 ff ff       	call   c0100435 <__panic>
    size_t n = ROUNDUP(size + PGOFF(la), PGSIZE) / PGSIZE;
c01031d5:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
c01031dc:	8b 45 0c             	mov    0xc(%ebp),%eax
c01031df:	25 ff 0f 00 00       	and    $0xfff,%eax
c01031e4:	89 c2                	mov    %eax,%edx
c01031e6:	8b 45 10             	mov    0x10(%ebp),%eax
c01031e9:	01 c2                	add    %eax,%edx
c01031eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01031ee:	01 d0                	add    %edx,%eax
c01031f0:	48                   	dec    %eax
c01031f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
c01031f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01031f7:	ba 00 00 00 00       	mov    $0x0,%edx
c01031fc:	f7 75 f0             	divl   -0x10(%ebp)
c01031ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103202:	29 d0                	sub    %edx,%eax
c0103204:	c1 e8 0c             	shr    $0xc,%eax
c0103207:	89 45 f4             	mov    %eax,-0xc(%ebp)
    la = ROUNDDOWN(la, PGSIZE);
c010320a:	8b 45 0c             	mov    0xc(%ebp),%eax
c010320d:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0103210:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0103213:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103218:	89 45 0c             	mov    %eax,0xc(%ebp)
    pa = ROUNDDOWN(pa, PGSIZE);
c010321b:	8b 45 14             	mov    0x14(%ebp),%eax
c010321e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0103221:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103224:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103229:	89 45 14             	mov    %eax,0x14(%ebp)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
c010322c:	eb 68                	jmp    c0103296 <boot_map_segment+0xfe>
        pte_t *ptep = get_pte(pgdir, la, 1);
c010322e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
c0103235:	00 
c0103236:	8b 45 0c             	mov    0xc(%ebp),%eax
c0103239:	89 44 24 04          	mov    %eax,0x4(%esp)
c010323d:	8b 45 08             	mov    0x8(%ebp),%eax
c0103240:	89 04 24             	mov    %eax,(%esp)
c0103243:	e8 8a 01 00 00       	call   c01033d2 <get_pte>
c0103248:	89 45 e0             	mov    %eax,-0x20(%ebp)
        assert(ptep != NULL);
c010324b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
c010324f:	75 24                	jne    c0103275 <boot_map_segment+0xdd>
c0103251:	c7 44 24 0c 42 69 10 	movl   $0xc0106942,0xc(%esp)
c0103258:	c0 
c0103259:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103260:	c0 
c0103261:	c7 44 24 04 00 01 00 	movl   $0x100,0x4(%esp)
c0103268:	00 
c0103269:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103270:	e8 c0 d1 ff ff       	call   c0100435 <__panic>
        *ptep = pa | PTE_P | perm;
c0103275:	8b 45 14             	mov    0x14(%ebp),%eax
c0103278:	0b 45 18             	or     0x18(%ebp),%eax
c010327b:	83 c8 01             	or     $0x1,%eax
c010327e:	89 c2                	mov    %eax,%edx
c0103280:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0103283:	89 10                	mov    %edx,(%eax)
    for (; n > 0; n --, la += PGSIZE, pa += PGSIZE) {
c0103285:	ff 4d f4             	decl   -0xc(%ebp)
c0103288:	81 45 0c 00 10 00 00 	addl   $0x1000,0xc(%ebp)
c010328f:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
c0103296:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c010329a:	75 92                	jne    c010322e <boot_map_segment+0x96>
    }
}
c010329c:	90                   	nop
c010329d:	90                   	nop
c010329e:	c9                   	leave  
c010329f:	c3                   	ret    

c01032a0 <boot_alloc_page>:

//boot_alloc_page - allocate one page using pmm->alloc_pages(1) 
// return value: the kernel virtual address of this allocated page
//note: this function is used to get the memory for PDT(Page Directory Table)&PT(Page Table)
static void *
boot_alloc_page(void) {
c01032a0:	f3 0f 1e fb          	endbr32 
c01032a4:	55                   	push   %ebp
c01032a5:	89 e5                	mov    %esp,%ebp
c01032a7:	83 ec 28             	sub    $0x28,%esp
    struct Page *p = alloc_page();
c01032aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c01032b1:	e8 74 fa ff ff       	call   c0102d2a <alloc_pages>
c01032b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (p == NULL) {
c01032b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01032bd:	75 1c                	jne    c01032db <boot_alloc_page+0x3b>
        panic("boot_alloc_page failed.\n");
c01032bf:	c7 44 24 08 4f 69 10 	movl   $0xc010694f,0x8(%esp)
c01032c6:	c0 
c01032c7:	c7 44 24 04 0c 01 00 	movl   $0x10c,0x4(%esp)
c01032ce:	00 
c01032cf:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c01032d6:	e8 5a d1 ff ff       	call   c0100435 <__panic>
    }
    return page2kva(p);
c01032db:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01032de:	89 04 24             	mov    %eax,(%esp)
c01032e1:	e8 84 f7 ff ff       	call   c0102a6a <page2kva>
}
c01032e6:	c9                   	leave  
c01032e7:	c3                   	ret    

c01032e8 <pmm_init>:

//pmm_init - setup a pmm to manage physical memory, build PDT&PT to setup paging mechanism 
//         - check the correctness of pmm & paging mechanism, print PDT&PT
void
pmm_init(void) {
c01032e8:	f3 0f 1e fb          	endbr32 
c01032ec:	55                   	push   %ebp
c01032ed:	89 e5                	mov    %esp,%ebp
c01032ef:	83 ec 38             	sub    $0x38,%esp
    // We've already enabled paging
    boot_cr3 = PADDR(boot_pgdir);
c01032f2:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c01032f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01032fa:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
c0103301:	77 23                	ja     c0103326 <pmm_init+0x3e>
c0103303:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103306:	89 44 24 0c          	mov    %eax,0xc(%esp)
c010330a:	c7 44 24 08 e4 68 10 	movl   $0xc01068e4,0x8(%esp)
c0103311:	c0 
c0103312:	c7 44 24 04 16 01 00 	movl   $0x116,0x4(%esp)
c0103319:	00 
c010331a:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103321:	e8 0f d1 ff ff       	call   c0100435 <__panic>
c0103326:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103329:	05 00 00 00 40       	add    $0x40000000,%eax
c010332e:	a3 14 cf 11 c0       	mov    %eax,0xc011cf14
    //We need to alloc/free the physical memory (granularity is 4KB or other size). 
    //So a framework of physical memory manager (struct pmm_manager)is defined in pmm.h
    //First we should init a physical memory manager(pmm) based on the framework.
    //Then pmm can alloc/free the physical memory. 
    //Now the first_fit/best_fit/worst_fit/buddy_system pmm are available.
    init_pmm_manager();
c0103333:	e8 96 f9 ff ff       	call   c0102cce <init_pmm_manager>

    // detect physical memory space, reserve already used memory,
    // then use pmm->init_memmap to create free page list
    page_init();
c0103338:	e8 8f fa ff ff       	call   c0102dcc <page_init>

    //use pmm->check to verify the correctness of the alloc/free function in a pmm
    check_alloc_page();
c010333d:	e8 f3 03 00 00       	call   c0103735 <check_alloc_page>

    check_pgdir();
c0103342:	e8 11 04 00 00       	call   c0103758 <check_pgdir>

    static_assert(KERNBASE % PTSIZE == 0 && KERNTOP % PTSIZE == 0);

    // recursively insert boot_pgdir in itself
    // to form a virtual page table at virtual address VPT
    boot_pgdir[PDX(VPT)] = PADDR(boot_pgdir) | PTE_P | PTE_W;
c0103347:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c010334c:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010334f:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
c0103356:	77 23                	ja     c010337b <pmm_init+0x93>
c0103358:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010335b:	89 44 24 0c          	mov    %eax,0xc(%esp)
c010335f:	c7 44 24 08 e4 68 10 	movl   $0xc01068e4,0x8(%esp)
c0103366:	c0 
c0103367:	c7 44 24 04 2c 01 00 	movl   $0x12c,0x4(%esp)
c010336e:	00 
c010336f:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103376:	e8 ba d0 ff ff       	call   c0100435 <__panic>
c010337b:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010337e:	8d 90 00 00 00 40    	lea    0x40000000(%eax),%edx
c0103384:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103389:	05 ac 0f 00 00       	add    $0xfac,%eax
c010338e:	83 ca 03             	or     $0x3,%edx
c0103391:	89 10                	mov    %edx,(%eax)

    // map all physical memory to linear memory with base linear addr KERNBASE
    // linear_addr KERNBASE ~ KERNBASE + KMEMSIZE = phy_addr 0 ~ KMEMSIZE
    boot_map_segment(boot_pgdir, KERNBASE, KMEMSIZE, 0, PTE_W);
c0103393:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103398:	c7 44 24 10 02 00 00 	movl   $0x2,0x10(%esp)
c010339f:	00 
c01033a0:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
c01033a7:	00 
c01033a8:	c7 44 24 08 00 00 00 	movl   $0x38000000,0x8(%esp)
c01033af:	38 
c01033b0:	c7 44 24 04 00 00 00 	movl   $0xc0000000,0x4(%esp)
c01033b7:	c0 
c01033b8:	89 04 24             	mov    %eax,(%esp)
c01033bb:	e8 d8 fd ff ff       	call   c0103198 <boot_map_segment>

    // Since we are using bootloader's GDT,
    // we should reload gdt (second time, the last time) to get user segments and the TSS
    // map virtual_addr 0 ~ 4G = linear_addr 0 ~ 4G
    // then set kernel stack (ss:esp) in TSS, setup TSS in gdt, load TSS
    gdt_init();
c01033c0:	e8 1b f8 ff ff       	call   c0102be0 <gdt_init>

    //now the basic virtual memory map(see memalyout.h) is established.
    //check the correctness of the basic virtual memory map.
    check_boot_pgdir();
c01033c5:	e8 2e 0a 00 00       	call   c0103df8 <check_boot_pgdir>

    print_pgdir();
c01033ca:	e8 b3 0e 00 00       	call   c0104282 <print_pgdir>

}
c01033cf:	90                   	nop
c01033d0:	c9                   	leave  
c01033d1:	c3                   	ret    

c01033d2 <get_pte>:
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
//此函数找到一个虚地址对应的二级页表项的内核虚地址，如果此二级页表项不存在，则分配一个包含此项的二级页表。
pte_t *
get_pte(pde_t *pgdir, uintptr_t la, bool create) {
c01033d2:	f3 0f 1e fb          	endbr32 
c01033d6:	55                   	push   %ebp
c01033d7:	89 e5                	mov    %esp,%ebp
c01033d9:	83 ec 38             	sub    $0x38,%esp

PTE_U 0x004 表示可以读取对应地址的物理内存页内容
*/

//#if 0
    pde_t *pdep = &pgdir[PDX(la)];   // (1) find page directory entry
c01033dc:	8b 45 0c             	mov    0xc(%ebp),%eax
c01033df:	c1 e8 16             	shr    $0x16,%eax
c01033e2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c01033e9:	8b 45 08             	mov    0x8(%ebp),%eax
c01033ec:	01 d0                	add    %edx,%eax
c01033ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(!(*pdep & PTE_P)){
c01033f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01033f4:	8b 00                	mov    (%eax),%eax
c01033f6:	83 e0 01             	and    $0x1,%eax
c01033f9:	85 c0                	test   %eax,%eax
c01033fb:	0f 85 af 00 00 00    	jne    c01034b0 <get_pte+0xde>
        struct Page *page;
		if (!create || (page = alloc_page()) == NULL) {
c0103401:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0103405:	74 15                	je     c010341c <get_pte+0x4a>
c0103407:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c010340e:	e8 17 f9 ff ff       	call   c0102d2a <alloc_pages>
c0103413:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103416:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c010341a:	75 0a                	jne    c0103426 <get_pte+0x54>
		// (2) check if entry is not present
        // (3) check if creating is needed, then alloc page for page table
			return NULL;  // CAUTION: this page is used for page table, not for common data page
c010341c:	b8 00 00 00 00       	mov    $0x0,%eax
c0103421:	e9 e7 00 00 00       	jmp    c010350d <get_pte+0x13b>
		}
        set_page_ref(page, 1);  // (4) set page reference
c0103426:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c010342d:	00 
c010342e:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103431:	89 04 24             	mov    %eax,(%esp)
c0103434:	e8 e5 f6 ff ff       	call   c0102b1e <set_page_ref>
        uintptr_t pa = page2pa(page); // (5) get linear address of page
c0103439:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010343c:	89 04 24             	mov    %eax,(%esp)
c010343f:	e8 c1 f5 ff ff       	call   c0102a05 <page2pa>
c0103444:	89 45 ec             	mov    %eax,-0x14(%ebp)
        memset(KADDR(pa), 0, PGSIZE); // (6) clear page content using memset
c0103447:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010344a:	89 45 e8             	mov    %eax,-0x18(%ebp)
c010344d:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0103450:	c1 e8 0c             	shr    $0xc,%eax
c0103453:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0103456:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c010345b:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
c010345e:	72 23                	jb     c0103483 <get_pte+0xb1>
c0103460:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0103463:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0103467:	c7 44 24 08 40 68 10 	movl   $0xc0106840,0x8(%esp)
c010346e:	c0 
c010346f:	c7 44 24 04 7f 01 00 	movl   $0x17f,0x4(%esp)
c0103476:	00 
c0103477:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c010347e:	e8 b2 cf ff ff       	call   c0100435 <__panic>
c0103483:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0103486:	2d 00 00 00 40       	sub    $0x40000000,%eax
c010348b:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
c0103492:	00 
c0103493:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c010349a:	00 
c010349b:	89 04 24             	mov    %eax,(%esp)
c010349e:	e8 1e 24 00 00       	call   c01058c1 <memset>
        *pdep = pa | PTE_U | PTE_W | PTE_P; // (7) set page directory entry's permission
c01034a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01034a6:	83 c8 07             	or     $0x7,%eax
c01034a9:	89 c2                	mov    %eax,%edx
c01034ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01034ae:	89 10                	mov    %edx,(%eax)
    }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep)))[PTX(la)]; // (8) return page table entry
c01034b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01034b3:	8b 00                	mov    (%eax),%eax
c01034b5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c01034ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
c01034bd:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01034c0:	c1 e8 0c             	shr    $0xc,%eax
c01034c3:	89 45 dc             	mov    %eax,-0x24(%ebp)
c01034c6:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c01034cb:	39 45 dc             	cmp    %eax,-0x24(%ebp)
c01034ce:	72 23                	jb     c01034f3 <get_pte+0x121>
c01034d0:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01034d3:	89 44 24 0c          	mov    %eax,0xc(%esp)
c01034d7:	c7 44 24 08 40 68 10 	movl   $0xc0106840,0x8(%esp)
c01034de:	c0 
c01034df:	c7 44 24 04 82 01 00 	movl   $0x182,0x4(%esp)
c01034e6:	00 
c01034e7:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c01034ee:	e8 42 cf ff ff       	call   c0100435 <__panic>
c01034f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01034f6:	2d 00 00 00 40       	sub    $0x40000000,%eax
c01034fb:	89 c2                	mov    %eax,%edx
c01034fd:	8b 45 0c             	mov    0xc(%ebp),%eax
c0103500:	c1 e8 0c             	shr    $0xc,%eax
c0103503:	25 ff 03 00 00       	and    $0x3ff,%eax
c0103508:	c1 e0 02             	shl    $0x2,%eax
c010350b:	01 d0                	add    %edx,%eax
//#endif
    
    
        
    
}
c010350d:	c9                   	leave  
c010350e:	c3                   	ret    

c010350f <get_page>:

//get_page - get related Page struct for linear address la using PDT pgdir
struct Page *
get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store) {
c010350f:	f3 0f 1e fb          	endbr32 
c0103513:	55                   	push   %ebp
c0103514:	89 e5                	mov    %esp,%ebp
c0103516:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
c0103519:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c0103520:	00 
c0103521:	8b 45 0c             	mov    0xc(%ebp),%eax
c0103524:	89 44 24 04          	mov    %eax,0x4(%esp)
c0103528:	8b 45 08             	mov    0x8(%ebp),%eax
c010352b:	89 04 24             	mov    %eax,(%esp)
c010352e:	e8 9f fe ff ff       	call   c01033d2 <get_pte>
c0103533:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep_store != NULL) {
c0103536:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c010353a:	74 08                	je     c0103544 <get_page+0x35>
        *ptep_store = ptep;
c010353c:	8b 45 10             	mov    0x10(%ebp),%eax
c010353f:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0103542:	89 10                	mov    %edx,(%eax)
    }
    if (ptep != NULL && *ptep & PTE_P) {
c0103544:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0103548:	74 1b                	je     c0103565 <get_page+0x56>
c010354a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010354d:	8b 00                	mov    (%eax),%eax
c010354f:	83 e0 01             	and    $0x1,%eax
c0103552:	85 c0                	test   %eax,%eax
c0103554:	74 0f                	je     c0103565 <get_page+0x56>
        return pte2page(*ptep);
c0103556:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103559:	8b 00                	mov    (%eax),%eax
c010355b:	89 04 24             	mov    %eax,(%esp)
c010355e:	e8 5b f5 ff ff       	call   c0102abe <pte2page>
c0103563:	eb 05                	jmp    c010356a <get_page+0x5b>
    }
    return NULL;
c0103565:	b8 00 00 00 00       	mov    $0x0,%eax
}
c010356a:	c9                   	leave  
c010356b:	c3                   	ret    

c010356c <page_remove_pte>:

//page_remove_pte - free an Page sturct which is related linear address la
//                - and clean(invalidate) pte which is related linear address la
//note: PT is changed, so the TLB need to be invalidate 
static inline void
page_remove_pte(pde_t *pgdir, uintptr_t la, pte_t *ptep) {
c010356c:	55                   	push   %ebp
c010356d:	89 e5                	mov    %esp,%ebp
c010356f:	83 ec 28             	sub    $0x28,%esp
     *                        edited are the ones currently in use by the processor.
     * DEFINEs:
     *   PTE_P           0x001                   // page table/directory entry flags bit : Present
     */
//#if 0
    if (*ptep & PTE_P) {                      //(1) check if this page table entry is present
c0103572:	8b 45 10             	mov    0x10(%ebp),%eax
c0103575:	8b 00                	mov    (%eax),%eax
c0103577:	83 e0 01             	and    $0x1,%eax
c010357a:	85 c0                	test   %eax,%eax
c010357c:	74 4d                	je     c01035cb <page_remove_pte+0x5f>
        struct Page *page = pte2page(*ptep); //(2) find corresponding page to pte
c010357e:	8b 45 10             	mov    0x10(%ebp),%eax
c0103581:	8b 00                	mov    (%eax),%eax
c0103583:	89 04 24             	mov    %eax,(%esp)
c0103586:	e8 33 f5 ff ff       	call   c0102abe <pte2page>
c010358b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (page_ref_dec(page) == 0) { //(3) decrease page reference
c010358e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103591:	89 04 24             	mov    %eax,(%esp)
c0103594:	e8 aa f5 ff ff       	call   c0102b43 <page_ref_dec>
c0103599:	85 c0                	test   %eax,%eax
c010359b:	75 13                	jne    c01035b0 <page_remove_pte+0x44>
            free_page(page); ////(4) and free this page when page reference reachs 0
c010359d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c01035a4:	00 
c01035a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01035a8:	89 04 24             	mov    %eax,(%esp)
c01035ab:	e8 b6 f7 ff ff       	call   c0102d66 <free_pages>
		}
		*ptep = 0; //(5) clear second page table entry
c01035b0:	8b 45 10             	mov    0x10(%ebp),%eax
c01035b3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
         tlb_invalidate(pgdir, la); //(6) flush tlb
c01035b9:	8b 45 0c             	mov    0xc(%ebp),%eax
c01035bc:	89 44 24 04          	mov    %eax,0x4(%esp)
c01035c0:	8b 45 08             	mov    0x8(%ebp),%eax
c01035c3:	89 04 24             	mov    %eax,(%esp)
c01035c6:	e8 09 01 00 00       	call   c01036d4 <tlb_invalidate>
    }
//#endif
}
c01035cb:	90                   	nop
c01035cc:	c9                   	leave  
c01035cd:	c3                   	ret    

c01035ce <page_remove>:

//page_remove - free an Page which is related linear address la and has an validated pte
void
page_remove(pde_t *pgdir, uintptr_t la) {
c01035ce:	f3 0f 1e fb          	endbr32 
c01035d2:	55                   	push   %ebp
c01035d3:	89 e5                	mov    %esp,%ebp
c01035d5:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep = get_pte(pgdir, la, 0);
c01035d8:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c01035df:	00 
c01035e0:	8b 45 0c             	mov    0xc(%ebp),%eax
c01035e3:	89 44 24 04          	mov    %eax,0x4(%esp)
c01035e7:	8b 45 08             	mov    0x8(%ebp),%eax
c01035ea:	89 04 24             	mov    %eax,(%esp)
c01035ed:	e8 e0 fd ff ff       	call   c01033d2 <get_pte>
c01035f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep != NULL) {
c01035f5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c01035f9:	74 19                	je     c0103614 <page_remove+0x46>
        page_remove_pte(pgdir, la, ptep);
c01035fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01035fe:	89 44 24 08          	mov    %eax,0x8(%esp)
c0103602:	8b 45 0c             	mov    0xc(%ebp),%eax
c0103605:	89 44 24 04          	mov    %eax,0x4(%esp)
c0103609:	8b 45 08             	mov    0x8(%ebp),%eax
c010360c:	89 04 24             	mov    %eax,(%esp)
c010360f:	e8 58 ff ff ff       	call   c010356c <page_remove_pte>
    }
}
c0103614:	90                   	nop
c0103615:	c9                   	leave  
c0103616:	c3                   	ret    

c0103617 <page_insert>:
//  la:    the linear address need to map
//  perm:  the permission of this Page which is setted in related pte
// return value: always 0
//note: PT is changed, so the TLB need to be invalidate 
int
page_insert(pde_t *pgdir, struct Page *page, uintptr_t la, uint32_t perm) {
c0103617:	f3 0f 1e fb          	endbr32 
c010361b:	55                   	push   %ebp
c010361c:	89 e5                	mov    %esp,%ebp
c010361e:	83 ec 28             	sub    $0x28,%esp
    pte_t *ptep = get_pte(pgdir, la, 1);
c0103621:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
c0103628:	00 
c0103629:	8b 45 10             	mov    0x10(%ebp),%eax
c010362c:	89 44 24 04          	mov    %eax,0x4(%esp)
c0103630:	8b 45 08             	mov    0x8(%ebp),%eax
c0103633:	89 04 24             	mov    %eax,(%esp)
c0103636:	e8 97 fd ff ff       	call   c01033d2 <get_pte>
c010363b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (ptep == NULL) {
c010363e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0103642:	75 0a                	jne    c010364e <page_insert+0x37>
        return -E_NO_MEM;
c0103644:	b8 fc ff ff ff       	mov    $0xfffffffc,%eax
c0103649:	e9 84 00 00 00       	jmp    c01036d2 <page_insert+0xbb>
    }
    page_ref_inc(page);
c010364e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0103651:	89 04 24             	mov    %eax,(%esp)
c0103654:	e8 d3 f4 ff ff       	call   c0102b2c <page_ref_inc>
    if (*ptep & PTE_P) {
c0103659:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010365c:	8b 00                	mov    (%eax),%eax
c010365e:	83 e0 01             	and    $0x1,%eax
c0103661:	85 c0                	test   %eax,%eax
c0103663:	74 3e                	je     c01036a3 <page_insert+0x8c>
        struct Page *p = pte2page(*ptep);
c0103665:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103668:	8b 00                	mov    (%eax),%eax
c010366a:	89 04 24             	mov    %eax,(%esp)
c010366d:	e8 4c f4 ff ff       	call   c0102abe <pte2page>
c0103672:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (p == page) {
c0103675:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103678:	3b 45 0c             	cmp    0xc(%ebp),%eax
c010367b:	75 0d                	jne    c010368a <page_insert+0x73>
            page_ref_dec(page);
c010367d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0103680:	89 04 24             	mov    %eax,(%esp)
c0103683:	e8 bb f4 ff ff       	call   c0102b43 <page_ref_dec>
c0103688:	eb 19                	jmp    c01036a3 <page_insert+0x8c>
        }
        else {
            page_remove_pte(pgdir, la, ptep);
c010368a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010368d:	89 44 24 08          	mov    %eax,0x8(%esp)
c0103691:	8b 45 10             	mov    0x10(%ebp),%eax
c0103694:	89 44 24 04          	mov    %eax,0x4(%esp)
c0103698:	8b 45 08             	mov    0x8(%ebp),%eax
c010369b:	89 04 24             	mov    %eax,(%esp)
c010369e:	e8 c9 fe ff ff       	call   c010356c <page_remove_pte>
        }
    }
    *ptep = page2pa(page) | PTE_P | perm;
c01036a3:	8b 45 0c             	mov    0xc(%ebp),%eax
c01036a6:	89 04 24             	mov    %eax,(%esp)
c01036a9:	e8 57 f3 ff ff       	call   c0102a05 <page2pa>
c01036ae:	0b 45 14             	or     0x14(%ebp),%eax
c01036b1:	83 c8 01             	or     $0x1,%eax
c01036b4:	89 c2                	mov    %eax,%edx
c01036b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01036b9:	89 10                	mov    %edx,(%eax)
    tlb_invalidate(pgdir, la);
c01036bb:	8b 45 10             	mov    0x10(%ebp),%eax
c01036be:	89 44 24 04          	mov    %eax,0x4(%esp)
c01036c2:	8b 45 08             	mov    0x8(%ebp),%eax
c01036c5:	89 04 24             	mov    %eax,(%esp)
c01036c8:	e8 07 00 00 00       	call   c01036d4 <tlb_invalidate>
    return 0;
c01036cd:	b8 00 00 00 00       	mov    $0x0,%eax
}
c01036d2:	c9                   	leave  
c01036d3:	c3                   	ret    

c01036d4 <tlb_invalidate>:

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void
tlb_invalidate(pde_t *pgdir, uintptr_t la) {
c01036d4:	f3 0f 1e fb          	endbr32 
c01036d8:	55                   	push   %ebp
c01036d9:	89 e5                	mov    %esp,%ebp
c01036db:	83 ec 28             	sub    $0x28,%esp
}

static inline uintptr_t
rcr3(void) {
    uintptr_t cr3;
    asm volatile ("mov %%cr3, %0" : "=r" (cr3) :: "memory");
c01036de:	0f 20 d8             	mov    %cr3,%eax
c01036e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    return cr3;
c01036e4:	8b 55 f0             	mov    -0x10(%ebp),%edx
    if (rcr3() == PADDR(pgdir)) {
c01036e7:	8b 45 08             	mov    0x8(%ebp),%eax
c01036ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01036ed:	81 7d f4 ff ff ff bf 	cmpl   $0xbfffffff,-0xc(%ebp)
c01036f4:	77 23                	ja     c0103719 <tlb_invalidate+0x45>
c01036f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01036f9:	89 44 24 0c          	mov    %eax,0xc(%esp)
c01036fd:	c7 44 24 08 e4 68 10 	movl   $0xc01068e4,0x8(%esp)
c0103704:	c0 
c0103705:	c7 44 24 04 e2 01 00 	movl   $0x1e2,0x4(%esp)
c010370c:	00 
c010370d:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103714:	e8 1c cd ff ff       	call   c0100435 <__panic>
c0103719:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010371c:	05 00 00 00 40       	add    $0x40000000,%eax
c0103721:	39 d0                	cmp    %edx,%eax
c0103723:	75 0d                	jne    c0103732 <tlb_invalidate+0x5e>
        invlpg((void *)la);
c0103725:	8b 45 0c             	mov    0xc(%ebp),%eax
c0103728:	89 45 ec             	mov    %eax,-0x14(%ebp)
}

static inline void
invlpg(void *addr) {
    asm volatile ("invlpg (%0)" :: "r" (addr) : "memory");
c010372b:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010372e:	0f 01 38             	invlpg (%eax)
}
c0103731:	90                   	nop
    }
}
c0103732:	90                   	nop
c0103733:	c9                   	leave  
c0103734:	c3                   	ret    

c0103735 <check_alloc_page>:

static void
check_alloc_page(void) {
c0103735:	f3 0f 1e fb          	endbr32 
c0103739:	55                   	push   %ebp
c010373a:	89 e5                	mov    %esp,%ebp
c010373c:	83 ec 18             	sub    $0x18,%esp
    pmm_manager->check();
c010373f:	a1 10 cf 11 c0       	mov    0xc011cf10,%eax
c0103744:	8b 40 18             	mov    0x18(%eax),%eax
c0103747:	ff d0                	call   *%eax
    cprintf("check_alloc_page() succeeded!\n");
c0103749:	c7 04 24 68 69 10 c0 	movl   $0xc0106968,(%esp)
c0103750:	e8 74 cb ff ff       	call   c01002c9 <cprintf>
}
c0103755:	90                   	nop
c0103756:	c9                   	leave  
c0103757:	c3                   	ret    

c0103758 <check_pgdir>:

static void
check_pgdir(void) {
c0103758:	f3 0f 1e fb          	endbr32 
c010375c:	55                   	push   %ebp
c010375d:	89 e5                	mov    %esp,%ebp
c010375f:	83 ec 38             	sub    $0x38,%esp
    assert(npage <= KMEMSIZE / PGSIZE);
c0103762:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c0103767:	3d 00 80 03 00       	cmp    $0x38000,%eax
c010376c:	76 24                	jbe    c0103792 <check_pgdir+0x3a>
c010376e:	c7 44 24 0c 87 69 10 	movl   $0xc0106987,0xc(%esp)
c0103775:	c0 
c0103776:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c010377d:	c0 
c010377e:	c7 44 24 04 ef 01 00 	movl   $0x1ef,0x4(%esp)
c0103785:	00 
c0103786:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c010378d:	e8 a3 cc ff ff       	call   c0100435 <__panic>
    assert(boot_pgdir != NULL && (uint32_t)PGOFF(boot_pgdir) == 0);
c0103792:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103797:	85 c0                	test   %eax,%eax
c0103799:	74 0e                	je     c01037a9 <check_pgdir+0x51>
c010379b:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c01037a0:	25 ff 0f 00 00       	and    $0xfff,%eax
c01037a5:	85 c0                	test   %eax,%eax
c01037a7:	74 24                	je     c01037cd <check_pgdir+0x75>
c01037a9:	c7 44 24 0c a4 69 10 	movl   $0xc01069a4,0xc(%esp)
c01037b0:	c0 
c01037b1:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c01037b8:	c0 
c01037b9:	c7 44 24 04 f0 01 00 	movl   $0x1f0,0x4(%esp)
c01037c0:	00 
c01037c1:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c01037c8:	e8 68 cc ff ff       	call   c0100435 <__panic>
    assert(get_page(boot_pgdir, 0x0, NULL) == NULL);
c01037cd:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c01037d2:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c01037d9:	00 
c01037da:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c01037e1:	00 
c01037e2:	89 04 24             	mov    %eax,(%esp)
c01037e5:	e8 25 fd ff ff       	call   c010350f <get_page>
c01037ea:	85 c0                	test   %eax,%eax
c01037ec:	74 24                	je     c0103812 <check_pgdir+0xba>
c01037ee:	c7 44 24 0c dc 69 10 	movl   $0xc01069dc,0xc(%esp)
c01037f5:	c0 
c01037f6:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c01037fd:	c0 
c01037fe:	c7 44 24 04 f1 01 00 	movl   $0x1f1,0x4(%esp)
c0103805:	00 
c0103806:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c010380d:	e8 23 cc ff ff       	call   c0100435 <__panic>

    struct Page *p1, *p2;
    p1 = alloc_page();
c0103812:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0103819:	e8 0c f5 ff ff       	call   c0102d2a <alloc_pages>
c010381e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    assert(page_insert(boot_pgdir, p1, 0x0, 0) == 0);
c0103821:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103826:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
c010382d:	00 
c010382e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c0103835:	00 
c0103836:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0103839:	89 54 24 04          	mov    %edx,0x4(%esp)
c010383d:	89 04 24             	mov    %eax,(%esp)
c0103840:	e8 d2 fd ff ff       	call   c0103617 <page_insert>
c0103845:	85 c0                	test   %eax,%eax
c0103847:	74 24                	je     c010386d <check_pgdir+0x115>
c0103849:	c7 44 24 0c 04 6a 10 	movl   $0xc0106a04,0xc(%esp)
c0103850:	c0 
c0103851:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103858:	c0 
c0103859:	c7 44 24 04 f5 01 00 	movl   $0x1f5,0x4(%esp)
c0103860:	00 
c0103861:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103868:	e8 c8 cb ff ff       	call   c0100435 <__panic>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir, 0x0, 0)) != NULL);
c010386d:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103872:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c0103879:	00 
c010387a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0103881:	00 
c0103882:	89 04 24             	mov    %eax,(%esp)
c0103885:	e8 48 fb ff ff       	call   c01033d2 <get_pte>
c010388a:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010388d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0103891:	75 24                	jne    c01038b7 <check_pgdir+0x15f>
c0103893:	c7 44 24 0c 30 6a 10 	movl   $0xc0106a30,0xc(%esp)
c010389a:	c0 
c010389b:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c01038a2:	c0 
c01038a3:	c7 44 24 04 f8 01 00 	movl   $0x1f8,0x4(%esp)
c01038aa:	00 
c01038ab:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c01038b2:	e8 7e cb ff ff       	call   c0100435 <__panic>
    assert(pte2page(*ptep) == p1);
c01038b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01038ba:	8b 00                	mov    (%eax),%eax
c01038bc:	89 04 24             	mov    %eax,(%esp)
c01038bf:	e8 fa f1 ff ff       	call   c0102abe <pte2page>
c01038c4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c01038c7:	74 24                	je     c01038ed <check_pgdir+0x195>
c01038c9:	c7 44 24 0c 5d 6a 10 	movl   $0xc0106a5d,0xc(%esp)
c01038d0:	c0 
c01038d1:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c01038d8:	c0 
c01038d9:	c7 44 24 04 f9 01 00 	movl   $0x1f9,0x4(%esp)
c01038e0:	00 
c01038e1:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c01038e8:	e8 48 cb ff ff       	call   c0100435 <__panic>
    assert(page_ref(p1) == 1);
c01038ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01038f0:	89 04 24             	mov    %eax,(%esp)
c01038f3:	e8 1c f2 ff ff       	call   c0102b14 <page_ref>
c01038f8:	83 f8 01             	cmp    $0x1,%eax
c01038fb:	74 24                	je     c0103921 <check_pgdir+0x1c9>
c01038fd:	c7 44 24 0c 73 6a 10 	movl   $0xc0106a73,0xc(%esp)
c0103904:	c0 
c0103905:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c010390c:	c0 
c010390d:	c7 44 24 04 fa 01 00 	movl   $0x1fa,0x4(%esp)
c0103914:	00 
c0103915:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c010391c:	e8 14 cb ff ff       	call   c0100435 <__panic>

    ptep = &((pte_t *)KADDR(PDE_ADDR(boot_pgdir[0])))[1];
c0103921:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103926:	8b 00                	mov    (%eax),%eax
c0103928:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c010392d:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0103930:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103933:	c1 e8 0c             	shr    $0xc,%eax
c0103936:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0103939:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c010393e:	39 45 e8             	cmp    %eax,-0x18(%ebp)
c0103941:	72 23                	jb     c0103966 <check_pgdir+0x20e>
c0103943:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103946:	89 44 24 0c          	mov    %eax,0xc(%esp)
c010394a:	c7 44 24 08 40 68 10 	movl   $0xc0106840,0x8(%esp)
c0103951:	c0 
c0103952:	c7 44 24 04 fc 01 00 	movl   $0x1fc,0x4(%esp)
c0103959:	00 
c010395a:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103961:	e8 cf ca ff ff       	call   c0100435 <__panic>
c0103966:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103969:	2d 00 00 00 40       	sub    $0x40000000,%eax
c010396e:	83 c0 04             	add    $0x4,%eax
c0103971:	89 45 f0             	mov    %eax,-0x10(%ebp)
    assert(get_pte(boot_pgdir, PGSIZE, 0) == ptep);
c0103974:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103979:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c0103980:	00 
c0103981:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
c0103988:	00 
c0103989:	89 04 24             	mov    %eax,(%esp)
c010398c:	e8 41 fa ff ff       	call   c01033d2 <get_pte>
c0103991:	39 45 f0             	cmp    %eax,-0x10(%ebp)
c0103994:	74 24                	je     c01039ba <check_pgdir+0x262>
c0103996:	c7 44 24 0c 88 6a 10 	movl   $0xc0106a88,0xc(%esp)
c010399d:	c0 
c010399e:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c01039a5:	c0 
c01039a6:	c7 44 24 04 fd 01 00 	movl   $0x1fd,0x4(%esp)
c01039ad:	00 
c01039ae:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c01039b5:	e8 7b ca ff ff       	call   c0100435 <__panic>

    p2 = alloc_page();
c01039ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c01039c1:	e8 64 f3 ff ff       	call   c0102d2a <alloc_pages>
c01039c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    assert(page_insert(boot_pgdir, p2, PGSIZE, PTE_U | PTE_W) == 0);
c01039c9:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c01039ce:	c7 44 24 0c 06 00 00 	movl   $0x6,0xc(%esp)
c01039d5:	00 
c01039d6:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
c01039dd:	00 
c01039de:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c01039e1:	89 54 24 04          	mov    %edx,0x4(%esp)
c01039e5:	89 04 24             	mov    %eax,(%esp)
c01039e8:	e8 2a fc ff ff       	call   c0103617 <page_insert>
c01039ed:	85 c0                	test   %eax,%eax
c01039ef:	74 24                	je     c0103a15 <check_pgdir+0x2bd>
c01039f1:	c7 44 24 0c b0 6a 10 	movl   $0xc0106ab0,0xc(%esp)
c01039f8:	c0 
c01039f9:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103a00:	c0 
c0103a01:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
c0103a08:	00 
c0103a09:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103a10:	e8 20 ca ff ff       	call   c0100435 <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
c0103a15:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103a1a:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c0103a21:	00 
c0103a22:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
c0103a29:	00 
c0103a2a:	89 04 24             	mov    %eax,(%esp)
c0103a2d:	e8 a0 f9 ff ff       	call   c01033d2 <get_pte>
c0103a32:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103a35:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0103a39:	75 24                	jne    c0103a5f <check_pgdir+0x307>
c0103a3b:	c7 44 24 0c e8 6a 10 	movl   $0xc0106ae8,0xc(%esp)
c0103a42:	c0 
c0103a43:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103a4a:	c0 
c0103a4b:	c7 44 24 04 01 02 00 	movl   $0x201,0x4(%esp)
c0103a52:	00 
c0103a53:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103a5a:	e8 d6 c9 ff ff       	call   c0100435 <__panic>
    assert(*ptep & PTE_U);
c0103a5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103a62:	8b 00                	mov    (%eax),%eax
c0103a64:	83 e0 04             	and    $0x4,%eax
c0103a67:	85 c0                	test   %eax,%eax
c0103a69:	75 24                	jne    c0103a8f <check_pgdir+0x337>
c0103a6b:	c7 44 24 0c 18 6b 10 	movl   $0xc0106b18,0xc(%esp)
c0103a72:	c0 
c0103a73:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103a7a:	c0 
c0103a7b:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
c0103a82:	00 
c0103a83:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103a8a:	e8 a6 c9 ff ff       	call   c0100435 <__panic>
    assert(*ptep & PTE_W);
c0103a8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103a92:	8b 00                	mov    (%eax),%eax
c0103a94:	83 e0 02             	and    $0x2,%eax
c0103a97:	85 c0                	test   %eax,%eax
c0103a99:	75 24                	jne    c0103abf <check_pgdir+0x367>
c0103a9b:	c7 44 24 0c 26 6b 10 	movl   $0xc0106b26,0xc(%esp)
c0103aa2:	c0 
c0103aa3:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103aaa:	c0 
c0103aab:	c7 44 24 04 03 02 00 	movl   $0x203,0x4(%esp)
c0103ab2:	00 
c0103ab3:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103aba:	e8 76 c9 ff ff       	call   c0100435 <__panic>
    assert(boot_pgdir[0] & PTE_U);
c0103abf:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103ac4:	8b 00                	mov    (%eax),%eax
c0103ac6:	83 e0 04             	and    $0x4,%eax
c0103ac9:	85 c0                	test   %eax,%eax
c0103acb:	75 24                	jne    c0103af1 <check_pgdir+0x399>
c0103acd:	c7 44 24 0c 34 6b 10 	movl   $0xc0106b34,0xc(%esp)
c0103ad4:	c0 
c0103ad5:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103adc:	c0 
c0103add:	c7 44 24 04 04 02 00 	movl   $0x204,0x4(%esp)
c0103ae4:	00 
c0103ae5:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103aec:	e8 44 c9 ff ff       	call   c0100435 <__panic>
    assert(page_ref(p2) == 1);
c0103af1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103af4:	89 04 24             	mov    %eax,(%esp)
c0103af7:	e8 18 f0 ff ff       	call   c0102b14 <page_ref>
c0103afc:	83 f8 01             	cmp    $0x1,%eax
c0103aff:	74 24                	je     c0103b25 <check_pgdir+0x3cd>
c0103b01:	c7 44 24 0c 4a 6b 10 	movl   $0xc0106b4a,0xc(%esp)
c0103b08:	c0 
c0103b09:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103b10:	c0 
c0103b11:	c7 44 24 04 05 02 00 	movl   $0x205,0x4(%esp)
c0103b18:	00 
c0103b19:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103b20:	e8 10 c9 ff ff       	call   c0100435 <__panic>

    assert(page_insert(boot_pgdir, p1, PGSIZE, 0) == 0);
c0103b25:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103b2a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
c0103b31:	00 
c0103b32:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
c0103b39:	00 
c0103b3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0103b3d:	89 54 24 04          	mov    %edx,0x4(%esp)
c0103b41:	89 04 24             	mov    %eax,(%esp)
c0103b44:	e8 ce fa ff ff       	call   c0103617 <page_insert>
c0103b49:	85 c0                	test   %eax,%eax
c0103b4b:	74 24                	je     c0103b71 <check_pgdir+0x419>
c0103b4d:	c7 44 24 0c 5c 6b 10 	movl   $0xc0106b5c,0xc(%esp)
c0103b54:	c0 
c0103b55:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103b5c:	c0 
c0103b5d:	c7 44 24 04 07 02 00 	movl   $0x207,0x4(%esp)
c0103b64:	00 
c0103b65:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103b6c:	e8 c4 c8 ff ff       	call   c0100435 <__panic>
    assert(page_ref(p1) == 2);
c0103b71:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103b74:	89 04 24             	mov    %eax,(%esp)
c0103b77:	e8 98 ef ff ff       	call   c0102b14 <page_ref>
c0103b7c:	83 f8 02             	cmp    $0x2,%eax
c0103b7f:	74 24                	je     c0103ba5 <check_pgdir+0x44d>
c0103b81:	c7 44 24 0c 88 6b 10 	movl   $0xc0106b88,0xc(%esp)
c0103b88:	c0 
c0103b89:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103b90:	c0 
c0103b91:	c7 44 24 04 08 02 00 	movl   $0x208,0x4(%esp)
c0103b98:	00 
c0103b99:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103ba0:	e8 90 c8 ff ff       	call   c0100435 <__panic>
    assert(page_ref(p2) == 0);
c0103ba5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103ba8:	89 04 24             	mov    %eax,(%esp)
c0103bab:	e8 64 ef ff ff       	call   c0102b14 <page_ref>
c0103bb0:	85 c0                	test   %eax,%eax
c0103bb2:	74 24                	je     c0103bd8 <check_pgdir+0x480>
c0103bb4:	c7 44 24 0c 9a 6b 10 	movl   $0xc0106b9a,0xc(%esp)
c0103bbb:	c0 
c0103bbc:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103bc3:	c0 
c0103bc4:	c7 44 24 04 09 02 00 	movl   $0x209,0x4(%esp)
c0103bcb:	00 
c0103bcc:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103bd3:	e8 5d c8 ff ff       	call   c0100435 <__panic>
    assert((ptep = get_pte(boot_pgdir, PGSIZE, 0)) != NULL);
c0103bd8:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103bdd:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c0103be4:	00 
c0103be5:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
c0103bec:	00 
c0103bed:	89 04 24             	mov    %eax,(%esp)
c0103bf0:	e8 dd f7 ff ff       	call   c01033d2 <get_pte>
c0103bf5:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103bf8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0103bfc:	75 24                	jne    c0103c22 <check_pgdir+0x4ca>
c0103bfe:	c7 44 24 0c e8 6a 10 	movl   $0xc0106ae8,0xc(%esp)
c0103c05:	c0 
c0103c06:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103c0d:	c0 
c0103c0e:	c7 44 24 04 0a 02 00 	movl   $0x20a,0x4(%esp)
c0103c15:	00 
c0103c16:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103c1d:	e8 13 c8 ff ff       	call   c0100435 <__panic>
    assert(pte2page(*ptep) == p1);
c0103c22:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103c25:	8b 00                	mov    (%eax),%eax
c0103c27:	89 04 24             	mov    %eax,(%esp)
c0103c2a:	e8 8f ee ff ff       	call   c0102abe <pte2page>
c0103c2f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c0103c32:	74 24                	je     c0103c58 <check_pgdir+0x500>
c0103c34:	c7 44 24 0c 5d 6a 10 	movl   $0xc0106a5d,0xc(%esp)
c0103c3b:	c0 
c0103c3c:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103c43:	c0 
c0103c44:	c7 44 24 04 0b 02 00 	movl   $0x20b,0x4(%esp)
c0103c4b:	00 
c0103c4c:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103c53:	e8 dd c7 ff ff       	call   c0100435 <__panic>
    assert((*ptep & PTE_U) == 0);
c0103c58:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103c5b:	8b 00                	mov    (%eax),%eax
c0103c5d:	83 e0 04             	and    $0x4,%eax
c0103c60:	85 c0                	test   %eax,%eax
c0103c62:	74 24                	je     c0103c88 <check_pgdir+0x530>
c0103c64:	c7 44 24 0c ac 6b 10 	movl   $0xc0106bac,0xc(%esp)
c0103c6b:	c0 
c0103c6c:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103c73:	c0 
c0103c74:	c7 44 24 04 0c 02 00 	movl   $0x20c,0x4(%esp)
c0103c7b:	00 
c0103c7c:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103c83:	e8 ad c7 ff ff       	call   c0100435 <__panic>

    page_remove(boot_pgdir, 0x0);
c0103c88:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103c8d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0103c94:	00 
c0103c95:	89 04 24             	mov    %eax,(%esp)
c0103c98:	e8 31 f9 ff ff       	call   c01035ce <page_remove>
    assert(page_ref(p1) == 1);
c0103c9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103ca0:	89 04 24             	mov    %eax,(%esp)
c0103ca3:	e8 6c ee ff ff       	call   c0102b14 <page_ref>
c0103ca8:	83 f8 01             	cmp    $0x1,%eax
c0103cab:	74 24                	je     c0103cd1 <check_pgdir+0x579>
c0103cad:	c7 44 24 0c 73 6a 10 	movl   $0xc0106a73,0xc(%esp)
c0103cb4:	c0 
c0103cb5:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103cbc:	c0 
c0103cbd:	c7 44 24 04 0f 02 00 	movl   $0x20f,0x4(%esp)
c0103cc4:	00 
c0103cc5:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103ccc:	e8 64 c7 ff ff       	call   c0100435 <__panic>
    assert(page_ref(p2) == 0);
c0103cd1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103cd4:	89 04 24             	mov    %eax,(%esp)
c0103cd7:	e8 38 ee ff ff       	call   c0102b14 <page_ref>
c0103cdc:	85 c0                	test   %eax,%eax
c0103cde:	74 24                	je     c0103d04 <check_pgdir+0x5ac>
c0103ce0:	c7 44 24 0c 9a 6b 10 	movl   $0xc0106b9a,0xc(%esp)
c0103ce7:	c0 
c0103ce8:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103cef:	c0 
c0103cf0:	c7 44 24 04 10 02 00 	movl   $0x210,0x4(%esp)
c0103cf7:	00 
c0103cf8:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103cff:	e8 31 c7 ff ff       	call   c0100435 <__panic>

    page_remove(boot_pgdir, PGSIZE);
c0103d04:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103d09:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
c0103d10:	00 
c0103d11:	89 04 24             	mov    %eax,(%esp)
c0103d14:	e8 b5 f8 ff ff       	call   c01035ce <page_remove>
    assert(page_ref(p1) == 0);
c0103d19:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103d1c:	89 04 24             	mov    %eax,(%esp)
c0103d1f:	e8 f0 ed ff ff       	call   c0102b14 <page_ref>
c0103d24:	85 c0                	test   %eax,%eax
c0103d26:	74 24                	je     c0103d4c <check_pgdir+0x5f4>
c0103d28:	c7 44 24 0c c1 6b 10 	movl   $0xc0106bc1,0xc(%esp)
c0103d2f:	c0 
c0103d30:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103d37:	c0 
c0103d38:	c7 44 24 04 13 02 00 	movl   $0x213,0x4(%esp)
c0103d3f:	00 
c0103d40:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103d47:	e8 e9 c6 ff ff       	call   c0100435 <__panic>
    assert(page_ref(p2) == 0);
c0103d4c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103d4f:	89 04 24             	mov    %eax,(%esp)
c0103d52:	e8 bd ed ff ff       	call   c0102b14 <page_ref>
c0103d57:	85 c0                	test   %eax,%eax
c0103d59:	74 24                	je     c0103d7f <check_pgdir+0x627>
c0103d5b:	c7 44 24 0c 9a 6b 10 	movl   $0xc0106b9a,0xc(%esp)
c0103d62:	c0 
c0103d63:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103d6a:	c0 
c0103d6b:	c7 44 24 04 14 02 00 	movl   $0x214,0x4(%esp)
c0103d72:	00 
c0103d73:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103d7a:	e8 b6 c6 ff ff       	call   c0100435 <__panic>

    assert(page_ref(pde2page(boot_pgdir[0])) == 1);
c0103d7f:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103d84:	8b 00                	mov    (%eax),%eax
c0103d86:	89 04 24             	mov    %eax,(%esp)
c0103d89:	e8 6e ed ff ff       	call   c0102afc <pde2page>
c0103d8e:	89 04 24             	mov    %eax,(%esp)
c0103d91:	e8 7e ed ff ff       	call   c0102b14 <page_ref>
c0103d96:	83 f8 01             	cmp    $0x1,%eax
c0103d99:	74 24                	je     c0103dbf <check_pgdir+0x667>
c0103d9b:	c7 44 24 0c d4 6b 10 	movl   $0xc0106bd4,0xc(%esp)
c0103da2:	c0 
c0103da3:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103daa:	c0 
c0103dab:	c7 44 24 04 16 02 00 	movl   $0x216,0x4(%esp)
c0103db2:	00 
c0103db3:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103dba:	e8 76 c6 ff ff       	call   c0100435 <__panic>
    free_page(pde2page(boot_pgdir[0]));
c0103dbf:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103dc4:	8b 00                	mov    (%eax),%eax
c0103dc6:	89 04 24             	mov    %eax,(%esp)
c0103dc9:	e8 2e ed ff ff       	call   c0102afc <pde2page>
c0103dce:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0103dd5:	00 
c0103dd6:	89 04 24             	mov    %eax,(%esp)
c0103dd9:	e8 88 ef ff ff       	call   c0102d66 <free_pages>
    boot_pgdir[0] = 0;
c0103dde:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103de3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_pgdir() succeeded!\n");
c0103de9:	c7 04 24 fb 6b 10 c0 	movl   $0xc0106bfb,(%esp)
c0103df0:	e8 d4 c4 ff ff       	call   c01002c9 <cprintf>
}
c0103df5:	90                   	nop
c0103df6:	c9                   	leave  
c0103df7:	c3                   	ret    

c0103df8 <check_boot_pgdir>:

static void
check_boot_pgdir(void) {
c0103df8:	f3 0f 1e fb          	endbr32 
c0103dfc:	55                   	push   %ebp
c0103dfd:	89 e5                	mov    %esp,%ebp
c0103dff:	83 ec 38             	sub    $0x38,%esp
    pte_t *ptep;
    int i;
    for (i = 0; i < npage; i += PGSIZE) {
c0103e02:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0103e09:	e9 ca 00 00 00       	jmp    c0103ed8 <check_boot_pgdir+0xe0>
        assert((ptep = get_pte(boot_pgdir, (uintptr_t)KADDR(i), 0)) != NULL);
c0103e0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103e11:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0103e14:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103e17:	c1 e8 0c             	shr    $0xc,%eax
c0103e1a:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0103e1d:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c0103e22:	39 45 e0             	cmp    %eax,-0x20(%ebp)
c0103e25:	72 23                	jb     c0103e4a <check_boot_pgdir+0x52>
c0103e27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103e2a:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0103e2e:	c7 44 24 08 40 68 10 	movl   $0xc0106840,0x8(%esp)
c0103e35:	c0 
c0103e36:	c7 44 24 04 22 02 00 	movl   $0x222,0x4(%esp)
c0103e3d:	00 
c0103e3e:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103e45:	e8 eb c5 ff ff       	call   c0100435 <__panic>
c0103e4a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0103e4d:	2d 00 00 00 40       	sub    $0x40000000,%eax
c0103e52:	89 c2                	mov    %eax,%edx
c0103e54:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103e59:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
c0103e60:	00 
c0103e61:	89 54 24 04          	mov    %edx,0x4(%esp)
c0103e65:	89 04 24             	mov    %eax,(%esp)
c0103e68:	e8 65 f5 ff ff       	call   c01033d2 <get_pte>
c0103e6d:	89 45 dc             	mov    %eax,-0x24(%ebp)
c0103e70:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
c0103e74:	75 24                	jne    c0103e9a <check_boot_pgdir+0xa2>
c0103e76:	c7 44 24 0c 18 6c 10 	movl   $0xc0106c18,0xc(%esp)
c0103e7d:	c0 
c0103e7e:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103e85:	c0 
c0103e86:	c7 44 24 04 22 02 00 	movl   $0x222,0x4(%esp)
c0103e8d:	00 
c0103e8e:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103e95:	e8 9b c5 ff ff       	call   c0100435 <__panic>
        assert(PTE_ADDR(*ptep) == i);
c0103e9a:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0103e9d:	8b 00                	mov    (%eax),%eax
c0103e9f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103ea4:	89 c2                	mov    %eax,%edx
c0103ea6:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0103ea9:	39 c2                	cmp    %eax,%edx
c0103eab:	74 24                	je     c0103ed1 <check_boot_pgdir+0xd9>
c0103ead:	c7 44 24 0c 55 6c 10 	movl   $0xc0106c55,0xc(%esp)
c0103eb4:	c0 
c0103eb5:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103ebc:	c0 
c0103ebd:	c7 44 24 04 23 02 00 	movl   $0x223,0x4(%esp)
c0103ec4:	00 
c0103ec5:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103ecc:	e8 64 c5 ff ff       	call   c0100435 <__panic>
    for (i = 0; i < npage; i += PGSIZE) {
c0103ed1:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
c0103ed8:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0103edb:	a1 80 ce 11 c0       	mov    0xc011ce80,%eax
c0103ee0:	39 c2                	cmp    %eax,%edx
c0103ee2:	0f 82 26 ff ff ff    	jb     c0103e0e <check_boot_pgdir+0x16>
    }

    assert(PDE_ADDR(boot_pgdir[PDX(VPT)]) == PADDR(boot_pgdir));
c0103ee8:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103eed:	05 ac 0f 00 00       	add    $0xfac,%eax
c0103ef2:	8b 00                	mov    (%eax),%eax
c0103ef4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
c0103ef9:	89 c2                	mov    %eax,%edx
c0103efb:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103f00:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0103f03:	81 7d f0 ff ff ff bf 	cmpl   $0xbfffffff,-0x10(%ebp)
c0103f0a:	77 23                	ja     c0103f2f <check_boot_pgdir+0x137>
c0103f0c:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103f0f:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0103f13:	c7 44 24 08 e4 68 10 	movl   $0xc01068e4,0x8(%esp)
c0103f1a:	c0 
c0103f1b:	c7 44 24 04 26 02 00 	movl   $0x226,0x4(%esp)
c0103f22:	00 
c0103f23:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103f2a:	e8 06 c5 ff ff       	call   c0100435 <__panic>
c0103f2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0103f32:	05 00 00 00 40       	add    $0x40000000,%eax
c0103f37:	39 d0                	cmp    %edx,%eax
c0103f39:	74 24                	je     c0103f5f <check_boot_pgdir+0x167>
c0103f3b:	c7 44 24 0c 6c 6c 10 	movl   $0xc0106c6c,0xc(%esp)
c0103f42:	c0 
c0103f43:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103f4a:	c0 
c0103f4b:	c7 44 24 04 26 02 00 	movl   $0x226,0x4(%esp)
c0103f52:	00 
c0103f53:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103f5a:	e8 d6 c4 ff ff       	call   c0100435 <__panic>

    assert(boot_pgdir[0] == 0);
c0103f5f:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103f64:	8b 00                	mov    (%eax),%eax
c0103f66:	85 c0                	test   %eax,%eax
c0103f68:	74 24                	je     c0103f8e <check_boot_pgdir+0x196>
c0103f6a:	c7 44 24 0c a0 6c 10 	movl   $0xc0106ca0,0xc(%esp)
c0103f71:	c0 
c0103f72:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103f79:	c0 
c0103f7a:	c7 44 24 04 28 02 00 	movl   $0x228,0x4(%esp)
c0103f81:	00 
c0103f82:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103f89:	e8 a7 c4 ff ff       	call   c0100435 <__panic>

    struct Page *p;
    p = alloc_page();
c0103f8e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0103f95:	e8 90 ed ff ff       	call   c0102d2a <alloc_pages>
c0103f9a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert(page_insert(boot_pgdir, p, 0x100, PTE_W) == 0);
c0103f9d:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0103fa2:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
c0103fa9:	00 
c0103faa:	c7 44 24 08 00 01 00 	movl   $0x100,0x8(%esp)
c0103fb1:	00 
c0103fb2:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0103fb5:	89 54 24 04          	mov    %edx,0x4(%esp)
c0103fb9:	89 04 24             	mov    %eax,(%esp)
c0103fbc:	e8 56 f6 ff ff       	call   c0103617 <page_insert>
c0103fc1:	85 c0                	test   %eax,%eax
c0103fc3:	74 24                	je     c0103fe9 <check_boot_pgdir+0x1f1>
c0103fc5:	c7 44 24 0c b4 6c 10 	movl   $0xc0106cb4,0xc(%esp)
c0103fcc:	c0 
c0103fcd:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0103fd4:	c0 
c0103fd5:	c7 44 24 04 2c 02 00 	movl   $0x22c,0x4(%esp)
c0103fdc:	00 
c0103fdd:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0103fe4:	e8 4c c4 ff ff       	call   c0100435 <__panic>
    assert(page_ref(p) == 1);
c0103fe9:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0103fec:	89 04 24             	mov    %eax,(%esp)
c0103fef:	e8 20 eb ff ff       	call   c0102b14 <page_ref>
c0103ff4:	83 f8 01             	cmp    $0x1,%eax
c0103ff7:	74 24                	je     c010401d <check_boot_pgdir+0x225>
c0103ff9:	c7 44 24 0c e2 6c 10 	movl   $0xc0106ce2,0xc(%esp)
c0104000:	c0 
c0104001:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0104008:	c0 
c0104009:	c7 44 24 04 2d 02 00 	movl   $0x22d,0x4(%esp)
c0104010:	00 
c0104011:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0104018:	e8 18 c4 ff ff       	call   c0100435 <__panic>
    assert(page_insert(boot_pgdir, p, 0x100 + PGSIZE, PTE_W) == 0);
c010401d:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0104022:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
c0104029:	00 
c010402a:	c7 44 24 08 00 11 00 	movl   $0x1100,0x8(%esp)
c0104031:	00 
c0104032:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0104035:	89 54 24 04          	mov    %edx,0x4(%esp)
c0104039:	89 04 24             	mov    %eax,(%esp)
c010403c:	e8 d6 f5 ff ff       	call   c0103617 <page_insert>
c0104041:	85 c0                	test   %eax,%eax
c0104043:	74 24                	je     c0104069 <check_boot_pgdir+0x271>
c0104045:	c7 44 24 0c f4 6c 10 	movl   $0xc0106cf4,0xc(%esp)
c010404c:	c0 
c010404d:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0104054:	c0 
c0104055:	c7 44 24 04 2e 02 00 	movl   $0x22e,0x4(%esp)
c010405c:	00 
c010405d:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0104064:	e8 cc c3 ff ff       	call   c0100435 <__panic>
    assert(page_ref(p) == 2);
c0104069:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010406c:	89 04 24             	mov    %eax,(%esp)
c010406f:	e8 a0 ea ff ff       	call   c0102b14 <page_ref>
c0104074:	83 f8 02             	cmp    $0x2,%eax
c0104077:	74 24                	je     c010409d <check_boot_pgdir+0x2a5>
c0104079:	c7 44 24 0c 2b 6d 10 	movl   $0xc0106d2b,0xc(%esp)
c0104080:	c0 
c0104081:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0104088:	c0 
c0104089:	c7 44 24 04 2f 02 00 	movl   $0x22f,0x4(%esp)
c0104090:	00 
c0104091:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0104098:	e8 98 c3 ff ff       	call   c0100435 <__panic>

    const char *str = "ucore: Hello world!!";
c010409d:	c7 45 e8 3c 6d 10 c0 	movl   $0xc0106d3c,-0x18(%ebp)
    strcpy((void *)0x100, str);
c01040a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01040a7:	89 44 24 04          	mov    %eax,0x4(%esp)
c01040ab:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
c01040b2:	e8 26 15 00 00       	call   c01055dd <strcpy>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
c01040b7:	c7 44 24 04 00 11 00 	movl   $0x1100,0x4(%esp)
c01040be:	00 
c01040bf:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
c01040c6:	e8 90 15 00 00       	call   c010565b <strcmp>
c01040cb:	85 c0                	test   %eax,%eax
c01040cd:	74 24                	je     c01040f3 <check_boot_pgdir+0x2fb>
c01040cf:	c7 44 24 0c 54 6d 10 	movl   $0xc0106d54,0xc(%esp)
c01040d6:	c0 
c01040d7:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c01040de:	c0 
c01040df:	c7 44 24 04 33 02 00 	movl   $0x233,0x4(%esp)
c01040e6:	00 
c01040e7:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c01040ee:	e8 42 c3 ff ff       	call   c0100435 <__panic>

    *(char *)(page2kva(p) + 0x100) = '\0';
c01040f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01040f6:	89 04 24             	mov    %eax,(%esp)
c01040f9:	e8 6c e9 ff ff       	call   c0102a6a <page2kva>
c01040fe:	05 00 01 00 00       	add    $0x100,%eax
c0104103:	c6 00 00             	movb   $0x0,(%eax)
    assert(strlen((const char *)0x100) == 0);
c0104106:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
c010410d:	e8 6d 14 00 00       	call   c010557f <strlen>
c0104112:	85 c0                	test   %eax,%eax
c0104114:	74 24                	je     c010413a <check_boot_pgdir+0x342>
c0104116:	c7 44 24 0c 8c 6d 10 	movl   $0xc0106d8c,0xc(%esp)
c010411d:	c0 
c010411e:	c7 44 24 08 2d 69 10 	movl   $0xc010692d,0x8(%esp)
c0104125:	c0 
c0104126:	c7 44 24 04 36 02 00 	movl   $0x236,0x4(%esp)
c010412d:	00 
c010412e:	c7 04 24 08 69 10 c0 	movl   $0xc0106908,(%esp)
c0104135:	e8 fb c2 ff ff       	call   c0100435 <__panic>

    free_page(p);
c010413a:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0104141:	00 
c0104142:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104145:	89 04 24             	mov    %eax,(%esp)
c0104148:	e8 19 ec ff ff       	call   c0102d66 <free_pages>
    free_page(pde2page(boot_pgdir[0]));
c010414d:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0104152:	8b 00                	mov    (%eax),%eax
c0104154:	89 04 24             	mov    %eax,(%esp)
c0104157:	e8 a0 e9 ff ff       	call   c0102afc <pde2page>
c010415c:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0104163:	00 
c0104164:	89 04 24             	mov    %eax,(%esp)
c0104167:	e8 fa eb ff ff       	call   c0102d66 <free_pages>
    boot_pgdir[0] = 0;
c010416c:	a1 e0 99 11 c0       	mov    0xc01199e0,%eax
c0104171:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

    cprintf("check_boot_pgdir() succeeded!\n");
c0104177:	c7 04 24 b0 6d 10 c0 	movl   $0xc0106db0,(%esp)
c010417e:	e8 46 c1 ff ff       	call   c01002c9 <cprintf>
}
c0104183:	90                   	nop
c0104184:	c9                   	leave  
c0104185:	c3                   	ret    

c0104186 <perm2str>:

//perm2str - use string 'u,r,w,-' to present the permission
static const char *
perm2str(int perm) {
c0104186:	f3 0f 1e fb          	endbr32 
c010418a:	55                   	push   %ebp
c010418b:	89 e5                	mov    %esp,%ebp
    static char str[4];
    str[0] = (perm & PTE_U) ? 'u' : '-';
c010418d:	8b 45 08             	mov    0x8(%ebp),%eax
c0104190:	83 e0 04             	and    $0x4,%eax
c0104193:	85 c0                	test   %eax,%eax
c0104195:	74 04                	je     c010419b <perm2str+0x15>
c0104197:	b0 75                	mov    $0x75,%al
c0104199:	eb 02                	jmp    c010419d <perm2str+0x17>
c010419b:	b0 2d                	mov    $0x2d,%al
c010419d:	a2 08 cf 11 c0       	mov    %al,0xc011cf08
    str[1] = 'r';
c01041a2:	c6 05 09 cf 11 c0 72 	movb   $0x72,0xc011cf09
    str[2] = (perm & PTE_W) ? 'w' : '-';
c01041a9:	8b 45 08             	mov    0x8(%ebp),%eax
c01041ac:	83 e0 02             	and    $0x2,%eax
c01041af:	85 c0                	test   %eax,%eax
c01041b1:	74 04                	je     c01041b7 <perm2str+0x31>
c01041b3:	b0 77                	mov    $0x77,%al
c01041b5:	eb 02                	jmp    c01041b9 <perm2str+0x33>
c01041b7:	b0 2d                	mov    $0x2d,%al
c01041b9:	a2 0a cf 11 c0       	mov    %al,0xc011cf0a
    str[3] = '\0';
c01041be:	c6 05 0b cf 11 c0 00 	movb   $0x0,0xc011cf0b
    return str;
c01041c5:	b8 08 cf 11 c0       	mov    $0xc011cf08,%eax
}
c01041ca:	5d                   	pop    %ebp
c01041cb:	c3                   	ret    

c01041cc <get_pgtable_items>:
//  table:       the beginning addr of table
//  left_store:  the pointer of the high side of table's next range
//  right_store: the pointer of the low side of table's next range
// return value: 0 - not a invalid item range, perm - a valid item range with perm permission 
static int
get_pgtable_items(size_t left, size_t right, size_t start, uintptr_t *table, size_t *left_store, size_t *right_store) {
c01041cc:	f3 0f 1e fb          	endbr32 
c01041d0:	55                   	push   %ebp
c01041d1:	89 e5                	mov    %esp,%ebp
c01041d3:	83 ec 10             	sub    $0x10,%esp
    if (start >= right) {
c01041d6:	8b 45 10             	mov    0x10(%ebp),%eax
c01041d9:	3b 45 0c             	cmp    0xc(%ebp),%eax
c01041dc:	72 0d                	jb     c01041eb <get_pgtable_items+0x1f>
        return 0;
c01041de:	b8 00 00 00 00       	mov    $0x0,%eax
c01041e3:	e9 98 00 00 00       	jmp    c0104280 <get_pgtable_items+0xb4>
    }
    while (start < right && !(table[start] & PTE_P)) {
        start ++;
c01041e8:	ff 45 10             	incl   0x10(%ebp)
    while (start < right && !(table[start] & PTE_P)) {
c01041eb:	8b 45 10             	mov    0x10(%ebp),%eax
c01041ee:	3b 45 0c             	cmp    0xc(%ebp),%eax
c01041f1:	73 18                	jae    c010420b <get_pgtable_items+0x3f>
c01041f3:	8b 45 10             	mov    0x10(%ebp),%eax
c01041f6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c01041fd:	8b 45 14             	mov    0x14(%ebp),%eax
c0104200:	01 d0                	add    %edx,%eax
c0104202:	8b 00                	mov    (%eax),%eax
c0104204:	83 e0 01             	and    $0x1,%eax
c0104207:	85 c0                	test   %eax,%eax
c0104209:	74 dd                	je     c01041e8 <get_pgtable_items+0x1c>
    }
    if (start < right) {
c010420b:	8b 45 10             	mov    0x10(%ebp),%eax
c010420e:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0104211:	73 68                	jae    c010427b <get_pgtable_items+0xaf>
        if (left_store != NULL) {
c0104213:	83 7d 18 00          	cmpl   $0x0,0x18(%ebp)
c0104217:	74 08                	je     c0104221 <get_pgtable_items+0x55>
            *left_store = start;
c0104219:	8b 45 18             	mov    0x18(%ebp),%eax
c010421c:	8b 55 10             	mov    0x10(%ebp),%edx
c010421f:	89 10                	mov    %edx,(%eax)
        }
        int perm = (table[start ++] & PTE_USER);
c0104221:	8b 45 10             	mov    0x10(%ebp),%eax
c0104224:	8d 50 01             	lea    0x1(%eax),%edx
c0104227:	89 55 10             	mov    %edx,0x10(%ebp)
c010422a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0104231:	8b 45 14             	mov    0x14(%ebp),%eax
c0104234:	01 d0                	add    %edx,%eax
c0104236:	8b 00                	mov    (%eax),%eax
c0104238:	83 e0 07             	and    $0x7,%eax
c010423b:	89 45 fc             	mov    %eax,-0x4(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
c010423e:	eb 03                	jmp    c0104243 <get_pgtable_items+0x77>
            start ++;
c0104240:	ff 45 10             	incl   0x10(%ebp)
        while (start < right && (table[start] & PTE_USER) == perm) {
c0104243:	8b 45 10             	mov    0x10(%ebp),%eax
c0104246:	3b 45 0c             	cmp    0xc(%ebp),%eax
c0104249:	73 1d                	jae    c0104268 <get_pgtable_items+0x9c>
c010424b:	8b 45 10             	mov    0x10(%ebp),%eax
c010424e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
c0104255:	8b 45 14             	mov    0x14(%ebp),%eax
c0104258:	01 d0                	add    %edx,%eax
c010425a:	8b 00                	mov    (%eax),%eax
c010425c:	83 e0 07             	and    $0x7,%eax
c010425f:	89 c2                	mov    %eax,%edx
c0104261:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0104264:	39 c2                	cmp    %eax,%edx
c0104266:	74 d8                	je     c0104240 <get_pgtable_items+0x74>
        }
        if (right_store != NULL) {
c0104268:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
c010426c:	74 08                	je     c0104276 <get_pgtable_items+0xaa>
            *right_store = start;
c010426e:	8b 45 1c             	mov    0x1c(%ebp),%eax
c0104271:	8b 55 10             	mov    0x10(%ebp),%edx
c0104274:	89 10                	mov    %edx,(%eax)
        }
        return perm;
c0104276:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0104279:	eb 05                	jmp    c0104280 <get_pgtable_items+0xb4>
    }
    return 0;
c010427b:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0104280:	c9                   	leave  
c0104281:	c3                   	ret    

c0104282 <print_pgdir>:

//print_pgdir - print the PDT&PT
void
print_pgdir(void) {
c0104282:	f3 0f 1e fb          	endbr32 
c0104286:	55                   	push   %ebp
c0104287:	89 e5                	mov    %esp,%ebp
c0104289:	57                   	push   %edi
c010428a:	56                   	push   %esi
c010428b:	53                   	push   %ebx
c010428c:	83 ec 4c             	sub    $0x4c,%esp
    cprintf("-------------------- BEGIN --------------------\n");
c010428f:	c7 04 24 d0 6d 10 c0 	movl   $0xc0106dd0,(%esp)
c0104296:	e8 2e c0 ff ff       	call   c01002c9 <cprintf>
    size_t left, right = 0, perm;
c010429b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
c01042a2:	e9 fa 00 00 00       	jmp    c01043a1 <print_pgdir+0x11f>
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
c01042a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c01042aa:	89 04 24             	mov    %eax,(%esp)
c01042ad:	e8 d4 fe ff ff       	call   c0104186 <perm2str>
                left * PTSIZE, right * PTSIZE, (right - left) * PTSIZE, perm2str(perm));
c01042b2:	8b 4d dc             	mov    -0x24(%ebp),%ecx
c01042b5:	8b 55 e0             	mov    -0x20(%ebp),%edx
c01042b8:	29 d1                	sub    %edx,%ecx
c01042ba:	89 ca                	mov    %ecx,%edx
        cprintf("PDE(%03x) %08x-%08x %08x %s\n", right - left,
c01042bc:	89 d6                	mov    %edx,%esi
c01042be:	c1 e6 16             	shl    $0x16,%esi
c01042c1:	8b 55 dc             	mov    -0x24(%ebp),%edx
c01042c4:	89 d3                	mov    %edx,%ebx
c01042c6:	c1 e3 16             	shl    $0x16,%ebx
c01042c9:	8b 55 e0             	mov    -0x20(%ebp),%edx
c01042cc:	89 d1                	mov    %edx,%ecx
c01042ce:	c1 e1 16             	shl    $0x16,%ecx
c01042d1:	8b 7d dc             	mov    -0x24(%ebp),%edi
c01042d4:	8b 55 e0             	mov    -0x20(%ebp),%edx
c01042d7:	29 d7                	sub    %edx,%edi
c01042d9:	89 fa                	mov    %edi,%edx
c01042db:	89 44 24 14          	mov    %eax,0x14(%esp)
c01042df:	89 74 24 10          	mov    %esi,0x10(%esp)
c01042e3:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
c01042e7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
c01042eb:	89 54 24 04          	mov    %edx,0x4(%esp)
c01042ef:	c7 04 24 01 6e 10 c0 	movl   $0xc0106e01,(%esp)
c01042f6:	e8 ce bf ff ff       	call   c01002c9 <cprintf>
        size_t l, r = left * NPTEENTRY;
c01042fb:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01042fe:	c1 e0 0a             	shl    $0xa,%eax
c0104301:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
c0104304:	eb 54                	jmp    c010435a <print_pgdir+0xd8>
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
c0104306:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104309:	89 04 24             	mov    %eax,(%esp)
c010430c:	e8 75 fe ff ff       	call   c0104186 <perm2str>
                    l * PGSIZE, r * PGSIZE, (r - l) * PGSIZE, perm2str(perm));
c0104311:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
c0104314:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0104317:	29 d1                	sub    %edx,%ecx
c0104319:	89 ca                	mov    %ecx,%edx
            cprintf("  |-- PTE(%05x) %08x-%08x %08x %s\n", r - l,
c010431b:	89 d6                	mov    %edx,%esi
c010431d:	c1 e6 0c             	shl    $0xc,%esi
c0104320:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0104323:	89 d3                	mov    %edx,%ebx
c0104325:	c1 e3 0c             	shl    $0xc,%ebx
c0104328:	8b 55 d8             	mov    -0x28(%ebp),%edx
c010432b:	89 d1                	mov    %edx,%ecx
c010432d:	c1 e1 0c             	shl    $0xc,%ecx
c0104330:	8b 7d d4             	mov    -0x2c(%ebp),%edi
c0104333:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0104336:	29 d7                	sub    %edx,%edi
c0104338:	89 fa                	mov    %edi,%edx
c010433a:	89 44 24 14          	mov    %eax,0x14(%esp)
c010433e:	89 74 24 10          	mov    %esi,0x10(%esp)
c0104342:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
c0104346:	89 4c 24 08          	mov    %ecx,0x8(%esp)
c010434a:	89 54 24 04          	mov    %edx,0x4(%esp)
c010434e:	c7 04 24 20 6e 10 c0 	movl   $0xc0106e20,(%esp)
c0104355:	e8 6f bf ff ff       	call   c01002c9 <cprintf>
        while ((perm = get_pgtable_items(left * NPTEENTRY, right * NPTEENTRY, r, vpt, &l, &r)) != 0) {
c010435a:	be 00 00 c0 fa       	mov    $0xfac00000,%esi
c010435f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104362:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0104365:	89 d3                	mov    %edx,%ebx
c0104367:	c1 e3 0a             	shl    $0xa,%ebx
c010436a:	8b 55 e0             	mov    -0x20(%ebp),%edx
c010436d:	89 d1                	mov    %edx,%ecx
c010436f:	c1 e1 0a             	shl    $0xa,%ecx
c0104372:	8d 55 d4             	lea    -0x2c(%ebp),%edx
c0104375:	89 54 24 14          	mov    %edx,0x14(%esp)
c0104379:	8d 55 d8             	lea    -0x28(%ebp),%edx
c010437c:	89 54 24 10          	mov    %edx,0x10(%esp)
c0104380:	89 74 24 0c          	mov    %esi,0xc(%esp)
c0104384:	89 44 24 08          	mov    %eax,0x8(%esp)
c0104388:	89 5c 24 04          	mov    %ebx,0x4(%esp)
c010438c:	89 0c 24             	mov    %ecx,(%esp)
c010438f:	e8 38 fe ff ff       	call   c01041cc <get_pgtable_items>
c0104394:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0104397:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c010439b:	0f 85 65 ff ff ff    	jne    c0104306 <print_pgdir+0x84>
    while ((perm = get_pgtable_items(0, NPDEENTRY, right, vpd, &left, &right)) != 0) {
c01043a1:	b9 00 b0 fe fa       	mov    $0xfafeb000,%ecx
c01043a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01043a9:	8d 55 dc             	lea    -0x24(%ebp),%edx
c01043ac:	89 54 24 14          	mov    %edx,0x14(%esp)
c01043b0:	8d 55 e0             	lea    -0x20(%ebp),%edx
c01043b3:	89 54 24 10          	mov    %edx,0x10(%esp)
c01043b7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
c01043bb:	89 44 24 08          	mov    %eax,0x8(%esp)
c01043bf:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
c01043c6:	00 
c01043c7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
c01043ce:	e8 f9 fd ff ff       	call   c01041cc <get_pgtable_items>
c01043d3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c01043d6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c01043da:	0f 85 c7 fe ff ff    	jne    c01042a7 <print_pgdir+0x25>
        }
    }
    cprintf("--------------------- END ---------------------\n");
c01043e0:	c7 04 24 44 6e 10 c0 	movl   $0xc0106e44,(%esp)
c01043e7:	e8 dd be ff ff       	call   c01002c9 <cprintf>
}
c01043ec:	90                   	nop
c01043ed:	83 c4 4c             	add    $0x4c,%esp
c01043f0:	5b                   	pop    %ebx
c01043f1:	5e                   	pop    %esi
c01043f2:	5f                   	pop    %edi
c01043f3:	5d                   	pop    %ebp
c01043f4:	c3                   	ret    

c01043f5 <page2ppn>:
page2ppn(struct Page *page) {
c01043f5:	55                   	push   %ebp
c01043f6:	89 e5                	mov    %esp,%ebp
    return page - pages;
c01043f8:	a1 18 cf 11 c0       	mov    0xc011cf18,%eax
c01043fd:	8b 55 08             	mov    0x8(%ebp),%edx
c0104400:	29 c2                	sub    %eax,%edx
c0104402:	89 d0                	mov    %edx,%eax
c0104404:	c1 f8 02             	sar    $0x2,%eax
c0104407:	69 c0 cd cc cc cc    	imul   $0xcccccccd,%eax,%eax
}
c010440d:	5d                   	pop    %ebp
c010440e:	c3                   	ret    

c010440f <page2pa>:
page2pa(struct Page *page) {
c010440f:	55                   	push   %ebp
c0104410:	89 e5                	mov    %esp,%ebp
c0104412:	83 ec 04             	sub    $0x4,%esp
    return page2ppn(page) << PGSHIFT;
c0104415:	8b 45 08             	mov    0x8(%ebp),%eax
c0104418:	89 04 24             	mov    %eax,(%esp)
c010441b:	e8 d5 ff ff ff       	call   c01043f5 <page2ppn>
c0104420:	c1 e0 0c             	shl    $0xc,%eax
}
c0104423:	c9                   	leave  
c0104424:	c3                   	ret    

c0104425 <page_ref>:
page_ref(struct Page *page) {
c0104425:	55                   	push   %ebp
c0104426:	89 e5                	mov    %esp,%ebp
    return page->ref;
c0104428:	8b 45 08             	mov    0x8(%ebp),%eax
c010442b:	8b 00                	mov    (%eax),%eax
}
c010442d:	5d                   	pop    %ebp
c010442e:	c3                   	ret    

c010442f <set_page_ref>:
set_page_ref(struct Page *page, int val) {
c010442f:	55                   	push   %ebp
c0104430:	89 e5                	mov    %esp,%ebp
    page->ref = val;
c0104432:	8b 45 08             	mov    0x8(%ebp),%eax
c0104435:	8b 55 0c             	mov    0xc(%ebp),%edx
c0104438:	89 10                	mov    %edx,(%eax)
}
c010443a:	90                   	nop
c010443b:	5d                   	pop    %ebp
c010443c:	c3                   	ret    

c010443d <default_init>:
#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

//实现:将双向链表初始化，同时将空闲页总数nr_free初始化为0
static void
default_init(void) {
c010443d:	f3 0f 1e fb          	endbr32 
c0104441:	55                   	push   %ebp
c0104442:	89 e5                	mov    %esp,%ebp
c0104444:	83 ec 10             	sub    $0x10,%esp
c0104447:	c7 45 fc 1c cf 11 c0 	movl   $0xc011cf1c,-0x4(%ebp)
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
c010444e:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0104451:	8b 55 fc             	mov    -0x4(%ebp),%edx
c0104454:	89 50 04             	mov    %edx,0x4(%eax)
c0104457:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010445a:	8b 50 04             	mov    0x4(%eax),%edx
c010445d:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0104460:	89 10                	mov    %edx,(%eax)
}
c0104462:	90                   	nop
    list_init(&free_list);
    nr_free = 0;
c0104463:	c7 05 24 cf 11 c0 00 	movl   $0x0,0xc011cf24
c010446a:	00 00 00 
}
c010446d:	90                   	nop
c010446e:	c9                   	leave  
c010446f:	c3                   	ret    

c0104470 <default_init_memmap>:
综上，具体流程为：遍历块内所有空闲物理页的Page结构，将各个flags置为0以标记物理页帧有效，将property成员置零，使用 SetPageProperty宏置PG_Property标志位来标记各个页有效（具体而言，如果一页的该位为1，则对应页应是一个空闲块的块首页；若为0，则对应页要么是一个已分配块的块首页，要么不是块中首页；另一个标志位PG_Reserved在pmm_init函数里已被置位，这里用于确认对应页不是被OS内核占用的保留页，因而可用于用户程序的分配和回收），清空各物理页的引用计数ref；最后再将首页Page结构的property置为块内总页数，将全局总页数nr_free加上块内总页数，并用page_link这个双链表结点指针集合将块首页连接到空闲块链表里。
*/
//Page:返回传入参数pa开始的第一个物理页，也就是基地址base
//n:代表物理页的个数
static void
default_init_memmap(struct Page *base, size_t n) {
c0104470:	f3 0f 1e fb          	endbr32 
c0104474:	55                   	push   %ebp
c0104475:	89 e5                	mov    %esp,%ebp
c0104477:	83 ec 48             	sub    $0x48,%esp
    assert(n > 0); //判断n是否大于0
c010447a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c010447e:	75 24                	jne    c01044a4 <default_init_memmap+0x34>
c0104480:	c7 44 24 0c 78 6e 10 	movl   $0xc0106e78,0xc(%esp)
c0104487:	c0 
c0104488:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c010448f:	c0 
c0104490:	c7 44 24 04 84 00 00 	movl   $0x84,0x4(%esp)
c0104497:	00 
c0104498:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c010449f:	e8 91 bf ff ff       	call   c0100435 <__panic>
    struct Page *p = base;
c01044a4:	8b 45 08             	mov    0x8(%ebp),%eax
c01044a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for (; p != base + n; p ++) { //初始化n块物理页
c01044aa:	e9 e1 00 00 00       	jmp    c0104590 <default_init_memmap+0x120>
        assert(PageReserved(p)); //检查此页是否为保留页
c01044af:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01044b2:	83 c0 04             	add    $0x4,%eax
c01044b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
c01044bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
 * @addr:   the address to count from
 * */
static inline bool
test_bit(int nr, volatile void *addr) {
    int oldbit;
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c01044bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01044c2:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01044c5:	0f a3 10             	bt     %edx,(%eax)
c01044c8:	19 c0                	sbb    %eax,%eax
c01044ca:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return oldbit != 0;
c01044cd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c01044d1:	0f 95 c0             	setne  %al
c01044d4:	0f b6 c0             	movzbl %al,%eax
c01044d7:	85 c0                	test   %eax,%eax
c01044d9:	75 24                	jne    c01044ff <default_init_memmap+0x8f>
c01044db:	c7 44 24 0c a9 6e 10 	movl   $0xc0106ea9,0xc(%esp)
c01044e2:	c0 
c01044e3:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c01044ea:	c0 
c01044eb:	c7 44 24 04 87 00 00 	movl   $0x87,0x4(%esp)
c01044f2:	00 
c01044f3:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c01044fa:	e8 36 bf ff ff       	call   c0100435 <__panic>
        p->flags = p->property = 0; //标志位清0
c01044ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104502:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
c0104509:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010450c:	8b 50 08             	mov    0x8(%eax),%edx
c010450f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104512:	89 50 04             	mov    %edx,0x4(%eax)
        SetPageProperty(p);       //设置标志位为1 //p->flags should be set bit PG_property (means this page is valid. In pmm_init fun (in pmm.c)
c0104515:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104518:	83 c0 04             	add    $0x4,%eax
c010451b:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
c0104522:	89 45 cc             	mov    %eax,-0x34(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0104525:	8b 45 cc             	mov    -0x34(%ebp),%eax
c0104528:	8b 55 d0             	mov    -0x30(%ebp),%edx
c010452b:	0f ab 10             	bts    %edx,(%eax)
}
c010452e:	90                   	nop
        set_page_ref(p, 0); //清除引用此页的虚拟页的个数
c010452f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0104536:	00 
c0104537:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010453a:	89 04 24             	mov    %eax,(%esp)
c010453d:	e8 ed fe ff ff       	call   c010442f <set_page_ref>
        //加入空闲链表
        list_add_before(&free_list, &(p->page_link)); 
c0104542:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104545:	83 c0 0c             	add    $0xc,%eax
c0104548:	c7 45 e4 1c cf 11 c0 	movl   $0xc011cf1c,-0x1c(%ebp)
c010454f:	89 45 e0             	mov    %eax,-0x20(%ebp)
 * Insert the new element @elm *before* the element @listelm which
 * is already in the list.
 * */
static inline void
list_add_before(list_entry_t *listelm, list_entry_t *elm) {
    __list_add(elm, listelm->prev, listelm);
c0104552:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104555:	8b 00                	mov    (%eax),%eax
c0104557:	8b 55 e0             	mov    -0x20(%ebp),%edx
c010455a:	89 55 dc             	mov    %edx,-0x24(%ebp)
c010455d:	89 45 d8             	mov    %eax,-0x28(%ebp)
c0104560:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104563:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
c0104566:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104569:	8b 55 dc             	mov    -0x24(%ebp),%edx
c010456c:	89 10                	mov    %edx,(%eax)
c010456e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104571:	8b 10                	mov    (%eax),%edx
c0104573:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0104576:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c0104579:	8b 45 dc             	mov    -0x24(%ebp),%eax
c010457c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c010457f:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c0104582:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104585:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0104588:	89 10                	mov    %edx,(%eax)
}
c010458a:	90                   	nop
}
c010458b:	90                   	nop
    for (; p != base + n; p ++) { //初始化n块物理页
c010458c:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
c0104590:	8b 55 0c             	mov    0xc(%ebp),%edx
c0104593:	89 d0                	mov    %edx,%eax
c0104595:	c1 e0 02             	shl    $0x2,%eax
c0104598:	01 d0                	add    %edx,%eax
c010459a:	c1 e0 02             	shl    $0x2,%eax
c010459d:	89 c2                	mov    %eax,%edx
c010459f:	8b 45 08             	mov    0x8(%ebp),%eax
c01045a2:	01 d0                	add    %edx,%eax
c01045a4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
c01045a7:	0f 85 02 ff ff ff    	jne    c01044af <default_init_memmap+0x3f>
    }
    nr_free += n; //计算空闲页总数
c01045ad:	8b 15 24 cf 11 c0    	mov    0xc011cf24,%edx
c01045b3:	8b 45 0c             	mov    0xc(%ebp),%eax
c01045b6:	01 d0                	add    %edx,%eax
c01045b8:	a3 24 cf 11 c0       	mov    %eax,0xc011cf24
    base->property = n; //修改base的连续空页值为n
c01045bd:	8b 45 08             	mov    0x8(%ebp),%eax
c01045c0:	8b 55 0c             	mov    0xc(%ebp),%edx
c01045c3:	89 50 08             	mov    %edx,0x8(%eax)
    //SetPageProperty(base);
    //nr_free += n;
    //list_add(&free_list, &(base->page_link));
}
c01045c6:	90                   	nop
c01045c7:	c9                   	leave  
c01045c8:	c3                   	ret    

c01045c9 <default_alloc_pages>:

//实现
static struct Page *
default_alloc_pages(size_t n) {
c01045c9:	f3 0f 1e fb          	endbr32 
c01045cd:	55                   	push   %ebp
c01045ce:	89 e5                	mov    %esp,%ebp
c01045d0:	83 ec 68             	sub    $0x68,%esp
    assert(n > 0); //判断n是否大于0
c01045d3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c01045d7:	75 24                	jne    c01045fd <default_alloc_pages+0x34>
c01045d9:	c7 44 24 0c 78 6e 10 	movl   $0xc0106e78,0xc(%esp)
c01045e0:	c0 
c01045e1:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c01045e8:	c0 
c01045e9:	c7 44 24 04 98 00 00 	movl   $0x98,0x4(%esp)
c01045f0:	00 
c01045f1:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c01045f8:	e8 38 be ff ff       	call   c0100435 <__panic>
    if (n > nr_free) { //需要分配页的个数大于空闲页的总数,直接返回
c01045fd:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c0104602:	39 45 08             	cmp    %eax,0x8(%ebp)
c0104605:	76 0a                	jbe    c0104611 <default_alloc_pages+0x48>
        return NULL;
c0104607:	b8 00 00 00 00       	mov    $0x0,%eax
c010460c:	e9 3c 01 00 00       	jmp    c010474d <default_alloc_pages+0x184>
    }
    //struct Page *page = NULL;
    //list_entry_t *le = &free_list;
    list_entry_t *le, *len; //空闲链表的头部和长度
    le = &free_list;  //空闲链表的头部
c0104611:	c7 45 f4 1c cf 11 c0 	movl   $0xc011cf1c,-0xc(%ebp)
    
    while ((le = list_next(le)) != &free_list) { //遍历整个空闲链表
c0104618:	e9 0f 01 00 00       	jmp    c010472c <default_alloc_pages+0x163>
        struct Page *p = le2page(le, page_link); //转换为页结构
c010461d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104620:	83 e8 0c             	sub    $0xc,%eax
c0104623:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if (p->property >= n) { //找到合适的空闲页
c0104626:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104629:	8b 40 08             	mov    0x8(%eax),%eax
c010462c:	39 45 08             	cmp    %eax,0x8(%ebp)
c010462f:	0f 87 f7 00 00 00    	ja     c010472c <default_alloc_pages+0x163>
            //page = p;
            //break;
            int i;
            for(i=0;i<n;i++){
c0104635:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
c010463c:	eb 7f                	jmp    c01046bd <default_alloc_pages+0xf4>
c010463e:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104641:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return listelm->next;
c0104644:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0104647:	8b 40 04             	mov    0x4(%eax),%eax
                len = list_next(le); 
c010464a:	89 45 e8             	mov    %eax,-0x18(%ebp)
                struct Page *pp = le2page(le, page_link); //转换页结构
c010464d:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104650:	83 e8 0c             	sub    $0xc,%eax
c0104653:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                SetPageReserved(pp); //设置每一页的标志位
c0104656:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104659:	83 c0 04             	add    $0x4,%eax
c010465c:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
c0104663:	89 45 c8             	mov    %eax,-0x38(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0104666:	8b 45 c8             	mov    -0x38(%ebp),%eax
c0104669:	8b 55 cc             	mov    -0x34(%ebp),%edx
c010466c:	0f ab 10             	bts    %edx,(%eax)
}
c010466f:	90                   	nop
                ClearPageProperty(pp); 
c0104670:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104673:	83 c0 04             	add    $0x4,%eax
c0104676:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
c010467d:	89 45 d0             	mov    %eax,-0x30(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0104680:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0104683:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0104686:	0f b3 10             	btr    %edx,(%eax)
}
c0104689:	90                   	nop
c010468a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010468d:	89 45 e0             	mov    %eax,-0x20(%ebp)
    __list_del(listelm->prev, listelm->next);
c0104690:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0104693:	8b 40 04             	mov    0x4(%eax),%eax
c0104696:	8b 55 e0             	mov    -0x20(%ebp),%edx
c0104699:	8b 12                	mov    (%edx),%edx
c010469b:	89 55 dc             	mov    %edx,-0x24(%ebp)
c010469e:	89 45 d8             	mov    %eax,-0x28(%ebp)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
c01046a1:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01046a4:	8b 55 d8             	mov    -0x28(%ebp),%edx
c01046a7:	89 50 04             	mov    %edx,0x4(%eax)
    next->prev = prev;
c01046aa:	8b 45 d8             	mov    -0x28(%ebp),%eax
c01046ad:	8b 55 dc             	mov    -0x24(%ebp),%edx
c01046b0:	89 10                	mov    %edx,(%eax)
}
c01046b2:	90                   	nop
}
c01046b3:	90                   	nop
                list_del(le); //将此页从free_list中清除
                le = len;
c01046b4:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01046b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
            for(i=0;i<n;i++){
c01046ba:	ff 45 f0             	incl   -0x10(%ebp)
c01046bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01046c0:	39 45 08             	cmp    %eax,0x8(%ebp)
c01046c3:	0f 87 75 ff ff ff    	ja     c010463e <default_alloc_pages+0x75>
            }
            if(p->property>n){ //如果页块大小大于所需大小，分割页块
c01046c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01046cc:	8b 40 08             	mov    0x8(%eax),%eax
c01046cf:	39 45 08             	cmp    %eax,0x8(%ebp)
c01046d2:	73 12                	jae    c01046e6 <default_alloc_pages+0x11d>
                (le2page(le,page_link))->property = p->property-n;
c01046d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01046d7:	8b 40 08             	mov    0x8(%eax),%eax
c01046da:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01046dd:	83 ea 0c             	sub    $0xc,%edx
c01046e0:	2b 45 08             	sub    0x8(%ebp),%eax
c01046e3:	89 42 08             	mov    %eax,0x8(%edx)
            }
            ClearPageProperty(p);
c01046e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01046e9:	83 c0 04             	add    $0x4,%eax
c01046ec:	c7 45 b8 01 00 00 00 	movl   $0x1,-0x48(%ebp)
c01046f3:	89 45 b4             	mov    %eax,-0x4c(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c01046f6:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c01046f9:	8b 55 b8             	mov    -0x48(%ebp),%edx
c01046fc:	0f b3 10             	btr    %edx,(%eax)
}
c01046ff:	90                   	nop
            SetPageReserved(p);
c0104700:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104703:	83 c0 04             	add    $0x4,%eax
c0104706:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
c010470d:	89 45 bc             	mov    %eax,-0x44(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c0104710:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0104713:	8b 55 c0             	mov    -0x40(%ebp),%edx
c0104716:	0f ab 10             	bts    %edx,(%eax)
}
c0104719:	90                   	nop
            nr_free -= n; //减去已经分配的页块大小
c010471a:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c010471f:	2b 45 08             	sub    0x8(%ebp),%eax
c0104722:	a3 24 cf 11 c0       	mov    %eax,0xc011cf24
            return p;
c0104727:	8b 45 ec             	mov    -0x14(%ebp),%eax
c010472a:	eb 21                	jmp    c010474d <default_alloc_pages+0x184>
c010472c:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010472f:	89 45 b0             	mov    %eax,-0x50(%ebp)
    return listelm->next;
c0104732:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0104735:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) { //遍历整个空闲链表
c0104738:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010473b:	81 7d f4 1c cf 11 c0 	cmpl   $0xc011cf1c,-0xc(%ebp)
c0104742:	0f 85 d5 fe ff ff    	jne    c010461d <default_alloc_pages+0x54>
        nr_free -= n;
        ClearPageProperty(page);
    }
    return page;
    */
    return NULL;
c0104748:	b8 00 00 00 00       	mov    $0x0,%eax
}
c010474d:	c9                   	leave  
c010474e:	c3                   	ret    

c010474f <default_free_pages>:

//实现
static void
default_free_pages(struct Page *base, size_t n) {
c010474f:	f3 0f 1e fb          	endbr32 
c0104753:	55                   	push   %ebp
c0104754:	89 e5                	mov    %esp,%ebp
c0104756:	83 ec 68             	sub    $0x68,%esp
    assert(n > 0);
c0104759:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c010475d:	75 24                	jne    c0104783 <default_free_pages+0x34>
c010475f:	c7 44 24 0c 78 6e 10 	movl   $0xc0106e78,0xc(%esp)
c0104766:	c0 
c0104767:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c010476e:	c0 
c010476f:	c7 44 24 04 cb 00 00 	movl   $0xcb,0x4(%esp)
c0104776:	00 
c0104777:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c010477e:	e8 b2 bc ff ff       	call   c0100435 <__panic>
    assert(PageReserved(base));    //检查需要释放的页块是否已经被分配
c0104783:	8b 45 08             	mov    0x8(%ebp),%eax
c0104786:	83 c0 04             	add    $0x4,%eax
c0104789:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
c0104790:	89 45 e8             	mov    %eax,-0x18(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104793:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104796:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0104799:	0f a3 10             	bt     %edx,(%eax)
c010479c:	19 c0                	sbb    %eax,%eax
c010479e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return oldbit != 0;
c01047a1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c01047a5:	0f 95 c0             	setne  %al
c01047a8:	0f b6 c0             	movzbl %al,%eax
c01047ab:	85 c0                	test   %eax,%eax
c01047ad:	75 24                	jne    c01047d3 <default_free_pages+0x84>
c01047af:	c7 44 24 0c b9 6e 10 	movl   $0xc0106eb9,0xc(%esp)
c01047b6:	c0 
c01047b7:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c01047be:	c0 
c01047bf:	c7 44 24 04 cc 00 00 	movl   $0xcc,0x4(%esp)
c01047c6:	00 
c01047c7:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c01047ce:	e8 62 bc ff ff       	call   c0100435 <__panic>
    list_entry_t *le = &free_list; 
c01047d3:	c7 45 f4 1c cf 11 c0 	movl   $0xc011cf1c,-0xc(%ebp)
    }
    base->property = n;
    SetPageProperty(base);
    list_entry_t *le = list_next(&free_list);
    */
    while((le=list_next(le)) != &free_list) {    //寻找合适的位置
c01047da:	eb 11                	jmp    c01047ed <default_free_pages+0x9e>
        p = le2page(le, page_link); //获取链表对应的Page
c01047dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01047df:	83 e8 0c             	sub    $0xc,%eax
c01047e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if(p>base){    
c01047e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01047e8:	3b 45 08             	cmp    0x8(%ebp),%eax
c01047eb:	77 1a                	ja     c0104807 <default_free_pages+0xb8>
c01047ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01047f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
c01047f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01047f6:	8b 40 04             	mov    0x4(%eax),%eax
    while((le=list_next(le)) != &free_list) {    //寻找合适的位置
c01047f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01047fc:	81 7d f4 1c cf 11 c0 	cmpl   $0xc011cf1c,-0xc(%ebp)
c0104803:	75 d7                	jne    c01047dc <default_free_pages+0x8d>
c0104805:	eb 01                	jmp    c0104808 <default_free_pages+0xb9>
            break;
c0104807:	90                   	nop
        }
    } 
    for(p=base;p<base+n;p++){              
c0104808:	8b 45 08             	mov    0x8(%ebp),%eax
c010480b:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010480e:	eb 4d                	jmp    c010485d <default_free_pages+0x10e>
        list_add_before(le, &(p->page_link)); //将每一空闲块对应的链表插入空闲链表中
c0104810:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104813:	8d 50 0c             	lea    0xc(%eax),%edx
c0104816:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104819:	89 45 dc             	mov    %eax,-0x24(%ebp)
c010481c:	89 55 d8             	mov    %edx,-0x28(%ebp)
    __list_add(elm, listelm->prev, listelm);
c010481f:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104822:	8b 00                	mov    (%eax),%eax
c0104824:	8b 55 d8             	mov    -0x28(%ebp),%edx
c0104827:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c010482a:	89 45 d0             	mov    %eax,-0x30(%ebp)
c010482d:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104830:	89 45 cc             	mov    %eax,-0x34(%ebp)
    prev->next = next->prev = elm;
c0104833:	8b 45 cc             	mov    -0x34(%ebp),%eax
c0104836:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0104839:	89 10                	mov    %edx,(%eax)
c010483b:	8b 45 cc             	mov    -0x34(%ebp),%eax
c010483e:	8b 10                	mov    (%eax),%edx
c0104840:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0104843:	89 50 04             	mov    %edx,0x4(%eax)
    elm->next = next;
c0104846:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104849:	8b 55 cc             	mov    -0x34(%ebp),%edx
c010484c:	89 50 04             	mov    %edx,0x4(%eax)
    elm->prev = prev;
c010484f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104852:	8b 55 d0             	mov    -0x30(%ebp),%edx
c0104855:	89 10                	mov    %edx,(%eax)
}
c0104857:	90                   	nop
}
c0104858:	90                   	nop
    for(p=base;p<base+n;p++){              
c0104859:	83 45 f0 14          	addl   $0x14,-0x10(%ebp)
c010485d:	8b 55 0c             	mov    0xc(%ebp),%edx
c0104860:	89 d0                	mov    %edx,%eax
c0104862:	c1 e0 02             	shl    $0x2,%eax
c0104865:	01 d0                	add    %edx,%eax
c0104867:	c1 e0 02             	shl    $0x2,%eax
c010486a:	89 c2                	mov    %eax,%edx
c010486c:	8b 45 08             	mov    0x8(%ebp),%eax
c010486f:	01 d0                	add    %edx,%eax
c0104871:	39 45 f0             	cmp    %eax,-0x10(%ebp)
c0104874:	72 9a                	jb     c0104810 <default_free_pages+0xc1>
    } 
    base->flags = 0;         //修改标志位
c0104876:	8b 45 08             	mov    0x8(%ebp),%eax
c0104879:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    set_page_ref(base, 0);    
c0104880:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
c0104887:	00 
c0104888:	8b 45 08             	mov    0x8(%ebp),%eax
c010488b:	89 04 24             	mov    %eax,(%esp)
c010488e:	e8 9c fb ff ff       	call   c010442f <set_page_ref>
    ClearPageProperty(base);
c0104893:	8b 45 08             	mov    0x8(%ebp),%eax
c0104896:	83 c0 04             	add    $0x4,%eax
c0104899:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
c01048a0:	89 45 bc             	mov    %eax,-0x44(%ebp)
    asm volatile ("btrl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c01048a3:	8b 45 bc             	mov    -0x44(%ebp),%eax
c01048a6:	8b 55 c0             	mov    -0x40(%ebp),%edx
c01048a9:	0f b3 10             	btr    %edx,(%eax)
}
c01048ac:	90                   	nop
    SetPageProperty(base);
c01048ad:	8b 45 08             	mov    0x8(%ebp),%eax
c01048b0:	83 c0 04             	add    $0x4,%eax
c01048b3:	c7 45 c8 01 00 00 00 	movl   $0x1,-0x38(%ebp)
c01048ba:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    asm volatile ("btsl %1, %0" :"=m" (*(volatile long *)addr) : "Ir" (nr));
c01048bd:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c01048c0:	8b 55 c8             	mov    -0x38(%ebp),%edx
c01048c3:	0f ab 10             	bts    %edx,(%eax)
}
c01048c6:	90                   	nop
    base->property = n;      //设置连续大小为n
c01048c7:	8b 45 08             	mov    0x8(%ebp),%eax
c01048ca:	8b 55 0c             	mov    0xc(%ebp),%edx
c01048cd:	89 50 08             	mov    %edx,0x8(%eax)
    //如果是高位，则向高地址合并
    p = le2page(le,page_link) ;
c01048d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01048d3:	83 e8 0c             	sub    $0xc,%eax
c01048d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if( base+n == p ){
c01048d9:	8b 55 0c             	mov    0xc(%ebp),%edx
c01048dc:	89 d0                	mov    %edx,%eax
c01048de:	c1 e0 02             	shl    $0x2,%eax
c01048e1:	01 d0                	add    %edx,%eax
c01048e3:	c1 e0 02             	shl    $0x2,%eax
c01048e6:	89 c2                	mov    %eax,%edx
c01048e8:	8b 45 08             	mov    0x8(%ebp),%eax
c01048eb:	01 d0                	add    %edx,%eax
c01048ed:	39 45 f0             	cmp    %eax,-0x10(%ebp)
c01048f0:	75 1e                	jne    c0104910 <default_free_pages+0x1c1>
        base->property += p->property;
c01048f2:	8b 45 08             	mov    0x8(%ebp),%eax
c01048f5:	8b 50 08             	mov    0x8(%eax),%edx
c01048f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01048fb:	8b 40 08             	mov    0x8(%eax),%eax
c01048fe:	01 c2                	add    %eax,%edx
c0104900:	8b 45 08             	mov    0x8(%ebp),%eax
c0104903:	89 50 08             	mov    %edx,0x8(%eax)
        p->property = 0;
c0104906:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104909:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    }
     //如果是低位且在范围内，则向低地址合并
    le = list_prev(&(base->page_link));
c0104910:	8b 45 08             	mov    0x8(%ebp),%eax
c0104913:	83 c0 0c             	add    $0xc,%eax
c0104916:	89 45 b8             	mov    %eax,-0x48(%ebp)
    return listelm->prev;
c0104919:	8b 45 b8             	mov    -0x48(%ebp),%eax
c010491c:	8b 00                	mov    (%eax),%eax
c010491e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    p = le2page(le, page_link);
c0104921:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104924:	83 e8 0c             	sub    $0xc,%eax
c0104927:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(le!=&free_list && p==base-1){ //满足条件，未分配则合并
c010492a:	81 7d f4 1c cf 11 c0 	cmpl   $0xc011cf1c,-0xc(%ebp)
c0104931:	74 57                	je     c010498a <default_free_pages+0x23b>
c0104933:	8b 45 08             	mov    0x8(%ebp),%eax
c0104936:	83 e8 14             	sub    $0x14,%eax
c0104939:	39 45 f0             	cmp    %eax,-0x10(%ebp)
c010493c:	75 4c                	jne    c010498a <default_free_pages+0x23b>
        while(le!=&free_list){
c010493e:	eb 41                	jmp    c0104981 <default_free_pages+0x232>
            if(p->property){ //连续
c0104940:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104943:	8b 40 08             	mov    0x8(%eax),%eax
c0104946:	85 c0                	test   %eax,%eax
c0104948:	74 20                	je     c010496a <default_free_pages+0x21b>
                p->property += base->property;
c010494a:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010494d:	8b 50 08             	mov    0x8(%eax),%edx
c0104950:	8b 45 08             	mov    0x8(%ebp),%eax
c0104953:	8b 40 08             	mov    0x8(%eax),%eax
c0104956:	01 c2                	add    %eax,%edx
c0104958:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010495b:	89 50 08             	mov    %edx,0x8(%eax)
                base->property = 0;
c010495e:	8b 45 08             	mov    0x8(%ebp),%eax
c0104961:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
            break;
c0104968:	eb 20                	jmp    c010498a <default_free_pages+0x23b>
c010496a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010496d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
c0104970:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c0104973:	8b 00                	mov    (%eax),%eax
            }
            le = list_prev(le);
c0104975:	89 45 f4             	mov    %eax,-0xc(%ebp)
            p = le2page(le,page_link);
c0104978:	8b 45 f4             	mov    -0xc(%ebp),%eax
c010497b:	83 e8 0c             	sub    $0xc,%eax
c010497e:	89 45 f0             	mov    %eax,-0x10(%ebp)
        while(le!=&free_list){
c0104981:	81 7d f4 1c cf 11 c0 	cmpl   $0xc011cf1c,-0xc(%ebp)
c0104988:	75 b6                	jne    c0104940 <default_free_pages+0x1f1>
        }
    }

    nr_free += n;
c010498a:	8b 15 24 cf 11 c0    	mov    0xc011cf24,%edx
c0104990:	8b 45 0c             	mov    0xc(%ebp),%eax
c0104993:	01 d0                	add    %edx,%eax
c0104995:	a3 24 cf 11 c0       	mov    %eax,0xc011cf24
    return ;
c010499a:	90                   	nop
        }
    }
    nr_free += n;
    list_add(&free_list, &(base->page_link));
    */
}
c010499b:	c9                   	leave  
c010499c:	c3                   	ret    

c010499d <default_nr_free_pages>:

static size_t
default_nr_free_pages(void) {
c010499d:	f3 0f 1e fb          	endbr32 
c01049a1:	55                   	push   %ebp
c01049a2:	89 e5                	mov    %esp,%ebp
    return nr_free;
c01049a4:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
}
c01049a9:	5d                   	pop    %ebp
c01049aa:	c3                   	ret    

c01049ab <basic_check>:

static void
basic_check(void) {
c01049ab:	f3 0f 1e fb          	endbr32 
c01049af:	55                   	push   %ebp
c01049b0:	89 e5                	mov    %esp,%ebp
c01049b2:	83 ec 48             	sub    $0x48,%esp
    struct Page *p0, *p1, *p2;
    p0 = p1 = p2 = NULL;
c01049b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c01049bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01049bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01049c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01049c5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    assert((p0 = alloc_page()) != NULL);
c01049c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c01049cf:	e8 56 e3 ff ff       	call   c0102d2a <alloc_pages>
c01049d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
c01049d7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
c01049db:	75 24                	jne    c0104a01 <basic_check+0x56>
c01049dd:	c7 44 24 0c cc 6e 10 	movl   $0xc0106ecc,0xc(%esp)
c01049e4:	c0 
c01049e5:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c01049ec:	c0 
c01049ed:	c7 44 24 04 1d 01 00 	movl   $0x11d,0x4(%esp)
c01049f4:	00 
c01049f5:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c01049fc:	e8 34 ba ff ff       	call   c0100435 <__panic>
    assert((p1 = alloc_page()) != NULL);
c0104a01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0104a08:	e8 1d e3 ff ff       	call   c0102d2a <alloc_pages>
c0104a0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104a10:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0104a14:	75 24                	jne    c0104a3a <basic_check+0x8f>
c0104a16:	c7 44 24 0c e8 6e 10 	movl   $0xc0106ee8,0xc(%esp)
c0104a1d:	c0 
c0104a1e:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104a25:	c0 
c0104a26:	c7 44 24 04 1e 01 00 	movl   $0x11e,0x4(%esp)
c0104a2d:	00 
c0104a2e:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104a35:	e8 fb b9 ff ff       	call   c0100435 <__panic>
    assert((p2 = alloc_page()) != NULL);
c0104a3a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0104a41:	e8 e4 e2 ff ff       	call   c0102d2a <alloc_pages>
c0104a46:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0104a49:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0104a4d:	75 24                	jne    c0104a73 <basic_check+0xc8>
c0104a4f:	c7 44 24 0c 04 6f 10 	movl   $0xc0106f04,0xc(%esp)
c0104a56:	c0 
c0104a57:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104a5e:	c0 
c0104a5f:	c7 44 24 04 1f 01 00 	movl   $0x11f,0x4(%esp)
c0104a66:	00 
c0104a67:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104a6e:	e8 c2 b9 ff ff       	call   c0100435 <__panic>

    assert(p0 != p1 && p0 != p2 && p1 != p2);
c0104a73:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104a76:	3b 45 f0             	cmp    -0x10(%ebp),%eax
c0104a79:	74 10                	je     c0104a8b <basic_check+0xe0>
c0104a7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104a7e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c0104a81:	74 08                	je     c0104a8b <basic_check+0xe0>
c0104a83:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104a86:	3b 45 f4             	cmp    -0xc(%ebp),%eax
c0104a89:	75 24                	jne    c0104aaf <basic_check+0x104>
c0104a8b:	c7 44 24 0c 20 6f 10 	movl   $0xc0106f20,0xc(%esp)
c0104a92:	c0 
c0104a93:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104a9a:	c0 
c0104a9b:	c7 44 24 04 21 01 00 	movl   $0x121,0x4(%esp)
c0104aa2:	00 
c0104aa3:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104aaa:	e8 86 b9 ff ff       	call   c0100435 <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
c0104aaf:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104ab2:	89 04 24             	mov    %eax,(%esp)
c0104ab5:	e8 6b f9 ff ff       	call   c0104425 <page_ref>
c0104aba:	85 c0                	test   %eax,%eax
c0104abc:	75 1e                	jne    c0104adc <basic_check+0x131>
c0104abe:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104ac1:	89 04 24             	mov    %eax,(%esp)
c0104ac4:	e8 5c f9 ff ff       	call   c0104425 <page_ref>
c0104ac9:	85 c0                	test   %eax,%eax
c0104acb:	75 0f                	jne    c0104adc <basic_check+0x131>
c0104acd:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104ad0:	89 04 24             	mov    %eax,(%esp)
c0104ad3:	e8 4d f9 ff ff       	call   c0104425 <page_ref>
c0104ad8:	85 c0                	test   %eax,%eax
c0104ada:	74 24                	je     c0104b00 <basic_check+0x155>
c0104adc:	c7 44 24 0c 44 6f 10 	movl   $0xc0106f44,0xc(%esp)
c0104ae3:	c0 
c0104ae4:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104aeb:	c0 
c0104aec:	c7 44 24 04 22 01 00 	movl   $0x122,0x4(%esp)
c0104af3:	00 
c0104af4:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104afb:	e8 35 b9 ff ff       	call   c0100435 <__panic>

    assert(page2pa(p0) < npage * PGSIZE);
c0104b00:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104b03:	89 04 24             	mov    %eax,(%esp)
c0104b06:	e8 04 f9 ff ff       	call   c010440f <page2pa>
c0104b0b:	8b 15 80 ce 11 c0    	mov    0xc011ce80,%edx
c0104b11:	c1 e2 0c             	shl    $0xc,%edx
c0104b14:	39 d0                	cmp    %edx,%eax
c0104b16:	72 24                	jb     c0104b3c <basic_check+0x191>
c0104b18:	c7 44 24 0c 80 6f 10 	movl   $0xc0106f80,0xc(%esp)
c0104b1f:	c0 
c0104b20:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104b27:	c0 
c0104b28:	c7 44 24 04 24 01 00 	movl   $0x124,0x4(%esp)
c0104b2f:	00 
c0104b30:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104b37:	e8 f9 b8 ff ff       	call   c0100435 <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
c0104b3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104b3f:	89 04 24             	mov    %eax,(%esp)
c0104b42:	e8 c8 f8 ff ff       	call   c010440f <page2pa>
c0104b47:	8b 15 80 ce 11 c0    	mov    0xc011ce80,%edx
c0104b4d:	c1 e2 0c             	shl    $0xc,%edx
c0104b50:	39 d0                	cmp    %edx,%eax
c0104b52:	72 24                	jb     c0104b78 <basic_check+0x1cd>
c0104b54:	c7 44 24 0c 9d 6f 10 	movl   $0xc0106f9d,0xc(%esp)
c0104b5b:	c0 
c0104b5c:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104b63:	c0 
c0104b64:	c7 44 24 04 25 01 00 	movl   $0x125,0x4(%esp)
c0104b6b:	00 
c0104b6c:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104b73:	e8 bd b8 ff ff       	call   c0100435 <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
c0104b78:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104b7b:	89 04 24             	mov    %eax,(%esp)
c0104b7e:	e8 8c f8 ff ff       	call   c010440f <page2pa>
c0104b83:	8b 15 80 ce 11 c0    	mov    0xc011ce80,%edx
c0104b89:	c1 e2 0c             	shl    $0xc,%edx
c0104b8c:	39 d0                	cmp    %edx,%eax
c0104b8e:	72 24                	jb     c0104bb4 <basic_check+0x209>
c0104b90:	c7 44 24 0c ba 6f 10 	movl   $0xc0106fba,0xc(%esp)
c0104b97:	c0 
c0104b98:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104b9f:	c0 
c0104ba0:	c7 44 24 04 26 01 00 	movl   $0x126,0x4(%esp)
c0104ba7:	00 
c0104ba8:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104baf:	e8 81 b8 ff ff       	call   c0100435 <__panic>

    list_entry_t free_list_store = free_list;
c0104bb4:	a1 1c cf 11 c0       	mov    0xc011cf1c,%eax
c0104bb9:	8b 15 20 cf 11 c0    	mov    0xc011cf20,%edx
c0104bbf:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0104bc2:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c0104bc5:	c7 45 dc 1c cf 11 c0 	movl   $0xc011cf1c,-0x24(%ebp)
    elm->prev = elm->next = elm;
c0104bcc:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104bcf:	8b 55 dc             	mov    -0x24(%ebp),%edx
c0104bd2:	89 50 04             	mov    %edx,0x4(%eax)
c0104bd5:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104bd8:	8b 50 04             	mov    0x4(%eax),%edx
c0104bdb:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0104bde:	89 10                	mov    %edx,(%eax)
}
c0104be0:	90                   	nop
c0104be1:	c7 45 e0 1c cf 11 c0 	movl   $0xc011cf1c,-0x20(%ebp)
    return list->next == list;
c0104be8:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0104beb:	8b 40 04             	mov    0x4(%eax),%eax
c0104bee:	39 45 e0             	cmp    %eax,-0x20(%ebp)
c0104bf1:	0f 94 c0             	sete   %al
c0104bf4:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
c0104bf7:	85 c0                	test   %eax,%eax
c0104bf9:	75 24                	jne    c0104c1f <basic_check+0x274>
c0104bfb:	c7 44 24 0c d7 6f 10 	movl   $0xc0106fd7,0xc(%esp)
c0104c02:	c0 
c0104c03:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104c0a:	c0 
c0104c0b:	c7 44 24 04 2a 01 00 	movl   $0x12a,0x4(%esp)
c0104c12:	00 
c0104c13:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104c1a:	e8 16 b8 ff ff       	call   c0100435 <__panic>

    unsigned int nr_free_store = nr_free;
c0104c1f:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c0104c24:	89 45 e8             	mov    %eax,-0x18(%ebp)
    nr_free = 0;
c0104c27:	c7 05 24 cf 11 c0 00 	movl   $0x0,0xc011cf24
c0104c2e:	00 00 00 

    assert(alloc_page() == NULL);
c0104c31:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0104c38:	e8 ed e0 ff ff       	call   c0102d2a <alloc_pages>
c0104c3d:	85 c0                	test   %eax,%eax
c0104c3f:	74 24                	je     c0104c65 <basic_check+0x2ba>
c0104c41:	c7 44 24 0c ee 6f 10 	movl   $0xc0106fee,0xc(%esp)
c0104c48:	c0 
c0104c49:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104c50:	c0 
c0104c51:	c7 44 24 04 2f 01 00 	movl   $0x12f,0x4(%esp)
c0104c58:	00 
c0104c59:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104c60:	e8 d0 b7 ff ff       	call   c0100435 <__panic>

    free_page(p0);
c0104c65:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0104c6c:	00 
c0104c6d:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104c70:	89 04 24             	mov    %eax,(%esp)
c0104c73:	e8 ee e0 ff ff       	call   c0102d66 <free_pages>
    free_page(p1);
c0104c78:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0104c7f:	00 
c0104c80:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104c83:	89 04 24             	mov    %eax,(%esp)
c0104c86:	e8 db e0 ff ff       	call   c0102d66 <free_pages>
    free_page(p2);
c0104c8b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0104c92:	00 
c0104c93:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104c96:	89 04 24             	mov    %eax,(%esp)
c0104c99:	e8 c8 e0 ff ff       	call   c0102d66 <free_pages>
    assert(nr_free == 3);
c0104c9e:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c0104ca3:	83 f8 03             	cmp    $0x3,%eax
c0104ca6:	74 24                	je     c0104ccc <basic_check+0x321>
c0104ca8:	c7 44 24 0c 03 70 10 	movl   $0xc0107003,0xc(%esp)
c0104caf:	c0 
c0104cb0:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104cb7:	c0 
c0104cb8:	c7 44 24 04 34 01 00 	movl   $0x134,0x4(%esp)
c0104cbf:	00 
c0104cc0:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104cc7:	e8 69 b7 ff ff       	call   c0100435 <__panic>

    assert((p0 = alloc_page()) != NULL);
c0104ccc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0104cd3:	e8 52 e0 ff ff       	call   c0102d2a <alloc_pages>
c0104cd8:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104cdb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
c0104cdf:	75 24                	jne    c0104d05 <basic_check+0x35a>
c0104ce1:	c7 44 24 0c cc 6e 10 	movl   $0xc0106ecc,0xc(%esp)
c0104ce8:	c0 
c0104ce9:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104cf0:	c0 
c0104cf1:	c7 44 24 04 36 01 00 	movl   $0x136,0x4(%esp)
c0104cf8:	00 
c0104cf9:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104d00:	e8 30 b7 ff ff       	call   c0100435 <__panic>
    assert((p1 = alloc_page()) != NULL);
c0104d05:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0104d0c:	e8 19 e0 ff ff       	call   c0102d2a <alloc_pages>
c0104d11:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104d14:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0104d18:	75 24                	jne    c0104d3e <basic_check+0x393>
c0104d1a:	c7 44 24 0c e8 6e 10 	movl   $0xc0106ee8,0xc(%esp)
c0104d21:	c0 
c0104d22:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104d29:	c0 
c0104d2a:	c7 44 24 04 37 01 00 	movl   $0x137,0x4(%esp)
c0104d31:	00 
c0104d32:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104d39:	e8 f7 b6 ff ff       	call   c0100435 <__panic>
    assert((p2 = alloc_page()) != NULL);
c0104d3e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0104d45:	e8 e0 df ff ff       	call   c0102d2a <alloc_pages>
c0104d4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0104d4d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c0104d51:	75 24                	jne    c0104d77 <basic_check+0x3cc>
c0104d53:	c7 44 24 0c 04 6f 10 	movl   $0xc0106f04,0xc(%esp)
c0104d5a:	c0 
c0104d5b:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104d62:	c0 
c0104d63:	c7 44 24 04 38 01 00 	movl   $0x138,0x4(%esp)
c0104d6a:	00 
c0104d6b:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104d72:	e8 be b6 ff ff       	call   c0100435 <__panic>

    assert(alloc_page() == NULL);
c0104d77:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0104d7e:	e8 a7 df ff ff       	call   c0102d2a <alloc_pages>
c0104d83:	85 c0                	test   %eax,%eax
c0104d85:	74 24                	je     c0104dab <basic_check+0x400>
c0104d87:	c7 44 24 0c ee 6f 10 	movl   $0xc0106fee,0xc(%esp)
c0104d8e:	c0 
c0104d8f:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104d96:	c0 
c0104d97:	c7 44 24 04 3a 01 00 	movl   $0x13a,0x4(%esp)
c0104d9e:	00 
c0104d9f:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104da6:	e8 8a b6 ff ff       	call   c0100435 <__panic>

    free_page(p0);
c0104dab:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0104db2:	00 
c0104db3:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104db6:	89 04 24             	mov    %eax,(%esp)
c0104db9:	e8 a8 df ff ff       	call   c0102d66 <free_pages>
c0104dbe:	c7 45 d8 1c cf 11 c0 	movl   $0xc011cf1c,-0x28(%ebp)
c0104dc5:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0104dc8:	8b 40 04             	mov    0x4(%eax),%eax
c0104dcb:	39 45 d8             	cmp    %eax,-0x28(%ebp)
c0104dce:	0f 94 c0             	sete   %al
c0104dd1:	0f b6 c0             	movzbl %al,%eax
    assert(!list_empty(&free_list));
c0104dd4:	85 c0                	test   %eax,%eax
c0104dd6:	74 24                	je     c0104dfc <basic_check+0x451>
c0104dd8:	c7 44 24 0c 10 70 10 	movl   $0xc0107010,0xc(%esp)
c0104ddf:	c0 
c0104de0:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104de7:	c0 
c0104de8:	c7 44 24 04 3d 01 00 	movl   $0x13d,0x4(%esp)
c0104def:	00 
c0104df0:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104df7:	e8 39 b6 ff ff       	call   c0100435 <__panic>

    struct Page *p;
    assert((p = alloc_page()) == p0);
c0104dfc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0104e03:	e8 22 df ff ff       	call   c0102d2a <alloc_pages>
c0104e08:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0104e0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104e0e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c0104e11:	74 24                	je     c0104e37 <basic_check+0x48c>
c0104e13:	c7 44 24 0c 28 70 10 	movl   $0xc0107028,0xc(%esp)
c0104e1a:	c0 
c0104e1b:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104e22:	c0 
c0104e23:	c7 44 24 04 40 01 00 	movl   $0x140,0x4(%esp)
c0104e2a:	00 
c0104e2b:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104e32:	e8 fe b5 ff ff       	call   c0100435 <__panic>
    assert(alloc_page() == NULL);
c0104e37:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0104e3e:	e8 e7 de ff ff       	call   c0102d2a <alloc_pages>
c0104e43:	85 c0                	test   %eax,%eax
c0104e45:	74 24                	je     c0104e6b <basic_check+0x4c0>
c0104e47:	c7 44 24 0c ee 6f 10 	movl   $0xc0106fee,0xc(%esp)
c0104e4e:	c0 
c0104e4f:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104e56:	c0 
c0104e57:	c7 44 24 04 41 01 00 	movl   $0x141,0x4(%esp)
c0104e5e:	00 
c0104e5f:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104e66:	e8 ca b5 ff ff       	call   c0100435 <__panic>

    assert(nr_free == 0);
c0104e6b:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c0104e70:	85 c0                	test   %eax,%eax
c0104e72:	74 24                	je     c0104e98 <basic_check+0x4ed>
c0104e74:	c7 44 24 0c 41 70 10 	movl   $0xc0107041,0xc(%esp)
c0104e7b:	c0 
c0104e7c:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104e83:	c0 
c0104e84:	c7 44 24 04 43 01 00 	movl   $0x143,0x4(%esp)
c0104e8b:	00 
c0104e8c:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104e93:	e8 9d b5 ff ff       	call   c0100435 <__panic>
    free_list = free_list_store;
c0104e98:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0104e9b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0104e9e:	a3 1c cf 11 c0       	mov    %eax,0xc011cf1c
c0104ea3:	89 15 20 cf 11 c0    	mov    %edx,0xc011cf20
    nr_free = nr_free_store;
c0104ea9:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0104eac:	a3 24 cf 11 c0       	mov    %eax,0xc011cf24

    free_page(p);
c0104eb1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0104eb8:	00 
c0104eb9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0104ebc:	89 04 24             	mov    %eax,(%esp)
c0104ebf:	e8 a2 de ff ff       	call   c0102d66 <free_pages>
    free_page(p1);
c0104ec4:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0104ecb:	00 
c0104ecc:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104ecf:	89 04 24             	mov    %eax,(%esp)
c0104ed2:	e8 8f de ff ff       	call   c0102d66 <free_pages>
    free_page(p2);
c0104ed7:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0104ede:	00 
c0104edf:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0104ee2:	89 04 24             	mov    %eax,(%esp)
c0104ee5:	e8 7c de ff ff       	call   c0102d66 <free_pages>
}
c0104eea:	90                   	nop
c0104eeb:	c9                   	leave  
c0104eec:	c3                   	ret    

c0104eed <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1) 
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void) {
c0104eed:	f3 0f 1e fb          	endbr32 
c0104ef1:	55                   	push   %ebp
c0104ef2:	89 e5                	mov    %esp,%ebp
c0104ef4:	81 ec 98 00 00 00    	sub    $0x98,%esp
    int count = 0, total = 0;
c0104efa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
c0104f01:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    list_entry_t *le = &free_list;
c0104f08:	c7 45 ec 1c cf 11 c0 	movl   $0xc011cf1c,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
c0104f0f:	eb 6a                	jmp    c0104f7b <default_check+0x8e>
        struct Page *p = le2page(le, page_link);
c0104f11:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104f14:	83 e8 0c             	sub    $0xc,%eax
c0104f17:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        assert(PageProperty(p));
c0104f1a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104f1d:	83 c0 04             	add    $0x4,%eax
c0104f20:	c7 45 d0 01 00 00 00 	movl   $0x1,-0x30(%ebp)
c0104f27:	89 45 cc             	mov    %eax,-0x34(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0104f2a:	8b 45 cc             	mov    -0x34(%ebp),%eax
c0104f2d:	8b 55 d0             	mov    -0x30(%ebp),%edx
c0104f30:	0f a3 10             	bt     %edx,(%eax)
c0104f33:	19 c0                	sbb    %eax,%eax
c0104f35:	89 45 c8             	mov    %eax,-0x38(%ebp)
    return oldbit != 0;
c0104f38:	83 7d c8 00          	cmpl   $0x0,-0x38(%ebp)
c0104f3c:	0f 95 c0             	setne  %al
c0104f3f:	0f b6 c0             	movzbl %al,%eax
c0104f42:	85 c0                	test   %eax,%eax
c0104f44:	75 24                	jne    c0104f6a <default_check+0x7d>
c0104f46:	c7 44 24 0c 4e 70 10 	movl   $0xc010704e,0xc(%esp)
c0104f4d:	c0 
c0104f4e:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104f55:	c0 
c0104f56:	c7 44 24 04 54 01 00 	movl   $0x154,0x4(%esp)
c0104f5d:	00 
c0104f5e:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104f65:	e8 cb b4 ff ff       	call   c0100435 <__panic>
        count ++, total += p->property;
c0104f6a:	ff 45 f4             	incl   -0xc(%ebp)
c0104f6d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
c0104f70:	8b 50 08             	mov    0x8(%eax),%edx
c0104f73:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0104f76:	01 d0                	add    %edx,%eax
c0104f78:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0104f7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0104f7e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return listelm->next;
c0104f81:	8b 45 c4             	mov    -0x3c(%ebp),%eax
c0104f84:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
c0104f87:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0104f8a:	81 7d ec 1c cf 11 c0 	cmpl   $0xc011cf1c,-0x14(%ebp)
c0104f91:	0f 85 7a ff ff ff    	jne    c0104f11 <default_check+0x24>
    }
    assert(total == nr_free_pages());
c0104f97:	e8 01 de ff ff       	call   c0102d9d <nr_free_pages>
c0104f9c:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0104f9f:	39 d0                	cmp    %edx,%eax
c0104fa1:	74 24                	je     c0104fc7 <default_check+0xda>
c0104fa3:	c7 44 24 0c 5e 70 10 	movl   $0xc010705e,0xc(%esp)
c0104faa:	c0 
c0104fab:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104fb2:	c0 
c0104fb3:	c7 44 24 04 57 01 00 	movl   $0x157,0x4(%esp)
c0104fba:	00 
c0104fbb:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0104fc2:	e8 6e b4 ff ff       	call   c0100435 <__panic>

    basic_check();
c0104fc7:	e8 df f9 ff ff       	call   c01049ab <basic_check>

    struct Page *p0 = alloc_pages(5), *p1, *p2;
c0104fcc:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
c0104fd3:	e8 52 dd ff ff       	call   c0102d2a <alloc_pages>
c0104fd8:	89 45 e8             	mov    %eax,-0x18(%ebp)
    assert(p0 != NULL);
c0104fdb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0104fdf:	75 24                	jne    c0105005 <default_check+0x118>
c0104fe1:	c7 44 24 0c 77 70 10 	movl   $0xc0107077,0xc(%esp)
c0104fe8:	c0 
c0104fe9:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0104ff0:	c0 
c0104ff1:	c7 44 24 04 5c 01 00 	movl   $0x15c,0x4(%esp)
c0104ff8:	00 
c0104ff9:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0105000:	e8 30 b4 ff ff       	call   c0100435 <__panic>
    assert(!PageProperty(p0));
c0105005:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105008:	83 c0 04             	add    $0x4,%eax
c010500b:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
c0105012:	89 45 bc             	mov    %eax,-0x44(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0105015:	8b 45 bc             	mov    -0x44(%ebp),%eax
c0105018:	8b 55 c0             	mov    -0x40(%ebp),%edx
c010501b:	0f a3 10             	bt     %edx,(%eax)
c010501e:	19 c0                	sbb    %eax,%eax
c0105020:	89 45 b8             	mov    %eax,-0x48(%ebp)
    return oldbit != 0;
c0105023:	83 7d b8 00          	cmpl   $0x0,-0x48(%ebp)
c0105027:	0f 95 c0             	setne  %al
c010502a:	0f b6 c0             	movzbl %al,%eax
c010502d:	85 c0                	test   %eax,%eax
c010502f:	74 24                	je     c0105055 <default_check+0x168>
c0105031:	c7 44 24 0c 82 70 10 	movl   $0xc0107082,0xc(%esp)
c0105038:	c0 
c0105039:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0105040:	c0 
c0105041:	c7 44 24 04 5d 01 00 	movl   $0x15d,0x4(%esp)
c0105048:	00 
c0105049:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0105050:	e8 e0 b3 ff ff       	call   c0100435 <__panic>

    list_entry_t free_list_store = free_list;
c0105055:	a1 1c cf 11 c0       	mov    0xc011cf1c,%eax
c010505a:	8b 15 20 cf 11 c0    	mov    0xc011cf20,%edx
c0105060:	89 45 80             	mov    %eax,-0x80(%ebp)
c0105063:	89 55 84             	mov    %edx,-0x7c(%ebp)
c0105066:	c7 45 b0 1c cf 11 c0 	movl   $0xc011cf1c,-0x50(%ebp)
    elm->prev = elm->next = elm;
c010506d:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0105070:	8b 55 b0             	mov    -0x50(%ebp),%edx
c0105073:	89 50 04             	mov    %edx,0x4(%eax)
c0105076:	8b 45 b0             	mov    -0x50(%ebp),%eax
c0105079:	8b 50 04             	mov    0x4(%eax),%edx
c010507c:	8b 45 b0             	mov    -0x50(%ebp),%eax
c010507f:	89 10                	mov    %edx,(%eax)
}
c0105081:	90                   	nop
c0105082:	c7 45 b4 1c cf 11 c0 	movl   $0xc011cf1c,-0x4c(%ebp)
    return list->next == list;
c0105089:	8b 45 b4             	mov    -0x4c(%ebp),%eax
c010508c:	8b 40 04             	mov    0x4(%eax),%eax
c010508f:	39 45 b4             	cmp    %eax,-0x4c(%ebp)
c0105092:	0f 94 c0             	sete   %al
c0105095:	0f b6 c0             	movzbl %al,%eax
    list_init(&free_list);
    assert(list_empty(&free_list));
c0105098:	85 c0                	test   %eax,%eax
c010509a:	75 24                	jne    c01050c0 <default_check+0x1d3>
c010509c:	c7 44 24 0c d7 6f 10 	movl   $0xc0106fd7,0xc(%esp)
c01050a3:	c0 
c01050a4:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c01050ab:	c0 
c01050ac:	c7 44 24 04 61 01 00 	movl   $0x161,0x4(%esp)
c01050b3:	00 
c01050b4:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c01050bb:	e8 75 b3 ff ff       	call   c0100435 <__panic>
    assert(alloc_page() == NULL);
c01050c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c01050c7:	e8 5e dc ff ff       	call   c0102d2a <alloc_pages>
c01050cc:	85 c0                	test   %eax,%eax
c01050ce:	74 24                	je     c01050f4 <default_check+0x207>
c01050d0:	c7 44 24 0c ee 6f 10 	movl   $0xc0106fee,0xc(%esp)
c01050d7:	c0 
c01050d8:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c01050df:	c0 
c01050e0:	c7 44 24 04 62 01 00 	movl   $0x162,0x4(%esp)
c01050e7:	00 
c01050e8:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c01050ef:	e8 41 b3 ff ff       	call   c0100435 <__panic>

    unsigned int nr_free_store = nr_free;
c01050f4:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c01050f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    nr_free = 0;
c01050fc:	c7 05 24 cf 11 c0 00 	movl   $0x0,0xc011cf24
c0105103:	00 00 00 

    free_pages(p0 + 2, 3);
c0105106:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105109:	83 c0 28             	add    $0x28,%eax
c010510c:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
c0105113:	00 
c0105114:	89 04 24             	mov    %eax,(%esp)
c0105117:	e8 4a dc ff ff       	call   c0102d66 <free_pages>
    assert(alloc_pages(4) == NULL);
c010511c:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
c0105123:	e8 02 dc ff ff       	call   c0102d2a <alloc_pages>
c0105128:	85 c0                	test   %eax,%eax
c010512a:	74 24                	je     c0105150 <default_check+0x263>
c010512c:	c7 44 24 0c 94 70 10 	movl   $0xc0107094,0xc(%esp)
c0105133:	c0 
c0105134:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c010513b:	c0 
c010513c:	c7 44 24 04 68 01 00 	movl   $0x168,0x4(%esp)
c0105143:	00 
c0105144:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c010514b:	e8 e5 b2 ff ff       	call   c0100435 <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
c0105150:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105153:	83 c0 28             	add    $0x28,%eax
c0105156:	83 c0 04             	add    $0x4,%eax
c0105159:	c7 45 ac 01 00 00 00 	movl   $0x1,-0x54(%ebp)
c0105160:	89 45 a8             	mov    %eax,-0x58(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c0105163:	8b 45 a8             	mov    -0x58(%ebp),%eax
c0105166:	8b 55 ac             	mov    -0x54(%ebp),%edx
c0105169:	0f a3 10             	bt     %edx,(%eax)
c010516c:	19 c0                	sbb    %eax,%eax
c010516e:	89 45 a4             	mov    %eax,-0x5c(%ebp)
    return oldbit != 0;
c0105171:	83 7d a4 00          	cmpl   $0x0,-0x5c(%ebp)
c0105175:	0f 95 c0             	setne  %al
c0105178:	0f b6 c0             	movzbl %al,%eax
c010517b:	85 c0                	test   %eax,%eax
c010517d:	74 0e                	je     c010518d <default_check+0x2a0>
c010517f:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105182:	83 c0 28             	add    $0x28,%eax
c0105185:	8b 40 08             	mov    0x8(%eax),%eax
c0105188:	83 f8 03             	cmp    $0x3,%eax
c010518b:	74 24                	je     c01051b1 <default_check+0x2c4>
c010518d:	c7 44 24 0c ac 70 10 	movl   $0xc01070ac,0xc(%esp)
c0105194:	c0 
c0105195:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c010519c:	c0 
c010519d:	c7 44 24 04 69 01 00 	movl   $0x169,0x4(%esp)
c01051a4:	00 
c01051a5:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c01051ac:	e8 84 b2 ff ff       	call   c0100435 <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
c01051b1:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
c01051b8:	e8 6d db ff ff       	call   c0102d2a <alloc_pages>
c01051bd:	89 45 e0             	mov    %eax,-0x20(%ebp)
c01051c0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
c01051c4:	75 24                	jne    c01051ea <default_check+0x2fd>
c01051c6:	c7 44 24 0c d8 70 10 	movl   $0xc01070d8,0xc(%esp)
c01051cd:	c0 
c01051ce:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c01051d5:	c0 
c01051d6:	c7 44 24 04 6a 01 00 	movl   $0x16a,0x4(%esp)
c01051dd:	00 
c01051de:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c01051e5:	e8 4b b2 ff ff       	call   c0100435 <__panic>
    assert(alloc_page() == NULL);
c01051ea:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c01051f1:	e8 34 db ff ff       	call   c0102d2a <alloc_pages>
c01051f6:	85 c0                	test   %eax,%eax
c01051f8:	74 24                	je     c010521e <default_check+0x331>
c01051fa:	c7 44 24 0c ee 6f 10 	movl   $0xc0106fee,0xc(%esp)
c0105201:	c0 
c0105202:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0105209:	c0 
c010520a:	c7 44 24 04 6b 01 00 	movl   $0x16b,0x4(%esp)
c0105211:	00 
c0105212:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0105219:	e8 17 b2 ff ff       	call   c0100435 <__panic>
    assert(p0 + 2 == p1);
c010521e:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105221:	83 c0 28             	add    $0x28,%eax
c0105224:	39 45 e0             	cmp    %eax,-0x20(%ebp)
c0105227:	74 24                	je     c010524d <default_check+0x360>
c0105229:	c7 44 24 0c f6 70 10 	movl   $0xc01070f6,0xc(%esp)
c0105230:	c0 
c0105231:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0105238:	c0 
c0105239:	c7 44 24 04 6c 01 00 	movl   $0x16c,0x4(%esp)
c0105240:	00 
c0105241:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0105248:	e8 e8 b1 ff ff       	call   c0100435 <__panic>

    p2 = p0 + 1;
c010524d:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105250:	83 c0 14             	add    $0x14,%eax
c0105253:	89 45 dc             	mov    %eax,-0x24(%ebp)
    free_page(p0);
c0105256:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c010525d:	00 
c010525e:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105261:	89 04 24             	mov    %eax,(%esp)
c0105264:	e8 fd da ff ff       	call   c0102d66 <free_pages>
    free_pages(p1, 3);
c0105269:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
c0105270:	00 
c0105271:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105274:	89 04 24             	mov    %eax,(%esp)
c0105277:	e8 ea da ff ff       	call   c0102d66 <free_pages>
    assert(PageProperty(p0) && p0->property == 1);
c010527c:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010527f:	83 c0 04             	add    $0x4,%eax
c0105282:	c7 45 a0 01 00 00 00 	movl   $0x1,-0x60(%ebp)
c0105289:	89 45 9c             	mov    %eax,-0x64(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c010528c:	8b 45 9c             	mov    -0x64(%ebp),%eax
c010528f:	8b 55 a0             	mov    -0x60(%ebp),%edx
c0105292:	0f a3 10             	bt     %edx,(%eax)
c0105295:	19 c0                	sbb    %eax,%eax
c0105297:	89 45 98             	mov    %eax,-0x68(%ebp)
    return oldbit != 0;
c010529a:	83 7d 98 00          	cmpl   $0x0,-0x68(%ebp)
c010529e:	0f 95 c0             	setne  %al
c01052a1:	0f b6 c0             	movzbl %al,%eax
c01052a4:	85 c0                	test   %eax,%eax
c01052a6:	74 0b                	je     c01052b3 <default_check+0x3c6>
c01052a8:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01052ab:	8b 40 08             	mov    0x8(%eax),%eax
c01052ae:	83 f8 01             	cmp    $0x1,%eax
c01052b1:	74 24                	je     c01052d7 <default_check+0x3ea>
c01052b3:	c7 44 24 0c 04 71 10 	movl   $0xc0107104,0xc(%esp)
c01052ba:	c0 
c01052bb:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c01052c2:	c0 
c01052c3:	c7 44 24 04 71 01 00 	movl   $0x171,0x4(%esp)
c01052ca:	00 
c01052cb:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c01052d2:	e8 5e b1 ff ff       	call   c0100435 <__panic>
    assert(PageProperty(p1) && p1->property == 3);
c01052d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
c01052da:	83 c0 04             	add    $0x4,%eax
c01052dd:	c7 45 94 01 00 00 00 	movl   $0x1,-0x6c(%ebp)
c01052e4:	89 45 90             	mov    %eax,-0x70(%ebp)
    asm volatile ("btl %2, %1; sbbl %0,%0" : "=r" (oldbit) : "m" (*(volatile long *)addr), "Ir" (nr));
c01052e7:	8b 45 90             	mov    -0x70(%ebp),%eax
c01052ea:	8b 55 94             	mov    -0x6c(%ebp),%edx
c01052ed:	0f a3 10             	bt     %edx,(%eax)
c01052f0:	19 c0                	sbb    %eax,%eax
c01052f2:	89 45 8c             	mov    %eax,-0x74(%ebp)
    return oldbit != 0;
c01052f5:	83 7d 8c 00          	cmpl   $0x0,-0x74(%ebp)
c01052f9:	0f 95 c0             	setne  %al
c01052fc:	0f b6 c0             	movzbl %al,%eax
c01052ff:	85 c0                	test   %eax,%eax
c0105301:	74 0b                	je     c010530e <default_check+0x421>
c0105303:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105306:	8b 40 08             	mov    0x8(%eax),%eax
c0105309:	83 f8 03             	cmp    $0x3,%eax
c010530c:	74 24                	je     c0105332 <default_check+0x445>
c010530e:	c7 44 24 0c 2c 71 10 	movl   $0xc010712c,0xc(%esp)
c0105315:	c0 
c0105316:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c010531d:	c0 
c010531e:	c7 44 24 04 72 01 00 	movl   $0x172,0x4(%esp)
c0105325:	00 
c0105326:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c010532d:	e8 03 b1 ff ff       	call   c0100435 <__panic>

    assert((p0 = alloc_page()) == p2 - 1);
c0105332:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0105339:	e8 ec d9 ff ff       	call   c0102d2a <alloc_pages>
c010533e:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105341:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0105344:	83 e8 14             	sub    $0x14,%eax
c0105347:	39 45 e8             	cmp    %eax,-0x18(%ebp)
c010534a:	74 24                	je     c0105370 <default_check+0x483>
c010534c:	c7 44 24 0c 52 71 10 	movl   $0xc0107152,0xc(%esp)
c0105353:	c0 
c0105354:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c010535b:	c0 
c010535c:	c7 44 24 04 74 01 00 	movl   $0x174,0x4(%esp)
c0105363:	00 
c0105364:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c010536b:	e8 c5 b0 ff ff       	call   c0100435 <__panic>
    free_page(p0);
c0105370:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c0105377:	00 
c0105378:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010537b:	89 04 24             	mov    %eax,(%esp)
c010537e:	e8 e3 d9 ff ff       	call   c0102d66 <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
c0105383:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
c010538a:	e8 9b d9 ff ff       	call   c0102d2a <alloc_pages>
c010538f:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105392:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0105395:	83 c0 14             	add    $0x14,%eax
c0105398:	39 45 e8             	cmp    %eax,-0x18(%ebp)
c010539b:	74 24                	je     c01053c1 <default_check+0x4d4>
c010539d:	c7 44 24 0c 70 71 10 	movl   $0xc0107170,0xc(%esp)
c01053a4:	c0 
c01053a5:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c01053ac:	c0 
c01053ad:	c7 44 24 04 76 01 00 	movl   $0x176,0x4(%esp)
c01053b4:	00 
c01053b5:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c01053bc:	e8 74 b0 ff ff       	call   c0100435 <__panic>

    free_pages(p0, 2);
c01053c1:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
c01053c8:	00 
c01053c9:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01053cc:	89 04 24             	mov    %eax,(%esp)
c01053cf:	e8 92 d9 ff ff       	call   c0102d66 <free_pages>
    free_page(p2);
c01053d4:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
c01053db:	00 
c01053dc:	8b 45 dc             	mov    -0x24(%ebp),%eax
c01053df:	89 04 24             	mov    %eax,(%esp)
c01053e2:	e8 7f d9 ff ff       	call   c0102d66 <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
c01053e7:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
c01053ee:	e8 37 d9 ff ff       	call   c0102d2a <alloc_pages>
c01053f3:	89 45 e8             	mov    %eax,-0x18(%ebp)
c01053f6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c01053fa:	75 24                	jne    c0105420 <default_check+0x533>
c01053fc:	c7 44 24 0c 90 71 10 	movl   $0xc0107190,0xc(%esp)
c0105403:	c0 
c0105404:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c010540b:	c0 
c010540c:	c7 44 24 04 7b 01 00 	movl   $0x17b,0x4(%esp)
c0105413:	00 
c0105414:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c010541b:	e8 15 b0 ff ff       	call   c0100435 <__panic>
    assert(alloc_page() == NULL);
c0105420:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
c0105427:	e8 fe d8 ff ff       	call   c0102d2a <alloc_pages>
c010542c:	85 c0                	test   %eax,%eax
c010542e:	74 24                	je     c0105454 <default_check+0x567>
c0105430:	c7 44 24 0c ee 6f 10 	movl   $0xc0106fee,0xc(%esp)
c0105437:	c0 
c0105438:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c010543f:	c0 
c0105440:	c7 44 24 04 7c 01 00 	movl   $0x17c,0x4(%esp)
c0105447:	00 
c0105448:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c010544f:	e8 e1 af ff ff       	call   c0100435 <__panic>

    assert(nr_free == 0);
c0105454:	a1 24 cf 11 c0       	mov    0xc011cf24,%eax
c0105459:	85 c0                	test   %eax,%eax
c010545b:	74 24                	je     c0105481 <default_check+0x594>
c010545d:	c7 44 24 0c 41 70 10 	movl   $0xc0107041,0xc(%esp)
c0105464:	c0 
c0105465:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c010546c:	c0 
c010546d:	c7 44 24 04 7e 01 00 	movl   $0x17e,0x4(%esp)
c0105474:	00 
c0105475:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c010547c:	e8 b4 af ff ff       	call   c0100435 <__panic>
    nr_free = nr_free_store;
c0105481:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105484:	a3 24 cf 11 c0       	mov    %eax,0xc011cf24

    free_list = free_list_store;
c0105489:	8b 45 80             	mov    -0x80(%ebp),%eax
c010548c:	8b 55 84             	mov    -0x7c(%ebp),%edx
c010548f:	a3 1c cf 11 c0       	mov    %eax,0xc011cf1c
c0105494:	89 15 20 cf 11 c0    	mov    %edx,0xc011cf20
    free_pages(p0, 5);
c010549a:	c7 44 24 04 05 00 00 	movl   $0x5,0x4(%esp)
c01054a1:	00 
c01054a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
c01054a5:	89 04 24             	mov    %eax,(%esp)
c01054a8:	e8 b9 d8 ff ff       	call   c0102d66 <free_pages>

    le = &free_list;
c01054ad:	c7 45 ec 1c cf 11 c0 	movl   $0xc011cf1c,-0x14(%ebp)
    while ((le = list_next(le)) != &free_list) {
c01054b4:	eb 5a                	jmp    c0105510 <default_check+0x623>
        assert(le->next->prev == le && le->prev->next == le);
c01054b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01054b9:	8b 40 04             	mov    0x4(%eax),%eax
c01054bc:	8b 00                	mov    (%eax),%eax
c01054be:	39 45 ec             	cmp    %eax,-0x14(%ebp)
c01054c1:	75 0d                	jne    c01054d0 <default_check+0x5e3>
c01054c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01054c6:	8b 00                	mov    (%eax),%eax
c01054c8:	8b 40 04             	mov    0x4(%eax),%eax
c01054cb:	39 45 ec             	cmp    %eax,-0x14(%ebp)
c01054ce:	74 24                	je     c01054f4 <default_check+0x607>
c01054d0:	c7 44 24 0c b0 71 10 	movl   $0xc01071b0,0xc(%esp)
c01054d7:	c0 
c01054d8:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c01054df:	c0 
c01054e0:	c7 44 24 04 86 01 00 	movl   $0x186,0x4(%esp)
c01054e7:	00 
c01054e8:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c01054ef:	e8 41 af ff ff       	call   c0100435 <__panic>
        struct Page *p = le2page(le, page_link);
c01054f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01054f7:	83 e8 0c             	sub    $0xc,%eax
c01054fa:	89 45 d8             	mov    %eax,-0x28(%ebp)
        count --, total -= p->property;
c01054fd:	ff 4d f4             	decl   -0xc(%ebp)
c0105500:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0105503:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0105506:	8b 40 08             	mov    0x8(%eax),%eax
c0105509:	29 c2                	sub    %eax,%edx
c010550b:	89 d0                	mov    %edx,%eax
c010550d:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105510:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105513:	89 45 88             	mov    %eax,-0x78(%ebp)
    return listelm->next;
c0105516:	8b 45 88             	mov    -0x78(%ebp),%eax
c0105519:	8b 40 04             	mov    0x4(%eax),%eax
    while ((le = list_next(le)) != &free_list) {
c010551c:	89 45 ec             	mov    %eax,-0x14(%ebp)
c010551f:	81 7d ec 1c cf 11 c0 	cmpl   $0xc011cf1c,-0x14(%ebp)
c0105526:	75 8e                	jne    c01054b6 <default_check+0x5c9>
    }
    assert(count == 0);
c0105528:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
c010552c:	74 24                	je     c0105552 <default_check+0x665>
c010552e:	c7 44 24 0c dd 71 10 	movl   $0xc01071dd,0xc(%esp)
c0105535:	c0 
c0105536:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c010553d:	c0 
c010553e:	c7 44 24 04 8a 01 00 	movl   $0x18a,0x4(%esp)
c0105545:	00 
c0105546:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c010554d:	e8 e3 ae ff ff       	call   c0100435 <__panic>
    assert(total == 0);
c0105552:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0105556:	74 24                	je     c010557c <default_check+0x68f>
c0105558:	c7 44 24 0c e8 71 10 	movl   $0xc01071e8,0xc(%esp)
c010555f:	c0 
c0105560:	c7 44 24 08 7e 6e 10 	movl   $0xc0106e7e,0x8(%esp)
c0105567:	c0 
c0105568:	c7 44 24 04 8b 01 00 	movl   $0x18b,0x4(%esp)
c010556f:	00 
c0105570:	c7 04 24 93 6e 10 c0 	movl   $0xc0106e93,(%esp)
c0105577:	e8 b9 ae ff ff       	call   c0100435 <__panic>
}
c010557c:	90                   	nop
c010557d:	c9                   	leave  
c010557e:	c3                   	ret    

c010557f <strlen>:
 * @s:      the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
c010557f:	f3 0f 1e fb          	endbr32 
c0105583:	55                   	push   %ebp
c0105584:	89 e5                	mov    %esp,%ebp
c0105586:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
c0105589:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
c0105590:	eb 03                	jmp    c0105595 <strlen+0x16>
        cnt ++;
c0105592:	ff 45 fc             	incl   -0x4(%ebp)
    while (*s ++ != '\0') {
c0105595:	8b 45 08             	mov    0x8(%ebp),%eax
c0105598:	8d 50 01             	lea    0x1(%eax),%edx
c010559b:	89 55 08             	mov    %edx,0x8(%ebp)
c010559e:	0f b6 00             	movzbl (%eax),%eax
c01055a1:	84 c0                	test   %al,%al
c01055a3:	75 ed                	jne    c0105592 <strlen+0x13>
    }
    return cnt;
c01055a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c01055a8:	c9                   	leave  
c01055a9:	c3                   	ret    

c01055aa <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
c01055aa:	f3 0f 1e fb          	endbr32 
c01055ae:	55                   	push   %ebp
c01055af:	89 e5                	mov    %esp,%ebp
c01055b1:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
c01055b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
c01055bb:	eb 03                	jmp    c01055c0 <strnlen+0x16>
        cnt ++;
c01055bd:	ff 45 fc             	incl   -0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
c01055c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
c01055c3:	3b 45 0c             	cmp    0xc(%ebp),%eax
c01055c6:	73 10                	jae    c01055d8 <strnlen+0x2e>
c01055c8:	8b 45 08             	mov    0x8(%ebp),%eax
c01055cb:	8d 50 01             	lea    0x1(%eax),%edx
c01055ce:	89 55 08             	mov    %edx,0x8(%ebp)
c01055d1:	0f b6 00             	movzbl (%eax),%eax
c01055d4:	84 c0                	test   %al,%al
c01055d6:	75 e5                	jne    c01055bd <strnlen+0x13>
    }
    return cnt;
c01055d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
c01055db:	c9                   	leave  
c01055dc:	c3                   	ret    

c01055dd <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
c01055dd:	f3 0f 1e fb          	endbr32 
c01055e1:	55                   	push   %ebp
c01055e2:	89 e5                	mov    %esp,%ebp
c01055e4:	57                   	push   %edi
c01055e5:	56                   	push   %esi
c01055e6:	83 ec 20             	sub    $0x20,%esp
c01055e9:	8b 45 08             	mov    0x8(%ebp),%eax
c01055ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01055ef:	8b 45 0c             	mov    0xc(%ebp),%eax
c01055f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
c01055f5:	8b 55 f0             	mov    -0x10(%ebp),%edx
c01055f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
c01055fb:	89 d1                	mov    %edx,%ecx
c01055fd:	89 c2                	mov    %eax,%edx
c01055ff:	89 ce                	mov    %ecx,%esi
c0105601:	89 d7                	mov    %edx,%edi
c0105603:	ac                   	lods   %ds:(%esi),%al
c0105604:	aa                   	stos   %al,%es:(%edi)
c0105605:	84 c0                	test   %al,%al
c0105607:	75 fa                	jne    c0105603 <strcpy+0x26>
c0105609:	89 fa                	mov    %edi,%edx
c010560b:	89 f1                	mov    %esi,%ecx
c010560d:	89 4d ec             	mov    %ecx,-0x14(%ebp)
c0105610:	89 55 e8             	mov    %edx,-0x18(%ebp)
c0105613:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        "stosb;"
        "testb %%al, %%al;"
        "jne 1b;"
        : "=&S" (d0), "=&D" (d1), "=&a" (d2)
        : "0" (src), "1" (dst) : "memory");
    return dst;
c0105616:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
c0105619:	83 c4 20             	add    $0x20,%esp
c010561c:	5e                   	pop    %esi
c010561d:	5f                   	pop    %edi
c010561e:	5d                   	pop    %ebp
c010561f:	c3                   	ret    

c0105620 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
c0105620:	f3 0f 1e fb          	endbr32 
c0105624:	55                   	push   %ebp
c0105625:	89 e5                	mov    %esp,%ebp
c0105627:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
c010562a:	8b 45 08             	mov    0x8(%ebp),%eax
c010562d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
c0105630:	eb 1e                	jmp    c0105650 <strncpy+0x30>
        if ((*p = *src) != '\0') {
c0105632:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105635:	0f b6 10             	movzbl (%eax),%edx
c0105638:	8b 45 fc             	mov    -0x4(%ebp),%eax
c010563b:	88 10                	mov    %dl,(%eax)
c010563d:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0105640:	0f b6 00             	movzbl (%eax),%eax
c0105643:	84 c0                	test   %al,%al
c0105645:	74 03                	je     c010564a <strncpy+0x2a>
            src ++;
c0105647:	ff 45 0c             	incl   0xc(%ebp)
        }
        p ++, len --;
c010564a:	ff 45 fc             	incl   -0x4(%ebp)
c010564d:	ff 4d 10             	decl   0x10(%ebp)
    while (len > 0) {
c0105650:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105654:	75 dc                	jne    c0105632 <strncpy+0x12>
    }
    return dst;
c0105656:	8b 45 08             	mov    0x8(%ebp),%eax
}
c0105659:	c9                   	leave  
c010565a:	c3                   	ret    

c010565b <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
c010565b:	f3 0f 1e fb          	endbr32 
c010565f:	55                   	push   %ebp
c0105660:	89 e5                	mov    %esp,%ebp
c0105662:	57                   	push   %edi
c0105663:	56                   	push   %esi
c0105664:	83 ec 20             	sub    $0x20,%esp
c0105667:	8b 45 08             	mov    0x8(%ebp),%eax
c010566a:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010566d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105670:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
c0105673:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105676:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105679:	89 d1                	mov    %edx,%ecx
c010567b:	89 c2                	mov    %eax,%edx
c010567d:	89 ce                	mov    %ecx,%esi
c010567f:	89 d7                	mov    %edx,%edi
c0105681:	ac                   	lods   %ds:(%esi),%al
c0105682:	ae                   	scas   %es:(%edi),%al
c0105683:	75 08                	jne    c010568d <strcmp+0x32>
c0105685:	84 c0                	test   %al,%al
c0105687:	75 f8                	jne    c0105681 <strcmp+0x26>
c0105689:	31 c0                	xor    %eax,%eax
c010568b:	eb 04                	jmp    c0105691 <strcmp+0x36>
c010568d:	19 c0                	sbb    %eax,%eax
c010568f:	0c 01                	or     $0x1,%al
c0105691:	89 fa                	mov    %edi,%edx
c0105693:	89 f1                	mov    %esi,%ecx
c0105695:	89 45 ec             	mov    %eax,-0x14(%ebp)
c0105698:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c010569b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
c010569e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
c01056a1:	83 c4 20             	add    $0x20,%esp
c01056a4:	5e                   	pop    %esi
c01056a5:	5f                   	pop    %edi
c01056a6:	5d                   	pop    %ebp
c01056a7:	c3                   	ret    

c01056a8 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
c01056a8:	f3 0f 1e fb          	endbr32 
c01056ac:	55                   	push   %ebp
c01056ad:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
c01056af:	eb 09                	jmp    c01056ba <strncmp+0x12>
        n --, s1 ++, s2 ++;
c01056b1:	ff 4d 10             	decl   0x10(%ebp)
c01056b4:	ff 45 08             	incl   0x8(%ebp)
c01056b7:	ff 45 0c             	incl   0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
c01056ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01056be:	74 1a                	je     c01056da <strncmp+0x32>
c01056c0:	8b 45 08             	mov    0x8(%ebp),%eax
c01056c3:	0f b6 00             	movzbl (%eax),%eax
c01056c6:	84 c0                	test   %al,%al
c01056c8:	74 10                	je     c01056da <strncmp+0x32>
c01056ca:	8b 45 08             	mov    0x8(%ebp),%eax
c01056cd:	0f b6 10             	movzbl (%eax),%edx
c01056d0:	8b 45 0c             	mov    0xc(%ebp),%eax
c01056d3:	0f b6 00             	movzbl (%eax),%eax
c01056d6:	38 c2                	cmp    %al,%dl
c01056d8:	74 d7                	je     c01056b1 <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
c01056da:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01056de:	74 18                	je     c01056f8 <strncmp+0x50>
c01056e0:	8b 45 08             	mov    0x8(%ebp),%eax
c01056e3:	0f b6 00             	movzbl (%eax),%eax
c01056e6:	0f b6 d0             	movzbl %al,%edx
c01056e9:	8b 45 0c             	mov    0xc(%ebp),%eax
c01056ec:	0f b6 00             	movzbl (%eax),%eax
c01056ef:	0f b6 c0             	movzbl %al,%eax
c01056f2:	29 c2                	sub    %eax,%edx
c01056f4:	89 d0                	mov    %edx,%eax
c01056f6:	eb 05                	jmp    c01056fd <strncmp+0x55>
c01056f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
c01056fd:	5d                   	pop    %ebp
c01056fe:	c3                   	ret    

c01056ff <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
c01056ff:	f3 0f 1e fb          	endbr32 
c0105703:	55                   	push   %ebp
c0105704:	89 e5                	mov    %esp,%ebp
c0105706:	83 ec 04             	sub    $0x4,%esp
c0105709:	8b 45 0c             	mov    0xc(%ebp),%eax
c010570c:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
c010570f:	eb 13                	jmp    c0105724 <strchr+0x25>
        if (*s == c) {
c0105711:	8b 45 08             	mov    0x8(%ebp),%eax
c0105714:	0f b6 00             	movzbl (%eax),%eax
c0105717:	38 45 fc             	cmp    %al,-0x4(%ebp)
c010571a:	75 05                	jne    c0105721 <strchr+0x22>
            return (char *)s;
c010571c:	8b 45 08             	mov    0x8(%ebp),%eax
c010571f:	eb 12                	jmp    c0105733 <strchr+0x34>
        }
        s ++;
c0105721:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
c0105724:	8b 45 08             	mov    0x8(%ebp),%eax
c0105727:	0f b6 00             	movzbl (%eax),%eax
c010572a:	84 c0                	test   %al,%al
c010572c:	75 e3                	jne    c0105711 <strchr+0x12>
    }
    return NULL;
c010572e:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0105733:	c9                   	leave  
c0105734:	c3                   	ret    

c0105735 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
c0105735:	f3 0f 1e fb          	endbr32 
c0105739:	55                   	push   %ebp
c010573a:	89 e5                	mov    %esp,%ebp
c010573c:	83 ec 04             	sub    $0x4,%esp
c010573f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105742:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
c0105745:	eb 0e                	jmp    c0105755 <strfind+0x20>
        if (*s == c) {
c0105747:	8b 45 08             	mov    0x8(%ebp),%eax
c010574a:	0f b6 00             	movzbl (%eax),%eax
c010574d:	38 45 fc             	cmp    %al,-0x4(%ebp)
c0105750:	74 0f                	je     c0105761 <strfind+0x2c>
            break;
        }
        s ++;
c0105752:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
c0105755:	8b 45 08             	mov    0x8(%ebp),%eax
c0105758:	0f b6 00             	movzbl (%eax),%eax
c010575b:	84 c0                	test   %al,%al
c010575d:	75 e8                	jne    c0105747 <strfind+0x12>
c010575f:	eb 01                	jmp    c0105762 <strfind+0x2d>
            break;
c0105761:	90                   	nop
    }
    return (char *)s;
c0105762:	8b 45 08             	mov    0x8(%ebp),%eax
}
c0105765:	c9                   	leave  
c0105766:	c3                   	ret    

c0105767 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
c0105767:	f3 0f 1e fb          	endbr32 
c010576b:	55                   	push   %ebp
c010576c:	89 e5                	mov    %esp,%ebp
c010576e:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
c0105771:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
c0105778:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
c010577f:	eb 03                	jmp    c0105784 <strtol+0x1d>
        s ++;
c0105781:	ff 45 08             	incl   0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
c0105784:	8b 45 08             	mov    0x8(%ebp),%eax
c0105787:	0f b6 00             	movzbl (%eax),%eax
c010578a:	3c 20                	cmp    $0x20,%al
c010578c:	74 f3                	je     c0105781 <strtol+0x1a>
c010578e:	8b 45 08             	mov    0x8(%ebp),%eax
c0105791:	0f b6 00             	movzbl (%eax),%eax
c0105794:	3c 09                	cmp    $0x9,%al
c0105796:	74 e9                	je     c0105781 <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
c0105798:	8b 45 08             	mov    0x8(%ebp),%eax
c010579b:	0f b6 00             	movzbl (%eax),%eax
c010579e:	3c 2b                	cmp    $0x2b,%al
c01057a0:	75 05                	jne    c01057a7 <strtol+0x40>
        s ++;
c01057a2:	ff 45 08             	incl   0x8(%ebp)
c01057a5:	eb 14                	jmp    c01057bb <strtol+0x54>
    }
    else if (*s == '-') {
c01057a7:	8b 45 08             	mov    0x8(%ebp),%eax
c01057aa:	0f b6 00             	movzbl (%eax),%eax
c01057ad:	3c 2d                	cmp    $0x2d,%al
c01057af:	75 0a                	jne    c01057bb <strtol+0x54>
        s ++, neg = 1;
c01057b1:	ff 45 08             	incl   0x8(%ebp)
c01057b4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
c01057bb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01057bf:	74 06                	je     c01057c7 <strtol+0x60>
c01057c1:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
c01057c5:	75 22                	jne    c01057e9 <strtol+0x82>
c01057c7:	8b 45 08             	mov    0x8(%ebp),%eax
c01057ca:	0f b6 00             	movzbl (%eax),%eax
c01057cd:	3c 30                	cmp    $0x30,%al
c01057cf:	75 18                	jne    c01057e9 <strtol+0x82>
c01057d1:	8b 45 08             	mov    0x8(%ebp),%eax
c01057d4:	40                   	inc    %eax
c01057d5:	0f b6 00             	movzbl (%eax),%eax
c01057d8:	3c 78                	cmp    $0x78,%al
c01057da:	75 0d                	jne    c01057e9 <strtol+0x82>
        s += 2, base = 16;
c01057dc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
c01057e0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
c01057e7:	eb 29                	jmp    c0105812 <strtol+0xab>
    }
    else if (base == 0 && s[0] == '0') {
c01057e9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c01057ed:	75 16                	jne    c0105805 <strtol+0x9e>
c01057ef:	8b 45 08             	mov    0x8(%ebp),%eax
c01057f2:	0f b6 00             	movzbl (%eax),%eax
c01057f5:	3c 30                	cmp    $0x30,%al
c01057f7:	75 0c                	jne    c0105805 <strtol+0x9e>
        s ++, base = 8;
c01057f9:	ff 45 08             	incl   0x8(%ebp)
c01057fc:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
c0105803:	eb 0d                	jmp    c0105812 <strtol+0xab>
    }
    else if (base == 0) {
c0105805:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
c0105809:	75 07                	jne    c0105812 <strtol+0xab>
        base = 10;
c010580b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
c0105812:	8b 45 08             	mov    0x8(%ebp),%eax
c0105815:	0f b6 00             	movzbl (%eax),%eax
c0105818:	3c 2f                	cmp    $0x2f,%al
c010581a:	7e 1b                	jle    c0105837 <strtol+0xd0>
c010581c:	8b 45 08             	mov    0x8(%ebp),%eax
c010581f:	0f b6 00             	movzbl (%eax),%eax
c0105822:	3c 39                	cmp    $0x39,%al
c0105824:	7f 11                	jg     c0105837 <strtol+0xd0>
            dig = *s - '0';
c0105826:	8b 45 08             	mov    0x8(%ebp),%eax
c0105829:	0f b6 00             	movzbl (%eax),%eax
c010582c:	0f be c0             	movsbl %al,%eax
c010582f:	83 e8 30             	sub    $0x30,%eax
c0105832:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0105835:	eb 48                	jmp    c010587f <strtol+0x118>
        }
        else if (*s >= 'a' && *s <= 'z') {
c0105837:	8b 45 08             	mov    0x8(%ebp),%eax
c010583a:	0f b6 00             	movzbl (%eax),%eax
c010583d:	3c 60                	cmp    $0x60,%al
c010583f:	7e 1b                	jle    c010585c <strtol+0xf5>
c0105841:	8b 45 08             	mov    0x8(%ebp),%eax
c0105844:	0f b6 00             	movzbl (%eax),%eax
c0105847:	3c 7a                	cmp    $0x7a,%al
c0105849:	7f 11                	jg     c010585c <strtol+0xf5>
            dig = *s - 'a' + 10;
c010584b:	8b 45 08             	mov    0x8(%ebp),%eax
c010584e:	0f b6 00             	movzbl (%eax),%eax
c0105851:	0f be c0             	movsbl %al,%eax
c0105854:	83 e8 57             	sub    $0x57,%eax
c0105857:	89 45 f4             	mov    %eax,-0xc(%ebp)
c010585a:	eb 23                	jmp    c010587f <strtol+0x118>
        }
        else if (*s >= 'A' && *s <= 'Z') {
c010585c:	8b 45 08             	mov    0x8(%ebp),%eax
c010585f:	0f b6 00             	movzbl (%eax),%eax
c0105862:	3c 40                	cmp    $0x40,%al
c0105864:	7e 3b                	jle    c01058a1 <strtol+0x13a>
c0105866:	8b 45 08             	mov    0x8(%ebp),%eax
c0105869:	0f b6 00             	movzbl (%eax),%eax
c010586c:	3c 5a                	cmp    $0x5a,%al
c010586e:	7f 31                	jg     c01058a1 <strtol+0x13a>
            dig = *s - 'A' + 10;
c0105870:	8b 45 08             	mov    0x8(%ebp),%eax
c0105873:	0f b6 00             	movzbl (%eax),%eax
c0105876:	0f be c0             	movsbl %al,%eax
c0105879:	83 e8 37             	sub    $0x37,%eax
c010587c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
c010587f:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0105882:	3b 45 10             	cmp    0x10(%ebp),%eax
c0105885:	7d 19                	jge    c01058a0 <strtol+0x139>
            break;
        }
        s ++, val = (val * base) + dig;
c0105887:	ff 45 08             	incl   0x8(%ebp)
c010588a:	8b 45 f8             	mov    -0x8(%ebp),%eax
c010588d:	0f af 45 10          	imul   0x10(%ebp),%eax
c0105891:	89 c2                	mov    %eax,%edx
c0105893:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0105896:	01 d0                	add    %edx,%eax
c0105898:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
c010589b:	e9 72 ff ff ff       	jmp    c0105812 <strtol+0xab>
            break;
c01058a0:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
c01058a1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c01058a5:	74 08                	je     c01058af <strtol+0x148>
        *endptr = (char *) s;
c01058a7:	8b 45 0c             	mov    0xc(%ebp),%eax
c01058aa:	8b 55 08             	mov    0x8(%ebp),%edx
c01058ad:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
c01058af:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
c01058b3:	74 07                	je     c01058bc <strtol+0x155>
c01058b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
c01058b8:	f7 d8                	neg    %eax
c01058ba:	eb 03                	jmp    c01058bf <strtol+0x158>
c01058bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
c01058bf:	c9                   	leave  
c01058c0:	c3                   	ret    

c01058c1 <memset>:
 * @n:      number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
c01058c1:	f3 0f 1e fb          	endbr32 
c01058c5:	55                   	push   %ebp
c01058c6:	89 e5                	mov    %esp,%ebp
c01058c8:	57                   	push   %edi
c01058c9:	83 ec 24             	sub    $0x24,%esp
c01058cc:	8b 45 0c             	mov    0xc(%ebp),%eax
c01058cf:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
c01058d2:	0f be 55 d8          	movsbl -0x28(%ebp),%edx
c01058d6:	8b 45 08             	mov    0x8(%ebp),%eax
c01058d9:	89 45 f8             	mov    %eax,-0x8(%ebp)
c01058dc:	88 55 f7             	mov    %dl,-0x9(%ebp)
c01058df:	8b 45 10             	mov    0x10(%ebp),%eax
c01058e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
c01058e5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
c01058e8:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
c01058ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
c01058ef:	89 d7                	mov    %edx,%edi
c01058f1:	f3 aa                	rep stos %al,%es:(%edi)
c01058f3:	89 fa                	mov    %edi,%edx
c01058f5:	89 4d ec             	mov    %ecx,-0x14(%ebp)
c01058f8:	89 55 e8             	mov    %edx,-0x18(%ebp)
        "rep; stosb;"
        : "=&c" (d0), "=&D" (d1)
        : "0" (n), "a" (c), "1" (s)
        : "memory");
    return s;
c01058fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
c01058fe:	83 c4 24             	add    $0x24,%esp
c0105901:	5f                   	pop    %edi
c0105902:	5d                   	pop    %ebp
c0105903:	c3                   	ret    

c0105904 <memmove>:
 * @n:      number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
c0105904:	f3 0f 1e fb          	endbr32 
c0105908:	55                   	push   %ebp
c0105909:	89 e5                	mov    %esp,%ebp
c010590b:	57                   	push   %edi
c010590c:	56                   	push   %esi
c010590d:	53                   	push   %ebx
c010590e:	83 ec 30             	sub    $0x30,%esp
c0105911:	8b 45 08             	mov    0x8(%ebp),%eax
c0105914:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105917:	8b 45 0c             	mov    0xc(%ebp),%eax
c010591a:	89 45 ec             	mov    %eax,-0x14(%ebp)
c010591d:	8b 45 10             	mov    0x10(%ebp),%eax
c0105920:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
c0105923:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105926:	3b 45 ec             	cmp    -0x14(%ebp),%eax
c0105929:	73 42                	jae    c010596d <memmove+0x69>
c010592b:	8b 45 f0             	mov    -0x10(%ebp),%eax
c010592e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0105931:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105934:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0105937:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010593a:	89 45 dc             	mov    %eax,-0x24(%ebp)
        "andl $3, %%ecx;"
        "jz 1f;"
        "rep; movsb;"
        "1:"
        : "=&c" (d0), "=&D" (d1), "=&S" (d2)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
c010593d:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0105940:	c1 e8 02             	shr    $0x2,%eax
c0105943:	89 c1                	mov    %eax,%ecx
    asm volatile (
c0105945:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0105948:	8b 45 e0             	mov    -0x20(%ebp),%eax
c010594b:	89 d7                	mov    %edx,%edi
c010594d:	89 c6                	mov    %eax,%esi
c010594f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
c0105951:	8b 4d dc             	mov    -0x24(%ebp),%ecx
c0105954:	83 e1 03             	and    $0x3,%ecx
c0105957:	74 02                	je     c010595b <memmove+0x57>
c0105959:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c010595b:	89 f0                	mov    %esi,%eax
c010595d:	89 fa                	mov    %edi,%edx
c010595f:	89 4d d8             	mov    %ecx,-0x28(%ebp)
c0105962:	89 55 d4             	mov    %edx,-0x2c(%ebp)
c0105965:	89 45 d0             	mov    %eax,-0x30(%ebp)
        : "memory");
    return dst;
c0105968:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
c010596b:	eb 36                	jmp    c01059a3 <memmove+0x9f>
        : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
c010596d:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105970:	8d 50 ff             	lea    -0x1(%eax),%edx
c0105973:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105976:	01 c2                	add    %eax,%edx
c0105978:	8b 45 e8             	mov    -0x18(%ebp),%eax
c010597b:	8d 48 ff             	lea    -0x1(%eax),%ecx
c010597e:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105981:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
c0105984:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105987:	89 c1                	mov    %eax,%ecx
c0105989:	89 d8                	mov    %ebx,%eax
c010598b:	89 d6                	mov    %edx,%esi
c010598d:	89 c7                	mov    %eax,%edi
c010598f:	fd                   	std    
c0105990:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c0105992:	fc                   	cld    
c0105993:	89 f8                	mov    %edi,%eax
c0105995:	89 f2                	mov    %esi,%edx
c0105997:	89 4d cc             	mov    %ecx,-0x34(%ebp)
c010599a:	89 55 c8             	mov    %edx,-0x38(%ebp)
c010599d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
c01059a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
c01059a3:	83 c4 30             	add    $0x30,%esp
c01059a6:	5b                   	pop    %ebx
c01059a7:	5e                   	pop    %esi
c01059a8:	5f                   	pop    %edi
c01059a9:	5d                   	pop    %ebp
c01059aa:	c3                   	ret    

c01059ab <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
c01059ab:	f3 0f 1e fb          	endbr32 
c01059af:	55                   	push   %ebp
c01059b0:	89 e5                	mov    %esp,%ebp
c01059b2:	57                   	push   %edi
c01059b3:	56                   	push   %esi
c01059b4:	83 ec 20             	sub    $0x20,%esp
c01059b7:	8b 45 08             	mov    0x8(%ebp),%eax
c01059ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
c01059bd:	8b 45 0c             	mov    0xc(%ebp),%eax
c01059c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
c01059c3:	8b 45 10             	mov    0x10(%ebp),%eax
c01059c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
        : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
c01059c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01059cc:	c1 e8 02             	shr    $0x2,%eax
c01059cf:	89 c1                	mov    %eax,%ecx
    asm volatile (
c01059d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
c01059d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01059d7:	89 d7                	mov    %edx,%edi
c01059d9:	89 c6                	mov    %eax,%esi
c01059db:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
c01059dd:	8b 4d ec             	mov    -0x14(%ebp),%ecx
c01059e0:	83 e1 03             	and    $0x3,%ecx
c01059e3:	74 02                	je     c01059e7 <memcpy+0x3c>
c01059e5:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
c01059e7:	89 f0                	mov    %esi,%eax
c01059e9:	89 fa                	mov    %edi,%edx
c01059eb:	89 4d e8             	mov    %ecx,-0x18(%ebp)
c01059ee:	89 55 e4             	mov    %edx,-0x1c(%ebp)
c01059f1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
c01059f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
c01059f7:	83 c4 20             	add    $0x20,%esp
c01059fa:	5e                   	pop    %esi
c01059fb:	5f                   	pop    %edi
c01059fc:	5d                   	pop    %ebp
c01059fd:	c3                   	ret    

c01059fe <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
c01059fe:	f3 0f 1e fb          	endbr32 
c0105a02:	55                   	push   %ebp
c0105a03:	89 e5                	mov    %esp,%ebp
c0105a05:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
c0105a08:	8b 45 08             	mov    0x8(%ebp),%eax
c0105a0b:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
c0105a0e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105a11:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
c0105a14:	eb 2e                	jmp    c0105a44 <memcmp+0x46>
        if (*s1 != *s2) {
c0105a16:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0105a19:	0f b6 10             	movzbl (%eax),%edx
c0105a1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0105a1f:	0f b6 00             	movzbl (%eax),%eax
c0105a22:	38 c2                	cmp    %al,%dl
c0105a24:	74 18                	je     c0105a3e <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
c0105a26:	8b 45 fc             	mov    -0x4(%ebp),%eax
c0105a29:	0f b6 00             	movzbl (%eax),%eax
c0105a2c:	0f b6 d0             	movzbl %al,%edx
c0105a2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
c0105a32:	0f b6 00             	movzbl (%eax),%eax
c0105a35:	0f b6 c0             	movzbl %al,%eax
c0105a38:	29 c2                	sub    %eax,%edx
c0105a3a:	89 d0                	mov    %edx,%eax
c0105a3c:	eb 18                	jmp    c0105a56 <memcmp+0x58>
        }
        s1 ++, s2 ++;
c0105a3e:	ff 45 fc             	incl   -0x4(%ebp)
c0105a41:	ff 45 f8             	incl   -0x8(%ebp)
    while (n -- > 0) {
c0105a44:	8b 45 10             	mov    0x10(%ebp),%eax
c0105a47:	8d 50 ff             	lea    -0x1(%eax),%edx
c0105a4a:	89 55 10             	mov    %edx,0x10(%ebp)
c0105a4d:	85 c0                	test   %eax,%eax
c0105a4f:	75 c5                	jne    c0105a16 <memcmp+0x18>
    }
    return 0;
c0105a51:	b8 00 00 00 00       	mov    $0x0,%eax
}
c0105a56:	c9                   	leave  
c0105a57:	c3                   	ret    

c0105a58 <printnum>:
 * @width:      maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:       character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
c0105a58:	f3 0f 1e fb          	endbr32 
c0105a5c:	55                   	push   %ebp
c0105a5d:	89 e5                	mov    %esp,%ebp
c0105a5f:	83 ec 58             	sub    $0x58,%esp
c0105a62:	8b 45 10             	mov    0x10(%ebp),%eax
c0105a65:	89 45 d0             	mov    %eax,-0x30(%ebp)
c0105a68:	8b 45 14             	mov    0x14(%ebp),%eax
c0105a6b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
c0105a6e:	8b 45 d0             	mov    -0x30(%ebp),%eax
c0105a71:	8b 55 d4             	mov    -0x2c(%ebp),%edx
c0105a74:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105a77:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
c0105a7a:	8b 45 18             	mov    0x18(%ebp),%eax
c0105a7d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
c0105a80:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105a83:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0105a86:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0105a89:	89 55 f0             	mov    %edx,-0x10(%ebp)
c0105a8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105a8f:	89 45 f4             	mov    %eax,-0xc(%ebp)
c0105a92:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
c0105a96:	74 1c                	je     c0105ab4 <printnum+0x5c>
c0105a98:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105a9b:	ba 00 00 00 00       	mov    $0x0,%edx
c0105aa0:	f7 75 e4             	divl   -0x1c(%ebp)
c0105aa3:	89 55 f4             	mov    %edx,-0xc(%ebp)
c0105aa6:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105aa9:	ba 00 00 00 00       	mov    $0x0,%edx
c0105aae:	f7 75 e4             	divl   -0x1c(%ebp)
c0105ab1:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105ab4:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105ab7:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105aba:	f7 75 e4             	divl   -0x1c(%ebp)
c0105abd:	89 45 e0             	mov    %eax,-0x20(%ebp)
c0105ac0:	89 55 dc             	mov    %edx,-0x24(%ebp)
c0105ac3:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105ac6:	8b 55 f0             	mov    -0x10(%ebp),%edx
c0105ac9:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105acc:	89 55 ec             	mov    %edx,-0x14(%ebp)
c0105acf:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0105ad2:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
c0105ad5:	8b 45 18             	mov    0x18(%ebp),%eax
c0105ad8:	ba 00 00 00 00       	mov    $0x0,%edx
c0105add:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
c0105ae0:	39 45 d0             	cmp    %eax,-0x30(%ebp)
c0105ae3:	19 d1                	sbb    %edx,%ecx
c0105ae5:	72 4c                	jb     c0105b33 <printnum+0xdb>
        printnum(putch, putdat, result, base, width - 1, padc);
c0105ae7:	8b 45 1c             	mov    0x1c(%ebp),%eax
c0105aea:	8d 50 ff             	lea    -0x1(%eax),%edx
c0105aed:	8b 45 20             	mov    0x20(%ebp),%eax
c0105af0:	89 44 24 18          	mov    %eax,0x18(%esp)
c0105af4:	89 54 24 14          	mov    %edx,0x14(%esp)
c0105af8:	8b 45 18             	mov    0x18(%ebp),%eax
c0105afb:	89 44 24 10          	mov    %eax,0x10(%esp)
c0105aff:	8b 45 e8             	mov    -0x18(%ebp),%eax
c0105b02:	8b 55 ec             	mov    -0x14(%ebp),%edx
c0105b05:	89 44 24 08          	mov    %eax,0x8(%esp)
c0105b09:	89 54 24 0c          	mov    %edx,0xc(%esp)
c0105b0d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105b10:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105b14:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b17:	89 04 24             	mov    %eax,(%esp)
c0105b1a:	e8 39 ff ff ff       	call   c0105a58 <printnum>
c0105b1f:	eb 1b                	jmp    c0105b3c <printnum+0xe4>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
c0105b21:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105b24:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105b28:	8b 45 20             	mov    0x20(%ebp),%eax
c0105b2b:	89 04 24             	mov    %eax,(%esp)
c0105b2e:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b31:	ff d0                	call   *%eax
        while (-- width > 0)
c0105b33:	ff 4d 1c             	decl   0x1c(%ebp)
c0105b36:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
c0105b3a:	7f e5                	jg     c0105b21 <printnum+0xc9>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
c0105b3c:	8b 45 d8             	mov    -0x28(%ebp),%eax
c0105b3f:	05 a4 72 10 c0       	add    $0xc01072a4,%eax
c0105b44:	0f b6 00             	movzbl (%eax),%eax
c0105b47:	0f be c0             	movsbl %al,%eax
c0105b4a:	8b 55 0c             	mov    0xc(%ebp),%edx
c0105b4d:	89 54 24 04          	mov    %edx,0x4(%esp)
c0105b51:	89 04 24             	mov    %eax,(%esp)
c0105b54:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b57:	ff d0                	call   *%eax
}
c0105b59:	90                   	nop
c0105b5a:	c9                   	leave  
c0105b5b:	c3                   	ret    

c0105b5c <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
c0105b5c:	f3 0f 1e fb          	endbr32 
c0105b60:	55                   	push   %ebp
c0105b61:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
c0105b63:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
c0105b67:	7e 14                	jle    c0105b7d <getuint+0x21>
        return va_arg(*ap, unsigned long long);
c0105b69:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b6c:	8b 00                	mov    (%eax),%eax
c0105b6e:	8d 48 08             	lea    0x8(%eax),%ecx
c0105b71:	8b 55 08             	mov    0x8(%ebp),%edx
c0105b74:	89 0a                	mov    %ecx,(%edx)
c0105b76:	8b 50 04             	mov    0x4(%eax),%edx
c0105b79:	8b 00                	mov    (%eax),%eax
c0105b7b:	eb 30                	jmp    c0105bad <getuint+0x51>
    }
    else if (lflag) {
c0105b7d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c0105b81:	74 16                	je     c0105b99 <getuint+0x3d>
        return va_arg(*ap, unsigned long);
c0105b83:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b86:	8b 00                	mov    (%eax),%eax
c0105b88:	8d 48 04             	lea    0x4(%eax),%ecx
c0105b8b:	8b 55 08             	mov    0x8(%ebp),%edx
c0105b8e:	89 0a                	mov    %ecx,(%edx)
c0105b90:	8b 00                	mov    (%eax),%eax
c0105b92:	ba 00 00 00 00       	mov    $0x0,%edx
c0105b97:	eb 14                	jmp    c0105bad <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
c0105b99:	8b 45 08             	mov    0x8(%ebp),%eax
c0105b9c:	8b 00                	mov    (%eax),%eax
c0105b9e:	8d 48 04             	lea    0x4(%eax),%ecx
c0105ba1:	8b 55 08             	mov    0x8(%ebp),%edx
c0105ba4:	89 0a                	mov    %ecx,(%edx)
c0105ba6:	8b 00                	mov    (%eax),%eax
c0105ba8:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
c0105bad:	5d                   	pop    %ebp
c0105bae:	c3                   	ret    

c0105baf <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:         a varargs list pointer
 * @lflag:      determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
c0105baf:	f3 0f 1e fb          	endbr32 
c0105bb3:	55                   	push   %ebp
c0105bb4:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
c0105bb6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
c0105bba:	7e 14                	jle    c0105bd0 <getint+0x21>
        return va_arg(*ap, long long);
c0105bbc:	8b 45 08             	mov    0x8(%ebp),%eax
c0105bbf:	8b 00                	mov    (%eax),%eax
c0105bc1:	8d 48 08             	lea    0x8(%eax),%ecx
c0105bc4:	8b 55 08             	mov    0x8(%ebp),%edx
c0105bc7:	89 0a                	mov    %ecx,(%edx)
c0105bc9:	8b 50 04             	mov    0x4(%eax),%edx
c0105bcc:	8b 00                	mov    (%eax),%eax
c0105bce:	eb 28                	jmp    c0105bf8 <getint+0x49>
    }
    else if (lflag) {
c0105bd0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
c0105bd4:	74 12                	je     c0105be8 <getint+0x39>
        return va_arg(*ap, long);
c0105bd6:	8b 45 08             	mov    0x8(%ebp),%eax
c0105bd9:	8b 00                	mov    (%eax),%eax
c0105bdb:	8d 48 04             	lea    0x4(%eax),%ecx
c0105bde:	8b 55 08             	mov    0x8(%ebp),%edx
c0105be1:	89 0a                	mov    %ecx,(%edx)
c0105be3:	8b 00                	mov    (%eax),%eax
c0105be5:	99                   	cltd   
c0105be6:	eb 10                	jmp    c0105bf8 <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
c0105be8:	8b 45 08             	mov    0x8(%ebp),%eax
c0105beb:	8b 00                	mov    (%eax),%eax
c0105bed:	8d 48 04             	lea    0x4(%eax),%ecx
c0105bf0:	8b 55 08             	mov    0x8(%ebp),%edx
c0105bf3:	89 0a                	mov    %ecx,(%edx)
c0105bf5:	8b 00                	mov    (%eax),%eax
c0105bf7:	99                   	cltd   
    }
}
c0105bf8:	5d                   	pop    %ebp
c0105bf9:	c3                   	ret    

c0105bfa <printfmt>:
 * @putch:      specified putch function, print a single character
 * @putdat:     used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
c0105bfa:	f3 0f 1e fb          	endbr32 
c0105bfe:	55                   	push   %ebp
c0105bff:	89 e5                	mov    %esp,%ebp
c0105c01:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
c0105c04:	8d 45 14             	lea    0x14(%ebp),%eax
c0105c07:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
c0105c0a:	8b 45 f4             	mov    -0xc(%ebp),%eax
c0105c0d:	89 44 24 0c          	mov    %eax,0xc(%esp)
c0105c11:	8b 45 10             	mov    0x10(%ebp),%eax
c0105c14:	89 44 24 08          	mov    %eax,0x8(%esp)
c0105c18:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105c1b:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105c1f:	8b 45 08             	mov    0x8(%ebp),%eax
c0105c22:	89 04 24             	mov    %eax,(%esp)
c0105c25:	e8 03 00 00 00       	call   c0105c2d <vprintfmt>
    va_end(ap);
}
c0105c2a:	90                   	nop
c0105c2b:	c9                   	leave  
c0105c2c:	c3                   	ret    

c0105c2d <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
c0105c2d:	f3 0f 1e fb          	endbr32 
c0105c31:	55                   	push   %ebp
c0105c32:	89 e5                	mov    %esp,%ebp
c0105c34:	56                   	push   %esi
c0105c35:	53                   	push   %ebx
c0105c36:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
c0105c39:	eb 17                	jmp    c0105c52 <vprintfmt+0x25>
            if (ch == '\0') {
c0105c3b:	85 db                	test   %ebx,%ebx
c0105c3d:	0f 84 c0 03 00 00    	je     c0106003 <vprintfmt+0x3d6>
                return;
            }
            putch(ch, putdat);
c0105c43:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105c46:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105c4a:	89 1c 24             	mov    %ebx,(%esp)
c0105c4d:	8b 45 08             	mov    0x8(%ebp),%eax
c0105c50:	ff d0                	call   *%eax
        while ((ch = *(unsigned char *)fmt ++) != '%') {
c0105c52:	8b 45 10             	mov    0x10(%ebp),%eax
c0105c55:	8d 50 01             	lea    0x1(%eax),%edx
c0105c58:	89 55 10             	mov    %edx,0x10(%ebp)
c0105c5b:	0f b6 00             	movzbl (%eax),%eax
c0105c5e:	0f b6 d8             	movzbl %al,%ebx
c0105c61:	83 fb 25             	cmp    $0x25,%ebx
c0105c64:	75 d5                	jne    c0105c3b <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
c0105c66:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
c0105c6a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
c0105c71:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105c74:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
c0105c77:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
c0105c7e:	8b 45 dc             	mov    -0x24(%ebp),%eax
c0105c81:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
c0105c84:	8b 45 10             	mov    0x10(%ebp),%eax
c0105c87:	8d 50 01             	lea    0x1(%eax),%edx
c0105c8a:	89 55 10             	mov    %edx,0x10(%ebp)
c0105c8d:	0f b6 00             	movzbl (%eax),%eax
c0105c90:	0f b6 d8             	movzbl %al,%ebx
c0105c93:	8d 43 dd             	lea    -0x23(%ebx),%eax
c0105c96:	83 f8 55             	cmp    $0x55,%eax
c0105c99:	0f 87 38 03 00 00    	ja     c0105fd7 <vprintfmt+0x3aa>
c0105c9f:	8b 04 85 c8 72 10 c0 	mov    -0x3fef8d38(,%eax,4),%eax
c0105ca6:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
c0105ca9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
c0105cad:	eb d5                	jmp    c0105c84 <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
c0105caf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
c0105cb3:	eb cf                	jmp    c0105c84 <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
c0105cb5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
c0105cbc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
c0105cbf:	89 d0                	mov    %edx,%eax
c0105cc1:	c1 e0 02             	shl    $0x2,%eax
c0105cc4:	01 d0                	add    %edx,%eax
c0105cc6:	01 c0                	add    %eax,%eax
c0105cc8:	01 d8                	add    %ebx,%eax
c0105cca:	83 e8 30             	sub    $0x30,%eax
c0105ccd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
c0105cd0:	8b 45 10             	mov    0x10(%ebp),%eax
c0105cd3:	0f b6 00             	movzbl (%eax),%eax
c0105cd6:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
c0105cd9:	83 fb 2f             	cmp    $0x2f,%ebx
c0105cdc:	7e 38                	jle    c0105d16 <vprintfmt+0xe9>
c0105cde:	83 fb 39             	cmp    $0x39,%ebx
c0105ce1:	7f 33                	jg     c0105d16 <vprintfmt+0xe9>
            for (precision = 0; ; ++ fmt) {
c0105ce3:	ff 45 10             	incl   0x10(%ebp)
                precision = precision * 10 + ch - '0';
c0105ce6:	eb d4                	jmp    c0105cbc <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
c0105ce8:	8b 45 14             	mov    0x14(%ebp),%eax
c0105ceb:	8d 50 04             	lea    0x4(%eax),%edx
c0105cee:	89 55 14             	mov    %edx,0x14(%ebp)
c0105cf1:	8b 00                	mov    (%eax),%eax
c0105cf3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
c0105cf6:	eb 1f                	jmp    c0105d17 <vprintfmt+0xea>

        case '.':
            if (width < 0)
c0105cf8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105cfc:	79 86                	jns    c0105c84 <vprintfmt+0x57>
                width = 0;
c0105cfe:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
c0105d05:	e9 7a ff ff ff       	jmp    c0105c84 <vprintfmt+0x57>

        case '#':
            altflag = 1;
c0105d0a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
c0105d11:	e9 6e ff ff ff       	jmp    c0105c84 <vprintfmt+0x57>
            goto process_precision;
c0105d16:	90                   	nop

        process_precision:
            if (width < 0)
c0105d17:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105d1b:	0f 89 63 ff ff ff    	jns    c0105c84 <vprintfmt+0x57>
                width = precision, precision = -1;
c0105d21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105d24:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105d27:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
c0105d2e:	e9 51 ff ff ff       	jmp    c0105c84 <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
c0105d33:	ff 45 e0             	incl   -0x20(%ebp)
            goto reswitch;
c0105d36:	e9 49 ff ff ff       	jmp    c0105c84 <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
c0105d3b:	8b 45 14             	mov    0x14(%ebp),%eax
c0105d3e:	8d 50 04             	lea    0x4(%eax),%edx
c0105d41:	89 55 14             	mov    %edx,0x14(%ebp)
c0105d44:	8b 00                	mov    (%eax),%eax
c0105d46:	8b 55 0c             	mov    0xc(%ebp),%edx
c0105d49:	89 54 24 04          	mov    %edx,0x4(%esp)
c0105d4d:	89 04 24             	mov    %eax,(%esp)
c0105d50:	8b 45 08             	mov    0x8(%ebp),%eax
c0105d53:	ff d0                	call   *%eax
            break;
c0105d55:	e9 a4 02 00 00       	jmp    c0105ffe <vprintfmt+0x3d1>

        // error message
        case 'e':
            err = va_arg(ap, int);
c0105d5a:	8b 45 14             	mov    0x14(%ebp),%eax
c0105d5d:	8d 50 04             	lea    0x4(%eax),%edx
c0105d60:	89 55 14             	mov    %edx,0x14(%ebp)
c0105d63:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
c0105d65:	85 db                	test   %ebx,%ebx
c0105d67:	79 02                	jns    c0105d6b <vprintfmt+0x13e>
                err = -err;
c0105d69:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
c0105d6b:	83 fb 06             	cmp    $0x6,%ebx
c0105d6e:	7f 0b                	jg     c0105d7b <vprintfmt+0x14e>
c0105d70:	8b 34 9d 88 72 10 c0 	mov    -0x3fef8d78(,%ebx,4),%esi
c0105d77:	85 f6                	test   %esi,%esi
c0105d79:	75 23                	jne    c0105d9e <vprintfmt+0x171>
                printfmt(putch, putdat, "error %d", err);
c0105d7b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
c0105d7f:	c7 44 24 08 b5 72 10 	movl   $0xc01072b5,0x8(%esp)
c0105d86:	c0 
c0105d87:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105d8a:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105d8e:	8b 45 08             	mov    0x8(%ebp),%eax
c0105d91:	89 04 24             	mov    %eax,(%esp)
c0105d94:	e8 61 fe ff ff       	call   c0105bfa <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
c0105d99:	e9 60 02 00 00       	jmp    c0105ffe <vprintfmt+0x3d1>
                printfmt(putch, putdat, "%s", p);
c0105d9e:	89 74 24 0c          	mov    %esi,0xc(%esp)
c0105da2:	c7 44 24 08 be 72 10 	movl   $0xc01072be,0x8(%esp)
c0105da9:	c0 
c0105daa:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105dad:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105db1:	8b 45 08             	mov    0x8(%ebp),%eax
c0105db4:	89 04 24             	mov    %eax,(%esp)
c0105db7:	e8 3e fe ff ff       	call   c0105bfa <printfmt>
            break;
c0105dbc:	e9 3d 02 00 00       	jmp    c0105ffe <vprintfmt+0x3d1>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
c0105dc1:	8b 45 14             	mov    0x14(%ebp),%eax
c0105dc4:	8d 50 04             	lea    0x4(%eax),%edx
c0105dc7:	89 55 14             	mov    %edx,0x14(%ebp)
c0105dca:	8b 30                	mov    (%eax),%esi
c0105dcc:	85 f6                	test   %esi,%esi
c0105dce:	75 05                	jne    c0105dd5 <vprintfmt+0x1a8>
                p = "(null)";
c0105dd0:	be c1 72 10 c0       	mov    $0xc01072c1,%esi
            }
            if (width > 0 && padc != '-') {
c0105dd5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105dd9:	7e 76                	jle    c0105e51 <vprintfmt+0x224>
c0105ddb:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
c0105ddf:	74 70                	je     c0105e51 <vprintfmt+0x224>
                for (width -= strnlen(p, precision); width > 0; width --) {
c0105de1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
c0105de4:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105de8:	89 34 24             	mov    %esi,(%esp)
c0105deb:	e8 ba f7 ff ff       	call   c01055aa <strnlen>
c0105df0:	8b 55 e8             	mov    -0x18(%ebp),%edx
c0105df3:	29 c2                	sub    %eax,%edx
c0105df5:	89 d0                	mov    %edx,%eax
c0105df7:	89 45 e8             	mov    %eax,-0x18(%ebp)
c0105dfa:	eb 16                	jmp    c0105e12 <vprintfmt+0x1e5>
                    putch(padc, putdat);
c0105dfc:	0f be 45 db          	movsbl -0x25(%ebp),%eax
c0105e00:	8b 55 0c             	mov    0xc(%ebp),%edx
c0105e03:	89 54 24 04          	mov    %edx,0x4(%esp)
c0105e07:	89 04 24             	mov    %eax,(%esp)
c0105e0a:	8b 45 08             	mov    0x8(%ebp),%eax
c0105e0d:	ff d0                	call   *%eax
                for (width -= strnlen(p, precision); width > 0; width --) {
c0105e0f:	ff 4d e8             	decl   -0x18(%ebp)
c0105e12:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105e16:	7f e4                	jg     c0105dfc <vprintfmt+0x1cf>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
c0105e18:	eb 37                	jmp    c0105e51 <vprintfmt+0x224>
                if (altflag && (ch < ' ' || ch > '~')) {
c0105e1a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
c0105e1e:	74 1f                	je     c0105e3f <vprintfmt+0x212>
c0105e20:	83 fb 1f             	cmp    $0x1f,%ebx
c0105e23:	7e 05                	jle    c0105e2a <vprintfmt+0x1fd>
c0105e25:	83 fb 7e             	cmp    $0x7e,%ebx
c0105e28:	7e 15                	jle    c0105e3f <vprintfmt+0x212>
                    putch('?', putdat);
c0105e2a:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105e2d:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105e31:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
c0105e38:	8b 45 08             	mov    0x8(%ebp),%eax
c0105e3b:	ff d0                	call   *%eax
c0105e3d:	eb 0f                	jmp    c0105e4e <vprintfmt+0x221>
                }
                else {
                    putch(ch, putdat);
c0105e3f:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105e42:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105e46:	89 1c 24             	mov    %ebx,(%esp)
c0105e49:	8b 45 08             	mov    0x8(%ebp),%eax
c0105e4c:	ff d0                	call   *%eax
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
c0105e4e:	ff 4d e8             	decl   -0x18(%ebp)
c0105e51:	89 f0                	mov    %esi,%eax
c0105e53:	8d 70 01             	lea    0x1(%eax),%esi
c0105e56:	0f b6 00             	movzbl (%eax),%eax
c0105e59:	0f be d8             	movsbl %al,%ebx
c0105e5c:	85 db                	test   %ebx,%ebx
c0105e5e:	74 27                	je     c0105e87 <vprintfmt+0x25a>
c0105e60:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0105e64:	78 b4                	js     c0105e1a <vprintfmt+0x1ed>
c0105e66:	ff 4d e4             	decl   -0x1c(%ebp)
c0105e69:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
c0105e6d:	79 ab                	jns    c0105e1a <vprintfmt+0x1ed>
                }
            }
            for (; width > 0; width --) {
c0105e6f:	eb 16                	jmp    c0105e87 <vprintfmt+0x25a>
                putch(' ', putdat);
c0105e71:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105e74:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105e78:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
c0105e7f:	8b 45 08             	mov    0x8(%ebp),%eax
c0105e82:	ff d0                	call   *%eax
            for (; width > 0; width --) {
c0105e84:	ff 4d e8             	decl   -0x18(%ebp)
c0105e87:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
c0105e8b:	7f e4                	jg     c0105e71 <vprintfmt+0x244>
            }
            break;
c0105e8d:	e9 6c 01 00 00       	jmp    c0105ffe <vprintfmt+0x3d1>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
c0105e92:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105e95:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105e99:	8d 45 14             	lea    0x14(%ebp),%eax
c0105e9c:	89 04 24             	mov    %eax,(%esp)
c0105e9f:	e8 0b fd ff ff       	call   c0105baf <getint>
c0105ea4:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105ea7:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
c0105eaa:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105ead:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105eb0:	85 d2                	test   %edx,%edx
c0105eb2:	79 26                	jns    c0105eda <vprintfmt+0x2ad>
                putch('-', putdat);
c0105eb4:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105eb7:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105ebb:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
c0105ec2:	8b 45 08             	mov    0x8(%ebp),%eax
c0105ec5:	ff d0                	call   *%eax
                num = -(long long)num;
c0105ec7:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105eca:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105ecd:	f7 d8                	neg    %eax
c0105ecf:	83 d2 00             	adc    $0x0,%edx
c0105ed2:	f7 da                	neg    %edx
c0105ed4:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105ed7:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
c0105eda:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
c0105ee1:	e9 a8 00 00 00       	jmp    c0105f8e <vprintfmt+0x361>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
c0105ee6:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105ee9:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105eed:	8d 45 14             	lea    0x14(%ebp),%eax
c0105ef0:	89 04 24             	mov    %eax,(%esp)
c0105ef3:	e8 64 fc ff ff       	call   c0105b5c <getuint>
c0105ef8:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105efb:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
c0105efe:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
c0105f05:	e9 84 00 00 00       	jmp    c0105f8e <vprintfmt+0x361>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
c0105f0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105f0d:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105f11:	8d 45 14             	lea    0x14(%ebp),%eax
c0105f14:	89 04 24             	mov    %eax,(%esp)
c0105f17:	e8 40 fc ff ff       	call   c0105b5c <getuint>
c0105f1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105f1f:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
c0105f22:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
c0105f29:	eb 63                	jmp    c0105f8e <vprintfmt+0x361>

        // pointer
        case 'p':
            putch('0', putdat);
c0105f2b:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105f2e:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105f32:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
c0105f39:	8b 45 08             	mov    0x8(%ebp),%eax
c0105f3c:	ff d0                	call   *%eax
            putch('x', putdat);
c0105f3e:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105f41:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105f45:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
c0105f4c:	8b 45 08             	mov    0x8(%ebp),%eax
c0105f4f:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
c0105f51:	8b 45 14             	mov    0x14(%ebp),%eax
c0105f54:	8d 50 04             	lea    0x4(%eax),%edx
c0105f57:	89 55 14             	mov    %edx,0x14(%ebp)
c0105f5a:	8b 00                	mov    (%eax),%eax
c0105f5c:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105f5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
c0105f66:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
c0105f6d:	eb 1f                	jmp    c0105f8e <vprintfmt+0x361>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
c0105f6f:	8b 45 e0             	mov    -0x20(%ebp),%eax
c0105f72:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105f76:	8d 45 14             	lea    0x14(%ebp),%eax
c0105f79:	89 04 24             	mov    %eax,(%esp)
c0105f7c:	e8 db fb ff ff       	call   c0105b5c <getuint>
c0105f81:	89 45 f0             	mov    %eax,-0x10(%ebp)
c0105f84:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
c0105f87:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
c0105f8e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
c0105f92:	8b 45 ec             	mov    -0x14(%ebp),%eax
c0105f95:	89 54 24 18          	mov    %edx,0x18(%esp)
c0105f99:	8b 55 e8             	mov    -0x18(%ebp),%edx
c0105f9c:	89 54 24 14          	mov    %edx,0x14(%esp)
c0105fa0:	89 44 24 10          	mov    %eax,0x10(%esp)
c0105fa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0105fa7:	8b 55 f4             	mov    -0xc(%ebp),%edx
c0105faa:	89 44 24 08          	mov    %eax,0x8(%esp)
c0105fae:	89 54 24 0c          	mov    %edx,0xc(%esp)
c0105fb2:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105fb5:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105fb9:	8b 45 08             	mov    0x8(%ebp),%eax
c0105fbc:	89 04 24             	mov    %eax,(%esp)
c0105fbf:	e8 94 fa ff ff       	call   c0105a58 <printnum>
            break;
c0105fc4:	eb 38                	jmp    c0105ffe <vprintfmt+0x3d1>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
c0105fc6:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105fc9:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105fcd:	89 1c 24             	mov    %ebx,(%esp)
c0105fd0:	8b 45 08             	mov    0x8(%ebp),%eax
c0105fd3:	ff d0                	call   *%eax
            break;
c0105fd5:	eb 27                	jmp    c0105ffe <vprintfmt+0x3d1>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
c0105fd7:	8b 45 0c             	mov    0xc(%ebp),%eax
c0105fda:	89 44 24 04          	mov    %eax,0x4(%esp)
c0105fde:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
c0105fe5:	8b 45 08             	mov    0x8(%ebp),%eax
c0105fe8:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
c0105fea:	ff 4d 10             	decl   0x10(%ebp)
c0105fed:	eb 03                	jmp    c0105ff2 <vprintfmt+0x3c5>
c0105fef:	ff 4d 10             	decl   0x10(%ebp)
c0105ff2:	8b 45 10             	mov    0x10(%ebp),%eax
c0105ff5:	48                   	dec    %eax
c0105ff6:	0f b6 00             	movzbl (%eax),%eax
c0105ff9:	3c 25                	cmp    $0x25,%al
c0105ffb:	75 f2                	jne    c0105fef <vprintfmt+0x3c2>
                /* do nothing */;
            break;
c0105ffd:	90                   	nop
    while (1) {
c0105ffe:	e9 36 fc ff ff       	jmp    c0105c39 <vprintfmt+0xc>
                return;
c0106003:	90                   	nop
        }
    }
}
c0106004:	83 c4 40             	add    $0x40,%esp
c0106007:	5b                   	pop    %ebx
c0106008:	5e                   	pop    %esi
c0106009:	5d                   	pop    %ebp
c010600a:	c3                   	ret    

c010600b <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:         the character will be printed
 * @b:          the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
c010600b:	f3 0f 1e fb          	endbr32 
c010600f:	55                   	push   %ebp
c0106010:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
c0106012:	8b 45 0c             	mov    0xc(%ebp),%eax
c0106015:	8b 40 08             	mov    0x8(%eax),%eax
c0106018:	8d 50 01             	lea    0x1(%eax),%edx
c010601b:	8b 45 0c             	mov    0xc(%ebp),%eax
c010601e:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
c0106021:	8b 45 0c             	mov    0xc(%ebp),%eax
c0106024:	8b 10                	mov    (%eax),%edx
c0106026:	8b 45 0c             	mov    0xc(%ebp),%eax
c0106029:	8b 40 04             	mov    0x4(%eax),%eax
c010602c:	39 c2                	cmp    %eax,%edx
c010602e:	73 12                	jae    c0106042 <sprintputch+0x37>
        *b->buf ++ = ch;
c0106030:	8b 45 0c             	mov    0xc(%ebp),%eax
c0106033:	8b 00                	mov    (%eax),%eax
c0106035:	8d 48 01             	lea    0x1(%eax),%ecx
c0106038:	8b 55 0c             	mov    0xc(%ebp),%edx
c010603b:	89 0a                	mov    %ecx,(%edx)
c010603d:	8b 55 08             	mov    0x8(%ebp),%edx
c0106040:	88 10                	mov    %dl,(%eax)
    }
}
c0106042:	90                   	nop
c0106043:	5d                   	pop    %ebp
c0106044:	c3                   	ret    

c0106045 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:       the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
c0106045:	f3 0f 1e fb          	endbr32 
c0106049:	55                   	push   %ebp
c010604a:	89 e5                	mov    %esp,%ebp
c010604c:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
c010604f:	8d 45 14             	lea    0x14(%ebp),%eax
c0106052:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
c0106055:	8b 45 f0             	mov    -0x10(%ebp),%eax
c0106058:	89 44 24 0c          	mov    %eax,0xc(%esp)
c010605c:	8b 45 10             	mov    0x10(%ebp),%eax
c010605f:	89 44 24 08          	mov    %eax,0x8(%esp)
c0106063:	8b 45 0c             	mov    0xc(%ebp),%eax
c0106066:	89 44 24 04          	mov    %eax,0x4(%esp)
c010606a:	8b 45 08             	mov    0x8(%ebp),%eax
c010606d:	89 04 24             	mov    %eax,(%esp)
c0106070:	e8 08 00 00 00       	call   c010607d <vsnprintf>
c0106075:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
c0106078:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c010607b:	c9                   	leave  
c010607c:	c3                   	ret    

c010607d <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
c010607d:	f3 0f 1e fb          	endbr32 
c0106081:	55                   	push   %ebp
c0106082:	89 e5                	mov    %esp,%ebp
c0106084:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
c0106087:	8b 45 08             	mov    0x8(%ebp),%eax
c010608a:	89 45 ec             	mov    %eax,-0x14(%ebp)
c010608d:	8b 45 0c             	mov    0xc(%ebp),%eax
c0106090:	8d 50 ff             	lea    -0x1(%eax),%edx
c0106093:	8b 45 08             	mov    0x8(%ebp),%eax
c0106096:	01 d0                	add    %edx,%eax
c0106098:	89 45 f0             	mov    %eax,-0x10(%ebp)
c010609b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
c01060a2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
c01060a6:	74 0a                	je     c01060b2 <vsnprintf+0x35>
c01060a8:	8b 55 ec             	mov    -0x14(%ebp),%edx
c01060ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
c01060ae:	39 c2                	cmp    %eax,%edx
c01060b0:	76 07                	jbe    c01060b9 <vsnprintf+0x3c>
        return -E_INVAL;
c01060b2:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
c01060b7:	eb 2a                	jmp    c01060e3 <vsnprintf+0x66>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
c01060b9:	8b 45 14             	mov    0x14(%ebp),%eax
c01060bc:	89 44 24 0c          	mov    %eax,0xc(%esp)
c01060c0:	8b 45 10             	mov    0x10(%ebp),%eax
c01060c3:	89 44 24 08          	mov    %eax,0x8(%esp)
c01060c7:	8d 45 ec             	lea    -0x14(%ebp),%eax
c01060ca:	89 44 24 04          	mov    %eax,0x4(%esp)
c01060ce:	c7 04 24 0b 60 10 c0 	movl   $0xc010600b,(%esp)
c01060d5:	e8 53 fb ff ff       	call   c0105c2d <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
c01060da:	8b 45 ec             	mov    -0x14(%ebp),%eax
c01060dd:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
c01060e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
c01060e3:	c9                   	leave  
c01060e4:	c3                   	ret    
