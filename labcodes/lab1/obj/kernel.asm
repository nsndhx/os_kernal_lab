
bin/kernel：     文件格式 elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	f3 0f 1e fb          	endbr32 
  100004:	55                   	push   %ebp
  100005:	89 e5                	mov    %esp,%ebp
  100007:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  10000a:	b8 20 0d 11 00       	mov    $0x110d20,%eax
  10000f:	2d 16 fa 10 00       	sub    $0x10fa16,%eax
  100014:	89 44 24 08          	mov    %eax,0x8(%esp)
  100018:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10001f:	00 
  100020:	c7 04 24 16 fa 10 00 	movl   $0x10fa16,(%esp)
  100027:	e8 55 2e 00 00       	call   102e81 <memset>

    cons_init();                // init the console
  10002c:	e8 0a 16 00 00       	call   10163b <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 c0 36 10 00 	movl   $0x1036c0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 dc 36 10 00 	movl   $0x1036dc,(%esp)
  100046:	e8 48 02 00 00       	call   100293 <cprintf>

    print_kerninfo();
  10004b:	e8 06 09 00 00       	call   100956 <print_kerninfo>

    grade_backtrace();
  100050:	e8 9a 00 00 00       	call   1000ef <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 d6 2a 00 00       	call   102b30 <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 31 17 00 00       	call   101790 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 d6 18 00 00       	call   10193a <idt_init>

    clock_init();               // init clock interrupt
  100064:	e8 57 0d 00 00       	call   100dc0 <clock_init>
    intr_enable();              // enable irq interrupt
  100069:	e8 6e 18 00 00       	call   1018dc <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  10006e:	e8 86 01 00 00       	call   1001f9 <lab1_switch_test>

    /* do nothing */
    while (1);
  100073:	eb fe                	jmp    100073 <kern_init+0x73>

00100075 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100075:	f3 0f 1e fb          	endbr32 
  100079:	55                   	push   %ebp
  10007a:	89 e5                	mov    %esp,%ebp
  10007c:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  10007f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100086:	00 
  100087:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10008e:	00 
  10008f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100096:	e8 0f 0d 00 00       	call   100daa <mon_backtrace>
}
  10009b:	90                   	nop
  10009c:	c9                   	leave  
  10009d:	c3                   	ret    

0010009e <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  10009e:	f3 0f 1e fb          	endbr32 
  1000a2:	55                   	push   %ebp
  1000a3:	89 e5                	mov    %esp,%ebp
  1000a5:	53                   	push   %ebx
  1000a6:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000a9:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  1000ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  1000af:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000b2:	8b 45 08             	mov    0x8(%ebp),%eax
  1000b5:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1000b9:	89 54 24 08          	mov    %edx,0x8(%esp)
  1000bd:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1000c1:	89 04 24             	mov    %eax,(%esp)
  1000c4:	e8 ac ff ff ff       	call   100075 <grade_backtrace2>
}
  1000c9:	90                   	nop
  1000ca:	83 c4 14             	add    $0x14,%esp
  1000cd:	5b                   	pop    %ebx
  1000ce:	5d                   	pop    %ebp
  1000cf:	c3                   	ret    

001000d0 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000d0:	f3 0f 1e fb          	endbr32 
  1000d4:	55                   	push   %ebp
  1000d5:	89 e5                	mov    %esp,%ebp
  1000d7:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000da:	8b 45 10             	mov    0x10(%ebp),%eax
  1000dd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000e1:	8b 45 08             	mov    0x8(%ebp),%eax
  1000e4:	89 04 24             	mov    %eax,(%esp)
  1000e7:	e8 b2 ff ff ff       	call   10009e <grade_backtrace1>
}
  1000ec:	90                   	nop
  1000ed:	c9                   	leave  
  1000ee:	c3                   	ret    

001000ef <grade_backtrace>:

void
grade_backtrace(void) {
  1000ef:	f3 0f 1e fb          	endbr32 
  1000f3:	55                   	push   %ebp
  1000f4:	89 e5                	mov    %esp,%ebp
  1000f6:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000f9:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000fe:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  100105:	ff 
  100106:	89 44 24 04          	mov    %eax,0x4(%esp)
  10010a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100111:	e8 ba ff ff ff       	call   1000d0 <grade_backtrace0>
}
  100116:	90                   	nop
  100117:	c9                   	leave  
  100118:	c3                   	ret    

00100119 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100119:	f3 0f 1e fb          	endbr32 
  10011d:	55                   	push   %ebp
  10011e:	89 e5                	mov    %esp,%ebp
  100120:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100123:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  100126:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  100129:	8c 45 f2             	mov    %es,-0xe(%ebp)
  10012c:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  10012f:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100133:	83 e0 03             	and    $0x3,%eax
  100136:	89 c2                	mov    %eax,%edx
  100138:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10013d:	89 54 24 08          	mov    %edx,0x8(%esp)
  100141:	89 44 24 04          	mov    %eax,0x4(%esp)
  100145:	c7 04 24 e1 36 10 00 	movl   $0x1036e1,(%esp)
  10014c:	e8 42 01 00 00       	call   100293 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100151:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100155:	89 c2                	mov    %eax,%edx
  100157:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10015c:	89 54 24 08          	mov    %edx,0x8(%esp)
  100160:	89 44 24 04          	mov    %eax,0x4(%esp)
  100164:	c7 04 24 ef 36 10 00 	movl   $0x1036ef,(%esp)
  10016b:	e8 23 01 00 00       	call   100293 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  100170:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100174:	89 c2                	mov    %eax,%edx
  100176:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10017b:	89 54 24 08          	mov    %edx,0x8(%esp)
  10017f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100183:	c7 04 24 fd 36 10 00 	movl   $0x1036fd,(%esp)
  10018a:	e8 04 01 00 00       	call   100293 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  10018f:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100193:	89 c2                	mov    %eax,%edx
  100195:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10019a:	89 54 24 08          	mov    %edx,0x8(%esp)
  10019e:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001a2:	c7 04 24 0b 37 10 00 	movl   $0x10370b,(%esp)
  1001a9:	e8 e5 00 00 00       	call   100293 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  1001ae:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001b2:	89 c2                	mov    %eax,%edx
  1001b4:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  1001b9:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001c1:	c7 04 24 19 37 10 00 	movl   $0x103719,(%esp)
  1001c8:	e8 c6 00 00 00       	call   100293 <cprintf>
    round ++;
  1001cd:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  1001d2:	40                   	inc    %eax
  1001d3:	a3 20 fa 10 00       	mov    %eax,0x10fa20
}
  1001d8:	90                   	nop
  1001d9:	c9                   	leave  
  1001da:	c3                   	ret    

001001db <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001db:	f3 0f 1e fb          	endbr32 
  1001df:	55                   	push   %ebp
  1001e0:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
    //中断处理例程处于ring 0,所以内核态发生的中断不发生堆栈切换，因此SS、ESP不会自动压栈;但是是否弹出SS、ESP确实由堆栈上的CS中的特权位决定的。当我们将堆栈中的CS的特权位设置为ring 3时，IRET会误认为中断是从ring 3发生的，执行时会按照发生特权级切换的情况弹出SS、ESP。
    //利用这个特性，只需要手动地将内核堆栈布局设置为发生了特权级转换时的布局，将所有的特权位修改为DPL_USER,保持EIP、ESP不变，IRET执行后就可以切换为应用态。
    //因为从内核态发生中断不压入SS、ESP，所以在中断前手动压入SS、ESP。中断处理过程中会修改tf->tf_esp的值，中断发生前压入的SS实际不会被使用，所以代码中仅仅是压入了%ss占位。
    //为了在切换为应用态后，保存原有堆栈结构不变，确保程序正确运行，栈顶的位置应该被恢复到中断发生前的位置。SS、ESP是通过push指令压栈的，压入SS后，ESP的值已经上移了4个字节，所以在trap_dispatch将ESP下移4字节。
    asm volatile (
  1001e2:	16                   	push   %ss
  1001e3:	54                   	push   %esp
  1001e4:	cd 78                	int    $0x78
  1001e6:	89 ec                	mov    %ebp,%esp
        "int %0 \n"
        "movl %%ebp, %%esp"
        : 
        : "i"(T_SWITCH_TOU)
    );
}
  1001e8:	90                   	nop
  1001e9:	5d                   	pop    %ebp
  1001ea:	c3                   	ret    

001001eb <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001eb:	f3 0f 1e fb          	endbr32 
  1001ef:	55                   	push   %ebp
  1001f0:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
    //在用户态发生中断时堆栈会从用户栈切换到内核栈，并压入SS、ESP等寄存器。在篡改内核堆栈后IRET返回时会误认为没有特权级转换发生，不会把SS、ESP弹出，因此从用户态切换到内核态时需要手动弹出SS、ESP。
    //tf->tf_esp指向发生中断前用户栈栈顶，IRET执行后程序仍处于内核态
    asm volatile (
  1001f2:	cd 79                	int    $0x79
  1001f4:	89 ec                	mov    %ebp,%esp
        "int %0 \n"
        "movl %%ebp, %%esp \n"
        : 
        : "i"(T_SWITCH_TOK)
    );
}
  1001f6:	90                   	nop
  1001f7:	5d                   	pop    %ebp
  1001f8:	c3                   	ret    

001001f9 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001f9:	f3 0f 1e fb          	endbr32 
  1001fd:	55                   	push   %ebp
  1001fe:	89 e5                	mov    %esp,%ebp
  100200:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();//print 当前 cs/ss/ds 等寄存器状态
  100203:	e8 11 ff ff ff       	call   100119 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  100208:	c7 04 24 28 37 10 00 	movl   $0x103728,(%esp)
  10020f:	e8 7f 00 00 00       	call   100293 <cprintf>
    lab1_switch_to_user();
  100214:	e8 c2 ff ff ff       	call   1001db <lab1_switch_to_user>
    lab1_print_cur_status();
  100219:	e8 fb fe ff ff       	call   100119 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  10021e:	c7 04 24 48 37 10 00 	movl   $0x103748,(%esp)
  100225:	e8 69 00 00 00       	call   100293 <cprintf>
    lab1_switch_to_kernel();
  10022a:	e8 bc ff ff ff       	call   1001eb <lab1_switch_to_kernel>
    lab1_print_cur_status();
  10022f:	e8 e5 fe ff ff       	call   100119 <lab1_print_cur_status>
}
  100234:	90                   	nop
  100235:	c9                   	leave  
  100236:	c3                   	ret    

00100237 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  100237:	f3 0f 1e fb          	endbr32 
  10023b:	55                   	push   %ebp
  10023c:	89 e5                	mov    %esp,%ebp
  10023e:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  100241:	8b 45 08             	mov    0x8(%ebp),%eax
  100244:	89 04 24             	mov    %eax,(%esp)
  100247:	e8 20 14 00 00       	call   10166c <cons_putc>
    (*cnt) ++;
  10024c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10024f:	8b 00                	mov    (%eax),%eax
  100251:	8d 50 01             	lea    0x1(%eax),%edx
  100254:	8b 45 0c             	mov    0xc(%ebp),%eax
  100257:	89 10                	mov    %edx,(%eax)
}
  100259:	90                   	nop
  10025a:	c9                   	leave  
  10025b:	c3                   	ret    

0010025c <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  10025c:	f3 0f 1e fb          	endbr32 
  100260:	55                   	push   %ebp
  100261:	89 e5                	mov    %esp,%ebp
  100263:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100266:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  10026d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100270:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100274:	8b 45 08             	mov    0x8(%ebp),%eax
  100277:	89 44 24 08          	mov    %eax,0x8(%esp)
  10027b:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10027e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100282:	c7 04 24 37 02 10 00 	movl   $0x100237,(%esp)
  100289:	e8 5f 2f 00 00       	call   1031ed <vprintfmt>
    return cnt;
  10028e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100291:	c9                   	leave  
  100292:	c3                   	ret    

00100293 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100293:	f3 0f 1e fb          	endbr32 
  100297:	55                   	push   %ebp
  100298:	89 e5                	mov    %esp,%ebp
  10029a:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  10029d:	8d 45 0c             	lea    0xc(%ebp),%eax
  1002a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  1002a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002a6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1002aa:	8b 45 08             	mov    0x8(%ebp),%eax
  1002ad:	89 04 24             	mov    %eax,(%esp)
  1002b0:	e8 a7 ff ff ff       	call   10025c <vcprintf>
  1002b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  1002b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002bb:	c9                   	leave  
  1002bc:	c3                   	ret    

001002bd <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  1002bd:	f3 0f 1e fb          	endbr32 
  1002c1:	55                   	push   %ebp
  1002c2:	89 e5                	mov    %esp,%ebp
  1002c4:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002c7:	8b 45 08             	mov    0x8(%ebp),%eax
  1002ca:	89 04 24             	mov    %eax,(%esp)
  1002cd:	e8 9a 13 00 00       	call   10166c <cons_putc>
}
  1002d2:	90                   	nop
  1002d3:	c9                   	leave  
  1002d4:	c3                   	ret    

001002d5 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  1002d5:	f3 0f 1e fb          	endbr32 
  1002d9:	55                   	push   %ebp
  1002da:	89 e5                	mov    %esp,%ebp
  1002dc:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  1002df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  1002e6:	eb 13                	jmp    1002fb <cputs+0x26>
        cputch(c, &cnt);
  1002e8:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  1002ec:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1002ef:	89 54 24 04          	mov    %edx,0x4(%esp)
  1002f3:	89 04 24             	mov    %eax,(%esp)
  1002f6:	e8 3c ff ff ff       	call   100237 <cputch>
    while ((c = *str ++) != '\0') {
  1002fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1002fe:	8d 50 01             	lea    0x1(%eax),%edx
  100301:	89 55 08             	mov    %edx,0x8(%ebp)
  100304:	0f b6 00             	movzbl (%eax),%eax
  100307:	88 45 f7             	mov    %al,-0x9(%ebp)
  10030a:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  10030e:	75 d8                	jne    1002e8 <cputs+0x13>
    }
    cputch('\n', &cnt);
  100310:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100313:	89 44 24 04          	mov    %eax,0x4(%esp)
  100317:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  10031e:	e8 14 ff ff ff       	call   100237 <cputch>
    return cnt;
  100323:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  100326:	c9                   	leave  
  100327:	c3                   	ret    

00100328 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  100328:	f3 0f 1e fb          	endbr32 
  10032c:	55                   	push   %ebp
  10032d:	89 e5                	mov    %esp,%ebp
  10032f:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  100332:	90                   	nop
  100333:	e8 62 13 00 00       	call   10169a <cons_getc>
  100338:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10033b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10033f:	74 f2                	je     100333 <getchar+0xb>
        /* do nothing */;
    return c;
  100341:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100344:	c9                   	leave  
  100345:	c3                   	ret    

00100346 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100346:	f3 0f 1e fb          	endbr32 
  10034a:	55                   	push   %ebp
  10034b:	89 e5                	mov    %esp,%ebp
  10034d:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  100350:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100354:	74 13                	je     100369 <readline+0x23>
        cprintf("%s", prompt);
  100356:	8b 45 08             	mov    0x8(%ebp),%eax
  100359:	89 44 24 04          	mov    %eax,0x4(%esp)
  10035d:	c7 04 24 67 37 10 00 	movl   $0x103767,(%esp)
  100364:	e8 2a ff ff ff       	call   100293 <cprintf>
    }
    int i = 0, c;
  100369:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  100370:	e8 b3 ff ff ff       	call   100328 <getchar>
  100375:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100378:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10037c:	79 07                	jns    100385 <readline+0x3f>
            return NULL;
  10037e:	b8 00 00 00 00       	mov    $0x0,%eax
  100383:	eb 78                	jmp    1003fd <readline+0xb7>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100385:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100389:	7e 28                	jle    1003b3 <readline+0x6d>
  10038b:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100392:	7f 1f                	jg     1003b3 <readline+0x6d>
            cputchar(c);
  100394:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100397:	89 04 24             	mov    %eax,(%esp)
  10039a:	e8 1e ff ff ff       	call   1002bd <cputchar>
            buf[i ++] = c;
  10039f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003a2:	8d 50 01             	lea    0x1(%eax),%edx
  1003a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1003a8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1003ab:	88 90 40 fa 10 00    	mov    %dl,0x10fa40(%eax)
  1003b1:	eb 45                	jmp    1003f8 <readline+0xb2>
        }
        else if (c == '\b' && i > 0) {
  1003b3:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  1003b7:	75 16                	jne    1003cf <readline+0x89>
  1003b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003bd:	7e 10                	jle    1003cf <readline+0x89>
            cputchar(c);
  1003bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003c2:	89 04 24             	mov    %eax,(%esp)
  1003c5:	e8 f3 fe ff ff       	call   1002bd <cputchar>
            i --;
  1003ca:	ff 4d f4             	decl   -0xc(%ebp)
  1003cd:	eb 29                	jmp    1003f8 <readline+0xb2>
        }
        else if (c == '\n' || c == '\r') {
  1003cf:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1003d3:	74 06                	je     1003db <readline+0x95>
  1003d5:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1003d9:	75 95                	jne    100370 <readline+0x2a>
            cputchar(c);
  1003db:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003de:	89 04 24             	mov    %eax,(%esp)
  1003e1:	e8 d7 fe ff ff       	call   1002bd <cputchar>
            buf[i] = '\0';
  1003e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003e9:	05 40 fa 10 00       	add    $0x10fa40,%eax
  1003ee:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1003f1:	b8 40 fa 10 00       	mov    $0x10fa40,%eax
  1003f6:	eb 05                	jmp    1003fd <readline+0xb7>
        c = getchar();
  1003f8:	e9 73 ff ff ff       	jmp    100370 <readline+0x2a>
        }
    }
}
  1003fd:	c9                   	leave  
  1003fe:	c3                   	ret    

001003ff <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1003ff:	f3 0f 1e fb          	endbr32 
  100403:	55                   	push   %ebp
  100404:	89 e5                	mov    %esp,%ebp
  100406:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  100409:	a1 40 fe 10 00       	mov    0x10fe40,%eax
  10040e:	85 c0                	test   %eax,%eax
  100410:	75 5b                	jne    10046d <__panic+0x6e>
        goto panic_dead;
    }
    is_panic = 1;
  100412:	c7 05 40 fe 10 00 01 	movl   $0x1,0x10fe40
  100419:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  10041c:	8d 45 14             	lea    0x14(%ebp),%eax
  10041f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100422:	8b 45 0c             	mov    0xc(%ebp),%eax
  100425:	89 44 24 08          	mov    %eax,0x8(%esp)
  100429:	8b 45 08             	mov    0x8(%ebp),%eax
  10042c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100430:	c7 04 24 6a 37 10 00 	movl   $0x10376a,(%esp)
  100437:	e8 57 fe ff ff       	call   100293 <cprintf>
    vcprintf(fmt, ap);
  10043c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10043f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100443:	8b 45 10             	mov    0x10(%ebp),%eax
  100446:	89 04 24             	mov    %eax,(%esp)
  100449:	e8 0e fe ff ff       	call   10025c <vcprintf>
    cprintf("\n");
  10044e:	c7 04 24 86 37 10 00 	movl   $0x103786,(%esp)
  100455:	e8 39 fe ff ff       	call   100293 <cprintf>
    
    cprintf("stack trackback:\n");
  10045a:	c7 04 24 88 37 10 00 	movl   $0x103788,(%esp)
  100461:	e8 2d fe ff ff       	call   100293 <cprintf>
    print_stackframe();
  100466:	e8 3d 06 00 00       	call   100aa8 <print_stackframe>
  10046b:	eb 01                	jmp    10046e <__panic+0x6f>
        goto panic_dead;
  10046d:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  10046e:	e8 75 14 00 00       	call   1018e8 <intr_disable>
    while (1) {
        kmonitor(NULL);
  100473:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10047a:	e8 52 08 00 00       	call   100cd1 <kmonitor>
  10047f:	eb f2                	jmp    100473 <__panic+0x74>

00100481 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100481:	f3 0f 1e fb          	endbr32 
  100485:	55                   	push   %ebp
  100486:	89 e5                	mov    %esp,%ebp
  100488:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  10048b:	8d 45 14             	lea    0x14(%ebp),%eax
  10048e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100491:	8b 45 0c             	mov    0xc(%ebp),%eax
  100494:	89 44 24 08          	mov    %eax,0x8(%esp)
  100498:	8b 45 08             	mov    0x8(%ebp),%eax
  10049b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10049f:	c7 04 24 9a 37 10 00 	movl   $0x10379a,(%esp)
  1004a6:	e8 e8 fd ff ff       	call   100293 <cprintf>
    vcprintf(fmt, ap);
  1004ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004ae:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004b2:	8b 45 10             	mov    0x10(%ebp),%eax
  1004b5:	89 04 24             	mov    %eax,(%esp)
  1004b8:	e8 9f fd ff ff       	call   10025c <vcprintf>
    cprintf("\n");
  1004bd:	c7 04 24 86 37 10 00 	movl   $0x103786,(%esp)
  1004c4:	e8 ca fd ff ff       	call   100293 <cprintf>
    va_end(ap);
}
  1004c9:	90                   	nop
  1004ca:	c9                   	leave  
  1004cb:	c3                   	ret    

001004cc <is_kernel_panic>:

bool
is_kernel_panic(void) {
  1004cc:	f3 0f 1e fb          	endbr32 
  1004d0:	55                   	push   %ebp
  1004d1:	89 e5                	mov    %esp,%ebp
    return is_panic;
  1004d3:	a1 40 fe 10 00       	mov    0x10fe40,%eax
}
  1004d8:	5d                   	pop    %ebp
  1004d9:	c3                   	ret    

001004da <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1004da:	f3 0f 1e fb          	endbr32 
  1004de:	55                   	push   %ebp
  1004df:	89 e5                	mov    %esp,%ebp
  1004e1:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1004e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004e7:	8b 00                	mov    (%eax),%eax
  1004e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1004ec:	8b 45 10             	mov    0x10(%ebp),%eax
  1004ef:	8b 00                	mov    (%eax),%eax
  1004f1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1004fb:	e9 ca 00 00 00       	jmp    1005ca <stab_binsearch+0xf0>
        int true_m = (l + r) / 2, m = true_m;
  100500:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100503:	8b 45 f8             	mov    -0x8(%ebp),%eax
  100506:	01 d0                	add    %edx,%eax
  100508:	89 c2                	mov    %eax,%edx
  10050a:	c1 ea 1f             	shr    $0x1f,%edx
  10050d:	01 d0                	add    %edx,%eax
  10050f:	d1 f8                	sar    %eax
  100511:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100514:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100517:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  10051a:	eb 03                	jmp    10051f <stab_binsearch+0x45>
            m --;
  10051c:	ff 4d f0             	decl   -0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  10051f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100522:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100525:	7c 1f                	jl     100546 <stab_binsearch+0x6c>
  100527:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10052a:	89 d0                	mov    %edx,%eax
  10052c:	01 c0                	add    %eax,%eax
  10052e:	01 d0                	add    %edx,%eax
  100530:	c1 e0 02             	shl    $0x2,%eax
  100533:	89 c2                	mov    %eax,%edx
  100535:	8b 45 08             	mov    0x8(%ebp),%eax
  100538:	01 d0                	add    %edx,%eax
  10053a:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10053e:	0f b6 c0             	movzbl %al,%eax
  100541:	39 45 14             	cmp    %eax,0x14(%ebp)
  100544:	75 d6                	jne    10051c <stab_binsearch+0x42>
        }
        if (m < l) {    // no match in [l, m]
  100546:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100549:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10054c:	7d 09                	jge    100557 <stab_binsearch+0x7d>
            l = true_m + 1;
  10054e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100551:	40                   	inc    %eax
  100552:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  100555:	eb 73                	jmp    1005ca <stab_binsearch+0xf0>
        }

        // actual binary search
        any_matches = 1;
  100557:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  10055e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100561:	89 d0                	mov    %edx,%eax
  100563:	01 c0                	add    %eax,%eax
  100565:	01 d0                	add    %edx,%eax
  100567:	c1 e0 02             	shl    $0x2,%eax
  10056a:	89 c2                	mov    %eax,%edx
  10056c:	8b 45 08             	mov    0x8(%ebp),%eax
  10056f:	01 d0                	add    %edx,%eax
  100571:	8b 40 08             	mov    0x8(%eax),%eax
  100574:	39 45 18             	cmp    %eax,0x18(%ebp)
  100577:	76 11                	jbe    10058a <stab_binsearch+0xb0>
            *region_left = m;
  100579:	8b 45 0c             	mov    0xc(%ebp),%eax
  10057c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10057f:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100581:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100584:	40                   	inc    %eax
  100585:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100588:	eb 40                	jmp    1005ca <stab_binsearch+0xf0>
        } else if (stabs[m].n_value > addr) {
  10058a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10058d:	89 d0                	mov    %edx,%eax
  10058f:	01 c0                	add    %eax,%eax
  100591:	01 d0                	add    %edx,%eax
  100593:	c1 e0 02             	shl    $0x2,%eax
  100596:	89 c2                	mov    %eax,%edx
  100598:	8b 45 08             	mov    0x8(%ebp),%eax
  10059b:	01 d0                	add    %edx,%eax
  10059d:	8b 40 08             	mov    0x8(%eax),%eax
  1005a0:	39 45 18             	cmp    %eax,0x18(%ebp)
  1005a3:	73 14                	jae    1005b9 <stab_binsearch+0xdf>
            *region_right = m - 1;
  1005a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005a8:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005ab:	8b 45 10             	mov    0x10(%ebp),%eax
  1005ae:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  1005b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005b3:	48                   	dec    %eax
  1005b4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1005b7:	eb 11                	jmp    1005ca <stab_binsearch+0xf0>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1005b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005bc:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005bf:	89 10                	mov    %edx,(%eax)
            l = m;
  1005c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1005c7:	ff 45 18             	incl   0x18(%ebp)
    while (l <= r) {
  1005ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1005cd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1005d0:	0f 8e 2a ff ff ff    	jle    100500 <stab_binsearch+0x26>
        }
    }

    if (!any_matches) {
  1005d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1005da:	75 0f                	jne    1005eb <stab_binsearch+0x111>
        *region_right = *region_left - 1;
  1005dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005df:	8b 00                	mov    (%eax),%eax
  1005e1:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005e4:	8b 45 10             	mov    0x10(%ebp),%eax
  1005e7:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1005e9:	eb 3e                	jmp    100629 <stab_binsearch+0x14f>
        l = *region_right;
  1005eb:	8b 45 10             	mov    0x10(%ebp),%eax
  1005ee:	8b 00                	mov    (%eax),%eax
  1005f0:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1005f3:	eb 03                	jmp    1005f8 <stab_binsearch+0x11e>
  1005f5:	ff 4d fc             	decl   -0x4(%ebp)
  1005f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005fb:	8b 00                	mov    (%eax),%eax
  1005fd:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  100600:	7e 1f                	jle    100621 <stab_binsearch+0x147>
  100602:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100605:	89 d0                	mov    %edx,%eax
  100607:	01 c0                	add    %eax,%eax
  100609:	01 d0                	add    %edx,%eax
  10060b:	c1 e0 02             	shl    $0x2,%eax
  10060e:	89 c2                	mov    %eax,%edx
  100610:	8b 45 08             	mov    0x8(%ebp),%eax
  100613:	01 d0                	add    %edx,%eax
  100615:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100619:	0f b6 c0             	movzbl %al,%eax
  10061c:	39 45 14             	cmp    %eax,0x14(%ebp)
  10061f:	75 d4                	jne    1005f5 <stab_binsearch+0x11b>
        *region_left = l;
  100621:	8b 45 0c             	mov    0xc(%ebp),%eax
  100624:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100627:	89 10                	mov    %edx,(%eax)
}
  100629:	90                   	nop
  10062a:	c9                   	leave  
  10062b:	c3                   	ret    

