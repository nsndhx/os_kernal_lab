
bin/kernel：     文件格式 elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
void kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

void
kern_init(void){
  100000:	f3 0f 1e fb          	endbr32 
  100004:	55                   	push   %ebp
  100005:	89 e5                	mov    %esp,%ebp
  100007:	83 ec 18             	sub    $0x18,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  10000a:	b8 80 0d 11 00       	mov    $0x110d80,%eax
  10000f:	2d 16 fa 10 00       	sub    $0x10fa16,%eax
  100014:	83 ec 04             	sub    $0x4,%esp
  100017:	50                   	push   %eax
  100018:	6a 00                	push   $0x0
  10001a:	68 16 fa 10 00       	push   $0x10fa16
  10001f:	e8 05 2f 00 00       	call   102f29 <memset>
  100024:	83 c4 10             	add    $0x10,%esp

    cons_init();                // init the console
  100027:	e8 01 16 00 00       	call   10162d <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  10002c:	c7 45 f4 00 37 10 00 	movl   $0x103700,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100033:	83 ec 08             	sub    $0x8,%esp
  100036:	ff 75 f4             	pushl  -0xc(%ebp)
  100039:	68 1c 37 10 00       	push   $0x10371c
  10003e:	e8 32 02 00 00       	call   100275 <cprintf>
  100043:	83 c4 10             	add    $0x10,%esp

    print_kerninfo();
  100046:	e8 e6 08 00 00       	call   100931 <print_kerninfo>

    grade_backtrace();
  10004b:	e8 85 00 00 00       	call   1000d5 <grade_backtrace>

    pmm_init();                 // init physical memory management
  100050:	e8 72 2b 00 00       	call   102bc7 <pmm_init>

    pic_init();                 // init interrupt controller
  100055:	e8 2c 17 00 00       	call   101786 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005a:	e8 ce 18 00 00       	call   10192d <idt_init>

    clock_init();               // init clock interrupt
  10005f:	e8 4e 0d 00 00       	call   100db2 <clock_init>
    intr_enable();              // enable irq interrupt
  100064:	e8 6c 18 00 00       	call   1018d5 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  100069:	e8 6c 01 00 00       	call   1001da <lab1_switch_test>

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
  100077:	83 ec 08             	sub    $0x8,%esp
    mon_backtrace(0, NULL, NULL);
  10007a:	83 ec 04             	sub    $0x4,%esp
  10007d:	6a 00                	push   $0x0
  10007f:	6a 00                	push   $0x0
  100081:	6a 00                	push   $0x0
  100083:	e8 14 0d 00 00       	call   100d9c <mon_backtrace>
  100088:	83 c4 10             	add    $0x10,%esp
}
  10008b:	90                   	nop
  10008c:	c9                   	leave  
  10008d:	c3                   	ret    

0010008e <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  10008e:	f3 0f 1e fb          	endbr32 
  100092:	55                   	push   %ebp
  100093:	89 e5                	mov    %esp,%ebp
  100095:	53                   	push   %ebx
  100096:	83 ec 04             	sub    $0x4,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  100099:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  10009c:	8b 55 0c             	mov    0xc(%ebp),%edx
  10009f:	8d 5d 08             	lea    0x8(%ebp),%ebx
  1000a2:	8b 45 08             	mov    0x8(%ebp),%eax
  1000a5:	51                   	push   %ecx
  1000a6:	52                   	push   %edx
  1000a7:	53                   	push   %ebx
  1000a8:	50                   	push   %eax
  1000a9:	e8 c2 ff ff ff       	call   100070 <grade_backtrace2>
  1000ae:	83 c4 10             	add    $0x10,%esp
}
  1000b1:	90                   	nop
  1000b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000b5:	c9                   	leave  
  1000b6:	c3                   	ret    

001000b7 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000b7:	f3 0f 1e fb          	endbr32 
  1000bb:	55                   	push   %ebp
  1000bc:	89 e5                	mov    %esp,%ebp
  1000be:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace1(arg0, arg2);
  1000c1:	83 ec 08             	sub    $0x8,%esp
  1000c4:	ff 75 10             	pushl  0x10(%ebp)
  1000c7:	ff 75 08             	pushl  0x8(%ebp)
  1000ca:	e8 bf ff ff ff       	call   10008e <grade_backtrace1>
  1000cf:	83 c4 10             	add    $0x10,%esp
}
  1000d2:	90                   	nop
  1000d3:	c9                   	leave  
  1000d4:	c3                   	ret    

001000d5 <grade_backtrace>:

void
grade_backtrace(void) {
  1000d5:	f3 0f 1e fb          	endbr32 
  1000d9:	55                   	push   %ebp
  1000da:	89 e5                	mov    %esp,%ebp
  1000dc:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000df:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000e4:	83 ec 04             	sub    $0x4,%esp
  1000e7:	68 00 00 ff ff       	push   $0xffff0000
  1000ec:	50                   	push   %eax
  1000ed:	6a 00                	push   $0x0
  1000ef:	e8 c3 ff ff ff       	call   1000b7 <grade_backtrace0>
  1000f4:	83 c4 10             	add    $0x10,%esp
}
  1000f7:	90                   	nop
  1000f8:	c9                   	leave  
  1000f9:	c3                   	ret    

001000fa <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  1000fa:	f3 0f 1e fb          	endbr32 
  1000fe:	55                   	push   %ebp
  1000ff:	89 e5                	mov    %esp,%ebp
  100101:	83 ec 18             	sub    $0x18,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100104:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  100107:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  10010a:	8c 45 f2             	mov    %es,-0xe(%ebp)
  10010d:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100110:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100114:	0f b7 c0             	movzwl %ax,%eax
  100117:	83 e0 03             	and    $0x3,%eax
  10011a:	89 c2                	mov    %eax,%edx
  10011c:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  100121:	83 ec 04             	sub    $0x4,%esp
  100124:	52                   	push   %edx
  100125:	50                   	push   %eax
  100126:	68 21 37 10 00       	push   $0x103721
  10012b:	e8 45 01 00 00       	call   100275 <cprintf>
  100130:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
  100133:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100137:	0f b7 d0             	movzwl %ax,%edx
  10013a:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10013f:	83 ec 04             	sub    $0x4,%esp
  100142:	52                   	push   %edx
  100143:	50                   	push   %eax
  100144:	68 2f 37 10 00       	push   $0x10372f
  100149:	e8 27 01 00 00       	call   100275 <cprintf>
  10014e:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
  100151:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100155:	0f b7 d0             	movzwl %ax,%edx
  100158:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10015d:	83 ec 04             	sub    $0x4,%esp
  100160:	52                   	push   %edx
  100161:	50                   	push   %eax
  100162:	68 3d 37 10 00       	push   $0x10373d
  100167:	e8 09 01 00 00       	call   100275 <cprintf>
  10016c:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
  10016f:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100173:	0f b7 d0             	movzwl %ax,%edx
  100176:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  10017b:	83 ec 04             	sub    $0x4,%esp
  10017e:	52                   	push   %edx
  10017f:	50                   	push   %eax
  100180:	68 4b 37 10 00       	push   $0x10374b
  100185:	e8 eb 00 00 00       	call   100275 <cprintf>
  10018a:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
  10018d:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  100191:	0f b7 d0             	movzwl %ax,%edx
  100194:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  100199:	83 ec 04             	sub    $0x4,%esp
  10019c:	52                   	push   %edx
  10019d:	50                   	push   %eax
  10019e:	68 59 37 10 00       	push   $0x103759
  1001a3:	e8 cd 00 00 00       	call   100275 <cprintf>
  1001a8:	83 c4 10             	add    $0x10,%esp
    round ++;
  1001ab:	a1 20 fa 10 00       	mov    0x10fa20,%eax
  1001b0:	83 c0 01             	add    $0x1,%eax
  1001b3:	a3 20 fa 10 00       	mov    %eax,0x10fa20
}
  1001b8:	90                   	nop
  1001b9:	c9                   	leave  
  1001ba:	c3                   	ret    

001001bb <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001bb:	f3 0f 1e fb          	endbr32 
  1001bf:	55                   	push   %ebp
  1001c0:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
	asm volatile (
  1001c2:	83 ec 08             	sub    $0x8,%esp
  1001c5:	cd 78                	int    $0x78
  1001c7:	89 ec                	mov    %ebp,%esp
	    "int %0 \n"
	    "movl %%ebp, %%esp"
	    : 
	    : "i"(T_SWITCH_TOU)
	);
}
  1001c9:	90                   	nop
  1001ca:	5d                   	pop    %ebp
  1001cb:	c3                   	ret    

001001cc <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001cc:	f3 0f 1e fb          	endbr32 
  1001d0:	55                   	push   %ebp
  1001d1:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
	asm volatile (
  1001d3:	cd 79                	int    $0x79
  1001d5:	89 ec                	mov    %ebp,%esp
	    "int %0 \n"
	    "movl %%ebp, %%esp \n"
	    : 
	    : "i"(T_SWITCH_TOK)
	);
}
  1001d7:	90                   	nop
  1001d8:	5d                   	pop    %ebp
  1001d9:	c3                   	ret    

001001da <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001da:	f3 0f 1e fb          	endbr32 
  1001de:	55                   	push   %ebp
  1001df:	89 e5                	mov    %esp,%ebp
  1001e1:	83 ec 08             	sub    $0x8,%esp
    lab1_print_cur_status();
  1001e4:	e8 11 ff ff ff       	call   1000fa <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001e9:	83 ec 0c             	sub    $0xc,%esp
  1001ec:	68 68 37 10 00       	push   $0x103768
  1001f1:	e8 7f 00 00 00       	call   100275 <cprintf>
  1001f6:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
  1001f9:	e8 bd ff ff ff       	call   1001bb <lab1_switch_to_user>
    lab1_print_cur_status();
  1001fe:	e8 f7 fe ff ff       	call   1000fa <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  100203:	83 ec 0c             	sub    $0xc,%esp
  100206:	68 88 37 10 00       	push   $0x103788
  10020b:	e8 65 00 00 00       	call   100275 <cprintf>
  100210:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
  100213:	e8 b4 ff ff ff       	call   1001cc <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100218:	e8 dd fe ff ff       	call   1000fa <lab1_print_cur_status>
}
  10021d:	90                   	nop
  10021e:	c9                   	leave  
  10021f:	c3                   	ret    

00100220 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  100220:	f3 0f 1e fb          	endbr32 
  100224:	55                   	push   %ebp
  100225:	89 e5                	mov    %esp,%ebp
  100227:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
  10022a:	83 ec 0c             	sub    $0xc,%esp
  10022d:	ff 75 08             	pushl  0x8(%ebp)
  100230:	e8 2d 14 00 00       	call   101662 <cons_putc>
  100235:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
  100238:	8b 45 0c             	mov    0xc(%ebp),%eax
  10023b:	8b 00                	mov    (%eax),%eax
  10023d:	8d 50 01             	lea    0x1(%eax),%edx
  100240:	8b 45 0c             	mov    0xc(%ebp),%eax
  100243:	89 10                	mov    %edx,(%eax)
}
  100245:	90                   	nop
  100246:	c9                   	leave  
  100247:	c3                   	ret    

00100248 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  100248:	f3 0f 1e fb          	endbr32 
  10024c:	55                   	push   %ebp
  10024d:	89 e5                	mov    %esp,%ebp
  10024f:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  100252:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100259:	ff 75 0c             	pushl  0xc(%ebp)
  10025c:	ff 75 08             	pushl  0x8(%ebp)
  10025f:	8d 45 f4             	lea    -0xc(%ebp),%eax
  100262:	50                   	push   %eax
  100263:	68 20 02 10 00       	push   $0x100220
  100268:	e8 0b 30 00 00       	call   103278 <vprintfmt>
  10026d:	83 c4 10             	add    $0x10,%esp
    return cnt;
  100270:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100273:	c9                   	leave  
  100274:	c3                   	ret    

00100275 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100275:	f3 0f 1e fb          	endbr32 
  100279:	55                   	push   %ebp
  10027a:	89 e5                	mov    %esp,%ebp
  10027c:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  10027f:	8d 45 0c             	lea    0xc(%ebp),%eax
  100282:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  100285:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100288:	83 ec 08             	sub    $0x8,%esp
  10028b:	50                   	push   %eax
  10028c:	ff 75 08             	pushl  0x8(%ebp)
  10028f:	e8 b4 ff ff ff       	call   100248 <vcprintf>
  100294:	83 c4 10             	add    $0x10,%esp
  100297:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10029a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10029d:	c9                   	leave  
  10029e:	c3                   	ret    

0010029f <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  10029f:	f3 0f 1e fb          	endbr32 
  1002a3:	55                   	push   %ebp
  1002a4:	89 e5                	mov    %esp,%ebp
  1002a6:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
  1002a9:	83 ec 0c             	sub    $0xc,%esp
  1002ac:	ff 75 08             	pushl  0x8(%ebp)
  1002af:	e8 ae 13 00 00       	call   101662 <cons_putc>
  1002b4:	83 c4 10             	add    $0x10,%esp
}
  1002b7:	90                   	nop
  1002b8:	c9                   	leave  
  1002b9:	c3                   	ret    

001002ba <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  1002ba:	f3 0f 1e fb          	endbr32 
  1002be:	55                   	push   %ebp
  1002bf:	89 e5                	mov    %esp,%ebp
  1002c1:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  1002c4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  1002cb:	eb 14                	jmp    1002e1 <cputs+0x27>
        cputch(c, &cnt);
  1002cd:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  1002d1:	83 ec 08             	sub    $0x8,%esp
  1002d4:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1002d7:	52                   	push   %edx
  1002d8:	50                   	push   %eax
  1002d9:	e8 42 ff ff ff       	call   100220 <cputch>
  1002de:	83 c4 10             	add    $0x10,%esp
    while ((c = *str ++) != '\0') {
  1002e1:	8b 45 08             	mov    0x8(%ebp),%eax
  1002e4:	8d 50 01             	lea    0x1(%eax),%edx
  1002e7:	89 55 08             	mov    %edx,0x8(%ebp)
  1002ea:	0f b6 00             	movzbl (%eax),%eax
  1002ed:	88 45 f7             	mov    %al,-0x9(%ebp)
  1002f0:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  1002f4:	75 d7                	jne    1002cd <cputs+0x13>
    }
    cputch('\n', &cnt);
  1002f6:	83 ec 08             	sub    $0x8,%esp
  1002f9:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1002fc:	50                   	push   %eax
  1002fd:	6a 0a                	push   $0xa
  1002ff:	e8 1c ff ff ff       	call   100220 <cputch>
  100304:	83 c4 10             	add    $0x10,%esp
    return cnt;
  100307:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  10030a:	c9                   	leave  
  10030b:	c3                   	ret    

0010030c <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  10030c:	f3 0f 1e fb          	endbr32 
  100310:	55                   	push   %ebp
  100311:	89 e5                	mov    %esp,%ebp
  100313:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  100316:	90                   	nop
  100317:	e8 7a 13 00 00       	call   101696 <cons_getc>
  10031c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10031f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100323:	74 f2                	je     100317 <getchar+0xb>
        /* do nothing */;
    return c;
  100325:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100328:	c9                   	leave  
  100329:	c3                   	ret    

0010032a <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  10032a:	f3 0f 1e fb          	endbr32 
  10032e:	55                   	push   %ebp
  10032f:	89 e5                	mov    %esp,%ebp
  100331:	83 ec 18             	sub    $0x18,%esp
    if (prompt != NULL) {
  100334:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100338:	74 13                	je     10034d <readline+0x23>
        cprintf("%s", prompt);
  10033a:	83 ec 08             	sub    $0x8,%esp
  10033d:	ff 75 08             	pushl  0x8(%ebp)
  100340:	68 a7 37 10 00       	push   $0x1037a7
  100345:	e8 2b ff ff ff       	call   100275 <cprintf>
  10034a:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
  10034d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  100354:	e8 b3 ff ff ff       	call   10030c <getchar>
  100359:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  10035c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100360:	79 0a                	jns    10036c <readline+0x42>
            return NULL;
  100362:	b8 00 00 00 00       	mov    $0x0,%eax
  100367:	e9 82 00 00 00       	jmp    1003ee <readline+0xc4>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  10036c:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100370:	7e 2b                	jle    10039d <readline+0x73>
  100372:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100379:	7f 22                	jg     10039d <readline+0x73>
            cputchar(c);
  10037b:	83 ec 0c             	sub    $0xc,%esp
  10037e:	ff 75 f0             	pushl  -0x10(%ebp)
  100381:	e8 19 ff ff ff       	call   10029f <cputchar>
  100386:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
  100389:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10038c:	8d 50 01             	lea    0x1(%eax),%edx
  10038f:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100392:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100395:	88 90 40 fa 10 00    	mov    %dl,0x10fa40(%eax)
  10039b:	eb 4c                	jmp    1003e9 <readline+0xbf>
        }
        else if (c == '\b' && i > 0) {
  10039d:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  1003a1:	75 1a                	jne    1003bd <readline+0x93>
  1003a3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003a7:	7e 14                	jle    1003bd <readline+0x93>
            cputchar(c);
  1003a9:	83 ec 0c             	sub    $0xc,%esp
  1003ac:	ff 75 f0             	pushl  -0x10(%ebp)
  1003af:	e8 eb fe ff ff       	call   10029f <cputchar>
  1003b4:	83 c4 10             	add    $0x10,%esp
            i --;
  1003b7:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  1003bb:	eb 2c                	jmp    1003e9 <readline+0xbf>
        }
        else if (c == '\n' || c == '\r') {
  1003bd:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1003c1:	74 06                	je     1003c9 <readline+0x9f>
  1003c3:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1003c7:	75 8b                	jne    100354 <readline+0x2a>
            cputchar(c);
  1003c9:	83 ec 0c             	sub    $0xc,%esp
  1003cc:	ff 75 f0             	pushl  -0x10(%ebp)
  1003cf:	e8 cb fe ff ff       	call   10029f <cputchar>
  1003d4:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
  1003d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003da:	05 40 fa 10 00       	add    $0x10fa40,%eax
  1003df:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1003e2:	b8 40 fa 10 00       	mov    $0x10fa40,%eax
  1003e7:	eb 05                	jmp    1003ee <readline+0xc4>
        c = getchar();
  1003e9:	e9 66 ff ff ff       	jmp    100354 <readline+0x2a>
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
  1003f7:	83 ec 18             	sub    $0x18,%esp
    if (is_panic) {
  1003fa:	a1 40 fe 10 00       	mov    0x10fe40,%eax
  1003ff:	85 c0                	test   %eax,%eax
  100401:	75 5f                	jne    100462 <__panic+0x72>
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
  100413:	83 ec 04             	sub    $0x4,%esp
  100416:	ff 75 0c             	pushl  0xc(%ebp)
  100419:	ff 75 08             	pushl  0x8(%ebp)
  10041c:	68 aa 37 10 00       	push   $0x1037aa
  100421:	e8 4f fe ff ff       	call   100275 <cprintf>
  100426:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  100429:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10042c:	83 ec 08             	sub    $0x8,%esp
  10042f:	50                   	push   %eax
  100430:	ff 75 10             	pushl  0x10(%ebp)
  100433:	e8 10 fe ff ff       	call   100248 <vcprintf>
  100438:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  10043b:	83 ec 0c             	sub    $0xc,%esp
  10043e:	68 c6 37 10 00       	push   $0x1037c6
  100443:	e8 2d fe ff ff       	call   100275 <cprintf>
  100448:	83 c4 10             	add    $0x10,%esp
    
    cprintf("stack trackback:\n");
  10044b:	83 ec 0c             	sub    $0xc,%esp
  10044e:	68 c8 37 10 00       	push   $0x1037c8
  100453:	e8 1d fe ff ff       	call   100275 <cprintf>
  100458:	83 c4 10             	add    $0x10,%esp
    print_stackframe();
  10045b:	e8 25 06 00 00       	call   100a85 <print_stackframe>
  100460:	eb 01                	jmp    100463 <__panic+0x73>
        goto panic_dead;
  100462:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  100463:	e8 79 14 00 00       	call   1018e1 <intr_disable>
    while (1) {
        kmonitor(NULL);
  100468:	83 ec 0c             	sub    $0xc,%esp
  10046b:	6a 00                	push   $0x0
  10046d:	e8 44 08 00 00       	call   100cb6 <kmonitor>
  100472:	83 c4 10             	add    $0x10,%esp
  100475:	eb f1                	jmp    100468 <__panic+0x78>

00100477 <__warn>:
    }
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100477:	f3 0f 1e fb          	endbr32 
  10047b:	55                   	push   %ebp
  10047c:	89 e5                	mov    %esp,%ebp
  10047e:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    va_start(ap, fmt);
  100481:	8d 45 14             	lea    0x14(%ebp),%eax
  100484:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100487:	83 ec 04             	sub    $0x4,%esp
  10048a:	ff 75 0c             	pushl  0xc(%ebp)
  10048d:	ff 75 08             	pushl  0x8(%ebp)
  100490:	68 da 37 10 00       	push   $0x1037da
  100495:	e8 db fd ff ff       	call   100275 <cprintf>
  10049a:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  10049d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1004a0:	83 ec 08             	sub    $0x8,%esp
  1004a3:	50                   	push   %eax
  1004a4:	ff 75 10             	pushl  0x10(%ebp)
  1004a7:	e8 9c fd ff ff       	call   100248 <vcprintf>
  1004ac:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  1004af:	83 ec 0c             	sub    $0xc,%esp
  1004b2:	68 c6 37 10 00       	push   $0x1037c6
  1004b7:	e8 b9 fd ff ff       	call   100275 <cprintf>
  1004bc:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  1004bf:	90                   	nop
  1004c0:	c9                   	leave  
  1004c1:	c3                   	ret    

001004c2 <is_kernel_panic>:

bool
is_kernel_panic(void) {
  1004c2:	f3 0f 1e fb          	endbr32 
  1004c6:	55                   	push   %ebp
  1004c7:	89 e5                	mov    %esp,%ebp
    return is_panic;
  1004c9:	a1 40 fe 10 00       	mov    0x10fe40,%eax
}
  1004ce:	5d                   	pop    %ebp
  1004cf:	c3                   	ret    

001004d0 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1004d0:	f3 0f 1e fb          	endbr32 
  1004d4:	55                   	push   %ebp
  1004d5:	89 e5                	mov    %esp,%ebp
  1004d7:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1004da:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004dd:	8b 00                	mov    (%eax),%eax
  1004df:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1004e2:	8b 45 10             	mov    0x10(%ebp),%eax
  1004e5:	8b 00                	mov    (%eax),%eax
  1004e7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1004f1:	e9 d2 00 00 00       	jmp    1005c8 <stab_binsearch+0xf8>
        int true_m = (l + r) / 2, m = true_m;
  1004f6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1004fc:	01 d0                	add    %edx,%eax
  1004fe:	89 c2                	mov    %eax,%edx
  100500:	c1 ea 1f             	shr    $0x1f,%edx
  100503:	01 d0                	add    %edx,%eax
  100505:	d1 f8                	sar    %eax
  100507:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10050a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10050d:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100510:	eb 04                	jmp    100516 <stab_binsearch+0x46>
            m --;
  100512:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  100516:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100519:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10051c:	7c 1f                	jl     10053d <stab_binsearch+0x6d>
  10051e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100521:	89 d0                	mov    %edx,%eax
  100523:	01 c0                	add    %eax,%eax
  100525:	01 d0                	add    %edx,%eax
  100527:	c1 e0 02             	shl    $0x2,%eax
  10052a:	89 c2                	mov    %eax,%edx
  10052c:	8b 45 08             	mov    0x8(%ebp),%eax
  10052f:	01 d0                	add    %edx,%eax
  100531:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100535:	0f b6 c0             	movzbl %al,%eax
  100538:	39 45 14             	cmp    %eax,0x14(%ebp)
  10053b:	75 d5                	jne    100512 <stab_binsearch+0x42>
        }
        if (m < l) {    // no match in [l, m]
  10053d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100540:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100543:	7d 0b                	jge    100550 <stab_binsearch+0x80>
            l = true_m + 1;
  100545:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100548:	83 c0 01             	add    $0x1,%eax
  10054b:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  10054e:	eb 78                	jmp    1005c8 <stab_binsearch+0xf8>
        }

        // actual binary search
        any_matches = 1;
  100550:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100557:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10055a:	89 d0                	mov    %edx,%eax
  10055c:	01 c0                	add    %eax,%eax
  10055e:	01 d0                	add    %edx,%eax
  100560:	c1 e0 02             	shl    $0x2,%eax
  100563:	89 c2                	mov    %eax,%edx
  100565:	8b 45 08             	mov    0x8(%ebp),%eax
  100568:	01 d0                	add    %edx,%eax
  10056a:	8b 40 08             	mov    0x8(%eax),%eax
  10056d:	39 45 18             	cmp    %eax,0x18(%ebp)
  100570:	76 13                	jbe    100585 <stab_binsearch+0xb5>
            *region_left = m;
  100572:	8b 45 0c             	mov    0xc(%ebp),%eax
  100575:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100578:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  10057a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10057d:	83 c0 01             	add    $0x1,%eax
  100580:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100583:	eb 43                	jmp    1005c8 <stab_binsearch+0xf8>
        } else if (stabs[m].n_value > addr) {
  100585:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100588:	89 d0                	mov    %edx,%eax
  10058a:	01 c0                	add    %eax,%eax
  10058c:	01 d0                	add    %edx,%eax
  10058e:	c1 e0 02             	shl    $0x2,%eax
  100591:	89 c2                	mov    %eax,%edx
  100593:	8b 45 08             	mov    0x8(%ebp),%eax
  100596:	01 d0                	add    %edx,%eax
  100598:	8b 40 08             	mov    0x8(%eax),%eax
  10059b:	39 45 18             	cmp    %eax,0x18(%ebp)
  10059e:	73 16                	jae    1005b6 <stab_binsearch+0xe6>
            *region_right = m - 1;
  1005a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005a3:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005a6:	8b 45 10             	mov    0x10(%ebp),%eax
  1005a9:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  1005ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005ae:	83 e8 01             	sub    $0x1,%eax
  1005b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1005b4:	eb 12                	jmp    1005c8 <stab_binsearch+0xf8>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1005b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005b9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1005bc:	89 10                	mov    %edx,(%eax)
            l = m;
  1005be:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1005c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1005c4:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
  1005c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1005cb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1005ce:	0f 8e 22 ff ff ff    	jle    1004f6 <stab_binsearch+0x26>
        }
    }

    if (!any_matches) {
  1005d4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1005d8:	75 0f                	jne    1005e9 <stab_binsearch+0x119>
        *region_right = *region_left - 1;
  1005da:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005dd:	8b 00                	mov    (%eax),%eax
  1005df:	8d 50 ff             	lea    -0x1(%eax),%edx
  1005e2:	8b 45 10             	mov    0x10(%ebp),%eax
  1005e5:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  1005e7:	eb 3f                	jmp    100628 <stab_binsearch+0x158>
        l = *region_right;
  1005e9:	8b 45 10             	mov    0x10(%ebp),%eax
  1005ec:	8b 00                	mov    (%eax),%eax
  1005ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1005f1:	eb 04                	jmp    1005f7 <stab_binsearch+0x127>
  1005f3:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1005f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005fa:	8b 00                	mov    (%eax),%eax
  1005fc:	39 45 fc             	cmp    %eax,-0x4(%ebp)
  1005ff:	7e 1f                	jle    100620 <stab_binsearch+0x150>
  100601:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100604:	89 d0                	mov    %edx,%eax
  100606:	01 c0                	add    %eax,%eax
  100608:	01 d0                	add    %edx,%eax
  10060a:	c1 e0 02             	shl    $0x2,%eax
  10060d:	89 c2                	mov    %eax,%edx
  10060f:	8b 45 08             	mov    0x8(%ebp),%eax
  100612:	01 d0                	add    %edx,%eax
  100614:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100618:	0f b6 c0             	movzbl %al,%eax
  10061b:	39 45 14             	cmp    %eax,0x14(%ebp)
  10061e:	75 d3                	jne    1005f3 <stab_binsearch+0x123>
        *region_left = l;
  100620:	8b 45 0c             	mov    0xc(%ebp),%eax
  100623:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100626:	89 10                	mov    %edx,(%eax)
}
  100628:	90                   	nop
  100629:	c9                   	leave  
  10062a:	c3                   	ret    

