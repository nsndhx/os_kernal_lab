
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
  100027:	e8 a1 2d 00 00       	call   102dcd <memset>

    cons_init();                // init the console
  10002c:	e8 fb 15 00 00       	call   10162c <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 00 36 10 00 	movl   $0x103600,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 1c 36 10 00 	movl   $0x10361c,(%esp)
  100046:	e8 39 02 00 00       	call   100284 <cprintf>

    print_kerninfo();
  10004b:	e8 f7 08 00 00       	call   100947 <print_kerninfo>

    grade_backtrace();
  100050:	e8 95 00 00 00       	call   1000ea <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 22 2a 00 00       	call   102a7c <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 22 17 00 00       	call   101781 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 c7 18 00 00       	call   10192b <idt_init>

    clock_init();               // init clock interrupt
  100064:	e8 48 0d 00 00       	call   100db1 <clock_init>
    intr_enable();              // enable irq interrupt
  100069:	e8 5f 18 00 00       	call   1018cd <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
  10006e:	eb fe                	jmp    10006e <kern_init+0x6e>

00100070 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100070:	f3 0f 1e fb          	endbr32 
  100074:	55                   	push   %ebp
  100075:	89 e5                	mov    %esp,%ebp
  100077:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  10007a:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100081:	00 
  100082:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100089:	00 
  10008a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100091:	e8 05 0d 00 00       	call   100d9b <mon_backtrace>
}
  100096:	90                   	nop
  100097:	c9                   	leave  
  100098:	c3                   	ret    

00100099 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100099:	f3 0f 1e fb          	endbr32 
  10009d:	55                   	push   %ebp
  10009e:	89 e5                	mov    %esp,%ebp
  1000a0:	53                   	push   %ebx
  1000a1:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000a4:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  1000a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  1000aa:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1000b0:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  1000b4:	89 54 24 08          	mov    %edx,0x8(%esp)
  1000b8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  1000bc:	89 04 24             	mov    %eax,(%esp)
  1000bf:	e8 ac ff ff ff       	call   100070 <grade_backtrace2>
}
  1000c4:	90                   	nop
  1000c5:	83 c4 14             	add    $0x14,%esp
  1000c8:	5b                   	pop    %ebx
  1000c9:	5d                   	pop    %ebp
  1000ca:	c3                   	ret    

001000cb <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000cb:	f3 0f 1e fb          	endbr32 
  1000cf:	55                   	push   %ebp
  1000d0:	89 e5                	mov    %esp,%ebp
  1000d2:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000d5:	8b 45 10             	mov    0x10(%ebp),%eax
  1000d8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000dc:	8b 45 08             	mov    0x8(%ebp),%eax
  1000df:	89 04 24             	mov    %eax,(%esp)
  1000e2:	e8 b2 ff ff ff       	call   100099 <grade_backtrace1>
}
  1000e7:	90                   	nop
  1000e8:	c9                   	leave  
  1000e9:	c3                   	ret    

001000ea <grade_backtrace>:

void
grade_backtrace(void) {
  1000ea:	f3 0f 1e fb          	endbr32 
  1000ee:	55                   	push   %ebp
  1000ef:	89 e5                	mov    %esp,%ebp
  1000f1:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000f4:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000f9:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  100100:	ff 
  100101:	89 44 24 04          	mov    %eax,0x4(%esp)
  100105:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10010c:	e8 ba ff ff ff       	call   1000cb <grade_backtrace0>
}
  100111:	90                   	nop
  100112:	c9                   	leave  
  100113:	c3                   	ret    

00100114 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100114:	f3 0f 1e fb          	endbr32 
  100118:	55                   	push   %ebp
  100119:	89 e5                	mov    %esp,%ebp
  10011b:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  10011e:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  100121:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  100124:	8c 45 f2             	mov    %es,-0xe(%ebp)
  100127:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  10012a:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10012e:	83 e0 03             	and    $0x3,%eax
  100131:	89 c2                	mov    %eax,%edx
  100133:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  100138:	89 54 24 08          	mov    %edx,0x8(%esp)
  10013c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100140:	c7 04 24 21 36 10 00 	movl   $0x103621,(%esp)
  100147:	e8 38 01 00 00       	call   100284 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  10014c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100150:	89 c2                	mov    %eax,%edx
  100152:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  100157:	89 54 24 08          	mov    %edx,0x8(%esp)
  10015b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10015f:	c7 04 24 2f 36 10 00 	movl   $0x10362f,(%esp)
  100166:	e8 19 01 00 00       	call   100284 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  10016b:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  10016f:	89 c2                	mov    %eax,%edx
  100171:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  100176:	89 54 24 08          	mov    %edx,0x8(%esp)
  10017a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10017e:	c7 04 24 3d 36 10 00 	movl   $0x10363d,(%esp)
  100185:	e8 fa 00 00 00       	call   100284 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  10018a:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10018e:	89 c2                	mov    %eax,%edx
  100190:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  100195:	89 54 24 08          	mov    %edx,0x8(%esp)
  100199:	89 44 24 04          	mov    %eax,0x4(%esp)
  10019d:	c7 04 24 4b 36 10 00 	movl   $0x10364b,(%esp)
  1001a4:	e8 db 00 00 00       	call   100284 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  1001a9:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001ad:	89 c2                	mov    %eax,%edx
  1001af:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  1001b4:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001b8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001bc:	c7 04 24 59 36 10 00 	movl   $0x103659,(%esp)
  1001c3:	e8 bc 00 00 00       	call   100284 <cprintf>
    round ++;
  1001c8:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  1001cd:	40                   	inc    %eax
  1001ce:	a3 20 fa 10 00       	mov    %eax,0x10fa20
}
  1001d3:	90                   	nop
  1001d4:	c9                   	leave  
  1001d5:	c3                   	ret    

001001d6 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001d6:	f3 0f 1e fb          	endbr32 
  1001da:	55                   	push   %ebp
  1001db:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
}
  1001dd:	90                   	nop
  1001de:	5d                   	pop    %ebp
  1001df:	c3                   	ret    

001001e0 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001e0:	f3 0f 1e fb          	endbr32 
  1001e4:	55                   	push   %ebp
  1001e5:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
}
  1001e7:	90                   	nop
  1001e8:	5d                   	pop    %ebp
  1001e9:	c3                   	ret    

001001ea <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001ea:	f3 0f 1e fb          	endbr32 
  1001ee:	55                   	push   %ebp
  1001ef:	89 e5                	mov    %esp,%ebp
  1001f1:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  1001f4:	e8 1b ff ff ff       	call   100114 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001f9:	c7 04 24 68 36 10 00 	movl   $0x103668,(%esp)
  100200:	e8 7f 00 00 00       	call   100284 <cprintf>
    lab1_switch_to_user();
  100205:	e8 cc ff ff ff       	call   1001d6 <lab1_switch_to_user>
    lab1_print_cur_status();
  10020a:	e8 05 ff ff ff       	call   100114 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  10020f:	c7 04 24 88 36 10 00 	movl   $0x103688,(%esp)
  100216:	e8 69 00 00 00       	call   100284 <cprintf>
    lab1_switch_to_kernel();
  10021b:	e8 c0 ff ff ff       	call   1001e0 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100220:	e8 ef fe ff ff       	call   100114 <lab1_print_cur_status>
}
  100225:	90                   	nop
  100226:	c9                   	leave  
  100227:	c3                   	ret    

00100228 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  100228:	f3 0f 1e fb          	endbr32 
  10022c:	55                   	push   %ebp
  10022d:	89 e5                	mov    %esp,%ebp
  10022f:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  100232:	8b 45 08             	mov    0x8(%ebp),%eax
  100235:	89 04 24             	mov    %eax,(%esp)
  100238:	e8 20 14 00 00       	call   10165d <cons_putc>
    (*cnt) ++;
  10023d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100240:	8b 00                	mov    (%eax),%eax
  100242:	8d 50 01             	lea    0x1(%eax),%edx
  100245:	8b 45 0c             	mov    0xc(%ebp),%eax
  100248:	89 10                	mov    %edx,(%eax)
}
  10024a:	90                   	nop
  10024b:	c9                   	leave  
  10024c:	c3                   	ret    

0010024d <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  10024d:	f3 0f 1e fb          	endbr32 
  100251:	55                   	push   %ebp
  100252:	89 e5                	mov    %esp,%ebp
  100254:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100257:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  10025e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100261:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100265:	8b 45 08             	mov    0x8(%ebp),%eax
  100268:	89 44 24 08          	mov    %eax,0x8(%esp)
  10026c:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10026f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100273:	c7 04 24 28 02 10 00 	movl   $0x100228,(%esp)
  10027a:	e8 ba 2e 00 00       	call   103139 <vprintfmt>
    return cnt;
  10027f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100282:	c9                   	leave  
  100283:	c3                   	ret    

00100284 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100284:	f3 0f 1e fb          	endbr32 
  100288:	55                   	push   %ebp
  100289:	89 e5                	mov    %esp,%ebp
  10028b:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  10028e:	8d 45 0c             	lea    0xc(%ebp),%eax
  100291:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  100294:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100297:	89 44 24 04          	mov    %eax,0x4(%esp)
  10029b:	8b 45 08             	mov    0x8(%ebp),%eax
  10029e:	89 04 24             	mov    %eax,(%esp)
  1002a1:	e8 a7 ff ff ff       	call   10024d <vcprintf>
  1002a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  1002a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002ac:	c9                   	leave  
  1002ad:	c3                   	ret    

001002ae <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  1002ae:	f3 0f 1e fb          	endbr32 
  1002b2:	55                   	push   %ebp
  1002b3:	89 e5                	mov    %esp,%ebp
  1002b5:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002b8:	8b 45 08             	mov    0x8(%ebp),%eax
  1002bb:	89 04 24             	mov    %eax,(%esp)
  1002be:	e8 9a 13 00 00       	call   10165d <cons_putc>
}
  1002c3:	90                   	nop
  1002c4:	c9                   	leave  
  1002c5:	c3                   	ret    

001002c6 <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  1002c6:	f3 0f 1e fb          	endbr32 
  1002ca:	55                   	push   %ebp
  1002cb:	89 e5                	mov    %esp,%ebp
  1002cd:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  1002d0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  1002d7:	eb 13                	jmp    1002ec <cputs+0x26>
        cputch(c, &cnt);
  1002d9:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  1002dd:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1002e0:	89 54 24 04          	mov    %edx,0x4(%esp)
  1002e4:	89 04 24             	mov    %eax,(%esp)
  1002e7:	e8 3c ff ff ff       	call   100228 <cputch>
    while ((c = *str ++) != '\0') {
  1002ec:	8b 45 08             	mov    0x8(%ebp),%eax
  1002ef:	8d 50 01             	lea    0x1(%eax),%edx
  1002f2:	89 55 08             	mov    %edx,0x8(%ebp)
  1002f5:	0f b6 00             	movzbl (%eax),%eax
  1002f8:	88 45 f7             	mov    %al,-0x9(%ebp)
  1002fb:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  1002ff:	75 d8                	jne    1002d9 <cputs+0x13>
    }
    cputch('\n', &cnt);
  100301:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100304:	89 44 24 04          	mov    %eax,0x4(%esp)
  100308:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  10030f:	e8 14 ff ff ff       	call   100228 <cputch>
    return cnt;
  100314:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  100317:	c9                   	leave  
  100318:	c3                   	ret    

00100319 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  100319:	f3 0f 1e fb          	endbr32 
  10031d:	55                   	push   %ebp
  10031e:	89 e5                	mov    %esp,%ebp
  100320:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  100323:	90                   	nop
  100324:	e8 62 13 00 00       	call   10168b <cons_getc>
  100329:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10032c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100330:	74 f2                	je     100324 <getchar+0xb>
        /* do nothing */;
    return c;
  100332:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100335:	c9                   	leave  
  100336:	c3                   	ret    

00100337 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100337:	f3 0f 1e fb          	endbr32 
  10033b:	55                   	push   %ebp
  10033c:	89 e5                	mov    %esp,%ebp
  10033e:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  100341:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100345:	74 13                	je     10035a <readline+0x23>
        cprintf("%s", prompt);
  100347:	8b 45 08             	mov    0x8(%ebp),%eax
  10034a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10034e:	c7 04 24 a7 36 10 00 	movl   $0x1036a7,(%esp)
  100355:	e8 2a ff ff ff       	call   100284 <cprintf>
    }
    int i = 0, c;
  10035a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  100361:	e8 b3 ff ff ff       	call   100319 <getchar>
  100366:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100369:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10036d:	79 07                	jns    100376 <readline+0x3f>
            return NULL;
  10036f:	b8 00 00 00 00       	mov    $0x0,%eax
  100374:	eb 78                	jmp    1003ee <readline+0xb7>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100376:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  10037a:	7e 28                	jle    1003a4 <readline+0x6d>
  10037c:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100383:	7f 1f                	jg     1003a4 <readline+0x6d>
            cputchar(c);
  100385:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100388:	89 04 24             	mov    %eax,(%esp)
  10038b:	e8 1e ff ff ff       	call   1002ae <cputchar>
            buf[i ++] = c;
  100390:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100393:	8d 50 01             	lea    0x1(%eax),%edx
  100396:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100399:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10039c:	88 90 40 fa 10 00    	mov    %dl,0x10fa40(%eax)
  1003a2:	eb 45                	jmp    1003e9 <readline+0xb2>
        }
        else if (c == '\b' && i > 0) {
  1003a4:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  1003a8:	75 16                	jne    1003c0 <readline+0x89>
  1003aa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003ae:	7e 10                	jle    1003c0 <readline+0x89>
            cputchar(c);
  1003b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003b3:	89 04 24             	mov    %eax,(%esp)
  1003b6:	e8 f3 fe ff ff       	call   1002ae <cputchar>
            i --;
  1003bb:	ff 4d f4             	decl   -0xc(%ebp)
  1003be:	eb 29                	jmp    1003e9 <readline+0xb2>
        }
        else if (c == '\n' || c == '\r') {
  1003c0:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1003c4:	74 06                	je     1003cc <readline+0x95>
  1003c6:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1003ca:	75 95                	jne    100361 <readline+0x2a>
            cputchar(c);
  1003cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003cf:	89 04 24             	mov    %eax,(%esp)
  1003d2:	e8 d7 fe ff ff       	call   1002ae <cputchar>
            buf[i] = '\0';
  1003d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003da:	05 40 fa 10 00       	add    $0x10fa40,%eax
  1003df:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1003e2:	b8 40 fa 10 00       	mov    $0x10fa40,%eax
  1003e7:	eb 05                	jmp    1003ee <readline+0xb7>
        c = getchar();
  1003e9:	e9 73 ff ff ff       	jmp    100361 <readline+0x2a>
        }
    }
}
  1003ee:	c9                   	leave  
  1003ef:	c3                   	ret    

001003f0 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1003f0:	f3 0f 1e fb          	endbr32 
  1003f4:	55                   	push   %ebp
  1003f5:	89 e5                	mov    %esp,%ebp
  1003f7:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  1003fa:	a1 40 fe 10 00       	mov    0x10fe40,%eax
  1003ff:	85 c0                	test   %eax,%eax
  100401:	75 5b                	jne    10045e <__panic+0x6e>
        goto panic_dead;
    }
    is_panic = 1;
  100403:	c7 05 40 fe 10 00 01 	movl   $0x1,0x10fe40
  10040a:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  10040d:	8d 45 14             	lea    0x14(%ebp),%eax
  100410:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100413:	8b 45 0c             	mov    0xc(%ebp),%eax
  100416:	89 44 24 08          	mov    %eax,0x8(%esp)
  10041a:	8b 45 08             	mov    0x8(%ebp),%eax
  10041d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100421:	c7 04 24 aa 36 10 00 	movl   $0x1036aa,(%esp)
  100428:	e8 57 fe ff ff       	call   100284 <cprintf>
    vcprintf(fmt, ap);
  10042d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100430:	89 44 24 04          	mov    %eax,0x4(%esp)
  100434:	8b 45 10             	mov    0x10(%ebp),%eax
  100437:	89 04 24             	mov    %eax,(%esp)
  10043a:	e8 0e fe ff ff       	call   10024d <vcprintf>
    cprintf("\n");
  10043f:	c7 04 24 c6 36 10 00 	movl   $0x1036c6,(%esp)
  100446:	e8 39 fe ff ff       	call   100284 <cprintf>
    
    cprintf("stack trackback:\n");
  10044b:	c7 04 24 c8 36 10 00 	movl   $0x1036c8,(%esp)
  100452:	e8 2d fe ff ff       	call   100284 <cprintf>
    print_stackframe();
  100457:	e8 3d 06 00 00       	call   100a99 <print_stackframe>
  10045c:	eb 01                	jmp    10045f <__panic+0x6f>
        goto panic_dead;
  10045e:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  10045f:	e8 75 14 00 00       	call   1018d9 <intr_disable>
    while (1) {
        kmonitor(NULL);
  100464:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10046b:	e8 52 08 00 00       	call   100cc2 <kmonitor>
  100470:	eb f2                	jmp    100464 <__panic+0x74>

00100472 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100472:	f3 0f 1e fb          	endbr32 
  100476:	55                   	push   %ebp
  100477:	89 e5                	mov    %esp,%ebp
  100479:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  10047c:	8d 45 14             	lea    0x14(%ebp),%eax
  10047f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100482:	8b 45 0c             	mov    0xc(%ebp),%eax
  100485:	89 44 24 08          	mov    %eax,0x8(%esp)
  100489:	8b 45 08             	mov    0x8(%ebp),%eax
  10048c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100490:	c7 04 24 da 36 10 00 	movl   $0x1036da,(%esp)
  100497:	e8 e8 fd ff ff       	call   100284 <cprintf>
    vcprintf(fmt, ap);
  10049c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10049f:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004a3:	8b 45 10             	mov    0x10(%ebp),%eax
  1004a6:	89 04 24             	mov    %eax,(%esp)
  1004a9:	e8 9f fd ff ff       	call   10024d <vcprintf>
    cprintf("\n");
  1004ae:	c7 04 24 c6 36 10 00 	movl   $0x1036c6,(%esp)
  1004b5:	e8 ca fd ff ff       	call   100284 <cprintf>
    va_end(ap);
}
  1004ba:	90                   	nop
  1004bb:	c9                   	leave  
  1004bc:	c3                   	ret    

001004bd <is_kernel_panic>:

bool
is_kernel_panic(void) {
  1004bd:	f3 0f 1e fb          	endbr32 
  1004c1:	55                   	push   %ebp
  1004c2:	89 e5                	mov    %esp,%ebp
    return is_panic;
  1004c4:	a1 40 fe 10 00       	mov    0x10fe40,%eax
}
  1004c9:	5d                   	pop    %ebp
  1004ca:	c3                   	ret    

001004cb <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1004cb:	f3 0f 1e fb          	endbr32 
  1004cf:	55                   	push   %ebp
  1004d0:	89 e5                	mov    %esp,%ebp
  1004d2:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1004d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004d8:	8b 00                	mov    (%eax),%eax
  1004da:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1004dd:	8b 45 10             	mov    0x10(%ebp),%eax
  1004e0:	8b 00                	mov    (%eax),%eax
  1004e2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1004ec:	e9 ca 00 00 00       	jmp    1005bb <stab_binsearch+0xf0>
        int true_m = (l + r) / 2, m = true_m;
  1004f1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1004f7:	01 d0                	add    %edx,%eax
  1004f9:	89 c2                	mov    %eax,%edx
  1004fb:	c1 ea 1f             	shr    $0x1f,%edx
  1004fe:	01 d0                	add    %edx,%eax
  100500:	d1 f8                	sar    %eax
  100502:	89 45 ec             	mov    %eax,-0x14(%ebp)
  100505:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100508:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  10050b:	eb 03                	jmp    100510 <stab_binsearch+0x45>
            m --;
  10050d:	ff 4d f0             	decl   -0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  100510:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100513:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100516:	7c 1f                	jl     100537 <stab_binsearch+0x6c>
  100518:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10051b:	89 d0                	mov    %edx,%eax
  10051d:	01 c0                	add    %eax,%eax
  10051f:	01 d0                	add    %edx,%eax
  100521:	c1 e0 02             	shl    $0x2,%eax
  100524:	89 c2                	mov    %eax,%edx
  100526:	8b 45 08             	mov    0x8(%ebp),%eax
  100529:	01 d0                	add    %edx,%eax
  10052b:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10052f:	0f b6 c0             	movzbl %al,%eax
  100532:	39 45 14             	cmp    %eax,0x14(%ebp)
  100535:	75 d6                	jne    10050d <stab_binsearch+0x42>
        }
        if (m < l) {    // no match in [l, m]
  100537:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10053a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10053d:	7d 09                	jge    100548 <stab_binsearch+0x7d>
            l = true_m + 1;
  10053f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100542:	40                   	inc    %eax
  100543:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  100546:	eb 73                	jmp    1005bb <stab_binsearch+0xf0>
        }

        // actual binary search
        any_matches = 1;
  100548:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  10054f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100552:	89 d0                	mov    %edx,%eax
  100554:	01 c0                	add    %eax,%eax
  100556:	01 d0                	add    %edx,%eax
  100558:	c1 e0 02             	shl    $0x2,%eax
  10055b:	89 c2                	mov    %eax,%edx
  10055d:	8b 45 08             	mov    0x8(%ebp),%eax
  100560:	01 d0                	add    %edx,%eax
  100562:	8b 40 08             	mov    0x8(%eax),%eax
  100565:	39 45 18             	cmp    %eax,0x18(%ebp)
  100568:	76 11                	jbe    10057b <stab_binsearch+0xb0>
            *region_left = m;
  10056a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10056d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100570:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100572:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100575:	40                   	inc    %eax
  100576:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100579:	eb 40                	jmp    1005bb <stab_binsearch+0xf0>
        } else if (stabs[m].n_value > addr) {
  10057b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10057e:	89 d0                	mov    %edx,%eax
  100580:	01 c0                	add    %eax,%eax
  100582:	01 d0                	add    %edx,%eax
  100584:	c1 e0 02             	shl    $0x2,%eax
  100587:	89 c2                	mov    %eax,%edx
  100589:	8b 45 08             	mov    0x8(%ebp),%eax
  10058c:	01 d0                	add    %edx,%eax
  10058e:	8b 40 08             	mov    0x8(%eax),%eax
  100591:	39 45 18             	cmp    %eax,0x18(%ebp)
  100594:	73 14                	jae    1005aa <stab_binsearch+0xdf>
            *region_right = m - 1;
  100596:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100599:	8d 50 ff             	lea    -0x1(%eax),%edx
  10059c:	8b 45 10             	mov    0x10(%ebp),%eax
  10059f:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  1005a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005a4:	48                   	dec    %eax
  1005a5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1005a8:	eb 11                	jmp    1005bb <stab_binsearch+0xf0>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1005aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005ad:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005b0:	89 10                	mov    %edx,(%eax)
            l = m;
  1005b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005b5:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1005b8:	ff 45 18             	incl   0x18(%ebp)
    while (l <= r) {
  1005bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1005be:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1005c1:	0f 8e 2a ff ff ff    	jle    1004f1 <stab_binsearch+0x26>
        }
    }

    if (!any_matches) {
  1005c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1005cb:	75 0f                	jne    1005dc <stab_binsearch+0x111>
        *region_right = *region_left - 1;
  1005cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005d0:	8b 00                	mov    (%eax),%eax
  1005d2:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005d5:	8b 45 10             	mov    0x10(%ebp),%eax
  1005d8:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1005da:	eb 3e                	jmp    10061a <stab_binsearch+0x14f>
        l = *region_right;
  1005dc:	8b 45 10             	mov    0x10(%ebp),%eax
  1005df:	8b 00                	mov    (%eax),%eax
  1005e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1005e4:	eb 03                	jmp    1005e9 <stab_binsearch+0x11e>
  1005e6:	ff 4d fc             	decl   -0x4(%ebp)
  1005e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005ec:	8b 00                	mov    (%eax),%eax
  1005ee:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  1005f1:	7e 1f                	jle    100612 <stab_binsearch+0x147>
  1005f3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005f6:	89 d0                	mov    %edx,%eax
  1005f8:	01 c0                	add    %eax,%eax
  1005fa:	01 d0                	add    %edx,%eax
  1005fc:	c1 e0 02             	shl    $0x2,%eax
  1005ff:	89 c2                	mov    %eax,%edx
  100601:	8b 45 08             	mov    0x8(%ebp),%eax
  100604:	01 d0                	add    %edx,%eax
  100606:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10060a:	0f b6 c0             	movzbl %al,%eax
  10060d:	39 45 14             	cmp    %eax,0x14(%ebp)
  100610:	75 d4                	jne    1005e6 <stab_binsearch+0x11b>
        *region_left = l;
  100612:	8b 45 0c             	mov    0xc(%ebp),%eax
  100615:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100618:	89 10                	mov    %edx,(%eax)
}
  10061a:	90                   	nop
  10061b:	c9                   	leave  
  10061c:	c3                   	ret    

