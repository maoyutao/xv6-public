
_vim：     文件格式 elf32-i386


Disassembly of section .text:

00000000 <main>:
    }
}

int
main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	56                   	push   %esi
       e:	53                   	push   %ebx
       f:	51                   	push   %ecx
      10:	83 ec 1c             	sub    $0x1c,%esp
    char buf[1];
    int i;

    if (argc > 1){
      13:	83 39 01             	cmpl   $0x1,(%ecx)
    }
}

int
main(int argc, char *argv[])
{
      16:	8b 71 04             	mov    0x4(%ecx),%esi
    char buf[1];
    int i;

    if (argc > 1){
      19:	0f 8e 47 01 00 00    	jle    166 <main+0x166>
        if (openFile(argv[1]) < 0)
      1f:	83 ec 0c             	sub    $0xc,%esp
      22:	ff 76 04             	pushl  0x4(%esi)
      25:	e8 06 03 00 00       	call   330 <openFile>
      2a:	83 c4 10             	add    $0x10,%esp
      2d:	85 c0                	test   %eax,%eax
      2f:	0f 88 1c 01 00 00    	js     151 <main+0x151>
      35:	31 db                	xor    %ebx,%ebx
      37:	eb 17                	jmp    50 <main+0x50>
      39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        {
            printf(1, "vim: cannot open %s\n", argv[1]);
            exit();
        }
        for (i = 0; i < strlen(argv[1]); ++i)
            filename[i] = argv[1][i];//将命令行的第1个参数作为文件名filename
      40:	8b 46 04             	mov    0x4(%esi),%eax
      43:	0f b6 04 18          	movzbl (%eax,%ebx,1),%eax
        if (openFile(argv[1]) < 0)
        {
            printf(1, "vim: cannot open %s\n", argv[1]);
            exit();
        }
        for (i = 0; i < strlen(argv[1]); ++i)
      47:	83 c3 01             	add    $0x1,%ebx
            filename[i] = argv[1][i];//将命令行的第1个参数作为文件名filename
      4a:	88 83 df 28 00 00    	mov    %al,0x28df(%ebx)
        if (openFile(argv[1]) < 0)
        {
            printf(1, "vim: cannot open %s\n", argv[1]);
            exit();
        }
        for (i = 0; i < strlen(argv[1]); ++i)
      50:	83 ec 0c             	sub    $0xc,%esp
      53:	ff 76 04             	pushl  0x4(%esi)
      56:	e8 15 18 00 00       	call   1870 <strlen>
      5b:	83 c4 10             	add    $0x10,%esp
      5e:	39 d8                	cmp    %ebx,%eax
      60:	77 de                	ja     40 <main+0x40>
            filename[i] = argv[1][i];//将命令行的第1个参数作为文件名filename
        filename[i] = 0;
        if (num_line == 0)//如果文件中原先没有内容，则
      62:	8b 15 88 28 00 00    	mov    0x2888,%edx
            printf(1, "vim: cannot open %s\n", argv[1]);
            exit();
        }
        for (i = 0; i < strlen(argv[1]); ++i)
            filename[i] = argv[1][i];//将命令行的第1个参数作为文件名filename
        filename[i] = 0;
      68:	c6 83 e0 28 00 00 00 	movb   $0x0,0x28e0(%ebx)
        if (num_line == 0)//如果文件中原先没有内容，则
      6f:	85 d2                	test   %edx,%edx
      71:	0f 84 d0 00 00 00    	je     147 <main+0x147>
            insertline();//插入一行内容
        moveCursor(-100,-100);//光标移到左上方
      77:	83 ec 08             	sub    $0x8,%esp
      7a:	8d 5d e7             	lea    -0x19(%ebp),%ebx
      7d:	6a 9c                	push   $0xffffff9c
      7f:	6a 9c                	push   $0xffffff9c
      81:	e8 9a 0a 00 00       	call   b20 <moveCursor>

void 
initColorConfiguration()//初始化颜色配置
{
    //首先尝试从配置文件中读入颜色设置
    BACKGROUND_COLOR = BLACK;//背景色
      86:	c7 05 44 29 00 00 00 	movl   $0x0,0x2944
      8d:	00 00 00 
    RESERVERED_WORD_COLOR = BLUE;//保留字的颜色
      90:	c7 05 dc 50 00 00 00 	movl   $0x900,0x50dc
      97:	09 00 00 
    PARAMETER_COLOR = DARKGREEN;//常量的颜色
      9a:	c7 05 c0 28 00 00 00 	movl   $0x200,0x28c0
      a1:	02 00 00 
    VARIABLE_COLOR = WHITE;//变量的颜色
      a4:	c7 05 d4 50 00 00 00 	movl   $0xf00,0x50d4
      ab:	0f 00 00 
    EMPHASIZE_WORD_COLOR = RED;//强调字体的颜色
      ae:	c7 05 c4 28 00 00 00 	movl   $0xc00,0x28c4
      b5:	0c 00 00 

    CONTROL_LINE_COLOR = YELLOW;//控制栏的颜色
      b8:	c7 05 d8 50 00 00 00 	movl   $0xe00,0x50d8
      bf:	0e 00 00 
    CURRENT_POSITION_COLOR = DARKPINK;//当前光标位置的颜色
      c2:	c7 05 c8 28 00 00 00 	movl   $0x500,0x28c8
      c9:	05 00 00 
    CURRENT_LINE_COLOR = GREEN;//当前行的颜色
      cc:	c7 05 d0 50 00 00 00 	movl   $0xa00,0x50d0
      d3:	0a 00 00 
    else{
        printf(1, "vim: please input filename\n");
        exit();
    }
    initColorConfiguration();//初始化颜色配置
    cursorX = cursorY = 0;
      d6:	c7 05 a4 29 00 00 00 	movl   $0x0,0x29a4
      dd:	00 00 00 
      e0:	c7 05 cc 28 00 00 00 	movl   $0x0,0x28cc
      e7:	00 00 00 
    init();//首先清空显示区的内容
      ea:	e8 51 01 00 00       	call   240 <init>
    showText();//将文档内容显示在显示区
      ef:	e8 8c 07 00 00       	call   880 <showText>
    showMessage(getFileInfo());//在最后一行显示当前文件的文件名和行数
      f4:	e8 37 09 00 00       	call   a30 <getFileInfo>
      f9:	89 04 24             	mov    %eax,(%esp)
      fc:	e8 6f 04 00 00       	call   570 <showMessage>
        printf(1, c);
        if(n<=0) break;
    }
    */
    
    while ((n = read(0, buf, sizeof(buf))) > 0){//不断从键盘读入字符
     101:	83 c4 10             	add    $0x10,%esp
     104:	eb 12                	jmp    118 <main+0x118>
     106:	8d 76 00             	lea    0x0(%esi),%esi
     109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        //printf(1,"He\n");
        if (buf[0] != 0)
     110:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
     114:	84 c0                	test   %al,%al
     116:	75 21                	jne    139 <main+0x139>
        printf(1, c);
        if(n<=0) break;
    }
    */
    
    while ((n = read(0, buf, sizeof(buf))) > 0){//不断从键盘读入字符
     118:	83 ec 04             	sub    $0x4,%esp
     11b:	6a 01                	push   $0x1
     11d:	53                   	push   %ebx
     11e:	6a 00                	push   $0x0
     120:	e8 25 19 00 00       	call   1a4a <read>
     125:	83 c4 10             	add    $0x10,%esp
     128:	85 c0                	test   %eax,%eax
     12a:	7f e4                	jg     110 <main+0x110>
        if (buf[0] != 0)
            parseInput(buf[0]);//并进行处理
    }
    
  return 0;
}
     12c:	8d 65 f4             	lea    -0xc(%ebp),%esp
     12f:	31 c0                	xor    %eax,%eax
     131:	59                   	pop    %ecx
     132:	5b                   	pop    %ebx
     133:	5e                   	pop    %esi
     134:	5d                   	pop    %ebp
     135:	8d 61 fc             	lea    -0x4(%ecx),%esp
     138:	c3                   	ret    
    */
    
    while ((n = read(0, buf, sizeof(buf))) > 0){//不断从键盘读入字符
        //printf(1,"He\n");
        if (buf[0] != 0)
            parseInput(buf[0]);//并进行处理
     139:	83 ec 0c             	sub    $0xc,%esp
     13c:	50                   	push   %eax
     13d:	e8 2e 15 00 00       	call   1670 <parseInput>
     142:	83 c4 10             	add    $0x10,%esp
     145:	eb d1                	jmp    118 <main+0x118>
        }
        for (i = 0; i < strlen(argv[1]); ++i)
            filename[i] = argv[1][i];//将命令行的第1个参数作为文件名filename
        filename[i] = 0;
        if (num_line == 0)//如果文件中原先没有内容，则
            insertline();//插入一行内容
     147:	e8 e4 0b 00 00       	call   d30 <insertline>
     14c:	e9 26 ff ff ff       	jmp    77 <main+0x77>
    int i;

    if (argc > 1){
        if (openFile(argv[1]) < 0)
        {
            printf(1, "vim: cannot open %s\n", argv[1]);
     151:	51                   	push   %ecx
     152:	ff 76 04             	pushl  0x4(%esi)
     155:	68 f5 1e 00 00       	push   $0x1ef5
     15a:	6a 01                	push   $0x1
     15c:	e8 1f 1a 00 00       	call   1b80 <printf>
            exit();
     161:	e8 cc 18 00 00       	call   1a32 <exit>
        if (num_line == 0)//如果文件中原先没有内容，则
            insertline();//插入一行内容
        moveCursor(-100,-100);//光标移到左上方
    }
    else{
        printf(1, "vim: please input filename\n");
     166:	50                   	push   %eax
     167:	50                   	push   %eax
     168:	68 0a 1f 00 00       	push   $0x1f0a
     16d:	6a 01                	push   $0x1
     16f:	e8 0c 1a 00 00       	call   1b80 <printf>
        exit();
     174:	e8 b9 18 00 00       	call   1a32 <exit>
     179:	66 90                	xchg   %ax,%ax
     17b:	66 90                	xchg   %ax,%ax
     17d:	66 90                	xchg   %ax,%ax
     17f:	90                   	nop

00000180 <initColorConfiguration>:
#include "vim.h"
#include "color.h"

void 
initColorConfiguration()//初始化颜色配置
{
     180:	55                   	push   %ebp
    //首先尝试从配置文件中读入颜色设置
    BACKGROUND_COLOR = BLACK;//背景色
     181:	c7 05 44 29 00 00 00 	movl   $0x0,0x2944
     188:	00 00 00 
    RESERVERED_WORD_COLOR = BLUE;//保留字的颜色
     18b:	c7 05 dc 50 00 00 00 	movl   $0x900,0x50dc
     192:	09 00 00 
    PARAMETER_COLOR = DARKGREEN;//常量的颜色
     195:	c7 05 c0 28 00 00 00 	movl   $0x200,0x28c0
     19c:	02 00 00 
#include "vim.h"
#include "color.h"

void 
initColorConfiguration()//初始化颜色配置
{
     19f:	89 e5                	mov    %esp,%ebp
    //首先尝试从配置文件中读入颜色设置
    BACKGROUND_COLOR = BLACK;//背景色
    RESERVERED_WORD_COLOR = BLUE;//保留字的颜色
    PARAMETER_COLOR = DARKGREEN;//常量的颜色
    VARIABLE_COLOR = WHITE;//变量的颜色
     1a1:	c7 05 d4 50 00 00 00 	movl   $0xf00,0x50d4
     1a8:	0f 00 00 
    EMPHASIZE_WORD_COLOR = RED;//强调字体的颜色
     1ab:	c7 05 c4 28 00 00 00 	movl   $0xc00,0x28c4
     1b2:	0c 00 00 

    CONTROL_LINE_COLOR = YELLOW;//控制栏的颜色
     1b5:	c7 05 d8 50 00 00 00 	movl   $0xe00,0x50d8
     1bc:	0e 00 00 
    CURRENT_POSITION_COLOR = DARKPINK;//当前光标位置的颜色
     1bf:	c7 05 c8 28 00 00 00 	movl   $0x500,0x28c8
     1c6:	05 00 00 
    CURRENT_LINE_COLOR = GREEN;//当前行的颜色
     1c9:	c7 05 d0 50 00 00 00 	movl   $0xa00,0x50d0
     1d0:	0a 00 00 
}
     1d3:	5d                   	pop    %ebp
     1d4:	c3                   	ret    
     1d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001e0 <isTextChar>:

int 
isTextChar(char c)//判断是否为可显示字符
{
     1e0:	55                   	push   %ebp
     1e1:	89 e5                	mov    %esp,%ebp
     1e3:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
    if (c >= ' ' && c <= '~')
        return 1;
    return 0;
}
     1e7:	5d                   	pop    %ebp
     1e8:	83 e8 20             	sub    $0x20,%eax
     1eb:	3c 5e                	cmp    $0x5e,%al
     1ed:	0f 96 c0             	setbe  %al
     1f0:	0f b6 c0             	movzbl %al,%eax
     1f3:	c3                   	ret    
     1f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     1fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000200 <isControlChar>:

int isControlChar(char c){//判断是否为支持的控制字符
     200:	55                   	push   %ebp
     201:	31 c0                	xor    %eax,%eax
     203:	89 e5                	mov    %esp,%ebp
     205:	8b 4d 08             	mov    0x8(%ebp),%ecx
     208:	80 f9 0d             	cmp    $0xd,%cl
     20b:	77 10                	ja     21d <isControlChar+0x1d>
    switch(c){
        case BACKSPACE:
        case NEW_LINE:
        case CARRIAGE_RETURN:
        case HORIZONTAL_TAB:
            return 1;
     20d:	b8 01 00 00 00       	mov    $0x1,%eax
     212:	d3 e0                	shl    %cl,%eax
     214:	f6 c4 27             	test   $0x27,%ah
     217:	0f 95 c0             	setne  %al
     21a:	0f b6 c0             	movzbl %al,%eax
        default:
            return 0;
    }
}
     21d:	5d                   	pop    %ebp
     21e:	c3                   	ret    
     21f:	90                   	nop

00000220 <coor>:

int
coor(int x, int y)//将二维坐标转换为一维的编号
{
     220:	55                   	push   %ebp
     221:	89 e5                	mov    %esp,%ebp
     223:	8b 45 08             	mov    0x8(%ebp),%eax
    return x * CONSOLE_WIDTH + y;
     226:	8d 04 80             	lea    (%eax,%eax,4),%eax
     229:	c1 e0 04             	shl    $0x4,%eax
     22c:	03 45 0c             	add    0xc(%ebp),%eax
}
     22f:	5d                   	pop    %ebp
     230:	c3                   	ret    
     231:	eb 0d                	jmp    240 <init>
     233:	90                   	nop
     234:	90                   	nop
     235:	90                   	nop
     236:	90                   	nop
     237:	90                   	nop
     238:	90                   	nop
     239:	90                   	nop
     23a:	90                   	nop
     23b:	90                   	nop
     23c:	90                   	nop
     23d:	90                   	nop
     23e:	90                   	nop
     23f:	90                   	nop

00000240 <init>:

void
init()//将显示区刷新为空白内容
{
     240:	55                   	push   %ebp
     241:	89 e5                	mov    %esp,%ebp
     243:	56                   	push   %esi
     244:	53                   	push   %ebx
     245:	31 db                	xor    %ebx,%ebx
     247:	89 f6                	mov    %esi,%esi
     249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     250:	8d 73 50             	lea    0x50(%ebx),%esi
     253:	90                   	nop
     254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int i, j;
    for (i = 0; i < CONSOLE_HEIGHT; ++i)
        for (j = 0; j < CONSOLE_WIDTH; ++j)
            setconsole(coor(i, j), 0, WHITE_ON_BLACK, -1, 2);//setconsole整个函数的实现在哪里？？？
     258:	83 ec 0c             	sub    $0xc,%esp
     25b:	6a 02                	push   $0x2
     25d:	6a ff                	push   $0xffffffff
     25f:	68 00 07 00 00       	push   $0x700
     264:	6a 00                	push   $0x0
     266:	53                   	push   %ebx
     267:	83 c3 01             	add    $0x1,%ebx
     26a:	e8 63 18 00 00       	call   1ad2 <setconsole>
void
init()//将显示区刷新为空白内容
{
    int i, j;
    for (i = 0; i < CONSOLE_HEIGHT; ++i)
        for (j = 0; j < CONSOLE_WIDTH; ++j)
     26f:	83 c4 20             	add    $0x20,%esp
     272:	39 f3                	cmp    %esi,%ebx
     274:	75 e2                	jne    258 <init+0x18>

void
init()//将显示区刷新为空白内容
{
    int i, j;
    for (i = 0; i < CONSOLE_HEIGHT; ++i)
     276:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
     27c:	75 d2                	jne    250 <init+0x10>
        for (j = 0; j < CONSOLE_WIDTH; ++j)
            setconsole(coor(i, j), 0, WHITE_ON_BLACK, -1, 2);//setconsole整个函数的实现在哪里？？？
    setconsole(-1, 0, 0, coor(cursorX, cursorY), 2);
     27e:	a1 cc 28 00 00       	mov    0x28cc,%eax
     283:	83 ec 0c             	sub    $0xc,%esp
     286:	6a 02                	push   $0x2
     288:	8d 04 80             	lea    (%eax,%eax,4),%eax
     28b:	c1 e0 04             	shl    $0x4,%eax
     28e:	03 05 a4 29 00 00    	add    0x29a4,%eax
     294:	50                   	push   %eax
     295:	6a 00                	push   $0x0
     297:	6a 00                	push   $0x0
     299:	6a ff                	push   $0xffffffff
     29b:	e8 32 18 00 00       	call   1ad2 <setconsole>
}
     2a0:	83 c4 20             	add    $0x20,%esp
     2a3:	8d 65 f8             	lea    -0x8(%ebp),%esp
     2a6:	5b                   	pop    %ebx
     2a7:	5e                   	pop    %esi
     2a8:	5d                   	pop    %ebp
     2a9:	c3                   	ret    
     2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002b0 <printChar>:

void //在屏幕坐标（i，j）的位置放一个字符c，字体颜色为fontColor,背景颜色为backgroundColor
printChar(int i, int j, char c, int fontColor, int backgroundColor){
     2b0:	55                   	push   %ebp
     2b1:	89 e5                	mov    %esp,%ebp
     2b3:	56                   	push   %esi
     2b4:	53                   	push   %ebx
     2b5:	8b 45 10             	mov    0x10(%ebp),%eax
     2b8:	8b 75 08             	mov    0x8(%ebp),%esi
     2bb:	8b 4d 18             	mov    0x18(%ebp),%ecx
     2be:	8b 5d 14             	mov    0x14(%ebp),%ebx
     2c1:	8b 55 0c             	mov    0xc(%ebp),%edx
    setconsole(coor(i, j), c, combineColor(fontColor, backgroundColor), -1, 2);
     2c4:	c7 45 18 02 00 00 00 	movl   $0x2,0x18(%ebp)
     2cb:	0f be c0             	movsbl %al,%eax
     2ce:	c7 45 14 ff ff ff ff 	movl   $0xffffffff,0x14(%ebp)
     2d5:	89 45 0c             	mov    %eax,0xc(%ebp)
     2d8:	8d 04 b6             	lea    (%esi,%esi,4),%eax
     2db:	c1 e1 04             	shl    $0x4,%ecx
     2de:	09 d9                	or     %ebx,%ecx
     2e0:	c1 e0 04             	shl    $0x4,%eax
     2e3:	89 4d 10             	mov    %ecx,0x10(%ebp)
     2e6:	01 d0                	add    %edx,%eax
}
     2e8:	5b                   	pop    %ebx
    setconsole(-1, 0, 0, coor(cursorX, cursorY), 2);
}

void //在屏幕坐标（i，j）的位置放一个字符c，字体颜色为fontColor,背景颜色为backgroundColor
printChar(int i, int j, char c, int fontColor, int backgroundColor){
    setconsole(coor(i, j), c, combineColor(fontColor, backgroundColor), -1, 2);
     2e9:	89 45 08             	mov    %eax,0x8(%ebp)
}
     2ec:	5e                   	pop    %esi
     2ed:	5d                   	pop    %ebp
    setconsole(-1, 0, 0, coor(cursorX, cursorY), 2);
}

void //在屏幕坐标（i，j）的位置放一个字符c，字体颜色为fontColor,背景颜色为backgroundColor
printChar(int i, int j, char c, int fontColor, int backgroundColor){
    setconsole(coor(i, j), c, combineColor(fontColor, backgroundColor), -1, 2);
     2ee:	e9 df 17 00 00       	jmp    1ad2 <setconsole>
     2f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <quit>:
}

void
quit()
{
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	83 ec 08             	sub    $0x8,%esp
    init();
     306:	e8 35 ff ff ff       	call   240 <init>
    setconsole(-1, 0, 0, 0, 0);
     30b:	83 ec 0c             	sub    $0xc,%esp
     30e:	6a 00                	push   $0x0
     310:	6a 00                	push   $0x0
     312:	6a 00                	push   $0x0
     314:	6a 00                	push   $0x0
     316:	6a ff                	push   $0xffffffff
     318:	e8 b5 17 00 00       	call   1ad2 <setconsole>
    exit();
     31d:	83 c4 20             	add    $0x20,%esp
     320:	e8 0d 17 00 00       	call   1a32 <exit>
     325:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000330 <openFile>:
}

int
openFile(char* filename)//打开文件
{
     330:	55                   	push   %ebp
     331:	89 e5                	mov    %esp,%ebp
     333:	57                   	push   %edi
     334:	56                   	push   %esi
     335:	53                   	push   %ebx
     336:	81 ec a4 00 00 00    	sub    $0xa4,%esp
    int fd = open(filename, O_RDONLY | O_CREATE);
     33c:	68 00 02 00 00       	push   $0x200
     341:	ff 75 08             	pushl  0x8(%ebp)
     344:	e8 29 17 00 00       	call   1a72 <open>
    if (fd < 0)
     349:	83 c4 10             	add    $0x10,%esp
     34c:	85 c0                	test   %eax,%eax
}

int
openFile(char* filename)//打开文件
{
    int fd = open(filename, O_RDONLY | O_CREATE);
     34e:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
    if (fd < 0)
     354:	0f 88 d1 00 00 00    	js     42b <openFile+0xfb>
        return fd;
    char buf[128];//读入字符缓冲区
    int n, i, p = 0;
    num_line = 0;
     35a:	c7 05 88 28 00 00 00 	movl   $0x0,0x2888
     361:	00 00 00 
{
    int fd = open(filename, O_RDONLY | O_CREATE);
    if (fd < 0)
        return fd;
    char buf[128];//读入字符缓冲区
    int n, i, p = 0;
     364:	31 ff                	xor    %edi,%edi
     366:	8d 76 00             	lea    0x0(%esi),%esi
     369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    num_line = 0;
    while ((n = read(fd, buf, 128)) > 0){//从文件中不断读入字符到缓冲区
     370:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
     376:	83 ec 04             	sub    $0x4,%esp
     379:	68 80 00 00 00       	push   $0x80
     37e:	50                   	push   %eax
     37f:	ff b5 60 ff ff ff    	pushl  -0xa0(%ebp)
     385:	e8 c0 16 00 00       	call   1a4a <read>
     38a:	83 c4 10             	add    $0x10,%esp
     38d:	85 c0                	test   %eax,%eax
     38f:	7e 7f                	jle    410 <openFile+0xe0>
     391:	8d 95 68 ff ff ff    	lea    -0x98(%ebp),%edx
     397:	8b 0d 88 28 00 00    	mov    0x2888,%ecx
     39d:	c6 85 67 ff ff ff 00 	movb   $0x0,-0x99(%ebp)
     3a4:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
     3a7:	eb 20                	jmp    3c9 <openFile+0x99>
     3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if (buf[i] == '\n'){//如果读入的是换行符，则增加行数
                textbuf[num_line++][p] = '\0';
                p = 0;
            }
            else{
                if (p < MAX_LENGTH)//否则读入当前行不超过MAX_LENGTH的字符串。
     3b0:	83 ff 4f             	cmp    $0x4f,%edi
     3b3:	7f 0d                	jg     3c2 <openFile+0x92>
                    textbuf[num_line][p++] = buf[i];//Note:这样的实现导致较长行字符串的丢失。
     3b5:	6b f1 64             	imul   $0x64,%ecx,%esi
     3b8:	88 84 37 c0 29 00 00 	mov    %al,0x29c0(%edi,%esi,1)
     3bf:	83 c7 01             	add    $0x1,%edi
     3c2:	83 c2 01             	add    $0x1,%edx
        return fd;
    char buf[128];//读入字符缓冲区
    int n, i, p = 0;
    num_line = 0;
    while ((n = read(fd, buf, 128)) > 0){//从文件中不断读入字符到缓冲区
        for (i = 0; i < n; ++i){
     3c5:	39 da                	cmp    %ebx,%edx
     3c7:	74 25                	je     3ee <openFile+0xbe>
            if (buf[i] == '\n'){//如果读入的是换行符，则增加行数
     3c9:	0f b6 02             	movzbl (%edx),%eax
     3cc:	3c 0a                	cmp    $0xa,%al
     3ce:	75 e0                	jne    3b0 <openFile+0x80>
                textbuf[num_line++][p] = '\0';
     3d0:	6b c1 64             	imul   $0x64,%ecx,%eax
     3d3:	83 c2 01             	add    $0x1,%edx
     3d6:	83 c1 01             	add    $0x1,%ecx
     3d9:	c6 85 67 ff ff ff 01 	movb   $0x1,-0x99(%ebp)
     3e0:	c6 84 07 c0 29 00 00 	movb   $0x0,0x29c0(%edi,%eax,1)
     3e7:	00 
                p = 0;
     3e8:	31 ff                	xor    %edi,%edi
        return fd;
    char buf[128];//读入字符缓冲区
    int n, i, p = 0;
    num_line = 0;
    while ((n = read(fd, buf, 128)) > 0){//从文件中不断读入字符到缓冲区
        for (i = 0; i < n; ++i){
     3ea:	39 da                	cmp    %ebx,%edx
     3ec:	75 db                	jne    3c9 <openFile+0x99>
     3ee:	80 bd 67 ff ff ff 00 	cmpb   $0x0,-0x99(%ebp)
     3f5:	0f 84 75 ff ff ff    	je     370 <openFile+0x40>
     3fb:	89 0d 88 28 00 00    	mov    %ecx,0x2888
     401:	e9 6a ff ff ff       	jmp    370 <openFile+0x40>
     406:	8d 76 00             	lea    0x0(%esi),%esi
     409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                if (p < MAX_LENGTH)//否则读入当前行不超过MAX_LENGTH的字符串。
                    textbuf[num_line][p++] = buf[i];//Note:这样的实现导致较长行字符串的丢失。
            }
        }
    }
    close(fd);
     410:	83 ec 0c             	sub    $0xc,%esp
     413:	ff b5 60 ff ff ff    	pushl  -0xa0(%ebp)
     419:	e8 3c 16 00 00       	call   1a5a <close>
    return 0;
     41e:	83 c4 10             	add    $0x10,%esp
}
     421:	8d 65 f4             	lea    -0xc(%ebp),%esp
                    textbuf[num_line][p++] = buf[i];//Note:这样的实现导致较长行字符串的丢失。
            }
        }
    }
    close(fd);
    return 0;
     424:	31 c0                	xor    %eax,%eax
}
     426:	5b                   	pop    %ebx
     427:	5e                   	pop    %esi
     428:	5f                   	pop    %edi
     429:	5d                   	pop    %ebp
     42a:	c3                   	ret    
     42b:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
     431:	8d 65 f4             	lea    -0xc(%ebp),%esp
     434:	5b                   	pop    %ebx
     435:	5e                   	pop    %esi
     436:	5f                   	pop    %edi
     437:	5d                   	pop    %ebp
     438:	c3                   	ret    
     439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000440 <saveFile>:

int
saveFile(char* filename)//保存文件
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	57                   	push   %edi
     444:	56                   	push   %esi
     445:	53                   	push   %ebx
     446:	83 ec 14             	sub    $0x14,%esp
    int fd = open(filename, O_WRONLY | O_CREATE | O_OVER);
     449:	68 21 02 00 00       	push   $0x221
     44e:	ff 75 08             	pushl  0x8(%ebp)
     451:	e8 1c 16 00 00       	call   1a72 <open>
    if (fd < 0)
     456:	83 c4 10             	add    $0x10,%esp
     459:	85 c0                	test   %eax,%eax
}

int
saveFile(char* filename)//保存文件
{
    int fd = open(filename, O_WRONLY | O_CREATE | O_OVER);
     45b:	89 c7                	mov    %eax,%edi
    if (fd < 0)
     45d:	78 54                	js     4b3 <saveFile+0x73>
        return fd;
    int i;
    for (i = 0; i < num_line; ++i)
     45f:	a1 88 28 00 00       	mov    0x2888,%eax
     464:	31 f6                	xor    %esi,%esi
     466:	bb c0 29 00 00       	mov    $0x29c0,%ebx
     46b:	85 c0                	test   %eax,%eax
     46d:	7e 36                	jle    4a5 <saveFile+0x65>
     46f:	90                   	nop
    {
        write(fd, textbuf[i], strlen(textbuf[i]));
     470:	83 ec 0c             	sub    $0xc,%esp
{
    int fd = open(filename, O_WRONLY | O_CREATE | O_OVER);
    if (fd < 0)
        return fd;
    int i;
    for (i = 0; i < num_line; ++i)
     473:	83 c6 01             	add    $0x1,%esi
    {
        write(fd, textbuf[i], strlen(textbuf[i]));
     476:	53                   	push   %ebx
     477:	e8 f4 13 00 00       	call   1870 <strlen>
     47c:	83 c4 0c             	add    $0xc,%esp
     47f:	50                   	push   %eax
     480:	53                   	push   %ebx
     481:	83 c3 64             	add    $0x64,%ebx
     484:	57                   	push   %edi
     485:	e8 c8 15 00 00       	call   1a52 <write>
        write(fd, "\n", 1);
     48a:	83 c4 0c             	add    $0xc,%esp
     48d:	6a 01                	push   $0x1
     48f:	68 24 1f 00 00       	push   $0x1f24
     494:	57                   	push   %edi
     495:	e8 b8 15 00 00       	call   1a52 <write>
{
    int fd = open(filename, O_WRONLY | O_CREATE | O_OVER);
    if (fd < 0)
        return fd;
    int i;
    for (i = 0; i < num_line; ++i)
     49a:	83 c4 10             	add    $0x10,%esp
     49d:	39 35 88 28 00 00    	cmp    %esi,0x2888
     4a3:	7f cb                	jg     470 <saveFile+0x30>
    {
        write(fd, textbuf[i], strlen(textbuf[i]));
        write(fd, "\n", 1);
    }
    close(fd);
     4a5:	83 ec 0c             	sub    $0xc,%esp
     4a8:	57                   	push   %edi
     4a9:	e8 ac 15 00 00       	call   1a5a <close>
    return 0;
     4ae:	83 c4 10             	add    $0x10,%esp
     4b1:	31 c0                	xor    %eax,%eax
}
     4b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4b6:	5b                   	pop    %ebx
     4b7:	5e                   	pop    %esi
     4b8:	5f                   	pop    %edi
     4b9:	5d                   	pop    %ebp
     4ba:	c3                   	ret    
     4bb:	90                   	nop
     4bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004c0 <intToString>:

char*
intToString(int k)//整数转换为字符串
{
     4c0:	55                   	push   %ebp
     4c1:	89 e5                	mov    %esp,%ebp
     4c3:	57                   	push   %edi
     4c4:	56                   	push   %esi
     4c5:	53                   	push   %ebx
     4c6:	83 ec 28             	sub    $0x28,%esp
     4c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
    char* result = malloc(sizeof(char) * 10);
     4cc:	6a 0a                	push   $0xa
     4ce:	e8 dd 18 00 00       	call   1db0 <malloc>
    if (k == 0)
     4d3:	83 c4 10             	add    $0x10,%esp
     4d6:	83 fb 00             	cmp    $0x0,%ebx
}

char*
intToString(int k)//整数转换为字符串
{
    char* result = malloc(sizeof(char) * 10);
     4d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if (k == 0)
     4dc:	74 72                	je     550 <intToString+0x90>
        result[0] = '0';
        result[1] = 0;
        return result;
    }
    int l = 0, p = k;
    while (p > 0){
     4de:	89 d9                	mov    %ebx,%ecx
     4e0:	be 00 00 00 00       	mov    $0x0,%esi
     4e5:	7f 0b                	jg     4f2 <intToString+0x32>
     4e7:	eb 7c                	jmp    565 <intToString+0xa5>
     4e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        l++;
     4f0:	89 fe                	mov    %edi,%esi
        p /= 10;
     4f2:	b8 67 66 66 66       	mov    $0x66666667,%eax
        result[1] = 0;
        return result;
    }
    int l = 0, p = k;
    while (p > 0){
        l++;
     4f7:	8d 7e 01             	lea    0x1(%esi),%edi
        p /= 10;
     4fa:	f7 e9                	imul   %ecx
     4fc:	c1 f9 1f             	sar    $0x1f,%ecx
     4ff:	c1 fa 02             	sar    $0x2,%edx
        result[0] = '0';
        result[1] = 0;
        return result;
    }
    int l = 0, p = k;
    while (p > 0){
     502:	29 ca                	sub    %ecx,%edx
     504:	89 d1                	mov    %edx,%ecx
     506:	75 e8                	jne    4f0 <intToString+0x30>
        l++;
        p /= 10;
    }
    result[l--] = 0;
     508:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    while (k > 0){
        result[l--] = k % 10 + '0';
     50b:	b9 67 66 66 66       	mov    $0x66666667,%ecx
    int l = 0, p = k;
    while (p > 0){
        l++;
        p /= 10;
    }
    result[l--] = 0;
     510:	c6 04 38 00          	movb   $0x0,(%eax,%edi,1)
     514:	01 c6                	add    %eax,%esi
     516:	8d 76 00             	lea    0x0(%esi),%esi
     519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    while (k > 0){
        result[l--] = k % 10 + '0';
     520:	89 d8                	mov    %ebx,%eax
     522:	83 ee 01             	sub    $0x1,%esi
     525:	f7 e9                	imul   %ecx
     527:	89 d8                	mov    %ebx,%eax
     529:	c1 f8 1f             	sar    $0x1f,%eax
     52c:	c1 fa 02             	sar    $0x2,%edx
     52f:	29 c2                	sub    %eax,%edx
     531:	8d 04 92             	lea    (%edx,%edx,4),%eax
     534:	01 c0                	add    %eax,%eax
     536:	29 c3                	sub    %eax,%ebx
     538:	83 c3 30             	add    $0x30,%ebx
     53b:	88 5e 01             	mov    %bl,0x1(%esi)
    while (p > 0){
        l++;
        p /= 10;
    }
    result[l--] = 0;
    while (k > 0){
     53e:	85 d2                	test   %edx,%edx
        result[l--] = k % 10 + '0';
        k /= 10;
     540:	89 d3                	mov    %edx,%ebx
    while (p > 0){
        l++;
        p /= 10;
    }
    result[l--] = 0;
    while (k > 0){
     542:	75 dc                	jne    520 <intToString+0x60>
        result[l--] = k % 10 + '0';
        k /= 10;
    }
    return result;
}
     544:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     547:	8d 65 f4             	lea    -0xc(%ebp),%esp
     54a:	5b                   	pop    %ebx
     54b:	5e                   	pop    %esi
     54c:	5f                   	pop    %edi
     54d:	5d                   	pop    %ebp
     54e:	c3                   	ret    
     54f:	90                   	nop
intToString(int k)//整数转换为字符串
{
    char* result = malloc(sizeof(char) * 10);
    if (k == 0)
    {
        result[0] = '0';
     550:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     553:	c6 00 30             	movb   $0x30,(%eax)
        result[1] = 0;
     556:	c6 40 01 00          	movb   $0x0,0x1(%eax)
    while (k > 0){
        result[l--] = k % 10 + '0';
        k /= 10;
    }
    return result;
}
     55a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     55d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     560:	5b                   	pop    %ebx
     561:	5e                   	pop    %esi
     562:	5f                   	pop    %edi
     563:	5d                   	pop    %ebp
     564:	c3                   	ret    
    int l = 0, p = k;
    while (p > 0){
        l++;
        p /= 10;
    }
    result[l--] = 0;
     565:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     568:	c6 00 00             	movb   $0x0,(%eax)
     56b:	eb d7                	jmp    544 <intToString+0x84>
     56d:	8d 76 00             	lea    0x0(%esi),%esi

00000570 <showMessage>:
    return result;
}

void 
showMessage(char* msg)//将控制命令输出在最后一行
{
     570:	55                   	push   %ebp
     571:	89 e5                	mov    %esp,%ebp
     573:	57                   	push   %edi
     574:	56                   	push   %esi
     575:	53                   	push   %ebx
  return 0;
}

int combineColor(int textColor, int backgroundColor)//设置字体的颜色和背景的颜色
{
    return ( textColor | ( backgroundColor << 4 ) );
     576:	bf 80 07 00 00       	mov    $0x780,%edi
    return result;
}

void 
showMessage(char* msg)//将控制命令输出在最后一行
{
     57b:	83 ec 28             	sub    $0x28,%esp
     57e:	8b 75 08             	mov    0x8(%ebp),%esi
    int line = 24;
    int i;
    int l = strlen(msg);
     581:	56                   	push   %esi
     582:	e8 e9 12 00 00       	call   1870 <strlen>
  return 0;
}

int combineColor(int textColor, int backgroundColor)//设置字体的颜色和背景的颜色
{
    return ( textColor | ( backgroundColor << 4 ) );
     587:	8b 1d d8 50 00 00    	mov    0x50d8,%ebx
void 
showMessage(char* msg)//将控制命令输出在最后一行
{
    int line = 24;
    int i;
    int l = strlen(msg);
     58d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  return 0;
}

int combineColor(int textColor, int backgroundColor)//设置字体的颜色和背景的颜色
{
    return ( textColor | ( backgroundColor << 4 ) );
     590:	83 c4 10             	add    $0x10,%esp
     593:	c1 e3 04             	shl    $0x4,%ebx
     596:	0b 1d c4 28 00 00    	or     0x28c4,%ebx
     59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int line = 24;
    int i;
    int l = strlen(msg);
    int messageColor = combineColor(EMPHASIZE_WORD_COLOR, CONTROL_LINE_COLOR);//设置控制命令的颜色
    for (i = 0; i < 65; ++i)
        setconsole(coor(line, i), 0, messageColor, -1, 2);
     5a0:	83 ec 0c             	sub    $0xc,%esp
     5a3:	6a 02                	push   $0x2
     5a5:	6a ff                	push   $0xffffffff
     5a7:	53                   	push   %ebx
     5a8:	6a 00                	push   $0x0
     5aa:	57                   	push   %edi
     5ab:	83 c7 01             	add    $0x1,%edi
     5ae:	e8 1f 15 00 00       	call   1ad2 <setconsole>
{
    int line = 24;
    int i;
    int l = strlen(msg);
    int messageColor = combineColor(EMPHASIZE_WORD_COLOR, CONTROL_LINE_COLOR);//设置控制命令的颜色
    for (i = 0; i < 65; ++i)
     5b3:	83 c4 20             	add    $0x20,%esp
     5b6:	81 ff c1 07 00 00    	cmp    $0x7c1,%edi
     5bc:	75 e2                	jne    5a0 <showMessage+0x30>
     5be:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     5c1:	b8 3c 00 00 00       	mov    $0x3c,%eax
        setconsole(coor(line, i), 0, messageColor, -1, 2);
    if (l > 60)
        l = 60;
    for (i = 0; i < l; ++i)
     5c6:	bf 80 07 00 00       	mov    $0x780,%edi
     5cb:	83 fa 3c             	cmp    $0x3c,%edx
     5ce:	0f 4e c2             	cmovle %edx,%eax
     5d1:	8d 88 80 07 00 00    	lea    0x780(%eax),%ecx
     5d7:	85 c0                	test   %eax,%eax
     5d9:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
     5dc:	7e 24                	jle    602 <showMessage+0x92>
     5de:	66 90                	xchg   %ax,%ax
        setconsole(coor(line, i), msg[i], messageColor, -1, 2);
     5e0:	83 ec 0c             	sub    $0xc,%esp
     5e3:	6a 02                	push   $0x2
     5e5:	6a ff                	push   $0xffffffff
     5e7:	53                   	push   %ebx
     5e8:	0f be 84 3e 80 f8 ff 	movsbl -0x780(%esi,%edi,1),%eax
     5ef:	ff 
     5f0:	50                   	push   %eax
     5f1:	57                   	push   %edi
     5f2:	83 c7 01             	add    $0x1,%edi
     5f5:	e8 d8 14 00 00       	call   1ad2 <setconsole>
    int messageColor = combineColor(EMPHASIZE_WORD_COLOR, CONTROL_LINE_COLOR);//设置控制命令的颜色
    for (i = 0; i < 65; ++i)
        setconsole(coor(line, i), 0, messageColor, -1, 2);
    if (l > 60)
        l = 60;
    for (i = 0; i < l; ++i)
     5fa:	83 c4 20             	add    $0x20,%esp
     5fd:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
     600:	75 de                	jne    5e0 <showMessage+0x70>
        setconsole(coor(line, i), msg[i], messageColor, -1, 2);
}
     602:	8d 65 f4             	lea    -0xc(%ebp),%esp
     605:	5b                   	pop    %ebx
     606:	5e                   	pop    %esi
     607:	5f                   	pop    %edi
     608:	5d                   	pop    %ebp
     609:	c3                   	ret    
     60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000610 <runCommand.part.0>:
:w save
:wq save & quit
:q! quit without save
*/
void
runCommand()
     610:	55                   	push   %ebp
     611:	89 e5                	mov    %esp,%ebp
     613:	83 ec 08             	sub    $0x8,%esp
{
    if (controlbuf[0] != ':')
        return ;
    if (controlbuf[1] == 'w' && (controlbuf[2] == ' ' || controlbuf[2] == 0 || controlbuf[2] == 'q')){
     616:	0f b6 05 61 29 00 00 	movzbl 0x2961,%eax
     61d:	3c 77                	cmp    $0x77,%al
     61f:	74 4f                	je     670 <runCommand.part.0+0x60>
        showMessage("Save succeed!");
        if (controlbuf[2] == 'q')//如果输入为“：wq”，则在保存后，退出程序
            quit();
        return ;
    }
    if (controlbuf[1] == 'q'){
     621:	3c 71                	cmp    $0x71,%al
     623:	75 34                	jne    659 <runCommand.part.0+0x49>
        if (controlbuf[2] == '!' && controlbuf[3] == 0)//如果输入为“：q!",则强制退出
     625:	0f b6 05 62 29 00 00 	movzbl 0x2962,%eax
     62c:	3c 21                	cmp    $0x21,%al
     62e:	74 20                	je     650 <runCommand.part.0+0x40>
            quit();
        if (controlbuf[2] == 0){//如果输入是":q"
     630:	84 c0                	test   %al,%al
     632:	75 25                	jne    659 <runCommand.part.0+0x49>
            if (saved == 0){//如果当前内容尚未保存，
     634:	a1 64 28 00 00       	mov    0x2864,%eax
     639:	85 c0                	test   %eax,%eax
     63b:	75 6f                	jne    6ac <runCommand.part.0+0x9c>
                showMessage("File isn't saved. Force quit by \'q!\'");//则退出失败
     63d:	83 ec 0c             	sub    $0xc,%esp
     640:	68 28 1f 00 00       	push   $0x1f28
     645:	e8 26 ff ff ff       	call   570 <showMessage>
     64a:	83 c4 10             	add    $0x10,%esp
            else//否则
                quit();//可以退出
        }
    }
    showMessage("Invalid command");//其余情况，则显示命令非负
}
     64d:	c9                   	leave  
     64e:	c3                   	ret    
     64f:	90                   	nop
        if (controlbuf[2] == 'q')//如果输入为“：wq”，则在保存后，退出程序
            quit();
        return ;
    }
    if (controlbuf[1] == 'q'){
        if (controlbuf[2] == '!' && controlbuf[3] == 0)//如果输入为“：q!",则强制退出
     650:	80 3d 63 29 00 00 00 	cmpb   $0x0,0x2963
     657:	74 53                	je     6ac <runCommand.part.0+0x9c>
            }
            else//否则
                quit();//可以退出
        }
    }
    showMessage("Invalid command");//其余情况，则显示命令非负
     659:	83 ec 0c             	sub    $0xc,%esp
     65c:	68 bb 1e 00 00       	push   $0x1ebb
     661:	e8 0a ff ff ff       	call   570 <showMessage>
     666:	83 c4 10             	add    $0x10,%esp
}
     669:	c9                   	leave  
     66a:	c3                   	ret    
     66b:	90                   	nop
     66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
void
runCommand()
{
    if (controlbuf[0] != ':')
        return ;
    if (controlbuf[1] == 'w' && (controlbuf[2] == ' ' || controlbuf[2] == 0 || controlbuf[2] == 'q')){
     670:	0f b6 05 62 29 00 00 	movzbl 0x2962,%eax
     677:	a8 df                	test   $0xdf,%al
     679:	75 3d                	jne    6b8 <runCommand.part.0+0xa8>
        if (controlbuf[2] == ' '){//如果输入为":w_filename",则将当前内容存到filename中
     67b:	3c 20                	cmp    $0x20,%al
     67d:	74 69                	je     6e8 <runCommand.part.0+0xd8>
            int i, l = strlen(controlbuf);
            for (i = 3; i < l; ++i)
                filename[i - 3] = controlbuf[i];
            filename[i - 3] = 0;
        }
        if (saveFile(filename) != 0){//如果输入为“：w”，则将当前内容存到原先打开的文件中
     67f:	83 ec 0c             	sub    $0xc,%esp
     682:	68 e0 28 00 00       	push   $0x28e0
     687:	e8 b4 fd ff ff       	call   440 <saveFile>
     68c:	83 c4 10             	add    $0x10,%esp
     68f:	85 c0                	test   %eax,%eax
     691:	75 3d                	jne    6d0 <runCommand.part.0+0xc0>
            showMessage("Save failed!");
            return ;
        }
        showMessage("Save succeed!");
     693:	83 ec 0c             	sub    $0xc,%esp
     696:	68 ad 1e 00 00       	push   $0x1ead
     69b:	e8 d0 fe ff ff       	call   570 <showMessage>
        if (controlbuf[2] == 'q')//如果输入为“：wq”，则在保存后，退出程序
     6a0:	83 c4 10             	add    $0x10,%esp
     6a3:	80 3d 62 29 00 00 71 	cmpb   $0x71,0x2962
     6aa:	75 a1                	jne    64d <runCommand.part.0+0x3d>
            quit();
     6ac:	e8 4f fc ff ff       	call   300 <quit>
     6b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
void
runCommand()
{
    if (controlbuf[0] != ':')
        return ;
    if (controlbuf[1] == 'w' && (controlbuf[2] == ' ' || controlbuf[2] == 0 || controlbuf[2] == 'q')){
     6b8:	3c 71                	cmp    $0x71,%al
     6ba:	74 c3                	je     67f <runCommand.part.0+0x6f>
            }
            else//否则
                quit();//可以退出
        }
    }
    showMessage("Invalid command");//其余情况，则显示命令非负
     6bc:	83 ec 0c             	sub    $0xc,%esp
     6bf:	68 bb 1e 00 00       	push   $0x1ebb
     6c4:	e8 a7 fe ff ff       	call   570 <showMessage>
     6c9:	83 c4 10             	add    $0x10,%esp
     6cc:	eb 9b                	jmp    669 <runCommand.part.0+0x59>
     6ce:	66 90                	xchg   %ax,%ax
            for (i = 3; i < l; ++i)
                filename[i - 3] = controlbuf[i];
            filename[i - 3] = 0;
        }
        if (saveFile(filename) != 0){//如果输入为“：w”，则将当前内容存到原先打开的文件中
            showMessage("Save failed!");
     6d0:	83 ec 0c             	sub    $0xc,%esp
     6d3:	68 a0 1e 00 00       	push   $0x1ea0
     6d8:	e8 93 fe ff ff       	call   570 <showMessage>
     6dd:	83 c4 10             	add    $0x10,%esp
            else//否则
                quit();//可以退出
        }
    }
    showMessage("Invalid command");//其余情况，则显示命令非负
}
     6e0:	c9                   	leave  
     6e1:	c3                   	ret    
     6e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
    if (controlbuf[0] != ':')
        return ;
    if (controlbuf[1] == 'w' && (controlbuf[2] == ' ' || controlbuf[2] == 0 || controlbuf[2] == 'q')){
        if (controlbuf[2] == ' '){//如果输入为":w_filename",则将当前内容存到filename中
            int i, l = strlen(controlbuf);
     6e8:	83 ec 0c             	sub    $0xc,%esp
     6eb:	68 60 29 00 00       	push   $0x2960
     6f0:	e8 7b 11 00 00       	call   1870 <strlen>
            for (i = 3; i < l; ++i)
     6f5:	83 c4 10             	add    $0x10,%esp
     6f8:	83 f8 03             	cmp    $0x3,%eax
     6fb:	7e 2b                	jle    728 <runCommand.part.0+0x118>
     6fd:	ba 03 00 00 00       	mov    $0x3,%edx
     702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                filename[i - 3] = controlbuf[i];
     708:	0f b6 8a 60 29 00 00 	movzbl 0x2960(%edx),%ecx
    if (controlbuf[0] != ':')
        return ;
    if (controlbuf[1] == 'w' && (controlbuf[2] == ' ' || controlbuf[2] == 0 || controlbuf[2] == 'q')){
        if (controlbuf[2] == ' '){//如果输入为":w_filename",则将当前内容存到filename中
            int i, l = strlen(controlbuf);
            for (i = 3; i < l; ++i)
     70f:	83 c2 01             	add    $0x1,%edx
                filename[i - 3] = controlbuf[i];
     712:	88 8a dc 28 00 00    	mov    %cl,0x28dc(%edx)
    if (controlbuf[0] != ':')
        return ;
    if (controlbuf[1] == 'w' && (controlbuf[2] == ' ' || controlbuf[2] == 0 || controlbuf[2] == 'q')){
        if (controlbuf[2] == ' '){//如果输入为":w_filename",则将当前内容存到filename中
            int i, l = strlen(controlbuf);
            for (i = 3; i < l; ++i)
     718:	39 d0                	cmp    %edx,%eax
     71a:	75 ec                	jne    708 <runCommand.part.0+0xf8>
                filename[i - 3] = controlbuf[i];
            filename[i - 3] = 0;
     71c:	c6 80 dd 28 00 00 00 	movb   $0x0,0x28dd(%eax)
     723:	e9 57 ff ff ff       	jmp    67f <runCommand.part.0+0x6f>
    if (controlbuf[0] != ':')
        return ;
    if (controlbuf[1] == 'w' && (controlbuf[2] == ' ' || controlbuf[2] == 0 || controlbuf[2] == 'q')){
        if (controlbuf[2] == ' '){//如果输入为":w_filename",则将当前内容存到filename中
            int i, l = strlen(controlbuf);
            for (i = 3; i < l; ++i)
     728:	b8 03 00 00 00       	mov    $0x3,%eax
     72d:	eb ed                	jmp    71c <runCommand.part.0+0x10c>
     72f:	90                   	nop

00000730 <showCoor>:
        setconsole(coor(line, i), msg[i], messageColor, -1, 2);
}

void
showCoor()//显示行列号
{
     730:	55                   	push   %ebp
     731:	89 e5                	mov    %esp,%ebp
     733:	57                   	push   %edi
     734:	56                   	push   %esi
     735:	53                   	push   %ebx
  return 0;
}

int combineColor(int textColor, int backgroundColor)//设置字体的颜色和背景的颜色
{
    return ( textColor | ( backgroundColor << 4 ) );
     736:	bb c1 07 00 00       	mov    $0x7c1,%ebx
        setconsole(coor(line, i), msg[i], messageColor, -1, 2);
}

void
showCoor()//显示行列号
{
     73b:	83 ec 3c             	sub    $0x3c,%esp
  return 0;
}

int combineColor(int textColor, int backgroundColor)//设置字体的颜色和背景的颜色
{
    return ( textColor | ( backgroundColor << 4 ) );
     73e:	8b 3d d8 50 00 00    	mov    0x50d8,%edi
     744:	c1 e7 04             	shl    $0x4,%edi
     747:	0b 3d c4 28 00 00    	or     0x28c4,%edi
     74d:	89 7d bc             	mov    %edi,-0x44(%ebp)
     750:	89 fe                	mov    %edi,%esi
     752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
    int line = 24;
    int i, p = 0, l;
    int coorColor = combineColor(EMPHASIZE_WORD_COLOR, CONTROL_LINE_COLOR);//设置行列号的颜色
    for (i = 65; i < CONSOLE_WIDTH; ++i)
        setconsole(coor(line, i), 0, coorColor, -1, 2);//先将原先的位置上的字符清空
     758:	83 ec 0c             	sub    $0xc,%esp
     75b:	6a 02                	push   $0x2
     75d:	6a ff                	push   $0xffffffff
     75f:	56                   	push   %esi
     760:	6a 00                	push   $0x0
     762:	53                   	push   %ebx
     763:	83 c3 01             	add    $0x1,%ebx
     766:	e8 67 13 00 00       	call   1ad2 <setconsole>
showCoor()//显示行列号
{
    int line = 24;
    int i, p = 0, l;
    int coorColor = combineColor(EMPHASIZE_WORD_COLOR, CONTROL_LINE_COLOR);//设置行列号的颜色
    for (i = 65; i < CONSOLE_WIDTH; ++i)
     76b:	83 c4 20             	add    $0x20,%esp
     76e:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
     774:	75 e2                	jne    758 <showCoor+0x28>
        setconsole(coor(line, i), 0, coorColor, -1, 2);//先将原先的位置上的字符清空
    char tmp[20];//存储当前光标位置的行、列的字符串
    char* digit;
    digit = intToString(cursorX + 1 + startline);
     776:	a1 8c 28 00 00       	mov    0x288c,%eax
     77b:	8b 15 cc 28 00 00    	mov    0x28cc,%edx
     781:	83 ec 0c             	sub    $0xc,%esp
    for (i = 0; i < strlen(digit); ++i)
     784:	31 db                	xor    %ebx,%ebx
    int coorColor = combineColor(EMPHASIZE_WORD_COLOR, CONTROL_LINE_COLOR);//设置行列号的颜色
    for (i = 65; i < CONSOLE_WIDTH; ++i)
        setconsole(coor(line, i), 0, coorColor, -1, 2);//先将原先的位置上的字符清空
    char tmp[20];//存储当前光标位置的行、列的字符串
    char* digit;
    digit = intToString(cursorX + 1 + startline);
     786:	8d 44 02 01          	lea    0x1(%edx,%eax,1),%eax
     78a:	50                   	push   %eax
     78b:	e8 30 fd ff ff       	call   4c0 <intToString>
    for (i = 0; i < strlen(digit); ++i)
     790:	83 c4 10             	add    $0x10,%esp
    int coorColor = combineColor(EMPHASIZE_WORD_COLOR, CONTROL_LINE_COLOR);//设置行列号的颜色
    for (i = 65; i < CONSOLE_WIDTH; ++i)
        setconsole(coor(line, i), 0, coorColor, -1, 2);//先将原先的位置上的字符清空
    char tmp[20];//存储当前光标位置的行、列的字符串
    char* digit;
    digit = intToString(cursorX + 1 + startline);
     793:	89 c6                	mov    %eax,%esi
    for (i = 0; i < strlen(digit); ++i)
     795:	eb 14                	jmp    7ab <showCoor+0x7b>
     797:	89 f6                	mov    %esi,%esi
     799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        tmp[p++] = digit[i];
     7a0:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
     7a4:	88 44 1d d4          	mov    %al,-0x2c(%ebp,%ebx,1)
    for (i = 65; i < CONSOLE_WIDTH; ++i)
        setconsole(coor(line, i), 0, coorColor, -1, 2);//先将原先的位置上的字符清空
    char tmp[20];//存储当前光标位置的行、列的字符串
    char* digit;
    digit = intToString(cursorX + 1 + startline);
    for (i = 0; i < strlen(digit); ++i)
     7a8:	83 c3 01             	add    $0x1,%ebx
     7ab:	83 ec 0c             	sub    $0xc,%esp
     7ae:	56                   	push   %esi
     7af:	e8 bc 10 00 00       	call   1870 <strlen>
     7b4:	83 c4 10             	add    $0x10,%esp
     7b7:	39 d8                	cmp    %ebx,%eax
     7b9:	77 e5                	ja     7a0 <showCoor+0x70>
        tmp[p++] = digit[i];
    tmp[p++] = 'R';
    tmp[p++] = ',';
    tmp[p++] = ' ';
    digit = intToString(cursorY + 1 - left);
     7bb:	8b 15 a4 29 00 00    	mov    0x29a4,%edx
    digit = intToString(cursorX + 1 + startline);
    for (i = 0; i < strlen(digit); ++i)
        tmp[p++] = digit[i];
    tmp[p++] = 'R';
    tmp[p++] = ',';
    tmp[p++] = ' ';
     7c1:	8d 43 03             	lea    0x3(%ebx),%eax
    digit = intToString(cursorY + 1 - left);
     7c4:	83 ec 0c             	sub    $0xc,%esp
    char tmp[20];//存储当前光标位置的行、列的字符串
    char* digit;
    digit = intToString(cursorX + 1 + startline);
    for (i = 0; i < strlen(digit); ++i)
        tmp[p++] = digit[i];
    tmp[p++] = 'R';
     7c7:	c6 44 1d d4 52       	movb   $0x52,-0x2c(%ebp,%ebx,1)
    tmp[p++] = ',';
     7cc:	c6 44 1d d5 2c       	movb   $0x2c,-0x2b(%ebp,%ebx,1)
    tmp[p++] = ' ';
    digit = intToString(cursorY + 1 - left);
    for (i = 0; i < strlen(digit); ++i)
     7d1:	31 f6                	xor    %esi,%esi
    digit = intToString(cursorX + 1 + startline);
    for (i = 0; i < strlen(digit); ++i)
        tmp[p++] = digit[i];
    tmp[p++] = 'R';
    tmp[p++] = ',';
    tmp[p++] = ' ';
     7d3:	89 45 c0             	mov    %eax,-0x40(%ebp)
     7d6:	c6 44 1d d6 20       	movb   $0x20,-0x2a(%ebp,%ebx,1)
    digit = intToString(cursorY + 1 - left);
     7db:	8d 42 01             	lea    0x1(%edx),%eax
     7de:	2b 05 90 28 00 00    	sub    0x2890,%eax
     7e4:	50                   	push   %eax
     7e5:	e8 d6 fc ff ff       	call   4c0 <intToString>
    for (i = 0; i < strlen(digit); ++i)
        tmp[p++] = digit[i];
     7ea:	8d 55 d4             	lea    -0x2c(%ebp),%edx
    for (i = 0; i < strlen(digit); ++i)
        tmp[p++] = digit[i];
    tmp[p++] = 'R';
    tmp[p++] = ',';
    tmp[p++] = ' ';
    digit = intToString(cursorY + 1 - left);
     7ed:	89 c7                	mov    %eax,%edi
    for (i = 0; i < strlen(digit); ++i)
     7ef:	83 c4 10             	add    $0x10,%esp
        tmp[p++] = digit[i];
     7f2:	01 d3                	add    %edx,%ebx
     7f4:	89 5d c4             	mov    %ebx,-0x3c(%ebp)
     7f7:	8b 5d c0             	mov    -0x40(%ebp),%ebx
        tmp[p++] = digit[i];
    tmp[p++] = 'R';
    tmp[p++] = ',';
    tmp[p++] = ' ';
    digit = intToString(cursorY + 1 - left);
    for (i = 0; i < strlen(digit); ++i)
     7fa:	eb 15                	jmp    811 <showCoor+0xe1>
     7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        tmp[p++] = digit[i];
     800:	0f b6 04 37          	movzbl (%edi,%esi,1),%eax
     804:	8b 4d c4             	mov    -0x3c(%ebp),%ecx
     807:	83 c3 01             	add    $0x1,%ebx
     80a:	88 44 31 03          	mov    %al,0x3(%ecx,%esi,1)
        tmp[p++] = digit[i];
    tmp[p++] = 'R';
    tmp[p++] = ',';
    tmp[p++] = ' ';
    digit = intToString(cursorY + 1 - left);
    for (i = 0; i < strlen(digit); ++i)
     80e:	83 c6 01             	add    $0x1,%esi
     811:	83 ec 0c             	sub    $0xc,%esp
     814:	57                   	push   %edi
     815:	e8 56 10 00 00       	call   1870 <strlen>
     81a:	83 c4 10             	add    $0x10,%esp
     81d:	39 f0                	cmp    %esi,%eax
     81f:	77 df                	ja     800 <showCoor+0xd0>
        tmp[p++] = digit[i];
    tmp[p++] = 'C';
    tmp[p++] = 0;
    l = strlen(tmp);
     821:	8d 45 d4             	lea    -0x2c(%ebp),%eax
     824:	83 ec 0c             	sub    $0xc,%esp
    tmp[p++] = ',';
    tmp[p++] = ' ';
    digit = intToString(cursorY + 1 - left);
    for (i = 0; i < strlen(digit); ++i)
        tmp[p++] = digit[i];
    tmp[p++] = 'C';
     827:	c6 44 1d d4 43       	movb   $0x43,-0x2c(%ebp,%ebx,1)
    tmp[p++] = 0;
     82c:	c6 44 1d d5 00       	movb   $0x0,-0x2b(%ebp,%ebx,1)
    l = strlen(tmp);
    for (i = 0; i < l; ++i)
     831:	bb c1 07 00 00       	mov    $0x7c1,%ebx
    digit = intToString(cursorY + 1 - left);
    for (i = 0; i < strlen(digit); ++i)
        tmp[p++] = digit[i];
    tmp[p++] = 'C';
    tmp[p++] = 0;
    l = strlen(tmp);
     836:	50                   	push   %eax
     837:	e8 34 10 00 00       	call   1870 <strlen>
    for (i = 0; i < l; ++i)
     83c:	83 c4 10             	add    $0x10,%esp
     83f:	85 c0                	test   %eax,%eax
     841:	8d b0 c1 07 00 00    	lea    0x7c1(%eax),%esi
     847:	7e 28                	jle    871 <showCoor+0x141>
     849:	8b 7d bc             	mov    -0x44(%ebp),%edi
     84c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        setconsole(coor(line, i + 65), tmp[i], coorColor, -1, 2);//然后输出当前光标位置的行、列号
     850:	0f be 84 1d 13 f8 ff 	movsbl -0x7ed(%ebp,%ebx,1),%eax
     857:	ff 
     858:	83 ec 0c             	sub    $0xc,%esp
     85b:	6a 02                	push   $0x2
     85d:	6a ff                	push   $0xffffffff
     85f:	57                   	push   %edi
     860:	50                   	push   %eax
     861:	53                   	push   %ebx
     862:	83 c3 01             	add    $0x1,%ebx
     865:	e8 68 12 00 00       	call   1ad2 <setconsole>
    for (i = 0; i < strlen(digit); ++i)
        tmp[p++] = digit[i];
    tmp[p++] = 'C';
    tmp[p++] = 0;
    l = strlen(tmp);
    for (i = 0; i < l; ++i)
     86a:	83 c4 20             	add    $0x20,%esp
     86d:	39 de                	cmp    %ebx,%esi
     86f:	75 df                	jne    850 <showCoor+0x120>
        setconsole(coor(line, i + 65), tmp[i], coorColor, -1, 2);//然后输出当前光标位置的行、列号
}
     871:	8d 65 f4             	lea    -0xc(%ebp),%esp
     874:	5b                   	pop    %ebx
     875:	5e                   	pop    %esi
     876:	5f                   	pop    %edi
     877:	5d                   	pop    %ebp
     878:	c3                   	ret    
     879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000880 <showText>:

void
showText()//显示文本
{
     880:	55                   	push   %ebp
     881:	ba 18 00 00 00       	mov    $0x18,%edx
     886:	89 e5                	mov    %esp,%ebp
     888:	57                   	push   %edi
     889:	56                   	push   %esi
     88a:	53                   	push   %ebx
     88b:	83 ec 1c             	sub    $0x1c,%esp
    int i, j, l;
    int n = num_line - startline;
     88e:	a1 88 28 00 00       	mov    0x2888,%eax
     893:	2b 05 8c 28 00 00    	sub    0x288c,%eax
     899:	83 f8 18             	cmp    $0x18,%eax
     89c:	0f 4e d0             	cmovle %eax,%edx
     89f:	31 ff                	xor    %edi,%edi
    if (n > 24)
        n = 24;
    for (i = 0; i < 24; ++i)
     8a1:	31 db                	xor    %ebx,%ebx
     8a3:	89 55 dc             	mov    %edx,-0x24(%ebp)
     8a6:	8d 76 00             	lea    0x0(%esi),%esi
     8a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     8b0:	8d 77 50             	lea    0x50(%edi),%esi
     8b3:	eb 21                	jmp    8d6 <showText+0x56>
     8b5:	8d 76 00             	lea    0x0(%esi),%esi
        for (j = 0; j < CONSOLE_WIDTH; ++j)
            if( i != cursorX)//如果当前行不是焦点行
                setconsole(coor(i, j), 0, GRAY, -1, 2);
     8b8:	83 ec 0c             	sub    $0xc,%esp
     8bb:	6a 02                	push   $0x2
     8bd:	6a ff                	push   $0xffffffff
     8bf:	68 00 07 00 00       	push   $0x700
     8c4:	6a 00                	push   $0x0
     8c6:	57                   	push   %edi
     8c7:	83 c7 01             	add    $0x1,%edi
     8ca:	e8 03 12 00 00       	call   1ad2 <setconsole>
     8cf:	83 c4 20             	add    $0x20,%esp
    int i, j, l;
    int n = num_line - startline;
    if (n > 24)
        n = 24;
    for (i = 0; i < 24; ++i)
        for (j = 0; j < CONSOLE_WIDTH; ++j)
     8d2:	39 fe                	cmp    %edi,%esi
     8d4:	74 2a                	je     900 <showText+0x80>
            if( i != cursorX)//如果当前行不是焦点行
     8d6:	39 1d cc 28 00 00    	cmp    %ebx,0x28cc
     8dc:	75 da                	jne    8b8 <showText+0x38>
                setconsole(coor(i, j), 0, GRAY, -1, 2);
            else
                setconsole(coor(i,j), 0, combineColor(BLACK, CURRENT_LINE_COLOR), -1, 2);
     8de:	a1 d0 50 00 00       	mov    0x50d0,%eax
     8e3:	83 ec 0c             	sub    $0xc,%esp
     8e6:	6a 02                	push   $0x2
     8e8:	6a ff                	push   $0xffffffff
     8ea:	c1 e0 04             	shl    $0x4,%eax
     8ed:	50                   	push   %eax
     8ee:	6a 00                	push   $0x0
     8f0:	57                   	push   %edi
     8f1:	83 c7 01             	add    $0x1,%edi
     8f4:	e8 d9 11 00 00       	call   1ad2 <setconsole>
     8f9:	83 c4 20             	add    $0x20,%esp
    int i, j, l;
    int n = num_line - startline;
    if (n > 24)
        n = 24;
    for (i = 0; i < 24; ++i)
        for (j = 0; j < CONSOLE_WIDTH; ++j)
     8fc:	39 fe                	cmp    %edi,%esi
     8fe:	75 d6                	jne    8d6 <showText+0x56>
{
    int i, j, l;
    int n = num_line - startline;
    if (n > 24)
        n = 24;
    for (i = 0; i < 24; ++i)
     900:	83 c3 01             	add    $0x1,%ebx
     903:	89 f7                	mov    %esi,%edi
     905:	83 fb 18             	cmp    $0x18,%ebx
     908:	75 a6                	jne    8b0 <showText+0x30>
        for (j = 0; j < CONSOLE_WIDTH; ++j)
            if( i != cursorX)//如果当前行不是焦点行
                setconsole(coor(i, j), 0, GRAY, -1, 2);
            else
                setconsole(coor(i,j), 0, combineColor(BLACK, CURRENT_LINE_COLOR), -1, 2);
    for (i = startline; i < startline + n; ++i){
     90a:	8b 35 8c 28 00 00    	mov    0x288c,%esi
     910:	8b 45 dc             	mov    -0x24(%ebp),%eax
     913:	01 f0                	add    %esi,%eax
     915:	39 c6                	cmp    %eax,%esi
     917:	0f 8d df 00 00 00    	jge    9fc <showText+0x17c>
     91d:	6b c6 64             	imul   $0x64,%esi,%eax
     920:	05 c0 29 00 00       	add    $0x29c0,%eax
     925:	89 45 e0             	mov    %eax,-0x20(%ebp)
        l = strlen(textbuf[i]);
     928:	8b 7d e0             	mov    -0x20(%ebp),%edi
     92b:	83 ec 0c             	sub    $0xc,%esp
        for (j = 0; j < l; ++j)
     92e:	31 db                	xor    %ebx,%ebx
            if( i != cursorX)//如果当前行不是焦点行
                setconsole(coor(i, j), 0, GRAY, -1, 2);
            else
                setconsole(coor(i,j), 0, combineColor(BLACK, CURRENT_LINE_COLOR), -1, 2);
    for (i = startline; i < startline + n; ++i){
        l = strlen(textbuf[i]);
     930:	57                   	push   %edi
     931:	e8 3a 0f 00 00       	call   1870 <strlen>
        for (j = 0; j < l; ++j)
     936:	83 c4 10             	add    $0x10,%esp
     939:	85 c0                	test   %eax,%eax
            if( i != cursorX)//如果当前行不是焦点行
                setconsole(coor(i, j), 0, GRAY, -1, 2);
            else
                setconsole(coor(i,j), 0, combineColor(BLACK, CURRENT_LINE_COLOR), -1, 2);
    for (i = startline; i < startline + n; ++i){
        l = strlen(textbuf[i]);
     93b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for (j = 0; j < l; ++j)
     93e:	7f 47                	jg     987 <showText+0x107>
     940:	e9 9f 00 00 00       	jmp    9e4 <showText+0x164>
     945:	8d 76 00             	lea    0x0(%esi),%esi
            if( (i-startline) != cursorX)//如果不是焦点行
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, BACKGROUND_COLOR), -1, 2);
     948:	8b 15 44 29 00 00    	mov    0x2944,%edx
     94e:	83 ec 0c             	sub    $0xc,%esp
     951:	6a 02                	push   $0x2
     953:	6a ff                	push   $0xffffffff
     955:	c1 e2 04             	shl    $0x4,%edx
     958:	0b 15 d4 50 00 00    	or     0x50d4,%edx
     95e:	52                   	push   %edx
     95f:	0f be 17             	movsbl (%edi),%edx
     962:	52                   	push   %edx
     963:	8b 15 90 28 00 00    	mov    0x2890,%edx
     969:	01 da                	add    %ebx,%edx
            else if( (j-left) != cursorY)//如果是焦点行
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, CURRENT_LINE_COLOR), -1, 2);
            else//如果是焦点位置
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, CURRENT_POSITION_COLOR), -1, 2);
     96b:	8d 04 80             	lea    (%eax,%eax,4),%eax
                setconsole(coor(i, j), 0, GRAY, -1, 2);
            else
                setconsole(coor(i,j), 0, combineColor(BLACK, CURRENT_LINE_COLOR), -1, 2);
    for (i = startline; i < startline + n; ++i){
        l = strlen(textbuf[i]);
        for (j = 0; j < l; ++j)
     96e:	83 c3 01             	add    $0x1,%ebx
     971:	83 c7 01             	add    $0x1,%edi
            if( (i-startline) != cursorX)//如果不是焦点行
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, BACKGROUND_COLOR), -1, 2);
            else if( (j-left) != cursorY)//如果是焦点行
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, CURRENT_LINE_COLOR), -1, 2);
            else//如果是焦点位置
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, CURRENT_POSITION_COLOR), -1, 2);
     974:	c1 e0 04             	shl    $0x4,%eax
     977:	01 d0                	add    %edx,%eax
     979:	50                   	push   %eax
     97a:	e8 53 11 00 00       	call   1ad2 <setconsole>
     97f:	83 c4 20             	add    $0x20,%esp
                setconsole(coor(i, j), 0, GRAY, -1, 2);
            else
                setconsole(coor(i,j), 0, combineColor(BLACK, CURRENT_LINE_COLOR), -1, 2);
    for (i = startline; i < startline + n; ++i){
        l = strlen(textbuf[i]);
        for (j = 0; j < l; ++j)
     982:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
     985:	74 5d                	je     9e4 <showText+0x164>
            if( (i-startline) != cursorX)//如果不是焦点行
     987:	89 f0                	mov    %esi,%eax
     989:	2b 05 8c 28 00 00    	sub    0x288c,%eax
     98f:	3b 05 cc 28 00 00    	cmp    0x28cc,%eax
     995:	75 b1                	jne    948 <showText+0xc8>
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, BACKGROUND_COLOR), -1, 2);
            else if( (j-left) != cursorY)//如果是焦点行
     997:	8b 15 90 28 00 00    	mov    0x2890,%edx
     99d:	89 d9                	mov    %ebx,%ecx
     99f:	29 d1                	sub    %edx,%ecx
     9a1:	3b 0d a4 29 00 00    	cmp    0x29a4,%ecx
     9a7:	74 5f                	je     a08 <showText+0x188>
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, CURRENT_LINE_COLOR), -1, 2);
     9a9:	8b 0d d0 50 00 00    	mov    0x50d0,%ecx
     9af:	83 ec 0c             	sub    $0xc,%esp
     9b2:	83 c7 01             	add    $0x1,%edi
     9b5:	6a 02                	push   $0x2
     9b7:	6a ff                	push   $0xffffffff
     9b9:	c1 e1 04             	shl    $0x4,%ecx
     9bc:	0b 0d d4 50 00 00    	or     0x50d4,%ecx
     9c2:	51                   	push   %ecx
     9c3:	0f be 4f ff          	movsbl -0x1(%edi),%ecx
     9c7:	51                   	push   %ecx
     9c8:	8d 0c 13             	lea    (%ebx,%edx,1),%ecx
     9cb:	8d 14 80             	lea    (%eax,%eax,4),%edx
                setconsole(coor(i, j), 0, GRAY, -1, 2);
            else
                setconsole(coor(i,j), 0, combineColor(BLACK, CURRENT_LINE_COLOR), -1, 2);
    for (i = startline; i < startline + n; ++i){
        l = strlen(textbuf[i]);
        for (j = 0; j < l; ++j)
     9ce:	83 c3 01             	add    $0x1,%ebx
            if( (i-startline) != cursorX)//如果不是焦点行
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, BACKGROUND_COLOR), -1, 2);
            else if( (j-left) != cursorY)//如果是焦点行
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, CURRENT_LINE_COLOR), -1, 2);
     9d1:	c1 e2 04             	shl    $0x4,%edx
     9d4:	01 ca                	add    %ecx,%edx
     9d6:	52                   	push   %edx
     9d7:	e8 f6 10 00 00       	call   1ad2 <setconsole>
     9dc:	83 c4 20             	add    $0x20,%esp
                setconsole(coor(i, j), 0, GRAY, -1, 2);
            else
                setconsole(coor(i,j), 0, combineColor(BLACK, CURRENT_LINE_COLOR), -1, 2);
    for (i = startline; i < startline + n; ++i){
        l = strlen(textbuf[i]);
        for (j = 0; j < l; ++j)
     9df:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
     9e2:	75 a3                	jne    987 <showText+0x107>
        for (j = 0; j < CONSOLE_WIDTH; ++j)
            if( i != cursorX)//如果当前行不是焦点行
                setconsole(coor(i, j), 0, GRAY, -1, 2);
            else
                setconsole(coor(i,j), 0, combineColor(BLACK, CURRENT_LINE_COLOR), -1, 2);
    for (i = startline; i < startline + n; ++i){
     9e4:	8b 45 dc             	mov    -0x24(%ebp),%eax
     9e7:	03 05 8c 28 00 00    	add    0x288c,%eax
     9ed:	83 c6 01             	add    $0x1,%esi
     9f0:	83 45 e0 64          	addl   $0x64,-0x20(%ebp)
     9f4:	39 f0                	cmp    %esi,%eax
     9f6:	0f 8f 2c ff ff ff    	jg     928 <showText+0xa8>
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, CURRENT_LINE_COLOR), -1, 2);
            else//如果是焦点位置
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, CURRENT_POSITION_COLOR), -1, 2);
    }
    showCoor();
}
     9fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9ff:	5b                   	pop    %ebx
     a00:	5e                   	pop    %esi
     a01:	5f                   	pop    %edi
     a02:	5d                   	pop    %ebp
            else if( (j-left) != cursorY)//如果是焦点行
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, CURRENT_LINE_COLOR), -1, 2);
            else//如果是焦点位置
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, CURRENT_POSITION_COLOR), -1, 2);
    }
    showCoor();
     a03:	e9 28 fd ff ff       	jmp    730 <showCoor>
            if( (i-startline) != cursorX)//如果不是焦点行
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, BACKGROUND_COLOR), -1, 2);
            else if( (j-left) != cursorY)//如果是焦点行
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, CURRENT_LINE_COLOR), -1, 2);
            else//如果是焦点位置
                setconsole(coor(i - startline, j + left), textbuf[i][j], combineColor(VARIABLE_COLOR, CURRENT_POSITION_COLOR), -1, 2);
     a08:	8b 0d c8 28 00 00    	mov    0x28c8,%ecx
     a0e:	83 ec 0c             	sub    $0xc,%esp
     a11:	01 da                	add    %ebx,%edx
     a13:	6a 02                	push   $0x2
     a15:	6a ff                	push   $0xffffffff
     a17:	c1 e1 04             	shl    $0x4,%ecx
     a1a:	0b 0d d4 50 00 00    	or     0x50d4,%ecx
     a20:	51                   	push   %ecx
     a21:	0f be 0f             	movsbl (%edi),%ecx
     a24:	51                   	push   %ecx
     a25:	e9 41 ff ff ff       	jmp    96b <showText+0xeb>
     a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a30 <getFileInfo>:
    showCoor();
}