0010062c <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  10062c:	f3 0f 1e fb          	endbr32 
  100630:	55                   	push   %ebp
  100631:	89 e5                	mov    %esp,%ebp
  100633:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  100636:	8b 45 0c             	mov    0xc(%ebp),%eax
  100639:	c7 00 b8 37 10 00    	movl   $0x1037b8,(%eax)
    info->eip_line = 0;
  10063f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100642:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100649:	8b 45 0c             	mov    0xc(%ebp),%eax
  10064c:	c7 40 08 b8 37 10 00 	movl   $0x1037b8,0x8(%eax)
    info->eip_fn_namelen = 9;
  100653:	8b 45 0c             	mov    0xc(%ebp),%eax
  100656:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  10065d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100660:	8b 55 08             	mov    0x8(%ebp),%edx
  100663:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100666:	8b 45 0c             	mov    0xc(%ebp),%eax
  100669:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100670:	c7 45 f4 ec 3f 10 00 	movl   $0x103fec,-0xc(%ebp)
    stab_end = __STAB_END__;
  100677:	c7 45 f0 88 cd 10 00 	movl   $0x10cd88,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  10067e:	c7 45 ec 89 cd 10 00 	movl   $0x10cd89,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100685:	c7 45 e8 60 ee 10 00 	movl   $0x10ee60,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  10068c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10068f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100692:	76 0b                	jbe    10069f <debuginfo_eip+0x73>
  100694:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100697:	48                   	dec    %eax
  100698:	0f b6 00             	movzbl (%eax),%eax
  10069b:	84 c0                	test   %al,%al
  10069d:	74 0a                	je     1006a9 <debuginfo_eip+0x7d>
        return -1;
  10069f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006a4:	e9 ab 02 00 00       	jmp    100954 <debuginfo_eip+0x328>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  1006a9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1006b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006b3:	2b 45 f4             	sub    -0xc(%ebp),%eax
  1006b6:	c1 f8 02             	sar    $0x2,%eax
  1006b9:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1006bf:	48                   	dec    %eax
  1006c0:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1006c3:	8b 45 08             	mov    0x8(%ebp),%eax
  1006c6:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006ca:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1006d1:	00 
  1006d2:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1006d5:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006d9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1006dc:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006e3:	89 04 24             	mov    %eax,(%esp)
  1006e6:	e8 ef fd ff ff       	call   1004da <stab_binsearch>
    if (lfile == 0)
  1006eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006ee:	85 c0                	test   %eax,%eax
  1006f0:	75 0a                	jne    1006fc <debuginfo_eip+0xd0>
        return -1;
  1006f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006f7:	e9 58 02 00 00       	jmp    100954 <debuginfo_eip+0x328>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1006fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006ff:	89 45 dc             	mov    %eax,-0x24(%ebp)
  100702:	8b 45 e0             	mov    -0x20(%ebp),%eax
  100705:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  100708:	8b 45 08             	mov    0x8(%ebp),%eax
  10070b:	89 44 24 10          	mov    %eax,0x10(%esp)
  10070f:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  100716:	00 
  100717:	8d 45 d8             	lea    -0x28(%ebp),%eax
  10071a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10071e:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100721:	89 44 24 04          	mov    %eax,0x4(%esp)
  100725:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100728:	89 04 24             	mov    %eax,(%esp)
  10072b:	e8 aa fd ff ff       	call   1004da <stab_binsearch>

    if (lfun <= rfun) {
  100730:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100733:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100736:	39 c2                	cmp    %eax,%edx
  100738:	7f 78                	jg     1007b2 <debuginfo_eip+0x186>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  10073a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10073d:	89 c2                	mov    %eax,%edx
  10073f:	89 d0                	mov    %edx,%eax
  100741:	01 c0                	add    %eax,%eax
  100743:	01 d0                	add    %edx,%eax
  100745:	c1 e0 02             	shl    $0x2,%eax
  100748:	89 c2                	mov    %eax,%edx
  10074a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10074d:	01 d0                	add    %edx,%eax
  10074f:	8b 10                	mov    (%eax),%edx
  100751:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100754:	2b 45 ec             	sub    -0x14(%ebp),%eax
  100757:	39 c2                	cmp    %eax,%edx
  100759:	73 22                	jae    10077d <debuginfo_eip+0x151>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  10075b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10075e:	89 c2                	mov    %eax,%edx
  100760:	89 d0                	mov    %edx,%eax
  100762:	01 c0                	add    %eax,%eax
  100764:	01 d0                	add    %edx,%eax
  100766:	c1 e0 02             	shl    $0x2,%eax
  100769:	89 c2                	mov    %eax,%edx
  10076b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10076e:	01 d0                	add    %edx,%eax
  100770:	8b 10                	mov    (%eax),%edx
  100772:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100775:	01 c2                	add    %eax,%edx
  100777:	8b 45 0c             	mov    0xc(%ebp),%eax
  10077a:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  10077d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100780:	89 c2                	mov    %eax,%edx
  100782:	89 d0                	mov    %edx,%eax
  100784:	01 c0                	add    %eax,%eax
  100786:	01 d0                	add    %edx,%eax
  100788:	c1 e0 02             	shl    $0x2,%eax
  10078b:	89 c2                	mov    %eax,%edx
  10078d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100790:	01 d0                	add    %edx,%eax
  100792:	8b 50 08             	mov    0x8(%eax),%edx
  100795:	8b 45 0c             	mov    0xc(%ebp),%eax
  100798:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  10079b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10079e:	8b 40 10             	mov    0x10(%eax),%eax
  1007a1:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  1007a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1007a7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  1007aa:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1007ad:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1007b0:	eb 15                	jmp    1007c7 <debuginfo_eip+0x19b>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1007b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007b5:	8b 55 08             	mov    0x8(%ebp),%edx
  1007b8:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1007bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007be:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1007c1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1007c4:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1007c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007ca:	8b 40 08             	mov    0x8(%eax),%eax
  1007cd:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1007d4:	00 
  1007d5:	89 04 24             	mov    %eax,(%esp)
  1007d8:	e8 18 25 00 00       	call   102cf5 <strfind>
  1007dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  1007e0:	8b 52 08             	mov    0x8(%edx),%edx
  1007e3:	29 d0                	sub    %edx,%eax
  1007e5:	89 c2                	mov    %eax,%edx
  1007e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007ea:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1007ed:	8b 45 08             	mov    0x8(%ebp),%eax
  1007f0:	89 44 24 10          	mov    %eax,0x10(%esp)
  1007f4:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1007fb:	00 
  1007fc:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1007ff:	89 44 24 08          	mov    %eax,0x8(%esp)
  100803:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  100806:	89 44 24 04          	mov    %eax,0x4(%esp)
  10080a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10080d:	89 04 24             	mov    %eax,(%esp)
  100810:	e8 c5 fc ff ff       	call   1004da <stab_binsearch>
    if (lline <= rline) {
  100815:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100818:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10081b:	39 c2                	cmp    %eax,%edx
  10081d:	7f 23                	jg     100842 <debuginfo_eip+0x216>
        info->eip_line = stabs[rline].n_desc;
  10081f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100822:	89 c2                	mov    %eax,%edx
  100824:	89 d0                	mov    %edx,%eax
  100826:	01 c0                	add    %eax,%eax
  100828:	01 d0                	add    %edx,%eax
  10082a:	c1 e0 02             	shl    $0x2,%eax
  10082d:	89 c2                	mov    %eax,%edx
  10082f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100832:	01 d0                	add    %edx,%eax
  100834:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  100838:	89 c2                	mov    %eax,%edx
  10083a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10083d:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100840:	eb 11                	jmp    100853 <debuginfo_eip+0x227>
        return -1;
  100842:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100847:	e9 08 01 00 00       	jmp    100954 <debuginfo_eip+0x328>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  10084c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10084f:	48                   	dec    %eax
  100850:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  100853:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100856:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100859:	39 c2                	cmp    %eax,%edx
  10085b:	7c 56                	jl     1008b3 <debuginfo_eip+0x287>
           && stabs[lline].n_type != N_SOL
  10085d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100860:	89 c2                	mov    %eax,%edx
  100862:	89 d0                	mov    %edx,%eax
  100864:	01 c0                	add    %eax,%eax
  100866:	01 d0                	add    %edx,%eax
  100868:	c1 e0 02             	shl    $0x2,%eax
  10086b:	89 c2                	mov    %eax,%edx
  10086d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100870:	01 d0                	add    %edx,%eax
  100872:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100876:	3c 84                	cmp    $0x84,%al
  100878:	74 39                	je     1008b3 <debuginfo_eip+0x287>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  10087a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10087d:	89 c2                	mov    %eax,%edx
  10087f:	89 d0                	mov    %edx,%eax
  100881:	01 c0                	add    %eax,%eax
  100883:	01 d0                	add    %edx,%eax
  100885:	c1 e0 02             	shl    $0x2,%eax
  100888:	89 c2                	mov    %eax,%edx
  10088a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10088d:	01 d0                	add    %edx,%eax
  10088f:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100893:	3c 64                	cmp    $0x64,%al
  100895:	75 b5                	jne    10084c <debuginfo_eip+0x220>
  100897:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10089a:	89 c2                	mov    %eax,%edx
  10089c:	89 d0                	mov    %edx,%eax
  10089e:	01 c0                	add    %eax,%eax
  1008a0:	01 d0                	add    %edx,%eax
  1008a2:	c1 e0 02             	shl    $0x2,%eax
  1008a5:	89 c2                	mov    %eax,%edx
  1008a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008aa:	01 d0                	add    %edx,%eax
  1008ac:	8b 40 08             	mov    0x8(%eax),%eax
  1008af:	85 c0                	test   %eax,%eax
  1008b1:	74 99                	je     10084c <debuginfo_eip+0x220>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1008b3:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1008b9:	39 c2                	cmp    %eax,%edx
  1008bb:	7c 42                	jl     1008ff <debuginfo_eip+0x2d3>
  1008bd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008c0:	89 c2                	mov    %eax,%edx
  1008c2:	89 d0                	mov    %edx,%eax
  1008c4:	01 c0                	add    %eax,%eax
  1008c6:	01 d0                	add    %edx,%eax
  1008c8:	c1 e0 02             	shl    $0x2,%eax
  1008cb:	89 c2                	mov    %eax,%edx
  1008cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008d0:	01 d0                	add    %edx,%eax
  1008d2:	8b 10                	mov    (%eax),%edx
  1008d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1008d7:	2b 45 ec             	sub    -0x14(%ebp),%eax
  1008da:	39 c2                	cmp    %eax,%edx
  1008dc:	73 21                	jae    1008ff <debuginfo_eip+0x2d3>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1008de:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008e1:	89 c2                	mov    %eax,%edx
  1008e3:	89 d0                	mov    %edx,%eax
  1008e5:	01 c0                	add    %eax,%eax
  1008e7:	01 d0                	add    %edx,%eax
  1008e9:	c1 e0 02             	shl    $0x2,%eax
  1008ec:	89 c2                	mov    %eax,%edx
  1008ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008f1:	01 d0                	add    %edx,%eax
  1008f3:	8b 10                	mov    (%eax),%edx
  1008f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1008f8:	01 c2                	add    %eax,%edx
  1008fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008fd:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1008ff:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100902:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100905:	39 c2                	cmp    %eax,%edx
  100907:	7d 46                	jge    10094f <debuginfo_eip+0x323>
        for (lline = lfun + 1;
  100909:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10090c:	40                   	inc    %eax
  10090d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  100910:	eb 16                	jmp    100928 <debuginfo_eip+0x2fc>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100912:	8b 45 0c             	mov    0xc(%ebp),%eax
  100915:	8b 40 14             	mov    0x14(%eax),%eax
  100918:	8d 50 01             	lea    0x1(%eax),%edx
  10091b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10091e:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  100921:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100924:	40                   	inc    %eax
  100925:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100928:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10092b:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  10092e:	39 c2                	cmp    %eax,%edx
  100930:	7d 1d                	jge    10094f <debuginfo_eip+0x323>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100932:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100935:	89 c2                	mov    %eax,%edx
  100937:	89 d0                	mov    %edx,%eax
  100939:	01 c0                	add    %eax,%eax
  10093b:	01 d0                	add    %edx,%eax
  10093d:	c1 e0 02             	shl    $0x2,%eax
  100940:	89 c2                	mov    %eax,%edx
  100942:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100945:	01 d0                	add    %edx,%eax
  100947:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10094b:	3c a0                	cmp    $0xa0,%al
  10094d:	74 c3                	je     100912 <debuginfo_eip+0x2e6>
        }
    }
    return 0;
  10094f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100954:	c9                   	leave  
  100955:	c3                   	ret    

00100956 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100956:	f3 0f 1e fb          	endbr32 
  10095a:	55                   	push   %ebp
  10095b:	89 e5                	mov    %esp,%ebp
  10095d:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100960:	c7 04 24 c2 37 10 00 	movl   $0x1037c2,(%esp)
  100967:	e8 27 f9 ff ff       	call   100293 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  10096c:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  100973:	00 
  100974:	c7 04 24 db 37 10 00 	movl   $0x1037db,(%esp)
  10097b:	e8 13 f9 ff ff       	call   100293 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  100980:	c7 44 24 04 a5 36 10 	movl   $0x1036a5,0x4(%esp)
  100987:	00 
  100988:	c7 04 24 f3 37 10 00 	movl   $0x1037f3,(%esp)
  10098f:	e8 ff f8 ff ff       	call   100293 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  100994:	c7 44 24 04 16 fa 10 	movl   $0x10fa16,0x4(%esp)
  10099b:	00 
  10099c:	c7 04 24 0b 38 10 00 	movl   $0x10380b,(%esp)
  1009a3:	e8 eb f8 ff ff       	call   100293 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  1009a8:	c7 44 24 04 20 0d 11 	movl   $0x110d20,0x4(%esp)
  1009af:	00 
  1009b0:	c7 04 24 23 38 10 00 	movl   $0x103823,(%esp)
  1009b7:	e8 d7 f8 ff ff       	call   100293 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1009bc:	b8 20 0d 11 00       	mov    $0x110d20,%eax
  1009c1:	2d 00 00 10 00       	sub    $0x100000,%eax
  1009c6:	05 ff 03 00 00       	add    $0x3ff,%eax
  1009cb:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1009d1:	85 c0                	test   %eax,%eax
  1009d3:	0f 48 c2             	cmovs  %edx,%eax
  1009d6:	c1 f8 0a             	sar    $0xa,%eax
  1009d9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009dd:	c7 04 24 3c 38 10 00 	movl   $0x10383c,(%esp)
  1009e4:	e8 aa f8 ff ff       	call   100293 <cprintf>
}
  1009e9:	90                   	nop
  1009ea:	c9                   	leave  
  1009eb:	c3                   	ret    

001009ec <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1009ec:	f3 0f 1e fb          	endbr32 
  1009f0:	55                   	push   %ebp
  1009f1:	89 e5                	mov    %esp,%ebp
  1009f3:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1009f9:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1009fc:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a00:	8b 45 08             	mov    0x8(%ebp),%eax
  100a03:	89 04 24             	mov    %eax,(%esp)
  100a06:	e8 21 fc ff ff       	call   10062c <debuginfo_eip>
  100a0b:	85 c0                	test   %eax,%eax
  100a0d:	74 15                	je     100a24 <print_debuginfo+0x38>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100a0f:	8b 45 08             	mov    0x8(%ebp),%eax
  100a12:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a16:	c7 04 24 66 38 10 00 	movl   $0x103866,(%esp)
  100a1d:	e8 71 f8 ff ff       	call   100293 <cprintf>
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100a22:	eb 6c                	jmp    100a90 <print_debuginfo+0xa4>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a24:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100a2b:	eb 1b                	jmp    100a48 <print_debuginfo+0x5c>
            fnname[j] = info.eip_fn_name[j];
  100a2d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100a30:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a33:	01 d0                	add    %edx,%eax
  100a35:	0f b6 10             	movzbl (%eax),%edx
  100a38:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a41:	01 c8                	add    %ecx,%eax
  100a43:	88 10                	mov    %dl,(%eax)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a45:	ff 45 f4             	incl   -0xc(%ebp)
  100a48:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100a4b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100a4e:	7c dd                	jl     100a2d <print_debuginfo+0x41>
        fnname[j] = '\0';
  100a50:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100a56:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a59:	01 d0                	add    %edx,%eax
  100a5b:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100a5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100a61:	8b 55 08             	mov    0x8(%ebp),%edx
  100a64:	89 d1                	mov    %edx,%ecx
  100a66:	29 c1                	sub    %eax,%ecx
  100a68:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100a6b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a6e:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  100a72:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a78:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a7c:	89 54 24 08          	mov    %edx,0x8(%esp)
  100a80:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a84:	c7 04 24 82 38 10 00 	movl   $0x103882,(%esp)
  100a8b:	e8 03 f8 ff ff       	call   100293 <cprintf>
}
  100a90:	90                   	nop
  100a91:	c9                   	leave  
  100a92:	c3                   	ret    

00100a93 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100a93:	f3 0f 1e fb          	endbr32 
  100a97:	55                   	push   %ebp
  100a98:	89 e5                	mov    %esp,%ebp
  100a9a:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100a9d:	8b 45 04             	mov    0x4(%ebp),%eax
  100aa0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100aa3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100aa6:	c9                   	leave  
  100aa7:	c3                   	ret    

00100aa8 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100aa8:	f3 0f 1e fb          	endbr32 
  100aac:	55                   	push   %ebp
  100aad:	89 e5                	mov    %esp,%ebp
  100aaf:	83 ec 38             	sub    $0x38,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100ab2:	89 e8                	mov    %ebp,%eax
  100ab4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return ebp;
  100ab7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
    uint32_t ebp=read_ebp();   //调用read ebp访问当前ebp的值，数据类型为32位。
  100aba:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32_t eip=read_eip();   //调用read eip访问eip的值，数据类型同。
  100abd:	e8 d1 ff ff ff       	call   100a93 <read_eip>
  100ac2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int i;   //这里有个细节问题，就是不能for int i，这里面的C标准似乎不允许
	for(i=0;i<STACKFRAME_DEPTH&&ebp!=0;i++)
  100ac5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100acc:	eb 7c                	jmp    100b4a <print_stackframe+0xa2>
	{
		//(3) from 0 .. STACKFRAME_DEPTH
		cprintf("ebp:0x%08x eip:0x%08x ",ebp,eip);//(3.1)printf value of ebp, eip
  100ace:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100ad1:	89 44 24 08          	mov    %eax,0x8(%esp)
  100ad5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ad8:	89 44 24 04          	mov    %eax,0x4(%esp)
  100adc:	c7 04 24 94 38 10 00 	movl   $0x103894,(%esp)
  100ae3:	e8 ab f7 ff ff       	call   100293 <cprintf>
		for(int j=0;j<4;j++){
  100ae8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100aef:	eb 25                	jmp    100b16 <print_stackframe+0x6e>
            	cprintf("0x%08x ",((uint32_t*)ebp+2+j));
  100af1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100af4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100afb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100afe:	01 d0                	add    %edx,%eax
  100b00:	83 c0 08             	add    $0x8,%eax
  100b03:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b07:	c7 04 24 ab 38 10 00 	movl   $0x1038ab,(%esp)
  100b0e:	e8 80 f7 ff ff       	call   100293 <cprintf>
		for(int j=0;j<4;j++){
  100b13:	ff 45 e8             	incl   -0x18(%ebp)
  100b16:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100b1a:	7e d5                	jle    100af1 <print_stackframe+0x49>
        }
		cprintf("\n");
  100b1c:	c7 04 24 b3 38 10 00 	movl   $0x1038b3,(%esp)
  100b23:	e8 6b f7 ff ff       	call   100293 <cprintf>
 
		//因为使用的是栈数据结构，因此可以直接根据ebp就能读取到各个栈帧的地址和值，ebp+4处为返回地址，ebp+8处为第一个参数值（最后一个入栈的参数值，对应32位系统），ebp-4处为第一个局部变量，ebp处为上一层 ebp 值。
 
		//而这里，*代表指针，指针也是占用4个字节，因此可以直接对于指针加一，地址加4。
 
		print_debuginfo(eip-1);	//打印eip以及ebp相关的信息
  100b28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b2b:	48                   	dec    %eax
  100b2c:	89 04 24             	mov    %eax,(%esp)
  100b2f:	e8 b8 fe ff ff       	call   1009ec <print_debuginfo>
		eip=*((uint32_t *)ebp+1);//此时eip指向了返回地址
  100b34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b37:	83 c0 04             	add    $0x4,%eax
  100b3a:	8b 00                	mov    (%eax),%eax
  100b3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		ebp=*((uint32_t *)ebp+0);//ebp指向了原ebp的位置
  100b3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b42:	8b 00                	mov    (%eax),%eax
  100b44:	89 45 f4             	mov    %eax,-0xc(%ebp)
	for(i=0;i<STACKFRAME_DEPTH&&ebp!=0;i++)
  100b47:	ff 45 ec             	incl   -0x14(%ebp)
  100b4a:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100b4e:	7f 0a                	jg     100b5a <print_stackframe+0xb2>
  100b50:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b54:	0f 85 74 ff ff ff    	jne    100ace <print_stackframe+0x26>
//最后更新ebp：ebp=ebp[0],更新eip：eip=ebp[1]，因为ebp[0]=ebp，ebp[1]=ebp[0]+4=eip。
	}
}
  100b5a:	90                   	nop
  100b5b:	c9                   	leave  
  100b5c:	c3                   	ret    

00100b5d <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100b5d:	f3 0f 1e fb          	endbr32 
  100b61:	55                   	push   %ebp
  100b62:	89 e5                	mov    %esp,%ebp
  100b64:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100b67:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b6e:	eb 0c                	jmp    100b7c <parse+0x1f>
            *buf ++ = '\0';
  100b70:	8b 45 08             	mov    0x8(%ebp),%eax
  100b73:	8d 50 01             	lea    0x1(%eax),%edx
  100b76:	89 55 08             	mov    %edx,0x8(%ebp)
  100b79:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b7c:	8b 45 08             	mov    0x8(%ebp),%eax
  100b7f:	0f b6 00             	movzbl (%eax),%eax
  100b82:	84 c0                	test   %al,%al
  100b84:	74 1d                	je     100ba3 <parse+0x46>
  100b86:	8b 45 08             	mov    0x8(%ebp),%eax
  100b89:	0f b6 00             	movzbl (%eax),%eax
  100b8c:	0f be c0             	movsbl %al,%eax
  100b8f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b93:	c7 04 24 38 39 10 00 	movl   $0x103938,(%esp)
  100b9a:	e8 20 21 00 00       	call   102cbf <strchr>
  100b9f:	85 c0                	test   %eax,%eax
  100ba1:	75 cd                	jne    100b70 <parse+0x13>
        }
        if (*buf == '\0') {
  100ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  100ba6:	0f b6 00             	movzbl (%eax),%eax
  100ba9:	84 c0                	test   %al,%al
  100bab:	74 65                	je     100c12 <parse+0xb5>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100bad:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100bb1:	75 14                	jne    100bc7 <parse+0x6a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100bb3:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100bba:	00 
  100bbb:	c7 04 24 3d 39 10 00 	movl   $0x10393d,(%esp)
  100bc2:	e8 cc f6 ff ff       	call   100293 <cprintf>
        }
        argv[argc ++] = buf;
  100bc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bca:	8d 50 01             	lea    0x1(%eax),%edx
  100bcd:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100bd0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100bd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  100bda:	01 c2                	add    %eax,%edx
  100bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  100bdf:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100be1:	eb 03                	jmp    100be6 <parse+0x89>
            buf ++;
  100be3:	ff 45 08             	incl   0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100be6:	8b 45 08             	mov    0x8(%ebp),%eax
  100be9:	0f b6 00             	movzbl (%eax),%eax
  100bec:	84 c0                	test   %al,%al
  100bee:	74 8c                	je     100b7c <parse+0x1f>
  100bf0:	8b 45 08             	mov    0x8(%ebp),%eax
  100bf3:	0f b6 00             	movzbl (%eax),%eax
  100bf6:	0f be c0             	movsbl %al,%eax
  100bf9:	89 44 24 04          	mov    %eax,0x4(%esp)
  100bfd:	c7 04 24 38 39 10 00 	movl   $0x103938,(%esp)
  100c04:	e8 b6 20 00 00       	call   102cbf <strchr>
  100c09:	85 c0                	test   %eax,%eax
  100c0b:	74 d6                	je     100be3 <parse+0x86>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100c0d:	e9 6a ff ff ff       	jmp    100b7c <parse+0x1f>
            break;
  100c12:	90                   	nop
        }
    }
    return argc;
  100c13:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100c16:	c9                   	leave  
  100c17:	c3                   	ret    

00100c18 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100c18:	f3 0f 1e fb          	endbr32 
  100c1c:	55                   	push   %ebp
  100c1d:	89 e5                	mov    %esp,%ebp
  100c1f:	53                   	push   %ebx
  100c20:	83 ec 64             	sub    $0x64,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100c23:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c26:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c2a:	8b 45 08             	mov    0x8(%ebp),%eax
  100c2d:	89 04 24             	mov    %eax,(%esp)
  100c30:	e8 28 ff ff ff       	call   100b5d <parse>
  100c35:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100c38:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100c3c:	75 0a                	jne    100c48 <runcmd+0x30>
        return 0;
  100c3e:	b8 00 00 00 00       	mov    $0x0,%eax
  100c43:	e9 83 00 00 00       	jmp    100ccb <runcmd+0xb3>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c48:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c4f:	eb 5a                	jmp    100cab <runcmd+0x93>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100c51:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100c54:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c57:	89 d0                	mov    %edx,%eax
  100c59:	01 c0                	add    %eax,%eax
  100c5b:	01 d0                	add    %edx,%eax
  100c5d:	c1 e0 02             	shl    $0x2,%eax
  100c60:	05 00 f0 10 00       	add    $0x10f000,%eax
  100c65:	8b 00                	mov    (%eax),%eax
  100c67:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100c6b:	89 04 24             	mov    %eax,(%esp)
  100c6e:	e8 a8 1f 00 00       	call   102c1b <strcmp>
  100c73:	85 c0                	test   %eax,%eax
  100c75:	75 31                	jne    100ca8 <runcmd+0x90>
            return commands[i].func(argc - 1, argv + 1, tf);
  100c77:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c7a:	89 d0                	mov    %edx,%eax
  100c7c:	01 c0                	add    %eax,%eax
  100c7e:	01 d0                	add    %edx,%eax
  100c80:	c1 e0 02             	shl    $0x2,%eax
  100c83:	05 08 f0 10 00       	add    $0x10f008,%eax
  100c88:	8b 10                	mov    (%eax),%edx
  100c8a:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c8d:	83 c0 04             	add    $0x4,%eax
  100c90:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100c93:	8d 59 ff             	lea    -0x1(%ecx),%ebx
  100c96:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100c99:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100c9d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100ca1:	89 1c 24             	mov    %ebx,(%esp)
  100ca4:	ff d2                	call   *%edx
  100ca6:	eb 23                	jmp    100ccb <runcmd+0xb3>
    for (i = 0; i < NCOMMANDS; i ++) {
  100ca8:	ff 45 f4             	incl   -0xc(%ebp)
  100cab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cae:	83 f8 02             	cmp    $0x2,%eax
  100cb1:	76 9e                	jbe    100c51 <runcmd+0x39>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100cb3:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100cb6:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cba:	c7 04 24 5b 39 10 00 	movl   $0x10395b,(%esp)
  100cc1:	e8 cd f5 ff ff       	call   100293 <cprintf>
    return 0;
  100cc6:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100ccb:	83 c4 64             	add    $0x64,%esp
  100cce:	5b                   	pop    %ebx
  100ccf:	5d                   	pop    %ebp
  100cd0:	c3                   	ret    

00100cd1 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100cd1:	f3 0f 1e fb          	endbr32 
  100cd5:	55                   	push   %ebp
  100cd6:	89 e5                	mov    %esp,%ebp
  100cd8:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100cdb:	c7 04 24 74 39 10 00 	movl   $0x103974,(%esp)
  100ce2:	e8 ac f5 ff ff       	call   100293 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100ce7:	c7 04 24 9c 39 10 00 	movl   $0x10399c,(%esp)
  100cee:	e8 a0 f5 ff ff       	call   100293 <cprintf>

    if (tf != NULL) {
  100cf3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100cf7:	74 0b                	je     100d04 <kmonitor+0x33>
        print_trapframe(tf);
  100cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  100cfc:	89 04 24             	mov    %eax,(%esp)
  100cff:	e8 fb 0d 00 00       	call   101aff <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100d04:	c7 04 24 c1 39 10 00 	movl   $0x1039c1,(%esp)
  100d0b:	e8 36 f6 ff ff       	call   100346 <readline>
  100d10:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100d13:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100d17:	74 eb                	je     100d04 <kmonitor+0x33>
            if (runcmd(buf, tf) < 0) {
  100d19:	8b 45 08             	mov    0x8(%ebp),%eax
  100d1c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d20:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d23:	89 04 24             	mov    %eax,(%esp)
  100d26:	e8 ed fe ff ff       	call   100c18 <runcmd>
  100d2b:	85 c0                	test   %eax,%eax
  100d2d:	78 02                	js     100d31 <kmonitor+0x60>
        if ((buf = readline("K> ")) != NULL) {
  100d2f:	eb d3                	jmp    100d04 <kmonitor+0x33>
                break;
  100d31:	90                   	nop
            }
        }
    }
}
  100d32:	90                   	nop
  100d33:	c9                   	leave  
  100d34:	c3                   	ret    

00100d35 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100d35:	f3 0f 1e fb          	endbr32 
  100d39:	55                   	push   %ebp
  100d3a:	89 e5                	mov    %esp,%ebp
  100d3c:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100d3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100d46:	eb 3d                	jmp    100d85 <mon_help+0x50>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100d48:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d4b:	89 d0                	mov    %edx,%eax
  100d4d:	01 c0                	add    %eax,%eax
  100d4f:	01 d0                	add    %edx,%eax
  100d51:	c1 e0 02             	shl    $0x2,%eax
  100d54:	05 04 f0 10 00       	add    $0x10f004,%eax
  100d59:	8b 08                	mov    (%eax),%ecx
  100d5b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d5e:	89 d0                	mov    %edx,%eax
  100d60:	01 c0                	add    %eax,%eax
  100d62:	01 d0                	add    %edx,%eax
  100d64:	c1 e0 02             	shl    $0x2,%eax
  100d67:	05 00 f0 10 00       	add    $0x10f000,%eax
  100d6c:	8b 00                	mov    (%eax),%eax
  100d6e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100d72:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d76:	c7 04 24 c5 39 10 00 	movl   $0x1039c5,(%esp)
  100d7d:	e8 11 f5 ff ff       	call   100293 <cprintf>
    for (i = 0; i < NCOMMANDS; i ++) {
  100d82:	ff 45 f4             	incl   -0xc(%ebp)
  100d85:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d88:	83 f8 02             	cmp    $0x2,%eax
  100d8b:	76 bb                	jbe    100d48 <mon_help+0x13>
    }
    return 0;
  100d8d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d92:	c9                   	leave  
  100d93:	c3                   	ret    

00100d94 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100d94:	f3 0f 1e fb          	endbr32 
  100d98:	55                   	push   %ebp
  100d99:	89 e5                	mov    %esp,%ebp
  100d9b:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100d9e:	e8 b3 fb ff ff       	call   100956 <print_kerninfo>
    return 0;
  100da3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100da8:	c9                   	leave  
  100da9:	c3                   	ret    

00100daa <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100daa:	f3 0f 1e fb          	endbr32 
  100dae:	55                   	push   %ebp
  100daf:	89 e5                	mov    %esp,%ebp
  100db1:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100db4:	e8 ef fc ff ff       	call   100aa8 <print_stackframe>
    return 0;
  100db9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100dbe:	c9                   	leave  
  100dbf:	c3                   	ret    

00100dc0 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100dc0:	f3 0f 1e fb          	endbr32 
  100dc4:	55                   	push   %ebp
  100dc5:	89 e5                	mov    %esp,%ebp
  100dc7:	83 ec 28             	sub    $0x28,%esp
  100dca:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100dd0:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dd4:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100dd8:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100ddc:	ee                   	out    %al,(%dx)
}
  100ddd:	90                   	nop
  100dde:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100de4:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100de8:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100dec:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100df0:	ee                   	out    %al,(%dx)
}
  100df1:	90                   	nop
  100df2:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100df8:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dfc:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100e00:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100e04:	ee                   	out    %al,(%dx)
}
  100e05:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100e06:	c7 05 08 09 11 00 00 	movl   $0x0,0x110908
  100e0d:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100e10:	c7 04 24 ce 39 10 00 	movl   $0x1039ce,(%esp)
  100e17:	e8 77 f4 ff ff       	call   100293 <cprintf>
    pic_enable(IRQ_TIMER);
  100e1c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100e23:	e8 31 09 00 00       	call   101759 <pic_enable>
}
  100e28:	90                   	nop
  100e29:	c9                   	leave  
  100e2a:	c3                   	ret    

00100e2b <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100e2b:	f3 0f 1e fb          	endbr32 
  100e2f:	55                   	push   %ebp
  100e30:	89 e5                	mov    %esp,%ebp
  100e32:	83 ec 10             	sub    $0x10,%esp
  100e35:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e3b:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e3f:	89 c2                	mov    %eax,%edx
  100e41:	ec                   	in     (%dx),%al
  100e42:	88 45 f1             	mov    %al,-0xf(%ebp)
  100e45:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e4b:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e4f:	89 c2                	mov    %eax,%edx
  100e51:	ec                   	in     (%dx),%al
  100e52:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e55:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e5b:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e5f:	89 c2                	mov    %eax,%edx
  100e61:	ec                   	in     (%dx),%al
  100e62:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e65:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100e6b:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e6f:	89 c2                	mov    %eax,%edx
  100e71:	ec                   	in     (%dx),%al
  100e72:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e75:	90                   	nop
  100e76:	c9                   	leave  
  100e77:	c3                   	ret    

