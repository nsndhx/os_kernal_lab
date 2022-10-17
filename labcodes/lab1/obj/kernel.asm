
bin/kernelÔºö     Êñá‰ª∂Ê†ºÂºè elf32-i386


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
  100027:	e8 46 2e 00 00       	call   102e72 <memset>

    cons_init();                // init the console
  10002c:	e8 0a 16 00 00       	call   10163b <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 a0 36 10 00 	movl   $0x1036a0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 bc 36 10 00 	movl   $0x1036bc,(%esp)
  100046:	e8 48 02 00 00       	call   100293 <cprintf>

    print_kerninfo();
  10004b:	e8 06 09 00 00       	call   100956 <print_kerninfo>

    grade_backtrace();
  100050:	e8 9a 00 00 00       	call   1000ef <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 c7 2a 00 00       	call   102b21 <pmm_init>

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
  100145:	c7 04 24 c1 36 10 00 	movl   $0x1036c1,(%esp)
  10014c:	e8 42 01 00 00       	call   100293 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100151:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100155:	89 c2                	mov    %eax,%edx
  100157:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10015c:	89 54 24 08          	mov    %edx,0x8(%esp)
  100160:	89 44 24 04          	mov    %eax,0x4(%esp)
  100164:	c7 04 24 cf 36 10 00 	movl   $0x1036cf,(%esp)
  10016b:	e8 23 01 00 00       	call   100293 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  100170:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100174:	89 c2                	mov    %eax,%edx
  100176:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10017b:	89 54 24 08          	mov    %edx,0x8(%esp)
  10017f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100183:	c7 04 24 dd 36 10 00 	movl   $0x1036dd,(%esp)
  10018a:	e8 04 01 00 00       	call   100293 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  10018f:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100193:	89 c2                	mov    %eax,%edx
  100195:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10019a:	89 54 24 08          	mov    %edx,0x8(%esp)
  10019e:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001a2:	c7 04 24 eb 36 10 00 	movl   $0x1036eb,(%esp)
  1001a9:	e8 e5 00 00 00       	call   100293 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  1001ae:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001b2:	89 c2                	mov    %eax,%edx
  1001b4:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  1001b9:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001c1:	c7 04 24 f9 36 10 00 	movl   $0x1036f9,(%esp)
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
    lab1_print_cur_status();//print ÂΩìÂâç cs/ss/ds Á≠âÂØÑÂ≠òÂô®Áä∂ÊÄÅ
  100203:	e8 11 ff ff ff       	call   100119 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  100208:	c7 04 24 08 37 10 00 	movl   $0x103708,(%esp)
  10020f:	e8 7f 00 00 00       	call   100293 <cprintf>
    lab1_switch_to_user();
  100214:	e8 c2 ff ff ff       	call   1001db <lab1_switch_to_user>
    lab1_print_cur_status();
  100219:	e8 fb fe ff ff       	call   100119 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  10021e:	c7 04 24 28 37 10 00 	movl   $0x103728,(%esp)
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
  100289:	e8 50 2f 00 00       	call   1031de <vprintfmt>
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
  10035d:	c7 04 24 47 37 10 00 	movl   $0x103747,(%esp)
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
  100430:	c7 04 24 4a 37 10 00 	movl   $0x10374a,(%esp)
  100437:	e8 57 fe ff ff       	call   100293 <cprintf>
    vcprintf(fmt, ap);
  10043c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10043f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100443:	8b 45 10             	mov    0x10(%ebp),%eax
  100446:	89 04 24             	mov    %eax,(%esp)
  100449:	e8 0e fe ff ff       	call   10025c <vcprintf>
    cprintf("\n");
  10044e:	c7 04 24 66 37 10 00 	movl   $0x103766,(%esp)
  100455:	e8 39 fe ff ff       	call   100293 <cprintf>
    
    cprintf("stack trackback:\n");
  10045a:	c7 04 24 68 37 10 00 	movl   $0x103768,(%esp)
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
  10049f:	c7 04 24 7a 37 10 00 	movl   $0x10377a,(%esp)
  1004a6:	e8 e8 fd ff ff       	call   100293 <cprintf>
    vcprintf(fmt, ap);
  1004ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004ae:	89 44 24 04          	mov    %eax,0x4(%esp)
  1004b2:	8b 45 10             	mov    0x10(%ebp),%eax
  1004b5:	89 04 24             	mov    %eax,(%esp)
  1004b8:	e8 9f fd ff ff       	call   10025c <vcprintf>
    cprintf("\n");
  1004bd:	c7 04 24 66 37 10 00 	movl   $0x103766,(%esp)
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
  100639:	c7 00 98 37 10 00    	movl   $0x103798,(%eax)
    info->eip_line = 0;
  10063f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100642:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100649:	8b 45 0c             	mov    0xc(%ebp),%eax
  10064c:	c7 40 08 98 37 10 00 	movl   $0x103798,0x8(%eax)
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
  100670:	c7 45 f4 cc 3f 10 00 	movl   $0x103fcc,-0xc(%ebp)
    stab_end = __STAB_END__;
  100677:	c7 45 f0 5c cd 10 00 	movl   $0x10cd5c,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  10067e:	c7 45 ec 5d cd 10 00 	movl   $0x10cd5d,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100685:	c7 45 e8 34 ee 10 00 	movl   $0x10ee34,-0x18(%ebp)

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
  1007d8:	e8 09 25 00 00       	call   102ce6 <strfind>
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
  100960:	c7 04 24 a2 37 10 00 	movl   $0x1037a2,(%esp)
  100967:	e8 27 f9 ff ff       	call   100293 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  10096c:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  100973:	00 
  100974:	c7 04 24 bb 37 10 00 	movl   $0x1037bb,(%esp)
  10097b:	e8 13 f9 ff ff       	call   100293 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  100980:	c7 44 24 04 96 36 10 	movl   $0x103696,0x4(%esp)
  100987:	00 
  100988:	c7 04 24 d3 37 10 00 	movl   $0x1037d3,(%esp)
  10098f:	e8 ff f8 ff ff       	call   100293 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  100994:	c7 44 24 04 16 fa 10 	movl   $0x10fa16,0x4(%esp)
  10099b:	00 
  10099c:	c7 04 24 eb 37 10 00 	movl   $0x1037eb,(%esp)
  1009a3:	e8 eb f8 ff ff       	call   100293 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  1009a8:	c7 44 24 04 20 0d 11 	movl   $0x110d20,0x4(%esp)
  1009af:	00 
  1009b0:	c7 04 24 03 38 10 00 	movl   $0x103803,(%esp)
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
  1009dd:	c7 04 24 1c 38 10 00 	movl   $0x10381c,(%esp)
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
  100a16:	c7 04 24 46 38 10 00 	movl   $0x103846,(%esp)
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
  100a84:	c7 04 24 62 38 10 00 	movl   $0x103862,(%esp)
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
    uint32_t ebp=read_ebp();   //Ë∞ÉÁî®read ebpËÆøÈóÆÂΩìÂâçebpÁöÑÂÄºÔºåÊï∞ÊçÆÁ±ªÂûã‰∏∫32‰Ωç„ÄÇ
  100aba:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32_t eip=read_eip();   //Ë∞ÉÁî®read eipËÆøÈóÆeipÁöÑÂÄºÔºåÊï∞ÊçÆÁ±ªÂûãÂêå„ÄÇ
  100abd:	e8 d1 ff ff ff       	call   100a93 <read_eip>
  100ac2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int i;   //ËøôÈáåÊúâ‰∏™ÁªÜËäÇÈóÆÈ¢òÔºåÂ∞±ÊòØ‰∏çËÉΩfor int iÔºåËøôÈáåÈù¢ÁöÑCÊ†áÂáÜ‰ºº‰πé‰∏çÂÖÅËÆ∏
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
  100adc:	c7 04 24 74 38 10 00 	movl   $0x103874,(%esp)
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
  100b07:	c7 04 24 8b 38 10 00 	movl   $0x10388b,(%esp)
  100b0e:	e8 80 f7 ff ff       	call   100293 <cprintf>
		for(int j=0;j<4;j++){
  100b13:	ff 45 e8             	incl   -0x18(%ebp)
  100b16:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100b1a:	7e d5                	jle    100af1 <print_stackframe+0x49>
        }
		cprintf("\n");
  100b1c:	c7 04 24 93 38 10 00 	movl   $0x103893,(%esp)
  100b23:	e8 6b f7 ff ff       	call   100293 <cprintf>
 
		//Âõ†‰∏∫‰ΩøÁî®ÁöÑÊòØÊ†àÊï∞ÊçÆÁªìÊûÑÔºåÂõ†Ê≠§ÂèØ‰ª•Áõ¥Êé•Ê†πÊçÆebpÂ∞±ËÉΩËØªÂèñÂà∞ÂêÑ‰∏™Ê†àÂ∏ßÁöÑÂú∞ÂùÄÂíåÂÄºÔºåebp+4Â§Ñ‰∏∫ËøîÂõûÂú∞ÂùÄÔºåebp+8Â§Ñ‰∏∫Á¨¨‰∏Ä‰∏™ÂèÇÊï∞ÂÄºÔºàÊúÄÂêé‰∏Ä‰∏™ÂÖ•Ê†àÁöÑÂèÇÊï∞ÂÄºÔºåÂØπÂ∫î32‰ΩçÁ≥ªÁªüÔºâÔºåebp-4Â§Ñ‰∏∫Á¨¨‰∏Ä‰∏™Â±ÄÈÉ®ÂèòÈáèÔºåebpÂ§Ñ‰∏∫‰∏ä‰∏ÄÂ±Ç ebp ÂÄº„ÄÇ
 
		//ËÄåËøôÈáåÔºå*‰ª£Ë°®ÊåáÈíàÔºåÊåáÈíà‰πüÊòØÂç†Áî®4‰∏™Â≠óËäÇÔºåÂõ†Ê≠§ÂèØ‰ª•Áõ¥Êé•ÂØπ‰∫éÊåáÈíàÂä†‰∏ÄÔºåÂú∞ÂùÄÂä†4„ÄÇ
 
		print_debuginfo(eip-1);	//ÊâìÂç∞eip‰ª•ÂèäebpÁõ∏ÂÖ≥ÁöÑ‰ø°ÊÅØ
  100b28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b2b:	48                   	dec    %eax
  100b2c:	89 04 24             	mov    %eax,(%esp)
  100b2f:	e8 b8 fe ff ff       	call   1009ec <print_debuginfo>
		eip=*((uint32_t *)ebp+1);//Ê≠§Êó∂eipÊåáÂêë‰∫ÜËøîÂõûÂú∞ÂùÄ
  100b34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b37:	83 c0 04             	add    $0x4,%eax
  100b3a:	8b 00                	mov    (%eax),%eax
  100b3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
		ebp=*((uint32_t *)ebp+0);//ebpÊåáÂêë‰∫ÜÂéüebpÁöÑ‰ΩçÁΩÆ
  100b3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b42:	8b 00                	mov    (%eax),%eax
  100b44:	89 45 f4             	mov    %eax,-0xc(%ebp)
	for(i=0;i<STACKFRAME_DEPTH&&ebp!=0;i++)
  100b47:	ff 45 ec             	incl   -0x14(%ebp)
  100b4a:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100b4e:	7f 0a                	jg     100b5a <print_stackframe+0xb2>
  100b50:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b54:	0f 85 74 ff ff ff    	jne    100ace <print_stackframe+0x26>