0010062b <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  10062b:	f3 0f 1e fb          	endbr32 
  10062f:	55                   	push   %ebp
  100630:	89 e5                	mov    %esp,%ebp
  100632:	83 ec 38             	sub    $0x38,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  100635:	8b 45 0c             	mov    0xc(%ebp),%eax
  100638:	c7 00 f8 37 10 00    	movl   $0x1037f8,(%eax)
    info->eip_line = 0;
  10063e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100641:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100648:	8b 45 0c             	mov    0xc(%ebp),%eax
  10064b:	c7 40 08 f8 37 10 00 	movl   $0x1037f8,0x8(%eax)
    info->eip_fn_namelen = 9;
  100652:	8b 45 0c             	mov    0xc(%ebp),%eax
  100655:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  10065c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10065f:	8b 55 08             	mov    0x8(%ebp),%edx
  100662:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100665:	8b 45 0c             	mov    0xc(%ebp),%eax
  100668:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  10066f:	c7 45 f4 2c 40 10 00 	movl   $0x10402c,-0xc(%ebp)
    stab_end = __STAB_END__;
  100676:	c7 45 f0 a0 ce 10 00 	movl   $0x10cea0,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  10067d:	c7 45 ec a1 ce 10 00 	movl   $0x10cea1,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100684:	c7 45 e8 9c ef 10 00 	movl   $0x10ef9c,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  10068b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10068e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100691:	76 0d                	jbe    1006a0 <debuginfo_eip+0x75>
  100693:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100696:	83 e8 01             	sub    $0x1,%eax
  100699:	0f b6 00             	movzbl (%eax),%eax
  10069c:	84 c0                	test   %al,%al
  10069e:	74 0a                	je     1006aa <debuginfo_eip+0x7f>
        return -1;
  1006a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006a5:	e9 85 02 00 00       	jmp    10092f <debuginfo_eip+0x304>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  1006aa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  1006b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1006b4:	2b 45 f4             	sub    -0xc(%ebp),%eax
  1006b7:	c1 f8 02             	sar    $0x2,%eax
  1006ba:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1006c0:	83 e8 01             	sub    $0x1,%eax
  1006c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1006c6:	ff 75 08             	pushl  0x8(%ebp)
  1006c9:	6a 64                	push   $0x64
  1006cb:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1006ce:	50                   	push   %eax
  1006cf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1006d2:	50                   	push   %eax
  1006d3:	ff 75 f4             	pushl  -0xc(%ebp)
  1006d6:	e8 f5 fd ff ff       	call   1004d0 <stab_binsearch>
  1006db:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
  1006de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006e1:	85 c0                	test   %eax,%eax
  1006e3:	75 0a                	jne    1006ef <debuginfo_eip+0xc4>
        return -1;
  1006e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1006ea:	e9 40 02 00 00       	jmp    10092f <debuginfo_eip+0x304>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1006ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006f2:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1006f5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006f8:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1006fb:	ff 75 08             	pushl  0x8(%ebp)
  1006fe:	6a 24                	push   $0x24
  100700:	8d 45 d8             	lea    -0x28(%ebp),%eax
  100703:	50                   	push   %eax
  100704:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100707:	50                   	push   %eax
  100708:	ff 75 f4             	pushl  -0xc(%ebp)
  10070b:	e8 c0 fd ff ff       	call   1004d0 <stab_binsearch>
  100710:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
  100713:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100716:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100719:	39 c2                	cmp    %eax,%edx
  10071b:	7f 78                	jg     100795 <debuginfo_eip+0x16a>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  10071d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100720:	89 c2                	mov    %eax,%edx
  100722:	89 d0                	mov    %edx,%eax
  100724:	01 c0                	add    %eax,%eax
  100726:	01 d0                	add    %edx,%eax
  100728:	c1 e0 02             	shl    $0x2,%eax
  10072b:	89 c2                	mov    %eax,%edx
  10072d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100730:	01 d0                	add    %edx,%eax
  100732:	8b 10                	mov    (%eax),%edx
  100734:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100737:	2b 45 ec             	sub    -0x14(%ebp),%eax
  10073a:	39 c2                	cmp    %eax,%edx
  10073c:	73 22                	jae    100760 <debuginfo_eip+0x135>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  10073e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100741:	89 c2                	mov    %eax,%edx
  100743:	89 d0                	mov    %edx,%eax
  100745:	01 c0                	add    %eax,%eax
  100747:	01 d0                	add    %edx,%eax
  100749:	c1 e0 02             	shl    $0x2,%eax
  10074c:	89 c2                	mov    %eax,%edx
  10074e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100751:	01 d0                	add    %edx,%eax
  100753:	8b 10                	mov    (%eax),%edx
  100755:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100758:	01 c2                	add    %eax,%edx
  10075a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10075d:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100760:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100763:	89 c2                	mov    %eax,%edx
  100765:	89 d0                	mov    %edx,%eax
  100767:	01 c0                	add    %eax,%eax
  100769:	01 d0                	add    %edx,%eax
  10076b:	c1 e0 02             	shl    $0x2,%eax
  10076e:	89 c2                	mov    %eax,%edx
  100770:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100773:	01 d0                	add    %edx,%eax
  100775:	8b 50 08             	mov    0x8(%eax),%edx
  100778:	8b 45 0c             	mov    0xc(%ebp),%eax
  10077b:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  10077e:	8b 45 0c             	mov    0xc(%ebp),%eax
  100781:	8b 40 10             	mov    0x10(%eax),%eax
  100784:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  100787:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10078a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  10078d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100790:	89 45 d0             	mov    %eax,-0x30(%ebp)
  100793:	eb 15                	jmp    1007aa <debuginfo_eip+0x17f>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  100795:	8b 45 0c             	mov    0xc(%ebp),%eax
  100798:	8b 55 08             	mov    0x8(%ebp),%edx
  10079b:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  10079e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007a1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1007a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1007a7:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1007aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007ad:	8b 40 08             	mov    0x8(%eax),%eax
  1007b0:	83 ec 08             	sub    $0x8,%esp
  1007b3:	6a 3a                	push   $0x3a
  1007b5:	50                   	push   %eax
  1007b6:	e8 da 25 00 00       	call   102d95 <strfind>
  1007bb:	83 c4 10             	add    $0x10,%esp
  1007be:	8b 55 0c             	mov    0xc(%ebp),%edx
  1007c1:	8b 52 08             	mov    0x8(%edx),%edx
  1007c4:	29 d0                	sub    %edx,%eax
  1007c6:	89 c2                	mov    %eax,%edx
  1007c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007cb:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1007ce:	83 ec 0c             	sub    $0xc,%esp
  1007d1:	ff 75 08             	pushl  0x8(%ebp)
  1007d4:	6a 44                	push   $0x44
  1007d6:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1007d9:	50                   	push   %eax
  1007da:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1007dd:	50                   	push   %eax
  1007de:	ff 75 f4             	pushl  -0xc(%ebp)
  1007e1:	e8 ea fc ff ff       	call   1004d0 <stab_binsearch>
  1007e6:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
  1007e9:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007ec:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1007ef:	39 c2                	cmp    %eax,%edx
  1007f1:	7f 24                	jg     100817 <debuginfo_eip+0x1ec>
        info->eip_line = stabs[rline].n_desc;
  1007f3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1007f6:	89 c2                	mov    %eax,%edx
  1007f8:	89 d0                	mov    %edx,%eax
  1007fa:	01 c0                	add    %eax,%eax
  1007fc:	01 d0                	add    %edx,%eax
  1007fe:	c1 e0 02             	shl    $0x2,%eax
  100801:	89 c2                	mov    %eax,%edx
  100803:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100806:	01 d0                	add    %edx,%eax
  100808:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  10080c:	0f b7 d0             	movzwl %ax,%edx
  10080f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100812:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100815:	eb 13                	jmp    10082a <debuginfo_eip+0x1ff>
        return -1;
  100817:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10081c:	e9 0e 01 00 00       	jmp    10092f <debuginfo_eip+0x304>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100821:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100824:	83 e8 01             	sub    $0x1,%eax
  100827:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  10082a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10082d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100830:	39 c2                	cmp    %eax,%edx
  100832:	7c 56                	jl     10088a <debuginfo_eip+0x25f>
           && stabs[lline].n_type != N_SOL
  100834:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100837:	89 c2                	mov    %eax,%edx
  100839:	89 d0                	mov    %edx,%eax
  10083b:	01 c0                	add    %eax,%eax
  10083d:	01 d0                	add    %edx,%eax
  10083f:	c1 e0 02             	shl    $0x2,%eax
  100842:	89 c2                	mov    %eax,%edx
  100844:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100847:	01 d0                	add    %edx,%eax
  100849:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10084d:	3c 84                	cmp    $0x84,%al
  10084f:	74 39                	je     10088a <debuginfo_eip+0x25f>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100851:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100854:	89 c2                	mov    %eax,%edx
  100856:	89 d0                	mov    %edx,%eax
  100858:	01 c0                	add    %eax,%eax
  10085a:	01 d0                	add    %edx,%eax
  10085c:	c1 e0 02             	shl    $0x2,%eax
  10085f:	89 c2                	mov    %eax,%edx
  100861:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100864:	01 d0                	add    %edx,%eax
  100866:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10086a:	3c 64                	cmp    $0x64,%al
  10086c:	75 b3                	jne    100821 <debuginfo_eip+0x1f6>
  10086e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100871:	89 c2                	mov    %eax,%edx
  100873:	89 d0                	mov    %edx,%eax
  100875:	01 c0                	add    %eax,%eax
  100877:	01 d0                	add    %edx,%eax
  100879:	c1 e0 02             	shl    $0x2,%eax
  10087c:	89 c2                	mov    %eax,%edx
  10087e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100881:	01 d0                	add    %edx,%eax
  100883:	8b 40 08             	mov    0x8(%eax),%eax
  100886:	85 c0                	test   %eax,%eax
  100888:	74 97                	je     100821 <debuginfo_eip+0x1f6>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  10088a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10088d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100890:	39 c2                	cmp    %eax,%edx
  100892:	7c 42                	jl     1008d6 <debuginfo_eip+0x2ab>
  100894:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100897:	89 c2                	mov    %eax,%edx
  100899:	89 d0                	mov    %edx,%eax
  10089b:	01 c0                	add    %eax,%eax
  10089d:	01 d0                	add    %edx,%eax
  10089f:	c1 e0 02             	shl    $0x2,%eax
  1008a2:	89 c2                	mov    %eax,%edx
  1008a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008a7:	01 d0                	add    %edx,%eax
  1008a9:	8b 10                	mov    (%eax),%edx
  1008ab:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1008ae:	2b 45 ec             	sub    -0x14(%ebp),%eax
  1008b1:	39 c2                	cmp    %eax,%edx
  1008b3:	73 21                	jae    1008d6 <debuginfo_eip+0x2ab>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1008b5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008b8:	89 c2                	mov    %eax,%edx
  1008ba:	89 d0                	mov    %edx,%eax
  1008bc:	01 c0                	add    %eax,%eax
  1008be:	01 d0                	add    %edx,%eax
  1008c0:	c1 e0 02             	shl    $0x2,%eax
  1008c3:	89 c2                	mov    %eax,%edx
  1008c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008c8:	01 d0                	add    %edx,%eax
  1008ca:	8b 10                	mov    (%eax),%edx
  1008cc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1008cf:	01 c2                	add    %eax,%edx
  1008d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008d4:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1008d6:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1008d9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1008dc:	39 c2                	cmp    %eax,%edx
  1008de:	7d 4a                	jge    10092a <debuginfo_eip+0x2ff>
        for (lline = lfun + 1;
  1008e0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1008e3:	83 c0 01             	add    $0x1,%eax
  1008e6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1008e9:	eb 18                	jmp    100903 <debuginfo_eip+0x2d8>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  1008eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008ee:	8b 40 14             	mov    0x14(%eax),%eax
  1008f1:	8d 50 01             	lea    0x1(%eax),%edx
  1008f4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008f7:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  1008fa:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008fd:	83 c0 01             	add    $0x1,%eax
  100900:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100903:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100906:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  100909:	39 c2                	cmp    %eax,%edx
  10090b:	7d 1d                	jge    10092a <debuginfo_eip+0x2ff>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  10090d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100910:	89 c2                	mov    %eax,%edx
  100912:	89 d0                	mov    %edx,%eax
  100914:	01 c0                	add    %eax,%eax
  100916:	01 d0                	add    %edx,%eax
  100918:	c1 e0 02             	shl    $0x2,%eax
  10091b:	89 c2                	mov    %eax,%edx
  10091d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100920:	01 d0                	add    %edx,%eax
  100922:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100926:	3c a0                	cmp    $0xa0,%al
  100928:	74 c1                	je     1008eb <debuginfo_eip+0x2c0>
        }
    }
    return 0;
  10092a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10092f:	c9                   	leave  
  100930:	c3                   	ret    

00100931 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100931:	f3 0f 1e fb          	endbr32 
  100935:	55                   	push   %ebp
  100936:	89 e5                	mov    %esp,%ebp
  100938:	83 ec 08             	sub    $0x8,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  10093b:	83 ec 0c             	sub    $0xc,%esp
  10093e:	68 02 38 10 00       	push   $0x103802
  100943:	e8 2d f9 ff ff       	call   100275 <cprintf>
  100948:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  10094b:	83 ec 08             	sub    $0x8,%esp
  10094e:	68 00 00 10 00       	push   $0x100000
  100953:	68 1b 38 10 00       	push   $0x10381b
  100958:	e8 18 f9 ff ff       	call   100275 <cprintf>
  10095d:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
  100960:	83 ec 08             	sub    $0x8,%esp
  100963:	68 ea 36 10 00       	push   $0x1036ea
  100968:	68 33 38 10 00       	push   $0x103833
  10096d:	e8 03 f9 ff ff       	call   100275 <cprintf>
  100972:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
  100975:	83 ec 08             	sub    $0x8,%esp
  100978:	68 16 fa 10 00       	push   $0x10fa16
  10097d:	68 4b 38 10 00       	push   $0x10384b
  100982:	e8 ee f8 ff ff       	call   100275 <cprintf>
  100987:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
  10098a:	83 ec 08             	sub    $0x8,%esp
  10098d:	68 80 0d 11 00       	push   $0x110d80
  100992:	68 63 38 10 00       	push   $0x103863
  100997:	e8 d9 f8 ff ff       	call   100275 <cprintf>
  10099c:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  10099f:	b8 80 0d 11 00       	mov    $0x110d80,%eax
  1009a4:	2d 00 00 10 00       	sub    $0x100000,%eax
  1009a9:	05 ff 03 00 00       	add    $0x3ff,%eax
  1009ae:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1009b4:	85 c0                	test   %eax,%eax
  1009b6:	0f 48 c2             	cmovs  %edx,%eax
  1009b9:	c1 f8 0a             	sar    $0xa,%eax
  1009bc:	83 ec 08             	sub    $0x8,%esp
  1009bf:	50                   	push   %eax
  1009c0:	68 7c 38 10 00       	push   $0x10387c
  1009c5:	e8 ab f8 ff ff       	call   100275 <cprintf>
  1009ca:	83 c4 10             	add    $0x10,%esp
}
  1009cd:	90                   	nop
  1009ce:	c9                   	leave  
  1009cf:	c3                   	ret    

001009d0 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1009d0:	f3 0f 1e fb          	endbr32 
  1009d4:	55                   	push   %ebp
  1009d5:	89 e5                	mov    %esp,%ebp
  1009d7:	81 ec 28 01 00 00    	sub    $0x128,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1009dd:	83 ec 08             	sub    $0x8,%esp
  1009e0:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1009e3:	50                   	push   %eax
  1009e4:	ff 75 08             	pushl  0x8(%ebp)
  1009e7:	e8 3f fc ff ff       	call   10062b <debuginfo_eip>
  1009ec:	83 c4 10             	add    $0x10,%esp
  1009ef:	85 c0                	test   %eax,%eax
  1009f1:	74 15                	je     100a08 <print_debuginfo+0x38>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  1009f3:	83 ec 08             	sub    $0x8,%esp
  1009f6:	ff 75 08             	pushl  0x8(%ebp)
  1009f9:	68 a6 38 10 00       	push   $0x1038a6
  1009fe:	e8 72 f8 ff ff       	call   100275 <cprintf>
  100a03:	83 c4 10             	add    $0x10,%esp
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  100a06:	eb 65                	jmp    100a6d <print_debuginfo+0x9d>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a08:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100a0f:	eb 1c                	jmp    100a2d <print_debuginfo+0x5d>
            fnname[j] = info.eip_fn_name[j];
  100a11:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  100a14:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a17:	01 d0                	add    %edx,%eax
  100a19:	0f b6 00             	movzbl (%eax),%eax
  100a1c:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a22:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100a25:	01 ca                	add    %ecx,%edx
  100a27:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100a29:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100a2d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100a30:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  100a33:	7c dc                	jl     100a11 <print_debuginfo+0x41>
        fnname[j] = '\0';
  100a35:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100a3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a3e:	01 d0                	add    %edx,%eax
  100a40:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  100a43:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  100a46:	8b 55 08             	mov    0x8(%ebp),%edx
  100a49:	89 d1                	mov    %edx,%ecx
  100a4b:	29 c1                	sub    %eax,%ecx
  100a4d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100a50:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a53:	83 ec 0c             	sub    $0xc,%esp
  100a56:	51                   	push   %ecx
  100a57:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a5d:	51                   	push   %ecx
  100a5e:	52                   	push   %edx
  100a5f:	50                   	push   %eax
  100a60:	68 c2 38 10 00       	push   $0x1038c2
  100a65:	e8 0b f8 ff ff       	call   100275 <cprintf>
  100a6a:	83 c4 20             	add    $0x20,%esp
}
  100a6d:	90                   	nop
  100a6e:	c9                   	leave  
  100a6f:	c3                   	ret    

00100a70 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100a70:	f3 0f 1e fb          	endbr32 
  100a74:	55                   	push   %ebp
  100a75:	89 e5                	mov    %esp,%ebp
  100a77:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100a7a:	8b 45 04             	mov    0x4(%ebp),%eax
  100a7d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100a80:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100a83:	c9                   	leave  
  100a84:	c3                   	ret    

00100a85 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100a85:	f3 0f 1e fb          	endbr32 
  100a89:	55                   	push   %ebp
  100a8a:	89 e5                	mov    %esp,%ebp
  100a8c:	83 ec 28             	sub    $0x28,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100a8f:	89 e8                	mov    %ebp,%eax
  100a91:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    return ebp;
  100a94:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
    uint32_t ebp=read_ebp();   //调用read ebp访问当前ebp的值，数据类型为32位。
  100a97:	89 45 f4             	mov    %eax,-0xc(%ebp)
	uint32_t eip=read_eip();   //调用read eip访问eip的值，数据类型同。
  100a9a:	e8 d1 ff ff ff       	call   100a70 <read_eip>
  100a9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int i;   //这里有个细节问题，就是不能for int i，这里面的C标准似乎不允许
	for(i=0;i<STACKFRAME_DEPTH&&ebp!=0;i++)
  100aa2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100aa9:	e9 85 00 00 00       	jmp    100b33 <print_stackframe+0xae>
	{
		//(3) from 0 .. STACKFRAME_DEPTH
		cprintf("ebp:0x%08x eip:0x%08x ",ebp,eip);//(3.1)printf value of ebp, eip
  100aae:	83 ec 04             	sub    $0x4,%esp
  100ab1:	ff 75 f0             	pushl  -0x10(%ebp)
  100ab4:	ff 75 f4             	pushl  -0xc(%ebp)
  100ab7:	68 d4 38 10 00       	push   $0x1038d4
  100abc:	e8 b4 f7 ff ff       	call   100275 <cprintf>
  100ac1:	83 c4 10             	add    $0x10,%esp
		for(int j=0;j<4;j++){
  100ac4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  100acb:	eb 27                	jmp    100af4 <print_stackframe+0x6f>
            	cprintf("0x%08x ",((uint32_t*)ebp+2+j));
  100acd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100ad0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100ad7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ada:	01 d0                	add    %edx,%eax
  100adc:	83 c0 08             	add    $0x8,%eax
  100adf:	83 ec 08             	sub    $0x8,%esp
  100ae2:	50                   	push   %eax
  100ae3:	68 eb 38 10 00       	push   $0x1038eb
  100ae8:	e8 88 f7 ff ff       	call   100275 <cprintf>
  100aed:	83 c4 10             	add    $0x10,%esp
		for(int j=0;j<4;j++){
  100af0:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  100af4:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100af8:	7e d3                	jle    100acd <print_stackframe+0x48>
        }
		cprintf("\n");
  100afa:	83 ec 0c             	sub    $0xc,%esp
  100afd:	68 f3 38 10 00       	push   $0x1038f3
  100b02:	e8 6e f7 ff ff       	call   100275 <cprintf>
  100b07:	83 c4 10             	add    $0x10,%esp
 
		//因为使用的是栈数据结构，因此可以直接根据ebp就能读取到各个栈帧的地址和值，ebp+4处为返回地址，ebp+8处为第一个参数值（最后一个入栈的参数值，对应32位系统），ebp-4处为第一个局部变量，ebp处为上一层 ebp 值。
 
		//而这里，*代表指针，指针也是占用4个字节，因此可以直接对于指针加一，地址加4。
 
		print_debuginfo(eip-1);	//打印eip以及ebp相关的信息
  100b0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100b0d:	83 e8 01             	sub    $0x1,%eax
  100b10:	83 ec 0c             	sub    $0xc,%esp
  100b13:	50                   	push   %eax
  100b14:	e8 b7 fe ff ff       	call   1009d0 <print_debuginfo>
  100b19:	83 c4 10             	add    $0x10,%esp
		eip=*((uint32_t *)ebp+1);//此时eip指向了返回地址
  100b1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b1f:	83 c0 04             	add    $0x4,%eax
  100b22:	8b 00                	mov    (%eax),%eax
  100b24:	89 45 f0             	mov    %eax,-0x10(%ebp)
		ebp=*((uint32_t *)ebp+0);//ebp指向了原ebp的位置
  100b27:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b2a:	8b 00                	mov    (%eax),%eax
  100b2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	for(i=0;i<STACKFRAME_DEPTH&&ebp!=0;i++)
  100b2f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  100b33:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100b37:	7f 0a                	jg     100b43 <print_stackframe+0xbe>
  100b39:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100b3d:	0f 85 6b ff ff ff    	jne    100aae <print_stackframe+0x29>
//最后更新ebp：ebp=ebp[0],更新eip：eip=ebp[1]，因为ebp[0]=ebp，ebp[1]=ebp[0]+4=eip。
	}
}
  100b43:	90                   	nop
  100b44:	c9                   	leave  
  100b45:	c3                   	ret    

00100b46 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100b46:	f3 0f 1e fb          	endbr32 
  100b4a:	55                   	push   %ebp
  100b4b:	89 e5                	mov    %esp,%ebp
  100b4d:	83 ec 18             	sub    $0x18,%esp
    int argc = 0;
  100b50:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b57:	eb 0c                	jmp    100b65 <parse+0x1f>
            *buf ++ = '\0';
  100b59:	8b 45 08             	mov    0x8(%ebp),%eax
  100b5c:	8d 50 01             	lea    0x1(%eax),%edx
  100b5f:	89 55 08             	mov    %edx,0x8(%ebp)
  100b62:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b65:	8b 45 08             	mov    0x8(%ebp),%eax
  100b68:	0f b6 00             	movzbl (%eax),%eax
  100b6b:	84 c0                	test   %al,%al
  100b6d:	74 1e                	je     100b8d <parse+0x47>
  100b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  100b72:	0f b6 00             	movzbl (%eax),%eax
  100b75:	0f be c0             	movsbl %al,%eax
  100b78:	83 ec 08             	sub    $0x8,%esp
  100b7b:	50                   	push   %eax
  100b7c:	68 78 39 10 00       	push   $0x103978
  100b81:	e8 d8 21 00 00       	call   102d5e <strchr>
  100b86:	83 c4 10             	add    $0x10,%esp
  100b89:	85 c0                	test   %eax,%eax
  100b8b:	75 cc                	jne    100b59 <parse+0x13>
        }
        if (*buf == '\0') {
  100b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  100b90:	0f b6 00             	movzbl (%eax),%eax
  100b93:	84 c0                	test   %al,%al
  100b95:	74 65                	je     100bfc <parse+0xb6>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100b97:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100b9b:	75 12                	jne    100baf <parse+0x69>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100b9d:	83 ec 08             	sub    $0x8,%esp
  100ba0:	6a 10                	push   $0x10
  100ba2:	68 7d 39 10 00       	push   $0x10397d
  100ba7:	e8 c9 f6 ff ff       	call   100275 <cprintf>
  100bac:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
  100baf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bb2:	8d 50 01             	lea    0x1(%eax),%edx
  100bb5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100bb8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100bbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  100bc2:	01 c2                	add    %eax,%edx
  100bc4:	8b 45 08             	mov    0x8(%ebp),%eax
  100bc7:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bc9:	eb 04                	jmp    100bcf <parse+0x89>
            buf ++;
  100bcb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100bcf:	8b 45 08             	mov    0x8(%ebp),%eax
  100bd2:	0f b6 00             	movzbl (%eax),%eax
  100bd5:	84 c0                	test   %al,%al
  100bd7:	74 8c                	je     100b65 <parse+0x1f>
  100bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  100bdc:	0f b6 00             	movzbl (%eax),%eax
  100bdf:	0f be c0             	movsbl %al,%eax
  100be2:	83 ec 08             	sub    $0x8,%esp
  100be5:	50                   	push   %eax
  100be6:	68 78 39 10 00       	push   $0x103978
  100beb:	e8 6e 21 00 00       	call   102d5e <strchr>
  100bf0:	83 c4 10             	add    $0x10,%esp
  100bf3:	85 c0                	test   %eax,%eax
  100bf5:	74 d4                	je     100bcb <parse+0x85>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100bf7:	e9 69 ff ff ff       	jmp    100b65 <parse+0x1f>
            break;
  100bfc:	90                   	nop
        }
    }
    return argc;
  100bfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100c00:	c9                   	leave  
  100c01:	c3                   	ret    

00100c02 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100c02:	f3 0f 1e fb          	endbr32 
  100c06:	55                   	push   %ebp
  100c07:	89 e5                	mov    %esp,%ebp
  100c09:	83 ec 58             	sub    $0x58,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100c0c:	83 ec 08             	sub    $0x8,%esp
  100c0f:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c12:	50                   	push   %eax
  100c13:	ff 75 08             	pushl  0x8(%ebp)
  100c16:	e8 2b ff ff ff       	call   100b46 <parse>
  100c1b:	83 c4 10             	add    $0x10,%esp
  100c1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100c21:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100c25:	75 0a                	jne    100c31 <runcmd+0x2f>
        return 0;
  100c27:	b8 00 00 00 00       	mov    $0x0,%eax
  100c2c:	e9 83 00 00 00       	jmp    100cb4 <runcmd+0xb2>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c31:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c38:	eb 59                	jmp    100c93 <runcmd+0x91>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100c3a:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100c3d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c40:	89 d0                	mov    %edx,%eax
  100c42:	01 c0                	add    %eax,%eax
  100c44:	01 d0                	add    %edx,%eax
  100c46:	c1 e0 02             	shl    $0x2,%eax
  100c49:	05 00 f0 10 00       	add    $0x10f000,%eax
  100c4e:	8b 00                	mov    (%eax),%eax
  100c50:	83 ec 08             	sub    $0x8,%esp
  100c53:	51                   	push   %ecx
  100c54:	50                   	push   %eax
  100c55:	e8 5d 20 00 00       	call   102cb7 <strcmp>
  100c5a:	83 c4 10             	add    $0x10,%esp
  100c5d:	85 c0                	test   %eax,%eax
  100c5f:	75 2e                	jne    100c8f <runcmd+0x8d>
            return commands[i].func(argc - 1, argv + 1, tf);
  100c61:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c64:	89 d0                	mov    %edx,%eax
  100c66:	01 c0                	add    %eax,%eax
  100c68:	01 d0                	add    %edx,%eax
  100c6a:	c1 e0 02             	shl    $0x2,%eax
  100c6d:	05 08 f0 10 00       	add    $0x10f008,%eax
  100c72:	8b 10                	mov    (%eax),%edx
  100c74:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100c77:	83 c0 04             	add    $0x4,%eax
  100c7a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100c7d:	83 e9 01             	sub    $0x1,%ecx
  100c80:	83 ec 04             	sub    $0x4,%esp
  100c83:	ff 75 0c             	pushl  0xc(%ebp)
  100c86:	50                   	push   %eax
  100c87:	51                   	push   %ecx
  100c88:	ff d2                	call   *%edx
  100c8a:	83 c4 10             	add    $0x10,%esp
  100c8d:	eb 25                	jmp    100cb4 <runcmd+0xb2>
    for (i = 0; i < NCOMMANDS; i ++) {
  100c8f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100c93:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c96:	83 f8 02             	cmp    $0x2,%eax
  100c99:	76 9f                	jbe    100c3a <runcmd+0x38>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100c9b:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100c9e:	83 ec 08             	sub    $0x8,%esp
  100ca1:	50                   	push   %eax
  100ca2:	68 9b 39 10 00       	push   $0x10399b
  100ca7:	e8 c9 f5 ff ff       	call   100275 <cprintf>
  100cac:	83 c4 10             	add    $0x10,%esp
    return 0;
  100caf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cb4:	c9                   	leave  
  100cb5:	c3                   	ret    

00100cb6 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100cb6:	f3 0f 1e fb          	endbr32 
  100cba:	55                   	push   %ebp
  100cbb:	89 e5                	mov    %esp,%ebp
  100cbd:	83 ec 18             	sub    $0x18,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100cc0:	83 ec 0c             	sub    $0xc,%esp
  100cc3:	68 b4 39 10 00       	push   $0x1039b4
  100cc8:	e8 a8 f5 ff ff       	call   100275 <cprintf>
  100ccd:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
  100cd0:	83 ec 0c             	sub    $0xc,%esp
  100cd3:	68 dc 39 10 00       	push   $0x1039dc
  100cd8:	e8 98 f5 ff ff       	call   100275 <cprintf>
  100cdd:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
  100ce0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100ce4:	74 0e                	je     100cf4 <kmonitor+0x3e>
        print_trapframe(tf);
  100ce6:	83 ec 0c             	sub    $0xc,%esp
  100ce9:	ff 75 08             	pushl  0x8(%ebp)
  100cec:	e8 02 0e 00 00       	call   101af3 <print_trapframe>
  100cf1:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100cf4:	83 ec 0c             	sub    $0xc,%esp
  100cf7:	68 01 3a 10 00       	push   $0x103a01
  100cfc:	e8 29 f6 ff ff       	call   10032a <readline>
  100d01:	83 c4 10             	add    $0x10,%esp
  100d04:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100d07:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100d0b:	74 e7                	je     100cf4 <kmonitor+0x3e>
            if (runcmd(buf, tf) < 0) {
  100d0d:	83 ec 08             	sub    $0x8,%esp
  100d10:	ff 75 08             	pushl  0x8(%ebp)
  100d13:	ff 75 f4             	pushl  -0xc(%ebp)
  100d16:	e8 e7 fe ff ff       	call   100c02 <runcmd>
  100d1b:	83 c4 10             	add    $0x10,%esp
  100d1e:	85 c0                	test   %eax,%eax
  100d20:	78 02                	js     100d24 <kmonitor+0x6e>
        if ((buf = readline("K> ")) != NULL) {
  100d22:	eb d0                	jmp    100cf4 <kmonitor+0x3e>
                break;
  100d24:	90                   	nop
            }
        }
    }
}
  100d25:	90                   	nop
  100d26:	c9                   	leave  
  100d27:	c3                   	ret    

00100d28 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100d28:	f3 0f 1e fb          	endbr32 
  100d2c:	55                   	push   %ebp
  100d2d:	89 e5                	mov    %esp,%ebp
  100d2f:	83 ec 18             	sub    $0x18,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100d32:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100d39:	eb 3c                	jmp    100d77 <mon_help+0x4f>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100d3b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d3e:	89 d0                	mov    %edx,%eax
  100d40:	01 c0                	add    %eax,%eax
  100d42:	01 d0                	add    %edx,%eax
  100d44:	c1 e0 02             	shl    $0x2,%eax
  100d47:	05 04 f0 10 00       	add    $0x10f004,%eax
  100d4c:	8b 08                	mov    (%eax),%ecx
  100d4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100d51:	89 d0                	mov    %edx,%eax
  100d53:	01 c0                	add    %eax,%eax
  100d55:	01 d0                	add    %edx,%eax
  100d57:	c1 e0 02             	shl    $0x2,%eax
  100d5a:	05 00 f0 10 00       	add    $0x10f000,%eax
  100d5f:	8b 00                	mov    (%eax),%eax
  100d61:	83 ec 04             	sub    $0x4,%esp
  100d64:	51                   	push   %ecx
  100d65:	50                   	push   %eax
  100d66:	68 05 3a 10 00       	push   $0x103a05
  100d6b:	e8 05 f5 ff ff       	call   100275 <cprintf>
  100d70:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NCOMMANDS; i ++) {
  100d73:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100d77:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d7a:	83 f8 02             	cmp    $0x2,%eax
  100d7d:	76 bc                	jbe    100d3b <mon_help+0x13>
    }
    return 0;
  100d7f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d84:	c9                   	leave  
  100d85:	c3                   	ret    

00100d86 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100d86:	f3 0f 1e fb          	endbr32 
  100d8a:	55                   	push   %ebp
  100d8b:	89 e5                	mov    %esp,%ebp
  100d8d:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100d90:	e8 9c fb ff ff       	call   100931 <print_kerninfo>
    return 0;
  100d95:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d9a:	c9                   	leave  
  100d9b:	c3                   	ret    

00100d9c <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100d9c:	f3 0f 1e fb          	endbr32 
  100da0:	55                   	push   %ebp
  100da1:	89 e5                	mov    %esp,%ebp
  100da3:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100da6:	e8 da fc ff ff       	call   100a85 <print_stackframe>
    return 0;
  100dab:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100db0:	c9                   	leave  
  100db1:	c3                   	ret    

00100db2 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100db2:	f3 0f 1e fb          	endbr32 
  100db6:	55                   	push   %ebp
  100db7:	89 e5                	mov    %esp,%ebp
  100db9:	83 ec 18             	sub    $0x18,%esp
  100dbc:	66 c7 45 ee 43 00    	movw   $0x43,-0x12(%ebp)
  100dc2:	c6 45 ed 34          	movb   $0x34,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dc6:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100dca:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100dce:	ee                   	out    %al,(%dx)
}
  100dcf:	90                   	nop
  100dd0:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100dd6:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dda:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100dde:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100de2:	ee                   	out    %al,(%dx)
}
  100de3:	90                   	nop
  100de4:	66 c7 45 f6 40 00    	movw   $0x40,-0xa(%ebp)
  100dea:	c6 45 f5 2e          	movb   $0x2e,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100dee:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100df2:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100df6:	ee                   	out    %al,(%dx)
}
  100df7:	90                   	nop
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100df8:	c7 05 08 09 11 00 00 	movl   $0x0,0x110908
  100dff:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100e02:	83 ec 0c             	sub    $0xc,%esp
  100e05:	68 0e 3a 10 00       	push   $0x103a0e
  100e0a:	e8 66 f4 ff ff       	call   100275 <cprintf>
  100e0f:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
  100e12:	83 ec 0c             	sub    $0xc,%esp
  100e15:	6a 00                	push   $0x0
  100e17:	e8 39 09 00 00       	call   101755 <pic_enable>
  100e1c:	83 c4 10             	add    $0x10,%esp
}
  100e1f:	90                   	nop
  100e20:	c9                   	leave  
  100e21:	c3                   	ret    

00100e22 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100e22:	f3 0f 1e fb          	endbr32 
  100e26:	55                   	push   %ebp
  100e27:	89 e5                	mov    %esp,%ebp
  100e29:	83 ec 10             	sub    $0x10,%esp
  100e2c:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e32:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e36:	89 c2                	mov    %eax,%edx
  100e38:	ec                   	in     (%dx),%al
  100e39:	88 45 f1             	mov    %al,-0xf(%ebp)
  100e3c:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e42:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e46:	89 c2                	mov    %eax,%edx
  100e48:	ec                   	in     (%dx),%al
  100e49:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e4c:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e52:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e56:	89 c2                	mov    %eax,%edx
  100e58:	ec                   	in     (%dx),%al
  100e59:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e5c:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
  100e62:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e66:	89 c2                	mov    %eax,%edx
  100e68:	ec                   	in     (%dx),%al
  100e69:	88 45 fd             	mov    %al,-0x3(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e6c:	90                   	nop
  100e6d:	c9                   	leave  
  100e6e:	c3                   	ret    

00100e6f <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
  100e6f:	f3 0f 1e fb          	endbr32 
  100e73:	55                   	push   %ebp
  100e74:	89 e5                	mov    %esp,%ebp
  100e76:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;
  100e79:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;
  100e80:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e83:	0f b7 00             	movzwl (%eax),%eax
  100e86:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
  100e8a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e8d:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
  100e92:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e95:	0f b7 00             	movzwl (%eax),%eax
  100e98:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100e9c:	74 12                	je     100eb0 <cga_init+0x41>
        cp = (uint16_t*)MONO_BUF;
  100e9e:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
  100ea5:	66 c7 05 66 fe 10 00 	movw   $0x3b4,0x10fe66
  100eac:	b4 03 
  100eae:	eb 13                	jmp    100ec3 <cga_init+0x54>
    } else {
        *cp = was;
  100eb0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100eb3:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100eb7:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
  100eba:	66 c7 05 66 fe 10 00 	movw   $0x3d4,0x10fe66
  100ec1:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
  100ec3:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100eca:	0f b7 c0             	movzwl %ax,%eax
  100ecd:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  100ed1:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ed5:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100ed9:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100edd:	ee                   	out    %al,(%dx)
}
  100ede:	90                   	nop
    pos = inb(addr_6845 + 1) << 8;
  100edf:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100ee6:	83 c0 01             	add    $0x1,%eax
  100ee9:	0f b7 c0             	movzwl %ax,%eax
  100eec:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ef0:	0f b7 45 ea          	movzwl -0x16(%ebp),%eax
  100ef4:	89 c2                	mov    %eax,%edx
  100ef6:	ec                   	in     (%dx),%al
  100ef7:	88 45 e9             	mov    %al,-0x17(%ebp)
    return data;
  100efa:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100efe:	0f b6 c0             	movzbl %al,%eax
  100f01:	c1 e0 08             	shl    $0x8,%eax
  100f04:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100f07:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f0e:	0f b7 c0             	movzwl %ax,%eax
  100f11:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  100f15:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f19:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f1d:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f21:	ee                   	out    %al,(%dx)
}
  100f22:	90                   	nop
    pos |= inb(addr_6845 + 1);
  100f23:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  100f2a:	83 c0 01             	add    $0x1,%eax
  100f2d:	0f b7 c0             	movzwl %ax,%eax
  100f30:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f34:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100f38:	89 c2                	mov    %eax,%edx
  100f3a:	ec                   	in     (%dx),%al
  100f3b:	88 45 f1             	mov    %al,-0xf(%ebp)
    return data;
  100f3e:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f42:	0f b6 c0             	movzbl %al,%eax
  100f45:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
  100f48:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f4b:	a3 60 fe 10 00       	mov    %eax,0x10fe60
    crt_pos = pos;
  100f50:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f53:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
}
  100f59:	90                   	nop
  100f5a:	c9                   	leave  
  100f5b:	c3                   	ret    