char*
getFileInfo()//返回文件的信息，包括文件名和文件的总行数
{
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	57                   	push   %edi
     a34:	56                   	push   %esi
     a35:	53                   	push   %ebx
     a36:	83 ec 28             	sub    $0x28,%esp
    char* result = malloc(sizeof(char) * 60);
     a39:	6a 3c                	push   $0x3c
     a3b:	e8 70 13 00 00       	call   1db0 <malloc>
     a40:	89 c3                	mov    %eax,%ebx
    char* digit = intToString(num_line);
     a42:	58                   	pop    %eax
     a43:	ff 35 88 28 00 00    	pushl  0x2888
     a49:	e8 72 fa ff ff       	call   4c0 <intToString>

    int fl = strlen(filename);
     a4e:	c7 04 24 e0 28 00 00 	movl   $0x28e0,(%esp)

char*
getFileInfo()//返回文件的信息，包括文件名和文件的总行数
{
    char* result = malloc(sizeof(char) * 60);
    char* digit = intToString(num_line);
     a55:	89 c6                	mov    %eax,%esi

    int fl = strlen(filename);
     a57:	e8 14 0e 00 00       	call   1870 <strlen>
     a5c:	89 c7                	mov    %eax,%edi
    int dl = strlen(digit);
     a5e:	89 34 24             	mov    %esi,(%esp)
     a61:	e8 0a 0e 00 00       	call   1870 <strlen>

    int i, p = 1;
    result[0] = '\"';
    for (i = 0; i < fl; ++i)
     a66:	83 c4 10             	add    $0x10,%esp
     a69:	85 ff                	test   %edi,%edi

    int fl = strlen(filename);
    int dl = strlen(digit);

    int i, p = 1;
    result[0] = '\"';
     a6b:	c6 03 22             	movb   $0x22,(%ebx)
    for (i = 0; i < fl; ++i)
     a6e:	0f 8e 9a 00 00 00    	jle    b0e <getFileInfo+0xde>
     a74:	31 c9                	xor    %ecx,%ecx
     a76:	8d 76 00             	lea    0x0(%esi),%esi
     a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        result[p++] = filename[i];
     a80:	0f b6 91 e0 28 00 00 	movzbl 0x28e0(%ecx),%edx
     a87:	88 54 0b 01          	mov    %dl,0x1(%ebx,%ecx,1)
    int fl = strlen(filename);
    int dl = strlen(digit);

    int i, p = 1;
    result[0] = '\"';
    for (i = 0; i < fl; ++i)
     a8b:	83 c1 01             	add    $0x1,%ecx
     a8e:	39 cf                	cmp    %ecx,%edi
     a90:	75 ee                	jne    a80 <getFileInfo+0x50>
     a92:	8d 4f 02             	lea    0x2(%edi),%ecx
     a95:	8d 57 01             	lea    0x1(%edi),%edx
        result[p++] = filename[i];
    result[p++] = '\"';
    for (i = 0; i < 3; ++i)
        result[p++] = ' ';
     a98:	8d 3c 0b             	lea    (%ebx,%ecx,1),%edi

    int i, p = 1;
    result[0] = '\"';
    for (i = 0; i < fl; ++i)
        result[p++] = filename[i];
    result[p++] = '\"';
     a9b:	c6 04 13 22          	movb   $0x22,(%ebx,%edx,1)
    for (i = 0; i < 3; ++i)
        result[p++] = ' ';
     a9f:	c6 07 20             	movb   $0x20,(%edi)
     aa2:	c6 44 0b 01 20       	movb   $0x20,0x1(%ebx,%ecx,1)
     aa7:	c6 44 0b 02 20       	movb   $0x20,0x2(%ebx,%ecx,1)
     aac:	83 c1 03             	add    $0x3,%ecx
    for (i = 0; i < dl; ++i)
     aaf:	85 c0                	test   %eax,%eax
     ab1:	7e 21                	jle    ad4 <getFileInfo+0xa4>
     ab3:	31 d2                	xor    %edx,%edx
     ab5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
     ab8:	90                   	nop
     ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        result[p++] = digit[i];
     ac0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     ac4:	88 4c 17 03          	mov    %cl,0x3(%edi,%edx,1)
    for (i = 0; i < fl; ++i)
        result[p++] = filename[i];
    result[p++] = '\"';
    for (i = 0; i < 3; ++i)
        result[p++] = ' ';
    for (i = 0; i < dl; ++i)
     ac8:	83 c2 01             	add    $0x1,%edx
     acb:	39 d0                	cmp    %edx,%eax
     acd:	75 f1                	jne    ac0 <getFileInfo+0x90>
     acf:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     ad2:	01 c1                	add    %eax,%ecx
        result[p++] = digit[i];
    result[p++] = ' ';
     ad4:	c6 04 0b 20          	movb   $0x20,(%ebx,%ecx,1)
    result[p++] = 'l';
     ad8:	c6 44 0b 01 6c       	movb   $0x6c,0x1(%ebx,%ecx,1)
    result[p++] = 'i';
    result[p++] = 'n';
    result[p++] = 'e';
     add:	8d 41 05             	lea    0x5(%ecx),%eax
        result[p++] = ' ';
    for (i = 0; i < dl; ++i)
        result[p++] = digit[i];
    result[p++] = ' ';
    result[p++] = 'l';
    result[p++] = 'i';
     ae0:	c6 44 0b 02 69       	movb   $0x69,0x2(%ebx,%ecx,1)
    result[p++] = 'n';
     ae5:	c6 44 0b 03 6e       	movb   $0x6e,0x3(%ebx,%ecx,1)
    result[p++] = 'e';
     aea:	c6 44 0b 04 65       	movb   $0x65,0x4(%ebx,%ecx,1)
    if (num_line != 1)
     aef:	83 3d 88 28 00 00 01 	cmpl   $0x1,0x2888
     af6:	74 08                	je     b00 <getFileInfo+0xd0>
        result[p++] = 's';
     af8:	8d 41 06             	lea    0x6(%ecx),%eax
     afb:	c6 44 0b 05 73       	movb   $0x73,0x5(%ebx,%ecx,1)
    result[p++] = 0;
     b00:	c6 04 03 00          	movb   $0x0,(%ebx,%eax,1)
    return result;
}
     b04:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b07:	89 d8                	mov    %ebx,%eax
     b09:	5b                   	pop    %ebx
     b0a:	5e                   	pop    %esi
     b0b:	5f                   	pop    %edi
     b0c:	5d                   	pop    %ebp
     b0d:	c3                   	ret    
    int fl = strlen(filename);
    int dl = strlen(digit);

    int i, p = 1;
    result[0] = '\"';
    for (i = 0; i < fl; ++i)
     b0e:	ba 01 00 00 00       	mov    $0x1,%edx
     b13:	b9 02 00 00 00       	mov    $0x2,%ecx
     b18:	e9 7b ff ff ff       	jmp    a98 <getFileInfo+0x68>
     b1d:	8d 76 00             	lea    0x0(%esi),%esi

00000b20 <moveCursor>:
    return result;
}