//ÊúÄÂêéÊõ¥Êñ∞ebpÔºöebp=ebp[0],Êõ¥Êñ∞eipÔºöeip=ebp[1]ÔºåÂõ†‰∏∫ebp[0]=ebpÔºåebp[1]=ebp[0]+4=eip„ÄÇ
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
  100b93:	c7 04 24 18 39 10 00 	movl   $0x103918,(%esp)
  100b9a:	e8 11 21 00 00       	call   102cb0 <strchr>
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
  100bbb:	c7 04 24 1d 39 10 00 	movl   $0x10391d,(%esp)
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
  100bfd:	c7 04 24 18 39 10 00 	movl   $0x103918,(%esp)
  100c04:	e8 a7 20 00 00       	call   102cb0 <strchr>
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
  100c6e:	e8 99 1f 00 00       	call   102c0c <strcmp>
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
  100cba:	c7 04 24 3b 39 10 00 	movl   $0x10393b,(%esp)
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
  100cdb:	c7 04 24 54 39 10 00 	movl   $0x103954,(%esp)
  100ce2:	e8 ac f5 ff ff       	call   100293 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100ce7:	c7 04 24 7c 39 10 00 	movl   $0x10397c,(%esp)
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
  100d04:	c7 04 24 a1 39 10 00 	movl   $0x1039a1,(%esp)
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
  100d76:	c7 04 24 a5 39 10 00 	movl   $0x1039a5,(%esp)
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
  100e10:	c7 04 24 ae 39 10 00 	movl   $0x1039ae,(%esp)
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
//    -- Êï∞ÊçÆÂØÑÂ≠òÂô® Êò†Â∞Ñ Âà∞ Á´ØÂè£ 0x3D5Êàñ0x3B5 
//    -- Á¥¢ÂºïÂØÑÂ≠òÂô® 0x3D4Êàñ0x3B4,ÂÜ≥ÂÆöÂú®Êï∞ÊçÆÂØÑÂ≠òÂô®‰∏≠ÁöÑÊï∞ÊçÆË°®Á§∫‰ªÄ‰πà„ÄÇ

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100e78:	f3 0f 1e fb          	endbr32 
  100e7c:	55                   	push   %ebp
  100e7d:	89 e5                	mov    %esp,%ebp
  100e7f:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (ÂΩ©Ëâ≤ÊòæÁ§∫ÁöÑÊòæÂ≠òÁâ©ÁêÜÂü∫ÂùÄ)
  100e82:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //‰øùÂ≠òÂΩìÂâçÊòæÂ≠ò0xB8000Â§ÑÁöÑÂÄº
  100e89:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e8c:	0f b7 00             	movzwl (%eax),%eax
  100e8f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // ÁªôËøô‰∏™Âú∞ÂùÄÈöè‰æøÂÜô‰∏™ÂÄºÔºåÁúãÁúãËÉΩÂê¶ÂÜçËØªÂá∫ÂêåÊ†∑ÁöÑÂÄº
  100e93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e96:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // Â¶ÇÊûúËØª‰∏çÂá∫Êù•ÔºåËØ¥ÊòéÊ≤°ÊúâËøôÂùóÊòæÂ≠òÔºåÂç≥ÊòØÂçïÊòæÈÖçÁΩÆ
  100e9b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e9e:	0f b7 00             	movzwl (%eax),%eax
  100ea1:	0f b7 c0             	movzwl %ax,%eax
  100ea4:	3d 5a a5 00 00       	cmp    $0xa55a,%eax
  100ea9:	74 12                	je     100ebd <cga_init+0x45>
        cp = (uint16_t*)MONO_BUF;                         //ËÆæÁΩÆ‰∏∫ÂçïÊòæÁöÑÊòæÂ≠òÂü∫ÂùÄ MONO_BUFÔºö 0xB0000
  100eab:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //ËÆæÁΩÆ‰∏∫ÂçïÊòæÊéßÂà∂ÁöÑIOÂú∞ÂùÄÔºåMONO_BASE: 0x3B4
  100eb2:	66 c7 05 66 fe 10 00 	movw   $0x3b4,0x10fe66
  100eb9:	b4 03 
  100ebb:	eb 13                	jmp    100ed0 <cga_init+0x58>
    } else {                                                                // Â¶ÇÊûúËØªÂá∫Êù•‰∫ÜÔºåÊúâËøôÂùóÊòæÂ≠òÔºåÂç≥ÊòØÂΩ©ÊòæÈÖçÁΩÆ
        *cp = was;                                                      //ËøòÂéüÂéüÊù•ÊòæÂ≠ò‰ΩçÁΩÆÁöÑÂÄº
  100ebd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ec0:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100ec4:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // ËÆæÁΩÆ‰∏∫ÂΩ©ÊòæÊéßÂà∂ÁöÑIOÂú∞ÂùÄÔºåCGA_BASE: 0x3D4 
  100ec7:	66 c7 05 66 fe 10 00 	movw   $0x3d4,0x10fe66
  100ece:	d4 03 
    // Extract cursor location
    // 6845Á¥¢ÂºïÂØÑÂ≠òÂô®ÁöÑindex 0x0EÔºàÂèäÂçÅËøõÂà∂ÁöÑ14Ôºâ== ÂÖâÊ†á‰ΩçÁΩÆ(È´ò‰Ωç)
    // 6845Á¥¢ÂºïÂØÑÂ≠òÂô®ÁöÑindex 0x0FÔºàÂèäÂçÅËøõÂà∂ÁöÑ15Ôºâ== ÂÖâÊ†á‰ΩçÁΩÆ(‰Ωé‰Ωç)
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
    pos = inb(addr_6845 + 1) << 8;                       //ËØªÂá∫‰∫ÜÂÖâÊ†á‰ΩçÁΩÆ(È´ò‰Ωç)
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
    pos |= inb(addr_6845 + 1);                             //ËØªÂá∫‰∫ÜÂÖâÊ†á‰ΩçÁΩÆ(‰Ωé‰Ωç)
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

    crt_buf = (uint16_t*) cp;                                  //crt_bufÊòØCGAÊòæÂ≠òËµ∑ÂßãÂú∞ÂùÄ
  100f4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f4e:	a3 60 fe 10 00       	mov    %eax,0x10fe60
    crt_pos = pos;                                                  //crt_posÊòØCGAÂΩìÂâçÂÖâÊ†á‰ΩçÁΩÆ
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
  101242:	e8 6e 1c 00 00       	call   102eb5 <memmove>
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
  1015e0:	c7 04 24 c9 39 10 00 	movl   $0x1039c9,(%esp)
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
  10165d:	c7 04 24 d5 39 10 00 	movl   $0x1039d5,(%esp)
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
  101906:	c7 04 24 00 3a 10 00 	movl   $0x103a00,(%esp)
  10190d:	e8 81 e9 ff ff       	call   100293 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
  101912:	c7 04 24 0a 3a 10 00 	movl   $0x103a0a,(%esp)
  101919:	e8 75 e9 ff ff       	call   100293 <cprintf>
    panic("EOT: kernel seems ok.");
  10191e:	c7 44 24 08 18 3a 10 	movl   $0x103a18,0x8(%esp)
  101925:	00 
  101926:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
  10192d:	00 
  10192e:	c7 04 24 2e 3a 10 00 	movl   $0x103a2e,(%esp)
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
        //”…∏√Œƒº˛ø…÷™£¨À˘”–÷–∂œœÚ¡øµƒ÷–∂œ¥¶¿Ì∫Ø ˝µÿ÷∑æ˘±£¥Ê‘⁄__vectors ˝◊È÷–£¨∏√ ˝◊È÷–µ⁄i∏ˆ‘™Àÿ∂‘”¶µ⁄i∏ˆ÷–∂œœÚ¡øµƒ÷–∂œ¥¶¿Ì∫Ø ˝µÿ÷∑°£
        //∂¯«“”…Œƒº˛ø™Õ∑ø…÷™£¨÷–∂œ¥¶¿Ì∫Ø ˝ Ù”⁄.textµƒƒ⁄»›°£“Ú¥À£¨÷–∂œ¥¶¿Ì∫Ø ˝µƒ∂Œ—°‘Ò◊”º¥.textµƒ∂Œ—°‘Ò◊”GD_KTEXT°£
        //¥”kern / mm / pmm.cø…÷™.textµƒ∂Œª˘÷∑Œ™0£¨“Ú¥À÷–∂œ¥¶¿Ì∫Ø ˝µÿ÷∑µƒ∆´“∆¡øµ»”⁄∆‰µÿ÷∑±æ…Ì°£
        //dpl  DPL_KERNEL
        // ≥˝¡ÀT_SWITCH_TOK «DPL_USER∆‰À˚∂º «DPL_KERNEL°£
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);//≥ı ºªØidt
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
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);//“ÚŒ™‘⁄∑¢…˙÷–∂œ ±∫Ú£¨Œ“√«–Ë“™¥””√ªßÃ¨«–ªªµΩƒ⁄∫ÀÃ¨£¨À˘“‘µ√¡Ù∏ˆø⁄»√”√ªßÃ¨Ω¯¿¥
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
  101ac3:	8b 04 85 80 3d 10 00 	mov    0x103d80(,%eax,4),%eax
  101aca:	eb 18                	jmp    101ae4 <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101acc:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101ad0:	7e 0d                	jle    101adf <trapname+0x2e>
  101ad2:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101ad6:	7f 07                	jg     101adf <trapname+0x2e>
        return "Hardware Interrupt";
  101ad8:	b8 3f 3a 10 00       	mov    $0x103a3f,%eax
  101add:	eb 05                	jmp    101ae4 <trapname+0x33>
    }
    return "(unknown trap)";
  101adf:	b8 52 3a 10 00       	mov    $0x103a52,%eax
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
  101b10:	c7 04 24 93 3a 10 00 	movl   $0x103a93,(%esp)
  101b17:	e8 77 e7 ff ff       	call   100293 <cprintf>
    print_regs(&tf->tf_regs);
  101b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  101b1f:	89 04 24             	mov    %eax,(%esp)
  101b22:	e8 8d 01 00 00       	call   101cb4 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101b27:	8b 45 08             	mov    0x8(%ebp),%eax
  101b2a:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101b2e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b32:	c7 04 24 a4 3a 10 00 	movl   $0x103aa4,(%esp)
  101b39:	e8 55 e7 ff ff       	call   100293 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  101b41:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101b45:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b49:	c7 04 24 b7 3a 10 00 	movl   $0x103ab7,(%esp)
  101b50:	e8 3e e7 ff ff       	call   100293 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101b55:	8b 45 08             	mov    0x8(%ebp),%eax
  101b58:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101b5c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b60:	c7 04 24 ca 3a 10 00 	movl   $0x103aca,(%esp)
  101b67:	e8 27 e7 ff ff       	call   100293 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  101b6f:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101b73:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b77:	c7 04 24 dd 3a 10 00 	movl   $0x103add,(%esp)
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
  101b9f:	c7 04 24 f0 3a 10 00 	movl   $0x103af0,(%esp)
  101ba6:	e8 e8 e6 ff ff       	call   100293 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101bab:	8b 45 08             	mov    0x8(%ebp),%eax
  101bae:	8b 40 34             	mov    0x34(%eax),%eax
  101bb1:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bb5:	c7 04 24 02 3b 10 00 	movl   $0x103b02,(%esp)
  101bbc:	e8 d2 e6 ff ff       	call   100293 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  101bc4:	8b 40 38             	mov    0x38(%eax),%eax
  101bc7:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bcb:	c7 04 24 11 3b 10 00 	movl   $0x103b11,(%esp)
  101bd2:	e8 bc e6 ff ff       	call   100293 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101bd7:	8b 45 08             	mov    0x8(%ebp),%eax
  101bda:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101bde:	89 44 24 04          	mov    %eax,0x4(%esp)
  101be2:	c7 04 24 20 3b 10 00 	movl   $0x103b20,(%esp)
  101be9:	e8 a5 e6 ff ff       	call   100293 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101bee:	8b 45 08             	mov    0x8(%ebp),%eax
  101bf1:	8b 40 40             	mov    0x40(%eax),%eax
  101bf4:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bf8:	c7 04 24 33 3b 10 00 	movl   $0x103b33,(%esp)
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
  101c3f:	c7 04 24 42 3b 10 00 	movl   $0x103b42,(%esp)
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
  101c69:	c7 04 24 46 3b 10 00 	movl   $0x103b46,(%esp)
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
  101c8e:	c7 04 24 4f 3b 10 00 	movl   $0x103b4f,(%esp)
  101c95:	e8 f9 e5 ff ff       	call   100293 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  101c9d:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101ca1:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ca5:	c7 04 24 5e 3b 10 00 	movl   $0x103b5e,(%esp)
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
  101cc7:	c7 04 24 71 3b 10 00 	movl   $0x103b71,(%esp)
  101cce:	e8 c0 e5 ff ff       	call   100293 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  101cd6:	8b 40 04             	mov    0x4(%eax),%eax
  101cd9:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cdd:	c7 04 24 80 3b 10 00 	movl   $0x103b80,(%esp)
  101ce4:	e8 aa e5 ff ff       	call   100293 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101ce9:	8b 45 08             	mov    0x8(%ebp),%eax
  101cec:	8b 40 08             	mov    0x8(%eax),%eax
  101cef:	89 44 24 04          	mov    %eax,0x4(%esp)
  101cf3:	c7 04 24 8f 3b 10 00 	movl   $0x103b8f,(%esp)
  101cfa:	e8 94 e5 ff ff       	call   100293 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101cff:	8b 45 08             	mov    0x8(%ebp),%eax
  101d02:	8b 40 0c             	mov    0xc(%eax),%eax
  101d05:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d09:	c7 04 24 9e 3b 10 00 	movl   $0x103b9e,(%esp)
  101d10:	e8 7e e5 ff ff       	call   100293 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101d15:	8b 45 08             	mov    0x8(%ebp),%eax
  101d18:	8b 40 10             	mov    0x10(%eax),%eax
  101d1b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d1f:	c7 04 24 ad 3b 10 00 	movl   $0x103bad,(%esp)
  101d26:	e8 68 e5 ff ff       	call   100293 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  101d2e:	8b 40 14             	mov    0x14(%eax),%eax
  101d31:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d35:	c7 04 24 bc 3b 10 00 	movl   $0x103bbc,(%esp)
  101d3c:	e8 52 e5 ff ff       	call   100293 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101d41:	8b 45 08             	mov    0x8(%ebp),%eax
  101d44:	8b 40 18             	mov    0x18(%eax),%eax
  101d47:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d4b:	c7 04 24 cb 3b 10 00 	movl   $0x103bcb,(%esp)
  101d52:	e8 3c e5 ff ff       	call   100293 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101d57:	8b 45 08             	mov    0x8(%ebp),%eax
  101d5a:	8b 40 1c             	mov    0x1c(%eax),%eax
  101d5d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d61:	c7 04 24 da 3b 10 00 	movl   $0x103bda,(%esp)
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
  101d83:	0f 84 35 01 00 00    	je     101ebe <trap_dispatch+0x14e>
  101d89:	83 f8 79             	cmp    $0x79,%eax
  101d8c:	0f 87 6d 01 00 00    	ja     101eff <trap_dispatch+0x18f>
  101d92:	83 f8 78             	cmp    $0x78,%eax
  101d95:	0f 84 d0 00 00 00    	je     101e6b <trap_dispatch+0xfb>
  101d9b:	83 f8 78             	cmp    $0x78,%eax
  101d9e:	0f 87 5b 01 00 00    	ja     101eff <trap_dispatch+0x18f>
  101da4:	83 f8 2f             	cmp    $0x2f,%eax
  101da7:	0f 87 52 01 00 00    	ja     101eff <trap_dispatch+0x18f>
  101dad:	83 f8 2e             	cmp    $0x2e,%eax
  101db0:	0f 83 7e 01 00 00    	jae    101f34 <trap_dispatch+0x1c4>
  101db6:	83 f8 24             	cmp    $0x24,%eax
  101db9:	74 5e                	je     101e19 <trap_dispatch+0xa9>
  101dbb:	83 f8 24             	cmp    $0x24,%eax
  101dbe:	0f 87 3b 01 00 00    	ja     101eff <trap_dispatch+0x18f>
  101dc4:	83 f8 20             	cmp    $0x20,%eax
  101dc7:	74 0a                	je     101dd3 <trap_dispatch+0x63>
  101dc9:	83 f8 21             	cmp    $0x21,%eax
  101dcc:	74 74                	je     101e42 <trap_dispatch+0xd2>
  101dce:	e9 2c 01 00 00       	jmp    101eff <trap_dispatch+0x18f>
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
  101e09:	0f 85 28 01 00 00    	jne    101f37 <trap_dispatch+0x1c7>
            print_ticks();
  101e0f:	e8 e0 fa ff ff       	call   1018f4 <print_ticks>
        }
        break;
  101e14:	e9 1e 01 00 00       	jmp    101f37 <trap_dispatch+0x1c7>
    case IRQ_OFFSET + IRQ_COM1://»Ù÷–∂œ∫≈ «IRQ_OFFSET + IRQ_COM1 Œ™¥Æø⁄÷–∂œ£¨‘Úœ‘ æ ’µΩµƒ◊÷∑˚
        c = cons_getc();
  101e19:	e8 7c f8 ff ff       	call   10169a <cons_getc>
  101e1e:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101e21:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e25:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e29:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e31:	c7 04 24 e9 3b 10 00 	movl   $0x103be9,(%esp)
  101e38:	e8 56 e4 ff ff       	call   100293 <cprintf>
        break;
  101e3d:	e9 fc 00 00 00       	jmp    101f3e <trap_dispatch+0x1ce>
    case IRQ_OFFSET + IRQ_KBD://»Ù÷–∂œ∫≈ «IRQ_OFFSET + IRQ_KBD Œ™ º¸≈Ã÷–∂œ£¨‘Úœ‘ æ ’µΩµƒ◊÷∑˚
        c = cons_getc();
  101e42:	e8 53 f8 ff ff       	call   10169a <cons_getc>
  101e47:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101e4a:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101e4e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101e52:	89 54 24 08          	mov    %edx,0x8(%esp)
  101e56:	89 44 24 04          	mov    %eax,0x4(%esp)
  101e5a:	c7 04 24 fb 3b 10 00 	movl   $0x103bfb,(%esp)
  101e61:	e8 2d e4 ff ff       	call   100293 <cprintf>
        break;
  101e66:	e9 d3 00 00 00       	jmp    101f3e <trap_dispatch+0x1ce>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    //tf trapframe  ’ª÷°Ω·ππÃÂ
    case T_SWITCH_TOU://ƒ⁄∫À°˙”√ªß
        //panic("T_SWITCH_USER ??\n");
    	if (tf->tf_cs != USER_CS) {
  101e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  101e6e:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e72:	83 f8 1b             	cmp    $0x1b,%eax
  101e75:	0f 84 bf 00 00 00    	je     101f3a <trap_dispatch+0x1ca>
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
            //tf->tf_esp += 4;
            tf->tf_eflags |= FL_IOPL_MASK;
  101ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  101eac:	8b 40 40             	mov    0x40(%eax),%eax
  101eaf:	0d 00 30 00 00       	or     $0x3000,%eax
  101eb4:	89 c2                	mov    %eax,%edx
  101eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  101eb9:	89 50 40             	mov    %edx,0x40(%eax)
        }
        break;
  101ebc:	eb 7c                	jmp    101f3a <trap_dispatch+0x1ca>
    case T_SWITCH_TOK://”√ªß°˙ƒ⁄∫À
        //panic("T_SWITCH_KERNEL ??\n");
        if (tf->tf_cs != KERNEL_CS) {
  101ebe:	8b 45 08             	mov    0x8(%ebp),%eax
  101ec1:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ec5:	83 f8 08             	cmp    $0x8,%eax
  101ec8:	74 73                	je     101f3d <trap_dispatch+0x1cd>
            tf->tf_cs = KERNEL_CS;
  101eca:	8b 45 08             	mov    0x8(%ebp),%eax
  101ecd:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  101ed3:	8b 45 08             	mov    0x8(%ebp),%eax
  101ed6:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101edc:	8b 45 08             	mov    0x8(%ebp),%eax
  101edf:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101ee3:	8b 45 08             	mov    0x8(%ebp),%eax
  101ee6:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  101eea:	8b 45 08             	mov    0x8(%ebp),%eax
  101eed:	8b 40 40             	mov    0x40(%eax),%eax
  101ef0:	25 ff cf ff ff       	and    $0xffffcfff,%eax
  101ef5:	89 c2                	mov    %eax,%edx
  101ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  101efa:	89 50 40             	mov    %edx,0x40(%eax)
        }
        break;
  101efd:	eb 3e                	jmp    101f3d <trap_dispatch+0x1cd>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101eff:	8b 45 08             	mov    0x8(%ebp),%eax
  101f02:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101f06:	83 e0 03             	and    $0x3,%eax
  101f09:	85 c0                	test   %eax,%eax
  101f0b:	75 31                	jne    101f3e <trap_dispatch+0x1ce>
            print_trapframe(tf);
  101f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  101f10:	89 04 24             	mov    %eax,(%esp)
  101f13:	e8 e7 fb ff ff       	call   101aff <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101f18:	c7 44 24 08 0a 3c 10 	movl   $0x103c0a,0x8(%esp)
  101f1f:	00 
  101f20:	c7 44 24 04 e5 00 00 	movl   $0xe5,0x4(%esp)
  101f27:	00 
  101f28:	c7 04 24 2e 3a 10 00 	movl   $0x103a2e,(%esp)
  101f2f:	e8 cb e4 ff ff       	call   1003ff <__panic>
        break;
  101f34:	90                   	nop
  101f35:	eb 07                	jmp    101f3e <trap_dispatch+0x1ce>
        break;
  101f37:	90                   	nop
  101f38:	eb 04                	jmp    101f3e <trap_dispatch+0x1ce>
        break;
  101f3a:	90                   	nop
  101f3b:	eb 01                	jmp    101f3e <trap_dispatch+0x1ce>
        break;
  101f3d:	90                   	nop
        }
    }
}
  101f3e:	90                   	nop
  101f3f:	c9                   	leave  
  101f40:	c3                   	ret    

00101f41 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101f41:	f3 0f 1e fb          	endbr32 
  101f45:	55                   	push   %ebp
  101f46:	89 e5                	mov    %esp,%ebp
  101f48:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101f4b:	8b 45 08             	mov    0x8(%ebp),%eax
  101f4e:	89 04 24             	mov    %eax,(%esp)
  101f51:	e8 1a fe ff ff       	call   101d70 <trap_dispatch>
}
  101f56:	90                   	nop
  101f57:	c9                   	leave  
  101f58:	c3                   	ret    

00101f59 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101f59:	6a 00                	push   $0x0
  pushl $0
  101f5b:	6a 00                	push   $0x0
  jmp __alltraps
  101f5d:	e9 69 0a 00 00       	jmp    1029cb <__alltraps>

00101f62 <vector1>:
.globl vector1
vector1:
  pushl $0
  101f62:	6a 00                	push   $0x0
  pushl $1
  101f64:	6a 01                	push   $0x1
  jmp __alltraps
  101f66:	e9 60 0a 00 00       	jmp    1029cb <__alltraps>

00101f6b <vector2>:
.globl vector2
vector2:
  pushl $0
  101f6b:	6a 00                	push   $0x0
  pushl $2
  101f6d:	6a 02                	push   $0x2
  jmp __alltraps
  101f6f:	e9 57 0a 00 00       	jmp    1029cb <__alltraps>

00101f74 <vector3>:
.globl vector3
vector3:
  pushl $0
  101f74:	6a 00                	push   $0x0
  pushl $3
  101f76:	6a 03                	push   $0x3
  jmp __alltraps
  101f78:	e9 4e 0a 00 00       	jmp    1029cb <__alltraps>

00101f7d <vector4>:
.globl vector4
vector4:
  pushl $0
  101f7d:	6a 00                	push   $0x0
  pushl $4
  101f7f:	6a 04                	push   $0x4
  jmp __alltraps
  101f81:	e9 45 0a 00 00       	jmp    1029cb <__alltraps>

00101f86 <vector5>:
.globl vector5
vector5:
  pushl $0
  101f86:	6a 00                	push   $0x0
  pushl $5
  101f88:	6a 05                	push   $0x5
  jmp __alltraps
  101f8a:	e9 3c 0a 00 00       	jmp    1029cb <__alltraps>

00101f8f <vector6>:
.globl vector6
vector6:
  pushl $0
  101f8f:	6a 00                	push   $0x0
  pushl $6
  101f91:	6a 06                	push   $0x6
  jmp __alltraps
  101f93:	e9 33 0a 00 00       	jmp    1029cb <__alltraps>

00101f98 <vector7>:
.globl vector7
vector7:
  pushl $0
  101f98:	6a 00                	push   $0x0
  pushl $7
  101f9a:	6a 07                	push   $0x7
  jmp __alltraps
  101f9c:	e9 2a 0a 00 00       	jmp    1029cb <__alltraps>

00101fa1 <vector8>:
.globl vector8
vector8:
  pushl $8
  101fa1:	6a 08                	push   $0x8
  jmp __alltraps
  101fa3:	e9 23 0a 00 00       	jmp    1029cb <__alltraps>

00101fa8 <vector9>:
.globl vector9
vector9:
  pushl $0
  101fa8:	6a 00                	push   $0x0
  pushl $9
  101faa:	6a 09                	push   $0x9
  jmp __alltraps
  101fac:	e9 1a 0a 00 00       	jmp    1029cb <__alltraps>

00101fb1 <vector10>:
.globl vector10
vector10:
  pushl $10
  101fb1:	6a 0a                	push   $0xa
  jmp __alltraps
  101fb3:	e9 13 0a 00 00       	jmp    1029cb <__alltraps>

00101fb8 <vector11>:
.globl vector11
vector11:
  pushl $11
  101fb8:	6a 0b                	push   $0xb
  jmp __alltraps
  101fba:	e9 0c 0a 00 00       	jmp    1029cb <__alltraps>

00101fbf <vector12>:
.globl vector12
vector12:
  pushl $12
  101fbf:	6a 0c                	push   $0xc
  jmp __alltraps
  101fc1:	e9 05 0a 00 00       	jmp    1029cb <__alltraps>

00101fc6 <vector13>:
.globl vector13
vector13:
  pushl $13
  101fc6:	6a 0d                	push   $0xd
  jmp __alltraps
  101fc8:	e9 fe 09 00 00       	jmp    1029cb <__alltraps>

00101fcd <vector14>:
.globl vector14
vector14:
  pushl $14
  101fcd:	6a 0e                	push   $0xe
  jmp __alltraps
  101fcf:	e9 f7 09 00 00       	jmp    1029cb <__alltraps>

00101fd4 <vector15>:
.globl vector15
vector15:
  pushl $0
  101fd4:	6a 00                	push   $0x0
  pushl $15
  101fd6:	6a 0f                	push   $0xf
  jmp __alltraps
  101fd8:	e9 ee 09 00 00       	jmp    1029cb <__alltraps>

00101fdd <vector16>:
.globl vector16
vector16:
  pushl $0
  101fdd:	6a 00                	push   $0x0
  pushl $16
  101fdf:	6a 10                	push   $0x10
  jmp __alltraps
  101fe1:	e9 e5 09 00 00       	jmp    1029cb <__alltraps>

00101fe6 <vector17>:
.globl vector17
vector17:
  pushl $17
  101fe6:	6a 11                	push   $0x11
  jmp __alltraps
  101fe8:	e9 de 09 00 00       	jmp    1029cb <__alltraps>

00101fed <vector18>:
.globl vector18
vector18:
  pushl $0
  101fed:	6a 00                	push   $0x0
  pushl $18
  101fef:	6a 12                	push   $0x12
  jmp __alltraps
  101ff1:	e9 d5 09 00 00       	jmp    1029cb <__alltraps>

00101ff6 <vector19>:
.globl vector19
vector19:
  pushl $0
  101ff6:	6a 00                	push   $0x0
  pushl $19
  101ff8:	6a 13                	push   $0x13
  jmp __alltraps
  101ffa:	e9 cc 09 00 00       	jmp    1029cb <__alltraps>

00101fff <vector20>:
.globl vector20
vector20:
  pushl $0
  101fff:	6a 00                	push   $0x0
  pushl $20
  102001:	6a 14                	push   $0x14
  jmp __alltraps
  102003:	e9 c3 09 00 00       	jmp    1029cb <__alltraps>