0010061d <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  10061d:	f3 0f 1e fb          	endbr32 
  100621:	55                   	push   %ebp
  100622:	89 e5                	mov    %esp,%ebp
  100624:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  100627:	8b 45 0c             	mov    0xc(%ebp),%eax
  10062a:	c7 00 f8 36 10 00    	movl   $0x1036f8,(%eax)
    info->eip_line = 0;
  100630:	8b 45 0c             	mov    0xc(%ebp),%eax
  100633:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  10063a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10063d:	c7 40 08 f8 36 10 00 	movl   $0x1036f8,0x8(%eax)
    info->eip_fn_namelen = 9;
  100644:	8b 45 0c             	mov    0xc(%ebp),%eax
  100647:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  10064e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100651:	8b 55 08             	mov    0x8(%ebp),%edx
  100654:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100657:	8b 45 0c             	mov    0xc(%ebp),%eax
  10065a:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100661:	c7 45 f4 2c 3f 10 00 	movl   $0x103f2c,-0xc(%ebp)
    stab_end = __STAB_END__;
  100668:	c7 45 f0 b4 cb 10 00 	movl   $0x10cbb4,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  10066f:	c7 45 ec b5 cb 10 00 	movl   $0x10cbb5,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100676:	c7 45 e8 8c ec 10 00 	movl   $0x10ec8c,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  10067d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100680:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100683:	76 0b                	jbe    100690 <debuginfo_eip+0x73>
  100685:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100688:	48                   	dec    %eax
  100689:	0f b6 00             	movzbl (%eax),%eax
  10068c:	84 c0                	test   %al,%al
  10068e:	74 0a                	je     10069a <debuginfo_eip+0x7d>
        return -1;
  100690:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100695:	e9 ab 02 00 00       	jmp    100945 <debuginfo_eip+0x328>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  10069a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1006a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006a4:	2b 45 f4             	sub    -0xc(%ebp),%eax
  1006a7:	c1 f8 02             	sar    $0x2,%eax
  1006aa:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1006b0:	48                   	dec    %eax
  1006b1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1006b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1006b7:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006bb:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1006c2:	00 
  1006c3:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1006c6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006ca:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1006cd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006d4:	89 04 24             	mov    %eax,(%esp)
  1006d7:	e8 ef fd ff ff       	call   1004cb <stab_binsearch>
    if (lfile == 0)
  1006dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006df:	85 c0                	test   %eax,%eax
  1006e1:	75 0a                	jne    1006ed <debuginfo_eip+0xd0>
        return -1;
  1006e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006e8:	e9 58 02 00 00       	jmp    100945 <debuginfo_eip+0x328>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1006ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1006f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006f6:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1006f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1006fc:	89 44 24 10          	mov    %eax,0x10(%esp)
  100700:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  100707:	00 
  100708:	8d 45 d8             	lea    -0x28(%ebp),%eax
  10070b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10070f:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100712:	89 44 24 04          	mov    %eax,0x4(%esp)
  100716:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100719:	89 04 24             	mov    %eax,(%esp)
  10071c:	e8 aa fd ff ff       	call   1004cb <stab_binsearch>

    if (lfun <= rfun) {
  100721:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100724:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100727:	39 c2                	cmp    %eax,%edx
  100729:	7f 78                	jg     1007a3 <debuginfo_eip+0x186>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  10072b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10072e:	89 c2                	mov    %eax,%edx
  100730:	89 d0                	mov    %edx,%eax
  100732:	01 c0                	add    %eax,%eax
  100734:	01 d0                	add    %edx,%eax
  100736:	c1 e0 02             	shl    $0x2,%eax
  100739:	89 c2                	mov    %eax,%edx
  10073b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10073e:	01 d0                	add    %edx,%eax
  100740:	8b 10                	mov    (%eax),%edx
  100742:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100745:	2b 45 ec             	sub    -0x14(%ebp),%eax
  100748:	39 c2                	cmp    %eax,%edx
  10074a:	73 22                	jae    10076e <debuginfo_eip+0x151>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  10074c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10074f:	89 c2                	mov    %eax,%edx
  100751:	89 d0                	mov    %edx,%eax
  100753:	01 c0                	add    %eax,%eax
  100755:	01 d0                	add    %edx,%eax
  100757:	c1 e0 02             	shl    $0x2,%eax
  10075a:	89 c2                	mov    %eax,%edx
  10075c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10075f:	01 d0                	add    %edx,%eax
  100761:	8b 10                	mov    (%eax),%edx
  100763:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100766:	01 c2                	add    %eax,%edx
  100768:	8b 45 0c             	mov    0xc(%ebp),%eax
  10076b:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  10076e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100771:	89 c2                	mov    %eax,%edx
  100773:	89 d0                	mov    %edx,%eax
  100775:	01 c0                	add    %eax,%eax
  100777:	01 d0                	add    %edx,%eax
  100779:	c1 e0 02             	shl    $0x2,%eax
  10077c:	89 c2                	mov    %eax,%edx
  10077e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100781:	01 d0                	add    %edx,%eax
  100783:	8b 50 08             	mov    0x8(%eax),%edx
  100786:	8b 45 0c             	mov    0xc(%ebp),%eax
  100789:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  10078c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10078f:	8b 40 10             	mov    0x10(%eax),%eax
  100792:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  100795:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100798:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  10079b:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10079e:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1007a1:	eb 15                	jmp    1007b8 <debuginfo_eip+0x19b>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1007a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007a6:	8b 55 08             	mov    0x8(%ebp),%edx
  1007a9:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1007ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007af:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1007b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1007b5:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1007b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007bb:	8b 40 08             	mov    0x8(%eax),%eax
  1007be:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1007c5:	00 
  1007c6:	89 04 24             	mov    %eax,(%esp)
  1007c9:	e8 73 24 00 00       	call   102c41 <strfind>
  1007ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  1007d1:	8b 52 08             	mov    0x8(%edx),%edx
  1007d4:	29 d0                	sub    %edx,%eax
  1007d6:	89 c2                	mov    %eax,%edx
  1007d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007db:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1007de:	8b 45 08             	mov    0x8(%ebp),%eax
  1007e1:	89 44 24 10          	mov    %eax,0x10(%esp)
  1007e5:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1007ec:	00 
  1007ed:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1007f0:	89 44 24 08          	mov    %eax,0x8(%esp)
  1007f4:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1007f7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1007fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007fe:	89 04 24             	mov    %eax,(%esp)
  100801:	e8 c5 fc ff ff       	call   1004cb <stab_binsearch>
    if (lline <= rline) {
  100806:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100809:	8b 45 d0             	mov    -0x30(%ebp),%eax
  10080c:	39 c2                	cmp    %eax,%edx
  10080e:	7f 23                	jg     100833 <debuginfo_eip+0x216>
        info->eip_line = stabs[rline].n_desc;
  100810:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100813:	89 c2                	mov    %eax,%edx
  100815:	89 d0                	mov    %edx,%eax
  100817:	01 c0                	add    %eax,%eax
  100819:	01 d0                	add    %edx,%eax
  10081b:	c1 e0 02             	shl    $0x2,%eax
  10081e:	89 c2                	mov    %eax,%edx
  100820:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100823:	01 d0                	add    %edx,%eax
  100825:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  100829:	89 c2                	mov    %eax,%edx
  10082b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10082e:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100831:	eb 11                	jmp    100844 <debuginfo_eip+0x227>
        return -1;
  100833:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100838:	e9 08 01 00 00       	jmp    100945 <debuginfo_eip+0x328>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  10083d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100840:	48                   	dec    %eax
  100841:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  100844:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100847:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10084a:	39 c2                	cmp    %eax,%edx
  10084c:	7c 56                	jl     1008a4 <debuginfo_eip+0x287>
           && stabs[lline].n_type != N_SOL
  10084e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100851:	89 c2                	mov    %eax,%edx
  100853:	89 d0                	mov    %edx,%eax
  100855:	01 c0                	add    %eax,%eax
  100857:	01 d0                	add    %edx,%eax
  100859:	c1 e0 02             	shl    $0x2,%eax
  10085c:	89 c2                	mov    %eax,%edx
  10085e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100861:	01 d0                	add    %edx,%eax
  100863:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100867:	3c 84                	cmp    $0x84,%al
  100869:	74 39                	je     1008a4 <debuginfo_eip+0x287>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  10086b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10086e:	89 c2                	mov    %eax,%edx
  100870:	89 d0                	mov    %edx,%eax
  100872:	01 c0                	add    %eax,%eax
  100874:	01 d0                	add    %edx,%eax
  100876:	c1 e0 02             	shl    $0x2,%eax
  100879:	89 c2                	mov    %eax,%edx
  10087b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10087e:	01 d0                	add    %edx,%eax
  100880:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100884:	3c 64                	cmp    $0x64,%al
  100886:	75 b5                	jne    10083d <debuginfo_eip+0x220>
  100888:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10088b:	89 c2                	mov    %eax,%edx
  10088d:	89 d0                	mov    %edx,%eax
  10088f:	01 c0                	add    %eax,%eax
  100891:	01 d0                	add    %edx,%eax
  100893:	c1 e0 02             	shl    $0x2,%eax
  100896:	89 c2                	mov    %eax,%edx
  100898:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10089b:	01 d0                	add    %edx,%eax
  10089d:	8b 40 08             	mov    0x8(%eax),%eax
  1008a0:	85 c0                	test   %eax,%eax
  1008a2:	74 99                	je     10083d <debuginfo_eip+0x220>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1008a4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1008aa:	39 c2                	cmp    %eax,%edx
  1008ac:	7c 42                	jl     1008f0 <debuginfo_eip+0x2d3>
  1008ae:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008b1:	89 c2                	mov    %eax,%edx
  1008b3:	89 d0                	mov    %edx,%eax
  1008b5:	01 c0                	add    %eax,%eax
  1008b7:	01 d0                	add    %edx,%eax
  1008b9:	c1 e0 02             	shl    $0x2,%eax
  1008bc:	89 c2                	mov    %eax,%edx
  1008be:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008c1:	01 d0                	add    %edx,%eax
  1008c3:	8b 10                	mov    (%eax),%edx
  1008c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1008c8:	2b 45 ec             	sub    -0x14(%ebp),%eax
  1008cb:	39 c2                	cmp    %eax,%edx
  1008cd:	73 21                	jae    1008f0 <debuginfo_eip+0x2d3>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1008cf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008d2:	89 c2                	mov    %eax,%edx
  1008d4:	89 d0                	mov    %edx,%eax
  1008d6:	01 c0                	add    %eax,%eax
  1008d8:	01 d0                	add    %edx,%eax
  1008da:	c1 e0 02             	shl    $0x2,%eax
  1008dd:	89 c2                	mov    %eax,%edx
  1008df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008e2:	01 d0                	add    %edx,%eax
  1008e4:	8b 10                	mov    (%eax),%edx
  1008e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1008e9:	01 c2                	add    %eax,%edx
  1008eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008ee:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1008f0:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1008f3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1008f6:	39 c2                	cmp    %eax,%edx
  1008f8:	7d 46                	jge    100940 <debuginfo_eip+0x323>
        for (lline = lfun + 1;
  1008fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1008fd:	40                   	inc    %eax
  1008fe:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  100901:	eb 16                	jmp    100919 <debuginfo_eip+0x2fc>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100903:	8b 45 0c             	mov    0xc(%ebp),%eax
  100906:	8b 40 14             	mov    0x14(%eax),%eax
  100909:	8d 50 01             	lea    0x1(%eax),%edx
  10090c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10090f:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  100912:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100915:	40                   	inc    %eax
  100916:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100919:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10091c:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  10091f:	39 c2                	cmp    %eax,%edx
  100921:	7d 1d                	jge    100940 <debuginfo_eip+0x323>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100923:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100926:	89 c2                	mov    %eax,%edx
  100928:	89 d0                	mov    %edx,%eax
  10092a:	01 c0                	add    %eax,%eax
  10092c:	01 d0                	add    %edx,%eax
  10092e:	c1 e0 02             	shl    $0x2,%eax
  100931:	89 c2                	mov    %eax,%edx
  100933:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100936:	01 d0                	add    %edx,%eax
  100938:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10093c:	3c a0                	cmp    $0xa0,%al
  10093e:	74 c3                	je     100903 <debuginfo_eip+0x2e6>
        }
    }
    return 0;
  100940:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100945:	c9                   	leave  
  100946:	c3                   	ret    

00100947 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100947:	f3 0f 1e fb          	endbr32 
  10094b:	55                   	push   %ebp
  10094c:	89 e5                	mov    %esp,%ebp
  10094e:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  100951:	c7 04 24 02 37 10 00 	movl   $0x103702,(%esp)
  100958:	e8 27 f9 ff ff       	call   100284 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  10095d:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  100964:	00 
  100965:	c7 04 24 1b 37 10 00 	movl   $0x10371b,(%esp)
  10096c:	e8 13 f9 ff ff       	call   100284 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  100971:	c7 44 24 04 f1 35 10 	movl   $0x1035f1,0x4(%esp)
  100978:	00 
  100979:	c7 04 24 33 37 10 00 	movl   $0x103733,(%esp)
  100980:	e8 ff f8 ff ff       	call   100284 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  100985:	c7 44 24 04 16 fa 10 	movl   $0x10fa16,0x4(%esp)
  10098c:	00 
  10098d:	c7 04 24 4b 37 10 00 	movl   $0x10374b,(%esp)
  100994:	e8 eb f8 ff ff       	call   100284 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  100999:	c7 44 24 04 20 0d 11 	movl   $0x110d20,0x4(%esp)
  1009a0:	00 
  1009a1:	c7 04 24 63 37 10 00 	movl   $0x103763,(%esp)
  1009a8:	e8 d7 f8 ff ff       	call   100284 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1009ad:	b8 20 0d 11 00       	mov    $0x110d20,%eax
  1009b2:	2d 00 00 10 00       	sub    $0x100000,%eax
  1009b7:	05 ff 03 00 00       	add    $0x3ff,%eax
  1009bc:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1009c2:	85 c0                	test   %eax,%eax
  1009c4:	0f 48 c2             	cmovs  %edx,%eax
  1009c7:	c1 f8 0a             	sar    $0xa,%eax
  1009ca:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009ce:	c7 04 24 7c 37 10 00 	movl   $0x10377c,(%esp)
  1009d5:	e8 aa f8 ff ff       	call   100284 <cprintf>
}
  1009da:	90                   	nop
  1009db:	c9                   	leave  
  1009dc:	c3                   	ret    

001009dd <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1009dd:	f3 0f 1e fb          	endbr32 
  1009e1:	55                   	push   %ebp
  1009e2:	89 e5                	mov    %esp,%ebp
  1009e4:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1009ea:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1009ed:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009f1:	8b 45 08             	mov    0x8(%ebp),%eax
  1009f4:	89 04 24             	mov    %eax,(%esp)
  1009f7:	e8 21 fc ff ff       	call   10061d <debuginfo_eip>
  1009fc:	85 c0                	test   %eax,%eax
  1009fe:	74 15                	je     100a15 <print_debuginfo+0x38>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  100a00:	8b 45 08             	mov    0x8(%ebp),%eax
  100a03:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a07:	c7 04 24 a6 37 10 00 	movl   $0x1037a6,(%esp)
  100a0e:	e8 71 f8 ff ff       	call   100284 <cprintf>
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100a13:	eb 6c                	jmp    100a81 <print_debuginfo+0xa4>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a15:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100a1c:	eb 1b                	jmp    100a39 <print_debuginfo+0x5c>
            fnname[j] = info.eip_fn_name[j];
  100a1e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100a21:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a24:	01 d0                	add    %edx,%eax
  100a26:	0f b6 10             	movzbl (%eax),%edx
  100a29:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a32:	01 c8                	add    %ecx,%eax
  100a34:	88 10                	mov    %dl,(%eax)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a36:	ff 45 f4             	incl   -0xc(%ebp)
  100a39:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100a3c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100a3f:	7c dd                	jl     100a1e <print_debuginfo+0x41>
        fnname[j] = '\0';
  100a41:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a4a:	01 d0                	add    %edx,%eax
  100a4c:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100a4f:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100a52:	8b 55 08             	mov    0x8(%ebp),%edx
  100a55:	89 d1                	mov    %edx,%ecx
  100a57:	29 c1                	sub    %eax,%ecx
  100a59:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100a5c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a5f:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  100a63:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a69:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a6d:	89 54 24 08          	mov    %edx,0x8(%esp)
  100a71:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a75:	c7 04 24 c2 37 10 00 	movl   $0x1037c2,(%esp)
  100a7c:	e8 03 f8 ff ff       	call   100284 <cprintf>
}
  100a81:	90                   	nop
  100a82:	c9                   	leave  
  100a83:	c3                   	ret    

00100a84 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100a84:	f3 0f 1e fb          	endbr32 
  100a88:	55                   	push   %ebp
  100a89:	89 e5                	mov    %esp,%ebp
  100a8b:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100a8e:	8b 45 04             	mov    0x4(%ebp),%eax
  100a91:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100a94:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100a97:	c9                   	leave  
  100a98:	c3                   	ret    

00100a99 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100a99:	f3 0f 1e fb          	endbr32 
  100a9d:	55                   	push   %ebp
  100a9e:	89 e5                	mov    %esp,%ebp
  100aa0:	83 ec 38             	sub    $0x38,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100aa3:	89 e8                	mov    %ebp,%eax
  100aa5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return ebp;
  100aa8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
    uint32_t ebp=read_ebp();   //调用read ebp访问当前ebp的值，数据类型为32位。
  100aab:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32_t eip=read_eip();   //调用read eip访问eip的值，数据类型同。
  100aae:	e8 d1 ff ff ff       	call   100a84 <read_eip>
  100ab3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int i;   //这里有个细节问题，就是不能for int i，这里面的C标准似乎不允许
	for(i=0;i<STACKFRAME_DEPTH&&ebp!=0;i++)
  100ab6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100abd:	eb 7c                	jmp    100b3b <print_stackframe+0xa2>
	{
		//(3) from 0 .. STACKFRAME_DEPTH
		cprintf("ebp:0x%08x eip:0x%08x ",ebp,eip);//(3.1)printf value of ebp, eip
  100abf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100ac2:	89 44 24 08          	mov    %eax,0x8(%esp)
  100ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ac9:	89 44 24 04          	mov    %eax,0x4(%esp)
  100acd:	c7 04 24 d4 37 10 00 	movl   $0x1037d4,(%esp)
  100ad4:	e8 ab f7 ff ff       	call   100284 <cprintf>
		for(int j=0;j<4;j++){
  100ad9:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100ae0:	eb 25                	jmp    100b07 <print_stackframe+0x6e>
            	cprintf("0x%08x ",((uint32_t*)ebp+2+j));
  100ae2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100ae5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100aec:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100aef:	01 d0                	add    %edx,%eax
  100af1:	83 c0 08             	add    $0x8,%eax
  100af4:	89 44 24 04          	mov    %eax,0x4(%esp)
  100af8:	c7 04 24 eb 37 10 00 	movl   $0x1037eb,(%esp)
  100aff:	e8 80 f7 ff ff       	call   100284 <cprintf>
		for(int j=0;j<4;j++){
  100b04:	ff 45 e8             	incl   -0x18(%ebp)
  100b07:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100b0b:	7e d5                	jle    100ae2 <print_stackframe+0x49>
        }
		cprintf("\n");
  100b0d:	c7 04 24 f3 37 10 00 	movl   $0x1037f3,(%esp)
  100b14:	e8 6b f7 ff ff       	call   100284 <cprintf>
 
		//因为使用的是栈数据结构，因此可以直接根据ebp就能读取到各个栈帧的地址和值，ebp+4处为返回地址，ebp+8处为第一个参数值（最后一个入栈的参数值，对应32位系统），ebp-4处为第一个局部变量，ebp处为上一层 ebp 值。
 
		//而这里，*代表指针，指针也是占用4个字节，因此可以直接对于指针加一，地址加4。
 
		print_debuginfo(eip-1);	//打印eip以及ebp相关的信息
  100b19:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b1c:	48                   	dec    %eax
  100b1d:	89 04 24             	mov    %eax,(%esp)
  100b20:	e8 b8 fe ff ff       	call   1009dd <print_debuginfo>
		eip=*((uint32_t *)ebp+1);//此时eip指向了返回地址
  100b25:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b28:	83 c0 04             	add    $0x4,%eax
  100b2b:	8b 00                	mov    (%eax),%eax
  100b2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		ebp=*((uint32_t *)ebp+0);//ebp指向了原ebp的位置
  100b30:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b33:	8b 00                	mov    (%eax),%eax
  100b35:	89 45 f4             	mov    %eax,-0xc(%ebp)
	for(i=0;i<STACKFRAME_DEPTH&&ebp!=0;i++)
  100b38:	ff 45 ec             	incl   -0x14(%ebp)
  100b3b:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100b3f:	7f 0a                	jg     100b4b <print_stackframe+0xb2>
  100b41:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b45:	0f 85 74 ff ff ff    	jne    100abf <print_stackframe+0x26>
//最后更新ebp：ebp=ebp[0],更新eip：eip=ebp[1]，因为ebp[0]=ebp，ebp[1]=ebp[0]+4=eip。
	}
}
  100b4b:	90                   	nop
  100b4c:	c9                   	leave  
  100b4d:	c3                   	ret    

00100b4e <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100b4e:	f3 0f 1e fb          	endbr32 
  100b52:	55                   	push   %ebp
  100b53:	89 e5                	mov    %esp,%ebp
  100b55:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100b58:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b5f:	eb 0c                	jmp    100b6d <parse+0x1f>
            *buf ++ = '\0';
  100b61:	8b 45 08             	mov    0x8(%ebp),%eax
  100b64:	8d 50 01             	lea    0x1(%eax),%edx
  100b67:	89 55 08             	mov    %edx,0x8(%ebp)
  100b6a:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  100b70:	0f b6 00             	movzbl (%eax),%eax
  100b73:	84 c0                	test   %al,%al
  100b75:	74 1d                	je     100b94 <parse+0x46>
  100b77:	8b 45 08             	mov    0x8(%ebp),%eax
  100b7a:	0f b6 00             	movzbl (%eax),%eax
  100b7d:	0f be c0             	movsbl %al,%eax
  100b80:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b84:	c7 04 24 78 38 10 00 	movl   $0x103878,(%esp)
  100b8b:	e8 7b 20 00 00       	call   102c0b <strchr>
  100b90:	85 c0                	test   %eax,%eax
  100b92:	75 cd                	jne    100b61 <parse+0x13>
        }
        if (*buf == '\0') {
  100b94:	8b 45 08             	mov    0x8(%ebp),%eax
  100b97:	0f b6 00             	movzbl (%eax),%eax
  100b9a:	84 c0                	test   %al,%al
  100b9c:	74 65                	je     100c03 <parse+0xb5>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100b9e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100ba2:	75 14                	jne    100bb8 <parse+0x6a>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100ba4:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100bab:	00 
  100bac:	c7 04 24 7d 38 10 00 	movl   $0x10387d,(%esp)
  100bb3:	e8 cc f6 ff ff       	call   100284 <cprintf>
        }
        argv[argc ++] = buf;
  100bb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bbb:	8d 50 01             	lea    0x1(%eax),%edx
  100bbe:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100bc1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100bc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  100bcb:	01 c2                	add    %eax,%edx
  100bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  100bd0:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bd2:	eb 03                	jmp    100bd7 <parse+0x89>
            buf ++;
  100bd4:	ff 45 08             	incl   0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  100bda:	0f b6 00             	movzbl (%eax),%eax
  100bdd:	84 c0                	test   %al,%al
  100bdf:	74 8c                	je     100b6d <parse+0x1f>
  100be1:	8b 45 08             	mov    0x8(%ebp),%eax
  100be4:	0f b6 00             	movzbl (%eax),%eax
  100be7:	0f be c0             	movsbl %al,%eax
  100bea:	89 44 24 04          	mov    %eax,0x4(%esp)
  100bee:	c7 04 24 78 38 10 00 	movl   $0x103878,(%esp)
  100bf5:	e8 11 20 00 00       	call   102c0b <strchr>
  100bfa:	85 c0                	test   %eax,%eax
  100bfc:	74 d6                	je     100bd4 <parse+0x86>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100bfe:	e9 6a ff ff ff       	jmp    100b6d <parse+0x1f>
            break;
  100c03:	90                   	nop
        }
    }
    return argc;
  100c04:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100c07:	c9                   	leave  
  100c08:	c3                   	ret    

00100c09 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100c09:	f3 0f 1e fb          	endbr32 
  100c0d:	55                   	push   %ebp
  100c0e:	89 e5                	mov    %esp,%ebp
  100c10:	53                   	push   %ebx
  100c11:	83 ec 64             	sub    $0x64,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100c14:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c17:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  100c1e:	89 04 24             	mov    %eax,(%esp)
  100c21:	e8 28 ff ff ff       	call   100b4e <parse>
  100c26:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100c29:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100c2d:	75 0a                	jne    100c39 <runcmd+0x30>
        return 0;
  100c2f:	b8 00 00 00 00       	mov    $0x0,%eax
  100c34:	e9 83 00 00 00       	jmp    100cbc <runcmd+0xb3>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c39:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c40:	eb 5a                	jmp    100c9c <runcmd+0x93>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100c42:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100c45:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c48:	89 d0                	mov    %edx,%eax
  100c4a:	01 c0                	add    %eax,%eax
  100c4c:	01 d0                	add    %edx,%eax
  100c4e:	c1 e0 02             	shl    $0x2,%eax
  100c51:	05 00 f0 10 00       	add    $0x10f000,%eax
  100c56:	8b 00                	mov    (%eax),%eax
  100c58:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100c5c:	89 04 24             	mov    %eax,(%esp)
  100c5f:	e8 03 1f 00 00       	call   102b67 <strcmp>
  100c64:	85 c0                	test   %eax,%eax
  100c66:	75 31                	jne    100c99 <runcmd+0x90>
            return commands[i].func(argc - 1, argv + 1, tf);
  100c68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c6b:	89 d0                	mov    %edx,%eax
  100c6d:	01 c0                	add    %eax,%eax
  100c6f:	01 d0                	add    %edx,%eax
  100c71:	c1 e0 02             	shl    $0x2,%eax
  100c74:	05 08 f0 10 00       	add    $0x10f008,%eax
  100c79:	8b 10                	mov    (%eax),%edx
  100c7b:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c7e:	83 c0 04             	add    $0x4,%eax
  100c81:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100c84:	8d 59 ff             	lea    -0x1(%ecx),%ebx
  100c87:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  100c8a:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100c8e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c92:	89 1c 24             	mov    %ebx,(%esp)
  100c95:	ff d2                	call   *%edx
  100c97:	eb 23                	jmp    100cbc <runcmd+0xb3>
    for (i = 0; i < NCOMMANDS; i ++) {
  100c99:	ff 45 f4             	incl   -0xc(%ebp)
  100c9c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c9f:	83 f8 02             	cmp    $0x2,%eax
  100ca2:	76 9e                	jbe    100c42 <runcmd+0x39>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100ca4:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100ca7:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cab:	c7 04 24 9b 38 10 00 	movl   $0x10389b,(%esp)
  100cb2:	e8 cd f5 ff ff       	call   100284 <cprintf>
    return 0;
  100cb7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cbc:	83 c4 64             	add    $0x64,%esp
  100cbf:	5b                   	pop    %ebx
  100cc0:	5d                   	pop    %ebp
  100cc1:	c3                   	ret    

00100cc2 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100cc2:	f3 0f 1e fb          	endbr32 
  100cc6:	55                   	push   %ebp
  100cc7:	89 e5                	mov    %esp,%ebp
  100cc9:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100ccc:	c7 04 24 b4 38 10 00 	movl   $0x1038b4,(%esp)
  100cd3:	e8 ac f5 ff ff       	call   100284 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100cd8:	c7 04 24 dc 38 10 00 	movl   $0x1038dc,(%esp)
  100cdf:	e8 a0 f5 ff ff       	call   100284 <cprintf>

    if (tf != NULL) {
  100ce4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100ce8:	74 0b                	je     100cf5 <kmonitor+0x33>
        print_trapframe(tf);
  100cea:	8b 45 08             	mov    0x8(%ebp),%eax
  100ced:	89 04 24             	mov    %eax,(%esp)
  100cf0:	e8 fb 0d 00 00       	call   101af0 <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100cf5:	c7 04 24 01 39 10 00 	movl   $0x103901,(%esp)
  100cfc:	e8 36 f6 ff ff       	call   100337 <readline>
  100d01:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100d04:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100d08:	74 eb                	je     100cf5 <kmonitor+0x33>
            if (runcmd(buf, tf) < 0) {
  100d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  100d0d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d11:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d14:	89 04 24             	mov    %eax,(%esp)
  100d17:	e8 ed fe ff ff       	call   100c09 <runcmd>
  100d1c:	85 c0                	test   %eax,%eax
  100d1e:	78 02                	js     100d22 <kmonitor+0x60>
        if ((buf = readline("K> ")) != NULL) {
  100d20:	eb d3                	jmp    100cf5 <kmonitor+0x33>
                break;
  100d22:	90                   	nop
            }
        }
    }
}
  100d23:	90                   	nop
  100d24:	c9                   	leave  
  100d25:	c3                   	ret    

00100d26 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100d26:	f3 0f 1e fb          	endbr32 
  100d2a:	55                   	push   %ebp
  100d2b:	89 e5                	mov    %esp,%ebp
  100d2d:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100d30:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100d37:	eb 3d                	jmp    100d76 <mon_help+0x50>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100d39:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d3c:	89 d0                	mov    %edx,%eax
  100d3e:	01 c0                	add    %eax,%eax
  100d40:	01 d0                	add    %edx,%eax
  100d42:	c1 e0 02             	shl    $0x2,%eax
  100d45:	05 04 f0 10 00       	add    $0x10f004,%eax
  100d4a:	8b 08                	mov    (%eax),%ecx
  100d4c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d4f:	89 d0                	mov    %edx,%eax
  100d51:	01 c0                	add    %eax,%eax
  100d53:	01 d0                	add    %edx,%eax
  100d55:	c1 e0 02             	shl    $0x2,%eax
  100d58:	05 00 f0 10 00       	add    $0x10f000,%eax
  100d5d:	8b 00                	mov    (%eax),%eax
  100d5f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100d63:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d67:	c7 04 24 05 39 10 00 	movl   $0x103905,(%esp)
  100d6e:	e8 11 f5 ff ff       	call   100284 <cprintf>
    for (i = 0; i < NCOMMANDS; i ++) {
  100d73:	ff 45 f4             	incl   -0xc(%ebp)
  100d76:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d79:	83 f8 02             	cmp    $0x2,%eax
  100d7c:	76 bb                	jbe    100d39 <mon_help+0x13>
    }
    return 0;
  100d7e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d83:	c9                   	leave  
  100d84:	c3                   	ret    

00100d85 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100d85:	f3 0f 1e fb          	endbr32 
  100d89:	55                   	push   %ebp
  100d8a:	89 e5                	mov    %esp,%ebp
  100d8c:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100d8f:	e8 b3 fb ff ff       	call   100947 <print_kerninfo>
    return 0;
  100d94:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d99:	c9                   	leave  
  100d9a:	c3                   	ret    

00100d9b <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100d9b:	f3 0f 1e fb          	endbr32 
  100d9f:	55                   	push   %ebp
  100da0:	89 e5                	mov    %esp,%ebp
  100da2:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100da5:	e8 ef fc ff ff       	call   100a99 <print_stackframe>
    return 0;
  100daa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100daf:	c9                   	leave  
  100db0:	c3                   	ret    

00100db1 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100db1:	f3 0f 1e fb          	endbr32 
  100db5:	55                   	push   %ebp
  100db6:	89 e5                	mov    %esp,%ebp
  100db8:	83 ec 28             	sub    $0x28,%esp
  100dbb:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100dc1:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dc5:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100dc9:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100dcd:	ee                   	out    %al,(%dx)
}
  100dce:	90                   	nop
  100dcf:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100dd5:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dd9:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100ddd:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100de1:	ee                   	out    %al,(%dx)
}
  100de2:	90                   	nop
  100de3:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100de9:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ded:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100df1:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100df5:	ee                   	out    %al,(%dx)
}
  100df6:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100df7:	c7 05 08 09 11 00 00 	movl   $0x0,0x110908
  100dfe:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100e01:	c7 04 24 0e 39 10 00 	movl   $0x10390e,(%esp)
  100e08:	e8 77 f4 ff ff       	call   100284 <cprintf>
    pic_enable(IRQ_TIMER);
  100e0d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100e14:	e8 31 09 00 00       	call   10174a <pic_enable>
}
  100e19:	90                   	nop
  100e1a:	c9                   	leave  
  100e1b:	c3                   	ret    

00100e1c <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100e1c:	f3 0f 1e fb          	endbr32 
  100e20:	55                   	push   %ebp
  100e21:	89 e5                	mov    %esp,%ebp
  100e23:	83 ec 10             	sub    $0x10,%esp
  100e26:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e2c:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e30:	89 c2                	mov    %eax,%edx
  100e32:	ec                   	in     (%dx),%al
  100e33:	88 45 f1             	mov    %al,-0xf(%ebp)
  100e36:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e3c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e40:	89 c2                	mov    %eax,%edx
  100e42:	ec                   	in     (%dx),%al
  100e43:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e46:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e4c:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e50:	89 c2                	mov    %eax,%edx
  100e52:	ec                   	in     (%dx),%al
  100e53:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e56:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100e5c:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e60:	89 c2                	mov    %eax,%edx
  100e62:	ec                   	in     (%dx),%al
  100e63:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e66:	90                   	nop
  100e67:	c9                   	leave  
  100e68:	c3                   	ret    

00100e69 <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100e69:	f3 0f 1e fb          	endbr32 
  100e6d:	55                   	push   %ebp
  100e6e:	89 e5                	mov    %esp,%ebp
  100e70:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100e73:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100e7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e7d:	0f b7 00             	movzwl (%eax),%eax
  100e80:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100e84:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e87:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100e8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e8f:	0f b7 00             	movzwl (%eax),%eax
  100e92:	0f b7 c0             	movzwl %ax,%eax
  100e95:	3d 5a a5 00 00       	cmp    $0xa55a,%eax
  100e9a:	74 12                	je     100eae <cga_init+0x45>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100e9c:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100ea3:	66 c7 05 66 fe 10 00 	movw   $0x3b4,0x10fe66
  100eaa:	b4 03 
  100eac:	eb 13                	jmp    100ec1 <cga_init+0x58>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100eae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100eb1:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100eb5:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100eb8:	66 c7 05 66 fe 10 00 	movw   $0x3d4,0x10fe66
  100ebf:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100ec1:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100ec8:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100ecc:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ed0:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100ed4:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100ed8:	ee                   	out    %al,(%dx)
}
  100ed9:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100eda:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100ee1:	40                   	inc    %eax
  100ee2:	0f b7 c0             	movzwl %ax,%eax
  100ee5:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ee9:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  100eed:	89 c2                	mov    %eax,%edx
  100eef:	ec                   	in     (%dx),%al
  100ef0:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  100ef3:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100ef7:	0f b6 c0             	movzbl %al,%eax
  100efa:	c1 e0 08             	shl    $0x8,%eax
  100efd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100f00:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f07:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100f0b:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f0f:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f13:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f17:	ee                   	out    %al,(%dx)
}
  100f18:	90                   	nop
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100f19:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f20:	40                   	inc    %eax
  100f21:	0f b7 c0             	movzwl %ax,%eax
  100f24:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f28:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100f2c:	89 c2                	mov    %eax,%edx
  100f2e:	ec                   	in     (%dx),%al
  100f2f:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  100f32:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f36:	0f b6 c0             	movzbl %al,%eax
  100f39:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100f3c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f3f:	a3 60 fe 10 00       	mov    %eax,0x10fe60
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100f44:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f47:	0f b7 c0             	movzwl %ax,%eax
  100f4a:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
}
  100f50:	90                   	nop
  100f51:	c9                   	leave  
  100f52:	c3                   	ret    