00100f5c <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f5c:	f3 0f 1e fb          	endbr32 
  100f60:	55                   	push   %ebp
  100f61:	89 e5                	mov    %esp,%ebp
  100f63:	83 ec 38             	sub    $0x38,%esp
  100f66:	66 c7 45 d2 fa 03    	movw   $0x3fa,-0x2e(%ebp)
  100f6c:	c6 45 d1 00          	movb   $0x0,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f70:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  100f74:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  100f78:	ee                   	out    %al,(%dx)
}
  100f79:	90                   	nop
  100f7a:	66 c7 45 d6 fb 03    	movw   $0x3fb,-0x2a(%ebp)
  100f80:	c6 45 d5 80          	movb   $0x80,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f84:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  100f88:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  100f8c:	ee                   	out    %al,(%dx)
}
  100f8d:	90                   	nop
  100f8e:	66 c7 45 da f8 03    	movw   $0x3f8,-0x26(%ebp)
  100f94:	c6 45 d9 0c          	movb   $0xc,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f98:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  100f9c:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  100fa0:	ee                   	out    %al,(%dx)
}
  100fa1:	90                   	nop
  100fa2:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100fa8:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fac:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100fb0:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100fb4:	ee                   	out    %al,(%dx)
}
  100fb5:	90                   	nop
  100fb6:	66 c7 45 e2 fb 03    	movw   $0x3fb,-0x1e(%ebp)
  100fbc:	c6 45 e1 03          	movb   $0x3,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fc0:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100fc4:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100fc8:	ee                   	out    %al,(%dx)
}
  100fc9:	90                   	nop
  100fca:	66 c7 45 e6 fc 03    	movw   $0x3fc,-0x1a(%ebp)
  100fd0:	c6 45 e5 00          	movb   $0x0,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fd4:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100fd8:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100fdc:	ee                   	out    %al,(%dx)
}
  100fdd:	90                   	nop
  100fde:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100fe4:	c6 45 e9 01          	movb   $0x1,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fe8:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100fec:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100ff0:	ee                   	out    %al,(%dx)
}
  100ff1:	90                   	nop
  100ff2:	66 c7 45 ee fd 03    	movw   $0x3fd,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ff8:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100ffc:	89 c2                	mov    %eax,%edx
  100ffe:	ec                   	in     (%dx),%al
  100fff:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  101002:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  101006:	3c ff                	cmp    $0xff,%al
  101008:	0f 95 c0             	setne  %al
  10100b:	0f b6 c0             	movzbl %al,%eax
  10100e:	a3 68 fe 10 00       	mov    %eax,0x10fe68
  101013:	66 c7 45 f2 fa 03    	movw   $0x3fa,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101019:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10101d:	89 c2                	mov    %eax,%edx
  10101f:	ec                   	in     (%dx),%al
  101020:	88 45 f1             	mov    %al,-0xf(%ebp)
  101023:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101029:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10102d:	89 c2                	mov    %eax,%edx
  10102f:	ec                   	in     (%dx),%al
  101030:	88 45 f5             	mov    %al,-0xb(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  101033:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101038:	85 c0                	test   %eax,%eax
  10103a:	74 0d                	je     101049 <serial_init+0xed>
        pic_enable(IRQ_COM1);
  10103c:	83 ec 0c             	sub    $0xc,%esp
  10103f:	6a 04                	push   $0x4
  101041:	e8 0f 07 00 00       	call   101755 <pic_enable>
  101046:	83 c4 10             	add    $0x10,%esp
    }
}
  101049:	90                   	nop
  10104a:	c9                   	leave  
  10104b:	c3                   	ret    

0010104c <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  10104c:	f3 0f 1e fb          	endbr32 
  101050:	55                   	push   %ebp
  101051:	89 e5                	mov    %esp,%ebp
  101053:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101056:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10105d:	eb 09                	jmp    101068 <lpt_putc_sub+0x1c>
        delay();
  10105f:	e8 be fd ff ff       	call   100e22 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101064:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101068:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  10106e:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101072:	89 c2                	mov    %eax,%edx
  101074:	ec                   	in     (%dx),%al
  101075:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101078:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10107c:	84 c0                	test   %al,%al
  10107e:	78 09                	js     101089 <lpt_putc_sub+0x3d>
  101080:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101087:	7e d6                	jle    10105f <lpt_putc_sub+0x13>
    }
    outb(LPTPORT + 0, c);
  101089:	8b 45 08             	mov    0x8(%ebp),%eax
  10108c:	0f b6 c0             	movzbl %al,%eax
  10108f:	66 c7 45 ee 78 03    	movw   $0x378,-0x12(%ebp)
  101095:	88 45 ed             	mov    %al,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101098:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10109c:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1010a0:	ee                   	out    %al,(%dx)
}
  1010a1:	90                   	nop
  1010a2:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  1010a8:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010ac:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1010b0:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1010b4:	ee                   	out    %al,(%dx)
}
  1010b5:	90                   	nop
  1010b6:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  1010bc:	c6 45 f5 08          	movb   $0x8,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1010c0:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1010c4:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1010c8:	ee                   	out    %al,(%dx)
}
  1010c9:	90                   	nop
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  1010ca:	90                   	nop
  1010cb:	c9                   	leave  
  1010cc:	c3                   	ret    

001010cd <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  1010cd:	f3 0f 1e fb          	endbr32 
  1010d1:	55                   	push   %ebp
  1010d2:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
  1010d4:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1010d8:	74 0d                	je     1010e7 <lpt_putc+0x1a>
        lpt_putc_sub(c);
  1010da:	ff 75 08             	pushl  0x8(%ebp)
  1010dd:	e8 6a ff ff ff       	call   10104c <lpt_putc_sub>
  1010e2:	83 c4 04             	add    $0x4,%esp
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  1010e5:	eb 1e                	jmp    101105 <lpt_putc+0x38>
        lpt_putc_sub('\b');
  1010e7:	6a 08                	push   $0x8
  1010e9:	e8 5e ff ff ff       	call   10104c <lpt_putc_sub>
  1010ee:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
  1010f1:	6a 20                	push   $0x20
  1010f3:	e8 54 ff ff ff       	call   10104c <lpt_putc_sub>
  1010f8:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
  1010fb:	6a 08                	push   $0x8
  1010fd:	e8 4a ff ff ff       	call   10104c <lpt_putc_sub>
  101102:	83 c4 04             	add    $0x4,%esp
}
  101105:	90                   	nop
  101106:	c9                   	leave  
  101107:	c3                   	ret    

00101108 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101108:	f3 0f 1e fb          	endbr32 
  10110c:	55                   	push   %ebp
  10110d:	89 e5                	mov    %esp,%ebp
  10110f:	53                   	push   %ebx
  101110:	83 ec 24             	sub    $0x24,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  101113:	8b 45 08             	mov    0x8(%ebp),%eax
  101116:	b0 00                	mov    $0x0,%al
  101118:	85 c0                	test   %eax,%eax
  10111a:	75 07                	jne    101123 <cga_putc+0x1b>
        c |= 0x0700;
  10111c:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  101123:	8b 45 08             	mov    0x8(%ebp),%eax
  101126:	0f b6 c0             	movzbl %al,%eax
  101129:	83 f8 0d             	cmp    $0xd,%eax
  10112c:	74 6c                	je     10119a <cga_putc+0x92>
  10112e:	83 f8 0d             	cmp    $0xd,%eax
  101131:	0f 8f 9d 00 00 00    	jg     1011d4 <cga_putc+0xcc>
  101137:	83 f8 08             	cmp    $0x8,%eax
  10113a:	74 0a                	je     101146 <cga_putc+0x3e>
  10113c:	83 f8 0a             	cmp    $0xa,%eax
  10113f:	74 49                	je     10118a <cga_putc+0x82>
  101141:	e9 8e 00 00 00       	jmp    1011d4 <cga_putc+0xcc>
    case '\b':
        if (crt_pos > 0) {
  101146:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10114d:	66 85 c0             	test   %ax,%ax
  101150:	0f 84 a4 00 00 00    	je     1011fa <cga_putc+0xf2>
            crt_pos --;
  101156:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  10115d:	83 e8 01             	sub    $0x1,%eax
  101160:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  101166:	8b 45 08             	mov    0x8(%ebp),%eax
  101169:	b0 00                	mov    $0x0,%al
  10116b:	83 c8 20             	or     $0x20,%eax
  10116e:	89 c1                	mov    %eax,%ecx
  101170:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101175:	0f b7 15 64 fe 10 00 	movzwl 0x10fe64,%edx
  10117c:	0f b7 d2             	movzwl %dx,%edx
  10117f:	01 d2                	add    %edx,%edx
  101181:	01 d0                	add    %edx,%eax
  101183:	89 ca                	mov    %ecx,%edx
  101185:	66 89 10             	mov    %dx,(%eax)
        }
        break;
  101188:	eb 70                	jmp    1011fa <cga_putc+0xf2>
    case '\n':
        crt_pos += CRT_COLS;
  10118a:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101191:	83 c0 50             	add    $0x50,%eax
  101194:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  10119a:	0f b7 1d 64 fe 10 00 	movzwl 0x10fe64,%ebx
  1011a1:	0f b7 0d 64 fe 10 00 	movzwl 0x10fe64,%ecx
  1011a8:	0f b7 c1             	movzwl %cx,%eax
  1011ab:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  1011b1:	c1 e8 10             	shr    $0x10,%eax
  1011b4:	89 c2                	mov    %eax,%edx
  1011b6:	66 c1 ea 06          	shr    $0x6,%dx
  1011ba:	89 d0                	mov    %edx,%eax
  1011bc:	c1 e0 02             	shl    $0x2,%eax
  1011bf:	01 d0                	add    %edx,%eax
  1011c1:	c1 e0 04             	shl    $0x4,%eax
  1011c4:	29 c1                	sub    %eax,%ecx
  1011c6:	89 ca                	mov    %ecx,%edx
  1011c8:	89 d8                	mov    %ebx,%eax
  1011ca:	29 d0                	sub    %edx,%eax
  1011cc:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
        break;
  1011d2:	eb 27                	jmp    1011fb <cga_putc+0xf3>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  1011d4:	8b 0d 60 fe 10 00    	mov    0x10fe60,%ecx
  1011da:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1011e1:	8d 50 01             	lea    0x1(%eax),%edx
  1011e4:	66 89 15 64 fe 10 00 	mov    %dx,0x10fe64
  1011eb:	0f b7 c0             	movzwl %ax,%eax
  1011ee:	01 c0                	add    %eax,%eax
  1011f0:	01 c8                	add    %ecx,%eax
  1011f2:	8b 55 08             	mov    0x8(%ebp),%edx
  1011f5:	66 89 10             	mov    %dx,(%eax)
        break;
  1011f8:	eb 01                	jmp    1011fb <cga_putc+0xf3>
        break;
  1011fa:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  1011fb:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101202:	66 3d cf 07          	cmp    $0x7cf,%ax
  101206:	76 59                	jbe    101261 <cga_putc+0x159>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101208:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  10120d:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  101213:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101218:	83 ec 04             	sub    $0x4,%esp
  10121b:	68 00 0f 00 00       	push   $0xf00
  101220:	52                   	push   %edx
  101221:	50                   	push   %eax
  101222:	e8 45 1d 00 00       	call   102f6c <memmove>
  101227:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  10122a:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  101231:	eb 15                	jmp    101248 <cga_putc+0x140>
            crt_buf[i] = 0x0700 | ' ';
  101233:	a1 60 fe 10 00       	mov    0x10fe60,%eax
  101238:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10123b:	01 d2                	add    %edx,%edx
  10123d:	01 d0                	add    %edx,%eax
  10123f:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101244:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101248:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  10124f:	7e e2                	jle    101233 <cga_putc+0x12b>
        }
        crt_pos -= CRT_COLS;
  101251:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101258:	83 e8 50             	sub    $0x50,%eax
  10125b:	66 a3 64 fe 10 00    	mov    %ax,0x10fe64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101261:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  101268:	0f b7 c0             	movzwl %ax,%eax
  10126b:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
  10126f:	c6 45 e5 0e          	movb   $0xe,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101273:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101277:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10127b:	ee                   	out    %al,(%dx)
}
  10127c:	90                   	nop
    outb(addr_6845 + 1, crt_pos >> 8);
  10127d:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  101284:	66 c1 e8 08          	shr    $0x8,%ax
  101288:	0f b6 c0             	movzbl %al,%eax
  10128b:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  101292:	83 c2 01             	add    $0x1,%edx
  101295:	0f b7 d2             	movzwl %dx,%edx
  101298:	66 89 55 ea          	mov    %dx,-0x16(%ebp)
  10129c:	88 45 e9             	mov    %al,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10129f:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1012a3:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  1012a7:	ee                   	out    %al,(%dx)
}
  1012a8:	90                   	nop
    outb(addr_6845, 15);
  1012a9:	0f b7 05 66 fe 10 00 	movzwl 0x10fe66,%eax
  1012b0:	0f b7 c0             	movzwl %ax,%eax
  1012b3:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1012b7:	c6 45 ed 0f          	movb   $0xf,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012bb:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  1012bf:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1012c3:	ee                   	out    %al,(%dx)
}
  1012c4:	90                   	nop
    outb(addr_6845 + 1, crt_pos);
  1012c5:	0f b7 05 64 fe 10 00 	movzwl 0x10fe64,%eax
  1012cc:	0f b6 c0             	movzbl %al,%eax
  1012cf:	0f b7 15 66 fe 10 00 	movzwl 0x10fe66,%edx
  1012d6:	83 c2 01             	add    $0x1,%edx
  1012d9:	0f b7 d2             	movzwl %dx,%edx
  1012dc:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  1012e0:	88 45 f1             	mov    %al,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012e3:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1012e7:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1012eb:	ee                   	out    %al,(%dx)
}
  1012ec:	90                   	nop
}
  1012ed:	90                   	nop
  1012ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1012f1:	c9                   	leave  
  1012f2:	c3                   	ret    

001012f3 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  1012f3:	f3 0f 1e fb          	endbr32 
  1012f7:	55                   	push   %ebp
  1012f8:	89 e5                	mov    %esp,%ebp
  1012fa:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1012fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101304:	eb 09                	jmp    10130f <serial_putc_sub+0x1c>
        delay();
  101306:	e8 17 fb ff ff       	call   100e22 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10130b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10130f:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101315:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101319:	89 c2                	mov    %eax,%edx
  10131b:	ec                   	in     (%dx),%al
  10131c:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10131f:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101323:	0f b6 c0             	movzbl %al,%eax
  101326:	83 e0 20             	and    $0x20,%eax
  101329:	85 c0                	test   %eax,%eax
  10132b:	75 09                	jne    101336 <serial_putc_sub+0x43>
  10132d:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101334:	7e d0                	jle    101306 <serial_putc_sub+0x13>
    }
    outb(COM1 + COM_TX, c);
  101336:	8b 45 08             	mov    0x8(%ebp),%eax
  101339:	0f b6 c0             	movzbl %al,%eax
  10133c:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  101342:	88 45 f5             	mov    %al,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101345:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101349:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10134d:	ee                   	out    %al,(%dx)
}
  10134e:	90                   	nop
}
  10134f:	90                   	nop
  101350:	c9                   	leave  
  101351:	c3                   	ret    

00101352 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  101352:	f3 0f 1e fb          	endbr32 
  101356:	55                   	push   %ebp
  101357:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
  101359:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10135d:	74 0d                	je     10136c <serial_putc+0x1a>
        serial_putc_sub(c);
  10135f:	ff 75 08             	pushl  0x8(%ebp)
  101362:	e8 8c ff ff ff       	call   1012f3 <serial_putc_sub>
  101367:	83 c4 04             	add    $0x4,%esp
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  10136a:	eb 1e                	jmp    10138a <serial_putc+0x38>
        serial_putc_sub('\b');
  10136c:	6a 08                	push   $0x8
  10136e:	e8 80 ff ff ff       	call   1012f3 <serial_putc_sub>
  101373:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
  101376:	6a 20                	push   $0x20
  101378:	e8 76 ff ff ff       	call   1012f3 <serial_putc_sub>
  10137d:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
  101380:	6a 08                	push   $0x8
  101382:	e8 6c ff ff ff       	call   1012f3 <serial_putc_sub>
  101387:	83 c4 04             	add    $0x4,%esp
}
  10138a:	90                   	nop
  10138b:	c9                   	leave  
  10138c:	c3                   	ret    

0010138d <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  10138d:	f3 0f 1e fb          	endbr32 
  101391:	55                   	push   %ebp
  101392:	89 e5                	mov    %esp,%ebp
  101394:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  101397:	eb 33                	jmp    1013cc <cons_intr+0x3f>
        if (c != 0) {
  101399:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10139d:	74 2d                	je     1013cc <cons_intr+0x3f>
            cons.buf[cons.wpos ++] = c;
  10139f:	a1 84 00 11 00       	mov    0x110084,%eax
  1013a4:	8d 50 01             	lea    0x1(%eax),%edx
  1013a7:	89 15 84 00 11 00    	mov    %edx,0x110084
  1013ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1013b0:	88 90 80 fe 10 00    	mov    %dl,0x10fe80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  1013b6:	a1 84 00 11 00       	mov    0x110084,%eax
  1013bb:	3d 00 02 00 00       	cmp    $0x200,%eax
  1013c0:	75 0a                	jne    1013cc <cons_intr+0x3f>
                cons.wpos = 0;
  1013c2:	c7 05 84 00 11 00 00 	movl   $0x0,0x110084
  1013c9:	00 00 00 
    while ((c = (*proc)()) != -1) {
  1013cc:	8b 45 08             	mov    0x8(%ebp),%eax
  1013cf:	ff d0                	call   *%eax
  1013d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1013d4:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  1013d8:	75 bf                	jne    101399 <cons_intr+0xc>
            }
        }
    }
}
  1013da:	90                   	nop
  1013db:	90                   	nop
  1013dc:	c9                   	leave  
  1013dd:	c3                   	ret    

001013de <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  1013de:	f3 0f 1e fb          	endbr32 
  1013e2:	55                   	push   %ebp
  1013e3:	89 e5                	mov    %esp,%ebp
  1013e5:	83 ec 10             	sub    $0x10,%esp
  1013e8:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013ee:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1013f2:	89 c2                	mov    %eax,%edx
  1013f4:	ec                   	in     (%dx),%al
  1013f5:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1013f8:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  1013fc:	0f b6 c0             	movzbl %al,%eax
  1013ff:	83 e0 01             	and    $0x1,%eax
  101402:	85 c0                	test   %eax,%eax
  101404:	75 07                	jne    10140d <serial_proc_data+0x2f>
        return -1;
  101406:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10140b:	eb 2a                	jmp    101437 <serial_proc_data+0x59>
  10140d:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101413:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101417:	89 c2                	mov    %eax,%edx
  101419:	ec                   	in     (%dx),%al
  10141a:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  10141d:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  101421:	0f b6 c0             	movzbl %al,%eax
  101424:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101427:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  10142b:	75 07                	jne    101434 <serial_proc_data+0x56>
        c = '\b';
  10142d:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  101434:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  101437:	c9                   	leave  
  101438:	c3                   	ret    

00101439 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  101439:	f3 0f 1e fb          	endbr32 
  10143d:	55                   	push   %ebp
  10143e:	89 e5                	mov    %esp,%ebp
  101440:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists) {
  101443:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  101448:	85 c0                	test   %eax,%eax
  10144a:	74 10                	je     10145c <serial_intr+0x23>
        cons_intr(serial_proc_data);
  10144c:	83 ec 0c             	sub    $0xc,%esp
  10144f:	68 de 13 10 00       	push   $0x1013de
  101454:	e8 34 ff ff ff       	call   10138d <cons_intr>
  101459:	83 c4 10             	add    $0x10,%esp
    }
}
  10145c:	90                   	nop
  10145d:	c9                   	leave  
  10145e:	c3                   	ret    

0010145f <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  10145f:	f3 0f 1e fb          	endbr32 
  101463:	55                   	push   %ebp
  101464:	89 e5                	mov    %esp,%ebp
  101466:	83 ec 28             	sub    $0x28,%esp
  101469:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10146f:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  101473:	89 c2                	mov    %eax,%edx
  101475:	ec                   	in     (%dx),%al
  101476:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  101479:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  10147d:	0f b6 c0             	movzbl %al,%eax
  101480:	83 e0 01             	and    $0x1,%eax
  101483:	85 c0                	test   %eax,%eax
  101485:	75 0a                	jne    101491 <kbd_proc_data+0x32>
        return -1;
  101487:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10148c:	e9 5e 01 00 00       	jmp    1015ef <kbd_proc_data+0x190>
  101491:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101497:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10149b:	89 c2                	mov    %eax,%edx
  10149d:	ec                   	in     (%dx),%al
  10149e:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1014a1:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  1014a5:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1014a8:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1014ac:	75 17                	jne    1014c5 <kbd_proc_data+0x66>
        // E0 escape character
        shift |= E0ESC;
  1014ae:	a1 88 00 11 00       	mov    0x110088,%eax
  1014b3:	83 c8 40             	or     $0x40,%eax
  1014b6:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  1014bb:	b8 00 00 00 00       	mov    $0x0,%eax
  1014c0:	e9 2a 01 00 00       	jmp    1015ef <kbd_proc_data+0x190>
    } else if (data & 0x80) {
  1014c5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014c9:	84 c0                	test   %al,%al
  1014cb:	79 47                	jns    101514 <kbd_proc_data+0xb5>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1014cd:	a1 88 00 11 00       	mov    0x110088,%eax
  1014d2:	83 e0 40             	and    $0x40,%eax
  1014d5:	85 c0                	test   %eax,%eax
  1014d7:	75 09                	jne    1014e2 <kbd_proc_data+0x83>
  1014d9:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014dd:	83 e0 7f             	and    $0x7f,%eax
  1014e0:	eb 04                	jmp    1014e6 <kbd_proc_data+0x87>
  1014e2:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014e6:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  1014e9:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014ed:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  1014f4:	83 c8 40             	or     $0x40,%eax
  1014f7:	0f b6 c0             	movzbl %al,%eax
  1014fa:	f7 d0                	not    %eax
  1014fc:	89 c2                	mov    %eax,%edx
  1014fe:	a1 88 00 11 00       	mov    0x110088,%eax
  101503:	21 d0                	and    %edx,%eax
  101505:	a3 88 00 11 00       	mov    %eax,0x110088
        return 0;
  10150a:	b8 00 00 00 00       	mov    $0x0,%eax
  10150f:	e9 db 00 00 00       	jmp    1015ef <kbd_proc_data+0x190>
    } else if (shift & E0ESC) {
  101514:	a1 88 00 11 00       	mov    0x110088,%eax
  101519:	83 e0 40             	and    $0x40,%eax
  10151c:	85 c0                	test   %eax,%eax
  10151e:	74 11                	je     101531 <kbd_proc_data+0xd2>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101520:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101524:	a1 88 00 11 00       	mov    0x110088,%eax
  101529:	83 e0 bf             	and    $0xffffffbf,%eax
  10152c:	a3 88 00 11 00       	mov    %eax,0x110088
    }

    shift |= shiftcode[data];
  101531:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101535:	0f b6 80 40 f0 10 00 	movzbl 0x10f040(%eax),%eax
  10153c:	0f b6 d0             	movzbl %al,%edx
  10153f:	a1 88 00 11 00       	mov    0x110088,%eax
  101544:	09 d0                	or     %edx,%eax
  101546:	a3 88 00 11 00       	mov    %eax,0x110088
    shift ^= togglecode[data];
  10154b:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10154f:	0f b6 80 40 f1 10 00 	movzbl 0x10f140(%eax),%eax
  101556:	0f b6 d0             	movzbl %al,%edx
  101559:	a1 88 00 11 00       	mov    0x110088,%eax
  10155e:	31 d0                	xor    %edx,%eax
  101560:	a3 88 00 11 00       	mov    %eax,0x110088

    c = charcode[shift & (CTL | SHIFT)][data];
  101565:	a1 88 00 11 00       	mov    0x110088,%eax
  10156a:	83 e0 03             	and    $0x3,%eax
  10156d:	8b 14 85 40 f5 10 00 	mov    0x10f540(,%eax,4),%edx
  101574:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101578:	01 d0                	add    %edx,%eax
  10157a:	0f b6 00             	movzbl (%eax),%eax
  10157d:	0f b6 c0             	movzbl %al,%eax
  101580:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  101583:	a1 88 00 11 00       	mov    0x110088,%eax
  101588:	83 e0 08             	and    $0x8,%eax
  10158b:	85 c0                	test   %eax,%eax
  10158d:	74 22                	je     1015b1 <kbd_proc_data+0x152>
        if ('a' <= c && c <= 'z')
  10158f:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  101593:	7e 0c                	jle    1015a1 <kbd_proc_data+0x142>
  101595:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  101599:	7f 06                	jg     1015a1 <kbd_proc_data+0x142>
            c += 'A' - 'a';
  10159b:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  10159f:	eb 10                	jmp    1015b1 <kbd_proc_data+0x152>
        else if ('A' <= c && c <= 'Z')
  1015a1:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1015a5:	7e 0a                	jle    1015b1 <kbd_proc_data+0x152>
  1015a7:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1015ab:	7f 04                	jg     1015b1 <kbd_proc_data+0x152>
            c += 'a' - 'A';
  1015ad:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1015b1:	a1 88 00 11 00       	mov    0x110088,%eax
  1015b6:	f7 d0                	not    %eax
  1015b8:	83 e0 06             	and    $0x6,%eax
  1015bb:	85 c0                	test   %eax,%eax
  1015bd:	75 2d                	jne    1015ec <kbd_proc_data+0x18d>
  1015bf:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1015c6:	75 24                	jne    1015ec <kbd_proc_data+0x18d>
        cprintf("Rebooting!\n");
  1015c8:	83 ec 0c             	sub    $0xc,%esp
  1015cb:	68 29 3a 10 00       	push   $0x103a29
  1015d0:	e8 a0 ec ff ff       	call   100275 <cprintf>
  1015d5:	83 c4 10             	add    $0x10,%esp
  1015d8:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  1015de:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1015e2:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  1015e6:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  1015ea:	ee                   	out    %al,(%dx)
}
  1015eb:	90                   	nop
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  1015ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1015ef:	c9                   	leave  
  1015f0:	c3                   	ret    

001015f1 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  1015f1:	f3 0f 1e fb          	endbr32 
  1015f5:	55                   	push   %ebp
  1015f6:	89 e5                	mov    %esp,%ebp
  1015f8:	83 ec 08             	sub    $0x8,%esp
    cons_intr(kbd_proc_data);
  1015fb:	83 ec 0c             	sub    $0xc,%esp
  1015fe:	68 5f 14 10 00       	push   $0x10145f
  101603:	e8 85 fd ff ff       	call   10138d <cons_intr>
  101608:	83 c4 10             	add    $0x10,%esp
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
  101615:	83 ec 08             	sub    $0x8,%esp
    // drain the kbd buffer
    kbd_intr();
  101618:	e8 d4 ff ff ff       	call   1015f1 <kbd_intr>
    pic_enable(IRQ_KBD);
  10161d:	83 ec 0c             	sub    $0xc,%esp
  101620:	6a 01                	push   $0x1
  101622:	e8 2e 01 00 00       	call   101755 <pic_enable>
  101627:	83 c4 10             	add    $0x10,%esp
}
  10162a:	90                   	nop
  10162b:	c9                   	leave  
  10162c:	c3                   	ret    

0010162d <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  10162d:	f3 0f 1e fb          	endbr32 
  101631:	55                   	push   %ebp
  101632:	89 e5                	mov    %esp,%ebp
  101634:	83 ec 08             	sub    $0x8,%esp
    cga_init();
  101637:	e8 33 f8 ff ff       	call   100e6f <cga_init>
    serial_init();
  10163c:	e8 1b f9 ff ff       	call   100f5c <serial_init>
    kbd_init();
  101641:	e8 c8 ff ff ff       	call   10160e <kbd_init>
    if (!serial_exists) {
  101646:	a1 68 fe 10 00       	mov    0x10fe68,%eax
  10164b:	85 c0                	test   %eax,%eax
  10164d:	75 10                	jne    10165f <cons_init+0x32>
        cprintf("serial port does not exist!!\n");
  10164f:	83 ec 0c             	sub    $0xc,%esp
  101652:	68 35 3a 10 00       	push   $0x103a35
  101657:	e8 19 ec ff ff       	call   100275 <cprintf>
  10165c:	83 c4 10             	add    $0x10,%esp
    }
}
  10165f:	90                   	nop
  101660:	c9                   	leave  
  101661:	c3                   	ret    

00101662 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  101662:	f3 0f 1e fb          	endbr32 
  101666:	55                   	push   %ebp
  101667:	89 e5                	mov    %esp,%ebp
  101669:	83 ec 08             	sub    $0x8,%esp
    lpt_putc(c);
  10166c:	ff 75 08             	pushl  0x8(%ebp)
  10166f:	e8 59 fa ff ff       	call   1010cd <lpt_putc>
  101674:	83 c4 04             	add    $0x4,%esp
    cga_putc(c);
  101677:	83 ec 0c             	sub    $0xc,%esp
  10167a:	ff 75 08             	pushl  0x8(%ebp)
  10167d:	e8 86 fa ff ff       	call   101108 <cga_putc>
  101682:	83 c4 10             	add    $0x10,%esp
    serial_putc(c);
  101685:	83 ec 0c             	sub    $0xc,%esp
  101688:	ff 75 08             	pushl  0x8(%ebp)
  10168b:	e8 c2 fc ff ff       	call   101352 <serial_putc>
  101690:	83 c4 10             	add    $0x10,%esp
}
  101693:	90                   	nop
  101694:	c9                   	leave  
  101695:	c3                   	ret    

00101696 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  101696:	f3 0f 1e fb          	endbr32 
  10169a:	55                   	push   %ebp
  10169b:	89 e5                	mov    %esp,%ebp
  10169d:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1016a0:	e8 94 fd ff ff       	call   101439 <serial_intr>
    kbd_intr();
  1016a5:	e8 47 ff ff ff       	call   1015f1 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1016aa:	8b 15 80 00 11 00    	mov    0x110080,%edx
  1016b0:	a1 84 00 11 00       	mov    0x110084,%eax
  1016b5:	39 c2                	cmp    %eax,%edx
  1016b7:	74 36                	je     1016ef <cons_getc+0x59>
        c = cons.buf[cons.rpos ++];
  1016b9:	a1 80 00 11 00       	mov    0x110080,%eax
  1016be:	8d 50 01             	lea    0x1(%eax),%edx
  1016c1:	89 15 80 00 11 00    	mov    %edx,0x110080
  1016c7:	0f b6 80 80 fe 10 00 	movzbl 0x10fe80(%eax),%eax
  1016ce:	0f b6 c0             	movzbl %al,%eax
  1016d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  1016d4:	a1 80 00 11 00       	mov    0x110080,%eax
  1016d9:	3d 00 02 00 00       	cmp    $0x200,%eax
  1016de:	75 0a                	jne    1016ea <cons_getc+0x54>
            cons.rpos = 0;
  1016e0:	c7 05 80 00 11 00 00 	movl   $0x0,0x110080
  1016e7:	00 00 00 
        }
        return c;
  1016ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1016ed:	eb 05                	jmp    1016f4 <cons_getc+0x5e>
    }
    return 0;
  1016ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1016f4:	c9                   	leave  
  1016f5:	c3                   	ret    