00102008 <vector21>:
.globl vector21
vector21:
  pushl $0
  102008:	6a 00                	push   $0x0
  pushl $21
  10200a:	6a 15                	push   $0x15
  jmp __alltraps
  10200c:	e9 ba 09 00 00       	jmp    1029cb <__alltraps>

00102011 <vector22>:
.globl vector22
vector22:
  pushl $0
  102011:	6a 00                	push   $0x0
  pushl $22
  102013:	6a 16                	push   $0x16
  jmp __alltraps
  102015:	e9 b1 09 00 00       	jmp    1029cb <__alltraps>

0010201a <vector23>:
.globl vector23
vector23:
  pushl $0
  10201a:	6a 00                	push   $0x0
  pushl $23
  10201c:	6a 17                	push   $0x17
  jmp __alltraps
  10201e:	e9 a8 09 00 00       	jmp    1029cb <__alltraps>

00102023 <vector24>:
.globl vector24
vector24:
  pushl $0
  102023:	6a 00                	push   $0x0
  pushl $24
  102025:	6a 18                	push   $0x18
  jmp __alltraps
  102027:	e9 9f 09 00 00       	jmp    1029cb <__alltraps>

0010202c <vector25>:
.globl vector25
vector25:
  pushl $0
  10202c:	6a 00                	push   $0x0
  pushl $25
  10202e:	6a 19                	push   $0x19
  jmp __alltraps
  102030:	e9 96 09 00 00       	jmp    1029cb <__alltraps>

00102035 <vector26>:
.globl vector26
vector26:
  pushl $0
  102035:	6a 00                	push   $0x0
  pushl $26
  102037:	6a 1a                	push   $0x1a
  jmp __alltraps
  102039:	e9 8d 09 00 00       	jmp    1029cb <__alltraps>

0010203e <vector27>:
.globl vector27
vector27:
  pushl $0
  10203e:	6a 00                	push   $0x0
  pushl $27
  102040:	6a 1b                	push   $0x1b
  jmp __alltraps
  102042:	e9 84 09 00 00       	jmp    1029cb <__alltraps>

00102047 <vector28>:
.globl vector28
vector28:
  pushl $0
  102047:	6a 00                	push   $0x0
  pushl $28
  102049:	6a 1c                	push   $0x1c
  jmp __alltraps
  10204b:	e9 7b 09 00 00       	jmp    1029cb <__alltraps>

00102050 <vector29>:
.globl vector29
vector29:
  pushl $0
  102050:	6a 00                	push   $0x0
  pushl $29
  102052:	6a 1d                	push   $0x1d
  jmp __alltraps
  102054:	e9 72 09 00 00       	jmp    1029cb <__alltraps>

00102059 <vector30>:
.globl vector30
vector30:
  pushl $0
  102059:	6a 00                	push   $0x0
  pushl $30
  10205b:	6a 1e                	push   $0x1e
  jmp __alltraps
  10205d:	e9 69 09 00 00       	jmp    1029cb <__alltraps>

00102062 <vector31>:
.globl vector31
vector31:
  pushl $0
  102062:	6a 00                	push   $0x0
  pushl $31
  102064:	6a 1f                	push   $0x1f
  jmp __alltraps
  102066:	e9 60 09 00 00       	jmp    1029cb <__alltraps>

0010206b <vector32>:
.globl vector32
vector32:
  pushl $0
  10206b:	6a 00                	push   $0x0
  pushl $32
  10206d:	6a 20                	push   $0x20
  jmp __alltraps
  10206f:	e9 57 09 00 00       	jmp    1029cb <__alltraps>

00102074 <vector33>:
.globl vector33
vector33:
  pushl $0
  102074:	6a 00                	push   $0x0
  pushl $33
  102076:	6a 21                	push   $0x21
  jmp __alltraps
  102078:	e9 4e 09 00 00       	jmp    1029cb <__alltraps>

0010207d <vector34>:
.globl vector34
vector34:
  pushl $0
  10207d:	6a 00                	push   $0x0
  pushl $34
  10207f:	6a 22                	push   $0x22
  jmp __alltraps
  102081:	e9 45 09 00 00       	jmp    1029cb <__alltraps>

00102086 <vector35>:
.globl vector35
vector35:
  pushl $0
  102086:	6a 00                	push   $0x0
  pushl $35
  102088:	6a 23                	push   $0x23
  jmp __alltraps
  10208a:	e9 3c 09 00 00       	jmp    1029cb <__alltraps>

0010208f <vector36>:
.globl vector36
vector36:
  pushl $0
  10208f:	6a 00                	push   $0x0
  pushl $36
  102091:	6a 24                	push   $0x24
  jmp __alltraps
  102093:	e9 33 09 00 00       	jmp    1029cb <__alltraps>

00102098 <vector37>:
.globl vector37
vector37:
  pushl $0
  102098:	6a 00                	push   $0x0
  pushl $37
  10209a:	6a 25                	push   $0x25
  jmp __alltraps
  10209c:	e9 2a 09 00 00       	jmp    1029cb <__alltraps>

001020a1 <vector38>:
.globl vector38
vector38:
  pushl $0
  1020a1:	6a 00                	push   $0x0
  pushl $38
  1020a3:	6a 26                	push   $0x26
  jmp __alltraps
  1020a5:	e9 21 09 00 00       	jmp    1029cb <__alltraps>

001020aa <vector39>:
.globl vector39
vector39:
  pushl $0
  1020aa:	6a 00                	push   $0x0
  pushl $39
  1020ac:	6a 27                	push   $0x27
  jmp __alltraps
  1020ae:	e9 18 09 00 00       	jmp    1029cb <__alltraps>

001020b3 <vector40>:
.globl vector40
vector40:
  pushl $0
  1020b3:	6a 00                	push   $0x0
  pushl $40
  1020b5:	6a 28                	push   $0x28
  jmp __alltraps
  1020b7:	e9 0f 09 00 00       	jmp    1029cb <__alltraps>

001020bc <vector41>:
.globl vector41
vector41:
  pushl $0
  1020bc:	6a 00                	push   $0x0
  pushl $41
  1020be:	6a 29                	push   $0x29
  jmp __alltraps
  1020c0:	e9 06 09 00 00       	jmp    1029cb <__alltraps>

001020c5 <vector42>:
.globl vector42
vector42:
  pushl $0
  1020c5:	6a 00                	push   $0x0
  pushl $42
  1020c7:	6a 2a                	push   $0x2a
  jmp __alltraps
  1020c9:	e9 fd 08 00 00       	jmp    1029cb <__alltraps>

001020ce <vector43>:
.globl vector43
vector43:
  pushl $0
  1020ce:	6a 00                	push   $0x0
  pushl $43
  1020d0:	6a 2b                	push   $0x2b
  jmp __alltraps
  1020d2:	e9 f4 08 00 00       	jmp    1029cb <__alltraps>

001020d7 <vector44>:
.globl vector44
vector44:
  pushl $0
  1020d7:	6a 00                	push   $0x0
  pushl $44
  1020d9:	6a 2c                	push   $0x2c
  jmp __alltraps
  1020db:	e9 eb 08 00 00       	jmp    1029cb <__alltraps>

001020e0 <vector45>:
.globl vector45
vector45:
  pushl $0
  1020e0:	6a 00                	push   $0x0
  pushl $45
  1020e2:	6a 2d                	push   $0x2d
  jmp __alltraps
  1020e4:	e9 e2 08 00 00       	jmp    1029cb <__alltraps>

001020e9 <vector46>:
.globl vector46
vector46:
  pushl $0
  1020e9:	6a 00                	push   $0x0
  pushl $46
  1020eb:	6a 2e                	push   $0x2e
  jmp __alltraps
  1020ed:	e9 d9 08 00 00       	jmp    1029cb <__alltraps>

001020f2 <vector47>:
.globl vector47
vector47:
  pushl $0
  1020f2:	6a 00                	push   $0x0
  pushl $47
  1020f4:	6a 2f                	push   $0x2f
  jmp __alltraps
  1020f6:	e9 d0 08 00 00       	jmp    1029cb <__alltraps>

001020fb <vector48>:
.globl vector48
vector48:
  pushl $0
  1020fb:	6a 00                	push   $0x0
  pushl $48
  1020fd:	6a 30                	push   $0x30
  jmp __alltraps
  1020ff:	e9 c7 08 00 00       	jmp    1029cb <__alltraps>

00102104 <vector49>:
.globl vector49
vector49:
  pushl $0
  102104:	6a 00                	push   $0x0
  pushl $49
  102106:	6a 31                	push   $0x31
  jmp __alltraps
  102108:	e9 be 08 00 00       	jmp    1029cb <__alltraps>

0010210d <vector50>:
.globl vector50
vector50:
  pushl $0
  10210d:	6a 00                	push   $0x0
  pushl $50
  10210f:	6a 32                	push   $0x32
  jmp __alltraps
  102111:	e9 b5 08 00 00       	jmp    1029cb <__alltraps>

00102116 <vector51>:
.globl vector51
vector51:
  pushl $0
  102116:	6a 00                	push   $0x0
  pushl $51
  102118:	6a 33                	push   $0x33
  jmp __alltraps
  10211a:	e9 ac 08 00 00       	jmp    1029cb <__alltraps>

0010211f <vector52>:
.globl vector52
vector52:
  pushl $0
  10211f:	6a 00                	push   $0x0
  pushl $52
  102121:	6a 34                	push   $0x34
  jmp __alltraps
  102123:	e9 a3 08 00 00       	jmp    1029cb <__alltraps>

00102128 <vector53>:
.globl vector53
vector53:
  pushl $0
  102128:	6a 00                	push   $0x0
  pushl $53
  10212a:	6a 35                	push   $0x35
  jmp __alltraps
  10212c:	e9 9a 08 00 00       	jmp    1029cb <__alltraps>

00102131 <vector54>:
.globl vector54
vector54:
  pushl $0
  102131:	6a 00                	push   $0x0
  pushl $54
  102133:	6a 36                	push   $0x36
  jmp __alltraps
  102135:	e9 91 08 00 00       	jmp    1029cb <__alltraps>

0010213a <vector55>:
.globl vector55
vector55:
  pushl $0
  10213a:	6a 00                	push   $0x0
  pushl $55
  10213c:	6a 37                	push   $0x37
  jmp __alltraps
  10213e:	e9 88 08 00 00       	jmp    1029cb <__alltraps>

00102143 <vector56>:
.globl vector56
vector56:
  pushl $0
  102143:	6a 00                	push   $0x0
  pushl $56
  102145:	6a 38                	push   $0x38
  jmp __alltraps
  102147:	e9 7f 08 00 00       	jmp    1029cb <__alltraps>

0010214c <vector57>:
.globl vector57
vector57:
  pushl $0
  10214c:	6a 00                	push   $0x0
  pushl $57
  10214e:	6a 39                	push   $0x39
  jmp __alltraps
  102150:	e9 76 08 00 00       	jmp    1029cb <__alltraps>

00102155 <vector58>:
.globl vector58
vector58:
  pushl $0
  102155:	6a 00                	push   $0x0
  pushl $58
  102157:	6a 3a                	push   $0x3a
  jmp __alltraps
  102159:	e9 6d 08 00 00       	jmp    1029cb <__alltraps>

0010215e <vector59>:
.globl vector59
vector59:
  pushl $0
  10215e:	6a 00                	push   $0x0
  pushl $59
  102160:	6a 3b                	push   $0x3b
  jmp __alltraps
  102162:	e9 64 08 00 00       	jmp    1029cb <__alltraps>

00102167 <vector60>:
.globl vector60
vector60:
  pushl $0
  102167:	6a 00                	push   $0x0
  pushl $60
  102169:	6a 3c                	push   $0x3c
  jmp __alltraps
  10216b:	e9 5b 08 00 00       	jmp    1029cb <__alltraps>

00102170 <vector61>:
.globl vector61
vector61:
  pushl $0
  102170:	6a 00                	push   $0x0
  pushl $61
  102172:	6a 3d                	push   $0x3d
  jmp __alltraps
  102174:	e9 52 08 00 00       	jmp    1029cb <__alltraps>

00102179 <vector62>:
.globl vector62
vector62:
  pushl $0
  102179:	6a 00                	push   $0x0
  pushl $62
  10217b:	6a 3e                	push   $0x3e
  jmp __alltraps
  10217d:	e9 49 08 00 00       	jmp    1029cb <__alltraps>

00102182 <vector63>:
.globl vector63
vector63:
  pushl $0
  102182:	6a 00                	push   $0x0
  pushl $63
  102184:	6a 3f                	push   $0x3f
  jmp __alltraps
  102186:	e9 40 08 00 00       	jmp    1029cb <__alltraps>

0010218b <vector64>:
.globl vector64
vector64:
  pushl $0
  10218b:	6a 00                	push   $0x0
  pushl $64
  10218d:	6a 40                	push   $0x40
  jmp __alltraps
  10218f:	e9 37 08 00 00       	jmp    1029cb <__alltraps>

00102194 <vector65>:
.globl vector65
vector65:
  pushl $0
  102194:	6a 00                	push   $0x0
  pushl $65
  102196:	6a 41                	push   $0x41
  jmp __alltraps
  102198:	e9 2e 08 00 00       	jmp    1029cb <__alltraps>

0010219d <vector66>:
.globl vector66
vector66:
  pushl $0
  10219d:	6a 00                	push   $0x0
  pushl $66
  10219f:	6a 42                	push   $0x42
  jmp __alltraps
  1021a1:	e9 25 08 00 00       	jmp    1029cb <__alltraps>

001021a6 <vector67>:
.globl vector67
vector67:
  pushl $0
  1021a6:	6a 00                	push   $0x0
  pushl $67
  1021a8:	6a 43                	push   $0x43
  jmp __alltraps
  1021aa:	e9 1c 08 00 00       	jmp    1029cb <__alltraps>

001021af <vector68>:
.globl vector68
vector68:
  pushl $0
  1021af:	6a 00                	push   $0x0
  pushl $68
  1021b1:	6a 44                	push   $0x44
  jmp __alltraps
  1021b3:	e9 13 08 00 00       	jmp    1029cb <__alltraps>

001021b8 <vector69>:
.globl vector69
vector69:
  pushl $0
  1021b8:	6a 00                	push   $0x0
  pushl $69
  1021ba:	6a 45                	push   $0x45
  jmp __alltraps
  1021bc:	e9 0a 08 00 00       	jmp    1029cb <__alltraps>

001021c1 <vector70>:
.globl vector70
vector70:
  pushl $0
  1021c1:	6a 00                	push   $0x0
  pushl $70
  1021c3:	6a 46                	push   $0x46
  jmp __alltraps
  1021c5:	e9 01 08 00 00       	jmp    1029cb <__alltraps>

001021ca <vector71>:
.globl vector71
vector71:
  pushl $0
  1021ca:	6a 00                	push   $0x0
  pushl $71
  1021cc:	6a 47                	push   $0x47
  jmp __alltraps
  1021ce:	e9 f8 07 00 00       	jmp    1029cb <__alltraps>

001021d3 <vector72>:
.globl vector72
vector72:
  pushl $0
  1021d3:	6a 00                	push   $0x0
  pushl $72
  1021d5:	6a 48                	push   $0x48
  jmp __alltraps
  1021d7:	e9 ef 07 00 00       	jmp    1029cb <__alltraps>

001021dc <vector73>:
.globl vector73
vector73:
  pushl $0
  1021dc:	6a 00                	push   $0x0
  pushl $73
  1021de:	6a 49                	push   $0x49
  jmp __alltraps
  1021e0:	e9 e6 07 00 00       	jmp    1029cb <__alltraps>

001021e5 <vector74>:
.globl vector74
vector74:
  pushl $0
  1021e5:	6a 00                	push   $0x0
  pushl $74
  1021e7:	6a 4a                	push   $0x4a
  jmp __alltraps
  1021e9:	e9 dd 07 00 00       	jmp    1029cb <__alltraps>

001021ee <vector75>:
.globl vector75
vector75:
  pushl $0
  1021ee:	6a 00                	push   $0x0
  pushl $75
  1021f0:	6a 4b                	push   $0x4b
  jmp __alltraps
  1021f2:	e9 d4 07 00 00       	jmp    1029cb <__alltraps>

001021f7 <vector76>:
.globl vector76
vector76:
  pushl $0
  1021f7:	6a 00                	push   $0x0
  pushl $76
  1021f9:	6a 4c                	push   $0x4c
  jmp __alltraps
  1021fb:	e9 cb 07 00 00       	jmp    1029cb <__alltraps>

00102200 <vector77>:
.globl vector77
vector77:
  pushl $0
  102200:	6a 00                	push   $0x0
  pushl $77
  102202:	6a 4d                	push   $0x4d
  jmp __alltraps
  102204:	e9 c2 07 00 00       	jmp    1029cb <__alltraps>

00102209 <vector78>:
.globl vector78
vector78:
  pushl $0
  102209:	6a 00                	push   $0x0
  pushl $78
  10220b:	6a 4e                	push   $0x4e
  jmp __alltraps
  10220d:	e9 b9 07 00 00       	jmp    1029cb <__alltraps>

00102212 <vector79>:
.globl vector79
vector79:
  pushl $0
  102212:	6a 00                	push   $0x0
  pushl $79
  102214:	6a 4f                	push   $0x4f
  jmp __alltraps
  102216:	e9 b0 07 00 00       	jmp    1029cb <__alltraps>

0010221b <vector80>:
.globl vector80
vector80:
  pushl $0
  10221b:	6a 00                	push   $0x0
  pushl $80
  10221d:	6a 50                	push   $0x50
  jmp __alltraps
  10221f:	e9 a7 07 00 00       	jmp    1029cb <__alltraps>

00102224 <vector81>:
.globl vector81
vector81:
  pushl $0
  102224:	6a 00                	push   $0x0
  pushl $81
  102226:	6a 51                	push   $0x51
  jmp __alltraps
  102228:	e9 9e 07 00 00       	jmp    1029cb <__alltraps>

0010222d <vector82>:
.globl vector82
vector82:
  pushl $0
  10222d:	6a 00                	push   $0x0
  pushl $82
  10222f:	6a 52                	push   $0x52
  jmp __alltraps
  102231:	e9 95 07 00 00       	jmp    1029cb <__alltraps>

00102236 <vector83>:
.globl vector83
vector83:
  pushl $0
  102236:	6a 00                	push   $0x0
  pushl $83
  102238:	6a 53                	push   $0x53
  jmp __alltraps
  10223a:	e9 8c 07 00 00       	jmp    1029cb <__alltraps>

0010223f <vector84>:
.globl vector84
vector84:
  pushl $0
  10223f:	6a 00                	push   $0x0
  pushl $84
  102241:	6a 54                	push   $0x54
  jmp __alltraps
  102243:	e9 83 07 00 00       	jmp    1029cb <__alltraps>

00102248 <vector85>:
.globl vector85
vector85:
  pushl $0
  102248:	6a 00                	push   $0x0
  pushl $85
  10224a:	6a 55                	push   $0x55
  jmp __alltraps
  10224c:	e9 7a 07 00 00       	jmp    1029cb <__alltraps>

00102251 <vector86>:
.globl vector86
vector86:
  pushl $0
  102251:	6a 00                	push   $0x0
  pushl $86
  102253:	6a 56                	push   $0x56
  jmp __alltraps
  102255:	e9 71 07 00 00       	jmp    1029cb <__alltraps>

0010225a <vector87>:
.globl vector87
vector87:
  pushl $0
  10225a:	6a 00                	push   $0x0
  pushl $87
  10225c:	6a 57                	push   $0x57
  jmp __alltraps
  10225e:	e9 68 07 00 00       	jmp    1029cb <__alltraps>