00100f53 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f53:	f3 0f 1e fb          	endbr32 
  100f57:	55                   	push   %ebp
  100f58:	89 e5                	mov    %esp,%ebp
  100f5a:	83 ec 48             	sub    $0x48,%esp
  100f5d:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  100f63:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f67:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  100f6b:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100f6f:	ee                   	out    %al,(%dx)
}
  100f70:	90                   	nop
  100f71:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  100f77:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f7b:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  100f7f:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100f83:	ee                   	out    %al,(%dx)
}
  100f84:	90                   	nop
  100f85:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  100f8b:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f8f:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  100f93:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100f97:	ee                   	out    %al,(%dx)
}
  100f98:	90                   	nop
  100f99:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100f9f:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fa3:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100fa7:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100fab:	ee                   	out    %al,(%dx)
}
  100fac:	90                   	nop
  100fad:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  100fb3:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fb7:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100fbb:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100fbf:	ee                   	out    %al,(%dx)
}
  100fc0:	90                   	nop
  100fc1:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  100fc7:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fcb:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100fcf:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100fd3:	ee                   	out    %al,(%dx)
}
  100fd4:	90                   	nop
  100fd5:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100fdb:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fdf:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100fe3:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100fe7:	ee                   	out    %al,(%dx)
}
  100fe8:	90                   	nop
  100fe9:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100fef:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100ff3:	89 c2                	mov    %eax,%edx
  100ff5:	ec                   	in     (%dx),%al
  100ff6:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100ff9:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100ffd:	3c ff                	cmp    $0xff,%al
  100fff:	0f 95 c0             	setne  %al
  101002:	0f b6 c0             	movzbl %al,%eax
  101005:	a3 68 fe 10 00       	mov    %eax,0x10fe68
  10100a:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101010:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  101014:	89 c2                	mov    %eax,%edx
  101016:	ec                   	in     (%dx),%al
  101017:	88 45 f1             	mov    %al,-0xf(%ebp)
  10101a:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101020:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101024:	89 c2                	mov    %eax,%edx
  101026:	ec                   	in     (%dx),%al
  101027:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  10102a:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  10102f:	85 c0                	test   %eax,%eax
  101031:	74 0c                	je     10103f <serial_init+0xec>
        pic_enable(IRQ_COM1);
  101033:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  10103a:	e8 0b 07 00 00       	call   10174a <pic_enable>
    }
}
  10103f:	90                   	nop
  101040:	c9                   	leave  
  101041:	c3                   	ret    

00101042 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  101042:	f3 0f 1e fb          	endbr32 
  101046:	55                   	push   %ebp
  101047:	89 e5                	mov    %esp,%ebp
  101049:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  10104c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101053:	eb 08                	jmp    10105d <lpt_putc_sub+0x1b>
        delay();
  101055:	e8 c2 fd ff ff       	call   100e1c <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  10105a:	ff 45 fc             	incl   -0x4(%ebp)
  10105d:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  101063:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101067:	89 c2                	mov    %eax,%edx
  101069:	ec                   	in     (%dx),%al
  10106a:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10106d:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101071:	84 c0                	test   %al,%al
  101073:	78 09                	js     10107e <lpt_putc_sub+0x3c>
  101075:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10107c:	7e d7                	jle    101055 <lpt_putc_sub+0x13>
    }
    outb(LPTPORT + 0, c);
  10107e:	8b 45 08             	mov    0x8(%ebp),%eax
  101081:	0f b6 c0             	movzbl %al,%eax
  101084:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  10108a:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10108d:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101091:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101095:	ee                   	out    %al,(%dx)
}
  101096:	90                   	nop
  101097:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  10109d:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010a1:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1010a5:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1010a9:	ee                   	out    %al,(%dx)
}
  1010aa:	90                   	nop
  1010ab:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  1010b1:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010b5:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1010b9:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1010bd:	ee                   	out    %al,(%dx)
}
  1010be:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  1010bf:	90                   	nop
  1010c0:	c9                   	leave  
  1010c1:	c3                   	ret    

001010c2 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  1010c2:	f3 0f 1e fb          	endbr32 
  1010c6:	55                   	push   %ebp
  1010c7:	89 e5                	mov    %esp,%ebp
  1010c9:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1010cc:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1010d0:	74 0d                	je     1010df <lpt_putc+0x1d>
        lpt_putc_sub(c);
  1010d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1010d5:	89 04 24             	mov    %eax,(%esp)
  1010d8:	e8 65 ff ff ff       	call   101042 <lpt_putc_sub>
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  1010dd:	eb 24                	jmp    101103 <lpt_putc+0x41>
        lpt_putc_sub('\b');
  1010df:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010e6:	e8 57 ff ff ff       	call   101042 <lpt_putc_sub>
        lpt_putc_sub(' ');
  1010eb:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1010f2:	e8 4b ff ff ff       	call   101042 <lpt_putc_sub>
        lpt_putc_sub('\b');
  1010f7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010fe:	e8 3f ff ff ff       	call   101042 <lpt_putc_sub>
}
  101103:	90                   	nop
  101104:	c9                   	leave  
  101105:	c3                   	ret    

00101106 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101106:	f3 0f 1e fb          	endbr32 
  10110a:	55                   	push   %ebp
  10110b:	89 e5                	mov    %esp,%ebp
  10110d:	53                   	push   %ebx
  10110e:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  101111:	8b 45 08             	mov    0x8(%ebp),%eax
  101114:	25 00 ff ff ff       	and    $0xffffff00,%eax
  101119:	85 c0                	test   %eax,%eax
  10111b:	75 07                	jne    101124 <cga_putc+0x1e>
        c |= 0x0700;
  10111d:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  101124:	8b 45 08             	mov    0x8(%ebp),%eax
  101127:	0f b6 c0             	movzbl %al,%eax
  10112a:	83 f8 0d             	cmp    $0xd,%eax
  10112d:	74 72                	je     1011a1 <cga_putc+0x9b>
  10112f:	83 f8 0d             	cmp    $0xd,%eax
  101132:	0f 8f a3 00 00 00    	jg     1011db <cga_putc+0xd5>
  101138:	83 f8 08             	cmp    $0x8,%eax
  10113b:	74 0a                	je     101147 <cga_putc+0x41>
  10113d:	83 f8 0a             	cmp    $0xa,%eax
  101140:	74 4c                	je     10118e <cga_putc+0x88>
  101142:	e9 94 00 00 00       	jmp    1011db <cga_putc+0xd5>
    case '\b':
        if (crt_pos > 0) {
  101147:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10114e:	85 c0                	test   %eax,%eax
  101150:	0f 84 af 00 00 00    	je     101205 <cga_putc+0xff>
            crt_pos --;
  101156:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10115d:	48                   	dec    %eax
  10115e:	0f b7 c0             	movzwl %ax,%eax
  101161:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101167:	8b 45 08             	mov    0x8(%ebp),%eax
  10116a:	98                   	cwtl   
  10116b:	25 00 ff ff ff       	and    $0xffffff00,%eax
  101170:	98                   	cwtl   
  101171:	83 c8 20             	or     $0x20,%eax
  101174:	98                   	cwtl   
  101175:	8b 15 60 fe 10 00    	mov    0x10fe60,%edx
  10117b:	0f b7 0d 64 fe 10 00 	movzwl 0x10fe64,%ecx
  101182:	01 c9                	add    %ecx,%ecx
  101184:	01 ca                	add    %ecx,%edx
  101186:	0f b7 c0             	movzwl %ax,%eax
  101189:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  10118c:	eb 77                	jmp    101205 <cga_putc+0xff>
    case '\n':
        crt_pos += CRT_COLS;
  10118e:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101195:	83 c0 50             	add    $0x50,%eax
  101198:	0f b7 c0             	movzwl %ax,%eax
  10119b:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  1011a1:	0f b7 1d 64 fe 10 00 	movzwl 0x10fe64,%ebx
  1011a8:	0f b7 0d 64 fe 10 00 	movzwl 0x10fe64,%ecx
  1011af:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
  1011b4:	89 c8                	mov    %ecx,%eax
  1011b6:	f7 e2                	mul    %edx
  1011b8:	c1 ea 06             	shr    $0x6,%edx
  1011bb:	89 d0                	mov    %edx,%eax
  1011bd:	c1 e0 02             	shl    $0x2,%eax
  1011c0:	01 d0                	add    %edx,%eax
  1011c2:	c1 e0 04             	shl    $0x4,%eax
  1011c5:	29 c1                	sub    %eax,%ecx
  1011c7:	89 c8                	mov    %ecx,%eax
  1011c9:	0f b7 c0             	movzwl %ax,%eax
  1011cc:	29 c3                	sub    %eax,%ebx
  1011ce:	89 d8                	mov    %ebx,%eax
  1011d0:	0f b7 c0             	movzwl %ax,%eax
  1011d3:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
        break;
  1011d9:	eb 2b                	jmp    101206 <cga_putc+0x100>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1011db:	8b 0d 60 fe 10 00    	mov    0x10fe60,%ecx
  1011e1:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1011e8:	8d 50 01             	lea    0x1(%eax),%edx
  1011eb:	0f b7 d2             	movzwl %dx,%edx
  1011ee:	66 89 15 64 fe 10 00 	mov    %dx,0x10fe64
  1011f5:	01 c0                	add    %eax,%eax
  1011f7:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  1011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  1011fd:	0f b7 c0             	movzwl %ax,%eax
  101200:	66 89 02             	mov    %ax,(%edx)
        break;
  101203:	eb 01                	jmp    101206 <cga_putc+0x100>
        break;
  101205:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101206:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10120d:	3d cf 07 00 00       	cmp    $0x7cf,%eax
  101212:	76 5d                	jbe    101271 <cga_putc+0x16b>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101214:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101219:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  10121f:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101224:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  10122b:	00 
  10122c:	89 54 24 04          	mov    %edx,0x4(%esp)
  101230:	89 04 24             	mov    %eax,(%esp)
  101233:	e8 d8 1b 00 00       	call   102e10 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101238:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  10123f:	eb 14                	jmp    101255 <cga_putc+0x14f>
            crt_buf[i] = 0x0700 | ' ';
  101241:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101246:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101249:	01 d2                	add    %edx,%edx
  10124b:	01 d0                	add    %edx,%eax
  10124d:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101252:	ff 45 f4             	incl   -0xc(%ebp)
  101255:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  10125c:	7e e3                	jle    101241 <cga_putc+0x13b>
        }
        crt_pos -= CRT_COLS;
  10125e:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101265:	83 e8 50             	sub    $0x50,%eax
  101268:	0f b7 c0             	movzwl %ax,%eax
  10126b:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101271:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  101278:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  10127c:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101280:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101284:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101288:	ee                   	out    %al,(%dx)
}
  101289:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
  10128a:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101291:	c1 e8 08             	shr    $0x8,%eax
  101294:	0f b7 c0             	movzwl %ax,%eax
  101297:	0f b6 c0             	movzbl %al,%eax
  10129a:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  1012a1:	42                   	inc    %edx
  1012a2:	0f b7 d2             	movzwl %dx,%edx
  1012a5:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  1012a9:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012ac:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1012b0:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1012b4:	ee                   	out    %al,(%dx)
}
  1012b5:	90                   	nop
    outb(addr_6845, 15);
  1012b6:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  1012bd:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1012c1:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012c5:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1012c9:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1012cd:	ee                   	out    %al,(%dx)
}
  1012ce:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
  1012cf:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1012d6:	0f b6 c0             	movzbl %al,%eax
  1012d9:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  1012e0:	42                   	inc    %edx
  1012e1:	0f b7 d2             	movzwl %dx,%edx
  1012e4:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  1012e8:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012eb:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1012ef:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1012f3:	ee                   	out    %al,(%dx)
}
  1012f4:	90                   	nop
}
  1012f5:	90                   	nop
  1012f6:	83 c4 34             	add    $0x34,%esp
  1012f9:	5b                   	pop    %ebx
  1012fa:	5d                   	pop    %ebp
  1012fb:	c3                   	ret    

001012fc <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  1012fc:	f3 0f 1e fb          	endbr32 
  101300:	55                   	push   %ebp
  101301:	89 e5                	mov    %esp,%ebp
  101303:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101306:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10130d:	eb 08                	jmp    101317 <serial_putc_sub+0x1b>
        delay();
  10130f:	e8 08 fb ff ff       	call   100e1c <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101314:	ff 45 fc             	incl   -0x4(%ebp)
  101317:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10131d:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101321:	89 c2                	mov    %eax,%edx
  101323:	ec                   	in     (%dx),%al
  101324:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101327:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10132b:	0f b6 c0             	movzbl %al,%eax
  10132e:	83 e0 20             	and    $0x20,%eax
  101331:	85 c0                	test   %eax,%eax
  101333:	75 09                	jne    10133e <serial_putc_sub+0x42>
  101335:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10133c:	7e d1                	jle    10130f <serial_putc_sub+0x13>
    }
    outb(COM1 + COM_TX, c);
  10133e:	8b 45 08             	mov    0x8(%ebp),%eax
  101341:	0f b6 c0             	movzbl %al,%eax
  101344:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  10134a:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10134d:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101351:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101355:	ee                   	out    %al,(%dx)
}
  101356:	90                   	nop
}
  101357:	90                   	nop
  101358:	c9                   	leave  
  101359:	c3                   	ret    

0010135a <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  10135a:	f3 0f 1e fb          	endbr32 
  10135e:	55                   	push   %ebp
  10135f:	89 e5                	mov    %esp,%ebp
  101361:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  101364:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101368:	74 0d                	je     101377 <serial_putc+0x1d>
        serial_putc_sub(c);
  10136a:	8b 45 08             	mov    0x8(%ebp),%eax
  10136d:	89 04 24             	mov    %eax,(%esp)
  101370:	e8 87 ff ff ff       	call   1012fc <serial_putc_sub>
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  101375:	eb 24                	jmp    10139b <serial_putc+0x41>
        serial_putc_sub('\b');
  101377:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10137e:	e8 79 ff ff ff       	call   1012fc <serial_putc_sub>
        serial_putc_sub(' ');
  101383:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10138a:	e8 6d ff ff ff       	call   1012fc <serial_putc_sub>
        serial_putc_sub('\b');
  10138f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101396:	e8 61 ff ff ff       	call   1012fc <serial_putc_sub>
}
  10139b:	90                   	nop
  10139c:	c9                   	leave  
  10139d:	c3                   	ret    

0010139e <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  10139e:	f3 0f 1e fb          	endbr32 
  1013a2:	55                   	push   %ebp
  1013a3:	89 e5                	mov    %esp,%ebp
  1013a5:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  1013a8:	eb 33                	jmp    1013dd <cons_intr+0x3f>
        if (c != 0) {
  1013aa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1013ae:	74 2d                	je     1013dd <cons_intr+0x3f>
            cons.buf[cons.wpos ++] = c;
  1013b0:	a1 84 00 11 00       	mov    0x110084,%eax
  1013b5:	8d 50 01             	lea    0x1(%eax),%edx
  1013b8:	89 15 84 00 11 00    	mov    %edx,0x110084
  1013be:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013c1:	88 90 80 fe 10 00    	mov    %dl,0x10fe80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  1013c7:	a1 84 00 11 00       	mov    0x110084,%eax
  1013cc:	3d 00 02 00 00       	cmp    $0x200,%eax
  1013d1:	75 0a                	jne    1013dd <cons_intr+0x3f>
                cons.wpos = 0;
  1013d3:	c7 05 84 00 11 00 00 	movl   $0x0,0x110084
  1013da:	00 00 00 
    while ((c = (*proc)()) != -1) {
  1013dd:	8b 45 08             	mov    0x8(%ebp),%eax
  1013e0:	ff d0                	call   *%eax
  1013e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1013e5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1013e9:	75 bf                	jne    1013aa <cons_intr+0xc>
            }
        }
    }
}
  1013eb:	90                   	nop
  1013ec:	90                   	nop
  1013ed:	c9                   	leave  
  1013ee:	c3                   	ret    

001013ef <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1013ef:	f3 0f 1e fb          	endbr32 
  1013f3:	55                   	push   %ebp
  1013f4:	89 e5                	mov    %esp,%ebp
  1013f6:	83 ec 10             	sub    $0x10,%esp
  1013f9:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013ff:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101403:	89 c2                	mov    %eax,%edx
  101405:	ec                   	in     (%dx),%al
  101406:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101409:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  10140d:	0f b6 c0             	movzbl %al,%eax
  101410:	83 e0 01             	and    $0x1,%eax
  101413:	85 c0                	test   %eax,%eax
  101415:	75 07                	jne    10141e <serial_proc_data+0x2f>
        return -1;
  101417:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10141c:	eb 2a                	jmp    101448 <serial_proc_data+0x59>
  10141e:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101424:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101428:	89 c2                	mov    %eax,%edx
  10142a:	ec                   	in     (%dx),%al
  10142b:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  10142e:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  101432:	0f b6 c0             	movzbl %al,%eax
  101435:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101438:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  10143c:	75 07                	jne    101445 <serial_proc_data+0x56>
        c = '\b';
  10143e:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  101445:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101448:	c9                   	leave  
  101449:	c3                   	ret    

0010144a <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  10144a:	f3 0f 1e fb          	endbr32 
  10144e:	55                   	push   %ebp
  10144f:	89 e5                	mov    %esp,%ebp
  101451:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  101454:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101459:	85 c0                	test   %eax,%eax
  10145b:	74 0c                	je     101469 <serial_intr+0x1f>
        cons_intr(serial_proc_data);
  10145d:	c7 04 24 ef 13 10 00 	movl   $0x1013ef,(%esp)
  101464:	e8 35 ff ff ff       	call   10139e <cons_intr>
    }
}
  101469:	90                   	nop
  10146a:	c9                   	leave  
  10146b:	c3                   	ret    

0010146c <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  10146c:	f3 0f 1e fb          	endbr32 
  101470:	55                   	push   %ebp
  101471:	89 e5                	mov    %esp,%ebp
  101473:	83 ec 38             	sub    $0x38,%esp
  101476:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10147c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10147f:	89 c2                	mov    %eax,%edx
  101481:	ec                   	in     (%dx),%al
  101482:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  101485:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  101489:	0f b6 c0             	movzbl %al,%eax
  10148c:	83 e0 01             	and    $0x1,%eax
  10148f:	85 c0                	test   %eax,%eax
  101491:	75 0a                	jne    10149d <kbd_proc_data+0x31>
        return -1;
  101493:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101498:	e9 56 01 00 00       	jmp    1015f3 <kbd_proc_data+0x187>
  10149d:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1014a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1014a6:	89 c2                	mov    %eax,%edx
  1014a8:	ec                   	in     (%dx),%al
  1014a9:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1014ac:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1014b0:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1014b3:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1014b7:	75 17                	jne    1014d0 <kbd_proc_data+0x64>
        // E0 escape character
        shift |= E0ESC;
  1014b9:	a1 88 00 11 00       	mov    0x110088,%eax
  1014be:	83 c8 40             	or     $0x40,%eax
  1014c1:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  1014c6:	b8 00 00 00 00       	mov    $0x0,%eax
  1014cb:	e9 23 01 00 00       	jmp    1015f3 <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  1014d0:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014d4:	84 c0                	test   %al,%al
  1014d6:	79 45                	jns    10151d <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1014d8:	a1 88 00 11 00       	mov    0x110088,%eax
  1014dd:	83 e0 40             	and    $0x40,%eax
  1014e0:	85 c0                	test   %eax,%eax
  1014e2:	75 08                	jne    1014ec <kbd_proc_data+0x80>
  1014e4:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014e8:	24 7f                	and    $0x7f,%al
  1014ea:	eb 04                	jmp    1014f0 <kbd_proc_data+0x84>
  1014ec:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014f0:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  1014f3:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014f7:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  1014fe:	0c 40                	or     $0x40,%al
  101500:	0f b6 c0             	movzbl %al,%eax
  101503:	f7 d0                	not    %eax
  101505:	89 c2                	mov    %eax,%edx
  101507:	a1 88 00 11 00       	mov    0x110088,%eax
  10150c:	21 d0                	and    %edx,%eax
  10150e:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  101513:	b8 00 00 00 00       	mov    $0x0,%eax
  101518:	e9 d6 00 00 00       	jmp    1015f3 <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  10151d:	a1 88 00 11 00       	mov    0x110088,%eax
  101522:	83 e0 40             	and    $0x40,%eax
  101525:	85 c0                	test   %eax,%eax
  101527:	74 11                	je     10153a <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101529:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  10152d:	a1 88 00 11 00       	mov    0x110088,%eax
  101532:	83 e0 bf             	and    $0xffffffbf,%eax
  101535:	a3 88 00 11 00       	mov    %eax,0x110088
    }

    shift |= shiftcode[data];
  10153a:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10153e:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  101545:	0f b6 d0             	movzbl %al,%edx
  101548:	a1 88 00 11 00       	mov    0x110088,%eax
  10154d:	09 d0                	or     %edx,%eax
  10154f:	a3 88 00 11 00       	mov    %eax,0x110088
    shift ^= togglecode[data];
  101554:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101558:	0f b6 80 40 f1 10 00 	movzbl 0x10f140(%eax),%eax
  10155f:	0f b6 d0             	movzbl %al,%edx
  101562:	a1 88 00 11 00       	mov    0x110088,%eax
  101567:	31 d0                	xor    %edx,%eax
  101569:	a3 88 00 11 00       	mov    %eax,0x110088

    c = charcode[shift & (CTL | SHIFT)][data];
  10156e:	a1 88 00 11 00       	mov    0x110088,%eax
  101573:	83 e0 03             	and    $0x3,%eax
  101576:	8b 14 85 40 f5 10 00 	mov    0x10f540(,%eax,4),%edx
  10157d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101581:	01 d0                	add    %edx,%eax
  101583:	0f b6 00             	movzbl (%eax),%eax
  101586:	0f b6 c0             	movzbl %al,%eax
  101589:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  10158c:	a1 88 00 11 00       	mov    0x110088,%eax
  101591:	83 e0 08             	and    $0x8,%eax
  101594:	85 c0                	test   %eax,%eax
  101596:	74 22                	je     1015ba <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  101598:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  10159c:	7e 0c                	jle    1015aa <kbd_proc_data+0x13e>
  10159e:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1015a2:	7f 06                	jg     1015aa <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  1015a4:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1015a8:	eb 10                	jmp    1015ba <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  1015aa:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1015ae:	7e 0a                	jle    1015ba <kbd_proc_data+0x14e>
  1015b0:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1015b4:	7f 04                	jg     1015ba <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  1015b6:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1015ba:	a1 88 00 11 00       	mov    0x110088,%eax
  1015bf:	f7 d0                	not    %eax
  1015c1:	83 e0 06             	and    $0x6,%eax
  1015c4:	85 c0                	test   %eax,%eax
  1015c6:	75 28                	jne    1015f0 <kbd_proc_data+0x184>
  1015c8:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1015cf:	75 1f                	jne    1015f0 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  1015d1:	c7 04 24 29 39 10 00 	movl   $0x103929,(%esp)
  1015d8:	e8 a7 ec ff ff       	call   100284 <cprintf>
  1015dd:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1015e3:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1015e7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  1015eb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1015ee:	ee                   	out    %al,(%dx)
}
  1015ef:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  1015f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1015f3:	c9                   	leave  
  1015f4:	c3                   	ret    

001015f5 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  1015f5:	f3 0f 1e fb          	endbr32 
  1015f9:	55                   	push   %ebp
  1015fa:	89 e5                	mov    %esp,%ebp
  1015fc:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  1015ff:	c7 04 24 6c 14 10 00 	movl   $0x10146c,(%esp)
  101606:	e8 93 fd ff ff       	call   10139e <cons_intr>
}
  10160b:	90                   	nop
  10160c:	c9                   	leave  
  10160d:	c3                   	ret    

0010160e <kbd_init>:

static void
kbd_init(void) {
  10160e:	f3 0f 1e fb          	endbr32 
  101612:	55                   	push   %ebp
  101613:	89 e5                	mov    %esp,%ebp
  101615:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  101618:	e8 d8 ff ff ff       	call   1015f5 <kbd_intr>
    pic_enable(IRQ_KBD);
  10161d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  101624:	e8 21 01 00 00       	call   10174a <pic_enable>
}
  101629:	90                   	nop
  10162a:	c9                   	leave  
  10162b:	c3                   	ret    

0010162c <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  10162c:	f3 0f 1e fb          	endbr32 
  101630:	55                   	push   %ebp
  101631:	89 e5                	mov    %esp,%ebp
  101633:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  101636:	e8 2e f8 ff ff       	call   100e69 <cga_init>
    serial_init();
  10163b:	e8 13 f9 ff ff       	call   100f53 <serial_init>
    kbd_init();
  101640:	e8 c9 ff ff ff       	call   10160e <kbd_init>
    if (!serial_exists) {
  101645:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  10164a:	85 c0                	test   %eax,%eax
  10164c:	75 0c                	jne    10165a <cons_init+0x2e>
        cprintf("serial port does not exist!!\n");
  10164e:	c7 04 24 35 39 10 00 	movl   $0x103935,(%esp)
  101655:	e8 2a ec ff ff       	call   100284 <cprintf>
    }
}
  10165a:	90                   	nop
  10165b:	c9                   	leave  
  10165c:	c3                   	ret    

0010165d <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  10165d:	f3 0f 1e fb          	endbr32 
  101661:	55                   	push   %ebp
  101662:	89 e5                	mov    %esp,%ebp
  101664:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  101667:	8b 45 08             	mov    0x8(%ebp),%eax
  10166a:	89 04 24             	mov    %eax,(%esp)
  10166d:	e8 50 fa ff ff       	call   1010c2 <lpt_putc>
    cga_putc(c);
  101672:	8b 45 08             	mov    0x8(%ebp),%eax
  101675:	89 04 24             	mov    %eax,(%esp)
  101678:	e8 89 fa ff ff       	call   101106 <cga_putc>
    serial_putc(c);
  10167d:	8b 45 08             	mov    0x8(%ebp),%eax
  101680:	89 04 24             	mov    %eax,(%esp)
  101683:	e8 d2 fc ff ff       	call   10135a <serial_putc>
}
  101688:	90                   	nop
  101689:	c9                   	leave  
  10168a:	c3                   	ret    

0010168b <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  10168b:	f3 0f 1e fb          	endbr32 
  10168f:	55                   	push   %ebp
  101690:	89 e5                	mov    %esp,%ebp
  101692:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  101695:	e8 b0 fd ff ff       	call   10144a <serial_intr>
    kbd_intr();
  10169a:	e8 56 ff ff ff       	call   1015f5 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  10169f:	8b 15 80 00 11 00    	mov    0x110080,%edx
  1016a5:	a1 84 00 11 00       	mov    0x110084,%eax
  1016aa:	39 c2                	cmp    %eax,%edx
  1016ac:	74 36                	je     1016e4 <cons_getc+0x59>
        c = cons.buf[cons.rpos ++];
  1016ae:	a1 80 00 11 00       	mov    0x110080,%eax
  1016b3:	8d 50 01             	lea    0x1(%eax),%edx
  1016b6:	89 15 80 00 11 00    	mov    %edx,0x110080
  1016bc:	0f b6 80 80 fe 10 00 	movzbl 0x10fe80(%eax),%eax
  1016c3:	0f b6 c0             	movzbl %al,%eax
  1016c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  1016c9:	a1 80 00 11 00       	mov    0x110080,%eax
  1016ce:	3d 00 02 00 00       	cmp    $0x200,%eax
  1016d3:	75 0a                	jne    1016df <cons_getc+0x54>
            cons.rpos = 0;
  1016d5:	c7 05 80 00 11 00 00 	movl   $0x0,0x110080
  1016dc:	00 00 00 
        }
        return c;
  1016df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1016e2:	eb 05                	jmp    1016e9 <cons_getc+0x5e>
    }
    return 0;
  1016e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1016e9:	c9                   	leave  
  1016ea:	c3                   	ret    

001016eb <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  1016eb:	f3 0f 1e fb          	endbr32 
  1016ef:	55                   	push   %ebp
  1016f0:	89 e5                	mov    %esp,%ebp
  1016f2:	83 ec 14             	sub    $0x14,%esp
  1016f5:	8b 45 08             	mov    0x8(%ebp),%eax
  1016f8:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  1016fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1016ff:	66 a3 50 f5 10 00    	mov    %ax,0x10f550
    if (did_init) {
  101705:	a1 8c 00 11 00       	mov    0x11008c,%eax
  10170a:	85 c0                	test   %eax,%eax
  10170c:	74 39                	je     101747 <pic_setmask+0x5c>
        outb(IO_PIC1 + 1, mask);
  10170e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  101711:	0f b6 c0             	movzbl %al,%eax
  101714:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  10171a:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10171d:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101721:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101725:	ee                   	out    %al,(%dx)
}
  101726:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
  101727:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10172b:	c1 e8 08             	shr    $0x8,%eax
  10172e:	0f b7 c0             	movzwl %ax,%eax
  101731:	0f b6 c0             	movzbl %al,%eax
  101734:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  10173a:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10173d:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101741:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101745:	ee                   	out    %al,(%dx)
}
  101746:	90                   	nop
    }
}
  101747:	90                   	nop
  101748:	c9                   	leave  
  101749:	c3                   	ret    