001016f6 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  1016f6:	f3 0f 1e fb          	endbr32 
  1016fa:	55                   	push   %ebp
  1016fb:	89 e5                	mov    %esp,%ebp
  1016fd:	83 ec 14             	sub    $0x14,%esp
  101700:	8b 45 08             	mov    0x8(%ebp),%eax
  101703:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  101707:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10170b:	66 a3 50 f5 10 00    	mov    %ax,0x10f550
    if (did_init) {
  101711:	a1 8c 00 11 00       	mov    0x11008c,%eax
  101716:	85 c0                	test   %eax,%eax
  101718:	74 38                	je     101752 <pic_setmask+0x5c>
        outb(IO_PIC1 + 1, mask);
  10171a:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10171e:	0f b6 c0             	movzbl %al,%eax
  101721:	66 c7 45 fa 21 00    	movw   $0x21,-0x6(%ebp)
  101727:	88 45 f9             	mov    %al,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10172a:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  10172e:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101732:	ee                   	out    %al,(%dx)
}
  101733:	90                   	nop
        outb(IO_PIC2 + 1, mask >> 8);
  101734:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101738:	66 c1 e8 08          	shr    $0x8,%ax
  10173c:	0f b6 c0             	movzbl %al,%eax
  10173f:	66 c7 45 fe a1 00    	movw   $0xa1,-0x2(%ebp)
  101745:	88 45 fd             	mov    %al,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101748:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  10174c:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101750:	ee                   	out    %al,(%dx)
}
  101751:	90                   	nop
    }
}
  101752:	90                   	nop
  101753:	c9                   	leave  
  101754:	c3                   	ret    

00101755 <pic_enable>:

void
pic_enable(unsigned int irq) {
  101755:	f3 0f 1e fb          	endbr32 
  101759:	55                   	push   %ebp
  10175a:	89 e5                	mov    %esp,%ebp
    pic_setmask(irq_mask & ~(1 << irq));
  10175c:	8b 45 08             	mov    0x8(%ebp),%eax
  10175f:	ba 01 00 00 00       	mov    $0x1,%edx
  101764:	89 c1                	mov    %eax,%ecx
  101766:	d3 e2                	shl    %cl,%edx
  101768:	89 d0                	mov    %edx,%eax
  10176a:	f7 d0                	not    %eax
  10176c:	89 c2                	mov    %eax,%edx
  10176e:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  101775:	21 d0                	and    %edx,%eax
  101777:	0f b7 c0             	movzwl %ax,%eax
  10177a:	50                   	push   %eax
  10177b:	e8 76 ff ff ff       	call   1016f6 <pic_setmask>
  101780:	83 c4 04             	add    $0x4,%esp
}
  101783:	90                   	nop
  101784:	c9                   	leave  
  101785:	c3                   	ret    

00101786 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  101786:	f3 0f 1e fb          	endbr32 
  10178a:	55                   	push   %ebp
  10178b:	89 e5                	mov    %esp,%ebp
  10178d:	83 ec 40             	sub    $0x40,%esp
    did_init = 1;
  101790:	c7 05 8c 00 11 00 01 	movl   $0x1,0x11008c
  101797:	00 00 00 
  10179a:	66 c7 45 ca 21 00    	movw   $0x21,-0x36(%ebp)
  1017a0:	c6 45 c9 ff          	movb   $0xff,-0x37(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017a4:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1017a8:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1017ac:	ee                   	out    %al,(%dx)
}
  1017ad:	90                   	nop
  1017ae:	66 c7 45 ce a1 00    	movw   $0xa1,-0x32(%ebp)
  1017b4:	c6 45 cd ff          	movb   $0xff,-0x33(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017b8:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1017bc:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1017c0:	ee                   	out    %al,(%dx)
}
  1017c1:	90                   	nop
  1017c2:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1017c8:	c6 45 d1 11          	movb   $0x11,-0x2f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017cc:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017d0:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017d4:	ee                   	out    %al,(%dx)
}
  1017d5:	90                   	nop
  1017d6:	66 c7 45 d6 21 00    	movw   $0x21,-0x2a(%ebp)
  1017dc:	c6 45 d5 20          	movb   $0x20,-0x2b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017e0:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1017e4:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1017e8:	ee                   	out    %al,(%dx)
}
  1017e9:	90                   	nop
  1017ea:	66 c7 45 da 21 00    	movw   $0x21,-0x26(%ebp)
  1017f0:	c6 45 d9 04          	movb   $0x4,-0x27(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1017f4:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  1017f8:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  1017fc:	ee                   	out    %al,(%dx)
}
  1017fd:	90                   	nop
  1017fe:	66 c7 45 de 21 00    	movw   $0x21,-0x22(%ebp)
  101804:	c6 45 dd 03          	movb   $0x3,-0x23(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101808:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  10180c:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101810:	ee                   	out    %al,(%dx)
}
  101811:	90                   	nop
  101812:	66 c7 45 e2 a0 00    	movw   $0xa0,-0x1e(%ebp)
  101818:	c6 45 e1 11          	movb   $0x11,-0x1f(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10181c:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101820:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  101824:	ee                   	out    %al,(%dx)
}
  101825:	90                   	nop
  101826:	66 c7 45 e6 a1 00    	movw   $0xa1,-0x1a(%ebp)
  10182c:	c6 45 e5 28          	movb   $0x28,-0x1b(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101830:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101834:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101838:	ee                   	out    %al,(%dx)
}
  101839:	90                   	nop
  10183a:	66 c7 45 ea a1 00    	movw   $0xa1,-0x16(%ebp)
  101840:	c6 45 e9 02          	movb   $0x2,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101844:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101848:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10184c:	ee                   	out    %al,(%dx)
}
  10184d:	90                   	nop
  10184e:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  101854:	c6 45 ed 03          	movb   $0x3,-0x13(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101858:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10185c:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101860:	ee                   	out    %al,(%dx)
}
  101861:	90                   	nop
  101862:	66 c7 45 f2 20 00    	movw   $0x20,-0xe(%ebp)
  101868:	c6 45 f1 68          	movb   $0x68,-0xf(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10186c:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101870:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101874:	ee                   	out    %al,(%dx)
}
  101875:	90                   	nop
  101876:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  10187c:	c6 45 f5 0a          	movb   $0xa,-0xb(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101880:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101884:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101888:	ee                   	out    %al,(%dx)
}
  101889:	90                   	nop
  10188a:	66 c7 45 fa a0 00    	movw   $0xa0,-0x6(%ebp)
  101890:	c6 45 f9 68          	movb   $0x68,-0x7(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101894:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101898:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  10189c:	ee                   	out    %al,(%dx)
}
  10189d:	90                   	nop
  10189e:	66 c7 45 fe a0 00    	movw   $0xa0,-0x2(%ebp)
  1018a4:	c6 45 fd 0a          	movb   $0xa,-0x3(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1018a8:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1018ac:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1018b0:	ee                   	out    %al,(%dx)
}
  1018b1:	90                   	nop
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1018b2:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  1018b9:	66 83 f8 ff          	cmp    $0xffff,%ax
  1018bd:	74 13                	je     1018d2 <pic_init+0x14c>
        pic_setmask(irq_mask);
  1018bf:	0f b7 05 50 f5 10 00 	movzwl 0x10f550,%eax
  1018c6:	0f b7 c0             	movzwl %ax,%eax
  1018c9:	50                   	push   %eax
  1018ca:	e8 27 fe ff ff       	call   1016f6 <pic_setmask>
  1018cf:	83 c4 04             	add    $0x4,%esp
    }
}
  1018d2:	90                   	nop
  1018d3:	c9                   	leave  
  1018d4:	c3                   	ret    

001018d5 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1018d5:	f3 0f 1e fb          	endbr32 
  1018d9:	55                   	push   %ebp
  1018da:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1018dc:	fb                   	sti    
}
  1018dd:	90                   	nop
    sti();
}
  1018de:	90                   	nop
  1018df:	5d                   	pop    %ebp
  1018e0:	c3                   	ret    

001018e1 <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1018e1:	f3 0f 1e fb          	endbr32 
  1018e5:	55                   	push   %ebp
  1018e6:	89 e5                	mov    %esp,%ebp

static inline void
cli(void) {
    asm volatile ("cli");
  1018e8:	fa                   	cli    
}
  1018e9:	90                   	nop
    cli();
}
  1018ea:	90                   	nop
  1018eb:	5d                   	pop    %ebp
  1018ec:	c3                   	ret    

001018ed <print_ticks>:
#include <console.h>
#include <kdebug.h>
#include <string.h>
#define TICK_NUM 100

static void print_ticks() {
  1018ed:	f3 0f 1e fb          	endbr32 
  1018f1:	55                   	push   %ebp
  1018f2:	89 e5                	mov    %esp,%ebp
  1018f4:	83 ec 08             	sub    $0x8,%esp
    cprintf("%d ticks\n",TICK_NUM);
  1018f7:	83 ec 08             	sub    $0x8,%esp
  1018fa:	6a 64                	push   $0x64
  1018fc:	68 60 3a 10 00       	push   $0x103a60
  101901:	e8 6f e9 ff ff       	call   100275 <cprintf>
  101906:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
  101909:	83 ec 0c             	sub    $0xc,%esp
  10190c:	68 6a 3a 10 00       	push   $0x103a6a
  101911:	e8 5f e9 ff ff       	call   100275 <cprintf>
  101916:	83 c4 10             	add    $0x10,%esp
    panic("EOT: kernel seems ok.");
  101919:	83 ec 04             	sub    $0x4,%esp
  10191c:	68 78 3a 10 00       	push   $0x103a78
  101921:	6a 12                	push   $0x12
  101923:	68 8e 3a 10 00       	push   $0x103a8e
  101928:	e8 c3 ea ff ff       	call   1003f0 <__panic>

0010192d <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  10192d:	f3 0f 1e fb          	endbr32 
  101931:	55                   	push   %ebp
  101932:	89 e5                	mov    %esp,%ebp
  101934:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101937:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10193e:	e9 c3 00 00 00       	jmp    101a06 <idt_init+0xd9>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  101943:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101946:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  10194d:	89 c2                	mov    %eax,%edx
  10194f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101952:	66 89 14 c5 a0 00 11 	mov    %dx,0x1100a0(,%eax,8)
  101959:	00 
  10195a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10195d:	66 c7 04 c5 a2 00 11 	movw   $0x8,0x1100a2(,%eax,8)
  101964:	00 08 00 
  101967:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10196a:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  101971:	00 
  101972:	83 e2 e0             	and    $0xffffffe0,%edx
  101975:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  10197c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10197f:	0f b6 14 c5 a4 00 11 	movzbl 0x1100a4(,%eax,8),%edx
  101986:	00 
  101987:	83 e2 1f             	and    $0x1f,%edx
  10198a:	88 14 c5 a4 00 11 00 	mov    %dl,0x1100a4(,%eax,8)
  101991:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101994:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  10199b:	00 
  10199c:	83 e2 f0             	and    $0xfffffff0,%edx
  10199f:	83 ca 0e             	or     $0xe,%edx
  1019a2:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019ac:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019b3:	00 
  1019b4:	83 e2 ef             	and    $0xffffffef,%edx
  1019b7:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019c1:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019c8:	00 
  1019c9:	83 e2 9f             	and    $0xffffff9f,%edx
  1019cc:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019d6:	0f b6 14 c5 a5 00 11 	movzbl 0x1100a5(,%eax,8),%edx
  1019dd:	00 
  1019de:	83 ca 80             	or     $0xffffff80,%edx
  1019e1:	88 14 c5 a5 00 11 00 	mov    %dl,0x1100a5(,%eax,8)
  1019e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019eb:	8b 04 85 e0 f5 10 00 	mov    0x10f5e0(,%eax,4),%eax
  1019f2:	c1 e8 10             	shr    $0x10,%eax
  1019f5:	89 c2                	mov    %eax,%edx
  1019f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1019fa:	66 89 14 c5 a6 00 11 	mov    %dx,0x1100a6(,%eax,8)
  101a01:	00 
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101a02:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101a06:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101a09:	3d ff 00 00 00       	cmp    $0xff,%eax
  101a0e:	0f 86 2f ff ff ff    	jbe    101943 <idt_init+0x16>
    }
	// set for switch from user to kernel
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  101a14:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101a19:	66 a3 68 04 11 00    	mov    %ax,0x110468
  101a1f:	66 c7 05 6a 04 11 00 	movw   $0x8,0x11046a
  101a26:	08 00 
  101a28:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a2f:	83 e0 e0             	and    $0xffffffe0,%eax
  101a32:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a37:	0f b6 05 6c 04 11 00 	movzbl 0x11046c,%eax
  101a3e:	83 e0 1f             	and    $0x1f,%eax
  101a41:	a2 6c 04 11 00       	mov    %al,0x11046c
  101a46:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a4d:	83 e0 f0             	and    $0xfffffff0,%eax
  101a50:	83 c8 0e             	or     $0xe,%eax
  101a53:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a58:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a5f:	83 e0 ef             	and    $0xffffffef,%eax
  101a62:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a67:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a6e:	83 c8 60             	or     $0x60,%eax
  101a71:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a76:	0f b6 05 6d 04 11 00 	movzbl 0x11046d,%eax
  101a7d:	83 c8 80             	or     $0xffffff80,%eax
  101a80:	a2 6d 04 11 00       	mov    %al,0x11046d
  101a85:	a1 c4 f7 10 00       	mov    0x10f7c4,%eax
  101a8a:	c1 e8 10             	shr    $0x10,%eax
  101a8d:	66 a3 6e 04 11 00    	mov    %ax,0x11046e
  101a93:	c7 45 f8 60 f5 10 00 	movl   $0x10f560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101a9a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101a9d:	0f 01 18             	lidtl  (%eax)
}
  101aa0:	90                   	nop
	// load the IDT
    lidt(&idt_pd);
}
  101aa1:	90                   	nop
  101aa2:	c9                   	leave  
  101aa3:	c3                   	ret    

00101aa4 <trapname>:

static const char *
trapname(int trapno) {
  101aa4:	f3 0f 1e fb          	endbr32 
  101aa8:	55                   	push   %ebp
  101aa9:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101aab:	8b 45 08             	mov    0x8(%ebp),%eax
  101aae:	83 f8 13             	cmp    $0x13,%eax
  101ab1:	77 0c                	ja     101abf <trapname+0x1b>
        return excnames[trapno];
  101ab3:	8b 45 08             	mov    0x8(%ebp),%eax
  101ab6:	8b 04 85 e0 3d 10 00 	mov    0x103de0(,%eax,4),%eax
  101abd:	eb 18                	jmp    101ad7 <trapname+0x33>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101abf:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101ac3:	7e 0d                	jle    101ad2 <trapname+0x2e>
  101ac5:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  101ac9:	7f 07                	jg     101ad2 <trapname+0x2e>
        return "Hardware Interrupt";
  101acb:	b8 9f 3a 10 00       	mov    $0x103a9f,%eax
  101ad0:	eb 05                	jmp    101ad7 <trapname+0x33>
    }
    return "(unknown trap)";
  101ad2:	b8 b2 3a 10 00       	mov    $0x103ab2,%eax
}
  101ad7:	5d                   	pop    %ebp
  101ad8:	c3                   	ret    

00101ad9 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101ad9:	f3 0f 1e fb          	endbr32 
  101add:	55                   	push   %ebp
  101ade:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  101ae3:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ae7:	66 83 f8 08          	cmp    $0x8,%ax
  101aeb:	0f 94 c0             	sete   %al
  101aee:	0f b6 c0             	movzbl %al,%eax
}
  101af1:	5d                   	pop    %ebp
  101af2:	c3                   	ret    

00101af3 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101af3:	f3 0f 1e fb          	endbr32 
  101af7:	55                   	push   %ebp
  101af8:	89 e5                	mov    %esp,%ebp
  101afa:	83 ec 18             	sub    $0x18,%esp
    cprintf("trapframe at %p\n", tf);
  101afd:	83 ec 08             	sub    $0x8,%esp
  101b00:	ff 75 08             	pushl  0x8(%ebp)
  101b03:	68 f3 3a 10 00       	push   $0x103af3
  101b08:	e8 68 e7 ff ff       	call   100275 <cprintf>
  101b0d:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
  101b10:	8b 45 08             	mov    0x8(%ebp),%eax
  101b13:	83 ec 0c             	sub    $0xc,%esp
  101b16:	50                   	push   %eax
  101b17:	e8 b4 01 00 00       	call   101cd0 <print_regs>
  101b1c:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  101b22:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101b26:	0f b7 c0             	movzwl %ax,%eax
  101b29:	83 ec 08             	sub    $0x8,%esp
  101b2c:	50                   	push   %eax
  101b2d:	68 04 3b 10 00       	push   $0x103b04
  101b32:	e8 3e e7 ff ff       	call   100275 <cprintf>
  101b37:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  101b3d:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101b41:	0f b7 c0             	movzwl %ax,%eax
  101b44:	83 ec 08             	sub    $0x8,%esp
  101b47:	50                   	push   %eax
  101b48:	68 17 3b 10 00       	push   $0x103b17
  101b4d:	e8 23 e7 ff ff       	call   100275 <cprintf>
  101b52:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101b55:	8b 45 08             	mov    0x8(%ebp),%eax
  101b58:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101b5c:	0f b7 c0             	movzwl %ax,%eax
  101b5f:	83 ec 08             	sub    $0x8,%esp
  101b62:	50                   	push   %eax
  101b63:	68 2a 3b 10 00       	push   $0x103b2a
  101b68:	e8 08 e7 ff ff       	call   100275 <cprintf>
  101b6d:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101b70:	8b 45 08             	mov    0x8(%ebp),%eax
  101b73:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101b77:	0f b7 c0             	movzwl %ax,%eax
  101b7a:	83 ec 08             	sub    $0x8,%esp
  101b7d:	50                   	push   %eax
  101b7e:	68 3d 3b 10 00       	push   $0x103b3d
  101b83:	e8 ed e6 ff ff       	call   100275 <cprintf>
  101b88:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  101b8e:	8b 40 30             	mov    0x30(%eax),%eax
  101b91:	83 ec 0c             	sub    $0xc,%esp
  101b94:	50                   	push   %eax
  101b95:	e8 0a ff ff ff       	call   101aa4 <trapname>
  101b9a:	83 c4 10             	add    $0x10,%esp
  101b9d:	8b 55 08             	mov    0x8(%ebp),%edx
  101ba0:	8b 52 30             	mov    0x30(%edx),%edx
  101ba3:	83 ec 04             	sub    $0x4,%esp
  101ba6:	50                   	push   %eax
  101ba7:	52                   	push   %edx
  101ba8:	68 50 3b 10 00       	push   $0x103b50
  101bad:	e8 c3 e6 ff ff       	call   100275 <cprintf>
  101bb2:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
  101bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  101bb8:	8b 40 34             	mov    0x34(%eax),%eax
  101bbb:	83 ec 08             	sub    $0x8,%esp
  101bbe:	50                   	push   %eax
  101bbf:	68 62 3b 10 00       	push   $0x103b62
  101bc4:	e8 ac e6 ff ff       	call   100275 <cprintf>
  101bc9:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101bcc:	8b 45 08             	mov    0x8(%ebp),%eax
  101bcf:	8b 40 38             	mov    0x38(%eax),%eax
  101bd2:	83 ec 08             	sub    $0x8,%esp
  101bd5:	50                   	push   %eax
  101bd6:	68 71 3b 10 00       	push   $0x103b71
  101bdb:	e8 95 e6 ff ff       	call   100275 <cprintf>
  101be0:	83 c4 10             	add    $0x10,%esp
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101be3:	8b 45 08             	mov    0x8(%ebp),%eax
  101be6:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101bea:	0f b7 c0             	movzwl %ax,%eax
  101bed:	83 ec 08             	sub    $0x8,%esp
  101bf0:	50                   	push   %eax
  101bf1:	68 80 3b 10 00       	push   $0x103b80
  101bf6:	e8 7a e6 ff ff       	call   100275 <cprintf>
  101bfb:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  101c01:	8b 40 40             	mov    0x40(%eax),%eax
  101c04:	83 ec 08             	sub    $0x8,%esp
  101c07:	50                   	push   %eax
  101c08:	68 93 3b 10 00       	push   $0x103b93
  101c0d:	e8 63 e6 ff ff       	call   100275 <cprintf>
  101c12:	83 c4 10             	add    $0x10,%esp

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c15:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101c1c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101c23:	eb 3f                	jmp    101c64 <print_trapframe+0x171>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101c25:	8b 45 08             	mov    0x8(%ebp),%eax
  101c28:	8b 50 40             	mov    0x40(%eax),%edx
  101c2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101c2e:	21 d0                	and    %edx,%eax
  101c30:	85 c0                	test   %eax,%eax
  101c32:	74 29                	je     101c5d <print_trapframe+0x16a>
  101c34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c37:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c3e:	85 c0                	test   %eax,%eax
  101c40:	74 1b                	je     101c5d <print_trapframe+0x16a>
            cprintf("%s,", IA32flags[i]);
  101c42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c45:	8b 04 85 80 f5 10 00 	mov    0x10f580(,%eax,4),%eax
  101c4c:	83 ec 08             	sub    $0x8,%esp
  101c4f:	50                   	push   %eax
  101c50:	68 a2 3b 10 00       	push   $0x103ba2
  101c55:	e8 1b e6 ff ff       	call   100275 <cprintf>
  101c5a:	83 c4 10             	add    $0x10,%esp
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101c5d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101c61:	d1 65 f0             	shll   -0x10(%ebp)
  101c64:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101c67:	83 f8 17             	cmp    $0x17,%eax
  101c6a:	76 b9                	jbe    101c25 <print_trapframe+0x132>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101c6c:	8b 45 08             	mov    0x8(%ebp),%eax
  101c6f:	8b 40 40             	mov    0x40(%eax),%eax
  101c72:	c1 e8 0c             	shr    $0xc,%eax
  101c75:	83 e0 03             	and    $0x3,%eax
  101c78:	83 ec 08             	sub    $0x8,%esp
  101c7b:	50                   	push   %eax
  101c7c:	68 a6 3b 10 00       	push   $0x103ba6
  101c81:	e8 ef e5 ff ff       	call   100275 <cprintf>
  101c86:	83 c4 10             	add    $0x10,%esp

    if (!trap_in_kernel(tf)) {
  101c89:	83 ec 0c             	sub    $0xc,%esp
  101c8c:	ff 75 08             	pushl  0x8(%ebp)
  101c8f:	e8 45 fe ff ff       	call   101ad9 <trap_in_kernel>
  101c94:	83 c4 10             	add    $0x10,%esp
  101c97:	85 c0                	test   %eax,%eax
  101c99:	75 32                	jne    101ccd <print_trapframe+0x1da>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  101c9e:	8b 40 44             	mov    0x44(%eax),%eax
  101ca1:	83 ec 08             	sub    $0x8,%esp
  101ca4:	50                   	push   %eax
  101ca5:	68 af 3b 10 00       	push   $0x103baf
  101caa:	e8 c6 e5 ff ff       	call   100275 <cprintf>
  101caf:	83 c4 10             	add    $0x10,%esp
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  101cb5:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101cb9:	0f b7 c0             	movzwl %ax,%eax
  101cbc:	83 ec 08             	sub    $0x8,%esp
  101cbf:	50                   	push   %eax
  101cc0:	68 be 3b 10 00       	push   $0x103bbe
  101cc5:	e8 ab e5 ff ff       	call   100275 <cprintf>
  101cca:	83 c4 10             	add    $0x10,%esp
    }
}
  101ccd:	90                   	nop
  101cce:	c9                   	leave  
  101ccf:	c3                   	ret    

00101cd0 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101cd0:	f3 0f 1e fb          	endbr32 
  101cd4:	55                   	push   %ebp
  101cd5:	89 e5                	mov    %esp,%ebp
  101cd7:	83 ec 08             	sub    $0x8,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101cda:	8b 45 08             	mov    0x8(%ebp),%eax
  101cdd:	8b 00                	mov    (%eax),%eax
  101cdf:	83 ec 08             	sub    $0x8,%esp
  101ce2:	50                   	push   %eax
  101ce3:	68 d1 3b 10 00       	push   $0x103bd1
  101ce8:	e8 88 e5 ff ff       	call   100275 <cprintf>
  101ced:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  101cf3:	8b 40 04             	mov    0x4(%eax),%eax
  101cf6:	83 ec 08             	sub    $0x8,%esp
  101cf9:	50                   	push   %eax
  101cfa:	68 e0 3b 10 00       	push   $0x103be0
  101cff:	e8 71 e5 ff ff       	call   100275 <cprintf>
  101d04:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101d07:	8b 45 08             	mov    0x8(%ebp),%eax
  101d0a:	8b 40 08             	mov    0x8(%eax),%eax
  101d0d:	83 ec 08             	sub    $0x8,%esp
  101d10:	50                   	push   %eax
  101d11:	68 ef 3b 10 00       	push   $0x103bef
  101d16:	e8 5a e5 ff ff       	call   100275 <cprintf>
  101d1b:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  101d21:	8b 40 0c             	mov    0xc(%eax),%eax
  101d24:	83 ec 08             	sub    $0x8,%esp
  101d27:	50                   	push   %eax
  101d28:	68 fe 3b 10 00       	push   $0x103bfe
  101d2d:	e8 43 e5 ff ff       	call   100275 <cprintf>
  101d32:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101d35:	8b 45 08             	mov    0x8(%ebp),%eax
  101d38:	8b 40 10             	mov    0x10(%eax),%eax
  101d3b:	83 ec 08             	sub    $0x8,%esp
  101d3e:	50                   	push   %eax
  101d3f:	68 0d 3c 10 00       	push   $0x103c0d
  101d44:	e8 2c e5 ff ff       	call   100275 <cprintf>
  101d49:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  101d4f:	8b 40 14             	mov    0x14(%eax),%eax
  101d52:	83 ec 08             	sub    $0x8,%esp
  101d55:	50                   	push   %eax
  101d56:	68 1c 3c 10 00       	push   $0x103c1c
  101d5b:	e8 15 e5 ff ff       	call   100275 <cprintf>
  101d60:	83 c4 10             	add    $0x10,%esp
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101d63:	8b 45 08             	mov    0x8(%ebp),%eax
  101d66:	8b 40 18             	mov    0x18(%eax),%eax
  101d69:	83 ec 08             	sub    $0x8,%esp
  101d6c:	50                   	push   %eax
  101d6d:	68 2b 3c 10 00       	push   $0x103c2b
  101d72:	e8 fe e4 ff ff       	call   100275 <cprintf>
  101d77:	83 c4 10             	add    $0x10,%esp
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  101d7d:	8b 40 1c             	mov    0x1c(%eax),%eax
  101d80:	83 ec 08             	sub    $0x8,%esp
  101d83:	50                   	push   %eax
  101d84:	68 3a 3c 10 00       	push   $0x103c3a
  101d89:	e8 e7 e4 ff ff       	call   100275 <cprintf>
  101d8e:	83 c4 10             	add    $0x10,%esp
}
  101d91:	90                   	nop
  101d92:	c9                   	leave  
  101d93:	c3                   	ret    