00100e78 <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100e78:	f3 0f 1e fb          	endbr32 
  100e7c:	55                   	push   %ebp
  100e7d:	89 e5                	mov    %esp,%ebp
  100e7f:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100e82:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100e89:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e8c:	0f b7 00             	movzwl (%eax),%eax
  100e8f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100e93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e96:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100e9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e9e:	0f b7 00             	movzwl (%eax),%eax
  100ea1:	0f b7 c0             	movzwl %ax,%eax
  100ea4:	3d 5a a5 00 00       	cmp    $0xa55a,%eax
  100ea9:	74 12                	je     100ebd <cga_init+0x45>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100eab:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100eb2:	66 c7 05 66 fe 10 00 	movw   $0x3b4,0x10fe66
  100eb9:	b4 03 
  100ebb:	eb 13                	jmp    100ed0 <cga_init+0x58>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100ebd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ec0:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100ec4:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100ec7:	66 c7 05 66 fe 10 00 	movw   $0x3d4,0x10fe66
  100ece:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100ed0:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100ed7:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100edb:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100edf:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100ee3:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100ee7:	ee                   	out    %al,(%dx)
}
  100ee8:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100ee9:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100ef0:	40                   	inc    %eax
  100ef1:	0f b7 c0             	movzwl %ax,%eax
  100ef4:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ef8:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  100efc:	89 c2                	mov    %eax,%edx
  100efe:	ec                   	in     (%dx),%al
  100eff:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  100f02:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f06:	0f b6 c0             	movzbl %al,%eax
  100f09:	c1 e0 08             	shl    $0x8,%eax
  100f0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100f0f:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f16:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100f1a:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f1e:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f22:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f26:	ee                   	out    %al,(%dx)
}
  100f27:	90                   	nop
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100f28:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f2f:	40                   	inc    %eax
  100f30:	0f b7 c0             	movzwl %ax,%eax
  100f33:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f37:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100f3b:	89 c2                	mov    %eax,%edx
  100f3d:	ec                   	in     (%dx),%al
  100f3e:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  100f41:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f45:	0f b6 c0             	movzbl %al,%eax
  100f48:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100f4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f4e:	a3 60 fe 10 00       	mov    %eax,0x10fe60
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100f53:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f56:	0f b7 c0             	movzwl %ax,%eax
  100f59:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
}
  100f5f:	90                   	nop
  100f60:	c9                   	leave  
  100f61:	c3                   	ret    

00100f62 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f62:	f3 0f 1e fb          	endbr32 
  100f66:	55                   	push   %ebp
  100f67:	89 e5                	mov    %esp,%ebp
  100f69:	83 ec 48             	sub    $0x48,%esp
  100f6c:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  100f72:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f76:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  100f7a:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100f7e:	ee                   	out    %al,(%dx)
}
  100f7f:	90                   	nop
  100f80:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  100f86:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f8a:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  100f8e:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100f92:	ee                   	out    %al,(%dx)
}
  100f93:	90                   	nop
  100f94:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  100f9a:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f9e:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  100fa2:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100fa6:	ee                   	out    %al,(%dx)
}
  100fa7:	90                   	nop
  100fa8:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100fae:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fb2:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100fb6:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100fba:	ee                   	out    %al,(%dx)
}
  100fbb:	90                   	nop
  100fbc:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  100fc2:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fc6:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100fca:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100fce:	ee                   	out    %al,(%dx)
}
  100fcf:	90                   	nop
  100fd0:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  100fd6:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fda:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100fde:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100fe2:	ee                   	out    %al,(%dx)
}
  100fe3:	90                   	nop
  100fe4:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100fea:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fee:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100ff2:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100ff6:	ee                   	out    %al,(%dx)
}
  100ff7:	90                   	nop
  100ff8:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ffe:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  101002:	89 c2                	mov    %eax,%edx
  101004:	ec                   	in     (%dx),%al
  101005:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  101008:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  10100c:	3c ff                	cmp    $0xff,%al
  10100e:	0f 95 c0             	setne  %al
  101011:	0f b6 c0             	movzbl %al,%eax
  101014:	a3 68 fe 10 00       	mov    %eax,0x10fe68
  101019:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10101f:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  101023:	89 c2                	mov    %eax,%edx
  101025:	ec                   	in     (%dx),%al
  101026:	88 45 f1             	mov    %al,-0xf(%ebp)
  101029:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  10102f:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101033:	89 c2                	mov    %eax,%edx
  101035:	ec                   	in     (%dx),%al
  101036:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  101039:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  10103e:	85 c0                	test   %eax,%eax
  101040:	74 0c                	je     10104e <serial_init+0xec>
        pic_enable(IRQ_COM1);
  101042:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  101049:	e8 0b 07 00 00       	call   101759 <pic_enable>
    }
}
  10104e:	90                   	nop
  10104f:	c9                   	leave  
  101050:	c3                   	ret    

00101051 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  101051:	f3 0f 1e fb          	endbr32 
  101055:	55                   	push   %ebp
  101056:	89 e5                	mov    %esp,%ebp
  101058:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  10105b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101062:	eb 08                	jmp    10106c <lpt_putc_sub+0x1b>
        delay();
  101064:	e8 c2 fd ff ff       	call   100e2b <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101069:	ff 45 fc             	incl   -0x4(%ebp)
  10106c:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  101072:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101076:	89 c2                	mov    %eax,%edx
  101078:	ec                   	in     (%dx),%al
  101079:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10107c:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101080:	84 c0                	test   %al,%al
  101082:	78 09                	js     10108d <lpt_putc_sub+0x3c>
  101084:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10108b:	7e d7                	jle    101064 <lpt_putc_sub+0x13>
    }
    outb(LPTPORT + 0, c);
  10108d:	8b 45 08             	mov    0x8(%ebp),%eax
  101090:	0f b6 c0             	movzbl %al,%eax
  101093:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  101099:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10109c:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1010a0:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1010a4:	ee                   	out    %al,(%dx)
}
  1010a5:	90                   	nop
  1010a6:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  1010ac:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010b0:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1010b4:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1010b8:	ee                   	out    %al,(%dx)
}
  1010b9:	90                   	nop
  1010ba:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  1010c0:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010c4:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1010c8:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1010cc:	ee                   	out    %al,(%dx)
}
  1010cd:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  1010ce:	90                   	nop
  1010cf:	c9                   	leave  
  1010d0:	c3                   	ret    

001010d1 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  1010d1:	f3 0f 1e fb          	endbr32 
  1010d5:	55                   	push   %ebp
  1010d6:	89 e5                	mov    %esp,%ebp
  1010d8:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1010db:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1010df:	74 0d                	je     1010ee <lpt_putc+0x1d>
        lpt_putc_sub(c);
  1010e1:	8b 45 08             	mov    0x8(%ebp),%eax
  1010e4:	89 04 24             	mov    %eax,(%esp)
  1010e7:	e8 65 ff ff ff       	call   101051 <lpt_putc_sub>
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  1010ec:	eb 24                	jmp    101112 <lpt_putc+0x41>
        lpt_putc_sub('\b');
  1010ee:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010f5:	e8 57 ff ff ff       	call   101051 <lpt_putc_sub>
        lpt_putc_sub(' ');
  1010fa:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101101:	e8 4b ff ff ff       	call   101051 <lpt_putc_sub>
        lpt_putc_sub('\b');
  101106:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10110d:	e8 3f ff ff ff       	call   101051 <lpt_putc_sub>
}
  101112:	90                   	nop
  101113:	c9                   	leave  
  101114:	c3                   	ret    

00101115 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101115:	f3 0f 1e fb          	endbr32 
  101119:	55                   	push   %ebp
  10111a:	89 e5                	mov    %esp,%ebp
  10111c:	53                   	push   %ebx
  10111d:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  101120:	8b 45 08             	mov    0x8(%ebp),%eax
  101123:	25 00 ff ff ff       	and    $0xffffff00,%eax
  101128:	85 c0                	test   %eax,%eax
  10112a:	75 07                	jne    101133 <cga_putc+0x1e>
        c |= 0x0700;
  10112c:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  101133:	8b 45 08             	mov    0x8(%ebp),%eax
  101136:	0f b6 c0             	movzbl %al,%eax
  101139:	83 f8 0d             	cmp    $0xd,%eax
  10113c:	74 72                	je     1011b0 <cga_putc+0x9b>
  10113e:	83 f8 0d             	cmp    $0xd,%eax
  101141:	0f 8f a3 00 00 00    	jg     1011ea <cga_putc+0xd5>
  101147:	83 f8 08             	cmp    $0x8,%eax
  10114a:	74 0a                	je     101156 <cga_putc+0x41>
  10114c:	83 f8 0a             	cmp    $0xa,%eax
  10114f:	74 4c                	je     10119d <cga_putc+0x88>
  101151:	e9 94 00 00 00       	jmp    1011ea <cga_putc+0xd5>
    case '\b':
        if (crt_pos > 0) {
  101156:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10115d:	85 c0                	test   %eax,%eax
  10115f:	0f 84 af 00 00 00    	je     101214 <cga_putc+0xff>
            crt_pos --;
  101165:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10116c:	48                   	dec    %eax
  10116d:	0f b7 c0             	movzwl %ax,%eax
  101170:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101176:	8b 45 08             	mov    0x8(%ebp),%eax
  101179:	98                   	cwtl   
  10117a:	25 00 ff ff ff       	and    $0xffffff00,%eax
  10117f:	98                   	cwtl   
  101180:	83 c8 20             	or     $0x20,%eax
  101183:	98                   	cwtl   
  101184:	8b 15 60 fe 10 00    	mov    0x10fe60,%edx
  10118a:	0f b7 0d 64 fe 10 00 	movzwl 0x10fe64,%ecx
  101191:	01 c9                	add    %ecx,%ecx
  101193:	01 ca                	add    %ecx,%edx
  101195:	0f b7 c0             	movzwl %ax,%eax
  101198:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  10119b:	eb 77                	jmp    101214 <cga_putc+0xff>
    case '\n':
        crt_pos += CRT_COLS;
  10119d:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1011a4:	83 c0 50             	add    $0x50,%eax
  1011a7:	0f b7 c0             	movzwl %ax,%eax
  1011aa:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  1011b0:	0f b7 1d 64 fe 10 00 	movzwl 0x10fe64,%ebx
  1011b7:	0f b7 0d 64 fe 10 00 	movzwl 0x10fe64,%ecx
  1011be:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  1011c3:	89 c8                	mov    %ecx,%eax
  1011c5:	f7 e2                	mul    %edx
  1011c7:	c1 ea 06             	shr    $0x6,%edx
  1011ca:	89 d0                	mov    %edx,%eax
  1011cc:	c1 e0 02             	shl    $0x2,%eax
  1011cf:	01 d0                	add    %edx,%eax
  1011d1:	c1 e0 04             	shl    $0x4,%eax
  1011d4:	29 c1                	sub    %eax,%ecx
  1011d6:	89 c8                	mov    %ecx,%eax
  1011d8:	0f b7 c0             	movzwl %ax,%eax
  1011db:	29 c3                	sub    %eax,%ebx
  1011dd:	89 d8                	mov    %ebx,%eax
  1011df:	0f b7 c0             	movzwl %ax,%eax
  1011e2:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
        break;
  1011e8:	eb 2b                	jmp    101215 <cga_putc+0x100>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1011ea:	8b 0d 60 fe 10 00    	mov    0x10fe60,%ecx
  1011f0:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1011f7:	8d 50 01             	lea    0x1(%eax),%edx
  1011fa:	0f b7 d2             	movzwl %dx,%edx
  1011fd:	66 89 15 64 fe 10 00 	mov    %dx,0x10fe64
  101204:	01 c0                	add    %eax,%eax
  101206:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  101209:	8b 45 08             	mov    0x8(%ebp),%eax
  10120c:	0f b7 c0             	movzwl %ax,%eax
  10120f:	66 89 02             	mov    %ax,(%edx)
        break;
  101212:	eb 01                	jmp    101215 <cga_putc+0x100>
        break;
  101214:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101215:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10121c:	3d cf 07 00 00       	cmp    $0x7cf,%eax
  101221:	76 5d                	jbe    101280 <cga_putc+0x16b>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101223:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101228:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  10122e:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101233:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  10123a:	00 
  10123b:	89 54 24 04          	mov    %edx,0x4(%esp)
  10123f:	89 04 24             	mov    %eax,(%esp)
  101242:	e8 7d 1c 00 00       	call   102ec4 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101247:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  10124e:	eb 14                	jmp    101264 <cga_putc+0x14f>
            crt_buf[i] = 0x0700 | ' ';
  101250:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101255:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101258:	01 d2                	add    %edx,%edx
  10125a:	01 d0                	add    %edx,%eax
  10125c:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101261:	ff 45 f4             	incl   -0xc(%ebp)
  101264:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  10126b:	7e e3                	jle    101250 <cga_putc+0x13b>
        }
        crt_pos -= CRT_COLS;
  10126d:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101274:	83 e8 50             	sub    $0x50,%eax
  101277:	0f b7 c0             	movzwl %ax,%eax
  10127a:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101280:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  101287:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  10128b:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10128f:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101293:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101297:	ee                   	out    %al,(%dx)
}
  101298:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
  101299:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1012a0:	c1 e8 08             	shr    $0x8,%eax
  1012a3:	0f b7 c0             	movzwl %ax,%eax
  1012a6:	0f b6 c0             	movzbl %al,%eax
  1012a9:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  1012b0:	42                   	inc    %edx
  1012b1:	0f b7 d2             	movzwl %dx,%edx
  1012b4:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  1012b8:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012bb:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1012bf:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1012c3:	ee                   	out    %al,(%dx)
}
  1012c4:	90                   	nop
    outb(addr_6845, 15);
  1012c5:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  1012cc:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1012d0:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012d4:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1012d8:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1012dc:	ee                   	out    %al,(%dx)
}
  1012dd:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
  1012de:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1012e5:	0f b6 c0             	movzbl %al,%eax
  1012e8:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  1012ef:	42                   	inc    %edx
  1012f0:	0f b7 d2             	movzwl %dx,%edx
  1012f3:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  1012f7:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012fa:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1012fe:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101302:	ee                   	out    %al,(%dx)
}
  101303:	90                   	nop
}
  101304:	90                   	nop
  101305:	83 c4 34             	add    $0x34,%esp
  101308:	5b                   	pop    %ebx
  101309:	5d                   	pop    %ebp
  10130a:	c3                   	ret    

0010130b <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  10130b:	f3 0f 1e fb          	endbr32 
  10130f:	55                   	push   %ebp
  101310:	89 e5                	mov    %esp,%ebp
  101312:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101315:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10131c:	eb 08                	jmp    101326 <serial_putc_sub+0x1b>
        delay();
  10131e:	e8 08 fb ff ff       	call   100e2b <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101323:	ff 45 fc             	incl   -0x4(%ebp)
  101326:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10132c:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101330:	89 c2                	mov    %eax,%edx
  101332:	ec                   	in     (%dx),%al
  101333:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101336:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10133a:	0f b6 c0             	movzbl %al,%eax
  10133d:	83 e0 20             	and    $0x20,%eax
  101340:	85 c0                	test   %eax,%eax
  101342:	75 09                	jne    10134d <serial_putc_sub+0x42>
  101344:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10134b:	7e d1                	jle    10131e <serial_putc_sub+0x13>
    }
    outb(COM1 + COM_TX, c);
  10134d:	8b 45 08             	mov    0x8(%ebp),%eax
  101350:	0f b6 c0             	movzbl %al,%eax
  101353:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101359:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10135c:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101360:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101364:	ee                   	out    %al,(%dx)
}
  101365:	90                   	nop
}
  101366:	90                   	nop
  101367:	c9                   	leave  
  101368:	c3                   	ret    

00101369 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  101369:	f3 0f 1e fb          	endbr32 
  10136d:	55                   	push   %ebp
  10136e:	89 e5                	mov    %esp,%ebp
  101370:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  101373:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101377:	74 0d                	je     101386 <serial_putc+0x1d>
        serial_putc_sub(c);
  101379:	8b 45 08             	mov    0x8(%ebp),%eax
  10137c:	89 04 24             	mov    %eax,(%esp)
  10137f:	e8 87 ff ff ff       	call   10130b <serial_putc_sub>
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  101384:	eb 24                	jmp    1013aa <serial_putc+0x41>
        serial_putc_sub('\b');
  101386:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10138d:	e8 79 ff ff ff       	call   10130b <serial_putc_sub>
        serial_putc_sub(' ');
  101392:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101399:	e8 6d ff ff ff       	call   10130b <serial_putc_sub>
        serial_putc_sub('\b');
  10139e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1013a5:	e8 61 ff ff ff       	call   10130b <serial_putc_sub>
}
  1013aa:	90                   	nop
  1013ab:	c9                   	leave  
  1013ac:	c3                   	ret    

001013ad <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  1013ad:	f3 0f 1e fb          	endbr32 
  1013b1:	55                   	push   %ebp
  1013b2:	89 e5                	mov    %esp,%ebp
  1013b4:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  1013b7:	eb 33                	jmp    1013ec <cons_intr+0x3f>
        if (c != 0) {
  1013b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1013bd:	74 2d                	je     1013ec <cons_intr+0x3f>
            cons.buf[cons.wpos ++] = c;
  1013bf:	a1 84 00 11 00       	mov    0x110084,%eax
  1013c4:	8d 50 01             	lea    0x1(%eax),%edx
  1013c7:	89 15 84 00 11 00    	mov    %edx,0x110084
  1013cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013d0:	88 90 80 fe 10 00    	mov    %dl,0x10fe80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  1013d6:	a1 84 00 11 00       	mov    0x110084,%eax
  1013db:	3d 00 02 00 00       	cmp    $0x200,%eax
  1013e0:	75 0a                	jne    1013ec <cons_intr+0x3f>
                cons.wpos = 0;
  1013e2:	c7 05 84 00 11 00 00 	movl   $0x0,0x110084
  1013e9:	00 00 00 
    while ((c = (*proc)()) != -1) {
  1013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  1013ef:	ff d0                	call   *%eax
  1013f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1013f4:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1013f8:	75 bf                	jne    1013b9 <cons_intr+0xc>
            }
        }
    }
}
  1013fa:	90                   	nop
  1013fb:	90                   	nop
  1013fc:	c9                   	leave  
  1013fd:	c3                   	ret    

001013fe <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1013fe:	f3 0f 1e fb          	endbr32 
  101402:	55                   	push   %ebp
  101403:	89 e5                	mov    %esp,%ebp
  101405:	83 ec 10             	sub    $0x10,%esp
  101408:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10140e:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101412:	89 c2                	mov    %eax,%edx
  101414:	ec                   	in     (%dx),%al
  101415:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101418:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  10141c:	0f b6 c0             	movzbl %al,%eax
  10141f:	83 e0 01             	and    $0x1,%eax
  101422:	85 c0                	test   %eax,%eax
  101424:	75 07                	jne    10142d <serial_proc_data+0x2f>
        return -1;
  101426:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10142b:	eb 2a                	jmp    101457 <serial_proc_data+0x59>
  10142d:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101433:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101437:	89 c2                	mov    %eax,%edx
  101439:	ec                   	in     (%dx),%al
  10143a:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  10143d:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  101441:	0f b6 c0             	movzbl %al,%eax
  101444:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101447:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  10144b:	75 07                	jne    101454 <serial_proc_data+0x56>
        c = '\b';
  10144d:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  101454:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101457:	c9                   	leave  
  101458:	c3                   	ret    

00101459 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  101459:	f3 0f 1e fb          	endbr32 
  10145d:	55                   	push   %ebp
  10145e:	89 e5                	mov    %esp,%ebp
  101460:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  101463:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101468:	85 c0                	test   %eax,%eax
  10146a:	74 0c                	je     101478 <serial_intr+0x1f>
        cons_intr(serial_proc_data);
  10146c:	c7 04 24 fe 13 10 00 	movl   $0x1013fe,(%esp)
  101473:	e8 35 ff ff ff       	call   1013ad <cons_intr>
    }
}
  101478:	90                   	nop
  101479:	c9                   	leave  
  10147a:	c3                   	ret    

0010147b <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  10147b:	f3 0f 1e fb          	endbr32 
  10147f:	55                   	push   %ebp
  101480:	89 e5                	mov    %esp,%ebp
  101482:	83 ec 38             	sub    $0x38,%esp
  101485:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10148b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10148e:	89 c2                	mov    %eax,%edx
  101490:	ec                   	in     (%dx),%al
  101491:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  101494:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  101498:	0f b6 c0             	movzbl %al,%eax
  10149b:	83 e0 01             	and    $0x1,%eax
  10149e:	85 c0                	test   %eax,%eax
  1014a0:	75 0a                	jne    1014ac <kbd_proc_data+0x31>
        return -1;
  1014a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1014a7:	e9 56 01 00 00       	jmp    101602 <kbd_proc_data+0x187>
  1014ac:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1014b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1014b5:	89 c2                	mov    %eax,%edx
  1014b7:	ec                   	in     (%dx),%al
  1014b8:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1014bb:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1014bf:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1014c2:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1014c6:	75 17                	jne    1014df <kbd_proc_data+0x64>
        // E0 escape character
        shift |= E0ESC;
  1014c8:	a1 88 00 11 00       	mov    0x110088,%eax
  1014cd:	83 c8 40             	or     $0x40,%eax
  1014d0:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  1014d5:	b8 00 00 00 00       	mov    $0x0,%eax
  1014da:	e9 23 01 00 00       	jmp    101602 <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  1014df:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014e3:	84 c0                	test   %al,%al
  1014e5:	79 45                	jns    10152c <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1014e7:	a1 88 00 11 00       	mov    0x110088,%eax
  1014ec:	83 e0 40             	and    $0x40,%eax
  1014ef:	85 c0                	test   %eax,%eax
  1014f1:	75 08                	jne    1014fb <kbd_proc_data+0x80>
  1014f3:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014f7:	24 7f                	and    $0x7f,%al
  1014f9:	eb 04                	jmp    1014ff <kbd_proc_data+0x84>
  1014fb:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014ff:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  101502:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101506:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  10150d:	0c 40                	or     $0x40,%al
  10150f:	0f b6 c0             	movzbl %al,%eax
  101512:	f7 d0                	not    %eax
  101514:	89 c2                	mov    %eax,%edx
  101516:	a1 88 00 11 00       	mov    0x110088,%eax
  10151b:	21 d0                	and    %edx,%eax
  10151d:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  101522:	b8 00 00 00 00       	mov    $0x0,%eax
  101527:	e9 d6 00 00 00       	jmp    101602 <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  10152c:	a1 88 00 11 00       	mov    0x110088,%eax
  101531:	83 e0 40             	and    $0x40,%eax
  101534:	85 c0                	test   %eax,%eax
  101536:	74 11                	je     101549 <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101538:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  10153c:	a1 88 00 11 00       	mov    0x110088,%eax
  101541:	83 e0 bf             	and    $0xffffffbf,%eax
  101544:	a3 88 00 11 00       	mov    %eax,0x110088
    }

    shift |= shiftcode[data];
  101549:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10154d:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  101554:	0f b6 d0             	movzbl %al,%edx
  101557:	a1 88 00 11 00       	mov    0x110088,%eax
  10155c:	09 d0                	or     %edx,%eax
  10155e:	a3 88 00 11 00       	mov    %eax,0x110088
    shift ^= togglecode[data];
  101563:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101567:	0f b6 80 40 f1 10 00 	movzbl 0x10f140(%eax),%eax
  10156e:	0f b6 d0             	movzbl %al,%edx
  101571:	a1 88 00 11 00       	mov    0x110088,%eax
  101576:	31 d0                	xor    %edx,%eax
  101578:	a3 88 00 11 00       	mov    %eax,0x110088

    c = charcode[shift & (CTL | SHIFT)][data];
  10157d:	a1 88 00 11 00       	mov    0x110088,%eax
  101582:	83 e0 03             	and    $0x3,%eax
  101585:	8b 14 85 40 f5 10 00 	mov    0x10f540(,%eax,4),%edx
  10158c:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101590:	01 d0                	add    %edx,%eax
  101592:	0f b6 00             	movzbl (%eax),%eax
  101595:	0f b6 c0             	movzbl %al,%eax
  101598:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  10159b:	a1 88 00 11 00       	mov    0x110088,%eax
  1015a0:	83 e0 08             	and    $0x8,%eax
  1015a3:	85 c0                	test   %eax,%eax
  1015a5:	74 22                	je     1015c9 <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  1015a7:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1015ab:	7e 0c                	jle    1015b9 <kbd_proc_data+0x13e>
  1015ad:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1015b1:	7f 06                	jg     1015b9 <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  1015b3:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1015b7:	eb 10                	jmp    1015c9 <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  1015b9:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1015bd:	7e 0a                	jle    1015c9 <kbd_proc_data+0x14e>
  1015bf:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1015c3:	7f 04                	jg     1015c9 <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  1015c5:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1015c9:	a1 88 00 11 00       	mov    0x110088,%eax
  1015ce:	f7 d0                	not    %eax
  1015d0:	83 e0 06             	and    $0x6,%eax
  1015d3:	85 c0                	test   %eax,%eax
  1015d5:	75 28                	jne    1015ff <kbd_proc_data+0x184>
  1015d7:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1015de:	75 1f                	jne    1015ff <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  1015e0:	c7 04 24 e9 39 10 00 	movl   $0x1039e9,(%esp)
  1015e7:	e8 a7 ec ff ff       	call   100293 <cprintf>
  1015ec:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1015f2:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1015f6:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  1015fa:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1015fd:	ee                   	out    %al,(%dx)
}
  1015fe:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  1015ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  101602:	c9                   	leave  
  101603:	c3                   	ret    

00101604 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  101604:	f3 0f 1e fb          	endbr32 
  101608:	55                   	push   %ebp
  101609:	89 e5                	mov    %esp,%ebp
  10160b:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  10160e:	c7 04 24 7b 14 10 00 	movl   $0x10147b,(%esp)
  101615:	e8 93 fd ff ff       	call   1013ad <cons_intr>
}
  10161a:	90                   	nop
  10161b:	c9                   	leave  
  10161c:	c3                   	ret    

0010161d <kbd_init>:

static void
kbd_init(void) {
  10161d:	f3 0f 1e fb          	endbr32 
  101621:	55                   	push   %ebp
  101622:	89 e5                	mov    %esp,%ebp
  101624:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  101627:	e8 d8 ff ff ff       	call   101604 <kbd_intr>
    pic_enable(IRQ_KBD);
  10162c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  101633:	e8 21 01 00 00       	call   101759 <pic_enable>
}
  101638:	90                   	nop
  101639:	c9                   	leave  
  10163a:	c3                   	ret    

0010163b <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  10163b:	f3 0f 1e fb          	endbr32 
  10163f:	55                   	push   %ebp
  101640:	89 e5                	mov    %esp,%ebp
  101642:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  101645:	e8 2e f8 ff ff       	call   100e78 <cga_init>
    serial_init();
  10164a:	e8 13 f9 ff ff       	call   100f62 <serial_init>
    kbd_init();
  10164f:	e8 c9 ff ff ff       	call   10161d <kbd_init>
    if (!serial_exists) {
  101654:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101659:	85 c0                	test   %eax,%eax
  10165b:	75 0c                	jne    101669 <cons_init+0x2e>
        cprintf("serial port does not exist!!\n");
  10165d:	c7 04 24 f5 39 10 00 	movl   $0x1039f5,(%esp)
  101664:	e8 2a ec ff ff       	call   100293 <cprintf>
    }
}
  101669:	90                   	nop
  10166a:	c9                   	leave  
  10166b:	c3                   	ret    

0010166c <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  10166c:	f3 0f 1e fb          	endbr32 
  101670:	55                   	push   %ebp
  101671:	89 e5                	mov    %esp,%ebp
  101673:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  101676:	8b 45 08             	mov    0x8(%ebp),%eax
  101679:	89 04 24             	mov    %eax,(%esp)
  10167c:	e8 50 fa ff ff       	call   1010d1 <lpt_putc>
    cga_putc(c);
  101681:	8b 45 08             	mov    0x8(%ebp),%eax
  101684:	89 04 24             	mov    %eax,(%esp)
  101687:	e8 89 fa ff ff       	call   101115 <cga_putc>
    serial_putc(c);
  10168c:	8b 45 08             	mov    0x8(%ebp),%eax
  10168f:	89 04 24             	mov    %eax,(%esp)
  101692:	e8 d2 fc ff ff       	call   101369 <serial_putc>
}
  101697:	90                   	nop
  101698:	c9                   	leave  
  101699:	c3                   	ret    

0010169a <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  10169a:	f3 0f 1e fb          	endbr32 
  10169e:	55                   	push   %ebp
  10169f:	89 e5                	mov    %esp,%ebp
  1016a1:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1016a4:	e8 b0 fd ff ff       	call   101459 <serial_intr>
    kbd_intr();
  1016a9:	e8 56 ff ff ff       	call   101604 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1016ae:	8b 15 80 00 11 00    	mov    0x110080,%edx
  1016b4:	a1 84 00 11 00       	mov    0x110084,%eax
  1016b9:	39 c2                	cmp    %eax,%edx
  1016bb:	74 36                	je     1016f3 <cons_getc+0x59>
        c = cons.buf[cons.rpos ++];
  1016bd:	a1 80 00 11 00       	mov    0x110080,%eax
  1016c2:	8d 50 01             	lea    0x1(%eax),%edx
  1016c5:	89 15 80 00 11 00    	mov    %edx,0x110080
  1016cb:	0f b6 80 80 fe 10 00 	movzbl 0x10fe80(%eax),%eax
  1016d2:	0f b6 c0             	movzbl %al,%eax
  1016d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  1016d8:	a1 80 00 11 00       	mov    0x110080,%eax
  1016dd:	3d 00 02 00 00       	cmp    $0x200,%eax
  1016e2:	75 0a                	jne    1016ee <cons_getc+0x54>
            cons.rpos = 0;
  1016e4:	c7 05 80 00 11 00 00 	movl   $0x0,0x110080
  1016eb:	00 00 00 
        }
        return c;
  1016ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1016f1:	eb 05                	jmp    1016f8 <cons_getc+0x5e>
    }
    return 0;
  1016f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1016f8:	c9                   	leave  
  1016f9:	c3                   	ret    

001016fa <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  1016fa:	f3 0f 1e fb          	endbr32 
  1016fe:	55                   	push   %ebp
  1016ff:	89 e5                	mov    %esp,%ebp
  101701:	83 ec 14             	sub    $0x14,%esp
  101704:	8b 45 08             	mov    0x8(%ebp),%eax
  101707:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  10170b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10170e:	66 a3 50 f5 10 00    	mov    %ax,0x10f550
    if (did_init) {
  101714:	a1 8c 00 11 00       	mov    0x11008c,%eax
  101719:	85 c0                	test   %eax,%eax
  10171b:	74 39                	je     101756 <pic_setmask+0x5c>
        outb(IO_PIC1 + 1, mask);
  10171d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101720:	0f b6 c0             	movzbl %al,%eax
  101723:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  101729:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10172c:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101730:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101734:	ee                   	out    %al,(%dx)
}
  101735:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
  101736:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10173a:	c1 e8 08             	shr    $0x8,%eax
  10173d:	0f b7 c0             	movzwl %ax,%eax
  101740:	0f b6 c0             	movzbl %al,%eax
  101743:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  101749:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10174c:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101750:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101754:	ee                   	out    %al,(%dx)
}
  101755:	90                   	nop
    }
}
  101756:	90                   	nop
  101757:	c9                   	leave  
  101758:	c3                   	ret    