0010174a <pic_enable>:

void
pic_enable(unsigned int irq) {
  10174a:	f3 0f 1e fb          	endbr32 
  10174e:	55                   	push   %ebp
  10174f:	89 e5                	mov    %esp,%ebp
  101751:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  101754:	8b 45 08             	mov    0x8(%ebp),%eax
  101757:	ba 01 00 00 00       	mov    $0x1,%edx
  10175c:	88 c1                	mov    %al,%cl
  10175e:	d3 e2                	shl    %cl,%edx
  101760:	89 d0                	mov    %edx,%eax
  101762:	98                   	cwtl   
  101763:	f7 d0                	not    %eax
  101765:	0f bf d0             	movswl %ax,%edx
  101768:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  10176f:	98                   	cwtl   
  101770:	21 d0                	and    %edx,%eax
  101772:	98                   	cwtl   
  101773:	0f b7 c0             	movzwl %ax,%eax
  101776:	89 04 24             	mov    %eax,(%esp)
  101779:	e8 6d ff ff ff       	call   1016eb <pic_setmask>
}
  10177e:	90                   	nop
  10177f:	c9                   	leave  
  101780:	c3                   	ret    

00101781 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  101781:	f3 0f 1e fb          	endbr32 
  101785:	55                   	push   %ebp
  101786:	89 e5                	mov    %esp,%ebp
  101788:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  10178b:	c7 05 8c 00 11 00 01 	movl   $0x1,0x11008c
  101792:	00 00 00 
  101795:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  10179b:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10179f:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1017a3:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1017a7:	ee                   	out    %al,(%dx)
}
  1017a8:	90                   	nop
  1017a9:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  1017af:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017b3:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1017b7:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1017bb:	ee                   	out    %al,(%dx)
}
  1017bc:	90                   	nop
  1017bd:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1017c3:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017c7:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017cb:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017cf:	ee                   	out    %al,(%dx)
}
  1017d0:	90                   	nop
  1017d1:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  1017d7:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017db:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1017df:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1017e3:	ee                   	out    %al,(%dx)
}
  1017e4:	90                   	nop
  1017e5:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  1017eb:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017ef:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  1017f3:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  1017f7:	ee                   	out    %al,(%dx)
}
  1017f8:	90                   	nop
  1017f9:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  1017ff:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101803:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  101807:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  10180b:	ee                   	out    %al,(%dx)
}
  10180c:	90                   	nop
  10180d:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  101813:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101817:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  10181b:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  10181f:	ee                   	out    %al,(%dx)
}
  101820:	90                   	nop
  101821:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  101827:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10182b:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10182f:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101833:	ee                   	out    %al,(%dx)
}
  101834:	90                   	nop
  101835:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  10183b:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10183f:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101843:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101847:	ee                   	out    %al,(%dx)
}
  101848:	90                   	nop
  101849:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  10184f:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101853:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101857:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10185b:	ee                   	out    %al,(%dx)
}
  10185c:	90                   	nop
  10185d:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101863:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101867:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10186b:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10186f:	ee                   	out    %al,(%dx)
}
  101870:	90                   	nop
  101871:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101877:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10187b:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10187f:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101883:	ee                   	out    %al,(%dx)
}
  101884:	90                   	nop
  101885:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  10188b:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10188f:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101893:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101897:	ee                   	out    %al,(%dx)
}
  101898:	90                   	nop
  101899:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  10189f:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018a3:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1018a7:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1018ab:	ee                   	out    %al,(%dx)
}
  1018ac:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1018ad:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  1018b4:	3d ff ff 00 00       	cmp    $0xffff,%eax
  1018b9:	74 0f                	je     1018ca <pic_init+0x149>
        pic_setmask(irq_mask);
  1018bb:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  1018c2:	89 04 24             	mov    %eax,(%esp)
  1018c5:	e8 21 fe ff ff       	call   1016eb <pic_setmask>
    }
}
  1018ca:	90                   	nop
  1018cb:	c9                   	leave  
  1018cc:	c3                   	ret    

001018cd <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1018cd:	f3 0f 1e fb          	endbr32 
  1018d1:	55                   	push   %ebp
  1018d2:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1018d4:	fb                   	sti    
}
  1018d5:	90                   	nop
    sti();
}
  1018d6:	90                   	nop
  1018d7:	5d                   	pop    %ebp
  1018d8:	c3                   	ret    

001018d9 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1018d9:	f3 0f 1e fb          	endbr32 
  1018dd:	55                   	push   %ebp
  1018de:	89 e5                	mov    %esp,%ebp

static inline void
cli(void) {
    asm volatile ("cli");
  1018e0:	fa                   	cli    
}
  1018e1:	90                   	nop
    cli();
}
  1018e2:	90                   	nop
  1018e3:	5d                   	pop    %ebp
  1018e4:	c3                   	ret    

001018e5 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  1018e5:	f3 0f 1e fb          	endbr32 
  1018e9:	55                   	push   %ebp
  1018ea:	89 e5                	mov    %esp,%ebp
  1018ec:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  1018ef:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  1018f6:	00 
  1018f7:	c7 04 24 60 39 10 00 	movl   $0x103960,(%esp)
  1018fe:	e8 81 e9 ff ff       	call   100284 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
  101903:	c7 04 24 6a 39 10 00 	movl   $0x10396a,(%esp)
  10190a:	e8 75 e9 ff ff       	call   100284 <cprintf>
    panic("EOT: kernel seems ok.");
  10190f:	c7 44 24 08 78 39 10 	movl   $0x103978,0x8(%esp)
  101916:	00 
  101917:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
  10191e:	00 
  10191f:	c7 04 24 8e 39 10 00 	movl   $0x10398e,(%esp)
  101926:	e8 c5 ea ff ff       	call   1003f0 <__panic>

0010192b <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  10192b:	f3 0f 1e fb          	endbr32 
  10192f:	55                   	push   %ebp
  101930:	89 e5                	mov    %esp,%ebp
  101932:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[]; 
    int i;
    for(i=0; i<sizeof(idt)/sizeof(struct gatedesc);i++){
  101935:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10193c:	e9 c4 00 00 00       	jmp    101a05 <idt_init+0xda>
        //�ɸ��ļ���֪�������ж��������жϴ���������ַ��������__vectors�����У��������е�i��Ԫ�ض�Ӧ��i���ж��������жϴ���������ַ��
        //�������ļ���ͷ��֪���жϴ�����������.text�����ݡ���ˣ��жϴ��������Ķ�ѡ���Ӽ�.text�Ķ�ѡ����GD_KTEXT��
        //��kern / mm / pmm.c��֪.text�Ķλ�ַΪ0������жϴ���������ַ��ƫ�����������ַ������
        //dpl  DPL_KERNEL
        // ����T_SWITCH_TOK��DPL_USER��������DPL_KERNEL��
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);//��ʼ��idt
  101941:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101944:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  10194b:	0f b7 d0             	movzwl %ax,%edx
  10194e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101951:	66 89 14 c5 a0 00 11 	mov    %dx,0x1100a0(,%eax,8)
  101958:	00 
  101959:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10195c:	66 c7 04 c5 a2 00 11 	movw   $0x8,0x1100a2(,%eax,8)
  101963:	00 08 00 
  101966:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101969:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  101970:	00 
  101971:	80 e2 e0             	and    $0xe0,%dl
  101974:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  10197b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10197e:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  101985:	00 
  101986:	80 e2 1f             	and    $0x1f,%dl
  101989:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  101990:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101993:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  10199a:	00 
  10199b:	80 e2 f0             	and    $0xf0,%dl
  10199e:	80 ca 0e             	or     $0xe,%dl
  1019a1:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019ab:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019b2:	00 
  1019b3:	80 e2 ef             	and    $0xef,%dl
  1019b6:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019c0:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019c7:	00 
  1019c8:	80 e2 9f             	and    $0x9f,%dl
  1019cb:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019d5:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019dc:	00 
  1019dd:	80 ca 80             	or     $0x80,%dl
  1019e0:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019ea:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  1019f1:	c1 e8 10             	shr    $0x10,%eax
  1019f4:	0f b7 d0             	movzwl %ax,%edx
  1019f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019fa:	66 89 14 c5 a6 00 11 	mov    %dx,0x1100a6(,%eax,8)
  101a01:	00 
    for(i=0; i<sizeof(idt)/sizeof(struct gatedesc);i++){
  101a02:	ff 45 fc             	incl   -0x4(%ebp)
  101a05:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a08:	3d ff 00 00 00       	cmp    $0xff,%eax
  101a0d:	0f 86 2e ff ff ff    	jbe    101941 <idt_init+0x16>
    } 
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);//��Ϊ�ڷ����ж�ʱ��������Ҫ���û�̬�л����ں�̬�����Ե����������û�̬����
  101a13:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101a18:	0f b7 c0             	movzwl %ax,%eax
  101a1b:	66 a3 68 04 11 00    	mov    %ax,0x110468
  101a21:	66 c7 05 6a 04 11 00 	movw   $0x8,0x11046a
  101a28:	08 00 
  101a2a:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a31:	24 e0                	and    $0xe0,%al
  101a33:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a38:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a3f:	24 1f                	and    $0x1f,%al
  101a41:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a46:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a4d:	24 f0                	and    $0xf0,%al
  101a4f:	0c 0e                	or     $0xe,%al
  101a51:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a56:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a5d:	24 ef                	and    $0xef,%al
  101a5f:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a64:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a6b:	0c 60                	or     $0x60,%al
  101a6d:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a72:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a79:	0c 80                	or     $0x80,%al
  101a7b:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a80:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101a85:	c1 e8 10             	shr    $0x10,%eax
  101a88:	0f b7 c0             	movzwl %ax,%eax
  101a8b:	66 a3 6e 04 11 00    	mov    %ax,0x11046e
  101a91:	c7 45 f8 60 f5 10 00 	movl   $0x10f560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101a98:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101a9b:	0f 01 18             	lidtl  (%eax)
}
  101a9e:	90                   	nop
    lidt(&idt_pd);
}
  101a9f:	90                   	nop
  101aa0:	c9                   	leave  
  101aa1:	c3                   	ret    

00101aa2 <trapname>:

static const char *
trapname(int trapno) {
  101aa2:	f3 0f 1e fb          	endbr32 
  101aa6:	55                   	push   %ebp
  101aa7:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  101aac:	83 f8 13             	cmp    $0x13,%eax
  101aaf:	77 0c                	ja     101abd <trapname+0x1b>
        return excnames[trapno];
  101ab1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ab4:	8b 04 85 e0 3c 10 00 	mov    0x103ce0(,%eax,4),%eax
  101abb:	eb 18                	jmp    101ad5 <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101abd:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101ac1:	7e 0d                	jle    101ad0 <trapname+0x2e>
  101ac3:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101ac7:	7f 07                	jg     101ad0 <trapname+0x2e>
        return "Hardware Interrupt";
  101ac9:	b8 9f 39 10 00       	mov    $0x10399f,%eax
  101ace:	eb 05                	jmp    101ad5 <trapname+0x33>
    }
    return "(unknown trap)";
  101ad0:	b8 b2 39 10 00       	mov    $0x1039b2,%eax
}
  101ad5:	5d                   	pop    %ebp
  101ad6:	c3                   	ret    

00101ad7 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101ad7:	f3 0f 1e fb          	endbr32 
  101adb:	55                   	push   %ebp
  101adc:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101ade:	8b 45 08             	mov    0x8(%ebp),%eax
  101ae1:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ae5:	83 f8 08             	cmp    $0x8,%eax
  101ae8:	0f 94 c0             	sete   %al
  101aeb:	0f b6 c0             	movzbl %al,%eax
}
  101aee:	5d                   	pop    %ebp
  101aef:	c3                   	ret    

00101af0 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101af0:	f3 0f 1e fb          	endbr32 
  101af4:	55                   	push   %ebp
  101af5:	89 e5                	mov    %esp,%ebp
  101af7:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101afa:	8b 45 08             	mov    0x8(%ebp),%eax
  101afd:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b01:	c7 04 24 f3 39 10 00 	movl   $0x1039f3,(%esp)
  101b08:	e8 77 e7 ff ff       	call   100284 <cprintf>
    print_regs(&tf->tf_regs);
  101b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  101b10:	89 04 24             	mov    %eax,(%esp)
  101b13:	e8 8d 01 00 00       	call   101ca5 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101b18:	8b 45 08             	mov    0x8(%ebp),%eax
  101b1b:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101b1f:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b23:	c7 04 24 04 3a 10 00 	movl   $0x103a04,(%esp)
  101b2a:	e8 55 e7 ff ff       	call   100284 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  101b32:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101b36:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b3a:	c7 04 24 17 3a 10 00 	movl   $0x103a17,(%esp)
  101b41:	e8 3e e7 ff ff       	call   100284 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101b46:	8b 45 08             	mov    0x8(%ebp),%eax
  101b49:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101b4d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b51:	c7 04 24 2a 3a 10 00 	movl   $0x103a2a,(%esp)
  101b58:	e8 27 e7 ff ff       	call   100284 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  101b60:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101b64:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b68:	c7 04 24 3d 3a 10 00 	movl   $0x103a3d,(%esp)
  101b6f:	e8 10 e7 ff ff       	call   100284 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101b74:	8b 45 08             	mov    0x8(%ebp),%eax
  101b77:	8b 40 30             	mov    0x30(%eax),%eax
  101b7a:	89 04 24             	mov    %eax,(%esp)
  101b7d:	e8 20 ff ff ff       	call   101aa2 <trapname>
  101b82:	8b 55 08             	mov    0x8(%ebp),%edx
  101b85:	8b 52 30             	mov    0x30(%edx),%edx
  101b88:	89 44 24 08          	mov    %eax,0x8(%esp)
  101b8c:	89 54 24 04          	mov    %edx,0x4(%esp)
  101b90:	c7 04 24 50 3a 10 00 	movl   $0x103a50,(%esp)
  101b97:	e8 e8 e6 ff ff       	call   100284 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101b9c:	8b 45 08             	mov    0x8(%ebp),%eax
  101b9f:	8b 40 34             	mov    0x34(%eax),%eax
  101ba2:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ba6:	c7 04 24 62 3a 10 00 	movl   $0x103a62,(%esp)
  101bad:	e8 d2 e6 ff ff       	call   100284 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101bb2:	8b 45 08             	mov    0x8(%ebp),%eax
  101bb5:	8b 40 38             	mov    0x38(%eax),%eax
  101bb8:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bbc:	c7 04 24 71 3a 10 00 	movl   $0x103a71,(%esp)
  101bc3:	e8 bc e6 ff ff       	call   100284 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  101bcb:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101bcf:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bd3:	c7 04 24 80 3a 10 00 	movl   $0x103a80,(%esp)
  101bda:	e8 a5 e6 ff ff       	call   100284 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  101be2:	8b 40 40             	mov    0x40(%eax),%eax
  101be5:	89 44 24 04          	mov    %eax,0x4(%esp)
  101be9:	c7 04 24 93 3a 10 00 	movl   $0x103a93,(%esp)
  101bf0:	e8 8f e6 ff ff       	call   100284 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101bf5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101bfc:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101c03:	eb 3d                	jmp    101c42 <print_trapframe+0x152>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101c05:	8b 45 08             	mov    0x8(%ebp),%eax
  101c08:	8b 50 40             	mov    0x40(%eax),%edx
  101c0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c0e:	21 d0                	and    %edx,%eax
  101c10:	85 c0                	test   %eax,%eax
  101c12:	74 28                	je     101c3c <print_trapframe+0x14c>
  101c14:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c17:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c1e:	85 c0                	test   %eax,%eax
  101c20:	74 1a                	je     101c3c <print_trapframe+0x14c>
            cprintf("%s,", IA32flags[i]);
  101c22:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c25:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c2c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c30:	c7 04 24 a2 3a 10 00 	movl   $0x103aa2,(%esp)
  101c37:	e8 48 e6 ff ff       	call   100284 <cprintf>
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c3c:	ff 45 f4             	incl   -0xc(%ebp)
  101c3f:	d1 65 f0             	shll   -0x10(%ebp)
  101c42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c45:	83 f8 17             	cmp    $0x17,%eax
  101c48:	76 bb                	jbe    101c05 <print_trapframe+0x115>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  101c4d:	8b 40 40             	mov    0x40(%eax),%eax
  101c50:	c1 e8 0c             	shr    $0xc,%eax
  101c53:	83 e0 03             	and    $0x3,%eax
  101c56:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c5a:	c7 04 24 a6 3a 10 00 	movl   $0x103aa6,(%esp)
  101c61:	e8 1e e6 ff ff       	call   100284 <cprintf>

    if (!trap_in_kernel(tf)) {
  101c66:	8b 45 08             	mov    0x8(%ebp),%eax
  101c69:	89 04 24             	mov    %eax,(%esp)
  101c6c:	e8 66 fe ff ff       	call   101ad7 <trap_in_kernel>
  101c71:	85 c0                	test   %eax,%eax
  101c73:	75 2d                	jne    101ca2 <print_trapframe+0x1b2>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101c75:	8b 45 08             	mov    0x8(%ebp),%eax
  101c78:	8b 40 44             	mov    0x44(%eax),%eax
  101c7b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c7f:	c7 04 24 af 3a 10 00 	movl   $0x103aaf,(%esp)
  101c86:	e8 f9 e5 ff ff       	call   100284 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101c8b:	8b 45 08             	mov    0x8(%ebp),%eax
  101c8e:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101c92:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c96:	c7 04 24 be 3a 10 00 	movl   $0x103abe,(%esp)
  101c9d:	e8 e2 e5 ff ff       	call   100284 <cprintf>
    }
}
  101ca2:	90                   	nop
  101ca3:	c9                   	leave  
  101ca4:	c3                   	ret    

00101ca5 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101ca5:	f3 0f 1e fb          	endbr32 
  101ca9:	55                   	push   %ebp
  101caa:	89 e5                	mov    %esp,%ebp
  101cac:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101caf:	8b 45 08             	mov    0x8(%ebp),%eax
  101cb2:	8b 00                	mov    (%eax),%eax
  101cb4:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cb8:	c7 04 24 d1 3a 10 00 	movl   $0x103ad1,(%esp)
  101cbf:	e8 c0 e5 ff ff       	call   100284 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101cc4:	8b 45 08             	mov    0x8(%ebp),%eax
  101cc7:	8b 40 04             	mov    0x4(%eax),%eax
  101cca:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cce:	c7 04 24 e0 3a 10 00 	movl   $0x103ae0,(%esp)
  101cd5:	e8 aa e5 ff ff       	call   100284 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101cda:	8b 45 08             	mov    0x8(%ebp),%eax
  101cdd:	8b 40 08             	mov    0x8(%eax),%eax
  101ce0:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ce4:	c7 04 24 ef 3a 10 00 	movl   $0x103aef,(%esp)
  101ceb:	e8 94 e5 ff ff       	call   100284 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  101cf3:	8b 40 0c             	mov    0xc(%eax),%eax
  101cf6:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cfa:	c7 04 24 fe 3a 10 00 	movl   $0x103afe,(%esp)
  101d01:	e8 7e e5 ff ff       	call   100284 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101d06:	8b 45 08             	mov    0x8(%ebp),%eax
  101d09:	8b 40 10             	mov    0x10(%eax),%eax
  101d0c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d10:	c7 04 24 0d 3b 10 00 	movl   $0x103b0d,(%esp)
  101d17:	e8 68 e5 ff ff       	call   100284 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  101d1f:	8b 40 14             	mov    0x14(%eax),%eax
  101d22:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d26:	c7 04 24 1c 3b 10 00 	movl   $0x103b1c,(%esp)
  101d2d:	e8 52 e5 ff ff       	call   100284 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101d32:	8b 45 08             	mov    0x8(%ebp),%eax
  101d35:	8b 40 18             	mov    0x18(%eax),%eax
  101d38:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d3c:	c7 04 24 2b 3b 10 00 	movl   $0x103b2b,(%esp)
  101d43:	e8 3c e5 ff ff       	call   100284 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101d48:	8b 45 08             	mov    0x8(%ebp),%eax
  101d4b:	8b 40 1c             	mov    0x1c(%eax),%eax
  101d4e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d52:	c7 04 24 3a 3b 10 00 	movl   $0x103b3a,(%esp)
  101d59:	e8 26 e5 ff ff       	call   100284 <cprintf>
}
  101d5e:	90                   	nop
  101d5f:	c9                   	leave  
  101d60:	c3                   	ret    

00101d61 <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101d61:	f3 0f 1e fb          	endbr32 
  101d65:	55                   	push   %ebp
  101d66:	89 e5                	mov    %esp,%ebp
  101d68:	83 ec 28             	sub    $0x28,%esp
    char c;

    switch (tf->tf_trapno) {
  101d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  101d6e:	8b 40 30             	mov    0x30(%eax),%eax
  101d71:	83 f8 79             	cmp    $0x79,%eax
  101d74:	0f 87 e6 00 00 00    	ja     101e60 <trap_dispatch+0xff>
  101d7a:	83 f8 78             	cmp    $0x78,%eax
  101d7d:	0f 83 c1 00 00 00    	jae    101e44 <trap_dispatch+0xe3>
  101d83:	83 f8 2f             	cmp    $0x2f,%eax
  101d86:	0f 87 d4 00 00 00    	ja     101e60 <trap_dispatch+0xff>
  101d8c:	83 f8 2e             	cmp    $0x2e,%eax
  101d8f:	0f 83 00 01 00 00    	jae    101e95 <trap_dispatch+0x134>
  101d95:	83 f8 24             	cmp    $0x24,%eax
  101d98:	74 5e                	je     101df8 <trap_dispatch+0x97>
  101d9a:	83 f8 24             	cmp    $0x24,%eax
  101d9d:	0f 87 bd 00 00 00    	ja     101e60 <trap_dispatch+0xff>
  101da3:	83 f8 20             	cmp    $0x20,%eax
  101da6:	74 0a                	je     101db2 <trap_dispatch+0x51>
  101da8:	83 f8 21             	cmp    $0x21,%eax
  101dab:	74 71                	je     101e1e <trap_dispatch+0xbd>
  101dad:	e9 ae 00 00 00       	jmp    101e60 <trap_dispatch+0xff>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks++;
  101db2:	a1 08 09 11 00       	mov    0x110908,%eax
  101db7:	40                   	inc    %eax
  101db8:	a3 08 09 11 00       	mov    %eax,0x110908
        if(ticks%TICK_NUM==0){
  101dbd:	8b 0d 08 09 11 00    	mov    0x110908,%ecx
  101dc3:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101dc8:	89 c8                	mov    %ecx,%eax
  101dca:	f7 e2                	mul    %edx
  101dcc:	c1 ea 05             	shr    $0x5,%edx
  101dcf:	89 d0                	mov    %edx,%eax
  101dd1:	c1 e0 02             	shl    $0x2,%eax
  101dd4:	01 d0                	add    %edx,%eax
  101dd6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  101ddd:	01 d0                	add    %edx,%eax
  101ddf:	c1 e0 02             	shl    $0x2,%eax
  101de2:	29 c1                	sub    %eax,%ecx
  101de4:	89 ca                	mov    %ecx,%edx
  101de6:	85 d2                	test   %edx,%edx
  101de8:	0f 85 aa 00 00 00    	jne    101e98 <trap_dispatch+0x137>
            print_ticks();
  101dee:	e8 f2 fa ff ff       	call   1018e5 <print_ticks>
        }
        break;
  101df3:	e9 a0 00 00 00       	jmp    101e98 <trap_dispatch+0x137>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101df8:	e8 8e f8 ff ff       	call   10168b <cons_getc>
  101dfd:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101e00:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e04:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e08:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e0c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e10:	c7 04 24 49 3b 10 00 	movl   $0x103b49,(%esp)
  101e17:	e8 68 e4 ff ff       	call   100284 <cprintf>
        break;
  101e1c:	eb 7b                	jmp    101e99 <trap_dispatch+0x138>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101e1e:	e8 68 f8 ff ff       	call   10168b <cons_getc>
  101e23:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101e26:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e2a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e2e:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e32:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e36:	c7 04 24 5b 3b 10 00 	movl   $0x103b5b,(%esp)
  101e3d:	e8 42 e4 ff ff       	call   100284 <cprintf>
        break;
  101e42:	eb 55                	jmp    101e99 <trap_dispatch+0x138>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
  101e44:	c7 44 24 08 6a 3b 10 	movl   $0x103b6a,0x8(%esp)
  101e4b:	00 
  101e4c:	c7 44 24 04 cd 00 00 	movl   $0xcd,0x4(%esp)
  101e53:	00 
  101e54:	c7 04 24 8e 39 10 00 	movl   $0x10398e,(%esp)
  101e5b:	e8 90 e5 ff ff       	call   1003f0 <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101e60:	8b 45 08             	mov    0x8(%ebp),%eax
  101e63:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e67:	83 e0 03             	and    $0x3,%eax
  101e6a:	85 c0                	test   %eax,%eax
  101e6c:	75 2b                	jne    101e99 <trap_dispatch+0x138>
            print_trapframe(tf);
  101e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  101e71:	89 04 24             	mov    %eax,(%esp)
  101e74:	e8 77 fc ff ff       	call   101af0 <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101e79:	c7 44 24 08 7a 3b 10 	movl   $0x103b7a,0x8(%esp)
  101e80:	00 
  101e81:	c7 44 24 04 d7 00 00 	movl   $0xd7,0x4(%esp)
  101e88:	00 
  101e89:	c7 04 24 8e 39 10 00 	movl   $0x10398e,(%esp)
  101e90:	e8 5b e5 ff ff       	call   1003f0 <__panic>
        break;
  101e95:	90                   	nop
  101e96:	eb 01                	jmp    101e99 <trap_dispatch+0x138>
        break;
  101e98:	90                   	nop
        }
    }
}
  101e99:	90                   	nop
  101e9a:	c9                   	leave  
  101e9b:	c3                   	ret    

00101e9c <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101e9c:	f3 0f 1e fb          	endbr32 
  101ea0:	55                   	push   %ebp
  101ea1:	89 e5                	mov    %esp,%ebp
  101ea3:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  101ea9:	89 04 24             	mov    %eax,(%esp)
  101eac:	e8 b0 fe ff ff       	call   101d61 <trap_dispatch>
}
  101eb1:	90                   	nop
  101eb2:	c9                   	leave  
  101eb3:	c3                   	ret    

00101eb4 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101eb4:	6a 00                	push   $0x0
  pushl $0
  101eb6:	6a 00                	push   $0x0
  jmp __alltraps
  101eb8:	e9 69 0a 00 00       	jmp    102926 <__alltraps>

00101ebd <vector1>:
.globl vector1
vector1:
  pushl $0
  101ebd:	6a 00                	push   $0x0
  pushl $1
  101ebf:	6a 01                	push   $0x1
  jmp __alltraps
  101ec1:	e9 60 0a 00 00       	jmp    102926 <__alltraps>

00101ec6 <vector2>:
.globl vector2
vector2:
  pushl $0
  101ec6:	6a 00                	push   $0x0
  pushl $2
  101ec8:	6a 02                	push   $0x2
  jmp __alltraps
  101eca:	e9 57 0a 00 00       	jmp    102926 <__alltraps>

00101ecf <vector3>:
.globl vector3
vector3:
  pushl $0
  101ecf:	6a 00                	push   $0x0
  pushl $3
  101ed1:	6a 03                	push   $0x3
  jmp __alltraps
  101ed3:	e9 4e 0a 00 00       	jmp    102926 <__alltraps>

00101ed8 <vector4>:
.globl vector4
vector4:
  pushl $0
  101ed8:	6a 00                	push   $0x0
  pushl $4
  101eda:	6a 04                	push   $0x4
  jmp __alltraps
  101edc:	e9 45 0a 00 00       	jmp    102926 <__alltraps>

00101ee1 <vector5>:
.globl vector5
vector5:
  pushl $0
  101ee1:	6a 00                	push   $0x0
  pushl $5
  101ee3:	6a 05                	push   $0x5
  jmp __alltraps
  101ee5:	e9 3c 0a 00 00       	jmp    102926 <__alltraps>

00101eea <vector6>:
.globl vector6
vector6:
  pushl $0
  101eea:	6a 00                	push   $0x0
  pushl $6
  101eec:	6a 06                	push   $0x6
  jmp __alltraps
  101eee:	e9 33 0a 00 00       	jmp    102926 <__alltraps>

00101ef3 <vector7>:
.globl vector7
vector7:
  pushl $0
  101ef3:	6a 00                	push   $0x0
  pushl $7
  101ef5:	6a 07                	push   $0x7
  jmp __alltraps
  101ef7:	e9 2a 0a 00 00       	jmp    102926 <__alltraps>

00101efc <vector8>:
.globl vector8
vector8:
  pushl $8
  101efc:	6a 08                	push   $0x8
  jmp __alltraps
  101efe:	e9 23 0a 00 00       	jmp    102926 <__alltraps>

00101f03 <vector9>:
.globl vector9
vector9:
  pushl $0
  101f03:	6a 00                	push   $0x0
  pushl $9
  101f05:	6a 09                	push   $0x9
  jmp __alltraps
  101f07:	e9 1a 0a 00 00       	jmp    102926 <__alltraps>

00101f0c <vector10>:
.globl vector10
vector10:
  pushl $10
  101f0c:	6a 0a                	push   $0xa
  jmp __alltraps
  101f0e:	e9 13 0a 00 00       	jmp    102926 <__alltraps>

00101f13 <vector11>:
.globl vector11
vector11:
  pushl $11
  101f13:	6a 0b                	push   $0xb
  jmp __alltraps
  101f15:	e9 0c 0a 00 00       	jmp    102926 <__alltraps>

00101f1a <vector12>:
.globl vector12
vector12:
  pushl $12
  101f1a:	6a 0c                	push   $0xc
  jmp __alltraps
  101f1c:	e9 05 0a 00 00       	jmp    102926 <__alltraps>