00102263 <vector88>:
.globl vector88
vector88:
  pushl $0
  102263:	6a 00                	push   $0x0
  pushl $88
  102265:	6a 58                	push   $0x58
  jmp __alltraps
  102267:	e9 5f 07 00 00       	jmp    1029cb <__alltraps>

0010226c <vector89>:
.globl vector89
vector89:
  pushl $0
  10226c:	6a 00                	push   $0x0
  pushl $89
  10226e:	6a 59                	push   $0x59
  jmp __alltraps
  102270:	e9 56 07 00 00       	jmp    1029cb <__alltraps>

00102275 <vector90>:
.globl vector90
vector90:
  pushl $0
  102275:	6a 00                	push   $0x0
  pushl $90
  102277:	6a 5a                	push   $0x5a
  jmp __alltraps
  102279:	e9 4d 07 00 00       	jmp    1029cb <__alltraps>

0010227e <vector91>:
.globl vector91
vector91:
  pushl $0
  10227e:	6a 00                	push   $0x0
  pushl $91
  102280:	6a 5b                	push   $0x5b
  jmp __alltraps
  102282:	e9 44 07 00 00       	jmp    1029cb <__alltraps>

00102287 <vector92>:
.globl vector92
vector92:
  pushl $0
  102287:	6a 00                	push   $0x0
  pushl $92
  102289:	6a 5c                	push   $0x5c
  jmp __alltraps
  10228b:	e9 3b 07 00 00       	jmp    1029cb <__alltraps>

00102290 <vector93>:
.globl vector93
vector93:
  pushl $0
  102290:	6a 00                	push   $0x0
  pushl $93
  102292:	6a 5d                	push   $0x5d
  jmp __alltraps
  102294:	e9 32 07 00 00       	jmp    1029cb <__alltraps>

00102299 <vector94>:
.globl vector94
vector94:
  pushl $0
  102299:	6a 00                	push   $0x0
  pushl $94
  10229b:	6a 5e                	push   $0x5e
  jmp __alltraps
  10229d:	e9 29 07 00 00       	jmp    1029cb <__alltraps>

001022a2 <vector95>:
.globl vector95
vector95:
  pushl $0
  1022a2:	6a 00                	push   $0x0
  pushl $95
  1022a4:	6a 5f                	push   $0x5f
  jmp __alltraps
  1022a6:	e9 20 07 00 00       	jmp    1029cb <__alltraps>

001022ab <vector96>:
.globl vector96
vector96:
  pushl $0
  1022ab:	6a 00                	push   $0x0
  pushl $96
  1022ad:	6a 60                	push   $0x60
  jmp __alltraps
  1022af:	e9 17 07 00 00       	jmp    1029cb <__alltraps>

001022b4 <vector97>:
.globl vector97
vector97:
  pushl $0
  1022b4:	6a 00                	push   $0x0
  pushl $97
  1022b6:	6a 61                	push   $0x61
  jmp __alltraps
  1022b8:	e9 0e 07 00 00       	jmp    1029cb <__alltraps>

001022bd <vector98>:
.globl vector98
vector98:
  pushl $0
  1022bd:	6a 00                	push   $0x0
  pushl $98
  1022bf:	6a 62                	push   $0x62
  jmp __alltraps
  1022c1:	e9 05 07 00 00       	jmp    1029cb <__alltraps>

001022c6 <vector99>:
.globl vector99
vector99:
  pushl $0
  1022c6:	6a 00                	push   $0x0
  pushl $99
  1022c8:	6a 63                	push   $0x63
  jmp __alltraps
  1022ca:	e9 fc 06 00 00       	jmp    1029cb <__alltraps>

001022cf <vector100>:
.globl vector100
vector100:
  pushl $0
  1022cf:	6a 00                	push   $0x0
  pushl $100
  1022d1:	6a 64                	push   $0x64
  jmp __alltraps
  1022d3:	e9 f3 06 00 00       	jmp    1029cb <__alltraps>

001022d8 <vector101>:
.globl vector101
vector101:
  pushl $0
  1022d8:	6a 00                	push   $0x0
  pushl $101
  1022da:	6a 65                	push   $0x65
  jmp __alltraps
  1022dc:	e9 ea 06 00 00       	jmp    1029cb <__alltraps>

001022e1 <vector102>:
.globl vector102
vector102:
  pushl $0
  1022e1:	6a 00                	push   $0x0
  pushl $102
  1022e3:	6a 66                	push   $0x66
  jmp __alltraps
  1022e5:	e9 e1 06 00 00       	jmp    1029cb <__alltraps>

001022ea <vector103>:
.globl vector103
vector103:
  pushl $0
  1022ea:	6a 00                	push   $0x0
  pushl $103
  1022ec:	6a 67                	push   $0x67
  jmp __alltraps
  1022ee:	e9 d8 06 00 00       	jmp    1029cb <__alltraps>

001022f3 <vector104>:
.globl vector104
vector104:
  pushl $0
  1022f3:	6a 00                	push   $0x0
  pushl $104
  1022f5:	6a 68                	push   $0x68
  jmp __alltraps
  1022f7:	e9 cf 06 00 00       	jmp    1029cb <__alltraps>

001022fc <vector105>:
.globl vector105
vector105:
  pushl $0
  1022fc:	6a 00                	push   $0x0
  pushl $105
  1022fe:	6a 69                	push   $0x69
  jmp __alltraps
  102300:	e9 c6 06 00 00       	jmp    1029cb <__alltraps>

00102305 <vector106>:
.globl vector106
vector106:
  pushl $0
  102305:	6a 00                	push   $0x0
  pushl $106
  102307:	6a 6a                	push   $0x6a
  jmp __alltraps
  102309:	e9 bd 06 00 00       	jmp    1029cb <__alltraps>

0010230e <vector107>:
.globl vector107
vector107:
  pushl $0
  10230e:	6a 00                	push   $0x0
  pushl $107
  102310:	6a 6b                	push   $0x6b
  jmp __alltraps
  102312:	e9 b4 06 00 00       	jmp    1029cb <__alltraps>

00102317 <vector108>:
.globl vector108
vector108:
  pushl $0
  102317:	6a 00                	push   $0x0
  pushl $108
  102319:	6a 6c                	push   $0x6c
  jmp __alltraps
  10231b:	e9 ab 06 00 00       	jmp    1029cb <__alltraps>

00102320 <vector109>:
.globl vector109
vector109:
  pushl $0
  102320:	6a 00                	push   $0x0
  pushl $109
  102322:	6a 6d                	push   $0x6d
  jmp __alltraps
  102324:	e9 a2 06 00 00       	jmp    1029cb <__alltraps>

00102329 <vector110>:
.globl vector110
vector110:
  pushl $0
  102329:	6a 00                	push   $0x0
  pushl $110
  10232b:	6a 6e                	push   $0x6e
  jmp __alltraps
  10232d:	e9 99 06 00 00       	jmp    1029cb <__alltraps>

00102332 <vector111>:
.globl vector111
vector111:
  pushl $0
  102332:	6a 00                	push   $0x0
  pushl $111
  102334:	6a 6f                	push   $0x6f
  jmp __alltraps
  102336:	e9 90 06 00 00       	jmp    1029cb <__alltraps>

0010233b <vector112>:
.globl vector112
vector112:
  pushl $0
  10233b:	6a 00                	push   $0x0
  pushl $112
  10233d:	6a 70                	push   $0x70
  jmp __alltraps
  10233f:	e9 87 06 00 00       	jmp    1029cb <__alltraps>

00102344 <vector113>:
.globl vector113
vector113:
  pushl $0
  102344:	6a 00                	push   $0x0
  pushl $113
  102346:	6a 71                	push   $0x71
  jmp __alltraps
  102348:	e9 7e 06 00 00       	jmp    1029cb <__alltraps>

0010234d <vector114>:
.globl vector114
vector114:
  pushl $0
  10234d:	6a 00                	push   $0x0
  pushl $114
  10234f:	6a 72                	push   $0x72
  jmp __alltraps
  102351:	e9 75 06 00 00       	jmp    1029cb <__alltraps>

00102356 <vector115>:
.globl vector115
vector115:
  pushl $0
  102356:	6a 00                	push   $0x0
  pushl $115
  102358:	6a 73                	push   $0x73
  jmp __alltraps
  10235a:	e9 6c 06 00 00       	jmp    1029cb <__alltraps>

0010235f <vector116>:
.globl vector116
vector116:
  pushl $0
  10235f:	6a 00                	push   $0x0
  pushl $116
  102361:	6a 74                	push   $0x74
  jmp __alltraps
  102363:	e9 63 06 00 00       	jmp    1029cb <__alltraps>

00102368 <vector117>:
.globl vector117
vector117:
  pushl $0
  102368:	6a 00                	push   $0x0
  pushl $117
  10236a:	6a 75                	push   $0x75
  jmp __alltraps
  10236c:	e9 5a 06 00 00       	jmp    1029cb <__alltraps>

00102371 <vector118>:
.globl vector118
vector118:
  pushl $0
  102371:	6a 00                	push   $0x0
  pushl $118
  102373:	6a 76                	push   $0x76
  jmp __alltraps
  102375:	e9 51 06 00 00       	jmp    1029cb <__alltraps>

0010237a <vector119>:
.globl vector119
vector119:
  pushl $0
  10237a:	6a 00                	push   $0x0
  pushl $119
  10237c:	6a 77                	push   $0x77
  jmp __alltraps
  10237e:	e9 48 06 00 00       	jmp    1029cb <__alltraps>

00102383 <vector120>:
.globl vector120
vector120:
  pushl $0
  102383:	6a 00                	push   $0x0
  pushl $120
  102385:	6a 78                	push   $0x78
  jmp __alltraps
  102387:	e9 3f 06 00 00       	jmp    1029cb <__alltraps>

0010238c <vector121>:
.globl vector121
vector121:
  pushl $0
  10238c:	6a 00                	push   $0x0
  pushl $121
  10238e:	6a 79                	push   $0x79
  jmp __alltraps
  102390:	e9 36 06 00 00       	jmp    1029cb <__alltraps>

00102395 <vector122>:
.globl vector122
vector122:
  pushl $0
  102395:	6a 00                	push   $0x0
  pushl $122
  102397:	6a 7a                	push   $0x7a
  jmp __alltraps
  102399:	e9 2d 06 00 00       	jmp    1029cb <__alltraps>

0010239e <vector123>:
.globl vector123
vector123:
  pushl $0
  10239e:	6a 00                	push   $0x0
  pushl $123
  1023a0:	6a 7b                	push   $0x7b
  jmp __alltraps
  1023a2:	e9 24 06 00 00       	jmp    1029cb <__alltraps>

001023a7 <vector124>:
.globl vector124
vector124:
  pushl $0
  1023a7:	6a 00                	push   $0x0
  pushl $124
  1023a9:	6a 7c                	push   $0x7c
  jmp __alltraps
  1023ab:	e9 1b 06 00 00       	jmp    1029cb <__alltraps>

001023b0 <vector125>:
.globl vector125
vector125:
  pushl $0
  1023b0:	6a 00                	push   $0x0
  pushl $125
  1023b2:	6a 7d                	push   $0x7d
  jmp __alltraps
  1023b4:	e9 12 06 00 00       	jmp    1029cb <__alltraps>

001023b9 <vector126>:
.globl vector126
vector126:
  pushl $0
  1023b9:	6a 00                	push   $0x0
  pushl $126
  1023bb:	6a 7e                	push   $0x7e
  jmp __alltraps
  1023bd:	e9 09 06 00 00       	jmp    1029cb <__alltraps>

001023c2 <vector127>:
.globl vector127
vector127:
  pushl $0
  1023c2:	6a 00                	push   $0x0
  pushl $127
  1023c4:	6a 7f                	push   $0x7f
  jmp __alltraps
  1023c6:	e9 00 06 00 00       	jmp    1029cb <__alltraps>

001023cb <vector128>:
.globl vector128
vector128:
  pushl $0
  1023cb:	6a 00                	push   $0x0
  pushl $128
  1023cd:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  1023d2:	e9 f4 05 00 00       	jmp    1029cb <__alltraps>

001023d7 <vector129>:
.globl vector129
vector129:
  pushl $0
  1023d7:	6a 00                	push   $0x0
  pushl $129
  1023d9:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  1023de:	e9 e8 05 00 00       	jmp    1029cb <__alltraps>

001023e3 <vector130>:
.globl vector130
vector130:
  pushl $0
  1023e3:	6a 00                	push   $0x0
  pushl $130
  1023e5:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  1023ea:	e9 dc 05 00 00       	jmp    1029cb <__alltraps>

001023ef <vector131>:
.globl vector131
vector131:
  pushl $0
  1023ef:	6a 00                	push   $0x0
  pushl $131
  1023f1:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  1023f6:	e9 d0 05 00 00       	jmp    1029cb <__alltraps>

001023fb <vector132>:
.globl vector132
vector132:
  pushl $0
  1023fb:	6a 00                	push   $0x0
  pushl $132
  1023fd:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102402:	e9 c4 05 00 00       	jmp    1029cb <__alltraps>

00102407 <vector133>:
.globl vector133
vector133:
  pushl $0
  102407:	6a 00                	push   $0x0
  pushl $133
  102409:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  10240e:	e9 b8 05 00 00       	jmp    1029cb <__alltraps>

00102413 <vector134>:
.globl vector134
vector134:
  pushl $0
  102413:	6a 00                	push   $0x0
  pushl $134
  102415:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  10241a:	e9 ac 05 00 00       	jmp    1029cb <__alltraps>

0010241f <vector135>:
.globl vector135
vector135:
  pushl $0
  10241f:	6a 00                	push   $0x0
  pushl $135
  102421:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  102426:	e9 a0 05 00 00       	jmp    1029cb <__alltraps>

0010242b <vector136>:
.globl vector136
vector136:
  pushl $0
  10242b:	6a 00                	push   $0x0
  pushl $136
  10242d:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102432:	e9 94 05 00 00       	jmp    1029cb <__alltraps>

00102437 <vector137>:
.globl vector137
vector137:
  pushl $0
  102437:	6a 00                	push   $0x0
  pushl $137
  102439:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  10243e:	e9 88 05 00 00       	jmp    1029cb <__alltraps>

00102443 <vector138>:
.globl vector138
vector138:
  pushl $0
  102443:	6a 00                	push   $0x0
  pushl $138
  102445:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  10244a:	e9 7c 05 00 00       	jmp    1029cb <__alltraps>

0010244f <vector139>:
.globl vector139
vector139:
  pushl $0
  10244f:	6a 00                	push   $0x0
  pushl $139
  102451:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102456:	e9 70 05 00 00       	jmp    1029cb <__alltraps>

0010245b <vector140>:
.globl vector140
vector140:
  pushl $0
  10245b:	6a 00                	push   $0x0
  pushl $140
  10245d:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  102462:	e9 64 05 00 00       	jmp    1029cb <__alltraps>

00102467 <vector141>:
.globl vector141
vector141:
  pushl $0
  102467:	6a 00                	push   $0x0
  pushl $141
  102469:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  10246e:	e9 58 05 00 00       	jmp    1029cb <__alltraps>

00102473 <vector142>:
.globl vector142
vector142:
  pushl $0
  102473:	6a 00                	push   $0x0
  pushl $142
  102475:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  10247a:	e9 4c 05 00 00       	jmp    1029cb <__alltraps>

0010247f <vector143>:
.globl vector143
vector143:
  pushl $0
  10247f:	6a 00                	push   $0x0
  pushl $143
  102481:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102486:	e9 40 05 00 00       	jmp    1029cb <__alltraps>

0010248b <vector144>:
.globl vector144
vector144:
  pushl $0
  10248b:	6a 00                	push   $0x0
  pushl $144
  10248d:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  102492:	e9 34 05 00 00       	jmp    1029cb <__alltraps>

00102497 <vector145>:
.globl vector145
vector145:
  pushl $0
  102497:	6a 00                	push   $0x0
  pushl $145
  102499:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  10249e:	e9 28 05 00 00       	jmp    1029cb <__alltraps>

001024a3 <vector146>:
.globl vector146
vector146:
  pushl $0
  1024a3:	6a 00                	push   $0x0
  pushl $146
  1024a5:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1024aa:	e9 1c 05 00 00       	jmp    1029cb <__alltraps>

001024af <vector147>:
.globl vector147
vector147:
  pushl $0
  1024af:	6a 00                	push   $0x0
  pushl $147
  1024b1:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1024b6:	e9 10 05 00 00       	jmp    1029cb <__alltraps>

001024bb <vector148>:
.globl vector148
vector148:
  pushl $0
  1024bb:	6a 00                	push   $0x0
  pushl $148
  1024bd:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  1024c2:	e9 04 05 00 00       	jmp    1029cb <__alltraps>

001024c7 <vector149>:
.globl vector149
vector149:
  pushl $0
  1024c7:	6a 00                	push   $0x0
  pushl $149
  1024c9:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  1024ce:	e9 f8 04 00 00       	jmp    1029cb <__alltraps>

001024d3 <vector150>:
.globl vector150
vector150:
  pushl $0
  1024d3:	6a 00                	push   $0x0
  pushl $150
  1024d5:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  1024da:	e9 ec 04 00 00       	jmp    1029cb <__alltraps>

001024df <vector151>:
.globl vector151
vector151:
  pushl $0
  1024df:	6a 00                	push   $0x0
  pushl $151
  1024e1:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  1024e6:	e9 e0 04 00 00       	jmp    1029cb <__alltraps>

001024eb <vector152>:
.globl vector152
vector152:
  pushl $0
  1024eb:	6a 00                	push   $0x0
  pushl $152
  1024ed:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  1024f2:	e9 d4 04 00 00       	jmp    1029cb <__alltraps>

001024f7 <vector153>:
.globl vector153
vector153:
  pushl $0
  1024f7:	6a 00                	push   $0x0
  pushl $153
  1024f9:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  1024fe:	e9 c8 04 00 00       	jmp    1029cb <__alltraps>

00102503 <vector154>:
.globl vector154
vector154:
  pushl $0
  102503:	6a 00                	push   $0x0
  pushl $154
  102505:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  10250a:	e9 bc 04 00 00       	jmp    1029cb <__alltraps>

0010250f <vector155>:
.globl vector155
vector155:
  pushl $0
  10250f:	6a 00                	push   $0x0
  pushl $155
  102511:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102516:	e9 b0 04 00 00       	jmp    1029cb <__alltraps>

0010251b <vector156>:
.globl vector156
vector156:
  pushl $0
  10251b:	6a 00                	push   $0x0
  pushl $156
  10251d:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102522:	e9 a4 04 00 00       	jmp    1029cb <__alltraps>

00102527 <vector157>:
.globl vector157
vector157:
  pushl $0
  102527:	6a 00                	push   $0x0
  pushl $157
  102529:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  10252e:	e9 98 04 00 00       	jmp    1029cb <__alltraps>

00102533 <vector158>:
.globl vector158
vector158:
  pushl $0
  102533:	6a 00                	push   $0x0
  pushl $158
  102535:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  10253a:	e9 8c 04 00 00       	jmp    1029cb <__alltraps>

0010253f <vector159>:
.globl vector159
vector159:
  pushl $0
  10253f:	6a 00                	push   $0x0
  pushl $159
  102541:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  102546:	e9 80 04 00 00       	jmp    1029cb <__alltraps>

0010254b <vector160>:
.globl vector160
vector160:
  pushl $0
  10254b:	6a 00                	push   $0x0
  pushl $160
  10254d:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102552:	e9 74 04 00 00       	jmp    1029cb <__alltraps>

00102557 <vector161>:
.globl vector161
vector161:
  pushl $0
  102557:	6a 00                	push   $0x0
  pushl $161
  102559:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  10255e:	e9 68 04 00 00       	jmp    1029cb <__alltraps>

00102563 <vector162>:
.globl vector162
vector162:
  pushl $0
  102563:	6a 00                	push   $0x0
  pushl $162
  102565:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  10256a:	e9 5c 04 00 00       	jmp    1029cb <__alltraps>