00101d94 <trap_dispatch>:
/* temporary trapframe or pointer to trapframe */
struct trapframe switchk2u, *switchu2k;

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101d94:	f3 0f 1e fb          	endbr32 
  101d98:	55                   	push   %ebp
  101d99:	89 e5                	mov    %esp,%ebp
  101d9b:	57                   	push   %edi
  101d9c:	56                   	push   %esi
  101d9d:	53                   	push   %ebx
  101d9e:	83 ec 1c             	sub    $0x1c,%esp
    char c;

    switch (tf->tf_trapno) {
  101da1:	8b 45 08             	mov    0x8(%ebp),%eax
  101da4:	8b 40 30             	mov    0x30(%eax),%eax
  101da7:	83 f8 79             	cmp    $0x79,%eax
  101daa:	0f 84 6e 01 00 00    	je     101f1e <trap_dispatch+0x18a>
  101db0:	83 f8 79             	cmp    $0x79,%eax
  101db3:	0f 87 db 01 00 00    	ja     101f94 <trap_dispatch+0x200>
  101db9:	83 f8 78             	cmp    $0x78,%eax
  101dbc:	0f 84 c0 00 00 00    	je     101e82 <trap_dispatch+0xee>
  101dc2:	83 f8 78             	cmp    $0x78,%eax
  101dc5:	0f 87 c9 01 00 00    	ja     101f94 <trap_dispatch+0x200>
  101dcb:	83 f8 2f             	cmp    $0x2f,%eax
  101dce:	0f 87 c0 01 00 00    	ja     101f94 <trap_dispatch+0x200>
  101dd4:	83 f8 2e             	cmp    $0x2e,%eax
  101dd7:	0f 83 ed 01 00 00    	jae    101fca <trap_dispatch+0x236>
  101ddd:	83 f8 24             	cmp    $0x24,%eax
  101de0:	74 52                	je     101e34 <trap_dispatch+0xa0>
  101de2:	83 f8 24             	cmp    $0x24,%eax
  101de5:	0f 87 a9 01 00 00    	ja     101f94 <trap_dispatch+0x200>
  101deb:	83 f8 20             	cmp    $0x20,%eax
  101dee:	74 0a                	je     101dfa <trap_dispatch+0x66>
  101df0:	83 f8 21             	cmp    $0x21,%eax
  101df3:	74 66                	je     101e5b <trap_dispatch+0xc7>
  101df5:	e9 9a 01 00 00       	jmp    101f94 <trap_dispatch+0x200>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks ++;
  101dfa:	a1 08 09 11 00       	mov    0x110908,%eax
  101dff:	83 c0 01             	add    $0x1,%eax
  101e02:	a3 08 09 11 00       	mov    %eax,0x110908
        if (ticks % TICK_NUM == 0) {
  101e07:	8b 0d 08 09 11 00    	mov    0x110908,%ecx
  101e0d:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101e12:	89 c8                	mov    %ecx,%eax
  101e14:	f7 e2                	mul    %edx
  101e16:	89 d0                	mov    %edx,%eax
  101e18:	c1 e8 05             	shr    $0x5,%eax
  101e1b:	6b c0 64             	imul   $0x64,%eax,%eax
  101e1e:	29 c1                	sub    %eax,%ecx
  101e20:	89 c8                	mov    %ecx,%eax
  101e22:	85 c0                	test   %eax,%eax
  101e24:	0f 85 a3 01 00 00    	jne    101fcd <trap_dispatch+0x239>
            print_ticks();
  101e2a:	e8 be fa ff ff       	call   1018ed <print_ticks>
        }
        break;
  101e2f:	e9 99 01 00 00       	jmp    101fcd <trap_dispatch+0x239>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101e34:	e8 5d f8 ff ff       	call   101696 <cons_getc>
  101e39:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101e3c:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101e40:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101e44:	83 ec 04             	sub    $0x4,%esp
  101e47:	52                   	push   %edx
  101e48:	50                   	push   %eax
  101e49:	68 49 3c 10 00       	push   $0x103c49
  101e4e:	e8 22 e4 ff ff       	call   100275 <cprintf>
  101e53:	83 c4 10             	add    $0x10,%esp
        break;
  101e56:	e9 79 01 00 00       	jmp    101fd4 <trap_dispatch+0x240>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101e5b:	e8 36 f8 ff ff       	call   101696 <cons_getc>
  101e60:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101e63:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101e67:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101e6b:	83 ec 04             	sub    $0x4,%esp
  101e6e:	52                   	push   %edx
  101e6f:	50                   	push   %eax
  101e70:	68 5b 3c 10 00       	push   $0x103c5b
  101e75:	e8 fb e3 ff ff       	call   100275 <cprintf>
  101e7a:	83 c4 10             	add    $0x10,%esp
        break;
  101e7d:	e9 52 01 00 00       	jmp    101fd4 <trap_dispatch+0x240>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
        if (tf->tf_cs != USER_CS) {
  101e82:	8b 45 08             	mov    0x8(%ebp),%eax
  101e85:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e89:	66 83 f8 1b          	cmp    $0x1b,%ax
  101e8d:	0f 84 3d 01 00 00    	je     101fd0 <trap_dispatch+0x23c>
            switchk2u = *tf;
  101e93:	8b 55 08             	mov    0x8(%ebp),%edx
  101e96:	b8 20 09 11 00       	mov    $0x110920,%eax
  101e9b:	89 d3                	mov    %edx,%ebx
  101e9d:	ba 4c 00 00 00       	mov    $0x4c,%edx
  101ea2:	8b 0b                	mov    (%ebx),%ecx
  101ea4:	89 08                	mov    %ecx,(%eax)
  101ea6:	8b 4c 13 fc          	mov    -0x4(%ebx,%edx,1),%ecx
  101eaa:	89 4c 10 fc          	mov    %ecx,-0x4(%eax,%edx,1)
  101eae:	8d 78 04             	lea    0x4(%eax),%edi
  101eb1:	83 e7 fc             	and    $0xfffffffc,%edi
  101eb4:	29 f8                	sub    %edi,%eax
  101eb6:	29 c3                	sub    %eax,%ebx
  101eb8:	01 c2                	add    %eax,%edx
  101eba:	83 e2 fc             	and    $0xfffffffc,%edx
  101ebd:	89 d0                	mov    %edx,%eax
  101ebf:	c1 e8 02             	shr    $0x2,%eax
  101ec2:	89 de                	mov    %ebx,%esi
  101ec4:	89 c1                	mov    %eax,%ecx
  101ec6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
            switchk2u.tf_cs = USER_CS;
  101ec8:	66 c7 05 5c 09 11 00 	movw   $0x1b,0x11095c
  101ecf:	1b 00 
            switchk2u.tf_ds = switchk2u.tf_es = switchk2u.tf_ss = USER_DS;
  101ed1:	66 c7 05 68 09 11 00 	movw   $0x23,0x110968
  101ed8:	23 00 
  101eda:	0f b7 05 68 09 11 00 	movzwl 0x110968,%eax
  101ee1:	66 a3 48 09 11 00    	mov    %ax,0x110948
  101ee7:	0f b7 05 48 09 11 00 	movzwl 0x110948,%eax
  101eee:	66 a3 4c 09 11 00    	mov    %ax,0x11094c
            switchk2u.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;
  101ef4:	8b 45 08             	mov    0x8(%ebp),%eax
  101ef7:	83 c0 44             	add    $0x44,%eax
  101efa:	a3 64 09 11 00       	mov    %eax,0x110964
		
            // set eflags, make sure ucore can use io under user mode.
            // if CPL > IOPL, then cpu will generate a general protection.
            switchk2u.tf_eflags |= FL_IOPL_MASK;
  101eff:	a1 60 09 11 00       	mov    0x110960,%eax
  101f04:	80 cc 30             	or     $0x30,%ah
  101f07:	a3 60 09 11 00       	mov    %eax,0x110960
		
            // set temporary stack
            // then iret will jump to the right stack
            *((uint32_t *)tf - 1) = (uint32_t)&switchk2u;
  101f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  101f0f:	83 e8 04             	sub    $0x4,%eax
  101f12:	ba 20 09 11 00       	mov    $0x110920,%edx
  101f17:	89 10                	mov    %edx,(%eax)
        }
        break;
  101f19:	e9 b2 00 00 00       	jmp    101fd0 <trap_dispatch+0x23c>
    case T_SWITCH_TOK:
        if (tf->tf_cs != KERNEL_CS) {
  101f1e:	8b 45 08             	mov    0x8(%ebp),%eax
  101f21:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101f25:	66 83 f8 08          	cmp    $0x8,%ax
  101f29:	0f 84 a4 00 00 00    	je     101fd3 <trap_dispatch+0x23f>
            tf->tf_cs = KERNEL_CS;
  101f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  101f32:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  101f38:	8b 45 08             	mov    0x8(%ebp),%eax
  101f3b:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101f41:	8b 45 08             	mov    0x8(%ebp),%eax
  101f44:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101f48:	8b 45 08             	mov    0x8(%ebp),%eax
  101f4b:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  101f4f:	8b 45 08             	mov    0x8(%ebp),%eax
  101f52:	8b 40 40             	mov    0x40(%eax),%eax
  101f55:	80 e4 cf             	and    $0xcf,%ah
  101f58:	89 c2                	mov    %eax,%edx
  101f5a:	8b 45 08             	mov    0x8(%ebp),%eax
  101f5d:	89 50 40             	mov    %edx,0x40(%eax)
            switchu2k = (struct trapframe *)(tf->tf_esp - (sizeof(struct trapframe) - 8));
  101f60:	8b 45 08             	mov    0x8(%ebp),%eax
  101f63:	8b 40 44             	mov    0x44(%eax),%eax
  101f66:	83 e8 44             	sub    $0x44,%eax
  101f69:	a3 6c 09 11 00       	mov    %eax,0x11096c
            memmove(switchu2k, tf, sizeof(struct trapframe) - 8);
  101f6e:	a1 6c 09 11 00       	mov    0x11096c,%eax
  101f73:	83 ec 04             	sub    $0x4,%esp
  101f76:	6a 44                	push   $0x44
  101f78:	ff 75 08             	pushl  0x8(%ebp)
  101f7b:	50                   	push   %eax
  101f7c:	e8 eb 0f 00 00       	call   102f6c <memmove>
  101f81:	83 c4 10             	add    $0x10,%esp
            *((uint32_t *)tf - 1) = (uint32_t)switchu2k;
  101f84:	8b 15 6c 09 11 00    	mov    0x11096c,%edx
  101f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  101f8d:	83 e8 04             	sub    $0x4,%eax
  101f90:	89 10                	mov    %edx,(%eax)
        }
        break;
  101f92:	eb 3f                	jmp    101fd3 <trap_dispatch+0x23f>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101f94:	8b 45 08             	mov    0x8(%ebp),%eax
  101f97:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101f9b:	0f b7 c0             	movzwl %ax,%eax
  101f9e:	83 e0 03             	and    $0x3,%eax
  101fa1:	85 c0                	test   %eax,%eax
  101fa3:	75 2f                	jne    101fd4 <trap_dispatch+0x240>
            print_trapframe(tf);
  101fa5:	83 ec 0c             	sub    $0xc,%esp
  101fa8:	ff 75 08             	pushl  0x8(%ebp)
  101fab:	e8 43 fb ff ff       	call   101af3 <print_trapframe>
  101fb0:	83 c4 10             	add    $0x10,%esp
            panic("unexpected trap in kernel.\n");
  101fb3:	83 ec 04             	sub    $0x4,%esp
  101fb6:	68 6a 3c 10 00       	push   $0x103c6a
  101fbb:	68 d2 00 00 00       	push   $0xd2
  101fc0:	68 8e 3a 10 00       	push   $0x103a8e
  101fc5:	e8 26 e4 ff ff       	call   1003f0 <__panic>
        break;
  101fca:	90                   	nop
  101fcb:	eb 07                	jmp    101fd4 <trap_dispatch+0x240>
        break;
  101fcd:	90                   	nop
  101fce:	eb 04                	jmp    101fd4 <trap_dispatch+0x240>
        break;
  101fd0:	90                   	nop
  101fd1:	eb 01                	jmp    101fd4 <trap_dispatch+0x240>
        break;
  101fd3:	90                   	nop
        }
    }
}
  101fd4:	90                   	nop
  101fd5:	8d 65 f4             	lea    -0xc(%ebp),%esp
  101fd8:	5b                   	pop    %ebx
  101fd9:	5e                   	pop    %esi
  101fda:	5f                   	pop    %edi
  101fdb:	5d                   	pop    %ebp
  101fdc:	c3                   	ret    

00101fdd <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101fdd:	f3 0f 1e fb          	endbr32 
  101fe1:	55                   	push   %ebp
  101fe2:	89 e5                	mov    %esp,%ebp
  101fe4:	83 ec 08             	sub    $0x8,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101fe7:	83 ec 0c             	sub    $0xc,%esp
  101fea:	ff 75 08             	pushl  0x8(%ebp)
  101fed:	e8 a2 fd ff ff       	call   101d94 <trap_dispatch>
  101ff2:	83 c4 10             	add    $0x10,%esp
}
  101ff5:	90                   	nop
  101ff6:	c9                   	leave  
  101ff7:	c3                   	ret    

00101ff8 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101ff8:	6a 00                	push   $0x0
  pushl $0
  101ffa:	6a 00                	push   $0x0
  jmp __alltraps
  101ffc:	e9 67 0a 00 00       	jmp    102a68 <__alltraps>

00102001 <vector1>:
.globl vector1
vector1:
  pushl $0
  102001:	6a 00                	push   $0x0
  pushl $1
  102003:	6a 01                	push   $0x1
  jmp __alltraps
  102005:	e9 5e 0a 00 00       	jmp    102a68 <__alltraps>

0010200a <vector2>:
.globl vector2
vector2:
  pushl $0
  10200a:	6a 00                	push   $0x0
  pushl $2
  10200c:	6a 02                	push   $0x2
  jmp __alltraps
  10200e:	e9 55 0a 00 00       	jmp    102a68 <__alltraps>

00102013 <vector3>:
.globl vector3
vector3:
  pushl $0
  102013:	6a 00                	push   $0x0
  pushl $3
  102015:	6a 03                	push   $0x3
  jmp __alltraps
  102017:	e9 4c 0a 00 00       	jmp    102a68 <__alltraps>

0010201c <vector4>:
.globl vector4
vector4:
  pushl $0
  10201c:	6a 00                	push   $0x0
  pushl $4
  10201e:	6a 04                	push   $0x4
  jmp __alltraps
  102020:	e9 43 0a 00 00       	jmp    102a68 <__alltraps>

00102025 <vector5>:
.globl vector5
vector5:
  pushl $0
  102025:	6a 00                	push   $0x0
  pushl $5
  102027:	6a 05                	push   $0x5
  jmp __alltraps
  102029:	e9 3a 0a 00 00       	jmp    102a68 <__alltraps>

0010202e <vector6>:
.globl vector6
vector6:
  pushl $0
  10202e:	6a 00                	push   $0x0
  pushl $6
  102030:	6a 06                	push   $0x6
  jmp __alltraps
  102032:	e9 31 0a 00 00       	jmp    102a68 <__alltraps>

00102037 <vector7>:
.globl vector7
vector7:
  pushl $0
  102037:	6a 00                	push   $0x0
  pushl $7
  102039:	6a 07                	push   $0x7
  jmp __alltraps
  10203b:	e9 28 0a 00 00       	jmp    102a68 <__alltraps>

00102040 <vector8>:
.globl vector8
vector8:
  pushl $8
  102040:	6a 08                	push   $0x8
  jmp __alltraps
  102042:	e9 21 0a 00 00       	jmp    102a68 <__alltraps>

00102047 <vector9>:
.globl vector9
vector9:
  pushl $9
  102047:	6a 09                	push   $0x9
  jmp __alltraps
  102049:	e9 1a 0a 00 00       	jmp    102a68 <__alltraps>

0010204e <vector10>:
.globl vector10
vector10:
  pushl $10
  10204e:	6a 0a                	push   $0xa
  jmp __alltraps
  102050:	e9 13 0a 00 00       	jmp    102a68 <__alltraps>

00102055 <vector11>:
.globl vector11
vector11:
  pushl $11
  102055:	6a 0b                	push   $0xb
  jmp __alltraps
  102057:	e9 0c 0a 00 00       	jmp    102a68 <__alltraps>

0010205c <vector12>:
.globl vector12
vector12:
  pushl $12
  10205c:	6a 0c                	push   $0xc
  jmp __alltraps
  10205e:	e9 05 0a 00 00       	jmp    102a68 <__alltraps>

00102063 <vector13>:
.globl vector13
vector13:
  pushl $13
  102063:	6a 0d                	push   $0xd
  jmp __alltraps
  102065:	e9 fe 09 00 00       	jmp    102a68 <__alltraps>

0010206a <vector14>:
.globl vector14
vector14:
  pushl $14
  10206a:	6a 0e                	push   $0xe
  jmp __alltraps
  10206c:	e9 f7 09 00 00       	jmp    102a68 <__alltraps>

00102071 <vector15>:
.globl vector15
vector15:
  pushl $0
  102071:	6a 00                	push   $0x0
  pushl $15
  102073:	6a 0f                	push   $0xf
  jmp __alltraps
  102075:	e9 ee 09 00 00       	jmp    102a68 <__alltraps>

0010207a <vector16>:
.globl vector16
vector16:
  pushl $0
  10207a:	6a 00                	push   $0x0
  pushl $16
  10207c:	6a 10                	push   $0x10
  jmp __alltraps
  10207e:	e9 e5 09 00 00       	jmp    102a68 <__alltraps>

00102083 <vector17>:
.globl vector17
vector17:
  pushl $17
  102083:	6a 11                	push   $0x11
  jmp __alltraps
  102085:	e9 de 09 00 00       	jmp    102a68 <__alltraps>

0010208a <vector18>:
.globl vector18
vector18:
  pushl $0
  10208a:	6a 00                	push   $0x0
  pushl $18
  10208c:	6a 12                	push   $0x12
  jmp __alltraps
  10208e:	e9 d5 09 00 00       	jmp    102a68 <__alltraps>

00102093 <vector19>:
.globl vector19
vector19:
  pushl $0
  102093:	6a 00                	push   $0x0
  pushl $19
  102095:	6a 13                	push   $0x13
  jmp __alltraps
  102097:	e9 cc 09 00 00       	jmp    102a68 <__alltraps>

0010209c <vector20>:
.globl vector20
vector20:
  pushl $0
  10209c:	6a 00                	push   $0x0
  pushl $20
  10209e:	6a 14                	push   $0x14
  jmp __alltraps
  1020a0:	e9 c3 09 00 00       	jmp    102a68 <__alltraps>

001020a5 <vector21>:
.globl vector21
vector21:
  pushl $0
  1020a5:	6a 00                	push   $0x0
  pushl $21
  1020a7:	6a 15                	push   $0x15
  jmp __alltraps
  1020a9:	e9 ba 09 00 00       	jmp    102a68 <__alltraps>

001020ae <vector22>:
.globl vector22
vector22:
  pushl $0
  1020ae:	6a 00                	push   $0x0
  pushl $22
  1020b0:	6a 16                	push   $0x16
  jmp __alltraps
  1020b2:	e9 b1 09 00 00       	jmp    102a68 <__alltraps>

001020b7 <vector23>:
.globl vector23
vector23:
  pushl $0
  1020b7:	6a 00                	push   $0x0
  pushl $23
  1020b9:	6a 17                	push   $0x17
  jmp __alltraps
  1020bb:	e9 a8 09 00 00       	jmp    102a68 <__alltraps>

001020c0 <vector24>:
.globl vector24
vector24:
  pushl $0
  1020c0:	6a 00                	push   $0x0
  pushl $24
  1020c2:	6a 18                	push   $0x18
  jmp __alltraps
  1020c4:	e9 9f 09 00 00       	jmp    102a68 <__alltraps>

001020c9 <vector25>:
.globl vector25
vector25:
  pushl $0
  1020c9:	6a 00                	push   $0x0
  pushl $25
  1020cb:	6a 19                	push   $0x19
  jmp __alltraps
  1020cd:	e9 96 09 00 00       	jmp    102a68 <__alltraps>

001020d2 <vector26>:
.globl vector26
vector26:
  pushl $0
  1020d2:	6a 00                	push   $0x0
  pushl $26
  1020d4:	6a 1a                	push   $0x1a
  jmp __alltraps
  1020d6:	e9 8d 09 00 00       	jmp    102a68 <__alltraps>

001020db <vector27>:
.globl vector27
vector27:
  pushl $0
  1020db:	6a 00                	push   $0x0
  pushl $27
  1020dd:	6a 1b                	push   $0x1b
  jmp __alltraps
  1020df:	e9 84 09 00 00       	jmp    102a68 <__alltraps>

001020e4 <vector28>:
.globl vector28
vector28:
  pushl $0
  1020e4:	6a 00                	push   $0x0
  pushl $28
  1020e6:	6a 1c                	push   $0x1c
  jmp __alltraps
  1020e8:	e9 7b 09 00 00       	jmp    102a68 <__alltraps>

001020ed <vector29>:
.globl vector29
vector29:
  pushl $0
  1020ed:	6a 00                	push   $0x0
  pushl $29
  1020ef:	6a 1d                	push   $0x1d
  jmp __alltraps
  1020f1:	e9 72 09 00 00       	jmp    102a68 <__alltraps>

001020f6 <vector30>:
.globl vector30
vector30:
  pushl $0
  1020f6:	6a 00                	push   $0x0
  pushl $30
  1020f8:	6a 1e                	push   $0x1e
  jmp __alltraps
  1020fa:	e9 69 09 00 00       	jmp    102a68 <__alltraps>

001020ff <vector31>:
.globl vector31
vector31:
  pushl $0
  1020ff:	6a 00                	push   $0x0
  pushl $31
  102101:	6a 1f                	push   $0x1f
  jmp __alltraps
  102103:	e9 60 09 00 00       	jmp    102a68 <__alltraps>

00102108 <vector32>:
.globl vector32
vector32:
  pushl $0
  102108:	6a 00                	push   $0x0
  pushl $32
  10210a:	6a 20                	push   $0x20
  jmp __alltraps
  10210c:	e9 57 09 00 00       	jmp    102a68 <__alltraps>

00102111 <vector33>:
.globl vector33
vector33:
  pushl $0
  102111:	6a 00                	push   $0x0
  pushl $33
  102113:	6a 21                	push   $0x21
  jmp __alltraps
  102115:	e9 4e 09 00 00       	jmp    102a68 <__alltraps>

0010211a <vector34>:
.globl vector34
vector34:
  pushl $0
  10211a:	6a 00                	push   $0x0
  pushl $34
  10211c:	6a 22                	push   $0x22
  jmp __alltraps
  10211e:	e9 45 09 00 00       	jmp    102a68 <__alltraps>

00102123 <vector35>:
.globl vector35
vector35:
  pushl $0
  102123:	6a 00                	push   $0x0
  pushl $35
  102125:	6a 23                	push   $0x23
  jmp __alltraps
  102127:	e9 3c 09 00 00       	jmp    102a68 <__alltraps>

0010212c <vector36>:
.globl vector36
vector36:
  pushl $0
  10212c:	6a 00                	push   $0x0
  pushl $36
  10212e:	6a 24                	push   $0x24
  jmp __alltraps
  102130:	e9 33 09 00 00       	jmp    102a68 <__alltraps>

00102135 <vector37>:
.globl vector37
vector37:
  pushl $0
  102135:	6a 00                	push   $0x0
  pushl $37
  102137:	6a 25                	push   $0x25
  jmp __alltraps
  102139:	e9 2a 09 00 00       	jmp    102a68 <__alltraps>

0010213e <vector38>:
.globl vector38
vector38:
  pushl $0
  10213e:	6a 00                	push   $0x0
  pushl $38
  102140:	6a 26                	push   $0x26
  jmp __alltraps
  102142:	e9 21 09 00 00       	jmp    102a68 <__alltraps>

00102147 <vector39>:
.globl vector39
vector39:
  pushl $0
  102147:	6a 00                	push   $0x0
  pushl $39
  102149:	6a 27                	push   $0x27
  jmp __alltraps
  10214b:	e9 18 09 00 00       	jmp    102a68 <__alltraps>

00102150 <vector40>:
.globl vector40
vector40:
  pushl $0
  102150:	6a 00                	push   $0x0
  pushl $40
  102152:	6a 28                	push   $0x28
  jmp __alltraps
  102154:	e9 0f 09 00 00       	jmp    102a68 <__alltraps>

00102159 <vector41>:
.globl vector41
vector41:
  pushl $0
  102159:	6a 00                	push   $0x0
  pushl $41
  10215b:	6a 29                	push   $0x29
  jmp __alltraps
  10215d:	e9 06 09 00 00       	jmp    102a68 <__alltraps>

00102162 <vector42>:
.globl vector42
vector42:
  pushl $0
  102162:	6a 00                	push   $0x0
  pushl $42
  102164:	6a 2a                	push   $0x2a
  jmp __alltraps
  102166:	e9 fd 08 00 00       	jmp    102a68 <__alltraps>

0010216b <vector43>:
.globl vector43
vector43:
  pushl $0
  10216b:	6a 00                	push   $0x0
  pushl $43
  10216d:	6a 2b                	push   $0x2b
  jmp __alltraps
  10216f:	e9 f4 08 00 00       	jmp    102a68 <__alltraps>

00102174 <vector44>:
.globl vector44
vector44:
  pushl $0
  102174:	6a 00                	push   $0x0
  pushl $44
  102176:	6a 2c                	push   $0x2c
  jmp __alltraps
  102178:	e9 eb 08 00 00       	jmp    102a68 <__alltraps>

0010217d <vector45>:
.globl vector45
vector45:
  pushl $0
  10217d:	6a 00                	push   $0x0
  pushl $45
  10217f:	6a 2d                	push   $0x2d
  jmp __alltraps
  102181:	e9 e2 08 00 00       	jmp    102a68 <__alltraps>

00102186 <vector46>:
.globl vector46
vector46:
  pushl $0
  102186:	6a 00                	push   $0x0
  pushl $46
  102188:	6a 2e                	push   $0x2e
  jmp __alltraps
  10218a:	e9 d9 08 00 00       	jmp    102a68 <__alltraps>

0010218f <vector47>:
.globl vector47
vector47:
  pushl $0
  10218f:	6a 00                	push   $0x0
  pushl $47
  102191:	6a 2f                	push   $0x2f
  jmp __alltraps
  102193:	e9 d0 08 00 00       	jmp    102a68 <__alltraps>

00102198 <vector48>:
.globl vector48
vector48:
  pushl $0
  102198:	6a 00                	push   $0x0
  pushl $48
  10219a:	6a 30                	push   $0x30
  jmp __alltraps
  10219c:	e9 c7 08 00 00       	jmp    102a68 <__alltraps>

001021a1 <vector49>:
.globl vector49
vector49:
  pushl $0
  1021a1:	6a 00                	push   $0x0
  pushl $49
  1021a3:	6a 31                	push   $0x31
  jmp __alltraps
  1021a5:	e9 be 08 00 00       	jmp    102a68 <__alltraps>

001021aa <vector50>:
.globl vector50
vector50:
  pushl $0
  1021aa:	6a 00                	push   $0x0
  pushl $50
  1021ac:	6a 32                	push   $0x32
  jmp __alltraps
  1021ae:	e9 b5 08 00 00       	jmp    102a68 <__alltraps>

001021b3 <vector51>:
.globl vector51
vector51:
  pushl $0
  1021b3:	6a 00                	push   $0x0
  pushl $51
  1021b5:	6a 33                	push   $0x33
  jmp __alltraps
  1021b7:	e9 ac 08 00 00       	jmp    102a68 <__alltraps>

001021bc <vector52>:
.globl vector52
vector52:
  pushl $0
  1021bc:	6a 00                	push   $0x0
  pushl $52
  1021be:	6a 34                	push   $0x34
  jmp __alltraps
  1021c0:	e9 a3 08 00 00       	jmp    102a68 <__alltraps>

001021c5 <vector53>:
.globl vector53
vector53:
  pushl $0
  1021c5:	6a 00                	push   $0x0
  pushl $53
  1021c7:	6a 35                	push   $0x35
  jmp __alltraps
  1021c9:	e9 9a 08 00 00       	jmp    102a68 <__alltraps>

001021ce <vector54>:
.globl vector54
vector54:
  pushl $0
  1021ce:	6a 00                	push   $0x0
  pushl $54
  1021d0:	6a 36                	push   $0x36
  jmp __alltraps
  1021d2:	e9 91 08 00 00       	jmp    102a68 <__alltraps>

001021d7 <vector55>:
.globl vector55
vector55:
  pushl $0
  1021d7:	6a 00                	push   $0x0
  pushl $55
  1021d9:	6a 37                	push   $0x37
  jmp __alltraps
  1021db:	e9 88 08 00 00       	jmp    102a68 <__alltraps>

001021e0 <vector56>:
.globl vector56
vector56:
  pushl $0
  1021e0:	6a 00                	push   $0x0
  pushl $56
  1021e2:	6a 38                	push   $0x38
  jmp __alltraps
  1021e4:	e9 7f 08 00 00       	jmp    102a68 <__alltraps>

001021e9 <vector57>:
.globl vector57
vector57:
  pushl $0
  1021e9:	6a 00                	push   $0x0
  pushl $57
  1021eb:	6a 39                	push   $0x39
  jmp __alltraps
  1021ed:	e9 76 08 00 00       	jmp    102a68 <__alltraps>

001021f2 <vector58>:
.globl vector58
vector58:
  pushl $0
  1021f2:	6a 00                	push   $0x0
  pushl $58
  1021f4:	6a 3a                	push   $0x3a
  jmp __alltraps
  1021f6:	e9 6d 08 00 00       	jmp    102a68 <__alltraps>

001021fb <vector59>:
.globl vector59
vector59:
  pushl $0
  1021fb:	6a 00                	push   $0x0
  pushl $59
  1021fd:	6a 3b                	push   $0x3b
  jmp __alltraps
  1021ff:	e9 64 08 00 00       	jmp    102a68 <__alltraps>

00102204 <vector60>:
.globl vector60
vector60:
  pushl $0
  102204:	6a 00                	push   $0x0
  pushl $60
  102206:	6a 3c                	push   $0x3c
  jmp __alltraps
  102208:	e9 5b 08 00 00       	jmp    102a68 <__alltraps>

0010220d <vector61>:
.globl vector61
vector61:
  pushl $0
  10220d:	6a 00                	push   $0x0
  pushl $61
  10220f:	6a 3d                	push   $0x3d
  jmp __alltraps
  102211:	e9 52 08 00 00       	jmp    102a68 <__alltraps>

00102216 <vector62>:
.globl vector62
vector62:
  pushl $0
  102216:	6a 00                	push   $0x0
  pushl $62
  102218:	6a 3e                	push   $0x3e
  jmp __alltraps
  10221a:	e9 49 08 00 00       	jmp    102a68 <__alltraps>

0010221f <vector63>:
.globl vector63
vector63:
  pushl $0
  10221f:	6a 00                	push   $0x0
  pushl $63
  102221:	6a 3f                	push   $0x3f
  jmp __alltraps
  102223:	e9 40 08 00 00       	jmp    102a68 <__alltraps>

00102228 <vector64>:
.globl vector64
vector64:
  pushl $0
  102228:	6a 00                	push   $0x0
  pushl $64
  10222a:	6a 40                	push   $0x40
  jmp __alltraps
  10222c:	e9 37 08 00 00       	jmp    102a68 <__alltraps>

00102231 <vector65>:
.globl vector65
vector65:
  pushl $0
  102231:	6a 00                	push   $0x0
  pushl $65
  102233:	6a 41                	push   $0x41
  jmp __alltraps
  102235:	e9 2e 08 00 00       	jmp    102a68 <__alltraps>

0010223a <vector66>:
.globl vector66
vector66:
  pushl $0
  10223a:	6a 00                	push   $0x0
  pushl $66
  10223c:	6a 42                	push   $0x42
  jmp __alltraps
  10223e:	e9 25 08 00 00       	jmp    102a68 <__alltraps>

00102243 <vector67>:
.globl vector67
vector67:
  pushl $0
  102243:	6a 00                	push   $0x0
  pushl $67
  102245:	6a 43                	push   $0x43
  jmp __alltraps
  102247:	e9 1c 08 00 00       	jmp    102a68 <__alltraps>

0010224c <vector68>:
.globl vector68
vector68:
  pushl $0
  10224c:	6a 00                	push   $0x0
  pushl $68
  10224e:	6a 44                	push   $0x44
  jmp __alltraps
  102250:	e9 13 08 00 00       	jmp    102a68 <__alltraps>

00102255 <vector69>:
.globl vector69
vector69:
  pushl $0
  102255:	6a 00                	push   $0x0
  pushl $69
  102257:	6a 45                	push   $0x45
  jmp __alltraps
  102259:	e9 0a 08 00 00       	jmp    102a68 <__alltraps>

0010225e <vector70>:
.globl vector70
vector70:
  pushl $0
  10225e:	6a 00                	push   $0x0
  pushl $70
  102260:	6a 46                	push   $0x46
  jmp __alltraps
  102262:	e9 01 08 00 00       	jmp    102a68 <__alltraps>

00102267 <vector71>:
.globl vector71
vector71:
  pushl $0
  102267:	6a 00                	push   $0x0
  pushl $71
  102269:	6a 47                	push   $0x47
  jmp __alltraps
  10226b:	e9 f8 07 00 00       	jmp    102a68 <__alltraps>

00102270 <vector72>:
.globl vector72
vector72:
  pushl $0
  102270:	6a 00                	push   $0x0
  pushl $72
  102272:	6a 48                	push   $0x48
  jmp __alltraps
  102274:	e9 ef 07 00 00       	jmp    102a68 <__alltraps>

00102279 <vector73>:
.globl vector73
vector73:
  pushl $0
  102279:	6a 00                	push   $0x0
  pushl $73
  10227b:	6a 49                	push   $0x49
  jmp __alltraps
  10227d:	e9 e6 07 00 00       	jmp    102a68 <__alltraps>

00102282 <vector74>:
.globl vector74
vector74:
  pushl $0
  102282:	6a 00                	push   $0x0
  pushl $74
  102284:	6a 4a                	push   $0x4a
  jmp __alltraps
  102286:	e9 dd 07 00 00       	jmp    102a68 <__alltraps>

0010228b <vector75>:
.globl vector75
vector75:
  pushl $0
  10228b:	6a 00                	push   $0x0
  pushl $75
  10228d:	6a 4b                	push   $0x4b
  jmp __alltraps
  10228f:	e9 d4 07 00 00       	jmp    102a68 <__alltraps>

00102294 <vector76>:
.globl vector76
vector76:
  pushl $0
  102294:	6a 00                	push   $0x0
  pushl $76
  102296:	6a 4c                	push   $0x4c
  jmp __alltraps
  102298:	e9 cb 07 00 00       	jmp    102a68 <__alltraps>

0010229d <vector77>:
.globl vector77
vector77:
  pushl $0
  10229d:	6a 00                	push   $0x0
  pushl $77
  10229f:	6a 4d                	push   $0x4d
  jmp __alltraps
  1022a1:	e9 c2 07 00 00       	jmp    102a68 <__alltraps>

001022a6 <vector78>:
.globl vector78
vector78:
  pushl $0
  1022a6:	6a 00                	push   $0x0
  pushl $78
  1022a8:	6a 4e                	push   $0x4e
  jmp __alltraps
  1022aa:	e9 b9 07 00 00       	jmp    102a68 <__alltraps>

001022af <vector79>:
.globl vector79
vector79:
  pushl $0
  1022af:	6a 00                	push   $0x0
  pushl $79
  1022b1:	6a 4f                	push   $0x4f
  jmp __alltraps
  1022b3:	e9 b0 07 00 00       	jmp    102a68 <__alltraps>

001022b8 <vector80>:
.globl vector80
vector80:
  pushl $0
  1022b8:	6a 00                	push   $0x0
  pushl $80
  1022ba:	6a 50                	push   $0x50
  jmp __alltraps
  1022bc:	e9 a7 07 00 00       	jmp    102a68 <__alltraps>

001022c1 <vector81>:
.globl vector81
vector81:
  pushl $0
  1022c1:	6a 00                	push   $0x0
  pushl $81
  1022c3:	6a 51                	push   $0x51
  jmp __alltraps
  1022c5:	e9 9e 07 00 00       	jmp    102a68 <__alltraps>

001022ca <vector82>:
.globl vector82
vector82:
  pushl $0
  1022ca:	6a 00                	push   $0x0
  pushl $82
  1022cc:	6a 52                	push   $0x52
  jmp __alltraps
  1022ce:	e9 95 07 00 00       	jmp    102a68 <__alltraps>

001022d3 <vector83>:
.globl vector83
vector83:
  pushl $0
  1022d3:	6a 00                	push   $0x0
  pushl $83
  1022d5:	6a 53                	push   $0x53
  jmp __alltraps
  1022d7:	e9 8c 07 00 00       	jmp    102a68 <__alltraps>

001022dc <vector84>:
.globl vector84
vector84:
  pushl $0
  1022dc:	6a 00                	push   $0x0
  pushl $84
  1022de:	6a 54                	push   $0x54
  jmp __alltraps
  1022e0:	e9 83 07 00 00       	jmp    102a68 <__alltraps>

001022e5 <vector85>:
.globl vector85
vector85:
  pushl $0
  1022e5:	6a 00                	push   $0x0
  pushl $85
  1022e7:	6a 55                	push   $0x55
  jmp __alltraps
  1022e9:	e9 7a 07 00 00       	jmp    102a68 <__alltraps>

001022ee <vector86>:
.globl vector86
vector86:
  pushl $0
  1022ee:	6a 00                	push   $0x0
  pushl $86
  1022f0:	6a 56                	push   $0x56
  jmp __alltraps
  1022f2:	e9 71 07 00 00       	jmp    102a68 <__alltraps>

001022f7 <vector87>:
.globl vector87
vector87:
  pushl $0
  1022f7:	6a 00                	push   $0x0
  pushl $87
  1022f9:	6a 57                	push   $0x57
  jmp __alltraps
  1022fb:	e9 68 07 00 00       	jmp    102a68 <__alltraps>

00102300 <vector88>:
.globl vector88
vector88:
  pushl $0
  102300:	6a 00                	push   $0x0
  pushl $88
  102302:	6a 58                	push   $0x58
  jmp __alltraps
  102304:	e9 5f 07 00 00       	jmp    102a68 <__alltraps>

00102309 <vector89>:
.globl vector89
vector89:
  pushl $0
  102309:	6a 00                	push   $0x0
  pushl $89
  10230b:	6a 59                	push   $0x59
  jmp __alltraps
  10230d:	e9 56 07 00 00       	jmp    102a68 <__alltraps>

00102312 <vector90>:
.globl vector90
vector90:
  pushl $0
  102312:	6a 00                	push   $0x0
  pushl $90
  102314:	6a 5a                	push   $0x5a
  jmp __alltraps
  102316:	e9 4d 07 00 00       	jmp    102a68 <__alltraps>