00101f21 <vector13>:
.globl vector13
vector13:
  pushl $13
  101f21:	6a 0d                	push   $0xd
  jmp __alltraps
  101f23:	e9 fe 09 00 00       	jmp    102926 <__alltraps>

00101f28 <vector14>:
.globl vector14
vector14:
  pushl $14
  101f28:	6a 0e                	push   $0xe
  jmp __alltraps
  101f2a:	e9 f7 09 00 00       	jmp    102926 <__alltraps>

00101f2f <vector15>:
.globl vector15
vector15:
  pushl $0
  101f2f:	6a 00                	push   $0x0
  pushl $15
  101f31:	6a 0f                	push   $0xf
  jmp __alltraps
  101f33:	e9 ee 09 00 00       	jmp    102926 <__alltraps>

00101f38 <vector16>:
.globl vector16
vector16:
  pushl $0
  101f38:	6a 00                	push   $0x0
  pushl $16
  101f3a:	6a 10                	push   $0x10
  jmp __alltraps
  101f3c:	e9 e5 09 00 00       	jmp    102926 <__alltraps>

00101f41 <vector17>:
.globl vector17
vector17:
  pushl $17
  101f41:	6a 11                	push   $0x11
  jmp __alltraps
  101f43:	e9 de 09 00 00       	jmp    102926 <__alltraps>

00101f48 <vector18>:
.globl vector18
vector18:
  pushl $0
  101f48:	6a 00                	push   $0x0
  pushl $18
  101f4a:	6a 12                	push   $0x12
  jmp __alltraps
  101f4c:	e9 d5 09 00 00       	jmp    102926 <__alltraps>

00101f51 <vector19>:
.globl vector19
vector19:
  pushl $0
  101f51:	6a 00                	push   $0x0
  pushl $19
  101f53:	6a 13                	push   $0x13
  jmp __alltraps
  101f55:	e9 cc 09 00 00       	jmp    102926 <__alltraps>

00101f5a <vector20>:
.globl vector20
vector20:
  pushl $0
  101f5a:	6a 00                	push   $0x0
  pushl $20
  101f5c:	6a 14                	push   $0x14
  jmp __alltraps
  101f5e:	e9 c3 09 00 00       	jmp    102926 <__alltraps>

00101f63 <vector21>:
.globl vector21
vector21:
  pushl $0
  101f63:	6a 00                	push   $0x0
  pushl $21
  101f65:	6a 15                	push   $0x15
  jmp __alltraps
  101f67:	e9 ba 09 00 00       	jmp    102926 <__alltraps>

00101f6c <vector22>:
.globl vector22
vector22:
  pushl $0
  101f6c:	6a 00                	push   $0x0
  pushl $22
  101f6e:	6a 16                	push   $0x16
  jmp __alltraps
  101f70:	e9 b1 09 00 00       	jmp    102926 <__alltraps>

00101f75 <vector23>:
.globl vector23
vector23:
  pushl $0
  101f75:	6a 00                	push   $0x0
  pushl $23
  101f77:	6a 17                	push   $0x17
  jmp __alltraps
  101f79:	e9 a8 09 00 00       	jmp    102926 <__alltraps>

00101f7e <vector24>:
.globl vector24
vector24:
  pushl $0
  101f7e:	6a 00                	push   $0x0
  pushl $24
  101f80:	6a 18                	push   $0x18
  jmp __alltraps
  101f82:	e9 9f 09 00 00       	jmp    102926 <__alltraps>

00101f87 <vector25>:
.globl vector25
vector25:
  pushl $0
  101f87:	6a 00                	push   $0x0
  pushl $25
  101f89:	6a 19                	push   $0x19
  jmp __alltraps
  101f8b:	e9 96 09 00 00       	jmp    102926 <__alltraps>

00101f90 <vector26>:
.globl vector26
vector26:
  pushl $0
  101f90:	6a 00                	push   $0x0
  pushl $26
  101f92:	6a 1a                	push   $0x1a
  jmp __alltraps
  101f94:	e9 8d 09 00 00       	jmp    102926 <__alltraps>

00101f99 <vector27>:
.globl vector27
vector27:
  pushl $0
  101f99:	6a 00                	push   $0x0
  pushl $27
  101f9b:	6a 1b                	push   $0x1b
  jmp __alltraps
  101f9d:	e9 84 09 00 00       	jmp    102926 <__alltraps>

00101fa2 <vector28>:
.globl vector28
vector28:
  pushl $0
  101fa2:	6a 00                	push   $0x0
  pushl $28
  101fa4:	6a 1c                	push   $0x1c
  jmp __alltraps
  101fa6:	e9 7b 09 00 00       	jmp    102926 <__alltraps>

00101fab <vector29>:
.globl vector29
vector29:
  pushl $0
  101fab:	6a 00                	push   $0x0
  pushl $29
  101fad:	6a 1d                	push   $0x1d
  jmp __alltraps
  101faf:	e9 72 09 00 00       	jmp    102926 <__alltraps>

00101fb4 <vector30>:
.globl vector30
vector30:
  pushl $0
  101fb4:	6a 00                	push   $0x0
  pushl $30
  101fb6:	6a 1e                	push   $0x1e
  jmp __alltraps
  101fb8:	e9 69 09 00 00       	jmp    102926 <__alltraps>

00101fbd <vector31>:
.globl vector31
vector31:
  pushl $0
  101fbd:	6a 00                	push   $0x0
  pushl $31
  101fbf:	6a 1f                	push   $0x1f
  jmp __alltraps
  101fc1:	e9 60 09 00 00       	jmp    102926 <__alltraps>

00101fc6 <vector32>:
.globl vector32
vector32:
  pushl $0
  101fc6:	6a 00                	push   $0x0
  pushl $32
  101fc8:	6a 20                	push   $0x20
  jmp __alltraps
  101fca:	e9 57 09 00 00       	jmp    102926 <__alltraps>

00101fcf <vector33>:
.globl vector33
vector33:
  pushl $0
  101fcf:	6a 00                	push   $0x0
  pushl $33
  101fd1:	6a 21                	push   $0x21
  jmp __alltraps
  101fd3:	e9 4e 09 00 00       	jmp    102926 <__alltraps>

00101fd8 <vector34>:
.globl vector34
vector34:
  pushl $0
  101fd8:	6a 00                	push   $0x0
  pushl $34
  101fda:	6a 22                	push   $0x22
  jmp __alltraps
  101fdc:	e9 45 09 00 00       	jmp    102926 <__alltraps>

00101fe1 <vector35>:
.globl vector35
vector35:
  pushl $0
  101fe1:	6a 00                	push   $0x0
  pushl $35
  101fe3:	6a 23                	push   $0x23
  jmp __alltraps
  101fe5:	e9 3c 09 00 00       	jmp    102926 <__alltraps>

00101fea <vector36>:
.globl vector36
vector36:
  pushl $0
  101fea:	6a 00                	push   $0x0
  pushl $36
  101fec:	6a 24                	push   $0x24
  jmp __alltraps
  101fee:	e9 33 09 00 00       	jmp    102926 <__alltraps>

00101ff3 <vector37>:
.globl vector37
vector37:
  pushl $0
  101ff3:	6a 00                	push   $0x0
  pushl $37
  101ff5:	6a 25                	push   $0x25
  jmp __alltraps
  101ff7:	e9 2a 09 00 00       	jmp    102926 <__alltraps>

00101ffc <vector38>:
.globl vector38
vector38:
  pushl $0
  101ffc:	6a 00                	push   $0x0
  pushl $38
  101ffe:	6a 26                	push   $0x26
  jmp __alltraps
  102000:	e9 21 09 00 00       	jmp    102926 <__alltraps>

00102005 <vector39>:
.globl vector39
vector39:
  pushl $0
  102005:	6a 00                	push   $0x0
  pushl $39
  102007:	6a 27                	push   $0x27
  jmp __alltraps
  102009:	e9 18 09 00 00       	jmp    102926 <__alltraps>

0010200e <vector40>:
.globl vector40
vector40:
  pushl $0
  10200e:	6a 00                	push   $0x0
  pushl $40
  102010:	6a 28                	push   $0x28
  jmp __alltraps
  102012:	e9 0f 09 00 00       	jmp    102926 <__alltraps>

00102017 <vector41>:
.globl vector41
vector41:
  pushl $0
  102017:	6a 00                	push   $0x0
  pushl $41
  102019:	6a 29                	push   $0x29
  jmp __alltraps
  10201b:	e9 06 09 00 00       	jmp    102926 <__alltraps>

00102020 <vector42>:
.globl vector42
vector42:
  pushl $0
  102020:	6a 00                	push   $0x0
  pushl $42
  102022:	6a 2a                	push   $0x2a
  jmp __alltraps
  102024:	e9 fd 08 00 00       	jmp    102926 <__alltraps>

00102029 <vector43>:
.globl vector43
vector43:
  pushl $0
  102029:	6a 00                	push   $0x0
  pushl $43
  10202b:	6a 2b                	push   $0x2b
  jmp __alltraps
  10202d:	e9 f4 08 00 00       	jmp    102926 <__alltraps>

00102032 <vector44>:
.globl vector44
vector44:
  pushl $0
  102032:	6a 00                	push   $0x0
  pushl $44
  102034:	6a 2c                	push   $0x2c
  jmp __alltraps
  102036:	e9 eb 08 00 00       	jmp    102926 <__alltraps>

0010203b <vector45>:
.globl vector45
vector45:
  pushl $0
  10203b:	6a 00                	push   $0x0
  pushl $45
  10203d:	6a 2d                	push   $0x2d
  jmp __alltraps
  10203f:	e9 e2 08 00 00       	jmp    102926 <__alltraps>

00102044 <vector46>:
.globl vector46
vector46:
  pushl $0
  102044:	6a 00                	push   $0x0
  pushl $46
  102046:	6a 2e                	push   $0x2e
  jmp __alltraps
  102048:	e9 d9 08 00 00       	jmp    102926 <__alltraps>

0010204d <vector47>:
.globl vector47
vector47:
  pushl $0
  10204d:	6a 00                	push   $0x0
  pushl $47
  10204f:	6a 2f                	push   $0x2f
  jmp __alltraps
  102051:	e9 d0 08 00 00       	jmp    102926 <__alltraps>

00102056 <vector48>:
.globl vector48
vector48:
  pushl $0
  102056:	6a 00                	push   $0x0
  pushl $48
  102058:	6a 30                	push   $0x30
  jmp __alltraps
  10205a:	e9 c7 08 00 00       	jmp    102926 <__alltraps>

0010205f <vector49>:
.globl vector49
vector49:
  pushl $0
  10205f:	6a 00                	push   $0x0
  pushl $49
  102061:	6a 31                	push   $0x31
  jmp __alltraps
  102063:	e9 be 08 00 00       	jmp    102926 <__alltraps>

00102068 <vector50>:
.globl vector50
vector50:
  pushl $0
  102068:	6a 00                	push   $0x0
  pushl $50
  10206a:	6a 32                	push   $0x32
  jmp __alltraps
  10206c:	e9 b5 08 00 00       	jmp    102926 <__alltraps>

00102071 <vector51>:
.globl vector51
vector51:
  pushl $0
  102071:	6a 00                	push   $0x0
  pushl $51
  102073:	6a 33                	push   $0x33
  jmp __alltraps
  102075:	e9 ac 08 00 00       	jmp    102926 <__alltraps>

0010207a <vector52>:
.globl vector52
vector52:
  pushl $0
  10207a:	6a 00                	push   $0x0
  pushl $52
  10207c:	6a 34                	push   $0x34
  jmp __alltraps
  10207e:	e9 a3 08 00 00       	jmp    102926 <__alltraps>

00102083 <vector53>:
.globl vector53
vector53:
  pushl $0
  102083:	6a 00                	push   $0x0
  pushl $53
  102085:	6a 35                	push   $0x35
  jmp __alltraps
  102087:	e9 9a 08 00 00       	jmp    102926 <__alltraps>

0010208c <vector54>:
.globl vector54
vector54:
  pushl $0
  10208c:	6a 00                	push   $0x0
  pushl $54
  10208e:	6a 36                	push   $0x36
  jmp __alltraps
  102090:	e9 91 08 00 00       	jmp    102926 <__alltraps>

00102095 <vector55>:
.globl vector55
vector55:
  pushl $0
  102095:	6a 00                	push   $0x0
  pushl $55
  102097:	6a 37                	push   $0x37
  jmp __alltraps
  102099:	e9 88 08 00 00       	jmp    102926 <__alltraps>

0010209e <vector56>:
.globl vector56
vector56:
  pushl $0
  10209e:	6a 00                	push   $0x0
  pushl $56
  1020a0:	6a 38                	push   $0x38
  jmp __alltraps
  1020a2:	e9 7f 08 00 00       	jmp    102926 <__alltraps>

001020a7 <vector57>:
.globl vector57
vector57:
  pushl $0
  1020a7:	6a 00                	push   $0x0
  pushl $57
  1020a9:	6a 39                	push   $0x39
  jmp __alltraps
  1020ab:	e9 76 08 00 00       	jmp    102926 <__alltraps>

001020b0 <vector58>:
.globl vector58
vector58:
  pushl $0
  1020b0:	6a 00                	push   $0x0
  pushl $58
  1020b2:	6a 3a                	push   $0x3a
  jmp __alltraps
  1020b4:	e9 6d 08 00 00       	jmp    102926 <__alltraps>

001020b9 <vector59>:
.globl vector59
vector59:
  pushl $0
  1020b9:	6a 00                	push   $0x0
  pushl $59
  1020bb:	6a 3b                	push   $0x3b
  jmp __alltraps
  1020bd:	e9 64 08 00 00       	jmp    102926 <__alltraps>

001020c2 <vector60>:
.globl vector60
vector60:
  pushl $0
  1020c2:	6a 00                	push   $0x0
  pushl $60
  1020c4:	6a 3c                	push   $0x3c
  jmp __alltraps
  1020c6:	e9 5b 08 00 00       	jmp    102926 <__alltraps>

001020cb <vector61>:
.globl vector61
vector61:
  pushl $0
  1020cb:	6a 00                	push   $0x0
  pushl $61
  1020cd:	6a 3d                	push   $0x3d
  jmp __alltraps
  1020cf:	e9 52 08 00 00       	jmp    102926 <__alltraps>

001020d4 <vector62>:
.globl vector62
vector62:
  pushl $0
  1020d4:	6a 00                	push   $0x0
  pushl $62
  1020d6:	6a 3e                	push   $0x3e
  jmp __alltraps
  1020d8:	e9 49 08 00 00       	jmp    102926 <__alltraps>

001020dd <vector63>:
.globl vector63
vector63:
  pushl $0
  1020dd:	6a 00                	push   $0x0
  pushl $63
  1020df:	6a 3f                	push   $0x3f
  jmp __alltraps
  1020e1:	e9 40 08 00 00       	jmp    102926 <__alltraps>

001020e6 <vector64>:
.globl vector64
vector64:
  pushl $0
  1020e6:	6a 00                	push   $0x0
  pushl $64
  1020e8:	6a 40                	push   $0x40
  jmp __alltraps
  1020ea:	e9 37 08 00 00       	jmp    102926 <__alltraps>

001020ef <vector65>:
.globl vector65
vector65:
  pushl $0
  1020ef:	6a 00                	push   $0x0
  pushl $65
  1020f1:	6a 41                	push   $0x41
  jmp __alltraps
  1020f3:	e9 2e 08 00 00       	jmp    102926 <__alltraps>

001020f8 <vector66>:
.globl vector66
vector66:
  pushl $0
  1020f8:	6a 00                	push   $0x0
  pushl $66
  1020fa:	6a 42                	push   $0x42
  jmp __alltraps
  1020fc:	e9 25 08 00 00       	jmp    102926 <__alltraps>

00102101 <vector67>:
.globl vector67
vector67:
  pushl $0
  102101:	6a 00                	push   $0x0
  pushl $67
  102103:	6a 43                	push   $0x43
  jmp __alltraps
  102105:	e9 1c 08 00 00       	jmp    102926 <__alltraps>

0010210a <vector68>:
.globl vector68
vector68:
  pushl $0
  10210a:	6a 00                	push   $0x0
  pushl $68
  10210c:	6a 44                	push   $0x44
  jmp __alltraps
  10210e:	e9 13 08 00 00       	jmp    102926 <__alltraps>

00102113 <vector69>:
.globl vector69
vector69:
  pushl $0
  102113:	6a 00                	push   $0x0
  pushl $69
  102115:	6a 45                	push   $0x45
  jmp __alltraps
  102117:	e9 0a 08 00 00       	jmp    102926 <__alltraps>

0010211c <vector70>:
.globl vector70
vector70:
  pushl $0
  10211c:	6a 00                	push   $0x0
  pushl $70
  10211e:	6a 46                	push   $0x46
  jmp __alltraps
  102120:	e9 01 08 00 00       	jmp    102926 <__alltraps>

00102125 <vector71>:
.globl vector71
vector71:
  pushl $0
  102125:	6a 00                	push   $0x0
  pushl $71
  102127:	6a 47                	push   $0x47
  jmp __alltraps
  102129:	e9 f8 07 00 00       	jmp    102926 <__alltraps>

0010212e <vector72>:
.globl vector72
vector72:
  pushl $0
  10212e:	6a 00                	push   $0x0
  pushl $72
  102130:	6a 48                	push   $0x48
  jmp __alltraps
  102132:	e9 ef 07 00 00       	jmp    102926 <__alltraps>

00102137 <vector73>:
.globl vector73
vector73:
  pushl $0
  102137:	6a 00                	push   $0x0
  pushl $73
  102139:	6a 49                	push   $0x49
  jmp __alltraps
  10213b:	e9 e6 07 00 00       	jmp    102926 <__alltraps>

00102140 <vector74>:
.globl vector74
vector74:
  pushl $0
  102140:	6a 00                	push   $0x0
  pushl $74
  102142:	6a 4a                	push   $0x4a
  jmp __alltraps
  102144:	e9 dd 07 00 00       	jmp    102926 <__alltraps>

00102149 <vector75>:
.globl vector75
vector75:
  pushl $0
  102149:	6a 00                	push   $0x0
  pushl $75
  10214b:	6a 4b                	push   $0x4b
  jmp __alltraps
  10214d:	e9 d4 07 00 00       	jmp    102926 <__alltraps>

00102152 <vector76>:
.globl vector76
vector76:
  pushl $0
  102152:	6a 00                	push   $0x0
  pushl $76
  102154:	6a 4c                	push   $0x4c
  jmp __alltraps
  102156:	e9 cb 07 00 00       	jmp    102926 <__alltraps>

0010215b <vector77>:
.globl vector77
vector77:
  pushl $0
  10215b:	6a 00                	push   $0x0
  pushl $77
  10215d:	6a 4d                	push   $0x4d
  jmp __alltraps
  10215f:	e9 c2 07 00 00       	jmp    102926 <__alltraps>

00102164 <vector78>:
.globl vector78
vector78:
  pushl $0
  102164:	6a 00                	push   $0x0
  pushl $78
  102166:	6a 4e                	push   $0x4e
  jmp __alltraps
  102168:	e9 b9 07 00 00       	jmp    102926 <__alltraps>

0010216d <vector79>:
.globl vector79
vector79:
  pushl $0
  10216d:	6a 00                	push   $0x0
  pushl $79
  10216f:	6a 4f                	push   $0x4f
  jmp __alltraps
  102171:	e9 b0 07 00 00       	jmp    102926 <__alltraps>

00102176 <vector80>:
.globl vector80
vector80:
  pushl $0
  102176:	6a 00                	push   $0x0
  pushl $80
  102178:	6a 50                	push   $0x50
  jmp __alltraps
  10217a:	e9 a7 07 00 00       	jmp    102926 <__alltraps>

0010217f <vector81>:
.globl vector81
vector81:
  pushl $0
  10217f:	6a 00                	push   $0x0
  pushl $81
  102181:	6a 51                	push   $0x51
  jmp __alltraps
  102183:	e9 9e 07 00 00       	jmp    102926 <__alltraps>

00102188 <vector82>:
.globl vector82
vector82:
  pushl $0
  102188:	6a 00                	push   $0x0
  pushl $82
  10218a:	6a 52                	push   $0x52
  jmp __alltraps
  10218c:	e9 95 07 00 00       	jmp    102926 <__alltraps>

00102191 <vector83>:
.globl vector83
vector83:
  pushl $0
  102191:	6a 00                	push   $0x0
  pushl $83
  102193:	6a 53                	push   $0x53
  jmp __alltraps
  102195:	e9 8c 07 00 00       	jmp    102926 <__alltraps>

0010219a <vector84>:
.globl vector84
vector84:
  pushl $0
  10219a:	6a 00                	push   $0x0
  pushl $84
  10219c:	6a 54                	push   $0x54
  jmp __alltraps
  10219e:	e9 83 07 00 00       	jmp    102926 <__alltraps>

001021a3 <vector85>:
.globl vector85
vector85:
  pushl $0
  1021a3:	6a 00                	push   $0x0
  pushl $85
  1021a5:	6a 55                	push   $0x55
  jmp __alltraps
  1021a7:	e9 7a 07 00 00       	jmp    102926 <__alltraps>

001021ac <vector86>:
.globl vector86
vector86:
  pushl $0
  1021ac:	6a 00                	push   $0x0
  pushl $86
  1021ae:	6a 56                	push   $0x56
  jmp __alltraps
  1021b0:	e9 71 07 00 00       	jmp    102926 <__alltraps>

001021b5 <vector87>:
.globl vector87
vector87:
  pushl $0
  1021b5:	6a 00                	push   $0x0
  pushl $87
  1021b7:	6a 57                	push   $0x57
  jmp __alltraps
  1021b9:	e9 68 07 00 00       	jmp    102926 <__alltraps>

001021be <vector88>:
.globl vector88
vector88:
  pushl $0
  1021be:	6a 00                	push   $0x0
  pushl $88
  1021c0:	6a 58                	push   $0x58
  jmp __alltraps
  1021c2:	e9 5f 07 00 00       	jmp    102926 <__alltraps>

001021c7 <vector89>:
.globl vector89
vector89:
  pushl $0
  1021c7:	6a 00                	push   $0x0
  pushl $89
  1021c9:	6a 59                	push   $0x59
  jmp __alltraps
  1021cb:	e9 56 07 00 00       	jmp    102926 <__alltraps>

001021d0 <vector90>:
.globl vector90
vector90:
  pushl $0
  1021d0:	6a 00                	push   $0x0
  pushl $90
  1021d2:	6a 5a                	push   $0x5a
  jmp __alltraps
  1021d4:	e9 4d 07 00 00       	jmp    102926 <__alltraps>

001021d9 <vector91>:
.globl vector91
vector91:
  pushl $0
  1021d9:	6a 00                	push   $0x0
  pushl $91
  1021db:	6a 5b                	push   $0x5b
  jmp __alltraps
  1021dd:	e9 44 07 00 00       	jmp    102926 <__alltraps>

001021e2 <vector92>:
.globl vector92
vector92:
  pushl $0
  1021e2:	6a 00                	push   $0x0
  pushl $92
  1021e4:	6a 5c                	push   $0x5c
  jmp __alltraps
  1021e6:	e9 3b 07 00 00       	jmp    102926 <__alltraps>

001021eb <vector93>:
.globl vector93
vector93:
  pushl $0
  1021eb:	6a 00                	push   $0x0
  pushl $93
  1021ed:	6a 5d                	push   $0x5d
  jmp __alltraps
  1021ef:	e9 32 07 00 00       	jmp    102926 <__alltraps>

001021f4 <vector94>:
.globl vector94
vector94:
  pushl $0
  1021f4:	6a 00                	push   $0x0
  pushl $94
  1021f6:	6a 5e                	push   $0x5e
  jmp __alltraps
  1021f8:	e9 29 07 00 00       	jmp    102926 <__alltraps>

001021fd <vector95>:
.globl vector95
vector95:
  pushl $0
  1021fd:	6a 00                	push   $0x0
  pushl $95
  1021ff:	6a 5f                	push   $0x5f
  jmp __alltraps
  102201:	e9 20 07 00 00       	jmp    102926 <__alltraps>

00102206 <vector96>:
.globl vector96
vector96:
  pushl $0
  102206:	6a 00                	push   $0x0
  pushl $96
  102208:	6a 60                	push   $0x60
  jmp __alltraps
  10220a:	e9 17 07 00 00       	jmp    102926 <__alltraps>

0010220f <vector97>:
.globl vector97
vector97:
  pushl $0
  10220f:	6a 00                	push   $0x0
  pushl $97
  102211:	6a 61                	push   $0x61
  jmp __alltraps
  102213:	e9 0e 07 00 00       	jmp    102926 <__alltraps>

00102218 <vector98>:
.globl vector98
vector98:
  pushl $0
  102218:	6a 00                	push   $0x0
  pushl $98
  10221a:	6a 62                	push   $0x62
  jmp __alltraps
  10221c:	e9 05 07 00 00       	jmp    102926 <__alltraps>

00102221 <vector99>:
.globl vector99
vector99:
  pushl $0
  102221:	6a 00                	push   $0x0
  pushl $99
  102223:	6a 63                	push   $0x63
  jmp __alltraps
  102225:	e9 fc 06 00 00       	jmp    102926 <__alltraps>

0010222a <vector100>:
.globl vector100
vector100:
  pushl $0
  10222a:	6a 00                	push   $0x0
  pushl $100
  10222c:	6a 64                	push   $0x64
  jmp __alltraps
  10222e:	e9 f3 06 00 00       	jmp    102926 <__alltraps>

00102233 <vector101>:
.globl vector101
vector101:
  pushl $0
  102233:	6a 00                	push   $0x0
  pushl $101
  102235:	6a 65                	push   $0x65
  jmp __alltraps
  102237:	e9 ea 06 00 00       	jmp    102926 <__alltraps>

0010223c <vector102>:
.globl vector102
vector102:
  pushl $0
  10223c:	6a 00                	push   $0x0
  pushl $102
  10223e:	6a 66                	push   $0x66
  jmp __alltraps
  102240:	e9 e1 06 00 00       	jmp    102926 <__alltraps>

00102245 <vector103>:
.globl vector103
vector103:
  pushl $0
  102245:	6a 00                	push   $0x0
  pushl $103
  102247:	6a 67                	push   $0x67
  jmp __alltraps
  102249:	e9 d8 06 00 00       	jmp    102926 <__alltraps>

0010224e <vector104>:
.globl vector104
vector104:
  pushl $0
  10224e:	6a 00                	push   $0x0
  pushl $104
  102250:	6a 68                	push   $0x68
  jmp __alltraps
  102252:	e9 cf 06 00 00       	jmp    102926 <__alltraps>

00102257 <vector105>:
.globl vector105
vector105:
  pushl $0
  102257:	6a 00                	push   $0x0
  pushl $105
  102259:	6a 69                	push   $0x69
  jmp __alltraps
  10225b:	e9 c6 06 00 00       	jmp    102926 <__alltraps>

00102260 <vector106>:
.globl vector106
vector106:
  pushl $0
  102260:	6a 00                	push   $0x0
  pushl $106
  102262:	6a 6a                	push   $0x6a
  jmp __alltraps
  102264:	e9 bd 06 00 00       	jmp    102926 <__alltraps>

00102269 <vector107>:
.globl vector107
vector107:
  pushl $0
  102269:	6a 00                	push   $0x0
  pushl $107
  10226b:	6a 6b                	push   $0x6b
  jmp __alltraps
  10226d:	e9 b4 06 00 00       	jmp    102926 <__alltraps>

00102272 <vector108>:
.globl vector108
vector108:
  pushl $0
  102272:	6a 00                	push   $0x0
  pushl $108
  102274:	6a 6c                	push   $0x6c
  jmp __alltraps
  102276:	e9 ab 06 00 00       	jmp    102926 <__alltraps>

0010227b <vector109>:
.globl vector109
vector109:
  pushl $0
  10227b:	6a 00                	push   $0x0
  pushl $109
  10227d:	6a 6d                	push   $0x6d
  jmp __alltraps
  10227f:	e9 a2 06 00 00       	jmp    102926 <__alltraps>

00102284 <vector110>:
.globl vector110
vector110:
  pushl $0
  102284:	6a 00                	push   $0x0
  pushl $110
  102286:	6a 6e                	push   $0x6e
  jmp __alltraps
  102288:	e9 99 06 00 00       	jmp    102926 <__alltraps>

0010228d <vector111>:
.globl vector111
vector111:
  pushl $0
  10228d:	6a 00                	push   $0x0
  pushl $111
  10228f:	6a 6f                	push   $0x6f
  jmp __alltraps
  102291:	e9 90 06 00 00       	jmp    102926 <__alltraps>

00102296 <vector112>:
.globl vector112
vector112:
  pushl $0
  102296:	6a 00                	push   $0x0
  pushl $112
  102298:	6a 70                	push   $0x70
  jmp __alltraps
  10229a:	e9 87 06 00 00       	jmp    102926 <__alltraps>

0010229f <vector113>:
.globl vector113
vector113:
  pushl $0
  10229f:	6a 00                	push   $0x0
  pushl $113
  1022a1:	6a 71                	push   $0x71
  jmp __alltraps
  1022a3:	e9 7e 06 00 00       	jmp    102926 <__alltraps>

001022a8 <vector114>:
.globl vector114
vector114:
  pushl $0
  1022a8:	6a 00                	push   $0x0
  pushl $114
  1022aa:	6a 72                	push   $0x72
  jmp __alltraps
  1022ac:	e9 75 06 00 00       	jmp    102926 <__alltraps>

001022b1 <vector115>:
.globl vector115
vector115:
  pushl $0
  1022b1:	6a 00                	push   $0x0
  pushl $115
  1022b3:	6a 73                	push   $0x73
  jmp __alltraps
  1022b5:	e9 6c 06 00 00       	jmp    102926 <__alltraps>