0010256f <vector163>:
.globl vector163
vector163:
  pushl $0
  10256f:	6a 00                	push   $0x0
  pushl $163
  102571:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  102576:	e9 50 04 00 00       	jmp    1029cb <__alltraps>

0010257b <vector164>:
.globl vector164
vector164:
  pushl $0
  10257b:	6a 00                	push   $0x0
  pushl $164
  10257d:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  102582:	e9 44 04 00 00       	jmp    1029cb <__alltraps>

00102587 <vector165>:
.globl vector165
vector165:
  pushl $0
  102587:	6a 00                	push   $0x0
  pushl $165
  102589:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  10258e:	e9 38 04 00 00       	jmp    1029cb <__alltraps>

00102593 <vector166>:
.globl vector166
vector166:
  pushl $0
  102593:	6a 00                	push   $0x0
  pushl $166
  102595:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  10259a:	e9 2c 04 00 00       	jmp    1029cb <__alltraps>

0010259f <vector167>:
.globl vector167
vector167:
  pushl $0
  10259f:	6a 00                	push   $0x0
  pushl $167
  1025a1:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1025a6:	e9 20 04 00 00       	jmp    1029cb <__alltraps>

001025ab <vector168>:
.globl vector168
vector168:
  pushl $0
  1025ab:	6a 00                	push   $0x0
  pushl $168
  1025ad:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1025b2:	e9 14 04 00 00       	jmp    1029cb <__alltraps>

001025b7 <vector169>:
.globl vector169
vector169:
  pushl $0
  1025b7:	6a 00                	push   $0x0
  pushl $169
  1025b9:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  1025be:	e9 08 04 00 00       	jmp    1029cb <__alltraps>

001025c3 <vector170>:
.globl vector170
vector170:
  pushl $0
  1025c3:	6a 00                	push   $0x0
  pushl $170
  1025c5:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  1025ca:	e9 fc 03 00 00       	jmp    1029cb <__alltraps>

001025cf <vector171>:
.globl vector171
vector171:
  pushl $0
  1025cf:	6a 00                	push   $0x0
  pushl $171
  1025d1:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  1025d6:	e9 f0 03 00 00       	jmp    1029cb <__alltraps>

001025db <vector172>:
.globl vector172
vector172:
  pushl $0
  1025db:	6a 00                	push   $0x0
  pushl $172
  1025dd:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  1025e2:	e9 e4 03 00 00       	jmp    1029cb <__alltraps>

001025e7 <vector173>:
.globl vector173
vector173:
  pushl $0
  1025e7:	6a 00                	push   $0x0
  pushl $173
  1025e9:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  1025ee:	e9 d8 03 00 00       	jmp    1029cb <__alltraps>

001025f3 <vector174>:
.globl vector174
vector174:
  pushl $0
  1025f3:	6a 00                	push   $0x0
  pushl $174
  1025f5:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  1025fa:	e9 cc 03 00 00       	jmp    1029cb <__alltraps>

001025ff <vector175>:
.globl vector175
vector175:
  pushl $0
  1025ff:	6a 00                	push   $0x0
  pushl $175
  102601:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102606:	e9 c0 03 00 00       	jmp    1029cb <__alltraps>

0010260b <vector176>:
.globl vector176
vector176:
  pushl $0
  10260b:	6a 00                	push   $0x0
  pushl $176
  10260d:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102612:	e9 b4 03 00 00       	jmp    1029cb <__alltraps>

00102617 <vector177>:
.globl vector177
vector177:
  pushl $0
  102617:	6a 00                	push   $0x0
  pushl $177
  102619:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  10261e:	e9 a8 03 00 00       	jmp    1029cb <__alltraps>

00102623 <vector178>:
.globl vector178
vector178:
  pushl $0
  102623:	6a 00                	push   $0x0
  pushl $178
  102625:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  10262a:	e9 9c 03 00 00       	jmp    1029cb <__alltraps>

0010262f <vector179>:
.globl vector179
vector179:
  pushl $0
  10262f:	6a 00                	push   $0x0
  pushl $179
  102631:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  102636:	e9 90 03 00 00       	jmp    1029cb <__alltraps>

0010263b <vector180>:
.globl vector180
vector180:
  pushl $0
  10263b:	6a 00                	push   $0x0
  pushl $180
  10263d:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102642:	e9 84 03 00 00       	jmp    1029cb <__alltraps>

00102647 <vector181>:
.globl vector181
vector181:
  pushl $0
  102647:	6a 00                	push   $0x0
  pushl $181
  102649:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  10264e:	e9 78 03 00 00       	jmp    1029cb <__alltraps>

00102653 <vector182>:
.globl vector182
vector182:
  pushl $0
  102653:	6a 00                	push   $0x0
  pushl $182
  102655:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  10265a:	e9 6c 03 00 00       	jmp    1029cb <__alltraps>

0010265f <vector183>:
.globl vector183
vector183:
  pushl $0
  10265f:	6a 00                	push   $0x0
  pushl $183
  102661:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102666:	e9 60 03 00 00       	jmp    1029cb <__alltraps>

0010266b <vector184>:
.globl vector184
vector184:
  pushl $0
  10266b:	6a 00                	push   $0x0
  pushl $184
  10266d:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  102672:	e9 54 03 00 00       	jmp    1029cb <__alltraps>

00102677 <vector185>:
.globl vector185
vector185:
  pushl $0
  102677:	6a 00                	push   $0x0
  pushl $185
  102679:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  10267e:	e9 48 03 00 00       	jmp    1029cb <__alltraps>

00102683 <vector186>:
.globl vector186
vector186:
  pushl $0
  102683:	6a 00                	push   $0x0
  pushl $186
  102685:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  10268a:	e9 3c 03 00 00       	jmp    1029cb <__alltraps>

0010268f <vector187>:
.globl vector187
vector187:
  pushl $0
  10268f:	6a 00                	push   $0x0
  pushl $187
  102691:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102696:	e9 30 03 00 00       	jmp    1029cb <__alltraps>

0010269b <vector188>:
.globl vector188
vector188:
  pushl $0
  10269b:	6a 00                	push   $0x0
  pushl $188
  10269d:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1026a2:	e9 24 03 00 00       	jmp    1029cb <__alltraps>

001026a7 <vector189>:
.globl vector189
vector189:
  pushl $0
  1026a7:	6a 00                	push   $0x0
  pushl $189
  1026a9:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1026ae:	e9 18 03 00 00       	jmp    1029cb <__alltraps>

001026b3 <vector190>:
.globl vector190
vector190:
  pushl $0
  1026b3:	6a 00                	push   $0x0
  pushl $190
  1026b5:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1026ba:	e9 0c 03 00 00       	jmp    1029cb <__alltraps>

001026bf <vector191>:
.globl vector191
vector191:
  pushl $0
  1026bf:	6a 00                	push   $0x0
  pushl $191
  1026c1:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  1026c6:	e9 00 03 00 00       	jmp    1029cb <__alltraps>

001026cb <vector192>:
.globl vector192
vector192:
  pushl $0
  1026cb:	6a 00                	push   $0x0
  pushl $192
  1026cd:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  1026d2:	e9 f4 02 00 00       	jmp    1029cb <__alltraps>

001026d7 <vector193>:
.globl vector193
vector193:
  pushl $0
  1026d7:	6a 00                	push   $0x0
  pushl $193
  1026d9:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  1026de:	e9 e8 02 00 00       	jmp    1029cb <__alltraps>

001026e3 <vector194>:
.globl vector194
vector194:
  pushl $0
  1026e3:	6a 00                	push   $0x0
  pushl $194
  1026e5:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  1026ea:	e9 dc 02 00 00       	jmp    1029cb <__alltraps>

001026ef <vector195>:
.globl vector195
vector195:
  pushl $0
  1026ef:	6a 00                	push   $0x0
  pushl $195
  1026f1:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  1026f6:	e9 d0 02 00 00       	jmp    1029cb <__alltraps>

001026fb <vector196>:
.globl vector196
vector196:
  pushl $0
  1026fb:	6a 00                	push   $0x0
  pushl $196
  1026fd:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102702:	e9 c4 02 00 00       	jmp    1029cb <__alltraps>

00102707 <vector197>:
.globl vector197
vector197:
  pushl $0
  102707:	6a 00                	push   $0x0
  pushl $197
  102709:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  10270e:	e9 b8 02 00 00       	jmp    1029cb <__alltraps>

00102713 <vector198>:
.globl vector198
vector198:
  pushl $0
  102713:	6a 00                	push   $0x0
  pushl $198
  102715:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  10271a:	e9 ac 02 00 00       	jmp    1029cb <__alltraps>

0010271f <vector199>:
.globl vector199
vector199:
  pushl $0
  10271f:	6a 00                	push   $0x0
  pushl $199
  102721:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102726:	e9 a0 02 00 00       	jmp    1029cb <__alltraps>

0010272b <vector200>:
.globl vector200
vector200:
  pushl $0
  10272b:	6a 00                	push   $0x0
  pushl $200
  10272d:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102732:	e9 94 02 00 00       	jmp    1029cb <__alltraps>

00102737 <vector201>:
.globl vector201
vector201:
  pushl $0
  102737:	6a 00                	push   $0x0
  pushl $201
  102739:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  10273e:	e9 88 02 00 00       	jmp    1029cb <__alltraps>

00102743 <vector202>:
.globl vector202
vector202:
  pushl $0
  102743:	6a 00                	push   $0x0
  pushl $202
  102745:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  10274a:	e9 7c 02 00 00       	jmp    1029cb <__alltraps>

0010274f <vector203>:
.globl vector203
vector203:
  pushl $0
  10274f:	6a 00                	push   $0x0
  pushl $203
  102751:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102756:	e9 70 02 00 00       	jmp    1029cb <__alltraps>

0010275b <vector204>:
.globl vector204
vector204:
  pushl $0
  10275b:	6a 00                	push   $0x0
  pushl $204
  10275d:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102762:	e9 64 02 00 00       	jmp    1029cb <__alltraps>

00102767 <vector205>:
.globl vector205
vector205:
  pushl $0
  102767:	6a 00                	push   $0x0
  pushl $205
  102769:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  10276e:	e9 58 02 00 00       	jmp    1029cb <__alltraps>

00102773 <vector206>:
.globl vector206
vector206:
  pushl $0
  102773:	6a 00                	push   $0x0
  pushl $206
  102775:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  10277a:	e9 4c 02 00 00       	jmp    1029cb <__alltraps>

0010277f <vector207>:
.globl vector207
vector207:
  pushl $0
  10277f:	6a 00                	push   $0x0
  pushl $207
  102781:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102786:	e9 40 02 00 00       	jmp    1029cb <__alltraps>

0010278b <vector208>:
.globl vector208
vector208:
  pushl $0
  10278b:	6a 00                	push   $0x0
  pushl $208
  10278d:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  102792:	e9 34 02 00 00       	jmp    1029cb <__alltraps>

00102797 <vector209>:
.globl vector209
vector209:
  pushl $0
  102797:	6a 00                	push   $0x0
  pushl $209
  102799:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  10279e:	e9 28 02 00 00       	jmp    1029cb <__alltraps>

001027a3 <vector210>:
.globl vector210
vector210:
  pushl $0
  1027a3:	6a 00                	push   $0x0
  pushl $210
  1027a5:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1027aa:	e9 1c 02 00 00       	jmp    1029cb <__alltraps>

001027af <vector211>:
.globl vector211
vector211:
  pushl $0
  1027af:	6a 00                	push   $0x0
  pushl $211
  1027b1:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1027b6:	e9 10 02 00 00       	jmp    1029cb <__alltraps>

001027bb <vector212>:
.globl vector212
vector212:
  pushl $0
  1027bb:	6a 00                	push   $0x0
  pushl $212
  1027bd:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  1027c2:	e9 04 02 00 00       	jmp    1029cb <__alltraps>

001027c7 <vector213>:
.globl vector213
vector213:
  pushl $0
  1027c7:	6a 00                	push   $0x0
  pushl $213
  1027c9:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  1027ce:	e9 f8 01 00 00       	jmp    1029cb <__alltraps>

001027d3 <vector214>:
.globl vector214
vector214:
  pushl $0
  1027d3:	6a 00                	push   $0x0
  pushl $214
  1027d5:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  1027da:	e9 ec 01 00 00       	jmp    1029cb <__alltraps>

001027df <vector215>:
.globl vector215
vector215:
  pushl $0
  1027df:	6a 00                	push   $0x0
  pushl $215
  1027e1:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  1027e6:	e9 e0 01 00 00       	jmp    1029cb <__alltraps>

001027eb <vector216>:
.globl vector216
vector216:
  pushl $0
  1027eb:	6a 00                	push   $0x0
  pushl $216
  1027ed:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  1027f2:	e9 d4 01 00 00       	jmp    1029cb <__alltraps>

001027f7 <vector217>:
.globl vector217
vector217:
  pushl $0
  1027f7:	6a 00                	push   $0x0
  pushl $217
  1027f9:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  1027fe:	e9 c8 01 00 00       	jmp    1029cb <__alltraps>

00102803 <vector218>:
.globl vector218
vector218:
  pushl $0
  102803:	6a 00                	push   $0x0
  pushl $218
  102805:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  10280a:	e9 bc 01 00 00       	jmp    1029cb <__alltraps>

0010280f <vector219>:
.globl vector219
vector219:
  pushl $0
  10280f:	6a 00                	push   $0x0
  pushl $219
  102811:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102816:	e9 b0 01 00 00       	jmp    1029cb <__alltraps>

0010281b <vector220>:
.globl vector220
vector220:
  pushl $0
  10281b:	6a 00                	push   $0x0
  pushl $220
  10281d:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102822:	e9 a4 01 00 00       	jmp    1029cb <__alltraps>

00102827 <vector221>:
.globl vector221
vector221:
  pushl $0
  102827:	6a 00                	push   $0x0
  pushl $221
  102829:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  10282e:	e9 98 01 00 00       	jmp    1029cb <__alltraps>

00102833 <vector222>:
.globl vector222
vector222:
  pushl $0
  102833:	6a 00                	push   $0x0
  pushl $222
  102835:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  10283a:	e9 8c 01 00 00       	jmp    1029cb <__alltraps>

0010283f <vector223>:
.globl vector223
vector223:
  pushl $0
  10283f:	6a 00                	push   $0x0
  pushl $223
  102841:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102846:	e9 80 01 00 00       	jmp    1029cb <__alltraps>

0010284b <vector224>:
.globl vector224
vector224:
  pushl $0
  10284b:	6a 00                	push   $0x0
  pushl $224
  10284d:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102852:	e9 74 01 00 00       	jmp    1029cb <__alltraps>

00102857 <vector225>:
.globl vector225
vector225:
  pushl $0
  102857:	6a 00                	push   $0x0
  pushl $225
  102859:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  10285e:	e9 68 01 00 00       	jmp    1029cb <__alltraps>

00102863 <vector226>:
.globl vector226
vector226:
  pushl $0
  102863:	6a 00                	push   $0x0
  pushl $226
  102865:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  10286a:	e9 5c 01 00 00       	jmp    1029cb <__alltraps>

0010286f <vector227>:
.globl vector227
vector227:
  pushl $0
  10286f:	6a 00                	push   $0x0
  pushl $227
  102871:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102876:	e9 50 01 00 00       	jmp    1029cb <__alltraps>

0010287b <vector228>:
.globl vector228
vector228:
  pushl $0
  10287b:	6a 00                	push   $0x0
  pushl $228
  10287d:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102882:	e9 44 01 00 00       	jmp    1029cb <__alltraps>

00102887 <vector229>:
.globl vector229
vector229:
  pushl $0
  102887:	6a 00                	push   $0x0
  pushl $229
  102889:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  10288e:	e9 38 01 00 00       	jmp    1029cb <__alltraps>

00102893 <vector230>:
.globl vector230
vector230:
  pushl $0
  102893:	6a 00                	push   $0x0
  pushl $230
  102895:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  10289a:	e9 2c 01 00 00       	jmp    1029cb <__alltraps>

0010289f <vector231>:
.globl vector231
vector231:
  pushl $0
  10289f:	6a 00                	push   $0x0
  pushl $231
  1028a1:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  1028a6:	e9 20 01 00 00       	jmp    1029cb <__alltraps>

001028ab <vector232>:
.globl vector232
vector232:
  pushl $0
  1028ab:	6a 00                	push   $0x0
  pushl $232
  1028ad:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  1028b2:	e9 14 01 00 00       	jmp    1029cb <__alltraps>

001028b7 <vector233>:
.globl vector233
vector233:
  pushl $0
  1028b7:	6a 00                	push   $0x0
  pushl $233
  1028b9:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  1028be:	e9 08 01 00 00       	jmp    1029cb <__alltraps>

001028c3 <vector234>:
.globl vector234
vector234:
  pushl $0
  1028c3:	6a 00                	push   $0x0
  pushl $234
  1028c5:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  1028ca:	e9 fc 00 00 00       	jmp    1029cb <__alltraps>

001028cf <vector235>:
.globl vector235
vector235:
  pushl $0
  1028cf:	6a 00                	push   $0x0
  pushl $235
  1028d1:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  1028d6:	e9 f0 00 00 00       	jmp    1029cb <__alltraps>

001028db <vector236>:
.globl vector236
vector236:
  pushl $0
  1028db:	6a 00                	push   $0x0
  pushl $236
  1028dd:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  1028e2:	e9 e4 00 00 00       	jmp    1029cb <__alltraps>

001028e7 <vector237>:
.globl vector237
vector237:
  pushl $0
  1028e7:	6a 00                	push   $0x0
  pushl $237
  1028e9:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  1028ee:	e9 d8 00 00 00       	jmp    1029cb <__alltraps>

001028f3 <vector238>:
.globl vector238
vector238:
  pushl $0
  1028f3:	6a 00                	push   $0x0
  pushl $238
  1028f5:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  1028fa:	e9 cc 00 00 00       	jmp    1029cb <__alltraps>

001028ff <vector239>:
.globl vector239
vector239:
  pushl $0
  1028ff:	6a 00                	push   $0x0
  pushl $239
  102901:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102906:	e9 c0 00 00 00       	jmp    1029cb <__alltraps>

0010290b <vector240>:
.globl vector240
vector240:
  pushl $0
  10290b:	6a 00                	push   $0x0
  pushl $240
  10290d:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102912:	e9 b4 00 00 00       	jmp    1029cb <__alltraps>

00102917 <vector241>:
.globl vector241
vector241:
  pushl $0
  102917:	6a 00                	push   $0x0
  pushl $241
  102919:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  10291e:	e9 a8 00 00 00       	jmp    1029cb <__alltraps>

00102923 <vector242>:
.globl vector242
vector242:
  pushl $0
  102923:	6a 00                	push   $0x0
  pushl $242
  102925:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  10292a:	e9 9c 00 00 00       	jmp    1029cb <__alltraps>

0010292f <vector243>:
.globl vector243
vector243:
  pushl $0
  10292f:	6a 00                	push   $0x0
  pushl $243
  102931:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102936:	e9 90 00 00 00       	jmp    1029cb <__alltraps>

0010293b <vector244>:
.globl vector244
vector244:
  pushl $0
  10293b:	6a 00                	push   $0x0
  pushl $244
  10293d:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102942:	e9 84 00 00 00       	jmp    1029cb <__alltraps>

00102947 <vector245>:
.globl vector245
vector245:
  pushl $0
  102947:	6a 00                	push   $0x0
  pushl $245
  102949:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  10294e:	e9 78 00 00 00       	jmp    1029cb <__alltraps>

00102953 <vector246>:
.globl vector246
vector246:
  pushl $0
  102953:	6a 00                	push   $0x0
  pushl $246
  102955:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  10295a:	e9 6c 00 00 00       	jmp    1029cb <__alltraps>

0010295f <vector247>:
.globl vector247
vector247:
  pushl $0
  10295f:	6a 00                	push   $0x0
  pushl $247
  102961:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102966:	e9 60 00 00 00       	jmp    1029cb <__alltraps>