0010231b <vector91>:
.globl vector91
vector91:
  pushl $0
  10231b:	6a 00                	push   $0x0
  pushl $91
  10231d:	6a 5b                	push   $0x5b
  jmp __alltraps
  10231f:	e9 44 07 00 00       	jmp    102a68 <__alltraps>

00102324 <vector92>:
.globl vector92
vector92:
  pushl $0
  102324:	6a 00                	push   $0x0
  pushl $92
  102326:	6a 5c                	push   $0x5c
  jmp __alltraps
  102328:	e9 3b 07 00 00       	jmp    102a68 <__alltraps>

0010232d <vector93>:
.globl vector93
vector93:
  pushl $0
  10232d:	6a 00                	push   $0x0
  pushl $93
  10232f:	6a 5d                	push   $0x5d
  jmp __alltraps
  102331:	e9 32 07 00 00       	jmp    102a68 <__alltraps>

00102336 <vector94>:
.globl vector94
vector94:
  pushl $0
  102336:	6a 00                	push   $0x0
  pushl $94
  102338:	6a 5e                	push   $0x5e
  jmp __alltraps
  10233a:	e9 29 07 00 00       	jmp    102a68 <__alltraps>

0010233f <vector95>:
.globl vector95
vector95:
  pushl $0
  10233f:	6a 00                	push   $0x0
  pushl $95
  102341:	6a 5f                	push   $0x5f
  jmp __alltraps
  102343:	e9 20 07 00 00       	jmp    102a68 <__alltraps>

00102348 <vector96>:
.globl vector96
vector96:
  pushl $0
  102348:	6a 00                	push   $0x0
  pushl $96
  10234a:	6a 60                	push   $0x60
  jmp __alltraps
  10234c:	e9 17 07 00 00       	jmp    102a68 <__alltraps>

00102351 <vector97>:
.globl vector97
vector97:
  pushl $0
  102351:	6a 00                	push   $0x0
  pushl $97
  102353:	6a 61                	push   $0x61
  jmp __alltraps
  102355:	e9 0e 07 00 00       	jmp    102a68 <__alltraps>

0010235a <vector98>:
.globl vector98
vector98:
  pushl $0
  10235a:	6a 00                	push   $0x0
  pushl $98
  10235c:	6a 62                	push   $0x62
  jmp __alltraps
  10235e:	e9 05 07 00 00       	jmp    102a68 <__alltraps>

00102363 <vector99>:
.globl vector99
vector99:
  pushl $0
  102363:	6a 00                	push   $0x0
  pushl $99
  102365:	6a 63                	push   $0x63
  jmp __alltraps
  102367:	e9 fc 06 00 00       	jmp    102a68 <__alltraps>

0010236c <vector100>:
.globl vector100
vector100:
  pushl $0
  10236c:	6a 00                	push   $0x0
  pushl $100
  10236e:	6a 64                	push   $0x64
  jmp __alltraps
  102370:	e9 f3 06 00 00       	jmp    102a68 <__alltraps>

00102375 <vector101>:
.globl vector101
vector101:
  pushl $0
  102375:	6a 00                	push   $0x0
  pushl $101
  102377:	6a 65                	push   $0x65
  jmp __alltraps
  102379:	e9 ea 06 00 00       	jmp    102a68 <__alltraps>

0010237e <vector102>:
.globl vector102
vector102:
  pushl $0
  10237e:	6a 00                	push   $0x0
  pushl $102
  102380:	6a 66                	push   $0x66
  jmp __alltraps
  102382:	e9 e1 06 00 00       	jmp    102a68 <__alltraps>

00102387 <vector103>:
.globl vector103
vector103:
  pushl $0
  102387:	6a 00                	push   $0x0
  pushl $103
  102389:	6a 67                	push   $0x67
  jmp __alltraps
  10238b:	e9 d8 06 00 00       	jmp    102a68 <__alltraps>

00102390 <vector104>:
.globl vector104
vector104:
  pushl $0
  102390:	6a 00                	push   $0x0
  pushl $104
  102392:	6a 68                	push   $0x68
  jmp __alltraps
  102394:	e9 cf 06 00 00       	jmp    102a68 <__alltraps>

00102399 <vector105>:
.globl vector105
vector105:
  pushl $0
  102399:	6a 00                	push   $0x0
  pushl $105
  10239b:	6a 69                	push   $0x69
  jmp __alltraps
  10239d:	e9 c6 06 00 00       	jmp    102a68 <__alltraps>

001023a2 <vector106>:
.globl vector106
vector106:
  pushl $0
  1023a2:	6a 00                	push   $0x0
  pushl $106
  1023a4:	6a 6a                	push   $0x6a
  jmp __alltraps
  1023a6:	e9 bd 06 00 00       	jmp    102a68 <__alltraps>

001023ab <vector107>:
.globl vector107
vector107:
  pushl $0
  1023ab:	6a 00                	push   $0x0
  pushl $107
  1023ad:	6a 6b                	push   $0x6b
  jmp __alltraps
  1023af:	e9 b4 06 00 00       	jmp    102a68 <__alltraps>

001023b4 <vector108>:
.globl vector108
vector108:
  pushl $0
  1023b4:	6a 00                	push   $0x0
  pushl $108
  1023b6:	6a 6c                	push   $0x6c
  jmp __alltraps
  1023b8:	e9 ab 06 00 00       	jmp    102a68 <__alltraps>

001023bd <vector109>:
.globl vector109
vector109:
  pushl $0
  1023bd:	6a 00                	push   $0x0
  pushl $109
  1023bf:	6a 6d                	push   $0x6d
  jmp __alltraps
  1023c1:	e9 a2 06 00 00       	jmp    102a68 <__alltraps>

001023c6 <vector110>:
.globl vector110
vector110:
  pushl $0
  1023c6:	6a 00                	push   $0x0
  pushl $110
  1023c8:	6a 6e                	push   $0x6e
  jmp __alltraps
  1023ca:	e9 99 06 00 00       	jmp    102a68 <__alltraps>

001023cf <vector111>:
.globl vector111
vector111:
  pushl $0
  1023cf:	6a 00                	push   $0x0
  pushl $111
  1023d1:	6a 6f                	push   $0x6f
  jmp __alltraps
  1023d3:	e9 90 06 00 00       	jmp    102a68 <__alltraps>

001023d8 <vector112>:
.globl vector112
vector112:
  pushl $0
  1023d8:	6a 00                	push   $0x0
  pushl $112
  1023da:	6a 70                	push   $0x70
  jmp __alltraps
  1023dc:	e9 87 06 00 00       	jmp    102a68 <__alltraps>

001023e1 <vector113>:
.globl vector113
vector113:
  pushl $0
  1023e1:	6a 00                	push   $0x0
  pushl $113
  1023e3:	6a 71                	push   $0x71
  jmp __alltraps
  1023e5:	e9 7e 06 00 00       	jmp    102a68 <__alltraps>

001023ea <vector114>:
.globl vector114
vector114:
  pushl $0
  1023ea:	6a 00                	push   $0x0
  pushl $114
  1023ec:	6a 72                	push   $0x72
  jmp __alltraps
  1023ee:	e9 75 06 00 00       	jmp    102a68 <__alltraps>

001023f3 <vector115>:
.globl vector115
vector115:
  pushl $0
  1023f3:	6a 00                	push   $0x0
  pushl $115
  1023f5:	6a 73                	push   $0x73
  jmp __alltraps
  1023f7:	e9 6c 06 00 00       	jmp    102a68 <__alltraps>

001023fc <vector116>:
.globl vector116
vector116:
  pushl $0
  1023fc:	6a 00                	push   $0x0
  pushl $116
  1023fe:	6a 74                	push   $0x74
  jmp __alltraps
  102400:	e9 63 06 00 00       	jmp    102a68 <__alltraps>

00102405 <vector117>:
.globl vector117
vector117:
  pushl $0
  102405:	6a 00                	push   $0x0
  pushl $117
  102407:	6a 75                	push   $0x75
  jmp __alltraps
  102409:	e9 5a 06 00 00       	jmp    102a68 <__alltraps>

0010240e <vector118>:
.globl vector118
vector118:
  pushl $0
  10240e:	6a 00                	push   $0x0
  pushl $118
  102410:	6a 76                	push   $0x76
  jmp __alltraps
  102412:	e9 51 06 00 00       	jmp    102a68 <__alltraps>

00102417 <vector119>:
.globl vector119
vector119:
  pushl $0
  102417:	6a 00                	push   $0x0
  pushl $119
  102419:	6a 77                	push   $0x77
  jmp __alltraps
  10241b:	e9 48 06 00 00       	jmp    102a68 <__alltraps>

00102420 <vector120>:
.globl vector120
vector120:
  pushl $0
  102420:	6a 00                	push   $0x0
  pushl $120
  102422:	6a 78                	push   $0x78
  jmp __alltraps
  102424:	e9 3f 06 00 00       	jmp    102a68 <__alltraps>

00102429 <vector121>:
.globl vector121
vector121:
  pushl $0
  102429:	6a 00                	push   $0x0
  pushl $121
  10242b:	6a 79                	push   $0x79
  jmp __alltraps
  10242d:	e9 36 06 00 00       	jmp    102a68 <__alltraps>

00102432 <vector122>:
.globl vector122
vector122:
  pushl $0
  102432:	6a 00                	push   $0x0
  pushl $122
  102434:	6a 7a                	push   $0x7a
  jmp __alltraps
  102436:	e9 2d 06 00 00       	jmp    102a68 <__alltraps>

0010243b <vector123>:
.globl vector123
vector123:
  pushl $0
  10243b:	6a 00                	push   $0x0
  pushl $123
  10243d:	6a 7b                	push   $0x7b
  jmp __alltraps
  10243f:	e9 24 06 00 00       	jmp    102a68 <__alltraps>

00102444 <vector124>:
.globl vector124
vector124:
  pushl $0
  102444:	6a 00                	push   $0x0
  pushl $124
  102446:	6a 7c                	push   $0x7c
  jmp __alltraps
  102448:	e9 1b 06 00 00       	jmp    102a68 <__alltraps>

0010244d <vector125>:
.globl vector125
vector125:
  pushl $0
  10244d:	6a 00                	push   $0x0
  pushl $125
  10244f:	6a 7d                	push   $0x7d
  jmp __alltraps
  102451:	e9 12 06 00 00       	jmp    102a68 <__alltraps>

00102456 <vector126>:
.globl vector126
vector126:
  pushl $0
  102456:	6a 00                	push   $0x0
  pushl $126
  102458:	6a 7e                	push   $0x7e
  jmp __alltraps
  10245a:	e9 09 06 00 00       	jmp    102a68 <__alltraps>

0010245f <vector127>:
.globl vector127
vector127:
  pushl $0
  10245f:	6a 00                	push   $0x0
  pushl $127
  102461:	6a 7f                	push   $0x7f
  jmp __alltraps
  102463:	e9 00 06 00 00       	jmp    102a68 <__alltraps>

00102468 <vector128>:
.globl vector128
vector128:
  pushl $0
  102468:	6a 00                	push   $0x0
  pushl $128
  10246a:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  10246f:	e9 f4 05 00 00       	jmp    102a68 <__alltraps>

00102474 <vector129>:
.globl vector129
vector129:
  pushl $0
  102474:	6a 00                	push   $0x0
  pushl $129
  102476:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  10247b:	e9 e8 05 00 00       	jmp    102a68 <__alltraps>

00102480 <vector130>:
.globl vector130
vector130:
  pushl $0
  102480:	6a 00                	push   $0x0
  pushl $130
  102482:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  102487:	e9 dc 05 00 00       	jmp    102a68 <__alltraps>

0010248c <vector131>:
.globl vector131
vector131:
  pushl $0
  10248c:	6a 00                	push   $0x0
  pushl $131
  10248e:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102493:	e9 d0 05 00 00       	jmp    102a68 <__alltraps>

00102498 <vector132>:
.globl vector132
vector132:
  pushl $0
  102498:	6a 00                	push   $0x0
  pushl $132
  10249a:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  10249f:	e9 c4 05 00 00       	jmp    102a68 <__alltraps>

001024a4 <vector133>:
.globl vector133
vector133:
  pushl $0
  1024a4:	6a 00                	push   $0x0
  pushl $133
  1024a6:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  1024ab:	e9 b8 05 00 00       	jmp    102a68 <__alltraps>

001024b0 <vector134>:
.globl vector134
vector134:
  pushl $0
  1024b0:	6a 00                	push   $0x0
  pushl $134
  1024b2:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  1024b7:	e9 ac 05 00 00       	jmp    102a68 <__alltraps>

001024bc <vector135>:
.globl vector135
vector135:
  pushl $0
  1024bc:	6a 00                	push   $0x0
  pushl $135
  1024be:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  1024c3:	e9 a0 05 00 00       	jmp    102a68 <__alltraps>

001024c8 <vector136>:
.globl vector136
vector136:
  pushl $0
  1024c8:	6a 00                	push   $0x0
  pushl $136
  1024ca:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  1024cf:	e9 94 05 00 00       	jmp    102a68 <__alltraps>

001024d4 <vector137>:
.globl vector137
vector137:
  pushl $0
  1024d4:	6a 00                	push   $0x0
  pushl $137
  1024d6:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  1024db:	e9 88 05 00 00       	jmp    102a68 <__alltraps>

001024e0 <vector138>:
.globl vector138
vector138:
  pushl $0
  1024e0:	6a 00                	push   $0x0
  pushl $138
  1024e2:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1024e7:	e9 7c 05 00 00       	jmp    102a68 <__alltraps>

001024ec <vector139>:
.globl vector139
vector139:
  pushl $0
  1024ec:	6a 00                	push   $0x0
  pushl $139
  1024ee:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  1024f3:	e9 70 05 00 00       	jmp    102a68 <__alltraps>

001024f8 <vector140>:
.globl vector140
vector140:
  pushl $0
  1024f8:	6a 00                	push   $0x0
  pushl $140
  1024fa:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1024ff:	e9 64 05 00 00       	jmp    102a68 <__alltraps>

00102504 <vector141>:
.globl vector141
vector141:
  pushl $0
  102504:	6a 00                	push   $0x0
  pushl $141
  102506:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  10250b:	e9 58 05 00 00       	jmp    102a68 <__alltraps>

00102510 <vector142>:
.globl vector142
vector142:
  pushl $0
  102510:	6a 00                	push   $0x0
  pushl $142
  102512:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  102517:	e9 4c 05 00 00       	jmp    102a68 <__alltraps>

0010251c <vector143>:
.globl vector143
vector143:
  pushl $0
  10251c:	6a 00                	push   $0x0
  pushl $143
  10251e:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102523:	e9 40 05 00 00       	jmp    102a68 <__alltraps>

00102528 <vector144>:
.globl vector144
vector144:
  pushl $0
  102528:	6a 00                	push   $0x0
  pushl $144
  10252a:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  10252f:	e9 34 05 00 00       	jmp    102a68 <__alltraps>

00102534 <vector145>:
.globl vector145
vector145:
  pushl $0
  102534:	6a 00                	push   $0x0
  pushl $145
  102536:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  10253b:	e9 28 05 00 00       	jmp    102a68 <__alltraps>

00102540 <vector146>:
.globl vector146
vector146:
  pushl $0
  102540:	6a 00                	push   $0x0
  pushl $146
  102542:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  102547:	e9 1c 05 00 00       	jmp    102a68 <__alltraps>

0010254c <vector147>:
.globl vector147
vector147:
  pushl $0
  10254c:	6a 00                	push   $0x0
  pushl $147
  10254e:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  102553:	e9 10 05 00 00       	jmp    102a68 <__alltraps>

00102558 <vector148>:
.globl vector148
vector148:
  pushl $0
  102558:	6a 00                	push   $0x0
  pushl $148
  10255a:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  10255f:	e9 04 05 00 00       	jmp    102a68 <__alltraps>

00102564 <vector149>:
.globl vector149
vector149:
  pushl $0
  102564:	6a 00                	push   $0x0
  pushl $149
  102566:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  10256b:	e9 f8 04 00 00       	jmp    102a68 <__alltraps>

00102570 <vector150>:
.globl vector150
vector150:
  pushl $0
  102570:	6a 00                	push   $0x0
  pushl $150
  102572:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  102577:	e9 ec 04 00 00       	jmp    102a68 <__alltraps>

0010257c <vector151>:
.globl vector151
vector151:
  pushl $0
  10257c:	6a 00                	push   $0x0
  pushl $151
  10257e:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  102583:	e9 e0 04 00 00       	jmp    102a68 <__alltraps>

00102588 <vector152>:
.globl vector152
vector152:
  pushl $0
  102588:	6a 00                	push   $0x0
  pushl $152
  10258a:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  10258f:	e9 d4 04 00 00       	jmp    102a68 <__alltraps>

00102594 <vector153>:
.globl vector153
vector153:
  pushl $0
  102594:	6a 00                	push   $0x0
  pushl $153
  102596:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  10259b:	e9 c8 04 00 00       	jmp    102a68 <__alltraps>

001025a0 <vector154>:
.globl vector154
vector154:
  pushl $0
  1025a0:	6a 00                	push   $0x0
  pushl $154
  1025a2:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  1025a7:	e9 bc 04 00 00       	jmp    102a68 <__alltraps>

001025ac <vector155>:
.globl vector155
vector155:
  pushl $0
  1025ac:	6a 00                	push   $0x0
  pushl $155
  1025ae:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  1025b3:	e9 b0 04 00 00       	jmp    102a68 <__alltraps>

001025b8 <vector156>:
.globl vector156
vector156:
  pushl $0
  1025b8:	6a 00                	push   $0x0
  pushl $156
  1025ba:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  1025bf:	e9 a4 04 00 00       	jmp    102a68 <__alltraps>

001025c4 <vector157>:
.globl vector157
vector157:
  pushl $0
  1025c4:	6a 00                	push   $0x0
  pushl $157
  1025c6:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  1025cb:	e9 98 04 00 00       	jmp    102a68 <__alltraps>

001025d0 <vector158>:
.globl vector158
vector158:
  pushl $0
  1025d0:	6a 00                	push   $0x0
  pushl $158
  1025d2:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1025d7:	e9 8c 04 00 00       	jmp    102a68 <__alltraps>

001025dc <vector159>:
.globl vector159
vector159:
  pushl $0
  1025dc:	6a 00                	push   $0x0
  pushl $159
  1025de:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  1025e3:	e9 80 04 00 00       	jmp    102a68 <__alltraps>

001025e8 <vector160>:
.globl vector160
vector160:
  pushl $0
  1025e8:	6a 00                	push   $0x0
  pushl $160
  1025ea:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  1025ef:	e9 74 04 00 00       	jmp    102a68 <__alltraps>

001025f4 <vector161>:
.globl vector161
vector161:
  pushl $0
  1025f4:	6a 00                	push   $0x0
  pushl $161
  1025f6:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1025fb:	e9 68 04 00 00       	jmp    102a68 <__alltraps>

00102600 <vector162>:
.globl vector162
vector162:
  pushl $0
  102600:	6a 00                	push   $0x0
  pushl $162
  102602:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  102607:	e9 5c 04 00 00       	jmp    102a68 <__alltraps>

0010260c <vector163>:
.globl vector163
vector163:
  pushl $0
  10260c:	6a 00                	push   $0x0
  pushl $163
  10260e:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  102613:	e9 50 04 00 00       	jmp    102a68 <__alltraps>

00102618 <vector164>:
.globl vector164
vector164:
  pushl $0
  102618:	6a 00                	push   $0x0
  pushl $164
  10261a:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  10261f:	e9 44 04 00 00       	jmp    102a68 <__alltraps>

00102624 <vector165>:
.globl vector165
vector165:
  pushl $0
  102624:	6a 00                	push   $0x0
  pushl $165
  102626:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  10262b:	e9 38 04 00 00       	jmp    102a68 <__alltraps>

00102630 <vector166>:
.globl vector166
vector166:
  pushl $0
  102630:	6a 00                	push   $0x0
  pushl $166
  102632:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  102637:	e9 2c 04 00 00       	jmp    102a68 <__alltraps>

0010263c <vector167>:
.globl vector167
vector167:
  pushl $0
  10263c:	6a 00                	push   $0x0
  pushl $167
  10263e:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  102643:	e9 20 04 00 00       	jmp    102a68 <__alltraps>

00102648 <vector168>:
.globl vector168
vector168:
  pushl $0
  102648:	6a 00                	push   $0x0
  pushl $168
  10264a:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  10264f:	e9 14 04 00 00       	jmp    102a68 <__alltraps>

00102654 <vector169>:
.globl vector169
vector169:
  pushl $0
  102654:	6a 00                	push   $0x0
  pushl $169
  102656:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  10265b:	e9 08 04 00 00       	jmp    102a68 <__alltraps>

00102660 <vector170>:
.globl vector170
vector170:
  pushl $0
  102660:	6a 00                	push   $0x0
  pushl $170
  102662:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  102667:	e9 fc 03 00 00       	jmp    102a68 <__alltraps>

0010266c <vector171>:
.globl vector171
vector171:
  pushl $0
  10266c:	6a 00                	push   $0x0
  pushl $171
  10266e:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102673:	e9 f0 03 00 00       	jmp    102a68 <__alltraps>

00102678 <vector172>:
.globl vector172
vector172:
  pushl $0
  102678:	6a 00                	push   $0x0
  pushl $172
  10267a:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  10267f:	e9 e4 03 00 00       	jmp    102a68 <__alltraps>

00102684 <vector173>:
.globl vector173
vector173:
  pushl $0
  102684:	6a 00                	push   $0x0
  pushl $173
  102686:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  10268b:	e9 d8 03 00 00       	jmp    102a68 <__alltraps>

00102690 <vector174>:
.globl vector174
vector174:
  pushl $0
  102690:	6a 00                	push   $0x0
  pushl $174
  102692:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  102697:	e9 cc 03 00 00       	jmp    102a68 <__alltraps>

0010269c <vector175>:
.globl vector175
vector175:
  pushl $0
  10269c:	6a 00                	push   $0x0
  pushl $175
  10269e:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  1026a3:	e9 c0 03 00 00       	jmp    102a68 <__alltraps>

001026a8 <vector176>:
.globl vector176
vector176:
  pushl $0
  1026a8:	6a 00                	push   $0x0
  pushl $176
  1026aa:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  1026af:	e9 b4 03 00 00       	jmp    102a68 <__alltraps>

001026b4 <vector177>:
.globl vector177
vector177:
  pushl $0
  1026b4:	6a 00                	push   $0x0
  pushl $177
  1026b6:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  1026bb:	e9 a8 03 00 00       	jmp    102a68 <__alltraps>

001026c0 <vector178>:
.globl vector178
vector178:
  pushl $0
  1026c0:	6a 00                	push   $0x0
  pushl $178
  1026c2:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  1026c7:	e9 9c 03 00 00       	jmp    102a68 <__alltraps>

001026cc <vector179>:
.globl vector179
vector179:
  pushl $0
  1026cc:	6a 00                	push   $0x0
  pushl $179
  1026ce:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  1026d3:	e9 90 03 00 00       	jmp    102a68 <__alltraps>

001026d8 <vector180>:
.globl vector180
vector180:
  pushl $0
  1026d8:	6a 00                	push   $0x0
  pushl $180
  1026da:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  1026df:	e9 84 03 00 00       	jmp    102a68 <__alltraps>

001026e4 <vector181>:
.globl vector181
vector181:
  pushl $0
  1026e4:	6a 00                	push   $0x0
  pushl $181
  1026e6:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1026eb:	e9 78 03 00 00       	jmp    102a68 <__alltraps>

001026f0 <vector182>:
.globl vector182
vector182:
  pushl $0
  1026f0:	6a 00                	push   $0x0
  pushl $182
  1026f2:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  1026f7:	e9 6c 03 00 00       	jmp    102a68 <__alltraps>

001026fc <vector183>:
.globl vector183
vector183:
  pushl $0
  1026fc:	6a 00                	push   $0x0
  pushl $183
  1026fe:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102703:	e9 60 03 00 00       	jmp    102a68 <__alltraps>

00102708 <vector184>:
.globl vector184
vector184:
  pushl $0
  102708:	6a 00                	push   $0x0
  pushl $184
  10270a:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  10270f:	e9 54 03 00 00       	jmp    102a68 <__alltraps>

00102714 <vector185>:
.globl vector185
vector185:
  pushl $0
  102714:	6a 00                	push   $0x0
  pushl $185
  102716:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  10271b:	e9 48 03 00 00       	jmp    102a68 <__alltraps>

00102720 <vector186>:
.globl vector186
vector186:
  pushl $0
  102720:	6a 00                	push   $0x0
  pushl $186
  102722:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102727:	e9 3c 03 00 00       	jmp    102a68 <__alltraps>

0010272c <vector187>:
.globl vector187
vector187:
  pushl $0
  10272c:	6a 00                	push   $0x0
  pushl $187
  10272e:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102733:	e9 30 03 00 00       	jmp    102a68 <__alltraps>

00102738 <vector188>:
.globl vector188
vector188:
  pushl $0
  102738:	6a 00                	push   $0x0
  pushl $188
  10273a:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  10273f:	e9 24 03 00 00       	jmp    102a68 <__alltraps>

00102744 <vector189>:
.globl vector189
vector189:
  pushl $0
  102744:	6a 00                	push   $0x0
  pushl $189
  102746:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  10274b:	e9 18 03 00 00       	jmp    102a68 <__alltraps>

00102750 <vector190>:
.globl vector190
vector190:
  pushl $0
  102750:	6a 00                	push   $0x0
  pushl $190
  102752:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  102757:	e9 0c 03 00 00       	jmp    102a68 <__alltraps>

0010275c <vector191>:
.globl vector191
vector191:
  pushl $0
  10275c:	6a 00                	push   $0x0
  pushl $191
  10275e:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  102763:	e9 00 03 00 00       	jmp    102a68 <__alltraps>

00102768 <vector192>:
.globl vector192
vector192:
  pushl $0
  102768:	6a 00                	push   $0x0
  pushl $192
  10276a:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  10276f:	e9 f4 02 00 00       	jmp    102a68 <__alltraps>

00102774 <vector193>:
.globl vector193
vector193:
  pushl $0
  102774:	6a 00                	push   $0x0
  pushl $193
  102776:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  10277b:	e9 e8 02 00 00       	jmp    102a68 <__alltraps>

00102780 <vector194>:
.globl vector194
vector194:
  pushl $0
  102780:	6a 00                	push   $0x0
  pushl $194
  102782:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  102787:	e9 dc 02 00 00       	jmp    102a68 <__alltraps>

0010278c <vector195>:
.globl vector195
vector195:
  pushl $0
  10278c:	6a 00                	push   $0x0
  pushl $195
  10278e:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102793:	e9 d0 02 00 00       	jmp    102a68 <__alltraps>

00102798 <vector196>:
.globl vector196
vector196:
  pushl $0
  102798:	6a 00                	push   $0x0
  pushl $196
  10279a:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  10279f:	e9 c4 02 00 00       	jmp    102a68 <__alltraps>

001027a4 <vector197>:
.globl vector197
vector197:
  pushl $0
  1027a4:	6a 00                	push   $0x0
  pushl $197
  1027a6:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  1027ab:	e9 b8 02 00 00       	jmp    102a68 <__alltraps>

001027b0 <vector198>:
.globl vector198
vector198:
  pushl $0
  1027b0:	6a 00                	push   $0x0
  pushl $198
  1027b2:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  1027b7:	e9 ac 02 00 00       	jmp    102a68 <__alltraps>

001027bc <vector199>:
.globl vector199
vector199:
  pushl $0
  1027bc:	6a 00                	push   $0x0
  pushl $199
  1027be:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  1027c3:	e9 a0 02 00 00       	jmp    102a68 <__alltraps>

001027c8 <vector200>:
.globl vector200
vector200:
  pushl $0
  1027c8:	6a 00                	push   $0x0
  pushl $200
  1027ca:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  1027cf:	e9 94 02 00 00       	jmp    102a68 <__alltraps>

001027d4 <vector201>:
.globl vector201
vector201:
  pushl $0
  1027d4:	6a 00                	push   $0x0
  pushl $201
  1027d6:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  1027db:	e9 88 02 00 00       	jmp    102a68 <__alltraps>

001027e0 <vector202>:
.globl vector202
vector202:
  pushl $0
  1027e0:	6a 00                	push   $0x0
  pushl $202
  1027e2:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  1027e7:	e9 7c 02 00 00       	jmp    102a68 <__alltraps>

001027ec <vector203>:
.globl vector203
vector203:
  pushl $0
  1027ec:	6a 00                	push   $0x0
  pushl $203
  1027ee:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  1027f3:	e9 70 02 00 00       	jmp    102a68 <__alltraps>

001027f8 <vector204>:
.globl vector204
vector204:
  pushl $0
  1027f8:	6a 00                	push   $0x0
  pushl $204
  1027fa:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1027ff:	e9 64 02 00 00       	jmp    102a68 <__alltraps>

00102804 <vector205>:
.globl vector205
vector205:
  pushl $0
  102804:	6a 00                	push   $0x0
  pushl $205
  102806:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  10280b:	e9 58 02 00 00       	jmp    102a68 <__alltraps>

00102810 <vector206>:
.globl vector206
vector206:
  pushl $0
  102810:	6a 00                	push   $0x0
  pushl $206
  102812:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  102817:	e9 4c 02 00 00       	jmp    102a68 <__alltraps>

0010281c <vector207>:
.globl vector207
vector207:
  pushl $0
  10281c:	6a 00                	push   $0x0
  pushl $207
  10281e:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102823:	e9 40 02 00 00       	jmp    102a68 <__alltraps>

00102828 <vector208>:
.globl vector208
vector208:
  pushl $0
  102828:	6a 00                	push   $0x0
  pushl $208
  10282a:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  10282f:	e9 34 02 00 00       	jmp    102a68 <__alltraps>

00102834 <vector209>:
.globl vector209
vector209:
  pushl $0
  102834:	6a 00                	push   $0x0
  pushl $209
  102836:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  10283b:	e9 28 02 00 00       	jmp    102a68 <__alltraps>

00102840 <vector210>:
.globl vector210
vector210:
  pushl $0
  102840:	6a 00                	push   $0x0
  pushl $210
  102842:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  102847:	e9 1c 02 00 00       	jmp    102a68 <__alltraps>

0010284c <vector211>:
.globl vector211
vector211:
  pushl $0
  10284c:	6a 00                	push   $0x0
  pushl $211
  10284e:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  102853:	e9 10 02 00 00       	jmp    102a68 <__alltraps>

00102858 <vector212>:
.globl vector212
vector212:
  pushl $0
  102858:	6a 00                	push   $0x0
  pushl $212
  10285a:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  10285f:	e9 04 02 00 00       	jmp    102a68 <__alltraps>

00102864 <vector213>:
.globl vector213
vector213:
  pushl $0
  102864:	6a 00                	push   $0x0
  pushl $213
  102866:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  10286b:	e9 f8 01 00 00       	jmp    102a68 <__alltraps>

00102870 <vector214>:
.globl vector214
vector214:
  pushl $0
  102870:	6a 00                	push   $0x0
  pushl $214
  102872:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  102877:	e9 ec 01 00 00       	jmp    102a68 <__alltraps>

0010287c <vector215>:
.globl vector215
vector215:
  pushl $0
  10287c:	6a 00                	push   $0x0
  pushl $215
  10287e:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102883:	e9 e0 01 00 00       	jmp    102a68 <__alltraps>

00102888 <vector216>:
.globl vector216
vector216:
  pushl $0
  102888:	6a 00                	push   $0x0
  pushl $216
  10288a:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  10288f:	e9 d4 01 00 00       	jmp    102a68 <__alltraps>

00102894 <vector217>:
.globl vector217
vector217:
  pushl $0
  102894:	6a 00                	push   $0x0
  pushl $217
  102896:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  10289b:	e9 c8 01 00 00       	jmp    102a68 <__alltraps>

001028a0 <vector218>:
.globl vector218
vector218:
  pushl $0
  1028a0:	6a 00                	push   $0x0
  pushl $218
  1028a2:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  1028a7:	e9 bc 01 00 00       	jmp    102a68 <__alltraps>

001028ac <vector219>:
.globl vector219
vector219:
  pushl $0
  1028ac:	6a 00                	push   $0x0
  pushl $219
  1028ae:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  1028b3:	e9 b0 01 00 00       	jmp    102a68 <__alltraps>

001028b8 <vector220>:
.globl vector220
vector220:
  pushl $0
  1028b8:	6a 00                	push   $0x0
  pushl $220
  1028ba:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  1028bf:	e9 a4 01 00 00       	jmp    102a68 <__alltraps>

001028c4 <vector221>:
.globl vector221
vector221:
  pushl $0
  1028c4:	6a 00                	push   $0x0
  pushl $221
  1028c6:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  1028cb:	e9 98 01 00 00       	jmp    102a68 <__alltraps>

001028d0 <vector222>:
.globl vector222
vector222:
  pushl $0
  1028d0:	6a 00                	push   $0x0
  pushl $222
  1028d2:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  1028d7:	e9 8c 01 00 00       	jmp    102a68 <__alltraps>