001022ba <vector116>:
.globl vector116
vector116:
  pushl $0
  1022ba:	6a 00                	push   $0x0
  pushl $116
  1022bc:	6a 74                	push   $0x74
  jmp __alltraps
  1022be:	e9 63 06 00 00       	jmp    102926 <__alltraps>

001022c3 <vector117>:
.globl vector117
vector117:
  pushl $0
  1022c3:	6a 00                	push   $0x0
  pushl $117
  1022c5:	6a 75                	push   $0x75
  jmp __alltraps
  1022c7:	e9 5a 06 00 00       	jmp    102926 <__alltraps>

001022cc <vector118>:
.globl vector118
vector118:
  pushl $0
  1022cc:	6a 00                	push   $0x0
  pushl $118
  1022ce:	6a 76                	push   $0x76
  jmp __alltraps
  1022d0:	e9 51 06 00 00       	jmp    102926 <__alltraps>

001022d5 <vector119>:
.globl vector119
vector119:
  pushl $0
  1022d5:	6a 00                	push   $0x0
  pushl $119
  1022d7:	6a 77                	push   $0x77
  jmp __alltraps
  1022d9:	e9 48 06 00 00       	jmp    102926 <__alltraps>

001022de <vector120>:
.globl vector120
vector120:
  pushl $0
  1022de:	6a 00                	push   $0x0
  pushl $120
  1022e0:	6a 78                	push   $0x78
  jmp __alltraps
  1022e2:	e9 3f 06 00 00       	jmp    102926 <__alltraps>

001022e7 <vector121>:
.globl vector121
vector121:
  pushl $0
  1022e7:	6a 00                	push   $0x0
  pushl $121
  1022e9:	6a 79                	push   $0x79
  jmp __alltraps
  1022eb:	e9 36 06 00 00       	jmp    102926 <__alltraps>

001022f0 <vector122>:
.globl vector122
vector122:
  pushl $0
  1022f0:	6a 00                	push   $0x0
  pushl $122
  1022f2:	6a 7a                	push   $0x7a
  jmp __alltraps
  1022f4:	e9 2d 06 00 00       	jmp    102926 <__alltraps>

001022f9 <vector123>:
.globl vector123
vector123:
  pushl $0
  1022f9:	6a 00                	push   $0x0
  pushl $123
  1022fb:	6a 7b                	push   $0x7b
  jmp __alltraps
  1022fd:	e9 24 06 00 00       	jmp    102926 <__alltraps>

00102302 <vector124>:
.globl vector124
vector124:
  pushl $0
  102302:	6a 00                	push   $0x0
  pushl $124
  102304:	6a 7c                	push   $0x7c
  jmp __alltraps
  102306:	e9 1b 06 00 00       	jmp    102926 <__alltraps>

0010230b <vector125>:
.globl vector125
vector125:
  pushl $0
  10230b:	6a 00                	push   $0x0
  pushl $125
  10230d:	6a 7d                	push   $0x7d
  jmp __alltraps
  10230f:	e9 12 06 00 00       	jmp    102926 <__alltraps>

00102314 <vector126>:
.globl vector126
vector126:
  pushl $0
  102314:	6a 00                	push   $0x0
  pushl $126
  102316:	6a 7e                	push   $0x7e
  jmp __alltraps
  102318:	e9 09 06 00 00       	jmp    102926 <__alltraps>

0010231d <vector127>:
.globl vector127
vector127:
  pushl $0
  10231d:	6a 00                	push   $0x0
  pushl $127
  10231f:	6a 7f                	push   $0x7f
  jmp __alltraps
  102321:	e9 00 06 00 00       	jmp    102926 <__alltraps>

00102326 <vector128>:
.globl vector128
vector128:
  pushl $0
  102326:	6a 00                	push   $0x0
  pushl $128
  102328:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  10232d:	e9 f4 05 00 00       	jmp    102926 <__alltraps>

00102332 <vector129>:
.globl vector129
vector129:
  pushl $0
  102332:	6a 00                	push   $0x0
  pushl $129
  102334:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  102339:	e9 e8 05 00 00       	jmp    102926 <__alltraps>

0010233e <vector130>:
.globl vector130
vector130:
  pushl $0
  10233e:	6a 00                	push   $0x0
  pushl $130
  102340:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  102345:	e9 dc 05 00 00       	jmp    102926 <__alltraps>

0010234a <vector131>:
.globl vector131
vector131:
  pushl $0
  10234a:	6a 00                	push   $0x0
  pushl $131
  10234c:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102351:	e9 d0 05 00 00       	jmp    102926 <__alltraps>

00102356 <vector132>:
.globl vector132
vector132:
  pushl $0
  102356:	6a 00                	push   $0x0
  pushl $132
  102358:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  10235d:	e9 c4 05 00 00       	jmp    102926 <__alltraps>

00102362 <vector133>:
.globl vector133
vector133:
  pushl $0
  102362:	6a 00                	push   $0x0
  pushl $133
  102364:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  102369:	e9 b8 05 00 00       	jmp    102926 <__alltraps>

0010236e <vector134>:
.globl vector134
vector134:
  pushl $0
  10236e:	6a 00                	push   $0x0
  pushl $134
  102370:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  102375:	e9 ac 05 00 00       	jmp    102926 <__alltraps>

0010237a <vector135>:
.globl vector135
vector135:
  pushl $0
  10237a:	6a 00                	push   $0x0
  pushl $135
  10237c:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  102381:	e9 a0 05 00 00       	jmp    102926 <__alltraps>

00102386 <vector136>:
.globl vector136
vector136:
  pushl $0
  102386:	6a 00                	push   $0x0
  pushl $136
  102388:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  10238d:	e9 94 05 00 00       	jmp    102926 <__alltraps>

00102392 <vector137>:
.globl vector137
vector137:
  pushl $0
  102392:	6a 00                	push   $0x0
  pushl $137
  102394:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  102399:	e9 88 05 00 00       	jmp    102926 <__alltraps>

0010239e <vector138>:
.globl vector138
vector138:
  pushl $0
  10239e:	6a 00                	push   $0x0
  pushl $138
  1023a0:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1023a5:	e9 7c 05 00 00       	jmp    102926 <__alltraps>

001023aa <vector139>:
.globl vector139
vector139:
  pushl $0
  1023aa:	6a 00                	push   $0x0
  pushl $139
  1023ac:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  1023b1:	e9 70 05 00 00       	jmp    102926 <__alltraps>

001023b6 <vector140>:
.globl vector140
vector140:
  pushl $0
  1023b6:	6a 00                	push   $0x0
  pushl $140
  1023b8:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1023bd:	e9 64 05 00 00       	jmp    102926 <__alltraps>

001023c2 <vector141>:
.globl vector141
vector141:
  pushl $0
  1023c2:	6a 00                	push   $0x0
  pushl $141
  1023c4:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1023c9:	e9 58 05 00 00       	jmp    102926 <__alltraps>

001023ce <vector142>:
.globl vector142
vector142:
  pushl $0
  1023ce:	6a 00                	push   $0x0
  pushl $142
  1023d0:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1023d5:	e9 4c 05 00 00       	jmp    102926 <__alltraps>

001023da <vector143>:
.globl vector143
vector143:
  pushl $0
  1023da:	6a 00                	push   $0x0
  pushl $143
  1023dc:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  1023e1:	e9 40 05 00 00       	jmp    102926 <__alltraps>

001023e6 <vector144>:
.globl vector144
vector144:
  pushl $0
  1023e6:	6a 00                	push   $0x0
  pushl $144
  1023e8:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  1023ed:	e9 34 05 00 00       	jmp    102926 <__alltraps>

001023f2 <vector145>:
.globl vector145
vector145:
  pushl $0
  1023f2:	6a 00                	push   $0x0
  pushl $145
  1023f4:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  1023f9:	e9 28 05 00 00       	jmp    102926 <__alltraps>

001023fe <vector146>:
.globl vector146
vector146:
  pushl $0
  1023fe:	6a 00                	push   $0x0
  pushl $146
  102400:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  102405:	e9 1c 05 00 00       	jmp    102926 <__alltraps>

0010240a <vector147>:
.globl vector147
vector147:
  pushl $0
  10240a:	6a 00                	push   $0x0
  pushl $147
  10240c:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  102411:	e9 10 05 00 00       	jmp    102926 <__alltraps>

00102416 <vector148>:
.globl vector148
vector148:
  pushl $0
  102416:	6a 00                	push   $0x0
  pushl $148
  102418:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  10241d:	e9 04 05 00 00       	jmp    102926 <__alltraps>

00102422 <vector149>:
.globl vector149
vector149:
  pushl $0
  102422:	6a 00                	push   $0x0
  pushl $149
  102424:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102429:	e9 f8 04 00 00       	jmp    102926 <__alltraps>

0010242e <vector150>:
.globl vector150
vector150:
  pushl $0
  10242e:	6a 00                	push   $0x0
  pushl $150
  102430:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  102435:	e9 ec 04 00 00       	jmp    102926 <__alltraps>

0010243a <vector151>:
.globl vector151
vector151:
  pushl $0
  10243a:	6a 00                	push   $0x0
  pushl $151
  10243c:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  102441:	e9 e0 04 00 00       	jmp    102926 <__alltraps>

00102446 <vector152>:
.globl vector152
vector152:
  pushl $0
  102446:	6a 00                	push   $0x0
  pushl $152
  102448:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  10244d:	e9 d4 04 00 00       	jmp    102926 <__alltraps>

00102452 <vector153>:
.globl vector153
vector153:
  pushl $0
  102452:	6a 00                	push   $0x0
  pushl $153
  102454:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  102459:	e9 c8 04 00 00       	jmp    102926 <__alltraps>

0010245e <vector154>:
.globl vector154
vector154:
  pushl $0
  10245e:	6a 00                	push   $0x0
  pushl $154
  102460:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  102465:	e9 bc 04 00 00       	jmp    102926 <__alltraps>

0010246a <vector155>:
.globl vector155
vector155:
  pushl $0
  10246a:	6a 00                	push   $0x0
  pushl $155
  10246c:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102471:	e9 b0 04 00 00       	jmp    102926 <__alltraps>

00102476 <vector156>:
.globl vector156
vector156:
  pushl $0
  102476:	6a 00                	push   $0x0
  pushl $156
  102478:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  10247d:	e9 a4 04 00 00       	jmp    102926 <__alltraps>

00102482 <vector157>:
.globl vector157
vector157:
  pushl $0
  102482:	6a 00                	push   $0x0
  pushl $157
  102484:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  102489:	e9 98 04 00 00       	jmp    102926 <__alltraps>

0010248e <vector158>:
.globl vector158
vector158:
  pushl $0
  10248e:	6a 00                	push   $0x0
  pushl $158
  102490:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  102495:	e9 8c 04 00 00       	jmp    102926 <__alltraps>

0010249a <vector159>:
.globl vector159
vector159:
  pushl $0
  10249a:	6a 00                	push   $0x0
  pushl $159
  10249c:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  1024a1:	e9 80 04 00 00       	jmp    102926 <__alltraps>

001024a6 <vector160>:
.globl vector160
vector160:
  pushl $0
  1024a6:	6a 00                	push   $0x0
  pushl $160
  1024a8:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  1024ad:	e9 74 04 00 00       	jmp    102926 <__alltraps>

001024b2 <vector161>:
.globl vector161
vector161:
  pushl $0
  1024b2:	6a 00                	push   $0x0
  pushl $161
  1024b4:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1024b9:	e9 68 04 00 00       	jmp    102926 <__alltraps>

001024be <vector162>:
.globl vector162
vector162:
  pushl $0
  1024be:	6a 00                	push   $0x0
  pushl $162
  1024c0:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  1024c5:	e9 5c 04 00 00       	jmp    102926 <__alltraps>

001024ca <vector163>:
.globl vector163
vector163:
  pushl $0
  1024ca:	6a 00                	push   $0x0
  pushl $163
  1024cc:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1024d1:	e9 50 04 00 00       	jmp    102926 <__alltraps>

001024d6 <vector164>:
.globl vector164
vector164:
  pushl $0
  1024d6:	6a 00                	push   $0x0
  pushl $164
  1024d8:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1024dd:	e9 44 04 00 00       	jmp    102926 <__alltraps>

001024e2 <vector165>:
.globl vector165
vector165:
  pushl $0
  1024e2:	6a 00                	push   $0x0
  pushl $165
  1024e4:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  1024e9:	e9 38 04 00 00       	jmp    102926 <__alltraps>

001024ee <vector166>:
.globl vector166
vector166:
  pushl $0
  1024ee:	6a 00                	push   $0x0
  pushl $166
  1024f0:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  1024f5:	e9 2c 04 00 00       	jmp    102926 <__alltraps>

001024fa <vector167>:
.globl vector167
vector167:
  pushl $0
  1024fa:	6a 00                	push   $0x0
  pushl $167
  1024fc:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  102501:	e9 20 04 00 00       	jmp    102926 <__alltraps>

00102506 <vector168>:
.globl vector168
vector168:
  pushl $0
  102506:	6a 00                	push   $0x0
  pushl $168
  102508:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  10250d:	e9 14 04 00 00       	jmp    102926 <__alltraps>

00102512 <vector169>:
.globl vector169
vector169:
  pushl $0
  102512:	6a 00                	push   $0x0
  pushl $169
  102514:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  102519:	e9 08 04 00 00       	jmp    102926 <__alltraps>

0010251e <vector170>:
.globl vector170
vector170:
  pushl $0
  10251e:	6a 00                	push   $0x0
  pushl $170
  102520:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  102525:	e9 fc 03 00 00       	jmp    102926 <__alltraps>

0010252a <vector171>:
.globl vector171
vector171:
  pushl $0
  10252a:	6a 00                	push   $0x0
  pushl $171
  10252c:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102531:	e9 f0 03 00 00       	jmp    102926 <__alltraps>

00102536 <vector172>:
.globl vector172
vector172:
  pushl $0
  102536:	6a 00                	push   $0x0
  pushl $172
  102538:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  10253d:	e9 e4 03 00 00       	jmp    102926 <__alltraps>

00102542 <vector173>:
.globl vector173
vector173:
  pushl $0
  102542:	6a 00                	push   $0x0
  pushl $173
  102544:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  102549:	e9 d8 03 00 00       	jmp    102926 <__alltraps>

0010254e <vector174>:
.globl vector174
vector174:
  pushl $0
  10254e:	6a 00                	push   $0x0
  pushl $174
  102550:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  102555:	e9 cc 03 00 00       	jmp    102926 <__alltraps>

0010255a <vector175>:
.globl vector175
vector175:
  pushl $0
  10255a:	6a 00                	push   $0x0
  pushl $175
  10255c:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102561:	e9 c0 03 00 00       	jmp    102926 <__alltraps>

00102566 <vector176>:
.globl vector176
vector176:
  pushl $0
  102566:	6a 00                	push   $0x0
  pushl $176
  102568:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  10256d:	e9 b4 03 00 00       	jmp    102926 <__alltraps>

00102572 <vector177>:
.globl vector177
vector177:
  pushl $0
  102572:	6a 00                	push   $0x0
  pushl $177
  102574:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  102579:	e9 a8 03 00 00       	jmp    102926 <__alltraps>

0010257e <vector178>:
.globl vector178
vector178:
  pushl $0
  10257e:	6a 00                	push   $0x0
  pushl $178
  102580:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  102585:	e9 9c 03 00 00       	jmp    102926 <__alltraps>

0010258a <vector179>:
.globl vector179
vector179:
  pushl $0
  10258a:	6a 00                	push   $0x0
  pushl $179
  10258c:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  102591:	e9 90 03 00 00       	jmp    102926 <__alltraps>

00102596 <vector180>:
.globl vector180
vector180:
  pushl $0
  102596:	6a 00                	push   $0x0
  pushl $180
  102598:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  10259d:	e9 84 03 00 00       	jmp    102926 <__alltraps>

001025a2 <vector181>:
.globl vector181
vector181:
  pushl $0
  1025a2:	6a 00                	push   $0x0
  pushl $181
  1025a4:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1025a9:	e9 78 03 00 00       	jmp    102926 <__alltraps>

001025ae <vector182>:
.globl vector182
vector182:
  pushl $0
  1025ae:	6a 00                	push   $0x0
  pushl $182
  1025b0:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  1025b5:	e9 6c 03 00 00       	jmp    102926 <__alltraps>

001025ba <vector183>:
.globl vector183
vector183:
  pushl $0
  1025ba:	6a 00                	push   $0x0
  pushl $183
  1025bc:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  1025c1:	e9 60 03 00 00       	jmp    102926 <__alltraps>

001025c6 <vector184>:
.globl vector184
vector184:
  pushl $0
  1025c6:	6a 00                	push   $0x0
  pushl $184
  1025c8:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1025cd:	e9 54 03 00 00       	jmp    102926 <__alltraps>

001025d2 <vector185>:
.globl vector185
vector185:
  pushl $0
  1025d2:	6a 00                	push   $0x0
  pushl $185
  1025d4:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1025d9:	e9 48 03 00 00       	jmp    102926 <__alltraps>

001025de <vector186>:
.globl vector186
vector186:
  pushl $0
  1025de:	6a 00                	push   $0x0
  pushl $186
  1025e0:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  1025e5:	e9 3c 03 00 00       	jmp    102926 <__alltraps>

001025ea <vector187>:
.globl vector187
vector187:
  pushl $0
  1025ea:	6a 00                	push   $0x0
  pushl $187
  1025ec:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  1025f1:	e9 30 03 00 00       	jmp    102926 <__alltraps>

001025f6 <vector188>:
.globl vector188
vector188:
  pushl $0
  1025f6:	6a 00                	push   $0x0
  pushl $188
  1025f8:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1025fd:	e9 24 03 00 00       	jmp    102926 <__alltraps>

00102602 <vector189>:
.globl vector189
vector189:
  pushl $0
  102602:	6a 00                	push   $0x0
  pushl $189
  102604:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  102609:	e9 18 03 00 00       	jmp    102926 <__alltraps>

0010260e <vector190>:
.globl vector190
vector190:
  pushl $0
  10260e:	6a 00                	push   $0x0
  pushl $190
  102610:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  102615:	e9 0c 03 00 00       	jmp    102926 <__alltraps>

0010261a <vector191>:
.globl vector191
vector191:
  pushl $0
  10261a:	6a 00                	push   $0x0
  pushl $191
  10261c:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  102621:	e9 00 03 00 00       	jmp    102926 <__alltraps>

00102626 <vector192>:
.globl vector192
vector192:
  pushl $0
  102626:	6a 00                	push   $0x0
  pushl $192
  102628:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  10262d:	e9 f4 02 00 00       	jmp    102926 <__alltraps>

00102632 <vector193>:
.globl vector193
vector193:
  pushl $0
  102632:	6a 00                	push   $0x0
  pushl $193
  102634:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102639:	e9 e8 02 00 00       	jmp    102926 <__alltraps>

0010263e <vector194>:
.globl vector194
vector194:
  pushl $0
  10263e:	6a 00                	push   $0x0
  pushl $194
  102640:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  102645:	e9 dc 02 00 00       	jmp    102926 <__alltraps>

0010264a <vector195>:
.globl vector195
vector195:
  pushl $0
  10264a:	6a 00                	push   $0x0
  pushl $195
  10264c:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102651:	e9 d0 02 00 00       	jmp    102926 <__alltraps>

00102656 <vector196>:
.globl vector196
vector196:
  pushl $0
  102656:	6a 00                	push   $0x0
  pushl $196
  102658:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  10265d:	e9 c4 02 00 00       	jmp    102926 <__alltraps>

00102662 <vector197>:
.globl vector197
vector197:
  pushl $0
  102662:	6a 00                	push   $0x0
  pushl $197
  102664:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102669:	e9 b8 02 00 00       	jmp    102926 <__alltraps>

0010266e <vector198>:
.globl vector198
vector198:
  pushl $0
  10266e:	6a 00                	push   $0x0
  pushl $198
  102670:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102675:	e9 ac 02 00 00       	jmp    102926 <__alltraps>

0010267a <vector199>:
.globl vector199
vector199:
  pushl $0
  10267a:	6a 00                	push   $0x0
  pushl $199
  10267c:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102681:	e9 a0 02 00 00       	jmp    102926 <__alltraps>

00102686 <vector200>:
.globl vector200
vector200:
  pushl $0
  102686:	6a 00                	push   $0x0
  pushl $200
  102688:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  10268d:	e9 94 02 00 00       	jmp    102926 <__alltraps>

00102692 <vector201>:
.globl vector201
vector201:
  pushl $0
  102692:	6a 00                	push   $0x0
  pushl $201
  102694:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  102699:	e9 88 02 00 00       	jmp    102926 <__alltraps>

0010269e <vector202>:
.globl vector202
vector202:
  pushl $0
  10269e:	6a 00                	push   $0x0
  pushl $202
  1026a0:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  1026a5:	e9 7c 02 00 00       	jmp    102926 <__alltraps>

001026aa <vector203>:
.globl vector203
vector203:
  pushl $0
  1026aa:	6a 00                	push   $0x0
  pushl $203
  1026ac:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  1026b1:	e9 70 02 00 00       	jmp    102926 <__alltraps>

001026b6 <vector204>:
.globl vector204
vector204:
  pushl $0
  1026b6:	6a 00                	push   $0x0
  pushl $204
  1026b8:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1026bd:	e9 64 02 00 00       	jmp    102926 <__alltraps>

001026c2 <vector205>:
.globl vector205
vector205:
  pushl $0
  1026c2:	6a 00                	push   $0x0
  pushl $205
  1026c4:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  1026c9:	e9 58 02 00 00       	jmp    102926 <__alltraps>

001026ce <vector206>:
.globl vector206
vector206:
  pushl $0
  1026ce:	6a 00                	push   $0x0
  pushl $206
  1026d0:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1026d5:	e9 4c 02 00 00       	jmp    102926 <__alltraps>

001026da <vector207>:
.globl vector207
vector207:
  pushl $0
  1026da:	6a 00                	push   $0x0
  pushl $207
  1026dc:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  1026e1:	e9 40 02 00 00       	jmp    102926 <__alltraps>

001026e6 <vector208>:
.globl vector208
vector208:
  pushl $0
  1026e6:	6a 00                	push   $0x0
  pushl $208
  1026e8:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  1026ed:	e9 34 02 00 00       	jmp    102926 <__alltraps>

001026f2 <vector209>:
.globl vector209
vector209:
  pushl $0
  1026f2:	6a 00                	push   $0x0
  pushl $209
  1026f4:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  1026f9:	e9 28 02 00 00       	jmp    102926 <__alltraps>

001026fe <vector210>:
.globl vector210
vector210:
  pushl $0
  1026fe:	6a 00                	push   $0x0
  pushl $210
  102700:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  102705:	e9 1c 02 00 00       	jmp    102926 <__alltraps>

0010270a <vector211>:
.globl vector211
vector211:
  pushl $0
  10270a:	6a 00                	push   $0x0
  pushl $211
  10270c:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  102711:	e9 10 02 00 00       	jmp    102926 <__alltraps>

00102716 <vector212>:
.globl vector212
vector212:
  pushl $0
  102716:	6a 00                	push   $0x0
  pushl $212
  102718:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  10271d:	e9 04 02 00 00       	jmp    102926 <__alltraps>

00102722 <vector213>:
.globl vector213
vector213:
  pushl $0
  102722:	6a 00                	push   $0x0
  pushl $213
  102724:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102729:	e9 f8 01 00 00       	jmp    102926 <__alltraps>

0010272e <vector214>:
.globl vector214
vector214:
  pushl $0
  10272e:	6a 00                	push   $0x0
  pushl $214
  102730:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  102735:	e9 ec 01 00 00       	jmp    102926 <__alltraps>

0010273a <vector215>:
.globl vector215
vector215:
  pushl $0
  10273a:	6a 00                	push   $0x0
  pushl $215
  10273c:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102741:	e9 e0 01 00 00       	jmp    102926 <__alltraps>

00102746 <vector216>:
.globl vector216
vector216:
  pushl $0
  102746:	6a 00                	push   $0x0
  pushl $216
  102748:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  10274d:	e9 d4 01 00 00       	jmp    102926 <__alltraps>

00102752 <vector217>:
.globl vector217
vector217:
  pushl $0
  102752:	6a 00                	push   $0x0
  pushl $217
  102754:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102759:	e9 c8 01 00 00       	jmp    102926 <__alltraps>

0010275e <vector218>:
.globl vector218
vector218:
  pushl $0
  10275e:	6a 00                	push   $0x0
  pushl $218
  102760:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102765:	e9 bc 01 00 00       	jmp    102926 <__alltraps>

0010276a <vector219>:
.globl vector219
vector219:
  pushl $0
  10276a:	6a 00                	push   $0x0
  pushl $219
  10276c:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102771:	e9 b0 01 00 00       	jmp    102926 <__alltraps>

00102776 <vector220>:
.globl vector220
vector220:
  pushl $0
  102776:	6a 00                	push   $0x0
  pushl $220
  102778:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  10277d:	e9 a4 01 00 00       	jmp    102926 <__alltraps>

00102782 <vector221>:
.globl vector221
vector221:
  pushl $0
  102782:	6a 00                	push   $0x0
  pushl $221
  102784:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102789:	e9 98 01 00 00       	jmp    102926 <__alltraps>

0010278e <vector222>:
.globl vector222
vector222:
  pushl $0
  10278e:	6a 00                	push   $0x0
  pushl $222
  102790:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  102795:	e9 8c 01 00 00       	jmp    102926 <__alltraps>

0010279a <vector223>:
.globl vector223
vector223:
  pushl $0
  10279a:	6a 00                	push   $0x0
  pushl $223
  10279c:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  1027a1:	e9 80 01 00 00       	jmp    102926 <__alltraps>

001027a6 <vector224>:
.globl vector224
vector224:
  pushl $0
  1027a6:	6a 00                	push   $0x0
  pushl $224
  1027a8:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  1027ad:	e9 74 01 00 00       	jmp    102926 <__alltraps>

001027b2 <vector225>:
.globl vector225
vector225:
  pushl $0
  1027b2:	6a 00                	push   $0x0
  pushl $225
  1027b4:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  1027b9:	e9 68 01 00 00       	jmp    102926 <__alltraps>

001027be <vector226>:
.globl vector226
vector226:
  pushl $0
  1027be:	6a 00                	push   $0x0
  pushl $226
  1027c0:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  1027c5:	e9 5c 01 00 00       	jmp    102926 <__alltraps>

001027ca <vector227>:
.globl vector227
vector227:
  pushl $0
  1027ca:	6a 00                	push   $0x0
  pushl $227
  1027cc:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  1027d1:	e9 50 01 00 00       	jmp    102926 <__alltraps>

001027d6 <vector228>:
.globl vector228
vector228:
  pushl $0
  1027d6:	6a 00                	push   $0x0
  pushl $228
  1027d8:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  1027dd:	e9 44 01 00 00       	jmp    102926 <__alltraps>

001027e2 <vector229>:
.globl vector229
vector229:
  pushl $0
  1027e2:	6a 00                	push   $0x0
  pushl $229
  1027e4:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  1027e9:	e9 38 01 00 00       	jmp    102926 <__alltraps>

001027ee <vector230>:
.globl vector230
vector230:
  pushl $0
  1027ee:	6a 00                	push   $0x0
  pushl $230
  1027f0:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  1027f5:	e9 2c 01 00 00       	jmp    102926 <__alltraps>

001027fa <vector231>:
.globl vector231
vector231:
  pushl $0
  1027fa:	6a 00                	push   $0x0
  pushl $231
  1027fc:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  102801:	e9 20 01 00 00       	jmp    102926 <__alltraps>

00102806 <vector232>:
.globl vector232
vector232:
  pushl $0
  102806:	6a 00                	push   $0x0
  pushl $232
  102808:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  10280d:	e9 14 01 00 00       	jmp    102926 <__alltraps>

00102812 <vector233>:
.globl vector233
vector233:
  pushl $0
  102812:	6a 00                	push   $0x0
  pushl $233
  102814:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102819:	e9 08 01 00 00       	jmp    102926 <__alltraps>

0010281e <vector234>:
.globl vector234
vector234:
  pushl $0
  10281e:	6a 00                	push   $0x0
  pushl $234
  102820:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  102825:	e9 fc 00 00 00       	jmp    102926 <__alltraps>

0010282a <vector235>:
.globl vector235
vector235:
  pushl $0
  10282a:	6a 00                	push   $0x0
  pushl $235
  10282c:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102831:	e9 f0 00 00 00       	jmp    102926 <__alltraps>

00102836 <vector236>:
.globl vector236
vector236:
  pushl $0
  102836:	6a 00                	push   $0x0
  pushl $236
  102838:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  10283d:	e9 e4 00 00 00       	jmp    102926 <__alltraps>

00102842 <vector237>:
.globl vector237
vector237:
  pushl $0
  102842:	6a 00                	push   $0x0
  pushl $237
  102844:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102849:	e9 d8 00 00 00       	jmp    102926 <__alltraps>

0010284e <vector238>:
.globl vector238
vector238:
  pushl $0
  10284e:	6a 00                	push   $0x0
  pushl $238
  102850:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102855:	e9 cc 00 00 00       	jmp    102926 <__alltraps>

0010285a <vector239>:
.globl vector239
vector239:
  pushl $0
  10285a:	6a 00                	push   $0x0
  pushl $239
  10285c:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102861:	e9 c0 00 00 00       	jmp    102926 <__alltraps>

00102866 <vector240>:
.globl vector240
vector240:
  pushl $0
  102866:	6a 00                	push   $0x0
  pushl $240
  102868:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  10286d:	e9 b4 00 00 00       	jmp    102926 <__alltraps>

00102872 <vector241>:
.globl vector241
vector241:
  pushl $0
  102872:	6a 00                	push   $0x0
  pushl $241
  102874:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102879:	e9 a8 00 00 00       	jmp    102926 <__alltraps>

0010287e <vector242>:
.globl vector242
vector242:
  pushl $0
  10287e:	6a 00                	push   $0x0
  pushl $242
  102880:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102885:	e9 9c 00 00 00       	jmp    102926 <__alltraps>