00101759 <pic_enable>:

void
pic_enable(unsigned int irq) {
  101759:	f3 0f 1e fb          	endbr32 
  10175d:	55                   	push   %ebp
  10175e:	89 e5                	mov    %esp,%ebp
  101760:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  101763:	8b 45 08             	mov    0x8(%ebp),%eax
  101766:	ba 01 00 00 00       	mov    $0x1,%edx
  10176b:	88 c1                	mov    %al,%cl
  10176d:	d3 e2                	shl    %cl,%edx
  10176f:	89 d0                	mov    %edx,%eax
  101771:	98                   	cwtl   
  101772:	f7 d0                	not    %eax
  101774:	0f bf d0             	movswl %ax,%edx
  101777:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  10177e:	98                   	cwtl   
  10177f:	21 d0                	and    %edx,%eax
  101781:	98                   	cwtl   
  101782:	0f b7 c0             	movzwl %ax,%eax
  101785:	89 04 24             	mov    %eax,(%esp)
  101788:	e8 6d ff ff ff       	call   1016fa <pic_setmask>
}
  10178d:	90                   	nop
  10178e:	c9                   	leave  
  10178f:	c3                   	ret    

00101790 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  101790:	f3 0f 1e fb          	endbr32 
  101794:	55                   	push   %ebp
  101795:	89 e5                	mov    %esp,%ebp
  101797:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  10179a:	c7 05 8c 00 11 00 01 	movl   $0x1,0x11008c
  1017a1:	00 00 00 
  1017a4:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  1017aa:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017ae:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1017b2:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1017b6:	ee                   	out    %al,(%dx)
}
  1017b7:	90                   	nop
  1017b8:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  1017be:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017c2:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1017c6:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1017ca:	ee                   	out    %al,(%dx)
}
  1017cb:	90                   	nop
  1017cc:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1017d2:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017d6:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017da:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017de:	ee                   	out    %al,(%dx)
}
  1017df:	90                   	nop
  1017e0:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  1017e6:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017ea:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1017ee:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1017f2:	ee                   	out    %al,(%dx)
}
  1017f3:	90                   	nop
  1017f4:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  1017fa:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017fe:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101802:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101806:	ee                   	out    %al,(%dx)
}
  101807:	90                   	nop
  101808:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  10180e:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101812:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101816:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  10181a:	ee                   	out    %al,(%dx)
}
  10181b:	90                   	nop
  10181c:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  101822:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101826:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  10182a:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  10182e:	ee                   	out    %al,(%dx)
}
  10182f:	90                   	nop
  101830:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  101836:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10183a:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10183e:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101842:	ee                   	out    %al,(%dx)
}
  101843:	90                   	nop
  101844:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  10184a:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10184e:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101852:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101856:	ee                   	out    %al,(%dx)
}
  101857:	90                   	nop
  101858:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  10185e:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101862:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101866:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10186a:	ee                   	out    %al,(%dx)
}
  10186b:	90                   	nop
  10186c:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101872:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101876:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10187a:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10187e:	ee                   	out    %al,(%dx)
}
  10187f:	90                   	nop
  101880:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101886:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10188a:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10188e:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101892:	ee                   	out    %al,(%dx)
}
  101893:	90                   	nop
  101894:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  10189a:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10189e:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1018a2:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1018a6:	ee                   	out    %al,(%dx)
}
  1018a7:	90                   	nop
  1018a8:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  1018ae:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018b2:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1018b6:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1018ba:	ee                   	out    %al,(%dx)
}
  1018bb:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1018bc:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  1018c3:	3d ff ff 00 00       	cmp    $0xffff,%eax
  1018c8:	74 0f                	je     1018d9 <pic_init+0x149>
        pic_setmask(irq_mask);
  1018ca:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  1018d1:	89 04 24             	mov    %eax,(%esp)
  1018d4:	e8 21 fe ff ff       	call   1016fa <pic_setmask>
    }
}
  1018d9:	90                   	nop
  1018da:	c9                   	leave  
  1018db:	c3                   	ret    

001018dc <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1018dc:	f3 0f 1e fb          	endbr32 
  1018e0:	55                   	push   %ebp
  1018e1:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1018e3:	fb                   	sti    
}
  1018e4:	90                   	nop
    sti();
}
  1018e5:	90                   	nop
  1018e6:	5d                   	pop    %ebp
  1018e7:	c3                   	ret    

001018e8 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1018e8:	f3 0f 1e fb          	endbr32 
  1018ec:	55                   	push   %ebp
  1018ed:	89 e5                	mov    %esp,%ebp

static inline void
cli(void) {
    asm volatile ("cli");
  1018ef:	fa                   	cli    
}
  1018f0:	90                   	nop
    cli();
}
  1018f1:	90                   	nop
  1018f2:	5d                   	pop    %ebp
  1018f3:	c3                   	ret    

001018f4 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  1018f4:	f3 0f 1e fb          	endbr32 
  1018f8:	55                   	push   %ebp
  1018f9:	89 e5                	mov    %esp,%ebp
  1018fb:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  1018fe:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  101905:	00 
  101906:	c7 04 24 20 3a 10 00 	movl   $0x103a20,(%esp)
  10190d:	e8 81 e9 ff ff       	call   100293 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
  101912:	c7 04 24 2a 3a 10 00 	movl   $0x103a2a,(%esp)
  101919:	e8 75 e9 ff ff       	call   100293 <cprintf>
    panic("EOT: kernel seems ok.");
  10191e:	c7 44 24 08 38 3a 10 	movl   $0x103a38,0x8(%esp)
  101925:	00 
  101926:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
  10192d:	00 
  10192e:	c7 04 24 4e 3a 10 00 	movl   $0x103a4e,(%esp)
  101935:	e8 c5 ea ff ff       	call   1003ff <__panic>

0010193a <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  10193a:	f3 0f 1e fb          	endbr32 
  10193e:	55                   	push   %ebp
  10193f:	89 e5                	mov    %esp,%ebp
  101941:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[]; 
    int i;
    for(i=0; i<sizeof(idt)/sizeof(struct gatedesc);i++){
  101944:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10194b:	e9 c4 00 00 00       	jmp    101a14 <idt_init+0xda>
        //�ɸ��ļ���֪�������ж��������жϴ���������ַ��������__vectors�����У��������е�i��Ԫ�ض�Ӧ��i���ж��������жϴ���������ַ��
        //�������ļ���ͷ��֪���жϴ�����������.text�����ݡ���ˣ��жϴ��������Ķ�ѡ���Ӽ�.text�Ķ�ѡ����GD_KTEXT��
        //��kern / mm / pmm.c��֪.text�Ķλ�ַΪ0������жϴ���������ַ��ƫ�����������ַ������
        //dpl  DPL_KERNEL
        // ����T_SWITCH_TOK��DPL_USER��������DPL_KERNEL��
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);//��ʼ��idt
  101950:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101953:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  10195a:	0f b7 d0             	movzwl %ax,%edx
  10195d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101960:	66 89 14 c5 a0 00 11 	mov    %dx,0x1100a0(,%eax,8)
  101967:	00 
  101968:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10196b:	66 c7 04 c5 a2 00 11 	movw   $0x8,0x1100a2(,%eax,8)
  101972:	00 08 00 
  101975:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101978:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  10197f:	00 
  101980:	80 e2 e0             	and    $0xe0,%dl
  101983:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  10198a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10198d:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  101994:	00 
  101995:	80 e2 1f             	and    $0x1f,%dl
  101998:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  10199f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019a2:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019a9:	00 
  1019aa:	80 e2 f0             	and    $0xf0,%dl
  1019ad:	80 ca 0e             	or     $0xe,%dl
  1019b0:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019ba:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019c1:	00 
  1019c2:	80 e2 ef             	and    $0xef,%dl
  1019c5:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019cf:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019d6:	00 
  1019d7:	80 e2 9f             	and    $0x9f,%dl
  1019da:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019e4:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019eb:	00 
  1019ec:	80 ca 80             	or     $0x80,%dl
  1019ef:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019f9:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  101a00:	c1 e8 10             	shr    $0x10,%eax
  101a03:	0f b7 d0             	movzwl %ax,%edx
  101a06:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a09:	66 89 14 c5 a6 00 11 	mov    %dx,0x1100a6(,%eax,8)
  101a10:	00 
    for(i=0; i<sizeof(idt)/sizeof(struct gatedesc);i++){
  101a11:	ff 45 fc             	incl   -0x4(%ebp)
  101a14:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a17:	3d ff 00 00 00       	cmp    $0xff,%eax
  101a1c:	0f 86 2e ff ff ff    	jbe    101950 <idt_init+0x16>
    } 
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);//��Ϊ�ڷ����ж�ʱ��������Ҫ���û�̬�л����ں�̬�����Ե����������û�̬����
  101a22:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101a27:	0f b7 c0             	movzwl %ax,%eax
  101a2a:	66 a3 68 04 11 00    	mov    %ax,0x110468
  101a30:	66 c7 05 6a 04 11 00 	movw   $0x8,0x11046a
  101a37:	08 00 
  101a39:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a40:	24 e0                	and    $0xe0,%al
  101a42:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a47:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a4e:	24 1f                	and    $0x1f,%al
  101a50:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a55:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a5c:	24 f0                	and    $0xf0,%al
  101a5e:	0c 0e                	or     $0xe,%al
  101a60:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a65:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a6c:	24 ef                	and    $0xef,%al
  101a6e:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a73:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a7a:	0c 60                	or     $0x60,%al
  101a7c:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a81:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a88:	0c 80                	or     $0x80,%al
  101a8a:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a8f:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101a94:	c1 e8 10             	shr    $0x10,%eax
  101a97:	0f b7 c0             	movzwl %ax,%eax
  101a9a:	66 a3 6e 04 11 00    	mov    %ax,0x11046e
  101aa0:	c7 45 f8 60 f5 10 00 	movl   $0x10f560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101aa7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101aaa:	0f 01 18             	lidtl  (%eax)
}
  101aad:	90                   	nop
    lidt(&idt_pd);
}
  101aae:	90                   	nop
  101aaf:	c9                   	leave  
  101ab0:	c3                   	ret    

00101ab1 <trapname>:

static const char *
trapname(int trapno) {
  101ab1:	f3 0f 1e fb          	endbr32 
  101ab5:	55                   	push   %ebp
  101ab6:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101ab8:	8b 45 08             	mov    0x8(%ebp),%eax
  101abb:	83 f8 13             	cmp    $0x13,%eax
  101abe:	77 0c                	ja     101acc <trapname+0x1b>
        return excnames[trapno];
  101ac0:	8b 45 08             	mov    0x8(%ebp),%eax
  101ac3:	8b 04 85 a0 3d 10 00 	mov    0x103da0(,%eax,4),%eax
  101aca:	eb 18                	jmp    101ae4 <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101acc:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101ad0:	7e 0d                	jle    101adf <trapname+0x2e>
  101ad2:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101ad6:	7f 07                	jg     101adf <trapname+0x2e>
        return "Hardware Interrupt";
  101ad8:	b8 5f 3a 10 00       	mov    $0x103a5f,%eax
  101add:	eb 05                	jmp    101ae4 <trapname+0x33>
    }
    return "(unknown trap)";
  101adf:	b8 72 3a 10 00       	mov    $0x103a72,%eax
}
  101ae4:	5d                   	pop    %ebp
  101ae5:	c3                   	ret    

00101ae6 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101ae6:	f3 0f 1e fb          	endbr32 
  101aea:	55                   	push   %ebp
  101aeb:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101aed:	8b 45 08             	mov    0x8(%ebp),%eax
  101af0:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101af4:	83 f8 08             	cmp    $0x8,%eax
  101af7:	0f 94 c0             	sete   %al
  101afa:	0f b6 c0             	movzbl %al,%eax
}
  101afd:	5d                   	pop    %ebp
  101afe:	c3                   	ret    

00101aff <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101aff:	f3 0f 1e fb          	endbr32 
  101b03:	55                   	push   %ebp
  101b04:	89 e5                	mov    %esp,%ebp
  101b06:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101b09:	8b 45 08             	mov    0x8(%ebp),%eax
  101b0c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b10:	c7 04 24 b3 3a 10 00 	movl   $0x103ab3,(%esp)
  101b17:	e8 77 e7 ff ff       	call   100293 <cprintf>
    print_regs(&tf->tf_regs);
  101b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  101b1f:	89 04 24             	mov    %eax,(%esp)
  101b22:	e8 8d 01 00 00       	call   101cb4 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101b27:	8b 45 08             	mov    0x8(%ebp),%eax
  101b2a:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101b2e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b32:	c7 04 24 c4 3a 10 00 	movl   $0x103ac4,(%esp)
  101b39:	e8 55 e7 ff ff       	call   100293 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  101b41:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101b45:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b49:	c7 04 24 d7 3a 10 00 	movl   $0x103ad7,(%esp)
  101b50:	e8 3e e7 ff ff       	call   100293 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101b55:	8b 45 08             	mov    0x8(%ebp),%eax
  101b58:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101b5c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b60:	c7 04 24 ea 3a 10 00 	movl   $0x103aea,(%esp)
  101b67:	e8 27 e7 ff ff       	call   100293 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  101b6f:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101b73:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b77:	c7 04 24 fd 3a 10 00 	movl   $0x103afd,(%esp)
  101b7e:	e8 10 e7 ff ff       	call   100293 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101b83:	8b 45 08             	mov    0x8(%ebp),%eax
  101b86:	8b 40 30             	mov    0x30(%eax),%eax
  101b89:	89 04 24             	mov    %eax,(%esp)
  101b8c:	e8 20 ff ff ff       	call   101ab1 <trapname>
  101b91:	8b 55 08             	mov    0x8(%ebp),%edx
  101b94:	8b 52 30             	mov    0x30(%edx),%edx
  101b97:	89 44 24 08          	mov    %eax,0x8(%esp)
  101b9b:	89 54 24 04          	mov    %edx,0x4(%esp)
  101b9f:	c7 04 24 10 3b 10 00 	movl   $0x103b10,(%esp)
  101ba6:	e8 e8 e6 ff ff       	call   100293 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101bab:	8b 45 08             	mov    0x8(%ebp),%eax
  101bae:	8b 40 34             	mov    0x34(%eax),%eax
  101bb1:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bb5:	c7 04 24 22 3b 10 00 	movl   $0x103b22,(%esp)
  101bbc:	e8 d2 e6 ff ff       	call   100293 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  101bc4:	8b 40 38             	mov    0x38(%eax),%eax
  101bc7:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bcb:	c7 04 24 31 3b 10 00 	movl   $0x103b31,(%esp)
  101bd2:	e8 bc e6 ff ff       	call   100293 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  101bda:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101bde:	89 44 24 04          	mov    %eax,0x4(%esp)
  101be2:	c7 04 24 40 3b 10 00 	movl   $0x103b40,(%esp)
  101be9:	e8 a5 e6 ff ff       	call   100293 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101bee:	8b 45 08             	mov    0x8(%ebp),%eax
  101bf1:	8b 40 40             	mov    0x40(%eax),%eax
  101bf4:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bf8:	c7 04 24 53 3b 10 00 	movl   $0x103b53,(%esp)
  101bff:	e8 8f e6 ff ff       	call   100293 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c04:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101c0b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101c12:	eb 3d                	jmp    101c51 <print_trapframe+0x152>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101c14:	8b 45 08             	mov    0x8(%ebp),%eax
  101c17:	8b 50 40             	mov    0x40(%eax),%edx
  101c1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c1d:	21 d0                	and    %edx,%eax
  101c1f:	85 c0                	test   %eax,%eax
  101c21:	74 28                	je     101c4b <print_trapframe+0x14c>
  101c23:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c26:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c2d:	85 c0                	test   %eax,%eax
  101c2f:	74 1a                	je     101c4b <print_trapframe+0x14c>
            cprintf("%s,", IA32flags[i]);
  101c31:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c34:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c3b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c3f:	c7 04 24 62 3b 10 00 	movl   $0x103b62,(%esp)
  101c46:	e8 48 e6 ff ff       	call   100293 <cprintf>
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c4b:	ff 45 f4             	incl   -0xc(%ebp)
  101c4e:	d1 65 f0             	shll   -0x10(%ebp)
  101c51:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c54:	83 f8 17             	cmp    $0x17,%eax
  101c57:	76 bb                	jbe    101c14 <print_trapframe+0x115>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101c59:	8b 45 08             	mov    0x8(%ebp),%eax
  101c5c:	8b 40 40             	mov    0x40(%eax),%eax
  101c5f:	c1 e8 0c             	shr    $0xc,%eax
  101c62:	83 e0 03             	and    $0x3,%eax
  101c65:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c69:	c7 04 24 66 3b 10 00 	movl   $0x103b66,(%esp)
  101c70:	e8 1e e6 ff ff       	call   100293 <cprintf>

    if (!trap_in_kernel(tf)) {
  101c75:	8b 45 08             	mov    0x8(%ebp),%eax
  101c78:	89 04 24             	mov    %eax,(%esp)
  101c7b:	e8 66 fe ff ff       	call   101ae6 <trap_in_kernel>
  101c80:	85 c0                	test   %eax,%eax
  101c82:	75 2d                	jne    101cb1 <print_trapframe+0x1b2>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101c84:	8b 45 08             	mov    0x8(%ebp),%eax
  101c87:	8b 40 44             	mov    0x44(%eax),%eax
  101c8a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c8e:	c7 04 24 6f 3b 10 00 	movl   $0x103b6f,(%esp)
  101c95:	e8 f9 e5 ff ff       	call   100293 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  101c9d:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101ca1:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ca5:	c7 04 24 7e 3b 10 00 	movl   $0x103b7e,(%esp)
  101cac:	e8 e2 e5 ff ff       	call   100293 <cprintf>
    }
}
  101cb1:	90                   	nop
  101cb2:	c9                   	leave  
  101cb3:	c3                   	ret    

00101cb4 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101cb4:	f3 0f 1e fb          	endbr32 
  101cb8:	55                   	push   %ebp
  101cb9:	89 e5                	mov    %esp,%ebp
  101cbb:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  101cc1:	8b 00                	mov    (%eax),%eax
  101cc3:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cc7:	c7 04 24 91 3b 10 00 	movl   $0x103b91,(%esp)
  101cce:	e8 c0 e5 ff ff       	call   100293 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  101cd6:	8b 40 04             	mov    0x4(%eax),%eax
  101cd9:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cdd:	c7 04 24 a0 3b 10 00 	movl   $0x103ba0,(%esp)
  101ce4:	e8 aa e5 ff ff       	call   100293 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101ce9:	8b 45 08             	mov    0x8(%ebp),%eax
  101cec:	8b 40 08             	mov    0x8(%eax),%eax
  101cef:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cf3:	c7 04 24 af 3b 10 00 	movl   $0x103baf,(%esp)
  101cfa:	e8 94 e5 ff ff       	call   100293 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101cff:	8b 45 08             	mov    0x8(%ebp),%eax
  101d02:	8b 40 0c             	mov    0xc(%eax),%eax
  101d05:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d09:	c7 04 24 be 3b 10 00 	movl   $0x103bbe,(%esp)
  101d10:	e8 7e e5 ff ff       	call   100293 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101d15:	8b 45 08             	mov    0x8(%ebp),%eax
  101d18:	8b 40 10             	mov    0x10(%eax),%eax
  101d1b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d1f:	c7 04 24 cd 3b 10 00 	movl   $0x103bcd,(%esp)
  101d26:	e8 68 e5 ff ff       	call   100293 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  101d2e:	8b 40 14             	mov    0x14(%eax),%eax
  101d31:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d35:	c7 04 24 dc 3b 10 00 	movl   $0x103bdc,(%esp)
  101d3c:	e8 52 e5 ff ff       	call   100293 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101d41:	8b 45 08             	mov    0x8(%ebp),%eax
  101d44:	8b 40 18             	mov    0x18(%eax),%eax
  101d47:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d4b:	c7 04 24 eb 3b 10 00 	movl   $0x103beb,(%esp)
  101d52:	e8 3c e5 ff ff       	call   100293 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101d57:	8b 45 08             	mov    0x8(%ebp),%eax
  101d5a:	8b 40 1c             	mov    0x1c(%eax),%eax
  101d5d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d61:	c7 04 24 fa 3b 10 00 	movl   $0x103bfa,(%esp)
  101d68:	e8 26 e5 ff ff       	call   100293 <cprintf>
}
  101d6d:	90                   	nop
  101d6e:	c9                   	leave  
  101d6f:	c3                   	ret    

00101d70 <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101d70:	f3 0f 1e fb          	endbr32 
  101d74:	55                   	push   %ebp
  101d75:	89 e5                	mov    %esp,%ebp
  101d77:	83 ec 28             	sub    $0x28,%esp
    char c;

    switch (tf->tf_trapno) {
  101d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  101d7d:	8b 40 30             	mov    0x30(%eax),%eax
  101d80:	83 f8 79             	cmp    $0x79,%eax
  101d83:	0f 84 44 01 00 00    	je     101ecd <trap_dispatch+0x15d>
  101d89:	83 f8 79             	cmp    $0x79,%eax
  101d8c:	0f 87 7c 01 00 00    	ja     101f0e <trap_dispatch+0x19e>
  101d92:	83 f8 78             	cmp    $0x78,%eax
  101d95:	0f 84 d0 00 00 00    	je     101e6b <trap_dispatch+0xfb>
  101d9b:	83 f8 78             	cmp    $0x78,%eax
  101d9e:	0f 87 6a 01 00 00    	ja     101f0e <trap_dispatch+0x19e>
  101da4:	83 f8 2f             	cmp    $0x2f,%eax
  101da7:	0f 87 61 01 00 00    	ja     101f0e <trap_dispatch+0x19e>
  101dad:	83 f8 2e             	cmp    $0x2e,%eax
  101db0:	0f 83 8d 01 00 00    	jae    101f43 <trap_dispatch+0x1d3>
  101db6:	83 f8 24             	cmp    $0x24,%eax
  101db9:	74 5e                	je     101e19 <trap_dispatch+0xa9>
  101dbb:	83 f8 24             	cmp    $0x24,%eax
  101dbe:	0f 87 4a 01 00 00    	ja     101f0e <trap_dispatch+0x19e>
  101dc4:	83 f8 20             	cmp    $0x20,%eax
  101dc7:	74 0a                	je     101dd3 <trap_dispatch+0x63>
  101dc9:	83 f8 21             	cmp    $0x21,%eax
  101dcc:	74 74                	je     101e42 <trap_dispatch+0xd2>
  101dce:	e9 3b 01 00 00       	jmp    101f0e <trap_dispatch+0x19e>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks++;
  101dd3:	a1 08 09 11 00       	mov    0x110908,%eax
  101dd8:	40                   	inc    %eax
  101dd9:	a3 08 09 11 00       	mov    %eax,0x110908
        if(ticks%TICK_NUM==0){
  101dde:	8b 0d 08 09 11 00    	mov    0x110908,%ecx
  101de4:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101de9:	89 c8                	mov    %ecx,%eax
  101deb:	f7 e2                	mul    %edx
  101ded:	c1 ea 05             	shr    $0x5,%edx
  101df0:	89 d0                	mov    %edx,%eax
  101df2:	c1 e0 02             	shl    $0x2,%eax
  101df5:	01 d0                	add    %edx,%eax
  101df7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  101dfe:	01 d0                	add    %edx,%eax
  101e00:	c1 e0 02             	shl    $0x2,%eax
  101e03:	29 c1                	sub    %eax,%ecx
  101e05:	89 ca                	mov    %ecx,%edx
  101e07:	85 d2                	test   %edx,%edx
  101e09:	0f 85 37 01 00 00    	jne    101f46 <trap_dispatch+0x1d6>
            print_ticks();
  101e0f:	e8 e0 fa ff ff       	call   1018f4 <print_ticks>
        }
        break;
  101e14:	e9 2d 01 00 00       	jmp    101f46 <trap_dispatch+0x1d6>
    case IRQ_OFFSET + IRQ_COM1://���жϺ���IRQ_OFFSET + IRQ_COM1 Ϊ�����жϣ�����ʾ�յ����ַ�
        c = cons_getc();
  101e19:	e8 7c f8 ff ff       	call   10169a <cons_getc>
  101e1e:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101e21:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e25:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e29:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e31:	c7 04 24 09 3c 10 00 	movl   $0x103c09,(%esp)
  101e38:	e8 56 e4 ff ff       	call   100293 <cprintf>
        break;
  101e3d:	e9 0b 01 00 00       	jmp    101f4d <trap_dispatch+0x1dd>
    case IRQ_OFFSET + IRQ_KBD://���жϺ���IRQ_OFFSET + IRQ_KBD Ϊ �����жϣ�����ʾ�յ����ַ�
        c = cons_getc();
  101e42:	e8 53 f8 ff ff       	call   10169a <cons_getc>
  101e47:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101e4a:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e4e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e52:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e56:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e5a:	c7 04 24 1b 3c 10 00 	movl   $0x103c1b,(%esp)
  101e61:	e8 2d e4 ff ff       	call   100293 <cprintf>
        break;
  101e66:	e9 e2 00 00 00       	jmp    101f4d <trap_dispatch+0x1dd>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    //tf trapframe  ջ֡�ṹ��
    case T_SWITCH_TOU://�ںˡ��û�
        //panic("T_SWITCH_USER ??\n");
    	if (tf->tf_cs != USER_CS) {
  101e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  101e6e:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e72:	83 f8 1b             	cmp    $0x1b,%eax
  101e75:	0f 84 ce 00 00 00    	je     101f49 <trap_dispatch+0x1d9>
            tf->tf_cs = USER_CS;
  101e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  101e7e:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
            tf->tf_ds = tf->tf_es = tf->tf_ss = USER_DS;
  101e84:	8b 45 08             	mov    0x8(%ebp),%eax
  101e87:	66 c7 40 48 23 00    	movw   $0x23,0x48(%eax)
  101e8d:	8b 45 08             	mov    0x8(%ebp),%eax
  101e90:	0f b7 50 48          	movzwl 0x48(%eax),%edx
  101e94:	8b 45 08             	mov    0x8(%ebp),%eax
  101e97:	66 89 50 28          	mov    %dx,0x28(%eax)
  101e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  101e9e:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101ea2:	8b 45 08             	mov    0x8(%ebp),%eax
  101ea5:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_esp += 4;
  101ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  101eac:	8b 40 44             	mov    0x44(%eax),%eax
  101eaf:	8d 50 04             	lea    0x4(%eax),%edx
  101eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  101eb5:	89 50 44             	mov    %edx,0x44(%eax)
            tf->tf_eflags |= FL_IOPL_MASK;
  101eb8:	8b 45 08             	mov    0x8(%ebp),%eax
  101ebb:	8b 40 40             	mov    0x40(%eax),%eax
  101ebe:	0d 00 30 00 00       	or     $0x3000,%eax
  101ec3:	89 c2                	mov    %eax,%edx
  101ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  101ec8:	89 50 40             	mov    %edx,0x40(%eax)
        }
        break;
  101ecb:	eb 7c                	jmp    101f49 <trap_dispatch+0x1d9>
    case T_SWITCH_TOK://�û����ں�
        //panic("T_SWITCH_KERNEL ??\n");
        if (tf->tf_cs != KERNEL_CS) {
  101ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  101ed0:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ed4:	83 f8 08             	cmp    $0x8,%eax
  101ed7:	74 73                	je     101f4c <trap_dispatch+0x1dc>
            tf->tf_cs = KERNEL_CS;
  101ed9:	8b 45 08             	mov    0x8(%ebp),%eax
  101edc:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  101ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  101ee5:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101eeb:	8b 45 08             	mov    0x8(%ebp),%eax
  101eee:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101ef2:	8b 45 08             	mov    0x8(%ebp),%eax
  101ef5:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  101ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  101efc:	8b 40 40             	mov    0x40(%eax),%eax
  101eff:	25 ff cf ff ff       	and    $0xffffcfff,%eax
  101f04:	89 c2                	mov    %eax,%edx
  101f06:	8b 45 08             	mov    0x8(%ebp),%eax
  101f09:	89 50 40             	mov    %edx,0x40(%eax)
        }
        break;
  101f0c:	eb 3e                	jmp    101f4c <trap_dispatch+0x1dc>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101f0e:	8b 45 08             	mov    0x8(%ebp),%eax
  101f11:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101f15:	83 e0 03             	and    $0x3,%eax
  101f18:	85 c0                	test   %eax,%eax
  101f1a:	75 31                	jne    101f4d <trap_dispatch+0x1dd>
            print_trapframe(tf);
  101f1c:	8b 45 08             	mov    0x8(%ebp),%eax
  101f1f:	89 04 24             	mov    %eax,(%esp)
  101f22:	e8 d8 fb ff ff       	call   101aff <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101f27:	c7 44 24 08 2a 3c 10 	movl   $0x103c2a,0x8(%esp)
  101f2e:	00 
  101f2f:	c7 44 24 04 e6 00 00 	movl   $0xe6,0x4(%esp)
  101f36:	00 
  101f37:	c7 04 24 4e 3a 10 00 	movl   $0x103a4e,(%esp)
  101f3e:	e8 bc e4 ff ff       	call   1003ff <__panic>
        break;
  101f43:	90                   	nop
  101f44:	eb 07                	jmp    101f4d <trap_dispatch+0x1dd>
        break;
  101f46:	90                   	nop
  101f47:	eb 04                	jmp    101f4d <trap_dispatch+0x1dd>
        break;
  101f49:	90                   	nop
  101f4a:	eb 01                	jmp    101f4d <trap_dispatch+0x1dd>
        break;
  101f4c:	90                   	nop
        }
    }
}
  101f4d:	90                   	nop
  101f4e:	c9                   	leave  
  101f4f:	c3                   	ret    

00101f50 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101f50:	f3 0f 1e fb          	endbr32 
  101f54:	55                   	push   %ebp
  101f55:	89 e5                	mov    %esp,%ebp
  101f57:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101f5a:	8b 45 08             	mov    0x8(%ebp),%eax
  101f5d:	89 04 24             	mov    %eax,(%esp)
  101f60:	e8 0b fe ff ff       	call   101d70 <trap_dispatch>
}
  101f65:	90                   	nop
  101f66:	c9                   	leave  
  101f67:	c3                   	ret    

00101f68 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101f68:	6a 00                	push   $0x0
  pushl $0
  101f6a:	6a 00                	push   $0x0
  jmp __alltraps
  101f6c:	e9 69 0a 00 00       	jmp    1029da <__alltraps>