001028dc <vector223>:
.globl vector223
vector223:
  pushl $0
  1028dc:	6a 00                	push   $0x0
  pushl $223
  1028de:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  1028e3:	e9 80 01 00 00       	jmp    102a68 <__alltraps>

001028e8 <vector224>:
.globl vector224
vector224:
  pushl $0
  1028e8:	6a 00                	push   $0x0
  pushl $224
  1028ea:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  1028ef:	e9 74 01 00 00       	jmp    102a68 <__alltraps>

001028f4 <vector225>:
.globl vector225
vector225:
  pushl $0
  1028f4:	6a 00                	push   $0x0
  pushl $225
  1028f6:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  1028fb:	e9 68 01 00 00       	jmp    102a68 <__alltraps>

00102900 <vector226>:
.globl vector226
vector226:
  pushl $0
  102900:	6a 00                	push   $0x0
  pushl $226
  102902:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102907:	e9 5c 01 00 00       	jmp    102a68 <__alltraps>

0010290c <vector227>:
.globl vector227
vector227:
  pushl $0
  10290c:	6a 00                	push   $0x0
  pushl $227
  10290e:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102913:	e9 50 01 00 00       	jmp    102a68 <__alltraps>

00102918 <vector228>:
.globl vector228
vector228:
  pushl $0
  102918:	6a 00                	push   $0x0
  pushl $228
  10291a:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  10291f:	e9 44 01 00 00       	jmp    102a68 <__alltraps>

00102924 <vector229>:
.globl vector229
vector229:
  pushl $0
  102924:	6a 00                	push   $0x0
  pushl $229
  102926:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  10292b:	e9 38 01 00 00       	jmp    102a68 <__alltraps>

00102930 <vector230>:
.globl vector230
vector230:
  pushl $0
  102930:	6a 00                	push   $0x0
  pushl $230
  102932:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  102937:	e9 2c 01 00 00       	jmp    102a68 <__alltraps>

0010293c <vector231>:
.globl vector231
vector231:
  pushl $0
  10293c:	6a 00                	push   $0x0
  pushl $231
  10293e:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  102943:	e9 20 01 00 00       	jmp    102a68 <__alltraps>

00102948 <vector232>:
.globl vector232
vector232:
  pushl $0
  102948:	6a 00                	push   $0x0
  pushl $232
  10294a:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  10294f:	e9 14 01 00 00       	jmp    102a68 <__alltraps>

00102954 <vector233>:
.globl vector233
vector233:
  pushl $0
  102954:	6a 00                	push   $0x0
  pushl $233
  102956:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  10295b:	e9 08 01 00 00       	jmp    102a68 <__alltraps>

00102960 <vector234>:
.globl vector234
vector234:
  pushl $0
  102960:	6a 00                	push   $0x0
  pushl $234
  102962:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  102967:	e9 fc 00 00 00       	jmp    102a68 <__alltraps>

0010296c <vector235>:
.globl vector235
vector235:
  pushl $0
  10296c:	6a 00                	push   $0x0
  pushl $235
  10296e:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102973:	e9 f0 00 00 00       	jmp    102a68 <__alltraps>

00102978 <vector236>:
.globl vector236
vector236:
  pushl $0
  102978:	6a 00                	push   $0x0
  pushl $236
  10297a:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  10297f:	e9 e4 00 00 00       	jmp    102a68 <__alltraps>

00102984 <vector237>:
.globl vector237
vector237:
  pushl $0
  102984:	6a 00                	push   $0x0
  pushl $237
  102986:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  10298b:	e9 d8 00 00 00       	jmp    102a68 <__alltraps>

00102990 <vector238>:
.globl vector238
vector238:
  pushl $0
  102990:	6a 00                	push   $0x0
  pushl $238
  102992:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102997:	e9 cc 00 00 00       	jmp    102a68 <__alltraps>

0010299c <vector239>:
.globl vector239
vector239:
  pushl $0
  10299c:	6a 00                	push   $0x0
  pushl $239
  10299e:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  1029a3:	e9 c0 00 00 00       	jmp    102a68 <__alltraps>

001029a8 <vector240>:
.globl vector240
vector240:
  pushl $0
  1029a8:	6a 00                	push   $0x0
  pushl $240
  1029aa:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  1029af:	e9 b4 00 00 00       	jmp    102a68 <__alltraps>

001029b4 <vector241>:
.globl vector241
vector241:
  pushl $0
  1029b4:	6a 00                	push   $0x0
  pushl $241
  1029b6:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  1029bb:	e9 a8 00 00 00       	jmp    102a68 <__alltraps>

001029c0 <vector242>:
.globl vector242
vector242:
  pushl $0
  1029c0:	6a 00                	push   $0x0
  pushl $242
  1029c2:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  1029c7:	e9 9c 00 00 00       	jmp    102a68 <__alltraps>

001029cc <vector243>:
.globl vector243
vector243:
  pushl $0
  1029cc:	6a 00                	push   $0x0
  pushl $243
  1029ce:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  1029d3:	e9 90 00 00 00       	jmp    102a68 <__alltraps>

001029d8 <vector244>:
.globl vector244
vector244:
  pushl $0
  1029d8:	6a 00                	push   $0x0
  pushl $244
  1029da:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  1029df:	e9 84 00 00 00       	jmp    102a68 <__alltraps>

001029e4 <vector245>:
.globl vector245
vector245:
  pushl $0
  1029e4:	6a 00                	push   $0x0
  pushl $245
  1029e6:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  1029eb:	e9 78 00 00 00       	jmp    102a68 <__alltraps>

001029f0 <vector246>:
.globl vector246
vector246:
  pushl $0
  1029f0:	6a 00                	push   $0x0
  pushl $246
  1029f2:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  1029f7:	e9 6c 00 00 00       	jmp    102a68 <__alltraps>

001029fc <vector247>:
.globl vector247
vector247:
  pushl $0
  1029fc:	6a 00                	push   $0x0
  pushl $247
  1029fe:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102a03:	e9 60 00 00 00       	jmp    102a68 <__alltraps>

00102a08 <vector248>:
.globl vector248
vector248:
  pushl $0
  102a08:	6a 00                	push   $0x0
  pushl $248
  102a0a:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  102a0f:	e9 54 00 00 00       	jmp    102a68 <__alltraps>

00102a14 <vector249>:
.globl vector249
vector249:
  pushl $0
  102a14:	6a 00                	push   $0x0
  pushl $249
  102a16:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  102a1b:	e9 48 00 00 00       	jmp    102a68 <__alltraps>

00102a20 <vector250>:
.globl vector250
vector250:
  pushl $0
  102a20:	6a 00                	push   $0x0
  pushl $250
  102a22:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102a27:	e9 3c 00 00 00       	jmp    102a68 <__alltraps>

00102a2c <vector251>:
.globl vector251
vector251:
  pushl $0
  102a2c:	6a 00                	push   $0x0
  pushl $251
  102a2e:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102a33:	e9 30 00 00 00       	jmp    102a68 <__alltraps>

00102a38 <vector252>:
.globl vector252
vector252:
  pushl $0
  102a38:	6a 00                	push   $0x0
  pushl $252
  102a3a:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102a3f:	e9 24 00 00 00       	jmp    102a68 <__alltraps>

00102a44 <vector253>:
.globl vector253
vector253:
  pushl $0
  102a44:	6a 00                	push   $0x0
  pushl $253
  102a46:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102a4b:	e9 18 00 00 00       	jmp    102a68 <__alltraps>

00102a50 <vector254>:
.globl vector254
vector254:
  pushl $0
  102a50:	6a 00                	push   $0x0
  pushl $254
  102a52:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102a57:	e9 0c 00 00 00       	jmp    102a68 <__alltraps>

00102a5c <vector255>:
.globl vector255
vector255:
  pushl $0
  102a5c:	6a 00                	push   $0x0
  pushl $255
  102a5e:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102a63:	e9 00 00 00 00       	jmp    102a68 <__alltraps>

00102a68 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  102a68:	1e                   	push   %ds
    pushl %es
  102a69:	06                   	push   %es
    pushl %fs
  102a6a:	0f a0                	push   %fs
    pushl %gs
  102a6c:	0f a8                	push   %gs
    pushal
  102a6e:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  102a6f:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102a74:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102a76:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102a78:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  102a79:	e8 5f f5 ff ff       	call   101fdd <trap>

    # pop the pushed stack pointer
    popl %esp
  102a7e:	5c                   	pop    %esp

00102a7f <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  102a7f:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  102a80:	0f a9                	pop    %gs
    popl %fs
  102a82:	0f a1                	pop    %fs
    popl %es
  102a84:	07                   	pop    %es
    popl %ds
  102a85:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102a86:	83 c4 08             	add    $0x8,%esp
    iret
  102a89:	cf                   	iret   

00102a8a <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102a8a:	55                   	push   %ebp
  102a8b:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  102a90:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102a93:	b8 23 00 00 00       	mov    $0x23,%eax
  102a98:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102a9a:	b8 23 00 00 00       	mov    $0x23,%eax
  102a9f:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102aa1:	b8 10 00 00 00       	mov    $0x10,%eax
  102aa6:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102aa8:	b8 10 00 00 00       	mov    $0x10,%eax
  102aad:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102aaf:	b8 10 00 00 00       	mov    $0x10,%eax
  102ab4:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102ab6:	ea bd 2a 10 00 08 00 	ljmp   $0x8,$0x102abd
}
  102abd:	90                   	nop
  102abe:	5d                   	pop    %ebp
  102abf:	c3                   	ret    

00102ac0 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102ac0:	f3 0f 1e fb          	endbr32 
  102ac4:	55                   	push   %ebp
  102ac5:	89 e5                	mov    %esp,%ebp
  102ac7:	83 ec 10             	sub    $0x10,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102aca:	b8 80 09 11 00       	mov    $0x110980,%eax
  102acf:	05 00 04 00 00       	add    $0x400,%eax
  102ad4:	a3 a4 08 11 00       	mov    %eax,0x1108a4
    ts.ts_ss0 = KERNEL_DS;
  102ad9:	66 c7 05 a8 08 11 00 	movw   $0x10,0x1108a8
  102ae0:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102ae2:	66 c7 05 08 fa 10 00 	movw   $0x68,0x10fa08
  102ae9:	68 00 
  102aeb:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102af0:	66 a3 0a fa 10 00    	mov    %ax,0x10fa0a
  102af6:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102afb:	c1 e8 10             	shr    $0x10,%eax
  102afe:	a2 0c fa 10 00       	mov    %al,0x10fa0c
  102b03:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102b0a:	83 e0 f0             	and    $0xfffffff0,%eax
  102b0d:	83 c8 09             	or     $0x9,%eax
  102b10:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102b15:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102b1c:	83 c8 10             	or     $0x10,%eax
  102b1f:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102b24:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102b2b:	83 e0 9f             	and    $0xffffff9f,%eax
  102b2e:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102b33:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102b3a:	83 c8 80             	or     $0xffffff80,%eax
  102b3d:	a2 0d fa 10 00       	mov    %al,0x10fa0d
  102b42:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b49:	83 e0 f0             	and    $0xfffffff0,%eax
  102b4c:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b51:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b58:	83 e0 ef             	and    $0xffffffef,%eax
  102b5b:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b60:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b67:	83 e0 df             	and    $0xffffffdf,%eax
  102b6a:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b6f:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b76:	83 c8 40             	or     $0x40,%eax
  102b79:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b7e:	0f b6 05 0e fa 10 00 	movzbl 0x10fa0e,%eax
  102b85:	83 e0 7f             	and    $0x7f,%eax
  102b88:	a2 0e fa 10 00       	mov    %al,0x10fa0e
  102b8d:	b8 a0 08 11 00       	mov    $0x1108a0,%eax
  102b92:	c1 e8 18             	shr    $0x18,%eax
  102b95:	a2 0f fa 10 00       	mov    %al,0x10fa0f
    gdt[SEG_TSS].sd_s = 0;
  102b9a:	0f b6 05 0d fa 10 00 	movzbl 0x10fa0d,%eax
  102ba1:	83 e0 ef             	and    $0xffffffef,%eax
  102ba4:	a2 0d fa 10 00       	mov    %al,0x10fa0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102ba9:	68 10 fa 10 00       	push   $0x10fa10
  102bae:	e8 d7 fe ff ff       	call   102a8a <lgdt>
  102bb3:	83 c4 04             	add    $0x4,%esp
  102bb6:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102bbc:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102bc0:	0f 00 d8             	ltr    %ax
}
  102bc3:	90                   	nop

    // load the TSS
    ltr(GD_TSS);
}
  102bc4:	90                   	nop
  102bc5:	c9                   	leave  
  102bc6:	c3                   	ret    

00102bc7 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102bc7:	f3 0f 1e fb          	endbr32 
  102bcb:	55                   	push   %ebp
  102bcc:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102bce:	e8 ed fe ff ff       	call   102ac0 <gdt_init>
}
  102bd3:	90                   	nop
  102bd4:	5d                   	pop    %ebp
  102bd5:	c3                   	ret    

00102bd6 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  102bd6:	f3 0f 1e fb          	endbr32 
  102bda:	55                   	push   %ebp
  102bdb:	89 e5                	mov    %esp,%ebp
  102bdd:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102be0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  102be7:	eb 04                	jmp    102bed <strlen+0x17>
        cnt ++;
  102be9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
  102bed:	8b 45 08             	mov    0x8(%ebp),%eax
  102bf0:	8d 50 01             	lea    0x1(%eax),%edx
  102bf3:	89 55 08             	mov    %edx,0x8(%ebp)
  102bf6:	0f b6 00             	movzbl (%eax),%eax
  102bf9:	84 c0                	test   %al,%al
  102bfb:	75 ec                	jne    102be9 <strlen+0x13>
    }
    return cnt;
  102bfd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102c00:	c9                   	leave  
  102c01:	c3                   	ret    

00102c02 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  102c02:	f3 0f 1e fb          	endbr32 
  102c06:	55                   	push   %ebp
  102c07:	89 e5                	mov    %esp,%ebp
  102c09:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  102c0c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102c13:	eb 04                	jmp    102c19 <strnlen+0x17>
        cnt ++;
  102c15:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102c19:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102c1c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102c1f:	73 10                	jae    102c31 <strnlen+0x2f>
  102c21:	8b 45 08             	mov    0x8(%ebp),%eax
  102c24:	8d 50 01             	lea    0x1(%eax),%edx
  102c27:	89 55 08             	mov    %edx,0x8(%ebp)
  102c2a:	0f b6 00             	movzbl (%eax),%eax
  102c2d:	84 c0                	test   %al,%al
  102c2f:	75 e4                	jne    102c15 <strnlen+0x13>
    }
    return cnt;
  102c31:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102c34:	c9                   	leave  
  102c35:	c3                   	ret    

00102c36 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102c36:	f3 0f 1e fb          	endbr32 
  102c3a:	55                   	push   %ebp
  102c3b:	89 e5                	mov    %esp,%ebp
  102c3d:	57                   	push   %edi
  102c3e:	56                   	push   %esi
  102c3f:	83 ec 20             	sub    $0x20,%esp
  102c42:	8b 45 08             	mov    0x8(%ebp),%eax
  102c45:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c48:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c4b:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102c4e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102c51:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102c54:	89 d1                	mov    %edx,%ecx
  102c56:	89 c2                	mov    %eax,%edx
  102c58:	89 ce                	mov    %ecx,%esi
  102c5a:	89 d7                	mov    %edx,%edi
  102c5c:	ac                   	lods   %ds:(%esi),%al
  102c5d:	aa                   	stos   %al,%es:(%edi)
  102c5e:	84 c0                	test   %al,%al
  102c60:	75 fa                	jne    102c5c <strcpy+0x26>
  102c62:	89 fa                	mov    %edi,%edx
  102c64:	89 f1                	mov    %esi,%ecx
  102c66:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102c69:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102c6c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102c6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102c72:	83 c4 20             	add    $0x20,%esp
  102c75:	5e                   	pop    %esi
  102c76:	5f                   	pop    %edi
  102c77:	5d                   	pop    %ebp
  102c78:	c3                   	ret    

00102c79 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102c79:	f3 0f 1e fb          	endbr32 
  102c7d:	55                   	push   %ebp
  102c7e:	89 e5                	mov    %esp,%ebp
  102c80:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102c83:	8b 45 08             	mov    0x8(%ebp),%eax
  102c86:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102c89:	eb 21                	jmp    102cac <strncpy+0x33>
        if ((*p = *src) != '\0') {
  102c8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c8e:	0f b6 10             	movzbl (%eax),%edx
  102c91:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102c94:	88 10                	mov    %dl,(%eax)
  102c96:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102c99:	0f b6 00             	movzbl (%eax),%eax
  102c9c:	84 c0                	test   %al,%al
  102c9e:	74 04                	je     102ca4 <strncpy+0x2b>
            src ++;
  102ca0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  102ca4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102ca8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
  102cac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102cb0:	75 d9                	jne    102c8b <strncpy+0x12>
    }
    return dst;
  102cb2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102cb5:	c9                   	leave  
  102cb6:	c3                   	ret    

00102cb7 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102cb7:	f3 0f 1e fb          	endbr32 
  102cbb:	55                   	push   %ebp
  102cbc:	89 e5                	mov    %esp,%ebp
  102cbe:	57                   	push   %edi
  102cbf:	56                   	push   %esi
  102cc0:	83 ec 20             	sub    $0x20,%esp
  102cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  102cc6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102cc9:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ccc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102ccf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102cd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102cd5:	89 d1                	mov    %edx,%ecx
  102cd7:	89 c2                	mov    %eax,%edx
  102cd9:	89 ce                	mov    %ecx,%esi
  102cdb:	89 d7                	mov    %edx,%edi
  102cdd:	ac                   	lods   %ds:(%esi),%al
  102cde:	ae                   	scas   %es:(%edi),%al
  102cdf:	75 08                	jne    102ce9 <strcmp+0x32>
  102ce1:	84 c0                	test   %al,%al
  102ce3:	75 f8                	jne    102cdd <strcmp+0x26>
  102ce5:	31 c0                	xor    %eax,%eax
  102ce7:	eb 04                	jmp    102ced <strcmp+0x36>
  102ce9:	19 c0                	sbb    %eax,%eax
  102ceb:	0c 01                	or     $0x1,%al
  102ced:	89 fa                	mov    %edi,%edx
  102cef:	89 f1                	mov    %esi,%ecx
  102cf1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102cf4:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102cf7:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102cfa:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102cfd:	83 c4 20             	add    $0x20,%esp
  102d00:	5e                   	pop    %esi
  102d01:	5f                   	pop    %edi
  102d02:	5d                   	pop    %ebp
  102d03:	c3                   	ret    

00102d04 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102d04:	f3 0f 1e fb          	endbr32 
  102d08:	55                   	push   %ebp
  102d09:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102d0b:	eb 0c                	jmp    102d19 <strncmp+0x15>
        n --, s1 ++, s2 ++;
  102d0d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102d11:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102d15:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102d19:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d1d:	74 1a                	je     102d39 <strncmp+0x35>
  102d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  102d22:	0f b6 00             	movzbl (%eax),%eax
  102d25:	84 c0                	test   %al,%al
  102d27:	74 10                	je     102d39 <strncmp+0x35>
  102d29:	8b 45 08             	mov    0x8(%ebp),%eax
  102d2c:	0f b6 10             	movzbl (%eax),%edx
  102d2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d32:	0f b6 00             	movzbl (%eax),%eax
  102d35:	38 c2                	cmp    %al,%dl
  102d37:	74 d4                	je     102d0d <strncmp+0x9>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102d39:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102d3d:	74 18                	je     102d57 <strncmp+0x53>
  102d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  102d42:	0f b6 00             	movzbl (%eax),%eax
  102d45:	0f b6 d0             	movzbl %al,%edx
  102d48:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d4b:	0f b6 00             	movzbl (%eax),%eax
  102d4e:	0f b6 c0             	movzbl %al,%eax
  102d51:	29 c2                	sub    %eax,%edx
  102d53:	89 d0                	mov    %edx,%eax
  102d55:	eb 05                	jmp    102d5c <strncmp+0x58>
  102d57:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102d5c:	5d                   	pop    %ebp
  102d5d:	c3                   	ret    

00102d5e <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102d5e:	f3 0f 1e fb          	endbr32 
  102d62:	55                   	push   %ebp
  102d63:	89 e5                	mov    %esp,%ebp
  102d65:	83 ec 04             	sub    $0x4,%esp
  102d68:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d6b:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102d6e:	eb 14                	jmp    102d84 <strchr+0x26>
        if (*s == c) {
  102d70:	8b 45 08             	mov    0x8(%ebp),%eax
  102d73:	0f b6 00             	movzbl (%eax),%eax
  102d76:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102d79:	75 05                	jne    102d80 <strchr+0x22>
            return (char *)s;
  102d7b:	8b 45 08             	mov    0x8(%ebp),%eax
  102d7e:	eb 13                	jmp    102d93 <strchr+0x35>
        }
        s ++;
  102d80:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102d84:	8b 45 08             	mov    0x8(%ebp),%eax
  102d87:	0f b6 00             	movzbl (%eax),%eax
  102d8a:	84 c0                	test   %al,%al
  102d8c:	75 e2                	jne    102d70 <strchr+0x12>
    }
    return NULL;
  102d8e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102d93:	c9                   	leave  
  102d94:	c3                   	ret    

00102d95 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102d95:	f3 0f 1e fb          	endbr32 
  102d99:	55                   	push   %ebp
  102d9a:	89 e5                	mov    %esp,%ebp
  102d9c:	83 ec 04             	sub    $0x4,%esp
  102d9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102da2:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102da5:	eb 0f                	jmp    102db6 <strfind+0x21>
        if (*s == c) {
  102da7:	8b 45 08             	mov    0x8(%ebp),%eax
  102daa:	0f b6 00             	movzbl (%eax),%eax
  102dad:	38 45 fc             	cmp    %al,-0x4(%ebp)
  102db0:	74 10                	je     102dc2 <strfind+0x2d>
            break;
        }
        s ++;
  102db2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102db6:	8b 45 08             	mov    0x8(%ebp),%eax
  102db9:	0f b6 00             	movzbl (%eax),%eax
  102dbc:	84 c0                	test   %al,%al
  102dbe:	75 e7                	jne    102da7 <strfind+0x12>
  102dc0:	eb 01                	jmp    102dc3 <strfind+0x2e>
            break;
  102dc2:	90                   	nop
    }
    return (char *)s;
  102dc3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102dc6:	c9                   	leave  
  102dc7:	c3                   	ret    

00102dc8 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102dc8:	f3 0f 1e fb          	endbr32 
  102dcc:	55                   	push   %ebp
  102dcd:	89 e5                	mov    %esp,%ebp
  102dcf:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  102dd2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102dd9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102de0:	eb 04                	jmp    102de6 <strtol+0x1e>
        s ++;
  102de2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102de6:	8b 45 08             	mov    0x8(%ebp),%eax
  102de9:	0f b6 00             	movzbl (%eax),%eax
  102dec:	3c 20                	cmp    $0x20,%al
  102dee:	74 f2                	je     102de2 <strtol+0x1a>
  102df0:	8b 45 08             	mov    0x8(%ebp),%eax
  102df3:	0f b6 00             	movzbl (%eax),%eax
  102df6:	3c 09                	cmp    $0x9,%al
  102df8:	74 e8                	je     102de2 <strtol+0x1a>
    }

    // plus/minus sign
    if (*s == '+') {
  102dfa:	8b 45 08             	mov    0x8(%ebp),%eax
  102dfd:	0f b6 00             	movzbl (%eax),%eax
  102e00:	3c 2b                	cmp    $0x2b,%al
  102e02:	75 06                	jne    102e0a <strtol+0x42>
        s ++;
  102e04:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102e08:	eb 15                	jmp    102e1f <strtol+0x57>
    }
    else if (*s == '-') {
  102e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  102e0d:	0f b6 00             	movzbl (%eax),%eax
  102e10:	3c 2d                	cmp    $0x2d,%al
  102e12:	75 0b                	jne    102e1f <strtol+0x57>
        s ++, neg = 1;
  102e14:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102e18:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102e1f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102e23:	74 06                	je     102e2b <strtol+0x63>
  102e25:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102e29:	75 24                	jne    102e4f <strtol+0x87>
  102e2b:	8b 45 08             	mov    0x8(%ebp),%eax
  102e2e:	0f b6 00             	movzbl (%eax),%eax
  102e31:	3c 30                	cmp    $0x30,%al
  102e33:	75 1a                	jne    102e4f <strtol+0x87>
  102e35:	8b 45 08             	mov    0x8(%ebp),%eax
  102e38:	83 c0 01             	add    $0x1,%eax
  102e3b:	0f b6 00             	movzbl (%eax),%eax
  102e3e:	3c 78                	cmp    $0x78,%al
  102e40:	75 0d                	jne    102e4f <strtol+0x87>
        s += 2, base = 16;
  102e42:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102e46:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102e4d:	eb 2a                	jmp    102e79 <strtol+0xb1>
    }
    else if (base == 0 && s[0] == '0') {
  102e4f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102e53:	75 17                	jne    102e6c <strtol+0xa4>
  102e55:	8b 45 08             	mov    0x8(%ebp),%eax
  102e58:	0f b6 00             	movzbl (%eax),%eax
  102e5b:	3c 30                	cmp    $0x30,%al
  102e5d:	75 0d                	jne    102e6c <strtol+0xa4>
        s ++, base = 8;
  102e5f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102e63:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102e6a:	eb 0d                	jmp    102e79 <strtol+0xb1>
    }
    else if (base == 0) {
  102e6c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102e70:	75 07                	jne    102e79 <strtol+0xb1>
        base = 10;
  102e72:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102e79:	8b 45 08             	mov    0x8(%ebp),%eax
  102e7c:	0f b6 00             	movzbl (%eax),%eax
  102e7f:	3c 2f                	cmp    $0x2f,%al
  102e81:	7e 1b                	jle    102e9e <strtol+0xd6>
  102e83:	8b 45 08             	mov    0x8(%ebp),%eax
  102e86:	0f b6 00             	movzbl (%eax),%eax
  102e89:	3c 39                	cmp    $0x39,%al
  102e8b:	7f 11                	jg     102e9e <strtol+0xd6>
            dig = *s - '0';
  102e8d:	8b 45 08             	mov    0x8(%ebp),%eax
  102e90:	0f b6 00             	movzbl (%eax),%eax
  102e93:	0f be c0             	movsbl %al,%eax
  102e96:	83 e8 30             	sub    $0x30,%eax
  102e99:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102e9c:	eb 48                	jmp    102ee6 <strtol+0x11e>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  102ea1:	0f b6 00             	movzbl (%eax),%eax
  102ea4:	3c 60                	cmp    $0x60,%al
  102ea6:	7e 1b                	jle    102ec3 <strtol+0xfb>
  102ea8:	8b 45 08             	mov    0x8(%ebp),%eax
  102eab:	0f b6 00             	movzbl (%eax),%eax
  102eae:	3c 7a                	cmp    $0x7a,%al
  102eb0:	7f 11                	jg     102ec3 <strtol+0xfb>
            dig = *s - 'a' + 10;
  102eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  102eb5:	0f b6 00             	movzbl (%eax),%eax
  102eb8:	0f be c0             	movsbl %al,%eax
  102ebb:	83 e8 57             	sub    $0x57,%eax
  102ebe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102ec1:	eb 23                	jmp    102ee6 <strtol+0x11e>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  102ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  102ec6:	0f b6 00             	movzbl (%eax),%eax
  102ec9:	3c 40                	cmp    $0x40,%al
  102ecb:	7e 3c                	jle    102f09 <strtol+0x141>
  102ecd:	8b 45 08             	mov    0x8(%ebp),%eax
  102ed0:	0f b6 00             	movzbl (%eax),%eax
  102ed3:	3c 5a                	cmp    $0x5a,%al
  102ed5:	7f 32                	jg     102f09 <strtol+0x141>
            dig = *s - 'A' + 10;
  102ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  102eda:	0f b6 00             	movzbl (%eax),%eax
  102edd:	0f be c0             	movsbl %al,%eax
  102ee0:	83 e8 37             	sub    $0x37,%eax
  102ee3:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  102ee6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102ee9:	3b 45 10             	cmp    0x10(%ebp),%eax
  102eec:	7d 1a                	jge    102f08 <strtol+0x140>
            break;
        }
        s ++, val = (val * base) + dig;
  102eee:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102ef2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102ef5:	0f af 45 10          	imul   0x10(%ebp),%eax
  102ef9:	89 c2                	mov    %eax,%edx
  102efb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102efe:	01 d0                	add    %edx,%eax
  102f00:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (1) {
  102f03:	e9 71 ff ff ff       	jmp    102e79 <strtol+0xb1>
            break;
  102f08:	90                   	nop
        // we don't properly detect overflow!
    }

    if (endptr) {
  102f09:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102f0d:	74 08                	je     102f17 <strtol+0x14f>
        *endptr = (char *) s;
  102f0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f12:	8b 55 08             	mov    0x8(%ebp),%edx
  102f15:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102f17:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102f1b:	74 07                	je     102f24 <strtol+0x15c>
  102f1d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102f20:	f7 d8                	neg    %eax
  102f22:	eb 03                	jmp    102f27 <strtol+0x15f>
  102f24:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102f27:	c9                   	leave  
  102f28:	c3                   	ret    

00102f29 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102f29:	f3 0f 1e fb          	endbr32 
  102f2d:	55                   	push   %ebp
  102f2e:	89 e5                	mov    %esp,%ebp
  102f30:	57                   	push   %edi
  102f31:	83 ec 24             	sub    $0x24,%esp
  102f34:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f37:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102f3a:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  102f3e:	8b 55 08             	mov    0x8(%ebp),%edx
  102f41:	89 55 f8             	mov    %edx,-0x8(%ebp)
  102f44:	88 45 f7             	mov    %al,-0x9(%ebp)
  102f47:	8b 45 10             	mov    0x10(%ebp),%eax
  102f4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102f4d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102f50:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102f54:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102f57:	89 d7                	mov    %edx,%edi
  102f59:	f3 aa                	rep stos %al,%es:(%edi)
  102f5b:	89 fa                	mov    %edi,%edx
  102f5d:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102f60:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102f63:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102f66:	83 c4 24             	add    $0x24,%esp
  102f69:	5f                   	pop    %edi
  102f6a:	5d                   	pop    %ebp
  102f6b:	c3                   	ret    

00102f6c <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102f6c:	f3 0f 1e fb          	endbr32 
  102f70:	55                   	push   %ebp
  102f71:	89 e5                	mov    %esp,%ebp
  102f73:	57                   	push   %edi
  102f74:	56                   	push   %esi
  102f75:	53                   	push   %ebx
  102f76:	83 ec 30             	sub    $0x30,%esp
  102f79:	8b 45 08             	mov    0x8(%ebp),%eax
  102f7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f82:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102f85:	8b 45 10             	mov    0x10(%ebp),%eax
  102f88:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102f8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f8e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102f91:	73 42                	jae    102fd5 <memmove+0x69>
  102f93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f96:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102f99:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f9c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102f9f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102fa2:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102fa5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102fa8:	c1 e8 02             	shr    $0x2,%eax
  102fab:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102fad:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102fb0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102fb3:	89 d7                	mov    %edx,%edi
  102fb5:	89 c6                	mov    %eax,%esi
  102fb7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102fb9:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102fbc:	83 e1 03             	and    $0x3,%ecx
  102fbf:	74 02                	je     102fc3 <memmove+0x57>
  102fc1:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102fc3:	89 f0                	mov    %esi,%eax
  102fc5:	89 fa                	mov    %edi,%edx
  102fc7:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102fca:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102fcd:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  102fd0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        return __memcpy(dst, src, n);
  102fd3:	eb 36                	jmp    10300b <memmove+0x9f>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102fd5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102fd8:	8d 50 ff             	lea    -0x1(%eax),%edx
  102fdb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102fde:	01 c2                	add    %eax,%edx
  102fe0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102fe3:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102fe6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fe9:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  102fec:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102fef:	89 c1                	mov    %eax,%ecx
  102ff1:	89 d8                	mov    %ebx,%eax
  102ff3:	89 d6                	mov    %edx,%esi
  102ff5:	89 c7                	mov    %eax,%edi
  102ff7:	fd                   	std    
  102ff8:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102ffa:	fc                   	cld    
  102ffb:	89 f8                	mov    %edi,%eax
  102ffd:	89 f2                	mov    %esi,%edx
  102fff:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  103002:	89 55 c8             	mov    %edx,-0x38(%ebp)
  103005:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  103008:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  10300b:	83 c4 30             	add    $0x30,%esp
  10300e:	5b                   	pop    %ebx
  10300f:	5e                   	pop    %esi
  103010:	5f                   	pop    %edi
  103011:	5d                   	pop    %ebp
  103012:	c3                   	ret    

00103013 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  103013:	f3 0f 1e fb          	endbr32 
  103017:	55                   	push   %ebp
  103018:	89 e5                	mov    %esp,%ebp
  10301a:	57                   	push   %edi
  10301b:	56                   	push   %esi
  10301c:	83 ec 20             	sub    $0x20,%esp
  10301f:	8b 45 08             	mov    0x8(%ebp),%eax
  103022:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103025:	8b 45 0c             	mov    0xc(%ebp),%eax
  103028:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10302b:	8b 45 10             	mov    0x10(%ebp),%eax
  10302e:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  103031:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103034:	c1 e8 02             	shr    $0x2,%eax
  103037:	89 c1                	mov    %eax,%ecx
    asm volatile (
  103039:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10303c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10303f:	89 d7                	mov    %edx,%edi
  103041:	89 c6                	mov    %eax,%esi
  103043:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103045:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103048:	83 e1 03             	and    $0x3,%ecx
  10304b:	74 02                	je     10304f <memcpy+0x3c>
  10304d:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  10304f:	89 f0                	mov    %esi,%eax
  103051:	89 fa                	mov    %edi,%edx
  103053:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  103056:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  103059:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  10305c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  10305f:	83 c4 20             	add    $0x20,%esp
  103062:	5e                   	pop    %esi
  103063:	5f                   	pop    %edi
  103064:	5d                   	pop    %ebp
  103065:	c3                   	ret    

00103066 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  103066:	f3 0f 1e fb          	endbr32 
  10306a:	55                   	push   %ebp
  10306b:	89 e5                	mov    %esp,%ebp
  10306d:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  103070:	8b 45 08             	mov    0x8(%ebp),%eax
  103073:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  103076:	8b 45 0c             	mov    0xc(%ebp),%eax
  103079:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  10307c:	eb 30                	jmp    1030ae <memcmp+0x48>
        if (*s1 != *s2) {
  10307e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103081:	0f b6 10             	movzbl (%eax),%edx
  103084:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103087:	0f b6 00             	movzbl (%eax),%eax
  10308a:	38 c2                	cmp    %al,%dl
  10308c:	74 18                	je     1030a6 <memcmp+0x40>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  10308e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103091:	0f b6 00             	movzbl (%eax),%eax
  103094:	0f b6 d0             	movzbl %al,%edx
  103097:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10309a:	0f b6 00             	movzbl (%eax),%eax
  10309d:	0f b6 c0             	movzbl %al,%eax
  1030a0:	29 c2                	sub    %eax,%edx
  1030a2:	89 d0                	mov    %edx,%eax
  1030a4:	eb 1a                	jmp    1030c0 <memcmp+0x5a>
        }
        s1 ++, s2 ++;
  1030a6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1030aa:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
  1030ae:	8b 45 10             	mov    0x10(%ebp),%eax
  1030b1:	8d 50 ff             	lea    -0x1(%eax),%edx
  1030b4:	89 55 10             	mov    %edx,0x10(%ebp)
  1030b7:	85 c0                	test   %eax,%eax
  1030b9:	75 c3                	jne    10307e <memcmp+0x18>
    }
    return 0;
  1030bb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1030c0:	c9                   	leave  
  1030c1:	c3                   	ret    

001030c2 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  1030c2:	f3 0f 1e fb          	endbr32 
  1030c6:	55                   	push   %ebp
  1030c7:	89 e5                	mov    %esp,%ebp
  1030c9:	83 ec 38             	sub    $0x38,%esp
  1030cc:	8b 45 10             	mov    0x10(%ebp),%eax
  1030cf:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1030d2:	8b 45 14             	mov    0x14(%ebp),%eax
  1030d5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  1030d8:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1030db:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1030de:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1030e1:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  1030e4:	8b 45 18             	mov    0x18(%ebp),%eax
  1030e7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1030ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1030ed:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1030f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1030f3:	89 55 f0             	mov    %edx,-0x10(%ebp)
  1030f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1030f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1030fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  103100:	74 1c                	je     10311e <printnum+0x5c>
  103102:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103105:	ba 00 00 00 00       	mov    $0x0,%edx
  10310a:	f7 75 e4             	divl   -0x1c(%ebp)
  10310d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  103110:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103113:	ba 00 00 00 00       	mov    $0x0,%edx
  103118:	f7 75 e4             	divl   -0x1c(%ebp)
  10311b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10311e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103121:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103124:	f7 75 e4             	divl   -0x1c(%ebp)
  103127:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10312a:	89 55 dc             	mov    %edx,-0x24(%ebp)
  10312d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103130:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103133:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103136:	89 55 ec             	mov    %edx,-0x14(%ebp)
  103139:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10313c:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  10313f:	8b 45 18             	mov    0x18(%ebp),%eax
  103142:	ba 00 00 00 00       	mov    $0x0,%edx
  103147:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  10314a:	39 45 d0             	cmp    %eax,-0x30(%ebp)
  10314d:	19 d1                	sbb    %edx,%ecx
  10314f:	72 37                	jb     103188 <printnum+0xc6>
        printnum(putch, putdat, result, base, width - 1, padc);
  103151:	8b 45 1c             	mov    0x1c(%ebp),%eax
  103154:	83 e8 01             	sub    $0x1,%eax
  103157:	83 ec 04             	sub    $0x4,%esp
  10315a:	ff 75 20             	pushl  0x20(%ebp)
  10315d:	50                   	push   %eax
  10315e:	ff 75 18             	pushl  0x18(%ebp)
  103161:	ff 75 ec             	pushl  -0x14(%ebp)
  103164:	ff 75 e8             	pushl  -0x18(%ebp)
  103167:	ff 75 0c             	pushl  0xc(%ebp)
  10316a:	ff 75 08             	pushl  0x8(%ebp)
  10316d:	e8 50 ff ff ff       	call   1030c2 <printnum>
  103172:	83 c4 20             	add    $0x20,%esp
  103175:	eb 1b                	jmp    103192 <printnum+0xd0>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  103177:	83 ec 08             	sub    $0x8,%esp
  10317a:	ff 75 0c             	pushl  0xc(%ebp)
  10317d:	ff 75 20             	pushl  0x20(%ebp)
  103180:	8b 45 08             	mov    0x8(%ebp),%eax
  103183:	ff d0                	call   *%eax
  103185:	83 c4 10             	add    $0x10,%esp
        while (-- width > 0)
  103188:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  10318c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  103190:	7f e5                	jg     103177 <printnum+0xb5>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  103192:	8b 45 d8             	mov    -0x28(%ebp),%eax
  103195:	05 b0 3e 10 00       	add    $0x103eb0,%eax
  10319a:	0f b6 00             	movzbl (%eax),%eax
  10319d:	0f be c0             	movsbl %al,%eax
  1031a0:	83 ec 08             	sub    $0x8,%esp
  1031a3:	ff 75 0c             	pushl  0xc(%ebp)
  1031a6:	50                   	push   %eax
  1031a7:	8b 45 08             	mov    0x8(%ebp),%eax
  1031aa:	ff d0                	call   *%eax
  1031ac:	83 c4 10             	add    $0x10,%esp
}
  1031af:	90                   	nop
  1031b0:	c9                   	leave  
  1031b1:	c3                   	ret    