0010288a <vector243>:
.globl vector243
vector243:
  pushl $0
  10288a:	6a 00                	push   $0x0
  pushl $243
  10288c:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102891:	e9 90 00 00 00       	jmp    102926 <__alltraps>

00102896 <vector244>:
.globl vector244
vector244:
  pushl $0
  102896:	6a 00                	push   $0x0
  pushl $244
  102898:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  10289d:	e9 84 00 00 00       	jmp    102926 <__alltraps>

001028a2 <vector245>:
.globl vector245
vector245:
  pushl $0
  1028a2:	6a 00                	push   $0x0
  pushl $245
  1028a4:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  1028a9:	e9 78 00 00 00       	jmp    102926 <__alltraps>

001028ae <vector246>:
.globl vector246
vector246:
  pushl $0
  1028ae:	6a 00                	push   $0x0
  pushl $246
  1028b0:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  1028b5:	e9 6c 00 00 00       	jmp    102926 <__alltraps>

001028ba <vector247>:
.globl vector247
vector247:
  pushl $0
  1028ba:	6a 00                	push   $0x0
  pushl $247
  1028bc:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  1028c1:	e9 60 00 00 00       	jmp    102926 <__alltraps>

001028c6 <vector248>:
.globl vector248
vector248:
  pushl $0
  1028c6:	6a 00                	push   $0x0
  pushl $248
  1028c8:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  1028cd:	e9 54 00 00 00       	jmp    102926 <__alltraps>

001028d2 <vector249>:
.globl vector249
vector249:
  pushl $0
  1028d2:	6a 00                	push   $0x0
  pushl $249
  1028d4:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  1028d9:	e9 48 00 00 00       	jmp    102926 <__alltraps>

001028de <vector250>:
.globl vector250
vector250:
  pushl $0
  1028de:	6a 00                	push   $0x0
  pushl $250
  1028e0:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  1028e5:	e9 3c 00 00 00       	jmp    102926 <__alltraps>

001028ea <vector251>:
.globl vector251
vector251:
  pushl $0
  1028ea:	6a 00                	push   $0x0
  pushl $251
  1028ec:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  1028f1:	e9 30 00 00 00       	jmp    102926 <__alltraps>

001028f6 <vector252>:
.globl vector252
vector252:
  pushl $0
  1028f6:	6a 00                	push   $0x0
  pushl $252
  1028f8:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  1028fd:	e9 24 00 00 00       	jmp    102926 <__alltraps>

00102902 <vector253>:
.globl vector253
vector253:
  pushl $0
  102902:	6a 00                	push   $0x0
  pushl $253
  102904:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102909:	e9 18 00 00 00       	jmp    102926 <__alltraps>

0010290e <vector254>:
.globl vector254
vector254:
  pushl $0
  10290e:	6a 00                	push   $0x0
  pushl $254
  102910:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102915:	e9 0c 00 00 00       	jmp    102926 <__alltraps>

0010291a <vector255>:
.globl vector255
vector255:
  pushl $0
  10291a:	6a 00                	push   $0x0
  pushl $255
  10291c:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102921:	e9 00 00 00 00       	jmp    102926 <__alltraps>

00102926 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  102926:	1e                   	push   %ds
    pushl %es
  102927:	06                   	push   %es
    pushl %fs
  102928:	0f a0                	push   %fs
    pushl %gs
  10292a:	0f a8                	push   %gs
    pushal
  10292c:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  10292d:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102932:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102934:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102936:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  102937:	e8 60 f5 ff ff       	call   101e9c <trap>

    # pop the pushed stack pointer
    popl %esp
  10293c:	5c                   	pop    %esp

0010293d <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  10293d:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  10293e:	0f a9                	pop    %gs
    popl %fs
  102940:	0f a1                	pop    %fs
    popl %es
  102942:	07                   	pop    %es
    popl %ds
  102943:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102944:	83 c4 08             	add    $0x8,%esp
    iret
  102947:	cf                   	iret   

00102948 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102948:	55                   	push   %ebp
  102949:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  10294b:	8b 45 08             	mov    0x8(%ebp),%eax
  10294e:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102951:	b8 23 00 00 00       	mov    $0x23,%eax
  102956:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102958:	b8 23 00 00 00       	mov    $0x23,%eax
  10295d:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  10295f:	b8 10 00 00 00       	mov    $0x10,%eax
  102964:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102966:	b8 10 00 00 00       	mov    $0x10,%eax
  10296b:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  10296d:	b8 10 00 00 00       	mov    $0x10,%eax
  102972:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102974:	ea 7b 29 10 00 08 00 	ljmp   $0x8,$0x10297b
}
  10297b:	90                   	nop
  10297c:	5d                   	pop    %ebp
  10297d:	c3                   	ret    

0010297e <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  10297e:	f3 0f 1e fb          	endbr32 
  102982:	55                   	push   %ebp
  102983:	89 e5                	mov    %esp,%ebp
  102985:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102988:	b8 20 09 11 00       	mov    $0x110920,%eax
  10298d:	05 00 04 00 00       	add    $0x400,%eax
  102992:	a3 a4 08 11 00       	mov    %eax,0x1108a4
    ts.ts_ss0 = KERNEL_DS;
  102997:	66 c7 05 a8 08 11 00 	movw   $0x10,0x1108a8
  10299e:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  1029a0:	66 c7 05 08 fa 10 00 	movw   $0x68,0x10fa08
  1029a7:	68 00 
  1029a9:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  1029ae:	0f b7 c0             	movzwl %ax,%eax
  1029b1:	66 a3 0a fa 10 00    	mov    %ax,0x10fa0a
  1029b7:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  1029bc:	c1 e8 10             	shr    $0x10,%eax
  1029bf:	a2 0c fa 10 00       	mov    %al,0x10fa0c
  1029c4:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  1029cb:	24 f0                	and    $0xf0,%al
  1029cd:	0c 09                	or     $0x9,%al
  1029cf:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  1029d4:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  1029db:	0c 10                	or     $0x10,%al
  1029dd:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  1029e2:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  1029e9:	24 9f                	and    $0x9f,%al
  1029eb:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  1029f0:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  1029f7:	0c 80                	or     $0x80,%al
  1029f9:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  1029fe:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102a05:	24 f0                	and    $0xf0,%al
  102a07:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102a0c:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102a13:	24 ef                	and    $0xef,%al
  102a15:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102a1a:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102a21:	24 df                	and    $0xdf,%al
  102a23:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102a28:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102a2f:	0c 40                	or     $0x40,%al
  102a31:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102a36:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102a3d:	24 7f                	and    $0x7f,%al
  102a3f:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102a44:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102a49:	c1 e8 18             	shr    $0x18,%eax
  102a4c:	a2 0f fa 10 00       	mov    %al,0x10fa0f
    gdt[SEG_TSS].sd_s = 0;
  102a51:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102a58:	24 ef                	and    $0xef,%al
  102a5a:	a2 0d fa 10 00       	mov    %al,0x10fa0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102a5f:	c7 04 24 10 fa 10 00 	movl   $0x10fa10,(%esp)
  102a66:	e8 dd fe ff ff       	call   102948 <lgdt>
  102a6b:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102a71:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102a75:	0f 00 d8             	ltr    %ax
}
  102a78:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102a79:	90                   	nop
  102a7a:	c9                   	leave  
  102a7b:	c3                   	ret    

00102a7c <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102a7c:	f3 0f 1e fb          	endbr32 
  102a80:	55                   	push   %ebp
  102a81:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102a83:	e8 f6 fe ff ff       	call   10297e <gdt_init>
}
  102a88:	90                   	nop
  102a89:	5d                   	pop    %ebp
  102a8a:	c3                   	ret    

00102a8b <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102a8b:	f3 0f 1e fb          	endbr32 
  102a8f:	55                   	push   %ebp
  102a90:	89 e5                	mov    %esp,%ebp
  102a92:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102a95:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102a9c:	eb 03                	jmp    102aa1 <strlen+0x16>
        cnt ++;
  102a9e:	ff 45 fc             	incl   -0x4(%ebp)
    while (*s ++ != '\0') {
  102aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  102aa4:	8d 50 01             	lea    0x1(%eax),%edx
  102aa7:	89 55 08             	mov    %edx,0x8(%ebp)
  102aaa:	0f b6 00             	movzbl (%eax),%eax
  102aad:	84 c0                	test   %al,%al
  102aaf:	75 ed                	jne    102a9e <strlen+0x13>
    }
    return cnt;
  102ab1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102ab4:	c9                   	leave  
  102ab5:	c3                   	ret    

00102ab6 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102ab6:	f3 0f 1e fb          	endbr32 
  102aba:	55                   	push   %ebp
  102abb:	89 e5                	mov    %esp,%ebp
  102abd:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102ac0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102ac7:	eb 03                	jmp    102acc <strnlen+0x16>
        cnt ++;
  102ac9:	ff 45 fc             	incl   -0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102acc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102acf:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102ad2:	73 10                	jae    102ae4 <strnlen+0x2e>
  102ad4:	8b 45 08             	mov    0x8(%ebp),%eax
  102ad7:	8d 50 01             	lea    0x1(%eax),%edx
  102ada:	89 55 08             	mov    %edx,0x8(%ebp)
  102add:	0f b6 00             	movzbl (%eax),%eax
  102ae0:	84 c0                	test   %al,%al
  102ae2:	75 e5                	jne    102ac9 <strnlen+0x13>
    }
    return cnt;
  102ae4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102ae7:	c9                   	leave  
  102ae8:	c3                   	ret    

00102ae9 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102ae9:	f3 0f 1e fb          	endbr32 
  102aed:	55                   	push   %ebp
  102aee:	89 e5                	mov    %esp,%ebp
  102af0:	57                   	push   %edi
  102af1:	56                   	push   %esi
  102af2:	83 ec 20             	sub    $0x20,%esp
  102af5:	8b 45 08             	mov    0x8(%ebp),%eax
  102af8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102afb:	8b 45 0c             	mov    0xc(%ebp),%eax
  102afe:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102b01:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102b04:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102b07:	89 d1                	mov    %edx,%ecx
  102b09:	89 c2                	mov    %eax,%edx
  102b0b:	89 ce                	mov    %ecx,%esi
  102b0d:	89 d7                	mov    %edx,%edi
  102b0f:	ac                   	lods   %ds:(%esi),%al
  102b10:	aa                   	stos   %al,%es:(%edi)
  102b11:	84 c0                	test   %al,%al
  102b13:	75 fa                	jne    102b0f <strcpy+0x26>
  102b15:	89 fa                	mov    %edi,%edx
  102b17:	89 f1                	mov    %esi,%ecx
  102b19:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102b1c:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102b1f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102b22:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102b25:	83 c4 20             	add    $0x20,%esp
  102b28:	5e                   	pop    %esi
  102b29:	5f                   	pop    %edi
  102b2a:	5d                   	pop    %ebp
  102b2b:	c3                   	ret    

00102b2c <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102b2c:	f3 0f 1e fb          	endbr32 
  102b30:	55                   	push   %ebp
  102b31:	89 e5                	mov    %esp,%ebp
  102b33:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102b36:	8b 45 08             	mov    0x8(%ebp),%eax
  102b39:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102b3c:	eb 1e                	jmp    102b5c <strncpy+0x30>
        if ((*p = *src) != '\0') {
  102b3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b41:	0f b6 10             	movzbl (%eax),%edx
  102b44:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b47:	88 10                	mov    %dl,(%eax)
  102b49:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b4c:	0f b6 00             	movzbl (%eax),%eax
  102b4f:	84 c0                	test   %al,%al
  102b51:	74 03                	je     102b56 <strncpy+0x2a>
            src ++;
  102b53:	ff 45 0c             	incl   0xc(%ebp)
        }
        p ++, len --;
  102b56:	ff 45 fc             	incl   -0x4(%ebp)
  102b59:	ff 4d 10             	decl   0x10(%ebp)
    while (len > 0) {
  102b5c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102b60:	75 dc                	jne    102b3e <strncpy+0x12>
    }
    return dst;
  102b62:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102b65:	c9                   	leave  
  102b66:	c3                   	ret    

00102b67 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102b67:	f3 0f 1e fb          	endbr32 
  102b6b:	55                   	push   %ebp
  102b6c:	89 e5                	mov    %esp,%ebp
  102b6e:	57                   	push   %edi
  102b6f:	56                   	push   %esi
  102b70:	83 ec 20             	sub    $0x20,%esp
  102b73:	8b 45 08             	mov    0x8(%ebp),%eax
  102b76:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102b79:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102b7f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102b82:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102b85:	89 d1                	mov    %edx,%ecx
  102b87:	89 c2                	mov    %eax,%edx
  102b89:	89 ce                	mov    %ecx,%esi
  102b8b:	89 d7                	mov    %edx,%edi
  102b8d:	ac                   	lods   %ds:(%esi),%al
  102b8e:	ae                   	scas   %es:(%edi),%al
  102b8f:	75 08                	jne    102b99 <strcmp+0x32>
  102b91:	84 c0                	test   %al,%al
  102b93:	75 f8                	jne    102b8d <strcmp+0x26>
  102b95:	31 c0                	xor    %eax,%eax
  102b97:	eb 04                	jmp    102b9d <strcmp+0x36>
  102b99:	19 c0                	sbb    %eax,%eax
  102b9b:	0c 01                	or     $0x1,%al
  102b9d:	89 fa                	mov    %edi,%edx
  102b9f:	89 f1                	mov    %esi,%ecx
  102ba1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102ba4:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102ba7:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102baa:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102bad:	83 c4 20             	add    $0x20,%esp
  102bb0:	5e                   	pop    %esi
  102bb1:	5f                   	pop    %edi
  102bb2:	5d                   	pop    %ebp
  102bb3:	c3                   	ret    

00102bb4 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102bb4:	f3 0f 1e fb          	endbr32 
  102bb8:	55                   	push   %ebp
  102bb9:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102bbb:	eb 09                	jmp    102bc6 <strncmp+0x12>
        n --, s1 ++, s2 ++;
  102bbd:	ff 4d 10             	decl   0x10(%ebp)
  102bc0:	ff 45 08             	incl   0x8(%ebp)
  102bc3:	ff 45 0c             	incl   0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102bc6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102bca:	74 1a                	je     102be6 <strncmp+0x32>
  102bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  102bcf:	0f b6 00             	movzbl (%eax),%eax
  102bd2:	84 c0                	test   %al,%al
  102bd4:	74 10                	je     102be6 <strncmp+0x32>
  102bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  102bd9:	0f b6 10             	movzbl (%eax),%edx
  102bdc:	8b 45 0c             	mov    0xc(%ebp),%eax
  102bdf:	0f b6 00             	movzbl (%eax),%eax
  102be2:	38 c2                	cmp    %al,%dl
  102be4:	74 d7                	je     102bbd <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102be6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102bea:	74 18                	je     102c04 <strncmp+0x50>
  102bec:	8b 45 08             	mov    0x8(%ebp),%eax
  102bef:	0f b6 00             	movzbl (%eax),%eax
  102bf2:	0f b6 d0             	movzbl %al,%edx
  102bf5:	8b 45 0c             	mov    0xc(%ebp),%eax
  102bf8:	0f b6 00             	movzbl (%eax),%eax
  102bfb:	0f b6 c0             	movzbl %al,%eax
  102bfe:	29 c2                	sub    %eax,%edx
  102c00:	89 d0                	mov    %edx,%eax
  102c02:	eb 05                	jmp    102c09 <strncmp+0x55>
  102c04:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102c09:	5d                   	pop    %ebp
  102c0a:	c3                   	ret    

00102c0b <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102c0b:	f3 0f 1e fb          	endbr32 
  102c0f:	55                   	push   %ebp
  102c10:	89 e5                	mov    %esp,%ebp
  102c12:	83 ec 04             	sub    $0x4,%esp
  102c15:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c18:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102c1b:	eb 13                	jmp    102c30 <strchr+0x25>
        if (*s == c) {
  102c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  102c20:	0f b6 00             	movzbl (%eax),%eax
  102c23:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102c26:	75 05                	jne    102c2d <strchr+0x22>
            return (char *)s;
  102c28:	8b 45 08             	mov    0x8(%ebp),%eax
  102c2b:	eb 12                	jmp    102c3f <strchr+0x34>
        }
        s ++;
  102c2d:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102c30:	8b 45 08             	mov    0x8(%ebp),%eax
  102c33:	0f b6 00             	movzbl (%eax),%eax
  102c36:	84 c0                	test   %al,%al
  102c38:	75 e3                	jne    102c1d <strchr+0x12>
    }
    return NULL;
  102c3a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102c3f:	c9                   	leave  
  102c40:	c3                   	ret    

00102c41 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102c41:	f3 0f 1e fb          	endbr32 
  102c45:	55                   	push   %ebp
  102c46:	89 e5                	mov    %esp,%ebp
  102c48:	83 ec 04             	sub    $0x4,%esp
  102c4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c4e:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102c51:	eb 0e                	jmp    102c61 <strfind+0x20>
        if (*s == c) {
  102c53:	8b 45 08             	mov    0x8(%ebp),%eax
  102c56:	0f b6 00             	movzbl (%eax),%eax
  102c59:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102c5c:	74 0f                	je     102c6d <strfind+0x2c>
            break;
        }
        s ++;
  102c5e:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102c61:	8b 45 08             	mov    0x8(%ebp),%eax
  102c64:	0f b6 00             	movzbl (%eax),%eax
  102c67:	84 c0                	test   %al,%al
  102c69:	75 e8                	jne    102c53 <strfind+0x12>
  102c6b:	eb 01                	jmp    102c6e <strfind+0x2d>
            break;
  102c6d:	90                   	nop
    }
    return (char *)s;
  102c6e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102c71:	c9                   	leave  
  102c72:	c3                   	ret    

00102c73 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102c73:	f3 0f 1e fb          	endbr32 
  102c77:	55                   	push   %ebp
  102c78:	89 e5                	mov    %esp,%ebp
  102c7a:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  102c7d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102c84:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102c8b:	eb 03                	jmp    102c90 <strtol+0x1d>
        s ++;
  102c8d:	ff 45 08             	incl   0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102c90:	8b 45 08             	mov    0x8(%ebp),%eax
  102c93:	0f b6 00             	movzbl (%eax),%eax
  102c96:	3c 20                	cmp    $0x20,%al
  102c98:	74 f3                	je     102c8d <strtol+0x1a>
  102c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  102c9d:	0f b6 00             	movzbl (%eax),%eax
  102ca0:	3c 09                	cmp    $0x9,%al
  102ca2:	74 e9                	je     102c8d <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
  102ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  102ca7:	0f b6 00             	movzbl (%eax),%eax
  102caa:	3c 2b                	cmp    $0x2b,%al
  102cac:	75 05                	jne    102cb3 <strtol+0x40>
        s ++;
  102cae:	ff 45 08             	incl   0x8(%ebp)
  102cb1:	eb 14                	jmp    102cc7 <strtol+0x54>
    }
    else if (*s == '-') {
  102cb3:	8b 45 08             	mov    0x8(%ebp),%eax
  102cb6:	0f b6 00             	movzbl (%eax),%eax
  102cb9:	3c 2d                	cmp    $0x2d,%al
  102cbb:	75 0a                	jne    102cc7 <strtol+0x54>
        s ++, neg = 1;
  102cbd:	ff 45 08             	incl   0x8(%ebp)
  102cc0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102cc7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102ccb:	74 06                	je     102cd3 <strtol+0x60>
  102ccd:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102cd1:	75 22                	jne    102cf5 <strtol+0x82>
  102cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  102cd6:	0f b6 00             	movzbl (%eax),%eax
  102cd9:	3c 30                	cmp    $0x30,%al
  102cdb:	75 18                	jne    102cf5 <strtol+0x82>
  102cdd:	8b 45 08             	mov    0x8(%ebp),%eax
  102ce0:	40                   	inc    %eax
  102ce1:	0f b6 00             	movzbl (%eax),%eax
  102ce4:	3c 78                	cmp    $0x78,%al
  102ce6:	75 0d                	jne    102cf5 <strtol+0x82>
        s += 2, base = 16;
  102ce8:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102cec:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102cf3:	eb 29                	jmp    102d1e <strtol+0xab>
    }
    else if (base == 0 && s[0] == '0') {
  102cf5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102cf9:	75 16                	jne    102d11 <strtol+0x9e>
  102cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  102cfe:	0f b6 00             	movzbl (%eax),%eax
  102d01:	3c 30                	cmp    $0x30,%al
  102d03:	75 0c                	jne    102d11 <strtol+0x9e>
        s ++, base = 8;
  102d05:	ff 45 08             	incl   0x8(%ebp)
  102d08:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102d0f:	eb 0d                	jmp    102d1e <strtol+0xab>
    }
    else if (base == 0) {
  102d11:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d15:	75 07                	jne    102d1e <strtol+0xab>
        base = 10;
  102d17:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  102d21:	0f b6 00             	movzbl (%eax),%eax
  102d24:	3c 2f                	cmp    $0x2f,%al
  102d26:	7e 1b                	jle    102d43 <strtol+0xd0>
  102d28:	8b 45 08             	mov    0x8(%ebp),%eax
  102d2b:	0f b6 00             	movzbl (%eax),%eax
  102d2e:	3c 39                	cmp    $0x39,%al
  102d30:	7f 11                	jg     102d43 <strtol+0xd0>
            dig = *s - '0';
  102d32:	8b 45 08             	mov    0x8(%ebp),%eax
  102d35:	0f b6 00             	movzbl (%eax),%eax
  102d38:	0f be c0             	movsbl %al,%eax
  102d3b:	83 e8 30             	sub    $0x30,%eax
  102d3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102d41:	eb 48                	jmp    102d8b <strtol+0x118>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102d43:	8b 45 08             	mov    0x8(%ebp),%eax
  102d46:	0f b6 00             	movzbl (%eax),%eax
  102d49:	3c 60                	cmp    $0x60,%al
  102d4b:	7e 1b                	jle    102d68 <strtol+0xf5>
  102d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  102d50:	0f b6 00             	movzbl (%eax),%eax
  102d53:	3c 7a                	cmp    $0x7a,%al
  102d55:	7f 11                	jg     102d68 <strtol+0xf5>
            dig = *s - 'a' + 10;
  102d57:	8b 45 08             	mov    0x8(%ebp),%eax
  102d5a:	0f b6 00             	movzbl (%eax),%eax
  102d5d:	0f be c0             	movsbl %al,%eax
  102d60:	83 e8 57             	sub    $0x57,%eax
  102d63:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102d66:	eb 23                	jmp    102d8b <strtol+0x118>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  102d68:	8b 45 08             	mov    0x8(%ebp),%eax
  102d6b:	0f b6 00             	movzbl (%eax),%eax
  102d6e:	3c 40                	cmp    $0x40,%al
  102d70:	7e 3b                	jle    102dad <strtol+0x13a>
  102d72:	8b 45 08             	mov    0x8(%ebp),%eax
  102d75:	0f b6 00             	movzbl (%eax),%eax
  102d78:	3c 5a                	cmp    $0x5a,%al
  102d7a:	7f 31                	jg     102dad <strtol+0x13a>
            dig = *s - 'A' + 10;
  102d7c:	8b 45 08             	mov    0x8(%ebp),%eax
  102d7f:	0f b6 00             	movzbl (%eax),%eax
  102d82:	0f be c0             	movsbl %al,%eax
  102d85:	83 e8 37             	sub    $0x37,%eax
  102d88:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  102d8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102d8e:	3b 45 10             	cmp    0x10(%ebp),%eax
  102d91:	7d 19                	jge    102dac <strtol+0x139>
            break;
        }
        s ++, val = (val * base) + dig;
  102d93:	ff 45 08             	incl   0x8(%ebp)
  102d96:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102d99:	0f af 45 10          	imul   0x10(%ebp),%eax
  102d9d:	89 c2                	mov    %eax,%edx
  102d9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102da2:	01 d0                	add    %edx,%eax
  102da4:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  102da7:	e9 72 ff ff ff       	jmp    102d1e <strtol+0xab>
            break;
  102dac:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  102dad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102db1:	74 08                	je     102dbb <strtol+0x148>
        *endptr = (char *) s;
  102db3:	8b 45 0c             	mov    0xc(%ebp),%eax
  102db6:	8b 55 08             	mov    0x8(%ebp),%edx
  102db9:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102dbb:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102dbf:	74 07                	je     102dc8 <strtol+0x155>
  102dc1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102dc4:	f7 d8                	neg    %eax
  102dc6:	eb 03                	jmp    102dcb <strtol+0x158>
  102dc8:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102dcb:	c9                   	leave  
  102dcc:	c3                   	ret    

00102dcd <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102dcd:	f3 0f 1e fb          	endbr32 
  102dd1:	55                   	push   %ebp
  102dd2:	89 e5                	mov    %esp,%ebp
  102dd4:	57                   	push   %edi
  102dd5:	83 ec 24             	sub    $0x24,%esp
  102dd8:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ddb:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102dde:	0f be 55 d8          	movsbl -0x28(%ebp),%edx
  102de2:	8b 45 08             	mov    0x8(%ebp),%eax
  102de5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  102de8:	88 55 f7             	mov    %dl,-0x9(%ebp)
  102deb:	8b 45 10             	mov    0x10(%ebp),%eax
  102dee:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102df1:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102df4:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102df8:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102dfb:	89 d7                	mov    %edx,%edi
  102dfd:	f3 aa                	rep stos %al,%es:(%edi)
  102dff:	89 fa                	mov    %edi,%edx
  102e01:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102e04:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102e07:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102e0a:	83 c4 24             	add    $0x24,%esp
  102e0d:	5f                   	pop    %edi
  102e0e:	5d                   	pop    %ebp
  102e0f:	c3                   	ret    

00102e10 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102e10:	f3 0f 1e fb          	endbr32 
  102e14:	55                   	push   %ebp
  102e15:	89 e5                	mov    %esp,%ebp
  102e17:	57                   	push   %edi
  102e18:	56                   	push   %esi
  102e19:	53                   	push   %ebx
  102e1a:	83 ec 30             	sub    $0x30,%esp
  102e1d:	8b 45 08             	mov    0x8(%ebp),%eax
  102e20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102e23:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e26:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102e29:	8b 45 10             	mov    0x10(%ebp),%eax
  102e2c:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102e2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e32:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102e35:	73 42                	jae    102e79 <memmove+0x69>
  102e37:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e3a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102e3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102e40:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102e43:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102e46:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102e49:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102e4c:	c1 e8 02             	shr    $0x2,%eax
  102e4f:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102e51:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102e54:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102e57:	89 d7                	mov    %edx,%edi
  102e59:	89 c6                	mov    %eax,%esi
  102e5b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102e5d:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102e60:	83 e1 03             	and    $0x3,%ecx
  102e63:	74 02                	je     102e67 <memmove+0x57>
  102e65:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102e67:	89 f0                	mov    %esi,%eax
  102e69:	89 fa                	mov    %edi,%edx
  102e6b:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102e6e:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102e71:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  102e74:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  102e77:	eb 36                	jmp    102eaf <memmove+0x9f>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102e79:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102e7c:	8d 50 ff             	lea    -0x1(%eax),%edx
  102e7f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102e82:	01 c2                	add    %eax,%edx
  102e84:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102e87:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102e8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e8d:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  102e90:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102e93:	89 c1                	mov    %eax,%ecx
  102e95:	89 d8                	mov    %ebx,%eax
  102e97:	89 d6                	mov    %edx,%esi
  102e99:	89 c7                	mov    %eax,%edi
  102e9b:	fd                   	std    
  102e9c:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102e9e:	fc                   	cld    
  102e9f:	89 f8                	mov    %edi,%eax
  102ea1:	89 f2                	mov    %esi,%edx
  102ea3:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  102ea6:	89 55 c8             	mov    %edx,-0x38(%ebp)
  102ea9:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  102eac:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  102eaf:	83 c4 30             	add    $0x30,%esp
  102eb2:	5b                   	pop    %ebx
  102eb3:	5e                   	pop    %esi
  102eb4:	5f                   	pop    %edi
  102eb5:	5d                   	pop    %ebp
  102eb6:	c3                   	ret    

00102eb7 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  102eb7:	f3 0f 1e fb          	endbr32 
  102ebb:	55                   	push   %ebp
  102ebc:	89 e5                	mov    %esp,%ebp
  102ebe:	57                   	push   %edi
  102ebf:	56                   	push   %esi
  102ec0:	83 ec 20             	sub    $0x20,%esp
  102ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  102ec6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102ec9:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ecc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102ecf:	8b 45 10             	mov    0x10(%ebp),%eax
  102ed2:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102ed5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102ed8:	c1 e8 02             	shr    $0x2,%eax
  102edb:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102edd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102ee0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ee3:	89 d7                	mov    %edx,%edi
  102ee5:	89 c6                	mov    %eax,%esi
  102ee7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102ee9:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  102eec:	83 e1 03             	and    $0x3,%ecx
  102eef:	74 02                	je     102ef3 <memcpy+0x3c>
  102ef1:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102ef3:	89 f0                	mov    %esi,%eax
  102ef5:	89 fa                	mov    %edi,%edx
  102ef7:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102efa:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  102efd:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  102f00:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  102f03:	83 c4 20             	add    $0x20,%esp
  102f06:	5e                   	pop    %esi
  102f07:	5f                   	pop    %edi
  102f08:	5d                   	pop    %ebp
  102f09:	c3                   	ret    