00101f71 <vector1>:
.globl vector1
vector1:
  pushl $0
  101f71:	6a 00                	push   $0x0
  pushl $1
  101f73:	6a 01                	push   $0x1
  jmp __alltraps
  101f75:	e9 60 0a 00 00       	jmp    1029da <__alltraps>

00101f7a <vector2>:
.globl vector2
vector2:
  pushl $0
  101f7a:	6a 00                	push   $0x0
  pushl $2
  101f7c:	6a 02                	push   $0x2
  jmp __alltraps
  101f7e:	e9 57 0a 00 00       	jmp    1029da <__alltraps>

00101f83 <vector3>:
.globl vector3
vector3:
  pushl $0
  101f83:	6a 00                	push   $0x0
  pushl $3
  101f85:	6a 03                	push   $0x3
  jmp __alltraps
  101f87:	e9 4e 0a 00 00       	jmp    1029da <__alltraps>

00101f8c <vector4>:
.globl vector4
vector4:
  pushl $0
  101f8c:	6a 00                	push   $0x0
  pushl $4
  101f8e:	6a 04                	push   $0x4
  jmp __alltraps
  101f90:	e9 45 0a 00 00       	jmp    1029da <__alltraps>

00101f95 <vector5>:
.globl vector5
vector5:
  pushl $0
  101f95:	6a 00                	push   $0x0
  pushl $5
  101f97:	6a 05                	push   $0x5
  jmp __alltraps
  101f99:	e9 3c 0a 00 00       	jmp    1029da <__alltraps>

00101f9e <vector6>:
.globl vector6
vector6:
  pushl $0
  101f9e:	6a 00                	push   $0x0
  pushl $6
  101fa0:	6a 06                	push   $0x6
  jmp __alltraps
  101fa2:	e9 33 0a 00 00       	jmp    1029da <__alltraps>

00101fa7 <vector7>:
.globl vector7
vector7:
  pushl $0
  101fa7:	6a 00                	push   $0x0
  pushl $7
  101fa9:	6a 07                	push   $0x7
  jmp __alltraps
  101fab:	e9 2a 0a 00 00       	jmp    1029da <__alltraps>

00101fb0 <vector8>:
.globl vector8
vector8:
  pushl $8
  101fb0:	6a 08                	push   $0x8
  jmp __alltraps
  101fb2:	e9 23 0a 00 00       	jmp    1029da <__alltraps>

00101fb7 <vector9>:
.globl vector9
vector9:
  pushl $0
  101fb7:	6a 00                	push   $0x0
  pushl $9
  101fb9:	6a 09                	push   $0x9
  jmp __alltraps
  101fbb:	e9 1a 0a 00 00       	jmp    1029da <__alltraps>

00101fc0 <vector10>:
.globl vector10
vector10:
  pushl $10
  101fc0:	6a 0a                	push   $0xa
  jmp __alltraps
  101fc2:	e9 13 0a 00 00       	jmp    1029da <__alltraps>

00101fc7 <vector11>:
.globl vector11
vector11:
  pushl $11
  101fc7:	6a 0b                	push   $0xb
  jmp __alltraps
  101fc9:	e9 0c 0a 00 00       	jmp    1029da <__alltraps>

00101fce <vector12>:
.globl vector12
vector12:
  pushl $12
  101fce:	6a 0c                	push   $0xc
  jmp __alltraps
  101fd0:	e9 05 0a 00 00       	jmp    1029da <__alltraps>

00101fd5 <vector13>:
.globl vector13
vector13:
  pushl $13
  101fd5:	6a 0d                	push   $0xd
  jmp __alltraps
  101fd7:	e9 fe 09 00 00       	jmp    1029da <__alltraps>

00101fdc <vector14>:
.globl vector14
vector14:
  pushl $14
  101fdc:	6a 0e                	push   $0xe
  jmp __alltraps
  101fde:	e9 f7 09 00 00       	jmp    1029da <__alltraps>

00101fe3 <vector15>:
.globl vector15
vector15:
  pushl $0
  101fe3:	6a 00                	push   $0x0
  pushl $15
  101fe5:	6a 0f                	push   $0xf
  jmp __alltraps
  101fe7:	e9 ee 09 00 00       	jmp    1029da <__alltraps>

00101fec <vector16>:
.globl vector16
vector16:
  pushl $0
  101fec:	6a 00                	push   $0x0
  pushl $16
  101fee:	6a 10                	push   $0x10
  jmp __alltraps
  101ff0:	e9 e5 09 00 00       	jmp    1029da <__alltraps>

00101ff5 <vector17>:
.globl vector17
vector17:
  pushl $17
  101ff5:	6a 11                	push   $0x11
  jmp __alltraps
  101ff7:	e9 de 09 00 00       	jmp    1029da <__alltraps>

00101ffc <vector18>:
.globl vector18
vector18:
  pushl $0
  101ffc:	6a 00                	push   $0x0
  pushl $18
  101ffe:	6a 12                	push   $0x12
  jmp __alltraps
  102000:	e9 d5 09 00 00       	jmp    1029da <__alltraps>

00102005 <vector19>:
.globl vector19
vector19:
  pushl $0
  102005:	6a 00                	push   $0x0
  pushl $19
  102007:	6a 13                	push   $0x13
  jmp __alltraps
  102009:	e9 cc 09 00 00       	jmp    1029da <__alltraps>

0010200e <vector20>:
.globl vector20
vector20:
  pushl $0
  10200e:	6a 00                	push   $0x0
  pushl $20
  102010:	6a 14                	push   $0x14
  jmp __alltraps
  102012:	e9 c3 09 00 00       	jmp    1029da <__alltraps>

00102017 <vector21>:
.globl vector21
vector21:
  pushl $0
  102017:	6a 00                	push   $0x0
  pushl $21
  102019:	6a 15                	push   $0x15
  jmp __alltraps
  10201b:	e9 ba 09 00 00       	jmp    1029da <__alltraps>

00102020 <vector22>:
.globl vector22
vector22:
  pushl $0
  102020:	6a 00                	push   $0x0
  pushl $22
  102022:	6a 16                	push   $0x16
  jmp __alltraps
  102024:	e9 b1 09 00 00       	jmp    1029da <__alltraps>

00102029 <vector23>:
.globl vector23
vector23:
  pushl $0
  102029:	6a 00                	push   $0x0
  pushl $23
  10202b:	6a 17                	push   $0x17
  jmp __alltraps
  10202d:	e9 a8 09 00 00       	jmp    1029da <__alltraps>

00102032 <vector24>:
.globl vector24
vector24:
  pushl $0
  102032:	6a 00                	push   $0x0
  pushl $24
  102034:	6a 18                	push   $0x18
  jmp __alltraps
  102036:	e9 9f 09 00 00       	jmp    1029da <__alltraps>

0010203b <vector25>:
.globl vector25
vector25:
  pushl $0
  10203b:	6a 00                	push   $0x0
  pushl $25
  10203d:	6a 19                	push   $0x19
  jmp __alltraps
  10203f:	e9 96 09 00 00       	jmp    1029da <__alltraps>

00102044 <vector26>:
.globl vector26
vector26:
  pushl $0
  102044:	6a 00                	push   $0x0
  pushl $26
  102046:	6a 1a                	push   $0x1a
  jmp __alltraps
  102048:	e9 8d 09 00 00       	jmp    1029da <__alltraps>

0010204d <vector27>:
.globl vector27
vector27:
  pushl $0
  10204d:	6a 00                	push   $0x0
  pushl $27
  10204f:	6a 1b                	push   $0x1b
  jmp __alltraps
  102051:	e9 84 09 00 00       	jmp    1029da <__alltraps>

00102056 <vector28>:
.globl vector28
vector28:
  pushl $0
  102056:	6a 00                	push   $0x0
  pushl $28
  102058:	6a 1c                	push   $0x1c
  jmp __alltraps
  10205a:	e9 7b 09 00 00       	jmp    1029da <__alltraps>

0010205f <vector29>:
.globl vector29
vector29:
  pushl $0
  10205f:	6a 00                	push   $0x0
  pushl $29
  102061:	6a 1d                	push   $0x1d
  jmp __alltraps
  102063:	e9 72 09 00 00       	jmp    1029da <__alltraps>

00102068 <vector30>:
.globl vector30
vector30:
  pushl $0
  102068:	6a 00                	push   $0x0
  pushl $30
  10206a:	6a 1e                	push   $0x1e
  jmp __alltraps
  10206c:	e9 69 09 00 00       	jmp    1029da <__alltraps>

00102071 <vector31>:
.globl vector31
vector31:
  pushl $0
  102071:	6a 00                	push   $0x0
  pushl $31
  102073:	6a 1f                	push   $0x1f
  jmp __alltraps
  102075:	e9 60 09 00 00       	jmp    1029da <__alltraps>

0010207a <vector32>:
.globl vector32
vector32:
  pushl $0
  10207a:	6a 00                	push   $0x0
  pushl $32
  10207c:	6a 20                	push   $0x20
  jmp __alltraps
  10207e:	e9 57 09 00 00       	jmp    1029da <__alltraps>

00102083 <vector33>:
.globl vector33
vector33:
  pushl $0
  102083:	6a 00                	push   $0x0
  pushl $33
  102085:	6a 21                	push   $0x21
  jmp __alltraps
  102087:	e9 4e 09 00 00       	jmp    1029da <__alltraps>

0010208c <vector34>:
.globl vector34
vector34:
  pushl $0
  10208c:	6a 00                	push   $0x0
  pushl $34
  10208e:	6a 22                	push   $0x22
  jmp __alltraps
  102090:	e9 45 09 00 00       	jmp    1029da <__alltraps>

00102095 <vector35>:
.globl vector35
vector35:
  pushl $0
  102095:	6a 00                	push   $0x0
  pushl $35
  102097:	6a 23                	push   $0x23
  jmp __alltraps
  102099:	e9 3c 09 00 00       	jmp    1029da <__alltraps>

0010209e <vector36>:
.globl vector36
vector36:
  pushl $0
  10209e:	6a 00                	push   $0x0
  pushl $36
  1020a0:	6a 24                	push   $0x24
  jmp __alltraps
  1020a2:	e9 33 09 00 00       	jmp    1029da <__alltraps>

001020a7 <vector37>:
.globl vector37
vector37:
  pushl $0
  1020a7:	6a 00                	push   $0x0
  pushl $37
  1020a9:	6a 25                	push   $0x25
  jmp __alltraps
  1020ab:	e9 2a 09 00 00       	jmp    1029da <__alltraps>

001020b0 <vector38>:
.globl vector38
vector38:
  pushl $0
  1020b0:	6a 00                	push   $0x0
  pushl $38
  1020b2:	6a 26                	push   $0x26
  jmp __alltraps
  1020b4:	e9 21 09 00 00       	jmp    1029da <__alltraps>

001020b9 <vector39>:
.globl vector39
vector39:
  pushl $0
  1020b9:	6a 00                	push   $0x0
  pushl $39
  1020bb:	6a 27                	push   $0x27
  jmp __alltraps
  1020bd:	e9 18 09 00 00       	jmp    1029da <__alltraps>

001020c2 <vector40>:
.globl vector40
vector40:
  pushl $0
  1020c2:	6a 00                	push   $0x0
  pushl $40
  1020c4:	6a 28                	push   $0x28
  jmp __alltraps
  1020c6:	e9 0f 09 00 00       	jmp    1029da <__alltraps>

001020cb <vector41>:
.globl vector41
vector41:
  pushl $0
  1020cb:	6a 00                	push   $0x0
  pushl $41
  1020cd:	6a 29                	push   $0x29
  jmp __alltraps
  1020cf:	e9 06 09 00 00       	jmp    1029da <__alltraps>

001020d4 <vector42>:
.globl vector42
vector42:
  pushl $0
  1020d4:	6a 00                	push   $0x0
  pushl $42
  1020d6:	6a 2a                	push   $0x2a
  jmp __alltraps
  1020d8:	e9 fd 08 00 00       	jmp    1029da <__alltraps>

001020dd <vector43>:
.globl vector43
vector43:
  pushl $0
  1020dd:	6a 00                	push   $0x0
  pushl $43
  1020df:	6a 2b                	push   $0x2b
  jmp __alltraps
  1020e1:	e9 f4 08 00 00       	jmp    1029da <__alltraps>

001020e6 <vector44>:
.globl vector44
vector44:
  pushl $0
  1020e6:	6a 00                	push   $0x0
  pushl $44
  1020e8:	6a 2c                	push   $0x2c
  jmp __alltraps
  1020ea:	e9 eb 08 00 00       	jmp    1029da <__alltraps>

001020ef <vector45>:
.globl vector45
vector45:
  pushl $0
  1020ef:	6a 00                	push   $0x0
  pushl $45
  1020f1:	6a 2d                	push   $0x2d
  jmp __alltraps
  1020f3:	e9 e2 08 00 00       	jmp    1029da <__alltraps>

001020f8 <vector46>:
.globl vector46
vector46:
  pushl $0
  1020f8:	6a 00                	push   $0x0
  pushl $46
  1020fa:	6a 2e                	push   $0x2e
  jmp __alltraps
  1020fc:	e9 d9 08 00 00       	jmp    1029da <__alltraps>

00102101 <vector47>:
.globl vector47
vector47:
  pushl $0
  102101:	6a 00                	push   $0x0
  pushl $47
  102103:	6a 2f                	push   $0x2f
  jmp __alltraps
  102105:	e9 d0 08 00 00       	jmp    1029da <__alltraps>

0010210a <vector48>:
.globl vector48
vector48:
  pushl $0
  10210a:	6a 00                	push   $0x0
  pushl $48
  10210c:	6a 30                	push   $0x30
  jmp __alltraps
  10210e:	e9 c7 08 00 00       	jmp    1029da <__alltraps>

00102113 <vector49>:
.globl vector49
vector49:
  pushl $0
  102113:	6a 00                	push   $0x0
  pushl $49
  102115:	6a 31                	push   $0x31
  jmp __alltraps
  102117:	e9 be 08 00 00       	jmp    1029da <__alltraps>

0010211c <vector50>:
.globl vector50
vector50:
  pushl $0
  10211c:	6a 00                	push   $0x0
  pushl $50
  10211e:	6a 32                	push   $0x32
  jmp __alltraps
  102120:	e9 b5 08 00 00       	jmp    1029da <__alltraps>

00102125 <vector51>:
.globl vector51
vector51:
  pushl $0
  102125:	6a 00                	push   $0x0
  pushl $51
  102127:	6a 33                	push   $0x33
  jmp __alltraps
  102129:	e9 ac 08 00 00       	jmp    1029da <__alltraps>

0010212e <vector52>:
.globl vector52
vector52:
  pushl $0
  10212e:	6a 00                	push   $0x0
  pushl $52
  102130:	6a 34                	push   $0x34
  jmp __alltraps
  102132:	e9 a3 08 00 00       	jmp    1029da <__alltraps>

00102137 <vector53>:
.globl vector53
vector53:
  pushl $0
  102137:	6a 00                	push   $0x0
  pushl $53
  102139:	6a 35                	push   $0x35
  jmp __alltraps
  10213b:	e9 9a 08 00 00       	jmp    1029da <__alltraps>

00102140 <vector54>:
.globl vector54
vector54:
  pushl $0
  102140:	6a 00                	push   $0x0
  pushl $54
  102142:	6a 36                	push   $0x36
  jmp __alltraps
  102144:	e9 91 08 00 00       	jmp    1029da <__alltraps>

00102149 <vector55>:
.globl vector55
vector55:
  pushl $0
  102149:	6a 00                	push   $0x0
  pushl $55
  10214b:	6a 37                	push   $0x37
  jmp __alltraps
  10214d:	e9 88 08 00 00       	jmp    1029da <__alltraps>

00102152 <vector56>:
.globl vector56
vector56:
  pushl $0
  102152:	6a 00                	push   $0x0
  pushl $56
  102154:	6a 38                	push   $0x38
  jmp __alltraps
  102156:	e9 7f 08 00 00       	jmp    1029da <__alltraps>

0010215b <vector57>:
.globl vector57
vector57:
  pushl $0
  10215b:	6a 00                	push   $0x0
  pushl $57
  10215d:	6a 39                	push   $0x39
  jmp __alltraps
  10215f:	e9 76 08 00 00       	jmp    1029da <__alltraps>

00102164 <vector58>:
.globl vector58
vector58:
  pushl $0
  102164:	6a 00                	push   $0x0
  pushl $58
  102166:	6a 3a                	push   $0x3a
  jmp __alltraps
  102168:	e9 6d 08 00 00       	jmp    1029da <__alltraps>

0010216d <vector59>:
.globl vector59
vector59:
  pushl $0
  10216d:	6a 00                	push   $0x0
  pushl $59
  10216f:	6a 3b                	push   $0x3b
  jmp __alltraps
  102171:	e9 64 08 00 00       	jmp    1029da <__alltraps>

00102176 <vector60>:
.globl vector60
vector60:
  pushl $0
  102176:	6a 00                	push   $0x0
  pushl $60
  102178:	6a 3c                	push   $0x3c
  jmp __alltraps
  10217a:	e9 5b 08 00 00       	jmp    1029da <__alltraps>

0010217f <vector61>:
.globl vector61
vector61:
  pushl $0
  10217f:	6a 00                	push   $0x0
  pushl $61
  102181:	6a 3d                	push   $0x3d
  jmp __alltraps
  102183:	e9 52 08 00 00       	jmp    1029da <__alltraps>

00102188 <vector62>:
.globl vector62
vector62:
  pushl $0
  102188:	6a 00                	push   $0x0
  pushl $62
  10218a:	6a 3e                	push   $0x3e
  jmp __alltraps
  10218c:	e9 49 08 00 00       	jmp    1029da <__alltraps>

00102191 <vector63>:
.globl vector63
vector63:
  pushl $0
  102191:	6a 00                	push   $0x0
  pushl $63
  102193:	6a 3f                	push   $0x3f
  jmp __alltraps
  102195:	e9 40 08 00 00       	jmp    1029da <__alltraps>

0010219a <vector64>:
.globl vector64
vector64:
  pushl $0
  10219a:	6a 00                	push   $0x0
  pushl $64
  10219c:	6a 40                	push   $0x40
  jmp __alltraps
  10219e:	e9 37 08 00 00       	jmp    1029da <__alltraps>

001021a3 <vector65>:
.globl vector65
vector65:
  pushl $0
  1021a3:	6a 00                	push   $0x0
  pushl $65
  1021a5:	6a 41                	push   $0x41
  jmp __alltraps
  1021a7:	e9 2e 08 00 00       	jmp    1029da <__alltraps>

001021ac <vector66>:
.globl vector66
vector66:
  pushl $0
  1021ac:	6a 00                	push   $0x0
  pushl $66
  1021ae:	6a 42                	push   $0x42
  jmp __alltraps
  1021b0:	e9 25 08 00 00       	jmp    1029da <__alltraps>

001021b5 <vector67>:
.globl vector67
vector67:
  pushl $0
  1021b5:	6a 00                	push   $0x0
  pushl $67
  1021b7:	6a 43                	push   $0x43
  jmp __alltraps
  1021b9:	e9 1c 08 00 00       	jmp    1029da <__alltraps>

001021be <vector68>:
.globl vector68
vector68:
  pushl $0
  1021be:	6a 00                	push   $0x0
  pushl $68
  1021c0:	6a 44                	push   $0x44
  jmp __alltraps
  1021c2:	e9 13 08 00 00       	jmp    1029da <__alltraps>

001021c7 <vector69>:
.globl vector69
vector69:
  pushl $0
  1021c7:	6a 00                	push   $0x0
  pushl $69
  1021c9:	6a 45                	push   $0x45
  jmp __alltraps
  1021cb:	e9 0a 08 00 00       	jmp    1029da <__alltraps>

001021d0 <vector70>:
.globl vector70
vector70:
  pushl $0
  1021d0:	6a 00                	push   $0x0
  pushl $70
  1021d2:	6a 46                	push   $0x46
  jmp __alltraps
  1021d4:	e9 01 08 00 00       	jmp    1029da <__alltraps>

001021d9 <vector71>:
.globl vector71
vector71:
  pushl $0
  1021d9:	6a 00                	push   $0x0
  pushl $71
  1021db:	6a 47                	push   $0x47
  jmp __alltraps
  1021dd:	e9 f8 07 00 00       	jmp    1029da <__alltraps>

001021e2 <vector72>:
.globl vector72
vector72:
  pushl $0
  1021e2:	6a 00                	push   $0x0
  pushl $72
  1021e4:	6a 48                	push   $0x48
  jmp __alltraps
  1021e6:	e9 ef 07 00 00       	jmp    1029da <__alltraps>

001021eb <vector73>:
.globl vector73
vector73:
  pushl $0
  1021eb:	6a 00                	push   $0x0
  pushl $73
  1021ed:	6a 49                	push   $0x49
  jmp __alltraps
  1021ef:	e9 e6 07 00 00       	jmp    1029da <__alltraps>

001021f4 <vector74>:
.globl vector74
vector74:
  pushl $0
  1021f4:	6a 00                	push   $0x0
  pushl $74
  1021f6:	6a 4a                	push   $0x4a
  jmp __alltraps
  1021f8:	e9 dd 07 00 00       	jmp    1029da <__alltraps>

001021fd <vector75>:
.globl vector75
vector75:
  pushl $0
  1021fd:	6a 00                	push   $0x0
  pushl $75
  1021ff:	6a 4b                	push   $0x4b
  jmp __alltraps
  102201:	e9 d4 07 00 00       	jmp    1029da <__alltraps>

00102206 <vector76>:
.globl vector76
vector76:
  pushl $0
  102206:	6a 00                	push   $0x0
  pushl $76
  102208:	6a 4c                	push   $0x4c
  jmp __alltraps
  10220a:	e9 cb 07 00 00       	jmp    1029da <__alltraps>

0010220f <vector77>:
.globl vector77
vector77:
  pushl $0
  10220f:	6a 00                	push   $0x0
  pushl $77
  102211:	6a 4d                	push   $0x4d
  jmp __alltraps
  102213:	e9 c2 07 00 00       	jmp    1029da <__alltraps>

00102218 <vector78>:
.globl vector78
vector78:
  pushl $0
  102218:	6a 00                	push   $0x0
  pushl $78
  10221a:	6a 4e                	push   $0x4e
  jmp __alltraps
  10221c:	e9 b9 07 00 00       	jmp    1029da <__alltraps>

00102221 <vector79>:
.globl vector79
vector79:
  pushl $0
  102221:	6a 00                	push   $0x0
  pushl $79
  102223:	6a 4f                	push   $0x4f
  jmp __alltraps
  102225:	e9 b0 07 00 00       	jmp    1029da <__alltraps>

0010222a <vector80>:
.globl vector80
vector80:
  pushl $0
  10222a:	6a 00                	push   $0x0
  pushl $80
  10222c:	6a 50                	push   $0x50
  jmp __alltraps
  10222e:	e9 a7 07 00 00       	jmp    1029da <__alltraps>

00102233 <vector81>:
.globl vector81
vector81:
  pushl $0
  102233:	6a 00                	push   $0x0
  pushl $81
  102235:	6a 51                	push   $0x51
  jmp __alltraps
  102237:	e9 9e 07 00 00       	jmp    1029da <__alltraps>

0010223c <vector82>:
.globl vector82
vector82:
  pushl $0
  10223c:	6a 00                	push   $0x0
  pushl $82
  10223e:	6a 52                	push   $0x52
  jmp __alltraps
  102240:	e9 95 07 00 00       	jmp    1029da <__alltraps>

00102245 <vector83>:
.globl vector83
vector83:
  pushl $0
  102245:	6a 00                	push   $0x0
  pushl $83
  102247:	6a 53                	push   $0x53
  jmp __alltraps
  102249:	e9 8c 07 00 00       	jmp    1029da <__alltraps>

0010224e <vector84>:
.globl vector84
vector84:
  pushl $0
  10224e:	6a 00                	push   $0x0
  pushl $84
  102250:	6a 54                	push   $0x54
  jmp __alltraps
  102252:	e9 83 07 00 00       	jmp    1029da <__alltraps>

00102257 <vector85>:
.globl vector85
vector85:
  pushl $0
  102257:	6a 00                	push   $0x0
  pushl $85
  102259:	6a 55                	push   $0x55
  jmp __alltraps
  10225b:	e9 7a 07 00 00       	jmp    1029da <__alltraps>

00102260 <vector86>:
.globl vector86
vector86:
  pushl $0
  102260:	6a 00                	push   $0x0
  pushl $86
  102262:	6a 56                	push   $0x56
  jmp __alltraps
  102264:	e9 71 07 00 00       	jmp    1029da <__alltraps>

00102269 <vector87>:
.globl vector87
vector87:
  pushl $0
  102269:	6a 00                	push   $0x0
  pushl $87
  10226b:	6a 57                	push   $0x57
  jmp __alltraps
  10226d:	e9 68 07 00 00       	jmp    1029da <__alltraps>

00102272 <vector88>:
.globl vector88
vector88:
  pushl $0
  102272:	6a 00                	push   $0x0
  pushl $88
  102274:	6a 58                	push   $0x58
  jmp __alltraps
  102276:	e9 5f 07 00 00       	jmp    1029da <__alltraps>

0010227b <vector89>:
.globl vector89
vector89:
  pushl $0
  10227b:	6a 00                	push   $0x0
  pushl $89
  10227d:	6a 59                	push   $0x59
  jmp __alltraps
  10227f:	e9 56 07 00 00       	jmp    1029da <__alltraps>

00102284 <vector90>:
.globl vector90
vector90:
  pushl $0
  102284:	6a 00                	push   $0x0
  pushl $90
  102286:	6a 5a                	push   $0x5a
  jmp __alltraps
  102288:	e9 4d 07 00 00       	jmp    1029da <__alltraps>

0010228d <vector91>:
.globl vector91
vector91:
  pushl $0
  10228d:	6a 00                	push   $0x0
  pushl $91
  10228f:	6a 5b                	push   $0x5b
  jmp __alltraps
  102291:	e9 44 07 00 00       	jmp    1029da <__alltraps>

00102296 <vector92>:
.globl vector92
vector92:
  pushl $0
  102296:	6a 00                	push   $0x0
  pushl $92
  102298:	6a 5c                	push   $0x5c
  jmp __alltraps
  10229a:	e9 3b 07 00 00       	jmp    1029da <__alltraps>

0010229f <vector93>:
.globl vector93
vector93:
  pushl $0
  10229f:	6a 00                	push   $0x0
  pushl $93
  1022a1:	6a 5d                	push   $0x5d
  jmp __alltraps
  1022a3:	e9 32 07 00 00       	jmp    1029da <__alltraps>

001022a8 <vector94>:
.globl vector94
vector94:
  pushl $0
  1022a8:	6a 00                	push   $0x0
  pushl $94
  1022aa:	6a 5e                	push   $0x5e
  jmp __alltraps
  1022ac:	e9 29 07 00 00       	jmp    1029da <__alltraps>

001022b1 <vector95>:
.globl vector95
vector95:
  pushl $0
  1022b1:	6a 00                	push   $0x0
  pushl $95
  1022b3:	6a 5f                	push   $0x5f
  jmp __alltraps
  1022b5:	e9 20 07 00 00       	jmp    1029da <__alltraps>

001022ba <vector96>:
.globl vector96
vector96:
  pushl $0
  1022ba:	6a 00                	push   $0x0
  pushl $96
  1022bc:	6a 60                	push   $0x60
  jmp __alltraps
  1022be:	e9 17 07 00 00       	jmp    1029da <__alltraps>

001022c3 <vector97>:
.globl vector97
vector97:
  pushl $0
  1022c3:	6a 00                	push   $0x0
  pushl $97
  1022c5:	6a 61                	push   $0x61
  jmp __alltraps
  1022c7:	e9 0e 07 00 00       	jmp    1029da <__alltraps>

001022cc <vector98>:
.globl vector98
vector98:
  pushl $0
  1022cc:	6a 00                	push   $0x0
  pushl $98
  1022ce:	6a 62                	push   $0x62
  jmp __alltraps
  1022d0:	e9 05 07 00 00       	jmp    1029da <__alltraps>

001022d5 <vector99>:
.globl vector99
vector99:
  pushl $0
  1022d5:	6a 00                	push   $0x0
  pushl $99
  1022d7:	6a 63                	push   $0x63
  jmp __alltraps
  1022d9:	e9 fc 06 00 00       	jmp    1029da <__alltraps>

001022de <vector100>:
.globl vector100
vector100:
  pushl $0
  1022de:	6a 00                	push   $0x0
  pushl $100
  1022e0:	6a 64                	push   $0x64
  jmp __alltraps
  1022e2:	e9 f3 06 00 00       	jmp    1029da <__alltraps>

001022e7 <vector101>:
.globl vector101
vector101:
  pushl $0
  1022e7:	6a 00                	push   $0x0
  pushl $101
  1022e9:	6a 65                	push   $0x65
  jmp __alltraps
  1022eb:	e9 ea 06 00 00       	jmp    1029da <__alltraps>

001022f0 <vector102>:
.globl vector102
vector102:
  pushl $0
  1022f0:	6a 00                	push   $0x0
  pushl $102
  1022f2:	6a 66                	push   $0x66
  jmp __alltraps
  1022f4:	e9 e1 06 00 00       	jmp    1029da <__alltraps>

001022f9 <vector103>:
.globl vector103
vector103:
  pushl $0
  1022f9:	6a 00                	push   $0x0
  pushl $103
  1022fb:	6a 67                	push   $0x67
  jmp __alltraps
  1022fd:	e9 d8 06 00 00       	jmp    1029da <__alltraps>

00102302 <vector104>:
.globl vector104
vector104:
  pushl $0
  102302:	6a 00                	push   $0x0
  pushl $104
  102304:	6a 68                	push   $0x68
  jmp __alltraps
  102306:	e9 cf 06 00 00       	jmp    1029da <__alltraps>

0010230b <vector105>:
.globl vector105
vector105:
  pushl $0
  10230b:	6a 00                	push   $0x0
  pushl $105
  10230d:	6a 69                	push   $0x69
  jmp __alltraps
  10230f:	e9 c6 06 00 00       	jmp    1029da <__alltraps>

00102314 <vector106>:
.globl vector106
vector106:
  pushl $0
  102314:	6a 00                	push   $0x0
  pushl $106
  102316:	6a 6a                	push   $0x6a
  jmp __alltraps
  102318:	e9 bd 06 00 00       	jmp    1029da <__alltraps>

0010231d <vector107>:
.globl vector107
vector107:
  pushl $0
  10231d:	6a 00                	push   $0x0
  pushl $107
  10231f:	6a 6b                	push   $0x6b
  jmp __alltraps
  102321:	e9 b4 06 00 00       	jmp    1029da <__alltraps>

00102326 <vector108>:
.globl vector108
vector108:
  pushl $0
  102326:	6a 00                	push   $0x0
  pushl $108
  102328:	6a 6c                	push   $0x6c
  jmp __alltraps
  10232a:	e9 ab 06 00 00       	jmp    1029da <__alltraps>