001031b2 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  1031b2:	f3 0f 1e fb          	endbr32 
  1031b6:	55                   	push   %ebp
  1031b7:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  1031b9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  1031bd:	7e 14                	jle    1031d3 <getuint+0x21>
        return va_arg(*ap, unsigned long long);
  1031bf:	8b 45 08             	mov    0x8(%ebp),%eax
  1031c2:	8b 00                	mov    (%eax),%eax
  1031c4:	8d 48 08             	lea    0x8(%eax),%ecx
  1031c7:	8b 55 08             	mov    0x8(%ebp),%edx
  1031ca:	89 0a                	mov    %ecx,(%edx)
  1031cc:	8b 50 04             	mov    0x4(%eax),%edx
  1031cf:	8b 00                	mov    (%eax),%eax
  1031d1:	eb 30                	jmp    103203 <getuint+0x51>
    }
    else if (lflag) {
  1031d3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1031d7:	74 16                	je     1031ef <getuint+0x3d>
        return va_arg(*ap, unsigned long);
  1031d9:	8b 45 08             	mov    0x8(%ebp),%eax
  1031dc:	8b 00                	mov    (%eax),%eax
  1031de:	8d 48 04             	lea    0x4(%eax),%ecx
  1031e1:	8b 55 08             	mov    0x8(%ebp),%edx
  1031e4:	89 0a                	mov    %ecx,(%edx)
  1031e6:	8b 00                	mov    (%eax),%eax
  1031e8:	ba 00 00 00 00       	mov    $0x0,%edx
  1031ed:	eb 14                	jmp    103203 <getuint+0x51>
    }
    else {
        return va_arg(*ap, unsigned int);
  1031ef:	8b 45 08             	mov    0x8(%ebp),%eax
  1031f2:	8b 00                	mov    (%eax),%eax
  1031f4:	8d 48 04             	lea    0x4(%eax),%ecx
  1031f7:	8b 55 08             	mov    0x8(%ebp),%edx
  1031fa:	89 0a                	mov    %ecx,(%edx)
  1031fc:	8b 00                	mov    (%eax),%eax
  1031fe:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  103203:	5d                   	pop    %ebp
  103204:	c3                   	ret    

00103205 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  103205:	f3 0f 1e fb          	endbr32 
  103209:	55                   	push   %ebp
  10320a:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  10320c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  103210:	7e 14                	jle    103226 <getint+0x21>
        return va_arg(*ap, long long);
  103212:	8b 45 08             	mov    0x8(%ebp),%eax
  103215:	8b 00                	mov    (%eax),%eax
  103217:	8d 48 08             	lea    0x8(%eax),%ecx
  10321a:	8b 55 08             	mov    0x8(%ebp),%edx
  10321d:	89 0a                	mov    %ecx,(%edx)
  10321f:	8b 50 04             	mov    0x4(%eax),%edx
  103222:	8b 00                	mov    (%eax),%eax
  103224:	eb 28                	jmp    10324e <getint+0x49>
    }
    else if (lflag) {
  103226:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  10322a:	74 12                	je     10323e <getint+0x39>
        return va_arg(*ap, long);
  10322c:	8b 45 08             	mov    0x8(%ebp),%eax
  10322f:	8b 00                	mov    (%eax),%eax
  103231:	8d 48 04             	lea    0x4(%eax),%ecx
  103234:	8b 55 08             	mov    0x8(%ebp),%edx
  103237:	89 0a                	mov    %ecx,(%edx)
  103239:	8b 00                	mov    (%eax),%eax
  10323b:	99                   	cltd   
  10323c:	eb 10                	jmp    10324e <getint+0x49>
    }
    else {
        return va_arg(*ap, int);
  10323e:	8b 45 08             	mov    0x8(%ebp),%eax
  103241:	8b 00                	mov    (%eax),%eax
  103243:	8d 48 04             	lea    0x4(%eax),%ecx
  103246:	8b 55 08             	mov    0x8(%ebp),%edx
  103249:	89 0a                	mov    %ecx,(%edx)
  10324b:	8b 00                	mov    (%eax),%eax
  10324d:	99                   	cltd   
    }
}
  10324e:	5d                   	pop    %ebp
  10324f:	c3                   	ret    

00103250 <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  103250:	f3 0f 1e fb          	endbr32 
  103254:	55                   	push   %ebp
  103255:	89 e5                	mov    %esp,%ebp
  103257:	83 ec 18             	sub    $0x18,%esp
    va_list ap;

    va_start(ap, fmt);
  10325a:	8d 45 14             	lea    0x14(%ebp),%eax
  10325d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  103260:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103263:	50                   	push   %eax
  103264:	ff 75 10             	pushl  0x10(%ebp)
  103267:	ff 75 0c             	pushl  0xc(%ebp)
  10326a:	ff 75 08             	pushl  0x8(%ebp)
  10326d:	e8 06 00 00 00       	call   103278 <vprintfmt>
  103272:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  103275:	90                   	nop
  103276:	c9                   	leave  
  103277:	c3                   	ret    

00103278 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  103278:	f3 0f 1e fb          	endbr32 
  10327c:	55                   	push   %ebp
  10327d:	89 e5                	mov    %esp,%ebp
  10327f:	56                   	push   %esi
  103280:	53                   	push   %ebx
  103281:	83 ec 20             	sub    $0x20,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103284:	eb 17                	jmp    10329d <vprintfmt+0x25>
            if (ch == '\0') {
  103286:	85 db                	test   %ebx,%ebx
  103288:	0f 84 8f 03 00 00    	je     10361d <vprintfmt+0x3a5>
                return;
            }
            putch(ch, putdat);
  10328e:	83 ec 08             	sub    $0x8,%esp
  103291:	ff 75 0c             	pushl  0xc(%ebp)
  103294:	53                   	push   %ebx
  103295:	8b 45 08             	mov    0x8(%ebp),%eax
  103298:	ff d0                	call   *%eax
  10329a:	83 c4 10             	add    $0x10,%esp
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  10329d:	8b 45 10             	mov    0x10(%ebp),%eax
  1032a0:	8d 50 01             	lea    0x1(%eax),%edx
  1032a3:	89 55 10             	mov    %edx,0x10(%ebp)
  1032a6:	0f b6 00             	movzbl (%eax),%eax
  1032a9:	0f b6 d8             	movzbl %al,%ebx
  1032ac:	83 fb 25             	cmp    $0x25,%ebx
  1032af:	75 d5                	jne    103286 <vprintfmt+0xe>
        }

        // Process a %-escape sequence
        char padc = ' ';
  1032b1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  1032b5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  1032bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1032bf:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  1032c2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  1032c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1032cc:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  1032cf:	8b 45 10             	mov    0x10(%ebp),%eax
  1032d2:	8d 50 01             	lea    0x1(%eax),%edx
  1032d5:	89 55 10             	mov    %edx,0x10(%ebp)
  1032d8:	0f b6 00             	movzbl (%eax),%eax
  1032db:	0f b6 d8             	movzbl %al,%ebx
  1032de:	8d 43 dd             	lea    -0x23(%ebx),%eax
  1032e1:	83 f8 55             	cmp    $0x55,%eax
  1032e4:	0f 87 06 03 00 00    	ja     1035f0 <vprintfmt+0x378>
  1032ea:	8b 04 85 d4 3e 10 00 	mov    0x103ed4(,%eax,4),%eax
  1032f1:	3e ff e0             	notrack jmp *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  1032f4:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  1032f8:	eb d5                	jmp    1032cf <vprintfmt+0x57>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  1032fa:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  1032fe:	eb cf                	jmp    1032cf <vprintfmt+0x57>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  103300:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  103307:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10330a:	89 d0                	mov    %edx,%eax
  10330c:	c1 e0 02             	shl    $0x2,%eax
  10330f:	01 d0                	add    %edx,%eax
  103311:	01 c0                	add    %eax,%eax
  103313:	01 d8                	add    %ebx,%eax
  103315:	83 e8 30             	sub    $0x30,%eax
  103318:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  10331b:	8b 45 10             	mov    0x10(%ebp),%eax
  10331e:	0f b6 00             	movzbl (%eax),%eax
  103321:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  103324:	83 fb 2f             	cmp    $0x2f,%ebx
  103327:	7e 39                	jle    103362 <vprintfmt+0xea>
  103329:	83 fb 39             	cmp    $0x39,%ebx
  10332c:	7f 34                	jg     103362 <vprintfmt+0xea>
            for (precision = 0; ; ++ fmt) {
  10332e:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
  103332:	eb d3                	jmp    103307 <vprintfmt+0x8f>
                }
            }
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  103334:	8b 45 14             	mov    0x14(%ebp),%eax
  103337:	8d 50 04             	lea    0x4(%eax),%edx
  10333a:	89 55 14             	mov    %edx,0x14(%ebp)
  10333d:	8b 00                	mov    (%eax),%eax
  10333f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  103342:	eb 1f                	jmp    103363 <vprintfmt+0xeb>

        case '.':
            if (width < 0)
  103344:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103348:	79 85                	jns    1032cf <vprintfmt+0x57>
                width = 0;
  10334a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  103351:	e9 79 ff ff ff       	jmp    1032cf <vprintfmt+0x57>

        case '#':
            altflag = 1;
  103356:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  10335d:	e9 6d ff ff ff       	jmp    1032cf <vprintfmt+0x57>
            goto process_precision;
  103362:	90                   	nop

        process_precision:
            if (width < 0)
  103363:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103367:	0f 89 62 ff ff ff    	jns    1032cf <vprintfmt+0x57>
                width = precision, precision = -1;
  10336d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103370:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103373:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  10337a:	e9 50 ff ff ff       	jmp    1032cf <vprintfmt+0x57>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  10337f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  103383:	e9 47 ff ff ff       	jmp    1032cf <vprintfmt+0x57>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  103388:	8b 45 14             	mov    0x14(%ebp),%eax
  10338b:	8d 50 04             	lea    0x4(%eax),%edx
  10338e:	89 55 14             	mov    %edx,0x14(%ebp)
  103391:	8b 00                	mov    (%eax),%eax
  103393:	83 ec 08             	sub    $0x8,%esp
  103396:	ff 75 0c             	pushl  0xc(%ebp)
  103399:	50                   	push   %eax
  10339a:	8b 45 08             	mov    0x8(%ebp),%eax
  10339d:	ff d0                	call   *%eax
  10339f:	83 c4 10             	add    $0x10,%esp
            break;
  1033a2:	e9 71 02 00 00       	jmp    103618 <vprintfmt+0x3a0>

        // error message
        case 'e':
            err = va_arg(ap, int);
  1033a7:	8b 45 14             	mov    0x14(%ebp),%eax
  1033aa:	8d 50 04             	lea    0x4(%eax),%edx
  1033ad:	89 55 14             	mov    %edx,0x14(%ebp)
  1033b0:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  1033b2:	85 db                	test   %ebx,%ebx
  1033b4:	79 02                	jns    1033b8 <vprintfmt+0x140>
                err = -err;
  1033b6:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  1033b8:	83 fb 06             	cmp    $0x6,%ebx
  1033bb:	7f 0b                	jg     1033c8 <vprintfmt+0x150>
  1033bd:	8b 34 9d 94 3e 10 00 	mov    0x103e94(,%ebx,4),%esi
  1033c4:	85 f6                	test   %esi,%esi
  1033c6:	75 19                	jne    1033e1 <vprintfmt+0x169>
                printfmt(putch, putdat, "error %d", err);
  1033c8:	53                   	push   %ebx
  1033c9:	68 c1 3e 10 00       	push   $0x103ec1
  1033ce:	ff 75 0c             	pushl  0xc(%ebp)
  1033d1:	ff 75 08             	pushl  0x8(%ebp)
  1033d4:	e8 77 fe ff ff       	call   103250 <printfmt>
  1033d9:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  1033dc:	e9 37 02 00 00       	jmp    103618 <vprintfmt+0x3a0>
                printfmt(putch, putdat, "%s", p);
  1033e1:	56                   	push   %esi
  1033e2:	68 ca 3e 10 00       	push   $0x103eca
  1033e7:	ff 75 0c             	pushl  0xc(%ebp)
  1033ea:	ff 75 08             	pushl  0x8(%ebp)
  1033ed:	e8 5e fe ff ff       	call   103250 <printfmt>
  1033f2:	83 c4 10             	add    $0x10,%esp
            break;
  1033f5:	e9 1e 02 00 00       	jmp    103618 <vprintfmt+0x3a0>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  1033fa:	8b 45 14             	mov    0x14(%ebp),%eax
  1033fd:	8d 50 04             	lea    0x4(%eax),%edx
  103400:	89 55 14             	mov    %edx,0x14(%ebp)
  103403:	8b 30                	mov    (%eax),%esi
  103405:	85 f6                	test   %esi,%esi
  103407:	75 05                	jne    10340e <vprintfmt+0x196>
                p = "(null)";
  103409:	be cd 3e 10 00       	mov    $0x103ecd,%esi
            }
            if (width > 0 && padc != '-') {
  10340e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103412:	7e 76                	jle    10348a <vprintfmt+0x212>
  103414:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  103418:	74 70                	je     10348a <vprintfmt+0x212>
                for (width -= strnlen(p, precision); width > 0; width --) {
  10341a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10341d:	83 ec 08             	sub    $0x8,%esp
  103420:	50                   	push   %eax
  103421:	56                   	push   %esi
  103422:	e8 db f7 ff ff       	call   102c02 <strnlen>
  103427:	83 c4 10             	add    $0x10,%esp
  10342a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  10342d:	29 c2                	sub    %eax,%edx
  10342f:	89 d0                	mov    %edx,%eax
  103431:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103434:	eb 17                	jmp    10344d <vprintfmt+0x1d5>
                    putch(padc, putdat);
  103436:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  10343a:	83 ec 08             	sub    $0x8,%esp
  10343d:	ff 75 0c             	pushl  0xc(%ebp)
  103440:	50                   	push   %eax
  103441:	8b 45 08             	mov    0x8(%ebp),%eax
  103444:	ff d0                	call   *%eax
  103446:	83 c4 10             	add    $0x10,%esp
                for (width -= strnlen(p, precision); width > 0; width --) {
  103449:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  10344d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103451:	7f e3                	jg     103436 <vprintfmt+0x1be>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  103453:	eb 35                	jmp    10348a <vprintfmt+0x212>
                if (altflag && (ch < ' ' || ch > '~')) {
  103455:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  103459:	74 1c                	je     103477 <vprintfmt+0x1ff>
  10345b:	83 fb 1f             	cmp    $0x1f,%ebx
  10345e:	7e 05                	jle    103465 <vprintfmt+0x1ed>
  103460:	83 fb 7e             	cmp    $0x7e,%ebx
  103463:	7e 12                	jle    103477 <vprintfmt+0x1ff>
                    putch('?', putdat);
  103465:	83 ec 08             	sub    $0x8,%esp
  103468:	ff 75 0c             	pushl  0xc(%ebp)
  10346b:	6a 3f                	push   $0x3f
  10346d:	8b 45 08             	mov    0x8(%ebp),%eax
  103470:	ff d0                	call   *%eax
  103472:	83 c4 10             	add    $0x10,%esp
  103475:	eb 0f                	jmp    103486 <vprintfmt+0x20e>
                }
                else {
                    putch(ch, putdat);
  103477:	83 ec 08             	sub    $0x8,%esp
  10347a:	ff 75 0c             	pushl  0xc(%ebp)
  10347d:	53                   	push   %ebx
  10347e:	8b 45 08             	mov    0x8(%ebp),%eax
  103481:	ff d0                	call   *%eax
  103483:	83 c4 10             	add    $0x10,%esp
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  103486:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  10348a:	89 f0                	mov    %esi,%eax
  10348c:	8d 70 01             	lea    0x1(%eax),%esi
  10348f:	0f b6 00             	movzbl (%eax),%eax
  103492:	0f be d8             	movsbl %al,%ebx
  103495:	85 db                	test   %ebx,%ebx
  103497:	74 26                	je     1034bf <vprintfmt+0x247>
  103499:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10349d:	78 b6                	js     103455 <vprintfmt+0x1dd>
  10349f:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  1034a3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  1034a7:	79 ac                	jns    103455 <vprintfmt+0x1dd>
                }
            }
            for (; width > 0; width --) {
  1034a9:	eb 14                	jmp    1034bf <vprintfmt+0x247>
                putch(' ', putdat);
  1034ab:	83 ec 08             	sub    $0x8,%esp
  1034ae:	ff 75 0c             	pushl  0xc(%ebp)
  1034b1:	6a 20                	push   $0x20
  1034b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1034b6:	ff d0                	call   *%eax
  1034b8:	83 c4 10             	add    $0x10,%esp
            for (; width > 0; width --) {
  1034bb:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  1034bf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1034c3:	7f e6                	jg     1034ab <vprintfmt+0x233>
            }
            break;
  1034c5:	e9 4e 01 00 00       	jmp    103618 <vprintfmt+0x3a0>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  1034ca:	83 ec 08             	sub    $0x8,%esp
  1034cd:	ff 75 e0             	pushl  -0x20(%ebp)
  1034d0:	8d 45 14             	lea    0x14(%ebp),%eax
  1034d3:	50                   	push   %eax
  1034d4:	e8 2c fd ff ff       	call   103205 <getint>
  1034d9:	83 c4 10             	add    $0x10,%esp
  1034dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034df:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  1034e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1034e8:	85 d2                	test   %edx,%edx
  1034ea:	79 23                	jns    10350f <vprintfmt+0x297>
                putch('-', putdat);
  1034ec:	83 ec 08             	sub    $0x8,%esp
  1034ef:	ff 75 0c             	pushl  0xc(%ebp)
  1034f2:	6a 2d                	push   $0x2d
  1034f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1034f7:	ff d0                	call   *%eax
  1034f9:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
  1034fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034ff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103502:	f7 d8                	neg    %eax
  103504:	83 d2 00             	adc    $0x0,%edx
  103507:	f7 da                	neg    %edx
  103509:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10350c:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  10350f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  103516:	e9 9f 00 00 00       	jmp    1035ba <vprintfmt+0x342>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  10351b:	83 ec 08             	sub    $0x8,%esp
  10351e:	ff 75 e0             	pushl  -0x20(%ebp)
  103521:	8d 45 14             	lea    0x14(%ebp),%eax
  103524:	50                   	push   %eax
  103525:	e8 88 fc ff ff       	call   1031b2 <getuint>
  10352a:	83 c4 10             	add    $0x10,%esp
  10352d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103530:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  103533:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  10353a:	eb 7e                	jmp    1035ba <vprintfmt+0x342>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  10353c:	83 ec 08             	sub    $0x8,%esp
  10353f:	ff 75 e0             	pushl  -0x20(%ebp)
  103542:	8d 45 14             	lea    0x14(%ebp),%eax
  103545:	50                   	push   %eax
  103546:	e8 67 fc ff ff       	call   1031b2 <getuint>
  10354b:	83 c4 10             	add    $0x10,%esp
  10354e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103551:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  103554:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  10355b:	eb 5d                	jmp    1035ba <vprintfmt+0x342>

        // pointer
        case 'p':
            putch('0', putdat);
  10355d:	83 ec 08             	sub    $0x8,%esp
  103560:	ff 75 0c             	pushl  0xc(%ebp)
  103563:	6a 30                	push   $0x30
  103565:	8b 45 08             	mov    0x8(%ebp),%eax
  103568:	ff d0                	call   *%eax
  10356a:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
  10356d:	83 ec 08             	sub    $0x8,%esp
  103570:	ff 75 0c             	pushl  0xc(%ebp)
  103573:	6a 78                	push   $0x78
  103575:	8b 45 08             	mov    0x8(%ebp),%eax
  103578:	ff d0                	call   *%eax
  10357a:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  10357d:	8b 45 14             	mov    0x14(%ebp),%eax
  103580:	8d 50 04             	lea    0x4(%eax),%edx
  103583:	89 55 14             	mov    %edx,0x14(%ebp)
  103586:	8b 00                	mov    (%eax),%eax
  103588:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10358b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  103592:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  103599:	eb 1f                	jmp    1035ba <vprintfmt+0x342>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  10359b:	83 ec 08             	sub    $0x8,%esp
  10359e:	ff 75 e0             	pushl  -0x20(%ebp)
  1035a1:	8d 45 14             	lea    0x14(%ebp),%eax
  1035a4:	50                   	push   %eax
  1035a5:	e8 08 fc ff ff       	call   1031b2 <getuint>
  1035aa:	83 c4 10             	add    $0x10,%esp
  1035ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1035b0:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  1035b3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  1035ba:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  1035be:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1035c1:	83 ec 04             	sub    $0x4,%esp
  1035c4:	52                   	push   %edx
  1035c5:	ff 75 e8             	pushl  -0x18(%ebp)
  1035c8:	50                   	push   %eax
  1035c9:	ff 75 f4             	pushl  -0xc(%ebp)
  1035cc:	ff 75 f0             	pushl  -0x10(%ebp)
  1035cf:	ff 75 0c             	pushl  0xc(%ebp)
  1035d2:	ff 75 08             	pushl  0x8(%ebp)
  1035d5:	e8 e8 fa ff ff       	call   1030c2 <printnum>
  1035da:	83 c4 20             	add    $0x20,%esp
            break;
  1035dd:	eb 39                	jmp    103618 <vprintfmt+0x3a0>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  1035df:	83 ec 08             	sub    $0x8,%esp
  1035e2:	ff 75 0c             	pushl  0xc(%ebp)
  1035e5:	53                   	push   %ebx
  1035e6:	8b 45 08             	mov    0x8(%ebp),%eax
  1035e9:	ff d0                	call   *%eax
  1035eb:	83 c4 10             	add    $0x10,%esp
            break;
  1035ee:	eb 28                	jmp    103618 <vprintfmt+0x3a0>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  1035f0:	83 ec 08             	sub    $0x8,%esp
  1035f3:	ff 75 0c             	pushl  0xc(%ebp)
  1035f6:	6a 25                	push   $0x25
  1035f8:	8b 45 08             	mov    0x8(%ebp),%eax
  1035fb:	ff d0                	call   *%eax
  1035fd:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
  103600:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103604:	eb 04                	jmp    10360a <vprintfmt+0x392>
  103606:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  10360a:	8b 45 10             	mov    0x10(%ebp),%eax
  10360d:	83 e8 01             	sub    $0x1,%eax
  103610:	0f b6 00             	movzbl (%eax),%eax
  103613:	3c 25                	cmp    $0x25,%al
  103615:	75 ef                	jne    103606 <vprintfmt+0x38e>
                /* do nothing */;
            break;
  103617:	90                   	nop
    while (1) {
  103618:	e9 67 fc ff ff       	jmp    103284 <vprintfmt+0xc>
                return;
  10361d:	90                   	nop
        }
    }
}
  10361e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  103621:	5b                   	pop    %ebx
  103622:	5e                   	pop    %esi
  103623:	5d                   	pop    %ebp
  103624:	c3                   	ret    

00103625 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  103625:	f3 0f 1e fb          	endbr32 
  103629:	55                   	push   %ebp
  10362a:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  10362c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10362f:	8b 40 08             	mov    0x8(%eax),%eax
  103632:	8d 50 01             	lea    0x1(%eax),%edx
  103635:	8b 45 0c             	mov    0xc(%ebp),%eax
  103638:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  10363b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10363e:	8b 10                	mov    (%eax),%edx
  103640:	8b 45 0c             	mov    0xc(%ebp),%eax
  103643:	8b 40 04             	mov    0x4(%eax),%eax
  103646:	39 c2                	cmp    %eax,%edx
  103648:	73 12                	jae    10365c <sprintputch+0x37>
        *b->buf ++ = ch;
  10364a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10364d:	8b 00                	mov    (%eax),%eax
  10364f:	8d 48 01             	lea    0x1(%eax),%ecx
  103652:	8b 55 0c             	mov    0xc(%ebp),%edx
  103655:	89 0a                	mov    %ecx,(%edx)
  103657:	8b 55 08             	mov    0x8(%ebp),%edx
  10365a:	88 10                	mov    %dl,(%eax)
    }
}
  10365c:	90                   	nop
  10365d:	5d                   	pop    %ebp
  10365e:	c3                   	ret    

0010365f <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  10365f:	f3 0f 1e fb          	endbr32 
  103663:	55                   	push   %ebp
  103664:	89 e5                	mov    %esp,%ebp
  103666:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  103669:	8d 45 14             	lea    0x14(%ebp),%eax
  10366c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  10366f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103672:	50                   	push   %eax
  103673:	ff 75 10             	pushl  0x10(%ebp)
  103676:	ff 75 0c             	pushl  0xc(%ebp)
  103679:	ff 75 08             	pushl  0x8(%ebp)
  10367c:	e8 0b 00 00 00       	call   10368c <vsnprintf>
  103681:	83 c4 10             	add    $0x10,%esp
  103684:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103687:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10368a:	c9                   	leave  
  10368b:	c3                   	ret    

0010368c <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  10368c:	f3 0f 1e fb          	endbr32 
  103690:	55                   	push   %ebp
  103691:	89 e5                	mov    %esp,%ebp
  103693:	83 ec 18             	sub    $0x18,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  103696:	8b 45 08             	mov    0x8(%ebp),%eax
  103699:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10369c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10369f:	8d 50 ff             	lea    -0x1(%eax),%edx
  1036a2:	8b 45 08             	mov    0x8(%ebp),%eax
  1036a5:	01 d0                	add    %edx,%eax
  1036a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1036aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  1036b1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1036b5:	74 0a                	je     1036c1 <vsnprintf+0x35>
  1036b7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1036ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1036bd:	39 c2                	cmp    %eax,%edx
  1036bf:	76 07                	jbe    1036c8 <vsnprintf+0x3c>
        return -E_INVAL;
  1036c1:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  1036c6:	eb 20                	jmp    1036e8 <vsnprintf+0x5c>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  1036c8:	ff 75 14             	pushl  0x14(%ebp)
  1036cb:	ff 75 10             	pushl  0x10(%ebp)
  1036ce:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1036d1:	50                   	push   %eax
  1036d2:	68 25 36 10 00       	push   $0x103625
  1036d7:	e8 9c fb ff ff       	call   103278 <vprintfmt>
  1036dc:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
  1036df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1036e2:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1036e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1036e8:	c9                   	leave  
  1036e9:	c3                   	ret    