00102f0a <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  102f0a:	f3 0f 1e fb          	endbr32 
  102f0e:	55                   	push   %ebp
  102f0f:	89 e5                	mov    %esp,%ebp
  102f11:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  102f14:	8b 45 08             	mov    0x8(%ebp),%eax
  102f17:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  102f1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f1d:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  102f20:	eb 2e                	jmp    102f50 <memcmp+0x46>
        if (*s1 != *s2) {
  102f22:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102f25:	0f b6 10             	movzbl (%eax),%edx
  102f28:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102f2b:	0f b6 00             	movzbl (%eax),%eax
  102f2e:	38 c2                	cmp    %al,%dl
  102f30:	74 18                	je     102f4a <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  102f32:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102f35:	0f b6 00             	movzbl (%eax),%eax
  102f38:	0f b6 d0             	movzbl %al,%edx
  102f3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102f3e:	0f b6 00             	movzbl (%eax),%eax
  102f41:	0f b6 c0             	movzbl %al,%eax
  102f44:	29 c2                	sub    %eax,%edx
  102f46:	89 d0                	mov    %edx,%eax
  102f48:	eb 18                	jmp    102f62 <memcmp+0x58>
        }
        s1 ++, s2 ++;
  102f4a:	ff 45 fc             	incl   -0x4(%ebp)
  102f4d:	ff 45 f8             	incl   -0x8(%ebp)
    while (n -- > 0) {
  102f50:	8b 45 10             	mov    0x10(%ebp),%eax
  102f53:	8d 50 ff             	lea    -0x1(%eax),%edx
  102f56:	89 55 10             	mov    %edx,0x10(%ebp)
  102f59:	85 c0                	test   %eax,%eax
  102f5b:	75 c5                	jne    102f22 <memcmp+0x18>
    }
    return 0;
  102f5d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102f62:	c9                   	leave  
  102f63:	c3                   	ret    

00102f64 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  102f64:	f3 0f 1e fb          	endbr32 
  102f68:	55                   	push   %ebp
  102f69:	89 e5                	mov    %esp,%ebp
  102f6b:	83 ec 58             	sub    $0x58,%esp
  102f6e:	8b 45 10             	mov    0x10(%ebp),%eax
  102f71:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102f74:	8b 45 14             	mov    0x14(%ebp),%eax
  102f77:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  102f7a:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102f7d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102f80:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102f83:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  102f86:	8b 45 18             	mov    0x18(%ebp),%eax
  102f89:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102f8c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f8f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102f92:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102f95:	89 55 f0             	mov    %edx,-0x10(%ebp)
  102f98:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102f9e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102fa2:	74 1c                	je     102fc0 <printnum+0x5c>
  102fa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fa7:	ba 00 00 00 00       	mov    $0x0,%edx
  102fac:	f7 75 e4             	divl   -0x1c(%ebp)
  102faf:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102fb2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fb5:	ba 00 00 00 00       	mov    $0x0,%edx
  102fba:	f7 75 e4             	divl   -0x1c(%ebp)
  102fbd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fc0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102fc3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fc6:	f7 75 e4             	divl   -0x1c(%ebp)
  102fc9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102fcc:	89 55 dc             	mov    %edx,-0x24(%ebp)
  102fcf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102fd2:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102fd5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102fd8:	89 55 ec             	mov    %edx,-0x14(%ebp)
  102fdb:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102fde:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  102fe1:	8b 45 18             	mov    0x18(%ebp),%eax
  102fe4:	ba 00 00 00 00       	mov    $0x0,%edx
  102fe9:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  102fec:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  102fef:	19 d1                	sbb    %edx,%ecx
  102ff1:	72 4c                	jb     10303f <printnum+0xdb>
        printnum(putch, putdat, result, base, width - 1, padc);
  102ff3:	8b 45 1c             	mov    0x1c(%ebp),%eax
  102ff6:	8d 50 ff             	lea    -0x1(%eax),%edx
  102ff9:	8b 45 20             	mov    0x20(%ebp),%eax
  102ffc:	89 44 24 18          	mov    %eax,0x18(%esp)
  103000:	89 54 24 14          	mov    %edx,0x14(%esp)
  103004:	8b 45 18             	mov    0x18(%ebp),%eax
  103007:	89 44 24 10          	mov    %eax,0x10(%esp)
  10300b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10300e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103011:	89 44 24 08          	mov    %eax,0x8(%esp)
  103015:	89 54 24 0c          	mov    %edx,0xc(%esp)
  103019:	8b 45 0c             	mov    0xc(%ebp),%eax
  10301c:	89 44 24 04          	mov    %eax,0x4(%esp)
  103020:	8b 45 08             	mov    0x8(%ebp),%eax
  103023:	89 04 24             	mov    %eax,(%esp)
  103026:	e8 39 ff ff ff       	call   102f64 <printnum>
  10302b:	eb 1b                	jmp    103048 <printnum+0xe4>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  10302d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103030:	89 44 24 04          	mov    %eax,0x4(%esp)
  103034:	8b 45 20             	mov    0x20(%ebp),%eax
  103037:	89 04 24             	mov    %eax,(%esp)
  10303a:	8b 45 08             	mov    0x8(%ebp),%eax
  10303d:	ff d0                	call   *%eax
        while (-- width > 0)
  10303f:	ff 4d 1c             	decl   0x1c(%ebp)
  103042:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  103046:	7f e5                	jg     10302d <printnum+0xc9>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  103048:	8b 45 d8             	mov    -0x28(%ebp),%eax
  10304b:	05 b0 3d 10 00       	add    $0x103db0,%eax
  103050:	0f b6 00             	movzbl (%eax),%eax
  103053:	0f be c0             	movsbl %al,%eax
  103056:	8b 55 0c             	mov    0xc(%ebp),%edx
  103059:	89 54 24 04          	mov    %edx,0x4(%esp)
  10305d:	89 04 24             	mov    %eax,(%esp)
  103060:	8b 45 08             	mov    0x8(%ebp),%eax
  103063:	ff d0                	call   *%eax
}
  103065:	90                   	nop
  103066:	c9                   	leave  
  103067:	c3                   	ret    

00103068 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  103068:	f3 0f 1e fb          	endbr32 
  10306c:	55                   	push   %ebp
  10306d:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  10306f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103073:	7e 14                	jle    103089 <getuint+0x21>
        return va_arg(*ap, unsigned long long);
  103075:	8b 45 08             	mov    0x8(%ebp),%eax
  103078:	8b 00                	mov    (%eax),%eax
  10307a:	8d 48 08             	lea    0x8(%eax),%ecx
  10307d:	8b 55 08             	mov    0x8(%ebp),%edx
  103080:	89 0a                	mov    %ecx,(%edx)
  103082:	8b 50 04             	mov    0x4(%eax),%edx
  103085:	8b 00                	mov    (%eax),%eax
  103087:	eb 30                	jmp    1030b9 <getuint+0x51>
    }
    else if (lflag) {
  103089:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10308d:	74 16                	je     1030a5 <getuint+0x3d>
        return va_arg(*ap, unsigned long);
  10308f:	8b 45 08             	mov    0x8(%ebp),%eax
  103092:	8b 00                	mov    (%eax),%eax
  103094:	8d 48 04             	lea    0x4(%eax),%ecx
  103097:	8b 55 08             	mov    0x8(%ebp),%edx
  10309a:	89 0a                	mov    %ecx,(%edx)
  10309c:	8b 00                	mov    (%eax),%eax
  10309e:	ba 00 00 00 00       	mov    $0x0,%edx
  1030a3:	eb 14                	jmp    1030b9 <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
  1030a5:	8b 45 08             	mov    0x8(%ebp),%eax
  1030a8:	8b 00                	mov    (%eax),%eax
  1030aa:	8d 48 04             	lea    0x4(%eax),%ecx
  1030ad:	8b 55 08             	mov    0x8(%ebp),%edx
  1030b0:	89 0a                	mov    %ecx,(%edx)
  1030b2:	8b 00                	mov    (%eax),%eax
  1030b4:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  1030b9:	5d                   	pop    %ebp
  1030ba:	c3                   	ret    

001030bb <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  1030bb:	f3 0f 1e fb          	endbr32 
  1030bf:	55                   	push   %ebp
  1030c0:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  1030c2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1030c6:	7e 14                	jle    1030dc <getint+0x21>
        return va_arg(*ap, long long);
  1030c8:	8b 45 08             	mov    0x8(%ebp),%eax
  1030cb:	8b 00                	mov    (%eax),%eax
  1030cd:	8d 48 08             	lea    0x8(%eax),%ecx
  1030d0:	8b 55 08             	mov    0x8(%ebp),%edx
  1030d3:	89 0a                	mov    %ecx,(%edx)
  1030d5:	8b 50 04             	mov    0x4(%eax),%edx
  1030d8:	8b 00                	mov    (%eax),%eax
  1030da:	eb 28                	jmp    103104 <getint+0x49>
    }
    else if (lflag) {
  1030dc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1030e0:	74 12                	je     1030f4 <getint+0x39>
        return va_arg(*ap, long);
  1030e2:	8b 45 08             	mov    0x8(%ebp),%eax
  1030e5:	8b 00                	mov    (%eax),%eax
  1030e7:	8d 48 04             	lea    0x4(%eax),%ecx
  1030ea:	8b 55 08             	mov    0x8(%ebp),%edx
  1030ed:	89 0a                	mov    %ecx,(%edx)
  1030ef:	8b 00                	mov    (%eax),%eax
  1030f1:	99                   	cltd   
  1030f2:	eb 10                	jmp    103104 <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
  1030f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1030f7:	8b 00                	mov    (%eax),%eax
  1030f9:	8d 48 04             	lea    0x4(%eax),%ecx
  1030fc:	8b 55 08             	mov    0x8(%ebp),%edx
  1030ff:	89 0a                	mov    %ecx,(%edx)
  103101:	8b 00                	mov    (%eax),%eax
  103103:	99                   	cltd   
    }
}
  103104:	5d                   	pop    %ebp
  103105:	c3                   	ret    

00103106 <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  103106:	f3 0f 1e fb          	endbr32 
  10310a:	55                   	push   %ebp
  10310b:	89 e5                	mov    %esp,%ebp
  10310d:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  103110:	8d 45 14             	lea    0x14(%ebp),%eax
  103113:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  103116:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103119:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10311d:	8b 45 10             	mov    0x10(%ebp),%eax
  103120:	89 44 24 08          	mov    %eax,0x8(%esp)
  103124:	8b 45 0c             	mov    0xc(%ebp),%eax
  103127:	89 44 24 04          	mov    %eax,0x4(%esp)
  10312b:	8b 45 08             	mov    0x8(%ebp),%eax
  10312e:	89 04 24             	mov    %eax,(%esp)
  103131:	e8 03 00 00 00       	call   103139 <vprintfmt>
    va_end(ap);
}
  103136:	90                   	nop
  103137:	c9                   	leave  
  103138:	c3                   	ret    

00103139 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  103139:	f3 0f 1e fb          	endbr32 
  10313d:	55                   	push   %ebp
  10313e:	89 e5                	mov    %esp,%ebp
  103140:	56                   	push   %esi
  103141:	53                   	push   %ebx
  103142:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103145:	eb 17                	jmp    10315e <vprintfmt+0x25>
            if (ch == '\0') {
  103147:	85 db                	test   %ebx,%ebx
  103149:	0f 84 c0 03 00 00    	je     10350f <vprintfmt+0x3d6>
                return;
            }
            putch(ch, putdat);
  10314f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103152:	89 44 24 04          	mov    %eax,0x4(%esp)
  103156:	89 1c 24             	mov    %ebx,(%esp)
  103159:	8b 45 08             	mov    0x8(%ebp),%eax
  10315c:	ff d0                	call   *%eax
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  10315e:	8b 45 10             	mov    0x10(%ebp),%eax
  103161:	8d 50 01             	lea    0x1(%eax),%edx
  103164:	89 55 10             	mov    %edx,0x10(%ebp)
  103167:	0f b6 00             	movzbl (%eax),%eax
  10316a:	0f b6 d8             	movzbl %al,%ebx
  10316d:	83 fb 25             	cmp    $0x25,%ebx
  103170:	75 d5                	jne    103147 <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
  103172:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  103176:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  10317d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103180:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  103183:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  10318a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10318d:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  103190:	8b 45 10             	mov    0x10(%ebp),%eax
  103193:	8d 50 01             	lea    0x1(%eax),%edx
  103196:	89 55 10             	mov    %edx,0x10(%ebp)
  103199:	0f b6 00             	movzbl (%eax),%eax
  10319c:	0f b6 d8             	movzbl %al,%ebx
  10319f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  1031a2:	83 f8 55             	cmp    $0x55,%eax
  1031a5:	0f 87 38 03 00 00    	ja     1034e3 <vprintfmt+0x3aa>
  1031ab:	8b 04 85 d4 3d 10 00 	mov    0x103dd4(,%eax,4),%eax
  1031b2:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  1031b5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  1031b9:	eb d5                	jmp    103190 <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  1031bb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  1031bf:	eb cf                	jmp    103190 <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  1031c1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  1031c8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1031cb:	89 d0                	mov    %edx,%eax
  1031cd:	c1 e0 02             	shl    $0x2,%eax
  1031d0:	01 d0                	add    %edx,%eax
  1031d2:	01 c0                	add    %eax,%eax
  1031d4:	01 d8                	add    %ebx,%eax
  1031d6:	83 e8 30             	sub    $0x30,%eax
  1031d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  1031dc:	8b 45 10             	mov    0x10(%ebp),%eax
  1031df:	0f b6 00             	movzbl (%eax),%eax
  1031e2:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  1031e5:	83 fb 2f             	cmp    $0x2f,%ebx
  1031e8:	7e 38                	jle    103222 <vprintfmt+0xe9>
  1031ea:	83 fb 39             	cmp    $0x39,%ebx
  1031ed:	7f 33                	jg     103222 <vprintfmt+0xe9>
            for (precision = 0; ; ++ fmt) {
  1031ef:	ff 45 10             	incl   0x10(%ebp)
                precision = precision * 10 + ch - '0';
  1031f2:	eb d4                	jmp    1031c8 <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  1031f4:	8b 45 14             	mov    0x14(%ebp),%eax
  1031f7:	8d 50 04             	lea    0x4(%eax),%edx
  1031fa:	89 55 14             	mov    %edx,0x14(%ebp)
  1031fd:	8b 00                	mov    (%eax),%eax
  1031ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  103202:	eb 1f                	jmp    103223 <vprintfmt+0xea>

        case '.':
            if (width < 0)
  103204:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103208:	79 86                	jns    103190 <vprintfmt+0x57>
                width = 0;
  10320a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  103211:	e9 7a ff ff ff       	jmp    103190 <vprintfmt+0x57>

        case '#':
            altflag = 1;
  103216:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  10321d:	e9 6e ff ff ff       	jmp    103190 <vprintfmt+0x57>
            goto process_precision;
  103222:	90                   	nop

        process_precision:
            if (width < 0)
  103223:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103227:	0f 89 63 ff ff ff    	jns    103190 <vprintfmt+0x57>
                width = precision, precision = -1;
  10322d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103230:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103233:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  10323a:	e9 51 ff ff ff       	jmp    103190 <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  10323f:	ff 45 e0             	incl   -0x20(%ebp)
            goto reswitch;
  103242:	e9 49 ff ff ff       	jmp    103190 <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  103247:	8b 45 14             	mov    0x14(%ebp),%eax
  10324a:	8d 50 04             	lea    0x4(%eax),%edx
  10324d:	89 55 14             	mov    %edx,0x14(%ebp)
  103250:	8b 00                	mov    (%eax),%eax
  103252:	8b 55 0c             	mov    0xc(%ebp),%edx
  103255:	89 54 24 04          	mov    %edx,0x4(%esp)
  103259:	89 04 24             	mov    %eax,(%esp)
  10325c:	8b 45 08             	mov    0x8(%ebp),%eax
  10325f:	ff d0                	call   *%eax
            break;
  103261:	e9 a4 02 00 00       	jmp    10350a <vprintfmt+0x3d1>

        // error message
        case 'e':
            err = va_arg(ap, int);
  103266:	8b 45 14             	mov    0x14(%ebp),%eax
  103269:	8d 50 04             	lea    0x4(%eax),%edx
  10326c:	89 55 14             	mov    %edx,0x14(%ebp)
  10326f:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  103271:	85 db                	test   %ebx,%ebx
  103273:	79 02                	jns    103277 <vprintfmt+0x13e>
                err = -err;
  103275:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  103277:	83 fb 06             	cmp    $0x6,%ebx
  10327a:	7f 0b                	jg     103287 <vprintfmt+0x14e>
  10327c:	8b 34 9d 94 3d 10 00 	mov    0x103d94(,%ebx,4),%esi
  103283:	85 f6                	test   %esi,%esi
  103285:	75 23                	jne    1032aa <vprintfmt+0x171>
                printfmt(putch, putdat, "error %d", err);
  103287:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  10328b:	c7 44 24 08 c1 3d 10 	movl   $0x103dc1,0x8(%esp)
  103292:	00 
  103293:	8b 45 0c             	mov    0xc(%ebp),%eax
  103296:	89 44 24 04          	mov    %eax,0x4(%esp)
  10329a:	8b 45 08             	mov    0x8(%ebp),%eax
  10329d:	89 04 24             	mov    %eax,(%esp)
  1032a0:	e8 61 fe ff ff       	call   103106 <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  1032a5:	e9 60 02 00 00       	jmp    10350a <vprintfmt+0x3d1>
                printfmt(putch, putdat, "%s", p);
  1032aa:	89 74 24 0c          	mov    %esi,0xc(%esp)
  1032ae:	c7 44 24 08 ca 3d 10 	movl   $0x103dca,0x8(%esp)
  1032b5:	00 
  1032b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1032b9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1032bd:	8b 45 08             	mov    0x8(%ebp),%eax
  1032c0:	89 04 24             	mov    %eax,(%esp)
  1032c3:	e8 3e fe ff ff       	call   103106 <printfmt>
            break;
  1032c8:	e9 3d 02 00 00       	jmp    10350a <vprintfmt+0x3d1>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  1032cd:	8b 45 14             	mov    0x14(%ebp),%eax
  1032d0:	8d 50 04             	lea    0x4(%eax),%edx
  1032d3:	89 55 14             	mov    %edx,0x14(%ebp)
  1032d6:	8b 30                	mov    (%eax),%esi
  1032d8:	85 f6                	test   %esi,%esi
  1032da:	75 05                	jne    1032e1 <vprintfmt+0x1a8>
                p = "(null)";
  1032dc:	be cd 3d 10 00       	mov    $0x103dcd,%esi
            }
            if (width > 0 && padc != '-') {
  1032e1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1032e5:	7e 76                	jle    10335d <vprintfmt+0x224>
  1032e7:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  1032eb:	74 70                	je     10335d <vprintfmt+0x224>
                for (width -= strnlen(p, precision); width > 0; width --) {
  1032ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1032f0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1032f4:	89 34 24             	mov    %esi,(%esp)
  1032f7:	e8 ba f7 ff ff       	call   102ab6 <strnlen>
  1032fc:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1032ff:	29 c2                	sub    %eax,%edx
  103301:	89 d0                	mov    %edx,%eax
  103303:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103306:	eb 16                	jmp    10331e <vprintfmt+0x1e5>
                    putch(padc, putdat);
  103308:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  10330c:	8b 55 0c             	mov    0xc(%ebp),%edx
  10330f:	89 54 24 04          	mov    %edx,0x4(%esp)
  103313:	89 04 24             	mov    %eax,(%esp)
  103316:	8b 45 08             	mov    0x8(%ebp),%eax
  103319:	ff d0                	call   *%eax
                for (width -= strnlen(p, precision); width > 0; width --) {
  10331b:	ff 4d e8             	decl   -0x18(%ebp)
  10331e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103322:	7f e4                	jg     103308 <vprintfmt+0x1cf>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  103324:	eb 37                	jmp    10335d <vprintfmt+0x224>
                if (altflag && (ch < ' ' || ch > '~')) {
  103326:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  10332a:	74 1f                	je     10334b <vprintfmt+0x212>
  10332c:	83 fb 1f             	cmp    $0x1f,%ebx
  10332f:	7e 05                	jle    103336 <vprintfmt+0x1fd>
  103331:	83 fb 7e             	cmp    $0x7e,%ebx
  103334:	7e 15                	jle    10334b <vprintfmt+0x212>
                    putch('?', putdat);
  103336:	8b 45 0c             	mov    0xc(%ebp),%eax
  103339:	89 44 24 04          	mov    %eax,0x4(%esp)
  10333d:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  103344:	8b 45 08             	mov    0x8(%ebp),%eax
  103347:	ff d0                	call   *%eax
  103349:	eb 0f                	jmp    10335a <vprintfmt+0x221>
                }
                else {
                    putch(ch, putdat);
  10334b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10334e:	89 44 24 04          	mov    %eax,0x4(%esp)
  103352:	89 1c 24             	mov    %ebx,(%esp)
  103355:	8b 45 08             	mov    0x8(%ebp),%eax
  103358:	ff d0                	call   *%eax
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  10335a:	ff 4d e8             	decl   -0x18(%ebp)
  10335d:	89 f0                	mov    %esi,%eax
  10335f:	8d 70 01             	lea    0x1(%eax),%esi
  103362:	0f b6 00             	movzbl (%eax),%eax
  103365:	0f be d8             	movsbl %al,%ebx
  103368:	85 db                	test   %ebx,%ebx
  10336a:	74 27                	je     103393 <vprintfmt+0x25a>
  10336c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103370:	78 b4                	js     103326 <vprintfmt+0x1ed>
  103372:	ff 4d e4             	decl   -0x1c(%ebp)
  103375:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103379:	79 ab                	jns    103326 <vprintfmt+0x1ed>
                }
            }
            for (; width > 0; width --) {
  10337b:	eb 16                	jmp    103393 <vprintfmt+0x25a>
                putch(' ', putdat);
  10337d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103380:	89 44 24 04          	mov    %eax,0x4(%esp)
  103384:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10338b:	8b 45 08             	mov    0x8(%ebp),%eax
  10338e:	ff d0                	call   *%eax
            for (; width > 0; width --) {
  103390:	ff 4d e8             	decl   -0x18(%ebp)
  103393:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103397:	7f e4                	jg     10337d <vprintfmt+0x244>
            }
            break;
  103399:	e9 6c 01 00 00       	jmp    10350a <vprintfmt+0x3d1>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  10339e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1033a1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033a5:	8d 45 14             	lea    0x14(%ebp),%eax
  1033a8:	89 04 24             	mov    %eax,(%esp)
  1033ab:	e8 0b fd ff ff       	call   1030bb <getint>
  1033b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1033b3:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  1033b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1033b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1033bc:	85 d2                	test   %edx,%edx
  1033be:	79 26                	jns    1033e6 <vprintfmt+0x2ad>
                putch('-', putdat);
  1033c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033c3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033c7:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  1033ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1033d1:	ff d0                	call   *%eax
                num = -(long long)num;
  1033d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1033d6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1033d9:	f7 d8                	neg    %eax
  1033db:	83 d2 00             	adc    $0x0,%edx
  1033de:	f7 da                	neg    %edx
  1033e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1033e3:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  1033e6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1033ed:	e9 a8 00 00 00       	jmp    10349a <vprintfmt+0x361>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  1033f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1033f5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033f9:	8d 45 14             	lea    0x14(%ebp),%eax
  1033fc:	89 04 24             	mov    %eax,(%esp)
  1033ff:	e8 64 fc ff ff       	call   103068 <getuint>
  103404:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103407:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  10340a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  103411:	e9 84 00 00 00       	jmp    10349a <vprintfmt+0x361>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  103416:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103419:	89 44 24 04          	mov    %eax,0x4(%esp)
  10341d:	8d 45 14             	lea    0x14(%ebp),%eax
  103420:	89 04 24             	mov    %eax,(%esp)
  103423:	e8 40 fc ff ff       	call   103068 <getuint>
  103428:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10342b:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  10342e:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  103435:	eb 63                	jmp    10349a <vprintfmt+0x361>

        // pointer
        case 'p':
            putch('0', putdat);
  103437:	8b 45 0c             	mov    0xc(%ebp),%eax
  10343a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10343e:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  103445:	8b 45 08             	mov    0x8(%ebp),%eax
  103448:	ff d0                	call   *%eax
            putch('x', putdat);
  10344a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10344d:	89 44 24 04          	mov    %eax,0x4(%esp)
  103451:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  103458:	8b 45 08             	mov    0x8(%ebp),%eax
  10345b:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  10345d:	8b 45 14             	mov    0x14(%ebp),%eax
  103460:	8d 50 04             	lea    0x4(%eax),%edx
  103463:	89 55 14             	mov    %edx,0x14(%ebp)
  103466:	8b 00                	mov    (%eax),%eax
  103468:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10346b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  103472:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  103479:	eb 1f                	jmp    10349a <vprintfmt+0x361>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  10347b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10347e:	89 44 24 04          	mov    %eax,0x4(%esp)
  103482:	8d 45 14             	lea    0x14(%ebp),%eax
  103485:	89 04 24             	mov    %eax,(%esp)
  103488:	e8 db fb ff ff       	call   103068 <getuint>
  10348d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103490:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  103493:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  10349a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  10349e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1034a1:	89 54 24 18          	mov    %edx,0x18(%esp)
  1034a5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1034a8:	89 54 24 14          	mov    %edx,0x14(%esp)
  1034ac:	89 44 24 10          	mov    %eax,0x10(%esp)
  1034b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034b3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1034b6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1034ba:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1034be:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034c1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1034c8:	89 04 24             	mov    %eax,(%esp)
  1034cb:	e8 94 fa ff ff       	call   102f64 <printnum>
            break;
  1034d0:	eb 38                	jmp    10350a <vprintfmt+0x3d1>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  1034d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034d5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034d9:	89 1c 24             	mov    %ebx,(%esp)
  1034dc:	8b 45 08             	mov    0x8(%ebp),%eax
  1034df:	ff d0                	call   *%eax
            break;
  1034e1:	eb 27                	jmp    10350a <vprintfmt+0x3d1>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  1034e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034e6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034ea:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  1034f1:	8b 45 08             	mov    0x8(%ebp),%eax
  1034f4:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  1034f6:	ff 4d 10             	decl   0x10(%ebp)
  1034f9:	eb 03                	jmp    1034fe <vprintfmt+0x3c5>
  1034fb:	ff 4d 10             	decl   0x10(%ebp)
  1034fe:	8b 45 10             	mov    0x10(%ebp),%eax
  103501:	48                   	dec    %eax
  103502:	0f b6 00             	movzbl (%eax),%eax
  103505:	3c 25                	cmp    $0x25,%al
  103507:	75 f2                	jne    1034fb <vprintfmt+0x3c2>
                /* do nothing */;
            break;
  103509:	90                   	nop
    while (1) {
  10350a:	e9 36 fc ff ff       	jmp    103145 <vprintfmt+0xc>
                return;
  10350f:	90                   	nop
        }
    }
}
  103510:	83 c4 40             	add    $0x40,%esp
  103513:	5b                   	pop    %ebx
  103514:	5e                   	pop    %esi
  103515:	5d                   	pop    %ebp
  103516:	c3                   	ret    

00103517 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  103517:	f3 0f 1e fb          	endbr32 
  10351b:	55                   	push   %ebp
  10351c:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  10351e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103521:	8b 40 08             	mov    0x8(%eax),%eax
  103524:	8d 50 01             	lea    0x1(%eax),%edx
  103527:	8b 45 0c             	mov    0xc(%ebp),%eax
  10352a:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  10352d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103530:	8b 10                	mov    (%eax),%edx
  103532:	8b 45 0c             	mov    0xc(%ebp),%eax
  103535:	8b 40 04             	mov    0x4(%eax),%eax
  103538:	39 c2                	cmp    %eax,%edx
  10353a:	73 12                	jae    10354e <sprintputch+0x37>
        *b->buf ++ = ch;
  10353c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10353f:	8b 00                	mov    (%eax),%eax
  103541:	8d 48 01             	lea    0x1(%eax),%ecx
  103544:	8b 55 0c             	mov    0xc(%ebp),%edx
  103547:	89 0a                	mov    %ecx,(%edx)
  103549:	8b 55 08             	mov    0x8(%ebp),%edx
  10354c:	88 10                	mov    %dl,(%eax)
    }
}
  10354e:	90                   	nop
  10354f:	5d                   	pop    %ebp
  103550:	c3                   	ret    

00103551 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  103551:	f3 0f 1e fb          	endbr32 
  103555:	55                   	push   %ebp
  103556:	89 e5                	mov    %esp,%ebp
  103558:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  10355b:	8d 45 14             	lea    0x14(%ebp),%eax
  10355e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103561:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103564:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103568:	8b 45 10             	mov    0x10(%ebp),%eax
  10356b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10356f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103572:	89 44 24 04          	mov    %eax,0x4(%esp)
  103576:	8b 45 08             	mov    0x8(%ebp),%eax
  103579:	89 04 24             	mov    %eax,(%esp)
  10357c:	e8 08 00 00 00       	call   103589 <vsnprintf>
  103581:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103584:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103587:	c9                   	leave  
  103588:	c3                   	ret    

00103589 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  103589:	f3 0f 1e fb          	endbr32 
  10358d:	55                   	push   %ebp
  10358e:	89 e5                	mov    %esp,%ebp
  103590:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  103593:	8b 45 08             	mov    0x8(%ebp),%eax
  103596:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103599:	8b 45 0c             	mov    0xc(%ebp),%eax
  10359c:	8d 50 ff             	lea    -0x1(%eax),%edx
  10359f:	8b 45 08             	mov    0x8(%ebp),%eax
  1035a2:	01 d0                	add    %edx,%eax
  1035a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1035a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  1035ae:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1035b2:	74 0a                	je     1035be <vsnprintf+0x35>
  1035b4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1035b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1035ba:	39 c2                	cmp    %eax,%edx
  1035bc:	76 07                	jbe    1035c5 <vsnprintf+0x3c>
        return -E_INVAL;
  1035be:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  1035c3:	eb 2a                	jmp    1035ef <vsnprintf+0x66>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  1035c5:	8b 45 14             	mov    0x14(%ebp),%eax
  1035c8:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1035cc:	8b 45 10             	mov    0x10(%ebp),%eax
  1035cf:	89 44 24 08          	mov    %eax,0x8(%esp)
  1035d3:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1035d6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1035da:	c7 04 24 17 35 10 00 	movl   $0x103517,(%esp)
  1035e1:	e8 53 fb ff ff       	call   103139 <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  1035e6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1035e9:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1035ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1035ef:	c9                   	leave  
  1035f0:	c3                   	ret    