0010232f <vector109>:
.globl vector109
vector109:
  pushl $0
  10232f:	6a 00                	push   $0x0
  pushl $109
  102331:	6a 6d                	push   $0x6d
  jmp __alltraps
  102333:	e9 a2 06 00 00       	jmp    1029da <__alltraps>

00102338 <vector110>:
.globl vector110
vector110:
  pushl $0
  102338:	6a 00                	push   $0x0
  pushl $110
  10233a:	6a 6e                	push   $0x6e
  jmp __alltraps
  10233c:	e9 99 06 00 00       	jmp    1029da <__alltraps>

00102341 <vector111>:
.globl vector111
vector111:
  pushl $0
  102341:	6a 00                	push   $0x0
  pushl $111
  102343:	6a 6f                	push   $0x6f
  jmp __alltraps
  102345:	e9 90 06 00 00       	jmp    1029da <__alltraps>

0010234a <vector112>:
.globl vector112
vector112:
  pushl $0
  10234a:	6a 00                	push   $0x0
  pushl $112
  10234c:	6a 70                	push   $0x70
  jmp __alltraps
  10234e:	e9 87 06 00 00       	jmp    1029da <__alltraps>

00102353 <vector113>:
.globl vector113
vector113:
  pushl $0
  102353:	6a 00                	push   $0x0
  pushl $113
  102355:	6a 71                	push   $0x71
  jmp __alltraps
  102357:	e9 7e 06 00 00       	jmp    1029da <__alltraps>

0010235c <vector114>:
.globl vector114
vector114:
  pushl $0
  10235c:	6a 00                	push   $0x0
  pushl $114
  10235e:	6a 72                	push   $0x72
  jmp __alltraps
  102360:	e9 75 06 00 00       	jmp    1029da <__alltraps>

00102365 <vector115>:
.globl vector115
vector115:
  pushl $0
  102365:	6a 00                	push   $0x0
  pushl $115
  102367:	6a 73                	push   $0x73
  jmp __alltraps
  102369:	e9 6c 06 00 00       	jmp    1029da <__alltraps>

0010236e <vector116>:
.globl vector116
vector116:
  pushl $0
  10236e:	6a 00                	push   $0x0
  pushl $116
  102370:	6a 74                	push   $0x74
  jmp __alltraps
  102372:	e9 63 06 00 00       	jmp    1029da <__alltraps>

00102377 <vector117>:
.globl vector117
vector117:
  pushl $0
  102377:	6a 00                	push   $0x0
  pushl $117
  102379:	6a 75                	push   $0x75
  jmp __alltraps
  10237b:	e9 5a 06 00 00       	jmp    1029da <__alltraps>

00102380 <vector118>:
.globl vector118
vector118:
  pushl $0
  102380:	6a 00                	push   $0x0
  pushl $118
  102382:	6a 76                	push   $0x76
  jmp __alltraps
  102384:	e9 51 06 00 00       	jmp    1029da <__alltraps>

00102389 <vector119>:
.globl vector119
vector119:
  pushl $0
  102389:	6a 00                	push   $0x0
  pushl $119
  10238b:	6a 77                	push   $0x77
  jmp __alltraps
  10238d:	e9 48 06 00 00       	jmp    1029da <__alltraps>

00102392 <vector120>:
.globl vector120
vector120:
  pushl $0
  102392:	6a 00                	push   $0x0
  pushl $120
  102394:	6a 78                	push   $0x78
  jmp __alltraps
  102396:	e9 3f 06 00 00       	jmp    1029da <__alltraps>

0010239b <vector121>:
.globl vector121
vector121:
  pushl $0
  10239b:	6a 00                	push   $0x0
  pushl $121
  10239d:	6a 79                	push   $0x79
  jmp __alltraps
  10239f:	e9 36 06 00 00       	jmp    1029da <__alltraps>

001023a4 <vector122>:
.globl vector122
vector122:
  pushl $0
  1023a4:	6a 00                	push   $0x0
  pushl $122
  1023a6:	6a 7a                	push   $0x7a
  jmp __alltraps
  1023a8:	e9 2d 06 00 00       	jmp    1029da <__alltraps>

001023ad <vector123>:
.globl vector123
vector123:
  pushl $0
  1023ad:	6a 00                	push   $0x0
  pushl $123
  1023af:	6a 7b                	push   $0x7b
  jmp __alltraps
  1023b1:	e9 24 06 00 00       	jmp    1029da <__alltraps>

001023b6 <vector124>:
.globl vector124
vector124:
  pushl $0
  1023b6:	6a 00                	push   $0x0
  pushl $124
  1023b8:	6a 7c                	push   $0x7c
  jmp __alltraps
  1023ba:	e9 1b 06 00 00       	jmp    1029da <__alltraps>

001023bf <vector125>:
.globl vector125
vector125:
  pushl $0
  1023bf:	6a 00                	push   $0x0
  pushl $125
  1023c1:	6a 7d                	push   $0x7d
  jmp __alltraps
  1023c3:	e9 12 06 00 00       	jmp    1029da <__alltraps>

001023c8 <vector126>:
.globl vector126
vector126:
  pushl $0
  1023c8:	6a 00                	push   $0x0
  pushl $126
  1023ca:	6a 7e                	push   $0x7e
  jmp __alltraps
  1023cc:	e9 09 06 00 00       	jmp    1029da <__alltraps>

001023d1 <vector127>:
.globl vector127
vector127:
  pushl $0
  1023d1:	6a 00                	push   $0x0
  pushl $127
  1023d3:	6a 7f                	push   $0x7f
  jmp __alltraps
  1023d5:	e9 00 06 00 00       	jmp    1029da <__alltraps>

001023da <vector128>:
.globl vector128
vector128:
  pushl $0
  1023da:	6a 00                	push   $0x0
  pushl $128
  1023dc:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  1023e1:	e9 f4 05 00 00       	jmp    1029da <__alltraps>

001023e6 <vector129>:
.globl vector129
vector129:
  pushl $0
  1023e6:	6a 00                	push   $0x0
  pushl $129
  1023e8:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  1023ed:	e9 e8 05 00 00       	jmp    1029da <__alltraps>

001023f2 <vector130>:
.globl vector130
vector130:
  pushl $0
  1023f2:	6a 00                	push   $0x0
  pushl $130
  1023f4:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  1023f9:	e9 dc 05 00 00       	jmp    1029da <__alltraps>

001023fe <vector131>:
.globl vector131
vector131:
  pushl $0
  1023fe:	6a 00                	push   $0x0
  pushl $131
  102400:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102405:	e9 d0 05 00 00       	jmp    1029da <__alltraps>

0010240a <vector132>:
.globl vector132
vector132:
  pushl $0
  10240a:	6a 00                	push   $0x0
  pushl $132
  10240c:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102411:	e9 c4 05 00 00       	jmp    1029da <__alltraps>

00102416 <vector133>:
.globl vector133
vector133:
  pushl $0
  102416:	6a 00                	push   $0x0
  pushl $133
  102418:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  10241d:	e9 b8 05 00 00       	jmp    1029da <__alltraps>

00102422 <vector134>:
.globl vector134
vector134:
  pushl $0
  102422:	6a 00                	push   $0x0
  pushl $134
  102424:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  102429:	e9 ac 05 00 00       	jmp    1029da <__alltraps>

0010242e <vector135>:
.globl vector135
vector135:
  pushl $0
  10242e:	6a 00                	push   $0x0
  pushl $135
  102430:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  102435:	e9 a0 05 00 00       	jmp    1029da <__alltraps>

0010243a <vector136>:
.globl vector136
vector136:
  pushl $0
  10243a:	6a 00                	push   $0x0
  pushl $136
  10243c:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102441:	e9 94 05 00 00       	jmp    1029da <__alltraps>

00102446 <vector137>:
.globl vector137
vector137:
  pushl $0
  102446:	6a 00                	push   $0x0
  pushl $137
  102448:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  10244d:	e9 88 05 00 00       	jmp    1029da <__alltraps>

00102452 <vector138>:
.globl vector138
vector138:
  pushl $0
  102452:	6a 00                	push   $0x0
  pushl $138
  102454:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  102459:	e9 7c 05 00 00       	jmp    1029da <__alltraps>

0010245e <vector139>:
.globl vector139
vector139:
  pushl $0
  10245e:	6a 00                	push   $0x0
  pushl $139
  102460:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102465:	e9 70 05 00 00       	jmp    1029da <__alltraps>

0010246a <vector140>:
.globl vector140
vector140:
  pushl $0
  10246a:	6a 00                	push   $0x0
  pushl $140
  10246c:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  102471:	e9 64 05 00 00       	jmp    1029da <__alltraps>

00102476 <vector141>:
.globl vector141
vector141:
  pushl $0
  102476:	6a 00                	push   $0x0
  pushl $141
  102478:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  10247d:	e9 58 05 00 00       	jmp    1029da <__alltraps>

00102482 <vector142>:
.globl vector142
vector142:
  pushl $0
  102482:	6a 00                	push   $0x0
  pushl $142
  102484:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  102489:	e9 4c 05 00 00       	jmp    1029da <__alltraps>

0010248e <vector143>:
.globl vector143
vector143:
  pushl $0
  10248e:	6a 00                	push   $0x0
  pushl $143
  102490:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102495:	e9 40 05 00 00       	jmp    1029da <__alltraps>

0010249a <vector144>:
.globl vector144
vector144:
  pushl $0
  10249a:	6a 00                	push   $0x0
  pushl $144
  10249c:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  1024a1:	e9 34 05 00 00       	jmp    1029da <__alltraps>

001024a6 <vector145>:
.globl vector145
vector145:
  pushl $0
  1024a6:	6a 00                	push   $0x0
  pushl $145
  1024a8:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  1024ad:	e9 28 05 00 00       	jmp    1029da <__alltraps>

001024b2 <vector146>:
.globl vector146
vector146:
  pushl $0
  1024b2:	6a 00                	push   $0x0
  pushl $146
  1024b4:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1024b9:	e9 1c 05 00 00       	jmp    1029da <__alltraps>

001024be <vector147>:
.globl vector147
vector147:
  pushl $0
  1024be:	6a 00                	push   $0x0
  pushl $147
  1024c0:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1024c5:	e9 10 05 00 00       	jmp    1029da <__alltraps>

001024ca <vector148>:
.globl vector148
vector148:
  pushl $0
  1024ca:	6a 00                	push   $0x0
  pushl $148
  1024cc:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  1024d1:	e9 04 05 00 00       	jmp    1029da <__alltraps>

001024d6 <vector149>:
.globl vector149
vector149:
  pushl $0
  1024d6:	6a 00                	push   $0x0
  pushl $149
  1024d8:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  1024dd:	e9 f8 04 00 00       	jmp    1029da <__alltraps>

001024e2 <vector150>:
.globl vector150
vector150:
  pushl $0
  1024e2:	6a 00                	push   $0x0
  pushl $150
  1024e4:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  1024e9:	e9 ec 04 00 00       	jmp    1029da <__alltraps>

001024ee <vector151>:
.globl vector151
vector151:
  pushl $0
  1024ee:	6a 00                	push   $0x0
  pushl $151
  1024f0:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  1024f5:	e9 e0 04 00 00       	jmp    1029da <__alltraps>

001024fa <vector152>:
.globl vector152
vector152:
  pushl $0
  1024fa:	6a 00                	push   $0x0
  pushl $152
  1024fc:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  102501:	e9 d4 04 00 00       	jmp    1029da <__alltraps>

00102506 <vector153>:
.globl vector153
vector153:
  pushl $0
  102506:	6a 00                	push   $0x0
  pushl $153
  102508:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  10250d:	e9 c8 04 00 00       	jmp    1029da <__alltraps>

00102512 <vector154>:
.globl vector154
vector154:
  pushl $0
  102512:	6a 00                	push   $0x0
  pushl $154
  102514:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  102519:	e9 bc 04 00 00       	jmp    1029da <__alltraps>

0010251e <vector155>:
.globl vector155
vector155:
  pushl $0
  10251e:	6a 00                	push   $0x0
  pushl $155
  102520:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102525:	e9 b0 04 00 00       	jmp    1029da <__alltraps>

0010252a <vector156>:
.globl vector156
vector156:
  pushl $0
  10252a:	6a 00                	push   $0x0
  pushl $156
  10252c:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102531:	e9 a4 04 00 00       	jmp    1029da <__alltraps>

00102536 <vector157>:
.globl vector157
vector157:
  pushl $0
  102536:	6a 00                	push   $0x0
  pushl $157
  102538:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  10253d:	e9 98 04 00 00       	jmp    1029da <__alltraps>

00102542 <vector158>:
.globl vector158
vector158:
  pushl $0
  102542:	6a 00                	push   $0x0
  pushl $158
  102544:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  102549:	e9 8c 04 00 00       	jmp    1029da <__alltraps>

0010254e <vector159>:
.globl vector159
vector159:
  pushl $0
  10254e:	6a 00                	push   $0x0
  pushl $159
  102550:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  102555:	e9 80 04 00 00       	jmp    1029da <__alltraps>

0010255a <vector160>:
.globl vector160
vector160:
  pushl $0
  10255a:	6a 00                	push   $0x0
  pushl $160
  10255c:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102561:	e9 74 04 00 00       	jmp    1029da <__alltraps>

00102566 <vector161>:
.globl vector161
vector161:
  pushl $0
  102566:	6a 00                	push   $0x0
  pushl $161
  102568:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  10256d:	e9 68 04 00 00       	jmp    1029da <__alltraps>

00102572 <vector162>:
.globl vector162
vector162:
  pushl $0
  102572:	6a 00                	push   $0x0
  pushl $162
  102574:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  102579:	e9 5c 04 00 00       	jmp    1029da <__alltraps>

0010257e <vector163>:
.globl vector163
vector163:
  pushl $0
  10257e:	6a 00                	push   $0x0
  pushl $163
  102580:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  102585:	e9 50 04 00 00       	jmp    1029da <__alltraps>

0010258a <vector164>:
.globl vector164
vector164:
  pushl $0
  10258a:	6a 00                	push   $0x0
  pushl $164
  10258c:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  102591:	e9 44 04 00 00       	jmp    1029da <__alltraps>

00102596 <vector165>:
.globl vector165
vector165:
  pushl $0
  102596:	6a 00                	push   $0x0
  pushl $165
  102598:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  10259d:	e9 38 04 00 00       	jmp    1029da <__alltraps>

001025a2 <vector166>:
.globl vector166
vector166:
  pushl $0
  1025a2:	6a 00                	push   $0x0
  pushl $166
  1025a4:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  1025a9:	e9 2c 04 00 00       	jmp    1029da <__alltraps>

001025ae <vector167>:
.globl vector167
vector167:
  pushl $0
  1025ae:	6a 00                	push   $0x0
  pushl $167
  1025b0:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1025b5:	e9 20 04 00 00       	jmp    1029da <__alltraps>

001025ba <vector168>:
.globl vector168
vector168:
  pushl $0
  1025ba:	6a 00                	push   $0x0
  pushl $168
  1025bc:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1025c1:	e9 14 04 00 00       	jmp    1029da <__alltraps>

001025c6 <vector169>:
.globl vector169
vector169:
  pushl $0
  1025c6:	6a 00                	push   $0x0
  pushl $169
  1025c8:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  1025cd:	e9 08 04 00 00       	jmp    1029da <__alltraps>

001025d2 <vector170>:
.globl vector170
vector170:
  pushl $0
  1025d2:	6a 00                	push   $0x0
  pushl $170
  1025d4:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  1025d9:	e9 fc 03 00 00       	jmp    1029da <__alltraps>

001025de <vector171>:
.globl vector171
vector171:
  pushl $0
  1025de:	6a 00                	push   $0x0
  pushl $171
  1025e0:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  1025e5:	e9 f0 03 00 00       	jmp    1029da <__alltraps>

001025ea <vector172>:
.globl vector172
vector172:
  pushl $0
  1025ea:	6a 00                	push   $0x0
  pushl $172
  1025ec:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  1025f1:	e9 e4 03 00 00       	jmp    1029da <__alltraps>

001025f6 <vector173>:
.globl vector173
vector173:
  pushl $0
  1025f6:	6a 00                	push   $0x0
  pushl $173
  1025f8:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  1025fd:	e9 d8 03 00 00       	jmp    1029da <__alltraps>

00102602 <vector174>:
.globl vector174
vector174:
  pushl $0
  102602:	6a 00                	push   $0x0
  pushl $174
  102604:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  102609:	e9 cc 03 00 00       	jmp    1029da <__alltraps>

0010260e <vector175>:
.globl vector175
vector175:
  pushl $0
  10260e:	6a 00                	push   $0x0
  pushl $175
  102610:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102615:	e9 c0 03 00 00       	jmp    1029da <__alltraps>

0010261a <vector176>:
.globl vector176
vector176:
  pushl $0
  10261a:	6a 00                	push   $0x0
  pushl $176
  10261c:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102621:	e9 b4 03 00 00       	jmp    1029da <__alltraps>

00102626 <vector177>:
.globl vector177
vector177:
  pushl $0
  102626:	6a 00                	push   $0x0
  pushl $177
  102628:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  10262d:	e9 a8 03 00 00       	jmp    1029da <__alltraps>

00102632 <vector178>:
.globl vector178
vector178:
  pushl $0
  102632:	6a 00                	push   $0x0
  pushl $178
  102634:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  102639:	e9 9c 03 00 00       	jmp    1029da <__alltraps>

0010263e <vector179>:
.globl vector179
vector179:
  pushl $0
  10263e:	6a 00                	push   $0x0
  pushl $179
  102640:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  102645:	e9 90 03 00 00       	jmp    1029da <__alltraps>

0010264a <vector180>:
.globl vector180
vector180:
  pushl $0
  10264a:	6a 00                	push   $0x0
  pushl $180
  10264c:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102651:	e9 84 03 00 00       	jmp    1029da <__alltraps>

00102656 <vector181>:
.globl vector181
vector181:
  pushl $0
  102656:	6a 00                	push   $0x0
  pushl $181
  102658:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  10265d:	e9 78 03 00 00       	jmp    1029da <__alltraps>

00102662 <vector182>:
.globl vector182
vector182:
  pushl $0
  102662:	6a 00                	push   $0x0
  pushl $182
  102664:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  102669:	e9 6c 03 00 00       	jmp    1029da <__alltraps>

0010266e <vector183>:
.globl vector183
vector183:
  pushl $0
  10266e:	6a 00                	push   $0x0
  pushl $183
  102670:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102675:	e9 60 03 00 00       	jmp    1029da <__alltraps>

0010267a <vector184>:
.globl vector184
vector184:
  pushl $0
  10267a:	6a 00                	push   $0x0
  pushl $184
  10267c:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  102681:	e9 54 03 00 00       	jmp    1029da <__alltraps>

00102686 <vector185>:
.globl vector185
vector185:
  pushl $0
  102686:	6a 00                	push   $0x0
  pushl $185
  102688:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  10268d:	e9 48 03 00 00       	jmp    1029da <__alltraps>

00102692 <vector186>:
.globl vector186
vector186:
  pushl $0
  102692:	6a 00                	push   $0x0
  pushl $186
  102694:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102699:	e9 3c 03 00 00       	jmp    1029da <__alltraps>

0010269e <vector187>:
.globl vector187
vector187:
  pushl $0
  10269e:	6a 00                	push   $0x0
  pushl $187
  1026a0:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  1026a5:	e9 30 03 00 00       	jmp    1029da <__alltraps>

001026aa <vector188>:
.globl vector188
vector188:
  pushl $0
  1026aa:	6a 00                	push   $0x0
  pushl $188
  1026ac:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1026b1:	e9 24 03 00 00       	jmp    1029da <__alltraps>

001026b6 <vector189>:
.globl vector189
vector189:
  pushl $0
  1026b6:	6a 00                	push   $0x0
  pushl $189
  1026b8:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1026bd:	e9 18 03 00 00       	jmp    1029da <__alltraps>

001026c2 <vector190>:
.globl vector190
vector190:
  pushl $0
  1026c2:	6a 00                	push   $0x0
  pushl $190
  1026c4:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1026c9:	e9 0c 03 00 00       	jmp    1029da <__alltraps>

001026ce <vector191>:
.globl vector191
vector191:
  pushl $0
  1026ce:	6a 00                	push   $0x0
  pushl $191
  1026d0:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  1026d5:	e9 00 03 00 00       	jmp    1029da <__alltraps>

001026da <vector192>:
.globl vector192
vector192:
  pushl $0
  1026da:	6a 00                	push   $0x0
  pushl $192
  1026dc:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  1026e1:	e9 f4 02 00 00       	jmp    1029da <__alltraps>

001026e6 <vector193>:
.globl vector193
vector193:
  pushl $0
  1026e6:	6a 00                	push   $0x0
  pushl $193
  1026e8:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  1026ed:	e9 e8 02 00 00       	jmp    1029da <__alltraps>

001026f2 <vector194>:
.globl vector194
vector194:
  pushl $0
  1026f2:	6a 00                	push   $0x0
  pushl $194
  1026f4:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  1026f9:	e9 dc 02 00 00       	jmp    1029da <__alltraps>

001026fe <vector195>:
.globl vector195
vector195:
  pushl $0
  1026fe:	6a 00                	push   $0x0
  pushl $195
  102700:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102705:	e9 d0 02 00 00       	jmp    1029da <__alltraps>

0010270a <vector196>:
.globl vector196
vector196:
  pushl $0
  10270a:	6a 00                	push   $0x0
  pushl $196
  10270c:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102711:	e9 c4 02 00 00       	jmp    1029da <__alltraps>

00102716 <vector197>:
.globl vector197
vector197:
  pushl $0
  102716:	6a 00                	push   $0x0
  pushl $197
  102718:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  10271d:	e9 b8 02 00 00       	jmp    1029da <__alltraps>

00102722 <vector198>:
.globl vector198
vector198:
  pushl $0
  102722:	6a 00                	push   $0x0
  pushl $198
  102724:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102729:	e9 ac 02 00 00       	jmp    1029da <__alltraps>

0010272e <vector199>:
.globl vector199
vector199:
  pushl $0
  10272e:	6a 00                	push   $0x0
  pushl $199
  102730:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102735:	e9 a0 02 00 00       	jmp    1029da <__alltraps>

0010273a <vector200>:
.globl vector200
vector200:
  pushl $0
  10273a:	6a 00                	push   $0x0
  pushl $200
  10273c:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102741:	e9 94 02 00 00       	jmp    1029da <__alltraps>

00102746 <vector201>:
.globl vector201
vector201:
  pushl $0
  102746:	6a 00                	push   $0x0
  pushl $201
  102748:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  10274d:	e9 88 02 00 00       	jmp    1029da <__alltraps>

00102752 <vector202>:
.globl vector202
vector202:
  pushl $0
  102752:	6a 00                	push   $0x0
  pushl $202
  102754:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  102759:	e9 7c 02 00 00       	jmp    1029da <__alltraps>

0010275e <vector203>:
.globl vector203
vector203:
  pushl $0
  10275e:	6a 00                	push   $0x0
  pushl $203
  102760:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102765:	e9 70 02 00 00       	jmp    1029da <__alltraps>

0010276a <vector204>:
.globl vector204
vector204:
  pushl $0
  10276a:	6a 00                	push   $0x0
  pushl $204
  10276c:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102771:	e9 64 02 00 00       	jmp    1029da <__alltraps>

00102776 <vector205>:
.globl vector205
vector205:
  pushl $0
  102776:	6a 00                	push   $0x0
  pushl $205
  102778:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  10277d:	e9 58 02 00 00       	jmp    1029da <__alltraps>

00102782 <vector206>:
.globl vector206
vector206:
  pushl $0
  102782:	6a 00                	push   $0x0
  pushl $206
  102784:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  102789:	e9 4c 02 00 00       	jmp    1029da <__alltraps>

0010278e <vector207>:
.globl vector207
vector207:
  pushl $0
  10278e:	6a 00                	push   $0x0
  pushl $207
  102790:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102795:	e9 40 02 00 00       	jmp    1029da <__alltraps>

0010279a <vector208>:
.globl vector208
vector208:
  pushl $0
  10279a:	6a 00                	push   $0x0
  pushl $208
  10279c:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  1027a1:	e9 34 02 00 00       	jmp    1029da <__alltraps>

001027a6 <vector209>:
.globl vector209
vector209:
  pushl $0
  1027a6:	6a 00                	push   $0x0
  pushl $209
  1027a8:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  1027ad:	e9 28 02 00 00       	jmp    1029da <__alltraps>

001027b2 <vector210>:
.globl vector210
vector210:
  pushl $0
  1027b2:	6a 00                	push   $0x0
  pushl $210
  1027b4:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1027b9:	e9 1c 02 00 00       	jmp    1029da <__alltraps>

001027be <vector211>:
.globl vector211
vector211:
  pushl $0
  1027be:	6a 00                	push   $0x0
  pushl $211
  1027c0:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1027c5:	e9 10 02 00 00       	jmp    1029da <__alltraps>

001027ca <vector212>:
.globl vector212
vector212:
  pushl $0
  1027ca:	6a 00                	push   $0x0
  pushl $212
  1027cc:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  1027d1:	e9 04 02 00 00       	jmp    1029da <__alltraps>

001027d6 <vector213>:
.globl vector213
vector213:
  pushl $0
  1027d6:	6a 00                	push   $0x0
  pushl $213
  1027d8:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  1027dd:	e9 f8 01 00 00       	jmp    1029da <__alltraps>

001027e2 <vector214>:
.globl vector214
vector214:
  pushl $0
  1027e2:	6a 00                	push   $0x0
  pushl $214
  1027e4:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  1027e9:	e9 ec 01 00 00       	jmp    1029da <__alltraps>

001027ee <vector215>:
.globl vector215
vector215:
  pushl $0
  1027ee:	6a 00                	push   $0x0
  pushl $215
  1027f0:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  1027f5:	e9 e0 01 00 00       	jmp    1029da <__alltraps>

001027fa <vector216>:
.globl vector216
vector216:
  pushl $0
  1027fa:	6a 00                	push   $0x0
  pushl $216
  1027fc:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102801:	e9 d4 01 00 00       	jmp    1029da <__alltraps>

00102806 <vector217>:
.globl vector217
vector217:
  pushl $0
  102806:	6a 00                	push   $0x0
  pushl $217
  102808:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  10280d:	e9 c8 01 00 00       	jmp    1029da <__alltraps>

00102812 <vector218>:
.globl vector218
vector218:
  pushl $0
  102812:	6a 00                	push   $0x0
  pushl $218
  102814:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102819:	e9 bc 01 00 00       	jmp    1029da <__alltraps>

0010281e <vector219>:
.globl vector219
vector219:
  pushl $0
  10281e:	6a 00                	push   $0x0
  pushl $219
  102820:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102825:	e9 b0 01 00 00       	jmp    1029da <__alltraps>

0010282a <vector220>:
.globl vector220
vector220:
  pushl $0
  10282a:	6a 00                	push   $0x0
  pushl $220
  10282c:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102831:	e9 a4 01 00 00       	jmp    1029da <__alltraps>

00102836 <vector221>:
.globl vector221
vector221:
  pushl $0
  102836:	6a 00                	push   $0x0
  pushl $221
  102838:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  10283d:	e9 98 01 00 00       	jmp    1029da <__alltraps>

00102842 <vector222>:
.globl vector222
vector222:
  pushl $0
  102842:	6a 00                	push   $0x0
  pushl $222
  102844:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  102849:	e9 8c 01 00 00       	jmp    1029da <__alltraps>

0010284e <vector223>:
.globl vector223
vector223:
  pushl $0
  10284e:	6a 00                	push   $0x0
  pushl $223
  102850:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102855:	e9 80 01 00 00       	jmp    1029da <__alltraps>

0010285a <vector224>:
.globl vector224
vector224:
  pushl $0
  10285a:	6a 00                	push   $0x0
  pushl $224
  10285c:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102861:	e9 74 01 00 00       	jmp    1029da <__alltraps>

00102866 <vector225>:
.globl vector225
vector225:
  pushl $0
  102866:	6a 00                	push   $0x0
  pushl $225
  102868:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  10286d:	e9 68 01 00 00       	jmp    1029da <__alltraps>

00102872 <vector226>:
.globl vector226
vector226:
  pushl $0
  102872:	6a 00                	push   $0x0
  pushl $226
  102874:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102879:	e9 5c 01 00 00       	jmp    1029da <__alltraps>

0010287e <vector227>:
.globl vector227
vector227:
  pushl $0
  10287e:	6a 00                	push   $0x0
  pushl $227
  102880:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102885:	e9 50 01 00 00       	jmp    1029da <__alltraps>

0010288a <vector228>:
.globl vector228
vector228:
  pushl $0
  10288a:	6a 00                	push   $0x0
  pushl $228
  10288c:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102891:	e9 44 01 00 00       	jmp    1029da <__alltraps>

00102896 <vector229>:
.globl vector229
vector229:
  pushl $0
  102896:	6a 00                	push   $0x0
  pushl $229
  102898:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  10289d:	e9 38 01 00 00       	jmp    1029da <__alltraps>

001028a2 <vector230>:
.globl vector230
vector230:
  pushl $0
  1028a2:	6a 00                	push   $0x0
  pushl $230
  1028a4:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  1028a9:	e9 2c 01 00 00       	jmp    1029da <__alltraps>

001028ae <vector231>:
.globl vector231
vector231:
  pushl $0
  1028ae:	6a 00                	push   $0x0
  pushl $231
  1028b0:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  1028b5:	e9 20 01 00 00       	jmp    1029da <__alltraps>

001028ba <vector232>:
.globl vector232
vector232:
  pushl $0
  1028ba:	6a 00                	push   $0x0
  pushl $232
  1028bc:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  1028c1:	e9 14 01 00 00       	jmp    1029da <__alltraps>

001028c6 <vector233>:
.globl vector233
vector233:
  pushl $0
  1028c6:	6a 00                	push   $0x0
  pushl $233
  1028c8:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  1028cd:	e9 08 01 00 00       	jmp    1029da <__alltraps>

001028d2 <vector234>:
.globl vector234
vector234:
  pushl $0
  1028d2:	6a 00                	push   $0x0
  pushl $234
  1028d4:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  1028d9:	e9 fc 00 00 00       	jmp    1029da <__alltraps>

001028de <vector235>:
.globl vector235
vector235:
  pushl $0
  1028de:	6a 00                	push   $0x0
  pushl $235
  1028e0:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  1028e5:	e9 f0 00 00 00       	jmp    1029da <__alltraps>

001028ea <vector236>:
.globl vector236
vector236:
  pushl $0
  1028ea:	6a 00                	push   $0x0
  pushl $236
  1028ec:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  1028f1:	e9 e4 00 00 00       	jmp    1029da <__alltraps>