0010296b <vector248>:
.globl vector248
vector248:
  pushl $0
  10296b:	6a 00                	push   $0x0
  pushl $248
  10296d:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102972:	e9 54 00 00 00       	jmp    1029cb <__alltraps>

00102977 <vector249>:
.globl vector249
vector249:
  pushl $0
  102977:	6a 00                	push   $0x0
  pushl $249
  102979:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  10297e:	e9 48 00 00 00       	jmp    1029cb <__alltraps>

00102983 <vector250>:
.globl vector250
vector250:
  pushl $0
  102983:	6a 00                	push   $0x0
  pushl $250
  102985:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  10298a:	e9 3c 00 00 00       	jmp    1029cb <__alltraps>

0010298f <vector251>:
.globl vector251
vector251:
  pushl $0
  10298f:	6a 00                	push   $0x0
  pushl $251
  102991:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102996:	e9 30 00 00 00       	jmp    1029cb <__alltraps>

0010299b <vector252>:
.globl vector252
vector252:
  pushl $0
  10299b:	6a 00                	push   $0x0
  pushl $252
  10299d:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  1029a2:	e9 24 00 00 00       	jmp    1029cb <__alltraps>

001029a7 <vector253>:
.globl vector253
vector253:
  pushl $0
  1029a7:	6a 00                	push   $0x0
  pushl $253
  1029a9:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  1029ae:	e9 18 00 00 00       	jmp    1029cb <__alltraps>

001029b3 <vector254>:
.globl vector254
vector254:
  pushl $0
  1029b3:	6a 00                	push   $0x0
  pushl $254
  1029b5:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  1029ba:	e9 0c 00 00 00       	jmp    1029cb <__alltraps>

001029bf <vector255>:
.globl vector255
vector255:
  pushl $0
  1029bf:	6a 00                	push   $0x0
  pushl $255
  1029c1:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  1029c6:	e9 00 00 00 00       	jmp    1029cb <__alltraps>

001029cb <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  1029cb:	1e                   	push   %ds
    pushl %es
  1029cc:	06                   	push   %es
    pushl %fs
  1029cd:	0f a0                	push   %fs
    pushl %gs
  1029cf:	0f a8                	push   %gs
    pushal
  1029d1:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  1029d2:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  1029d7:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  1029d9:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  1029db:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  1029dc:	e8 60 f5 ff ff       	call   101f41 <trap>

    # pop the pushed stack pointer
    popl %esp
  1029e1:	5c                   	pop    %esp

001029e2 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  1029e2:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  1029e3:	0f a9                	pop    %gs
    popl %fs
  1029e5:	0f a1                	pop    %fs
    popl %es
  1029e7:	07                   	pop    %es
    popl %ds
  1029e8:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  1029e9:	83 c4 08             	add    $0x8,%esp
    iret
  1029ec:	cf                   	iret   

001029ed <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  1029ed:	55                   	push   %ebp
  1029ee:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  1029f0:	8b 45 08             	mov    0x8(%ebp),%eax
  1029f3:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  1029f6:	b8 23 00 00 00       	mov    $0x23,%eax
  1029fb:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  1029fd:	b8 23 00 00 00       	mov    $0x23,%eax
  102a02:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102a04:	b8 10 00 00 00       	mov    $0x10,%eax
  102a09:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102a0b:	b8 10 00 00 00       	mov    $0x10,%eax
  102a10:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102a12:	b8 10 00 00 00       	mov    $0x10,%eax
  102a17:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102a19:	ea 20 2a 10 00 08 00 	ljmp   $0x8,$0x102a20
}
  102a20:	90                   	nop
  102a21:	5d                   	pop    %ebp
  102a22:	c3                   	ret    

00102a23 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102a23:	f3 0f 1e fb          	endbr32 
  102a27:	55                   	push   %ebp
  102a28:	89 e5                	mov    %esp,%ebp
  102a2a:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102a2d:	b8 20 09 11 00       	mov    $0x110920,%eax
  102a32:	05 00 04 00 00       	add    $0x400,%eax
  102a37:	a3 a4 08 11 00       	mov    %eax,0x1108a4
    ts.ts_ss0 = KERNEL_DS;
  102a3c:	66 c7 05 a8 08 11 00 	movw   $0x10,0x1108a8
  102a43:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102a45:	66 c7 05 08 fa 10 00 	movw   $0x68,0x10fa08
  102a4c:	68 00 
  102a4e:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102a53:	0f b7 c0             	movzwl %ax,%eax
  102a56:	66 a3 0a fa 10 00    	mov    %ax,0x10fa0a
  102a5c:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102a61:	c1 e8 10             	shr    $0x10,%eax
  102a64:	a2 0c fa 10 00       	mov    %al,0x10fa0c
  102a69:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102a70:	24 f0                	and    $0xf0,%al
  102a72:	0c 09                	or     $0x9,%al
  102a74:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102a79:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102a80:	0c 10                	or     $0x10,%al
  102a82:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102a87:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102a8e:	24 9f                	and    $0x9f,%al
  102a90:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102a95:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102a9c:	0c 80                	or     $0x80,%al
  102a9e:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102aa3:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102aaa:	24 f0                	and    $0xf0,%al
  102aac:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102ab1:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102ab8:	24 ef                	and    $0xef,%al
  102aba:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102abf:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102ac6:	24 df                	and    $0xdf,%al
  102ac8:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102acd:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102ad4:	0c 40                	or     $0x40,%al
  102ad6:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102adb:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102ae2:	24 7f                	and    $0x7f,%al
  102ae4:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102ae9:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102aee:	c1 e8 18             	shr    $0x18,%eax
  102af1:	a2 0f fa 10 00       	mov    %al,0x10fa0f
    gdt[SEG_TSS].sd_s = 0;
  102af6:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102afd:	24 ef                	and    $0xef,%al
  102aff:	a2 0d fa 10 00       	mov    %al,0x10fa0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102b04:	c7 04 24 10 fa 10 00 	movl   $0x10fa10,(%esp)
  102b0b:	e8 dd fe ff ff       	call   1029ed <lgdt>
  102b10:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102b16:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102b1a:	0f 00 d8             	ltr    %ax
}
  102b1d:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102b1e:	90                   	nop
  102b1f:	c9                   	leave  
  102b20:	c3                   	ret    

00102b21 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102b21:	f3 0f 1e fb          	endbr32 
  102b25:	55                   	push   %ebp
  102b26:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102b28:	e8 f6 fe ff ff       	call   102a23 <gdt_init>
}
  102b2d:	90                   	nop
  102b2e:	5d                   	pop    %ebp
  102b2f:	c3                   	ret    

00102b30 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102b30:	f3 0f 1e fb          	endbr32 
  102b34:	55                   	push   %ebp
  102b35:	89 e5                	mov    %esp,%ebp
  102b37:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102b3a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102b41:	eb 03                	jmp    102b46 <strlen+0x16>
        cnt ++;
  102b43:	ff 45 fc             	incl   -0x4(%ebp)
    while (*s ++ != '\0') {
  102b46:	8b 45 08             	mov    0x8(%ebp),%eax
  102b49:	8d 50 01             	lea    0x1(%eax),%edx
  102b4c:	89 55 08             	mov    %edx,0x8(%ebp)
  102b4f:	0f b6 00             	movzbl (%eax),%eax
  102b52:	84 c0                	test   %al,%al
  102b54:	75 ed                	jne    102b43 <strlen+0x13>
    }
    return cnt;
  102b56:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102b59:	c9                   	leave  
  102b5a:	c3                   	ret    

00102b5b <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102b5b:	f3 0f 1e fb          	endbr32 
  102b5f:	55                   	push   %ebp
  102b60:	89 e5                	mov    %esp,%ebp
  102b62:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102b65:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102b6c:	eb 03                	jmp    102b71 <strnlen+0x16>
        cnt ++;
  102b6e:	ff 45 fc             	incl   -0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102b71:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102b74:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102b77:	73 10                	jae    102b89 <strnlen+0x2e>
  102b79:	8b 45 08             	mov    0x8(%ebp),%eax
  102b7c:	8d 50 01             	lea    0x1(%eax),%edx
  102b7f:	89 55 08             	mov    %edx,0x8(%ebp)
  102b82:	0f b6 00             	movzbl (%eax),%eax
  102b85:	84 c0                	test   %al,%al
  102b87:	75 e5                	jne    102b6e <strnlen+0x13>
    }
    return cnt;
  102b89:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102b8c:	c9                   	leave  
  102b8d:	c3                   	ret    

00102b8e <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102b8e:	f3 0f 1e fb          	endbr32 
  102b92:	55                   	push   %ebp
  102b93:	89 e5                	mov    %esp,%ebp
  102b95:	57                   	push   %edi
  102b96:	56                   	push   %esi
  102b97:	83 ec 20             	sub    $0x20,%esp
  102b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  102b9d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102ba0:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ba3:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102ba6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102ba9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102bac:	89 d1                	mov    %edx,%ecx
  102bae:	89 c2                	mov    %eax,%edx
  102bb0:	89 ce                	mov    %ecx,%esi
  102bb2:	89 d7                	mov    %edx,%edi
  102bb4:	ac                   	lods   %ds:(%esi),%al
  102bb5:	aa                   	stos   %al,%es:(%edi)
  102bb6:	84 c0                	test   %al,%al
  102bb8:	75 fa                	jne    102bb4 <strcpy+0x26>
  102bba:	89 fa                	mov    %edi,%edx
  102bbc:	89 f1                	mov    %esi,%ecx
  102bbe:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102bc1:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102bc4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102bc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102bca:	83 c4 20             	add    $0x20,%esp
  102bcd:	5e                   	pop    %esi
  102bce:	5f                   	pop    %edi
  102bcf:	5d                   	pop    %ebp
  102bd0:	c3                   	ret    

00102bd1 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102bd1:	f3 0f 1e fb          	endbr32 
  102bd5:	55                   	push   %ebp
  102bd6:	89 e5                	mov    %esp,%ebp
  102bd8:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102bdb:	8b 45 08             	mov    0x8(%ebp),%eax
  102bde:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102be1:	eb 1e                	jmp    102c01 <strncpy+0x30>
        if ((*p = *src) != '\0') {
  102be3:	8b 45 0c             	mov    0xc(%ebp),%eax
  102be6:	0f b6 10             	movzbl (%eax),%edx
  102be9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102bec:	88 10                	mov    %dl,(%eax)
  102bee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102bf1:	0f b6 00             	movzbl (%eax),%eax
  102bf4:	84 c0                	test   %al,%al
  102bf6:	74 03                	je     102bfb <strncpy+0x2a>
            src ++;
  102bf8:	ff 45 0c             	incl   0xc(%ebp)
        }
        p ++, len --;
  102bfb:	ff 45 fc             	incl   -0x4(%ebp)
  102bfe:	ff 4d 10             	decl   0x10(%ebp)
    while (len > 0) {
  102c01:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c05:	75 dc                	jne    102be3 <strncpy+0x12>
    }
    return dst;
  102c07:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102c0a:	c9                   	leave  
  102c0b:	c3                   	ret    

00102c0c <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102c0c:	f3 0f 1e fb          	endbr32 
  102c10:	55                   	push   %ebp
  102c11:	89 e5                	mov    %esp,%ebp
  102c13:	57                   	push   %edi
  102c14:	56                   	push   %esi
  102c15:	83 ec 20             	sub    $0x20,%esp
  102c18:	8b 45 08             	mov    0x8(%ebp),%eax
  102c1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c21:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102c24:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102c27:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102c2a:	89 d1                	mov    %edx,%ecx
  102c2c:	89 c2                	mov    %eax,%edx
  102c2e:	89 ce                	mov    %ecx,%esi
  102c30:	89 d7                	mov    %edx,%edi
  102c32:	ac                   	lods   %ds:(%esi),%al
  102c33:	ae                   	scas   %es:(%edi),%al
  102c34:	75 08                	jne    102c3e <strcmp+0x32>
  102c36:	84 c0                	test   %al,%al
  102c38:	75 f8                	jne    102c32 <strcmp+0x26>
  102c3a:	31 c0                	xor    %eax,%eax
  102c3c:	eb 04                	jmp    102c42 <strcmp+0x36>
  102c3e:	19 c0                	sbb    %eax,%eax
  102c40:	0c 01                	or     $0x1,%al
  102c42:	89 fa                	mov    %edi,%edx
  102c44:	89 f1                	mov    %esi,%ecx
  102c46:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102c49:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102c4c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102c4f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102c52:	83 c4 20             	add    $0x20,%esp
  102c55:	5e                   	pop    %esi
  102c56:	5f                   	pop    %edi
  102c57:	5d                   	pop    %ebp
  102c58:	c3                   	ret    

00102c59 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102c59:	f3 0f 1e fb          	endbr32 
  102c5d:	55                   	push   %ebp
  102c5e:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102c60:	eb 09                	jmp    102c6b <strncmp+0x12>
        n --, s1 ++, s2 ++;
  102c62:	ff 4d 10             	decl   0x10(%ebp)
  102c65:	ff 45 08             	incl   0x8(%ebp)
  102c68:	ff 45 0c             	incl   0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102c6b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c6f:	74 1a                	je     102c8b <strncmp+0x32>
  102c71:	8b 45 08             	mov    0x8(%ebp),%eax
  102c74:	0f b6 00             	movzbl (%eax),%eax
  102c77:	84 c0                	test   %al,%al
  102c79:	74 10                	je     102c8b <strncmp+0x32>
  102c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  102c7e:	0f b6 10             	movzbl (%eax),%edx
  102c81:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c84:	0f b6 00             	movzbl (%eax),%eax
  102c87:	38 c2                	cmp    %al,%dl
  102c89:	74 d7                	je     102c62 <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102c8b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c8f:	74 18                	je     102ca9 <strncmp+0x50>
  102c91:	8b 45 08             	mov    0x8(%ebp),%eax
  102c94:	0f b6 00             	movzbl (%eax),%eax
  102c97:	0f b6 d0             	movzbl %al,%edx
  102c9a:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c9d:	0f b6 00             	movzbl (%eax),%eax
  102ca0:	0f b6 c0             	movzbl %al,%eax
  102ca3:	29 c2                	sub    %eax,%edx
  102ca5:	89 d0                	mov    %edx,%eax
  102ca7:	eb 05                	jmp    102cae <strncmp+0x55>
  102ca9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102cae:	5d                   	pop    %ebp
  102caf:	c3                   	ret    

00102cb0 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102cb0:	f3 0f 1e fb          	endbr32 
  102cb4:	55                   	push   %ebp
  102cb5:	89 e5                	mov    %esp,%ebp
  102cb7:	83 ec 04             	sub    $0x4,%esp
  102cba:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cbd:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102cc0:	eb 13                	jmp    102cd5 <strchr+0x25>
        if (*s == c) {
  102cc2:	8b 45 08             	mov    0x8(%ebp),%eax
  102cc5:	0f b6 00             	movzbl (%eax),%eax
  102cc8:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102ccb:	75 05                	jne    102cd2 <strchr+0x22>
            return (char *)s;
  102ccd:	8b 45 08             	mov    0x8(%ebp),%eax
  102cd0:	eb 12                	jmp    102ce4 <strchr+0x34>
        }
        s ++;
  102cd2:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  102cd8:	0f b6 00             	movzbl (%eax),%eax
  102cdb:	84 c0                	test   %al,%al
  102cdd:	75 e3                	jne    102cc2 <strchr+0x12>
    }
    return NULL;
  102cdf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102ce4:	c9                   	leave  
  102ce5:	c3                   	ret    

00102ce6 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102ce6:	f3 0f 1e fb          	endbr32 
  102cea:	55                   	push   %ebp
  102ceb:	89 e5                	mov    %esp,%ebp
  102ced:	83 ec 04             	sub    $0x4,%esp
  102cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cf3:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102cf6:	eb 0e                	jmp    102d06 <strfind+0x20>
        if (*s == c) {
  102cf8:	8b 45 08             	mov    0x8(%ebp),%eax
  102cfb:	0f b6 00             	movzbl (%eax),%eax
  102cfe:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102d01:	74 0f                	je     102d12 <strfind+0x2c>
            break;
        }
        s ++;
  102d03:	ff 45 08             	incl   0x8(%ebp)
    while (*s != '\0') {
  102d06:	8b 45 08             	mov    0x8(%ebp),%eax
  102d09:	0f b6 00             	movzbl (%eax),%eax
  102d0c:	84 c0                	test   %al,%al
  102d0e:	75 e8                	jne    102cf8 <strfind+0x12>
  102d10:	eb 01                	jmp    102d13 <strfind+0x2d>
            break;
  102d12:	90                   	nop
    }
    return (char *)s;
  102d13:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102d16:	c9                   	leave  
  102d17:	c3                   	ret    