void
moveCursor(int dx, int dy)//在视图坐标系下，移动光标位置
{
     b20:	55                   	push   %ebp
    cursorX += dx;
     b21:	a1 cc 28 00 00       	mov    0x28cc,%eax
    cursorY += dy;
    if (cursorX < top){//如果光标超出了视图的顶部，
     b26:	8b 0d 94 28 00 00    	mov    0x2894,%ecx
        if (startline > 0){//并且视图的第一行不是文档的第一行，
     b2c:	8b 15 8c 28 00 00    	mov    0x288c,%edx
    return result;
}

void
moveCursor(int dx, int dy)//在视图坐标系下，移动光标位置
{
     b32:	89 e5                	mov    %esp,%ebp
     b34:	56                   	push   %esi
     b35:	53                   	push   %ebx
    cursorX += dx;
     b36:	03 45 08             	add    0x8(%ebp),%eax
    cursorY += dy;
     b39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     b3c:	03 1d a4 29 00 00    	add    0x29a4,%ebx
    if (cursorX < top){//如果光标超出了视图的顶部，
     b42:	39 c8                	cmp    %ecx,%eax
}

void
moveCursor(int dx, int dy)//在视图坐标系下，移动光标位置
{
    cursorX += dx;
     b44:	a3 cc 28 00 00       	mov    %eax,0x28cc
    cursorY += dy;
     b49:	89 1d a4 29 00 00    	mov    %ebx,0x29a4
    if (cursorX < top){//如果光标超出了视图的顶部，
     b4f:	7d 15                	jge    b66 <moveCursor+0x46>
        if (startline > 0){//并且视图的第一行不是文档的第一行，
     b51:	85 d2                	test   %edx,%edx
     b53:	7e 09                	jle    b5e <moveCursor+0x3e>
            startline--;//则将文档显示内容向上移动1行。Note:此处采用的策略，在快速移动多行时，会出错！！！
     b55:	83 ea 01             	sub    $0x1,%edx
     b58:	89 15 8c 28 00 00    	mov    %edx,0x288c
            //showText();//并重现显示文本
        }
        cursorX = top;//然后将光标定位在视图的顶部。
     b5e:	89 0d cc 28 00 00    	mov    %ecx,0x28cc
     b64:	89 c8                	mov    %ecx,%eax
    }
    if (cursorX > bottom - 1){//如果光标超出了视图的底部，
     b66:	8b 35 6c 28 00 00    	mov    0x286c,%esi
        if (num_line - startline > 24){//并且视图的最后一行不是文档的最后一行，
     b6c:	8b 0d 88 28 00 00    	mov    0x2888,%ecx
            startline--;//则将文档显示内容向上移动1行。Note:此处采用的策略，在快速移动多行时，会出错！！！
            //showText();//并重现显示文本
        }
        cursorX = top;//然后将光标定位在视图的顶部。
    }
    if (cursorX > bottom - 1){//如果光标超出了视图的底部，
     b72:	39 c6                	cmp    %eax,%esi
     b74:	7f 15                	jg     b8b <moveCursor+0x6b>
        if (num_line - startline > 24){//并且视图的最后一行不是文档的最后一行，
     b76:	89 c8                	mov    %ecx,%eax
     b78:	29 d0                	sub    %edx,%eax
     b7a:	83 f8 18             	cmp    $0x18,%eax
     b7d:	0f 8f 85 00 00 00    	jg     c08 <moveCursor+0xe8>
            startline++;//则将文档显示内容向下移动1行。Note:此处采用的策略，在快速移动多行时，会出错！！！
            //showText();//并重现显示文本
        }
        cursorX = bottom - 1;//然后将光标定位在视图的底部。
     b83:	8d 46 ff             	lea    -0x1(%esi),%eax
     b86:	a3 cc 28 00 00       	mov    %eax,0x28cc
    }
    if (startline + cursorX > num_line - 1)
     b8b:	01 d0                	add    %edx,%eax
     b8d:	39 c8                	cmp    %ecx,%eax
     b8f:	7c 0c                	jl     b9d <moveCursor+0x7d>
        cursorX = num_line - startline - 1;//保证光标cursorX移动不能超过文档的最底部
     b91:	29 d1                	sub    %edx,%ecx
     b93:	8d 41 ff             	lea    -0x1(%ecx),%eax
     b96:	a3 cc 28 00 00       	mov    %eax,0x28cc
     b9b:	01 d0                	add    %edx,%eax
    if (cursorY < left)
     b9d:	8b 15 90 28 00 00    	mov    0x2890,%edx
     ba3:	39 d3                	cmp    %edx,%ebx
     ba5:	7d 06                	jge    bad <moveCursor+0x8d>
        cursorY = left;//cursorY不能超过视图的左界，
     ba7:	89 15 a4 29 00 00    	mov    %edx,0x29a4
    int l = strlen(textbuf[startline + cursorX]);
     bad:	6b c0 64             	imul   $0x64,%eax,%eax
     bb0:	83 ec 0c             	sub    $0xc,%esp
     bb3:	05 c0 29 00 00       	add    $0x29c0,%eax
     bb8:	50                   	push   %eax
     bb9:	e8 b2 0c 00 00       	call   1870 <strlen>
    if (cursorY > l)
     bbe:	8b 15 a4 29 00 00    	mov    0x29a4,%edx
     bc4:	83 c4 10             	add    $0x10,%esp
     bc7:	39 d0                	cmp    %edx,%eax
     bc9:	7d 07                	jge    bd2 <moveCursor+0xb2>
        cursorY = l;//同时也不能超过字符串的右端
     bcb:	a3 a4 29 00 00       	mov    %eax,0x29a4
     bd0:	89 c2                	mov    %eax,%edx
    setconsole(-1, 0, 0, coor(cursorX, cursorY), 2);
     bd2:	a1 cc 28 00 00       	mov    0x28cc,%eax
     bd7:	83 ec 0c             	sub    $0xc,%esp
     bda:	6a 02                	push   $0x2
     bdc:	8d 04 80             	lea    (%eax,%eax,4),%eax
     bdf:	c1 e0 04             	shl    $0x4,%eax
     be2:	01 c2                	add    %eax,%edx
     be4:	52                   	push   %edx
     be5:	6a 00                	push   $0x0
     be7:	6a 00                	push   $0x0
     be9:	6a ff                	push   $0xffffffff
     beb:	e8 e2 0e 00 00       	call   1ad2 <setconsole>
    showCoor();//重新显示当前光标的位置
     bf0:	83 c4 20             	add    $0x20,%esp
     bf3:	e8 38 fb ff ff       	call   730 <showCoor>
    showText();//重新显示文本
}
     bf8:	8d 65 f8             	lea    -0x8(%ebp),%esp
     bfb:	5b                   	pop    %ebx
     bfc:	5e                   	pop    %esi
     bfd:	5d                   	pop    %ebp
    int l = strlen(textbuf[startline + cursorX]);
    if (cursorY > l)
        cursorY = l;//同时也不能超过字符串的右端
    setconsole(-1, 0, 0, coor(cursorX, cursorY), 2);
    showCoor();//重新显示当前光标的位置
    showText();//重新显示文本
     bfe:	e9 7d fc ff ff       	jmp    880 <showText>
     c03:	90                   	nop
     c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        }
        cursorX = top;//然后将光标定位在视图的顶部。
    }
    if (cursorX > bottom - 1){//如果光标超出了视图的底部，
        if (num_line - startline > 24){//并且视图的最后一行不是文档的最后一行，
            startline++;//则将文档显示内容向下移动1行。Note:此处采用的策略，在快速移动多行时，会出错！！！
     c08:	83 c2 01             	add    $0x1,%edx
     c0b:	89 15 8c 28 00 00    	mov    %edx,0x288c
     c11:	e9 6d ff ff ff       	jmp    b83 <moveCursor+0x63>
     c16:	8d 76 00             	lea    0x0(%esi),%esi
     c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c20 <runCursorCtrl>:
    showText();//重新显示文本
}

int
runCursorCtrl(char c)//光标的控制
{
     c20:	55                   	push   %ebp
     c21:	89 e5                	mov    %esp,%ebp
     c23:	83 ec 08             	sub    $0x8,%esp
    int t = c;
    t &= 0xff;
    switch (t){
     c26:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
     c2a:	2d e0 00 00 00       	sub    $0xe0,%eax
     c2f:	83 f8 08             	cmp    $0x8,%eax
     c32:	0f 87 e8 00 00 00    	ja     d20 <runCursorCtrl+0x100>
     c38:	ff 24 85 50 1f 00 00 	jmp    *0x1f50(,%eax,4)
     c3f:	90                   	nop
        case KEY_END:
            moveCursor(0, 10000);
            return 1;
        case KEY_INS:
            mode = 1;
            showMessage("-- INSERT --");
     c40:	83 ec 0c             	sub    $0xc,%esp
            return 1;
        case KEY_END:
            moveCursor(0, 10000);
            return 1;
        case KEY_INS:
            mode = 1;
     c43:	c7 05 84 28 00 00 01 	movl   $0x1,0x2884
     c4a:	00 00 00 
            showMessage("-- INSERT --");
     c4d:	68 cb 1e 00 00       	push   $0x1ecb
     c52:	e8 19 f9 ff ff       	call   570 <showMessage>
            return 1;
     c57:	83 c4 10             	add    $0x10,%esp
     c5a:	b8 01 00 00 00       	mov    $0x1,%eax
    }
    return 0;
}
     c5f:	c9                   	leave  
     c60:	c3                   	ret    
     c61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            return 1;
        case KEY_RT:
            moveCursor(0, 1);
            return 1;
        case KEY_HOME:
            moveCursor(0, -10000);
     c68:	83 ec 08             	sub    $0x8,%esp
     c6b:	68 f0 d8 ff ff       	push   $0xffffd8f0
     c70:	6a 00                	push   $0x0
     c72:	e8 a9 fe ff ff       	call   b20 <moveCursor>
     c77:	83 c4 10             	add    $0x10,%esp
     c7a:	b8 01 00 00 00       	mov    $0x1,%eax
            mode = 1;
            showMessage("-- INSERT --");
            return 1;
    }
    return 0;
}
     c7f:	c9                   	leave  
     c80:	c3                   	ret    
     c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            return 1;
        case KEY_HOME:
            moveCursor(0, -10000);
            return 1;
        case KEY_END:
            moveCursor(0, 10000);
     c88:	83 ec 08             	sub    $0x8,%esp
     c8b:	68 10 27 00 00       	push   $0x2710
     c90:	6a 00                	push   $0x0
     c92:	e8 89 fe ff ff       	call   b20 <moveCursor>
            return 1;
     c97:	83 c4 10             	add    $0x10,%esp
     c9a:	b8 01 00 00 00       	mov    $0x1,%eax
            mode = 1;
            showMessage("-- INSERT --");
            return 1;
    }
    return 0;
}
     c9f:	c9                   	leave  
     ca0:	c3                   	ret    
     ca1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
    int t = c;
    t &= 0xff;
    switch (t){
        case KEY_UP:
            moveCursor(-1, 0);
     ca8:	83 ec 08             	sub    $0x8,%esp
     cab:	6a 00                	push   $0x0
     cad:	6a ff                	push   $0xffffffff
     caf:	e8 6c fe ff ff       	call   b20 <moveCursor>
            return 1;
     cb4:	83 c4 10             	add    $0x10,%esp
     cb7:	b8 01 00 00 00       	mov    $0x1,%eax
            mode = 1;
            showMessage("-- INSERT --");
            return 1;
    }
    return 0;
}
     cbc:	c9                   	leave  
     cbd:	c3                   	ret    
     cbe:	66 90                	xchg   %ax,%ax
    switch (t){
        case KEY_UP:
            moveCursor(-1, 0);
            return 1;
        case KEY_DN:
            moveCursor(1, 0);
     cc0:	83 ec 08             	sub    $0x8,%esp
     cc3:	6a 00                	push   $0x0
     cc5:	6a 01                	push   $0x1
     cc7:	e8 54 fe ff ff       	call   b20 <moveCursor>
            return 1;
     ccc:	83 c4 10             	add    $0x10,%esp
     ccf:	b8 01 00 00 00       	mov    $0x1,%eax
            mode = 1;
            showMessage("-- INSERT --");
            return 1;
    }
    return 0;
}
     cd4:	c9                   	leave  
     cd5:	c3                   	ret    
     cd6:	8d 76 00             	lea    0x0(%esi),%esi
     cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            return 1;
        case KEY_DN:
            moveCursor(1, 0);
            return 1;
        case KEY_LF:
            moveCursor(0, -1);
     ce0:	83 ec 08             	sub    $0x8,%esp
     ce3:	6a ff                	push   $0xffffffff
     ce5:	6a 00                	push   $0x0
     ce7:	e8 34 fe ff ff       	call   b20 <moveCursor>
            return 1;
     cec:	83 c4 10             	add    $0x10,%esp
     cef:	b8 01 00 00 00       	mov    $0x1,%eax
            mode = 1;
            showMessage("-- INSERT --");
            return 1;
    }
    return 0;
}
     cf4:	c9                   	leave  
     cf5:	c3                   	ret    
     cf6:	8d 76 00             	lea    0x0(%esi),%esi
     cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            return 1;
        case KEY_LF:
            moveCursor(0, -1);
            return 1;
        case KEY_RT:
            moveCursor(0, 1);
     d00:	83 ec 08             	sub    $0x8,%esp
     d03:	6a 01                	push   $0x1
     d05:	6a 00                	push   $0x0
     d07:	e8 14 fe ff ff       	call   b20 <moveCursor>
            return 1;
     d0c:	83 c4 10             	add    $0x10,%esp
     d0f:	b8 01 00 00 00       	mov    $0x1,%eax
            mode = 1;
            showMessage("-- INSERT --");
            return 1;
    }
    return 0;
}
     d14:	c9                   	leave  
     d15:	c3                   	ret    
     d16:	8d 76 00             	lea    0x0(%esi),%esi
     d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        case KEY_INS:
            mode = 1;
            showMessage("-- INSERT --");
            return 1;
    }
    return 0;
     d20:	31 c0                	xor    %eax,%eax
}
     d22:	c9                   	leave  
     d23:	c3                   	ret    
     d24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000d30 <insertline>:

void
insertline()//在当前光标所在位置的下一行插入新的一行
{
     d30:	55                   	push   %ebp
     d31:	89 e5                	mov    %esp,%ebp
     d33:	57                   	push   %edi
     d34:	56                   	push   %esi
     d35:	53                   	push   %ebx
     d36:	83 ec 2c             	sub    $0x2c,%esp
    int i = 0, j = 0, l, textX = cursorX + startline + 1;//插入行在文档中的行数为textX
     d39:	a1 8c 28 00 00       	mov    0x288c,%eax
     d3e:	03 05 cc 28 00 00    	add    0x28cc,%eax
     d44:	83 c0 01             	add    $0x1,%eax
     d47:	89 c3                	mov    %eax,%ebx
     d49:	89 45 d0             	mov    %eax,-0x30(%ebp)
    num_line++;//总行数增加
     d4c:	a1 88 28 00 00       	mov    0x2888,%eax
     d51:	8d 50 01             	lea    0x1(%eax),%edx
    for (i = num_line - 1; i > textX; --i){//将textX以下的所有内容向下平移1行
     d54:	39 c3                	cmp    %eax,%ebx

void
insertline()//在当前光标所在位置的下一行插入新的一行
{
    int i = 0, j = 0, l, textX = cursorX + startline + 1;//插入行在文档中的行数为textX
    num_line++;//总行数增加
     d56:	89 45 e0             	mov    %eax,-0x20(%ebp)
     d59:	89 15 88 28 00 00    	mov    %edx,0x2888
    for (i = num_line - 1; i > textX; --i){//将textX以下的所有内容向下平移1行
     d5f:	0f 8d b4 00 00 00    	jge    e19 <insertline+0xe9>
     d65:	83 e8 01             	sub    $0x1,%eax
     d68:	89 c3                	mov    %eax,%ebx
     d6a:	89 45 d8             	mov    %eax,-0x28(%ebp)
     d6d:	6b c0 64             	imul   $0x64,%eax,%eax
     d70:	6b db 9c             	imul   $0xffffff9c,%ebx,%ebx
     d73:	8d b8 c0 29 00 00    	lea    0x29c0(%eax),%edi
     d79:	89 45 dc             	mov    %eax,-0x24(%ebp)
     d7c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
     d7f:	90                   	nop
        l = strlen(textbuf[i - 1]);
     d80:	8b 75 e4             	mov    -0x1c(%ebp),%esi
     d83:	83 ec 0c             	sub    $0xc,%esp
     d86:	56                   	push   %esi
     d87:	e8 e4 0a 00 00       	call   1870 <strlen>
        for (j = 0; j < l; ++j)
     d8c:	83 c4 10             	add    $0x10,%esp
     d8f:	85 c0                	test   %eax,%eax
     d91:	7e 5a                	jle    ded <insertline+0xbd>
     d93:	8b 4d dc             	mov    -0x24(%ebp),%ecx
     d96:	89 f2                	mov    %esi,%edx
     d98:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     d9b:	89 ce                	mov    %ecx,%esi
     d9d:	8d bc 08 c0 29 00 00 	lea    0x29c0(%eax,%ecx,1),%edi
     da4:	83 c6 64             	add    $0x64,%esi
     da7:	89 f6                	mov    %esi,%esi
     da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            textbuf[i][j] = textbuf[i - 1][j];
     db0:	0f b6 02             	movzbl (%edx),%eax
     db3:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
     db6:	83 c2 01             	add    $0x1,%edx
{
    int i = 0, j = 0, l, textX = cursorX + startline + 1;//插入行在文档中的行数为textX
    num_line++;//总行数增加
    for (i = num_line - 1; i > textX; --i){//将textX以下的所有内容向下平移1行
        l = strlen(textbuf[i - 1]);
        for (j = 0; j < l; ++j)
     db9:	39 fa                	cmp    %edi,%edx
            textbuf[i][j] = textbuf[i - 1][j];
     dbb:	88 04 31             	mov    %al,(%ecx,%esi,1)
{
    int i = 0, j = 0, l, textX = cursorX + startline + 1;//插入行在文档中的行数为textX
    num_line++;//总行数增加
    for (i = num_line - 1; i > textX; --i){//将textX以下的所有内容向下平移1行
        l = strlen(textbuf[i - 1]);
        for (j = 0; j < l; ++j)
     dbe:	75 f0                	jne    db0 <insertline+0x80>
     dc0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
            textbuf[i][j] = textbuf[i - 1][j];
        textbuf[i][j] = 0;
     dc3:	6b 55 e0 64          	imul   $0x64,-0x20(%ebp),%edx
     dc7:	8b 75 d8             	mov    -0x28(%ebp),%esi
     dca:	83 6d e4 64          	subl   $0x64,-0x1c(%ebp)
     dce:	83 c3 64             	add    $0x64,%ebx
     dd1:	83 6d dc 64          	subl   $0x64,-0x24(%ebp)
void
insertline()//在当前光标所在位置的下一行插入新的一行
{
    int i = 0, j = 0, l, textX = cursorX + startline + 1;//插入行在文档中的行数为textX
    num_line++;//总行数增加
    for (i = num_line - 1; i > textX; --i){//将textX以下的所有内容向下平移1行
     dd5:	3b 75 d0             	cmp    -0x30(%ebp),%esi
     dd8:	89 75 e0             	mov    %esi,-0x20(%ebp)
        l = strlen(textbuf[i - 1]);
        for (j = 0; j < l; ++j)
            textbuf[i][j] = textbuf[i - 1][j];
        textbuf[i][j] = 0;
     ddb:	c6 84 10 c0 29 00 00 	movb   $0x0,0x29c0(%eax,%edx,1)
     de2:	00 
void
insertline()//在当前光标所在位置的下一行插入新的一行
{
    int i = 0, j = 0, l, textX = cursorX + startline + 1;//插入行在文档中的行数为textX
    num_line++;//总行数增加
    for (i = num_line - 1; i > textX; --i){//将textX以下的所有内容向下平移1行
     de3:	74 0c                	je     df1 <insertline+0xc1>
     de5:	8d 46 ff             	lea    -0x1(%esi),%eax
     de8:	89 45 d8             	mov    %eax,-0x28(%ebp)
     deb:	eb 93                	jmp    d80 <insertline+0x50>
        l = strlen(textbuf[i - 1]);
        for (j = 0; j < l; ++j)
     ded:	31 c0                	xor    %eax,%eax
     def:	eb d2                	jmp    dc3 <insertline+0x93>
     df1:	8b 15 88 28 00 00    	mov    0x2888,%edx
            textbuf[i][j] = textbuf[i - 1][j];
        textbuf[i][j] = 0;
    }
    textbuf[num_line][j] = 0;//最后一行内容为空
     df7:	6b d2 64             	imul   $0x64,%edx,%edx
     dfa:	c6 84 10 c0 29 00 00 	movb   $0x0,0x29c0(%eax,%edx,1)
     e01:	00 
    textbuf[textX][0] = 0;//插入行的内容为空
     e02:	6b 45 d0 64          	imul   $0x64,-0x30(%ebp),%eax
     e06:	c6 80 c0 29 00 00 00 	movb   $0x0,0x29c0(%eax)
    showText();//重新显示视图
}
     e0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e10:	5b                   	pop    %ebx
     e11:	5e                   	pop    %esi
     e12:	5f                   	pop    %edi
     e13:	5d                   	pop    %ebp
            textbuf[i][j] = textbuf[i - 1][j];
        textbuf[i][j] = 0;
    }
    textbuf[num_line][j] = 0;//最后一行内容为空
    textbuf[textX][0] = 0;//插入行的内容为空
    showText();//重新显示视图
     e14:	e9 67 fa ff ff       	jmp    880 <showText>
}

void
insertline()//在当前光标所在位置的下一行插入新的一行
{
    int i = 0, j = 0, l, textX = cursorX + startline + 1;//插入行在文档中的行数为textX
     e19:	31 c0                	xor    %eax,%eax
     e1b:	eb da                	jmp    df7 <insertline+0xc7>
     e1d:	8d 76 00             	lea    0x0(%esi),%esi

00000e20 <deleteline>:
    showText();//重新显示视图
}

void
deleteline(int offset)//删除一行内容，该行相对于当前的光标位置的偏移量为offset
{
     e20:	55                   	push   %ebp
     e21:	89 e5                	mov    %esp,%ebp
     e23:	57                   	push   %edi
     e24:	56                   	push   %esi
     e25:	53                   	push   %ebx
     e26:	83 ec 2c             	sub    $0x2c,%esp
    int i, j, l, textX = cursorX + startline + offset;//删除行在文档的行数为textX
     e29:	a1 8c 28 00 00       	mov    0x288c,%eax
     e2e:	03 05 cc 28 00 00    	add    0x28cc,%eax
     e34:	03 45 08             	add    0x8(%ebp),%eax
     e37:	89 c3                	mov    %eax,%ebx
     e39:	89 45 e0             	mov    %eax,-0x20(%ebp)
    num_line--;//总行数减少
     e3c:	a1 88 28 00 00       	mov    0x2888,%eax
     e41:	83 e8 01             	sub    $0x1,%eax
    for (i = textX; i < num_line; ++i){//将textX以下的所有内容向上平移1行
     e44:	39 c3                	cmp    %eax,%ebx

void
deleteline(int offset)//删除一行内容，该行相对于当前的光标位置的偏移量为offset
{
    int i, j, l, textX = cursorX + startline + offset;//删除行在文档的行数为textX
    num_line--;//总行数减少
     e46:	a3 88 28 00 00       	mov    %eax,0x2888
    for (i = textX; i < num_line; ++i){//将textX以下的所有内容向上平移1行
     e4b:	0f 8d 94 00 00 00    	jge    ee5 <deleteline+0xc5>
     e51:	89 d8                	mov    %ebx,%eax
     e53:	83 c0 01             	add    $0x1,%eax
     e56:	89 c3                	mov    %eax,%ebx
     e58:	89 45 d8             	mov    %eax,-0x28(%ebp)
     e5b:	6b c0 64             	imul   $0x64,%eax,%eax
     e5e:	6b db 9c             	imul   $0xffffff9c,%ebx,%ebx
     e61:	8d b8 c0 29 00 00    	lea    0x29c0(%eax),%edi
     e67:	89 45 dc             	mov    %eax,-0x24(%ebp)
     e6a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
     e6d:	8d 76 00             	lea    0x0(%esi),%esi
        l = strlen(textbuf[i + 1]);
     e70:	8b 75 e4             	mov    -0x1c(%ebp),%esi
     e73:	83 ec 0c             	sub    $0xc,%esp
     e76:	56                   	push   %esi
     e77:	e8 f4 09 00 00       	call   1870 <strlen>
        for (j = 0; j < l; ++j)
     e7c:	83 c4 10             	add    $0x10,%esp
     e7f:	85 c0                	test   %eax,%eax
     e81:	7e 5e                	jle    ee1 <deleteline+0xc1>
     e83:	8b 4d dc             	mov    -0x24(%ebp),%ecx
     e86:	89 f2                	mov    %esi,%edx
     e88:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     e8b:	89 ce                	mov    %ecx,%esi
     e8d:	8d bc 08 c0 29 00 00 	lea    0x29c0(%eax,%ecx,1),%edi
     e94:	83 ee 64             	sub    $0x64,%esi
     e97:	89 f6                	mov    %esi,%esi
     e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            textbuf[i][j] = textbuf[i + 1][j];
     ea0:	0f b6 02             	movzbl (%edx),%eax
     ea3:	8d 0c 1a             	lea    (%edx,%ebx,1),%ecx
     ea6:	83 c2 01             	add    $0x1,%edx
{
    int i, j, l, textX = cursorX + startline + offset;//删除行在文档的行数为textX
    num_line--;//总行数减少
    for (i = textX; i < num_line; ++i){//将textX以下的所有内容向上平移1行
        l = strlen(textbuf[i + 1]);
        for (j = 0; j < l; ++j)
     ea9:	39 fa                	cmp    %edi,%edx
            textbuf[i][j] = textbuf[i + 1][j];
     eab:	88 04 31             	mov    %al,(%ecx,%esi,1)
{
    int i, j, l, textX = cursorX + startline + offset;//删除行在文档的行数为textX
    num_line--;//总行数减少
    for (i = textX; i < num_line; ++i){//将textX以下的所有内容向上平移1行
        l = strlen(textbuf[i + 1]);
        for (j = 0; j < l; ++j)
     eae:	75 f0                	jne    ea0 <deleteline+0x80>
     eb0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
            textbuf[i][j] = textbuf[i + 1][j];
        textbuf[i][j] = 0;
     eb3:	6b 55 e0 64          	imul   $0x64,-0x20(%ebp),%edx
     eb7:	8b 75 d8             	mov    -0x28(%ebp),%esi
     eba:	83 45 e4 64          	addl   $0x64,-0x1c(%ebp)
     ebe:	83 eb 64             	sub    $0x64,%ebx
     ec1:	83 45 dc 64          	addl   $0x64,-0x24(%ebp)
     ec5:	89 75 e0             	mov    %esi,-0x20(%ebp)
     ec8:	c6 84 10 c0 29 00 00 	movb   $0x0,0x29c0(%eax,%edx,1)
     ecf:	00 
void
deleteline(int offset)//删除一行内容，该行相对于当前的光标位置的偏移量为offset
{
    int i, j, l, textX = cursorX + startline + offset;//删除行在文档的行数为textX
    num_line--;//总行数减少
    for (i = textX; i < num_line; ++i){//将textX以下的所有内容向上平移1行
     ed0:	a1 88 28 00 00       	mov    0x2888,%eax
     ed5:	39 f0                	cmp    %esi,%eax
     ed7:	7e 0c                	jle    ee5 <deleteline+0xc5>
     ed9:	8d 46 01             	lea    0x1(%esi),%eax
     edc:	89 45 d8             	mov    %eax,-0x28(%ebp)
     edf:	eb 8f                	jmp    e70 <deleteline+0x50>
        l = strlen(textbuf[i + 1]);
        for (j = 0; j < l; ++j)
     ee1:	31 c0                	xor    %eax,%eax
     ee3:	eb ce                	jmp    eb3 <deleteline+0x93>
            textbuf[i][j] = textbuf[i + 1][j];
        textbuf[i][j] = 0;
    }
    textbuf[num_line][0] = 0;//最后一行内容为空。
     ee5:	6b d0 64             	imul   $0x64,%eax,%edx
    if (num_line == 0)
     ee8:	85 c0                	test   %eax,%eax
        l = strlen(textbuf[i + 1]);
        for (j = 0; j < l; ++j)
            textbuf[i][j] = textbuf[i + 1][j];
        textbuf[i][j] = 0;
    }
    textbuf[num_line][0] = 0;//最后一行内容为空。
     eea:	c6 82 c0 29 00 00 00 	movb   $0x0,0x29c0(%edx)
    if (num_line == 0)
     ef1:	74 0c                	je     eff <deleteline+0xdf>
        insertline();//保证文档中至少有一行内容
    showText();//出现显示视图
}
     ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ef6:	5b                   	pop    %ebx
     ef7:	5e                   	pop    %esi
     ef8:	5f                   	pop    %edi
     ef9:	5d                   	pop    %ebp
        textbuf[i][j] = 0;
    }
    textbuf[num_line][0] = 0;//最后一行内容为空。
    if (num_line == 0)
        insertline();//保证文档中至少有一行内容
    showText();//出现显示视图
     efa:	e9 81 f9 ff ff       	jmp    880 <showText>
            textbuf[i][j] = textbuf[i + 1][j];
        textbuf[i][j] = 0;
    }
    textbuf[num_line][0] = 0;//最后一行内容为空。
    if (num_line == 0)
        insertline();//保证文档中至少有一行内容
     eff:	e8 2c fe ff ff       	call   d30 <insertline>
    showText();//出现显示视图
}
     f04:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f07:	5b                   	pop    %ebx
     f08:	5e                   	pop    %esi
     f09:	5f                   	pop    %edi
     f0a:	5d                   	pop    %ebp
        textbuf[i][j] = 0;
    }
    textbuf[num_line][0] = 0;//最后一行内容为空。
    if (num_line == 0)
        insertline();//保证文档中至少有一行内容
    showText();//出现显示视图
     f0b:	e9 70 f9 ff ff       	jmp    880 <showText>

00000f10 <delete>:
}

void
delete()//删除1个字符
{
     f10:	55                   	push   %ebp
     f11:	89 e5                	mov    %esp,%ebp
     f13:	57                   	push   %edi
     f14:	56                   	push   %esi
     f15:	53                   	push   %ebx
     f16:	83 ec 1c             	sub    $0x1c,%esp
    int i, j, l1, l2, textX = cursorX + startline, textY = cursorY + left;//光标在文档中的行与列
     f19:	8b 15 a4 29 00 00    	mov    0x29a4,%edx
     f1f:	8b 3d 90 28 00 00    	mov    0x2890,%edi
     f25:	8b 35 8c 28 00 00    	mov    0x288c,%esi
     f2b:	03 35 cc 28 00 00    	add    0x28cc,%esi
    char c;
    if (cursorY == left){//如果光标位置在当前行的最左端
     f31:	39 fa                	cmp    %edi,%edx
     f33:	0f 84 c1 00 00 00    	je     ffa <delete+0xea>
        deleteline(1);//然后删除下一行，
        showText();//最后，重新显示文本
        return;
    }
	//如果光标位置不是在当前行的最左端
    l1 = strlen(textbuf[textX]);
     f39:	6b de 64             	imul   $0x64,%esi,%ebx
     f3c:	83 ec 0c             	sub    $0xc,%esp
     f3f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
     f42:	8d 83 c0 29 00 00    	lea    0x29c0(%ebx),%eax
     f48:	50                   	push   %eax
     f49:	e8 22 09 00 00       	call   1870 <strlen>
}

void
delete()//删除1个字符
{
    int i, j, l1, l2, textX = cursorX + startline, textY = cursorY + left;//光标在文档中的行与列
     f4e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
        showText();//最后，重新显示文本
        return;
    }
	//如果光标位置不是在当前行的最左端
    l1 = strlen(textbuf[textX]);
    for (i = textY - 1; i < l1; i++){//将textY右边的字符整体左移一格
     f51:	83 c4 10             	add    $0x10,%esp
}

void
delete()//删除1个字符
{
    int i, j, l1, l2, textX = cursorX + startline, textY = cursorY + left;//光标在文档中的行与列
     f54:	01 fa                	add    %edi,%edx
        showText();//最后，重新显示文本
        return;
    }
	//如果光标位置不是在当前行的最左端
    l1 = strlen(textbuf[textX]);
    for (i = textY - 1; i < l1; i++){//将textY右边的字符整体左移一格
     f56:	8d 7a ff             	lea    -0x1(%edx),%edi
     f59:	39 f8                	cmp    %edi,%eax
     f5b:	7e 20                	jle    f7d <delete+0x6d>
     f5d:	8d 94 1a c0 29 00 00 	lea    0x29c0(%edx,%ebx,1),%edx
     f64:	8d 9c 18 c1 29 00 00 	lea    0x29c1(%eax,%ebx,1),%ebx
     f6b:	90                   	nop
     f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        textbuf[textX][i] = textbuf[textX][i + 1];
     f70:	0f b6 0a             	movzbl (%edx),%ecx
     f73:	83 c2 01             	add    $0x1,%edx
     f76:	88 4a fe             	mov    %cl,-0x2(%edx)
        showText();//最后，重新显示文本
        return;
    }
	//如果光标位置不是在当前行的最左端
    l1 = strlen(textbuf[textX]);
    for (i = textY - 1; i < l1; i++){//将textY右边的字符整体左移一格
     f79:	39 da                	cmp    %ebx,%edx
     f7b:	75 f3                	jne    f70 <delete+0x60>
        textbuf[textX][i] = textbuf[textX][i + 1];
    }
    l1--;
    for (i = textY - 1; i < l1; i++){//只刷新修改行的内容
     f7d:	8d 58 ff             	lea    -0x1(%eax),%ebx
     f80:	39 df                	cmp    %ebx,%edi
     f82:	7d 3e                	jge    fc2 <delete+0xb2>
     f84:	6b f6 64             	imul   $0x64,%esi,%esi
     f87:	89 f6                	mov    %esi,%esi
     f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        c = textbuf[textX][i];
        setconsole(coor(cursorX, i), c, GRAY, -1, 2);    
     f90:	0f be 84 3e c0 29 00 	movsbl 0x29c0(%esi,%edi,1),%eax
     f97:	00 
     f98:	83 ec 0c             	sub    $0xc,%esp
     f9b:	6a 02                	push   $0x2
     f9d:	6a ff                	push   $0xffffffff
     f9f:	68 00 07 00 00       	push   $0x700
     fa4:	50                   	push   %eax
     fa5:	a1 cc 28 00 00       	mov    0x28cc,%eax
     faa:	8d 04 80             	lea    (%eax,%eax,4),%eax
     fad:	c1 e0 04             	shl    $0x4,%eax
     fb0:	01 f8                	add    %edi,%eax
    l1 = strlen(textbuf[textX]);
    for (i = textY - 1; i < l1; i++){//将textY右边的字符整体左移一格
        textbuf[textX][i] = textbuf[textX][i + 1];
    }
    l1--;
    for (i = textY - 1; i < l1; i++){//只刷新修改行的内容
     fb2:	83 c7 01             	add    $0x1,%edi
        c = textbuf[textX][i];
        setconsole(coor(cursorX, i), c, GRAY, -1, 2);    
     fb5:	50                   	push   %eax
     fb6:	e8 17 0b 00 00       	call   1ad2 <setconsole>
    l1 = strlen(textbuf[textX]);
    for (i = textY - 1; i < l1; i++){//将textY右边的字符整体左移一格
        textbuf[textX][i] = textbuf[textX][i + 1];
    }
    l1--;
    for (i = textY - 1; i < l1; i++){//只刷新修改行的内容
     fbb:	83 c4 20             	add    $0x20,%esp
     fbe:	39 df                	cmp    %ebx,%edi
     fc0:	75 ce                	jne    f90 <delete+0x80>
        c = textbuf[textX][i];
        setconsole(coor(cursorX, i), c, GRAY, -1, 2);    
    }
    setconsole(coor(cursorX, i), 0, GRAY, -1, 2);
     fc2:	a1 cc 28 00 00       	mov    0x28cc,%eax
     fc7:	83 ec 0c             	sub    $0xc,%esp
     fca:	6a 02                	push   $0x2
     fcc:	6a ff                	push   $0xffffffff
     fce:	68 00 07 00 00       	push   $0x700
     fd3:	6a 00                	push   $0x0
     fd5:	8d 04 80             	lea    (%eax,%eax,4),%eax
     fd8:	c1 e0 04             	shl    $0x4,%eax
     fdb:	01 c7                	add    %eax,%edi
     fdd:	57                   	push   %edi
     fde:	e8 ef 0a 00 00       	call   1ad2 <setconsole>
    moveCursor(0, -1);//光标向左移动一个单位
     fe3:	83 c4 18             	add    $0x18,%esp
     fe6:	6a ff                	push   $0xffffffff
     fe8:	6a 00                	push   $0x0
     fea:	e8 31 fb ff ff       	call   b20 <moveCursor>
     fef:	83 c4 10             	add    $0x10,%esp
}
     ff2:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ff5:	5b                   	pop    %ebx
     ff6:	5e                   	pop    %esi
     ff7:	5f                   	pop    %edi
     ff8:	5d                   	pop    %ebp
     ff9:	c3                   	ret    
delete()//删除1个字符
{
    int i, j, l1, l2, textX = cursorX + startline, textY = cursorY + left;//光标在文档中的行与列
    char c;
    if (cursorY == left){//如果光标位置在当前行的最左端
        if (textX == 0)//同时还是第一行
     ffa:	85 f6                	test   %esi,%esi
     ffc:	74 f4                	je     ff2 <delete+0xe2>
            return ;//则无法删除字符，直接返回
        l1 = strlen(textbuf[textX - 1]);
     ffe:	8d 46 ff             	lea    -0x1(%esi),%eax
    1001:	83 ec 0c             	sub    $0xc,%esp
        l2 = strlen(textbuf[textX]);
    1004:	6b f6 64             	imul   $0x64,%esi,%esi
    int i, j, l1, l2, textX = cursorX + startline, textY = cursorY + left;//光标在文档中的行与列
    char c;
    if (cursorY == left){//如果光标位置在当前行的最左端
        if (textX == 0)//同时还是第一行
            return ;//则无法删除字符，直接返回
        l1 = strlen(textbuf[textX - 1]);
    1007:	6b c8 64             	imul   $0x64,%eax,%ecx
    100a:	89 45 e0             	mov    %eax,-0x20(%ebp)
    100d:	8d 81 c0 29 00 00    	lea    0x29c0(%ecx),%eax
    1013:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    1016:	50                   	push   %eax
    1017:	e8 54 08 00 00       	call   1870 <strlen>
    101c:	89 c7                	mov    %eax,%edi
    101e:	89 c3                	mov    %eax,%ebx
        l2 = strlen(textbuf[textX]);
    1020:	8d 86 c0 29 00 00    	lea    0x29c0(%esi),%eax
    1026:	89 04 24             	mov    %eax,(%esp)
    1029:	e8 42 08 00 00       	call   1870 <strlen>
    102e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        moveCursor(-1, 10000);//首先将光标移动到上一行的末尾
    1031:	58                   	pop    %eax
    1032:	5a                   	pop    %edx
    1033:	68 10 27 00 00       	push   $0x2710
    1038:	6a ff                	push   $0xffffffff
    103a:	e8 e1 fa ff ff       	call   b20 <moveCursor>
        for (i = 0, j = l1; i < l2 && j < MAX_LENGTH; ++i, ++j)//将下一行的内容复制到上一行
    103f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1042:	83 c4 10             	add    $0x10,%esp
    1045:	85 c0                	test   %eax,%eax
    1047:	7e 37                	jle    1080 <delete+0x170>
    1049:	83 ff 4f             	cmp    $0x4f,%edi
    104c:	7f 32                	jg     1080 <delete+0x170>
    104e:	29 fe                	sub    %edi,%esi
    1050:	8b 4d dc             	mov    -0x24(%ebp),%ecx
    1053:	89 f2                	mov    %esi,%edx
    1055:	eb 0e                	jmp    1065 <delete+0x155>
    1057:	89 f6                	mov    %esi,%esi
    1059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1060:	83 fb 4f             	cmp    $0x4f,%ebx
    1063:	7f 1b                	jg     1080 <delete+0x170>
            textbuf[textX - 1][j] = textbuf[textX][i];//Note:此处的复制策略比较简单粗暴，存在着一个潜在的bug，当下一行较长时，可能会丢失后半段的字符
    1065:	0f b6 84 1a c0 29 00 	movzbl 0x29c0(%edx,%ebx,1),%eax
    106c:	00 
    106d:	88 84 19 c0 29 00 00 	mov    %al,0x29c0(%ecx,%ebx,1)
        if (textX == 0)//同时还是第一行
            return ;//则无法删除字符，直接返回
        l1 = strlen(textbuf[textX - 1]);
        l2 = strlen(textbuf[textX]);
        moveCursor(-1, 10000);//首先将光标移动到上一行的末尾
        for (i = 0, j = l1; i < l2 && j < MAX_LENGTH; ++i, ++j)//将下一行的内容复制到上一行
    1074:	83 c3 01             	add    $0x1,%ebx
    1077:	89 de                	mov    %ebx,%esi
    1079:	29 fe                	sub    %edi,%esi
    107b:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
    107e:	7c e0                	jl     1060 <delete+0x150>
            textbuf[textX - 1][j] = textbuf[textX][i];//Note:此处的复制策略比较简单粗暴，存在着一个潜在的bug，当下一行较长时，可能会丢失后半段的字符
        textbuf[textX - 1][j] = 0;
    1080:	6b 45 e0 64          	imul   $0x64,-0x20(%ebp),%eax
        deleteline(1);//然后删除下一行，
    1084:	83 ec 0c             	sub    $0xc,%esp
    1087:	6a 01                	push   $0x1
        l1 = strlen(textbuf[textX - 1]);
        l2 = strlen(textbuf[textX]);
        moveCursor(-1, 10000);//首先将光标移动到上一行的末尾
        for (i = 0, j = l1; i < l2 && j < MAX_LENGTH; ++i, ++j)//将下一行的内容复制到上一行
            textbuf[textX - 1][j] = textbuf[textX][i];//Note:此处的复制策略比较简单粗暴，存在着一个潜在的bug，当下一行较长时，可能会丢失后半段的字符
        textbuf[textX - 1][j] = 0;
    1089:	c6 84 03 c0 29 00 00 	movb   $0x0,0x29c0(%ebx,%eax,1)
    1090:	00 
        deleteline(1);//然后删除下一行，
    1091:	e8 8a fd ff ff       	call   e20 <deleteline>
        showText();//最后，重新显示文本
    1096:	83 c4 10             	add    $0x10,%esp
        c = textbuf[textX][i];
        setconsole(coor(cursorX, i), c, GRAY, -1, 2);    
    }
    setconsole(coor(cursorX, i), 0, GRAY, -1, 2);
    moveCursor(0, -1);//光标向左移动一个单位
}
    1099:	8d 65 f4             	lea    -0xc(%ebp),%esp
    109c:	5b                   	pop    %ebx
    109d:	5e                   	pop    %esi
    109e:	5f                   	pop    %edi
    109f:	5d                   	pop    %ebp
        moveCursor(-1, 10000);//首先将光标移动到上一行的末尾
        for (i = 0, j = l1; i < l2 && j < MAX_LENGTH; ++i, ++j)//将下一行的内容复制到上一行
            textbuf[textX - 1][j] = textbuf[textX][i];//Note:此处的复制策略比较简单粗暴，存在着一个潜在的bug，当下一行较长时，可能会丢失后半段的字符
        textbuf[textX - 1][j] = 0;
        deleteline(1);//然后删除下一行，
        showText();//最后，重新显示文本
    10a0:	e9 db f7 ff ff       	jmp    880 <showText>
    10a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010b0 <insert>:
    moveCursor(0, -1);//光标向左移动一个单位
}

void
insert(char c)//插入一个字符
{
    10b0:	55                   	push   %ebp
    10b1:	89 e5                	mov    %esp,%ebp
    10b3:	57                   	push   %edi
    10b4:	56                   	push   %esi
    10b5:	53                   	push   %ebx
    10b6:	83 ec 28             	sub    $0x28,%esp
    int i, l, textX = cursorX + startline, textY = cursorY + left;
    10b9:	8b 3d 8c 28 00 00    	mov    0x288c,%edi
    10bf:	03 3d cc 28 00 00    	add    0x28cc,%edi
    moveCursor(0, -1);//光标向左移动一个单位
}

void
insert(char c)//插入一个字符
{
    10c5:	8b 45 08             	mov    0x8(%ebp),%eax
    int i, l, textX = cursorX + startline, textY = cursorY + left;
    l = strlen(textbuf[textX]);//当前行的长度
    10c8:	6b f7 64             	imul   $0x64,%edi,%esi
    moveCursor(0, -1);//光标向左移动一个单位
}

void
insert(char c)//插入一个字符
{
    10cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
    int i, l, textX = cursorX + startline, textY = cursorY + left;
    10ce:	89 7d dc             	mov    %edi,-0x24(%ebp)
    10d1:	a1 90 28 00 00       	mov    0x2890,%eax
    10d6:	03 05 a4 29 00 00    	add    0x29a4,%eax
    l = strlen(textbuf[textX]);//当前行的长度
    10dc:	8d be c0 29 00 00    	lea    0x29c0(%esi),%edi
    10e2:	57                   	push   %edi
}

void
insert(char c)//插入一个字符
{
    int i, l, textX = cursorX + startline, textY = cursorY + left;
    10e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    l = strlen(textbuf[textX]);//当前行的长度
    10e6:	e8 85 07 00 00       	call   1870 <strlen>
    10eb:	89 c3                	mov    %eax,%ebx
    if (mode == 1){//如果处于插入模式，
    10ed:	a1 84 28 00 00       	mov    0x2884,%eax
    10f2:	83 c4 10             	add    $0x10,%esp
    10f5:	83 f8 01             	cmp    $0x1,%eax
    10f8:	74 76                	je     1170 <insert+0xc0>
        for (i = textY; i < l + 1; ++i)//刷新修改的内容
            setconsole(coor(cursorX, i), textbuf[textX][i], GRAY, -1, 2);
        moveCursor(0, 1);//光标向右移动一个单位

    }
    if (mode == 0 || mode == 2){//如果处于控制或者替换模式
    10fa:	83 e0 fd             	and    $0xfffffffd,%eax
    10fd:	74 11                	je     1110 <insert+0x60>
        setconsole(coor(cursorX, cursorY), c, GRAY, -1, 2);//并刷新修改内容。
        if (textY == l)//如果替换的字符原先是‘0’，
            textbuf[textX][l + 1] = 0;//还需要在当前行末尾补一个‘0’
        moveCursor(0, 1);//光标向右移动一个单位
    }
}
    10ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1102:	5b                   	pop    %ebx
    1103:	5e                   	pop    %esi
    1104:	5f                   	pop    %edi
    1105:	5d                   	pop    %ebp
    1106:	c3                   	ret    
    1107:	89 f6                	mov    %esi,%esi
    1109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            setconsole(coor(cursorX, i), textbuf[textX][i], GRAY, -1, 2);
        moveCursor(0, 1);//光标向右移动一个单位

    }
    if (mode == 0 || mode == 2){//如果处于控制或者替换模式
        textbuf[textX][textY] = c;//直接将当前位置的字符替换
    1110:	6b 7d dc 64          	imul   $0x64,-0x24(%ebp),%edi
    1114:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1117:	8b 4d e0             	mov    -0x20(%ebp),%ecx
        setconsole(coor(cursorX, cursorY), c, GRAY, -1, 2);//并刷新修改内容。
    111a:	83 ec 0c             	sub    $0xc,%esp
            setconsole(coor(cursorX, i), textbuf[textX][i], GRAY, -1, 2);
        moveCursor(0, 1);//光标向右移动一个单位

    }
    if (mode == 0 || mode == 2){//如果处于控制或者替换模式
        textbuf[textX][textY] = c;//直接将当前位置的字符替换
    111d:	8d b4 38 c0 29 00 00 	lea    0x29c0(%eax,%edi,1),%esi
        setconsole(coor(cursorX, cursorY), c, GRAY, -1, 2);//并刷新修改内容。
    1124:	0f be c1             	movsbl %cl,%eax
            setconsole(coor(cursorX, i), textbuf[textX][i], GRAY, -1, 2);
        moveCursor(0, 1);//光标向右移动一个单位

    }
    if (mode == 0 || mode == 2){//如果处于控制或者替换模式
        textbuf[textX][textY] = c;//直接将当前位置的字符替换
    1127:	88 0e                	mov    %cl,(%esi)
        setconsole(coor(cursorX, cursorY), c, GRAY, -1, 2);//并刷新修改内容。
    1129:	6a 02                	push   $0x2
    112b:	6a ff                	push   $0xffffffff
    112d:	68 00 07 00 00       	push   $0x700
    1132:	50                   	push   %eax
    1133:	a1 cc 28 00 00       	mov    0x28cc,%eax
    1138:	8d 04 80             	lea    (%eax,%eax,4),%eax
    113b:	c1 e0 04             	shl    $0x4,%eax
    113e:	03 05 a4 29 00 00    	add    0x29a4,%eax
    1144:	50                   	push   %eax
    1145:	e8 88 09 00 00       	call   1ad2 <setconsole>
        if (textY == l)//如果替换的字符原先是‘0’，
    114a:	83 c4 20             	add    $0x20,%esp
    114d:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
    1150:	0f 84 bd 00 00 00    	je     1213 <insert+0x163>
            textbuf[textX][l + 1] = 0;//还需要在当前行末尾补一个‘0’
        moveCursor(0, 1);//光标向右移动一个单位
    1156:	83 ec 08             	sub    $0x8,%esp
    1159:	6a 01                	push   $0x1
    115b:	6a 00                	push   $0x0
    115d:	e8 be f9 ff ff       	call   b20 <moveCursor>
    1162:	83 c4 10             	add    $0x10,%esp
    }
}
    1165:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1168:	5b                   	pop    %ebx
    1169:	5e                   	pop    %esi
    116a:	5f                   	pop    %edi
    116b:	5d                   	pop    %ebp
    116c:	c3                   	ret    
    116d:	8d 76 00             	lea    0x0(%esi),%esi
insert(char c)//插入一个字符
{
    int i, l, textX = cursorX + startline, textY = cursorY + left;
    l = strlen(textbuf[textX]);//当前行的长度
    if (mode == 1){//如果处于插入模式，
        if (l >= MAX_LENGTH)//如果当前行超过了最长长度，则直接返回
    1170:	83 fb 4f             	cmp    $0x4f,%ebx
    1173:	7f 8a                	jg     10ff <insert+0x4f>
            return ;//Note：这样的实现较为简洁，但是不太合理，比较合理的实现方式应该是将字符插入到下一行？
        for (i = l; i > textY; --i)//将当前行textY以后的字符串向右平移一个单位
    1175:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    1178:	39 d9                	cmp    %ebx,%ecx
    117a:	0f 8d 9c 00 00 00    	jge    121c <insert+0x16c>
    1180:	8d 84 33 bf 29 00 00 	lea    0x29bf(%ebx,%esi,1),%eax
    1187:	8d 8c 31 bf 29 00 00 	lea    0x29bf(%ecx,%esi,1),%ecx
    118e:	66 90                	xchg   %ax,%ax
            textbuf[textX][i] = textbuf[textX][i - 1];
    1190:	0f b6 10             	movzbl (%eax),%edx
    1193:	83 e8 01             	sub    $0x1,%eax
    1196:	88 50 02             	mov    %dl,0x2(%eax)
    int i, l, textX = cursorX + startline, textY = cursorY + left;
    l = strlen(textbuf[textX]);//当前行的长度
    if (mode == 1){//如果处于插入模式，
        if (l >= MAX_LENGTH)//如果当前行超过了最长长度，则直接返回
            return ;//Note：这样的实现较为简洁，但是不太合理，比较合理的实现方式应该是将字符插入到下一行？
        for (i = l; i > textY; --i)//将当前行textY以后的字符串向右平移一个单位
    1199:	39 c8                	cmp    %ecx,%eax
    119b:	75 f3                	jne    1190 <insert+0xe0>
            textbuf[textX][i] = textbuf[textX][i - 1];
        textbuf[textX][l + 1] = 0;
    119d:	6b 45 dc 64          	imul   $0x64,-0x24(%ebp),%eax
        textbuf[textX][textY] = c;
    11a1:	0f b6 4d e0          	movzbl -0x20(%ebp),%ecx
    11a5:	8b 75 e4             	mov    -0x1c(%ebp),%esi
    if (mode == 1){//如果处于插入模式，
        if (l >= MAX_LENGTH)//如果当前行超过了最长长度，则直接返回
            return ;//Note：这样的实现较为简洁，但是不太合理，比较合理的实现方式应该是将字符插入到下一行？
        for (i = l; i > textY; --i)//将当前行textY以后的字符串向右平移一个单位
            textbuf[textX][i] = textbuf[textX][i - 1];
        textbuf[textX][l + 1] = 0;
    11a8:	c6 84 18 c1 29 00 00 	movb   $0x0,0x29c1(%eax,%ebx,1)
    11af:	00 
        textbuf[textX][textY] = c;
    11b0:	88 8c 30 c0 29 00 00 	mov    %cl,0x29c0(%eax,%esi,1)
    11b7:	6b 75 dc 64          	imul   $0x64,-0x24(%ebp),%esi
    moveCursor(0, -1);//光标向左移动一个单位
}

void
insert(char c)//插入一个字符
{
    11bb:	0f be 45 e0          	movsbl -0x20(%ebp),%eax
    int i, l, textX = cursorX + startline, textY = cursorY + left;
    11bf:	8b 7d e4             	mov    -0x1c(%ebp),%edi
    11c2:	eb 0c                	jmp    11d0 <insert+0x120>
    11c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11c8:	0f be 84 3e c0 29 00 	movsbl 0x29c0(%esi,%edi,1),%eax
    11cf:	00 
        for (i = l; i > textY; --i)//将当前行textY以后的字符串向右平移一个单位
            textbuf[textX][i] = textbuf[textX][i - 1];
        textbuf[textX][l + 1] = 0;
        textbuf[textX][textY] = c;
        for (i = textY; i < l + 1; ++i)//刷新修改的内容
            setconsole(coor(cursorX, i), textbuf[textX][i], GRAY, -1, 2);
    11d0:	83 ec 0c             	sub    $0xc,%esp
    11d3:	6a 02                	push   $0x2
    11d5:	6a ff                	push   $0xffffffff
    11d7:	68 00 07 00 00       	push   $0x700
    11dc:	50                   	push   %eax
    11dd:	a1 cc 28 00 00       	mov    0x28cc,%eax
    11e2:	8d 04 80             	lea    (%eax,%eax,4),%eax
    11e5:	c1 e0 04             	shl    $0x4,%eax
    11e8:	01 f8                	add    %edi,%eax
            return ;//Note：这样的实现较为简洁，但是不太合理，比较合理的实现方式应该是将字符插入到下一行？
        for (i = l; i > textY; --i)//将当前行textY以后的字符串向右平移一个单位
            textbuf[textX][i] = textbuf[textX][i - 1];
        textbuf[textX][l + 1] = 0;
        textbuf[textX][textY] = c;
        for (i = textY; i < l + 1; ++i)//刷新修改的内容
    11ea:	83 c7 01             	add    $0x1,%edi
            setconsole(coor(cursorX, i), textbuf[textX][i], GRAY, -1, 2);
    11ed:	50                   	push   %eax
    11ee:	e8 df 08 00 00       	call   1ad2 <setconsole>
            return ;//Note：这样的实现较为简洁，但是不太合理，比较合理的实现方式应该是将字符插入到下一行？
        for (i = l; i > textY; --i)//将当前行textY以后的字符串向右平移一个单位
            textbuf[textX][i] = textbuf[textX][i - 1];
        textbuf[textX][l + 1] = 0;
        textbuf[textX][textY] = c;
        for (i = textY; i < l + 1; ++i)//刷新修改的内容
    11f3:	83 c4 20             	add    $0x20,%esp
    11f6:	39 fb                	cmp    %edi,%ebx
    11f8:	7d ce                	jge    11c8 <insert+0x118>
            setconsole(coor(cursorX, i), textbuf[textX][i], GRAY, -1, 2);
        moveCursor(0, 1);//光标向右移动一个单位
    11fa:	83 ec 08             	sub    $0x8,%esp
    11fd:	6a 01                	push   $0x1
    11ff:	6a 00                	push   $0x0
    1201:	e8 1a f9 ff ff       	call   b20 <moveCursor>
    1206:	a1 84 28 00 00       	mov    0x2884,%eax
    120b:	83 c4 10             	add    $0x10,%esp
    120e:	e9 e7 fe ff ff       	jmp    10fa <insert+0x4a>
    }
    if (mode == 0 || mode == 2){//如果处于控制或者替换模式
        textbuf[textX][textY] = c;//直接将当前位置的字符替换
        setconsole(coor(cursorX, cursorY), c, GRAY, -1, 2);//并刷新修改内容。
        if (textY == l)//如果替换的字符原先是‘0’，
            textbuf[textX][l + 1] = 0;//还需要在当前行末尾补一个‘0’
    1213:	c6 46 01 00          	movb   $0x0,0x1(%esi)
    1217:	e9 3a ff ff ff       	jmp    1156 <insert+0xa6>
        if (l >= MAX_LENGTH)//如果当前行超过了最长长度，则直接返回
            return ;//Note：这样的实现较为简洁，但是不太合理，比较合理的实现方式应该是将字符插入到下一行？
        for (i = l; i > textY; --i)//将当前行textY以后的字符串向右平移一个单位
            textbuf[textX][i] = textbuf[textX][i - 1];
        textbuf[textX][l + 1] = 0;
        textbuf[textX][textY] = c;
    121c:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    121f:	0f b6 45 e0          	movzbl -0x20(%ebp),%eax
    if (mode == 1){//如果处于插入模式，
        if (l >= MAX_LENGTH)//如果当前行超过了最长长度，则直接返回
            return ;//Note：这样的实现较为简洁，但是不太合理，比较合理的实现方式应该是将字符插入到下一行？
        for (i = l; i > textY; --i)//将当前行textY以后的字符串向右平移一个单位
            textbuf[textX][i] = textbuf[textX][i - 1];
        textbuf[textX][l + 1] = 0;
    1223:	c6 44 1f 01 00       	movb   $0x0,0x1(%edi,%ebx,1)
        textbuf[textX][textY] = c;
        for (i = textY; i < l + 1; ++i)//刷新修改的内容
    1228:	39 d9                	cmp    %ebx,%ecx
        if (l >= MAX_LENGTH)//如果当前行超过了最长长度，则直接返回
            return ;//Note：这样的实现较为简洁，但是不太合理，比较合理的实现方式应该是将字符插入到下一行？
        for (i = l; i > textY; --i)//将当前行textY以后的字符串向右平移一个单位
            textbuf[textX][i] = textbuf[textX][i - 1];
        textbuf[textX][l + 1] = 0;
        textbuf[textX][textY] = c;
    122a:	88 04 0f             	mov    %al,(%edi,%ecx,1)
        for (i = textY; i < l + 1; ++i)//刷新修改的内容
    122d:	7f cb                	jg     11fa <insert+0x14a>
    122f:	eb 86                	jmp    11b7 <insert+0x107>
    1231:	eb 0d                	jmp    1240 <runTextInput>
    1233:	90                   	nop
    1234:	90                   	nop
    1235:	90                   	nop
    1236:	90                   	nop
    1237:	90                   	nop
    1238:	90                   	nop
    1239:	90                   	nop
    123a:	90                   	nop
    123b:	90                   	nop
    123c:	90                   	nop
    123d:	90                   	nop
    123e:	90                   	nop
    123f:	90                   	nop

00001240 <runTextInput>:
    }
}

void
runTextInput(char c)//对输入的字符进行处理
{
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
    1243:	57                   	push   %edi
    1244:	56                   	push   %esi
    1245:	53                   	push   %ebx
    1246:	83 ec 28             	sub    $0x28,%esp
    int i, j, textX = cursorX + startline, textY = cursorY + left;
    1249:	a1 8c 28 00 00       	mov    0x288c,%eax
    124e:	03 05 cc 28 00 00    	add    0x28cc,%eax
    }
}

void
runTextInput(char c)//对输入的字符进行处理
{
    1254:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int i, j, textX = cursorX + startline, textY = cursorY + left;
    1257:	8b 15 90 28 00 00    	mov    0x2890,%edx
    125d:	8b 3d a4 29 00 00    	mov    0x29a4,%edi
    int l = strlen(textbuf[textX]);
    1263:	6b f0 64             	imul   $0x64,%eax,%esi
}

void
runTextInput(char c)//对输入的字符进行处理
{
    int i, j, textX = cursorX + startline, textY = cursorY + left;
    1266:	89 45 e0             	mov    %eax,-0x20(%ebp)
    1269:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    int l = strlen(textbuf[textX]);
    126c:	8d 86 c0 29 00 00    	lea    0x29c0(%esi),%eax
    1272:	50                   	push   %eax
    1273:	e8 f8 05 00 00       	call   1870 <strlen>
    switch(c){
    1278:	83 c4 10             	add    $0x10,%esp
    127b:	80 fb 09             	cmp    $0x9,%bl
    127e:	74 20                	je     12a0 <runTextInput+0x60>
    1280:	80 fb 0a             	cmp    $0xa,%bl
    1283:	74 4b                	je     12d0 <runTextInput+0x90>
    1285:	80 fb 08             	cmp    $0x8,%bl
    1288:	74 34                	je     12be <runTextInput+0x7e>
            do{//移动到cursorY为8的倍数的位置
                insert(' ');
            }while((cursorY % 8) != 0);
            break;
        default://其余情况
            insert(c);//直接插入字符
    128a:	0f be d3             	movsbl %bl,%edx
    128d:	89 55 08             	mov    %edx,0x8(%ebp)
            break;
    }
}
    1290:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1293:	5b                   	pop    %ebx
    1294:	5e                   	pop    %esi
    1295:	5f                   	pop    %edi
    1296:	5d                   	pop    %ebp
            do{//移动到cursorY为8的倍数的位置
                insert(' ');
            }while((cursorY % 8) != 0);
            break;
        default://其余情况
            insert(c);//直接插入字符
    1297:	e9 14 fe ff ff       	jmp    10b0 <insert>
    129c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        case BACKSPACE: // 输入Backspace时
            delete();//则删除一个字符
            break;
        case HORIZONTAL_TAB:
            do{//移动到cursorY为8的倍数的位置
                insert(' ');
    12a0:	83 ec 0c             	sub    $0xc,%esp
    12a3:	6a 20                	push   $0x20
    12a5:	e8 06 fe ff ff       	call   10b0 <insert>
            }while((cursorY % 8) != 0);
    12aa:	83 c4 10             	add    $0x10,%esp
    12ad:	f6 05 a4 29 00 00 07 	testb  $0x7,0x29a4
    12b4:	75 ea                	jne    12a0 <runTextInput+0x60>
            break;
        default://其余情况
            insert(c);//直接插入字符
            break;
    }
}
    12b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12b9:	5b                   	pop    %ebx
    12ba:	5e                   	pop    %esi
    12bb:	5f                   	pop    %edi
    12bc:	5d                   	pop    %ebp
    12bd:	c3                   	ret    
    12be:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12c1:	5b                   	pop    %ebx
    12c2:	5e                   	pop    %esi
    12c3:	5f                   	pop    %edi
    12c4:	5d                   	pop    %ebp
                setconsole(coor(cursorX, cursorY + j), 0, GRAY, -1, 2);
            }
            moveCursor(1, -10000);//将光标移动到下一行的开头
            break;
        case BACKSPACE: // 输入Backspace时
            delete();//则删除一个字符
    12c5:	e9 46 fc ff ff       	jmp    f10 <delete>
    12ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

void
runTextInput(char c)//对输入的字符进行处理
{
    int i, j, textX = cursorX + startline, textY = cursorY + left;
    12d0:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    12d3:	89 45 dc             	mov    %eax,-0x24(%ebp)
    int l = strlen(textbuf[textX]);
    switch(c){
        case NEW_LINE: // 输入Enter时，
            insertline();//首先在当前位置的下一行插入新的一行
    12d6:	e8 55 fa ff ff       	call   d30 <insertline>
            for (i = textY, j = 0; i < l; ++i, ++j){//将当前textY右边的字符串移动到下一行
    12db:	8b 45 dc             	mov    -0x24(%ebp),%eax
}

void
runTextInput(char c)//对输入的字符进行处理
{
    int i, j, textX = cursorX + startline, textY = cursorY + left;
    12de:	01 fb                	add    %edi,%ebx
    int l = strlen(textbuf[textX]);
    switch(c){
        case NEW_LINE: // 输入Enter时，
            insertline();//首先在当前位置的下一行插入新的一行
            for (i = textY, j = 0; i < l; ++i, ++j){//将当前textY右边的字符串移动到下一行
    12e0:	39 c3                	cmp    %eax,%ebx
    12e2:	0f 8d 8c 00 00 00    	jge    1374 <runTextInput+0x134>
    12e8:	29 d8                	sub    %ebx,%eax
    12ea:	8d 3c 1e             	lea    (%esi,%ebx,1),%edi
    12ed:	8b 5d e0             	mov    -0x20(%ebp),%ebx
    12f0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    12f3:	83 c3 01             	add    $0x1,%ebx
    12f6:	6b f3 64             	imul   $0x64,%ebx,%esi
    12f9:	31 db                	xor    %ebx,%ebx
    12fb:	90                   	nop
    12fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                textbuf[textX + 1][j] = textbuf[textX][i];
    1300:	0f b6 84 1f c0 29 00 	movzbl 0x29c0(%edi,%ebx,1),%eax
    1307:	00 
                setconsole(coor(cursorX + 1, j), textbuf[textX][i], GRAY, -1, 2);
    1308:	83 ec 0c             	sub    $0xc,%esp
    130b:	6a 02                	push   $0x2
    130d:	6a ff                	push   $0xffffffff
    130f:	68 00 07 00 00       	push   $0x700
    int l = strlen(textbuf[textX]);
    switch(c){
        case NEW_LINE: // 输入Enter时，
            insertline();//首先在当前位置的下一行插入新的一行
            for (i = textY, j = 0; i < l; ++i, ++j){//将当前textY右边的字符串移动到下一行
                textbuf[textX + 1][j] = textbuf[textX][i];
    1314:	88 84 1e c0 29 00 00 	mov    %al,0x29c0(%esi,%ebx,1)
                setconsole(coor(cursorX + 1, j), textbuf[textX][i], GRAY, -1, 2);
    131b:	0f be 84 1f c0 29 00 	movsbl 0x29c0(%edi,%ebx,1),%eax
    1322:	00 
    1323:	50                   	push   %eax
    1324:	a1 cc 28 00 00       	mov    0x28cc,%eax
    1329:	8d 44 80 05          	lea    0x5(%eax,%eax,4),%eax
    132d:	c1 e0 04             	shl    $0x4,%eax
    1330:	01 d8                	add    %ebx,%eax
    1332:	50                   	push   %eax
    1333:	e8 9a 07 00 00       	call   1ad2 <setconsole>
                textbuf[textX][i] = 0;
                setconsole(coor(cursorX, cursorY + j), 0, GRAY, -1, 2);
    1338:	a1 cc 28 00 00       	mov    0x28cc,%eax
    133d:	8b 0d a4 29 00 00    	mov    0x29a4,%ecx
    1343:	83 c4 14             	add    $0x14,%esp
    1346:	6a 02                	push   $0x2
    1348:	6a ff                	push   $0xffffffff
    134a:	68 00 07 00 00       	push   $0x700
    134f:	6a 00                	push   $0x0
    1351:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1354:	01 d9                	add    %ebx,%ecx
        case NEW_LINE: // 输入Enter时，
            insertline();//首先在当前位置的下一行插入新的一行
            for (i = textY, j = 0; i < l; ++i, ++j){//将当前textY右边的字符串移动到下一行
                textbuf[textX + 1][j] = textbuf[textX][i];
                setconsole(coor(cursorX + 1, j), textbuf[textX][i], GRAY, -1, 2);
                textbuf[textX][i] = 0;
    1356:	c6 84 1f c0 29 00 00 	movb   $0x0,0x29c0(%edi,%ebx,1)
    135d:	00 
    int i, j, textX = cursorX + startline, textY = cursorY + left;
    int l = strlen(textbuf[textX]);
    switch(c){
        case NEW_LINE: // 输入Enter时，
            insertline();//首先在当前位置的下一行插入新的一行
            for (i = textY, j = 0; i < l; ++i, ++j){//将当前textY右边的字符串移动到下一行
    135e:	83 c3 01             	add    $0x1,%ebx
                textbuf[textX + 1][j] = textbuf[textX][i];
                setconsole(coor(cursorX + 1, j), textbuf[textX][i], GRAY, -1, 2);
                textbuf[textX][i] = 0;
                setconsole(coor(cursorX, cursorY + j), 0, GRAY, -1, 2);
    1361:	c1 e0 04             	shl    $0x4,%eax
    1364:	01 c8                	add    %ecx,%eax
    1366:	50                   	push   %eax
    1367:	e8 66 07 00 00       	call   1ad2 <setconsole>
    int i, j, textX = cursorX + startline, textY = cursorY + left;
    int l = strlen(textbuf[textX]);
    switch(c){
        case NEW_LINE: // 输入Enter时，
            insertline();//首先在当前位置的下一行插入新的一行
            for (i = textY, j = 0; i < l; ++i, ++j){//将当前textY右边的字符串移动到下一行
    136c:	83 c4 20             	add    $0x20,%esp
    136f:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
    1372:	75 8c                	jne    1300 <runTextInput+0xc0>
                textbuf[textX + 1][j] = textbuf[textX][i];
                setconsole(coor(cursorX + 1, j), textbuf[textX][i], GRAY, -1, 2);
                textbuf[textX][i] = 0;
                setconsole(coor(cursorX, cursorY + j), 0, GRAY, -1, 2);
            }
            moveCursor(1, -10000);//将光标移动到下一行的开头
    1374:	83 ec 08             	sub    $0x8,%esp
    1377:	68 f0 d8 ff ff       	push   $0xffffd8f0
    137c:	6a 01                	push   $0x1
    137e:	e8 9d f7 ff ff       	call   b20 <moveCursor>
            break;
    1383:	83 c4 10             	add    $0x10,%esp
            break;
        default://其余情况
            insert(c);//直接插入字符
            break;
    }
}
    1386:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1389:	5b                   	pop    %ebx
    138a:	5e                   	pop    %esi
    138b:	5f                   	pop    %edi
    138c:	5d                   	pop    %ebp
    138d:	c3                   	ret    
    138e:	66 90                	xchg   %ax,%ax

00001390 <runCommand>:
:q! quit without save
*/
void
runCommand()
{
    if (controlbuf[0] != ':')
    1390:	80 3d 60 29 00 00 3a 	cmpb   $0x3a,0x2960
:wq save & quit
:q! quit without save
*/
void
runCommand()
{
    1397:	55                   	push   %ebp
    1398:	89 e5                	mov    %esp,%ebp
    if (controlbuf[0] != ':')
    139a:	74 04                	je     13a0 <runCommand+0x10>
            else//否则
                quit();//可以退出
        }
    }
    showMessage("Invalid command");//其余情况，则显示命令非负
}
    139c:	5d                   	pop    %ebp
    139d:	c3                   	ret    
    139e:	66 90                	xchg   %ax,%ax
    13a0:	5d                   	pop    %ebp
    13a1:	e9 6a f2 ff ff       	jmp    610 <runCommand.part.0>
    13a6:	8d 76 00             	lea    0x0(%esi),%esi
    13a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000013b0 <clearControl>:

void
clearControl()//清除命令缓冲区
{
    13b0:	55                   	push   %ebp
    controlp = 0;
    13b1:	c7 05 80 28 00 00 00 	movl   $0x0,0x2880
    13b8:	00 00 00 
    controlbuf[0] = 0;
    13bb:	c6 05 60 29 00 00 00 	movb   $0x0,0x2960
    showMessage("Invalid command");//其余情况，则显示命令非负
}

void
clearControl()//清除命令缓冲区
{
    13c2:	89 e5                	mov    %esp,%ebp
    controlp = 0;
    controlbuf[0] = 0;
}
    13c4:	5d                   	pop    %ebp
    13c5:	c3                   	ret    
    13c6:	8d 76 00             	lea    0x0(%esi),%esi
    13c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000013d0 <runControl>:

void
runControl()
{
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    13d3:	83 ec 08             	sub    $0x8,%esp
    switch (controlbuf[0]){
    13d6:	0f b6 05 60 29 00 00 	movzbl 0x2960,%eax
    13dd:	83 e8 3a             	sub    $0x3a,%eax
    13e0:	3c 3e                	cmp    $0x3e,%al
    13e2:	77 3c                	ja     1420 <runControl+0x50>
    13e4:	0f b6 c0             	movzbl %al,%eax
    13e7:	ff 24 85 74 1f 00 00 	jmp    *0x1f74(,%eax,4)
    13ee:	66 90                	xchg   %ax,%ax
            moveCursor(0, 1);
            showMessage("-- INSERT --");
            break;
        case 'A'://在行尾开始插入字符
            mode = 1;
            moveCursor(0, 10000);
    13f0:	83 ec 08             	sub    $0x8,%esp
            mode = 1;
            moveCursor(0, 1);
            showMessage("-- INSERT --");
            break;
        case 'A'://在行尾开始插入字符
            mode = 1;
    13f3:	c7 05 84 28 00 00 01 	movl   $0x1,0x2884
    13fa:	00 00 00 
            moveCursor(0, 10000);
    13fd:	68 10 27 00 00       	push   $0x2710
    1402:	6a 00                	push   $0x0
    1404:	e8 17 f7 ff ff       	call   b20 <moveCursor>
            showMessage("-- INSERT --");
    1409:	c7 04 24 cb 1e 00 00 	movl   $0x1ecb,(%esp)
    1410:	e8 5b f1 ff ff       	call   570 <showMessage>
            break;
    1415:	83 c4 10             	add    $0x10,%esp
    1418:	90                   	nop
    1419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

void
clearControl()//清除命令缓冲区
{
    controlp = 0;
    1420:	c7 05 80 28 00 00 00 	movl   $0x0,0x2880
    1427:	00 00 00 
    controlbuf[0] = 0;
    142a:	c6 05 60 29 00 00 00 	movb   $0x0,0x2960
        default:
            clearControl();
            break;
    }
    clearControl();
}
    1431:	c9                   	leave  
    1432:	c3                   	ret    
    1433:	90                   	nop
    1434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        case 'R'://进入替换模式
            mode = 2;
            showMessage("-- REPLACE --");
            break;
        case 'x'://删除光标出的字符
            moveCursor(0, 1);
    1438:	83 ec 08             	sub    $0x8,%esp
    143b:	6a 01                	push   $0x1
    143d:	6a 00                	push   $0x0
    143f:	e8 dc f6 ff ff       	call   b20 <moveCursor>
            delete();
    1444:	e8 c7 fa ff ff       	call   f10 <delete>
            saved = 0;
    1449:	c7 05 64 28 00 00 00 	movl   $0x0,0x2864
    1450:	00 00 00 
            break;
    1453:	83 c4 10             	add    $0x10,%esp
    1456:	eb c8                	jmp    1420 <runControl+0x50>
    1458:	90                   	nop
    1459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            moveCursor(0, -10000);
            showMessage("1 line deleted");
            saved = 0;
            break;
        case ':'://当输入':'时，
            showMessage(controlbuf);//需要显示控制缓冲区内容
    1460:	83 ec 0c             	sub    $0xc,%esp
    1463:	68 60 29 00 00       	push   $0x2960
    1468:	e8 03 f1 ff ff       	call   570 <showMessage>
            return ;
    146d:	83 c4 10             	add    $0x10,%esp
        default:
            clearControl();
            break;
    }
    clearControl();
}
    1470:	c9                   	leave  
    1471:	c3                   	ret    
    1472:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            if (controlbuf[1] != 0)
                break;
            return ;
        case 'R'://进入替换模式
            mode = 2;
            showMessage("-- REPLACE --");
    1478:	83 ec 0c             	sub    $0xc,%esp
            }
            if (controlbuf[1] != 0)
                break;
            return ;
        case 'R'://进入替换模式
            mode = 2;
    147b:	c7 05 84 28 00 00 02 	movl   $0x2,0x2884
    1482:	00 00 00 
            showMessage("-- REPLACE --");
    1485:	68 d8 1e 00 00       	push   $0x1ed8
    148a:	e8 e1 f0 ff ff       	call   570 <showMessage>
            break;
    148f:	83 c4 10             	add    $0x10,%esp
    1492:	eb 8c                	jmp    1420 <runControl+0x50>
    1494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            moveCursor(1, 0);
            showMessage("-- INSERT --");
            break;
        case 'a'://在当前光标下一个位置开始插入插入字符
            mode = 1;
            moveCursor(0, 1);
    1498:	83 ec 08             	sub    $0x8,%esp
            insertline();
            moveCursor(1, 0);
            showMessage("-- INSERT --");
            break;
        case 'a'://在当前光标下一个位置开始插入插入字符
            mode = 1;
    149b:	c7 05 84 28 00 00 01 	movl   $0x1,0x2884
    14a2:	00 00 00 
            moveCursor(0, 1);
    14a5:	6a 01                	push   $0x1
    14a7:	e9 56 ff ff ff       	jmp    1402 <runControl+0x32>
    14ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                moveCursor(1, -10000);
            else
                moveCursor(0, 1);
            break;
        case 'd'://删除光标所在行
            deleteline(0);
    14b0:	83 ec 0c             	sub    $0xc,%esp
    14b3:	6a 00                	push   $0x0
    14b5:	e8 66 f9 ff ff       	call   e20 <deleteline>
            moveCursor(0, -10000);
    14ba:	59                   	pop    %ecx
    14bb:	58                   	pop    %eax
    14bc:	68 f0 d8 ff ff       	push   $0xffffd8f0
    14c1:	6a 00                	push   $0x0
    14c3:	e8 58 f6 ff ff       	call   b20 <moveCursor>
            showMessage("1 line deleted");
    14c8:	c7 04 24 e6 1e 00 00 	movl   $0x1ee6,(%esp)
    14cf:	e8 9c f0 ff ff       	call   570 <showMessage>
            saved = 0;
    14d4:	c7 05 64 28 00 00 00 	movl   $0x0,0x2864
    14db:	00 00 00 
            break;
    14de:	83 c4 10             	add    $0x10,%esp
    14e1:	e9 3a ff ff ff       	jmp    1420 <runControl+0x50>
    14e6:	8d 76 00             	lea    0x0(%esi),%esi
    14e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            moveCursor(0, 1);
            delete();
            saved = 0;
            break;
        case 'h'://光标向左移动一个字符
            if (cursorY == 0)
    14f0:	a1 a4 29 00 00       	mov    0x29a4,%eax
    14f5:	85 c0                	test   %eax,%eax
    14f7:	0f 85 43 01 00 00    	jne    1640 <runControl+0x270>
                moveCursor(-1, 10000);
    14fd:	83 ec 08             	sub    $0x8,%esp
    1500:	68 10 27 00 00       	push   $0x2710
    1505:	6a ff                	push   $0xffffffff
    1507:	e8 14 f6 ff ff       	call   b20 <moveCursor>
    150c:	83 c4 10             	add    $0x10,%esp
    150f:	e9 0c ff ff ff       	jmp    1420 <runControl+0x50>
    1514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
runControl()
{
    switch (controlbuf[0]){
        case 'i'://在当前光标处开始插入字符
            mode = 1;
            showMessage("-- INSERT --");
    1518:	83 ec 0c             	sub    $0xc,%esp
void
runControl()
{
    switch (controlbuf[0]){
        case 'i'://在当前光标处开始插入字符
            mode = 1;
    151b:	c7 05 84 28 00 00 01 	movl   $0x1,0x2884
    1522:	00 00 00 
            showMessage("-- INSERT --");
    1525:	68 cb 1e 00 00       	push   $0x1ecb
    152a:	e8 41 f0 ff ff       	call   570 <showMessage>
            break;
    152f:	83 c4 10             	add    $0x10,%esp
    1532:	e9 e9 fe ff ff       	jmp    1420 <runControl+0x50>
    1537:	89 f6                	mov    %esi,%esi
    1539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                moveCursor(-1, 10000);
            else
                moveCursor(0, -1);
            break;
        case 'j'://光标向下移动一个字符
            moveCursor(1, 0);
    1540:	83 ec 08             	sub    $0x8,%esp
    1543:	6a 00                	push   $0x0
    1545:	6a 01                	push   $0x1
    1547:	e8 d4 f5 ff ff       	call   b20 <moveCursor>
            break;
    154c:	83 c4 10             	add    $0x10,%esp
    154f:	e9 cc fe ff ff       	jmp    1420 <runControl+0x50>
    1554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        case 'k'://光标向上移动一个字符
            moveCursor(-1, 0);
    1558:	83 ec 08             	sub    $0x8,%esp
    155b:	6a 00                	push   $0x0
    155d:	6a ff                	push   $0xffffffff
    155f:	e8 bc f5 ff ff       	call   b20 <moveCursor>
            break;
    1564:	83 c4 10             	add    $0x10,%esp
    1567:	e9 b4 fe ff ff       	jmp    1420 <runControl+0x50>
    156c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        case 'l'://向右移动一个字符
            if (cursorY >= strlen(textbuf[cursorX + startline]) && cursorX + startline != num_line - 1)
    1570:	a1 8c 28 00 00       	mov    0x288c,%eax
    1575:	03 05 cc 28 00 00    	add    0x28cc,%eax
    157b:	83 ec 0c             	sub    $0xc,%esp
    157e:	6b c0 64             	imul   $0x64,%eax,%eax
    1581:	05 c0 29 00 00       	add    $0x29c0,%eax
    1586:	50                   	push   %eax
    1587:	e8 e4 02 00 00       	call   1870 <strlen>
    158c:	83 c4 10             	add    $0x10,%esp
    158f:	3b 05 a4 29 00 00    	cmp    0x29a4,%eax
    1595:	0f 87 bd 00 00 00    	ja     1658 <runControl+0x288>
    159b:	8b 15 8c 28 00 00    	mov    0x288c,%edx
    15a1:	a1 88 28 00 00       	mov    0x2888,%eax
    15a6:	03 15 cc 28 00 00    	add    0x28cc,%edx
    15ac:	83 e8 01             	sub    $0x1,%eax
    15af:	39 c2                	cmp    %eax,%edx
    15b1:	0f 84 a1 00 00 00    	je     1658 <runControl+0x288>
                moveCursor(1, -10000);
    15b7:	83 ec 08             	sub    $0x8,%esp
    15ba:	68 f0 d8 ff ff       	push   $0xffffd8f0
    15bf:	6a 01                	push   $0x1
    15c1:	e8 5a f5 ff ff       	call   b20 <moveCursor>
    15c6:	83 c4 10             	add    $0x10,%esp
    15c9:	e9 52 fe ff ff       	jmp    1420 <runControl+0x50>
    15ce:	66 90                	xchg   %ax,%ax
        case 'i'://在当前光标处开始插入字符
            mode = 1;
            showMessage("-- INSERT --");
            break;
        case 'o'://新建一行并开始插入字符
            mode = 1;
    15d0:	c7 05 84 28 00 00 01 	movl   $0x1,0x2884
    15d7:	00 00 00 
            insertline();
    15da:	e8 51 f7 ff ff       	call   d30 <insertline>
            moveCursor(1, 0);
    15df:	83 ec 08             	sub    $0x8,%esp
    15e2:	6a 00                	push   $0x0
    15e4:	6a 01                	push   $0x1
    15e6:	e8 35 f5 ff ff       	call   b20 <moveCursor>
            showMessage("-- INSERT --");
    15eb:	c7 04 24 cb 1e 00 00 	movl   $0x1ecb,(%esp)
    15f2:	e8 79 ef ff ff       	call   570 <showMessage>
            break;
    15f7:	83 c4 10             	add    $0x10,%esp
    15fa:	e9 21 fe ff ff       	jmp    1420 <runControl+0x50>
    15ff:	90                   	nop
            mode = 1;
            moveCursor(0, 10000);
            showMessage("-- INSERT --");
            break;
        case 'r'://输入"ra"时
            if (isTextChar(controlbuf[1])){//若a是一个显示字符
    1600:	0f be 05 61 29 00 00 	movsbl 0x2961,%eax
}

int 
isTextChar(char c)//判断是否为可显示字符
{
    if (c >= ' ' && c <= '~')
    1607:	8d 50 e0             	lea    -0x20(%eax),%edx
    160a:	80 fa 5e             	cmp    $0x5e,%dl
    160d:	77 21                	ja     1630 <runControl+0x260>
            moveCursor(0, 10000);
            showMessage("-- INSERT --");
            break;
        case 'r'://输入"ra"时
            if (isTextChar(controlbuf[1])){//若a是一个显示字符
                insert(controlbuf[1]);//将其插入光标所在位置
    160f:	83 ec 0c             	sub    $0xc,%esp
    1612:	50                   	push   %eax
    1613:	e8 98 fa ff ff       	call   10b0 <insert>
                moveCursor(0, -1);//光标重新移到a左边的位置
    1618:	58                   	pop    %eax
    1619:	5a                   	pop    %edx
    161a:	6a ff                	push   $0xffffffff
    161c:	6a 00                	push   $0x0
    161e:	e8 fd f4 ff ff       	call   b20 <moveCursor>
                break;
    1623:	83 c4 10             	add    $0x10,%esp
    1626:	e9 f5 fd ff ff       	jmp    1420 <runControl+0x50>
    162b:	90                   	nop
    162c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            }
            if (controlbuf[1] != 0)
    1630:	84 c0                	test   %al,%al
    1632:	0f 85 e8 fd ff ff    	jne    1420 <runControl+0x50>
    1638:	e9 f4 fd ff ff       	jmp    1431 <runControl+0x61>
    163d:	8d 76 00             	lea    0x0(%esi),%esi
            break;
        case 'h'://光标向左移动一个字符
            if (cursorY == 0)
                moveCursor(-1, 10000);
            else
                moveCursor(0, -1);
    1640:	83 ec 08             	sub    $0x8,%esp
    1643:	6a ff                	push   $0xffffffff
    1645:	6a 00                	push   $0x0
    1647:	e8 d4 f4 ff ff       	call   b20 <moveCursor>
    164c:	83 c4 10             	add    $0x10,%esp
    164f:	e9 cc fd ff ff       	jmp    1420 <runControl+0x50>
    1654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            break;
        case 'l'://向右移动一个字符
            if (cursorY >= strlen(textbuf[cursorX + startline]) && cursorX + startline != num_line - 1)
                moveCursor(1, -10000);
            else
                moveCursor(0, 1);
    1658:	83 ec 08             	sub    $0x8,%esp
    165b:	6a 01                	push   $0x1
    165d:	6a 00                	push   $0x0
    165f:	e8 bc f4 ff ff       	call   b20 <moveCursor>
    1664:	83 c4 10             	add    $0x10,%esp
    1667:	e9 b4 fd ff ff       	jmp    1420 <runControl+0x50>
    166c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001670 <parseInput>:
    clearControl();
}

void
parseInput(char c)//综合上述各个处理函数对输入字符c进行处理
{
    1670:	55                   	push   %ebp
    1671:	89 e5                	mov    %esp,%ebp
    1673:	57                   	push   %edi
    1674:	56                   	push   %esi
    1675:	53                   	push   %ebx
    1676:	83 ec 0c             	sub    $0xc,%esp
    1679:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (c == KEY_ESC){//如果输入的是ESC
    167c:	80 fb 1b             	cmp    $0x1b,%bl
    167f:	0f 84 fb 00 00 00    	je     1780 <parseInput+0x110>
        mode = 0;//则进入控制模式
        clearControl();
        showMessage("");
        return ;
    }
    if (runCursorCtrl(c) != 0){//首先判断是否为光标的移动键
    1685:	83 ec 0c             	sub    $0xc,%esp
    1688:	0f be f3             	movsbl %bl,%esi
    168b:	56                   	push   %esi
    168c:	e8 8f f5 ff ff       	call   c20 <runCursorCtrl>
    1691:	83 c4 10             	add    $0x10,%esp
    1694:	85 c0                	test   %eax,%eax
    1696:	0f 85 a4 00 00 00    	jne    1740 <parseInput+0xd0>
}

int 
isTextChar(char c)//判断是否为可显示字符
{
    if (c >= ' ' && c <= '~')
    169c:	8d 43 e0             	lea    -0x20(%ebx),%eax
    169f:	3c 5e                	cmp    $0x5e,%al
    16a1:	76 1b                	jbe    16be <parseInput+0x4e>
    16a3:	80 fb 0d             	cmp    $0xd,%bl
    16a6:	0f 87 a5 00 00 00    	ja     1751 <parseInput+0xe1>
    16ac:	b8 01 00 00 00       	mov    $0x1,%eax
    16b1:	89 d9                	mov    %ebx,%ecx
    16b3:	d3 e0                	shl    %cl,%eax
    16b5:	f6 c4 27             	test   $0x27,%ah
    16b8:	0f 84 93 00 00 00    	je     1751 <parseInput+0xe1>
        clearControl();
        return ;
    }
    if (!isTextChar(c) && !isControlChar(c))
        return ;//确保字符c是一个显示字符或者控制字符中的一种
    if (mode == 0){//当前处于控制模式
    16be:	8b 3d 84 28 00 00    	mov    0x2884,%edi
    16c4:	85 ff                	test   %edi,%edi
    16c6:	0f 85 94 00 00 00    	jne    1760 <parseInput+0xf0>
        showMessage("");
    16cc:	83 ec 0c             	sub    $0xc,%esp
    16cf:	68 25 1f 00 00       	push   $0x1f25
    16d4:	e8 97 ee ff ff       	call   570 <showMessage>
        if (controlp >= 60)//控制字符串的长度不能超过60
    16d9:	a1 80 28 00 00       	mov    0x2880,%eax
    16de:	83 c4 10             	add    $0x10,%esp
    16e1:	83 f8 3b             	cmp    $0x3b,%eax
    16e4:	7f 6b                	jg     1751 <parseInput+0xe1>
            return ;
        if (c == ':'){//每当输入“：”时，
    16e6:	80 fb 3a             	cmp    $0x3a,%bl
    16e9:	0f 84 d1 00 00 00    	je     17c0 <parseInput+0x150>
            clearControl();//都需要清空控制字符串
        }
        if (c == NEW_LINE){//当输入换行键时
    16ef:	80 fb 0a             	cmp    $0xa,%bl
    16f2:	74 34                	je     1728 <parseInput+0xb8>
            runCommand();//运行保存/退出等命令
            clearControl();//清空控制字符串
            return ;
        }
        if (c == BACKSPACE)//当输入退格键时
    16f4:	80 fb 08             	cmp    $0x8,%bl
    16f7:	8d 50 01             	lea    0x1(%eax),%edx
    16fa:	89 c7                	mov    %eax,%edi
    16fc:	0f 84 ae 00 00 00    	je     17b0 <parseInput+0x140>
            controlp--;//光标向左移
        else//其余情况
            controlbuf[controlp++] = c;//输入字符c
    1702:	89 15 80 28 00 00    	mov    %edx,0x2880
    1708:	88 9f 60 29 00 00    	mov    %bl,0x2960(%edi)
        controlbuf[controlp] = 0;
    170e:	c6 82 60 29 00 00 00 	movb   $0x0,0x2960(%edx)
    }
    else{//如果处于非控制模式
        saved = 0;//只要输入字符，当前文件就尚未保存
        runTextInput(c);//并按照文本内容处理字符c
    }
}
    1715:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1718:	5b                   	pop    %ebx
    1719:	5e                   	pop    %esi
    171a:	5f                   	pop    %edi
    171b:	5d                   	pop    %ebp
        if (c == BACKSPACE)//当输入退格键时
            controlp--;//光标向左移
        else//其余情况
            controlbuf[controlp++] = c;//输入字符c
        controlbuf[controlp] = 0;
        runControl();//并且尝试执行控制命令
    171c:	e9 af fc ff ff       	jmp    13d0 <runControl>
    1721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
:q! quit without save
*/
void
runCommand()
{
    if (controlbuf[0] != ':')
    1728:	80 3d 60 29 00 00 3a 	cmpb   $0x3a,0x2960
    172f:	75 0f                	jne    1740 <parseInput+0xd0>
    1731:	e8 da ee ff ff       	call   610 <runCommand.part.0>
    1736:	8d 76 00             	lea    0x0(%esi),%esi
    1739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

void
clearControl()//清除命令缓冲区
{
    controlp = 0;
    1740:	c7 05 80 28 00 00 00 	movl   $0x0,0x2880
    1747:	00 00 00 
    controlbuf[0] = 0;
    174a:	c6 05 60 29 00 00 00 	movb   $0x0,0x2960
    }
    else{//如果处于非控制模式
        saved = 0;//只要输入字符，当前文件就尚未保存
        runTextInput(c);//并按照文本内容处理字符c
    }
}
    1751:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1754:	5b                   	pop    %ebx
    1755:	5e                   	pop    %esi
    1756:	5f                   	pop    %edi
    1757:	5d                   	pop    %ebp
    1758:	c3                   	ret    
    1759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        controlbuf[controlp] = 0;
        runControl();//并且尝试执行控制命令
    }
    else{//如果处于非控制模式
        saved = 0;//只要输入字符，当前文件就尚未保存
        runTextInput(c);//并按照文本内容处理字符c
    1760:	89 75 08             	mov    %esi,0x8(%ebp)
            controlbuf[controlp++] = c;//输入字符c
        controlbuf[controlp] = 0;
        runControl();//并且尝试执行控制命令
    }
    else{//如果处于非控制模式
        saved = 0;//只要输入字符，当前文件就尚未保存
    1763:	c7 05 64 28 00 00 00 	movl   $0x0,0x2864
    176a:	00 00 00 
        runTextInput(c);//并按照文本内容处理字符c
    }
}
    176d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1770:	5b                   	pop    %ebx
    1771:	5e                   	pop    %esi
    1772:	5f                   	pop    %edi
    1773:	5d                   	pop    %ebp
        controlbuf[controlp] = 0;
        runControl();//并且尝试执行控制命令
    }
    else{//如果处于非控制模式
        saved = 0;//只要输入字符，当前文件就尚未保存
        runTextInput(c);//并按照文本内容处理字符c
    1774:	e9 c7 fa ff ff       	jmp    1240 <runTextInput>
    1779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
parseInput(char c)//综合上述各个处理函数对输入字符c进行处理
{
    if (c == KEY_ESC){//如果输入的是ESC
        mode = 0;//则进入控制模式
        clearControl();
        showMessage("");
    1780:	c7 45 08 25 1f 00 00 	movl   $0x1f25,0x8(%ebp)

void
parseInput(char c)//综合上述各个处理函数对输入字符c进行处理
{
    if (c == KEY_ESC){//如果输入的是ESC
        mode = 0;//则进入控制模式
    1787:	c7 05 84 28 00 00 00 	movl   $0x0,0x2884
    178e:	00 00 00 
}

void
clearControl()//清除命令缓冲区
{
    controlp = 0;
    1791:	c7 05 80 28 00 00 00 	movl   $0x0,0x2880
    1798:	00 00 00 
    controlbuf[0] = 0;
    179b:	c6 05 60 29 00 00 00 	movb   $0x0,0x2960
    }
    else{//如果处于非控制模式
        saved = 0;//只要输入字符，当前文件就尚未保存
        runTextInput(c);//并按照文本内容处理字符c
    }
}
    17a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    17a5:	5b                   	pop    %ebx
    17a6:	5e                   	pop    %esi
    17a7:	5f                   	pop    %edi
    17a8:	5d                   	pop    %ebp
parseInput(char c)//综合上述各个处理函数对输入字符c进行处理
{
    if (c == KEY_ESC){//如果输入的是ESC
        mode = 0;//则进入控制模式
        clearControl();
        showMessage("");
    17a9:	e9 c2 ed ff ff       	jmp    570 <showMessage>
    17ae:	66 90                	xchg   %ax,%ax
            runCommand();//运行保存/退出等命令
            clearControl();//清空控制字符串
            return ;
        }
        if (c == BACKSPACE)//当输入退格键时
            controlp--;//光标向左移
    17b0:	8d 50 ff             	lea    -0x1(%eax),%edx
    17b3:	89 15 80 28 00 00    	mov    %edx,0x2880
    17b9:	e9 50 ff ff ff       	jmp    170e <parseInput+0x9e>
    17be:	66 90                	xchg   %ax,%ax

void
clearControl()//清除命令缓冲区
{
    controlp = 0;
    controlbuf[0] = 0;
    17c0:	c6 05 60 29 00 00 00 	movb   $0x0,0x2960
    17c7:	ba 01 00 00 00       	mov    $0x1,%edx
    17cc:	e9 31 ff ff ff       	jmp    1702 <parseInput+0x92>
    17d1:	eb 0d                	jmp    17e0 <combineColor>
    17d3:	90                   	nop
    17d4:	90                   	nop
    17d5:	90                   	nop
    17d6:	90                   	nop
    17d7:	90                   	nop
    17d8:	90                   	nop
    17d9:	90                   	nop
    17da:	90                   	nop
    17db:	90                   	nop
    17dc:	90                   	nop
    17dd:	90                   	nop
    17de:	90                   	nop
    17df:	90                   	nop

000017e0 <combineColor>:
    
  return 0;
}

int combineColor(int textColor, int backgroundColor)//设置字体的颜色和背景的颜色
{
    17e0:	55                   	push   %ebp
    17e1:	89 e5                	mov    %esp,%ebp
    return ( textColor | ( backgroundColor << 4 ) );
    17e3:	8b 45 0c             	mov    0xc(%ebp),%eax
    17e6:	c1 e0 04             	shl    $0x4,%eax
    17e9:	0b 45 08             	or     0x8(%ebp),%eax
    17ec:	5d                   	pop    %ebp
    17ed:	c3                   	ret    
    17ee:	66 90                	xchg   %ax,%ax

000017f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    17f0:	55                   	push   %ebp
    17f1:	89 e5                	mov    %esp,%ebp
    17f3:	53                   	push   %ebx
    17f4:	8b 45 08             	mov    0x8(%ebp),%eax
    17f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    17fa:	89 c2                	mov    %eax,%edx
    17fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1800:	83 c1 01             	add    $0x1,%ecx
    1803:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1807:	83 c2 01             	add    $0x1,%edx
    180a:	84 db                	test   %bl,%bl
    180c:	88 5a ff             	mov    %bl,-0x1(%edx)
    180f:	75 ef                	jne    1800 <strcpy+0x10>
    ;
  return os;
}
    1811:	5b                   	pop    %ebx
    1812:	5d                   	pop    %ebp
    1813:	c3                   	ret    
    1814:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    181a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001820 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1820:	55                   	push   %ebp
    1821:	89 e5                	mov    %esp,%ebp
    1823:	56                   	push   %esi
    1824:	53                   	push   %ebx
    1825:	8b 55 08             	mov    0x8(%ebp),%edx
    1828:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    182b:	0f b6 02             	movzbl (%edx),%eax
    182e:	0f b6 19             	movzbl (%ecx),%ebx
    1831:	84 c0                	test   %al,%al
    1833:	75 1e                	jne    1853 <strcmp+0x33>
    1835:	eb 29                	jmp    1860 <strcmp+0x40>
    1837:	89 f6                	mov    %esi,%esi
    1839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1840:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1843:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1846:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1849:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    184d:	84 c0                	test   %al,%al
    184f:	74 0f                	je     1860 <strcmp+0x40>
    1851:	89 f1                	mov    %esi,%ecx
    1853:	38 d8                	cmp    %bl,%al
    1855:	74 e9                	je     1840 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1857:	29 d8                	sub    %ebx,%eax
}
    1859:	5b                   	pop    %ebx
    185a:	5e                   	pop    %esi
    185b:	5d                   	pop    %ebp
    185c:	c3                   	ret    
    185d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1860:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1862:	29 d8                	sub    %ebx,%eax
}
    1864:	5b                   	pop    %ebx
    1865:	5e                   	pop    %esi
    1866:	5d                   	pop    %ebp
    1867:	c3                   	ret    
    1868:	90                   	nop
    1869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001870 <strlen>:

uint
strlen(char *s)
{
    1870:	55                   	push   %ebp
    1871:	89 e5                	mov    %esp,%ebp
    1873:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    1876:	80 39 00             	cmpb   $0x0,(%ecx)
    1879:	74 12                	je     188d <strlen+0x1d>
    187b:	31 d2                	xor    %edx,%edx
    187d:	8d 76 00             	lea    0x0(%esi),%esi
    1880:	83 c2 01             	add    $0x1,%edx
    1883:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1887:	89 d0                	mov    %edx,%eax
    1889:	75 f5                	jne    1880 <strlen+0x10>
    ;
  return n;
}
    188b:	5d                   	pop    %ebp
    188c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    188d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    188f:	5d                   	pop    %ebp
    1890:	c3                   	ret    
    1891:	eb 0d                	jmp    18a0 <memset>
    1893:	90                   	nop
    1894:	90                   	nop
    1895:	90                   	nop
    1896:	90                   	nop
    1897:	90                   	nop
    1898:	90                   	nop
    1899:	90                   	nop
    189a:	90                   	nop
    189b:	90                   	nop
    189c:	90                   	nop
    189d:	90                   	nop
    189e:	90                   	nop
    189f:	90                   	nop

000018a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    18a0:	55                   	push   %ebp
    18a1:	89 e5                	mov    %esp,%ebp
    18a3:	57                   	push   %edi
    18a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    18a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    18aa:	8b 45 0c             	mov    0xc(%ebp),%eax
    18ad:	89 d7                	mov    %edx,%edi
    18af:	fc                   	cld    
    18b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    18b2:	89 d0                	mov    %edx,%eax
    18b4:	5f                   	pop    %edi
    18b5:	5d                   	pop    %ebp
    18b6:	c3                   	ret    
    18b7:	89 f6                	mov    %esi,%esi
    18b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000018c0 <strchr>:

char*
strchr(const char *s, char c)
{
    18c0:	55                   	push   %ebp
    18c1:	89 e5                	mov    %esp,%ebp
    18c3:	53                   	push   %ebx
    18c4:	8b 45 08             	mov    0x8(%ebp),%eax
    18c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    18ca:	0f b6 10             	movzbl (%eax),%edx
    18cd:	84 d2                	test   %dl,%dl
    18cf:	74 1d                	je     18ee <strchr+0x2e>
    if(*s == c)
    18d1:	38 d3                	cmp    %dl,%bl
    18d3:	89 d9                	mov    %ebx,%ecx
    18d5:	75 0d                	jne    18e4 <strchr+0x24>
    18d7:	eb 17                	jmp    18f0 <strchr+0x30>
    18d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    18e0:	38 ca                	cmp    %cl,%dl
    18e2:	74 0c                	je     18f0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    18e4:	83 c0 01             	add    $0x1,%eax
    18e7:	0f b6 10             	movzbl (%eax),%edx
    18ea:	84 d2                	test   %dl,%dl
    18ec:	75 f2                	jne    18e0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
    18ee:	31 c0                	xor    %eax,%eax
}
    18f0:	5b                   	pop    %ebx
    18f1:	5d                   	pop    %ebp
    18f2:	c3                   	ret    
    18f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    18f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001900 <gets>:

char*
gets(char *buf, int max)
{
    1900:	55                   	push   %ebp
    1901:	89 e5                	mov    %esp,%ebp
    1903:	57                   	push   %edi
    1904:	56                   	push   %esi
    1905:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1906:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    1908:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
    190b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    190e:	eb 29                	jmp    1939 <gets+0x39>
    cc = read(0, &c, 1);
    1910:	83 ec 04             	sub    $0x4,%esp
    1913:	6a 01                	push   $0x1
    1915:	57                   	push   %edi
    1916:	6a 00                	push   $0x0
    1918:	e8 2d 01 00 00       	call   1a4a <read>
    if(cc < 1)
    191d:	83 c4 10             	add    $0x10,%esp
    1920:	85 c0                	test   %eax,%eax
    1922:	7e 1d                	jle    1941 <gets+0x41>
      break;
    buf[i++] = c;
    1924:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1928:	8b 55 08             	mov    0x8(%ebp),%edx
    192b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
    192d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    192f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    1933:	74 1b                	je     1950 <gets+0x50>
    1935:	3c 0d                	cmp    $0xd,%al
    1937:	74 17                	je     1950 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1939:	8d 5e 01             	lea    0x1(%esi),%ebx
    193c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    193f:	7c cf                	jl     1910 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1941:	8b 45 08             	mov    0x8(%ebp),%eax
    1944:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    1948:	8d 65 f4             	lea    -0xc(%ebp),%esp
    194b:	5b                   	pop    %ebx
    194c:	5e                   	pop    %esi
    194d:	5f                   	pop    %edi
    194e:	5d                   	pop    %ebp
    194f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1950:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1953:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1955:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    1959:	8d 65 f4             	lea    -0xc(%ebp),%esp
    195c:	5b                   	pop    %ebx
    195d:	5e                   	pop    %esi
    195e:	5f                   	pop    %edi
    195f:	5d                   	pop    %ebp
    1960:	c3                   	ret    
    1961:	eb 0d                	jmp    1970 <stat>
    1963:	90                   	nop
    1964:	90                   	nop
    1965:	90                   	nop
    1966:	90                   	nop
    1967:	90                   	nop
    1968:	90                   	nop
    1969:	90                   	nop
    196a:	90                   	nop
    196b:	90                   	nop
    196c:	90                   	nop
    196d:	90                   	nop
    196e:	90                   	nop
    196f:	90                   	nop

00001970 <stat>:

int
stat(char *n, struct stat *st)
{
    1970:	55                   	push   %ebp
    1971:	89 e5                	mov    %esp,%ebp
    1973:	56                   	push   %esi
    1974:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1975:	83 ec 08             	sub    $0x8,%esp
    1978:	6a 00                	push   $0x0
    197a:	ff 75 08             	pushl  0x8(%ebp)
    197d:	e8 f0 00 00 00       	call   1a72 <open>
  if(fd < 0)
    1982:	83 c4 10             	add    $0x10,%esp
    1985:	85 c0                	test   %eax,%eax
    1987:	78 27                	js     19b0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1989:	83 ec 08             	sub    $0x8,%esp
    198c:	ff 75 0c             	pushl  0xc(%ebp)
    198f:	89 c3                	mov    %eax,%ebx
    1991:	50                   	push   %eax
    1992:	e8 f3 00 00 00       	call   1a8a <fstat>
    1997:	89 c6                	mov    %eax,%esi
  close(fd);
    1999:	89 1c 24             	mov    %ebx,(%esp)
    199c:	e8 b9 00 00 00       	call   1a5a <close>
  return r;
    19a1:	83 c4 10             	add    $0x10,%esp
    19a4:	89 f0                	mov    %esi,%eax
}
    19a6:	8d 65 f8             	lea    -0x8(%ebp),%esp
    19a9:	5b                   	pop    %ebx
    19aa:	5e                   	pop    %esi
    19ab:	5d                   	pop    %ebp
    19ac:	c3                   	ret    
    19ad:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    19b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    19b5:	eb ef                	jmp    19a6 <stat+0x36>
    19b7:	89 f6                	mov    %esi,%esi
    19b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000019c0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    19c0:	55                   	push   %ebp
    19c1:	89 e5                	mov    %esp,%ebp
    19c3:	53                   	push   %ebx
    19c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    19c7:	0f be 11             	movsbl (%ecx),%edx
    19ca:	8d 42 d0             	lea    -0x30(%edx),%eax
    19cd:	3c 09                	cmp    $0x9,%al
    19cf:	b8 00 00 00 00       	mov    $0x0,%eax
    19d4:	77 1f                	ja     19f5 <atoi+0x35>
    19d6:	8d 76 00             	lea    0x0(%esi),%esi
    19d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    19e0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    19e3:	83 c1 01             	add    $0x1,%ecx
    19e6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    19ea:	0f be 11             	movsbl (%ecx),%edx
    19ed:	8d 5a d0             	lea    -0x30(%edx),%ebx
    19f0:	80 fb 09             	cmp    $0x9,%bl
    19f3:	76 eb                	jbe    19e0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
    19f5:	5b                   	pop    %ebx
    19f6:	5d                   	pop    %ebp
    19f7:	c3                   	ret    
    19f8:	90                   	nop
    19f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001a00 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1a00:	55                   	push   %ebp
    1a01:	89 e5                	mov    %esp,%ebp
    1a03:	56                   	push   %esi
    1a04:	53                   	push   %ebx
    1a05:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1a08:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1a0e:	85 db                	test   %ebx,%ebx
    1a10:	7e 14                	jle    1a26 <memmove+0x26>
    1a12:	31 d2                	xor    %edx,%edx
    1a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1a18:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    1a1c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    1a1f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1a22:	39 da                	cmp    %ebx,%edx
    1a24:	75 f2                	jne    1a18 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    1a26:	5b                   	pop    %ebx
    1a27:	5e                   	pop    %esi
    1a28:	5d                   	pop    %ebp
    1a29:	c3                   	ret    

00001a2a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1a2a:	b8 01 00 00 00       	mov    $0x1,%eax
    1a2f:	cd 40                	int    $0x40
    1a31:	c3                   	ret    

00001a32 <exit>:
SYSCALL(exit)
    1a32:	b8 02 00 00 00       	mov    $0x2,%eax
    1a37:	cd 40                	int    $0x40
    1a39:	c3                   	ret    

00001a3a <wait>:
SYSCALL(wait)
    1a3a:	b8 03 00 00 00       	mov    $0x3,%eax
    1a3f:	cd 40                	int    $0x40
    1a41:	c3                   	ret    

00001a42 <pipe>:
SYSCALL(pipe)
    1a42:	b8 04 00 00 00       	mov    $0x4,%eax
    1a47:	cd 40                	int    $0x40
    1a49:	c3                   	ret    

00001a4a <read>:
SYSCALL(read)
    1a4a:	b8 05 00 00 00       	mov    $0x5,%eax
    1a4f:	cd 40                	int    $0x40
    1a51:	c3                   	ret    

00001a52 <write>:
SYSCALL(write)
    1a52:	b8 10 00 00 00       	mov    $0x10,%eax
    1a57:	cd 40                	int    $0x40
    1a59:	c3                   	ret    

00001a5a <close>:
SYSCALL(close)
    1a5a:	b8 15 00 00 00       	mov    $0x15,%eax
    1a5f:	cd 40                	int    $0x40
    1a61:	c3                   	ret    

00001a62 <kill>:
SYSCALL(kill)
    1a62:	b8 06 00 00 00       	mov    $0x6,%eax
    1a67:	cd 40                	int    $0x40
    1a69:	c3                   	ret    

00001a6a <exec>:
SYSCALL(exec)
    1a6a:	b8 07 00 00 00       	mov    $0x7,%eax
    1a6f:	cd 40                	int    $0x40
    1a71:	c3                   	ret    

00001a72 <open>:
SYSCALL(open)
    1a72:	b8 0f 00 00 00       	mov    $0xf,%eax
    1a77:	cd 40                	int    $0x40
    1a79:	c3                   	ret    

00001a7a <mknod>:
SYSCALL(mknod)
    1a7a:	b8 11 00 00 00       	mov    $0x11,%eax
    1a7f:	cd 40                	int    $0x40
    1a81:	c3                   	ret    

00001a82 <unlink>:
SYSCALL(unlink)
    1a82:	b8 12 00 00 00       	mov    $0x12,%eax
    1a87:	cd 40                	int    $0x40
    1a89:	c3                   	ret    

00001a8a <fstat>:
SYSCALL(fstat)
    1a8a:	b8 08 00 00 00       	mov    $0x8,%eax
    1a8f:	cd 40                	int    $0x40
    1a91:	c3                   	ret    

00001a92 <link>:
SYSCALL(link)
    1a92:	b8 13 00 00 00       	mov    $0x13,%eax
    1a97:	cd 40                	int    $0x40
    1a99:	c3                   	ret    

00001a9a <mkdir>:
SYSCALL(mkdir)
    1a9a:	b8 14 00 00 00       	mov    $0x14,%eax
    1a9f:	cd 40                	int    $0x40
    1aa1:	c3                   	ret    

00001aa2 <chdir>:
SYSCALL(chdir)
    1aa2:	b8 09 00 00 00       	mov    $0x9,%eax
    1aa7:	cd 40                	int    $0x40
    1aa9:	c3                   	ret    

00001aaa <dup>:
SYSCALL(dup)
    1aaa:	b8 0a 00 00 00       	mov    $0xa,%eax
    1aaf:	cd 40                	int    $0x40
    1ab1:	c3                   	ret    

00001ab2 <getpid>:
SYSCALL(getpid)
    1ab2:	b8 0b 00 00 00       	mov    $0xb,%eax
    1ab7:	cd 40                	int    $0x40
    1ab9:	c3                   	ret    

00001aba <sbrk>:
SYSCALL(sbrk)
    1aba:	b8 0c 00 00 00       	mov    $0xc,%eax
    1abf:	cd 40                	int    $0x40
    1ac1:	c3                   	ret    

00001ac2 <sleep>:
SYSCALL(sleep)
    1ac2:	b8 0d 00 00 00       	mov    $0xd,%eax
    1ac7:	cd 40                	int    $0x40
    1ac9:	c3                   	ret    

00001aca <uptime>:
SYSCALL(uptime)
    1aca:	b8 0e 00 00 00       	mov    $0xe,%eax
    1acf:	cd 40                	int    $0x40
    1ad1:	c3                   	ret    

00001ad2 <setconsole>:

SYSCALL(setconsole)
    1ad2:	b8 16 00 00 00       	mov    $0x16,%eax
    1ad7:	cd 40                	int    $0x40
    1ad9:	c3                   	ret    
    1ada:	66 90                	xchg   %ax,%ax
    1adc:	66 90                	xchg   %ax,%ax
    1ade:	66 90                	xchg   %ax,%ax

00001ae0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1ae0:	55                   	push   %ebp
    1ae1:	89 e5                	mov    %esp,%ebp
    1ae3:	57                   	push   %edi
    1ae4:	56                   	push   %esi
    1ae5:	53                   	push   %ebx
    1ae6:	89 c6                	mov    %eax,%esi
    1ae8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1aeb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1aee:	85 db                	test   %ebx,%ebx
    1af0:	74 7e                	je     1b70 <printint+0x90>
    1af2:	89 d0                	mov    %edx,%eax
    1af4:	c1 e8 1f             	shr    $0x1f,%eax
    1af7:	84 c0                	test   %al,%al
    1af9:	74 75                	je     1b70 <printint+0x90>
    neg = 1;
    x = -xx;
    1afb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    1afd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
    1b04:	f7 d8                	neg    %eax
    1b06:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    1b09:	31 ff                	xor    %edi,%edi
    1b0b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    1b0e:	89 ce                	mov    %ecx,%esi
    1b10:	eb 08                	jmp    1b1a <printint+0x3a>
    1b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1b18:	89 cf                	mov    %ecx,%edi
    1b1a:	31 d2                	xor    %edx,%edx
    1b1c:	8d 4f 01             	lea    0x1(%edi),%ecx
    1b1f:	f7 f6                	div    %esi
    1b21:	0f b6 92 78 20 00 00 	movzbl 0x2078(%edx),%edx
  }while((x /= base) != 0);
    1b28:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    1b2a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    1b2d:	75 e9                	jne    1b18 <printint+0x38>
  if(neg)
    1b2f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    1b32:	8b 75 c0             	mov    -0x40(%ebp),%esi
    1b35:	85 c0                	test   %eax,%eax
    1b37:	74 08                	je     1b41 <printint+0x61>
    buf[i++] = '-';
    1b39:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
    1b3e:	8d 4f 02             	lea    0x2(%edi),%ecx
    1b41:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
    1b45:	8d 76 00             	lea    0x0(%esi),%esi
    1b48:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1b4b:	83 ec 04             	sub    $0x4,%esp
    1b4e:	83 ef 01             	sub    $0x1,%edi
    1b51:	6a 01                	push   $0x1
    1b53:	53                   	push   %ebx
    1b54:	56                   	push   %esi
    1b55:	88 45 d7             	mov    %al,-0x29(%ebp)
    1b58:	e8 f5 fe ff ff       	call   1a52 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1b5d:	83 c4 10             	add    $0x10,%esp
    1b60:	39 df                	cmp    %ebx,%edi
    1b62:	75 e4                	jne    1b48 <printint+0x68>
    putc(fd, buf[i]);
}
    1b64:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1b67:	5b                   	pop    %ebx
    1b68:	5e                   	pop    %esi
    1b69:	5f                   	pop    %edi
    1b6a:	5d                   	pop    %ebp
    1b6b:	c3                   	ret    
    1b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1b70:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1b72:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    1b79:	eb 8b                	jmp    1b06 <printint+0x26>
    1b7b:	90                   	nop
    1b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001b80 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1b80:	55                   	push   %ebp
    1b81:	89 e5                	mov    %esp,%ebp
    1b83:	57                   	push   %edi
    1b84:	56                   	push   %esi
    1b85:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1b86:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1b89:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1b8c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1b8f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1b92:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1b95:	0f b6 1e             	movzbl (%esi),%ebx
    1b98:	83 c6 01             	add    $0x1,%esi
    1b9b:	84 db                	test   %bl,%bl
    1b9d:	0f 84 b0 00 00 00    	je     1c53 <printf+0xd3>
    1ba3:	31 d2                	xor    %edx,%edx
    1ba5:	eb 39                	jmp    1be0 <printf+0x60>
    1ba7:	89 f6                	mov    %esi,%esi
    1ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1bb0:	83 f8 25             	cmp    $0x25,%eax
    1bb3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
    1bb6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1bbb:	74 18                	je     1bd5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1bbd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1bc0:	83 ec 04             	sub    $0x4,%esp
    1bc3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    1bc6:	6a 01                	push   $0x1
    1bc8:	50                   	push   %eax
    1bc9:	57                   	push   %edi
    1bca:	e8 83 fe ff ff       	call   1a52 <write>
    1bcf:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1bd2:	83 c4 10             	add    $0x10,%esp
    1bd5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1bd8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    1bdc:	84 db                	test   %bl,%bl
    1bde:	74 73                	je     1c53 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
    1be0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    1be2:	0f be cb             	movsbl %bl,%ecx
    1be5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    1be8:	74 c6                	je     1bb0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1bea:	83 fa 25             	cmp    $0x25,%edx
    1bed:	75 e6                	jne    1bd5 <printf+0x55>
      if(c == 'd'){
    1bef:	83 f8 64             	cmp    $0x64,%eax
    1bf2:	0f 84 f8 00 00 00    	je     1cf0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1bf8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1bfe:	83 f9 70             	cmp    $0x70,%ecx
    1c01:	74 5d                	je     1c60 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1c03:	83 f8 73             	cmp    $0x73,%eax
    1c06:	0f 84 84 00 00 00    	je     1c90 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1c0c:	83 f8 63             	cmp    $0x63,%eax
    1c0f:	0f 84 ea 00 00 00    	je     1cff <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1c15:	83 f8 25             	cmp    $0x25,%eax
    1c18:	0f 84 c2 00 00 00    	je     1ce0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1c1e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1c21:	83 ec 04             	sub    $0x4,%esp
    1c24:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    1c28:	6a 01                	push   $0x1
    1c2a:	50                   	push   %eax
    1c2b:	57                   	push   %edi
    1c2c:	e8 21 fe ff ff       	call   1a52 <write>
    1c31:	83 c4 0c             	add    $0xc,%esp
    1c34:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1c37:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    1c3a:	6a 01                	push   $0x1
    1c3c:	50                   	push   %eax
    1c3d:	57                   	push   %edi
    1c3e:	83 c6 01             	add    $0x1,%esi
    1c41:	e8 0c fe ff ff       	call   1a52 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1c46:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1c4a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1c4d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1c4f:	84 db                	test   %bl,%bl
    1c51:	75 8d                	jne    1be0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1c53:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1c56:	5b                   	pop    %ebx
    1c57:	5e                   	pop    %esi
    1c58:	5f                   	pop    %edi
    1c59:	5d                   	pop    %ebp
    1c5a:	c3                   	ret    
    1c5b:	90                   	nop
    1c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1c60:	83 ec 0c             	sub    $0xc,%esp
    1c63:	b9 10 00 00 00       	mov    $0x10,%ecx
    1c68:	6a 00                	push   $0x0
    1c6a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1c6d:	89 f8                	mov    %edi,%eax
    1c6f:	8b 13                	mov    (%ebx),%edx
    1c71:	e8 6a fe ff ff       	call   1ae0 <printint>
        ap++;
    1c76:	89 d8                	mov    %ebx,%eax
    1c78:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1c7b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    1c7d:	83 c0 04             	add    $0x4,%eax
    1c80:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1c83:	e9 4d ff ff ff       	jmp    1bd5 <printf+0x55>
    1c88:	90                   	nop
    1c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    1c90:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1c93:	8b 18                	mov    (%eax),%ebx
        ap++;
    1c95:	83 c0 04             	add    $0x4,%eax
    1c98:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
    1c9b:	b8 70 20 00 00       	mov    $0x2070,%eax
    1ca0:	85 db                	test   %ebx,%ebx
    1ca2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
    1ca5:	0f b6 03             	movzbl (%ebx),%eax
    1ca8:	84 c0                	test   %al,%al
    1caa:	74 23                	je     1ccf <printf+0x14f>
    1cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1cb0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1cb3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    1cb6:	83 ec 04             	sub    $0x4,%esp
    1cb9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    1cbb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1cbe:	50                   	push   %eax
    1cbf:	57                   	push   %edi
    1cc0:	e8 8d fd ff ff       	call   1a52 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1cc5:	0f b6 03             	movzbl (%ebx),%eax
    1cc8:	83 c4 10             	add    $0x10,%esp
    1ccb:	84 c0                	test   %al,%al
    1ccd:	75 e1                	jne    1cb0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1ccf:	31 d2                	xor    %edx,%edx
    1cd1:	e9 ff fe ff ff       	jmp    1bd5 <printf+0x55>
    1cd6:	8d 76 00             	lea    0x0(%esi),%esi
    1cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1ce0:	83 ec 04             	sub    $0x4,%esp
    1ce3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1ce6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1ce9:	6a 01                	push   $0x1
    1ceb:	e9 4c ff ff ff       	jmp    1c3c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    1cf0:	83 ec 0c             	sub    $0xc,%esp
    1cf3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1cf8:	6a 01                	push   $0x1
    1cfa:	e9 6b ff ff ff       	jmp    1c6a <printf+0xea>
    1cff:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1d02:	83 ec 04             	sub    $0x4,%esp
    1d05:	8b 03                	mov    (%ebx),%eax
    1d07:	6a 01                	push   $0x1
    1d09:	88 45 e4             	mov    %al,-0x1c(%ebp)
    1d0c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1d0f:	50                   	push   %eax
    1d10:	57                   	push   %edi
    1d11:	e8 3c fd ff ff       	call   1a52 <write>
    1d16:	e9 5b ff ff ff       	jmp    1c76 <printf+0xf6>
    1d1b:	66 90                	xchg   %ax,%ax
    1d1d:	66 90                	xchg   %ax,%ax
    1d1f:	90                   	nop

00001d20 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1d20:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1d21:	a1 98 28 00 00       	mov    0x2898,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1d26:	89 e5                	mov    %esp,%ebp
    1d28:	57                   	push   %edi
    1d29:	56                   	push   %esi
    1d2a:	53                   	push   %ebx
    1d2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1d2e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1d30:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1d33:	39 c8                	cmp    %ecx,%eax
    1d35:	73 19                	jae    1d50 <free+0x30>
    1d37:	89 f6                	mov    %esi,%esi
    1d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    1d40:	39 d1                	cmp    %edx,%ecx
    1d42:	72 1c                	jb     1d60 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1d44:	39 d0                	cmp    %edx,%eax
    1d46:	73 18                	jae    1d60 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
    1d48:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1d4a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1d4c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1d4e:	72 f0                	jb     1d40 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1d50:	39 d0                	cmp    %edx,%eax
    1d52:	72 f4                	jb     1d48 <free+0x28>
    1d54:	39 d1                	cmp    %edx,%ecx
    1d56:	73 f0                	jae    1d48 <free+0x28>
    1d58:	90                   	nop
    1d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
    1d60:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1d63:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    1d66:	39 d7                	cmp    %edx,%edi
    1d68:	74 19                	je     1d83 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1d6a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1d6d:	8b 50 04             	mov    0x4(%eax),%edx
    1d70:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1d73:	39 f1                	cmp    %esi,%ecx
    1d75:	74 23                	je     1d9a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1d77:	89 08                	mov    %ecx,(%eax)
  freep = p;
    1d79:	a3 98 28 00 00       	mov    %eax,0x2898
}
    1d7e:	5b                   	pop    %ebx
    1d7f:	5e                   	pop    %esi
    1d80:	5f                   	pop    %edi
    1d81:	5d                   	pop    %ebp
    1d82:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1d83:	03 72 04             	add    0x4(%edx),%esi
    1d86:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1d89:	8b 10                	mov    (%eax),%edx
    1d8b:	8b 12                	mov    (%edx),%edx
    1d8d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1d90:	8b 50 04             	mov    0x4(%eax),%edx
    1d93:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1d96:	39 f1                	cmp    %esi,%ecx
    1d98:	75 dd                	jne    1d77 <free+0x57>
    p->s.size += bp->s.size;
    1d9a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    1d9d:	a3 98 28 00 00       	mov    %eax,0x2898
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1da2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1da5:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1da8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    1daa:	5b                   	pop    %ebx
    1dab:	5e                   	pop    %esi
    1dac:	5f                   	pop    %edi
    1dad:	5d                   	pop    %ebp
    1dae:	c3                   	ret    
    1daf:	90                   	nop

00001db0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1db0:	55                   	push   %ebp
    1db1:	89 e5                	mov    %esp,%ebp
    1db3:	57                   	push   %edi
    1db4:	56                   	push   %esi
    1db5:	53                   	push   %ebx
    1db6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1db9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    1dbc:	8b 15 98 28 00 00    	mov    0x2898,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1dc2:	8d 78 07             	lea    0x7(%eax),%edi
    1dc5:	c1 ef 03             	shr    $0x3,%edi
    1dc8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    1dcb:	85 d2                	test   %edx,%edx
    1dcd:	0f 84 a3 00 00 00    	je     1e76 <malloc+0xc6>
    1dd3:	8b 02                	mov    (%edx),%eax
    1dd5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1dd8:	39 cf                	cmp    %ecx,%edi
    1dda:	76 74                	jbe    1e50 <malloc+0xa0>
    1ddc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1de2:	be 00 10 00 00       	mov    $0x1000,%esi
    1de7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
    1dee:	0f 43 f7             	cmovae %edi,%esi
    1df1:	ba 00 80 00 00       	mov    $0x8000,%edx
    1df6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
    1dfc:	0f 46 da             	cmovbe %edx,%ebx
    1dff:	eb 10                	jmp    1e11 <malloc+0x61>
    1e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1e08:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1e0a:	8b 48 04             	mov    0x4(%eax),%ecx
    1e0d:	39 cf                	cmp    %ecx,%edi
    1e0f:	76 3f                	jbe    1e50 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1e11:	39 05 98 28 00 00    	cmp    %eax,0x2898
    1e17:	89 c2                	mov    %eax,%edx
    1e19:	75 ed                	jne    1e08 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    1e1b:	83 ec 0c             	sub    $0xc,%esp
    1e1e:	53                   	push   %ebx
    1e1f:	e8 96 fc ff ff       	call   1aba <sbrk>
  if(p == (char*)-1)
    1e24:	83 c4 10             	add    $0x10,%esp
    1e27:	83 f8 ff             	cmp    $0xffffffff,%eax
    1e2a:	74 1c                	je     1e48 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    1e2c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
    1e2f:	83 ec 0c             	sub    $0xc,%esp
    1e32:	83 c0 08             	add    $0x8,%eax
    1e35:	50                   	push   %eax
    1e36:	e8 e5 fe ff ff       	call   1d20 <free>
  return freep;
    1e3b:	8b 15 98 28 00 00    	mov    0x2898,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    1e41:	83 c4 10             	add    $0x10,%esp
    1e44:	85 d2                	test   %edx,%edx
    1e46:	75 c0                	jne    1e08 <malloc+0x58>
        return 0;
    1e48:	31 c0                	xor    %eax,%eax
    1e4a:	eb 1c                	jmp    1e68 <malloc+0xb8>
    1e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    1e50:	39 cf                	cmp    %ecx,%edi
    1e52:	74 1c                	je     1e70 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1e54:	29 f9                	sub    %edi,%ecx
    1e56:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1e59:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1e5c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
    1e5f:	89 15 98 28 00 00    	mov    %edx,0x2898
      return (void*)(p + 1);
    1e65:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1e68:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1e6b:	5b                   	pop    %ebx
    1e6c:	5e                   	pop    %esi
    1e6d:	5f                   	pop    %edi
    1e6e:	5d                   	pop    %ebp
    1e6f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1e70:	8b 08                	mov    (%eax),%ecx
    1e72:	89 0a                	mov    %ecx,(%edx)
    1e74:	eb e9                	jmp    1e5f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1e76:	c7 05 98 28 00 00 9c 	movl   $0x289c,0x2898
    1e7d:	28 00 00 
    1e80:	c7 05 9c 28 00 00 9c 	movl   $0x289c,0x289c
    1e87:	28 00 00 
    base.s.size = 0;
    1e8a:	b8 9c 28 00 00       	mov    $0x289c,%eax
    1e8f:	c7 05 a0 28 00 00 00 	movl   $0x0,0x28a0
    1e96:	00 00 00 
    1e99:	e9 3e ff ff ff       	jmp    1ddc <malloc+0x2c>