001028f6 <vector237>:
.globl vector237
vector237:
  pushl $0
  1028f6:	6a 00                	push   $0x0
  pushl $237
  1028f8:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  1028fd:	e9 d8 00 00 00       	jmp    1029da <__alltraps>

00102902 <vector238>:
.globl vector238
vector238:
  pushl $0
  102902:	6a 00                	push   $0x0
  pushl $238
  102904:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102909:	e9 cc 00 00 00       	jmp    1029da <__alltraps>

0010290e <vector239>:
.globl vector239
vector239:
  pushl $0
  10290e:	6a 00                	push   $0x0
  pushl $239
  102910:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102915:	e9 c0 00 00 00       	jmp    1029da <__alltraps>

0010291a <vector240>:
.globl vector240
vector240:
  pushl $0
  10291a:	6a 00                	push   $0x0
  pushl $240
  10291c:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102921:	e9 b4 00 00 00       	jmp    1029da <__alltraps>

00102926 <vector241>:
.globl vector241
vector241:
  pushl $0
  102926:	6a 00                	push   $0x0
  pushl $241
  102928:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  10292d:	e9 a8 00 00 00       	jmp    1029da <__alltraps>

00102932 <vector242>:
.globl vector242
vector242:
  pushl $0
  102932:	6a 00                	push   $0x0
  pushl $242
  102934:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102939:	e9 9c 00 00 00       	jmp    1029da <__alltraps>

0010293e <vector243>:
.globl vector243
vector243:
  pushl $0
  10293e:	6a 00                	push   $0x0
  pushl $243
  102940:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102945:	e9 90 00 00 00       	jmp    1029da <__alltraps>

0010294a <vector244>:
.globl vector244
vector244:
  pushl $0
  10294a:	6a 00                	push   $0x0
  pushl $244
  10294c:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102951:	e9 84 00 00 00       	jmp    1029da <__alltraps>

00102956 <vector245>:
.globl vector245
vector245:
  pushl $0
  102956:	6a 00                	push   $0x0
  pushl $245
  102958:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  10295d:	e9 78 00 00 00       	jmp    1029da <__alltraps>

00102962 <vector246>:
.globl vector246
vector246:
  pushl $0
  102962:	6a 00                	push   $0x0
  pushl $246
  102964:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  102969:	e9 6c 00 00 00       	jmp    1029da <__alltraps>

0010296e <vector247>:
.globl vector247
vector247:
  pushl $0
  10296e:	6a 00                	push   $0x0
  pushl $247
  102970:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102975:	e9 60 00 00 00       	jmp    1029da <__alltraps>

0010297a <vector248>:
.globl vector248
vector248:
  pushl $0
  10297a:	6a 00                	push   $0x0
  pushl $248
  10297c:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102981:	e9 54 00 00 00       	jmp    1029da <__alltraps>

00102986 <vector249>:
.globl vector249
vector249:
  pushl $0
  102986:	6a 00                	push   $0x0
  pushl $249
  102988:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  10298d:	e9 48 00 00 00       	jmp    1029da <__alltraps>

00102992 <vector250>:
.globl vector250
vector250:
  pushl $0
  102992:	6a 00                	push   $0x0
  pushl $250
  102994:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102999:	e9 3c 00 00 00       	jmp    1029da <__alltraps>

0010299e <vector251>:
.globl vector251
vector251:
  pushl $0
  10299e:	6a 00                	push   $0x0
  pushl $251
  1029a0:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  1029a5:	e9 30 00 00 00       	jmp    1029da <__alltraps>

001029aa <vector252>:
.globl vector252
vector252:
  pushl $0
  1029aa:	6a 00                	push   $0x0
  pushl $252
  1029ac:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  1029b1:	e9 24 00 00 00       	jmp    1029da <__alltraps>

001029b6 <vector253>:
.globl vector253
vector253:
  pushl $0
  1029b6:	6a 00                	push   $0x0
  pushl $253
  1029b8:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  1029bd:	e9 18 00 00 00       	jmp    1029da <__alltraps>

001029c2 <vector254>:
.globl vector254
vector254:
  pushl $0
  1029c2:	6a 00                	push   $0x0
  pushl $254
  1029c4:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  1029c9:	e9 0c 00 00 00       	jmp    1029da <__alltraps>

001029ce <vector255>:
.globl vector255
vector255:
  pushl $0
  1029ce:	6a 00                	push   $0x0
  pushl $255
  1029d0:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  1029d5:	e9 00 00 00 00       	jmp    1029da <__alltraps>

001029da <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  1029da:	1e                   	push   %ds
    pushl %es
  1029db:	06                   	push   %es
    pushl %fs
  1029dc:	0f a0                	push   %fs
    pushl %gs
  1029de:	0f a8                	push   %gs
    pushal
  1029e0:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  1029e1:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  1029e6:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  1029e8:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  1029ea:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  1029eb:	e8 60 f5 ff ff       	call   101f50 <trap>

    # pop the pushed stack pointer
    popl %esp
  1029f0:	5c                   	pop    %esp

001029f1 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  1029f1:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  1029f2:	0f a9                	pop    %gs
    popl %fs
  1029f4:	0f a1                	pop    %fs
    popl %es
  1029f6:	07                   	pop    %es
    popl %ds
  1029f7:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  1029f8:	83 c4 08             	add    $0x8,%esp
    iret
  1029fb:	cf                   	iret   

001029fc <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  1029fc:	55                   	push   %ebp
  1029fd:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  1029ff:	8b 45 08             	mov    0x8(%ebp),%eax
  102a02:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102a05:	b8 23 00 00 00       	mov    $0x23,%eax
  102a0a:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102a0c:	b8 23 00 00 00       	mov    $0x23,%eax
  102a11:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102a13:	b8 10 00 00 00       	mov    $0x10,%eax
  102a18:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102a1a:	b8 10 00 00 00       	mov    $0x10,%eax
  102a1f:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102a21:	b8 10 00 00 00       	mov    $0x10,%eax
  102a26:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102a28:	ea 2f 2a 10 00 08 00 	ljmp   $0x8,$0x102a2f
}
  102a2f:	90                   	nop
  102a30:	5d                   	pop    %ebp
  102a31:	c3                   	ret    

00102a32 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102a32:	f3 0f 1e fb          	endbr32 
  102a36:	55                   	push   %ebp
  102a37:	89 e5                	mov    %esp,%ebp
  102a39:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102a3c:	b8 20 09 11 00       	mov    $0x110920,%eax
  102a41:	05 00 04 00 00       	add    $0x400,%eax
  102a46:	a3 a4 08 11 00       	mov    %eax,0x1108a4
    ts.ts_ss0 = KERNEL_DS;
  102a4b:	66 c7 05 a8 08 11 00 	movw   $0x10,0x1108a8
  102a52:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102a54:	66 c7 05 08 fa 10 00 	movw   $0x68,0x10fa08
  102a5b:	68 00 
  102a5d:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102a62:	0f b7 c0             	movzwl %ax,%eax
  102a65:	66 a3 0a fa 10 00    	mov    %ax,0x10fa0a
  102a6b:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102a70:	c1 e8 10             	shr    $0x10,%eax
  102a73:	a2 0c fa 10 00       	mov    %al,0x10fa0c
  102a78:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102a7f:	24 f0                	and    $0xf0,%al
  102a81:	0c 09                	or     $0x9,%al
  102a83:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102a88:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102a8f:	0c 10                	or     $0x10,%al
  102a91:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102a96:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102a9d:	24 9f                	and    $0x9f,%al
  102a9f:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102aa4:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102aab:	0c 80                	or     $0x80,%al
  102aad:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102ab2:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102ab9:	24 f0                	and    $0xf0,%al
  102abb:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102ac0:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102ac7:	24 ef                	and    $0xef,%al
  102ac9:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102ace:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102ad5:	24 df                	and    $0xdf,%al
  102ad7:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102adc:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102ae3:	0c 40                	or     $0x40,%al
  102ae5:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102aea:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102af1:	24 7f                	and    $0x7f,%al
  102af3:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102af8:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102afd:	c1 e8 18             	shr    $0x18,%eax
  102b00:	a2 0f fa 10 00       	mov    %al,0x10fa0f
    gdt[SEG_TSS].sd_s = 0;
  102b05:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102b0c:	24 ef                	and    $0xef,%al
  102b0e:	a2 0d fa 10 00       	mov    %al,0x10fa0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102b13:	c7 04 24 10 fa 10 00 	movl   $0x10fa10,(%esp)
  102b1a:	e8 dd fe ff ff       	call   1029fc <lgdt>
  102b1f:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102b25:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102b29:	0f 00 d8             	ltr    %ax
}
  102b2c:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102b2d:	90                   	nop
  102b2e:	c9                   	leave  
  102b2f:	c3                   	ret    

00102b30 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102b30:	f3 0f 1e fb          	endbr32 
  102b34:	55                   	push   %ebp
  102b35:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102b37:	e8 f6 fe ff ff       	call   102a32 <gdt_init>
}
  102b3c:	90                   	nop
  102b3d:	5d                   	pop    %ebp
  102b3e:	c3                   	ret    

00102b3f <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102b3f:	f3 0f 1e fb          	endbr32 
  102b43:	55                   	push   %ebp
  102b44:	89 e5                	mov    %esp,%ebp
  102b46:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102b49:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102b50:	eb 03                	jmp    102b55 <strlen+0x16>
        cnt ++;
  102b52:	ff 45 fc             	incl   -0x4(%ebp)
    while (*s ++ != '\0') {
  102b55:	8b 45 08             	mov    0x8(%ebp),%eax
  102b58:	8d 50 01             	lea    0x1(%eax),%edx
  102b5b:	89 55 08             	mov    %edx,0x8(%ebp)
  102b5e:	0f b6 00             	movzbl (%eax),%eax
  102b61:	84 c0                	test   %al,%al
  102b63:	75 ed                	jne    102b52 <strlen+0x13>
    }
    return cnt;
  102b65:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102b68:	c9                   	leave  
  102b69:	c3                   	ret    

00102b6a <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102b6a:	f3 0f 1e fb          	endbr32 
  102b6e:	55                   	push   %ebp
  102b6f:	89 e5                	mov    %esp,%ebp
  102b71:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102b74:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102b7b:	eb 03                	jmp    102b80 <strnlen+0x16>
        cnt ++;
  102b7d:	ff 45 fc             	incl   -0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102b80:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b83:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102b86:	73 10                	jae    102b98 <strnlen+0x2e>
  102b88:	8b 45 08             	mov    0x8(%ebp),%eax
  102b8b:	8d 50 01             	lea    0x1(%eax),%edx
  102b8e:	89 55 08             	mov    %edx,0x8(%ebp)
  102b91:	0f b6 00             	movzbl (%eax),%eax
  102b94:	84 c0                	test   %al,%al
  102b96:	75 e5                	jne    102b7d <strnlen+0x13>
    }
    return cnt;
  102b98:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102b9b:	c9                   	leave  
  102b9c:	c3                   	ret    

00102b9d <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102b9d:	f3 0f 1e fb          	endbr32 
  102ba1:	55                   	push   %ebp
  102ba2:	89 e5                	mov    %esp,%ebp
  102ba4:	57                   	push   %edi
  102ba5:	56                   	push   %esi
  102ba6:	83 ec 20             	sub    $0x20,%esp
  102ba9:	8b 45 08             	mov    0x8(%ebp),%eax
  102bac:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102baf:	8b 45 0c             	mov    0xc(%ebp),%eax
  102bb2:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102bb5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102bb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102bbb:	89 d1                	mov    %edx,%ecx
  102bbd:	89 c2                	mov    %eax,%edx
  102bbf:	89 ce                	mov    %ecx,%esi
  102bc1:	89 d7                	mov    %edx,%edi
  102bc3:	ac                   	lods   %ds:(%esi),%al
  102bc4:	aa                   	stos   %al,%es:(%edi)
  102bc5:	84 c0                	test   %al,%al
  102bc7:	75 fa                	jne    102bc3 <strcpy+0x26>
  102bc9:	89 fa                	mov    %edi,%edx
  102bcb:	89 f1                	mov    %esi,%ecx
  102bcd:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102bd0:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102bd3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102bd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102bd9:	83 c4 20             	add    $0x20,%esp
  102bdc:	5e                   	pop    %esi
  102bdd:	5f                   	pop    %edi
  102bde:	5d                   	pop    %ebp
  102bdf:	c3                   	ret    

00102be0 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102be0:	f3 0f 1e fb          	endbr32 
  102be4:	55                   	push   %ebp
  102be5:	89 e5                	mov    %esp,%ebp
  102be7:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102bea:	8b 45 08             	mov    0x8(%ebp),%eax
  102bed:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102bf0:	eb 1e                	jmp    102c10 <strncpy+0x30>
        if ((*p = *src) != '\0') {
  102bf2:	8b 45 0c             	mov    0xc(%ebp),%eax
  102bf5:	0f b6 10             	movzbl (%eax),%edx
  102bf8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102bfb:	88 10                	mov    %dl,(%eax)
  102bfd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102c00:	0f b6 00             	movzbl (%eax),%eax
  102c03:	84 c0                	test   %al,%al
  102c05:	74 03                	je     102c0a <strncpy+0x2a>
            src ++;
  102c07:	ff 45 0c             	incl   0xc(%ebp)
        }
        p ++, len --;
  102c0a:	ff 45 fc             	incl   -0x4(%ebp)
  102c0d:	ff 4d 10             	decl   0x10(%ebp)
    while (len > 0) {
  102c10:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c14:	75 dc                	jne    102bf2 <strncpy+0x12>
    }
    return dst;
  102c16:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102c19:	c9                   	leave  
  102c1a:	c3                   	ret    

00102c1b <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102c1b:	f3 0f 1e fb          	endbr32 
  102c1f:	55                   	push   %ebp
  102c20:	89 e5                	mov    %esp,%ebp
  102c22:	57                   	push   %edi
  102c23:	56                   	push   %esi
  102c24:	83 ec 20             	sub    $0x20,%esp
  102c27:	8b 45 08             	mov    0x8(%ebp),%eax
  102c2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c30:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102c33:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c36:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c39:	89 d1                	mov    %edx,%ecx
  102c3b:	89 c2                	mov    %eax,%edx
  102c3d:	89 ce                	mov    %ecx,%esi
  102c3f:	89 d7                	mov    %edx,%edi
  102c41:	ac                   	lods   %ds:(%esi),%al
  102c42:	ae                   	scas   %es:(%edi),%al
  102c43:	75 08                	jne    102c4d <strcmp+0x32>
  102c45:	84 c0                	test   %al,%al
  102c47:	75 f8                	jne    102c41 <strcmp+0x26>
  102c49:	31 c0                	xor    %eax,%eax
  102c4b:	eb 04                	jmp    102c51 <strcmp+0x36>
  102c4d:	19 c0                	sbb    %eax,%eax
  102c4f:	0c 01                	or     $0x1,%al
  102c51:	89 fa                	mov    %edi,%edx
  102c53:	89 f1                	mov    %esi,%ecx
  102c55:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102c58:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102c5b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102c5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102c61:	83 c4 20             	add    $0x20,%esp
  102c64:	5e                   	pop    %esi
  102c65:	5f                   	pop    %edi
  102c66:	5d                   	pop    %ebp
  102c67:	c3                   	ret    

00102c68 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102c68:	f3 0f 1e fb          	endbr32 
  102c6c:	55                   	push   %ebp
  102c6d:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102c6f:	eb 09                	jmp    102c7a <strncmp+0x12>
        n --, s1 ++, s2 ++;
  102c71:	ff 4d 10             	decl   0x10(%ebp)
  102c74:	ff 45 08             	incl   0x8(%ebp)
  102c77:	ff 45 0c             	incl   0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102c7a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c7e:	74 1a                	je     102c9a <strncmp+0x32>
  102c80:	8b 45 08             	mov    0x8(%ebp),%eax
  102c83:	0f b6 00             	movzbl (%eax),%eax
  102c86:	84 c0                	test   %al,%al
  102c88:	74 10                	je     102c9a <strncmp+0x32>
  102c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  102c8d:	0f b6 10             	movzbl (%eax),%edx
  102c90:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c93:	0f b6 00             	movzbl (%eax),%eax
  102c96:	38 c2                	cmp    %al,%dl
  102c98:	74 d7                	je     102c71 <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102c9a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c9e:	74 18                	je     102cb8 <strncmp+0x50>
  102ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  102ca3:	0f b6 00             	movzbl (%eax),%eax
  102ca6:	0f b6 d0             	movzbl %al,%edx
  102ca9:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cac:	0f b6 00             	movzbl (%eax),%eax
  102caf:	0f b6 c0             	movzbl %al,%eax
  102cb2:	29 c2                	sub    %eax,%edx
  102cb4:	89 d0                	mov    %edx,%eax
  102cb6:	eb 05                	jmp    102cbd <strncmp+0x55>
  102cb8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102cbd:	5d                   	pop    %ebp
  102cbe:	c3                   	ret    

00102cbf <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102cbf:	f3 0f 1e fb          	endbr32 
  102cc3:	55                   	push   %ebp
  102cc4:	89 e5                	mov    %esp,%ebp
  102cc6:	83 ec 04             	sub    $0x4,%esp
  102cc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ccc:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102ccf:	eb 13                	jmp    102ce4 <strchr+0x25>
        if (*s == c) {
  102cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  102cd4:	0f b6 00             	movzbl (%eax),%eax
  102cd7:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102cda:	75 05                	jne    102ce1 <strchr+0x22>
            return (char *)s;
  102cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  102cdf:	eb 12                	jmp    102cf3 <strchr+0x34>
        }
        s ++;
  102ce1:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102ce4:	8b 45 08             	mov    0x8(%ebp),%eax
  102ce7:	0f b6 00             	movzbl (%eax),%eax
  102cea:	84 c0                	test   %al,%al
  102cec:	75 e3                	jne    102cd1 <strchr+0x12>
    }
    return NULL;
  102cee:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102cf3:	c9                   	leave  
  102cf4:	c3                   	ret    

00102cf5 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102cf5:	f3 0f 1e fb          	endbr32 
  102cf9:	55                   	push   %ebp
  102cfa:	89 e5                	mov    %esp,%ebp
  102cfc:	83 ec 04             	sub    $0x4,%esp
  102cff:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d02:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102d05:	eb 0e                	jmp    102d15 <strfind+0x20>
        if (*s == c) {
  102d07:	8b 45 08             	mov    0x8(%ebp),%eax
  102d0a:	0f b6 00             	movzbl (%eax),%eax
  102d0d:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102d10:	74 0f                	je     102d21 <strfind+0x2c>
            break;
        }
        s ++;
  102d12:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102d15:	8b 45 08             	mov    0x8(%ebp),%eax
  102d18:	0f b6 00             	movzbl (%eax),%eax
  102d1b:	84 c0                	test   %al,%al
  102d1d:	75 e8                	jne    102d07 <strfind+0x12>
  102d1f:	eb 01                	jmp    102d22 <strfind+0x2d>
            break;
  102d21:	90                   	nop
    }
    return (char *)s;
  102d22:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102d25:	c9                   	leave  
  102d26:	c3                   	ret    

00102d27 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102d27:	f3 0f 1e fb          	endbr32 
  102d2b:	55                   	push   %ebp
  102d2c:	89 e5                	mov    %esp,%ebp
  102d2e:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  102d31:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102d38:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102d3f:	eb 03                	jmp    102d44 <strtol+0x1d>
        s ++;
  102d41:	ff 45 08             	incl   0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102d44:	8b 45 08             	mov    0x8(%ebp),%eax
  102d47:	0f b6 00             	movzbl (%eax),%eax
  102d4a:	3c 20                	cmp    $0x20,%al
  102d4c:	74 f3                	je     102d41 <strtol+0x1a>
  102d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  102d51:	0f b6 00             	movzbl (%eax),%eax
  102d54:	3c 09                	cmp    $0x9,%al
  102d56:	74 e9                	je     102d41 <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
  102d58:	8b 45 08             	mov    0x8(%ebp),%eax
  102d5b:	0f b6 00             	movzbl (%eax),%eax
  102d5e:	3c 2b                	cmp    $0x2b,%al
  102d60:	75 05                	jne    102d67 <strtol+0x40>
        s ++;
  102d62:	ff 45 08             	incl   0x8(%ebp)
  102d65:	eb 14                	jmp    102d7b <strtol+0x54>
    }
    else if (*s == '-') {
  102d67:	8b 45 08             	mov    0x8(%ebp),%eax
  102d6a:	0f b6 00             	movzbl (%eax),%eax
  102d6d:	3c 2d                	cmp    $0x2d,%al
  102d6f:	75 0a                	jne    102d7b <strtol+0x54>
        s ++, neg = 1;
  102d71:	ff 45 08             	incl   0x8(%ebp)
  102d74:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102d7b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d7f:	74 06                	je     102d87 <strtol+0x60>
  102d81:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102d85:	75 22                	jne    102da9 <strtol+0x82>
  102d87:	8b 45 08             	mov    0x8(%ebp),%eax
  102d8a:	0f b6 00             	movzbl (%eax),%eax
  102d8d:	3c 30                	cmp    $0x30,%al
  102d8f:	75 18                	jne    102da9 <strtol+0x82>
  102d91:	8b 45 08             	mov    0x8(%ebp),%eax
  102d94:	40                   	inc    %eax
  102d95:	0f b6 00             	movzbl (%eax),%eax
  102d98:	3c 78                	cmp    $0x78,%al
  102d9a:	75 0d                	jne    102da9 <strtol+0x82>
        s += 2, base = 16;
  102d9c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102da0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102da7:	eb 29                	jmp    102dd2 <strtol+0xab>
    }
    else if (base == 0 && s[0] == '0') {
  102da9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102dad:	75 16                	jne    102dc5 <strtol+0x9e>
  102daf:	8b 45 08             	mov    0x8(%ebp),%eax
  102db2:	0f b6 00             	movzbl (%eax),%eax
  102db5:	3c 30                	cmp    $0x30,%al
  102db7:	75 0c                	jne    102dc5 <strtol+0x9e>
        s ++, base = 8;
  102db9:	ff 45 08             	incl   0x8(%ebp)
  102dbc:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102dc3:	eb 0d                	jmp    102dd2 <strtol+0xab>
    }
    else if (base == 0) {
  102dc5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102dc9:	75 07                	jne    102dd2 <strtol+0xab>
        base = 10;
  102dcb:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102dd2:	8b 45 08             	mov    0x8(%ebp),%eax
  102dd5:	0f b6 00             	movzbl (%eax),%eax
  102dd8:	3c 2f                	cmp    $0x2f,%al
  102dda:	7e 1b                	jle    102df7 <strtol+0xd0>
  102ddc:	8b 45 08             	mov    0x8(%ebp),%eax
  102ddf:	0f b6 00             	movzbl (%eax),%eax
  102de2:	3c 39                	cmp    $0x39,%al
  102de4:	7f 11                	jg     102df7 <strtol+0xd0>
            dig = *s - '0';
  102de6:	8b 45 08             	mov    0x8(%ebp),%eax
  102de9:	0f b6 00             	movzbl (%eax),%eax
  102dec:	0f be c0             	movsbl %al,%eax
  102def:	83 e8 30             	sub    $0x30,%eax
  102df2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102df5:	eb 48                	jmp    102e3f <strtol+0x118>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102df7:	8b 45 08             	mov    0x8(%ebp),%eax
  102dfa:	0f b6 00             	movzbl (%eax),%eax
  102dfd:	3c 60                	cmp    $0x60,%al
  102dff:	7e 1b                	jle    102e1c <strtol+0xf5>
  102e01:	8b 45 08             	mov    0x8(%ebp),%eax
  102e04:	0f b6 00             	movzbl (%eax),%eax
  102e07:	3c 7a                	cmp    $0x7a,%al
  102e09:	7f 11                	jg     102e1c <strtol+0xf5>
            dig = *s - 'a' + 10;
  102e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  102e0e:	0f b6 00             	movzbl (%eax),%eax
  102e11:	0f be c0             	movsbl %al,%eax
  102e14:	83 e8 57             	sub    $0x57,%eax
  102e17:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102e1a:	eb 23                	jmp    102e3f <strtol+0x118>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  102e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  102e1f:	0f b6 00             	movzbl (%eax),%eax
  102e22:	3c 40                	cmp    $0x40,%al
  102e24:	7e 3b                	jle    102e61 <strtol+0x13a>
  102e26:	8b 45 08             	mov    0x8(%ebp),%eax
  102e29:	0f b6 00             	movzbl (%eax),%eax
  102e2c:	3c 5a                	cmp    $0x5a,%al
  102e2e:	7f 31                	jg     102e61 <strtol+0x13a>
            dig = *s - 'A' + 10;
  102e30:	8b 45 08             	mov    0x8(%ebp),%eax
  102e33:	0f b6 00             	movzbl (%eax),%eax
  102e36:	0f be c0             	movsbl %al,%eax
  102e39:	83 e8 37             	sub    $0x37,%eax
  102e3c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  102e3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e42:	3b 45 10             	cmp    0x10(%ebp),%eax
  102e45:	7d 19                	jge    102e60 <strtol+0x139>
            break;
        }
        s ++, val = (val * base) + dig;
  102e47:	ff 45 08             	incl   0x8(%ebp)
  102e4a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102e4d:	0f af 45 10          	imul   0x10(%ebp),%eax
  102e51:	89 c2                	mov    %eax,%edx
  102e53:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e56:	01 d0                	add    %edx,%eax
  102e58:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  102e5b:	e9 72 ff ff ff       	jmp    102dd2 <strtol+0xab>
            break;
  102e60:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  102e61:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102e65:	74 08                	je     102e6f <strtol+0x148>
        *endptr = (char *) s;
  102e67:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e6a:	8b 55 08             	mov    0x8(%ebp),%edx
  102e6d:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102e6f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102e73:	74 07                	je     102e7c <strtol+0x155>
  102e75:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102e78:	f7 d8                	neg    %eax
  102e7a:	eb 03                	jmp    102e7f <strtol+0x158>
  102e7c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102e7f:	c9                   	leave  
  102e80:	c3                   	ret    

00102e81 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102e81:	f3 0f 1e fb          	endbr32 
  102e85:	55                   	push   %ebp
  102e86:	89 e5                	mov    %esp,%ebp
  102e88:	57                   	push   %edi
  102e89:	83 ec 24             	sub    $0x24,%esp
  102e8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e8f:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102e92:	0f be 55 d8          	movsbl -0x28(%ebp),%edx
  102e96:	8b 45 08             	mov    0x8(%ebp),%eax
  102e99:	89 45 f8             	mov    %eax,-0x8(%ebp)
  102e9c:	88 55 f7             	mov    %dl,-0x9(%ebp)
  102e9f:	8b 45 10             	mov    0x10(%ebp),%eax
  102ea2:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102ea5:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102ea8:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102eac:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102eaf:	89 d7                	mov    %edx,%edi
  102eb1:	f3 aa                	rep stos %al,%es:(%edi)
  102eb3:	89 fa                	mov    %edi,%edx
  102eb5:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102eb8:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102ebb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102ebe:	83 c4 24             	add    $0x24,%esp
  102ec1:	5f                   	pop    %edi
  102ec2:	5d                   	pop    %ebp
  102ec3:	c3                   	ret    

00102ec4 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102ec4:	f3 0f 1e fb          	endbr32 
  102ec8:	55                   	push   %ebp
  102ec9:	89 e5                	mov    %esp,%ebp
  102ecb:	57                   	push   %edi
  102ecc:	56                   	push   %esi
  102ecd:	53                   	push   %ebx
  102ece:	83 ec 30             	sub    $0x30,%esp
  102ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  102ed4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102ed7:	8b 45 0c             	mov    0xc(%ebp),%eax
  102eda:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102edd:	8b 45 10             	mov    0x10(%ebp),%eax
  102ee0:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102ee3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ee6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102ee9:	73 42                	jae    102f2d <memmove+0x69>
  102eeb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102eee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102ef1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102ef4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102ef7:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102efa:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102efd:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102f00:	c1 e8 02             	shr    $0x2,%eax
  102f03:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102f05:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102f08:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102f0b:	89 d7                	mov    %edx,%edi
  102f0d:	89 c6                	mov    %eax,%esi
  102f0f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102f11:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102f14:	83 e1 03             	and    $0x3,%ecx
  102f17:	74 02                	je     102f1b <memmove+0x57>
  102f19:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102f1b:	89 f0                	mov    %esi,%eax
  102f1d:	89 fa                	mov    %edi,%edx
  102f1f:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102f22:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102f25:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  102f28:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  102f2b:	eb 36                	jmp    102f63 <memmove+0x9f>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102f2d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f30:	8d 50 ff             	lea    -0x1(%eax),%edx
  102f33:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f36:	01 c2                	add    %eax,%edx
  102f38:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f3b:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102f3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f41:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  102f44:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f47:	89 c1                	mov    %eax,%ecx
  102f49:	89 d8                	mov    %ebx,%eax
  102f4b:	89 d6                	mov    %edx,%esi
  102f4d:	89 c7                	mov    %eax,%edi
  102f4f:	fd                   	std    
  102f50:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102f52:	fc                   	cld    
  102f53:	89 f8                	mov    %edi,%eax
  102f55:	89 f2                	mov    %esi,%edx
  102f57:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  102f5a:	89 55 c8             	mov    %edx,-0x38(%ebp)
  102f5d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  102f60:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  102f63:	83 c4 30             	add    $0x30,%esp
  102f66:	5b                   	pop    %ebx
  102f67:	5e                   	pop    %esi
  102f68:	5f                   	pop    %edi
  102f69:	5d                   	pop    %ebp
  102f6a:	c3                   	ret    

00102f6b <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  102f6b:	f3 0f 1e fb          	endbr32 
  102f6f:	55                   	push   %ebp
  102f70:	89 e5                	mov    %esp,%ebp
  102f72:	57                   	push   %edi
  102f73:	56                   	push   %esi
  102f74:	83 ec 20             	sub    $0x20,%esp
  102f77:	8b 45 08             	mov    0x8(%ebp),%eax
  102f7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102f7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f80:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f83:	8b 45 10             	mov    0x10(%ebp),%eax
  102f86:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102f89:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f8c:	c1 e8 02             	shr    $0x2,%eax
  102f8f:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102f91:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102f94:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f97:	89 d7                	mov    %edx,%edi
  102f99:	89 c6                	mov    %eax,%esi
  102f9b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102f9d:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  102fa0:	83 e1 03             	and    $0x3,%ecx
  102fa3:	74 02                	je     102fa7 <memcpy+0x3c>
  102fa5:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102fa7:	89 f0                	mov    %esi,%eax
  102fa9:	89 fa                	mov    %edi,%edx
  102fab:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102fae:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  102fb1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  102fb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  102fb7:	83 c4 20             	add    $0x20,%esp
  102fba:	5e                   	pop    %esi
  102fbb:	5f                   	pop    %edi
  102fbc:	5d                   	pop    %ebp
  102fbd:	c3                   	ret    