00102d18 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102d18:	f3 0f 1e fb          	endbr32 
  102d1c:	55                   	push   %ebp
  102d1d:	89 e5                	mov    %esp,%ebp
  102d1f:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  102d22:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102d29:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102d30:	eb 03                	jmp    102d35 <strtol+0x1d>
        s ++;
  102d32:	ff 45 08             	incl   0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102d35:	8b 45 08             	mov    0x8(%ebp),%eax
  102d38:	0f b6 00             	movzbl (%eax),%eax
  102d3b:	3c 20                	cmp    $0x20,%al
  102d3d:	74 f3                	je     102d32 <strtol+0x1a>
  102d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  102d42:	0f b6 00             	movzbl (%eax),%eax
  102d45:	3c 09                	cmp    $0x9,%al
  102d47:	74 e9                	je     102d32 <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
  102d49:	8b 45 08             	mov    0x8(%ebp),%eax
  102d4c:	0f b6 00             	movzbl (%eax),%eax
  102d4f:	3c 2b                	cmp    $0x2b,%al
  102d51:	75 05                	jne    102d58 <strtol+0x40>
        s ++;
  102d53:	ff 45 08             	incl   0x8(%ebp)
  102d56:	eb 14                	jmp    102d6c <strtol+0x54>
    }
    else if (*s == '-') {
  102d58:	8b 45 08             	mov    0x8(%ebp),%eax
  102d5b:	0f b6 00             	movzbl (%eax),%eax
  102d5e:	3c 2d                	cmp    $0x2d,%al
  102d60:	75 0a                	jne    102d6c <strtol+0x54>
        s ++, neg = 1;
  102d62:	ff 45 08             	incl   0x8(%ebp)
  102d65:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102d6c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d70:	74 06                	je     102d78 <strtol+0x60>
  102d72:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102d76:	75 22                	jne    102d9a <strtol+0x82>
  102d78:	8b 45 08             	mov    0x8(%ebp),%eax
  102d7b:	0f b6 00             	movzbl (%eax),%eax
  102d7e:	3c 30                	cmp    $0x30,%al
  102d80:	75 18                	jne    102d9a <strtol+0x82>
  102d82:	8b 45 08             	mov    0x8(%ebp),%eax
  102d85:	40                   	inc    %eax
  102d86:	0f b6 00             	movzbl (%eax),%eax
  102d89:	3c 78                	cmp    $0x78,%al
  102d8b:	75 0d                	jne    102d9a <strtol+0x82>
        s += 2, base = 16;
  102d8d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102d91:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102d98:	eb 29                	jmp    102dc3 <strtol+0xab>
    }
    else if (base == 0 && s[0] == '0') {
  102d9a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d9e:	75 16                	jne    102db6 <strtol+0x9e>
  102da0:	8b 45 08             	mov    0x8(%ebp),%eax
  102da3:	0f b6 00             	movzbl (%eax),%eax
  102da6:	3c 30                	cmp    $0x30,%al
  102da8:	75 0c                	jne    102db6 <strtol+0x9e>
        s ++, base = 8;
  102daa:	ff 45 08             	incl   0x8(%ebp)
  102dad:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102db4:	eb 0d                	jmp    102dc3 <strtol+0xab>
    }
    else if (base == 0) {
  102db6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102dba:	75 07                	jne    102dc3 <strtol+0xab>
        base = 10;
  102dbc:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102dc3:	8b 45 08             	mov    0x8(%ebp),%eax
  102dc6:	0f b6 00             	movzbl (%eax),%eax
  102dc9:	3c 2f                	cmp    $0x2f,%al
  102dcb:	7e 1b                	jle    102de8 <strtol+0xd0>
  102dcd:	8b 45 08             	mov    0x8(%ebp),%eax
  102dd0:	0f b6 00             	movzbl (%eax),%eax
  102dd3:	3c 39                	cmp    $0x39,%al
  102dd5:	7f 11                	jg     102de8 <strtol+0xd0>
            dig = *s - '0';
  102dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  102dda:	0f b6 00             	movzbl (%eax),%eax
  102ddd:	0f be c0             	movsbl %al,%eax
  102de0:	83 e8 30             	sub    $0x30,%eax
  102de3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102de6:	eb 48                	jmp    102e30 <strtol+0x118>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102de8:	8b 45 08             	mov    0x8(%ebp),%eax
  102deb:	0f b6 00             	movzbl (%eax),%eax
  102dee:	3c 60                	cmp    $0x60,%al
  102df0:	7e 1b                	jle    102e0d <strtol+0xf5>
  102df2:	8b 45 08             	mov    0x8(%ebp),%eax
  102df5:	0f b6 00             	movzbl (%eax),%eax
  102df8:	3c 7a                	cmp    $0x7a,%al
  102dfa:	7f 11                	jg     102e0d <strtol+0xf5>
            dig = *s - 'a' + 10;
  102dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  102dff:	0f b6 00             	movzbl (%eax),%eax
  102e02:	0f be c0             	movsbl %al,%eax
  102e05:	83 e8 57             	sub    $0x57,%eax
  102e08:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102e0b:	eb 23                	jmp    102e30 <strtol+0x118>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  102e0d:	8b 45 08             	mov    0x8(%ebp),%eax
  102e10:	0f b6 00             	movzbl (%eax),%eax
  102e13:	3c 40                	cmp    $0x40,%al
  102e15:	7e 3b                	jle    102e52 <strtol+0x13a>
  102e17:	8b 45 08             	mov    0x8(%ebp),%eax
  102e1a:	0f b6 00             	movzbl (%eax),%eax
  102e1d:	3c 5a                	cmp    $0x5a,%al
  102e1f:	7f 31                	jg     102e52 <strtol+0x13a>
            dig = *s - 'A' + 10;
  102e21:	8b 45 08             	mov    0x8(%ebp),%eax
  102e24:	0f b6 00             	movzbl (%eax),%eax
  102e27:	0f be c0             	movsbl %al,%eax
  102e2a:	83 e8 37             	sub    $0x37,%eax
  102e2d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  102e30:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e33:	3b 45 10             	cmp    0x10(%ebp),%eax
  102e36:	7d 19                	jge    102e51 <strtol+0x139>
            break;
        }
        s ++, val = (val * base) + dig;
  102e38:	ff 45 08             	incl   0x8(%ebp)
  102e3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102e3e:	0f af 45 10          	imul   0x10(%ebp),%eax
  102e42:	89 c2                	mov    %eax,%edx
  102e44:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102e47:	01 d0                	add    %edx,%eax
  102e49:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  102e4c:	e9 72 ff ff ff       	jmp    102dc3 <strtol+0xab>
            break;
  102e51:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  102e52:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102e56:	74 08                	je     102e60 <strtol+0x148>
        *endptr = (char *) s;
  102e58:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e5b:	8b 55 08             	mov    0x8(%ebp),%edx
  102e5e:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102e60:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102e64:	74 07                	je     102e6d <strtol+0x155>
  102e66:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102e69:	f7 d8                	neg    %eax
  102e6b:	eb 03                	jmp    102e70 <strtol+0x158>
  102e6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102e70:	c9                   	leave  
  102e71:	c3                   	ret    

00102e72 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102e72:	f3 0f 1e fb          	endbr32 
  102e76:	55                   	push   %ebp
  102e77:	89 e5                	mov    %esp,%ebp
  102e79:	57                   	push   %edi
  102e7a:	83 ec 24             	sub    $0x24,%esp
  102e7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e80:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102e83:	0f be 55 d8          	movsbl -0x28(%ebp),%edx
  102e87:	8b 45 08             	mov    0x8(%ebp),%eax
  102e8a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  102e8d:	88 55 f7             	mov    %dl,-0x9(%ebp)
  102e90:	8b 45 10             	mov    0x10(%ebp),%eax
  102e93:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102e96:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102e99:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102e9d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102ea0:	89 d7                	mov    %edx,%edi
  102ea2:	f3 aa                	rep stos %al,%es:(%edi)
  102ea4:	89 fa                	mov    %edi,%edx
  102ea6:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102ea9:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102eac:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102eaf:	83 c4 24             	add    $0x24,%esp
  102eb2:	5f                   	pop    %edi
  102eb3:	5d                   	pop    %ebp
  102eb4:	c3                   	ret    

00102eb5 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102eb5:	f3 0f 1e fb          	endbr32 
  102eb9:	55                   	push   %ebp
  102eba:	89 e5                	mov    %esp,%ebp
  102ebc:	57                   	push   %edi
  102ebd:	56                   	push   %esi
  102ebe:	53                   	push   %ebx
  102ebf:	83 ec 30             	sub    $0x30,%esp
  102ec2:	8b 45 08             	mov    0x8(%ebp),%eax
  102ec5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102ec8:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ecb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102ece:	8b 45 10             	mov    0x10(%ebp),%eax
  102ed1:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102ed4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ed7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102eda:	73 42                	jae    102f1e <memmove+0x69>
  102edc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102edf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102ee2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102ee5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102ee8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102eeb:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102eee:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102ef1:	c1 e8 02             	shr    $0x2,%eax
  102ef4:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102ef6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102ef9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102efc:	89 d7                	mov    %edx,%edi
  102efe:	89 c6                	mov    %eax,%esi
  102f00:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102f02:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102f05:	83 e1 03             	and    $0x3,%ecx
  102f08:	74 02                	je     102f0c <memmove+0x57>
  102f0a:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102f0c:	89 f0                	mov    %esi,%eax
  102f0e:	89 fa                	mov    %edi,%edx
  102f10:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102f13:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102f16:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  102f19:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  102f1c:	eb 36                	jmp    102f54 <memmove+0x9f>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102f1e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f21:	8d 50 ff             	lea    -0x1(%eax),%edx
  102f24:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f27:	01 c2                	add    %eax,%edx
  102f29:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f2c:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102f2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f32:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  102f35:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102f38:	89 c1                	mov    %eax,%ecx
  102f3a:	89 d8                	mov    %ebx,%eax
  102f3c:	89 d6                	mov    %edx,%esi
  102f3e:	89 c7                	mov    %eax,%edi
  102f40:	fd                   	std    
  102f41:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102f43:	fc                   	cld    
  102f44:	89 f8                	mov    %edi,%eax
  102f46:	89 f2                	mov    %esi,%edx
  102f48:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  102f4b:	89 55 c8             	mov    %edx,-0x38(%ebp)
  102f4e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  102f51:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  102f54:	83 c4 30             	add    $0x30,%esp
  102f57:	5b                   	pop    %ebx
  102f58:	5e                   	pop    %esi
  102f59:	5f                   	pop    %edi
  102f5a:	5d                   	pop    %ebp
  102f5b:	c3                   	ret    

00102f5c <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  102f5c:	f3 0f 1e fb          	endbr32 
  102f60:	55                   	push   %ebp
  102f61:	89 e5                	mov    %esp,%ebp
  102f63:	57                   	push   %edi
  102f64:	56                   	push   %esi
  102f65:	83 ec 20             	sub    $0x20,%esp
  102f68:	8b 45 08             	mov    0x8(%ebp),%eax
  102f6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102f6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f71:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f74:	8b 45 10             	mov    0x10(%ebp),%eax
  102f77:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102f7a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f7d:	c1 e8 02             	shr    $0x2,%eax
  102f80:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102f82:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102f85:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f88:	89 d7                	mov    %edx,%edi
  102f8a:	89 c6                	mov    %eax,%esi
  102f8c:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102f8e:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  102f91:	83 e1 03             	and    $0x3,%ecx
  102f94:	74 02                	je     102f98 <memcpy+0x3c>
  102f96:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102f98:	89 f0                	mov    %esi,%eax
  102f9a:	89 fa                	mov    %edi,%edx
  102f9c:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102f9f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  102fa2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  102fa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  102fa8:	83 c4 20             	add    $0x20,%esp
  102fab:	5e                   	pop    %esi
  102fac:	5f                   	pop    %edi
  102fad:	5d                   	pop    %ebp
  102fae:	c3                   	ret    

00102faf <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  102faf:	f3 0f 1e fb          	endbr32 
  102fb3:	55                   	push   %ebp
  102fb4:	89 e5                	mov    %esp,%ebp
  102fb6:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  102fb9:	8b 45 08             	mov    0x8(%ebp),%eax
  102fbc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  102fbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fc2:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  102fc5:	eb 2e                	jmp    102ff5 <memcmp+0x46>
        if (*s1 != *s2) {
  102fc7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102fca:	0f b6 10             	movzbl (%eax),%edx
  102fcd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102fd0:	0f b6 00             	movzbl (%eax),%eax
  102fd3:	38 c2                	cmp    %al,%dl
  102fd5:	74 18                	je     102fef <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  102fd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102fda:	0f b6 00             	movzbl (%eax),%eax
  102fdd:	0f b6 d0             	movzbl %al,%edx
  102fe0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102fe3:	0f b6 00             	movzbl (%eax),%eax
  102fe6:	0f b6 c0             	movzbl %al,%eax
  102fe9:	29 c2                	sub    %eax,%edx
  102feb:	89 d0                	mov    %edx,%eax
  102fed:	eb 18                	jmp    103007 <memcmp+0x58>
        }
        s1 ++, s2 ++;
  102fef:	ff 45 fc             	incl   -0x4(%ebp)
  102ff2:	ff 45 f8             	incl   -0x8(%ebp)
    while (n -- > 0) {
  102ff5:	8b 45 10             	mov    0x10(%ebp),%eax
  102ff8:	8d 50 ff             	lea    -0x1(%eax),%edx
  102ffb:	89 55 10             	mov    %edx,0x10(%ebp)
  102ffe:	85 c0                	test   %eax,%eax
  103000:	75 c5                	jne    102fc7 <memcmp+0x18>
    }
    return 0;
  103002:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103007:	c9                   	leave  
  103008:	c3                   	ret    

00103009 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  103009:	f3 0f 1e fb          	endbr32 
  10300d:	55                   	push   %ebp
  10300e:	89 e5                	mov    %esp,%ebp
  103010:	83 ec 58             	sub    $0x58,%esp
  103013:	8b 45 10             	mov    0x10(%ebp),%eax
  103016:	89 45 d0             	mov    %eax,-0x30(%ebp)
  103019:	8b 45 14             	mov    0x14(%ebp),%eax
  10301c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  10301f:	8b 45 d0             	mov    -0x30(%ebp),%eax
  103022:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  103025:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103028:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  10302b:	8b 45 18             	mov    0x18(%ebp),%eax
  10302e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103031:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103034:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103037:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10303a:	89 55 f0             	mov    %edx,-0x10(%ebp)
  10303d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103040:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103043:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103047:	74 1c                	je     103065 <printnum+0x5c>
  103049:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10304c:	ba 00 00 00 00       	mov    $0x0,%edx
  103051:	f7 75 e4             	divl   -0x1c(%ebp)
  103054:	89 55 f4             	mov    %edx,-0xc(%ebp)
  103057:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10305a:	ba 00 00 00 00       	mov    $0x0,%edx
  10305f:	f7 75 e4             	divl   -0x1c(%ebp)
  103062:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103065:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103068:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10306b:	f7 75 e4             	divl   -0x1c(%ebp)
  10306e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103071:	89 55 dc             	mov    %edx,-0x24(%ebp)
  103074:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103077:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10307a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  10307d:	89 55 ec             	mov    %edx,-0x14(%ebp)
  103080:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103083:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  103086:	8b 45 18             	mov    0x18(%ebp),%eax
  103089:	ba 00 00 00 00       	mov    $0x0,%edx
  10308e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  103091:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  103094:	19 d1                	sbb    %edx,%ecx
  103096:	72 4c                	jb     1030e4 <printnum+0xdb>
        printnum(putch, putdat, result, base, width - 1, padc);
  103098:	8b 45 1c             	mov    0x1c(%ebp),%eax
  10309b:	8d 50 ff             	lea    -0x1(%eax),%edx
  10309e:	8b 45 20             	mov    0x20(%ebp),%eax
  1030a1:	89 44 24 18          	mov    %eax,0x18(%esp)
  1030a5:	89 54 24 14          	mov    %edx,0x14(%esp)
  1030a9:	8b 45 18             	mov    0x18(%ebp),%eax
  1030ac:	89 44 24 10          	mov    %eax,0x10(%esp)
  1030b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1030b3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1030b6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1030ba:	89 54 24 0c          	mov    %edx,0xc(%esp)
  1030be:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030c1:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1030c8:	89 04 24             	mov    %eax,(%esp)
  1030cb:	e8 39 ff ff ff       	call   103009 <printnum>
  1030d0:	eb 1b                	jmp    1030ed <printnum+0xe4>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  1030d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030d5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030d9:	8b 45 20             	mov    0x20(%ebp),%eax
  1030dc:	89 04 24             	mov    %eax,(%esp)
  1030df:	8b 45 08             	mov    0x8(%ebp),%eax
  1030e2:	ff d0                	call   *%eax
        while (-- width > 0)
  1030e4:	ff 4d 1c             	decl   0x1c(%ebp)
  1030e7:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  1030eb:	7f e5                	jg     1030d2 <printnum+0xc9>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  1030ed:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1030f0:	05 50 3e 10 00       	add    $0x103e50,%eax
  1030f5:	0f b6 00             	movzbl (%eax),%eax
  1030f8:	0f be c0             	movsbl %al,%eax
  1030fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  1030fe:	89 54 24 04          	mov    %edx,0x4(%esp)
  103102:	89 04 24             	mov    %eax,(%esp)
  103105:	8b 45 08             	mov    0x8(%ebp),%eax
  103108:	ff d0                	call   *%eax
}
  10310a:	90                   	nop
  10310b:	c9                   	leave  
  10310c:	c3                   	ret    

0010310d <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  10310d:	f3 0f 1e fb          	endbr32 
  103111:	55                   	push   %ebp
  103112:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  103114:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103118:	7e 14                	jle    10312e <getuint+0x21>
        return va_arg(*ap, unsigned long long);
  10311a:	8b 45 08             	mov    0x8(%ebp),%eax
  10311d:	8b 00                	mov    (%eax),%eax
  10311f:	8d 48 08             	lea    0x8(%eax),%ecx
  103122:	8b 55 08             	mov    0x8(%ebp),%edx
  103125:	89 0a                	mov    %ecx,(%edx)
  103127:	8b 50 04             	mov    0x4(%eax),%edx
  10312a:	8b 00                	mov    (%eax),%eax
  10312c:	eb 30                	jmp    10315e <getuint+0x51>
    }
    else if (lflag) {
  10312e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103132:	74 16                	je     10314a <getuint+0x3d>
        return va_arg(*ap, unsigned long);
  103134:	8b 45 08             	mov    0x8(%ebp),%eax
  103137:	8b 00                	mov    (%eax),%eax
  103139:	8d 48 04             	lea    0x4(%eax),%ecx
  10313c:	8b 55 08             	mov    0x8(%ebp),%edx
  10313f:	89 0a                	mov    %ecx,(%edx)
  103141:	8b 00                	mov    (%eax),%eax
  103143:	ba 00 00 00 00       	mov    $0x0,%edx
  103148:	eb 14                	jmp    10315e <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
  10314a:	8b 45 08             	mov    0x8(%ebp),%eax
  10314d:	8b 00                	mov    (%eax),%eax
  10314f:	8d 48 04             	lea    0x4(%eax),%ecx
  103152:	8b 55 08             	mov    0x8(%ebp),%edx
  103155:	89 0a                	mov    %ecx,(%edx)
  103157:	8b 00                	mov    (%eax),%eax
  103159:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  10315e:	5d                   	pop    %ebp
  10315f:	c3                   	ret    

00103160 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  103160:	f3 0f 1e fb          	endbr32 
  103164:	55                   	push   %ebp
  103165:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  103167:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  10316b:	7e 14                	jle    103181 <getint+0x21>
        return va_arg(*ap, long long);
  10316d:	8b 45 08             	mov    0x8(%ebp),%eax
  103170:	8b 00                	mov    (%eax),%eax
  103172:	8d 48 08             	lea    0x8(%eax),%ecx
  103175:	8b 55 08             	mov    0x8(%ebp),%edx
  103178:	89 0a                	mov    %ecx,(%edx)
  10317a:	8b 50 04             	mov    0x4(%eax),%edx
  10317d:	8b 00                	mov    (%eax),%eax
  10317f:	eb 28                	jmp    1031a9 <getint+0x49>
    }
    else if (lflag) {
  103181:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103185:	74 12                	je     103199 <getint+0x39>
        return va_arg(*ap, long);
  103187:	8b 45 08             	mov    0x8(%ebp),%eax
  10318a:	8b 00                	mov    (%eax),%eax
  10318c:	8d 48 04             	lea    0x4(%eax),%ecx
  10318f:	8b 55 08             	mov    0x8(%ebp),%edx
  103192:	89 0a                	mov    %ecx,(%edx)
  103194:	8b 00                	mov    (%eax),%eax
  103196:	99                   	cltd   
  103197:	eb 10                	jmp    1031a9 <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
  103199:	8b 45 08             	mov    0x8(%ebp),%eax
  10319c:	8b 00                	mov    (%eax),%eax
  10319e:	8d 48 04             	lea    0x4(%eax),%ecx
  1031a1:	8b 55 08             	mov    0x8(%ebp),%edx
  1031a4:	89 0a                	mov    %ecx,(%edx)
  1031a6:	8b 00                	mov    (%eax),%eax
  1031a8:	99                   	cltd   
    }
}
  1031a9:	5d                   	pop    %ebp
  1031aa:	c3                   	ret    

001031ab <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  1031ab:	f3 0f 1e fb          	endbr32 
  1031af:	55                   	push   %ebp
  1031b0:	89 e5                	mov    %esp,%ebp
  1031b2:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  1031b5:	8d 45 14             	lea    0x14(%ebp),%eax
  1031b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  1031bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1031be:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1031c2:	8b 45 10             	mov    0x10(%ebp),%eax
  1031c5:	89 44 24 08          	mov    %eax,0x8(%esp)
  1031c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031cc:	89 44 24 04          	mov    %eax,0x4(%esp)
  1031d0:	8b 45 08             	mov    0x8(%ebp),%eax
  1031d3:	89 04 24             	mov    %eax,(%esp)
  1031d6:	e8 03 00 00 00       	call   1031de <vprintfmt>
    va_end(ap);
}
  1031db:	90                   	nop
  1031dc:	c9                   	leave  
  1031dd:	c3                   	ret    