00102fbe <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  102fbe:	f3 0f 1e fb          	endbr32 
  102fc2:	55                   	push   %ebp
  102fc3:	89 e5                	mov    %esp,%ebp
  102fc5:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  102fc8:	8b 45 08             	mov    0x8(%ebp),%eax
  102fcb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  102fce:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fd1:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  102fd4:	eb 2e                	jmp    103004 <memcmp+0x46>
        if (*s1 != *s2) {
  102fd6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102fd9:	0f b6 10             	movzbl (%eax),%edx
  102fdc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102fdf:	0f b6 00             	movzbl (%eax),%eax
  102fe2:	38 c2                	cmp    %al,%dl
  102fe4:	74 18                	je     102ffe <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  102fe6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102fe9:	0f b6 00             	movzbl (%eax),%eax
  102fec:	0f b6 d0             	movzbl %al,%edx
  102fef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102ff2:	0f b6 00             	movzbl (%eax),%eax
  102ff5:	0f b6 c0             	movzbl %al,%eax
  102ff8:	29 c2                	sub    %eax,%edx
  102ffa:	89 d0                	mov    %edx,%eax
  102ffc:	eb 18                	jmp    103016 <memcmp+0x58>
        }
        s1 ++, s2 ++;
  102ffe:	ff 45 fc             	incl   -0x4(%ebp)
  103001:	ff 45 f8             	incl   -0x8(%ebp)
    while (n -- > 0) {
  103004:	8b 45 10             	mov    0x10(%ebp),%eax
  103007:	8d 50 ff             	lea    -0x1(%eax),%edx
  10300a:	89 55 10             	mov    %edx,0x10(%ebp)
  10300d:	85 c0                	test   %eax,%eax
  10300f:	75 c5                	jne    102fd6 <memcmp+0x18>
    }
    return 0;
  103011:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103016:	c9                   	leave  
  103017:	c3                   	ret    

00103018 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  103018:	f3 0f 1e fb          	endbr32 
  10301c:	55                   	push   %ebp
  10301d:	89 e5                	mov    %esp,%ebp
  10301f:	83 ec 58             	sub    $0x58,%esp
  103022:	8b 45 10             	mov    0x10(%ebp),%eax
  103025:	89 45 d0             	mov    %eax,-0x30(%ebp)
  103028:	8b 45 14             	mov    0x14(%ebp),%eax
  10302b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  10302e:	8b 45 d0             	mov    -0x30(%ebp),%eax
  103031:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103034:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103037:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  10303a:	8b 45 18             	mov    0x18(%ebp),%eax
  10303d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103040:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103043:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103046:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103049:	89 55 f0             	mov    %edx,-0x10(%ebp)
  10304c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10304f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103052:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103056:	74 1c                	je     103074 <printnum+0x5c>
  103058:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10305b:	ba 00 00 00 00       	mov    $0x0,%edx
  103060:	f7 75 e4             	divl   -0x1c(%ebp)
  103063:	89 55 f4             	mov    %edx,-0xc(%ebp)
  103066:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103069:	ba 00 00 00 00       	mov    $0x0,%edx
  10306e:	f7 75 e4             	divl   -0x1c(%ebp)
  103071:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103074:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103077:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10307a:	f7 75 e4             	divl   -0x1c(%ebp)
  10307d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103080:	89 55 dc             	mov    %edx,-0x24(%ebp)
  103083:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103086:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103089:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10308c:	89 55 ec             	mov    %edx,-0x14(%ebp)
  10308f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103092:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  103095:	8b 45 18             	mov    0x18(%ebp),%eax
  103098:	ba 00 00 00 00       	mov    $0x0,%edx
  10309d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  1030a0:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  1030a3:	19 d1                	sbb    %edx,%ecx
  1030a5:	72 4c                	jb     1030f3 <printnum+0xdb>
        printnum(putch, putdat, result, base, width - 1, padc);
  1030a7:	8b 45 1c             	mov    0x1c(%ebp),%eax
  1030aa:	8d 50 ff             	lea    -0x1(%eax),%edx
  1030ad:	8b 45 20             	mov    0x20(%ebp),%eax
  1030b0:	89 44 24 18          	mov    %eax,0x18(%esp)
  1030b4:	89 54 24 14          	mov    %edx,0x14(%esp)
  1030b8:	8b 45 18             	mov    0x18(%ebp),%eax
  1030bb:	89 44 24 10          	mov    %eax,0x10(%esp)
  1030bf:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1030c2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1030c5:	89 44 24 08          	mov    %eax,0x8(%esp)
  1030c9:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1030cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030d0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030d4:	8b 45 08             	mov    0x8(%ebp),%eax
  1030d7:	89 04 24             	mov    %eax,(%esp)
  1030da:	e8 39 ff ff ff       	call   103018 <printnum>
  1030df:	eb 1b                	jmp    1030fc <printnum+0xe4>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  1030e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030e4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030e8:	8b 45 20             	mov    0x20(%ebp),%eax
  1030eb:	89 04 24             	mov    %eax,(%esp)
  1030ee:	8b 45 08             	mov    0x8(%ebp),%eax
  1030f1:	ff d0                	call   *%eax
        while (-- width > 0)
  1030f3:	ff 4d 1c             	decl   0x1c(%ebp)
  1030f6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  1030fa:	7f e5                	jg     1030e1 <printnum+0xc9>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  1030fc:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1030ff:	05 70 3e 10 00       	add    $0x103e70,%eax
  103104:	0f b6 00             	movzbl (%eax),%eax
  103107:	0f be c0             	movsbl %al,%eax
  10310a:	8b 55 0c             	mov    0xc(%ebp),%edx
  10310d:	89 54 24 04          	mov    %edx,0x4(%esp)
  103111:	89 04 24             	mov    %eax,(%esp)
  103114:	8b 45 08             	mov    0x8(%ebp),%eax
  103117:	ff d0                	call   *%eax
}
  103119:	90                   	nop
  10311a:	c9                   	leave  
  10311b:	c3                   	ret    

0010311c <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  10311c:	f3 0f 1e fb          	endbr32 
  103120:	55                   	push   %ebp
  103121:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  103123:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103127:	7e 14                	jle    10313d <getuint+0x21>
        return va_arg(*ap, unsigned long long);
  103129:	8b 45 08             	mov    0x8(%ebp),%eax
  10312c:	8b 00                	mov    (%eax),%eax
  10312e:	8d 48 08             	lea    0x8(%eax),%ecx
  103131:	8b 55 08             	mov    0x8(%ebp),%edx
  103134:	89 0a                	mov    %ecx,(%edx)
  103136:	8b 50 04             	mov    0x4(%eax),%edx
  103139:	8b 00                	mov    (%eax),%eax
  10313b:	eb 30                	jmp    10316d <getuint+0x51>
    }
    else if (lflag) {
  10313d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103141:	74 16                	je     103159 <getuint+0x3d>
        return va_arg(*ap, unsigned long);
  103143:	8b 45 08             	mov    0x8(%ebp),%eax
  103146:	8b 00                	mov    (%eax),%eax
  103148:	8d 48 04             	lea    0x4(%eax),%ecx
  10314b:	8b 55 08             	mov    0x8(%ebp),%edx
  10314e:	89 0a                	mov    %ecx,(%edx)
  103150:	8b 00                	mov    (%eax),%eax
  103152:	ba 00 00 00 00       	mov    $0x0,%edx
  103157:	eb 14                	jmp    10316d <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
  103159:	8b 45 08             	mov    0x8(%ebp),%eax
  10315c:	8b 00                	mov    (%eax),%eax
  10315e:	8d 48 04             	lea    0x4(%eax),%ecx
  103161:	8b 55 08             	mov    0x8(%ebp),%edx
  103164:	89 0a                	mov    %ecx,(%edx)
  103166:	8b 00                	mov    (%eax),%eax
  103168:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  10316d:	5d                   	pop    %ebp
  10316e:	c3                   	ret    

0010316f <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  10316f:	f3 0f 1e fb          	endbr32 
  103173:	55                   	push   %ebp
  103174:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  103176:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  10317a:	7e 14                	jle    103190 <getint+0x21>
        return va_arg(*ap, long long);
  10317c:	8b 45 08             	mov    0x8(%ebp),%eax
  10317f:	8b 00                	mov    (%eax),%eax
  103181:	8d 48 08             	lea    0x8(%eax),%ecx
  103184:	8b 55 08             	mov    0x8(%ebp),%edx
  103187:	89 0a                	mov    %ecx,(%edx)
  103189:	8b 50 04             	mov    0x4(%eax),%edx
  10318c:	8b 00                	mov    (%eax),%eax
  10318e:	eb 28                	jmp    1031b8 <getint+0x49>
    }
    else if (lflag) {
  103190:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103194:	74 12                	je     1031a8 <getint+0x39>
        return va_arg(*ap, long);
  103196:	8b 45 08             	mov    0x8(%ebp),%eax
  103199:	8b 00                	mov    (%eax),%eax
  10319b:	8d 48 04             	lea    0x4(%eax),%ecx
  10319e:	8b 55 08             	mov    0x8(%ebp),%edx
  1031a1:	89 0a                	mov    %ecx,(%edx)
  1031a3:	8b 00                	mov    (%eax),%eax
  1031a5:	99                   	cltd   
  1031a6:	eb 10                	jmp    1031b8 <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
  1031a8:	8b 45 08             	mov    0x8(%ebp),%eax
  1031ab:	8b 00                	mov    (%eax),%eax
  1031ad:	8d 48 04             	lea    0x4(%eax),%ecx
  1031b0:	8b 55 08             	mov    0x8(%ebp),%edx
  1031b3:	89 0a                	mov    %ecx,(%edx)
  1031b5:	8b 00                	mov    (%eax),%eax
  1031b7:	99                   	cltd   
    }
}
  1031b8:	5d                   	pop    %ebp
  1031b9:	c3                   	ret    

001031ba <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  1031ba:	f3 0f 1e fb          	endbr32 
  1031be:	55                   	push   %ebp
  1031bf:	89 e5                	mov    %esp,%ebp
  1031c1:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  1031c4:	8d 45 14             	lea    0x14(%ebp),%eax
  1031c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  1031ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1031cd:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1031d1:	8b 45 10             	mov    0x10(%ebp),%eax
  1031d4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1031d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031db:	89 44 24 04          	mov    %eax,0x4(%esp)
  1031df:	8b 45 08             	mov    0x8(%ebp),%eax
  1031e2:	89 04 24             	mov    %eax,(%esp)
  1031e5:	e8 03 00 00 00       	call   1031ed <vprintfmt>
    va_end(ap);
}
  1031ea:	90                   	nop
  1031eb:	c9                   	leave  
  1031ec:	c3                   	ret    

001031ed <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  1031ed:	f3 0f 1e fb          	endbr32 
  1031f1:	55                   	push   %ebp
  1031f2:	89 e5                	mov    %esp,%ebp
  1031f4:	56                   	push   %esi
  1031f5:	53                   	push   %ebx
  1031f6:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  1031f9:	eb 17                	jmp    103212 <vprintfmt+0x25>
            if (ch == '\0') {
  1031fb:	85 db                	test   %ebx,%ebx
  1031fd:	0f 84 c0 03 00 00    	je     1035c3 <vprintfmt+0x3d6>
                return;
            }
            putch(ch, putdat);
  103203:	8b 45 0c             	mov    0xc(%ebp),%eax
  103206:	89 44 24 04          	mov    %eax,0x4(%esp)
  10320a:	89 1c 24             	mov    %ebx,(%esp)
  10320d:	8b 45 08             	mov    0x8(%ebp),%eax
  103210:	ff d0                	call   *%eax
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103212:	8b 45 10             	mov    0x10(%ebp),%eax
  103215:	8d 50 01             	lea    0x1(%eax),%edx
  103218:	89 55 10             	mov    %edx,0x10(%ebp)
  10321b:	0f b6 00             	movzbl (%eax),%eax
  10321e:	0f b6 d8             	movzbl %al,%ebx
  103221:	83 fb 25             	cmp    $0x25,%ebx
  103224:	75 d5                	jne    1031fb <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
  103226:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  10322a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  103231:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103234:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  103237:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  10323e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103241:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  103244:	8b 45 10             	mov    0x10(%ebp),%eax
  103247:	8d 50 01             	lea    0x1(%eax),%edx
  10324a:	89 55 10             	mov    %edx,0x10(%ebp)
  10324d:	0f b6 00             	movzbl (%eax),%eax
  103250:	0f b6 d8             	movzbl %al,%ebx
  103253:	8d 43 dd             	lea    -0x23(%ebx),%eax
  103256:	83 f8 55             	cmp    $0x55,%eax
  103259:	0f 87 38 03 00 00    	ja     103597 <vprintfmt+0x3aa>
  10325f:	8b 04 85 94 3e 10 00 	mov    0x103e94(,%eax,4),%eax
  103266:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  103269:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  10326d:	eb d5                	jmp    103244 <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  10326f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  103273:	eb cf                	jmp    103244 <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  103275:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  10327c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10327f:	89 d0                	mov    %edx,%eax
  103281:	c1 e0 02             	shl    $0x2,%eax
  103284:	01 d0                	add    %edx,%eax
  103286:	01 c0                	add    %eax,%eax
  103288:	01 d8                	add    %ebx,%eax
  10328a:	83 e8 30             	sub    $0x30,%eax
  10328d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  103290:	8b 45 10             	mov    0x10(%ebp),%eax
  103293:	0f b6 00             	movzbl (%eax),%eax
  103296:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  103299:	83 fb 2f             	cmp    $0x2f,%ebx
  10329c:	7e 38                	jle    1032d6 <vprintfmt+0xe9>
  10329e:	83 fb 39             	cmp    $0x39,%ebx
  1032a1:	7f 33                	jg     1032d6 <vprintfmt+0xe9>
            for (precision = 0; ; ++ fmt) {
  1032a3:	ff 45 10             	incl   0x10(%ebp)
                precision = precision * 10 + ch - '0';
  1032a6:	eb d4                	jmp    10327c <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  1032a8:	8b 45 14             	mov    0x14(%ebp),%eax
  1032ab:	8d 50 04             	lea    0x4(%eax),%edx
  1032ae:	89 55 14             	mov    %edx,0x14(%ebp)
  1032b1:	8b 00                	mov    (%eax),%eax
  1032b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  1032b6:	eb 1f                	jmp    1032d7 <vprintfmt+0xea>

        case '.':
            if (width < 0)
  1032b8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1032bc:	79 86                	jns    103244 <vprintfmt+0x57>
                width = 0;
  1032be:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  1032c5:	e9 7a ff ff ff       	jmp    103244 <vprintfmt+0x57>

        case '#':
            altflag = 1;
  1032ca:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  1032d1:	e9 6e ff ff ff       	jmp    103244 <vprintfmt+0x57>
            goto process_precision;
  1032d6:	90                   	nop

        process_precision:
            if (width < 0)
  1032d7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1032db:	0f 89 63 ff ff ff    	jns    103244 <vprintfmt+0x57>
                width = precision, precision = -1;
  1032e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1032e4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1032e7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  1032ee:	e9 51 ff ff ff       	jmp    103244 <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  1032f3:	ff 45 e0             	incl   -0x20(%ebp)
            goto reswitch;
  1032f6:	e9 49 ff ff ff       	jmp    103244 <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  1032fb:	8b 45 14             	mov    0x14(%ebp),%eax
  1032fe:	8d 50 04             	lea    0x4(%eax),%edx
  103301:	89 55 14             	mov    %edx,0x14(%ebp)
  103304:	8b 00                	mov    (%eax),%eax
  103306:	8b 55 0c             	mov    0xc(%ebp),%edx
  103309:	89 54 24 04          	mov    %edx,0x4(%esp)
  10330d:	89 04 24             	mov    %eax,(%esp)
  103310:	8b 45 08             	mov    0x8(%ebp),%eax
  103313:	ff d0                	call   *%eax
            break;
  103315:	e9 a4 02 00 00       	jmp    1035be <vprintfmt+0x3d1>

        // error message
        case 'e':
            err = va_arg(ap, int);
  10331a:	8b 45 14             	mov    0x14(%ebp),%eax
  10331d:	8d 50 04             	lea    0x4(%eax),%edx
  103320:	89 55 14             	mov    %edx,0x14(%ebp)
  103323:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  103325:	85 db                	test   %ebx,%ebx
  103327:	79 02                	jns    10332b <vprintfmt+0x13e>
                err = -err;
  103329:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  10332b:	83 fb 06             	cmp    $0x6,%ebx
  10332e:	7f 0b                	jg     10333b <vprintfmt+0x14e>
  103330:	8b 34 9d 54 3e 10 00 	mov    0x103e54(,%ebx,4),%esi
  103337:	85 f6                	test   %esi,%esi
  103339:	75 23                	jne    10335e <vprintfmt+0x171>
                printfmt(putch, putdat, "error %d", err);
  10333b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  10333f:	c7 44 24 08 81 3e 10 	movl   $0x103e81,0x8(%esp)
  103346:	00 
  103347:	8b 45 0c             	mov    0xc(%ebp),%eax
  10334a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10334e:	8b 45 08             	mov    0x8(%ebp),%eax
  103351:	89 04 24             	mov    %eax,(%esp)
  103354:	e8 61 fe ff ff       	call   1031ba <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  103359:	e9 60 02 00 00       	jmp    1035be <vprintfmt+0x3d1>
                printfmt(putch, putdat, "%s", p);
  10335e:	89 74 24 0c          	mov    %esi,0xc(%esp)
  103362:	c7 44 24 08 8a 3e 10 	movl   $0x103e8a,0x8(%esp)
  103369:	00 
  10336a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10336d:	89 44 24 04          	mov    %eax,0x4(%esp)
  103371:	8b 45 08             	mov    0x8(%ebp),%eax
  103374:	89 04 24             	mov    %eax,(%esp)
  103377:	e8 3e fe ff ff       	call   1031ba <printfmt>
            break;
  10337c:	e9 3d 02 00 00       	jmp    1035be <vprintfmt+0x3d1>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  103381:	8b 45 14             	mov    0x14(%ebp),%eax
  103384:	8d 50 04             	lea    0x4(%eax),%edx
  103387:	89 55 14             	mov    %edx,0x14(%ebp)
  10338a:	8b 30                	mov    (%eax),%esi
  10338c:	85 f6                	test   %esi,%esi
  10338e:	75 05                	jne    103395 <vprintfmt+0x1a8>
                p = "(null)";
  103390:	be 8d 3e 10 00       	mov    $0x103e8d,%esi
            }
            if (width > 0 && padc != '-') {
  103395:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103399:	7e 76                	jle    103411 <vprintfmt+0x224>
  10339b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  10339f:	74 70                	je     103411 <vprintfmt+0x224>
                for (width -= strnlen(p, precision); width > 0; width --) {
  1033a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1033a4:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033a8:	89 34 24             	mov    %esi,(%esp)
  1033ab:	e8 ba f7 ff ff       	call   102b6a <strnlen>
  1033b0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1033b3:	29 c2                	sub    %eax,%edx
  1033b5:	89 d0                	mov    %edx,%eax
  1033b7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1033ba:	eb 16                	jmp    1033d2 <vprintfmt+0x1e5>
                    putch(padc, putdat);
  1033bc:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  1033c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  1033c3:	89 54 24 04          	mov    %edx,0x4(%esp)
  1033c7:	89 04 24             	mov    %eax,(%esp)
  1033ca:	8b 45 08             	mov    0x8(%ebp),%eax
  1033cd:	ff d0                	call   *%eax
                for (width -= strnlen(p, precision); width > 0; width --) {
  1033cf:	ff 4d e8             	decl   -0x18(%ebp)
  1033d2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1033d6:	7f e4                	jg     1033bc <vprintfmt+0x1cf>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1033d8:	eb 37                	jmp    103411 <vprintfmt+0x224>
                if (altflag && (ch < ' ' || ch > '~')) {
  1033da:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  1033de:	74 1f                	je     1033ff <vprintfmt+0x212>
  1033e0:	83 fb 1f             	cmp    $0x1f,%ebx
  1033e3:	7e 05                	jle    1033ea <vprintfmt+0x1fd>
  1033e5:	83 fb 7e             	cmp    $0x7e,%ebx
  1033e8:	7e 15                	jle    1033ff <vprintfmt+0x212>
                    putch('?', putdat);
  1033ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033ed:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033f1:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  1033f8:	8b 45 08             	mov    0x8(%ebp),%eax
  1033fb:	ff d0                	call   *%eax
  1033fd:	eb 0f                	jmp    10340e <vprintfmt+0x221>
                }
                else {
                    putch(ch, putdat);
  1033ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  103402:	89 44 24 04          	mov    %eax,0x4(%esp)
  103406:	89 1c 24             	mov    %ebx,(%esp)
  103409:	8b 45 08             	mov    0x8(%ebp),%eax
  10340c:	ff d0                	call   *%eax
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  10340e:	ff 4d e8             	decl   -0x18(%ebp)
  103411:	89 f0                	mov    %esi,%eax
  103413:	8d 70 01             	lea    0x1(%eax),%esi
  103416:	0f b6 00             	movzbl (%eax),%eax
  103419:	0f be d8             	movsbl %al,%ebx
  10341c:	85 db                	test   %ebx,%ebx
  10341e:	74 27                	je     103447 <vprintfmt+0x25a>
  103420:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103424:	78 b4                	js     1033da <vprintfmt+0x1ed>
  103426:	ff 4d e4             	decl   -0x1c(%ebp)
  103429:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10342d:	79 ab                	jns    1033da <vprintfmt+0x1ed>
                }
            }
            for (; width > 0; width --) {
  10342f:	eb 16                	jmp    103447 <vprintfmt+0x25a>
                putch(' ', putdat);
  103431:	8b 45 0c             	mov    0xc(%ebp),%eax
  103434:	89 44 24 04          	mov    %eax,0x4(%esp)
  103438:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10343f:	8b 45 08             	mov    0x8(%ebp),%eax
  103442:	ff d0                	call   *%eax
            for (; width > 0; width --) {
  103444:	ff 4d e8             	decl   -0x18(%ebp)
  103447:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10344b:	7f e4                	jg     103431 <vprintfmt+0x244>
            }
            break;
  10344d:	e9 6c 01 00 00       	jmp    1035be <vprintfmt+0x3d1>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  103452:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103455:	89 44 24 04          	mov    %eax,0x4(%esp)
  103459:	8d 45 14             	lea    0x14(%ebp),%eax
  10345c:	89 04 24             	mov    %eax,(%esp)
  10345f:	e8 0b fd ff ff       	call   10316f <getint>
  103464:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103467:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  10346a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10346d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103470:	85 d2                	test   %edx,%edx
  103472:	79 26                	jns    10349a <vprintfmt+0x2ad>
                putch('-', putdat);
  103474:	8b 45 0c             	mov    0xc(%ebp),%eax
  103477:	89 44 24 04          	mov    %eax,0x4(%esp)
  10347b:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  103482:	8b 45 08             	mov    0x8(%ebp),%eax
  103485:	ff d0                	call   *%eax
                num = -(long long)num;
  103487:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10348a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10348d:	f7 d8                	neg    %eax
  10348f:	83 d2 00             	adc    $0x0,%edx
  103492:	f7 da                	neg    %edx
  103494:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103497:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  10349a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1034a1:	e9 a8 00 00 00       	jmp    10354e <vprintfmt+0x361>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  1034a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034a9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034ad:	8d 45 14             	lea    0x14(%ebp),%eax
  1034b0:	89 04 24             	mov    %eax,(%esp)
  1034b3:	e8 64 fc ff ff       	call   10311c <getuint>
  1034b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034bb:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  1034be:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1034c5:	e9 84 00 00 00       	jmp    10354e <vprintfmt+0x361>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  1034ca:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034cd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034d1:	8d 45 14             	lea    0x14(%ebp),%eax
  1034d4:	89 04 24             	mov    %eax,(%esp)
  1034d7:	e8 40 fc ff ff       	call   10311c <getuint>
  1034dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034df:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  1034e2:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  1034e9:	eb 63                	jmp    10354e <vprintfmt+0x361>

        // pointer
        case 'p':
            putch('0', putdat);
  1034eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034ee:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034f2:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  1034f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1034fc:	ff d0                	call   *%eax
            putch('x', putdat);
  1034fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  103501:	89 44 24 04          	mov    %eax,0x4(%esp)
  103505:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  10350c:	8b 45 08             	mov    0x8(%ebp),%eax
  10350f:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  103511:	8b 45 14             	mov    0x14(%ebp),%eax
  103514:	8d 50 04             	lea    0x4(%eax),%edx
  103517:	89 55 14             	mov    %edx,0x14(%ebp)
  10351a:	8b 00                	mov    (%eax),%eax
  10351c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10351f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  103526:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  10352d:	eb 1f                	jmp    10354e <vprintfmt+0x361>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  10352f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103532:	89 44 24 04          	mov    %eax,0x4(%esp)
  103536:	8d 45 14             	lea    0x14(%ebp),%eax
  103539:	89 04 24             	mov    %eax,(%esp)
  10353c:	e8 db fb ff ff       	call   10311c <getuint>
  103541:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103544:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  103547:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  10354e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  103552:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103555:	89 54 24 18          	mov    %edx,0x18(%esp)
  103559:	8b 55 e8             	mov    -0x18(%ebp),%edx
  10355c:	89 54 24 14          	mov    %edx,0x14(%esp)
  103560:	89 44 24 10          	mov    %eax,0x10(%esp)
  103564:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103567:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10356a:	89 44 24 08          	mov    %eax,0x8(%esp)
  10356e:	89 54 24 0c          	mov    %edx,0xc(%esp)
  103572:	8b 45 0c             	mov    0xc(%ebp),%eax
  103575:	89 44 24 04          	mov    %eax,0x4(%esp)
  103579:	8b 45 08             	mov    0x8(%ebp),%eax
  10357c:	89 04 24             	mov    %eax,(%esp)
  10357f:	e8 94 fa ff ff       	call   103018 <printnum>
            break;
  103584:	eb 38                	jmp    1035be <vprintfmt+0x3d1>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  103586:	8b 45 0c             	mov    0xc(%ebp),%eax
  103589:	89 44 24 04          	mov    %eax,0x4(%esp)
  10358d:	89 1c 24             	mov    %ebx,(%esp)
  103590:	8b 45 08             	mov    0x8(%ebp),%eax
  103593:	ff d0                	call   *%eax
            break;
  103595:	eb 27                	jmp    1035be <vprintfmt+0x3d1>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  103597:	8b 45 0c             	mov    0xc(%ebp),%eax
  10359a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10359e:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  1035a5:	8b 45 08             	mov    0x8(%ebp),%eax
  1035a8:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  1035aa:	ff 4d 10             	decl   0x10(%ebp)
  1035ad:	eb 03                	jmp    1035b2 <vprintfmt+0x3c5>
  1035af:	ff 4d 10             	decl   0x10(%ebp)
  1035b2:	8b 45 10             	mov    0x10(%ebp),%eax
  1035b5:	48                   	dec    %eax
  1035b6:	0f b6 00             	movzbl (%eax),%eax
  1035b9:	3c 25                	cmp    $0x25,%al
  1035bb:	75 f2                	jne    1035af <vprintfmt+0x3c2>
                /* do nothing */;
            break;
  1035bd:	90                   	nop
    while (1) {
  1035be:	e9 36 fc ff ff       	jmp    1031f9 <vprintfmt+0xc>
                return;
  1035c3:	90                   	nop
        }
    }
}
  1035c4:	83 c4 40             	add    $0x40,%esp
  1035c7:	5b                   	pop    %ebx
  1035c8:	5e                   	pop    %esi
  1035c9:	5d                   	pop    %ebp
  1035ca:	c3                   	ret    

001035cb <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  1035cb:	f3 0f 1e fb          	endbr32 
  1035cf:	55                   	push   %ebp
  1035d0:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  1035d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035d5:	8b 40 08             	mov    0x8(%eax),%eax
  1035d8:	8d 50 01             	lea    0x1(%eax),%edx
  1035db:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035de:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  1035e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035e4:	8b 10                	mov    (%eax),%edx
  1035e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035e9:	8b 40 04             	mov    0x4(%eax),%eax
  1035ec:	39 c2                	cmp    %eax,%edx
  1035ee:	73 12                	jae    103602 <sprintputch+0x37>
        *b->buf ++ = ch;
  1035f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035f3:	8b 00                	mov    (%eax),%eax
  1035f5:	8d 48 01             	lea    0x1(%eax),%ecx
  1035f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  1035fb:	89 0a                	mov    %ecx,(%edx)
  1035fd:	8b 55 08             	mov    0x8(%ebp),%edx
  103600:	88 10                	mov    %dl,(%eax)
    }
}
  103602:	90                   	nop
  103603:	5d                   	pop    %ebp
  103604:	c3                   	ret    

00103605 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  103605:	f3 0f 1e fb          	endbr32 
  103609:	55                   	push   %ebp
  10360a:	89 e5                	mov    %esp,%ebp
  10360c:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  10360f:	8d 45 14             	lea    0x14(%ebp),%eax
  103612:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103615:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103618:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10361c:	8b 45 10             	mov    0x10(%ebp),%eax
  10361f:	89 44 24 08          	mov    %eax,0x8(%esp)
  103623:	8b 45 0c             	mov    0xc(%ebp),%eax
  103626:	89 44 24 04          	mov    %eax,0x4(%esp)
  10362a:	8b 45 08             	mov    0x8(%ebp),%eax
  10362d:	89 04 24             	mov    %eax,(%esp)
  103630:	e8 08 00 00 00       	call   10363d <vsnprintf>
  103635:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103638:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10363b:	c9                   	leave  
  10363c:	c3                   	ret    

0010363d <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  10363d:	f3 0f 1e fb          	endbr32 
  103641:	55                   	push   %ebp
  103642:	89 e5                	mov    %esp,%ebp
  103644:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  103647:	8b 45 08             	mov    0x8(%ebp),%eax
  10364a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10364d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103650:	8d 50 ff             	lea    -0x1(%eax),%edx
  103653:	8b 45 08             	mov    0x8(%ebp),%eax
  103656:	01 d0                	add    %edx,%eax
  103658:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10365b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  103662:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103666:	74 0a                	je     103672 <vsnprintf+0x35>
  103668:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10366b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10366e:	39 c2                	cmp    %eax,%edx
  103670:	76 07                	jbe    103679 <vsnprintf+0x3c>
        return -E_INVAL;
  103672:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  103677:	eb 2a                	jmp    1036a3 <vsnprintf+0x66>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  103679:	8b 45 14             	mov    0x14(%ebp),%eax
  10367c:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103680:	8b 45 10             	mov    0x10(%ebp),%eax
  103683:	89 44 24 08          	mov    %eax,0x8(%esp)
  103687:	8d 45 ec             	lea    -0x14(%ebp),%eax
  10368a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10368e:	c7 04 24 cb 35 10 00 	movl   $0x1035cb,(%esp)
  103695:	e8 53 fb ff ff       	call   1031ed <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  10369a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10369d:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1036a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1036a3:	c9                   	leave  
  1036a4:	c3                   	ret    