001031de <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  1031de:	f3 0f 1e fb          	endbr32 
  1031e2:	55                   	push   %ebp
  1031e3:	89 e5                	mov    %esp,%ebp
  1031e5:	56                   	push   %esi
  1031e6:	53                   	push   %ebx
  1031e7:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  1031ea:	eb 17                	jmp    103203 <vprintfmt+0x25>
            if (ch == '\0') {
  1031ec:	85 db                	test   %ebx,%ebx
  1031ee:	0f 84 c0 03 00 00    	je     1035b4 <vprintfmt+0x3d6>
                return;
            }
            putch(ch, putdat);
  1031f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031f7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1031fb:	89 1c 24             	mov    %ebx,(%esp)
  1031fe:	8b 45 08             	mov    0x8(%ebp),%eax
  103201:	ff d0                	call   *%eax
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103203:	8b 45 10             	mov    0x10(%ebp),%eax
  103206:	8d 50 01             	lea    0x1(%eax),%edx
  103209:	89 55 10             	mov    %edx,0x10(%ebp)
  10320c:	0f b6 00             	movzbl (%eax),%eax
  10320f:	0f b6 d8             	movzbl %al,%ebx
  103212:	83 fb 25             	cmp    $0x25,%ebx
  103215:	75 d5                	jne    1031ec <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
  103217:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  10321b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  103222:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103225:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  103228:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  10322f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103232:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  103235:	8b 45 10             	mov    0x10(%ebp),%eax
  103238:	8d 50 01             	lea    0x1(%eax),%edx
  10323b:	89 55 10             	mov    %edx,0x10(%ebp)
  10323e:	0f b6 00             	movzbl (%eax),%eax
  103241:	0f b6 d8             	movzbl %al,%ebx
  103244:	8d 43 dd             	lea    -0x23(%ebx),%eax
  103247:	83 f8 55             	cmp    $0x55,%eax
  10324a:	0f 87 38 03 00 00    	ja     103588 <vprintfmt+0x3aa>
  103250:	8b 04 85 74 3e 10 00 	mov    0x103e74(,%eax,4),%eax
  103257:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  10325a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  10325e:	eb d5                	jmp    103235 <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  103260:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  103264:	eb cf                	jmp    103235 <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  103266:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  10326d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  103270:	89 d0                	mov    %edx,%eax
  103272:	c1 e0 02             	shl    $0x2,%eax
  103275:	01 d0                	add    %edx,%eax
  103277:	01 c0                	add    %eax,%eax
  103279:	01 d8                	add    %ebx,%eax
  10327b:	83 e8 30             	sub    $0x30,%eax
  10327e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  103281:	8b 45 10             	mov    0x10(%ebp),%eax
  103284:	0f b6 00             	movzbl (%eax),%eax
  103287:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  10328a:	83 fb 2f             	cmp    $0x2f,%ebx
  10328d:	7e 38                	jle    1032c7 <vprintfmt+0xe9>
  10328f:	83 fb 39             	cmp    $0x39,%ebx
  103292:	7f 33                	jg     1032c7 <vprintfmt+0xe9>
            for (precision = 0; ; ++ fmt) {
  103294:	ff 45 10             	incl   0x10(%ebp)
                precision = precision * 10 + ch - '0';
  103297:	eb d4                	jmp    10326d <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  103299:	8b 45 14             	mov    0x14(%ebp),%eax
  10329c:	8d 50 04             	lea    0x4(%eax),%edx
  10329f:	89 55 14             	mov    %edx,0x14(%ebp)
  1032a2:	8b 00                	mov    (%eax),%eax
  1032a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  1032a7:	eb 1f                	jmp    1032c8 <vprintfmt+0xea>

        case '.':
            if (width < 0)
  1032a9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1032ad:	79 86                	jns    103235 <vprintfmt+0x57>
                width = 0;
  1032af:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  1032b6:	e9 7a ff ff ff       	jmp    103235 <vprintfmt+0x57>

        case '#':
            altflag = 1;
  1032bb:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  1032c2:	e9 6e ff ff ff       	jmp    103235 <vprintfmt+0x57>
            goto process_precision;
  1032c7:	90                   	nop

        process_precision:
            if (width < 0)
  1032c8:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1032cc:	0f 89 63 ff ff ff    	jns    103235 <vprintfmt+0x57>
                width = precision, precision = -1;
  1032d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1032d5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1032d8:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  1032df:	e9 51 ff ff ff       	jmp    103235 <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  1032e4:	ff 45 e0             	incl   -0x20(%ebp)
            goto reswitch;
  1032e7:	e9 49 ff ff ff       	jmp    103235 <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  1032ec:	8b 45 14             	mov    0x14(%ebp),%eax
  1032ef:	8d 50 04             	lea    0x4(%eax),%edx
  1032f2:	89 55 14             	mov    %edx,0x14(%ebp)
  1032f5:	8b 00                	mov    (%eax),%eax
  1032f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  1032fa:	89 54 24 04          	mov    %edx,0x4(%esp)
  1032fe:	89 04 24             	mov    %eax,(%esp)
  103301:	8b 45 08             	mov    0x8(%ebp),%eax
  103304:	ff d0                	call   *%eax
            break;
  103306:	e9 a4 02 00 00       	jmp    1035af <vprintfmt+0x3d1>

        // error message
        case 'e':
            err = va_arg(ap, int);
  10330b:	8b 45 14             	mov    0x14(%ebp),%eax
  10330e:	8d 50 04             	lea    0x4(%eax),%edx
  103311:	89 55 14             	mov    %edx,0x14(%ebp)
  103314:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  103316:	85 db                	test   %ebx,%ebx
  103318:	79 02                	jns    10331c <vprintfmt+0x13e>
                err = -err;
  10331a:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  10331c:	83 fb 06             	cmp    $0x6,%ebx
  10331f:	7f 0b                	jg     10332c <vprintfmt+0x14e>
  103321:	8b 34 9d 34 3e 10 00 	mov    0x103e34(,%ebx,4),%esi
  103328:	85 f6                	test   %esi,%esi
  10332a:	75 23                	jne    10334f <vprintfmt+0x171>
                printfmt(putch, putdat, "error %d", err);
  10332c:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  103330:	c7 44 24 08 61 3e 10 	movl   $0x103e61,0x8(%esp)
  103337:	00 
  103338:	8b 45 0c             	mov    0xc(%ebp),%eax
  10333b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10333f:	8b 45 08             	mov    0x8(%ebp),%eax
  103342:	89 04 24             	mov    %eax,(%esp)
  103345:	e8 61 fe ff ff       	call   1031ab <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  10334a:	e9 60 02 00 00       	jmp    1035af <vprintfmt+0x3d1>
                printfmt(putch, putdat, "%s", p);
  10334f:	89 74 24 0c          	mov    %esi,0xc(%esp)
  103353:	c7 44 24 08 6a 3e 10 	movl   $0x103e6a,0x8(%esp)
  10335a:	00 
  10335b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10335e:	89 44 24 04          	mov    %eax,0x4(%esp)
  103362:	8b 45 08             	mov    0x8(%ebp),%eax
  103365:	89 04 24             	mov    %eax,(%esp)
  103368:	e8 3e fe ff ff       	call   1031ab <printfmt>
            break;
  10336d:	e9 3d 02 00 00       	jmp    1035af <vprintfmt+0x3d1>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  103372:	8b 45 14             	mov    0x14(%ebp),%eax
  103375:	8d 50 04             	lea    0x4(%eax),%edx
  103378:	89 55 14             	mov    %edx,0x14(%ebp)
  10337b:	8b 30                	mov    (%eax),%esi
  10337d:	85 f6                	test   %esi,%esi
  10337f:	75 05                	jne    103386 <vprintfmt+0x1a8>
                p = "(null)";
  103381:	be 6d 3e 10 00       	mov    $0x103e6d,%esi
            }
            if (width > 0 && padc != '-') {
  103386:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10338a:	7e 76                	jle    103402 <vprintfmt+0x224>
  10338c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  103390:	74 70                	je     103402 <vprintfmt+0x224>
                for (width -= strnlen(p, precision); width > 0; width --) {
  103392:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103395:	89 44 24 04          	mov    %eax,0x4(%esp)
  103399:	89 34 24             	mov    %esi,(%esp)
  10339c:	e8 ba f7 ff ff       	call   102b5b <strnlen>
  1033a1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  1033a4:	29 c2                	sub    %eax,%edx
  1033a6:	89 d0                	mov    %edx,%eax
  1033a8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1033ab:	eb 16                	jmp    1033c3 <vprintfmt+0x1e5>
                    putch(padc, putdat);
  1033ad:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  1033b1:	8b 55 0c             	mov    0xc(%ebp),%edx
  1033b4:	89 54 24 04          	mov    %edx,0x4(%esp)
  1033b8:	89 04 24             	mov    %eax,(%esp)
  1033bb:	8b 45 08             	mov    0x8(%ebp),%eax
  1033be:	ff d0                	call   *%eax
                for (width -= strnlen(p, precision); width > 0; width --) {
  1033c0:	ff 4d e8             	decl   -0x18(%ebp)
  1033c3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1033c7:	7f e4                	jg     1033ad <vprintfmt+0x1cf>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1033c9:	eb 37                	jmp    103402 <vprintfmt+0x224>
                if (altflag && (ch < ' ' || ch > '~')) {
  1033cb:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  1033cf:	74 1f                	je     1033f0 <vprintfmt+0x212>
  1033d1:	83 fb 1f             	cmp    $0x1f,%ebx
  1033d4:	7e 05                	jle    1033db <vprintfmt+0x1fd>
  1033d6:	83 fb 7e             	cmp    $0x7e,%ebx
  1033d9:	7e 15                	jle    1033f0 <vprintfmt+0x212>
                    putch('?', putdat);
  1033db:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033de:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033e2:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  1033e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1033ec:	ff d0                	call   *%eax
  1033ee:	eb 0f                	jmp    1033ff <vprintfmt+0x221>
                }
                else {
                    putch(ch, putdat);
  1033f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1033f7:	89 1c 24             	mov    %ebx,(%esp)
  1033fa:	8b 45 08             	mov    0x8(%ebp),%eax
  1033fd:	ff d0                	call   *%eax
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  1033ff:	ff 4d e8             	decl   -0x18(%ebp)
  103402:	89 f0                	mov    %esi,%eax
  103404:	8d 70 01             	lea    0x1(%eax),%esi
  103407:	0f b6 00             	movzbl (%eax),%eax
  10340a:	0f be d8             	movsbl %al,%ebx
  10340d:	85 db                	test   %ebx,%ebx
  10340f:	74 27                	je     103438 <vprintfmt+0x25a>
  103411:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103415:	78 b4                	js     1033cb <vprintfmt+0x1ed>
  103417:	ff 4d e4             	decl   -0x1c(%ebp)
  10341a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10341e:	79 ab                	jns    1033cb <vprintfmt+0x1ed>
                }
            }
            for (; width > 0; width --) {
  103420:	eb 16                	jmp    103438 <vprintfmt+0x25a>
                putch(' ', putdat);
  103422:	8b 45 0c             	mov    0xc(%ebp),%eax
  103425:	89 44 24 04          	mov    %eax,0x4(%esp)
  103429:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  103430:	8b 45 08             	mov    0x8(%ebp),%eax
  103433:	ff d0                	call   *%eax
            for (; width > 0; width --) {
  103435:	ff 4d e8             	decl   -0x18(%ebp)
  103438:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10343c:	7f e4                	jg     103422 <vprintfmt+0x244>
            }
            break;
  10343e:	e9 6c 01 00 00       	jmp    1035af <vprintfmt+0x3d1>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  103443:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103446:	89 44 24 04          	mov    %eax,0x4(%esp)
  10344a:	8d 45 14             	lea    0x14(%ebp),%eax
  10344d:	89 04 24             	mov    %eax,(%esp)
  103450:	e8 0b fd ff ff       	call   103160 <getint>
  103455:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103458:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  10345b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10345e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103461:	85 d2                	test   %edx,%edx
  103463:	79 26                	jns    10348b <vprintfmt+0x2ad>
                putch('-', putdat);
  103465:	8b 45 0c             	mov    0xc(%ebp),%eax
  103468:	89 44 24 04          	mov    %eax,0x4(%esp)
  10346c:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  103473:	8b 45 08             	mov    0x8(%ebp),%eax
  103476:	ff d0                	call   *%eax
                num = -(long long)num;
  103478:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10347b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10347e:	f7 d8                	neg    %eax
  103480:	83 d2 00             	adc    $0x0,%edx
  103483:	f7 da                	neg    %edx
  103485:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103488:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  10348b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  103492:	e9 a8 00 00 00       	jmp    10353f <vprintfmt+0x361>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  103497:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10349a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10349e:	8d 45 14             	lea    0x14(%ebp),%eax
  1034a1:	89 04 24             	mov    %eax,(%esp)
  1034a4:	e8 64 fc ff ff       	call   10310d <getuint>
  1034a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  1034af:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1034b6:	e9 84 00 00 00       	jmp    10353f <vprintfmt+0x361>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  1034bb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1034be:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034c2:	8d 45 14             	lea    0x14(%ebp),%eax
  1034c5:	89 04 24             	mov    %eax,(%esp)
  1034c8:	e8 40 fc ff ff       	call   10310d <getuint>
  1034cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034d0:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  1034d3:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  1034da:	eb 63                	jmp    10353f <vprintfmt+0x361>

        // pointer
        case 'p':
            putch('0', putdat);
  1034dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034df:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034e3:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  1034ea:	8b 45 08             	mov    0x8(%ebp),%eax
  1034ed:	ff d0                	call   *%eax
            putch('x', putdat);
  1034ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034f2:	89 44 24 04          	mov    %eax,0x4(%esp)
  1034f6:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  1034fd:	8b 45 08             	mov    0x8(%ebp),%eax
  103500:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  103502:	8b 45 14             	mov    0x14(%ebp),%eax
  103505:	8d 50 04             	lea    0x4(%eax),%edx
  103508:	89 55 14             	mov    %edx,0x14(%ebp)
  10350b:	8b 00                	mov    (%eax),%eax
  10350d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103510:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  103517:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  10351e:	eb 1f                	jmp    10353f <vprintfmt+0x361>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  103520:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103523:	89 44 24 04          	mov    %eax,0x4(%esp)
  103527:	8d 45 14             	lea    0x14(%ebp),%eax
  10352a:	89 04 24             	mov    %eax,(%esp)
  10352d:	e8 db fb ff ff       	call   10310d <getuint>
  103532:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103535:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  103538:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  10353f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  103543:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103546:	89 54 24 18          	mov    %edx,0x18(%esp)
  10354a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  10354d:	89 54 24 14          	mov    %edx,0x14(%esp)
  103551:	89 44 24 10          	mov    %eax,0x10(%esp)
  103555:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103558:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10355b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10355f:	89 54 24 0c          	mov    %edx,0xc(%esp)
  103563:	8b 45 0c             	mov    0xc(%ebp),%eax
  103566:	89 44 24 04          	mov    %eax,0x4(%esp)
  10356a:	8b 45 08             	mov    0x8(%ebp),%eax
  10356d:	89 04 24             	mov    %eax,(%esp)
  103570:	e8 94 fa ff ff       	call   103009 <printnum>
            break;
  103575:	eb 38                	jmp    1035af <vprintfmt+0x3d1>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  103577:	8b 45 0c             	mov    0xc(%ebp),%eax
  10357a:	89 44 24 04          	mov    %eax,0x4(%esp)
  10357e:	89 1c 24             	mov    %ebx,(%esp)
  103581:	8b 45 08             	mov    0x8(%ebp),%eax
  103584:	ff d0                	call   *%eax
            break;
  103586:	eb 27                	jmp    1035af <vprintfmt+0x3d1>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  103588:	8b 45 0c             	mov    0xc(%ebp),%eax
  10358b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10358f:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  103596:	8b 45 08             	mov    0x8(%ebp),%eax
  103599:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  10359b:	ff 4d 10             	decl   0x10(%ebp)
  10359e:	eb 03                	jmp    1035a3 <vprintfmt+0x3c5>
  1035a0:	ff 4d 10             	decl   0x10(%ebp)
  1035a3:	8b 45 10             	mov    0x10(%ebp),%eax
  1035a6:	48                   	dec    %eax
  1035a7:	0f b6 00             	movzbl (%eax),%eax
  1035aa:	3c 25                	cmp    $0x25,%al
  1035ac:	75 f2                	jne    1035a0 <vprintfmt+0x3c2>
                /* do nothing */;
            break;
  1035ae:	90                   	nop
    while (1) {
  1035af:	e9 36 fc ff ff       	jmp    1031ea <vprintfmt+0xc>
                return;
  1035b4:	90                   	nop
        }
    }
}
  1035b5:	83 c4 40             	add    $0x40,%esp
  1035b8:	5b                   	pop    %ebx
  1035b9:	5e                   	pop    %esi
  1035ba:	5d                   	pop    %ebp
  1035bb:	c3                   	ret    

001035bc <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  1035bc:	f3 0f 1e fb          	endbr32 
  1035c0:	55                   	push   %ebp
  1035c1:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  1035c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035c6:	8b 40 08             	mov    0x8(%eax),%eax
  1035c9:	8d 50 01             	lea    0x1(%eax),%edx
  1035cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035cf:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  1035d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035d5:	8b 10                	mov    (%eax),%edx
  1035d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035da:	8b 40 04             	mov    0x4(%eax),%eax
  1035dd:	39 c2                	cmp    %eax,%edx
  1035df:	73 12                	jae    1035f3 <sprintputch+0x37>
        *b->buf ++ = ch;
  1035e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1035e4:	8b 00                	mov    (%eax),%eax
  1035e6:	8d 48 01             	lea    0x1(%eax),%ecx
  1035e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  1035ec:	89 0a                	mov    %ecx,(%edx)
  1035ee:	8b 55 08             	mov    0x8(%ebp),%edx
  1035f1:	88 10                	mov    %dl,(%eax)
    }
}
  1035f3:	90                   	nop
  1035f4:	5d                   	pop    %ebp
  1035f5:	c3                   	ret    

001035f6 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  1035f6:	f3 0f 1e fb          	endbr32 
  1035fa:	55                   	push   %ebp
  1035fb:	89 e5                	mov    %esp,%ebp
  1035fd:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  103600:	8d 45 14             	lea    0x14(%ebp),%eax
  103603:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103606:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103609:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10360d:	8b 45 10             	mov    0x10(%ebp),%eax
  103610:	89 44 24 08          	mov    %eax,0x8(%esp)
  103614:	8b 45 0c             	mov    0xc(%ebp),%eax
  103617:	89 44 24 04          	mov    %eax,0x4(%esp)
  10361b:	8b 45 08             	mov    0x8(%ebp),%eax
  10361e:	89 04 24             	mov    %eax,(%esp)
  103621:	e8 08 00 00 00       	call   10362e <vsnprintf>
  103626:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103629:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10362c:	c9                   	leave  
  10362d:	c3                   	ret    

0010362e <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  10362e:	f3 0f 1e fb          	endbr32 
  103632:	55                   	push   %ebp
  103633:	89 e5                	mov    %esp,%ebp
  103635:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  103638:	8b 45 08             	mov    0x8(%ebp),%eax
  10363b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10363e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103641:	8d 50 ff             	lea    -0x1(%eax),%edx
  103644:	8b 45 08             	mov    0x8(%ebp),%eax
  103647:	01 d0                	add    %edx,%eax
  103649:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10364c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  103653:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  103657:	74 0a                	je     103663 <vsnprintf+0x35>
  103659:	8b 55 ec             	mov    -0x14(%ebp),%edx
  10365c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10365f:	39 c2                	cmp    %eax,%edx
  103661:	76 07                	jbe    10366a <vsnprintf+0x3c>
        return -E_INVAL;
  103663:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  103668:	eb 2a                	jmp    103694 <vsnprintf+0x66>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  10366a:	8b 45 14             	mov    0x14(%ebp),%eax
  10366d:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103671:	8b 45 10             	mov    0x10(%ebp),%eax
  103674:	89 44 24 08          	mov    %eax,0x8(%esp)
  103678:	8d 45 ec             	lea    -0x14(%ebp),%eax
  10367b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10367f:	c7 04 24 bc 35 10 00 	movl   $0x1035bc,(%esp)
  103686:	e8 53 fb ff ff       	call   1031de <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  10368b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10368e:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  103691:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103694:	c9                   	leave  
  103695:	c3                   	ret    
