
kernel：     文件格式 elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 10 c6 10 80       	mov    $0x8010c610,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 20 3c 10 80       	mov    $0x80103c20,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 c6 10 80       	mov    $0x8010c654,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 80 7d 10 80       	push   $0x80107d80
80100051:	68 20 c6 10 80       	push   $0x8010c620
80100056:	e8 05 4f 00 00       	call   80104f60 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 6c 0d 11 80 1c 	movl   $0x80110d1c,0x80110d6c
80100062:	0d 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 70 0d 11 80 1c 	movl   $0x80110d1c,0x80110d70
8010006c:	0d 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba 1c 0d 11 80       	mov    $0x80110d1c,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c 0d 11 80 	movl   $0x80110d1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 87 7d 10 80       	push   $0x80107d87
80100097:	50                   	push   %eax
80100098:	e8 b3 4d 00 00       	call   80104e50 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 0d 11 80       	mov    0x80110d70,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 70 0d 11 80    	mov    %ebx,0x80110d70

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d 1c 0d 11 80       	cmp    $0x80110d1c,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 20 c6 10 80       	push   $0x8010c620
801000e4:	e8 77 4f 00 00       	call   80105060 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 0d 11 80    	mov    0x80110d70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c 0d 11 80    	cmp    $0x80110d1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c 0d 11 80    	cmp    $0x80110d1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c 0d 11 80    	mov    0x80110d6c,%ebx
80100126:	81 fb 1c 0d 11 80    	cmp    $0x80110d1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c 0d 11 80    	cmp    $0x80110d1c,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 c6 10 80       	push   $0x8010c620
80100162:	e8 19 50 00 00       	call   80105180 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 1e 4d 00 00       	call   80104e90 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 2d 2d 00 00       	call   80102eb0 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 8e 7d 10 80       	push   $0x80107d8e
80100198:	e8 23 06 00 00       	call   801007c0 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 7d 4d 00 00       	call   80104f30 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 e7 2c 00 00       	jmp    80102eb0 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 9f 7d 10 80       	push   $0x80107d9f
801001d1:	e8 ea 05 00 00       	call   801007c0 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 3c 4d 00 00       	call   80104f30 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 ec 4c 00 00       	call   80104ef0 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 20 c6 10 80 	movl   $0x8010c620,(%esp)
8010020b:	e8 50 4e 00 00       	call   80105060 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 70 0d 11 80       	mov    0x80110d70,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 1c 0d 11 80 	movl   $0x80110d1c,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 70 0d 11 80       	mov    0x80110d70,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 70 0d 11 80    	mov    %ebx,0x80110d70
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 20 c6 10 80 	movl   $0x8010c620,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 1f 4f 00 00       	jmp    80105180 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 a6 7d 10 80       	push   $0x80107da6
80100269:	e8 52 05 00 00       	call   801007c0 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  release(&input.lock);
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 8b 22 00 00       	call   80102510 <iunlock>
  target = n;
  acquire(&input.lock);
80100285:	c7 04 24 80 0f 11 80 	movl   $0x80110f80,(%esp)
8010028c:	e8 cf 4d 00 00       	call   80105060 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 34 10 11 80       	mov    0x80111034,%eax
801002a6:	3b 05 38 10 11 80    	cmp    0x80111038,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(myproc()->killed){
        release(&input.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 80 0f 11 80       	push   $0x80110f80
801002b8:	68 34 10 11 80       	push   $0x80111034
801002bd:	e8 2e 48 00 00       	call   80104af0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 34 10 11 80       	mov    0x80111034,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 38 10 11 80    	cmp    0x80111038,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(myproc()->killed){
801002d2:	e8 69 42 00 00       	call   80104540 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&input.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 80 0f 11 80       	push   $0x80110f80
801002e6:	e8 95 4e 00 00       	call   80105180 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 3d 21 00 00       	call   80102430 <ilock>
        return -1;
801002f3:	83 c4 10             	add    $0x10,%esp
801002f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&input.lock);
  ilock(ip);

  return target - n;
}
801002fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002fe:	5b                   	pop    %ebx
801002ff:	5e                   	pop    %esi
80100300:	5f                   	pop    %edi
80100301:	5d                   	pop    %ebp
80100302:	c3                   	ret    
80100303:	90                   	nop
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 34 10 11 80    	mov    %edx,0x80111034
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 b4 0f 11 80 	movsbl -0x7feef04c(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&input.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 80 0f 11 80       	push   $0x80110f80
80100346:	e8 35 4e 00 00       	call   80105180 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 dd 20 00 00       	call   80102430 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a0                	jmp    801002fb <consoleread+0x8b>
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 34 10 11 80       	mov    %eax,0x80111034
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <recordScreenHistory>:

void recordScreenHistory(){
  //record history firstly
  int i, j;
  // scroll up : record the whole screen
  if(startScreenLine == 0){
80100370:	a1 30 b5 10 80       	mov    0x8010b530,%eax
80100375:	85 c0                	test   %eax,%eax
80100377:	75 43                	jne    801003bc <recordScreenHistory+0x4c>

// record  Screen History
// used in "scroll up" and "page up"
int switchMode(int pos);

void recordScreenHistory(){
80100379:	55                   	push   %ebp
8010037a:	89 e5                	mov    %esp,%ebp
8010037c:	53                   	push   %ebx
8010037d:	31 db                	xor    %ebx,%ebx
8010037f:	90                   	nop
80100380:	8d 83 00 80 0b 80    	lea    -0x7ff48000(%ebx),%eax
80100386:	8d 8b a0 80 0b 80    	lea    -0x7ff47f60(%ebx),%ecx
8010038c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int i, j;
  // scroll up : record the whole screen
  if(startScreenLine == 0){
    for(i = 0; i < rows; i++){
      for(j = 0; j < 80; j++)
        screenHistory[i][j] = crt[i*80+j];
80100390:	0f b7 10             	movzwl (%eax),%edx
80100393:	83 c0 02             	add    $0x2,%eax
80100396:	66 89 90 5e 90 05 00 	mov    %dx,0x5905e(%eax)
  //record history firstly
  int i, j;
  // scroll up : record the whole screen
  if(startScreenLine == 0){
    for(i = 0; i < rows; i++){
      for(j = 0; j < 80; j++)
8010039d:	39 c8                	cmp    %ecx,%eax
8010039f:	75 ef                	jne    80100390 <recordScreenHistory+0x20>
801003a1:	81 c3 a0 00 00 00    	add    $0xa0,%ebx
void recordScreenHistory(){
  //record history firstly
  int i, j;
  // scroll up : record the whole screen
  if(startScreenLine == 0){
    for(i = 0; i < rows; i++){
801003a7:	81 fb 00 0f 00 00    	cmp    $0xf00,%ebx
801003ad:	75 d1                	jne    80100380 <recordScreenHistory+0x10>
      screenHistory[screenHistoryLen-1][j] = crt[(rows-1)*80+j];
      //debug crt[80*17+j] = crt[(mainRows-1)*80+j];
    }
  }
  return;
}
801003af:	5b                   	pop    %ebx
  if(startScreenLine == 0){
    for(i = 0; i < rows; i++){
      for(j = 0; j < 80; j++)
        screenHistory[i][j] = crt[i*80+j];
    }
    screenHistoryLen = rows;  
801003b0:	c7 05 34 b5 10 80 18 	movl   $0x18,0x8010b534
801003b7:	00 00 00 
      screenHistory[screenHistoryLen-1][j] = crt[(rows-1)*80+j];
      //debug crt[80*17+j] = crt[(mainRows-1)*80+j];
    }
  }
  return;
}
801003ba:	5d                   	pop    %ebp
801003bb:	c3                   	ret    
801003bc:	a1 34 b5 10 80       	mov    0x8010b534,%eax
801003c1:	8d 4c 80 fb          	lea    -0x5(%eax,%eax,4),%ecx

void recordScreenHistory(){
  //record history firstly
  int i, j;
  // scroll up : record the whole screen
  if(startScreenLine == 0){
801003c5:	31 c0                	xor    %eax,%eax
801003c7:	c1 e1 05             	shl    $0x5,%ecx
801003ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
    screenHistoryLen = rows;  
  }
  else{   // page up or scroll up: record the last line(mainRows-1)
    for(j=0; j<80; j++){
      screenHistory[screenHistoryLen-1][j] = crt[(rows-1)*80+j];
801003d0:	0f b7 90 60 8e 0b 80 	movzwl -0x7ff471a0(%eax),%edx
801003d7:	66 89 94 01 60 10 11 	mov    %dx,-0x7feeefa0(%ecx,%eax,1)
801003de:	80 
801003df:	83 c0 02             	add    $0x2,%eax
        screenHistory[i][j] = crt[i*80+j];
    }
    screenHistoryLen = rows;  
  }
  else{   // page up or scroll up: record the last line(mainRows-1)
    for(j=0; j<80; j++){
801003e2:	3d a0 00 00 00       	cmp    $0xa0,%eax
801003e7:	75 e7                	jne    801003d0 <recordScreenHistory+0x60>
801003e9:	f3 c3                	repz ret 
801003eb:	90                   	nop
801003ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801003f0 <cgaputc>:
}


static void
cgaputc(int c)
{
801003f0:	55                   	push   %ebp
801003f1:	89 e5                	mov    %esp,%ebp
801003f3:	57                   	push   %edi
801003f4:	56                   	push   %esi
801003f5:	53                   	push   %ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003f6:	bf d4 03 00 00       	mov    $0x3d4,%edi
801003fb:	89 c6                	mov    %eax,%esi
801003fd:	89 fa                	mov    %edi,%edx
801003ff:	b8 0e 00 00 00       	mov    $0xe,%eax
80100404:	83 ec 1c             	sub    $0x1c,%esp
80100407:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100408:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010040d:	89 da                	mov    %ebx,%edx
8010040f:	ec                   	in     (%dx),%al
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100410:	0f b6 c8             	movzbl %al,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100413:	89 fa                	mov    %edi,%edx
80100415:	b8 0f 00 00 00       	mov    $0xf,%eax
8010041a:	c1 e1 08             	shl    $0x8,%ecx
8010041d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010041e:	89 da                	mov    %ebx,%edx
80100420:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
80100421:	0f b6 c0             	movzbl %al,%eax
80100424:	09 c8                	or     %ecx,%eax

  if(c == '\n')
80100426:	83 fe 0a             	cmp    $0xa,%esi
80100429:	0f 84 d1 00 00 00    	je     80100500 <cgaputc+0x110>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
8010042f:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100435:	0f 84 e5 00 00 00    	je     80100520 <cgaputc+0x130>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010043b:	89 f1                	mov    %esi,%ecx
8010043d:	8d 58 01             	lea    0x1(%eax),%ebx
80100440:	0f b6 f1             	movzbl %cl,%esi
80100443:	66 81 ce 00 07       	or     $0x700,%si
80100448:	66 89 b4 00 00 80 0b 	mov    %si,-0x7ff48000(%eax,%eax,1)
8010044f:	80 
      crt[80*(mainRows-1)+i] = (' '&0xff) | 0x8000;
    //memset(crt+pos, 0, sizeof(crt[0])*(mainRows*80 - pos));
  }
  */

  if((pos/80) >= 24){  // Scroll up.
80100450:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100456:	7f 48                	jg     801004a0 <cgaputc+0xb0>
80100458:	89 d8                	mov    %ebx,%eax
8010045a:	8d 8c 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%ecx
80100461:	89 df                	mov    %ebx,%edi
80100463:	c1 e8 08             	shr    $0x8,%eax
80100466:	89 45 d8             	mov    %eax,-0x28(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100469:	be d4 03 00 00       	mov    $0x3d4,%esi
8010046e:	b8 0e 00 00 00       	mov    $0xe,%eax
80100473:	89 f2                	mov    %esi,%edx
80100475:	ee                   	out    %al,(%dx)
80100476:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010047b:	0f b6 45 d8          	movzbl -0x28(%ebp),%eax
8010047f:	89 da                	mov    %ebx,%edx
80100481:	ee                   	out    %al,(%dx)
80100482:	b8 0f 00 00 00       	mov    $0xf,%eax
80100487:	89 f2                	mov    %esi,%edx
80100489:	ee                   	out    %al,(%dx)
8010048a:	89 f8                	mov    %edi,%eax
8010048c:	89 da                	mov    %ebx,%edx
8010048e:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
8010048f:	b8 20 07 00 00       	mov    $0x720,%eax
80100494:	66 89 01             	mov    %ax,(%ecx)
}
80100497:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010049a:	5b                   	pop    %ebx
8010049b:	5e                   	pop    %esi
8010049c:	5f                   	pop    %edi
8010049d:	5d                   	pop    %ebp
8010049e:	c3                   	ret    
8010049f:	90                   	nop
    //memset(crt+pos, 0, sizeof(crt[0])*(mainRows*80 - pos));
  }
  */

  if((pos/80) >= 24){  // Scroll up.
    recordScreenHistory();
801004a0:	e8 cb fe ff ff       	call   80100370 <recordScreenHistory>
    startScreenLine++;
    screenHistoryLen++;
    
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004a5:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004a8:	83 eb 50             	sub    $0x50,%ebx
  }
  */

  if((pos/80) >= 24){  // Scroll up.
    recordScreenHistory();
    startScreenLine++;
801004ab:	83 05 30 b5 10 80 01 	addl   $0x1,0x8010b530
    screenHistoryLen++;
    
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004b2:	68 60 0e 00 00       	push   $0xe60
801004b7:	68 a0 80 0b 80       	push   $0x800b80a0
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004bc:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
  if((pos/80) >= 24){  // Scroll up.
    recordScreenHistory();
    startScreenLine++;
    screenHistoryLen++;
    
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004c3:	68 00 80 0b 80       	push   $0x800b8000
  */

  if((pos/80) >= 24){  // Scroll up.
    recordScreenHistory();
    startScreenLine++;
    screenHistoryLen++;
801004c8:	83 05 34 b5 10 80 01 	addl   $0x1,0x8010b534
801004cf:	89 df                	mov    %ebx,%edi
    
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004d1:	e8 aa 4d 00 00       	call   80105280 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004d6:	b8 80 07 00 00       	mov    $0x780,%eax
801004db:	83 c4 0c             	add    $0xc,%esp
801004de:	29 d8                	sub    %ebx,%eax
801004e0:	c1 eb 08             	shr    $0x8,%ebx
801004e3:	01 c0                	add    %eax,%eax
801004e5:	50                   	push   %eax
801004e6:	6a 00                	push   $0x0
801004e8:	56                   	push   %esi
801004e9:	e8 e2 4c 00 00       	call   801051d0 <memset>
801004ee:	89 5d d8             	mov    %ebx,-0x28(%ebp)
801004f1:	83 c4 10             	add    $0x10,%esp
801004f4:	89 f1                	mov    %esi,%ecx
801004f6:	e9 6e ff ff ff       	jmp    80100469 <cgaputc+0x79>
801004fb:	90                   	nop
801004fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100500:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100505:	f7 ea                	imul   %edx
80100507:	89 d0                	mov    %edx,%eax
80100509:	c1 e8 05             	shr    $0x5,%eax
8010050c:	8d 04 80             	lea    (%eax,%eax,4),%eax
8010050f:	c1 e0 04             	shl    $0x4,%eax
80100512:	8d 58 50             	lea    0x50(%eax),%ebx
80100515:	e9 36 ff ff ff       	jmp    80100450 <cgaputc+0x60>
8010051a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
80100520:	85 c0                	test   %eax,%eax
80100522:	8d 58 ff             	lea    -0x1(%eax),%ebx
80100525:	0f 85 25 ff ff ff    	jne    80100450 <cgaputc+0x60>
8010052b:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
80100530:	c6 45 d8 00          	movb   $0x0,-0x28(%ebp)
80100534:	31 ff                	xor    %edi,%edi
80100536:	e9 2e ff ff ff       	jmp    80100469 <cgaputc+0x79>
8010053b:	90                   	nop
8010053c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100540 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
80100540:	8b 15 98 b5 10 80    	mov    0x8010b598,%edx
80100546:	85 d2                	test   %edx,%edx
80100548:	74 06                	je     80100550 <consputc+0x10>
}

static inline void
cli(void)
{
  asm volatile("cli");
8010054a:	fa                   	cli    
8010054b:	eb fe                	jmp    8010054b <consputc+0xb>
8010054d:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100550:	55                   	push   %ebp
80100551:	89 e5                	mov    %esp,%ebp
80100553:	53                   	push   %ebx
80100554:	89 c3                	mov    %eax,%ebx
80100556:	83 ec 04             	sub    $0x4,%esp
  if(panicked){
    cli();
    for(;;)
      ;
  }
  if(c == BACKSPACE){
80100559:	3d 00 01 00 00       	cmp    $0x100,%eax
8010055e:	74 17                	je     80100577 <consputc+0x37>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100560:	83 ec 0c             	sub    $0xc,%esp
80100563:	50                   	push   %eax
80100564:	e8 d7 63 00 00       	call   80106940 <uartputc>
80100569:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
8010056c:	89 d8                	mov    %ebx,%eax
}
8010056e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100571:	c9                   	leave  
  }
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
80100572:	e9 79 fe ff ff       	jmp    801003f0 <cgaputc>
    cli();
    for(;;)
      ;
  }
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100577:	83 ec 0c             	sub    $0xc,%esp
8010057a:	6a 08                	push   $0x8
8010057c:	e8 bf 63 00 00       	call   80106940 <uartputc>
80100581:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100588:	e8 b3 63 00 00       	call   80106940 <uartputc>
8010058d:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100594:	e8 a7 63 00 00       	call   80106940 <uartputc>
80100599:	83 c4 10             	add    $0x10,%esp
  } else
    uartputc(c);
  cgaputc(c);
8010059c:	89 d8                	mov    %ebx,%eax
}
8010059e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801005a1:	c9                   	leave  
  }
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
801005a2:	e9 49 fe ff ff       	jmp    801003f0 <cgaputc>
801005a7:	89 f6                	mov    %esi,%esi
801005a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801005b0 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801005b0:	55                   	push   %ebp
801005b1:	89 e5                	mov    %esp,%ebp
801005b3:	57                   	push   %edi
801005b4:	56                   	push   %esi
801005b5:	53                   	push   %ebx
801005b6:	89 d6                	mov    %edx,%esi
801005b8:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801005bb:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801005bd:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801005c0:	74 0c                	je     801005ce <printint+0x1e>
801005c2:	89 c7                	mov    %eax,%edi
801005c4:	c1 ef 1f             	shr    $0x1f,%edi
801005c7:	85 c0                	test   %eax,%eax
801005c9:	89 7d d4             	mov    %edi,-0x2c(%ebp)
801005cc:	78 51                	js     8010061f <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
801005ce:	31 ff                	xor    %edi,%edi
801005d0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005d3:	eb 05                	jmp    801005da <printint+0x2a>
801005d5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005d8:	89 cf                	mov    %ecx,%edi
801005da:	31 d2                	xor    %edx,%edx
801005dc:	8d 4f 01             	lea    0x1(%edi),%ecx
801005df:	f7 f6                	div    %esi
801005e1:	0f b6 92 78 81 10 80 	movzbl -0x7fef7e88(%edx),%edx
  }while((x /= base) != 0);
801005e8:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005ea:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
801005ed:	75 e9                	jne    801005d8 <printint+0x28>

  if(sign)
801005ef:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005f2:	85 c0                	test   %eax,%eax
801005f4:	74 08                	je     801005fe <printint+0x4e>
    buf[i++] = '-';
801005f6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005fb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005fe:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
80100602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
80100608:	0f be 06             	movsbl (%esi),%eax
8010060b:	83 ee 01             	sub    $0x1,%esi
8010060e:	e8 2d ff ff ff       	call   80100540 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
80100613:	39 de                	cmp    %ebx,%esi
80100615:	75 f1                	jne    80100608 <printint+0x58>
    consputc(buf[i]);
}
80100617:	83 c4 2c             	add    $0x2c,%esp
8010061a:	5b                   	pop    %ebx
8010061b:	5e                   	pop    %esi
8010061c:	5f                   	pop    %edi
8010061d:	5d                   	pop    %ebp
8010061e:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
8010061f:	f7 d8                	neg    %eax
80100621:	eb ab                	jmp    801005ce <printint+0x1e>
80100623:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100630 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100630:	55                   	push   %ebp
80100631:	89 e5                	mov    %esp,%ebp
80100633:	57                   	push   %edi
80100634:	56                   	push   %esi
80100635:	53                   	push   %ebx
80100636:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100639:	a1 94 b5 10 80       	mov    0x8010b594,%eax
  if(locking)
8010063e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100640:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100643:	0f 85 47 01 00 00    	jne    80100790 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100649:	8b 45 08             	mov    0x8(%ebp),%eax
8010064c:	85 c0                	test   %eax,%eax
8010064e:	89 c1                	mov    %eax,%ecx
80100650:	0f 84 4f 01 00 00    	je     801007a5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100656:	0f b6 00             	movzbl (%eax),%eax
80100659:	31 db                	xor    %ebx,%ebx
8010065b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010065e:	89 cf                	mov    %ecx,%edi
80100660:	85 c0                	test   %eax,%eax
80100662:	75 55                	jne    801006b9 <cprintf+0x89>
80100664:	eb 68                	jmp    801006ce <cprintf+0x9e>
80100666:	8d 76 00             	lea    0x0(%esi),%esi
80100669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
80100670:	83 c3 01             	add    $0x1,%ebx
80100673:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
80100677:	85 d2                	test   %edx,%edx
80100679:	74 53                	je     801006ce <cprintf+0x9e>
      break;
    switch(c){
8010067b:	83 fa 70             	cmp    $0x70,%edx
8010067e:	74 7a                	je     801006fa <cprintf+0xca>
80100680:	7f 6e                	jg     801006f0 <cprintf+0xc0>
80100682:	83 fa 25             	cmp    $0x25,%edx
80100685:	0f 84 ad 00 00 00    	je     80100738 <cprintf+0x108>
8010068b:	83 fa 64             	cmp    $0x64,%edx
8010068e:	0f 85 84 00 00 00    	jne    80100718 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
80100694:	8d 46 04             	lea    0x4(%esi),%eax
80100697:	b9 01 00 00 00       	mov    $0x1,%ecx
8010069c:	ba 0a 00 00 00       	mov    $0xa,%edx
801006a1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006a4:	8b 06                	mov    (%esi),%eax
801006a6:	e8 05 ff ff ff       	call   801005b0 <printint>
801006ab:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006ae:	83 c3 01             	add    $0x1,%ebx
801006b1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006b5:	85 c0                	test   %eax,%eax
801006b7:	74 15                	je     801006ce <cprintf+0x9e>
    if(c != '%'){
801006b9:	83 f8 25             	cmp    $0x25,%eax
801006bc:	74 b2                	je     80100670 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006be:	e8 7d fe ff ff       	call   80100540 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006c3:	83 c3 01             	add    $0x1,%ebx
801006c6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006ca:	85 c0                	test   %eax,%eax
801006cc:	75 eb                	jne    801006b9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
801006ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
801006d1:	85 c0                	test   %eax,%eax
801006d3:	74 10                	je     801006e5 <cprintf+0xb5>
    release(&cons.lock);
801006d5:	83 ec 0c             	sub    $0xc,%esp
801006d8:	68 60 b5 10 80       	push   $0x8010b560
801006dd:	e8 9e 4a 00 00       	call   80105180 <release>
801006e2:	83 c4 10             	add    $0x10,%esp
}
801006e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006e8:	5b                   	pop    %ebx
801006e9:	5e                   	pop    %esi
801006ea:	5f                   	pop    %edi
801006eb:	5d                   	pop    %ebp
801006ec:	c3                   	ret    
801006ed:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
801006f0:	83 fa 73             	cmp    $0x73,%edx
801006f3:	74 5b                	je     80100750 <cprintf+0x120>
801006f5:	83 fa 78             	cmp    $0x78,%edx
801006f8:	75 1e                	jne    80100718 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801006fa:	8d 46 04             	lea    0x4(%esi),%eax
801006fd:	31 c9                	xor    %ecx,%ecx
801006ff:	ba 10 00 00 00       	mov    $0x10,%edx
80100704:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100707:	8b 06                	mov    (%esi),%eax
80100709:	e8 a2 fe ff ff       	call   801005b0 <printint>
8010070e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100711:	eb 9b                	jmp    801006ae <cprintf+0x7e>
80100713:	90                   	nop
80100714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100718:	b8 25 00 00 00       	mov    $0x25,%eax
8010071d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100720:	e8 1b fe ff ff       	call   80100540 <consputc>
      consputc(c);
80100725:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100728:	89 d0                	mov    %edx,%eax
8010072a:	e8 11 fe ff ff       	call   80100540 <consputc>
      break;
8010072f:	e9 7a ff ff ff       	jmp    801006ae <cprintf+0x7e>
80100734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100738:	b8 25 00 00 00       	mov    $0x25,%eax
8010073d:	e8 fe fd ff ff       	call   80100540 <consputc>
80100742:	e9 7c ff ff ff       	jmp    801006c3 <cprintf+0x93>
80100747:	89 f6                	mov    %esi,%esi
80100749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100750:	8d 46 04             	lea    0x4(%esi),%eax
80100753:	8b 36                	mov    (%esi),%esi
80100755:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100758:	b8 ad 7d 10 80       	mov    $0x80107dad,%eax
8010075d:	85 f6                	test   %esi,%esi
8010075f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100762:	0f be 06             	movsbl (%esi),%eax
80100765:	84 c0                	test   %al,%al
80100767:	74 16                	je     8010077f <cprintf+0x14f>
80100769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100770:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
80100773:	e8 c8 fd ff ff       	call   80100540 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100778:	0f be 06             	movsbl (%esi),%eax
8010077b:	84 c0                	test   %al,%al
8010077d:	75 f1                	jne    80100770 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
8010077f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80100782:	e9 27 ff ff ff       	jmp    801006ae <cprintf+0x7e>
80100787:	89 f6                	mov    %esi,%esi
80100789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
80100790:	83 ec 0c             	sub    $0xc,%esp
80100793:	68 60 b5 10 80       	push   $0x8010b560
80100798:	e8 c3 48 00 00       	call   80105060 <acquire>
8010079d:	83 c4 10             	add    $0x10,%esp
801007a0:	e9 a4 fe ff ff       	jmp    80100649 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007a5:	83 ec 0c             	sub    $0xc,%esp
801007a8:	68 b4 7d 10 80       	push   $0x80107db4
801007ad:	e8 0e 00 00 00       	call   801007c0 <panic>
801007b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007c0 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
801007c0:	55                   	push   %ebp
801007c1:	89 e5                	mov    %esp,%ebp
801007c3:	56                   	push   %esi
801007c4:	53                   	push   %ebx
801007c5:	83 ec 3c             	sub    $0x3c,%esp
801007c8:	fa                   	cli    
  
  cli();
  cons.locking = 0;
  
  //cprintf("cpu%d: panic: ", cpu->id);//!!!此处注释掉后果未知
  cprintf(s);
801007c9:	ff 75 08             	pushl  0x8(%ebp)
{
  int i;
  uint pcs[10];
  
  cli();
  cons.locking = 0;
801007cc:	c7 05 94 b5 10 80 00 	movl   $0x0,0x8010b594
801007d3:	00 00 00 
  
  //cprintf("cpu%d: panic: ", cpu->id);//!!!此处注释掉后果未知
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
801007d6:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801007d9:	8d 75 f8             	lea    -0x8(%ebp),%esi
  
  cli();
  cons.locking = 0;
  
  //cprintf("cpu%d: panic: ", cpu->id);//!!!此处注释掉后果未知
  cprintf(s);
801007dc:	e8 4f fe ff ff       	call   80100630 <cprintf>
  cprintf("\n");
801007e1:	c7 04 24 7b 8a 10 80 	movl   $0x80108a7b,(%esp)
801007e8:	e8 43 fe ff ff       	call   80100630 <cprintf>
  getcallerpcs(&s, pcs);
801007ed:	58                   	pop    %eax
801007ee:	8d 45 08             	lea    0x8(%ebp),%eax
801007f1:	5a                   	pop    %edx
801007f2:	53                   	push   %ebx
801007f3:	50                   	push   %eax
801007f4:	e8 87 47 00 00       	call   80104f80 <getcallerpcs>
801007f9:	83 c4 10             	add    $0x10,%esp
801007fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
80100800:	83 ec 08             	sub    $0x8,%esp
80100803:	ff 33                	pushl  (%ebx)
80100805:	83 c3 04             	add    $0x4,%ebx
80100808:	68 bd 7d 10 80       	push   $0x80107dbd
8010080d:	e8 1e fe ff ff       	call   80100630 <cprintf>
  
  //cprintf("cpu%d: panic: ", cpu->id);//!!!此处注释掉后果未知
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
80100812:	83 c4 10             	add    $0x10,%esp
80100815:	39 f3                	cmp    %esi,%ebx
80100817:	75 e7                	jne    80100800 <panic+0x40>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
80100819:	c7 05 98 b5 10 80 01 	movl   $0x1,0x8010b598
80100820:	00 00 00 
80100823:	eb fe                	jmp    80100823 <panic+0x63>
80100825:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100830 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100830:	55                   	push   %ebp
80100831:	89 e5                	mov    %esp,%ebp
80100833:	57                   	push   %edi
80100834:	56                   	push   %esi
80100835:	53                   	push   %ebx
80100836:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100839:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010083c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010083f:	e8 cc 1c 00 00       	call   80102510 <iunlock>
  acquire(&cons.lock);
80100844:	c7 04 24 60 b5 10 80 	movl   $0x8010b560,(%esp)
8010084b:	e8 10 48 00 00       	call   80105060 <acquire>
80100850:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100853:	83 c4 10             	add    $0x10,%esp
80100856:	85 f6                	test   %esi,%esi
80100858:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010085b:	7e 12                	jle    8010086f <consolewrite+0x3f>
8010085d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100860:	0f b6 07             	movzbl (%edi),%eax
80100863:	83 c7 01             	add    $0x1,%edi
80100866:	e8 d5 fc ff ff       	call   80100540 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010086b:	39 df                	cmp    %ebx,%edi
8010086d:	75 f1                	jne    80100860 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010086f:	83 ec 0c             	sub    $0xc,%esp
80100872:	68 60 b5 10 80       	push   $0x8010b560
80100877:	e8 04 49 00 00       	call   80105180 <release>
  ilock(ip);
8010087c:	58                   	pop    %eax
8010087d:	ff 75 08             	pushl  0x8(%ebp)
80100880:	e8 ab 1b 00 00       	call   80102430 <ilock>

  return n;
}
80100885:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100888:	89 f0                	mov    %esi,%eax
8010088a:	5b                   	pop    %ebx
8010088b:	5e                   	pop    %esi
8010088c:	5f                   	pop    %edi
8010088d:	5d                   	pop    %ebp
8010088e:	c3                   	ret    
8010088f:	90                   	nop

80100890 <showPage>:
    }
  }
  return;
}

void showPage(int line){
80100890:	55                   	push   %ebp
80100891:	31 c9                	xor    %ecx,%ecx
80100893:	89 e5                	mov    %esp,%ebp
80100895:	57                   	push   %edi
80100896:	56                   	push   %esi
80100897:	53                   	push   %ebx
80100898:	83 ec 04             	sub    $0x4,%esp
8010089b:	8b 7d 08             	mov    0x8(%ebp),%edi
8010089e:	8d 04 bf             	lea    (%edi,%edi,4),%eax
801008a1:	69 ff 60 ff ff ff    	imul   $0xffffff60,%edi,%edi
801008a7:	c1 e0 05             	shl    $0x5,%eax
801008aa:	05 60 10 11 80       	add    $0x80111060,%eax
801008af:	90                   	nop
  int i,j;
  for(i = 0; i < rows; i++){
    for(j = 0; j < 80; j++)
      crt[i*80+j] = screenHistory[i+line][j];
801008b0:	89 fb                	mov    %edi,%ebx
801008b2:	8d b0 a0 00 00 00    	lea    0xa0(%eax),%esi
801008b8:	89 7d f0             	mov    %edi,-0x10(%ebp)
801008bb:	81 eb 60 10 11 80    	sub    $0x80111060,%ebx
801008c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801008c8:	0f b7 38             	movzwl (%eax),%edi
801008cb:	8d 14 03             	lea    (%ebx,%eax,1),%edx
801008ce:	83 c0 02             	add    $0x2,%eax
}

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
    for(j = 0; j < 80; j++)
801008d1:	39 f0                	cmp    %esi,%eax
      crt[i*80+j] = screenHistory[i+line][j];
801008d3:	66 89 bc 4a 00 80 0b 	mov    %di,-0x7ff48000(%edx,%ecx,2)
801008da:	80 
}

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
    for(j = 0; j < 80; j++)
801008db:	75 eb                	jne    801008c8 <showPage+0x38>
801008dd:	8b 7d f0             	mov    -0x10(%ebp),%edi
801008e0:	83 c1 50             	add    $0x50,%ecx
801008e3:	81 ef a0 00 00 00    	sub    $0xa0,%edi
  return;
}

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
801008e9:	81 f9 80 07 00 00    	cmp    $0x780,%ecx
801008ef:	75 bf                	jne    801008b0 <showPage+0x20>
    for(j = 0; j < 80; j++)
      crt[i*80+j] = screenHistory[i+line][j];
  }
}
801008f1:	83 c4 04             	add    $0x4,%esp
801008f4:	5b                   	pop    %ebx
801008f5:	5e                   	pop    %esi
801008f6:	5f                   	pop    %edi
801008f7:	5d                   	pop    %ebp
801008f8:	c3                   	ret    
801008f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100900 <pageEnd>:

void pageEnd(){
80100900:	55                   	push   %ebp
80100901:	89 e5                	mov    %esp,%ebp
80100903:	57                   	push   %edi
80100904:	56                   	push   %esi
80100905:	53                   	push   %ebx
80100906:	83 ec 04             	sub    $0x4,%esp
  if((screenHistoryLen - startScreenLine) <= rows)
80100909:	8b 3d 34 b5 10 80    	mov    0x8010b534,%edi
8010090f:	89 f8                	mov    %edi,%eax
80100911:	2b 05 30 b5 10 80    	sub    0x8010b530,%eax
80100917:	83 f8 18             	cmp    $0x18,%eax
8010091a:	7e 65                	jle    80100981 <pageEnd+0x81>
    return;
  startScreenLine = screenHistoryLen-rows;
8010091c:	83 ef 18             	sub    $0x18,%edi
8010091f:	31 c9                	xor    %ecx,%ecx
80100921:	8d 04 bf             	lea    (%edi,%edi,4),%eax
80100924:	89 3d 30 b5 10 80    	mov    %edi,0x8010b530
8010092a:	69 ff 60 ff ff ff    	imul   $0xffffff60,%edi,%edi
80100930:	c1 e0 05             	shl    $0x5,%eax
80100933:	05 60 10 11 80       	add    $0x80111060,%eax
80100938:	90                   	nop
80100939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
    for(j = 0; j < 80; j++)
      crt[i*80+j] = screenHistory[i+line][j];
80100940:	89 fb                	mov    %edi,%ebx
80100942:	8d b0 a0 00 00 00    	lea    0xa0(%eax),%esi
80100948:	89 7d f0             	mov    %edi,-0x10(%ebp)
8010094b:	81 eb 60 10 11 80    	sub    $0x80111060,%ebx
80100951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100958:	0f b7 38             	movzwl (%eax),%edi
8010095b:	8d 14 03             	lea    (%ebx,%eax,1),%edx
8010095e:	83 c0 02             	add    $0x2,%eax
}

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
    for(j = 0; j < 80; j++)
80100961:	39 f0                	cmp    %esi,%eax
      crt[i*80+j] = screenHistory[i+line][j];
80100963:	66 89 bc 4a 00 80 0b 	mov    %di,-0x7ff48000(%edx,%ecx,2)
8010096a:	80 
}

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
    for(j = 0; j < 80; j++)
8010096b:	75 eb                	jne    80100958 <pageEnd+0x58>
8010096d:	8b 7d f0             	mov    -0x10(%ebp),%edi
80100970:	83 c1 50             	add    $0x50,%ecx
80100973:	81 ef a0 00 00 00    	sub    $0xa0,%edi
  return;
}

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
80100979:	81 f9 80 07 00 00    	cmp    $0x780,%ecx
8010097f:	75 bf                	jne    80100940 <pageEnd+0x40>
  if((screenHistoryLen - startScreenLine) <= rows)
    return;
  startScreenLine = screenHistoryLen-rows;
  showPage(startScreenLine);
  return;
}
80100981:	83 c4 04             	add    $0x4,%esp
80100984:	5b                   	pop    %ebx
80100985:	5e                   	pop    %esi
80100986:	5f                   	pop    %edi
80100987:	5d                   	pop    %ebp
80100988:	c3                   	ret    
80100989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100990 <pageUp>:

void pageUp(){
80100990:	55                   	push   %ebp
80100991:	89 e5                	mov    %esp,%ebp
80100993:	57                   	push   %edi
80100994:	56                   	push   %esi
80100995:	53                   	push   %ebx
80100996:	83 ec 04             	sub    $0x4,%esp
  if(startScreenLine > 0){
80100999:	8b 3d 30 b5 10 80    	mov    0x8010b530,%edi
8010099f:	85 ff                	test   %edi,%edi
801009a1:	7e 6e                	jle    80100a11 <pageUp+0x81>
    if((screenHistoryLen - startScreenLine) == rows){
801009a3:	a1 34 b5 10 80       	mov    0x8010b534,%eax
801009a8:	29 f8                	sub    %edi,%eax
801009aa:	83 f8 18             	cmp    $0x18,%eax
801009ad:	74 6a                	je     80100a19 <pageUp+0x89>
      recordScreenHistory();
    }
    startScreenLine--;
801009af:	83 ef 01             	sub    $0x1,%edi
801009b2:	31 c9                	xor    %ecx,%ecx
801009b4:	8d 04 bf             	lea    (%edi,%edi,4),%eax
801009b7:	89 3d 30 b5 10 80    	mov    %edi,0x8010b530
801009bd:	69 ff 60 ff ff ff    	imul   $0xffffff60,%edi,%edi
801009c3:	c1 e0 05             	shl    $0x5,%eax
801009c6:	05 60 10 11 80       	add    $0x80111060,%eax
801009cb:	90                   	nop
801009cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
    for(j = 0; j < 80; j++)
      crt[i*80+j] = screenHistory[i+line][j];
801009d0:	89 fb                	mov    %edi,%ebx
801009d2:	8d b0 a0 00 00 00    	lea    0xa0(%eax),%esi
801009d8:	89 7d f0             	mov    %edi,-0x10(%ebp)
801009db:	81 eb 60 10 11 80    	sub    $0x80111060,%ebx
801009e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009e8:	0f b7 38             	movzwl (%eax),%edi
801009eb:	8d 14 03             	lea    (%ebx,%eax,1),%edx
801009ee:	83 c0 02             	add    $0x2,%eax
}

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
    for(j = 0; j < 80; j++)
801009f1:	39 f0                	cmp    %esi,%eax
      crt[i*80+j] = screenHistory[i+line][j];
801009f3:	66 89 bc 4a 00 80 0b 	mov    %di,-0x7ff48000(%edx,%ecx,2)
801009fa:	80 
}

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
    for(j = 0; j < 80; j++)
801009fb:	75 eb                	jne    801009e8 <pageUp+0x58>
801009fd:	8b 7d f0             	mov    -0x10(%ebp),%edi
80100a00:	83 c1 50             	add    $0x50,%ecx
80100a03:	81 ef a0 00 00 00    	sub    $0xa0,%edi
  return;
}

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
80100a09:	81 f9 80 07 00 00    	cmp    $0x780,%ecx
80100a0f:	75 bf                	jne    801009d0 <pageUp+0x40>
    startScreenLine--;
    showPage(startScreenLine);
  }
 // cprintf("startScreenLine:%d\n", startScreenLine);
  return;
}
80100a11:	83 c4 04             	add    $0x4,%esp
80100a14:	5b                   	pop    %ebx
80100a15:	5e                   	pop    %esi
80100a16:	5f                   	pop    %edi
80100a17:	5d                   	pop    %ebp
80100a18:	c3                   	ret    
}

void pageUp(){
  if(startScreenLine > 0){
    if((screenHistoryLen - startScreenLine) == rows){
      recordScreenHistory();
80100a19:	e8 52 f9 ff ff       	call   80100370 <recordScreenHistory>
80100a1e:	8b 3d 30 b5 10 80    	mov    0x8010b530,%edi
80100a24:	eb 89                	jmp    801009af <pageUp+0x1f>
80100a26:	8d 76 00             	lea    0x0(%esi),%esi
80100a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100a30 <pageDown>:
  }
 // cprintf("startScreenLine:%d\n", startScreenLine);
  return;
}

void pageDown(){
80100a30:	55                   	push   %ebp
80100a31:	89 e5                	mov    %esp,%ebp
80100a33:	57                   	push   %edi
80100a34:	56                   	push   %esi
80100a35:	53                   	push   %ebx
80100a36:	83 ec 04             	sub    $0x4,%esp
  if((screenHistoryLen - startScreenLine) > rows){
80100a39:	8b 3d 30 b5 10 80    	mov    0x8010b530,%edi
80100a3f:	a1 34 b5 10 80       	mov    0x8010b534,%eax
80100a44:	29 f8                	sub    %edi,%eax
80100a46:	83 f8 18             	cmp    $0x18,%eax
80100a49:	7e 66                	jle    80100ab1 <pageDown+0x81>
    startScreenLine++;
80100a4b:	83 c7 01             	add    $0x1,%edi
80100a4e:	31 c9                	xor    %ecx,%ecx
80100a50:	8d 04 bf             	lea    (%edi,%edi,4),%eax
80100a53:	89 3d 30 b5 10 80    	mov    %edi,0x8010b530
80100a59:	69 ff 60 ff ff ff    	imul   $0xffffff60,%edi,%edi
80100a5f:	c1 e0 05             	shl    $0x5,%eax
80100a62:	05 60 10 11 80       	add    $0x80111060,%eax
80100a67:	89 f6                	mov    %esi,%esi
80100a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
    for(j = 0; j < 80; j++)
      crt[i*80+j] = screenHistory[i+line][j];
80100a70:	89 fb                	mov    %edi,%ebx
80100a72:	8d b0 a0 00 00 00    	lea    0xa0(%eax),%esi
80100a78:	89 7d f0             	mov    %edi,-0x10(%ebp)
80100a7b:	81 eb 60 10 11 80    	sub    $0x80111060,%ebx
80100a81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a88:	0f b7 38             	movzwl (%eax),%edi
80100a8b:	8d 14 03             	lea    (%ebx,%eax,1),%edx
80100a8e:	83 c0 02             	add    $0x2,%eax
}

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
    for(j = 0; j < 80; j++)
80100a91:	39 f0                	cmp    %esi,%eax
      crt[i*80+j] = screenHistory[i+line][j];
80100a93:	66 89 bc 4a 00 80 0b 	mov    %di,-0x7ff48000(%edx,%ecx,2)
80100a9a:	80 
}

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
    for(j = 0; j < 80; j++)
80100a9b:	75 eb                	jne    80100a88 <pageDown+0x58>
80100a9d:	8b 7d f0             	mov    -0x10(%ebp),%edi
80100aa0:	83 c1 50             	add    $0x50,%ecx
80100aa3:	81 ef a0 00 00 00    	sub    $0xa0,%edi
  return;
}

void showPage(int line){
  int i,j;
  for(i = 0; i < rows; i++){
80100aa9:	81 f9 80 07 00 00    	cmp    $0x780,%ecx
80100aaf:	75 bf                	jne    80100a70 <pageDown+0x40>
  if((screenHistoryLen - startScreenLine) > rows){
    startScreenLine++;
      showPage(startScreenLine);
  }
  return;
}
80100ab1:	83 c4 04             	add    $0x4,%esp
80100ab4:	5b                   	pop    %ebx
80100ab5:	5e                   	pop    %esi
80100ab6:	5f                   	pop    %edi
80100ab7:	5d                   	pop    %ebp
80100ab8:	c3                   	ret    
80100ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ac0 <pageHome>:

// can be advanced, but keep it
void pageHome(){
  while(startScreenLine > 0){
80100ac0:	8b 15 30 b5 10 80    	mov    0x8010b530,%edx
80100ac6:	85 d2                	test   %edx,%edx
80100ac8:	7e 15                	jle    80100adf <pageHome+0x1f>
  }
  return;
}

// can be advanced, but keep it
void pageHome(){
80100aca:	55                   	push   %ebp
80100acb:	89 e5                	mov    %esp,%ebp
80100acd:	8d 76 00             	lea    0x0(%esi),%esi
  while(startScreenLine > 0){
    pageUp();
80100ad0:	e8 bb fe ff ff       	call   80100990 <pageUp>
  return;
}

// can be advanced, but keep it
void pageHome(){
  while(startScreenLine > 0){
80100ad5:	a1 30 b5 10 80       	mov    0x8010b530,%eax
80100ada:	85 c0                	test   %eax,%eax
80100adc:	7f f2                	jg     80100ad0 <pageHome+0x10>
    pageUp();
  }
  return;
}
80100ade:	5d                   	pop    %ebp
80100adf:	f3 c3                	repz ret 
80100ae1:	eb 0d                	jmp    80100af0 <switchMode>
80100ae3:	90                   	nop
80100ae4:	90                   	nop
80100ae5:	90                   	nop
80100ae6:	90                   	nop
80100ae7:	90                   	nop
80100ae8:	90                   	nop
80100ae9:	90                   	nop
80100aea:	90                   	nop
80100aeb:	90                   	nop
80100aec:	90                   	nop
80100aed:	90                   	nop
80100aee:	90                   	nop
80100aef:	90                   	nop

80100af0 <switchMode>:

int switchMode(int pos){
80100af0:	55                   	push   %ebp
80100af1:	89 e5                	mov    %esp,%ebp
80100af3:	83 ec 04             	sub    $0x4,%esp
  if(shellStatus == SHELL){
80100af6:	8b 15 2c b5 10 80    	mov    0x8010b52c,%edx
    pageUp();
  }
  return;
}

int switchMode(int pos){
80100afc:	8b 45 08             	mov    0x8(%ebp),%eax
  if(shellStatus == SHELL){
80100aff:	85 d2                	test   %edx,%edx
80100b01:	74 0d                	je     80100b10 <switchMode+0x20>
    mainPos = pos;
    pos = memoPos;
    shellStatus = MEMO;
  }
  else if(shellStatus == MEMO){
80100b03:	83 fa 01             	cmp    $0x1,%edx
80100b06:	74 28                	je     80100b30 <switchMode+0x40>
    shellStatus = SHELL;

  }
  // show('a');show('f');show(':');
  return pos;
}
80100b08:	c9                   	leave  
80100b09:	c3                   	ret    
80100b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return;
}

int switchMode(int pos){
  if(shellStatus == SHELL){
    mainPos = pos;
80100b10:	a3 28 b5 10 80       	mov    %eax,0x8010b528
    pos = memoPos;
    shellStatus = MEMO;
80100b15:	c7 05 2c b5 10 80 01 	movl   $0x1,0x8010b52c
80100b1c:	00 00 00 
}

int switchMode(int pos){
  if(shellStatus == SHELL){
    mainPos = pos;
    pos = memoPos;
80100b1f:	a1 00 90 10 80       	mov    0x80109000,%eax
    shellStatus = SHELL;

  }
  // show('a');show('f');show(':');
  return pos;
}
80100b24:	c9                   	leave  
80100b25:	c3                   	ret    
80100b26:	8d 76 00             	lea    0x0(%esi),%esi
80100b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80100b30:	89 45 fc             	mov    %eax,-0x4(%ebp)
    mainPos = pos;
    pos = memoPos;
    shellStatus = MEMO;
  }
  else if(shellStatus == MEMO){
    pageEnd();
80100b33:	e8 c8 fd ff ff       	call   80100900 <pageEnd>
    memoPos = pos;
80100b38:	8b 45 fc             	mov    -0x4(%ebp),%eax
    pos = mainPos;
    //cprintf("mainPos:%d (%d %d)\n",mainPos, mainPos/80,mainPos%80);
    shellStatus = SHELL;
80100b3b:	c7 05 2c b5 10 80 00 	movl   $0x0,0x8010b52c
80100b42:	00 00 00 
    pos = memoPos;
    shellStatus = MEMO;
  }
  else if(shellStatus == MEMO){
    pageEnd();
    memoPos = pos;
80100b45:	a3 00 90 10 80       	mov    %eax,0x80109000
    pos = mainPos;
80100b4a:	a1 28 b5 10 80       	mov    0x8010b528,%eax
    shellStatus = SHELL;

  }
  // show('a');show('f');show(':');
  return pos;
}
80100b4f:	c9                   	leave  
80100b50:	c3                   	ret    
80100b51:	eb 0d                	jmp    80100b60 <getcursor>
80100b53:	90                   	nop
80100b54:	90                   	nop
80100b55:	90                   	nop
80100b56:	90                   	nop
80100b57:	90                   	nop
80100b58:	90                   	nop
80100b59:	90                   	nop
80100b5a:	90                   	nop
80100b5b:	90                   	nop
80100b5c:	90                   	nop
80100b5d:	90                   	nop
80100b5e:	90                   	nop
80100b5f:	90                   	nop

80100b60 <getcursor>:
  cgaputc(c);
}

int
getcursor()
{
80100b60:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b61:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100b66:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b6b:	89 e5                	mov    %esp,%ebp
80100b6d:	53                   	push   %ebx
80100b6e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b6f:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100b74:	89 da                	mov    %ebx,%edx
80100b76:	ec                   	in     (%dx),%al
    int pos;
    // Cursor position: col + 80*row.
    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
80100b77:	0f b6 c8             	movzbl %al,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b7a:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100b7f:	b8 0f 00 00 00       	mov    $0xf,%eax
80100b84:	c1 e1 08             	shl    $0x8,%ecx
80100b87:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b88:	89 da                	mov    %ebx,%edx
80100b8a:	ec                   	in     (%dx),%al
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
    return pos;
80100b8b:	0f b6 c0             	movzbl %al,%eax
80100b8e:	09 c8                	or     %ecx,%eax
}
80100b90:	5b                   	pop    %ebx
80100b91:	5d                   	pop    %ebp
80100b92:	c3                   	ret    
80100b93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100ba0 <setcursor>:

void
setcursor(int pos)
{
80100ba0:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100ba1:	b8 0e 00 00 00       	mov    $0xe,%eax
80100ba6:	89 e5                	mov    %esp,%ebp
80100ba8:	57                   	push   %edi
80100ba9:	56                   	push   %esi
80100baa:	53                   	push   %ebx
80100bab:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100bb0:	89 fa                	mov    %edi,%edx
80100bb2:	83 ec 0c             	sub    $0xc,%esp
80100bb5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100bb8:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100bb9:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100bbe:	89 ca                	mov    %ecx,%edx
80100bc0:	ec                   	in     (%dx),%al
80100bc1:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100bc3:	89 fa                	mov    %edi,%edx
80100bc5:	b8 0f 00 00 00       	mov    $0xf,%eax
80100bca:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100bcb:	89 ca                	mov    %ecx,%edx
80100bcd:	ec                   	in     (%dx),%al
80100bce:	0f b6 c8             	movzbl %al,%ecx
    int pos;
    // Cursor position: col + 80*row.
    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
80100bd1:	89 f0                	mov    %esi,%eax
80100bd3:	0f b6 c0             	movzbl %al,%eax
80100bd6:	c1 e0 08             	shl    $0x8,%eax
80100bd9:	09 c8                	or     %ecx,%eax

void
setcursor(int pos)
{
    int old = getcursor();
    if (pos == -1)
80100bdb:	83 fb ff             	cmp    $0xffffffff,%ebx
80100bde:	0f 84 7c 00 00 00    	je     80100c60 <setcursor+0xc0>
        pos = old + 80 - old % 80;
    else
        input.e += pos - old;
80100be4:	89 df                	mov    %ebx,%edi
80100be6:	29 c7                	sub    %eax,%edi
80100be8:	01 3d 3c 10 11 80    	add    %edi,0x8011103c

    if((pos/80) >= 24){  // Scroll up.
80100bee:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100bf4:	7e 39                	jle    80100c2f <setcursor+0x8f>
        memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100bf6:	83 ec 04             	sub    $0x4,%esp
        pos -= 80;
80100bf9:	83 eb 50             	sub    $0x50,%ebx
        pos = old + 80 - old % 80;
    else
        input.e += pos - old;

    if((pos/80) >= 24){  // Scroll up.
        memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100bfc:	68 60 0e 00 00       	push   $0xe60
80100c01:	68 a0 80 0b 80       	push   $0x800b80a0
80100c06:	68 00 80 0b 80       	push   $0x800b8000
80100c0b:	e8 70 46 00 00       	call   80105280 <memmove>
        pos -= 80;
        memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100c10:	b8 80 07 00 00       	mov    $0x780,%eax
80100c15:	83 c4 0c             	add    $0xc,%esp
80100c18:	29 d8                	sub    %ebx,%eax
80100c1a:	01 c0                	add    %eax,%eax
80100c1c:	50                   	push   %eax
80100c1d:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100c24:	6a 00                	push   $0x0
80100c26:	50                   	push   %eax
80100c27:	e8 a4 45 00 00       	call   801051d0 <memset>
80100c2c:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100c2f:	be d4 03 00 00       	mov    $0x3d4,%esi
80100c34:	b8 0e 00 00 00       	mov    $0xe,%eax
80100c39:	89 f2                	mov    %esi,%edx
80100c3b:	ee                   	out    %al,(%dx)
80100c3c:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100c41:	89 d8                	mov    %ebx,%eax
80100c43:	c1 f8 08             	sar    $0x8,%eax
80100c46:	89 ca                	mov    %ecx,%edx
80100c48:	ee                   	out    %al,(%dx)
80100c49:	b8 0f 00 00 00       	mov    $0xf,%eax
80100c4e:	89 f2                	mov    %esi,%edx
80100c50:	ee                   	out    %al,(%dx)
80100c51:	89 d8                	mov    %ebx,%eax
80100c53:	89 ca                	mov    %ecx,%edx
80100c55:	ee                   	out    %al,(%dx)
    }   
    outb(CRTPORT, 14);
    outb(CRTPORT+1, pos>>8);
    outb(CRTPORT, 15);
    outb(CRTPORT+1, pos);
}
80100c56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c59:	5b                   	pop    %ebx
80100c5a:	5e                   	pop    %esi
80100c5b:	5f                   	pop    %edi
80100c5c:	5d                   	pop    %ebp
80100c5d:	c3                   	ret    
80100c5e:	66 90                	xchg   %ax,%ax
void
setcursor(int pos)
{
    int old = getcursor();
    if (pos == -1)
        pos = old + 80 - old % 80;
80100c60:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100c65:	f7 ea                	imul   %edx
80100c67:	c1 ea 05             	shr    $0x5,%edx
80100c6a:	8d 1c 92             	lea    (%edx,%edx,4),%ebx
80100c6d:	c1 e3 04             	shl    $0x4,%ebx
80100c70:	83 c3 50             	add    $0x50,%ebx
80100c73:	e9 76 ff ff ff       	jmp    80100bee <setcursor+0x4e>
80100c78:	90                   	nop
80100c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100c80 <insertc>:
    outb(CRTPORT+1, pos);
}

void 
insertc(int c)
{
80100c80:	55                   	push   %ebp
80100c81:	b8 0e 00 00 00       	mov    $0xe,%eax
80100c86:	89 e5                	mov    %esp,%ebp
80100c88:	57                   	push   %edi
80100c89:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100c8e:	56                   	push   %esi
80100c8f:	89 fa                	mov    %edi,%edx
80100c91:	53                   	push   %ebx
80100c92:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100c95:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100c96:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100c9b:	89 ca                	mov    %ecx,%edx
80100c9d:	ec                   	in     (%dx),%al
80100c9e:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100ca0:	89 fa                	mov    %edi,%edx
80100ca2:	b8 0f 00 00 00       	mov    $0xf,%eax
80100ca7:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100ca8:	89 ca                	mov    %ecx,%edx
80100caa:	ec                   	in     (%dx),%al
    int pos = getcursor();
    int i, j;
    if (c != 0 && input.l - input.r < INPUT_BUF){
80100cab:	85 db                	test   %ebx,%ebx
80100cad:	0f 84 a5 00 00 00    	je     80100d58 <insertc+0xd8>
80100cb3:	8b 15 40 10 11 80    	mov    0x80111040,%edx
80100cb9:	89 d1                	mov    %edx,%ecx
80100cbb:	2b 0d 34 10 11 80    	sub    0x80111034,%ecx
80100cc1:	83 f9 7f             	cmp    $0x7f,%ecx
80100cc4:	0f 87 8e 00 00 00    	ja     80100d58 <insertc+0xd8>
    int pos;
    // Cursor position: col + 80*row.
    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
80100cca:	89 f1                	mov    %esi,%ecx
80100ccc:	0f b6 c0             	movzbl %al,%eax
insertc(int c)
{
    int pos = getcursor();
    int i, j;
    if (c != 0 && input.l - input.r < INPUT_BUF){
        for (i = input.l, j = pos + input.l - input.e; i > input.e; --i, --j){
80100ccf:	89 d7                	mov    %edx,%edi
    int pos;
    // Cursor position: col + 80*row.
    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
80100cd1:	0f b6 f1             	movzbl %cl,%esi
insertc(int c)
{
    int pos = getcursor();
    int i, j;
    if (c != 0 && input.l - input.r < INPUT_BUF){
        for (i = input.l, j = pos + input.l - input.e; i > input.e; --i, --j){
80100cd4:	8b 0d 3c 10 11 80    	mov    0x8011103c,%ecx
    int pos;
    // Cursor position: col + 80*row.
    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
80100cda:	c1 e6 08             	shl    $0x8,%esi
80100cdd:	09 c6                	or     %eax,%esi
insertc(int c)
{
    int pos = getcursor();
    int i, j;
    if (c != 0 && input.l - input.r < INPUT_BUF){
        for (i = input.l, j = pos + input.l - input.e; i > input.e; --i, --j){
80100cdf:	89 d0                	mov    %edx,%eax
80100ce1:	29 cf                	sub    %ecx,%edi
80100ce3:	01 f7                	add    %esi,%edi
80100ce5:	39 ca                	cmp    %ecx,%edx
80100ce7:	76 35                	jbe    80100d1e <insertc+0x9e>
80100ce9:	8d 94 3f fe 7f 0b 80 	lea    -0x7ff48002(%edi,%edi,1),%edx
            input.buf[i] = input.buf[i - 1];
80100cf0:	83 e8 01             	sub    $0x1,%eax
80100cf3:	0f b6 88 b4 0f 11 80 	movzbl -0x7feef04c(%eax),%ecx
80100cfa:	83 ea 02             	sub    $0x2,%edx
80100cfd:	88 88 b5 0f 11 80    	mov    %cl,-0x7feef04b(%eax)
            crt[j] = crt[j - 1] | WHITE_ON_BLACK;
80100d03:	0f b7 4a 02          	movzwl 0x2(%edx),%ecx
80100d07:	80 cd 07             	or     $0x7,%ch
80100d0a:	66 89 4a 04          	mov    %cx,0x4(%edx)
insertc(int c)
{
    int pos = getcursor();
    int i, j;
    if (c != 0 && input.l - input.r < INPUT_BUF){
        for (i = input.l, j = pos + input.l - input.e; i > input.e; --i, --j){
80100d0e:	8b 0d 3c 10 11 80    	mov    0x8011103c,%ecx
80100d14:	39 c1                	cmp    %eax,%ecx
80100d16:	72 d8                	jb     80100cf0 <insertc+0x70>
80100d18:	8b 15 40 10 11 80    	mov    0x80111040,%edx
            input.buf[i] = input.buf[i - 1];
            crt[j] = crt[j - 1] | WHITE_ON_BLACK;
        }
        input.buf[input.e % INPUT_BUF] = c;
80100d1e:	89 c8                	mov    %ecx,%eax
        
        input.l++;
80100d20:	83 c2 01             	add    $0x1,%edx
    if (c != 0 && input.l - input.r < INPUT_BUF){
        for (i = input.l, j = pos + input.l - input.e; i > input.e; --i, --j){
            input.buf[i] = input.buf[i - 1];
            crt[j] = crt[j - 1] | WHITE_ON_BLACK;
        }
        input.buf[input.e % INPUT_BUF] = c;
80100d23:	83 e0 7f             	and    $0x7f,%eax
        
        input.l++;
        
        if (c == '\n'){
80100d26:	83 fb 0a             	cmp    $0xa,%ebx
            input.buf[i] = input.buf[i - 1];
            crt[j] = crt[j - 1] | WHITE_ON_BLACK;
        }
        input.buf[input.e % INPUT_BUF] = c;
        
        input.l++;
80100d29:	89 15 40 10 11 80    	mov    %edx,0x80111040
    if (c != 0 && input.l - input.r < INPUT_BUF){
        for (i = input.l, j = pos + input.l - input.e; i > input.e; --i, --j){
            input.buf[i] = input.buf[i - 1];
            crt[j] = crt[j - 1] | WHITE_ON_BLACK;
        }
        input.buf[input.e % INPUT_BUF] = c;
80100d2f:	88 98 b4 0f 11 80    	mov    %bl,-0x7feef04c(%eax)
        
        input.l++;
        
        if (c == '\n'){
80100d35:	74 26                	je     80100d5d <insertc+0xdd>
            input.e++;
            setcursor(-1);
        }
        else
        {
            crt[pos++] = (c & 0xff) | WHITE_ON_BLACK;
80100d37:	0f b6 db             	movzbl %bl,%ebx
80100d3a:	80 cf 07             	or     $0x7,%bh
80100d3d:	66 89 9c 36 00 80 0b 	mov    %bx,-0x7ff48000(%esi,%esi,1)
80100d44:	80 
            setcursor(pos);
80100d45:	83 c6 01             	add    $0x1,%esi
80100d48:	89 75 08             	mov    %esi,0x8(%ebp)
        }

    }
}
80100d4b:	5b                   	pop    %ebx
80100d4c:	5e                   	pop    %esi
80100d4d:	5f                   	pop    %edi
80100d4e:	5d                   	pop    %ebp
            setcursor(-1);
        }
        else
        {
            crt[pos++] = (c & 0xff) | WHITE_ON_BLACK;
            setcursor(pos);
80100d4f:	e9 4c fe ff ff       	jmp    80100ba0 <setcursor>
80100d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        }

    }
}
80100d58:	5b                   	pop    %ebx
80100d59:	5e                   	pop    %esi
80100d5a:	5f                   	pop    %edi
80100d5b:	5d                   	pop    %ebp
80100d5c:	c3                   	ret    
        input.buf[input.e % INPUT_BUF] = c;
        
        input.l++;
        
        if (c == '\n'){
            input.e++;
80100d5d:	83 c1 01             	add    $0x1,%ecx
            setcursor(-1);
80100d60:	c7 45 08 ff ff ff ff 	movl   $0xffffffff,0x8(%ebp)
        input.buf[input.e % INPUT_BUF] = c;
        
        input.l++;
        
        if (c == '\n'){
            input.e++;
80100d67:	89 0d 3c 10 11 80    	mov    %ecx,0x8011103c
80100d6d:	eb dc                	jmp    80100d4b <insertc+0xcb>
80100d6f:	90                   	nop

80100d70 <replacec>:
    }
}

void
replacec(int c)
{
80100d70:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d71:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100d76:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d7b:	89 e5                	mov    %esp,%ebp
80100d7d:	56                   	push   %esi
80100d7e:	53                   	push   %ebx
80100d7f:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100d82:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d83:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100d88:	89 ca                	mov    %ecx,%edx
80100d8a:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d8b:	ba d4 03 00 00       	mov    $0x3d4,%edx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d90:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d92:	b8 0f 00 00 00       	mov    $0xf,%eax
80100d97:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d98:	89 ca                	mov    %ecx,%edx
80100d9a:	ec                   	in     (%dx),%al
80100d9b:	0f b6 c8             	movzbl %al,%ecx
    int pos = getcursor();
    input.buf[input.e] = c;
80100d9e:	a1 3c 10 11 80       	mov    0x8011103c,%eax
80100da3:	88 98 b4 0f 11 80    	mov    %bl,-0x7feef04c(%eax)
    crt[pos] = c;
80100da9:	89 f0                	mov    %esi,%eax
80100dab:	0f b6 c0             	movzbl %al,%eax
80100dae:	c1 e0 08             	shl    $0x8,%eax
80100db1:	09 c8                	or     %ecx,%eax
80100db3:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100dba:	80 
}
80100dbb:	5b                   	pop    %ebx
80100dbc:	5e                   	pop    %esi
80100dbd:	5d                   	pop    %ebp
80100dbe:	c3                   	ret    
80100dbf:	90                   	nop

80100dc0 <deletec>:

//Delete a character at pos
//mode 0,backspace 1,delete
void
deletec(int mode)
{
80100dc0:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100dc1:	b8 0e 00 00 00       	mov    $0xe,%eax
80100dc6:	89 e5                	mov    %esp,%ebp
80100dc8:	57                   	push   %edi
80100dc9:	56                   	push   %esi
80100dca:	53                   	push   %ebx
80100dcb:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100dd0:	89 fa                	mov    %edi,%edx
80100dd2:	83 ec 1c             	sub    $0x1c,%esp
80100dd5:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100dd6:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100ddb:	89 ca                	mov    %ecx,%edx
80100ddd:	ec                   	in     (%dx),%al
80100dde:	0f b6 f0             	movzbl %al,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100de1:	89 fa                	mov    %edi,%edx
80100de3:	b8 0f 00 00 00       	mov    $0xf,%eax
80100de8:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100de9:	89 ca                	mov    %ecx,%edx
80100deb:	ec                   	in     (%dx),%al
    int pos = getcursor();
    if (mode == 0){
80100dec:	8b 55 08             	mov    0x8(%ebp),%edx
    int pos;
    // Cursor position: col + 80*row.
    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
80100def:	c1 e6 08             	shl    $0x8,%esi
80100df2:	0f b6 c0             	movzbl %al,%eax
80100df5:	09 c6                	or     %eax,%esi
//mode 0,backspace 1,delete
void
deletec(int mode)
{
    int pos = getcursor();
    if (mode == 0){
80100df7:	85 d2                	test   %edx,%edx
80100df9:	0f 85 90 00 00 00    	jne    80100e8f <deletec+0xcf>
        if (input.e != input.w && pos > 0){
80100dff:	a1 38 10 11 80       	mov    0x80111038,%eax
80100e04:	39 05 3c 10 11 80    	cmp    %eax,0x8011103c
80100e0a:	74 7b                	je     80100e87 <deletec+0xc7>
80100e0c:	85 f6                	test   %esi,%esi
80100e0e:	74 77                	je     80100e87 <deletec+0xc7>
            input.l--;
            pos--;
            setcursor(pos);
80100e10:	83 ec 0c             	sub    $0xc,%esp
{
    int pos = getcursor();
    if (mode == 0){
        if (input.e != input.w && pos > 0){
            input.l--;
            pos--;
80100e13:	83 ee 01             	sub    $0x1,%esi
deletec(int mode)
{
    int pos = getcursor();
    if (mode == 0){
        if (input.e != input.w && pos > 0){
            input.l--;
80100e16:	83 2d 40 10 11 80 01 	subl   $0x1,0x80111040
            pos--;
            setcursor(pos);
80100e1d:	56                   	push   %esi
80100e1e:	e8 7d fd ff ff       	call   80100ba0 <setcursor>
80100e23:	8b 3d 3c 10 11 80    	mov    0x8011103c,%edi
80100e29:	83 c4 10             	add    $0x10,%esp
80100e2c:	a1 40 10 11 80       	mov    0x80111040,%eax
        else
            return ;
    }
    
    int i, j;
    for (i = input.e, j = pos; i < input.l; ++i, ++j){
80100e31:	39 c7                	cmp    %eax,%edi
80100e33:	73 45                	jae    80100e7a <deletec+0xba>
80100e35:	8d 5e 01             	lea    0x1(%esi),%ebx
80100e38:	8d 97 b5 0f 11 80    	lea    -0x7feef04b(%edi),%edx
80100e3e:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80100e41:	8d 84 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%eax
80100e48:	eb 09                	jmp    80100e53 <deletec+0x93>
80100e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100e50:	83 c3 01             	add    $0x1,%ebx
        input.buf[i] = input.buf[i + 1];
80100e53:	0f b6 0a             	movzbl (%edx),%ecx
80100e56:	83 c0 02             	add    $0x2,%eax
80100e59:	83 c2 01             	add    $0x1,%edx
        else
            return ;
    }
    
    int i, j;
    for (i = input.e, j = pos; i < input.l; ++i, ++j){
80100e5c:	89 de                	mov    %ebx,%esi
        input.buf[i] = input.buf[i + 1];
80100e5e:	88 4a fe             	mov    %cl,-0x2(%edx)
        crt[j] = crt[j + 1] | WHITE_ON_BLACK;
80100e61:	0f b7 48 fe          	movzwl -0x2(%eax),%ecx
80100e65:	80 cd 07             	or     $0x7,%ch
80100e68:	66 89 48 fc          	mov    %cx,-0x4(%eax)
        else
            return ;
    }
    
    int i, j;
    for (i = input.e, j = pos; i < input.l; ++i, ++j){
80100e6c:	8d 0c 3b             	lea    (%ebx,%edi,1),%ecx
80100e6f:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
80100e72:	3b 0d 40 10 11 80    	cmp    0x80111040,%ecx
80100e78:	72 d6                	jb     80100e50 <deletec+0x90>
        input.buf[i] = input.buf[i + 1];
        crt[j] = crt[j + 1] | WHITE_ON_BLACK;
    }
    crt[j] = ' ' | WHITE_ON_BLACK;
80100e7a:	b8 20 07 00 00       	mov    $0x720,%eax
80100e7f:	66 89 84 36 00 80 0b 	mov    %ax,-0x7ff48000(%esi,%esi,1)
80100e86:	80 
}
80100e87:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e8a:	5b                   	pop    %ebx
80100e8b:	5e                   	pop    %esi
80100e8c:	5f                   	pop    %edi
80100e8d:	5d                   	pop    %ebp
80100e8e:	c3                   	ret    
            setcursor(pos);
        }
        else
            return ;
    }
    if (mode == 1){
80100e8f:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
        if (input.e < input.l){
80100e93:	8b 3d 3c 10 11 80    	mov    0x8011103c,%edi
80100e99:	a1 40 10 11 80       	mov    0x80111040,%eax
            setcursor(pos);
        }
        else
            return ;
    }
    if (mode == 1){
80100e9e:	75 91                	jne    80100e31 <deletec+0x71>
        if (input.e < input.l){
80100ea0:	39 c7                	cmp    %eax,%edi
80100ea2:	73 e3                	jae    80100e87 <deletec+0xc7>
            input.l--;
80100ea4:	83 e8 01             	sub    $0x1,%eax
80100ea7:	a3 40 10 11 80       	mov    %eax,0x80111040
80100eac:	e9 80 ff ff ff       	jmp    80100e31 <deletec+0x71>
80100eb1:	eb 0d                	jmp    80100ec0 <clearline>
80100eb3:	90                   	nop
80100eb4:	90                   	nop
80100eb5:	90                   	nop
80100eb6:	90                   	nop
80100eb7:	90                   	nop
80100eb8:	90                   	nop
80100eb9:	90                   	nop
80100eba:	90                   	nop
80100ebb:	90                   	nop
80100ebc:	90                   	nop
80100ebd:	90                   	nop
80100ebe:	90                   	nop
80100ebf:	90                   	nop

80100ec0 <clearline>:
    crt[j] = ' ' | WHITE_ON_BLACK;
}

void
clearline()
{
80100ec0:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100ec1:	b8 0e 00 00 00       	mov    $0xe,%eax
80100ec6:	89 e5                	mov    %esp,%ebp
80100ec8:	56                   	push   %esi
80100ec9:	be d4 03 00 00       	mov    $0x3d4,%esi
80100ece:	53                   	push   %ebx
80100ecf:	89 f2                	mov    %esi,%edx
80100ed1:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100ed2:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100ed7:	89 ca                	mov    %ecx,%edx
80100ed9:	ec                   	in     (%dx),%al
80100eda:	89 c3                	mov    %eax,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100edc:	89 f2                	mov    %esi,%edx
80100ede:	b8 0f 00 00 00       	mov    $0xf,%eax
80100ee3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100ee4:	89 ca                	mov    %ecx,%edx
80100ee6:	ec                   	in     (%dx),%al
    int i;
    int pos = getcursor();
    pos -= (input.e - input.w);
80100ee7:	8b 35 38 10 11 80    	mov    0x80111038,%esi
80100eed:	0f b6 c0             	movzbl %al,%eax
    setcursor(pos);
80100ef0:	83 ec 0c             	sub    $0xc,%esp
void
clearline()
{
    int i;
    int pos = getcursor();
    pos -= (input.e - input.w);
80100ef3:	89 f2                	mov    %esi,%edx
80100ef5:	2b 15 3c 10 11 80    	sub    0x8011103c,%edx
80100efb:	0f b6 f3             	movzbl %bl,%esi
80100efe:	c1 e6 08             	shl    $0x8,%esi
80100f01:	09 f0                	or     %esi,%eax
80100f03:	8d 34 02             	lea    (%edx,%eax,1),%esi
    setcursor(pos);
80100f06:	56                   	push   %esi
80100f07:	89 f3                	mov    %esi,%ebx
80100f09:	e8 92 fc ff ff       	call   80100ba0 <setcursor>
    for (i = pos; i < pos + input.l; ++i){
80100f0e:	a1 40 10 11 80       	mov    0x80111040,%eax
80100f13:	83 c4 10             	add    $0x10,%esp
80100f16:	01 f0                	add    %esi,%eax
80100f18:	39 c6                	cmp    %eax,%esi
80100f1a:	73 1f                	jae    80100f3b <clearline+0x7b>
80100f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        crt[i] = ' ' | WHITE_ON_BLACK;
80100f20:	b8 20 07 00 00       	mov    $0x720,%eax
80100f25:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100f2c:	80 
{
    int i;
    int pos = getcursor();
    pos -= (input.e - input.w);
    setcursor(pos);
    for (i = pos; i < pos + input.l; ++i){
80100f2d:	a1 40 10 11 80       	mov    0x80111040,%eax
80100f32:	83 c3 01             	add    $0x1,%ebx
80100f35:	01 f0                	add    %esi,%eax
80100f37:	39 d8                	cmp    %ebx,%eax
80100f39:	77 e5                	ja     80100f20 <clearline+0x60>
        crt[i] = ' ' | WHITE_ON_BLACK;
    }
    input.l = input.w;
80100f3b:	a1 38 10 11 80       	mov    0x80111038,%eax
80100f40:	a3 40 10 11 80       	mov    %eax,0x80111040
}
80100f45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100f48:	5b                   	pop    %ebx
80100f49:	5e                   	pop    %esi
80100f4a:	5d                   	pop    %ebp
80100f4b:	c3                   	ret    
80100f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f50 <clearc>:

void
clearc()
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	56                   	push   %esi
80100f54:	53                   	push   %ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100f55:	be d4 03 00 00       	mov    $0x3d4,%esi
  acquire(&input.lock);
80100f5a:	83 ec 0c             	sub    $0xc,%esp
80100f5d:	68 80 0f 11 80       	push   $0x80110f80
80100f62:	e8 f9 40 00 00       	call   80105060 <acquire>
80100f67:	b8 0e 00 00 00       	mov    $0xe,%eax
80100f6c:	89 f2                	mov    %esi,%edx
80100f6e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100f6f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100f74:	89 ca                	mov    %ecx,%edx
80100f76:	ec                   	in     (%dx),%al
80100f77:	89 c3                	mov    %eax,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100f79:	89 f2                	mov    %esi,%edx
80100f7b:	b8 0f 00 00 00       	mov    $0xf,%eax
80100f80:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100f81:	89 ca                	mov    %ecx,%edx
80100f83:	ec                   	in     (%dx),%al
    int pos;
    // Cursor position: col + 80*row.
    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
80100f84:	0f b6 cb             	movzbl %bl,%ecx
80100f87:	0f b6 c0             	movzbl %al,%eax
void
clearc()
{
  acquire(&input.lock);
  int pos = getcursor();
  if (pos > 0){  
80100f8a:	83 c4 10             	add    $0x10,%esp
    int pos;
    // Cursor position: col + 80*row.
    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
80100f8d:	c1 e1 08             	shl    $0x8,%ecx
void
clearc()
{
  acquire(&input.lock);
  int pos = getcursor();
  if (pos > 0){  
80100f90:	09 c8                	or     %ecx,%eax
80100f92:	74 46                	je     80100fda <clearc+0x8a>
    input.buf[input.w] = 0;
80100f94:	8b 1d 38 10 11 80    	mov    0x80111038,%ebx
    int ipos = --input.w;
    input.r--;
    input.l--;
    pos--;
80100f9a:	83 e8 01             	sub    $0x1,%eax
    crt[pos] = ' ' | WHITE_ON_BLACK;
    setcursor(pos);
80100f9d:	83 ec 0c             	sub    $0xc,%esp
    input.buf[input.w] = 0;
    int ipos = --input.w;
    input.r--;
    input.l--;
    pos--;
    crt[pos] = ' ' | WHITE_ON_BLACK;
80100fa0:	ba 20 07 00 00       	mov    $0x720,%edx
  acquire(&input.lock);
  int pos = getcursor();
  if (pos > 0){  
    input.buf[input.w] = 0;
    int ipos = --input.w;
    input.r--;
80100fa5:	83 2d 34 10 11 80 01 	subl   $0x1,0x80111034
    input.l--;
80100fac:	83 2d 40 10 11 80 01 	subl   $0x1,0x80111040
clearc()
{
  acquire(&input.lock);
  int pos = getcursor();
  if (pos > 0){  
    input.buf[input.w] = 0;
80100fb3:	c6 83 b4 0f 11 80 00 	movb   $0x0,-0x7feef04c(%ebx)
    int ipos = --input.w;
80100fba:	83 eb 01             	sub    $0x1,%ebx
80100fbd:	89 1d 38 10 11 80    	mov    %ebx,0x80111038
    input.r--;
    input.l--;
    pos--;
    crt[pos] = ' ' | WHITE_ON_BLACK;
80100fc3:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100fca:	80 
    setcursor(pos);
80100fcb:	50                   	push   %eax
80100fcc:	e8 cf fb ff ff       	call   80100ba0 <setcursor>
    input.e = ipos;
80100fd1:	89 1d 3c 10 11 80    	mov    %ebx,0x8011103c
80100fd7:	83 c4 10             	add    $0x10,%esp
  }
  release(&input.lock);
80100fda:	83 ec 0c             	sub    $0xc,%esp
80100fdd:	68 80 0f 11 80       	push   $0x80110f80
80100fe2:	e8 99 41 00 00       	call   80105180 <release>
  return;
80100fe7:	83 c4 10             	add    $0x10,%esp
}
80100fea:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100fed:	5b                   	pop    %ebx
80100fee:	5e                   	pop    %esi
80100fef:	5d                   	pop    %ebp
80100ff0:	c3                   	ret    
80100ff1:	eb 0d                	jmp    80101000 <insertline>
80100ff3:	90                   	nop
80100ff4:	90                   	nop
80100ff5:	90                   	nop
80100ff6:	90                   	nop
80100ff7:	90                   	nop
80100ff8:	90                   	nop
80100ff9:	90                   	nop
80100ffa:	90                   	nop
80100ffb:	90                   	nop
80100ffc:	90                   	nop
80100ffd:	90                   	nop
80100ffe:	90                   	nop
80100fff:	90                   	nop

80101000 <insertline>:


void
insertline(char* buf)
{
80101000:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101001:	b8 0e 00 00 00       	mov    $0xe,%eax
80101006:	89 e5                	mov    %esp,%ebp
80101008:	57                   	push   %edi
80101009:	56                   	push   %esi
8010100a:	53                   	push   %ebx
8010100b:	bf d4 03 00 00       	mov    $0x3d4,%edi
80101010:	89 fa                	mov    %edi,%edx
80101012:	83 ec 18             	sub    $0x18,%esp
80101015:	8b 75 08             	mov    0x8(%ebp),%esi
80101018:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101019:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010101e:	89 ca                	mov    %ecx,%edx
80101020:	ec                   	in     (%dx),%al
80101021:	0f b6 d8             	movzbl %al,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101024:	89 fa                	mov    %edi,%edx
80101026:	b8 0f 00 00 00       	mov    $0xf,%eax
8010102b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010102c:	89 ca                	mov    %ecx,%edx
8010102e:	ec                   	in     (%dx),%al
    int i, j, k;
    int pos = getcursor();
    input.l = input.w + strlen(buf);
8010102f:	8b 3d 38 10 11 80    	mov    0x80111038,%edi
80101035:	56                   	push   %esi
    int pos;
    // Cursor position: col + 80*row.
    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
80101036:	c1 e3 08             	shl    $0x8,%ebx
80101039:	0f b6 c0             	movzbl %al,%eax
8010103c:	09 c3                	or     %eax,%ebx
void
insertline(char* buf)
{
    int i, j, k;
    int pos = getcursor();
    input.l = input.w + strlen(buf);
8010103e:	e8 cd 43 00 00       	call   80105410 <strlen>
80101043:	8d 14 38             	lea    (%eax,%edi,1),%edx
    for (i = input.w, j = pos, k = 0; i < input.l; ++i, ++j, ++k){
80101046:	a1 38 10 11 80       	mov    0x80111038,%eax
8010104b:	83 c4 10             	add    $0x10,%esp
void
insertline(char* buf)
{
    int i, j, k;
    int pos = getcursor();
    input.l = input.w + strlen(buf);
8010104e:	89 15 40 10 11 80    	mov    %edx,0x80111040
    for (i = input.w, j = pos, k = 0; i < input.l; ++i, ++j, ++k){
80101054:	39 c2                	cmp    %eax,%edx
80101056:	76 35                	jbe    8010108d <insertline+0x8d>
80101058:	89 df                	mov    %ebx,%edi
8010105a:	89 f1                	mov    %esi,%ecx
8010105c:	29 c7                	sub    %eax,%edi
8010105e:	29 c1                	sub    %eax,%ecx
80101060:	01 ff                	add    %edi,%edi
80101062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.buf[i] = buf[k];
80101068:	0f b6 14 01          	movzbl (%ecx,%eax,1),%edx
8010106c:	88 90 b4 0f 11 80    	mov    %dl,-0x7feef04c(%eax)
        crt[j] = buf[k] | WHITE_ON_BLACK;
80101072:	66 0f be 14 01       	movsbw (%ecx,%eax,1),%dx
80101077:	80 ce 07             	or     $0x7,%dh
8010107a:	66 89 94 47 00 80 0b 	mov    %dx,-0x7ff48000(%edi,%eax,2)
80101081:	80 
insertline(char* buf)
{
    int i, j, k;
    int pos = getcursor();
    input.l = input.w + strlen(buf);
    for (i = input.w, j = pos, k = 0; i < input.l; ++i, ++j, ++k){
80101082:	83 c0 01             	add    $0x1,%eax
80101085:	39 05 40 10 11 80    	cmp    %eax,0x80111040
8010108b:	77 db                	ja     80101068 <insertline+0x68>
        input.buf[i] = buf[k];
        crt[j] = buf[k] | WHITE_ON_BLACK;
    }
    setcursor(pos + strlen(buf));
8010108d:	83 ec 0c             	sub    $0xc,%esp
80101090:	56                   	push   %esi
80101091:	e8 7a 43 00 00       	call   80105410 <strlen>
80101096:	01 c3                	add    %eax,%ebx
80101098:	83 c4 10             	add    $0x10,%esp
8010109b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010109e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010a1:	5b                   	pop    %ebx
801010a2:	5e                   	pop    %esi
801010a3:	5f                   	pop    %edi
801010a4:	5d                   	pop    %ebp
    input.l = input.w + strlen(buf);
    for (i = input.w, j = pos, k = 0; i < input.l; ++i, ++j, ++k){
        input.buf[i] = buf[k];
        crt[j] = buf[k] | WHITE_ON_BLACK;
    }
    setcursor(pos + strlen(buf));
801010a5:	e9 f6 fa ff ff       	jmp    80100ba0 <setcursor>
801010aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801010b0 <uartprint>:
}

void
uartprint(int k)
{
801010b0:	55                   	push   %ebp
801010b1:	89 e5                	mov    %esp,%ebp
801010b3:	56                   	push   %esi
801010b4:	53                   	push   %ebx
801010b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (k < 10)
801010b8:	83 fb 09             	cmp    $0x9,%ebx
801010bb:	7e 28                	jle    801010e5 <uartprint+0x35>
      uartputc(k + 48);
    else{
      uartprint(k / 10);
801010bd:	89 d8                	mov    %ebx,%eax
801010bf:	ba 67 66 66 66       	mov    $0x66666667,%edx
801010c4:	83 ec 0c             	sub    $0xc,%esp
801010c7:	f7 ea                	imul   %edx
801010c9:	89 d8                	mov    %ebx,%eax
801010cb:	c1 f8 1f             	sar    $0x1f,%eax
801010ce:	c1 fa 02             	sar    $0x2,%edx
801010d1:	89 d6                	mov    %edx,%esi
801010d3:	29 c6                	sub    %eax,%esi
801010d5:	56                   	push   %esi
801010d6:	e8 d5 ff ff ff       	call   801010b0 <uartprint>
      uartputc(k % 10 + 48);
801010db:	8d 04 b6             	lea    (%esi,%esi,4),%eax
801010de:	83 c4 10             	add    $0x10,%esp
801010e1:	01 c0                	add    %eax,%eax
801010e3:	29 c3                	sub    %eax,%ebx
801010e5:	83 c3 30             	add    $0x30,%ebx
801010e8:	89 5d 08             	mov    %ebx,0x8(%ebp)
    }
}
801010eb:	8d 65 f8             	lea    -0x8(%ebp),%esp
801010ee:	5b                   	pop    %ebx
801010ef:	5e                   	pop    %esi
801010f0:	5d                   	pop    %ebp
{
    if (k < 10)
      uartputc(k + 48);
    else{
      uartprint(k / 10);
      uartputc(k % 10 + 48);
801010f1:	e9 4a 58 00 00       	jmp    80106940 <uartputc>
801010f6:	8d 76 00             	lea    0x0(%esi),%esi
801010f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101100 <handleMemo>:
    }
}

void handleMemo(int c, int pos){
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	56                   	push   %esi
80101104:	53                   	push   %ebx
80101105:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101108:	8b 75 0c             	mov    0xc(%ebp),%esi
  if (c == PGEND){        
8010110b:	81 fb e1 00 00 00    	cmp    $0xe1,%ebx
80101111:	74 65                	je     80101178 <handleMemo+0x78>
    pageEnd();
  }
  else if (c == PGUP){
80101113:	81 fb e6 00 00 00    	cmp    $0xe6,%ebx
80101119:	74 65                	je     80101180 <handleMemo+0x80>
    pageUp();
  }
  else if (c == PGDN){        
8010111b:	81 fb e7 00 00 00    	cmp    $0xe7,%ebx
80101121:	74 6d                	je     80101190 <handleMemo+0x90>
    pageDown();
  }
  else if(c != 0)
80101123:	85 db                	test   %ebx,%ebx
80101125:	75 31                	jne    80101158 <handleMemo+0x58>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101127:	bb d4 03 00 00       	mov    $0x3d4,%ebx
8010112c:	b8 0e 00 00 00       	mov    $0xe,%eax
80101131:	89 da                	mov    %ebx,%edx
80101133:	ee                   	out    %al,(%dx)
80101134:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80101139:	89 f0                	mov    %esi,%eax
8010113b:	c1 f8 08             	sar    $0x8,%eax
8010113e:	89 ca                	mov    %ecx,%edx
80101140:	ee                   	out    %al,(%dx)
80101141:	b8 0f 00 00 00       	mov    $0xf,%eax
80101146:	89 da                	mov    %ebx,%edx
80101148:	ee                   	out    %al,(%dx)
80101149:	89 f0                	mov    %esi,%eax
8010114b:	89 ca                	mov    %ecx,%edx
8010114d:	ee                   	out    %al,(%dx)
  */
  outb(CRTPORT, 14); 
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
}
8010114e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101151:	5b                   	pop    %ebx
80101152:	5e                   	pop    %esi
80101153:	5d                   	pop    %ebp
80101154:	c3                   	ret    
80101155:	8d 76 00             	lea    0x0(%esi),%esi
  else if (c == PGDN){        
    pageDown();
  }
  else if(c != 0)
  {
    pos = switchMode(pos);
80101158:	56                   	push   %esi
80101159:	e8 92 f9 ff ff       	call   80100af0 <switchMode>
    insertc(c);
8010115e:	83 ec 08             	sub    $0x8,%esp
  else if (c == PGDN){        
    pageDown();
  }
  else if(c != 0)
  {
    pos = switchMode(pos);
80101161:	89 c6                	mov    %eax,%esi
    insertc(c);
80101163:	53                   	push   %ebx
    pos++;
80101164:	83 c6 01             	add    $0x1,%esi
    pageDown();
  }
  else if(c != 0)
  {
    pos = switchMode(pos);
    insertc(c);
80101167:	e8 14 fb ff ff       	call   80100c80 <insertc>
    pos++;
8010116c:	83 c4 10             	add    $0x10,%esp
8010116f:	eb b6                	jmp    80101127 <handleMemo+0x27>
80101171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
}

void handleMemo(int c, int pos){
  if (c == PGEND){        
    pageEnd();
80101178:	e8 83 f7 ff ff       	call   80100900 <pageEnd>
8010117d:	eb a8                	jmp    80101127 <handleMemo+0x27>
8010117f:	90                   	nop
  }
  else if (c == PGUP){
    pageUp();
80101180:	e8 0b f8 ff ff       	call   80100990 <pageUp>
80101185:	eb a0                	jmp    80101127 <handleMemo+0x27>
80101187:	89 f6                	mov    %esi,%esi
80101189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
  else if (c == PGDN){        
    pageDown();
80101190:	e8 9b f8 ff ff       	call   80100a30 <pageDown>
80101195:	eb 90                	jmp    80101127 <handleMemo+0x27>
80101197:	89 f6                	mov    %esi,%esi
80101199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801011a0 <consoleintr>:
  outb(CRTPORT+1, pos);
}

void
consoleintr(int (*getc)(void))
{
801011a0:	55                   	push   %ebp
801011a1:	89 e5                	mov    %esp,%ebp
801011a3:	57                   	push   %edi
801011a4:	56                   	push   %esi
801011a5:	53                   	push   %ebx
801011a6:	83 ec 1c             	sub    $0x1c,%esp
  int c;
  // memo [children]
  if(shellStatus == MEMO){
801011a9:	83 3d 2c b5 10 80 01 	cmpl   $0x1,0x8010b52c
  outb(CRTPORT+1, pos);
}

void
consoleintr(int (*getc)(void))
{
801011b0:	8b 45 08             	mov    0x8(%ebp),%eax
801011b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int c;
  // memo [children]
  if(shellStatus == MEMO){
801011b6:	0f 84 f4 04 00 00    	je     801016b0 <consoleintr+0x510>
    return;
  }

  int tmpoffset=0;

  acquire(&input.lock);
801011bc:	83 ec 0c             	sub    $0xc,%esp
801011bf:	be d4 03 00 00       	mov    $0x3d4,%esi
801011c4:	68 80 0f 11 80       	push   $0x80110f80
801011c9:	e8 92 3e 00 00       	call   80105060 <acquire>
801011ce:	b8 0e 00 00 00       	mov    $0xe,%eax
801011d3:	89 f2                	mov    %esi,%edx
801011d5:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801011d6:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801011db:	89 ca                	mov    %ecx,%edx
801011dd:	ec                   	in     (%dx),%al
801011de:	0f b6 f8             	movzbl %al,%edi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801011e1:	89 f2                	mov    %esi,%edx
801011e3:	b8 0f 00 00 00       	mov    $0xf,%eax
801011e8:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801011e9:	89 ca                	mov    %ecx,%edx
801011eb:	ec                   	in     (%dx),%al
    int pos;
    // Cursor position: col + 80*row.
    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
801011ec:	c1 e7 08             	shl    $0x8,%edi
801011ef:	0f b6 c0             	movzbl %al,%eax
  uartprint(pos);
  uartputc(';');
  for (i = input.w; i < input.l; ++i)
    uartputc(input.buf[i]);
  uartputc('\n');*/
  while((c = getc()) >= 0){
801011f2:	83 c4 10             	add    $0x10,%esp
    int pos;
    // Cursor position: col + 80*row.
    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
    outb(CRTPORT, 15);
    pos |= inb(CRTPORT+1);
801011f5:	09 c7                	or     %eax,%edi
801011f7:	89 f6                	mov    %esi,%esi
801011f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uartprint(pos);
  uartputc(';');
  for (i = input.w; i < input.l; ++i)
    uartputc(input.buf[i]);
  uartputc('\n');*/
  while((c = getc()) >= 0){
80101200:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101203:	ff d0                	call   *%eax
80101205:	85 c0                	test   %eax,%eax
80101207:	78 7c                	js     80101285 <consoleintr+0xe5>
    if(lastconsolemode != consolemode){
80101209:	8b 15 fc b5 10 80    	mov    0x8010b5fc,%edx
8010120f:	39 15 20 b5 10 80    	cmp    %edx,0x8010b520
80101215:	74 1a                	je     80101231 <consoleintr+0x91>
      lastconsolemode = consolemode;
80101217:	89 15 20 b5 10 80    	mov    %edx,0x8010b520
      screenHistoryLen = startScreenLine = 0;
8010121d:	c7 05 30 b5 10 80 00 	movl   $0x0,0x8010b530
80101224:	00 00 00 
80101227:	c7 05 34 b5 10 80 00 	movl   $0x0,0x8010b534
8010122e:	00 00 00 
    }
    if (consolemode == 2){
80101231:	83 fa 02             	cmp    $0x2,%edx
80101234:	74 6a                	je     801012a0 <consoleintr+0x100>
      input.e = input.l;
      input.w = input.l;
      wakeup(&input.r);
      continue;
    }
    switch(c){
80101236:	3d e9 00 00 00       	cmp    $0xe9,%eax
8010123b:	0f 87 1f 04 00 00    	ja     80101660 <consoleintr+0x4c0>
80101241:	ff 24 85 d0 7d 10 80 	jmp    *-0x7fef8230(,%eax,4)
80101248:	90                   	nop
80101249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while((c = getc()) >= 0){
      int pos;
      outb(CRTPORT, 14);    pos = inb(CRTPORT+1) << 8;
      outb(CRTPORT, 15);    pos |= inb(CRTPORT+1);
      if(c == ESC){
        pos = switchMode(pos);
80101250:	83 ec 0c             	sub    $0xc,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101253:	be d4 03 00 00       	mov    $0x3d4,%esi
80101258:	50                   	push   %eax
80101259:	e8 92 f8 ff ff       	call   80100af0 <switchMode>
8010125e:	89 f2                	mov    %esi,%edx
80101260:	89 c1                	mov    %eax,%ecx
80101262:	b8 0e 00 00 00       	mov    $0xe,%eax
80101267:	ee                   	out    %al,(%dx)
80101268:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010126d:	89 c8                	mov    %ecx,%eax
8010126f:	c1 f8 08             	sar    $0x8,%eax
80101272:	89 da                	mov    %ebx,%edx
80101274:	ee                   	out    %al,(%dx)
80101275:	b8 0f 00 00 00       	mov    $0xf,%eax
8010127a:	89 f2                	mov    %esi,%edx
8010127c:	ee                   	out    %al,(%dx)
8010127d:	89 c8                	mov    %ecx,%eax
8010127f:	89 da                	mov    %ebx,%edx
80101281:	ee                   	out    %al,(%dx)
80101282:	83 c4 10             	add    $0x10,%esp
        outb(CRTPORT, 15);  outb(CRTPORT+1, pos);
        break;
      }
      handleMemo(c,pos);
    }
    release(&input.lock);
80101285:	c7 45 08 80 0f 11 80 	movl   $0x80110f80,0x8(%ebp)
      }
      break;
    }
  }
  release(&input.lock);
}
8010128c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010128f:	5b                   	pop    %ebx
80101290:	5e                   	pop    %esi
80101291:	5f                   	pop    %edi
80101292:	5d                   	pop    %ebp
        outb(CRTPORT, 15);  outb(CRTPORT+1, pos);
        break;
      }
      handleMemo(c,pos);
    }
    release(&input.lock);
80101293:	e9 e8 3e 00 00       	jmp    80105180 <release>
80101298:	90                   	nop
80101299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(lastconsolemode != consolemode){
      lastconsolemode = consolemode;
      screenHistoryLen = startScreenLine = 0;
    }
    if (consolemode == 2){
      input.buf[input.l++ % INPUT_BUF] = c;
801012a0:	8b 15 40 10 11 80    	mov    0x80111040,%edx
      input.e = input.l;
      input.w = input.l;
      wakeup(&input.r);
801012a6:	83 ec 0c             	sub    $0xc,%esp
801012a9:	68 34 10 11 80       	push   $0x80111034
    if(lastconsolemode != consolemode){
      lastconsolemode = consolemode;
      screenHistoryLen = startScreenLine = 0;
    }
    if (consolemode == 2){
      input.buf[input.l++ % INPUT_BUF] = c;
801012ae:	8d 4a 01             	lea    0x1(%edx),%ecx
801012b1:	83 e2 7f             	and    $0x7f,%edx
801012b4:	88 82 b4 0f 11 80    	mov    %al,-0x7feef04c(%edx)
801012ba:	89 0d 40 10 11 80    	mov    %ecx,0x80111040
      input.e = input.l;
801012c0:	89 0d 3c 10 11 80    	mov    %ecx,0x8011103c
      input.w = input.l;
801012c6:	89 0d 38 10 11 80    	mov    %ecx,0x80111038
      wakeup(&input.r);
801012cc:	e8 cf 39 00 00       	call   80104ca0 <wakeup>
      continue;
801012d1:	83 c4 10             	add    $0x10,%esp
801012d4:	e9 27 ff ff ff       	jmp    80101200 <consoleintr+0x60>
801012d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        pageDown();
        break;
    case KEY_INS:
        break;
    case KEY_DEL:
        deletec(1);
801012e0:	83 ec 0c             	sub    $0xc,%esp
801012e3:	6a 01                	push   $0x1
801012e5:	e8 d6 fa ff ff       	call   80100dc0 <deletec>
        break;
801012ea:	83 c4 10             	add    $0x10,%esp
801012ed:	e9 0e ff ff ff       	jmp    80101200 <consoleintr+0x60>
801012f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          shellStatus = MEMO;
        }
        break;
    case KEY_PGDN:
        //cprintf("page Down!\n");
        pageDown();
801012f8:	e8 33 f7 ff ff       	call   80100a30 <pageDown>
        break;
801012fd:	e9 fe fe ff ff       	jmp    80101200 <consoleintr+0x60>
80101302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    case KEY_END: // End
        setcursor(pos + input.l - input.e);
        break;
    case KEY_PGUP:
        //cprintf("page Up!\n");
        pageEnd();
80101308:	e8 f3 f5 ff ff       	call   80100900 <pageEnd>
        pageUp();
8010130d:	e8 7e f6 ff ff       	call   80100990 <pageUp>
        
        if(shellStatus == SHELL){
80101312:	a1 2c b5 10 80       	mov    0x8010b52c,%eax
80101317:	85 c0                	test   %eax,%eax
80101319:	0f 85 e1 fe ff ff    	jne    80101200 <consoleintr+0x60>
          mainPos = pos;
8010131f:	89 3d 28 b5 10 80    	mov    %edi,0x8010b528
          pos = memoPos;
          shellStatus = MEMO;
80101325:	c7 05 2c b5 10 80 01 	movl   $0x1,0x8010b52c
8010132c:	00 00 00 
        pageEnd();
        pageUp();
        
        if(shellStatus == SHELL){
          mainPos = pos;
          pos = memoPos;
8010132f:	8b 3d 00 90 10 80    	mov    0x80109000,%edi
80101335:	e9 c6 fe ff ff       	jmp    80101200 <consoleintr+0x60>
8010133a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if (input.e != input.w){
            setcursor(pos - 1);
        }
        break;
    case KEY_RT: // Right
        if (input.e < input.l){
80101340:	a1 40 10 11 80       	mov    0x80111040,%eax
80101345:	39 05 3c 10 11 80    	cmp    %eax,0x8011103c
8010134b:	0f 83 af fe ff ff    	jae    80101200 <consoleintr+0x60>
            setcursor(pos + 1);
80101351:	8d 47 01             	lea    0x1(%edi),%eax
80101354:	83 ec 0c             	sub    $0xc,%esp
80101357:	50                   	push   %eax
80101358:	e8 43 f8 ff ff       	call   80100ba0 <setcursor>
8010135d:	83 c4 10             	add    $0x10,%esp
80101360:	e9 9b fe ff ff       	jmp    80101200 <consoleintr+0x60>
80101365:	8d 76 00             	lea    0x0(%esi),%esi
        break;
    case KEY_DEL:
        deletec(1);
        break;
    case KEY_LF: // Left
        if (input.e != input.w){
80101368:	a1 38 10 11 80       	mov    0x80111038,%eax
8010136d:	39 05 3c 10 11 80    	cmp    %eax,0x8011103c
80101373:	0f 84 87 fe ff ff    	je     80101200 <consoleintr+0x60>
            setcursor(pos - 1);
80101379:	8d 47 ff             	lea    -0x1(%edi),%eax
8010137c:	83 ec 0c             	sub    $0xc,%esp
8010137f:	50                   	push   %eax
80101380:	e8 1b f8 ff ff       	call   80100ba0 <setcursor>
80101385:	83 c4 10             	add    $0x10,%esp
80101388:	e9 73 fe ff ff       	jmp    80101200 <consoleintr+0x60>
8010138d:	8d 76 00             	lea    0x0(%esi),%esi
    
    case KEY_HOME: //Home
        setcursor(pos - input.e);
        break;
    case KEY_END: // End
        setcursor(pos + input.l - input.e);
80101390:	89 f8                	mov    %edi,%eax
80101392:	2b 05 3c 10 11 80    	sub    0x8011103c,%eax
80101398:	83 ec 0c             	sub    $0xc,%esp
8010139b:	03 05 40 10 11 80    	add    0x80111040,%eax
801013a1:	50                   	push   %eax
801013a2:	e8 f9 f7 ff ff       	call   80100ba0 <setcursor>
        break;
801013a7:	83 c4 10             	add    $0x10,%esp
801013aa:	e9 51 fe ff ff       	jmp    80101200 <consoleintr+0x60>
801013af:	90                   	nop
    case ESC:
        
        break;
    
    case KEY_HOME: //Home
        setcursor(pos - input.e);
801013b0:	89 f8                	mov    %edi,%eax
801013b2:	2b 05 3c 10 11 80    	sub    0x8011103c,%eax
801013b8:	83 ec 0c             	sub    $0xc,%esp
801013bb:	50                   	push   %eax
801013bc:	e8 df f7 ff ff       	call   80100ba0 <setcursor>
        break;
801013c1:	83 c4 10             	add    $0x10,%esp
801013c4:	e9 37 fe ff ff       	jmp    80101200 <consoleintr+0x60>
801013c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801013d0:	a1 3c 10 11 80       	mov    0x8011103c,%eax
801013d5:	39 05 38 10 11 80    	cmp    %eax,0x80111038
801013db:	75 29                	jne    80101406 <consoleintr+0x266>
801013dd:	e9 1e fe ff ff       	jmp    80101200 <consoleintr+0x60>
801013e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        deletec(0);
801013e8:	83 ec 0c             	sub    $0xc,%esp
801013eb:	6a 00                	push   $0x0
801013ed:	e8 ce f9 ff ff       	call   80100dc0 <deletec>
      break;
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801013f2:	a1 3c 10 11 80       	mov    0x8011103c,%eax
801013f7:	83 c4 10             	add    $0x10,%esp
801013fa:	3b 05 38 10 11 80    	cmp    0x80111038,%eax
80101400:	0f 84 fa fd ff ff    	je     80101200 <consoleintr+0x60>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80101406:	83 e8 01             	sub    $0x1,%eax
80101409:	83 e0 7f             	and    $0x7f,%eax
      break;
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010140c:	80 b8 b4 0f 11 80 0a 	cmpb   $0xa,-0x7feef04c(%eax)
80101413:	75 d3                	jne    801013e8 <consoleintr+0x248>
80101415:	e9 e6 fd ff ff       	jmp    80101200 <consoleintr+0x60>
8010141a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    case C('Z'):
      //sendsignal(1);//!!!此处注释掉后果未知
      insertc('\n');
      break;
    case C('P'):  // Process listing.
      procdump();
80101420:	e8 6b 39 00 00       	call   80104d90 <procdump>
      break;
80101425:	e9 d6 fd ff ff       	jmp    80101200 <consoleintr+0x60>
8010142a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(getcursor() > tmpoffset)
        deletec(0);
      break;
    case C('L'):
      screenHistoryLen = startScreenLine = 0;
      memset(crt,0,24*80*sizeof(ushort));
80101430:	83 ec 04             	sub    $0x4,%esp
80101433:	be d4 03 00 00       	mov    $0x3d4,%esi
      setcursor(pos + input.l - input.e);
      while(getcursor() > tmpoffset)
        deletec(0);
      break;
    case C('L'):
      screenHistoryLen = startScreenLine = 0;
80101438:	c7 05 30 b5 10 80 00 	movl   $0x0,0x8010b530
8010143f:	00 00 00 
      memset(crt,0,24*80*sizeof(ushort));
80101442:	68 00 0f 00 00       	push   $0xf00
80101447:	6a 00                	push   $0x0
80101449:	68 00 80 0b 80       	push   $0x800b8000
      setcursor(pos + input.l - input.e);
      while(getcursor() > tmpoffset)
        deletec(0);
      break;
    case C('L'):
      screenHistoryLen = startScreenLine = 0;
8010144e:	c7 05 34 b5 10 80 00 	movl   $0x0,0x8010b534
80101455:	00 00 00 
      memset(crt,0,24*80*sizeof(ushort));
80101458:	e8 73 3d 00 00       	call   801051d0 <memset>
8010145d:	b8 0e 00 00 00       	mov    $0xe,%eax
80101462:	89 f2                	mov    %esi,%edx
80101464:	ee                   	out    %al,(%dx)
80101465:	31 c9                	xor    %ecx,%ecx
80101467:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010146c:	89 c8                	mov    %ecx,%eax
8010146e:	89 da                	mov    %ebx,%edx
80101470:	ee                   	out    %al,(%dx)
80101471:	b8 0f 00 00 00       	mov    $0xf,%eax
80101476:	89 f2                	mov    %esi,%edx
80101478:	ee                   	out    %al,(%dx)
80101479:	89 c8                	mov    %ecx,%eax
8010147b:	89 da                	mov    %ebx,%edx
8010147d:	ee                   	out    %al,(%dx)
      outb(CRTPORT, 14);
      outb(CRTPORT+1, 0);
      outb(CRTPORT, 15);
      outb(CRTPORT+1, 0);
      pos = 0;
      cgaputc('X');
8010147e:	b8 58 00 00 00       	mov    $0x58,%eax
      memset(crt,0,24*80*sizeof(ushort));
      outb(CRTPORT, 14);
      outb(CRTPORT+1, 0);
      outb(CRTPORT, 15);
      outb(CRTPORT+1, 0);
      pos = 0;
80101483:	31 ff                	xor    %edi,%edi
      cgaputc('X');
80101485:	e8 66 ef ff ff       	call   801003f0 <cgaputc>
      cgaputc('V');
8010148a:	b8 56 00 00 00       	mov    $0x56,%eax
8010148f:	e8 5c ef ff ff       	call   801003f0 <cgaputc>
      cgaputc('6');
80101494:	b8 36 00 00 00       	mov    $0x36,%eax
80101499:	e8 52 ef ff ff       	call   801003f0 <cgaputc>
      cgaputc(':');
8010149e:	b8 3a 00 00 00       	mov    $0x3a,%eax
801014a3:	e8 48 ef ff ff       	call   801003f0 <cgaputc>
      break;
801014a8:	83 c4 10             	add    $0x10,%esp
801014ab:	e9 50 fd ff ff       	jmp    80101200 <consoleintr+0x60>
        setcursor(pos + input.l - input.e);
      }
      break;
    case C('K'):
      tmpoffset = pos;
      setcursor(pos + input.l - input.e);
801014b0:	89 f8                	mov    %edi,%eax
801014b2:	2b 05 3c 10 11 80    	sub    0x8011103c,%eax
801014b8:	83 ec 0c             	sub    $0xc,%esp
801014bb:	03 05 40 10 11 80    	add    0x80111040,%eax
801014c1:	be d4 03 00 00       	mov    $0x3d4,%esi
801014c6:	50                   	push   %eax
801014c7:	e8 d4 f6 ff ff       	call   80100ba0 <setcursor>
801014cc:	b8 0e 00 00 00       	mov    $0xe,%eax
801014d1:	89 f2                	mov    %esi,%edx
801014d3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801014d4:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801014d9:	89 da                	mov    %ebx,%edx
801014db:	ec                   	in     (%dx),%al
getcursor()
{
    int pos;
    // Cursor position: col + 80*row.
    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
801014dc:	0f b6 c8             	movzbl %al,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801014df:	89 f2                	mov    %esi,%edx
801014e1:	b8 0f 00 00 00       	mov    $0xf,%eax
801014e6:	c1 e1 08             	shl    $0x8,%ecx
801014e9:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801014ea:	89 da                	mov    %ebx,%edx
801014ec:	ec                   	in     (%dx),%al
      }
      break;
    case C('K'):
      tmpoffset = pos;
      setcursor(pos + input.l - input.e);
      while(getcursor() > tmpoffset)
801014ed:	0f b6 c0             	movzbl %al,%eax
801014f0:	83 c4 10             	add    $0x10,%esp
801014f3:	09 c8                	or     %ecx,%eax
801014f5:	39 c7                	cmp    %eax,%edi
801014f7:	0f 8d 03 fd ff ff    	jge    80101200 <consoleintr+0x60>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801014fd:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80101502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        deletec(0);
80101508:	83 ec 0c             	sub    $0xc,%esp
8010150b:	6a 00                	push   $0x0
8010150d:	e8 ae f8 ff ff       	call   80100dc0 <deletec>
80101512:	b8 0e 00 00 00       	mov    $0xe,%eax
80101517:	89 da                	mov    %ebx,%edx
80101519:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010151a:	be d5 03 00 00       	mov    $0x3d5,%esi
8010151f:	89 f2                	mov    %esi,%edx
80101521:	ec                   	in     (%dx),%al
getcursor()
{
    int pos;
    // Cursor position: col + 80*row.
    outb(CRTPORT, 14);
    pos = inb(CRTPORT+1) << 8;
80101522:	0f b6 c8             	movzbl %al,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101525:	89 da                	mov    %ebx,%edx
80101527:	b8 0f 00 00 00       	mov    $0xf,%eax
8010152c:	c1 e1 08             	shl    $0x8,%ecx
8010152f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101530:	89 f2                	mov    %esi,%edx
80101532:	ec                   	in     (%dx),%al
      }
      break;
    case C('K'):
      tmpoffset = pos;
      setcursor(pos + input.l - input.e);
      while(getcursor() > tmpoffset)
80101533:	0f b6 c0             	movzbl %al,%eax
80101536:	83 c4 10             	add    $0x10,%esp
80101539:	09 c8                	or     %ecx,%eax
8010153b:	39 c7                	cmp    %eax,%edi
8010153d:	7c c9                	jl     80101508 <consoleintr+0x368>
8010153f:	e9 bc fc ff ff       	jmp    80101200 <consoleintr+0x60>
80101544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        }
        break;
    case KEY_UP:
    case KEY_DN:
    case 9://tab
        setcursor(pos + input.l - input.e);
80101548:	89 fa                	mov    %edi,%edx
8010154a:	2b 15 3c 10 11 80    	sub    0x8011103c,%edx
80101550:	83 ec 0c             	sub    $0xc,%esp
80101553:	03 15 40 10 11 80    	add    0x80111040,%edx
80101559:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010155c:	52                   	push   %edx
8010155d:	e8 3e f6 ff ff       	call   80100ba0 <setcursor>
        insertc(c);
80101562:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101565:	89 04 24             	mov    %eax,(%esp)
        if(c == '\n' || c == C('D') || input.l == input.r + INPUT_BUF - 1){
            //setcursor(-1);
            //input.buf[input.l++ % INPUT_BUF] = '\n';
            //input.e = input.l;
            setcursor(pos + input.l - input.e);
            insertc('\n');
80101568:	e8 13 f7 ff ff       	call   80100c80 <insertc>
            input.w = input.l;
8010156d:	a1 40 10 11 80       	mov    0x80111040,%eax
            wakeup(&input.r);
80101572:	c7 04 24 34 10 11 80 	movl   $0x80111034,(%esp)
            //setcursor(-1);
            //input.buf[input.l++ % INPUT_BUF] = '\n';
            //input.e = input.l;
            setcursor(pos + input.l - input.e);
            insertc('\n');
            input.w = input.l;
80101579:	a3 38 10 11 80       	mov    %eax,0x80111038
            wakeup(&input.r);
8010157e:	e8 1d 37 00 00       	call   80104ca0 <wakeup>
            break;
80101583:	83 c4 10             	add    $0x10,%esp
80101586:	e9 75 fc ff ff       	jmp    80101200 <consoleintr+0x60>
8010158b:	90                   	nop
8010158c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        deletec(0);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80101590:	a1 38 10 11 80       	mov    0x80111038,%eax
80101595:	39 05 3c 10 11 80    	cmp    %eax,0x8011103c
8010159b:	0f 84 5f fc ff ff    	je     80101200 <consoleintr+0x60>
        deletec(0);
801015a1:	83 ec 0c             	sub    $0xc,%esp
801015a4:	6a 00                	push   $0x0
801015a6:	e8 15 f8 ff ff       	call   80100dc0 <deletec>
801015ab:	83 c4 10             	add    $0x10,%esp
801015ae:	e9 4d fc ff ff       	jmp    80101200 <consoleintr+0x60>
801015b3:	90                   	nop
801015b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        tmpoffset++;
      }
      setcursor(pos + 1 - tmpoffset);
      break;
    case C('E'):
      if(input.e < input.l){
801015b8:	8b 15 3c 10 11 80    	mov    0x8011103c,%edx
801015be:	a1 40 10 11 80       	mov    0x80111040,%eax
801015c3:	39 c2                	cmp    %eax,%edx
801015c5:	0f 83 35 fc ff ff    	jae    80101200 <consoleintr+0x60>
        setcursor(pos + input.l - input.e);
801015cb:	29 d0                	sub    %edx,%eax
801015cd:	83 ec 0c             	sub    $0xc,%esp
801015d0:	01 f8                	add    %edi,%eax
801015d2:	50                   	push   %eax
801015d3:	e8 c8 f5 ff ff       	call   80100ba0 <setcursor>
801015d8:	83 c4 10             	add    $0x10,%esp
801015db:	e9 20 fc ff ff       	jmp    80101200 <consoleintr+0x60>
    }
    switch(c){
    case C('C'):  // kill current process
    case C('Z'):
      //sendsignal(1);//!!!此处注释掉后果未知
      insertc('\n');
801015e0:	83 ec 0c             	sub    $0xc,%esp
801015e3:	6a 0a                	push   $0xa
801015e5:	e8 96 f6 ff ff       	call   80100c80 <insertc>
      break;
801015ea:	83 c4 10             	add    $0x10,%esp
801015ed:	e9 0e fc ff ff       	jmp    80101200 <consoleintr+0x60>
801015f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        deletec(0);
      }
      break;
    case C('A'): 
      tmpoffset = 1;
      while((input.e-tmpoffset+1) != input.w &&
801015f8:	a1 3c 10 11 80       	mov    0x8011103c,%eax
801015fd:	8b 1d 38 10 11 80    	mov    0x80111038,%ebx
80101603:	39 c3                	cmp    %eax,%ebx
80101605:	8d 48 ff             	lea    -0x1(%eax),%ecx
80101608:	0f 84 2c 01 00 00    	je     8010173a <consoleintr+0x59a>
            input.buf[(input.e-tmpoffset) % INPUT_BUF] != '\n'){
8010160e:	83 e1 7f             	and    $0x7f,%ecx
80101611:	83 e8 02             	sub    $0x2,%eax
80101614:	83 eb 01             	sub    $0x1,%ebx
        deletec(0);
      }
      break;
    case C('A'): 
      tmpoffset = 1;
      while((input.e-tmpoffset+1) != input.w &&
80101617:	80 b9 b4 0f 11 80 0a 	cmpb   $0xa,-0x7feef04c(%ecx)
8010161e:	ba 01 00 00 00       	mov    $0x1,%edx
80101623:	75 1c                	jne    80101641 <consoleintr+0x4a1>
80101625:	eb 21                	jmp    80101648 <consoleintr+0x4a8>
80101627:	89 f6                	mov    %esi,%esi
80101629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            input.buf[(input.e-tmpoffset) % INPUT_BUF] != '\n'){
80101630:	89 c1                	mov    %eax,%ecx
80101632:	83 e8 01             	sub    $0x1,%eax
80101635:	83 e1 7f             	and    $0x7f,%ecx
        deletec(0);
      }
      break;
    case C('A'): 
      tmpoffset = 1;
      while((input.e-tmpoffset+1) != input.w &&
80101638:	80 b9 b4 0f 11 80 0a 	cmpb   $0xa,-0x7feef04c(%ecx)
8010163f:	74 07                	je     80101648 <consoleintr+0x4a8>
            input.buf[(input.e-tmpoffset) % INPUT_BUF] != '\n'){
        tmpoffset++;
80101641:	83 c2 01             	add    $0x1,%edx
        deletec(0);
      }
      break;
    case C('A'): 
      tmpoffset = 1;
      while((input.e-tmpoffset+1) != input.w &&
80101644:	39 d8                	cmp    %ebx,%eax
80101646:	75 e8                	jne    80101630 <consoleintr+0x490>
            input.buf[(input.e-tmpoffset) % INPUT_BUF] != '\n'){
        tmpoffset++;
      }
      setcursor(pos + 1 - tmpoffset);
80101648:	8d 47 01             	lea    0x1(%edi),%eax
8010164b:	83 ec 0c             	sub    $0xc,%esp
8010164e:	29 d0                	sub    %edx,%eax
80101650:	50                   	push   %eax
80101651:	e8 4a f5 ff ff       	call   80100ba0 <setcursor>
      break;
80101656:	83 c4 10             	add    $0x10,%esp
80101659:	e9 a2 fb ff ff       	jmp    80101200 <consoleintr+0x60>
8010165e:	66 90                	xchg   %ax,%ax
      insertc('0'+c%100/10);
      insertc('0'+c%10);
      insertc('A');
      break;
      */
      if(c != 0 && input.l-input.r < INPUT_BUF){
80101660:	85 c0                	test   %eax,%eax
80101662:	0f 84 98 fb ff ff    	je     80101200 <consoleintr+0x60>
80101668:	8b 15 40 10 11 80    	mov    0x80111040,%edx
8010166e:	8b 0d 34 10 11 80    	mov    0x80111034,%ecx
80101674:	89 d3                	mov    %edx,%ebx
80101676:	29 cb                	sub    %ecx,%ebx
80101678:	83 fb 7f             	cmp    $0x7f,%ebx
8010167b:	0f 87 7f fb ff ff    	ja     80101200 <consoleintr+0x60>
        c = (c == '\r') ? '\n' : c;

        //Input enter
        if(c == '\n' || c == C('D') || input.l == input.r + INPUT_BUF - 1){
80101681:	83 f8 0d             	cmp    $0xd,%eax
80101684:	7f 0e                	jg     80101694 <consoleintr+0x4f4>
80101686:	bb 10 24 00 00       	mov    $0x2410,%ebx
8010168b:	0f a3 c3             	bt     %eax,%ebx
8010168e:	0f 82 88 00 00 00    	jb     8010171c <consoleintr+0x57c>
80101694:	83 c1 7f             	add    $0x7f,%ecx
80101697:	39 ca                	cmp    %ecx,%edx
80101699:	0f 84 7d 00 00 00    	je     8010171c <consoleintr+0x57c>
            input.w = input.l;
            wakeup(&input.r);
            break;
        }
        else
            insertc(c);
8010169f:	83 ec 0c             	sub    $0xc,%esp
801016a2:	50                   	push   %eax
801016a3:	e8 d8 f5 ff ff       	call   80100c80 <insertc>
801016a8:	83 c4 10             	add    $0x10,%esp
801016ab:	e9 50 fb ff ff       	jmp    80101200 <consoleintr+0x60>
consoleintr(int (*getc)(void))
{
  int c;
  // memo [children]
  if(shellStatus == MEMO){
    acquire(&input.lock);
801016b0:	83 ec 0c             	sub    $0xc,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801016b3:	be d4 03 00 00       	mov    $0x3d4,%esi
801016b8:	68 80 0f 11 80       	push   $0x80110f80
801016bd:	e8 9e 39 00 00       	call   80105060 <acquire>
    while((c = getc()) >= 0){
801016c2:	83 c4 10             	add    $0x10,%esp
801016c5:	eb 45                	jmp    8010170c <consoleintr+0x56c>
801016c7:	89 f6                	mov    %esi,%esi
801016c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801016d0:	b8 0e 00 00 00       	mov    $0xe,%eax
801016d5:	89 f2                	mov    %esi,%edx
801016d7:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801016d8:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801016dd:	89 da                	mov    %ebx,%edx
801016df:	ec                   	in     (%dx),%al
      int pos;
      outb(CRTPORT, 14);    pos = inb(CRTPORT+1) << 8;
801016e0:	0f b6 c8             	movzbl %al,%ecx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801016e3:	89 f2                	mov    %esi,%edx
801016e5:	b8 0f 00 00 00       	mov    $0xf,%eax
801016ea:	c1 e1 08             	shl    $0x8,%ecx
801016ed:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801016ee:	89 da                	mov    %ebx,%edx
801016f0:	ec                   	in     (%dx),%al
      outb(CRTPORT, 15);    pos |= inb(CRTPORT+1);
801016f1:	0f b6 c0             	movzbl %al,%eax
801016f4:	09 c8                	or     %ecx,%eax
      if(c == ESC){
801016f6:	83 ff 1b             	cmp    $0x1b,%edi
801016f9:	0f 84 51 fb ff ff    	je     80101250 <consoleintr+0xb0>
        pos = switchMode(pos);
        outb(CRTPORT, 14);  outb(CRTPORT+1, pos>>8);
        outb(CRTPORT, 15);  outb(CRTPORT+1, pos);
        break;
      }
      handleMemo(c,pos);
801016ff:	83 ec 08             	sub    $0x8,%esp
80101702:	50                   	push   %eax
80101703:	57                   	push   %edi
80101704:	e8 f7 f9 ff ff       	call   80101100 <handleMemo>
80101709:	83 c4 10             	add    $0x10,%esp
{
  int c;
  // memo [children]
  if(shellStatus == MEMO){
    acquire(&input.lock);
    while((c = getc()) >= 0){
8010170c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010170f:	ff d0                	call   *%eax
80101711:	85 c0                	test   %eax,%eax
80101713:	89 c7                	mov    %eax,%edi
80101715:	79 b9                	jns    801016d0 <consoleintr+0x530>
80101717:	e9 69 fb ff ff       	jmp    80101285 <consoleintr+0xe5>
        //Input enter
        if(c == '\n' || c == C('D') || input.l == input.r + INPUT_BUF - 1){
            //setcursor(-1);
            //input.buf[input.l++ % INPUT_BUF] = '\n';
            //input.e = input.l;
            setcursor(pos + input.l - input.e);
8010171c:	2b 15 3c 10 11 80    	sub    0x8011103c,%edx
80101722:	83 ec 0c             	sub    $0xc,%esp
80101725:	8d 04 3a             	lea    (%edx,%edi,1),%eax
80101728:	50                   	push   %eax
80101729:	e8 72 f4 ff ff       	call   80100ba0 <setcursor>
            insertc('\n');
8010172e:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80101735:	e9 2e fe ff ff       	jmp    80101568 <consoleintr+0x3c8>
        deletec(0);
      }
      break;
    case C('A'): 
      tmpoffset = 1;
      while((input.e-tmpoffset+1) != input.w &&
8010173a:	ba 01 00 00 00       	mov    $0x1,%edx
8010173f:	e9 04 ff ff ff       	jmp    80101648 <consoleintr+0x4a8>
80101744:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010174a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101750 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80101756:	68 c1 7d 10 80       	push   $0x80107dc1
8010175b:	68 60 b5 10 80       	push   $0x8010b560
80101760:	e8 fb 37 00 00       	call   80104f60 <initlock>
  initlock(&input.lock, "input");
80101765:	58                   	pop    %eax
80101766:	5a                   	pop    %edx
80101767:	68 c9 7d 10 80       	push   $0x80107dc9
8010176c:	68 80 0f 11 80       	push   $0x80110f80
80101771:	e8 ea 37 00 00       	call   80104f60 <initlock>
  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  //picenable(IRQ_KBD);//!!!此处注释掉后果未知
  ioapicenable(IRQ_KBD, 0);
80101776:	59                   	pop    %ecx
80101777:	58                   	pop    %eax
80101778:	6a 00                	push   $0x0
8010177a:	6a 01                	push   $0x1
consoleinit(void)
{
  initlock(&cons.lock, "console");
  initlock(&input.lock, "input");

  devsw[CONSOLE].write = consolewrite;
8010177c:	c7 05 0c 2d 12 80 30 	movl   $0x80100830,0x80122d0c
80101783:	08 10 80 
  devsw[CONSOLE].read = consoleread;
80101786:	c7 05 08 2d 12 80 70 	movl   $0x80100270,0x80122d08
8010178d:	02 10 80 
  cons.locking = 1;
80101790:	c7 05 94 b5 10 80 01 	movl   $0x1,0x8010b594
80101797:	00 00 00 

  //picenable(IRQ_KBD);//!!!此处注释掉后果未知
  ioapicenable(IRQ_KBD, 0);
8010179a:	e8 c1 18 00 00       	call   80103060 <ioapicenable>
}
8010179f:	83 c4 10             	add    $0x10,%esp
801017a2:	c9                   	leave  
801017a3:	c3                   	ret    
801017a4:	66 90                	xchg   %ax,%ax
801017a6:	66 90                	xchg   %ax,%ax
801017a8:	66 90                	xchg   %ax,%ax
801017aa:	66 90                	xchg   %ax,%ax
801017ac:	66 90                	xchg   %ax,%ax
801017ae:	66 90                	xchg   %ax,%ax

801017b0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	57                   	push   %edi
801017b4:	56                   	push   %esi
801017b5:	53                   	push   %ebx
801017b6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801017bc:	e8 7f 2d 00 00       	call   80104540 <myproc>
801017c1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801017c7:	e8 44 21 00 00       	call   80103910 <begin_op>

  if((ip = namei(path)) == 0){
801017cc:	83 ec 0c             	sub    $0xc,%esp
801017cf:	ff 75 08             	pushl  0x8(%ebp)
801017d2:	e8 a9 14 00 00       	call   80102c80 <namei>
801017d7:	83 c4 10             	add    $0x10,%esp
801017da:	85 c0                	test   %eax,%eax
801017dc:	0f 84 9c 01 00 00    	je     8010197e <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801017e2:	83 ec 0c             	sub    $0xc,%esp
801017e5:	89 c3                	mov    %eax,%ebx
801017e7:	50                   	push   %eax
801017e8:	e8 43 0c 00 00       	call   80102430 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
801017ed:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801017f3:	6a 34                	push   $0x34
801017f5:	6a 00                	push   $0x0
801017f7:	50                   	push   %eax
801017f8:	53                   	push   %ebx
801017f9:	e8 12 0f 00 00       	call   80102710 <readi>
801017fe:	83 c4 20             	add    $0x20,%esp
80101801:	83 f8 34             	cmp    $0x34,%eax
80101804:	74 22                	je     80101828 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80101806:	83 ec 0c             	sub    $0xc,%esp
80101809:	53                   	push   %ebx
8010180a:	e8 b1 0e 00 00       	call   801026c0 <iunlockput>
    end_op();
8010180f:	e8 6c 21 00 00       	call   80103980 <end_op>
80101814:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80101817:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010181c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010181f:	5b                   	pop    %ebx
80101820:	5e                   	pop    %esi
80101821:	5f                   	pop    %edi
80101822:	5d                   	pop    %ebp
80101823:	c3                   	ret    
80101824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80101828:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
8010182f:	45 4c 46 
80101832:	75 d2                	jne    80101806 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80101834:	e8 97 62 00 00       	call   80107ad0 <setupkvm>
80101839:	85 c0                	test   %eax,%eax
8010183b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101841:	74 c3                	je     80101806 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101843:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
8010184a:	00 
8010184b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101851:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80101858:	00 00 00 
8010185b:	0f 84 c5 00 00 00    	je     80101926 <exec+0x176>
80101861:	31 ff                	xor    %edi,%edi
80101863:	eb 18                	jmp    8010187d <exec+0xcd>
80101865:	8d 76 00             	lea    0x0(%esi),%esi
80101868:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
8010186f:	83 c7 01             	add    $0x1,%edi
80101872:	83 c6 20             	add    $0x20,%esi
80101875:	39 f8                	cmp    %edi,%eax
80101877:	0f 8e a9 00 00 00    	jle    80101926 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
8010187d:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80101883:	6a 20                	push   $0x20
80101885:	56                   	push   %esi
80101886:	50                   	push   %eax
80101887:	53                   	push   %ebx
80101888:	e8 83 0e 00 00       	call   80102710 <readi>
8010188d:	83 c4 10             	add    $0x10,%esp
80101890:	83 f8 20             	cmp    $0x20,%eax
80101893:	75 7b                	jne    80101910 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80101895:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
8010189c:	75 ca                	jne    80101868 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
8010189e:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
801018a4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
801018aa:	72 64                	jb     80101910 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
801018ac:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801018b2:	72 5c                	jb     80101910 <exec+0x160>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801018b4:	83 ec 04             	sub    $0x4,%esp
801018b7:	50                   	push   %eax
801018b8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
801018be:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
801018c4:	e8 57 60 00 00       	call   80107920 <allocuvm>
801018c9:	83 c4 10             	add    $0x10,%esp
801018cc:	85 c0                	test   %eax,%eax
801018ce:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
801018d4:	74 3a                	je     80101910 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
801018d6:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
801018dc:	a9 ff 0f 00 00       	test   $0xfff,%eax
801018e1:	75 2d                	jne    80101910 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
801018e3:	83 ec 0c             	sub    $0xc,%esp
801018e6:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
801018ec:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
801018f2:	53                   	push   %ebx
801018f3:	50                   	push   %eax
801018f4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
801018fa:	e8 61 5f 00 00       	call   80107860 <loaduvm>
801018ff:	83 c4 20             	add    $0x20,%esp
80101902:	85 c0                	test   %eax,%eax
80101904:	0f 89 5e ff ff ff    	jns    80101868 <exec+0xb8>
8010190a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80101910:	83 ec 0c             	sub    $0xc,%esp
80101913:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80101919:	e8 32 61 00 00       	call   80107a50 <freevm>
8010191e:	83 c4 10             	add    $0x10,%esp
80101921:	e9 e0 fe ff ff       	jmp    80101806 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80101926:	83 ec 0c             	sub    $0xc,%esp
80101929:	53                   	push   %ebx
8010192a:	e8 91 0d 00 00       	call   801026c0 <iunlockput>
  end_op();
8010192f:	e8 4c 20 00 00       	call   80103980 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80101934:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
8010193a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
8010193d:	05 ff 0f 00 00       	add    $0xfff,%eax
80101942:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101947:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
8010194d:	52                   	push   %edx
8010194e:	50                   	push   %eax
8010194f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80101955:	e8 c6 5f 00 00       	call   80107920 <allocuvm>
8010195a:	83 c4 10             	add    $0x10,%esp
8010195d:	85 c0                	test   %eax,%eax
8010195f:	89 c6                	mov    %eax,%esi
80101961:	75 3a                	jne    8010199d <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80101963:	83 ec 0c             	sub    $0xc,%esp
80101966:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
8010196c:	e8 df 60 00 00       	call   80107a50 <freevm>
80101971:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80101974:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101979:	e9 9e fe ff ff       	jmp    8010181c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
8010197e:	e8 fd 1f 00 00       	call   80103980 <end_op>
    cprintf("exec: fail\n");
80101983:	83 ec 0c             	sub    $0xc,%esp
80101986:	68 89 81 10 80       	push   $0x80108189
8010198b:	e8 a0 ec ff ff       	call   80100630 <cprintf>
    return -1;
80101990:	83 c4 10             	add    $0x10,%esp
80101993:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101998:	e9 7f fe ff ff       	jmp    8010181c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010199d:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
801019a3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
801019a6:	31 ff                	xor    %edi,%edi
801019a8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801019aa:	50                   	push   %eax
801019ab:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
801019b1:	e8 ba 61 00 00       	call   80107b70 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
801019b6:	8b 45 0c             	mov    0xc(%ebp),%eax
801019b9:	83 c4 10             	add    $0x10,%esp
801019bc:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
801019c2:	8b 00                	mov    (%eax),%eax
801019c4:	85 c0                	test   %eax,%eax
801019c6:	74 79                	je     80101a41 <exec+0x291>
801019c8:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
801019ce:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
801019d4:	eb 13                	jmp    801019e9 <exec+0x239>
801019d6:	8d 76 00             	lea    0x0(%esi),%esi
801019d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
801019e0:	83 ff 20             	cmp    $0x20,%edi
801019e3:	0f 84 7a ff ff ff    	je     80101963 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801019e9:	83 ec 0c             	sub    $0xc,%esp
801019ec:	50                   	push   %eax
801019ed:	e8 1e 3a 00 00       	call   80105410 <strlen>
801019f2:	f7 d0                	not    %eax
801019f4:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801019f6:	8b 45 0c             	mov    0xc(%ebp),%eax
801019f9:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801019fa:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801019fd:	ff 34 b8             	pushl  (%eax,%edi,4)
80101a00:	e8 0b 3a 00 00       	call   80105410 <strlen>
80101a05:	83 c0 01             	add    $0x1,%eax
80101a08:	50                   	push   %eax
80101a09:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a0c:	ff 34 b8             	pushl  (%eax,%edi,4)
80101a0f:	53                   	push   %ebx
80101a10:	56                   	push   %esi
80101a11:	e8 ba 62 00 00       	call   80107cd0 <copyout>
80101a16:	83 c4 20             	add    $0x20,%esp
80101a19:	85 c0                	test   %eax,%eax
80101a1b:	0f 88 42 ff ff ff    	js     80101963 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80101a21:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80101a24:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80101a2b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80101a2e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80101a34:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101a37:	85 c0                	test   %eax,%eax
80101a39:	75 a5                	jne    801019e0 <exec+0x230>
80101a3b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101a41:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80101a48:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80101a4a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80101a51:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80101a55:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80101a5c:	ff ff ff 
  ustack[1] = argc;
80101a5f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101a65:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80101a67:	83 c0 0c             	add    $0xc,%eax
80101a6a:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101a6c:	50                   	push   %eax
80101a6d:	52                   	push   %edx
80101a6e:	53                   	push   %ebx
80101a6f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101a75:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101a7b:	e8 50 62 00 00       	call   80107cd0 <copyout>
80101a80:	83 c4 10             	add    $0x10,%esp
80101a83:	85 c0                	test   %eax,%eax
80101a85:	0f 88 d8 fe ff ff    	js     80101963 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80101a8b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a8e:	0f b6 10             	movzbl (%eax),%edx
80101a91:	84 d2                	test   %dl,%dl
80101a93:	74 19                	je     80101aae <exec+0x2fe>
80101a95:	8b 4d 08             	mov    0x8(%ebp),%ecx
80101a98:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80101a9b:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80101a9e:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80101aa1:	0f 44 c8             	cmove  %eax,%ecx
80101aa4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80101aa7:	84 d2                	test   %dl,%dl
80101aa9:	75 f0                	jne    80101a9b <exec+0x2eb>
80101aab:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80101aae:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101ab4:	50                   	push   %eax
80101ab5:	6a 10                	push   $0x10
80101ab7:	ff 75 08             	pushl  0x8(%ebp)
80101aba:	89 f8                	mov    %edi,%eax
80101abc:	83 c0 6c             	add    $0x6c,%eax
80101abf:	50                   	push   %eax
80101ac0:	e8 0b 39 00 00       	call   801053d0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80101ac5:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80101acb:	89 f8                	mov    %edi,%eax
80101acd:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80101ad0:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80101ad2:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80101ad5:	89 c1                	mov    %eax,%ecx
80101ad7:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80101add:	8b 40 18             	mov    0x18(%eax),%eax
80101ae0:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101ae3:	8b 41 18             	mov    0x18(%ecx),%eax
80101ae6:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80101ae9:	89 0c 24             	mov    %ecx,(%esp)
80101aec:	e8 df 5b 00 00       	call   801076d0 <switchuvm>
  freevm(oldpgdir);
80101af1:	89 3c 24             	mov    %edi,(%esp)
80101af4:	e8 57 5f 00 00       	call   80107a50 <freevm>
  return 0;
80101af9:	83 c4 10             	add    $0x10,%esp
80101afc:	31 c0                	xor    %eax,%eax
80101afe:	e9 19 fd ff ff       	jmp    8010181c <exec+0x6c>
80101b03:	66 90                	xchg   %ax,%ax
80101b05:	66 90                	xchg   %ax,%ax
80101b07:	66 90                	xchg   %ax,%ax
80101b09:	66 90                	xchg   %ax,%ax
80101b0b:	66 90                	xchg   %ax,%ax
80101b0d:	66 90                	xchg   %ax,%ax
80101b0f:	90                   	nop

80101b10 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101b10:	55                   	push   %ebp
80101b11:	89 e5                	mov    %esp,%ebp
80101b13:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101b16:	68 95 81 10 80       	push   $0x80108195
80101b1b:	68 60 23 12 80       	push   $0x80122360
80101b20:	e8 3b 34 00 00       	call   80104f60 <initlock>
}
80101b25:	83 c4 10             	add    $0x10,%esp
80101b28:	c9                   	leave  
80101b29:	c3                   	ret    
80101b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101b30 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101b30:	55                   	push   %ebp
80101b31:	89 e5                	mov    %esp,%ebp
80101b33:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101b34:	bb 94 23 12 80       	mov    $0x80122394,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80101b39:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80101b3c:	68 60 23 12 80       	push   $0x80122360
80101b41:	e8 1a 35 00 00       	call   80105060 <acquire>
80101b46:	83 c4 10             	add    $0x10,%esp
80101b49:	eb 10                	jmp    80101b5b <filealloc+0x2b>
80101b4b:	90                   	nop
80101b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101b50:	83 c3 18             	add    $0x18,%ebx
80101b53:	81 fb f4 2c 12 80    	cmp    $0x80122cf4,%ebx
80101b59:	74 25                	je     80101b80 <filealloc+0x50>
    if(f->ref == 0){
80101b5b:	8b 43 04             	mov    0x4(%ebx),%eax
80101b5e:	85 c0                	test   %eax,%eax
80101b60:	75 ee                	jne    80101b50 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101b62:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80101b65:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80101b6c:	68 60 23 12 80       	push   $0x80122360
80101b71:	e8 0a 36 00 00       	call   80105180 <release>
      return f;
80101b76:	89 d8                	mov    %ebx,%eax
80101b78:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80101b7b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b7e:	c9                   	leave  
80101b7f:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80101b80:	83 ec 0c             	sub    $0xc,%esp
80101b83:	68 60 23 12 80       	push   $0x80122360
80101b88:	e8 f3 35 00 00       	call   80105180 <release>
  return 0;
80101b8d:	83 c4 10             	add    $0x10,%esp
80101b90:	31 c0                	xor    %eax,%eax
}
80101b92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b95:	c9                   	leave  
80101b96:	c3                   	ret    
80101b97:	89 f6                	mov    %esi,%esi
80101b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ba0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	53                   	push   %ebx
80101ba4:	83 ec 10             	sub    $0x10,%esp
80101ba7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80101baa:	68 60 23 12 80       	push   $0x80122360
80101baf:	e8 ac 34 00 00       	call   80105060 <acquire>
  if(f->ref < 1)
80101bb4:	8b 43 04             	mov    0x4(%ebx),%eax
80101bb7:	83 c4 10             	add    $0x10,%esp
80101bba:	85 c0                	test   %eax,%eax
80101bbc:	7e 1a                	jle    80101bd8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80101bbe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101bc1:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80101bc4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101bc7:	68 60 23 12 80       	push   $0x80122360
80101bcc:	e8 af 35 00 00       	call   80105180 <release>
  return f;
}
80101bd1:	89 d8                	mov    %ebx,%eax
80101bd3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101bd6:	c9                   	leave  
80101bd7:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80101bd8:	83 ec 0c             	sub    $0xc,%esp
80101bdb:	68 9c 81 10 80       	push   $0x8010819c
80101be0:	e8 db eb ff ff       	call   801007c0 <panic>
80101be5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bf0 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101bf0:	55                   	push   %ebp
80101bf1:	89 e5                	mov    %esp,%ebp
80101bf3:	57                   	push   %edi
80101bf4:	56                   	push   %esi
80101bf5:	53                   	push   %ebx
80101bf6:	83 ec 28             	sub    $0x28,%esp
80101bf9:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80101bfc:	68 60 23 12 80       	push   $0x80122360
80101c01:	e8 5a 34 00 00       	call   80105060 <acquire>
  if(f->ref < 1)
80101c06:	8b 47 04             	mov    0x4(%edi),%eax
80101c09:	83 c4 10             	add    $0x10,%esp
80101c0c:	85 c0                	test   %eax,%eax
80101c0e:	0f 8e 9b 00 00 00    	jle    80101caf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80101c14:	83 e8 01             	sub    $0x1,%eax
80101c17:	85 c0                	test   %eax,%eax
80101c19:	89 47 04             	mov    %eax,0x4(%edi)
80101c1c:	74 1a                	je     80101c38 <fileclose+0x48>
    release(&ftable.lock);
80101c1e:	c7 45 08 60 23 12 80 	movl   $0x80122360,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101c25:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c28:	5b                   	pop    %ebx
80101c29:	5e                   	pop    %esi
80101c2a:	5f                   	pop    %edi
80101c2b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80101c2c:	e9 4f 35 00 00       	jmp    80105180 <release>
80101c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80101c38:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80101c3c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101c3e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101c41:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80101c44:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101c4a:	88 45 e7             	mov    %al,-0x19(%ebp)
80101c4d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101c50:	68 60 23 12 80       	push   $0x80122360
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101c55:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101c58:	e8 23 35 00 00       	call   80105180 <release>

  if(ff.type == FD_PIPE)
80101c5d:	83 c4 10             	add    $0x10,%esp
80101c60:	83 fb 01             	cmp    $0x1,%ebx
80101c63:	74 13                	je     80101c78 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101c65:	83 fb 02             	cmp    $0x2,%ebx
80101c68:	74 26                	je     80101c90 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101c6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c6d:	5b                   	pop    %ebx
80101c6e:	5e                   	pop    %esi
80101c6f:	5f                   	pop    %edi
80101c70:	5d                   	pop    %ebp
80101c71:	c3                   	ret    
80101c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80101c78:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101c7c:	83 ec 08             	sub    $0x8,%esp
80101c7f:	53                   	push   %ebx
80101c80:	56                   	push   %esi
80101c81:	e8 2a 24 00 00       	call   801040b0 <pipeclose>
80101c86:	83 c4 10             	add    $0x10,%esp
80101c89:	eb df                	jmp    80101c6a <fileclose+0x7a>
80101c8b:	90                   	nop
80101c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80101c90:	e8 7b 1c 00 00       	call   80103910 <begin_op>
    iput(ff.ip);
80101c95:	83 ec 0c             	sub    $0xc,%esp
80101c98:	ff 75 e0             	pushl  -0x20(%ebp)
80101c9b:	e8 c0 08 00 00       	call   80102560 <iput>
    end_op();
80101ca0:	83 c4 10             	add    $0x10,%esp
  }
}
80101ca3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ca6:	5b                   	pop    %ebx
80101ca7:	5e                   	pop    %esi
80101ca8:	5f                   	pop    %edi
80101ca9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80101caa:	e9 d1 1c 00 00       	jmp    80103980 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80101caf:	83 ec 0c             	sub    $0xc,%esp
80101cb2:	68 a4 81 10 80       	push   $0x801081a4
80101cb7:	e8 04 eb ff ff       	call   801007c0 <panic>
80101cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101cc0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101cc0:	55                   	push   %ebp
80101cc1:	89 e5                	mov    %esp,%ebp
80101cc3:	53                   	push   %ebx
80101cc4:	83 ec 04             	sub    $0x4,%esp
80101cc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80101cca:	83 3b 02             	cmpl   $0x2,(%ebx)
80101ccd:	75 31                	jne    80101d00 <filestat+0x40>
    ilock(f->ip);
80101ccf:	83 ec 0c             	sub    $0xc,%esp
80101cd2:	ff 73 10             	pushl  0x10(%ebx)
80101cd5:	e8 56 07 00 00       	call   80102430 <ilock>
    stati(f->ip, st);
80101cda:	58                   	pop    %eax
80101cdb:	5a                   	pop    %edx
80101cdc:	ff 75 0c             	pushl  0xc(%ebp)
80101cdf:	ff 73 10             	pushl  0x10(%ebx)
80101ce2:	e8 f9 09 00 00       	call   801026e0 <stati>
    iunlock(f->ip);
80101ce7:	59                   	pop    %ecx
80101ce8:	ff 73 10             	pushl  0x10(%ebx)
80101ceb:	e8 20 08 00 00       	call   80102510 <iunlock>
    return 0;
80101cf0:	83 c4 10             	add    $0x10,%esp
80101cf3:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101cf5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101cf8:	c9                   	leave  
80101cf9:	c3                   	ret    
80101cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80101d00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101d05:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d08:	c9                   	leave  
80101d09:	c3                   	ret    
80101d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d10 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101d10:	55                   	push   %ebp
80101d11:	89 e5                	mov    %esp,%ebp
80101d13:	57                   	push   %edi
80101d14:	56                   	push   %esi
80101d15:	53                   	push   %ebx
80101d16:	83 ec 0c             	sub    $0xc,%esp
80101d19:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101d1c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101d1f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101d22:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101d26:	74 60                	je     80101d88 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101d28:	8b 03                	mov    (%ebx),%eax
80101d2a:	83 f8 01             	cmp    $0x1,%eax
80101d2d:	74 41                	je     80101d70 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101d2f:	83 f8 02             	cmp    $0x2,%eax
80101d32:	75 5b                	jne    80101d8f <fileread+0x7f>
    ilock(f->ip);
80101d34:	83 ec 0c             	sub    $0xc,%esp
80101d37:	ff 73 10             	pushl  0x10(%ebx)
80101d3a:	e8 f1 06 00 00       	call   80102430 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101d3f:	57                   	push   %edi
80101d40:	ff 73 14             	pushl  0x14(%ebx)
80101d43:	56                   	push   %esi
80101d44:	ff 73 10             	pushl  0x10(%ebx)
80101d47:	e8 c4 09 00 00       	call   80102710 <readi>
80101d4c:	83 c4 20             	add    $0x20,%esp
80101d4f:	85 c0                	test   %eax,%eax
80101d51:	89 c6                	mov    %eax,%esi
80101d53:	7e 03                	jle    80101d58 <fileread+0x48>
      f->off += r;
80101d55:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101d58:	83 ec 0c             	sub    $0xc,%esp
80101d5b:	ff 73 10             	pushl  0x10(%ebx)
80101d5e:	e8 ad 07 00 00       	call   80102510 <iunlock>
    return r;
80101d63:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101d66:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80101d68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d6b:	5b                   	pop    %ebx
80101d6c:	5e                   	pop    %esi
80101d6d:	5f                   	pop    %edi
80101d6e:	5d                   	pop    %ebp
80101d6f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101d70:	8b 43 0c             	mov    0xc(%ebx),%eax
80101d73:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80101d76:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d79:	5b                   	pop    %ebx
80101d7a:	5e                   	pop    %esi
80101d7b:	5f                   	pop    %edi
80101d7c:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101d7d:	e9 ce 24 00 00       	jmp    80104250 <piperead>
80101d82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80101d88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d8d:	eb d9                	jmp    80101d68 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80101d8f:	83 ec 0c             	sub    $0xc,%esp
80101d92:	68 ae 81 10 80       	push   $0x801081ae
80101d97:	e8 24 ea ff ff       	call   801007c0 <panic>
80101d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101da0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101da0:	55                   	push   %ebp
80101da1:	89 e5                	mov    %esp,%ebp
80101da3:	57                   	push   %edi
80101da4:	56                   	push   %esi
80101da5:	53                   	push   %ebx
80101da6:	83 ec 1c             	sub    $0x1c,%esp
80101da9:	8b 75 08             	mov    0x8(%ebp),%esi
80101dac:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80101daf:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101db3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101db6:	8b 45 10             	mov    0x10(%ebp),%eax
80101db9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80101dbc:	0f 84 aa 00 00 00    	je     80101e6c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101dc2:	8b 06                	mov    (%esi),%eax
80101dc4:	83 f8 01             	cmp    $0x1,%eax
80101dc7:	0f 84 c2 00 00 00    	je     80101e8f <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101dcd:	83 f8 02             	cmp    $0x2,%eax
80101dd0:	0f 85 d8 00 00 00    	jne    80101eae <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101dd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101dd9:	31 ff                	xor    %edi,%edi
80101ddb:	85 c0                	test   %eax,%eax
80101ddd:	7f 34                	jg     80101e13 <filewrite+0x73>
80101ddf:	e9 9c 00 00 00       	jmp    80101e80 <filewrite+0xe0>
80101de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101de8:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
80101deb:	83 ec 0c             	sub    $0xc,%esp
80101dee:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101df1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101df4:	e8 17 07 00 00       	call   80102510 <iunlock>
      end_op();
80101df9:	e8 82 1b 00 00       	call   80103980 <end_op>
80101dfe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e01:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101e04:	39 d8                	cmp    %ebx,%eax
80101e06:	0f 85 95 00 00 00    	jne    80101ea1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
80101e0c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101e0e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101e11:	7e 6d                	jle    80101e80 <filewrite+0xe0>
      int n1 = n - i;
80101e13:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101e16:	b8 00 06 00 00       	mov    $0x600,%eax
80101e1b:	29 fb                	sub    %edi,%ebx
80101e1d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101e23:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101e26:	e8 e5 1a 00 00       	call   80103910 <begin_op>
      ilock(f->ip);
80101e2b:	83 ec 0c             	sub    $0xc,%esp
80101e2e:	ff 76 10             	pushl  0x10(%esi)
80101e31:	e8 fa 05 00 00       	call   80102430 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101e36:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e39:	53                   	push   %ebx
80101e3a:	ff 76 14             	pushl  0x14(%esi)
80101e3d:	01 f8                	add    %edi,%eax
80101e3f:	50                   	push   %eax
80101e40:	ff 76 10             	pushl  0x10(%esi)
80101e43:	e8 c8 09 00 00       	call   80102810 <writei>
80101e48:	83 c4 20             	add    $0x20,%esp
80101e4b:	85 c0                	test   %eax,%eax
80101e4d:	7f 99                	jg     80101de8 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
80101e4f:	83 ec 0c             	sub    $0xc,%esp
80101e52:	ff 76 10             	pushl  0x10(%esi)
80101e55:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101e58:	e8 b3 06 00 00       	call   80102510 <iunlock>
      end_op();
80101e5d:	e8 1e 1b 00 00       	call   80103980 <end_op>

      if(r < 0)
80101e62:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e65:	83 c4 10             	add    $0x10,%esp
80101e68:	85 c0                	test   %eax,%eax
80101e6a:	74 98                	je     80101e04 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101e6c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101e6f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101e74:	5b                   	pop    %ebx
80101e75:	5e                   	pop    %esi
80101e76:	5f                   	pop    %edi
80101e77:	5d                   	pop    %ebp
80101e78:	c3                   	ret    
80101e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101e80:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101e83:	75 e7                	jne    80101e6c <filewrite+0xcc>
  }
  panic("filewrite");
}
80101e85:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e88:	89 f8                	mov    %edi,%eax
80101e8a:	5b                   	pop    %ebx
80101e8b:	5e                   	pop    %esi
80101e8c:	5f                   	pop    %edi
80101e8d:	5d                   	pop    %ebp
80101e8e:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80101e8f:	8b 46 0c             	mov    0xc(%esi),%eax
80101e92:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101e95:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e98:	5b                   	pop    %ebx
80101e99:	5e                   	pop    %esi
80101e9a:	5f                   	pop    %edi
80101e9b:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80101e9c:	e9 af 22 00 00       	jmp    80104150 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80101ea1:	83 ec 0c             	sub    $0xc,%esp
80101ea4:	68 b7 81 10 80       	push   $0x801081b7
80101ea9:	e8 12 e9 ff ff       	call   801007c0 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
80101eae:	83 ec 0c             	sub    $0xc,%esp
80101eb1:	68 bd 81 10 80       	push   $0x801081bd
80101eb6:	e8 05 e9 ff ff       	call   801007c0 <panic>
80101ebb:	66 90                	xchg   %ax,%ax
80101ebd:	66 90                	xchg   %ax,%ax
80101ebf:	90                   	nop

80101ec0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101ec0:	55                   	push   %ebp
80101ec1:	89 e5                	mov    %esp,%ebp
80101ec3:	57                   	push   %edi
80101ec4:	56                   	push   %esi
80101ec5:	53                   	push   %ebx
80101ec6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101ec9:	8b 0d 60 2d 12 80    	mov    0x80122d60,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101ecf:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101ed2:	85 c9                	test   %ecx,%ecx
80101ed4:	0f 84 85 00 00 00    	je     80101f5f <balloc+0x9f>
80101eda:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101ee1:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101ee4:	83 ec 08             	sub    $0x8,%esp
80101ee7:	89 f0                	mov    %esi,%eax
80101ee9:	c1 f8 0c             	sar    $0xc,%eax
80101eec:	03 05 78 2d 12 80    	add    0x80122d78,%eax
80101ef2:	50                   	push   %eax
80101ef3:	ff 75 d8             	pushl  -0x28(%ebp)
80101ef6:	e8 d5 e1 ff ff       	call   801000d0 <bread>
80101efb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101efe:	a1 60 2d 12 80       	mov    0x80122d60,%eax
80101f03:	83 c4 10             	add    $0x10,%esp
80101f06:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101f09:	31 c0                	xor    %eax,%eax
80101f0b:	eb 2d                	jmp    80101f3a <balloc+0x7a>
80101f0d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101f10:	89 c1                	mov    %eax,%ecx
80101f12:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101f17:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
80101f1a:	83 e1 07             	and    $0x7,%ecx
80101f1d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101f1f:	89 c1                	mov    %eax,%ecx
80101f21:	c1 f9 03             	sar    $0x3,%ecx
80101f24:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101f29:	85 d7                	test   %edx,%edi
80101f2b:	74 43                	je     80101f70 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101f2d:	83 c0 01             	add    $0x1,%eax
80101f30:	83 c6 01             	add    $0x1,%esi
80101f33:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101f38:	74 05                	je     80101f3f <balloc+0x7f>
80101f3a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80101f3d:	72 d1                	jb     80101f10 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101f3f:	83 ec 0c             	sub    $0xc,%esp
80101f42:	ff 75 e4             	pushl  -0x1c(%ebp)
80101f45:	e8 96 e2 ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101f4a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101f51:	83 c4 10             	add    $0x10,%esp
80101f54:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f57:	39 05 60 2d 12 80    	cmp    %eax,0x80122d60
80101f5d:	77 82                	ja     80101ee1 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101f5f:	83 ec 0c             	sub    $0xc,%esp
80101f62:	68 c7 81 10 80       	push   $0x801081c7
80101f67:	e8 54 e8 ff ff       	call   801007c0 <panic>
80101f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101f70:	09 fa                	or     %edi,%edx
80101f72:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101f75:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101f78:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101f7c:	57                   	push   %edi
80101f7d:	e8 6e 1b 00 00       	call   80103af0 <log_write>
        brelse(bp);
80101f82:	89 3c 24             	mov    %edi,(%esp)
80101f85:	e8 56 e2 ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
80101f8a:	58                   	pop    %eax
80101f8b:	5a                   	pop    %edx
80101f8c:	56                   	push   %esi
80101f8d:	ff 75 d8             	pushl  -0x28(%ebp)
80101f90:	e8 3b e1 ff ff       	call   801000d0 <bread>
80101f95:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101f97:	8d 40 5c             	lea    0x5c(%eax),%eax
80101f9a:	83 c4 0c             	add    $0xc,%esp
80101f9d:	68 00 02 00 00       	push   $0x200
80101fa2:	6a 00                	push   $0x0
80101fa4:	50                   	push   %eax
80101fa5:	e8 26 32 00 00       	call   801051d0 <memset>
  log_write(bp);
80101faa:	89 1c 24             	mov    %ebx,(%esp)
80101fad:	e8 3e 1b 00 00       	call   80103af0 <log_write>
  brelse(bp);
80101fb2:	89 1c 24             	mov    %ebx,(%esp)
80101fb5:	e8 26 e2 ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
80101fba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fbd:	89 f0                	mov    %esi,%eax
80101fbf:	5b                   	pop    %ebx
80101fc0:	5e                   	pop    %esi
80101fc1:	5f                   	pop    %edi
80101fc2:	5d                   	pop    %ebp
80101fc3:	c3                   	ret    
80101fc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101fd0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	57                   	push   %edi
80101fd4:	56                   	push   %esi
80101fd5:	53                   	push   %ebx
80101fd6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101fd8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101fda:	bb b4 2d 12 80       	mov    $0x80122db4,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101fdf:	83 ec 28             	sub    $0x28,%esp
80101fe2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101fe5:	68 80 2d 12 80       	push   $0x80122d80
80101fea:	e8 71 30 00 00       	call   80105060 <acquire>
80101fef:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101ff2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ff5:	eb 1b                	jmp    80102012 <iget+0x42>
80101ff7:	89 f6                	mov    %esi,%esi
80101ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80102000:	85 f6                	test   %esi,%esi
80102002:	74 44                	je     80102048 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102004:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010200a:	81 fb d4 49 12 80    	cmp    $0x801249d4,%ebx
80102010:	74 4e                	je     80102060 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102012:	8b 4b 08             	mov    0x8(%ebx),%ecx
80102015:	85 c9                	test   %ecx,%ecx
80102017:	7e e7                	jle    80102000 <iget+0x30>
80102019:	39 3b                	cmp    %edi,(%ebx)
8010201b:	75 e3                	jne    80102000 <iget+0x30>
8010201d:	39 53 04             	cmp    %edx,0x4(%ebx)
80102020:	75 de                	jne    80102000 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80102022:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80102025:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80102028:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010202a:	68 80 2d 12 80       	push   $0x80122d80

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010202f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80102032:	e8 49 31 00 00       	call   80105180 <release>
      return ip;
80102037:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010203a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010203d:	89 f0                	mov    %esi,%eax
8010203f:	5b                   	pop    %ebx
80102040:	5e                   	pop    %esi
80102041:	5f                   	pop    %edi
80102042:	5d                   	pop    %ebp
80102043:	c3                   	ret    
80102044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80102048:	85 c9                	test   %ecx,%ecx
8010204a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010204d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80102053:	81 fb d4 49 12 80    	cmp    $0x801249d4,%ebx
80102059:	75 b7                	jne    80102012 <iget+0x42>
8010205b:	90                   	nop
8010205c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80102060:	85 f6                	test   %esi,%esi
80102062:	74 2d                	je     80102091 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80102064:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80102067:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80102069:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010206c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80102073:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010207a:	68 80 2d 12 80       	push   $0x80122d80
8010207f:	e8 fc 30 00 00       	call   80105180 <release>

  return ip;
80102084:	83 c4 10             	add    $0x10,%esp
}
80102087:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010208a:	89 f0                	mov    %esi,%eax
8010208c:	5b                   	pop    %ebx
8010208d:	5e                   	pop    %esi
8010208e:	5f                   	pop    %edi
8010208f:	5d                   	pop    %ebp
80102090:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
80102091:	83 ec 0c             	sub    $0xc,%esp
80102094:	68 dd 81 10 80       	push   $0x801081dd
80102099:	e8 22 e7 ff ff       	call   801007c0 <panic>
8010209e:	66 90                	xchg   %ax,%ax

801020a0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801020a0:	55                   	push   %ebp
801020a1:	89 e5                	mov    %esp,%ebp
801020a3:	57                   	push   %edi
801020a4:	56                   	push   %esi
801020a5:	53                   	push   %ebx
801020a6:	89 c6                	mov    %eax,%esi
801020a8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801020ab:	83 fa 0b             	cmp    $0xb,%edx
801020ae:	77 18                	ja     801020c8 <bmap+0x28>
801020b0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
801020b3:	8b 43 5c             	mov    0x5c(%ebx),%eax
801020b6:	85 c0                	test   %eax,%eax
801020b8:	74 76                	je     80102130 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801020ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020bd:	5b                   	pop    %ebx
801020be:	5e                   	pop    %esi
801020bf:	5f                   	pop    %edi
801020c0:	5d                   	pop    %ebp
801020c1:	c3                   	ret    
801020c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801020c8:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801020cb:	83 fb 7f             	cmp    $0x7f,%ebx
801020ce:	0f 87 83 00 00 00    	ja     80102157 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801020d4:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801020da:	85 c0                	test   %eax,%eax
801020dc:	74 6a                	je     80102148 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801020de:	83 ec 08             	sub    $0x8,%esp
801020e1:	50                   	push   %eax
801020e2:	ff 36                	pushl  (%esi)
801020e4:	e8 e7 df ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801020e9:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801020ed:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801020f0:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801020f2:	8b 1a                	mov    (%edx),%ebx
801020f4:	85 db                	test   %ebx,%ebx
801020f6:	75 1d                	jne    80102115 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
801020f8:	8b 06                	mov    (%esi),%eax
801020fa:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801020fd:	e8 be fd ff ff       	call   80101ec0 <balloc>
80102102:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80102105:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80102108:	89 c3                	mov    %eax,%ebx
8010210a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010210c:	57                   	push   %edi
8010210d:	e8 de 19 00 00       	call   80103af0 <log_write>
80102112:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80102115:	83 ec 0c             	sub    $0xc,%esp
80102118:	57                   	push   %edi
80102119:	e8 c2 e0 ff ff       	call   801001e0 <brelse>
8010211e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80102121:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80102124:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80102126:	5b                   	pop    %ebx
80102127:	5e                   	pop    %esi
80102128:	5f                   	pop    %edi
80102129:	5d                   	pop    %ebp
8010212a:	c3                   	ret    
8010212b:	90                   	nop
8010212c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80102130:	8b 06                	mov    (%esi),%eax
80102132:	e8 89 fd ff ff       	call   80101ec0 <balloc>
80102137:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010213a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010213d:	5b                   	pop    %ebx
8010213e:	5e                   	pop    %esi
8010213f:	5f                   	pop    %edi
80102140:	5d                   	pop    %ebp
80102141:	c3                   	ret    
80102142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80102148:	8b 06                	mov    (%esi),%eax
8010214a:	e8 71 fd ff ff       	call   80101ec0 <balloc>
8010214f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80102155:	eb 87                	jmp    801020de <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80102157:	83 ec 0c             	sub    $0xc,%esp
8010215a:	68 ed 81 10 80       	push   $0x801081ed
8010215f:	e8 5c e6 ff ff       	call   801007c0 <panic>
80102164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010216a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102170 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80102170:	55                   	push   %ebp
80102171:	89 e5                	mov    %esp,%ebp
80102173:	56                   	push   %esi
80102174:	53                   	push   %ebx
80102175:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80102178:	83 ec 08             	sub    $0x8,%esp
8010217b:	6a 01                	push   $0x1
8010217d:	ff 75 08             	pushl  0x8(%ebp)
80102180:	e8 4b df ff ff       	call   801000d0 <bread>
80102185:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80102187:	8d 40 5c             	lea    0x5c(%eax),%eax
8010218a:	83 c4 0c             	add    $0xc,%esp
8010218d:	6a 1c                	push   $0x1c
8010218f:	50                   	push   %eax
80102190:	56                   	push   %esi
80102191:	e8 ea 30 00 00       	call   80105280 <memmove>
  brelse(bp);
80102196:	89 5d 08             	mov    %ebx,0x8(%ebp)
80102199:	83 c4 10             	add    $0x10,%esp
}
8010219c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010219f:	5b                   	pop    %ebx
801021a0:	5e                   	pop    %esi
801021a1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801021a2:	e9 39 e0 ff ff       	jmp    801001e0 <brelse>
801021a7:	89 f6                	mov    %esi,%esi
801021a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801021b0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801021b0:	55                   	push   %ebp
801021b1:	89 e5                	mov    %esp,%ebp
801021b3:	56                   	push   %esi
801021b4:	53                   	push   %ebx
801021b5:	89 d3                	mov    %edx,%ebx
801021b7:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801021b9:	83 ec 08             	sub    $0x8,%esp
801021bc:	68 60 2d 12 80       	push   $0x80122d60
801021c1:	50                   	push   %eax
801021c2:	e8 a9 ff ff ff       	call   80102170 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801021c7:	58                   	pop    %eax
801021c8:	5a                   	pop    %edx
801021c9:	89 da                	mov    %ebx,%edx
801021cb:	c1 ea 0c             	shr    $0xc,%edx
801021ce:	03 15 78 2d 12 80    	add    0x80122d78,%edx
801021d4:	52                   	push   %edx
801021d5:	56                   	push   %esi
801021d6:	e8 f5 de ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801021db:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801021dd:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
801021e3:	ba 01 00 00 00       	mov    $0x1,%edx
801021e8:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801021eb:	c1 fb 03             	sar    $0x3,%ebx
801021ee:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
801021f1:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801021f3:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801021f8:	85 d1                	test   %edx,%ecx
801021fa:	74 27                	je     80102223 <bfree+0x73>
801021fc:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801021fe:	f7 d2                	not    %edx
80102200:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80102202:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80102205:	21 d0                	and    %edx,%eax
80102207:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010220b:	56                   	push   %esi
8010220c:	e8 df 18 00 00       	call   80103af0 <log_write>
  brelse(bp);
80102211:	89 34 24             	mov    %esi,(%esp)
80102214:	e8 c7 df ff ff       	call   801001e0 <brelse>
}
80102219:	83 c4 10             	add    $0x10,%esp
8010221c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010221f:	5b                   	pop    %ebx
80102220:	5e                   	pop    %esi
80102221:	5d                   	pop    %ebp
80102222:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80102223:	83 ec 0c             	sub    $0xc,%esp
80102226:	68 00 82 10 80       	push   $0x80108200
8010222b:	e8 90 e5 ff ff       	call   801007c0 <panic>

80102230 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80102230:	55                   	push   %ebp
80102231:	89 e5                	mov    %esp,%ebp
80102233:	53                   	push   %ebx
80102234:	bb c0 2d 12 80       	mov    $0x80122dc0,%ebx
80102239:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010223c:	68 13 82 10 80       	push   $0x80108213
80102241:	68 80 2d 12 80       	push   $0x80122d80
80102246:	e8 15 2d 00 00       	call   80104f60 <initlock>
8010224b:	83 c4 10             	add    $0x10,%esp
8010224e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80102250:	83 ec 08             	sub    $0x8,%esp
80102253:	68 1a 82 10 80       	push   $0x8010821a
80102258:	53                   	push   %ebx
80102259:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010225f:	e8 ec 2b 00 00       	call   80104e50 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80102264:	83 c4 10             	add    $0x10,%esp
80102267:	81 fb e0 49 12 80    	cmp    $0x801249e0,%ebx
8010226d:	75 e1                	jne    80102250 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010226f:	83 ec 08             	sub    $0x8,%esp
80102272:	68 60 2d 12 80       	push   $0x80122d60
80102277:	ff 75 08             	pushl  0x8(%ebp)
8010227a:	e8 f1 fe ff ff       	call   80102170 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010227f:	ff 35 78 2d 12 80    	pushl  0x80122d78
80102285:	ff 35 74 2d 12 80    	pushl  0x80122d74
8010228b:	ff 35 70 2d 12 80    	pushl  0x80122d70
80102291:	ff 35 6c 2d 12 80    	pushl  0x80122d6c
80102297:	ff 35 68 2d 12 80    	pushl  0x80122d68
8010229d:	ff 35 64 2d 12 80    	pushl  0x80122d64
801022a3:	ff 35 60 2d 12 80    	pushl  0x80122d60
801022a9:	68 80 82 10 80       	push   $0x80108280
801022ae:	e8 7d e3 ff ff       	call   80100630 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801022b3:	83 c4 30             	add    $0x30,%esp
801022b6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801022b9:	c9                   	leave  
801022ba:	c3                   	ret    
801022bb:	90                   	nop
801022bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801022c0 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801022c0:	55                   	push   %ebp
801022c1:	89 e5                	mov    %esp,%ebp
801022c3:	57                   	push   %edi
801022c4:	56                   	push   %esi
801022c5:	53                   	push   %ebx
801022c6:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801022c9:	83 3d 68 2d 12 80 01 	cmpl   $0x1,0x80122d68
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801022d0:	8b 45 0c             	mov    0xc(%ebp),%eax
801022d3:	8b 75 08             	mov    0x8(%ebp),%esi
801022d6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801022d9:	0f 86 91 00 00 00    	jbe    80102370 <ialloc+0xb0>
801022df:	bb 01 00 00 00       	mov    $0x1,%ebx
801022e4:	eb 21                	jmp    80102307 <ialloc+0x47>
801022e6:	8d 76 00             	lea    0x0(%esi),%esi
801022e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801022f0:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801022f3:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
801022f6:	57                   	push   %edi
801022f7:	e8 e4 de ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801022fc:	83 c4 10             	add    $0x10,%esp
801022ff:	39 1d 68 2d 12 80    	cmp    %ebx,0x80122d68
80102305:	76 69                	jbe    80102370 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80102307:	89 d8                	mov    %ebx,%eax
80102309:	83 ec 08             	sub    $0x8,%esp
8010230c:	c1 e8 03             	shr    $0x3,%eax
8010230f:	03 05 74 2d 12 80    	add    0x80122d74,%eax
80102315:	50                   	push   %eax
80102316:	56                   	push   %esi
80102317:	e8 b4 dd ff ff       	call   801000d0 <bread>
8010231c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010231e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80102320:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80102323:	83 e0 07             	and    $0x7,%eax
80102326:	c1 e0 06             	shl    $0x6,%eax
80102329:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010232d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80102331:	75 bd                	jne    801022f0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80102333:	83 ec 04             	sub    $0x4,%esp
80102336:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102339:	6a 40                	push   $0x40
8010233b:	6a 00                	push   $0x0
8010233d:	51                   	push   %ecx
8010233e:	e8 8d 2e 00 00       	call   801051d0 <memset>
      dip->type = type;
80102343:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80102347:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010234a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010234d:	89 3c 24             	mov    %edi,(%esp)
80102350:	e8 9b 17 00 00       	call   80103af0 <log_write>
      brelse(bp);
80102355:	89 3c 24             	mov    %edi,(%esp)
80102358:	e8 83 de ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010235d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80102360:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80102363:	89 da                	mov    %ebx,%edx
80102365:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80102367:	5b                   	pop    %ebx
80102368:	5e                   	pop    %esi
80102369:	5f                   	pop    %edi
8010236a:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010236b:	e9 60 fc ff ff       	jmp    80101fd0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80102370:	83 ec 0c             	sub    $0xc,%esp
80102373:	68 20 82 10 80       	push   $0x80108220
80102378:	e8 43 e4 ff ff       	call   801007c0 <panic>
8010237d:	8d 76 00             	lea    0x0(%esi),%esi

80102380 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
80102380:	55                   	push   %ebp
80102381:	89 e5                	mov    %esp,%ebp
80102383:	56                   	push   %esi
80102384:	53                   	push   %ebx
80102385:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102388:	83 ec 08             	sub    $0x8,%esp
8010238b:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010238e:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102391:	c1 e8 03             	shr    $0x3,%eax
80102394:	03 05 74 2d 12 80    	add    0x80122d74,%eax
8010239a:	50                   	push   %eax
8010239b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010239e:	e8 2d dd ff ff       	call   801000d0 <bread>
801023a3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801023a5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801023a8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801023ac:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801023af:	83 e0 07             	and    $0x7,%eax
801023b2:	c1 e0 06             	shl    $0x6,%eax
801023b5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801023b9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801023bc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801023c0:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
801023c3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801023c7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801023cb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801023cf:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801023d3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801023d7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801023da:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801023dd:	6a 34                	push   $0x34
801023df:	53                   	push   %ebx
801023e0:	50                   	push   %eax
801023e1:	e8 9a 2e 00 00       	call   80105280 <memmove>
  log_write(bp);
801023e6:	89 34 24             	mov    %esi,(%esp)
801023e9:	e8 02 17 00 00       	call   80103af0 <log_write>
  brelse(bp);
801023ee:	89 75 08             	mov    %esi,0x8(%ebp)
801023f1:	83 c4 10             	add    $0x10,%esp
}
801023f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801023f7:	5b                   	pop    %ebx
801023f8:	5e                   	pop    %esi
801023f9:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
801023fa:	e9 e1 dd ff ff       	jmp    801001e0 <brelse>
801023ff:	90                   	nop

80102400 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80102400:	55                   	push   %ebp
80102401:	89 e5                	mov    %esp,%ebp
80102403:	53                   	push   %ebx
80102404:	83 ec 10             	sub    $0x10,%esp
80102407:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010240a:	68 80 2d 12 80       	push   $0x80122d80
8010240f:	e8 4c 2c 00 00       	call   80105060 <acquire>
  ip->ref++;
80102414:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102418:	c7 04 24 80 2d 12 80 	movl   $0x80122d80,(%esp)
8010241f:	e8 5c 2d 00 00       	call   80105180 <release>
  return ip;
}
80102424:	89 d8                	mov    %ebx,%eax
80102426:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102429:	c9                   	leave  
8010242a:	c3                   	ret    
8010242b:	90                   	nop
8010242c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102430 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80102430:	55                   	push   %ebp
80102431:	89 e5                	mov    %esp,%ebp
80102433:	56                   	push   %esi
80102434:	53                   	push   %ebx
80102435:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80102438:	85 db                	test   %ebx,%ebx
8010243a:	0f 84 b7 00 00 00    	je     801024f7 <ilock+0xc7>
80102440:	8b 53 08             	mov    0x8(%ebx),%edx
80102443:	85 d2                	test   %edx,%edx
80102445:	0f 8e ac 00 00 00    	jle    801024f7 <ilock+0xc7>
    panic("ilock");

  acquiresleep(&ip->lock);
8010244b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010244e:	83 ec 0c             	sub    $0xc,%esp
80102451:	50                   	push   %eax
80102452:	e8 39 2a 00 00       	call   80104e90 <acquiresleep>

  if(ip->valid == 0){
80102457:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010245a:	83 c4 10             	add    $0x10,%esp
8010245d:	85 c0                	test   %eax,%eax
8010245f:	74 0f                	je     80102470 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80102461:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102464:	5b                   	pop    %ebx
80102465:	5e                   	pop    %esi
80102466:	5d                   	pop    %ebp
80102467:	c3                   	ret    
80102468:	90                   	nop
80102469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102470:	8b 43 04             	mov    0x4(%ebx),%eax
80102473:	83 ec 08             	sub    $0x8,%esp
80102476:	c1 e8 03             	shr    $0x3,%eax
80102479:	03 05 74 2d 12 80    	add    0x80122d74,%eax
8010247f:	50                   	push   %eax
80102480:	ff 33                	pushl  (%ebx)
80102482:	e8 49 dc ff ff       	call   801000d0 <bread>
80102487:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80102489:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010248c:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010248f:	83 e0 07             	and    $0x7,%eax
80102492:	c1 e0 06             	shl    $0x6,%eax
80102495:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80102499:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010249c:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
8010249f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801024a3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801024a7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801024ab:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801024af:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801024b3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801024b7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801024bb:	8b 50 fc             	mov    -0x4(%eax),%edx
801024be:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801024c1:	6a 34                	push   $0x34
801024c3:	50                   	push   %eax
801024c4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801024c7:	50                   	push   %eax
801024c8:	e8 b3 2d 00 00       	call   80105280 <memmove>
    brelse(bp);
801024cd:	89 34 24             	mov    %esi,(%esp)
801024d0:	e8 0b dd ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
801024d5:	83 c4 10             	add    $0x10,%esp
801024d8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
801024dd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801024e4:	0f 85 77 ff ff ff    	jne    80102461 <ilock+0x31>
      panic("ilock: no type");
801024ea:	83 ec 0c             	sub    $0xc,%esp
801024ed:	68 38 82 10 80       	push   $0x80108238
801024f2:	e8 c9 e2 ff ff       	call   801007c0 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
801024f7:	83 ec 0c             	sub    $0xc,%esp
801024fa:	68 32 82 10 80       	push   $0x80108232
801024ff:	e8 bc e2 ff ff       	call   801007c0 <panic>
80102504:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010250a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102510 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80102510:	55                   	push   %ebp
80102511:	89 e5                	mov    %esp,%ebp
80102513:	56                   	push   %esi
80102514:	53                   	push   %ebx
80102515:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102518:	85 db                	test   %ebx,%ebx
8010251a:	74 28                	je     80102544 <iunlock+0x34>
8010251c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010251f:	83 ec 0c             	sub    $0xc,%esp
80102522:	56                   	push   %esi
80102523:	e8 08 2a 00 00       	call   80104f30 <holdingsleep>
80102528:	83 c4 10             	add    $0x10,%esp
8010252b:	85 c0                	test   %eax,%eax
8010252d:	74 15                	je     80102544 <iunlock+0x34>
8010252f:	8b 43 08             	mov    0x8(%ebx),%eax
80102532:	85 c0                	test   %eax,%eax
80102534:	7e 0e                	jle    80102544 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80102536:	89 75 08             	mov    %esi,0x8(%ebp)
}
80102539:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010253c:	5b                   	pop    %ebx
8010253d:	5e                   	pop    %esi
8010253e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010253f:	e9 ac 29 00 00       	jmp    80104ef0 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80102544:	83 ec 0c             	sub    $0xc,%esp
80102547:	68 47 82 10 80       	push   $0x80108247
8010254c:	e8 6f e2 ff ff       	call   801007c0 <panic>
80102551:	eb 0d                	jmp    80102560 <iput>
80102553:	90                   	nop
80102554:	90                   	nop
80102555:	90                   	nop
80102556:	90                   	nop
80102557:	90                   	nop
80102558:	90                   	nop
80102559:	90                   	nop
8010255a:	90                   	nop
8010255b:	90                   	nop
8010255c:	90                   	nop
8010255d:	90                   	nop
8010255e:	90                   	nop
8010255f:	90                   	nop

80102560 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	57                   	push   %edi
80102564:	56                   	push   %esi
80102565:	53                   	push   %ebx
80102566:	83 ec 28             	sub    $0x28,%esp
80102569:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
8010256c:	8d 7e 0c             	lea    0xc(%esi),%edi
8010256f:	57                   	push   %edi
80102570:	e8 1b 29 00 00       	call   80104e90 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80102575:	8b 56 4c             	mov    0x4c(%esi),%edx
80102578:	83 c4 10             	add    $0x10,%esp
8010257b:	85 d2                	test   %edx,%edx
8010257d:	74 07                	je     80102586 <iput+0x26>
8010257f:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
80102584:	74 32                	je     801025b8 <iput+0x58>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
80102586:	83 ec 0c             	sub    $0xc,%esp
80102589:	57                   	push   %edi
8010258a:	e8 61 29 00 00       	call   80104ef0 <releasesleep>

  acquire(&icache.lock);
8010258f:	c7 04 24 80 2d 12 80 	movl   $0x80122d80,(%esp)
80102596:	e8 c5 2a 00 00       	call   80105060 <acquire>
  ip->ref--;
8010259b:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
8010259f:	83 c4 10             	add    $0x10,%esp
801025a2:	c7 45 08 80 2d 12 80 	movl   $0x80122d80,0x8(%ebp)
}
801025a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801025ac:	5b                   	pop    %ebx
801025ad:	5e                   	pop    %esi
801025ae:	5f                   	pop    %edi
801025af:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
801025b0:	e9 cb 2b 00 00       	jmp    80105180 <release>
801025b5:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801025b8:	83 ec 0c             	sub    $0xc,%esp
801025bb:	68 80 2d 12 80       	push   $0x80122d80
801025c0:	e8 9b 2a 00 00       	call   80105060 <acquire>
    int r = ip->ref;
801025c5:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
801025c8:	c7 04 24 80 2d 12 80 	movl   $0x80122d80,(%esp)
801025cf:	e8 ac 2b 00 00       	call   80105180 <release>
    if(r == 1){
801025d4:	83 c4 10             	add    $0x10,%esp
801025d7:	83 fb 01             	cmp    $0x1,%ebx
801025da:	75 aa                	jne    80102586 <iput+0x26>
801025dc:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
801025e2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801025e5:	8d 5e 5c             	lea    0x5c(%esi),%ebx
801025e8:	89 cf                	mov    %ecx,%edi
801025ea:	eb 0b                	jmp    801025f7 <iput+0x97>
801025ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025f0:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801025f3:	39 fb                	cmp    %edi,%ebx
801025f5:	74 19                	je     80102610 <iput+0xb0>
    if(ip->addrs[i]){
801025f7:	8b 13                	mov    (%ebx),%edx
801025f9:	85 d2                	test   %edx,%edx
801025fb:	74 f3                	je     801025f0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801025fd:	8b 06                	mov    (%esi),%eax
801025ff:	e8 ac fb ff ff       	call   801021b0 <bfree>
      ip->addrs[i] = 0;
80102604:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010260a:	eb e4                	jmp    801025f0 <iput+0x90>
8010260c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80102610:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80102616:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102619:	85 c0                	test   %eax,%eax
8010261b:	75 33                	jne    80102650 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010261d:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80102620:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80102627:	56                   	push   %esi
80102628:	e8 53 fd ff ff       	call   80102380 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
8010262d:	31 c0                	xor    %eax,%eax
8010262f:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80102633:	89 34 24             	mov    %esi,(%esp)
80102636:	e8 45 fd ff ff       	call   80102380 <iupdate>
      ip->valid = 0;
8010263b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80102642:	83 c4 10             	add    $0x10,%esp
80102645:	e9 3c ff ff ff       	jmp    80102586 <iput+0x26>
8010264a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80102650:	83 ec 08             	sub    $0x8,%esp
80102653:	50                   	push   %eax
80102654:	ff 36                	pushl  (%esi)
80102656:	e8 75 da ff ff       	call   801000d0 <bread>
8010265b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80102661:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102664:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80102667:	8d 58 5c             	lea    0x5c(%eax),%ebx
8010266a:	83 c4 10             	add    $0x10,%esp
8010266d:	89 cf                	mov    %ecx,%edi
8010266f:	eb 0e                	jmp    8010267f <iput+0x11f>
80102671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102678:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
8010267b:	39 fb                	cmp    %edi,%ebx
8010267d:	74 0f                	je     8010268e <iput+0x12e>
      if(a[j])
8010267f:	8b 13                	mov    (%ebx),%edx
80102681:	85 d2                	test   %edx,%edx
80102683:	74 f3                	je     80102678 <iput+0x118>
        bfree(ip->dev, a[j]);
80102685:	8b 06                	mov    (%esi),%eax
80102687:	e8 24 fb ff ff       	call   801021b0 <bfree>
8010268c:	eb ea                	jmp    80102678 <iput+0x118>
    }
    brelse(bp);
8010268e:	83 ec 0c             	sub    $0xc,%esp
80102691:	ff 75 e4             	pushl  -0x1c(%ebp)
80102694:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102697:	e8 44 db ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010269c:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801026a2:	8b 06                	mov    (%esi),%eax
801026a4:	e8 07 fb ff ff       	call   801021b0 <bfree>
    ip->addrs[NDIRECT] = 0;
801026a9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801026b0:	00 00 00 
801026b3:	83 c4 10             	add    $0x10,%esp
801026b6:	e9 62 ff ff ff       	jmp    8010261d <iput+0xbd>
801026bb:	90                   	nop
801026bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801026c0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
801026c0:	55                   	push   %ebp
801026c1:	89 e5                	mov    %esp,%ebp
801026c3:	53                   	push   %ebx
801026c4:	83 ec 10             	sub    $0x10,%esp
801026c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801026ca:	53                   	push   %ebx
801026cb:	e8 40 fe ff ff       	call   80102510 <iunlock>
  iput(ip);
801026d0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801026d3:	83 c4 10             	add    $0x10,%esp
}
801026d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026d9:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
801026da:	e9 81 fe ff ff       	jmp    80102560 <iput>
801026df:	90                   	nop

801026e0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
801026e0:	55                   	push   %ebp
801026e1:	89 e5                	mov    %esp,%ebp
801026e3:	8b 55 08             	mov    0x8(%ebp),%edx
801026e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801026e9:	8b 0a                	mov    (%edx),%ecx
801026eb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801026ee:	8b 4a 04             	mov    0x4(%edx),%ecx
801026f1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801026f4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801026f8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801026fb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801026ff:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80102703:	8b 52 58             	mov    0x58(%edx),%edx
80102706:	89 50 10             	mov    %edx,0x10(%eax)
}
80102709:	5d                   	pop    %ebp
8010270a:	c3                   	ret    
8010270b:	90                   	nop
8010270c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102710 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102710:	55                   	push   %ebp
80102711:	89 e5                	mov    %esp,%ebp
80102713:	57                   	push   %edi
80102714:	56                   	push   %esi
80102715:	53                   	push   %ebx
80102716:	83 ec 1c             	sub    $0x1c,%esp
80102719:	8b 45 08             	mov    0x8(%ebp),%eax
8010271c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010271f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102722:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102727:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010272a:	8b 7d 14             	mov    0x14(%ebp),%edi
8010272d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102730:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102733:	0f 84 a7 00 00 00    	je     801027e0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80102739:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010273c:	8b 40 58             	mov    0x58(%eax),%eax
8010273f:	39 f0                	cmp    %esi,%eax
80102741:	0f 82 c1 00 00 00    	jb     80102808 <readi+0xf8>
80102747:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010274a:	89 fa                	mov    %edi,%edx
8010274c:	01 f2                	add    %esi,%edx
8010274e:	0f 82 b4 00 00 00    	jb     80102808 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80102754:	89 c1                	mov    %eax,%ecx
80102756:	29 f1                	sub    %esi,%ecx
80102758:	39 d0                	cmp    %edx,%eax
8010275a:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010275d:	31 ff                	xor    %edi,%edi
8010275f:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80102761:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102764:	74 6d                	je     801027d3 <readi+0xc3>
80102766:	8d 76 00             	lea    0x0(%esi),%esi
80102769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102770:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102773:	89 f2                	mov    %esi,%edx
80102775:	c1 ea 09             	shr    $0x9,%edx
80102778:	89 d8                	mov    %ebx,%eax
8010277a:	e8 21 f9 ff ff       	call   801020a0 <bmap>
8010277f:	83 ec 08             	sub    $0x8,%esp
80102782:	50                   	push   %eax
80102783:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
80102785:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010278a:	e8 41 d9 ff ff       	call   801000d0 <bread>
8010278f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102791:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102794:	89 f1                	mov    %esi,%ecx
80102796:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
8010279c:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
8010279f:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801027a2:	29 cb                	sub    %ecx,%ebx
801027a4:	29 f8                	sub    %edi,%eax
801027a6:	39 c3                	cmp    %eax,%ebx
801027a8:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801027ab:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
801027af:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801027b0:	01 df                	add    %ebx,%edi
801027b2:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
801027b4:	50                   	push   %eax
801027b5:	ff 75 e0             	pushl  -0x20(%ebp)
801027b8:	e8 c3 2a 00 00       	call   80105280 <memmove>
    brelse(bp);
801027bd:	8b 55 dc             	mov    -0x24(%ebp),%edx
801027c0:	89 14 24             	mov    %edx,(%esp)
801027c3:	e8 18 da ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801027c8:	01 5d e0             	add    %ebx,-0x20(%ebp)
801027cb:	83 c4 10             	add    $0x10,%esp
801027ce:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801027d1:	77 9d                	ja     80102770 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
801027d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
801027d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801027d9:	5b                   	pop    %ebx
801027da:	5e                   	pop    %esi
801027db:	5f                   	pop    %edi
801027dc:	5d                   	pop    %ebp
801027dd:	c3                   	ret    
801027de:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801027e0:	0f bf 40 52          	movswl 0x52(%eax),%eax
801027e4:	66 83 f8 09          	cmp    $0x9,%ax
801027e8:	77 1e                	ja     80102808 <readi+0xf8>
801027ea:	8b 04 c5 00 2d 12 80 	mov    -0x7fedd300(,%eax,8),%eax
801027f1:	85 c0                	test   %eax,%eax
801027f3:	74 13                	je     80102808 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
801027f5:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
801027f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801027fb:	5b                   	pop    %ebx
801027fc:	5e                   	pop    %esi
801027fd:	5f                   	pop    %edi
801027fe:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
801027ff:	ff e0                	jmp    *%eax
80102801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80102808:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010280d:	eb c7                	jmp    801027d6 <readi+0xc6>
8010280f:	90                   	nop

80102810 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102810:	55                   	push   %ebp
80102811:	89 e5                	mov    %esp,%ebp
80102813:	57                   	push   %edi
80102814:	56                   	push   %esi
80102815:	53                   	push   %ebx
80102816:	83 ec 1c             	sub    $0x1c,%esp
80102819:	8b 45 08             	mov    0x8(%ebp),%eax
8010281c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010281f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102822:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102827:	89 75 dc             	mov    %esi,-0x24(%ebp)
8010282a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010282d:	8b 75 10             	mov    0x10(%ebp),%esi
80102830:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102833:	0f 84 b7 00 00 00    	je     801028f0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80102839:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010283c:	39 70 58             	cmp    %esi,0x58(%eax)
8010283f:	0f 82 eb 00 00 00    	jb     80102930 <writei+0x120>
80102845:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102848:	89 f8                	mov    %edi,%eax
8010284a:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
8010284c:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102851:	0f 87 d9 00 00 00    	ja     80102930 <writei+0x120>
80102857:	39 c6                	cmp    %eax,%esi
80102859:	0f 87 d1 00 00 00    	ja     80102930 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010285f:	85 ff                	test   %edi,%edi
80102861:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80102868:	74 78                	je     801028e2 <writei+0xd2>
8010286a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102870:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102873:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102875:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010287a:	c1 ea 09             	shr    $0x9,%edx
8010287d:	89 f8                	mov    %edi,%eax
8010287f:	e8 1c f8 ff ff       	call   801020a0 <bmap>
80102884:	83 ec 08             	sub    $0x8,%esp
80102887:	50                   	push   %eax
80102888:	ff 37                	pushl  (%edi)
8010288a:	e8 41 d8 ff ff       	call   801000d0 <bread>
8010288f:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80102891:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102894:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80102897:	89 f1                	mov    %esi,%ecx
80102899:	83 c4 0c             	add    $0xc,%esp
8010289c:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801028a2:	29 cb                	sub    %ecx,%ebx
801028a4:	39 c3                	cmp    %eax,%ebx
801028a6:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
801028a9:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
801028ad:	53                   	push   %ebx
801028ae:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801028b1:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
801028b3:	50                   	push   %eax
801028b4:	e8 c7 29 00 00       	call   80105280 <memmove>
    log_write(bp);
801028b9:	89 3c 24             	mov    %edi,(%esp)
801028bc:	e8 2f 12 00 00       	call   80103af0 <log_write>
    brelse(bp);
801028c1:	89 3c 24             	mov    %edi,(%esp)
801028c4:	e8 17 d9 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801028c9:	01 5d e4             	add    %ebx,-0x1c(%ebp)
801028cc:	01 5d dc             	add    %ebx,-0x24(%ebp)
801028cf:	83 c4 10             	add    $0x10,%esp
801028d2:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801028d5:	39 55 e0             	cmp    %edx,-0x20(%ebp)
801028d8:	77 96                	ja     80102870 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
801028da:	8b 45 d8             	mov    -0x28(%ebp),%eax
801028dd:	3b 70 58             	cmp    0x58(%eax),%esi
801028e0:	77 36                	ja     80102918 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
801028e2:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
801028e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801028e8:	5b                   	pop    %ebx
801028e9:	5e                   	pop    %esi
801028ea:	5f                   	pop    %edi
801028eb:	5d                   	pop    %ebp
801028ec:	c3                   	ret    
801028ed:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801028f0:	0f bf 40 52          	movswl 0x52(%eax),%eax
801028f4:	66 83 f8 09          	cmp    $0x9,%ax
801028f8:	77 36                	ja     80102930 <writei+0x120>
801028fa:	8b 04 c5 04 2d 12 80 	mov    -0x7fedd2fc(,%eax,8),%eax
80102901:	85 c0                	test   %eax,%eax
80102903:	74 2b                	je     80102930 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80102905:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80102908:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010290b:	5b                   	pop    %ebx
8010290c:	5e                   	pop    %esi
8010290d:	5f                   	pop    %edi
8010290e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
8010290f:	ff e0                	jmp    *%eax
80102911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80102918:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
8010291b:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
8010291e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80102921:	50                   	push   %eax
80102922:	e8 59 fa ff ff       	call   80102380 <iupdate>
80102927:	83 c4 10             	add    $0x10,%esp
8010292a:	eb b6                	jmp    801028e2 <writei+0xd2>
8010292c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80102930:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102935:	eb ae                	jmp    801028e5 <writei+0xd5>
80102937:	89 f6                	mov    %esi,%esi
80102939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102940 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102940:	55                   	push   %ebp
80102941:	89 e5                	mov    %esp,%ebp
80102943:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102946:	6a 0e                	push   $0xe
80102948:	ff 75 0c             	pushl  0xc(%ebp)
8010294b:	ff 75 08             	pushl  0x8(%ebp)
8010294e:	e8 ad 29 00 00       	call   80105300 <strncmp>
}
80102953:	c9                   	leave  
80102954:	c3                   	ret    
80102955:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102960 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102960:	55                   	push   %ebp
80102961:	89 e5                	mov    %esp,%ebp
80102963:	57                   	push   %edi
80102964:	56                   	push   %esi
80102965:	53                   	push   %ebx
80102966:	83 ec 1c             	sub    $0x1c,%esp
80102969:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010296c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102971:	0f 85 80 00 00 00    	jne    801029f7 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102977:	8b 53 58             	mov    0x58(%ebx),%edx
8010297a:	31 ff                	xor    %edi,%edi
8010297c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010297f:	85 d2                	test   %edx,%edx
80102981:	75 0d                	jne    80102990 <dirlookup+0x30>
80102983:	eb 5b                	jmp    801029e0 <dirlookup+0x80>
80102985:	8d 76 00             	lea    0x0(%esi),%esi
80102988:	83 c7 10             	add    $0x10,%edi
8010298b:	39 7b 58             	cmp    %edi,0x58(%ebx)
8010298e:	76 50                	jbe    801029e0 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102990:	6a 10                	push   $0x10
80102992:	57                   	push   %edi
80102993:	56                   	push   %esi
80102994:	53                   	push   %ebx
80102995:	e8 76 fd ff ff       	call   80102710 <readi>
8010299a:	83 c4 10             	add    $0x10,%esp
8010299d:	83 f8 10             	cmp    $0x10,%eax
801029a0:	75 48                	jne    801029ea <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
801029a2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801029a7:	74 df                	je     80102988 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
801029a9:	8d 45 da             	lea    -0x26(%ebp),%eax
801029ac:	83 ec 04             	sub    $0x4,%esp
801029af:	6a 0e                	push   $0xe
801029b1:	50                   	push   %eax
801029b2:	ff 75 0c             	pushl  0xc(%ebp)
801029b5:	e8 46 29 00 00       	call   80105300 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
801029ba:	83 c4 10             	add    $0x10,%esp
801029bd:	85 c0                	test   %eax,%eax
801029bf:	75 c7                	jne    80102988 <dirlookup+0x28>
      // entry matches path element
      if(poff)
801029c1:	8b 45 10             	mov    0x10(%ebp),%eax
801029c4:	85 c0                	test   %eax,%eax
801029c6:	74 05                	je     801029cd <dirlookup+0x6d>
        *poff = off;
801029c8:	8b 45 10             	mov    0x10(%ebp),%eax
801029cb:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
801029cd:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
801029d1:	8b 03                	mov    (%ebx),%eax
801029d3:	e8 f8 f5 ff ff       	call   80101fd0 <iget>
    }
  }

  return 0;
}
801029d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029db:	5b                   	pop    %ebx
801029dc:	5e                   	pop    %esi
801029dd:	5f                   	pop    %edi
801029de:	5d                   	pop    %ebp
801029df:	c3                   	ret    
801029e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
801029e3:	31 c0                	xor    %eax,%eax
}
801029e5:	5b                   	pop    %ebx
801029e6:	5e                   	pop    %esi
801029e7:	5f                   	pop    %edi
801029e8:	5d                   	pop    %ebp
801029e9:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
801029ea:	83 ec 0c             	sub    $0xc,%esp
801029ed:	68 61 82 10 80       	push   $0x80108261
801029f2:	e8 c9 dd ff ff       	call   801007c0 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
801029f7:	83 ec 0c             	sub    $0xc,%esp
801029fa:	68 4f 82 10 80       	push   $0x8010824f
801029ff:	e8 bc dd ff ff       	call   801007c0 <panic>
80102a04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102a0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102a10 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102a10:	55                   	push   %ebp
80102a11:	89 e5                	mov    %esp,%ebp
80102a13:	57                   	push   %edi
80102a14:	56                   	push   %esi
80102a15:	53                   	push   %ebx
80102a16:	89 cf                	mov    %ecx,%edi
80102a18:	89 c3                	mov    %eax,%ebx
80102a1a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102a1d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102a20:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80102a23:	0f 84 53 01 00 00    	je     80102b7c <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80102a29:	e8 12 1b 00 00       	call   80104540 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80102a2e:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80102a31:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80102a34:	68 80 2d 12 80       	push   $0x80122d80
80102a39:	e8 22 26 00 00       	call   80105060 <acquire>
  ip->ref++;
80102a3e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102a42:	c7 04 24 80 2d 12 80 	movl   $0x80122d80,(%esp)
80102a49:	e8 32 27 00 00       	call   80105180 <release>
80102a4e:	83 c4 10             	add    $0x10,%esp
80102a51:	eb 08                	jmp    80102a5b <namex+0x4b>
80102a53:	90                   	nop
80102a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80102a58:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80102a5b:	0f b6 03             	movzbl (%ebx),%eax
80102a5e:	3c 2f                	cmp    $0x2f,%al
80102a60:	74 f6                	je     80102a58 <namex+0x48>
    path++;
  if(*path == 0)
80102a62:	84 c0                	test   %al,%al
80102a64:	0f 84 e3 00 00 00    	je     80102b4d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102a6a:	0f b6 03             	movzbl (%ebx),%eax
80102a6d:	89 da                	mov    %ebx,%edx
80102a6f:	84 c0                	test   %al,%al
80102a71:	0f 84 ac 00 00 00    	je     80102b23 <namex+0x113>
80102a77:	3c 2f                	cmp    $0x2f,%al
80102a79:	75 09                	jne    80102a84 <namex+0x74>
80102a7b:	e9 a3 00 00 00       	jmp    80102b23 <namex+0x113>
80102a80:	84 c0                	test   %al,%al
80102a82:	74 0a                	je     80102a8e <namex+0x7e>
    path++;
80102a84:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102a87:	0f b6 02             	movzbl (%edx),%eax
80102a8a:	3c 2f                	cmp    $0x2f,%al
80102a8c:	75 f2                	jne    80102a80 <namex+0x70>
80102a8e:	89 d1                	mov    %edx,%ecx
80102a90:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80102a92:	83 f9 0d             	cmp    $0xd,%ecx
80102a95:	0f 8e 8d 00 00 00    	jle    80102b28 <namex+0x118>
    memmove(name, s, DIRSIZ);
80102a9b:	83 ec 04             	sub    $0x4,%esp
80102a9e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102aa1:	6a 0e                	push   $0xe
80102aa3:	53                   	push   %ebx
80102aa4:	57                   	push   %edi
80102aa5:	e8 d6 27 00 00       	call   80105280 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80102aaa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80102aad:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80102ab0:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102ab2:	80 3a 2f             	cmpb   $0x2f,(%edx)
80102ab5:	75 11                	jne    80102ac8 <namex+0xb8>
80102ab7:	89 f6                	mov    %esi,%esi
80102ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80102ac0:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102ac3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102ac6:	74 f8                	je     80102ac0 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102ac8:	83 ec 0c             	sub    $0xc,%esp
80102acb:	56                   	push   %esi
80102acc:	e8 5f f9 ff ff       	call   80102430 <ilock>
    if(ip->type != T_DIR){
80102ad1:	83 c4 10             	add    $0x10,%esp
80102ad4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102ad9:	0f 85 7f 00 00 00    	jne    80102b5e <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102adf:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102ae2:	85 d2                	test   %edx,%edx
80102ae4:	74 09                	je     80102aef <namex+0xdf>
80102ae6:	80 3b 00             	cmpb   $0x0,(%ebx)
80102ae9:	0f 84 a3 00 00 00    	je     80102b92 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102aef:	83 ec 04             	sub    $0x4,%esp
80102af2:	6a 00                	push   $0x0
80102af4:	57                   	push   %edi
80102af5:	56                   	push   %esi
80102af6:	e8 65 fe ff ff       	call   80102960 <dirlookup>
80102afb:	83 c4 10             	add    $0x10,%esp
80102afe:	85 c0                	test   %eax,%eax
80102b00:	74 5c                	je     80102b5e <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80102b02:	83 ec 0c             	sub    $0xc,%esp
80102b05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102b08:	56                   	push   %esi
80102b09:	e8 02 fa ff ff       	call   80102510 <iunlock>
  iput(ip);
80102b0e:	89 34 24             	mov    %esi,(%esp)
80102b11:	e8 4a fa ff ff       	call   80102560 <iput>
80102b16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102b19:	83 c4 10             	add    $0x10,%esp
80102b1c:	89 c6                	mov    %eax,%esi
80102b1e:	e9 38 ff ff ff       	jmp    80102a5b <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102b23:	31 c9                	xor    %ecx,%ecx
80102b25:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80102b28:	83 ec 04             	sub    $0x4,%esp
80102b2b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102b2e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102b31:	51                   	push   %ecx
80102b32:	53                   	push   %ebx
80102b33:	57                   	push   %edi
80102b34:	e8 47 27 00 00       	call   80105280 <memmove>
    name[len] = 0;
80102b39:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102b3c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80102b3f:	83 c4 10             	add    $0x10,%esp
80102b42:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80102b46:	89 d3                	mov    %edx,%ebx
80102b48:	e9 65 ff ff ff       	jmp    80102ab2 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102b4d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102b50:	85 c0                	test   %eax,%eax
80102b52:	75 54                	jne    80102ba8 <namex+0x198>
80102b54:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80102b56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b59:	5b                   	pop    %ebx
80102b5a:	5e                   	pop    %esi
80102b5b:	5f                   	pop    %edi
80102b5c:	5d                   	pop    %ebp
80102b5d:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80102b5e:	83 ec 0c             	sub    $0xc,%esp
80102b61:	56                   	push   %esi
80102b62:	e8 a9 f9 ff ff       	call   80102510 <iunlock>
  iput(ip);
80102b67:	89 34 24             	mov    %esi,(%esp)
80102b6a:	e8 f1 f9 ff ff       	call   80102560 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80102b6f:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102b72:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80102b75:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102b77:	5b                   	pop    %ebx
80102b78:	5e                   	pop    %esi
80102b79:	5f                   	pop    %edi
80102b7a:	5d                   	pop    %ebp
80102b7b:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80102b7c:	ba 01 00 00 00       	mov    $0x1,%edx
80102b81:	b8 01 00 00 00       	mov    $0x1,%eax
80102b86:	e8 45 f4 ff ff       	call   80101fd0 <iget>
80102b8b:	89 c6                	mov    %eax,%esi
80102b8d:	e9 c9 fe ff ff       	jmp    80102a5b <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80102b92:	83 ec 0c             	sub    $0xc,%esp
80102b95:	56                   	push   %esi
80102b96:	e8 75 f9 ff ff       	call   80102510 <iunlock>
      return ip;
80102b9b:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102b9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80102ba1:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102ba3:	5b                   	pop    %ebx
80102ba4:	5e                   	pop    %esi
80102ba5:	5f                   	pop    %edi
80102ba6:	5d                   	pop    %ebp
80102ba7:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80102ba8:	83 ec 0c             	sub    $0xc,%esp
80102bab:	56                   	push   %esi
80102bac:	e8 af f9 ff ff       	call   80102560 <iput>
    return 0;
80102bb1:	83 c4 10             	add    $0x10,%esp
80102bb4:	31 c0                	xor    %eax,%eax
80102bb6:	eb 9e                	jmp    80102b56 <namex+0x146>
80102bb8:	90                   	nop
80102bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102bc0 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102bc0:	55                   	push   %ebp
80102bc1:	89 e5                	mov    %esp,%ebp
80102bc3:	57                   	push   %edi
80102bc4:	56                   	push   %esi
80102bc5:	53                   	push   %ebx
80102bc6:	83 ec 20             	sub    $0x20,%esp
80102bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102bcc:	6a 00                	push   $0x0
80102bce:	ff 75 0c             	pushl  0xc(%ebp)
80102bd1:	53                   	push   %ebx
80102bd2:	e8 89 fd ff ff       	call   80102960 <dirlookup>
80102bd7:	83 c4 10             	add    $0x10,%esp
80102bda:	85 c0                	test   %eax,%eax
80102bdc:	75 67                	jne    80102c45 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102bde:	8b 7b 58             	mov    0x58(%ebx),%edi
80102be1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102be4:	85 ff                	test   %edi,%edi
80102be6:	74 29                	je     80102c11 <dirlink+0x51>
80102be8:	31 ff                	xor    %edi,%edi
80102bea:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102bed:	eb 09                	jmp    80102bf8 <dirlink+0x38>
80102bef:	90                   	nop
80102bf0:	83 c7 10             	add    $0x10,%edi
80102bf3:	39 7b 58             	cmp    %edi,0x58(%ebx)
80102bf6:	76 19                	jbe    80102c11 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102bf8:	6a 10                	push   $0x10
80102bfa:	57                   	push   %edi
80102bfb:	56                   	push   %esi
80102bfc:	53                   	push   %ebx
80102bfd:	e8 0e fb ff ff       	call   80102710 <readi>
80102c02:	83 c4 10             	add    $0x10,%esp
80102c05:	83 f8 10             	cmp    $0x10,%eax
80102c08:	75 4e                	jne    80102c58 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80102c0a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102c0f:	75 df                	jne    80102bf0 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80102c11:	8d 45 da             	lea    -0x26(%ebp),%eax
80102c14:	83 ec 04             	sub    $0x4,%esp
80102c17:	6a 0e                	push   $0xe
80102c19:	ff 75 0c             	pushl  0xc(%ebp)
80102c1c:	50                   	push   %eax
80102c1d:	e8 4e 27 00 00       	call   80105370 <strncpy>
  de.inum = inum;
80102c22:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102c25:	6a 10                	push   $0x10
80102c27:	57                   	push   %edi
80102c28:	56                   	push   %esi
80102c29:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80102c2a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102c2e:	e8 dd fb ff ff       	call   80102810 <writei>
80102c33:	83 c4 20             	add    $0x20,%esp
80102c36:	83 f8 10             	cmp    $0x10,%eax
80102c39:	75 2a                	jne    80102c65 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80102c3b:	31 c0                	xor    %eax,%eax
}
80102c3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c40:	5b                   	pop    %ebx
80102c41:	5e                   	pop    %esi
80102c42:	5f                   	pop    %edi
80102c43:	5d                   	pop    %ebp
80102c44:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80102c45:	83 ec 0c             	sub    $0xc,%esp
80102c48:	50                   	push   %eax
80102c49:	e8 12 f9 ff ff       	call   80102560 <iput>
    return -1;
80102c4e:	83 c4 10             	add    $0x10,%esp
80102c51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c56:	eb e5                	jmp    80102c3d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80102c58:	83 ec 0c             	sub    $0xc,%esp
80102c5b:	68 70 82 10 80       	push   $0x80108270
80102c60:	e8 5b db ff ff       	call   801007c0 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80102c65:	83 ec 0c             	sub    $0xc,%esp
80102c68:	68 62 88 10 80       	push   $0x80108862
80102c6d:	e8 4e db ff ff       	call   801007c0 <panic>
80102c72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c80 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80102c80:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102c81:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80102c83:	89 e5                	mov    %esp,%ebp
80102c85:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102c88:	8b 45 08             	mov    0x8(%ebp),%eax
80102c8b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102c8e:	e8 7d fd ff ff       	call   80102a10 <namex>
}
80102c93:	c9                   	leave  
80102c94:	c3                   	ret    
80102c95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ca0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102ca0:	55                   	push   %ebp
  return namex(path, 1, name);
80102ca1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80102ca6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102ca8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102cab:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102cae:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80102caf:	e9 5c fd ff ff       	jmp    80102a10 <namex>
80102cb4:	66 90                	xchg   %ax,%ax
80102cb6:	66 90                	xchg   %ax,%ax
80102cb8:	66 90                	xchg   %ax,%ax
80102cba:	66 90                	xchg   %ax,%ax
80102cbc:	66 90                	xchg   %ax,%ax
80102cbe:	66 90                	xchg   %ax,%ax

80102cc0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102cc0:	55                   	push   %ebp
  if(b == 0)
80102cc1:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102cc3:	89 e5                	mov    %esp,%ebp
80102cc5:	56                   	push   %esi
80102cc6:	53                   	push   %ebx
  if(b == 0)
80102cc7:	0f 84 ad 00 00 00    	je     80102d7a <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102ccd:	8b 58 08             	mov    0x8(%eax),%ebx
80102cd0:	89 c1                	mov    %eax,%ecx
80102cd2:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80102cd8:	0f 87 8f 00 00 00    	ja     80102d6d <idestart+0xad>
80102cde:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102ce3:	90                   	nop
80102ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ce8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102ce9:	83 e0 c0             	and    $0xffffffc0,%eax
80102cec:	3c 40                	cmp    $0x40,%al
80102cee:	75 f8                	jne    80102ce8 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cf0:	31 f6                	xor    %esi,%esi
80102cf2:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102cf7:	89 f0                	mov    %esi,%eax
80102cf9:	ee                   	out    %al,(%dx)
80102cfa:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102cff:	b8 01 00 00 00       	mov    $0x1,%eax
80102d04:	ee                   	out    %al,(%dx)
80102d05:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102d0a:	89 d8                	mov    %ebx,%eax
80102d0c:	ee                   	out    %al,(%dx)
80102d0d:	89 d8                	mov    %ebx,%eax
80102d0f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102d14:	c1 f8 08             	sar    $0x8,%eax
80102d17:	ee                   	out    %al,(%dx)
80102d18:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102d1d:	89 f0                	mov    %esi,%eax
80102d1f:	ee                   	out    %al,(%dx)
80102d20:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80102d24:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102d29:	83 e0 01             	and    $0x1,%eax
80102d2c:	c1 e0 04             	shl    $0x4,%eax
80102d2f:	83 c8 e0             	or     $0xffffffe0,%eax
80102d32:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80102d33:	f6 01 04             	testb  $0x4,(%ecx)
80102d36:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102d3b:	75 13                	jne    80102d50 <idestart+0x90>
80102d3d:	b8 20 00 00 00       	mov    $0x20,%eax
80102d42:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102d43:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102d46:	5b                   	pop    %ebx
80102d47:	5e                   	pop    %esi
80102d48:	5d                   	pop    %ebp
80102d49:	c3                   	ret    
80102d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102d50:	b8 30 00 00 00       	mov    $0x30,%eax
80102d55:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80102d56:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80102d5b:	8d 71 5c             	lea    0x5c(%ecx),%esi
80102d5e:	b9 80 00 00 00       	mov    $0x80,%ecx
80102d63:	fc                   	cld    
80102d64:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102d66:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102d69:	5b                   	pop    %ebx
80102d6a:	5e                   	pop    %esi
80102d6b:	5d                   	pop    %ebp
80102d6c:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80102d6d:	83 ec 0c             	sub    $0xc,%esp
80102d70:	68 dc 82 10 80       	push   $0x801082dc
80102d75:	e8 46 da ff ff       	call   801007c0 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80102d7a:	83 ec 0c             	sub    $0xc,%esp
80102d7d:	68 d3 82 10 80       	push   $0x801082d3
80102d82:	e8 39 da ff ff       	call   801007c0 <panic>
80102d87:	89 f6                	mov    %esi,%esi
80102d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102d90 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102d90:	55                   	push   %ebp
80102d91:	89 e5                	mov    %esp,%ebp
80102d93:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80102d96:	68 ee 82 10 80       	push   $0x801082ee
80102d9b:	68 c0 b5 10 80       	push   $0x8010b5c0
80102da0:	e8 bb 21 00 00       	call   80104f60 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102da5:	58                   	pop    %eax
80102da6:	a1 a0 50 12 80       	mov    0x801250a0,%eax
80102dab:	5a                   	pop    %edx
80102dac:	83 e8 01             	sub    $0x1,%eax
80102daf:	50                   	push   %eax
80102db0:	6a 0e                	push   $0xe
80102db2:	e8 a9 02 00 00       	call   80103060 <ioapicenable>
80102db7:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dba:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102dbf:	90                   	nop
80102dc0:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102dc1:	83 e0 c0             	and    $0xffffffc0,%eax
80102dc4:	3c 40                	cmp    $0x40,%al
80102dc6:	75 f8                	jne    80102dc0 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dc8:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102dcd:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102dd2:	ee                   	out    %al,(%dx)
80102dd3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dd8:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102ddd:	eb 06                	jmp    80102de5 <ideinit+0x55>
80102ddf:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102de0:	83 e9 01             	sub    $0x1,%ecx
80102de3:	74 0f                	je     80102df4 <ideinit+0x64>
80102de5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102de6:	84 c0                	test   %al,%al
80102de8:	74 f6                	je     80102de0 <ideinit+0x50>
      havedisk1 = 1;
80102dea:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
80102df1:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102df4:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102df9:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102dfe:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
80102dff:	c9                   	leave  
80102e00:	c3                   	ret    
80102e01:	eb 0d                	jmp    80102e10 <ideintr>
80102e03:	90                   	nop
80102e04:	90                   	nop
80102e05:	90                   	nop
80102e06:	90                   	nop
80102e07:	90                   	nop
80102e08:	90                   	nop
80102e09:	90                   	nop
80102e0a:	90                   	nop
80102e0b:	90                   	nop
80102e0c:	90                   	nop
80102e0d:	90                   	nop
80102e0e:	90                   	nop
80102e0f:	90                   	nop

80102e10 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	57                   	push   %edi
80102e14:	56                   	push   %esi
80102e15:	53                   	push   %ebx
80102e16:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102e19:	68 c0 b5 10 80       	push   $0x8010b5c0
80102e1e:	e8 3d 22 00 00       	call   80105060 <acquire>

  if((b = idequeue) == 0){
80102e23:	8b 1d a4 b5 10 80    	mov    0x8010b5a4,%ebx
80102e29:	83 c4 10             	add    $0x10,%esp
80102e2c:	85 db                	test   %ebx,%ebx
80102e2e:	74 34                	je     80102e64 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102e30:	8b 43 58             	mov    0x58(%ebx),%eax
80102e33:	a3 a4 b5 10 80       	mov    %eax,0x8010b5a4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102e38:	8b 33                	mov    (%ebx),%esi
80102e3a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102e40:	74 3e                	je     80102e80 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102e42:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102e45:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102e48:	83 ce 02             	or     $0x2,%esi
80102e4b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102e4d:	53                   	push   %ebx
80102e4e:	e8 4d 1e 00 00       	call   80104ca0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102e53:	a1 a4 b5 10 80       	mov    0x8010b5a4,%eax
80102e58:	83 c4 10             	add    $0x10,%esp
80102e5b:	85 c0                	test   %eax,%eax
80102e5d:	74 05                	je     80102e64 <ideintr+0x54>
    idestart(idequeue);
80102e5f:	e8 5c fe ff ff       	call   80102cc0 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
80102e64:	83 ec 0c             	sub    $0xc,%esp
80102e67:	68 c0 b5 10 80       	push   $0x8010b5c0
80102e6c:	e8 0f 23 00 00       	call   80105180 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80102e71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e74:	5b                   	pop    %ebx
80102e75:	5e                   	pop    %esi
80102e76:	5f                   	pop    %edi
80102e77:	5d                   	pop    %ebp
80102e78:	c3                   	ret    
80102e79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e80:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102e85:	8d 76 00             	lea    0x0(%esi),%esi
80102e88:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102e89:	89 c1                	mov    %eax,%ecx
80102e8b:	83 e1 c0             	and    $0xffffffc0,%ecx
80102e8e:	80 f9 40             	cmp    $0x40,%cl
80102e91:	75 f5                	jne    80102e88 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102e93:	a8 21                	test   $0x21,%al
80102e95:	75 ab                	jne    80102e42 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80102e97:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
80102e9a:	b9 80 00 00 00       	mov    $0x80,%ecx
80102e9f:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102ea4:	fc                   	cld    
80102ea5:	f3 6d                	rep insl (%dx),%es:(%edi)
80102ea7:	8b 33                	mov    (%ebx),%esi
80102ea9:	eb 97                	jmp    80102e42 <ideintr+0x32>
80102eab:	90                   	nop
80102eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102eb0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	53                   	push   %ebx
80102eb4:	83 ec 10             	sub    $0x10,%esp
80102eb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80102eba:	8d 43 0c             	lea    0xc(%ebx),%eax
80102ebd:	50                   	push   %eax
80102ebe:	e8 6d 20 00 00       	call   80104f30 <holdingsleep>
80102ec3:	83 c4 10             	add    $0x10,%esp
80102ec6:	85 c0                	test   %eax,%eax
80102ec8:	0f 84 ad 00 00 00    	je     80102f7b <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102ece:	8b 03                	mov    (%ebx),%eax
80102ed0:	83 e0 06             	and    $0x6,%eax
80102ed3:	83 f8 02             	cmp    $0x2,%eax
80102ed6:	0f 84 b9 00 00 00    	je     80102f95 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102edc:	8b 53 04             	mov    0x4(%ebx),%edx
80102edf:	85 d2                	test   %edx,%edx
80102ee1:	74 0d                	je     80102ef0 <iderw+0x40>
80102ee3:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
80102ee8:	85 c0                	test   %eax,%eax
80102eea:	0f 84 98 00 00 00    	je     80102f88 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102ef0:	83 ec 0c             	sub    $0xc,%esp
80102ef3:	68 c0 b5 10 80       	push   $0x8010b5c0
80102ef8:	e8 63 21 00 00       	call   80105060 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102efd:	8b 15 a4 b5 10 80    	mov    0x8010b5a4,%edx
80102f03:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102f06:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102f0d:	85 d2                	test   %edx,%edx
80102f0f:	75 09                	jne    80102f1a <iderw+0x6a>
80102f11:	eb 58                	jmp    80102f6b <iderw+0xbb>
80102f13:	90                   	nop
80102f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f18:	89 c2                	mov    %eax,%edx
80102f1a:	8b 42 58             	mov    0x58(%edx),%eax
80102f1d:	85 c0                	test   %eax,%eax
80102f1f:	75 f7                	jne    80102f18 <iderw+0x68>
80102f21:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80102f24:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80102f26:	3b 1d a4 b5 10 80    	cmp    0x8010b5a4,%ebx
80102f2c:	74 44                	je     80102f72 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102f2e:	8b 03                	mov    (%ebx),%eax
80102f30:	83 e0 06             	and    $0x6,%eax
80102f33:	83 f8 02             	cmp    $0x2,%eax
80102f36:	74 23                	je     80102f5b <iderw+0xab>
80102f38:	90                   	nop
80102f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80102f40:	83 ec 08             	sub    $0x8,%esp
80102f43:	68 c0 b5 10 80       	push   $0x8010b5c0
80102f48:	53                   	push   %ebx
80102f49:	e8 a2 1b 00 00       	call   80104af0 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102f4e:	8b 03                	mov    (%ebx),%eax
80102f50:	83 c4 10             	add    $0x10,%esp
80102f53:	83 e0 06             	and    $0x6,%eax
80102f56:	83 f8 02             	cmp    $0x2,%eax
80102f59:	75 e5                	jne    80102f40 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
80102f5b:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80102f62:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f65:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
80102f66:	e9 15 22 00 00       	jmp    80105180 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102f6b:	ba a4 b5 10 80       	mov    $0x8010b5a4,%edx
80102f70:	eb b2                	jmp    80102f24 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102f72:	89 d8                	mov    %ebx,%eax
80102f74:	e8 47 fd ff ff       	call   80102cc0 <idestart>
80102f79:	eb b3                	jmp    80102f2e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
80102f7b:	83 ec 0c             	sub    $0xc,%esp
80102f7e:	68 f2 82 10 80       	push   $0x801082f2
80102f83:	e8 38 d8 ff ff       	call   801007c0 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102f88:	83 ec 0c             	sub    $0xc,%esp
80102f8b:	68 1d 83 10 80       	push   $0x8010831d
80102f90:	e8 2b d8 ff ff       	call   801007c0 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102f95:	83 ec 0c             	sub    $0xc,%esp
80102f98:	68 08 83 10 80       	push   $0x80108308
80102f9d:	e8 1e d8 ff ff       	call   801007c0 <panic>
80102fa2:	66 90                	xchg   %ax,%ax
80102fa4:	66 90                	xchg   %ax,%ax
80102fa6:	66 90                	xchg   %ax,%ax
80102fa8:	66 90                	xchg   %ax,%ax
80102faa:	66 90                	xchg   %ax,%ax
80102fac:	66 90                	xchg   %ax,%ax
80102fae:	66 90                	xchg   %ax,%ax

80102fb0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102fb0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102fb1:	c7 05 d4 49 12 80 00 	movl   $0xfec00000,0x801249d4
80102fb8:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102fbb:	89 e5                	mov    %esp,%ebp
80102fbd:	56                   	push   %esi
80102fbe:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102fbf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102fc6:	00 00 00 
  return ioapic->data;
80102fc9:	8b 15 d4 49 12 80    	mov    0x801249d4,%edx
80102fcf:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102fd2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102fd8:	8b 0d d4 49 12 80    	mov    0x801249d4,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102fde:	0f b6 15 00 4b 12 80 	movzbl 0x80124b00,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102fe5:	89 f0                	mov    %esi,%eax
80102fe7:	c1 e8 10             	shr    $0x10,%eax
80102fea:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
80102fed:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102ff0:	c1 e8 18             	shr    $0x18,%eax
80102ff3:	39 d0                	cmp    %edx,%eax
80102ff5:	74 16                	je     8010300d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102ff7:	83 ec 0c             	sub    $0xc,%esp
80102ffa:	68 3c 83 10 80       	push   $0x8010833c
80102fff:	e8 2c d6 ff ff       	call   80100630 <cprintf>
80103004:	8b 0d d4 49 12 80    	mov    0x801249d4,%ecx
8010300a:	83 c4 10             	add    $0x10,%esp
8010300d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80103010:	ba 10 00 00 00       	mov    $0x10,%edx
80103015:	b8 20 00 00 00       	mov    $0x20,%eax
8010301a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80103020:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80103022:	8b 0d d4 49 12 80    	mov    0x801249d4,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80103028:	89 c3                	mov    %eax,%ebx
8010302a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80103030:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80103033:	89 59 10             	mov    %ebx,0x10(%ecx)
80103036:	8d 5a 01             	lea    0x1(%edx),%ebx
80103039:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010303c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010303e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80103040:	8b 0d d4 49 12 80    	mov    0x801249d4,%ecx
80103046:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010304d:	75 d1                	jne    80103020 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010304f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103052:	5b                   	pop    %ebx
80103053:	5e                   	pop    %esi
80103054:	5d                   	pop    %ebp
80103055:	c3                   	ret    
80103056:	8d 76 00             	lea    0x0(%esi),%esi
80103059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103060 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80103060:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80103061:	8b 0d d4 49 12 80    	mov    0x801249d4,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80103067:	89 e5                	mov    %esp,%ebp
80103069:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010306c:	8d 50 20             	lea    0x20(%eax),%edx
8010306f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80103073:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103075:	8b 0d d4 49 12 80    	mov    0x801249d4,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010307b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010307e:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80103081:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80103084:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103086:	a1 d4 49 12 80       	mov    0x801249d4,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010308b:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
8010308e:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80103091:	5d                   	pop    %ebp
80103092:	c3                   	ret    
80103093:	66 90                	xchg   %ax,%ax
80103095:	66 90                	xchg   %ax,%ax
80103097:	66 90                	xchg   %ax,%ax
80103099:	66 90                	xchg   %ax,%ax
8010309b:	66 90                	xchg   %ax,%ax
8010309d:	66 90                	xchg   %ax,%ax
8010309f:	90                   	nop

801030a0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	53                   	push   %ebx
801030a4:	83 ec 04             	sub    $0x4,%esp
801030a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801030aa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801030b0:	75 70                	jne    80103122 <kfree+0x82>
801030b2:	81 fb 48 78 12 80    	cmp    $0x80127848,%ebx
801030b8:	72 68                	jb     80103122 <kfree+0x82>
801030ba:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801030c0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801030c5:	77 5b                	ja     80103122 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801030c7:	83 ec 04             	sub    $0x4,%esp
801030ca:	68 00 10 00 00       	push   $0x1000
801030cf:	6a 01                	push   $0x1
801030d1:	53                   	push   %ebx
801030d2:	e8 f9 20 00 00       	call   801051d0 <memset>

  if(kmem.use_lock)
801030d7:	8b 15 14 4a 12 80    	mov    0x80124a14,%edx
801030dd:	83 c4 10             	add    $0x10,%esp
801030e0:	85 d2                	test   %edx,%edx
801030e2:	75 2c                	jne    80103110 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801030e4:	a1 18 4a 12 80       	mov    0x80124a18,%eax
801030e9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801030eb:	a1 14 4a 12 80       	mov    0x80124a14,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
801030f0:	89 1d 18 4a 12 80    	mov    %ebx,0x80124a18
  if(kmem.use_lock)
801030f6:	85 c0                	test   %eax,%eax
801030f8:	75 06                	jne    80103100 <kfree+0x60>
    release(&kmem.lock);
}
801030fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030fd:	c9                   	leave  
801030fe:	c3                   	ret    
801030ff:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80103100:	c7 45 08 e0 49 12 80 	movl   $0x801249e0,0x8(%ebp)
}
80103107:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010310a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010310b:	e9 70 20 00 00       	jmp    80105180 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80103110:	83 ec 0c             	sub    $0xc,%esp
80103113:	68 e0 49 12 80       	push   $0x801249e0
80103118:	e8 43 1f 00 00       	call   80105060 <acquire>
8010311d:	83 c4 10             	add    $0x10,%esp
80103120:	eb c2                	jmp    801030e4 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80103122:	83 ec 0c             	sub    $0xc,%esp
80103125:	68 6e 83 10 80       	push   $0x8010836e
8010312a:	e8 91 d6 ff ff       	call   801007c0 <panic>
8010312f:	90                   	nop

80103130 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80103130:	55                   	push   %ebp
80103131:	89 e5                	mov    %esp,%ebp
80103133:	56                   	push   %esi
80103134:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80103135:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80103138:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010313b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103141:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103147:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010314d:	39 de                	cmp    %ebx,%esi
8010314f:	72 23                	jb     80103174 <freerange+0x44>
80103151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103158:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010315e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103161:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103167:	50                   	push   %eax
80103168:	e8 33 ff ff ff       	call   801030a0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010316d:	83 c4 10             	add    $0x10,%esp
80103170:	39 f3                	cmp    %esi,%ebx
80103172:	76 e4                	jbe    80103158 <freerange+0x28>
    kfree(p);
}
80103174:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103177:	5b                   	pop    %ebx
80103178:	5e                   	pop    %esi
80103179:	5d                   	pop    %ebp
8010317a:	c3                   	ret    
8010317b:	90                   	nop
8010317c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103180 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80103180:	55                   	push   %ebp
80103181:	89 e5                	mov    %esp,%ebp
80103183:	56                   	push   %esi
80103184:	53                   	push   %ebx
80103185:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80103188:	83 ec 08             	sub    $0x8,%esp
8010318b:	68 74 83 10 80       	push   $0x80108374
80103190:	68 e0 49 12 80       	push   $0x801249e0
80103195:	e8 c6 1d 00 00       	call   80104f60 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010319a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010319d:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801031a0:	c7 05 14 4a 12 80 00 	movl   $0x0,0x80124a14
801031a7:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801031aa:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801031b0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031b6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801031bc:	39 de                	cmp    %ebx,%esi
801031be:	72 1c                	jb     801031dc <kinit1+0x5c>
    kfree(p);
801031c0:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801031c6:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031c9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801031cf:	50                   	push   %eax
801031d0:	e8 cb fe ff ff       	call   801030a0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801031d5:	83 c4 10             	add    $0x10,%esp
801031d8:	39 de                	cmp    %ebx,%esi
801031da:	73 e4                	jae    801031c0 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
801031dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801031df:	5b                   	pop    %ebx
801031e0:	5e                   	pop    %esi
801031e1:	5d                   	pop    %ebp
801031e2:	c3                   	ret    
801031e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801031f0 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
801031f0:	55                   	push   %ebp
801031f1:	89 e5                	mov    %esp,%ebp
801031f3:	56                   	push   %esi
801031f4:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801031f5:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
801031f8:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801031fb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103201:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103207:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010320d:	39 de                	cmp    %ebx,%esi
8010320f:	72 23                	jb     80103234 <kinit2+0x44>
80103211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103218:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010321e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103221:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103227:	50                   	push   %eax
80103228:	e8 73 fe ff ff       	call   801030a0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010322d:	83 c4 10             	add    $0x10,%esp
80103230:	39 de                	cmp    %ebx,%esi
80103232:	73 e4                	jae    80103218 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80103234:	c7 05 14 4a 12 80 01 	movl   $0x1,0x80124a14
8010323b:	00 00 00 
}
8010323e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103241:	5b                   	pop    %ebx
80103242:	5e                   	pop    %esi
80103243:	5d                   	pop    %ebp
80103244:	c3                   	ret    
80103245:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103250 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80103250:	55                   	push   %ebp
80103251:	89 e5                	mov    %esp,%ebp
80103253:	53                   	push   %ebx
80103254:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80103257:	a1 14 4a 12 80       	mov    0x80124a14,%eax
8010325c:	85 c0                	test   %eax,%eax
8010325e:	75 30                	jne    80103290 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80103260:	8b 1d 18 4a 12 80    	mov    0x80124a18,%ebx
  if(r)
80103266:	85 db                	test   %ebx,%ebx
80103268:	74 1c                	je     80103286 <kalloc+0x36>
    kmem.freelist = r->next;
8010326a:	8b 13                	mov    (%ebx),%edx
8010326c:	89 15 18 4a 12 80    	mov    %edx,0x80124a18
  if(kmem.use_lock)
80103272:	85 c0                	test   %eax,%eax
80103274:	74 10                	je     80103286 <kalloc+0x36>
    release(&kmem.lock);
80103276:	83 ec 0c             	sub    $0xc,%esp
80103279:	68 e0 49 12 80       	push   $0x801249e0
8010327e:	e8 fd 1e 00 00       	call   80105180 <release>
80103283:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
80103286:	89 d8                	mov    %ebx,%eax
80103288:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010328b:	c9                   	leave  
8010328c:	c3                   	ret    
8010328d:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80103290:	83 ec 0c             	sub    $0xc,%esp
80103293:	68 e0 49 12 80       	push   $0x801249e0
80103298:	e8 c3 1d 00 00       	call   80105060 <acquire>
  r = kmem.freelist;
8010329d:	8b 1d 18 4a 12 80    	mov    0x80124a18,%ebx
  if(r)
801032a3:	83 c4 10             	add    $0x10,%esp
801032a6:	a1 14 4a 12 80       	mov    0x80124a14,%eax
801032ab:	85 db                	test   %ebx,%ebx
801032ad:	75 bb                	jne    8010326a <kalloc+0x1a>
801032af:	eb c1                	jmp    80103272 <kalloc+0x22>
801032b1:	66 90                	xchg   %ax,%ax
801032b3:	66 90                	xchg   %ax,%ax
801032b5:	66 90                	xchg   %ax,%ax
801032b7:	66 90                	xchg   %ax,%ax
801032b9:	66 90                	xchg   %ax,%ax
801032bb:	66 90                	xchg   %ax,%ax
801032bd:	66 90                	xchg   %ax,%ax
801032bf:	90                   	nop

801032c0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801032c0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032c1:	ba 64 00 00 00       	mov    $0x64,%edx
801032c6:	89 e5                	mov    %esp,%ebp
801032c8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801032c9:	a8 01                	test   $0x1,%al
801032cb:	0f 84 af 00 00 00    	je     80103380 <kbdgetc+0xc0>
801032d1:	ba 60 00 00 00       	mov    $0x60,%edx
801032d6:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801032d7:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
801032da:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801032e0:	74 7e                	je     80103360 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801032e2:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801032e4:	8b 0d f4 b5 10 80    	mov    0x8010b5f4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801032ea:	79 24                	jns    80103310 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801032ec:	f6 c1 40             	test   $0x40,%cl
801032ef:	75 05                	jne    801032f6 <kbdgetc+0x36>
801032f1:	89 c2                	mov    %eax,%edx
801032f3:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801032f6:	0f b6 82 a0 84 10 80 	movzbl -0x7fef7b60(%edx),%eax
801032fd:	83 c8 40             	or     $0x40,%eax
80103300:	0f b6 c0             	movzbl %al,%eax
80103303:	f7 d0                	not    %eax
80103305:	21 c8                	and    %ecx,%eax
80103307:	a3 f4 b5 10 80       	mov    %eax,0x8010b5f4
    return 0;
8010330c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010330e:	5d                   	pop    %ebp
8010330f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80103310:	f6 c1 40             	test   $0x40,%cl
80103313:	74 09                	je     8010331e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103315:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80103318:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010331b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010331e:	0f b6 82 a0 84 10 80 	movzbl -0x7fef7b60(%edx),%eax
80103325:	09 c1                	or     %eax,%ecx
80103327:	0f b6 82 a0 83 10 80 	movzbl -0x7fef7c60(%edx),%eax
8010332e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80103330:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80103332:	89 0d f4 b5 10 80    	mov    %ecx,0x8010b5f4
  c = charcode[shift & (CTL | SHIFT)][data];
80103338:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010333b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010333e:	8b 04 85 80 83 10 80 	mov    -0x7fef7c80(,%eax,4),%eax
80103345:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80103349:	74 c3                	je     8010330e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010334b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010334e:	83 fa 19             	cmp    $0x19,%edx
80103351:	77 1d                	ja     80103370 <kbdgetc+0xb0>
      c += 'A' - 'a';
80103353:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80103356:	5d                   	pop    %ebp
80103357:	c3                   	ret    
80103358:	90                   	nop
80103359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80103360:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80103362:	83 0d f4 b5 10 80 40 	orl    $0x40,0x8010b5f4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80103369:	5d                   	pop    %ebp
8010336a:	c3                   	ret    
8010336b:	90                   	nop
8010336c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80103370:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80103373:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
80103376:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
80103377:	83 f9 19             	cmp    $0x19,%ecx
8010337a:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
8010337d:	c3                   	ret    
8010337e:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80103380:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80103385:	5d                   	pop    %ebp
80103386:	c3                   	ret    
80103387:	89 f6                	mov    %esi,%esi
80103389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103390 <kbdintr>:

void
kbdintr(void)
{
80103390:	55                   	push   %ebp
80103391:	89 e5                	mov    %esp,%ebp
80103393:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80103396:	68 c0 32 10 80       	push   $0x801032c0
8010339b:	e8 00 de ff ff       	call   801011a0 <consoleintr>
}
801033a0:	83 c4 10             	add    $0x10,%esp
801033a3:	c9                   	leave  
801033a4:	c3                   	ret    
801033a5:	66 90                	xchg   %ax,%ax
801033a7:	66 90                	xchg   %ax,%ax
801033a9:	66 90                	xchg   %ax,%ax
801033ab:	66 90                	xchg   %ax,%ax
801033ad:	66 90                	xchg   %ax,%ax
801033af:	90                   	nop

801033b0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801033b0:	a1 1c 4a 12 80       	mov    0x80124a1c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
801033b5:	55                   	push   %ebp
801033b6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801033b8:	85 c0                	test   %eax,%eax
801033ba:	0f 84 c8 00 00 00    	je     80103488 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801033c0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801033c7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801033ca:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801033cd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801033d4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801033d7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801033da:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801033e1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801033e4:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801033e7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801033ee:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801033f1:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801033f4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801033fb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801033fe:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103401:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103408:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010340b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010340e:	8b 50 30             	mov    0x30(%eax),%edx
80103411:	c1 ea 10             	shr    $0x10,%edx
80103414:	80 fa 03             	cmp    $0x3,%dl
80103417:	77 77                	ja     80103490 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103419:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80103420:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103423:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103426:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010342d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103430:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103433:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010343a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010343d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103440:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103447:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010344a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010344d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80103454:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103457:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010345a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80103461:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80103464:	8b 50 20             	mov    0x20(%eax),%edx
80103467:	89 f6                	mov    %esi,%esi
80103469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80103470:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80103476:	80 e6 10             	and    $0x10,%dh
80103479:	75 f5                	jne    80103470 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010347b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80103482:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103485:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80103488:	5d                   	pop    %ebp
80103489:	c3                   	ret    
8010348a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103490:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80103497:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010349a:	8b 50 20             	mov    0x20(%eax),%edx
8010349d:	e9 77 ff ff ff       	jmp    80103419 <lapicinit+0x69>
801034a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801034b0 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
801034b0:	a1 1c 4a 12 80       	mov    0x80124a1c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
801034b5:	55                   	push   %ebp
801034b6:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801034b8:	85 c0                	test   %eax,%eax
801034ba:	74 0c                	je     801034c8 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
801034bc:	8b 40 20             	mov    0x20(%eax),%eax
}
801034bf:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
801034c0:	c1 e8 18             	shr    $0x18,%eax
}
801034c3:	c3                   	ret    
801034c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
801034c8:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
801034ca:	5d                   	pop    %ebp
801034cb:	c3                   	ret    
801034cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801034d0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801034d0:	a1 1c 4a 12 80       	mov    0x80124a1c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
801034d5:	55                   	push   %ebp
801034d6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801034d8:	85 c0                	test   %eax,%eax
801034da:	74 0d                	je     801034e9 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801034dc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801034e3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801034e6:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
801034e9:	5d                   	pop    %ebp
801034ea:	c3                   	ret    
801034eb:	90                   	nop
801034ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801034f0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801034f0:	55                   	push   %ebp
801034f1:	89 e5                	mov    %esp,%ebp
}
801034f3:	5d                   	pop    %ebp
801034f4:	c3                   	ret    
801034f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103500 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103500:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103501:	ba 70 00 00 00       	mov    $0x70,%edx
80103506:	b8 0f 00 00 00       	mov    $0xf,%eax
8010350b:	89 e5                	mov    %esp,%ebp
8010350d:	53                   	push   %ebx
8010350e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103511:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103514:	ee                   	out    %al,(%dx)
80103515:	ba 71 00 00 00       	mov    $0x71,%edx
8010351a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010351f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103520:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103522:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103525:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010352b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010352d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80103530:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103533:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80103535:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80103538:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010353e:	a1 1c 4a 12 80       	mov    0x80124a1c,%eax
80103543:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103549:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010354c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103553:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103556:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103559:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80103560:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103563:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103566:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010356c:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010356f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103575:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103578:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010357e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103581:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103587:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
8010358a:	5b                   	pop    %ebx
8010358b:	5d                   	pop    %ebp
8010358c:	c3                   	ret    
8010358d:	8d 76 00             	lea    0x0(%esi),%esi

80103590 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80103590:	55                   	push   %ebp
80103591:	ba 70 00 00 00       	mov    $0x70,%edx
80103596:	b8 0b 00 00 00       	mov    $0xb,%eax
8010359b:	89 e5                	mov    %esp,%ebp
8010359d:	57                   	push   %edi
8010359e:	56                   	push   %esi
8010359f:	53                   	push   %ebx
801035a0:	83 ec 4c             	sub    $0x4c,%esp
801035a3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035a4:	ba 71 00 00 00       	mov    $0x71,%edx
801035a9:	ec                   	in     (%dx),%al
801035aa:	83 e0 04             	and    $0x4,%eax
801035ad:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035b0:	31 db                	xor    %ebx,%ebx
801035b2:	88 45 b7             	mov    %al,-0x49(%ebp)
801035b5:	bf 70 00 00 00       	mov    $0x70,%edi
801035ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801035c0:	89 d8                	mov    %ebx,%eax
801035c2:	89 fa                	mov    %edi,%edx
801035c4:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035c5:	b9 71 00 00 00       	mov    $0x71,%ecx
801035ca:	89 ca                	mov    %ecx,%edx
801035cc:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801035cd:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035d0:	89 fa                	mov    %edi,%edx
801035d2:	89 45 b8             	mov    %eax,-0x48(%ebp)
801035d5:	b8 02 00 00 00       	mov    $0x2,%eax
801035da:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035db:	89 ca                	mov    %ecx,%edx
801035dd:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801035de:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035e1:	89 fa                	mov    %edi,%edx
801035e3:	89 45 bc             	mov    %eax,-0x44(%ebp)
801035e6:	b8 04 00 00 00       	mov    $0x4,%eax
801035eb:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035ec:	89 ca                	mov    %ecx,%edx
801035ee:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
801035ef:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035f2:	89 fa                	mov    %edi,%edx
801035f4:	89 45 c0             	mov    %eax,-0x40(%ebp)
801035f7:	b8 07 00 00 00       	mov    $0x7,%eax
801035fc:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035fd:	89 ca                	mov    %ecx,%edx
801035ff:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80103600:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103603:	89 fa                	mov    %edi,%edx
80103605:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103608:	b8 08 00 00 00       	mov    $0x8,%eax
8010360d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010360e:	89 ca                	mov    %ecx,%edx
80103610:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80103611:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103614:	89 fa                	mov    %edi,%edx
80103616:	89 45 c8             	mov    %eax,-0x38(%ebp)
80103619:	b8 09 00 00 00       	mov    $0x9,%eax
8010361e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010361f:	89 ca                	mov    %ecx,%edx
80103621:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80103622:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103625:	89 fa                	mov    %edi,%edx
80103627:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010362a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010362f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103630:	89 ca                	mov    %ecx,%edx
80103632:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103633:	84 c0                	test   %al,%al
80103635:	78 89                	js     801035c0 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103637:	89 d8                	mov    %ebx,%eax
80103639:	89 fa                	mov    %edi,%edx
8010363b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010363c:	89 ca                	mov    %ecx,%edx
8010363e:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010363f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103642:	89 fa                	mov    %edi,%edx
80103644:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103647:	b8 02 00 00 00       	mov    $0x2,%eax
8010364c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010364d:	89 ca                	mov    %ecx,%edx
8010364f:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80103650:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103653:	89 fa                	mov    %edi,%edx
80103655:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103658:	b8 04 00 00 00       	mov    $0x4,%eax
8010365d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010365e:	89 ca                	mov    %ecx,%edx
80103660:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80103661:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103664:	89 fa                	mov    %edi,%edx
80103666:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103669:	b8 07 00 00 00       	mov    $0x7,%eax
8010366e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010366f:	89 ca                	mov    %ecx,%edx
80103671:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80103672:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103675:	89 fa                	mov    %edi,%edx
80103677:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010367a:	b8 08 00 00 00       	mov    $0x8,%eax
8010367f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103680:	89 ca                	mov    %ecx,%edx
80103682:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80103683:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103686:	89 fa                	mov    %edi,%edx
80103688:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010368b:	b8 09 00 00 00       	mov    $0x9,%eax
80103690:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103691:	89 ca                	mov    %ecx,%edx
80103693:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80103694:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80103697:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
8010369a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010369d:	8d 45 b8             	lea    -0x48(%ebp),%eax
801036a0:	6a 18                	push   $0x18
801036a2:	56                   	push   %esi
801036a3:	50                   	push   %eax
801036a4:	e8 77 1b 00 00       	call   80105220 <memcmp>
801036a9:	83 c4 10             	add    $0x10,%esp
801036ac:	85 c0                	test   %eax,%eax
801036ae:	0f 85 0c ff ff ff    	jne    801035c0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
801036b4:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
801036b8:	75 78                	jne    80103732 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801036ba:	8b 45 b8             	mov    -0x48(%ebp),%eax
801036bd:	89 c2                	mov    %eax,%edx
801036bf:	83 e0 0f             	and    $0xf,%eax
801036c2:	c1 ea 04             	shr    $0x4,%edx
801036c5:	8d 14 92             	lea    (%edx,%edx,4),%edx
801036c8:	8d 04 50             	lea    (%eax,%edx,2),%eax
801036cb:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801036ce:	8b 45 bc             	mov    -0x44(%ebp),%eax
801036d1:	89 c2                	mov    %eax,%edx
801036d3:	83 e0 0f             	and    $0xf,%eax
801036d6:	c1 ea 04             	shr    $0x4,%edx
801036d9:	8d 14 92             	lea    (%edx,%edx,4),%edx
801036dc:	8d 04 50             	lea    (%eax,%edx,2),%eax
801036df:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801036e2:	8b 45 c0             	mov    -0x40(%ebp),%eax
801036e5:	89 c2                	mov    %eax,%edx
801036e7:	83 e0 0f             	and    $0xf,%eax
801036ea:	c1 ea 04             	shr    $0x4,%edx
801036ed:	8d 14 92             	lea    (%edx,%edx,4),%edx
801036f0:	8d 04 50             	lea    (%eax,%edx,2),%eax
801036f3:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801036f6:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801036f9:	89 c2                	mov    %eax,%edx
801036fb:	83 e0 0f             	and    $0xf,%eax
801036fe:	c1 ea 04             	shr    $0x4,%edx
80103701:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103704:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103707:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010370a:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010370d:	89 c2                	mov    %eax,%edx
8010370f:	83 e0 0f             	and    $0xf,%eax
80103712:	c1 ea 04             	shr    $0x4,%edx
80103715:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103718:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010371b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
8010371e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103721:	89 c2                	mov    %eax,%edx
80103723:	83 e0 0f             	and    $0xf,%eax
80103726:	c1 ea 04             	shr    $0x4,%edx
80103729:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010372c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010372f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103732:	8b 75 08             	mov    0x8(%ebp),%esi
80103735:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103738:	89 06                	mov    %eax,(%esi)
8010373a:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010373d:	89 46 04             	mov    %eax,0x4(%esi)
80103740:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103743:	89 46 08             	mov    %eax,0x8(%esi)
80103746:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103749:	89 46 0c             	mov    %eax,0xc(%esi)
8010374c:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010374f:	89 46 10             	mov    %eax,0x10(%esi)
80103752:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103755:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80103758:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
8010375f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103762:	5b                   	pop    %ebx
80103763:	5e                   	pop    %esi
80103764:	5f                   	pop    %edi
80103765:	5d                   	pop    %ebp
80103766:	c3                   	ret    
80103767:	66 90                	xchg   %ax,%ax
80103769:	66 90                	xchg   %ax,%ax
8010376b:	66 90                	xchg   %ax,%ax
8010376d:	66 90                	xchg   %ax,%ax
8010376f:	90                   	nop

80103770 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103770:	8b 0d 68 4a 12 80    	mov    0x80124a68,%ecx
80103776:	85 c9                	test   %ecx,%ecx
80103778:	0f 8e 85 00 00 00    	jle    80103803 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
8010377e:	55                   	push   %ebp
8010377f:	89 e5                	mov    %esp,%ebp
80103781:	57                   	push   %edi
80103782:	56                   	push   %esi
80103783:	53                   	push   %ebx
80103784:	31 db                	xor    %ebx,%ebx
80103786:	83 ec 0c             	sub    $0xc,%esp
80103789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103790:	a1 54 4a 12 80       	mov    0x80124a54,%eax
80103795:	83 ec 08             	sub    $0x8,%esp
80103798:	01 d8                	add    %ebx,%eax
8010379a:	83 c0 01             	add    $0x1,%eax
8010379d:	50                   	push   %eax
8010379e:	ff 35 64 4a 12 80    	pushl  0x80124a64
801037a4:	e8 27 c9 ff ff       	call   801000d0 <bread>
801037a9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801037ab:	58                   	pop    %eax
801037ac:	5a                   	pop    %edx
801037ad:	ff 34 9d 6c 4a 12 80 	pushl  -0x7fedb594(,%ebx,4)
801037b4:	ff 35 64 4a 12 80    	pushl  0x80124a64
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801037ba:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801037bd:	e8 0e c9 ff ff       	call   801000d0 <bread>
801037c2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801037c4:	8d 47 5c             	lea    0x5c(%edi),%eax
801037c7:	83 c4 0c             	add    $0xc,%esp
801037ca:	68 00 02 00 00       	push   $0x200
801037cf:	50                   	push   %eax
801037d0:	8d 46 5c             	lea    0x5c(%esi),%eax
801037d3:	50                   	push   %eax
801037d4:	e8 a7 1a 00 00       	call   80105280 <memmove>
    bwrite(dbuf);  // write dst to disk
801037d9:	89 34 24             	mov    %esi,(%esp)
801037dc:	e8 bf c9 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
801037e1:	89 3c 24             	mov    %edi,(%esp)
801037e4:	e8 f7 c9 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
801037e9:	89 34 24             	mov    %esi,(%esp)
801037ec:	e8 ef c9 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801037f1:	83 c4 10             	add    $0x10,%esp
801037f4:	39 1d 68 4a 12 80    	cmp    %ebx,0x80124a68
801037fa:	7f 94                	jg     80103790 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
801037fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037ff:	5b                   	pop    %ebx
80103800:	5e                   	pop    %esi
80103801:	5f                   	pop    %edi
80103802:	5d                   	pop    %ebp
80103803:	f3 c3                	repz ret 
80103805:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103810 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	53                   	push   %ebx
80103814:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103817:	ff 35 54 4a 12 80    	pushl  0x80124a54
8010381d:	ff 35 64 4a 12 80    	pushl  0x80124a64
80103823:	e8 a8 c8 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80103828:	8b 0d 68 4a 12 80    	mov    0x80124a68,%ecx
  for (i = 0; i < log.lh.n; i++) {
8010382e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80103831:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103833:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80103835:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103838:	7e 1f                	jle    80103859 <write_head+0x49>
8010383a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80103841:	31 d2                	xor    %edx,%edx
80103843:	90                   	nop
80103844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80103848:	8b 8a 6c 4a 12 80    	mov    -0x7fedb594(%edx),%ecx
8010384e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80103852:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103855:	39 c2                	cmp    %eax,%edx
80103857:	75 ef                	jne    80103848 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80103859:	83 ec 0c             	sub    $0xc,%esp
8010385c:	53                   	push   %ebx
8010385d:	e8 3e c9 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80103862:	89 1c 24             	mov    %ebx,(%esp)
80103865:	e8 76 c9 ff ff       	call   801001e0 <brelse>
}
8010386a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010386d:	c9                   	leave  
8010386e:	c3                   	ret    
8010386f:	90                   	nop

80103870 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	53                   	push   %ebx
80103874:	83 ec 2c             	sub    $0x2c,%esp
80103877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
8010387a:	68 a0 85 10 80       	push   $0x801085a0
8010387f:	68 20 4a 12 80       	push   $0x80124a20
80103884:	e8 d7 16 00 00       	call   80104f60 <initlock>
  readsb(dev, &sb);
80103889:	58                   	pop    %eax
8010388a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010388d:	5a                   	pop    %edx
8010388e:	50                   	push   %eax
8010388f:	53                   	push   %ebx
80103890:	e8 db e8 ff ff       	call   80102170 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80103895:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80103898:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
8010389b:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
8010389c:	89 1d 64 4a 12 80    	mov    %ebx,0x80124a64

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
801038a2:	89 15 58 4a 12 80    	mov    %edx,0x80124a58
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
801038a8:	a3 54 4a 12 80       	mov    %eax,0x80124a54

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
801038ad:	5a                   	pop    %edx
801038ae:	50                   	push   %eax
801038af:	53                   	push   %ebx
801038b0:	e8 1b c8 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
801038b5:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
801038b8:	83 c4 10             	add    $0x10,%esp
801038bb:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
801038bd:	89 0d 68 4a 12 80    	mov    %ecx,0x80124a68
  for (i = 0; i < log.lh.n; i++) {
801038c3:	7e 1c                	jle    801038e1 <initlog+0x71>
801038c5:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
801038cc:	31 d2                	xor    %edx,%edx
801038ce:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
801038d0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
801038d4:	83 c2 04             	add    $0x4,%edx
801038d7:	89 8a 68 4a 12 80    	mov    %ecx,-0x7fedb598(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
801038dd:	39 da                	cmp    %ebx,%edx
801038df:	75 ef                	jne    801038d0 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
801038e1:	83 ec 0c             	sub    $0xc,%esp
801038e4:	50                   	push   %eax
801038e5:	e8 f6 c8 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
801038ea:	e8 81 fe ff ff       	call   80103770 <install_trans>
  log.lh.n = 0;
801038ef:	c7 05 68 4a 12 80 00 	movl   $0x0,0x80124a68
801038f6:	00 00 00 
  write_head(); // clear the log
801038f9:	e8 12 ff ff ff       	call   80103810 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
801038fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103901:	c9                   	leave  
80103902:	c3                   	ret    
80103903:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103910 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103916:	68 20 4a 12 80       	push   $0x80124a20
8010391b:	e8 40 17 00 00       	call   80105060 <acquire>
80103920:	83 c4 10             	add    $0x10,%esp
80103923:	eb 18                	jmp    8010393d <begin_op+0x2d>
80103925:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103928:	83 ec 08             	sub    $0x8,%esp
8010392b:	68 20 4a 12 80       	push   $0x80124a20
80103930:	68 20 4a 12 80       	push   $0x80124a20
80103935:	e8 b6 11 00 00       	call   80104af0 <sleep>
8010393a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
8010393d:	a1 60 4a 12 80       	mov    0x80124a60,%eax
80103942:	85 c0                	test   %eax,%eax
80103944:	75 e2                	jne    80103928 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103946:	a1 5c 4a 12 80       	mov    0x80124a5c,%eax
8010394b:	8b 15 68 4a 12 80    	mov    0x80124a68,%edx
80103951:	83 c0 01             	add    $0x1,%eax
80103954:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103957:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010395a:	83 fa 1e             	cmp    $0x1e,%edx
8010395d:	7f c9                	jg     80103928 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
8010395f:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80103962:	a3 5c 4a 12 80       	mov    %eax,0x80124a5c
      release(&log.lock);
80103967:	68 20 4a 12 80       	push   $0x80124a20
8010396c:	e8 0f 18 00 00       	call   80105180 <release>
      break;
    }
  }
}
80103971:	83 c4 10             	add    $0x10,%esp
80103974:	c9                   	leave  
80103975:	c3                   	ret    
80103976:	8d 76 00             	lea    0x0(%esi),%esi
80103979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103980 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	57                   	push   %edi
80103984:	56                   	push   %esi
80103985:	53                   	push   %ebx
80103986:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103989:	68 20 4a 12 80       	push   $0x80124a20
8010398e:	e8 cd 16 00 00       	call   80105060 <acquire>
  log.outstanding -= 1;
80103993:	a1 5c 4a 12 80       	mov    0x80124a5c,%eax
  if(log.committing)
80103998:	8b 1d 60 4a 12 80    	mov    0x80124a60,%ebx
8010399e:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
801039a1:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
801039a4:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
801039a6:	a3 5c 4a 12 80       	mov    %eax,0x80124a5c
  if(log.committing)
801039ab:	0f 85 23 01 00 00    	jne    80103ad4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
801039b1:	85 c0                	test   %eax,%eax
801039b3:	0f 85 f7 00 00 00    	jne    80103ab0 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801039b9:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
801039bc:	c7 05 60 4a 12 80 01 	movl   $0x1,0x80124a60
801039c3:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
801039c6:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801039c8:	68 20 4a 12 80       	push   $0x80124a20
801039cd:	e8 ae 17 00 00       	call   80105180 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801039d2:	8b 0d 68 4a 12 80    	mov    0x80124a68,%ecx
801039d8:	83 c4 10             	add    $0x10,%esp
801039db:	85 c9                	test   %ecx,%ecx
801039dd:	0f 8e 8a 00 00 00    	jle    80103a6d <end_op+0xed>
801039e3:	90                   	nop
801039e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801039e8:	a1 54 4a 12 80       	mov    0x80124a54,%eax
801039ed:	83 ec 08             	sub    $0x8,%esp
801039f0:	01 d8                	add    %ebx,%eax
801039f2:	83 c0 01             	add    $0x1,%eax
801039f5:	50                   	push   %eax
801039f6:	ff 35 64 4a 12 80    	pushl  0x80124a64
801039fc:	e8 cf c6 ff ff       	call   801000d0 <bread>
80103a01:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103a03:	58                   	pop    %eax
80103a04:	5a                   	pop    %edx
80103a05:	ff 34 9d 6c 4a 12 80 	pushl  -0x7fedb594(,%ebx,4)
80103a0c:	ff 35 64 4a 12 80    	pushl  0x80124a64
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103a12:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103a15:	e8 b6 c6 ff ff       	call   801000d0 <bread>
80103a1a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103a1c:	8d 40 5c             	lea    0x5c(%eax),%eax
80103a1f:	83 c4 0c             	add    $0xc,%esp
80103a22:	68 00 02 00 00       	push   $0x200
80103a27:	50                   	push   %eax
80103a28:	8d 46 5c             	lea    0x5c(%esi),%eax
80103a2b:	50                   	push   %eax
80103a2c:	e8 4f 18 00 00       	call   80105280 <memmove>
    bwrite(to);  // write the log
80103a31:	89 34 24             	mov    %esi,(%esp)
80103a34:	e8 67 c7 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80103a39:	89 3c 24             	mov    %edi,(%esp)
80103a3c:	e8 9f c7 ff ff       	call   801001e0 <brelse>
    brelse(to);
80103a41:	89 34 24             	mov    %esi,(%esp)
80103a44:	e8 97 c7 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103a49:	83 c4 10             	add    $0x10,%esp
80103a4c:	3b 1d 68 4a 12 80    	cmp    0x80124a68,%ebx
80103a52:	7c 94                	jl     801039e8 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103a54:	e8 b7 fd ff ff       	call   80103810 <write_head>
    install_trans(); // Now install writes to home locations
80103a59:	e8 12 fd ff ff       	call   80103770 <install_trans>
    log.lh.n = 0;
80103a5e:	c7 05 68 4a 12 80 00 	movl   $0x0,0x80124a68
80103a65:	00 00 00 
    write_head();    // Erase the transaction from the log
80103a68:	e8 a3 fd ff ff       	call   80103810 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80103a6d:	83 ec 0c             	sub    $0xc,%esp
80103a70:	68 20 4a 12 80       	push   $0x80124a20
80103a75:	e8 e6 15 00 00       	call   80105060 <acquire>
    log.committing = 0;
    wakeup(&log);
80103a7a:	c7 04 24 20 4a 12 80 	movl   $0x80124a20,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80103a81:	c7 05 60 4a 12 80 00 	movl   $0x0,0x80124a60
80103a88:	00 00 00 
    wakeup(&log);
80103a8b:	e8 10 12 00 00       	call   80104ca0 <wakeup>
    release(&log.lock);
80103a90:	c7 04 24 20 4a 12 80 	movl   $0x80124a20,(%esp)
80103a97:	e8 e4 16 00 00       	call   80105180 <release>
80103a9c:	83 c4 10             	add    $0x10,%esp
  }
}
80103a9f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103aa2:	5b                   	pop    %ebx
80103aa3:	5e                   	pop    %esi
80103aa4:	5f                   	pop    %edi
80103aa5:	5d                   	pop    %ebp
80103aa6:	c3                   	ret    
80103aa7:	89 f6                	mov    %esi,%esi
80103aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80103ab0:	83 ec 0c             	sub    $0xc,%esp
80103ab3:	68 20 4a 12 80       	push   $0x80124a20
80103ab8:	e8 e3 11 00 00       	call   80104ca0 <wakeup>
  }
  release(&log.lock);
80103abd:	c7 04 24 20 4a 12 80 	movl   $0x80124a20,(%esp)
80103ac4:	e8 b7 16 00 00       	call   80105180 <release>
80103ac9:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80103acc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103acf:	5b                   	pop    %ebx
80103ad0:	5e                   	pop    %esi
80103ad1:	5f                   	pop    %edi
80103ad2:	5d                   	pop    %ebp
80103ad3:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80103ad4:	83 ec 0c             	sub    $0xc,%esp
80103ad7:	68 a4 85 10 80       	push   $0x801085a4
80103adc:	e8 df cc ff ff       	call   801007c0 <panic>
80103ae1:	eb 0d                	jmp    80103af0 <log_write>
80103ae3:	90                   	nop
80103ae4:	90                   	nop
80103ae5:	90                   	nop
80103ae6:	90                   	nop
80103ae7:	90                   	nop
80103ae8:	90                   	nop
80103ae9:	90                   	nop
80103aea:	90                   	nop
80103aeb:	90                   	nop
80103aec:	90                   	nop
80103aed:	90                   	nop
80103aee:	90                   	nop
80103aef:	90                   	nop

80103af0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	53                   	push   %ebx
80103af4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103af7:	8b 15 68 4a 12 80    	mov    0x80124a68,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103afd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103b00:	83 fa 1d             	cmp    $0x1d,%edx
80103b03:	0f 8f 97 00 00 00    	jg     80103ba0 <log_write+0xb0>
80103b09:	a1 58 4a 12 80       	mov    0x80124a58,%eax
80103b0e:	83 e8 01             	sub    $0x1,%eax
80103b11:	39 c2                	cmp    %eax,%edx
80103b13:	0f 8d 87 00 00 00    	jge    80103ba0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103b19:	a1 5c 4a 12 80       	mov    0x80124a5c,%eax
80103b1e:	85 c0                	test   %eax,%eax
80103b20:	0f 8e 87 00 00 00    	jle    80103bad <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103b26:	83 ec 0c             	sub    $0xc,%esp
80103b29:	68 20 4a 12 80       	push   $0x80124a20
80103b2e:	e8 2d 15 00 00       	call   80105060 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103b33:	8b 15 68 4a 12 80    	mov    0x80124a68,%edx
80103b39:	83 c4 10             	add    $0x10,%esp
80103b3c:	83 fa 00             	cmp    $0x0,%edx
80103b3f:	7e 50                	jle    80103b91 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103b41:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80103b44:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103b46:	3b 0d 6c 4a 12 80    	cmp    0x80124a6c,%ecx
80103b4c:	75 0b                	jne    80103b59 <log_write+0x69>
80103b4e:	eb 38                	jmp    80103b88 <log_write+0x98>
80103b50:	39 0c 85 6c 4a 12 80 	cmp    %ecx,-0x7fedb594(,%eax,4)
80103b57:	74 2f                	je     80103b88 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80103b59:	83 c0 01             	add    $0x1,%eax
80103b5c:	39 d0                	cmp    %edx,%eax
80103b5e:	75 f0                	jne    80103b50 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80103b60:	89 0c 95 6c 4a 12 80 	mov    %ecx,-0x7fedb594(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80103b67:	83 c2 01             	add    $0x1,%edx
80103b6a:	89 15 68 4a 12 80    	mov    %edx,0x80124a68
  b->flags |= B_DIRTY; // prevent eviction
80103b70:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80103b73:	c7 45 08 20 4a 12 80 	movl   $0x80124a20,0x8(%ebp)
}
80103b7a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b7d:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80103b7e:	e9 fd 15 00 00       	jmp    80105180 <release>
80103b83:	90                   	nop
80103b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80103b88:	89 0c 85 6c 4a 12 80 	mov    %ecx,-0x7fedb594(,%eax,4)
80103b8f:	eb df                	jmp    80103b70 <log_write+0x80>
80103b91:	8b 43 08             	mov    0x8(%ebx),%eax
80103b94:	a3 6c 4a 12 80       	mov    %eax,0x80124a6c
  if (i == log.lh.n)
80103b99:	75 d5                	jne    80103b70 <log_write+0x80>
80103b9b:	eb ca                	jmp    80103b67 <log_write+0x77>
80103b9d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80103ba0:	83 ec 0c             	sub    $0xc,%esp
80103ba3:	68 b3 85 10 80       	push   $0x801085b3
80103ba8:	e8 13 cc ff ff       	call   801007c0 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80103bad:	83 ec 0c             	sub    $0xc,%esp
80103bb0:	68 c9 85 10 80       	push   $0x801085c9
80103bb5:	e8 06 cc ff ff       	call   801007c0 <panic>
80103bba:	66 90                	xchg   %ax,%ax
80103bbc:	66 90                	xchg   %ax,%ax
80103bbe:	66 90                	xchg   %ax,%ax

80103bc0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103bc0:	55                   	push   %ebp
80103bc1:	89 e5                	mov    %esp,%ebp
80103bc3:	53                   	push   %ebx
80103bc4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103bc7:	e8 54 09 00 00       	call   80104520 <cpuid>
80103bcc:	89 c3                	mov    %eax,%ebx
80103bce:	e8 4d 09 00 00       	call   80104520 <cpuid>
80103bd3:	83 ec 04             	sub    $0x4,%esp
80103bd6:	53                   	push   %ebx
80103bd7:	50                   	push   %eax
80103bd8:	68 e4 85 10 80       	push   $0x801085e4
80103bdd:	e8 4e ca ff ff       	call   80100630 <cprintf>
  idtinit();       // load idt register
80103be2:	e8 a9 29 00 00       	call   80106590 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103be7:	e8 b4 08 00 00       	call   801044a0 <mycpu>
80103bec:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103bee:	b8 01 00 00 00       	mov    $0x1,%eax
80103bf3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80103bfa:	e8 01 0c 00 00       	call   80104800 <scheduler>
80103bff:	90                   	nop

80103c00 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103c06:	e8 a5 3a 00 00       	call   801076b0 <switchkvm>
  seginit();
80103c0b:	e8 a0 39 00 00       	call   801075b0 <seginit>
  lapicinit();
80103c10:	e8 9b f7 ff ff       	call   801033b0 <lapicinit>
  mpmain();
80103c15:	e8 a6 ff ff ff       	call   80103bc0 <mpmain>
80103c1a:	66 90                	xchg   %ax,%ax
80103c1c:	66 90                	xchg   %ax,%ax
80103c1e:	66 90                	xchg   %ax,%ax

80103c20 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103c20:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103c24:	83 e4 f0             	and    $0xfffffff0,%esp
80103c27:	ff 71 fc             	pushl  -0x4(%ecx)
80103c2a:	55                   	push   %ebp
80103c2b:	89 e5                	mov    %esp,%ebp
80103c2d:	53                   	push   %ebx
80103c2e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103c2f:	bb 20 4b 12 80       	mov    $0x80124b20,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103c34:	83 ec 08             	sub    $0x8,%esp
80103c37:	68 00 00 40 80       	push   $0x80400000
80103c3c:	68 48 78 12 80       	push   $0x80127848
80103c41:	e8 3a f5 ff ff       	call   80103180 <kinit1>
  kvmalloc();      // kernel page table
80103c46:	e8 05 3f 00 00       	call   80107b50 <kvmalloc>
  mpinit();        // detect other processors
80103c4b:	e8 70 01 00 00       	call   80103dc0 <mpinit>
  lapicinit();     // interrupt controller
80103c50:	e8 5b f7 ff ff       	call   801033b0 <lapicinit>
  seginit();       // segment descriptors
80103c55:	e8 56 39 00 00       	call   801075b0 <seginit>
  picinit();       // disable pic
80103c5a:	e8 31 03 00 00       	call   80103f90 <picinit>
  ioapicinit();    // another interrupt controller
80103c5f:	e8 4c f3 ff ff       	call   80102fb0 <ioapicinit>
  consoleinit();   // console hardware
80103c64:	e8 e7 da ff ff       	call   80101750 <consoleinit>
  uartinit();      // serial port
80103c69:	e8 12 2c 00 00       	call   80106880 <uartinit>
  pinit();         // process table
80103c6e:	e8 0d 08 00 00       	call   80104480 <pinit>
  tvinit();        // trap vectors
80103c73:	e8 78 28 00 00       	call   801064f0 <tvinit>
  binit();         // buffer cache
80103c78:	e8 c3 c3 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103c7d:	e8 8e de ff ff       	call   80101b10 <fileinit>
  ideinit();       // disk 
80103c82:	e8 09 f1 ff ff       	call   80102d90 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103c87:	83 c4 0c             	add    $0xc,%esp
80103c8a:	68 8a 00 00 00       	push   $0x8a
80103c8f:	68 8c b4 10 80       	push   $0x8010b48c
80103c94:	68 00 70 00 80       	push   $0x80007000
80103c99:	e8 e2 15 00 00       	call   80105280 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103c9e:	69 05 a0 50 12 80 b0 	imul   $0xb0,0x801250a0,%eax
80103ca5:	00 00 00 
80103ca8:	83 c4 10             	add    $0x10,%esp
80103cab:	05 20 4b 12 80       	add    $0x80124b20,%eax
80103cb0:	39 d8                	cmp    %ebx,%eax
80103cb2:	76 6f                	jbe    80103d23 <main+0x103>
80103cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80103cb8:	e8 e3 07 00 00       	call   801044a0 <mycpu>
80103cbd:	39 d8                	cmp    %ebx,%eax
80103cbf:	74 49                	je     80103d0a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103cc1:	e8 8a f5 ff ff       	call   80103250 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80103cc6:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80103ccb:	c7 05 f8 6f 00 80 00 	movl   $0x80103c00,0x80006ff8
80103cd2:	3c 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103cd5:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103cdc:	a0 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80103cdf:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103ce4:	0f b6 03             	movzbl (%ebx),%eax
80103ce7:	83 ec 08             	sub    $0x8,%esp
80103cea:	68 00 70 00 00       	push   $0x7000
80103cef:	50                   	push   %eax
80103cf0:	e8 0b f8 ff ff       	call   80103500 <lapicstartap>
80103cf5:	83 c4 10             	add    $0x10,%esp
80103cf8:	90                   	nop
80103cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103d00:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103d06:	85 c0                	test   %eax,%eax
80103d08:	74 f6                	je     80103d00 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103d0a:	69 05 a0 50 12 80 b0 	imul   $0xb0,0x801250a0,%eax
80103d11:	00 00 00 
80103d14:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103d1a:	05 20 4b 12 80       	add    $0x80124b20,%eax
80103d1f:	39 c3                	cmp    %eax,%ebx
80103d21:	72 95                	jb     80103cb8 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103d23:	83 ec 08             	sub    $0x8,%esp
80103d26:	68 00 00 00 8e       	push   $0x8e000000
80103d2b:	68 00 00 40 80       	push   $0x80400000
80103d30:	e8 bb f4 ff ff       	call   801031f0 <kinit2>
  userinit();      // first user process
80103d35:	e8 36 08 00 00       	call   80104570 <userinit>
  mpmain();        // finish this processor's setup
80103d3a:	e8 81 fe ff ff       	call   80103bc0 <mpmain>
80103d3f:	90                   	nop

80103d40 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	57                   	push   %edi
80103d44:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103d45:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103d4b:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
80103d4c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103d4f:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103d52:	39 de                	cmp    %ebx,%esi
80103d54:	73 48                	jae    80103d9e <mpsearch1+0x5e>
80103d56:	8d 76 00             	lea    0x0(%esi),%esi
80103d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103d60:	83 ec 04             	sub    $0x4,%esp
80103d63:	8d 7e 10             	lea    0x10(%esi),%edi
80103d66:	6a 04                	push   $0x4
80103d68:	68 f8 85 10 80       	push   $0x801085f8
80103d6d:	56                   	push   %esi
80103d6e:	e8 ad 14 00 00       	call   80105220 <memcmp>
80103d73:	83 c4 10             	add    $0x10,%esp
80103d76:	85 c0                	test   %eax,%eax
80103d78:	75 1e                	jne    80103d98 <mpsearch1+0x58>
80103d7a:	8d 7e 10             	lea    0x10(%esi),%edi
80103d7d:	89 f2                	mov    %esi,%edx
80103d7f:	31 c9                	xor    %ecx,%ecx
80103d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103d88:	0f b6 02             	movzbl (%edx),%eax
80103d8b:	83 c2 01             	add    $0x1,%edx
80103d8e:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103d90:	39 fa                	cmp    %edi,%edx
80103d92:	75 f4                	jne    80103d88 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103d94:	84 c9                	test   %cl,%cl
80103d96:	74 10                	je     80103da8 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103d98:	39 fb                	cmp    %edi,%ebx
80103d9a:	89 fe                	mov    %edi,%esi
80103d9c:	77 c2                	ja     80103d60 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
80103d9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103da1:	31 c0                	xor    %eax,%eax
}
80103da3:	5b                   	pop    %ebx
80103da4:	5e                   	pop    %esi
80103da5:	5f                   	pop    %edi
80103da6:	5d                   	pop    %ebp
80103da7:	c3                   	ret    
80103da8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103dab:	89 f0                	mov    %esi,%eax
80103dad:	5b                   	pop    %ebx
80103dae:	5e                   	pop    %esi
80103daf:	5f                   	pop    %edi
80103db0:	5d                   	pop    %ebp
80103db1:	c3                   	ret    
80103db2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103dc0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103dc0:	55                   	push   %ebp
80103dc1:	89 e5                	mov    %esp,%ebp
80103dc3:	57                   	push   %edi
80103dc4:	56                   	push   %esi
80103dc5:	53                   	push   %ebx
80103dc6:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103dc9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103dd0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103dd7:	c1 e0 08             	shl    $0x8,%eax
80103dda:	09 d0                	or     %edx,%eax
80103ddc:	c1 e0 04             	shl    $0x4,%eax
80103ddf:	85 c0                	test   %eax,%eax
80103de1:	75 1b                	jne    80103dfe <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103de3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103dea:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103df1:	c1 e0 08             	shl    $0x8,%eax
80103df4:	09 d0                	or     %edx,%eax
80103df6:	c1 e0 0a             	shl    $0xa,%eax
80103df9:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
80103dfe:	ba 00 04 00 00       	mov    $0x400,%edx
80103e03:	e8 38 ff ff ff       	call   80103d40 <mpsearch1>
80103e08:	85 c0                	test   %eax,%eax
80103e0a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103e0d:	0f 84 37 01 00 00    	je     80103f4a <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103e13:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103e16:	8b 58 04             	mov    0x4(%eax),%ebx
80103e19:	85 db                	test   %ebx,%ebx
80103e1b:	0f 84 43 01 00 00    	je     80103f64 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103e21:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103e27:	83 ec 04             	sub    $0x4,%esp
80103e2a:	6a 04                	push   $0x4
80103e2c:	68 fd 85 10 80       	push   $0x801085fd
80103e31:	56                   	push   %esi
80103e32:	e8 e9 13 00 00       	call   80105220 <memcmp>
80103e37:	83 c4 10             	add    $0x10,%esp
80103e3a:	85 c0                	test   %eax,%eax
80103e3c:	0f 85 22 01 00 00    	jne    80103f64 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103e42:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103e49:	3c 01                	cmp    $0x1,%al
80103e4b:	74 08                	je     80103e55 <mpinit+0x95>
80103e4d:	3c 04                	cmp    $0x4,%al
80103e4f:	0f 85 0f 01 00 00    	jne    80103f64 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103e55:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103e5c:	85 ff                	test   %edi,%edi
80103e5e:	74 21                	je     80103e81 <mpinit+0xc1>
80103e60:	31 d2                	xor    %edx,%edx
80103e62:	31 c0                	xor    %eax,%eax
80103e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103e68:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
80103e6f:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103e70:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103e73:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103e75:	39 c7                	cmp    %eax,%edi
80103e77:	75 ef                	jne    80103e68 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103e79:	84 d2                	test   %dl,%dl
80103e7b:	0f 85 e3 00 00 00    	jne    80103f64 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103e81:	85 f6                	test   %esi,%esi
80103e83:	0f 84 db 00 00 00    	je     80103f64 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103e89:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103e8f:	a3 1c 4a 12 80       	mov    %eax,0x80124a1c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103e94:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103e9b:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80103ea1:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103ea6:	01 d6                	add    %edx,%esi
80103ea8:	90                   	nop
80103ea9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103eb0:	39 c6                	cmp    %eax,%esi
80103eb2:	76 23                	jbe    80103ed7 <mpinit+0x117>
80103eb4:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
80103eb7:	80 fa 04             	cmp    $0x4,%dl
80103eba:	0f 87 c0 00 00 00    	ja     80103f80 <mpinit+0x1c0>
80103ec0:	ff 24 95 3c 86 10 80 	jmp    *-0x7fef79c4(,%edx,4)
80103ec7:	89 f6                	mov    %esi,%esi
80103ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103ed0:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103ed3:	39 c6                	cmp    %eax,%esi
80103ed5:	77 dd                	ja     80103eb4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103ed7:	85 db                	test   %ebx,%ebx
80103ed9:	0f 84 92 00 00 00    	je     80103f71 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103edf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103ee2:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103ee6:	74 15                	je     80103efd <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103ee8:	ba 22 00 00 00       	mov    $0x22,%edx
80103eed:	b8 70 00 00 00       	mov    $0x70,%eax
80103ef2:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103ef3:	ba 23 00 00 00       	mov    $0x23,%edx
80103ef8:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103ef9:	83 c8 01             	or     $0x1,%eax
80103efc:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103efd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103f00:	5b                   	pop    %ebx
80103f01:	5e                   	pop    %esi
80103f02:	5f                   	pop    %edi
80103f03:	5d                   	pop    %ebp
80103f04:	c3                   	ret    
80103f05:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103f08:	8b 0d a0 50 12 80    	mov    0x801250a0,%ecx
80103f0e:	83 f9 07             	cmp    $0x7,%ecx
80103f11:	7f 19                	jg     80103f2c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103f13:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80103f17:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
80103f1d:	83 c1 01             	add    $0x1,%ecx
80103f20:	89 0d a0 50 12 80    	mov    %ecx,0x801250a0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103f26:	88 97 20 4b 12 80    	mov    %dl,-0x7fedb4e0(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
80103f2c:	83 c0 14             	add    $0x14,%eax
      continue;
80103f2f:	e9 7c ff ff ff       	jmp    80103eb0 <mpinit+0xf0>
80103f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103f38:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
80103f3c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103f3f:	88 15 00 4b 12 80    	mov    %dl,0x80124b00
      p += sizeof(struct mpioapic);
      continue;
80103f45:	e9 66 ff ff ff       	jmp    80103eb0 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80103f4a:	ba 00 00 01 00       	mov    $0x10000,%edx
80103f4f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103f54:	e8 e7 fd ff ff       	call   80103d40 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103f59:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80103f5b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103f5e:	0f 85 af fe ff ff    	jne    80103e13 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
80103f64:	83 ec 0c             	sub    $0xc,%esp
80103f67:	68 02 86 10 80       	push   $0x80108602
80103f6c:	e8 4f c8 ff ff       	call   801007c0 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
80103f71:	83 ec 0c             	sub    $0xc,%esp
80103f74:	68 1c 86 10 80       	push   $0x8010861c
80103f79:	e8 42 c8 ff ff       	call   801007c0 <panic>
80103f7e:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
80103f80:	31 db                	xor    %ebx,%ebx
80103f82:	e9 30 ff ff ff       	jmp    80103eb7 <mpinit+0xf7>
80103f87:	66 90                	xchg   %ax,%ax
80103f89:	66 90                	xchg   %ax,%ax
80103f8b:	66 90                	xchg   %ax,%ax
80103f8d:	66 90                	xchg   %ax,%ax
80103f8f:	90                   	nop

80103f90 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103f90:	55                   	push   %ebp
80103f91:	ba 21 00 00 00       	mov    $0x21,%edx
80103f96:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103f9b:	89 e5                	mov    %esp,%ebp
80103f9d:	ee                   	out    %al,(%dx)
80103f9e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103fa3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103fa4:	5d                   	pop    %ebp
80103fa5:	c3                   	ret    
80103fa6:	66 90                	xchg   %ax,%ax
80103fa8:	66 90                	xchg   %ax,%ax
80103faa:	66 90                	xchg   %ax,%ax
80103fac:	66 90                	xchg   %ax,%ax
80103fae:	66 90                	xchg   %ax,%ax

80103fb0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103fb0:	55                   	push   %ebp
80103fb1:	89 e5                	mov    %esp,%ebp
80103fb3:	57                   	push   %edi
80103fb4:	56                   	push   %esi
80103fb5:	53                   	push   %ebx
80103fb6:	83 ec 0c             	sub    $0xc,%esp
80103fb9:	8b 75 08             	mov    0x8(%ebp),%esi
80103fbc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103fbf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103fc5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103fcb:	e8 60 db ff ff       	call   80101b30 <filealloc>
80103fd0:	85 c0                	test   %eax,%eax
80103fd2:	89 06                	mov    %eax,(%esi)
80103fd4:	0f 84 a8 00 00 00    	je     80104082 <pipealloc+0xd2>
80103fda:	e8 51 db ff ff       	call   80101b30 <filealloc>
80103fdf:	85 c0                	test   %eax,%eax
80103fe1:	89 03                	mov    %eax,(%ebx)
80103fe3:	0f 84 87 00 00 00    	je     80104070 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103fe9:	e8 62 f2 ff ff       	call   80103250 <kalloc>
80103fee:	85 c0                	test   %eax,%eax
80103ff0:	89 c7                	mov    %eax,%edi
80103ff2:	0f 84 b0 00 00 00    	je     801040a8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103ff8:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
80103ffb:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80104002:	00 00 00 
  p->writeopen = 1;
80104005:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010400c:	00 00 00 
  p->nwrite = 0;
8010400f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104016:	00 00 00 
  p->nread = 0;
80104019:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104020:	00 00 00 
  initlock(&p->lock, "pipe");
80104023:	68 50 86 10 80       	push   $0x80108650
80104028:	50                   	push   %eax
80104029:	e8 32 0f 00 00       	call   80104f60 <initlock>
  (*f0)->type = FD_PIPE;
8010402e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80104030:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80104033:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80104039:	8b 06                	mov    (%esi),%eax
8010403b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010403f:	8b 06                	mov    (%esi),%eax
80104041:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104045:	8b 06                	mov    (%esi),%eax
80104047:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010404a:	8b 03                	mov    (%ebx),%eax
8010404c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80104052:	8b 03                	mov    (%ebx),%eax
80104054:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80104058:	8b 03                	mov    (%ebx),%eax
8010405a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010405e:	8b 03                	mov    (%ebx),%eax
80104060:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80104063:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80104066:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80104068:	5b                   	pop    %ebx
80104069:	5e                   	pop    %esi
8010406a:	5f                   	pop    %edi
8010406b:	5d                   	pop    %ebp
8010406c:	c3                   	ret    
8010406d:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80104070:	8b 06                	mov    (%esi),%eax
80104072:	85 c0                	test   %eax,%eax
80104074:	74 1e                	je     80104094 <pipealloc+0xe4>
    fileclose(*f0);
80104076:	83 ec 0c             	sub    $0xc,%esp
80104079:	50                   	push   %eax
8010407a:	e8 71 db ff ff       	call   80101bf0 <fileclose>
8010407f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80104082:	8b 03                	mov    (%ebx),%eax
80104084:	85 c0                	test   %eax,%eax
80104086:	74 0c                	je     80104094 <pipealloc+0xe4>
    fileclose(*f1);
80104088:	83 ec 0c             	sub    $0xc,%esp
8010408b:	50                   	push   %eax
8010408c:	e8 5f db ff ff       	call   80101bf0 <fileclose>
80104091:	83 c4 10             	add    $0x10,%esp
  return -1;
}
80104094:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
80104097:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010409c:	5b                   	pop    %ebx
8010409d:	5e                   	pop    %esi
8010409e:	5f                   	pop    %edi
8010409f:	5d                   	pop    %ebp
801040a0:	c3                   	ret    
801040a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801040a8:	8b 06                	mov    (%esi),%eax
801040aa:	85 c0                	test   %eax,%eax
801040ac:	75 c8                	jne    80104076 <pipealloc+0xc6>
801040ae:	eb d2                	jmp    80104082 <pipealloc+0xd2>

801040b0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
801040b0:	55                   	push   %ebp
801040b1:	89 e5                	mov    %esp,%ebp
801040b3:	56                   	push   %esi
801040b4:	53                   	push   %ebx
801040b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801040b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801040bb:	83 ec 0c             	sub    $0xc,%esp
801040be:	53                   	push   %ebx
801040bf:	e8 9c 0f 00 00       	call   80105060 <acquire>
  if(writable){
801040c4:	83 c4 10             	add    $0x10,%esp
801040c7:	85 f6                	test   %esi,%esi
801040c9:	74 45                	je     80104110 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801040cb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801040d1:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
801040d4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801040db:	00 00 00 
    wakeup(&p->nread);
801040de:	50                   	push   %eax
801040df:	e8 bc 0b 00 00       	call   80104ca0 <wakeup>
801040e4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801040e7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801040ed:	85 d2                	test   %edx,%edx
801040ef:	75 0a                	jne    801040fb <pipeclose+0x4b>
801040f1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801040f7:	85 c0                	test   %eax,%eax
801040f9:	74 35                	je     80104130 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801040fb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801040fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104101:	5b                   	pop    %ebx
80104102:	5e                   	pop    %esi
80104103:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80104104:	e9 77 10 00 00       	jmp    80105180 <release>
80104109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80104110:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80104116:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80104119:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80104120:	00 00 00 
    wakeup(&p->nwrite);
80104123:	50                   	push   %eax
80104124:	e8 77 0b 00 00       	call   80104ca0 <wakeup>
80104129:	83 c4 10             	add    $0x10,%esp
8010412c:	eb b9                	jmp    801040e7 <pipeclose+0x37>
8010412e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80104130:	83 ec 0c             	sub    $0xc,%esp
80104133:	53                   	push   %ebx
80104134:	e8 47 10 00 00       	call   80105180 <release>
    kfree((char*)p);
80104139:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010413c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010413f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104142:	5b                   	pop    %ebx
80104143:	5e                   	pop    %esi
80104144:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80104145:	e9 56 ef ff ff       	jmp    801030a0 <kfree>
8010414a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104150 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	57                   	push   %edi
80104154:	56                   	push   %esi
80104155:	53                   	push   %ebx
80104156:	83 ec 28             	sub    $0x28,%esp
80104159:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010415c:	53                   	push   %ebx
8010415d:	e8 fe 0e 00 00       	call   80105060 <acquire>
  for(i = 0; i < n; i++){
80104162:	8b 45 10             	mov    0x10(%ebp),%eax
80104165:	83 c4 10             	add    $0x10,%esp
80104168:	85 c0                	test   %eax,%eax
8010416a:	0f 8e b9 00 00 00    	jle    80104229 <pipewrite+0xd9>
80104170:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104173:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80104179:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010417f:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80104185:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80104188:	03 4d 10             	add    0x10(%ebp),%ecx
8010418b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010418e:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80104194:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
8010419a:	39 d0                	cmp    %edx,%eax
8010419c:	74 38                	je     801041d6 <pipewrite+0x86>
8010419e:	eb 59                	jmp    801041f9 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
801041a0:	e8 9b 03 00 00       	call   80104540 <myproc>
801041a5:	8b 48 24             	mov    0x24(%eax),%ecx
801041a8:	85 c9                	test   %ecx,%ecx
801041aa:	75 34                	jne    801041e0 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801041ac:	83 ec 0c             	sub    $0xc,%esp
801041af:	57                   	push   %edi
801041b0:	e8 eb 0a 00 00       	call   80104ca0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801041b5:	58                   	pop    %eax
801041b6:	5a                   	pop    %edx
801041b7:	53                   	push   %ebx
801041b8:	56                   	push   %esi
801041b9:	e8 32 09 00 00       	call   80104af0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041be:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801041c4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801041ca:	83 c4 10             	add    $0x10,%esp
801041cd:	05 00 02 00 00       	add    $0x200,%eax
801041d2:	39 c2                	cmp    %eax,%edx
801041d4:	75 2a                	jne    80104200 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
801041d6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801041dc:	85 c0                	test   %eax,%eax
801041de:	75 c0                	jne    801041a0 <pipewrite+0x50>
        release(&p->lock);
801041e0:	83 ec 0c             	sub    $0xc,%esp
801041e3:	53                   	push   %ebx
801041e4:	e8 97 0f 00 00       	call   80105180 <release>
        return -1;
801041e9:	83 c4 10             	add    $0x10,%esp
801041ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801041f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041f4:	5b                   	pop    %ebx
801041f5:	5e                   	pop    %esi
801041f6:	5f                   	pop    %edi
801041f7:	5d                   	pop    %ebp
801041f8:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801041f9:	89 c2                	mov    %eax,%edx
801041fb:	90                   	nop
801041fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104200:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104203:	8d 42 01             	lea    0x1(%edx),%eax
80104206:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010420a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80104210:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80104216:	0f b6 09             	movzbl (%ecx),%ecx
80104219:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010421d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80104220:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80104223:	0f 85 65 ff ff ff    	jne    8010418e <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80104229:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010422f:	83 ec 0c             	sub    $0xc,%esp
80104232:	50                   	push   %eax
80104233:	e8 68 0a 00 00       	call   80104ca0 <wakeup>
  release(&p->lock);
80104238:	89 1c 24             	mov    %ebx,(%esp)
8010423b:	e8 40 0f 00 00       	call   80105180 <release>
  return n;
80104240:	83 c4 10             	add    $0x10,%esp
80104243:	8b 45 10             	mov    0x10(%ebp),%eax
80104246:	eb a9                	jmp    801041f1 <pipewrite+0xa1>
80104248:	90                   	nop
80104249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104250 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	57                   	push   %edi
80104254:	56                   	push   %esi
80104255:	53                   	push   %ebx
80104256:	83 ec 18             	sub    $0x18,%esp
80104259:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010425c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010425f:	53                   	push   %ebx
80104260:	e8 fb 0d 00 00       	call   80105060 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80104265:	83 c4 10             	add    $0x10,%esp
80104268:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010426e:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
80104274:	75 6a                	jne    801042e0 <piperead+0x90>
80104276:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
8010427c:	85 f6                	test   %esi,%esi
8010427e:	0f 84 cc 00 00 00    	je     80104350 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104284:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
8010428a:	eb 2d                	jmp    801042b9 <piperead+0x69>
8010428c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104290:	83 ec 08             	sub    $0x8,%esp
80104293:	53                   	push   %ebx
80104294:	56                   	push   %esi
80104295:	e8 56 08 00 00       	call   80104af0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010429a:	83 c4 10             	add    $0x10,%esp
8010429d:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801042a3:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
801042a9:	75 35                	jne    801042e0 <piperead+0x90>
801042ab:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
801042b1:	85 d2                	test   %edx,%edx
801042b3:	0f 84 97 00 00 00    	je     80104350 <piperead+0x100>
    if(myproc()->killed){
801042b9:	e8 82 02 00 00       	call   80104540 <myproc>
801042be:	8b 48 24             	mov    0x24(%eax),%ecx
801042c1:	85 c9                	test   %ecx,%ecx
801042c3:	74 cb                	je     80104290 <piperead+0x40>
      release(&p->lock);
801042c5:	83 ec 0c             	sub    $0xc,%esp
801042c8:	53                   	push   %ebx
801042c9:	e8 b2 0e 00 00       	call   80105180 <release>
      return -1;
801042ce:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801042d1:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
801042d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801042d9:	5b                   	pop    %ebx
801042da:	5e                   	pop    %esi
801042db:	5f                   	pop    %edi
801042dc:	5d                   	pop    %ebp
801042dd:	c3                   	ret    
801042de:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801042e0:	8b 45 10             	mov    0x10(%ebp),%eax
801042e3:	85 c0                	test   %eax,%eax
801042e5:	7e 69                	jle    80104350 <piperead+0x100>
    if(p->nread == p->nwrite)
801042e7:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801042ed:	31 c9                	xor    %ecx,%ecx
801042ef:	eb 15                	jmp    80104306 <piperead+0xb6>
801042f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042f8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801042fe:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80104304:	74 5a                	je     80104360 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104306:	8d 70 01             	lea    0x1(%eax),%esi
80104309:	25 ff 01 00 00       	and    $0x1ff,%eax
8010430e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80104314:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80104319:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010431c:	83 c1 01             	add    $0x1,%ecx
8010431f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80104322:	75 d4                	jne    801042f8 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80104324:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010432a:	83 ec 0c             	sub    $0xc,%esp
8010432d:	50                   	push   %eax
8010432e:	e8 6d 09 00 00       	call   80104ca0 <wakeup>
  release(&p->lock);
80104333:	89 1c 24             	mov    %ebx,(%esp)
80104336:	e8 45 0e 00 00       	call   80105180 <release>
  return i;
8010433b:	8b 45 10             	mov    0x10(%ebp),%eax
8010433e:	83 c4 10             	add    $0x10,%esp
}
80104341:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104344:	5b                   	pop    %ebx
80104345:	5e                   	pop    %esi
80104346:	5f                   	pop    %edi
80104347:	5d                   	pop    %ebp
80104348:	c3                   	ret    
80104349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104350:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
80104357:	eb cb                	jmp    80104324 <piperead+0xd4>
80104359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104360:	89 4d 10             	mov    %ecx,0x10(%ebp)
80104363:	eb bf                	jmp    80104324 <piperead+0xd4>
80104365:	66 90                	xchg   %ax,%ax
80104367:	66 90                	xchg   %ax,%ax
80104369:	66 90                	xchg   %ax,%ax
8010436b:	66 90                	xchg   %ax,%ax
8010436d:	66 90                	xchg   %ax,%ax
8010436f:	90                   	nop

80104370 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104370:	55                   	push   %ebp
80104371:	89 e5                	mov    %esp,%ebp
80104373:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104374:	bb f4 50 12 80       	mov    $0x801250f4,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104379:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010437c:	68 c0 50 12 80       	push   $0x801250c0
80104381:	e8 da 0c 00 00       	call   80105060 <acquire>
80104386:	83 c4 10             	add    $0x10,%esp
80104389:	eb 10                	jmp    8010439b <allocproc+0x2b>
8010438b:	90                   	nop
8010438c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104390:	83 c3 7c             	add    $0x7c,%ebx
80104393:	81 fb f4 6f 12 80    	cmp    $0x80126ff4,%ebx
80104399:	74 75                	je     80104410 <allocproc+0xa0>
    if(p->state == UNUSED)
8010439b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010439e:	85 c0                	test   %eax,%eax
801043a0:	75 ee                	jne    80104390 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801043a2:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
801043a7:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801043aa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
801043b1:	68 c0 50 12 80       	push   $0x801250c0
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801043b6:	8d 50 01             	lea    0x1(%eax),%edx
801043b9:	89 43 10             	mov    %eax,0x10(%ebx)
801043bc:	89 15 04 b0 10 80    	mov    %edx,0x8010b004

  release(&ptable.lock);
801043c2:	e8 b9 0d 00 00       	call   80105180 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801043c7:	e8 84 ee ff ff       	call   80103250 <kalloc>
801043cc:	83 c4 10             	add    $0x10,%esp
801043cf:	85 c0                	test   %eax,%eax
801043d1:	89 43 08             	mov    %eax,0x8(%ebx)
801043d4:	74 51                	je     80104427 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801043d6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801043dc:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
801043df:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801043e4:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
801043e7:	c7 40 14 e2 64 10 80 	movl   $0x801064e2,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801043ee:	6a 14                	push   $0x14
801043f0:	6a 00                	push   $0x0
801043f2:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
801043f3:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801043f6:	e8 d5 0d 00 00       	call   801051d0 <memset>
  p->context->eip = (uint)forkret;
801043fb:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801043fe:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80104401:	c7 40 10 30 44 10 80 	movl   $0x80104430,0x10(%eax)

  return p;
80104408:	89 d8                	mov    %ebx,%eax
}
8010440a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010440d:	c9                   	leave  
8010440e:	c3                   	ret    
8010440f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80104410:	83 ec 0c             	sub    $0xc,%esp
80104413:	68 c0 50 12 80       	push   $0x801250c0
80104418:	e8 63 0d 00 00       	call   80105180 <release>
  return 0;
8010441d:	83 c4 10             	add    $0x10,%esp
80104420:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80104422:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104425:	c9                   	leave  
80104426:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80104427:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010442e:	eb da                	jmp    8010440a <allocproc+0x9a>

80104430 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104436:	68 c0 50 12 80       	push   $0x801250c0
8010443b:	e8 40 0d 00 00       	call   80105180 <release>

  if (first) {
80104440:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80104445:	83 c4 10             	add    $0x10,%esp
80104448:	85 c0                	test   %eax,%eax
8010444a:	75 04                	jne    80104450 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010444c:	c9                   	leave  
8010444d:	c3                   	ret    
8010444e:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80104450:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80104453:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
8010445a:	00 00 00 
    iinit(ROOTDEV);
8010445d:	6a 01                	push   $0x1
8010445f:	e8 cc dd ff ff       	call   80102230 <iinit>
    initlog(ROOTDEV);
80104464:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010446b:	e8 00 f4 ff ff       	call   80103870 <initlog>
80104470:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80104473:	c9                   	leave  
80104474:	c3                   	ret    
80104475:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104480 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80104486:	68 55 86 10 80       	push   $0x80108655
8010448b:	68 c0 50 12 80       	push   $0x801250c0
80104490:	e8 cb 0a 00 00       	call   80104f60 <initlock>
}
80104495:	83 c4 10             	add    $0x10,%esp
80104498:	c9                   	leave  
80104499:	c3                   	ret    
8010449a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044a0 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	56                   	push   %esi
801044a4:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801044a5:	9c                   	pushf  
801044a6:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
801044a7:	f6 c4 02             	test   $0x2,%ah
801044aa:	75 5b                	jne    80104507 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
801044ac:	e8 ff ef ff ff       	call   801034b0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801044b1:	8b 35 a0 50 12 80    	mov    0x801250a0,%esi
801044b7:	85 f6                	test   %esi,%esi
801044b9:	7e 3f                	jle    801044fa <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801044bb:	0f b6 15 20 4b 12 80 	movzbl 0x80124b20,%edx
801044c2:	39 d0                	cmp    %edx,%eax
801044c4:	74 30                	je     801044f6 <mycpu+0x56>
801044c6:	b9 d0 4b 12 80       	mov    $0x80124bd0,%ecx
801044cb:	31 d2                	xor    %edx,%edx
801044cd:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801044d0:	83 c2 01             	add    $0x1,%edx
801044d3:	39 f2                	cmp    %esi,%edx
801044d5:	74 23                	je     801044fa <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801044d7:	0f b6 19             	movzbl (%ecx),%ebx
801044da:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801044e0:	39 d8                	cmp    %ebx,%eax
801044e2:	75 ec                	jne    801044d0 <mycpu+0x30>
      return &cpus[i];
801044e4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
801044ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044ed:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
801044ee:	05 20 4b 12 80       	add    $0x80124b20,%eax
  }
  panic("unknown apicid\n");
}
801044f3:	5e                   	pop    %esi
801044f4:	5d                   	pop    %ebp
801044f5:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
801044f6:	31 d2                	xor    %edx,%edx
801044f8:	eb ea                	jmp    801044e4 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
801044fa:	83 ec 0c             	sub    $0xc,%esp
801044fd:	68 5c 86 10 80       	push   $0x8010865c
80104502:	e8 b9 c2 ff ff       	call   801007c0 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80104507:	83 ec 0c             	sub    $0xc,%esp
8010450a:	68 38 87 10 80       	push   $0x80108738
8010450f:	e8 ac c2 ff ff       	call   801007c0 <panic>
80104514:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010451a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104520 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104526:	e8 75 ff ff ff       	call   801044a0 <mycpu>
8010452b:	2d 20 4b 12 80       	sub    $0x80124b20,%eax
}
80104530:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
80104531:	c1 f8 04             	sar    $0x4,%eax
80104534:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010453a:	c3                   	ret    
8010453b:	90                   	nop
8010453c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104540 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	53                   	push   %ebx
80104544:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80104547:	e8 d4 0a 00 00       	call   80105020 <pushcli>
  c = mycpu();
8010454c:	e8 4f ff ff ff       	call   801044a0 <mycpu>
  p = c->proc;
80104551:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104557:	e8 b4 0b 00 00       	call   80105110 <popcli>
  return p;
}
8010455c:	83 c4 04             	add    $0x4,%esp
8010455f:	89 d8                	mov    %ebx,%eax
80104561:	5b                   	pop    %ebx
80104562:	5d                   	pop    %ebp
80104563:	c3                   	ret    
80104564:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010456a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104570 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	53                   	push   %ebx
80104574:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80104577:	e8 f4 fd ff ff       	call   80104370 <allocproc>
8010457c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
8010457e:	a3 f8 b5 10 80       	mov    %eax,0x8010b5f8
  if((p->pgdir = setupkvm()) == 0)
80104583:	e8 48 35 00 00       	call   80107ad0 <setupkvm>
80104588:	85 c0                	test   %eax,%eax
8010458a:	89 43 04             	mov    %eax,0x4(%ebx)
8010458d:	0f 84 bd 00 00 00    	je     80104650 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80104593:	83 ec 04             	sub    $0x4,%esp
80104596:	68 2c 00 00 00       	push   $0x2c
8010459b:	68 60 b4 10 80       	push   $0x8010b460
801045a0:	50                   	push   %eax
801045a1:	e8 3a 32 00 00       	call   801077e0 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
801045a6:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
801045a9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801045af:	6a 4c                	push   $0x4c
801045b1:	6a 00                	push   $0x0
801045b3:	ff 73 18             	pushl  0x18(%ebx)
801045b6:	e8 15 0c 00 00       	call   801051d0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801045bb:	8b 43 18             	mov    0x18(%ebx),%eax
801045be:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801045c3:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
801045c8:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801045cb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801045cf:	8b 43 18             	mov    0x18(%ebx),%eax
801045d2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801045d6:	8b 43 18             	mov    0x18(%ebx),%eax
801045d9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801045dd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801045e1:	8b 43 18             	mov    0x18(%ebx),%eax
801045e4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801045e8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801045ec:	8b 43 18             	mov    0x18(%ebx),%eax
801045ef:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801045f6:	8b 43 18             	mov    0x18(%ebx),%eax
801045f9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104600:	8b 43 18             	mov    0x18(%ebx),%eax
80104603:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010460a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010460d:	6a 10                	push   $0x10
8010460f:	68 85 86 10 80       	push   $0x80108685
80104614:	50                   	push   %eax
80104615:	e8 b6 0d 00 00       	call   801053d0 <safestrcpy>
  p->cwd = namei("/");
8010461a:	c7 04 24 8e 86 10 80 	movl   $0x8010868e,(%esp)
80104621:	e8 5a e6 ff ff       	call   80102c80 <namei>
80104626:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80104629:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
80104630:	e8 2b 0a 00 00       	call   80105060 <acquire>

  p->state = RUNNABLE;
80104635:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
8010463c:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
80104643:	e8 38 0b 00 00       	call   80105180 <release>
}
80104648:	83 c4 10             	add    $0x10,%esp
8010464b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010464e:	c9                   	leave  
8010464f:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80104650:	83 ec 0c             	sub    $0xc,%esp
80104653:	68 6c 86 10 80       	push   $0x8010866c
80104658:	e8 63 c1 ff ff       	call   801007c0 <panic>
8010465d:	8d 76 00             	lea    0x0(%esi),%esi

80104660 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	56                   	push   %esi
80104664:	53                   	push   %ebx
80104665:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104668:	e8 b3 09 00 00       	call   80105020 <pushcli>
  c = mycpu();
8010466d:	e8 2e fe ff ff       	call   801044a0 <mycpu>
  p = c->proc;
80104672:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104678:	e8 93 0a 00 00       	call   80105110 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
8010467d:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
80104680:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80104682:	7e 34                	jle    801046b8 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104684:	83 ec 04             	sub    $0x4,%esp
80104687:	01 c6                	add    %eax,%esi
80104689:	56                   	push   %esi
8010468a:	50                   	push   %eax
8010468b:	ff 73 04             	pushl  0x4(%ebx)
8010468e:	e8 8d 32 00 00       	call   80107920 <allocuvm>
80104693:	83 c4 10             	add    $0x10,%esp
80104696:	85 c0                	test   %eax,%eax
80104698:	74 36                	je     801046d0 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
8010469a:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
8010469d:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010469f:	53                   	push   %ebx
801046a0:	e8 2b 30 00 00       	call   801076d0 <switchuvm>
  return 0;
801046a5:	83 c4 10             	add    $0x10,%esp
801046a8:	31 c0                	xor    %eax,%eax
}
801046aa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046ad:	5b                   	pop    %ebx
801046ae:	5e                   	pop    %esi
801046af:	5d                   	pop    %ebp
801046b0:	c3                   	ret    
801046b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
801046b8:	74 e0                	je     8010469a <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
801046ba:	83 ec 04             	sub    $0x4,%esp
801046bd:	01 c6                	add    %eax,%esi
801046bf:	56                   	push   %esi
801046c0:	50                   	push   %eax
801046c1:	ff 73 04             	pushl  0x4(%ebx)
801046c4:	e8 57 33 00 00       	call   80107a20 <deallocuvm>
801046c9:	83 c4 10             	add    $0x10,%esp
801046cc:	85 c0                	test   %eax,%eax
801046ce:	75 ca                	jne    8010469a <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
801046d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046d5:	eb d3                	jmp    801046aa <growproc+0x4a>
801046d7:	89 f6                	mov    %esi,%esi
801046d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046e0 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	57                   	push   %edi
801046e4:	56                   	push   %esi
801046e5:	53                   	push   %ebx
801046e6:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801046e9:	e8 32 09 00 00       	call   80105020 <pushcli>
  c = mycpu();
801046ee:	e8 ad fd ff ff       	call   801044a0 <mycpu>
  p = c->proc;
801046f3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801046f9:	e8 12 0a 00 00       	call   80105110 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
801046fe:	e8 6d fc ff ff       	call   80104370 <allocproc>
80104703:	85 c0                	test   %eax,%eax
80104705:	89 c7                	mov    %eax,%edi
80104707:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010470a:	0f 84 b5 00 00 00    	je     801047c5 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80104710:	83 ec 08             	sub    $0x8,%esp
80104713:	ff 33                	pushl  (%ebx)
80104715:	ff 73 04             	pushl  0x4(%ebx)
80104718:	e8 83 34 00 00       	call   80107ba0 <copyuvm>
8010471d:	83 c4 10             	add    $0x10,%esp
80104720:	85 c0                	test   %eax,%eax
80104722:	89 47 04             	mov    %eax,0x4(%edi)
80104725:	0f 84 a1 00 00 00    	je     801047cc <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
8010472b:	8b 03                	mov    (%ebx),%eax
8010472d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104730:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80104732:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80104735:	89 c8                	mov    %ecx,%eax
80104737:	8b 79 18             	mov    0x18(%ecx),%edi
8010473a:	8b 73 18             	mov    0x18(%ebx),%esi
8010473d:	b9 13 00 00 00       	mov    $0x13,%ecx
80104742:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80104744:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104746:	8b 40 18             	mov    0x18(%eax),%eax
80104749:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80104750:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104754:	85 c0                	test   %eax,%eax
80104756:	74 13                	je     8010476b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104758:	83 ec 0c             	sub    $0xc,%esp
8010475b:	50                   	push   %eax
8010475c:	e8 3f d4 ff ff       	call   80101ba0 <filedup>
80104761:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104764:	83 c4 10             	add    $0x10,%esp
80104767:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
8010476b:	83 c6 01             	add    $0x1,%esi
8010476e:	83 fe 10             	cmp    $0x10,%esi
80104771:	75 dd                	jne    80104750 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80104773:	83 ec 0c             	sub    $0xc,%esp
80104776:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104779:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
8010477c:	e8 7f dc ff ff       	call   80102400 <idup>
80104781:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104784:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80104787:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010478a:	8d 47 6c             	lea    0x6c(%edi),%eax
8010478d:	6a 10                	push   $0x10
8010478f:	53                   	push   %ebx
80104790:	50                   	push   %eax
80104791:	e8 3a 0c 00 00       	call   801053d0 <safestrcpy>

  pid = np->pid;
80104796:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
80104799:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
801047a0:	e8 bb 08 00 00       	call   80105060 <acquire>

  np->state = RUNNABLE;
801047a5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
801047ac:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
801047b3:	e8 c8 09 00 00       	call   80105180 <release>

  return pid;
801047b8:	83 c4 10             	add    $0x10,%esp
801047bb:	89 d8                	mov    %ebx,%eax
}
801047bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801047c0:	5b                   	pop    %ebx
801047c1:	5e                   	pop    %esi
801047c2:	5f                   	pop    %edi
801047c3:	5d                   	pop    %ebp
801047c4:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
801047c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047ca:	eb f1                	jmp    801047bd <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
801047cc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801047cf:	83 ec 0c             	sub    $0xc,%esp
801047d2:	ff 77 08             	pushl  0x8(%edi)
801047d5:	e8 c6 e8 ff ff       	call   801030a0 <kfree>
    np->kstack = 0;
801047da:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
801047e1:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
801047e8:	83 c4 10             	add    $0x10,%esp
801047eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801047f0:	eb cb                	jmp    801047bd <fork+0xdd>
801047f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104800 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	57                   	push   %edi
80104804:	56                   	push   %esi
80104805:	53                   	push   %ebx
80104806:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80104809:	e8 92 fc ff ff       	call   801044a0 <mycpu>
8010480e:	8d 78 04             	lea    0x4(%eax),%edi
80104811:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80104813:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010481a:	00 00 00 
8010481d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80104820:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104821:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104824:	bb f4 50 12 80       	mov    $0x801250f4,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104829:	68 c0 50 12 80       	push   $0x801250c0
8010482e:	e8 2d 08 00 00       	call   80105060 <acquire>
80104833:	83 c4 10             	add    $0x10,%esp
80104836:	eb 13                	jmp    8010484b <scheduler+0x4b>
80104838:	90                   	nop
80104839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104840:	83 c3 7c             	add    $0x7c,%ebx
80104843:	81 fb f4 6f 12 80    	cmp    $0x80126ff4,%ebx
80104849:	74 45                	je     80104890 <scheduler+0x90>
      if(p->state != RUNNABLE)
8010484b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
8010484f:	75 ef                	jne    80104840 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
80104851:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80104854:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010485a:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010485b:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
8010485e:	e8 6d 2e 00 00       	call   801076d0 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80104863:	58                   	pop    %eax
80104864:	5a                   	pop    %edx
80104865:	ff 73 a0             	pushl  -0x60(%ebx)
80104868:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80104869:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
80104870:	e8 b6 0b 00 00       	call   8010542b <swtch>
      switchkvm();
80104875:	e8 36 2e 00 00       	call   801076b0 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
8010487a:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010487d:	81 fb f4 6f 12 80    	cmp    $0x80126ff4,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80104883:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
8010488a:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010488d:	75 bc                	jne    8010484b <scheduler+0x4b>
8010488f:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80104890:	83 ec 0c             	sub    $0xc,%esp
80104893:	68 c0 50 12 80       	push   $0x801250c0
80104898:	e8 e3 08 00 00       	call   80105180 <release>

  }
8010489d:	83 c4 10             	add    $0x10,%esp
801048a0:	e9 7b ff ff ff       	jmp    80104820 <scheduler+0x20>
801048a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048b0 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	56                   	push   %esi
801048b4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801048b5:	e8 66 07 00 00       	call   80105020 <pushcli>
  c = mycpu();
801048ba:	e8 e1 fb ff ff       	call   801044a0 <mycpu>
  p = c->proc;
801048bf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801048c5:	e8 46 08 00 00       	call   80105110 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
801048ca:	83 ec 0c             	sub    $0xc,%esp
801048cd:	68 c0 50 12 80       	push   $0x801250c0
801048d2:	e8 09 07 00 00       	call   80104fe0 <holding>
801048d7:	83 c4 10             	add    $0x10,%esp
801048da:	85 c0                	test   %eax,%eax
801048dc:	74 4f                	je     8010492d <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
801048de:	e8 bd fb ff ff       	call   801044a0 <mycpu>
801048e3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801048ea:	75 68                	jne    80104954 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
801048ec:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801048f0:	74 55                	je     80104947 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801048f2:	9c                   	pushf  
801048f3:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
801048f4:	f6 c4 02             	test   $0x2,%ah
801048f7:	75 41                	jne    8010493a <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
801048f9:	e8 a2 fb ff ff       	call   801044a0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801048fe:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80104901:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104907:	e8 94 fb ff ff       	call   801044a0 <mycpu>
8010490c:	83 ec 08             	sub    $0x8,%esp
8010490f:	ff 70 04             	pushl  0x4(%eax)
80104912:	53                   	push   %ebx
80104913:	e8 13 0b 00 00       	call   8010542b <swtch>
  mycpu()->intena = intena;
80104918:	e8 83 fb ff ff       	call   801044a0 <mycpu>
}
8010491d:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80104920:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104926:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104929:	5b                   	pop    %ebx
8010492a:	5e                   	pop    %esi
8010492b:	5d                   	pop    %ebp
8010492c:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
8010492d:	83 ec 0c             	sub    $0xc,%esp
80104930:	68 90 86 10 80       	push   $0x80108690
80104935:	e8 86 be ff ff       	call   801007c0 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
8010493a:	83 ec 0c             	sub    $0xc,%esp
8010493d:	68 bc 86 10 80       	push   $0x801086bc
80104942:	e8 79 be ff ff       	call   801007c0 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80104947:	83 ec 0c             	sub    $0xc,%esp
8010494a:	68 ae 86 10 80       	push   $0x801086ae
8010494f:	e8 6c be ff ff       	call   801007c0 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80104954:	83 ec 0c             	sub    $0xc,%esp
80104957:	68 a2 86 10 80       	push   $0x801086a2
8010495c:	e8 5f be ff ff       	call   801007c0 <panic>
80104961:	eb 0d                	jmp    80104970 <exit>
80104963:	90                   	nop
80104964:	90                   	nop
80104965:	90                   	nop
80104966:	90                   	nop
80104967:	90                   	nop
80104968:	90                   	nop
80104969:	90                   	nop
8010496a:	90                   	nop
8010496b:	90                   	nop
8010496c:	90                   	nop
8010496d:	90                   	nop
8010496e:	90                   	nop
8010496f:	90                   	nop

80104970 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	57                   	push   %edi
80104974:	56                   	push   %esi
80104975:	53                   	push   %ebx
80104976:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104979:	e8 a2 06 00 00       	call   80105020 <pushcli>
  c = mycpu();
8010497e:	e8 1d fb ff ff       	call   801044a0 <mycpu>
  p = c->proc;
80104983:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104989:	e8 82 07 00 00       	call   80105110 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
8010498e:	39 35 f8 b5 10 80    	cmp    %esi,0x8010b5f8
80104994:	8d 5e 28             	lea    0x28(%esi),%ebx
80104997:	8d 7e 68             	lea    0x68(%esi),%edi
8010499a:	0f 84 e7 00 00 00    	je     80104a87 <exit+0x117>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
801049a0:	8b 03                	mov    (%ebx),%eax
801049a2:	85 c0                	test   %eax,%eax
801049a4:	74 12                	je     801049b8 <exit+0x48>
      fileclose(curproc->ofile[fd]);
801049a6:	83 ec 0c             	sub    $0xc,%esp
801049a9:	50                   	push   %eax
801049aa:	e8 41 d2 ff ff       	call   80101bf0 <fileclose>
      curproc->ofile[fd] = 0;
801049af:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801049b5:	83 c4 10             	add    $0x10,%esp
801049b8:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801049bb:	39 df                	cmp    %ebx,%edi
801049bd:	75 e1                	jne    801049a0 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
801049bf:	e8 4c ef ff ff       	call   80103910 <begin_op>
  iput(curproc->cwd);
801049c4:	83 ec 0c             	sub    $0xc,%esp
801049c7:	ff 76 68             	pushl  0x68(%esi)
801049ca:	e8 91 db ff ff       	call   80102560 <iput>
  end_op();
801049cf:	e8 ac ef ff ff       	call   80103980 <end_op>
  curproc->cwd = 0;
801049d4:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
801049db:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
801049e2:	e8 79 06 00 00       	call   80105060 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
801049e7:	8b 56 14             	mov    0x14(%esi),%edx
801049ea:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049ed:	b8 f4 50 12 80       	mov    $0x801250f4,%eax
801049f2:	eb 0e                	jmp    80104a02 <exit+0x92>
801049f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049f8:	83 c0 7c             	add    $0x7c,%eax
801049fb:	3d f4 6f 12 80       	cmp    $0x80126ff4,%eax
80104a00:	74 1c                	je     80104a1e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80104a02:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104a06:	75 f0                	jne    801049f8 <exit+0x88>
80104a08:	3b 50 20             	cmp    0x20(%eax),%edx
80104a0b:	75 eb                	jne    801049f8 <exit+0x88>
      p->state = RUNNABLE;
80104a0d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a14:	83 c0 7c             	add    $0x7c,%eax
80104a17:	3d f4 6f 12 80       	cmp    $0x80126ff4,%eax
80104a1c:	75 e4                	jne    80104a02 <exit+0x92>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80104a1e:	8b 0d f8 b5 10 80    	mov    0x8010b5f8,%ecx
80104a24:	ba f4 50 12 80       	mov    $0x801250f4,%edx
80104a29:	eb 10                	jmp    80104a3b <exit+0xcb>
80104a2b:	90                   	nop
80104a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a30:	83 c2 7c             	add    $0x7c,%edx
80104a33:	81 fa f4 6f 12 80    	cmp    $0x80126ff4,%edx
80104a39:	74 33                	je     80104a6e <exit+0xfe>
    if(p->parent == curproc){
80104a3b:	39 72 14             	cmp    %esi,0x14(%edx)
80104a3e:	75 f0                	jne    80104a30 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80104a40:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80104a44:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104a47:	75 e7                	jne    80104a30 <exit+0xc0>
80104a49:	b8 f4 50 12 80       	mov    $0x801250f4,%eax
80104a4e:	eb 0a                	jmp    80104a5a <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a50:	83 c0 7c             	add    $0x7c,%eax
80104a53:	3d f4 6f 12 80       	cmp    $0x80126ff4,%eax
80104a58:	74 d6                	je     80104a30 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80104a5a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104a5e:	75 f0                	jne    80104a50 <exit+0xe0>
80104a60:	3b 48 20             	cmp    0x20(%eax),%ecx
80104a63:	75 eb                	jne    80104a50 <exit+0xe0>
      p->state = RUNNABLE;
80104a65:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104a6c:	eb e2                	jmp    80104a50 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80104a6e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80104a75:	e8 36 fe ff ff       	call   801048b0 <sched>
  panic("zombie exit");
80104a7a:	83 ec 0c             	sub    $0xc,%esp
80104a7d:	68 dd 86 10 80       	push   $0x801086dd
80104a82:	e8 39 bd ff ff       	call   801007c0 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80104a87:	83 ec 0c             	sub    $0xc,%esp
80104a8a:	68 d0 86 10 80       	push   $0x801086d0
80104a8f:	e8 2c bd ff ff       	call   801007c0 <panic>
80104a94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104aa0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	53                   	push   %ebx
80104aa4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104aa7:	68 c0 50 12 80       	push   $0x801250c0
80104aac:	e8 af 05 00 00       	call   80105060 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104ab1:	e8 6a 05 00 00       	call   80105020 <pushcli>
  c = mycpu();
80104ab6:	e8 e5 f9 ff ff       	call   801044a0 <mycpu>
  p = c->proc;
80104abb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104ac1:	e8 4a 06 00 00       	call   80105110 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80104ac6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104acd:	e8 de fd ff ff       	call   801048b0 <sched>
  release(&ptable.lock);
80104ad2:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
80104ad9:	e8 a2 06 00 00       	call   80105180 <release>
}
80104ade:	83 c4 10             	add    $0x10,%esp
80104ae1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ae4:	c9                   	leave  
80104ae5:	c3                   	ret    
80104ae6:	8d 76 00             	lea    0x0(%esi),%esi
80104ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104af0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104af0:	55                   	push   %ebp
80104af1:	89 e5                	mov    %esp,%ebp
80104af3:	57                   	push   %edi
80104af4:	56                   	push   %esi
80104af5:	53                   	push   %ebx
80104af6:	83 ec 0c             	sub    $0xc,%esp
80104af9:	8b 7d 08             	mov    0x8(%ebp),%edi
80104afc:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104aff:	e8 1c 05 00 00       	call   80105020 <pushcli>
  c = mycpu();
80104b04:	e8 97 f9 ff ff       	call   801044a0 <mycpu>
  p = c->proc;
80104b09:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104b0f:	e8 fc 05 00 00       	call   80105110 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80104b14:	85 db                	test   %ebx,%ebx
80104b16:	0f 84 87 00 00 00    	je     80104ba3 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80104b1c:	85 f6                	test   %esi,%esi
80104b1e:	74 76                	je     80104b96 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104b20:	81 fe c0 50 12 80    	cmp    $0x801250c0,%esi
80104b26:	74 50                	je     80104b78 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104b28:	83 ec 0c             	sub    $0xc,%esp
80104b2b:	68 c0 50 12 80       	push   $0x801250c0
80104b30:	e8 2b 05 00 00       	call   80105060 <acquire>
    release(lk);
80104b35:	89 34 24             	mov    %esi,(%esp)
80104b38:	e8 43 06 00 00       	call   80105180 <release>
  }
  // Go to sleep.
  p->chan = chan;
80104b3d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104b40:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104b47:	e8 64 fd ff ff       	call   801048b0 <sched>

  // Tidy up.
  p->chan = 0;
80104b4c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80104b53:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
80104b5a:	e8 21 06 00 00       	call   80105180 <release>
    acquire(lk);
80104b5f:	89 75 08             	mov    %esi,0x8(%ebp)
80104b62:	83 c4 10             	add    $0x10,%esp
  }
}
80104b65:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b68:	5b                   	pop    %ebx
80104b69:	5e                   	pop    %esi
80104b6a:	5f                   	pop    %edi
80104b6b:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80104b6c:	e9 ef 04 00 00       	jmp    80105060 <acquire>
80104b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80104b78:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104b7b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104b82:	e8 29 fd ff ff       	call   801048b0 <sched>

  // Tidy up.
  p->chan = 0;
80104b87:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80104b8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b91:	5b                   	pop    %ebx
80104b92:	5e                   	pop    %esi
80104b93:	5f                   	pop    %edi
80104b94:	5d                   	pop    %ebp
80104b95:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80104b96:	83 ec 0c             	sub    $0xc,%esp
80104b99:	68 ef 86 10 80       	push   $0x801086ef
80104b9e:	e8 1d bc ff ff       	call   801007c0 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80104ba3:	83 ec 0c             	sub    $0xc,%esp
80104ba6:	68 e9 86 10 80       	push   $0x801086e9
80104bab:	e8 10 bc ff ff       	call   801007c0 <panic>

80104bb0 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	56                   	push   %esi
80104bb4:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104bb5:	e8 66 04 00 00       	call   80105020 <pushcli>
  c = mycpu();
80104bba:	e8 e1 f8 ff ff       	call   801044a0 <mycpu>
  p = c->proc;
80104bbf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104bc5:	e8 46 05 00 00       	call   80105110 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
80104bca:	83 ec 0c             	sub    $0xc,%esp
80104bcd:	68 c0 50 12 80       	push   $0x801250c0
80104bd2:	e8 89 04 00 00       	call   80105060 <acquire>
80104bd7:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80104bda:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bdc:	bb f4 50 12 80       	mov    $0x801250f4,%ebx
80104be1:	eb 10                	jmp    80104bf3 <wait+0x43>
80104be3:	90                   	nop
80104be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104be8:	83 c3 7c             	add    $0x7c,%ebx
80104beb:	81 fb f4 6f 12 80    	cmp    $0x80126ff4,%ebx
80104bf1:	74 1d                	je     80104c10 <wait+0x60>
      if(p->parent != curproc)
80104bf3:	39 73 14             	cmp    %esi,0x14(%ebx)
80104bf6:	75 f0                	jne    80104be8 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80104bf8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104bfc:	74 30                	je     80104c2e <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bfe:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80104c01:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c06:	81 fb f4 6f 12 80    	cmp    $0x80126ff4,%ebx
80104c0c:	75 e5                	jne    80104bf3 <wait+0x43>
80104c0e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104c10:	85 c0                	test   %eax,%eax
80104c12:	74 70                	je     80104c84 <wait+0xd4>
80104c14:	8b 46 24             	mov    0x24(%esi),%eax
80104c17:	85 c0                	test   %eax,%eax
80104c19:	75 69                	jne    80104c84 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104c1b:	83 ec 08             	sub    $0x8,%esp
80104c1e:	68 c0 50 12 80       	push   $0x801250c0
80104c23:	56                   	push   %esi
80104c24:	e8 c7 fe ff ff       	call   80104af0 <sleep>
  }
80104c29:	83 c4 10             	add    $0x10,%esp
80104c2c:	eb ac                	jmp    80104bda <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80104c2e:	83 ec 0c             	sub    $0xc,%esp
80104c31:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80104c34:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104c37:	e8 64 e4 ff ff       	call   801030a0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80104c3c:	5a                   	pop    %edx
80104c3d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80104c40:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104c47:	e8 04 2e 00 00       	call   80107a50 <freevm>
        p->pid = 0;
80104c4c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104c53:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104c5a:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104c5e:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104c65:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104c6c:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
80104c73:	e8 08 05 00 00       	call   80105180 <release>
        return pid;
80104c78:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104c7b:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80104c7e:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104c80:	5b                   	pop    %ebx
80104c81:	5e                   	pop    %esi
80104c82:	5d                   	pop    %ebp
80104c83:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80104c84:	83 ec 0c             	sub    $0xc,%esp
80104c87:	68 c0 50 12 80       	push   $0x801250c0
80104c8c:	e8 ef 04 00 00       	call   80105180 <release>
      return -1;
80104c91:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104c94:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80104c97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104c9c:	5b                   	pop    %ebx
80104c9d:	5e                   	pop    %esi
80104c9e:	5d                   	pop    %ebp
80104c9f:	c3                   	ret    

80104ca0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	53                   	push   %ebx
80104ca4:	83 ec 10             	sub    $0x10,%esp
80104ca7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104caa:	68 c0 50 12 80       	push   $0x801250c0
80104caf:	e8 ac 03 00 00       	call   80105060 <acquire>
80104cb4:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104cb7:	b8 f4 50 12 80       	mov    $0x801250f4,%eax
80104cbc:	eb 0c                	jmp    80104cca <wakeup+0x2a>
80104cbe:	66 90                	xchg   %ax,%ax
80104cc0:	83 c0 7c             	add    $0x7c,%eax
80104cc3:	3d f4 6f 12 80       	cmp    $0x80126ff4,%eax
80104cc8:	74 1c                	je     80104ce6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80104cca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104cce:	75 f0                	jne    80104cc0 <wakeup+0x20>
80104cd0:	3b 58 20             	cmp    0x20(%eax),%ebx
80104cd3:	75 eb                	jne    80104cc0 <wakeup+0x20>
      p->state = RUNNABLE;
80104cd5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104cdc:	83 c0 7c             	add    $0x7c,%eax
80104cdf:	3d f4 6f 12 80       	cmp    $0x80126ff4,%eax
80104ce4:	75 e4                	jne    80104cca <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104ce6:	c7 45 08 c0 50 12 80 	movl   $0x801250c0,0x8(%ebp)
}
80104ced:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cf0:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104cf1:	e9 8a 04 00 00       	jmp    80105180 <release>
80104cf6:	8d 76 00             	lea    0x0(%esi),%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d00 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	53                   	push   %ebx
80104d04:	83 ec 10             	sub    $0x10,%esp
80104d07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104d0a:	68 c0 50 12 80       	push   $0x801250c0
80104d0f:	e8 4c 03 00 00       	call   80105060 <acquire>
80104d14:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d17:	b8 f4 50 12 80       	mov    $0x801250f4,%eax
80104d1c:	eb 0c                	jmp    80104d2a <kill+0x2a>
80104d1e:	66 90                	xchg   %ax,%ax
80104d20:	83 c0 7c             	add    $0x7c,%eax
80104d23:	3d f4 6f 12 80       	cmp    $0x80126ff4,%eax
80104d28:	74 3e                	je     80104d68 <kill+0x68>
    if(p->pid == pid){
80104d2a:	39 58 10             	cmp    %ebx,0x10(%eax)
80104d2d:	75 f1                	jne    80104d20 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104d2f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104d33:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104d3a:	74 1c                	je     80104d58 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
80104d3c:	83 ec 0c             	sub    $0xc,%esp
80104d3f:	68 c0 50 12 80       	push   $0x801250c0
80104d44:	e8 37 04 00 00       	call   80105180 <release>
      return 0;
80104d49:	83 c4 10             	add    $0x10,%esp
80104d4c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104d4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d51:	c9                   	leave  
80104d52:	c3                   	ret    
80104d53:	90                   	nop
80104d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104d58:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104d5f:	eb db                	jmp    80104d3c <kill+0x3c>
80104d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104d68:	83 ec 0c             	sub    $0xc,%esp
80104d6b:	68 c0 50 12 80       	push   $0x801250c0
80104d70:	e8 0b 04 00 00       	call   80105180 <release>
  return -1;
80104d75:	83 c4 10             	add    $0x10,%esp
80104d78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d7d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d80:	c9                   	leave  
80104d81:	c3                   	ret    
80104d82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d90 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	57                   	push   %edi
80104d94:	56                   	push   %esi
80104d95:	53                   	push   %ebx
80104d96:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104d99:	bb 60 51 12 80       	mov    $0x80125160,%ebx
80104d9e:	83 ec 3c             	sub    $0x3c,%esp
80104da1:	eb 24                	jmp    80104dc7 <procdump+0x37>
80104da3:	90                   	nop
80104da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104da8:	83 ec 0c             	sub    $0xc,%esp
80104dab:	68 7b 8a 10 80       	push   $0x80108a7b
80104db0:	e8 7b b8 ff ff       	call   80100630 <cprintf>
80104db5:	83 c4 10             	add    $0x10,%esp
80104db8:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104dbb:	81 fb 60 70 12 80    	cmp    $0x80127060,%ebx
80104dc1:	0f 84 81 00 00 00    	je     80104e48 <procdump+0xb8>
    if(p->state == UNUSED)
80104dc7:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104dca:	85 c0                	test   %eax,%eax
80104dcc:	74 ea                	je     80104db8 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104dce:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104dd1:	ba 00 87 10 80       	mov    $0x80108700,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104dd6:	77 11                	ja     80104de9 <procdump+0x59>
80104dd8:	8b 14 85 60 87 10 80 	mov    -0x7fef78a0(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
80104ddf:	b8 00 87 10 80       	mov    $0x80108700,%eax
80104de4:	85 d2                	test   %edx,%edx
80104de6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104de9:	53                   	push   %ebx
80104dea:	52                   	push   %edx
80104deb:	ff 73 a4             	pushl  -0x5c(%ebx)
80104dee:	68 04 87 10 80       	push   $0x80108704
80104df3:	e8 38 b8 ff ff       	call   80100630 <cprintf>
    if(p->state == SLEEPING){
80104df8:	83 c4 10             	add    $0x10,%esp
80104dfb:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104dff:	75 a7                	jne    80104da8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104e01:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104e04:	83 ec 08             	sub    $0x8,%esp
80104e07:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104e0a:	50                   	push   %eax
80104e0b:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104e0e:	8b 40 0c             	mov    0xc(%eax),%eax
80104e11:	83 c0 08             	add    $0x8,%eax
80104e14:	50                   	push   %eax
80104e15:	e8 66 01 00 00       	call   80104f80 <getcallerpcs>
80104e1a:	83 c4 10             	add    $0x10,%esp
80104e1d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104e20:	8b 17                	mov    (%edi),%edx
80104e22:	85 d2                	test   %edx,%edx
80104e24:	74 82                	je     80104da8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104e26:	83 ec 08             	sub    $0x8,%esp
80104e29:	83 c7 04             	add    $0x4,%edi
80104e2c:	52                   	push   %edx
80104e2d:	68 bd 7d 10 80       	push   $0x80107dbd
80104e32:	e8 f9 b7 ff ff       	call   80100630 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104e37:	83 c4 10             	add    $0x10,%esp
80104e3a:	39 f7                	cmp    %esi,%edi
80104e3c:	75 e2                	jne    80104e20 <procdump+0x90>
80104e3e:	e9 65 ff ff ff       	jmp    80104da8 <procdump+0x18>
80104e43:	90                   	nop
80104e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104e48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e4b:	5b                   	pop    %ebx
80104e4c:	5e                   	pop    %esi
80104e4d:	5f                   	pop    %edi
80104e4e:	5d                   	pop    %ebp
80104e4f:	c3                   	ret    

80104e50 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	53                   	push   %ebx
80104e54:	83 ec 0c             	sub    $0xc,%esp
80104e57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104e5a:	68 78 87 10 80       	push   $0x80108778
80104e5f:	8d 43 04             	lea    0x4(%ebx),%eax
80104e62:	50                   	push   %eax
80104e63:	e8 f8 00 00 00       	call   80104f60 <initlock>
  lk->name = name;
80104e68:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104e6b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104e71:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
80104e74:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
80104e7b:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
80104e7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e81:	c9                   	leave  
80104e82:	c3                   	ret    
80104e83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e90 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104e90:	55                   	push   %ebp
80104e91:	89 e5                	mov    %esp,%ebp
80104e93:	56                   	push   %esi
80104e94:	53                   	push   %ebx
80104e95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e98:	83 ec 0c             	sub    $0xc,%esp
80104e9b:	8d 73 04             	lea    0x4(%ebx),%esi
80104e9e:	56                   	push   %esi
80104e9f:	e8 bc 01 00 00       	call   80105060 <acquire>
  while (lk->locked) {
80104ea4:	8b 13                	mov    (%ebx),%edx
80104ea6:	83 c4 10             	add    $0x10,%esp
80104ea9:	85 d2                	test   %edx,%edx
80104eab:	74 16                	je     80104ec3 <acquiresleep+0x33>
80104ead:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104eb0:	83 ec 08             	sub    $0x8,%esp
80104eb3:	56                   	push   %esi
80104eb4:	53                   	push   %ebx
80104eb5:	e8 36 fc ff ff       	call   80104af0 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
80104eba:	8b 03                	mov    (%ebx),%eax
80104ebc:	83 c4 10             	add    $0x10,%esp
80104ebf:	85 c0                	test   %eax,%eax
80104ec1:	75 ed                	jne    80104eb0 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104ec3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104ec9:	e8 72 f6 ff ff       	call   80104540 <myproc>
80104ece:	8b 40 10             	mov    0x10(%eax),%eax
80104ed1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104ed4:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104ed7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104eda:	5b                   	pop    %ebx
80104edb:	5e                   	pop    %esi
80104edc:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
80104edd:	e9 9e 02 00 00       	jmp    80105180 <release>
80104ee2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ef0 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	56                   	push   %esi
80104ef4:	53                   	push   %ebx
80104ef5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104ef8:	83 ec 0c             	sub    $0xc,%esp
80104efb:	8d 73 04             	lea    0x4(%ebx),%esi
80104efe:	56                   	push   %esi
80104eff:	e8 5c 01 00 00       	call   80105060 <acquire>
  lk->locked = 0;
80104f04:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104f0a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104f11:	89 1c 24             	mov    %ebx,(%esp)
80104f14:	e8 87 fd ff ff       	call   80104ca0 <wakeup>
  release(&lk->lk);
80104f19:	89 75 08             	mov    %esi,0x8(%ebp)
80104f1c:	83 c4 10             	add    $0x10,%esp
}
80104f1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f22:	5b                   	pop    %ebx
80104f23:	5e                   	pop    %esi
80104f24:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104f25:	e9 56 02 00 00       	jmp    80105180 <release>
80104f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f30 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	56                   	push   %esi
80104f34:	53                   	push   %ebx
80104f35:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104f38:	83 ec 0c             	sub    $0xc,%esp
80104f3b:	8d 5e 04             	lea    0x4(%esi),%ebx
80104f3e:	53                   	push   %ebx
80104f3f:	e8 1c 01 00 00       	call   80105060 <acquire>
  r = lk->locked;
80104f44:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104f46:	89 1c 24             	mov    %ebx,(%esp)
80104f49:	e8 32 02 00 00       	call   80105180 <release>
  return r;
}
80104f4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f51:	89 f0                	mov    %esi,%eax
80104f53:	5b                   	pop    %ebx
80104f54:	5e                   	pop    %esi
80104f55:	5d                   	pop    %ebp
80104f56:	c3                   	ret    
80104f57:	66 90                	xchg   %ax,%ax
80104f59:	66 90                	xchg   %ax,%ax
80104f5b:	66 90                	xchg   %ax,%ax
80104f5d:	66 90                	xchg   %ax,%ax
80104f5f:	90                   	nop

80104f60 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104f66:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104f69:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
80104f6f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104f72:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104f79:	5d                   	pop    %ebp
80104f7a:	c3                   	ret    
80104f7b:	90                   	nop
80104f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f80 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104f84:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104f87:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104f8a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
80104f8d:	31 c0                	xor    %eax,%eax
80104f8f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f90:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104f96:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104f9c:	77 1a                	ja     80104fb8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104f9e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104fa1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104fa4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104fa7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104fa9:	83 f8 0a             	cmp    $0xa,%eax
80104fac:	75 e2                	jne    80104f90 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104fae:	5b                   	pop    %ebx
80104faf:	5d                   	pop    %ebp
80104fb0:	c3                   	ret    
80104fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104fb8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104fbf:	83 c0 01             	add    $0x1,%eax
80104fc2:	83 f8 0a             	cmp    $0xa,%eax
80104fc5:	74 e7                	je     80104fae <getcallerpcs+0x2e>
    pcs[i] = 0;
80104fc7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104fce:	83 c0 01             	add    $0x1,%eax
80104fd1:	83 f8 0a             	cmp    $0xa,%eax
80104fd4:	75 e2                	jne    80104fb8 <getcallerpcs+0x38>
80104fd6:	eb d6                	jmp    80104fae <getcallerpcs+0x2e>
80104fd8:	90                   	nop
80104fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104fe0 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104fe0:	55                   	push   %ebp
80104fe1:	89 e5                	mov    %esp,%ebp
80104fe3:	53                   	push   %ebx
80104fe4:	83 ec 04             	sub    $0x4,%esp
80104fe7:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
80104fea:	8b 02                	mov    (%edx),%eax
80104fec:	85 c0                	test   %eax,%eax
80104fee:	75 10                	jne    80105000 <holding+0x20>
}
80104ff0:	83 c4 04             	add    $0x4,%esp
80104ff3:	31 c0                	xor    %eax,%eax
80104ff5:	5b                   	pop    %ebx
80104ff6:	5d                   	pop    %ebp
80104ff7:	c3                   	ret    
80104ff8:	90                   	nop
80104ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80105000:	8b 5a 08             	mov    0x8(%edx),%ebx
80105003:	e8 98 f4 ff ff       	call   801044a0 <mycpu>
80105008:	39 c3                	cmp    %eax,%ebx
8010500a:	0f 94 c0             	sete   %al
}
8010500d:	83 c4 04             	add    $0x4,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80105010:	0f b6 c0             	movzbl %al,%eax
}
80105013:	5b                   	pop    %ebx
80105014:	5d                   	pop    %ebp
80105015:	c3                   	ret    
80105016:	8d 76 00             	lea    0x0(%esi),%esi
80105019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105020 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	53                   	push   %ebx
80105024:	83 ec 04             	sub    $0x4,%esp
80105027:	9c                   	pushf  
80105028:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80105029:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010502a:	e8 71 f4 ff ff       	call   801044a0 <mycpu>
8010502f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105035:	85 c0                	test   %eax,%eax
80105037:	75 11                	jne    8010504a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105039:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010503f:	e8 5c f4 ff ff       	call   801044a0 <mycpu>
80105044:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010504a:	e8 51 f4 ff ff       	call   801044a0 <mycpu>
8010504f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105056:	83 c4 04             	add    $0x4,%esp
80105059:	5b                   	pop    %ebx
8010505a:	5d                   	pop    %ebp
8010505b:	c3                   	ret    
8010505c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105060 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	56                   	push   %esi
80105064:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80105065:	e8 b6 ff ff ff       	call   80105020 <pushcli>
  if(holding(lk))
8010506a:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
8010506d:	8b 03                	mov    (%ebx),%eax
8010506f:	85 c0                	test   %eax,%eax
80105071:	75 7d                	jne    801050f0 <acquire+0x90>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80105073:	ba 01 00 00 00       	mov    $0x1,%edx
80105078:	eb 09                	jmp    80105083 <acquire+0x23>
8010507a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105080:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105083:	89 d0                	mov    %edx,%eax
80105085:	f0 87 03             	lock xchg %eax,(%ebx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80105088:	85 c0                	test   %eax,%eax
8010508a:	75 f4                	jne    80105080 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010508c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80105091:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105094:	e8 07 f4 ff ff       	call   801044a0 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80105099:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
8010509b:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
8010509e:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801050a1:	31 c0                	xor    %eax,%eax
801050a3:	90                   	nop
801050a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801050a8:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801050ae:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801050b4:	77 1a                	ja     801050d0 <acquire+0x70>
      break;
    pcs[i] = ebp[1];     // saved %eip
801050b6:	8b 5a 04             	mov    0x4(%edx),%ebx
801050b9:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801050bc:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801050bf:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801050c1:	83 f8 0a             	cmp    $0xa,%eax
801050c4:	75 e2                	jne    801050a8 <acquire+0x48>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
801050c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050c9:	5b                   	pop    %ebx
801050ca:	5e                   	pop    %esi
801050cb:	5d                   	pop    %ebp
801050cc:	c3                   	ret    
801050cd:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801050d0:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801050d7:	83 c0 01             	add    $0x1,%eax
801050da:	83 f8 0a             	cmp    $0xa,%eax
801050dd:	74 e7                	je     801050c6 <acquire+0x66>
    pcs[i] = 0;
801050df:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801050e6:	83 c0 01             	add    $0x1,%eax
801050e9:	83 f8 0a             	cmp    $0xa,%eax
801050ec:	75 e2                	jne    801050d0 <acquire+0x70>
801050ee:	eb d6                	jmp    801050c6 <acquire+0x66>

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801050f0:	8b 73 08             	mov    0x8(%ebx),%esi
801050f3:	e8 a8 f3 ff ff       	call   801044a0 <mycpu>
801050f8:	39 c6                	cmp    %eax,%esi
801050fa:	0f 85 73 ff ff ff    	jne    80105073 <acquire+0x13>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80105100:	83 ec 0c             	sub    $0xc,%esp
80105103:	68 83 87 10 80       	push   $0x80108783
80105108:	e8 b3 b6 ff ff       	call   801007c0 <panic>
8010510d:	8d 76 00             	lea    0x0(%esi),%esi

80105110 <popcli>:
  mycpu()->ncli += 1;
}

void
popcli(void)
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105116:	9c                   	pushf  
80105117:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105118:	f6 c4 02             	test   $0x2,%ah
8010511b:	75 52                	jne    8010516f <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010511d:	e8 7e f3 ff ff       	call   801044a0 <mycpu>
80105122:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80105128:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010512b:	85 d2                	test   %edx,%edx
8010512d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80105133:	78 2d                	js     80105162 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105135:	e8 66 f3 ff ff       	call   801044a0 <mycpu>
8010513a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105140:	85 d2                	test   %edx,%edx
80105142:	74 0c                	je     80105150 <popcli+0x40>
    sti();
}
80105144:	c9                   	leave  
80105145:	c3                   	ret    
80105146:	8d 76 00             	lea    0x0(%esi),%esi
80105149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105150:	e8 4b f3 ff ff       	call   801044a0 <mycpu>
80105155:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010515b:	85 c0                	test   %eax,%eax
8010515d:	74 e5                	je     80105144 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
8010515f:	fb                   	sti    
    sti();
}
80105160:	c9                   	leave  
80105161:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80105162:	83 ec 0c             	sub    $0xc,%esp
80105165:	68 a2 87 10 80       	push   $0x801087a2
8010516a:	e8 51 b6 ff ff       	call   801007c0 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
8010516f:	83 ec 0c             	sub    $0xc,%esp
80105172:	68 8b 87 10 80       	push   $0x8010878b
80105177:	e8 44 b6 ff ff       	call   801007c0 <panic>
8010517c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105180 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80105180:	55                   	push   %ebp
80105181:	89 e5                	mov    %esp,%ebp
80105183:	56                   	push   %esi
80105184:	53                   	push   %ebx
80105185:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80105188:	8b 03                	mov    (%ebx),%eax
8010518a:	85 c0                	test   %eax,%eax
8010518c:	75 12                	jne    801051a0 <release+0x20>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
8010518e:	83 ec 0c             	sub    $0xc,%esp
80105191:	68 a9 87 10 80       	push   $0x801087a9
80105196:	e8 25 b6 ff ff       	call   801007c0 <panic>
8010519b:	90                   	nop
8010519c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801051a0:	8b 73 08             	mov    0x8(%ebx),%esi
801051a3:	e8 f8 f2 ff ff       	call   801044a0 <mycpu>
801051a8:	39 c6                	cmp    %eax,%esi
801051aa:	75 e2                	jne    8010518e <release+0xe>
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");

  lk->pcs[0] = 0;
801051ac:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801051b3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
801051ba:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801051bf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
801051c5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801051c8:	5b                   	pop    %ebx
801051c9:	5e                   	pop    %esi
801051ca:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
801051cb:	e9 40 ff ff ff       	jmp    80105110 <popcli>

801051d0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	57                   	push   %edi
801051d4:	53                   	push   %ebx
801051d5:	8b 55 08             	mov    0x8(%ebp),%edx
801051d8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801051db:	f6 c2 03             	test   $0x3,%dl
801051de:	75 05                	jne    801051e5 <memset+0x15>
801051e0:	f6 c1 03             	test   $0x3,%cl
801051e3:	74 13                	je     801051f8 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
801051e5:	89 d7                	mov    %edx,%edi
801051e7:	8b 45 0c             	mov    0xc(%ebp),%eax
801051ea:	fc                   	cld    
801051eb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801051ed:	5b                   	pop    %ebx
801051ee:	89 d0                	mov    %edx,%eax
801051f0:	5f                   	pop    %edi
801051f1:	5d                   	pop    %ebp
801051f2:	c3                   	ret    
801051f3:	90                   	nop
801051f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
801051f8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
801051fc:	c1 e9 02             	shr    $0x2,%ecx
801051ff:	89 fb                	mov    %edi,%ebx
80105201:	89 f8                	mov    %edi,%eax
80105203:	c1 e3 18             	shl    $0x18,%ebx
80105206:	c1 e0 10             	shl    $0x10,%eax
80105209:	09 d8                	or     %ebx,%eax
8010520b:	09 f8                	or     %edi,%eax
8010520d:	c1 e7 08             	shl    $0x8,%edi
80105210:	09 f8                	or     %edi,%eax
80105212:	89 d7                	mov    %edx,%edi
80105214:	fc                   	cld    
80105215:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105217:	5b                   	pop    %ebx
80105218:	89 d0                	mov    %edx,%eax
8010521a:	5f                   	pop    %edi
8010521b:	5d                   	pop    %ebp
8010521c:	c3                   	ret    
8010521d:	8d 76 00             	lea    0x0(%esi),%esi

80105220 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105220:	55                   	push   %ebp
80105221:	89 e5                	mov    %esp,%ebp
80105223:	57                   	push   %edi
80105224:	56                   	push   %esi
80105225:	8b 45 10             	mov    0x10(%ebp),%eax
80105228:	53                   	push   %ebx
80105229:	8b 75 0c             	mov    0xc(%ebp),%esi
8010522c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010522f:	85 c0                	test   %eax,%eax
80105231:	74 29                	je     8010525c <memcmp+0x3c>
    if(*s1 != *s2)
80105233:	0f b6 13             	movzbl (%ebx),%edx
80105236:	0f b6 0e             	movzbl (%esi),%ecx
80105239:	38 d1                	cmp    %dl,%cl
8010523b:	75 2b                	jne    80105268 <memcmp+0x48>
8010523d:	8d 78 ff             	lea    -0x1(%eax),%edi
80105240:	31 c0                	xor    %eax,%eax
80105242:	eb 14                	jmp    80105258 <memcmp+0x38>
80105244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105248:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010524d:	83 c0 01             	add    $0x1,%eax
80105250:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105254:	38 ca                	cmp    %cl,%dl
80105256:	75 10                	jne    80105268 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105258:	39 f8                	cmp    %edi,%eax
8010525a:	75 ec                	jne    80105248 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010525c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010525d:	31 c0                	xor    %eax,%eax
}
8010525f:	5e                   	pop    %esi
80105260:	5f                   	pop    %edi
80105261:	5d                   	pop    %ebp
80105262:	c3                   	ret    
80105263:	90                   	nop
80105264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80105268:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010526b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010526c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010526e:	5e                   	pop    %esi
8010526f:	5f                   	pop    %edi
80105270:	5d                   	pop    %ebp
80105271:	c3                   	ret    
80105272:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105280 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
80105283:	56                   	push   %esi
80105284:	53                   	push   %ebx
80105285:	8b 45 08             	mov    0x8(%ebp),%eax
80105288:	8b 75 0c             	mov    0xc(%ebp),%esi
8010528b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010528e:	39 c6                	cmp    %eax,%esi
80105290:	73 2e                	jae    801052c0 <memmove+0x40>
80105292:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80105295:	39 c8                	cmp    %ecx,%eax
80105297:	73 27                	jae    801052c0 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
80105299:	85 db                	test   %ebx,%ebx
8010529b:	8d 53 ff             	lea    -0x1(%ebx),%edx
8010529e:	74 17                	je     801052b7 <memmove+0x37>
      *--d = *--s;
801052a0:	29 d9                	sub    %ebx,%ecx
801052a2:	89 cb                	mov    %ecx,%ebx
801052a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052a8:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801052ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801052af:	83 ea 01             	sub    $0x1,%edx
801052b2:	83 fa ff             	cmp    $0xffffffff,%edx
801052b5:	75 f1                	jne    801052a8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801052b7:	5b                   	pop    %ebx
801052b8:	5e                   	pop    %esi
801052b9:	5d                   	pop    %ebp
801052ba:	c3                   	ret    
801052bb:	90                   	nop
801052bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801052c0:	31 d2                	xor    %edx,%edx
801052c2:	85 db                	test   %ebx,%ebx
801052c4:	74 f1                	je     801052b7 <memmove+0x37>
801052c6:	8d 76 00             	lea    0x0(%esi),%esi
801052c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
801052d0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801052d4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801052d7:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801052da:	39 d3                	cmp    %edx,%ebx
801052dc:	75 f2                	jne    801052d0 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
801052de:	5b                   	pop    %ebx
801052df:	5e                   	pop    %esi
801052e0:	5d                   	pop    %ebp
801052e1:	c3                   	ret    
801052e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052f0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801052f0:	55                   	push   %ebp
801052f1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801052f3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801052f4:	eb 8a                	jmp    80105280 <memmove>
801052f6:	8d 76 00             	lea    0x0(%esi),%esi
801052f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105300 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105300:	55                   	push   %ebp
80105301:	89 e5                	mov    %esp,%ebp
80105303:	57                   	push   %edi
80105304:	56                   	push   %esi
80105305:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105308:	53                   	push   %ebx
80105309:	8b 7d 08             	mov    0x8(%ebp),%edi
8010530c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010530f:	85 c9                	test   %ecx,%ecx
80105311:	74 37                	je     8010534a <strncmp+0x4a>
80105313:	0f b6 17             	movzbl (%edi),%edx
80105316:	0f b6 1e             	movzbl (%esi),%ebx
80105319:	84 d2                	test   %dl,%dl
8010531b:	74 3f                	je     8010535c <strncmp+0x5c>
8010531d:	38 d3                	cmp    %dl,%bl
8010531f:	75 3b                	jne    8010535c <strncmp+0x5c>
80105321:	8d 47 01             	lea    0x1(%edi),%eax
80105324:	01 cf                	add    %ecx,%edi
80105326:	eb 1b                	jmp    80105343 <strncmp+0x43>
80105328:	90                   	nop
80105329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105330:	0f b6 10             	movzbl (%eax),%edx
80105333:	84 d2                	test   %dl,%dl
80105335:	74 21                	je     80105358 <strncmp+0x58>
80105337:	0f b6 19             	movzbl (%ecx),%ebx
8010533a:	83 c0 01             	add    $0x1,%eax
8010533d:	89 ce                	mov    %ecx,%esi
8010533f:	38 da                	cmp    %bl,%dl
80105341:	75 19                	jne    8010535c <strncmp+0x5c>
80105343:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80105345:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80105348:	75 e6                	jne    80105330 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010534a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010534b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010534d:	5e                   	pop    %esi
8010534e:	5f                   	pop    %edi
8010534f:	5d                   	pop    %ebp
80105350:	c3                   	ret    
80105351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105358:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010535c:	0f b6 c2             	movzbl %dl,%eax
8010535f:	29 d8                	sub    %ebx,%eax
}
80105361:	5b                   	pop    %ebx
80105362:	5e                   	pop    %esi
80105363:	5f                   	pop    %edi
80105364:	5d                   	pop    %ebp
80105365:	c3                   	ret    
80105366:	8d 76 00             	lea    0x0(%esi),%esi
80105369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105370 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	56                   	push   %esi
80105374:	53                   	push   %ebx
80105375:	8b 45 08             	mov    0x8(%ebp),%eax
80105378:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010537b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010537e:	89 c2                	mov    %eax,%edx
80105380:	eb 19                	jmp    8010539b <strncpy+0x2b>
80105382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105388:	83 c3 01             	add    $0x1,%ebx
8010538b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010538f:	83 c2 01             	add    $0x1,%edx
80105392:	84 c9                	test   %cl,%cl
80105394:	88 4a ff             	mov    %cl,-0x1(%edx)
80105397:	74 09                	je     801053a2 <strncpy+0x32>
80105399:	89 f1                	mov    %esi,%ecx
8010539b:	85 c9                	test   %ecx,%ecx
8010539d:	8d 71 ff             	lea    -0x1(%ecx),%esi
801053a0:	7f e6                	jg     80105388 <strncpy+0x18>
    ;
  while(n-- > 0)
801053a2:	31 c9                	xor    %ecx,%ecx
801053a4:	85 f6                	test   %esi,%esi
801053a6:	7e 17                	jle    801053bf <strncpy+0x4f>
801053a8:	90                   	nop
801053a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801053b0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801053b4:	89 f3                	mov    %esi,%ebx
801053b6:	83 c1 01             	add    $0x1,%ecx
801053b9:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801053bb:	85 db                	test   %ebx,%ebx
801053bd:	7f f1                	jg     801053b0 <strncpy+0x40>
    *s++ = 0;
  return os;
}
801053bf:	5b                   	pop    %ebx
801053c0:	5e                   	pop    %esi
801053c1:	5d                   	pop    %ebp
801053c2:	c3                   	ret    
801053c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801053c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053d0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	56                   	push   %esi
801053d4:	53                   	push   %ebx
801053d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801053d8:	8b 45 08             	mov    0x8(%ebp),%eax
801053db:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
801053de:	85 c9                	test   %ecx,%ecx
801053e0:	7e 26                	jle    80105408 <safestrcpy+0x38>
801053e2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
801053e6:	89 c1                	mov    %eax,%ecx
801053e8:	eb 17                	jmp    80105401 <safestrcpy+0x31>
801053ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801053f0:	83 c2 01             	add    $0x1,%edx
801053f3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
801053f7:	83 c1 01             	add    $0x1,%ecx
801053fa:	84 db                	test   %bl,%bl
801053fc:	88 59 ff             	mov    %bl,-0x1(%ecx)
801053ff:	74 04                	je     80105405 <safestrcpy+0x35>
80105401:	39 f2                	cmp    %esi,%edx
80105403:	75 eb                	jne    801053f0 <safestrcpy+0x20>
    ;
  *s = 0;
80105405:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105408:	5b                   	pop    %ebx
80105409:	5e                   	pop    %esi
8010540a:	5d                   	pop    %ebp
8010540b:	c3                   	ret    
8010540c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105410 <strlen>:

int
strlen(const char *s)
{
80105410:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105411:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80105413:	89 e5                	mov    %esp,%ebp
80105415:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80105418:	80 3a 00             	cmpb   $0x0,(%edx)
8010541b:	74 0c                	je     80105429 <strlen+0x19>
8010541d:	8d 76 00             	lea    0x0(%esi),%esi
80105420:	83 c0 01             	add    $0x1,%eax
80105423:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105427:	75 f7                	jne    80105420 <strlen+0x10>
    ;
  return n;
}
80105429:	5d                   	pop    %ebp
8010542a:	c3                   	ret    

8010542b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010542b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010542f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80105433:	55                   	push   %ebp
  pushl %ebx
80105434:	53                   	push   %ebx
  pushl %esi
80105435:	56                   	push   %esi
  pushl %edi
80105436:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105437:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105439:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010543b:	5f                   	pop    %edi
  popl %esi
8010543c:	5e                   	pop    %esi
  popl %ebx
8010543d:	5b                   	pop    %ebx
  popl %ebp
8010543e:	5d                   	pop    %ebp
  ret
8010543f:	c3                   	ret    

80105440 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	53                   	push   %ebx
80105444:	83 ec 04             	sub    $0x4,%esp
80105447:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010544a:	e8 f1 f0 ff ff       	call   80104540 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010544f:	8b 00                	mov    (%eax),%eax
80105451:	39 d8                	cmp    %ebx,%eax
80105453:	76 1b                	jbe    80105470 <fetchint+0x30>
80105455:	8d 53 04             	lea    0x4(%ebx),%edx
80105458:	39 d0                	cmp    %edx,%eax
8010545a:	72 14                	jb     80105470 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010545c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010545f:	8b 13                	mov    (%ebx),%edx
80105461:	89 10                	mov    %edx,(%eax)
  return 0;
80105463:	31 c0                	xor    %eax,%eax
}
80105465:	83 c4 04             	add    $0x4,%esp
80105468:	5b                   	pop    %ebx
80105469:	5d                   	pop    %ebp
8010546a:	c3                   	ret    
8010546b:	90                   	nop
8010546c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80105470:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105475:	eb ee                	jmp    80105465 <fetchint+0x25>
80105477:	89 f6                	mov    %esi,%esi
80105479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105480 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	53                   	push   %ebx
80105484:	83 ec 04             	sub    $0x4,%esp
80105487:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010548a:	e8 b1 f0 ff ff       	call   80104540 <myproc>

  if(addr >= curproc->sz)
8010548f:	39 18                	cmp    %ebx,(%eax)
80105491:	76 29                	jbe    801054bc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80105493:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105496:	89 da                	mov    %ebx,%edx
80105498:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010549a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010549c:	39 c3                	cmp    %eax,%ebx
8010549e:	73 1c                	jae    801054bc <fetchstr+0x3c>
    if(*s == 0)
801054a0:	80 3b 00             	cmpb   $0x0,(%ebx)
801054a3:	75 10                	jne    801054b5 <fetchstr+0x35>
801054a5:	eb 29                	jmp    801054d0 <fetchstr+0x50>
801054a7:	89 f6                	mov    %esi,%esi
801054a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801054b0:	80 3a 00             	cmpb   $0x0,(%edx)
801054b3:	74 1b                	je     801054d0 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
801054b5:	83 c2 01             	add    $0x1,%edx
801054b8:	39 d0                	cmp    %edx,%eax
801054ba:	77 f4                	ja     801054b0 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801054bc:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
801054bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
801054c4:	5b                   	pop    %ebx
801054c5:	5d                   	pop    %ebp
801054c6:	c3                   	ret    
801054c7:	89 f6                	mov    %esi,%esi
801054c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801054d0:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
801054d3:	89 d0                	mov    %edx,%eax
801054d5:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801054d7:	5b                   	pop    %ebx
801054d8:	5d                   	pop    %ebp
801054d9:	c3                   	ret    
801054da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801054e0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	56                   	push   %esi
801054e4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054e5:	e8 56 f0 ff ff       	call   80104540 <myproc>
801054ea:	8b 40 18             	mov    0x18(%eax),%eax
801054ed:	8b 55 08             	mov    0x8(%ebp),%edx
801054f0:	8b 40 44             	mov    0x44(%eax),%eax
801054f3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
801054f6:	e8 45 f0 ff ff       	call   80104540 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801054fb:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054fd:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105500:	39 c6                	cmp    %eax,%esi
80105502:	73 1c                	jae    80105520 <argint+0x40>
80105504:	8d 53 08             	lea    0x8(%ebx),%edx
80105507:	39 d0                	cmp    %edx,%eax
80105509:	72 15                	jb     80105520 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
8010550b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010550e:	8b 53 04             	mov    0x4(%ebx),%edx
80105511:	89 10                	mov    %edx,(%eax)
  return 0;
80105513:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80105515:	5b                   	pop    %ebx
80105516:	5e                   	pop    %esi
80105517:	5d                   	pop    %ebp
80105518:	c3                   	ret    
80105519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80105520:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105525:	eb ee                	jmp    80105515 <argint+0x35>
80105527:	89 f6                	mov    %esi,%esi
80105529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105530 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	56                   	push   %esi
80105534:	53                   	push   %ebx
80105535:	83 ec 10             	sub    $0x10,%esp
80105538:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010553b:	e8 00 f0 ff ff       	call   80104540 <myproc>
80105540:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105542:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105545:	83 ec 08             	sub    $0x8,%esp
80105548:	50                   	push   %eax
80105549:	ff 75 08             	pushl  0x8(%ebp)
8010554c:	e8 8f ff ff ff       	call   801054e0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105551:	c1 e8 1f             	shr    $0x1f,%eax
80105554:	83 c4 10             	add    $0x10,%esp
80105557:	84 c0                	test   %al,%al
80105559:	75 2d                	jne    80105588 <argptr+0x58>
8010555b:	89 d8                	mov    %ebx,%eax
8010555d:	c1 e8 1f             	shr    $0x1f,%eax
80105560:	84 c0                	test   %al,%al
80105562:	75 24                	jne    80105588 <argptr+0x58>
80105564:	8b 16                	mov    (%esi),%edx
80105566:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105569:	39 c2                	cmp    %eax,%edx
8010556b:	76 1b                	jbe    80105588 <argptr+0x58>
8010556d:	01 c3                	add    %eax,%ebx
8010556f:	39 da                	cmp    %ebx,%edx
80105571:	72 15                	jb     80105588 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80105573:	8b 55 0c             	mov    0xc(%ebp),%edx
80105576:	89 02                	mov    %eax,(%edx)
  return 0;
80105578:	31 c0                	xor    %eax,%eax
}
8010557a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010557d:	5b                   	pop    %ebx
8010557e:	5e                   	pop    %esi
8010557f:	5d                   	pop    %ebp
80105580:	c3                   	ret    
80105581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80105588:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010558d:	eb eb                	jmp    8010557a <argptr+0x4a>
8010558f:	90                   	nop

80105590 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105596:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105599:	50                   	push   %eax
8010559a:	ff 75 08             	pushl  0x8(%ebp)
8010559d:	e8 3e ff ff ff       	call   801054e0 <argint>
801055a2:	83 c4 10             	add    $0x10,%esp
801055a5:	85 c0                	test   %eax,%eax
801055a7:	78 17                	js     801055c0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801055a9:	83 ec 08             	sub    $0x8,%esp
801055ac:	ff 75 0c             	pushl  0xc(%ebp)
801055af:	ff 75 f4             	pushl  -0xc(%ebp)
801055b2:	e8 c9 fe ff ff       	call   80105480 <fetchstr>
801055b7:	83 c4 10             	add    $0x10,%esp
}
801055ba:	c9                   	leave  
801055bb:	c3                   	ret    
801055bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
801055c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
801055c5:	c9                   	leave  
801055c6:	c3                   	ret    
801055c7:	89 f6                	mov    %esi,%esi
801055c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055d0 <syscall>:

};

void
syscall(void)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	56                   	push   %esi
801055d4:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
801055d5:	e8 66 ef ff ff       	call   80104540 <myproc>

  num = curproc->tf->eax;
801055da:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
801055dd:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801055df:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801055e2:	8d 50 ff             	lea    -0x1(%eax),%edx
801055e5:	83 fa 15             	cmp    $0x15,%edx
801055e8:	77 1e                	ja     80105608 <syscall+0x38>
801055ea:	8b 14 85 e0 87 10 80 	mov    -0x7fef7820(,%eax,4),%edx
801055f1:	85 d2                	test   %edx,%edx
801055f3:	74 13                	je     80105608 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
801055f5:	ff d2                	call   *%edx
801055f7:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801055fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801055fd:	5b                   	pop    %ebx
801055fe:	5e                   	pop    %esi
801055ff:	5d                   	pop    %ebp
80105600:	c3                   	ret    
80105601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105608:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105609:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
8010560c:	50                   	push   %eax
8010560d:	ff 73 10             	pushl  0x10(%ebx)
80105610:	68 b1 87 10 80       	push   $0x801087b1
80105615:	e8 16 b0 ff ff       	call   80100630 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
8010561a:	8b 43 18             	mov    0x18(%ebx),%eax
8010561d:	83 c4 10             	add    $0x10,%esp
80105620:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80105627:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010562a:	5b                   	pop    %ebx
8010562b:	5e                   	pop    %esi
8010562c:	5d                   	pop    %ebp
8010562d:	c3                   	ret    
8010562e:	66 90                	xchg   %ax,%ax

80105630 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	57                   	push   %edi
80105634:	56                   	push   %esi
80105635:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105636:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105639:	83 ec 44             	sub    $0x44,%esp
8010563c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010563f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105642:	56                   	push   %esi
80105643:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105644:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105647:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010564a:	e8 51 d6 ff ff       	call   80102ca0 <nameiparent>
8010564f:	83 c4 10             	add    $0x10,%esp
80105652:	85 c0                	test   %eax,%eax
80105654:	0f 84 f6 00 00 00    	je     80105750 <create+0x120>
    return 0;
  ilock(dp);
8010565a:	83 ec 0c             	sub    $0xc,%esp
8010565d:	89 c7                	mov    %eax,%edi
8010565f:	50                   	push   %eax
80105660:	e8 cb cd ff ff       	call   80102430 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105665:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105668:	83 c4 0c             	add    $0xc,%esp
8010566b:	50                   	push   %eax
8010566c:	56                   	push   %esi
8010566d:	57                   	push   %edi
8010566e:	e8 ed d2 ff ff       	call   80102960 <dirlookup>
80105673:	83 c4 10             	add    $0x10,%esp
80105676:	85 c0                	test   %eax,%eax
80105678:	89 c3                	mov    %eax,%ebx
8010567a:	74 54                	je     801056d0 <create+0xa0>
    iunlockput(dp);
8010567c:	83 ec 0c             	sub    $0xc,%esp
8010567f:	57                   	push   %edi
80105680:	e8 3b d0 ff ff       	call   801026c0 <iunlockput>
    ilock(ip);
80105685:	89 1c 24             	mov    %ebx,(%esp)
80105688:	e8 a3 cd ff ff       	call   80102430 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010568d:	83 c4 10             	add    $0x10,%esp
80105690:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80105695:	75 19                	jne    801056b0 <create+0x80>
80105697:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
8010569c:	89 d8                	mov    %ebx,%eax
8010569e:	75 10                	jne    801056b0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801056a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056a3:	5b                   	pop    %ebx
801056a4:	5e                   	pop    %esi
801056a5:	5f                   	pop    %edi
801056a6:	5d                   	pop    %ebp
801056a7:	c3                   	ret    
801056a8:	90                   	nop
801056a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
801056b0:	83 ec 0c             	sub    $0xc,%esp
801056b3:	53                   	push   %ebx
801056b4:	e8 07 d0 ff ff       	call   801026c0 <iunlockput>
    return 0;
801056b9:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801056bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
801056bf:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801056c1:	5b                   	pop    %ebx
801056c2:	5e                   	pop    %esi
801056c3:	5f                   	pop    %edi
801056c4:	5d                   	pop    %ebp
801056c5:	c3                   	ret    
801056c6:	8d 76 00             	lea    0x0(%esi),%esi
801056c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
801056d0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
801056d4:	83 ec 08             	sub    $0x8,%esp
801056d7:	50                   	push   %eax
801056d8:	ff 37                	pushl  (%edi)
801056da:	e8 e1 cb ff ff       	call   801022c0 <ialloc>
801056df:	83 c4 10             	add    $0x10,%esp
801056e2:	85 c0                	test   %eax,%eax
801056e4:	89 c3                	mov    %eax,%ebx
801056e6:	0f 84 cc 00 00 00    	je     801057b8 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
801056ec:	83 ec 0c             	sub    $0xc,%esp
801056ef:	50                   	push   %eax
801056f0:	e8 3b cd ff ff       	call   80102430 <ilock>
  ip->major = major;
801056f5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
801056f9:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
801056fd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105701:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80105705:	b8 01 00 00 00       	mov    $0x1,%eax
8010570a:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
8010570e:	89 1c 24             	mov    %ebx,(%esp)
80105711:	e8 6a cc ff ff       	call   80102380 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80105716:	83 c4 10             	add    $0x10,%esp
80105719:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010571e:	74 40                	je     80105760 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105720:	83 ec 04             	sub    $0x4,%esp
80105723:	ff 73 04             	pushl  0x4(%ebx)
80105726:	56                   	push   %esi
80105727:	57                   	push   %edi
80105728:	e8 93 d4 ff ff       	call   80102bc0 <dirlink>
8010572d:	83 c4 10             	add    $0x10,%esp
80105730:	85 c0                	test   %eax,%eax
80105732:	78 77                	js     801057ab <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80105734:	83 ec 0c             	sub    $0xc,%esp
80105737:	57                   	push   %edi
80105738:	e8 83 cf ff ff       	call   801026c0 <iunlockput>

  return ip;
8010573d:	83 c4 10             	add    $0x10,%esp
}
80105740:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80105743:	89 d8                	mov    %ebx,%eax
}
80105745:	5b                   	pop    %ebx
80105746:	5e                   	pop    %esi
80105747:	5f                   	pop    %edi
80105748:	5d                   	pop    %ebp
80105749:	c3                   	ret    
8010574a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80105750:	31 c0                	xor    %eax,%eax
80105752:	e9 49 ff ff ff       	jmp    801056a0 <create+0x70>
80105757:	89 f6                	mov    %esi,%esi
80105759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80105760:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80105765:	83 ec 0c             	sub    $0xc,%esp
80105768:	57                   	push   %edi
80105769:	e8 12 cc ff ff       	call   80102380 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010576e:	83 c4 0c             	add    $0xc,%esp
80105771:	ff 73 04             	pushl  0x4(%ebx)
80105774:	68 58 88 10 80       	push   $0x80108858
80105779:	53                   	push   %ebx
8010577a:	e8 41 d4 ff ff       	call   80102bc0 <dirlink>
8010577f:	83 c4 10             	add    $0x10,%esp
80105782:	85 c0                	test   %eax,%eax
80105784:	78 18                	js     8010579e <create+0x16e>
80105786:	83 ec 04             	sub    $0x4,%esp
80105789:	ff 77 04             	pushl  0x4(%edi)
8010578c:	68 57 88 10 80       	push   $0x80108857
80105791:	53                   	push   %ebx
80105792:	e8 29 d4 ff ff       	call   80102bc0 <dirlink>
80105797:	83 c4 10             	add    $0x10,%esp
8010579a:	85 c0                	test   %eax,%eax
8010579c:	79 82                	jns    80105720 <create+0xf0>
      panic("create dots");
8010579e:	83 ec 0c             	sub    $0xc,%esp
801057a1:	68 4b 88 10 80       	push   $0x8010884b
801057a6:	e8 15 b0 ff ff       	call   801007c0 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
801057ab:	83 ec 0c             	sub    $0xc,%esp
801057ae:	68 5a 88 10 80       	push   $0x8010885a
801057b3:	e8 08 b0 ff ff       	call   801007c0 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
801057b8:	83 ec 0c             	sub    $0xc,%esp
801057bb:	68 3c 88 10 80       	push   $0x8010883c
801057c0:	e8 fb af ff ff       	call   801007c0 <panic>
801057c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057d0 <argfd.constprop.0>:
}

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
801057d0:	55                   	push   %ebp
801057d1:	89 e5                	mov    %esp,%ebp
801057d3:	56                   	push   %esi
801057d4:	53                   	push   %ebx
801057d5:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801057d7:	8d 45 f4             	lea    -0xc(%ebp),%eax
}

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
801057da:	89 d3                	mov    %edx,%ebx
801057dc:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801057df:	50                   	push   %eax
801057e0:	6a 00                	push   $0x0
801057e2:	e8 f9 fc ff ff       	call   801054e0 <argint>
801057e7:	83 c4 10             	add    $0x10,%esp
801057ea:	85 c0                	test   %eax,%eax
801057ec:	78 32                	js     80105820 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801057ee:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801057f2:	77 2c                	ja     80105820 <argfd.constprop.0+0x50>
801057f4:	e8 47 ed ff ff       	call   80104540 <myproc>
801057f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057fc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105800:	85 c0                	test   %eax,%eax
80105802:	74 1c                	je     80105820 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80105804:	85 f6                	test   %esi,%esi
80105806:	74 02                	je     8010580a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105808:	89 16                	mov    %edx,(%esi)
  if(pf)
8010580a:	85 db                	test   %ebx,%ebx
8010580c:	74 22                	je     80105830 <argfd.constprop.0+0x60>
    *pf = f;
8010580e:	89 03                	mov    %eax,(%ebx)
  return 0;
80105810:	31 c0                	xor    %eax,%eax
}
80105812:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105815:	5b                   	pop    %ebx
80105816:	5e                   	pop    %esi
80105817:	5d                   	pop    %ebp
80105818:	c3                   	ret    
80105819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105820:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80105823:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80105828:	5b                   	pop    %ebx
80105829:	5e                   	pop    %esi
8010582a:	5d                   	pop    %ebp
8010582b:	c3                   	ret    
8010582c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80105830:	31 c0                	xor    %eax,%eax
80105832:	eb de                	jmp    80105812 <argfd.constprop.0+0x42>
80105834:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010583a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105840 <sys_setconsole>:
int consolemode = 0;

//Edit console output
int 
sys_setconsole(void)
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
80105843:	57                   	push   %edi
80105844:	56                   	push   %esi
80105845:	53                   	push   %ebx
    int pos, ch, color, cursor, mode;
    if (argint(0, &pos) < 0 || argint(1, &ch) < 0)
80105846:	8d 45 d4             	lea    -0x2c(%ebp),%eax
int consolemode = 0;

//Edit console output
int 
sys_setconsole(void)
{
80105849:	83 ec 34             	sub    $0x34,%esp
    int pos, ch, color, cursor, mode;
    if (argint(0, &pos) < 0 || argint(1, &ch) < 0)
8010584c:	50                   	push   %eax
8010584d:	6a 00                	push   $0x0
8010584f:	e8 8c fc ff ff       	call   801054e0 <argint>
80105854:	83 c4 10             	add    $0x10,%esp
80105857:	85 c0                	test   %eax,%eax
80105859:	0f 88 e9 00 00 00    	js     80105948 <sys_setconsole+0x108>
8010585f:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105862:	83 ec 08             	sub    $0x8,%esp
80105865:	50                   	push   %eax
80105866:	6a 01                	push   $0x1
80105868:	e8 73 fc ff ff       	call   801054e0 <argint>
8010586d:	83 c4 10             	add    $0x10,%esp
80105870:	85 c0                	test   %eax,%eax
80105872:	0f 88 d0 00 00 00    	js     80105948 <sys_setconsole+0x108>
        return -1;
    if (argint(2, &color) < 0)
80105878:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010587b:	83 ec 08             	sub    $0x8,%esp
8010587e:	50                   	push   %eax
8010587f:	6a 02                	push   $0x2
80105881:	e8 5a fc ff ff       	call   801054e0 <argint>
80105886:	83 c4 10             	add    $0x10,%esp
80105889:	85 c0                	test   %eax,%eax
8010588b:	0f 88 97 00 00 00    	js     80105928 <sys_setconsole+0xe8>
        color = 0x0700;
    if (argint(3, &cursor) < 0)
80105891:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105894:	83 ec 08             	sub    $0x8,%esp
80105897:	50                   	push   %eax
80105898:	6a 03                	push   $0x3
8010589a:	e8 41 fc ff ff       	call   801054e0 <argint>
8010589f:	83 c4 10             	add    $0x10,%esp
801058a2:	85 c0                	test   %eax,%eax
801058a4:	0f 88 8e 00 00 00    	js     80105938 <sys_setconsole+0xf8>
        cursor = -1;
    if (argint(4, &mode) < 0)
801058aa:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801058ad:	83 ec 08             	sub    $0x8,%esp
801058b0:	50                   	push   %eax
801058b1:	6a 04                	push   $0x4
801058b3:	e8 28 fc ff ff       	call   801054e0 <argint>
        mode = 0;
    if (pos >= 0){
801058b8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        return -1;
    if (argint(2, &color) < 0)
        color = 0x0700;
    if (argint(3, &cursor) < 0)
        cursor = -1;
    if (argint(4, &mode) < 0)
801058bb:	83 c4 10             	add    $0x10,%esp
801058be:	b9 00 00 00 00       	mov    $0x0,%ecx
801058c3:	85 c0                	test   %eax,%eax
801058c5:	0f 49 4d e4          	cmovns -0x1c(%ebp),%ecx
        mode = 0;
    if (pos >= 0){
801058c9:	85 d2                	test   %edx,%edx
801058cb:	78 10                	js     801058dd <sys_setconsole+0x9d>
        crt[pos] = (ch & 0xff) | color;
801058cd:	0f b6 45 d8          	movzbl -0x28(%ebp),%eax
801058d1:	66 0b 45 dc          	or     -0x24(%ebp),%ax
801058d5:	66 89 84 12 00 80 0b 	mov    %ax,-0x7ff48000(%edx,%edx,1)
801058dc:	80 
    }
    if (cursor >= 0){
801058dd:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801058e0:	85 db                	test   %ebx,%ebx
801058e2:	78 27                	js     8010590b <sys_setconsole+0xcb>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801058e4:	bf d4 03 00 00       	mov    $0x3d4,%edi
801058e9:	b8 0e 00 00 00       	mov    $0xe,%eax
801058ee:	89 fa                	mov    %edi,%edx
801058f0:	ee                   	out    %al,(%dx)
801058f1:	be d5 03 00 00       	mov    $0x3d5,%esi
801058f6:	89 d8                	mov    %ebx,%eax
801058f8:	c1 f8 08             	sar    $0x8,%eax
801058fb:	89 f2                	mov    %esi,%edx
801058fd:	ee                   	out    %al,(%dx)
801058fe:	b8 0f 00 00 00       	mov    $0xf,%eax
80105903:	89 fa                	mov    %edi,%edx
80105905:	ee                   	out    %al,(%dx)
80105906:	89 d8                	mov    %ebx,%eax
80105908:	89 f2                	mov    %esi,%edx
8010590a:	ee                   	out    %al,(%dx)
        outb(CRTPORT, 15);
        outb(CRTPORT+1, cursor);
    }
    if (mode < 0)
        mode = 0;
    consolemode = mode;
8010590b:	85 c9                	test   %ecx,%ecx
8010590d:	b8 00 00 00 00       	mov    $0x0,%eax
80105912:	0f 4e c8             	cmovle %eax,%ecx
80105915:	89 0d fc b5 10 80    	mov    %ecx,0x8010b5fc
    return 0;
}
8010591b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010591e:	5b                   	pop    %ebx
8010591f:	5e                   	pop    %esi
80105920:	5f                   	pop    %edi
80105921:	5d                   	pop    %ebp
80105922:	c3                   	ret    
80105923:	90                   	nop
80105924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
    int pos, ch, color, cursor, mode;
    if (argint(0, &pos) < 0 || argint(1, &ch) < 0)
        return -1;
    if (argint(2, &color) < 0)
        color = 0x0700;
80105928:	c7 45 dc 00 07 00 00 	movl   $0x700,-0x24(%ebp)
8010592f:	e9 5d ff ff ff       	jmp    80105891 <sys_setconsole+0x51>
80105934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (argint(3, &cursor) < 0)
        cursor = -1;
80105938:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
8010593f:	e9 66 ff ff ff       	jmp    801058aa <sys_setconsole+0x6a>
80105944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int 
sys_setconsole(void)
{
    int pos, ch, color, cursor, mode;
    if (argint(0, &pos) < 0 || argint(1, &ch) < 0)
        return -1;
80105948:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010594d:	eb cc                	jmp    8010591b <sys_setconsole+0xdb>
8010594f:	90                   	nop

80105950 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80105950:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105951:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80105953:	89 e5                	mov    %esp,%ebp
80105955:	56                   	push   %esi
80105956:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105957:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
8010595a:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
8010595d:	e8 6e fe ff ff       	call   801057d0 <argfd.constprop.0>
80105962:	85 c0                	test   %eax,%eax
80105964:	78 1a                	js     80105980 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105966:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80105968:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
8010596b:	e8 d0 eb ff ff       	call   80104540 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105970:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105974:	85 d2                	test   %edx,%edx
80105976:	74 18                	je     80105990 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105978:	83 c3 01             	add    $0x1,%ebx
8010597b:	83 fb 10             	cmp    $0x10,%ebx
8010597e:	75 f0                	jne    80105970 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80105980:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80105983:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80105988:	5b                   	pop    %ebx
80105989:	5e                   	pop    %esi
8010598a:	5d                   	pop    %ebp
8010598b:	c3                   	ret    
8010598c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105990:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80105994:	83 ec 0c             	sub    $0xc,%esp
80105997:	ff 75 f4             	pushl  -0xc(%ebp)
8010599a:	e8 01 c2 ff ff       	call   80101ba0 <filedup>
  return fd;
8010599f:	83 c4 10             	add    $0x10,%esp
}
801059a2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
801059a5:	89 d8                	mov    %ebx,%eax
}
801059a7:	5b                   	pop    %ebx
801059a8:	5e                   	pop    %esi
801059a9:	5d                   	pop    %ebp
801059aa:	c3                   	ret    
801059ab:	90                   	nop
801059ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059b0 <sys_read>:

int
sys_read(void)
{
801059b0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801059b1:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
801059b3:	89 e5                	mov    %esp,%ebp
801059b5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801059b8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801059bb:	e8 10 fe ff ff       	call   801057d0 <argfd.constprop.0>
801059c0:	85 c0                	test   %eax,%eax
801059c2:	78 4c                	js     80105a10 <sys_read+0x60>
801059c4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059c7:	83 ec 08             	sub    $0x8,%esp
801059ca:	50                   	push   %eax
801059cb:	6a 02                	push   $0x2
801059cd:	e8 0e fb ff ff       	call   801054e0 <argint>
801059d2:	83 c4 10             	add    $0x10,%esp
801059d5:	85 c0                	test   %eax,%eax
801059d7:	78 37                	js     80105a10 <sys_read+0x60>
801059d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059dc:	83 ec 04             	sub    $0x4,%esp
801059df:	ff 75 f0             	pushl  -0x10(%ebp)
801059e2:	50                   	push   %eax
801059e3:	6a 01                	push   $0x1
801059e5:	e8 46 fb ff ff       	call   80105530 <argptr>
801059ea:	83 c4 10             	add    $0x10,%esp
801059ed:	85 c0                	test   %eax,%eax
801059ef:	78 1f                	js     80105a10 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
801059f1:	83 ec 04             	sub    $0x4,%esp
801059f4:	ff 75 f0             	pushl  -0x10(%ebp)
801059f7:	ff 75 f4             	pushl  -0xc(%ebp)
801059fa:	ff 75 ec             	pushl  -0x14(%ebp)
801059fd:	e8 0e c3 ff ff       	call   80101d10 <fileread>
80105a02:	83 c4 10             	add    $0x10,%esp
}
80105a05:	c9                   	leave  
80105a06:	c3                   	ret    
80105a07:	89 f6                	mov    %esi,%esi
80105a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80105a10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80105a15:	c9                   	leave  
80105a16:	c3                   	ret    
80105a17:	89 f6                	mov    %esi,%esi
80105a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a20 <sys_write>:

int
sys_write(void)
{
80105a20:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105a21:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80105a23:	89 e5                	mov    %esp,%ebp
80105a25:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105a28:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105a2b:	e8 a0 fd ff ff       	call   801057d0 <argfd.constprop.0>
80105a30:	85 c0                	test   %eax,%eax
80105a32:	78 4c                	js     80105a80 <sys_write+0x60>
80105a34:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a37:	83 ec 08             	sub    $0x8,%esp
80105a3a:	50                   	push   %eax
80105a3b:	6a 02                	push   $0x2
80105a3d:	e8 9e fa ff ff       	call   801054e0 <argint>
80105a42:	83 c4 10             	add    $0x10,%esp
80105a45:	85 c0                	test   %eax,%eax
80105a47:	78 37                	js     80105a80 <sys_write+0x60>
80105a49:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a4c:	83 ec 04             	sub    $0x4,%esp
80105a4f:	ff 75 f0             	pushl  -0x10(%ebp)
80105a52:	50                   	push   %eax
80105a53:	6a 01                	push   $0x1
80105a55:	e8 d6 fa ff ff       	call   80105530 <argptr>
80105a5a:	83 c4 10             	add    $0x10,%esp
80105a5d:	85 c0                	test   %eax,%eax
80105a5f:	78 1f                	js     80105a80 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80105a61:	83 ec 04             	sub    $0x4,%esp
80105a64:	ff 75 f0             	pushl  -0x10(%ebp)
80105a67:	ff 75 f4             	pushl  -0xc(%ebp)
80105a6a:	ff 75 ec             	pushl  -0x14(%ebp)
80105a6d:	e8 2e c3 ff ff       	call   80101da0 <filewrite>
80105a72:	83 c4 10             	add    $0x10,%esp
}
80105a75:	c9                   	leave  
80105a76:	c3                   	ret    
80105a77:	89 f6                	mov    %esi,%esi
80105a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80105a80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80105a85:	c9                   	leave  
80105a86:	c3                   	ret    
80105a87:	89 f6                	mov    %esi,%esi
80105a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105a90 <sys_close>:

int
sys_close(void)
{
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80105a96:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105a99:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a9c:	e8 2f fd ff ff       	call   801057d0 <argfd.constprop.0>
80105aa1:	85 c0                	test   %eax,%eax
80105aa3:	78 2b                	js     80105ad0 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80105aa5:	e8 96 ea ff ff       	call   80104540 <myproc>
80105aaa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105aad:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80105ab0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105ab7:	00 
  fileclose(f);
80105ab8:	ff 75 f4             	pushl  -0xc(%ebp)
80105abb:	e8 30 c1 ff ff       	call   80101bf0 <fileclose>
  return 0;
80105ac0:	83 c4 10             	add    $0x10,%esp
80105ac3:	31 c0                	xor    %eax,%eax
}
80105ac5:	c9                   	leave  
80105ac6:	c3                   	ret    
80105ac7:	89 f6                	mov    %esi,%esi
80105ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80105ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80105ad5:	c9                   	leave  
80105ad6:	c3                   	ret    
80105ad7:	89 f6                	mov    %esi,%esi
80105ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ae0 <sys_fstat>:

int
sys_fstat(void)
{
80105ae0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105ae1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80105ae3:	89 e5                	mov    %esp,%ebp
80105ae5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105ae8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80105aeb:	e8 e0 fc ff ff       	call   801057d0 <argfd.constprop.0>
80105af0:	85 c0                	test   %eax,%eax
80105af2:	78 2c                	js     80105b20 <sys_fstat+0x40>
80105af4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105af7:	83 ec 04             	sub    $0x4,%esp
80105afa:	6a 14                	push   $0x14
80105afc:	50                   	push   %eax
80105afd:	6a 01                	push   $0x1
80105aff:	e8 2c fa ff ff       	call   80105530 <argptr>
80105b04:	83 c4 10             	add    $0x10,%esp
80105b07:	85 c0                	test   %eax,%eax
80105b09:	78 15                	js     80105b20 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80105b0b:	83 ec 08             	sub    $0x8,%esp
80105b0e:	ff 75 f4             	pushl  -0xc(%ebp)
80105b11:	ff 75 f0             	pushl  -0x10(%ebp)
80105b14:	e8 a7 c1 ff ff       	call   80101cc0 <filestat>
80105b19:	83 c4 10             	add    $0x10,%esp
}
80105b1c:	c9                   	leave  
80105b1d:	c3                   	ret    
80105b1e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80105b20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80105b25:	c9                   	leave  
80105b26:	c3                   	ret    
80105b27:	89 f6                	mov    %esi,%esi
80105b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b30 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105b30:	55                   	push   %ebp
80105b31:	89 e5                	mov    %esp,%ebp
80105b33:	57                   	push   %edi
80105b34:	56                   	push   %esi
80105b35:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105b36:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105b39:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105b3c:	50                   	push   %eax
80105b3d:	6a 00                	push   $0x0
80105b3f:	e8 4c fa ff ff       	call   80105590 <argstr>
80105b44:	83 c4 10             	add    $0x10,%esp
80105b47:	85 c0                	test   %eax,%eax
80105b49:	0f 88 fb 00 00 00    	js     80105c4a <sys_link+0x11a>
80105b4f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105b52:	83 ec 08             	sub    $0x8,%esp
80105b55:	50                   	push   %eax
80105b56:	6a 01                	push   $0x1
80105b58:	e8 33 fa ff ff       	call   80105590 <argstr>
80105b5d:	83 c4 10             	add    $0x10,%esp
80105b60:	85 c0                	test   %eax,%eax
80105b62:	0f 88 e2 00 00 00    	js     80105c4a <sys_link+0x11a>
    return -1;

  begin_op();
80105b68:	e8 a3 dd ff ff       	call   80103910 <begin_op>
  if((ip = namei(old)) == 0){
80105b6d:	83 ec 0c             	sub    $0xc,%esp
80105b70:	ff 75 d4             	pushl  -0x2c(%ebp)
80105b73:	e8 08 d1 ff ff       	call   80102c80 <namei>
80105b78:	83 c4 10             	add    $0x10,%esp
80105b7b:	85 c0                	test   %eax,%eax
80105b7d:	89 c3                	mov    %eax,%ebx
80105b7f:	0f 84 f3 00 00 00    	je     80105c78 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80105b85:	83 ec 0c             	sub    $0xc,%esp
80105b88:	50                   	push   %eax
80105b89:	e8 a2 c8 ff ff       	call   80102430 <ilock>
  if(ip->type == T_DIR){
80105b8e:	83 c4 10             	add    $0x10,%esp
80105b91:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105b96:	0f 84 c4 00 00 00    	je     80105c60 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80105b9c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80105ba1:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105ba4:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80105ba7:	53                   	push   %ebx
80105ba8:	e8 d3 c7 ff ff       	call   80102380 <iupdate>
  iunlock(ip);
80105bad:	89 1c 24             	mov    %ebx,(%esp)
80105bb0:	e8 5b c9 ff ff       	call   80102510 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80105bb5:	58                   	pop    %eax
80105bb6:	5a                   	pop    %edx
80105bb7:	57                   	push   %edi
80105bb8:	ff 75 d0             	pushl  -0x30(%ebp)
80105bbb:	e8 e0 d0 ff ff       	call   80102ca0 <nameiparent>
80105bc0:	83 c4 10             	add    $0x10,%esp
80105bc3:	85 c0                	test   %eax,%eax
80105bc5:	89 c6                	mov    %eax,%esi
80105bc7:	74 5b                	je     80105c24 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80105bc9:	83 ec 0c             	sub    $0xc,%esp
80105bcc:	50                   	push   %eax
80105bcd:	e8 5e c8 ff ff       	call   80102430 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105bd2:	83 c4 10             	add    $0x10,%esp
80105bd5:	8b 03                	mov    (%ebx),%eax
80105bd7:	39 06                	cmp    %eax,(%esi)
80105bd9:	75 3d                	jne    80105c18 <sys_link+0xe8>
80105bdb:	83 ec 04             	sub    $0x4,%esp
80105bde:	ff 73 04             	pushl  0x4(%ebx)
80105be1:	57                   	push   %edi
80105be2:	56                   	push   %esi
80105be3:	e8 d8 cf ff ff       	call   80102bc0 <dirlink>
80105be8:	83 c4 10             	add    $0x10,%esp
80105beb:	85 c0                	test   %eax,%eax
80105bed:	78 29                	js     80105c18 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80105bef:	83 ec 0c             	sub    $0xc,%esp
80105bf2:	56                   	push   %esi
80105bf3:	e8 c8 ca ff ff       	call   801026c0 <iunlockput>
  iput(ip);
80105bf8:	89 1c 24             	mov    %ebx,(%esp)
80105bfb:	e8 60 c9 ff ff       	call   80102560 <iput>

  end_op();
80105c00:	e8 7b dd ff ff       	call   80103980 <end_op>

  return 0;
80105c05:	83 c4 10             	add    $0x10,%esp
80105c08:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80105c0a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c0d:	5b                   	pop    %ebx
80105c0e:	5e                   	pop    %esi
80105c0f:	5f                   	pop    %edi
80105c10:	5d                   	pop    %ebp
80105c11:	c3                   	ret    
80105c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80105c18:	83 ec 0c             	sub    $0xc,%esp
80105c1b:	56                   	push   %esi
80105c1c:	e8 9f ca ff ff       	call   801026c0 <iunlockput>
    goto bad;
80105c21:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80105c24:	83 ec 0c             	sub    $0xc,%esp
80105c27:	53                   	push   %ebx
80105c28:	e8 03 c8 ff ff       	call   80102430 <ilock>
  ip->nlink--;
80105c2d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105c32:	89 1c 24             	mov    %ebx,(%esp)
80105c35:	e8 46 c7 ff ff       	call   80102380 <iupdate>
  iunlockput(ip);
80105c3a:	89 1c 24             	mov    %ebx,(%esp)
80105c3d:	e8 7e ca ff ff       	call   801026c0 <iunlockput>
  end_op();
80105c42:	e8 39 dd ff ff       	call   80103980 <end_op>
  return -1;
80105c47:	83 c4 10             	add    $0x10,%esp
}
80105c4a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80105c4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c52:	5b                   	pop    %ebx
80105c53:	5e                   	pop    %esi
80105c54:	5f                   	pop    %edi
80105c55:	5d                   	pop    %ebp
80105c56:	c3                   	ret    
80105c57:	89 f6                	mov    %esi,%esi
80105c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80105c60:	83 ec 0c             	sub    $0xc,%esp
80105c63:	53                   	push   %ebx
80105c64:	e8 57 ca ff ff       	call   801026c0 <iunlockput>
    end_op();
80105c69:	e8 12 dd ff ff       	call   80103980 <end_op>
    return -1;
80105c6e:	83 c4 10             	add    $0x10,%esp
80105c71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c76:	eb 92                	jmp    80105c0a <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80105c78:	e8 03 dd ff ff       	call   80103980 <end_op>
    return -1;
80105c7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c82:	eb 86                	jmp    80105c0a <sys_link+0xda>
80105c84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105c8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105c90 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105c90:	55                   	push   %ebp
80105c91:	89 e5                	mov    %esp,%ebp
80105c93:	57                   	push   %edi
80105c94:	56                   	push   %esi
80105c95:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105c96:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105c99:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105c9c:	50                   	push   %eax
80105c9d:	6a 00                	push   $0x0
80105c9f:	e8 ec f8 ff ff       	call   80105590 <argstr>
80105ca4:	83 c4 10             	add    $0x10,%esp
80105ca7:	85 c0                	test   %eax,%eax
80105ca9:	0f 88 7a 01 00 00    	js     80105e29 <sys_unlink+0x199>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80105caf:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80105cb2:	e8 59 dc ff ff       	call   80103910 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105cb7:	83 ec 08             	sub    $0x8,%esp
80105cba:	53                   	push   %ebx
80105cbb:	ff 75 c0             	pushl  -0x40(%ebp)
80105cbe:	e8 dd cf ff ff       	call   80102ca0 <nameiparent>
80105cc3:	83 c4 10             	add    $0x10,%esp
80105cc6:	85 c0                	test   %eax,%eax
80105cc8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105ccb:	0f 84 62 01 00 00    	je     80105e33 <sys_unlink+0x1a3>
    end_op();
    return -1;
  }

  ilock(dp);
80105cd1:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105cd4:	83 ec 0c             	sub    $0xc,%esp
80105cd7:	56                   	push   %esi
80105cd8:	e8 53 c7 ff ff       	call   80102430 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105cdd:	58                   	pop    %eax
80105cde:	5a                   	pop    %edx
80105cdf:	68 58 88 10 80       	push   $0x80108858
80105ce4:	53                   	push   %ebx
80105ce5:	e8 56 cc ff ff       	call   80102940 <namecmp>
80105cea:	83 c4 10             	add    $0x10,%esp
80105ced:	85 c0                	test   %eax,%eax
80105cef:	0f 84 f8 00 00 00    	je     80105ded <sys_unlink+0x15d>
80105cf5:	83 ec 08             	sub    $0x8,%esp
80105cf8:	68 57 88 10 80       	push   $0x80108857
80105cfd:	53                   	push   %ebx
80105cfe:	e8 3d cc ff ff       	call   80102940 <namecmp>
80105d03:	83 c4 10             	add    $0x10,%esp
80105d06:	85 c0                	test   %eax,%eax
80105d08:	0f 84 df 00 00 00    	je     80105ded <sys_unlink+0x15d>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105d0e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105d11:	83 ec 04             	sub    $0x4,%esp
80105d14:	50                   	push   %eax
80105d15:	53                   	push   %ebx
80105d16:	56                   	push   %esi
80105d17:	e8 44 cc ff ff       	call   80102960 <dirlookup>
80105d1c:	83 c4 10             	add    $0x10,%esp
80105d1f:	85 c0                	test   %eax,%eax
80105d21:	89 c3                	mov    %eax,%ebx
80105d23:	0f 84 c4 00 00 00    	je     80105ded <sys_unlink+0x15d>
    goto bad;
  ilock(ip);
80105d29:	83 ec 0c             	sub    $0xc,%esp
80105d2c:	50                   	push   %eax
80105d2d:	e8 fe c6 ff ff       	call   80102430 <ilock>

  if(ip->nlink < 1)
80105d32:	83 c4 10             	add    $0x10,%esp
80105d35:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105d3a:	0f 8e 1c 01 00 00    	jle    80105e5c <sys_unlink+0x1cc>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105d40:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105d45:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105d48:	74 66                	je     80105db0 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80105d4a:	83 ec 04             	sub    $0x4,%esp
80105d4d:	6a 10                	push   $0x10
80105d4f:	6a 00                	push   $0x0
80105d51:	56                   	push   %esi
80105d52:	e8 79 f4 ff ff       	call   801051d0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105d57:	6a 10                	push   $0x10
80105d59:	ff 75 c4             	pushl  -0x3c(%ebp)
80105d5c:	56                   	push   %esi
80105d5d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105d60:	e8 ab ca ff ff       	call   80102810 <writei>
80105d65:	83 c4 20             	add    $0x20,%esp
80105d68:	83 f8 10             	cmp    $0x10,%eax
80105d6b:	0f 85 de 00 00 00    	jne    80105e4f <sys_unlink+0x1bf>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105d71:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105d76:	0f 84 94 00 00 00    	je     80105e10 <sys_unlink+0x180>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80105d7c:	83 ec 0c             	sub    $0xc,%esp
80105d7f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105d82:	e8 39 c9 ff ff       	call   801026c0 <iunlockput>

  ip->nlink--;
80105d87:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105d8c:	89 1c 24             	mov    %ebx,(%esp)
80105d8f:	e8 ec c5 ff ff       	call   80102380 <iupdate>
  iunlockput(ip);
80105d94:	89 1c 24             	mov    %ebx,(%esp)
80105d97:	e8 24 c9 ff ff       	call   801026c0 <iunlockput>

  end_op();
80105d9c:	e8 df db ff ff       	call   80103980 <end_op>

  return 0;
80105da1:	83 c4 10             	add    $0x10,%esp
80105da4:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105da6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105da9:	5b                   	pop    %ebx
80105daa:	5e                   	pop    %esi
80105dab:	5f                   	pop    %edi
80105dac:	5d                   	pop    %ebp
80105dad:	c3                   	ret    
80105dae:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105db0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105db4:	76 94                	jbe    80105d4a <sys_unlink+0xba>
80105db6:	bf 20 00 00 00       	mov    $0x20,%edi
80105dbb:	eb 0b                	jmp    80105dc8 <sys_unlink+0x138>
80105dbd:	8d 76 00             	lea    0x0(%esi),%esi
80105dc0:	83 c7 10             	add    $0x10,%edi
80105dc3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105dc6:	73 82                	jae    80105d4a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105dc8:	6a 10                	push   $0x10
80105dca:	57                   	push   %edi
80105dcb:	56                   	push   %esi
80105dcc:	53                   	push   %ebx
80105dcd:	e8 3e c9 ff ff       	call   80102710 <readi>
80105dd2:	83 c4 10             	add    $0x10,%esp
80105dd5:	83 f8 10             	cmp    $0x10,%eax
80105dd8:	75 68                	jne    80105e42 <sys_unlink+0x1b2>
      panic("isdirempty: readi");
    if(de.inum != 0)
80105dda:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105ddf:	74 df                	je     80105dc0 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80105de1:	83 ec 0c             	sub    $0xc,%esp
80105de4:	53                   	push   %ebx
80105de5:	e8 d6 c8 ff ff       	call   801026c0 <iunlockput>
    goto bad;
80105dea:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105ded:	83 ec 0c             	sub    $0xc,%esp
80105df0:	ff 75 b4             	pushl  -0x4c(%ebp)
80105df3:	e8 c8 c8 ff ff       	call   801026c0 <iunlockput>
  end_op();
80105df8:	e8 83 db ff ff       	call   80103980 <end_op>
  return -1;
80105dfd:	83 c4 10             	add    $0x10,%esp
}
80105e00:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80105e03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e08:	5b                   	pop    %ebx
80105e09:	5e                   	pop    %esi
80105e0a:	5f                   	pop    %edi
80105e0b:	5d                   	pop    %ebp
80105e0c:	c3                   	ret    
80105e0d:	8d 76 00             	lea    0x0(%esi),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105e10:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105e13:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105e16:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105e1b:	50                   	push   %eax
80105e1c:	e8 5f c5 ff ff       	call   80102380 <iupdate>
80105e21:	83 c4 10             	add    $0x10,%esp
80105e24:	e9 53 ff ff ff       	jmp    80105d7c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105e29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e2e:	e9 73 ff ff ff       	jmp    80105da6 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
80105e33:	e8 48 db ff ff       	call   80103980 <end_op>
    return -1;
80105e38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e3d:	e9 64 ff ff ff       	jmp    80105da6 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
80105e42:	83 ec 0c             	sub    $0xc,%esp
80105e45:	68 7c 88 10 80       	push   $0x8010887c
80105e4a:	e8 71 a9 ff ff       	call   801007c0 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105e4f:	83 ec 0c             	sub    $0xc,%esp
80105e52:	68 8e 88 10 80       	push   $0x8010888e
80105e57:	e8 64 a9 ff ff       	call   801007c0 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105e5c:	83 ec 0c             	sub    $0xc,%esp
80105e5f:	68 6a 88 10 80       	push   $0x8010886a
80105e64:	e8 57 a9 ff ff       	call   801007c0 <panic>
80105e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e70 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105e70:	55                   	push   %ebp
80105e71:	89 e5                	mov    %esp,%ebp
80105e73:	57                   	push   %edi
80105e74:	56                   	push   %esi
80105e75:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105e76:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105e79:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105e7c:	50                   	push   %eax
80105e7d:	6a 00                	push   $0x0
80105e7f:	e8 0c f7 ff ff       	call   80105590 <argstr>
80105e84:	83 c4 10             	add    $0x10,%esp
80105e87:	85 c0                	test   %eax,%eax
80105e89:	0f 88 9e 00 00 00    	js     80105f2d <sys_open+0xbd>
80105e8f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105e92:	83 ec 08             	sub    $0x8,%esp
80105e95:	50                   	push   %eax
80105e96:	6a 01                	push   $0x1
80105e98:	e8 43 f6 ff ff       	call   801054e0 <argint>
80105e9d:	83 c4 10             	add    $0x10,%esp
80105ea0:	85 c0                	test   %eax,%eax
80105ea2:	0f 88 85 00 00 00    	js     80105f2d <sys_open+0xbd>
    return -1;

  begin_op();
80105ea8:	e8 63 da ff ff       	call   80103910 <begin_op>

  if(omode & O_CREATE){
80105ead:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105eb1:	0f 85 89 00 00 00    	jne    80105f40 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105eb7:	83 ec 0c             	sub    $0xc,%esp
80105eba:	ff 75 e0             	pushl  -0x20(%ebp)
80105ebd:	e8 be cd ff ff       	call   80102c80 <namei>
80105ec2:	83 c4 10             	add    $0x10,%esp
80105ec5:	85 c0                	test   %eax,%eax
80105ec7:	89 c6                	mov    %eax,%esi
80105ec9:	0f 84 8e 00 00 00    	je     80105f5d <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
80105ecf:	83 ec 0c             	sub    $0xc,%esp
80105ed2:	50                   	push   %eax
80105ed3:	e8 58 c5 ff ff       	call   80102430 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105ed8:	83 c4 10             	add    $0x10,%esp
80105edb:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105ee0:	0f 84 d2 00 00 00    	je     80105fb8 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105ee6:	e8 45 bc ff ff       	call   80101b30 <filealloc>
80105eeb:	85 c0                	test   %eax,%eax
80105eed:	89 c7                	mov    %eax,%edi
80105eef:	74 2b                	je     80105f1c <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105ef1:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105ef3:	e8 48 e6 ff ff       	call   80104540 <myproc>
80105ef8:	90                   	nop
80105ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105f00:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105f04:	85 d2                	test   %edx,%edx
80105f06:	74 68                	je     80105f70 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105f08:	83 c3 01             	add    $0x1,%ebx
80105f0b:	83 fb 10             	cmp    $0x10,%ebx
80105f0e:	75 f0                	jne    80105f00 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105f10:	83 ec 0c             	sub    $0xc,%esp
80105f13:	57                   	push   %edi
80105f14:	e8 d7 bc ff ff       	call   80101bf0 <fileclose>
80105f19:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105f1c:	83 ec 0c             	sub    $0xc,%esp
80105f1f:	56                   	push   %esi
80105f20:	e8 9b c7 ff ff       	call   801026c0 <iunlockput>
    end_op();
80105f25:	e8 56 da ff ff       	call   80103980 <end_op>
    return -1;
80105f2a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105f2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105f30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105f35:	5b                   	pop    %ebx
80105f36:	5e                   	pop    %esi
80105f37:	5f                   	pop    %edi
80105f38:	5d                   	pop    %ebp
80105f39:	c3                   	ret    
80105f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105f40:	83 ec 0c             	sub    $0xc,%esp
80105f43:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105f46:	31 c9                	xor    %ecx,%ecx
80105f48:	6a 00                	push   $0x0
80105f4a:	ba 02 00 00 00       	mov    $0x2,%edx
80105f4f:	e8 dc f6 ff ff       	call   80105630 <create>
    if(ip == 0){
80105f54:	83 c4 10             	add    $0x10,%esp
80105f57:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105f59:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105f5b:	75 89                	jne    80105ee6 <sys_open+0x76>
      end_op();
80105f5d:	e8 1e da ff ff       	call   80103980 <end_op>
      return -1;
80105f62:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f67:	eb 43                	jmp    80105fac <sys_open+0x13c>
80105f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105f70:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105f73:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105f77:	56                   	push   %esi
80105f78:	e8 93 c5 ff ff       	call   80102510 <iunlock>
  end_op();
80105f7d:	e8 fe d9 ff ff       	call   80103980 <end_op>

  f->type = FD_INODE;
80105f82:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105f88:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105f8b:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
80105f8e:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105f91:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105f98:	89 d0                	mov    %edx,%eax
80105f9a:	83 e0 01             	and    $0x1,%eax
80105f9d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105fa0:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105fa3:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105fa6:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
80105faa:	89 d8                	mov    %ebx,%eax
}
80105fac:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105faf:	5b                   	pop    %ebx
80105fb0:	5e                   	pop    %esi
80105fb1:	5f                   	pop    %edi
80105fb2:	5d                   	pop    %ebp
80105fb3:	c3                   	ret    
80105fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105fb8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105fbb:	85 c9                	test   %ecx,%ecx
80105fbd:	0f 84 23 ff ff ff    	je     80105ee6 <sys_open+0x76>
80105fc3:	e9 54 ff ff ff       	jmp    80105f1c <sys_open+0xac>
80105fc8:	90                   	nop
80105fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105fd0 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105fd0:	55                   	push   %ebp
80105fd1:	89 e5                	mov    %esp,%ebp
80105fd3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105fd6:	e8 35 d9 ff ff       	call   80103910 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105fdb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fde:	83 ec 08             	sub    $0x8,%esp
80105fe1:	50                   	push   %eax
80105fe2:	6a 00                	push   $0x0
80105fe4:	e8 a7 f5 ff ff       	call   80105590 <argstr>
80105fe9:	83 c4 10             	add    $0x10,%esp
80105fec:	85 c0                	test   %eax,%eax
80105fee:	78 30                	js     80106020 <sys_mkdir+0x50>
80105ff0:	83 ec 0c             	sub    $0xc,%esp
80105ff3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ff6:	31 c9                	xor    %ecx,%ecx
80105ff8:	6a 00                	push   $0x0
80105ffa:	ba 01 00 00 00       	mov    $0x1,%edx
80105fff:	e8 2c f6 ff ff       	call   80105630 <create>
80106004:	83 c4 10             	add    $0x10,%esp
80106007:	85 c0                	test   %eax,%eax
80106009:	74 15                	je     80106020 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010600b:	83 ec 0c             	sub    $0xc,%esp
8010600e:	50                   	push   %eax
8010600f:	e8 ac c6 ff ff       	call   801026c0 <iunlockput>
  end_op();
80106014:	e8 67 d9 ff ff       	call   80103980 <end_op>
  return 0;
80106019:	83 c4 10             	add    $0x10,%esp
8010601c:	31 c0                	xor    %eax,%eax
}
8010601e:	c9                   	leave  
8010601f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80106020:	e8 5b d9 ff ff       	call   80103980 <end_op>
    return -1;
80106025:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010602a:	c9                   	leave  
8010602b:	c3                   	ret    
8010602c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106030 <sys_mknod>:

int
sys_mknod(void)
{
80106030:	55                   	push   %ebp
80106031:	89 e5                	mov    %esp,%ebp
80106033:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106036:	e8 d5 d8 ff ff       	call   80103910 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010603b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010603e:	83 ec 08             	sub    $0x8,%esp
80106041:	50                   	push   %eax
80106042:	6a 00                	push   $0x0
80106044:	e8 47 f5 ff ff       	call   80105590 <argstr>
80106049:	83 c4 10             	add    $0x10,%esp
8010604c:	85 c0                	test   %eax,%eax
8010604e:	78 60                	js     801060b0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106050:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106053:	83 ec 08             	sub    $0x8,%esp
80106056:	50                   	push   %eax
80106057:	6a 01                	push   $0x1
80106059:	e8 82 f4 ff ff       	call   801054e0 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010605e:	83 c4 10             	add    $0x10,%esp
80106061:	85 c0                	test   %eax,%eax
80106063:	78 4b                	js     801060b0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106065:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106068:	83 ec 08             	sub    $0x8,%esp
8010606b:	50                   	push   %eax
8010606c:	6a 02                	push   $0x2
8010606e:	e8 6d f4 ff ff       	call   801054e0 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80106073:	83 c4 10             	add    $0x10,%esp
80106076:	85 c0                	test   %eax,%eax
80106078:	78 36                	js     801060b0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010607a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010607e:	83 ec 0c             	sub    $0xc,%esp
80106081:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80106085:	ba 03 00 00 00       	mov    $0x3,%edx
8010608a:	50                   	push   %eax
8010608b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010608e:	e8 9d f5 ff ff       	call   80105630 <create>
80106093:	83 c4 10             	add    $0x10,%esp
80106096:	85 c0                	test   %eax,%eax
80106098:	74 16                	je     801060b0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010609a:	83 ec 0c             	sub    $0xc,%esp
8010609d:	50                   	push   %eax
8010609e:	e8 1d c6 ff ff       	call   801026c0 <iunlockput>
  end_op();
801060a3:	e8 d8 d8 ff ff       	call   80103980 <end_op>
  return 0;
801060a8:	83 c4 10             	add    $0x10,%esp
801060ab:	31 c0                	xor    %eax,%eax
}
801060ad:	c9                   	leave  
801060ae:	c3                   	ret    
801060af:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801060b0:	e8 cb d8 ff ff       	call   80103980 <end_op>
    return -1;
801060b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801060ba:	c9                   	leave  
801060bb:	c3                   	ret    
801060bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801060c0 <sys_chdir>:

int
sys_chdir(void)
{
801060c0:	55                   	push   %ebp
801060c1:	89 e5                	mov    %esp,%ebp
801060c3:	56                   	push   %esi
801060c4:	53                   	push   %ebx
801060c5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801060c8:	e8 73 e4 ff ff       	call   80104540 <myproc>
801060cd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801060cf:	e8 3c d8 ff ff       	call   80103910 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801060d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060d7:	83 ec 08             	sub    $0x8,%esp
801060da:	50                   	push   %eax
801060db:	6a 00                	push   $0x0
801060dd:	e8 ae f4 ff ff       	call   80105590 <argstr>
801060e2:	83 c4 10             	add    $0x10,%esp
801060e5:	85 c0                	test   %eax,%eax
801060e7:	78 77                	js     80106160 <sys_chdir+0xa0>
801060e9:	83 ec 0c             	sub    $0xc,%esp
801060ec:	ff 75 f4             	pushl  -0xc(%ebp)
801060ef:	e8 8c cb ff ff       	call   80102c80 <namei>
801060f4:	83 c4 10             	add    $0x10,%esp
801060f7:	85 c0                	test   %eax,%eax
801060f9:	89 c3                	mov    %eax,%ebx
801060fb:	74 63                	je     80106160 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801060fd:	83 ec 0c             	sub    $0xc,%esp
80106100:	50                   	push   %eax
80106101:	e8 2a c3 ff ff       	call   80102430 <ilock>
  if(ip->type != T_DIR){
80106106:	83 c4 10             	add    $0x10,%esp
80106109:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010610e:	75 30                	jne    80106140 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106110:	83 ec 0c             	sub    $0xc,%esp
80106113:	53                   	push   %ebx
80106114:	e8 f7 c3 ff ff       	call   80102510 <iunlock>
  iput(curproc->cwd);
80106119:	58                   	pop    %eax
8010611a:	ff 76 68             	pushl  0x68(%esi)
8010611d:	e8 3e c4 ff ff       	call   80102560 <iput>
  end_op();
80106122:	e8 59 d8 ff ff       	call   80103980 <end_op>
  curproc->cwd = ip;
80106127:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010612a:	83 c4 10             	add    $0x10,%esp
8010612d:	31 c0                	xor    %eax,%eax
}
8010612f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106132:	5b                   	pop    %ebx
80106133:	5e                   	pop    %esi
80106134:	5d                   	pop    %ebp
80106135:	c3                   	ret    
80106136:	8d 76 00             	lea    0x0(%esi),%esi
80106139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80106140:	83 ec 0c             	sub    $0xc,%esp
80106143:	53                   	push   %ebx
80106144:	e8 77 c5 ff ff       	call   801026c0 <iunlockput>
    end_op();
80106149:	e8 32 d8 ff ff       	call   80103980 <end_op>
    return -1;
8010614e:	83 c4 10             	add    $0x10,%esp
80106151:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106156:	eb d7                	jmp    8010612f <sys_chdir+0x6f>
80106158:	90                   	nop
80106159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80106160:	e8 1b d8 ff ff       	call   80103980 <end_op>
    return -1;
80106165:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010616a:	eb c3                	jmp    8010612f <sys_chdir+0x6f>
8010616c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106170 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80106170:	55                   	push   %ebp
80106171:	89 e5                	mov    %esp,%ebp
80106173:	57                   	push   %edi
80106174:	56                   	push   %esi
80106175:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106176:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010617c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106182:	50                   	push   %eax
80106183:	6a 00                	push   $0x0
80106185:	e8 06 f4 ff ff       	call   80105590 <argstr>
8010618a:	83 c4 10             	add    $0x10,%esp
8010618d:	85 c0                	test   %eax,%eax
8010618f:	78 7f                	js     80106210 <sys_exec+0xa0>
80106191:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106197:	83 ec 08             	sub    $0x8,%esp
8010619a:	50                   	push   %eax
8010619b:	6a 01                	push   $0x1
8010619d:	e8 3e f3 ff ff       	call   801054e0 <argint>
801061a2:	83 c4 10             	add    $0x10,%esp
801061a5:	85 c0                	test   %eax,%eax
801061a7:	78 67                	js     80106210 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801061a9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801061af:	83 ec 04             	sub    $0x4,%esp
801061b2:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801061b8:	68 80 00 00 00       	push   $0x80
801061bd:	6a 00                	push   $0x0
801061bf:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801061c5:	50                   	push   %eax
801061c6:	31 db                	xor    %ebx,%ebx
801061c8:	e8 03 f0 ff ff       	call   801051d0 <memset>
801061cd:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801061d0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801061d6:	83 ec 08             	sub    $0x8,%esp
801061d9:	57                   	push   %edi
801061da:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801061dd:	50                   	push   %eax
801061de:	e8 5d f2 ff ff       	call   80105440 <fetchint>
801061e3:	83 c4 10             	add    $0x10,%esp
801061e6:	85 c0                	test   %eax,%eax
801061e8:	78 26                	js     80106210 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
801061ea:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801061f0:	85 c0                	test   %eax,%eax
801061f2:	74 2c                	je     80106220 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801061f4:	83 ec 08             	sub    $0x8,%esp
801061f7:	56                   	push   %esi
801061f8:	50                   	push   %eax
801061f9:	e8 82 f2 ff ff       	call   80105480 <fetchstr>
801061fe:	83 c4 10             	add    $0x10,%esp
80106201:	85 c0                	test   %eax,%eax
80106203:	78 0b                	js     80106210 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80106205:	83 c3 01             	add    $0x1,%ebx
80106208:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010620b:	83 fb 20             	cmp    $0x20,%ebx
8010620e:	75 c0                	jne    801061d0 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80106210:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80106213:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80106218:	5b                   	pop    %ebx
80106219:	5e                   	pop    %esi
8010621a:	5f                   	pop    %edi
8010621b:	5d                   	pop    %ebp
8010621c:	c3                   	ret    
8010621d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106220:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106226:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80106229:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106230:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106234:	50                   	push   %eax
80106235:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010623b:	e8 70 b5 ff ff       	call   801017b0 <exec>
80106240:	83 c4 10             	add    $0x10,%esp
}
80106243:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106246:	5b                   	pop    %ebx
80106247:	5e                   	pop    %esi
80106248:	5f                   	pop    %edi
80106249:	5d                   	pop    %ebp
8010624a:	c3                   	ret    
8010624b:	90                   	nop
8010624c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106250 <sys_pipe>:

int
sys_pipe(void)
{
80106250:	55                   	push   %ebp
80106251:	89 e5                	mov    %esp,%ebp
80106253:	57                   	push   %edi
80106254:	56                   	push   %esi
80106255:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106256:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80106259:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010625c:	6a 08                	push   $0x8
8010625e:	50                   	push   %eax
8010625f:	6a 00                	push   $0x0
80106261:	e8 ca f2 ff ff       	call   80105530 <argptr>
80106266:	83 c4 10             	add    $0x10,%esp
80106269:	85 c0                	test   %eax,%eax
8010626b:	78 4a                	js     801062b7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010626d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106270:	83 ec 08             	sub    $0x8,%esp
80106273:	50                   	push   %eax
80106274:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106277:	50                   	push   %eax
80106278:	e8 33 dd ff ff       	call   80103fb0 <pipealloc>
8010627d:	83 c4 10             	add    $0x10,%esp
80106280:	85 c0                	test   %eax,%eax
80106282:	78 33                	js     801062b7 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106284:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106286:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80106289:	e8 b2 e2 ff ff       	call   80104540 <myproc>
8010628e:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80106290:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106294:	85 f6                	test   %esi,%esi
80106296:	74 30                	je     801062c8 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106298:	83 c3 01             	add    $0x1,%ebx
8010629b:	83 fb 10             	cmp    $0x10,%ebx
8010629e:	75 f0                	jne    80106290 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801062a0:	83 ec 0c             	sub    $0xc,%esp
801062a3:	ff 75 e0             	pushl  -0x20(%ebp)
801062a6:	e8 45 b9 ff ff       	call   80101bf0 <fileclose>
    fileclose(wf);
801062ab:	58                   	pop    %eax
801062ac:	ff 75 e4             	pushl  -0x1c(%ebp)
801062af:	e8 3c b9 ff ff       	call   80101bf0 <fileclose>
    return -1;
801062b4:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801062b7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
801062ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801062bf:	5b                   	pop    %ebx
801062c0:	5e                   	pop    %esi
801062c1:	5f                   	pop    %edi
801062c2:	5d                   	pop    %ebp
801062c3:	c3                   	ret    
801062c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801062c8:	8d 73 08             	lea    0x8(%ebx),%esi
801062cb:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801062cf:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801062d2:	e8 69 e2 ff ff       	call   80104540 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
801062d7:	31 d2                	xor    %edx,%edx
801062d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801062e0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801062e4:	85 c9                	test   %ecx,%ecx
801062e6:	74 18                	je     80106300 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801062e8:	83 c2 01             	add    $0x1,%edx
801062eb:	83 fa 10             	cmp    $0x10,%edx
801062ee:	75 f0                	jne    801062e0 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801062f0:	e8 4b e2 ff ff       	call   80104540 <myproc>
801062f5:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801062fc:	00 
801062fd:	eb a1                	jmp    801062a0 <sys_pipe+0x50>
801062ff:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80106300:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106304:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106307:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106309:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010630c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
8010630f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80106312:	31 c0                	xor    %eax,%eax
}
80106314:	5b                   	pop    %ebx
80106315:	5e                   	pop    %esi
80106316:	5f                   	pop    %edi
80106317:	5d                   	pop    %ebp
80106318:	c3                   	ret    
80106319:	66 90                	xchg   %ax,%ax
8010631b:	66 90                	xchg   %ax,%ax
8010631d:	66 90                	xchg   %ax,%ax
8010631f:	90                   	nop

80106320 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106320:	55                   	push   %ebp
80106321:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106323:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106324:	e9 b7 e3 ff ff       	jmp    801046e0 <fork>
80106329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106330 <sys_exit>:
}

int
sys_exit(void)
{
80106330:	55                   	push   %ebp
80106331:	89 e5                	mov    %esp,%ebp
80106333:	83 ec 08             	sub    $0x8,%esp
  exit();
80106336:	e8 35 e6 ff ff       	call   80104970 <exit>
  return 0;  // not reached
}
8010633b:	31 c0                	xor    %eax,%eax
8010633d:	c9                   	leave  
8010633e:	c3                   	ret    
8010633f:	90                   	nop

80106340 <sys_wait>:

int
sys_wait(void)
{
80106340:	55                   	push   %ebp
80106341:	89 e5                	mov    %esp,%ebp
  return wait();
}
80106343:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80106344:	e9 67 e8 ff ff       	jmp    80104bb0 <wait>
80106349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106350 <sys_kill>:
}

int
sys_kill(void)
{
80106350:	55                   	push   %ebp
80106351:	89 e5                	mov    %esp,%ebp
80106353:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106356:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106359:	50                   	push   %eax
8010635a:	6a 00                	push   $0x0
8010635c:	e8 7f f1 ff ff       	call   801054e0 <argint>
80106361:	83 c4 10             	add    $0x10,%esp
80106364:	85 c0                	test   %eax,%eax
80106366:	78 18                	js     80106380 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106368:	83 ec 0c             	sub    $0xc,%esp
8010636b:	ff 75 f4             	pushl  -0xc(%ebp)
8010636e:	e8 8d e9 ff ff       	call   80104d00 <kill>
80106373:	83 c4 10             	add    $0x10,%esp
}
80106376:	c9                   	leave  
80106377:	c3                   	ret    
80106378:	90                   	nop
80106379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80106380:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80106385:	c9                   	leave  
80106386:	c3                   	ret    
80106387:	89 f6                	mov    %esi,%esi
80106389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106390 <sys_getpid>:

int
sys_getpid(void)
{
80106390:	55                   	push   %ebp
80106391:	89 e5                	mov    %esp,%ebp
80106393:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106396:	e8 a5 e1 ff ff       	call   80104540 <myproc>
8010639b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010639e:	c9                   	leave  
8010639f:	c3                   	ret    

801063a0 <sys_sbrk>:

int
sys_sbrk(void)
{
801063a0:	55                   	push   %ebp
801063a1:	89 e5                	mov    %esp,%ebp
801063a3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801063a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
801063a7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801063aa:	50                   	push   %eax
801063ab:	6a 00                	push   $0x0
801063ad:	e8 2e f1 ff ff       	call   801054e0 <argint>
801063b2:	83 c4 10             	add    $0x10,%esp
801063b5:	85 c0                	test   %eax,%eax
801063b7:	78 27                	js     801063e0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801063b9:	e8 82 e1 ff ff       	call   80104540 <myproc>
  if(growproc(n) < 0)
801063be:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
801063c1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801063c3:	ff 75 f4             	pushl  -0xc(%ebp)
801063c6:	e8 95 e2 ff ff       	call   80104660 <growproc>
801063cb:	83 c4 10             	add    $0x10,%esp
801063ce:	85 c0                	test   %eax,%eax
801063d0:	78 0e                	js     801063e0 <sys_sbrk+0x40>
    return -1;
  return addr;
801063d2:	89 d8                	mov    %ebx,%eax
}
801063d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801063d7:	c9                   	leave  
801063d8:	c3                   	ret    
801063d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
801063e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063e5:	eb ed                	jmp    801063d4 <sys_sbrk+0x34>
801063e7:	89 f6                	mov    %esi,%esi
801063e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801063f0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
801063f0:	55                   	push   %ebp
801063f1:	89 e5                	mov    %esp,%ebp
801063f3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801063f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
801063f7:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801063fa:	50                   	push   %eax
801063fb:	6a 00                	push   $0x0
801063fd:	e8 de f0 ff ff       	call   801054e0 <argint>
80106402:	83 c4 10             	add    $0x10,%esp
80106405:	85 c0                	test   %eax,%eax
80106407:	0f 88 8a 00 00 00    	js     80106497 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010640d:	83 ec 0c             	sub    $0xc,%esp
80106410:	68 00 70 12 80       	push   $0x80127000
80106415:	e8 46 ec ff ff       	call   80105060 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010641a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010641d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80106420:	8b 1d 40 78 12 80    	mov    0x80127840,%ebx
  while(ticks - ticks0 < n){
80106426:	85 d2                	test   %edx,%edx
80106428:	75 27                	jne    80106451 <sys_sleep+0x61>
8010642a:	eb 54                	jmp    80106480 <sys_sleep+0x90>
8010642c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106430:	83 ec 08             	sub    $0x8,%esp
80106433:	68 00 70 12 80       	push   $0x80127000
80106438:	68 40 78 12 80       	push   $0x80127840
8010643d:	e8 ae e6 ff ff       	call   80104af0 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106442:	a1 40 78 12 80       	mov    0x80127840,%eax
80106447:	83 c4 10             	add    $0x10,%esp
8010644a:	29 d8                	sub    %ebx,%eax
8010644c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010644f:	73 2f                	jae    80106480 <sys_sleep+0x90>
    if(myproc()->killed){
80106451:	e8 ea e0 ff ff       	call   80104540 <myproc>
80106456:	8b 40 24             	mov    0x24(%eax),%eax
80106459:	85 c0                	test   %eax,%eax
8010645b:	74 d3                	je     80106430 <sys_sleep+0x40>
      release(&tickslock);
8010645d:	83 ec 0c             	sub    $0xc,%esp
80106460:	68 00 70 12 80       	push   $0x80127000
80106465:	e8 16 ed ff ff       	call   80105180 <release>
      return -1;
8010646a:	83 c4 10             	add    $0x10,%esp
8010646d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80106472:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106475:	c9                   	leave  
80106476:	c3                   	ret    
80106477:	89 f6                	mov    %esi,%esi
80106479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80106480:	83 ec 0c             	sub    $0xc,%esp
80106483:	68 00 70 12 80       	push   $0x80127000
80106488:	e8 f3 ec ff ff       	call   80105180 <release>
  return 0;
8010648d:	83 c4 10             	add    $0x10,%esp
80106490:	31 c0                	xor    %eax,%eax
}
80106492:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106495:	c9                   	leave  
80106496:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80106497:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010649c:	eb d4                	jmp    80106472 <sys_sleep+0x82>
8010649e:	66 90                	xchg   %ax,%ax

801064a0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801064a0:	55                   	push   %ebp
801064a1:	89 e5                	mov    %esp,%ebp
801064a3:	53                   	push   %ebx
801064a4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801064a7:	68 00 70 12 80       	push   $0x80127000
801064ac:	e8 af eb ff ff       	call   80105060 <acquire>
  xticks = ticks;
801064b1:	8b 1d 40 78 12 80    	mov    0x80127840,%ebx
  release(&tickslock);
801064b7:	c7 04 24 00 70 12 80 	movl   $0x80127000,(%esp)
801064be:	e8 bd ec ff ff       	call   80105180 <release>
  return xticks;
}
801064c3:	89 d8                	mov    %ebx,%eax
801064c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801064c8:	c9                   	leave  
801064c9:	c3                   	ret    

801064ca <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801064ca:	1e                   	push   %ds
  pushl %es
801064cb:	06                   	push   %es
  pushl %fs
801064cc:	0f a0                	push   %fs
  pushl %gs
801064ce:	0f a8                	push   %gs
  pushal
801064d0:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
801064d1:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801064d5:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801064d7:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801064d9:	54                   	push   %esp
  call trap
801064da:	e8 e1 00 00 00       	call   801065c0 <trap>
  addl $4, %esp
801064df:	83 c4 04             	add    $0x4,%esp

801064e2 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801064e2:	61                   	popa   
  popl %gs
801064e3:	0f a9                	pop    %gs
  popl %fs
801064e5:	0f a1                	pop    %fs
  popl %es
801064e7:	07                   	pop    %es
  popl %ds
801064e8:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801064e9:	83 c4 08             	add    $0x8,%esp
  iret
801064ec:	cf                   	iret   
801064ed:	66 90                	xchg   %ax,%ax
801064ef:	90                   	nop

801064f0 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801064f0:	31 c0                	xor    %eax,%eax
801064f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801064f8:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
801064ff:	b9 08 00 00 00       	mov    $0x8,%ecx
80106504:	c6 04 c5 44 70 12 80 	movb   $0x0,-0x7fed8fbc(,%eax,8)
8010650b:	00 
8010650c:	66 89 0c c5 42 70 12 	mov    %cx,-0x7fed8fbe(,%eax,8)
80106513:	80 
80106514:	c6 04 c5 45 70 12 80 	movb   $0x8e,-0x7fed8fbb(,%eax,8)
8010651b:	8e 
8010651c:	66 89 14 c5 40 70 12 	mov    %dx,-0x7fed8fc0(,%eax,8)
80106523:	80 
80106524:	c1 ea 10             	shr    $0x10,%edx
80106527:	66 89 14 c5 46 70 12 	mov    %dx,-0x7fed8fba(,%eax,8)
8010652e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010652f:	83 c0 01             	add    $0x1,%eax
80106532:	3d 00 01 00 00       	cmp    $0x100,%eax
80106537:	75 bf                	jne    801064f8 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106539:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010653a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010653f:	89 e5                	mov    %esp,%ebp
80106541:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106544:	a1 08 b1 10 80       	mov    0x8010b108,%eax

  initlock(&tickslock, "time");
80106549:	68 9d 88 10 80       	push   $0x8010889d
8010654e:	68 00 70 12 80       	push   $0x80127000
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106553:	66 89 15 42 72 12 80 	mov    %dx,0x80127242
8010655a:	c6 05 44 72 12 80 00 	movb   $0x0,0x80127244
80106561:	66 a3 40 72 12 80    	mov    %ax,0x80127240
80106567:	c1 e8 10             	shr    $0x10,%eax
8010656a:	c6 05 45 72 12 80 ef 	movb   $0xef,0x80127245
80106571:	66 a3 46 72 12 80    	mov    %ax,0x80127246

  initlock(&tickslock, "time");
80106577:	e8 e4 e9 ff ff       	call   80104f60 <initlock>
}
8010657c:	83 c4 10             	add    $0x10,%esp
8010657f:	c9                   	leave  
80106580:	c3                   	ret    
80106581:	eb 0d                	jmp    80106590 <idtinit>
80106583:	90                   	nop
80106584:	90                   	nop
80106585:	90                   	nop
80106586:	90                   	nop
80106587:	90                   	nop
80106588:	90                   	nop
80106589:	90                   	nop
8010658a:	90                   	nop
8010658b:	90                   	nop
8010658c:	90                   	nop
8010658d:	90                   	nop
8010658e:	90                   	nop
8010658f:	90                   	nop

80106590 <idtinit>:

void
idtinit(void)
{
80106590:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106591:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106596:	89 e5                	mov    %esp,%ebp
80106598:	83 ec 10             	sub    $0x10,%esp
8010659b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010659f:	b8 40 70 12 80       	mov    $0x80127040,%eax
801065a4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801065a8:	c1 e8 10             	shr    $0x10,%eax
801065ab:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801065af:	8d 45 fa             	lea    -0x6(%ebp),%eax
801065b2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801065b5:	c9                   	leave  
801065b6:	c3                   	ret    
801065b7:	89 f6                	mov    %esi,%esi
801065b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801065c0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801065c0:	55                   	push   %ebp
801065c1:	89 e5                	mov    %esp,%ebp
801065c3:	57                   	push   %edi
801065c4:	56                   	push   %esi
801065c5:	53                   	push   %ebx
801065c6:	83 ec 1c             	sub    $0x1c,%esp
801065c9:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
801065cc:	8b 47 30             	mov    0x30(%edi),%eax
801065cf:	83 f8 40             	cmp    $0x40,%eax
801065d2:	0f 84 88 01 00 00    	je     80106760 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801065d8:	83 e8 20             	sub    $0x20,%eax
801065db:	83 f8 1f             	cmp    $0x1f,%eax
801065de:	77 10                	ja     801065f0 <trap+0x30>
801065e0:	ff 24 85 44 89 10 80 	jmp    *-0x7fef76bc(,%eax,4)
801065e7:	89 f6                	mov    %esi,%esi
801065e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801065f0:	e8 4b df ff ff       	call   80104540 <myproc>
801065f5:	85 c0                	test   %eax,%eax
801065f7:	0f 84 d7 01 00 00    	je     801067d4 <trap+0x214>
801065fd:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80106601:	0f 84 cd 01 00 00    	je     801067d4 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106607:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010660a:	8b 57 38             	mov    0x38(%edi),%edx
8010660d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80106610:	89 55 dc             	mov    %edx,-0x24(%ebp)
80106613:	e8 08 df ff ff       	call   80104520 <cpuid>
80106618:	8b 77 34             	mov    0x34(%edi),%esi
8010661b:	8b 5f 30             	mov    0x30(%edi),%ebx
8010661e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106621:	e8 1a df ff ff       	call   80104540 <myproc>
80106626:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106629:	e8 12 df ff ff       	call   80104540 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010662e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106631:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106634:	51                   	push   %ecx
80106635:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106636:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106639:	ff 75 e4             	pushl  -0x1c(%ebp)
8010663c:	56                   	push   %esi
8010663d:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010663e:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106641:	52                   	push   %edx
80106642:	ff 70 10             	pushl  0x10(%eax)
80106645:	68 00 89 10 80       	push   $0x80108900
8010664a:	e8 e1 9f ff ff       	call   80100630 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010664f:	83 c4 20             	add    $0x20,%esp
80106652:	e8 e9 de ff ff       	call   80104540 <myproc>
80106657:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010665e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106660:	e8 db de ff ff       	call   80104540 <myproc>
80106665:	85 c0                	test   %eax,%eax
80106667:	74 0c                	je     80106675 <trap+0xb5>
80106669:	e8 d2 de ff ff       	call   80104540 <myproc>
8010666e:	8b 50 24             	mov    0x24(%eax),%edx
80106671:	85 d2                	test   %edx,%edx
80106673:	75 4b                	jne    801066c0 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106675:	e8 c6 de ff ff       	call   80104540 <myproc>
8010667a:	85 c0                	test   %eax,%eax
8010667c:	74 0b                	je     80106689 <trap+0xc9>
8010667e:	e8 bd de ff ff       	call   80104540 <myproc>
80106683:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106687:	74 4f                	je     801066d8 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106689:	e8 b2 de ff ff       	call   80104540 <myproc>
8010668e:	85 c0                	test   %eax,%eax
80106690:	74 1d                	je     801066af <trap+0xef>
80106692:	e8 a9 de ff ff       	call   80104540 <myproc>
80106697:	8b 40 24             	mov    0x24(%eax),%eax
8010669a:	85 c0                	test   %eax,%eax
8010669c:	74 11                	je     801066af <trap+0xef>
8010669e:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801066a2:	83 e0 03             	and    $0x3,%eax
801066a5:	66 83 f8 03          	cmp    $0x3,%ax
801066a9:	0f 84 da 00 00 00    	je     80106789 <trap+0x1c9>
    exit();
}
801066af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801066b2:	5b                   	pop    %ebx
801066b3:	5e                   	pop    %esi
801066b4:	5f                   	pop    %edi
801066b5:	5d                   	pop    %ebp
801066b6:	c3                   	ret    
801066b7:	89 f6                	mov    %esi,%esi
801066b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066c0:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801066c4:	83 e0 03             	and    $0x3,%eax
801066c7:	66 83 f8 03          	cmp    $0x3,%ax
801066cb:	75 a8                	jne    80106675 <trap+0xb5>
    exit();
801066cd:	e8 9e e2 ff ff       	call   80104970 <exit>
801066d2:	eb a1                	jmp    80106675 <trap+0xb5>
801066d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801066d8:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
801066dc:	75 ab                	jne    80106689 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
801066de:	e8 bd e3 ff ff       	call   80104aa0 <yield>
801066e3:	eb a4                	jmp    80106689 <trap+0xc9>
801066e5:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
801066e8:	e8 33 de ff ff       	call   80104520 <cpuid>
801066ed:	85 c0                	test   %eax,%eax
801066ef:	0f 84 ab 00 00 00    	je     801067a0 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
801066f5:	e8 d6 cd ff ff       	call   801034d0 <lapiceoi>
    break;
801066fa:	e9 61 ff ff ff       	jmp    80106660 <trap+0xa0>
801066ff:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106700:	e8 8b cc ff ff       	call   80103390 <kbdintr>
    lapiceoi();
80106705:	e8 c6 cd ff ff       	call   801034d0 <lapiceoi>
    break;
8010670a:	e9 51 ff ff ff       	jmp    80106660 <trap+0xa0>
8010670f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106710:	e8 5b 02 00 00       	call   80106970 <uartintr>
    lapiceoi();
80106715:	e8 b6 cd ff ff       	call   801034d0 <lapiceoi>
    break;
8010671a:	e9 41 ff ff ff       	jmp    80106660 <trap+0xa0>
8010671f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106720:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80106724:	8b 77 38             	mov    0x38(%edi),%esi
80106727:	e8 f4 dd ff ff       	call   80104520 <cpuid>
8010672c:	56                   	push   %esi
8010672d:	53                   	push   %ebx
8010672e:	50                   	push   %eax
8010672f:	68 a8 88 10 80       	push   $0x801088a8
80106734:	e8 f7 9e ff ff       	call   80100630 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80106739:	e8 92 cd ff ff       	call   801034d0 <lapiceoi>
    break;
8010673e:	83 c4 10             	add    $0x10,%esp
80106741:	e9 1a ff ff ff       	jmp    80106660 <trap+0xa0>
80106746:	8d 76 00             	lea    0x0(%esi),%esi
80106749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106750:	e8 bb c6 ff ff       	call   80102e10 <ideintr>
80106755:	eb 9e                	jmp    801066f5 <trap+0x135>
80106757:	89 f6                	mov    %esi,%esi
80106759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80106760:	e8 db dd ff ff       	call   80104540 <myproc>
80106765:	8b 58 24             	mov    0x24(%eax),%ebx
80106768:	85 db                	test   %ebx,%ebx
8010676a:	75 2c                	jne    80106798 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
8010676c:	e8 cf dd ff ff       	call   80104540 <myproc>
80106771:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
80106774:	e8 57 ee ff ff       	call   801055d0 <syscall>
    if(myproc()->killed)
80106779:	e8 c2 dd ff ff       	call   80104540 <myproc>
8010677e:	8b 48 24             	mov    0x24(%eax),%ecx
80106781:	85 c9                	test   %ecx,%ecx
80106783:	0f 84 26 ff ff ff    	je     801066af <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80106789:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010678c:	5b                   	pop    %ebx
8010678d:	5e                   	pop    %esi
8010678e:	5f                   	pop    %edi
8010678f:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
80106790:	e9 db e1 ff ff       	jmp    80104970 <exit>
80106795:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80106798:	e8 d3 e1 ff ff       	call   80104970 <exit>
8010679d:	eb cd                	jmp    8010676c <trap+0x1ac>
8010679f:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
801067a0:	83 ec 0c             	sub    $0xc,%esp
801067a3:	68 00 70 12 80       	push   $0x80127000
801067a8:	e8 b3 e8 ff ff       	call   80105060 <acquire>
      ticks++;
      wakeup(&ticks);
801067ad:	c7 04 24 40 78 12 80 	movl   $0x80127840,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
801067b4:	83 05 40 78 12 80 01 	addl   $0x1,0x80127840
      wakeup(&ticks);
801067bb:	e8 e0 e4 ff ff       	call   80104ca0 <wakeup>
      release(&tickslock);
801067c0:	c7 04 24 00 70 12 80 	movl   $0x80127000,(%esp)
801067c7:	e8 b4 e9 ff ff       	call   80105180 <release>
801067cc:	83 c4 10             	add    $0x10,%esp
801067cf:	e9 21 ff ff ff       	jmp    801066f5 <trap+0x135>
801067d4:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801067d7:	8b 5f 38             	mov    0x38(%edi),%ebx
801067da:	e8 41 dd ff ff       	call   80104520 <cpuid>
801067df:	83 ec 0c             	sub    $0xc,%esp
801067e2:	56                   	push   %esi
801067e3:	53                   	push   %ebx
801067e4:	50                   	push   %eax
801067e5:	ff 77 30             	pushl  0x30(%edi)
801067e8:	68 cc 88 10 80       	push   $0x801088cc
801067ed:	e8 3e 9e ff ff       	call   80100630 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
801067f2:	83 c4 14             	add    $0x14,%esp
801067f5:	68 a2 88 10 80       	push   $0x801088a2
801067fa:	e8 c1 9f ff ff       	call   801007c0 <panic>
801067ff:	90                   	nop

80106800 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106800:	a1 00 b6 10 80       	mov    0x8010b600,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80106805:	55                   	push   %ebp
80106806:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106808:	85 c0                	test   %eax,%eax
8010680a:	74 1c                	je     80106828 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010680c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106811:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106812:	a8 01                	test   $0x1,%al
80106814:	74 12                	je     80106828 <uartgetc+0x28>
80106816:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010681b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010681c:	0f b6 c0             	movzbl %al,%eax
}
8010681f:	5d                   	pop    %ebp
80106820:	c3                   	ret    
80106821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80106828:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
8010682d:	5d                   	pop    %ebp
8010682e:	c3                   	ret    
8010682f:	90                   	nop

80106830 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80106830:	55                   	push   %ebp
80106831:	89 e5                	mov    %esp,%ebp
80106833:	57                   	push   %edi
80106834:	56                   	push   %esi
80106835:	53                   	push   %ebx
80106836:	89 c7                	mov    %eax,%edi
80106838:	bb 80 00 00 00       	mov    $0x80,%ebx
8010683d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106842:	83 ec 0c             	sub    $0xc,%esp
80106845:	eb 1b                	jmp    80106862 <uartputc.part.0+0x32>
80106847:	89 f6                	mov    %esi,%esi
80106849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80106850:	83 ec 0c             	sub    $0xc,%esp
80106853:	6a 0a                	push   $0xa
80106855:	e8 96 cc ff ff       	call   801034f0 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010685a:	83 c4 10             	add    $0x10,%esp
8010685d:	83 eb 01             	sub    $0x1,%ebx
80106860:	74 07                	je     80106869 <uartputc.part.0+0x39>
80106862:	89 f2                	mov    %esi,%edx
80106864:	ec                   	in     (%dx),%al
80106865:	a8 20                	test   $0x20,%al
80106867:	74 e7                	je     80106850 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106869:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010686e:	89 f8                	mov    %edi,%eax
80106870:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80106871:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106874:	5b                   	pop    %ebx
80106875:	5e                   	pop    %esi
80106876:	5f                   	pop    %edi
80106877:	5d                   	pop    %ebp
80106878:	c3                   	ret    
80106879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106880 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106880:	55                   	push   %ebp
80106881:	31 c9                	xor    %ecx,%ecx
80106883:	89 c8                	mov    %ecx,%eax
80106885:	89 e5                	mov    %esp,%ebp
80106887:	57                   	push   %edi
80106888:	56                   	push   %esi
80106889:	53                   	push   %ebx
8010688a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010688f:	89 da                	mov    %ebx,%edx
80106891:	83 ec 0c             	sub    $0xc,%esp
80106894:	ee                   	out    %al,(%dx)
80106895:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010689a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010689f:	89 fa                	mov    %edi,%edx
801068a1:	ee                   	out    %al,(%dx)
801068a2:	b8 0c 00 00 00       	mov    $0xc,%eax
801068a7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068ac:	ee                   	out    %al,(%dx)
801068ad:	be f9 03 00 00       	mov    $0x3f9,%esi
801068b2:	89 c8                	mov    %ecx,%eax
801068b4:	89 f2                	mov    %esi,%edx
801068b6:	ee                   	out    %al,(%dx)
801068b7:	b8 03 00 00 00       	mov    $0x3,%eax
801068bc:	89 fa                	mov    %edi,%edx
801068be:	ee                   	out    %al,(%dx)
801068bf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801068c4:	89 c8                	mov    %ecx,%eax
801068c6:	ee                   	out    %al,(%dx)
801068c7:	b8 01 00 00 00       	mov    $0x1,%eax
801068cc:	89 f2                	mov    %esi,%edx
801068ce:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801068cf:	ba fd 03 00 00       	mov    $0x3fd,%edx
801068d4:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
801068d5:	3c ff                	cmp    $0xff,%al
801068d7:	74 5a                	je     80106933 <uartinit+0xb3>
    return;
  uart = 1;
801068d9:	c7 05 00 b6 10 80 01 	movl   $0x1,0x8010b600
801068e0:	00 00 00 
801068e3:	89 da                	mov    %ebx,%edx
801068e5:	ec                   	in     (%dx),%al
801068e6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068eb:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
801068ec:	83 ec 08             	sub    $0x8,%esp
801068ef:	bb c4 89 10 80       	mov    $0x801089c4,%ebx
801068f4:	6a 00                	push   $0x0
801068f6:	6a 04                	push   $0x4
801068f8:	e8 63 c7 ff ff       	call   80103060 <ioapicenable>
801068fd:	83 c4 10             	add    $0x10,%esp
80106900:	b8 78 00 00 00       	mov    $0x78,%eax
80106905:	eb 13                	jmp    8010691a <uartinit+0x9a>
80106907:	89 f6                	mov    %esi,%esi
80106909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106910:	83 c3 01             	add    $0x1,%ebx
80106913:	0f be 03             	movsbl (%ebx),%eax
80106916:	84 c0                	test   %al,%al
80106918:	74 19                	je     80106933 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
8010691a:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
80106920:	85 d2                	test   %edx,%edx
80106922:	74 ec                	je     80106910 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106924:	83 c3 01             	add    $0x1,%ebx
80106927:	e8 04 ff ff ff       	call   80106830 <uartputc.part.0>
8010692c:	0f be 03             	movsbl (%ebx),%eax
8010692f:	84 c0                	test   %al,%al
80106931:	75 e7                	jne    8010691a <uartinit+0x9a>
    uartputc(*p);
}
80106933:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106936:	5b                   	pop    %ebx
80106937:	5e                   	pop    %esi
80106938:	5f                   	pop    %edi
80106939:	5d                   	pop    %ebp
8010693a:	c3                   	ret    
8010693b:	90                   	nop
8010693c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106940 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80106940:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80106946:	55                   	push   %ebp
80106947:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80106949:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
8010694b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
8010694e:	74 10                	je     80106960 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106950:	5d                   	pop    %ebp
80106951:	e9 da fe ff ff       	jmp    80106830 <uartputc.part.0>
80106956:	8d 76 00             	lea    0x0(%esi),%esi
80106959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106960:	5d                   	pop    %ebp
80106961:	c3                   	ret    
80106962:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106970 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80106970:	55                   	push   %ebp
80106971:	89 e5                	mov    %esp,%ebp
80106973:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106976:	68 00 68 10 80       	push   $0x80106800
8010697b:	e8 20 a8 ff ff       	call   801011a0 <consoleintr>
}
80106980:	83 c4 10             	add    $0x10,%esp
80106983:	c9                   	leave  
80106984:	c3                   	ret    

80106985 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106985:	6a 00                	push   $0x0
  pushl $0
80106987:	6a 00                	push   $0x0
  jmp alltraps
80106989:	e9 3c fb ff ff       	jmp    801064ca <alltraps>

8010698e <vector1>:
.globl vector1
vector1:
  pushl $0
8010698e:	6a 00                	push   $0x0
  pushl $1
80106990:	6a 01                	push   $0x1
  jmp alltraps
80106992:	e9 33 fb ff ff       	jmp    801064ca <alltraps>

80106997 <vector2>:
.globl vector2
vector2:
  pushl $0
80106997:	6a 00                	push   $0x0
  pushl $2
80106999:	6a 02                	push   $0x2
  jmp alltraps
8010699b:	e9 2a fb ff ff       	jmp    801064ca <alltraps>

801069a0 <vector3>:
.globl vector3
vector3:
  pushl $0
801069a0:	6a 00                	push   $0x0
  pushl $3
801069a2:	6a 03                	push   $0x3
  jmp alltraps
801069a4:	e9 21 fb ff ff       	jmp    801064ca <alltraps>

801069a9 <vector4>:
.globl vector4
vector4:
  pushl $0
801069a9:	6a 00                	push   $0x0
  pushl $4
801069ab:	6a 04                	push   $0x4
  jmp alltraps
801069ad:	e9 18 fb ff ff       	jmp    801064ca <alltraps>

801069b2 <vector5>:
.globl vector5
vector5:
  pushl $0
801069b2:	6a 00                	push   $0x0
  pushl $5
801069b4:	6a 05                	push   $0x5
  jmp alltraps
801069b6:	e9 0f fb ff ff       	jmp    801064ca <alltraps>

801069bb <vector6>:
.globl vector6
vector6:
  pushl $0
801069bb:	6a 00                	push   $0x0
  pushl $6
801069bd:	6a 06                	push   $0x6
  jmp alltraps
801069bf:	e9 06 fb ff ff       	jmp    801064ca <alltraps>

801069c4 <vector7>:
.globl vector7
vector7:
  pushl $0
801069c4:	6a 00                	push   $0x0
  pushl $7
801069c6:	6a 07                	push   $0x7
  jmp alltraps
801069c8:	e9 fd fa ff ff       	jmp    801064ca <alltraps>

801069cd <vector8>:
.globl vector8
vector8:
  pushl $8
801069cd:	6a 08                	push   $0x8
  jmp alltraps
801069cf:	e9 f6 fa ff ff       	jmp    801064ca <alltraps>

801069d4 <vector9>:
.globl vector9
vector9:
  pushl $0
801069d4:	6a 00                	push   $0x0
  pushl $9
801069d6:	6a 09                	push   $0x9
  jmp alltraps
801069d8:	e9 ed fa ff ff       	jmp    801064ca <alltraps>

801069dd <vector10>:
.globl vector10
vector10:
  pushl $10
801069dd:	6a 0a                	push   $0xa
  jmp alltraps
801069df:	e9 e6 fa ff ff       	jmp    801064ca <alltraps>

801069e4 <vector11>:
.globl vector11
vector11:
  pushl $11
801069e4:	6a 0b                	push   $0xb
  jmp alltraps
801069e6:	e9 df fa ff ff       	jmp    801064ca <alltraps>

801069eb <vector12>:
.globl vector12
vector12:
  pushl $12
801069eb:	6a 0c                	push   $0xc
  jmp alltraps
801069ed:	e9 d8 fa ff ff       	jmp    801064ca <alltraps>

801069f2 <vector13>:
.globl vector13
vector13:
  pushl $13
801069f2:	6a 0d                	push   $0xd
  jmp alltraps
801069f4:	e9 d1 fa ff ff       	jmp    801064ca <alltraps>

801069f9 <vector14>:
.globl vector14
vector14:
  pushl $14
801069f9:	6a 0e                	push   $0xe
  jmp alltraps
801069fb:	e9 ca fa ff ff       	jmp    801064ca <alltraps>

80106a00 <vector15>:
.globl vector15
vector15:
  pushl $0
80106a00:	6a 00                	push   $0x0
  pushl $15
80106a02:	6a 0f                	push   $0xf
  jmp alltraps
80106a04:	e9 c1 fa ff ff       	jmp    801064ca <alltraps>

80106a09 <vector16>:
.globl vector16
vector16:
  pushl $0
80106a09:	6a 00                	push   $0x0
  pushl $16
80106a0b:	6a 10                	push   $0x10
  jmp alltraps
80106a0d:	e9 b8 fa ff ff       	jmp    801064ca <alltraps>

80106a12 <vector17>:
.globl vector17
vector17:
  pushl $17
80106a12:	6a 11                	push   $0x11
  jmp alltraps
80106a14:	e9 b1 fa ff ff       	jmp    801064ca <alltraps>

80106a19 <vector18>:
.globl vector18
vector18:
  pushl $0
80106a19:	6a 00                	push   $0x0
  pushl $18
80106a1b:	6a 12                	push   $0x12
  jmp alltraps
80106a1d:	e9 a8 fa ff ff       	jmp    801064ca <alltraps>

80106a22 <vector19>:
.globl vector19
vector19:
  pushl $0
80106a22:	6a 00                	push   $0x0
  pushl $19
80106a24:	6a 13                	push   $0x13
  jmp alltraps
80106a26:	e9 9f fa ff ff       	jmp    801064ca <alltraps>

80106a2b <vector20>:
.globl vector20
vector20:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $20
80106a2d:	6a 14                	push   $0x14
  jmp alltraps
80106a2f:	e9 96 fa ff ff       	jmp    801064ca <alltraps>

80106a34 <vector21>:
.globl vector21
vector21:
  pushl $0
80106a34:	6a 00                	push   $0x0
  pushl $21
80106a36:	6a 15                	push   $0x15
  jmp alltraps
80106a38:	e9 8d fa ff ff       	jmp    801064ca <alltraps>

80106a3d <vector22>:
.globl vector22
vector22:
  pushl $0
80106a3d:	6a 00                	push   $0x0
  pushl $22
80106a3f:	6a 16                	push   $0x16
  jmp alltraps
80106a41:	e9 84 fa ff ff       	jmp    801064ca <alltraps>

80106a46 <vector23>:
.globl vector23
vector23:
  pushl $0
80106a46:	6a 00                	push   $0x0
  pushl $23
80106a48:	6a 17                	push   $0x17
  jmp alltraps
80106a4a:	e9 7b fa ff ff       	jmp    801064ca <alltraps>

80106a4f <vector24>:
.globl vector24
vector24:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $24
80106a51:	6a 18                	push   $0x18
  jmp alltraps
80106a53:	e9 72 fa ff ff       	jmp    801064ca <alltraps>

80106a58 <vector25>:
.globl vector25
vector25:
  pushl $0
80106a58:	6a 00                	push   $0x0
  pushl $25
80106a5a:	6a 19                	push   $0x19
  jmp alltraps
80106a5c:	e9 69 fa ff ff       	jmp    801064ca <alltraps>

80106a61 <vector26>:
.globl vector26
vector26:
  pushl $0
80106a61:	6a 00                	push   $0x0
  pushl $26
80106a63:	6a 1a                	push   $0x1a
  jmp alltraps
80106a65:	e9 60 fa ff ff       	jmp    801064ca <alltraps>

80106a6a <vector27>:
.globl vector27
vector27:
  pushl $0
80106a6a:	6a 00                	push   $0x0
  pushl $27
80106a6c:	6a 1b                	push   $0x1b
  jmp alltraps
80106a6e:	e9 57 fa ff ff       	jmp    801064ca <alltraps>

80106a73 <vector28>:
.globl vector28
vector28:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $28
80106a75:	6a 1c                	push   $0x1c
  jmp alltraps
80106a77:	e9 4e fa ff ff       	jmp    801064ca <alltraps>

80106a7c <vector29>:
.globl vector29
vector29:
  pushl $0
80106a7c:	6a 00                	push   $0x0
  pushl $29
80106a7e:	6a 1d                	push   $0x1d
  jmp alltraps
80106a80:	e9 45 fa ff ff       	jmp    801064ca <alltraps>

80106a85 <vector30>:
.globl vector30
vector30:
  pushl $0
80106a85:	6a 00                	push   $0x0
  pushl $30
80106a87:	6a 1e                	push   $0x1e
  jmp alltraps
80106a89:	e9 3c fa ff ff       	jmp    801064ca <alltraps>

80106a8e <vector31>:
.globl vector31
vector31:
  pushl $0
80106a8e:	6a 00                	push   $0x0
  pushl $31
80106a90:	6a 1f                	push   $0x1f
  jmp alltraps
80106a92:	e9 33 fa ff ff       	jmp    801064ca <alltraps>

80106a97 <vector32>:
.globl vector32
vector32:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $32
80106a99:	6a 20                	push   $0x20
  jmp alltraps
80106a9b:	e9 2a fa ff ff       	jmp    801064ca <alltraps>

80106aa0 <vector33>:
.globl vector33
vector33:
  pushl $0
80106aa0:	6a 00                	push   $0x0
  pushl $33
80106aa2:	6a 21                	push   $0x21
  jmp alltraps
80106aa4:	e9 21 fa ff ff       	jmp    801064ca <alltraps>

80106aa9 <vector34>:
.globl vector34
vector34:
  pushl $0
80106aa9:	6a 00                	push   $0x0
  pushl $34
80106aab:	6a 22                	push   $0x22
  jmp alltraps
80106aad:	e9 18 fa ff ff       	jmp    801064ca <alltraps>

80106ab2 <vector35>:
.globl vector35
vector35:
  pushl $0
80106ab2:	6a 00                	push   $0x0
  pushl $35
80106ab4:	6a 23                	push   $0x23
  jmp alltraps
80106ab6:	e9 0f fa ff ff       	jmp    801064ca <alltraps>

80106abb <vector36>:
.globl vector36
vector36:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $36
80106abd:	6a 24                	push   $0x24
  jmp alltraps
80106abf:	e9 06 fa ff ff       	jmp    801064ca <alltraps>

80106ac4 <vector37>:
.globl vector37
vector37:
  pushl $0
80106ac4:	6a 00                	push   $0x0
  pushl $37
80106ac6:	6a 25                	push   $0x25
  jmp alltraps
80106ac8:	e9 fd f9 ff ff       	jmp    801064ca <alltraps>

80106acd <vector38>:
.globl vector38
vector38:
  pushl $0
80106acd:	6a 00                	push   $0x0
  pushl $38
80106acf:	6a 26                	push   $0x26
  jmp alltraps
80106ad1:	e9 f4 f9 ff ff       	jmp    801064ca <alltraps>

80106ad6 <vector39>:
.globl vector39
vector39:
  pushl $0
80106ad6:	6a 00                	push   $0x0
  pushl $39
80106ad8:	6a 27                	push   $0x27
  jmp alltraps
80106ada:	e9 eb f9 ff ff       	jmp    801064ca <alltraps>

80106adf <vector40>:
.globl vector40
vector40:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $40
80106ae1:	6a 28                	push   $0x28
  jmp alltraps
80106ae3:	e9 e2 f9 ff ff       	jmp    801064ca <alltraps>

80106ae8 <vector41>:
.globl vector41
vector41:
  pushl $0
80106ae8:	6a 00                	push   $0x0
  pushl $41
80106aea:	6a 29                	push   $0x29
  jmp alltraps
80106aec:	e9 d9 f9 ff ff       	jmp    801064ca <alltraps>

80106af1 <vector42>:
.globl vector42
vector42:
  pushl $0
80106af1:	6a 00                	push   $0x0
  pushl $42
80106af3:	6a 2a                	push   $0x2a
  jmp alltraps
80106af5:	e9 d0 f9 ff ff       	jmp    801064ca <alltraps>

80106afa <vector43>:
.globl vector43
vector43:
  pushl $0
80106afa:	6a 00                	push   $0x0
  pushl $43
80106afc:	6a 2b                	push   $0x2b
  jmp alltraps
80106afe:	e9 c7 f9 ff ff       	jmp    801064ca <alltraps>

80106b03 <vector44>:
.globl vector44
vector44:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $44
80106b05:	6a 2c                	push   $0x2c
  jmp alltraps
80106b07:	e9 be f9 ff ff       	jmp    801064ca <alltraps>

80106b0c <vector45>:
.globl vector45
vector45:
  pushl $0
80106b0c:	6a 00                	push   $0x0
  pushl $45
80106b0e:	6a 2d                	push   $0x2d
  jmp alltraps
80106b10:	e9 b5 f9 ff ff       	jmp    801064ca <alltraps>

80106b15 <vector46>:
.globl vector46
vector46:
  pushl $0
80106b15:	6a 00                	push   $0x0
  pushl $46
80106b17:	6a 2e                	push   $0x2e
  jmp alltraps
80106b19:	e9 ac f9 ff ff       	jmp    801064ca <alltraps>

80106b1e <vector47>:
.globl vector47
vector47:
  pushl $0
80106b1e:	6a 00                	push   $0x0
  pushl $47
80106b20:	6a 2f                	push   $0x2f
  jmp alltraps
80106b22:	e9 a3 f9 ff ff       	jmp    801064ca <alltraps>

80106b27 <vector48>:
.globl vector48
vector48:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $48
80106b29:	6a 30                	push   $0x30
  jmp alltraps
80106b2b:	e9 9a f9 ff ff       	jmp    801064ca <alltraps>

80106b30 <vector49>:
.globl vector49
vector49:
  pushl $0
80106b30:	6a 00                	push   $0x0
  pushl $49
80106b32:	6a 31                	push   $0x31
  jmp alltraps
80106b34:	e9 91 f9 ff ff       	jmp    801064ca <alltraps>

80106b39 <vector50>:
.globl vector50
vector50:
  pushl $0
80106b39:	6a 00                	push   $0x0
  pushl $50
80106b3b:	6a 32                	push   $0x32
  jmp alltraps
80106b3d:	e9 88 f9 ff ff       	jmp    801064ca <alltraps>

80106b42 <vector51>:
.globl vector51
vector51:
  pushl $0
80106b42:	6a 00                	push   $0x0
  pushl $51
80106b44:	6a 33                	push   $0x33
  jmp alltraps
80106b46:	e9 7f f9 ff ff       	jmp    801064ca <alltraps>

80106b4b <vector52>:
.globl vector52
vector52:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $52
80106b4d:	6a 34                	push   $0x34
  jmp alltraps
80106b4f:	e9 76 f9 ff ff       	jmp    801064ca <alltraps>

80106b54 <vector53>:
.globl vector53
vector53:
  pushl $0
80106b54:	6a 00                	push   $0x0
  pushl $53
80106b56:	6a 35                	push   $0x35
  jmp alltraps
80106b58:	e9 6d f9 ff ff       	jmp    801064ca <alltraps>

80106b5d <vector54>:
.globl vector54
vector54:
  pushl $0
80106b5d:	6a 00                	push   $0x0
  pushl $54
80106b5f:	6a 36                	push   $0x36
  jmp alltraps
80106b61:	e9 64 f9 ff ff       	jmp    801064ca <alltraps>

80106b66 <vector55>:
.globl vector55
vector55:
  pushl $0
80106b66:	6a 00                	push   $0x0
  pushl $55
80106b68:	6a 37                	push   $0x37
  jmp alltraps
80106b6a:	e9 5b f9 ff ff       	jmp    801064ca <alltraps>

80106b6f <vector56>:
.globl vector56
vector56:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $56
80106b71:	6a 38                	push   $0x38
  jmp alltraps
80106b73:	e9 52 f9 ff ff       	jmp    801064ca <alltraps>

80106b78 <vector57>:
.globl vector57
vector57:
  pushl $0
80106b78:	6a 00                	push   $0x0
  pushl $57
80106b7a:	6a 39                	push   $0x39
  jmp alltraps
80106b7c:	e9 49 f9 ff ff       	jmp    801064ca <alltraps>

80106b81 <vector58>:
.globl vector58
vector58:
  pushl $0
80106b81:	6a 00                	push   $0x0
  pushl $58
80106b83:	6a 3a                	push   $0x3a
  jmp alltraps
80106b85:	e9 40 f9 ff ff       	jmp    801064ca <alltraps>

80106b8a <vector59>:
.globl vector59
vector59:
  pushl $0
80106b8a:	6a 00                	push   $0x0
  pushl $59
80106b8c:	6a 3b                	push   $0x3b
  jmp alltraps
80106b8e:	e9 37 f9 ff ff       	jmp    801064ca <alltraps>

80106b93 <vector60>:
.globl vector60
vector60:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $60
80106b95:	6a 3c                	push   $0x3c
  jmp alltraps
80106b97:	e9 2e f9 ff ff       	jmp    801064ca <alltraps>

80106b9c <vector61>:
.globl vector61
vector61:
  pushl $0
80106b9c:	6a 00                	push   $0x0
  pushl $61
80106b9e:	6a 3d                	push   $0x3d
  jmp alltraps
80106ba0:	e9 25 f9 ff ff       	jmp    801064ca <alltraps>

80106ba5 <vector62>:
.globl vector62
vector62:
  pushl $0
80106ba5:	6a 00                	push   $0x0
  pushl $62
80106ba7:	6a 3e                	push   $0x3e
  jmp alltraps
80106ba9:	e9 1c f9 ff ff       	jmp    801064ca <alltraps>

80106bae <vector63>:
.globl vector63
vector63:
  pushl $0
80106bae:	6a 00                	push   $0x0
  pushl $63
80106bb0:	6a 3f                	push   $0x3f
  jmp alltraps
80106bb2:	e9 13 f9 ff ff       	jmp    801064ca <alltraps>

80106bb7 <vector64>:
.globl vector64
vector64:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $64
80106bb9:	6a 40                	push   $0x40
  jmp alltraps
80106bbb:	e9 0a f9 ff ff       	jmp    801064ca <alltraps>

80106bc0 <vector65>:
.globl vector65
vector65:
  pushl $0
80106bc0:	6a 00                	push   $0x0
  pushl $65
80106bc2:	6a 41                	push   $0x41
  jmp alltraps
80106bc4:	e9 01 f9 ff ff       	jmp    801064ca <alltraps>

80106bc9 <vector66>:
.globl vector66
vector66:
  pushl $0
80106bc9:	6a 00                	push   $0x0
  pushl $66
80106bcb:	6a 42                	push   $0x42
  jmp alltraps
80106bcd:	e9 f8 f8 ff ff       	jmp    801064ca <alltraps>

80106bd2 <vector67>:
.globl vector67
vector67:
  pushl $0
80106bd2:	6a 00                	push   $0x0
  pushl $67
80106bd4:	6a 43                	push   $0x43
  jmp alltraps
80106bd6:	e9 ef f8 ff ff       	jmp    801064ca <alltraps>

80106bdb <vector68>:
.globl vector68
vector68:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $68
80106bdd:	6a 44                	push   $0x44
  jmp alltraps
80106bdf:	e9 e6 f8 ff ff       	jmp    801064ca <alltraps>

80106be4 <vector69>:
.globl vector69
vector69:
  pushl $0
80106be4:	6a 00                	push   $0x0
  pushl $69
80106be6:	6a 45                	push   $0x45
  jmp alltraps
80106be8:	e9 dd f8 ff ff       	jmp    801064ca <alltraps>

80106bed <vector70>:
.globl vector70
vector70:
  pushl $0
80106bed:	6a 00                	push   $0x0
  pushl $70
80106bef:	6a 46                	push   $0x46
  jmp alltraps
80106bf1:	e9 d4 f8 ff ff       	jmp    801064ca <alltraps>

80106bf6 <vector71>:
.globl vector71
vector71:
  pushl $0
80106bf6:	6a 00                	push   $0x0
  pushl $71
80106bf8:	6a 47                	push   $0x47
  jmp alltraps
80106bfa:	e9 cb f8 ff ff       	jmp    801064ca <alltraps>

80106bff <vector72>:
.globl vector72
vector72:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $72
80106c01:	6a 48                	push   $0x48
  jmp alltraps
80106c03:	e9 c2 f8 ff ff       	jmp    801064ca <alltraps>

80106c08 <vector73>:
.globl vector73
vector73:
  pushl $0
80106c08:	6a 00                	push   $0x0
  pushl $73
80106c0a:	6a 49                	push   $0x49
  jmp alltraps
80106c0c:	e9 b9 f8 ff ff       	jmp    801064ca <alltraps>

80106c11 <vector74>:
.globl vector74
vector74:
  pushl $0
80106c11:	6a 00                	push   $0x0
  pushl $74
80106c13:	6a 4a                	push   $0x4a
  jmp alltraps
80106c15:	e9 b0 f8 ff ff       	jmp    801064ca <alltraps>

80106c1a <vector75>:
.globl vector75
vector75:
  pushl $0
80106c1a:	6a 00                	push   $0x0
  pushl $75
80106c1c:	6a 4b                	push   $0x4b
  jmp alltraps
80106c1e:	e9 a7 f8 ff ff       	jmp    801064ca <alltraps>

80106c23 <vector76>:
.globl vector76
vector76:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $76
80106c25:	6a 4c                	push   $0x4c
  jmp alltraps
80106c27:	e9 9e f8 ff ff       	jmp    801064ca <alltraps>

80106c2c <vector77>:
.globl vector77
vector77:
  pushl $0
80106c2c:	6a 00                	push   $0x0
  pushl $77
80106c2e:	6a 4d                	push   $0x4d
  jmp alltraps
80106c30:	e9 95 f8 ff ff       	jmp    801064ca <alltraps>

80106c35 <vector78>:
.globl vector78
vector78:
  pushl $0
80106c35:	6a 00                	push   $0x0
  pushl $78
80106c37:	6a 4e                	push   $0x4e
  jmp alltraps
80106c39:	e9 8c f8 ff ff       	jmp    801064ca <alltraps>

80106c3e <vector79>:
.globl vector79
vector79:
  pushl $0
80106c3e:	6a 00                	push   $0x0
  pushl $79
80106c40:	6a 4f                	push   $0x4f
  jmp alltraps
80106c42:	e9 83 f8 ff ff       	jmp    801064ca <alltraps>

80106c47 <vector80>:
.globl vector80
vector80:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $80
80106c49:	6a 50                	push   $0x50
  jmp alltraps
80106c4b:	e9 7a f8 ff ff       	jmp    801064ca <alltraps>

80106c50 <vector81>:
.globl vector81
vector81:
  pushl $0
80106c50:	6a 00                	push   $0x0
  pushl $81
80106c52:	6a 51                	push   $0x51
  jmp alltraps
80106c54:	e9 71 f8 ff ff       	jmp    801064ca <alltraps>

80106c59 <vector82>:
.globl vector82
vector82:
  pushl $0
80106c59:	6a 00                	push   $0x0
  pushl $82
80106c5b:	6a 52                	push   $0x52
  jmp alltraps
80106c5d:	e9 68 f8 ff ff       	jmp    801064ca <alltraps>

80106c62 <vector83>:
.globl vector83
vector83:
  pushl $0
80106c62:	6a 00                	push   $0x0
  pushl $83
80106c64:	6a 53                	push   $0x53
  jmp alltraps
80106c66:	e9 5f f8 ff ff       	jmp    801064ca <alltraps>

80106c6b <vector84>:
.globl vector84
vector84:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $84
80106c6d:	6a 54                	push   $0x54
  jmp alltraps
80106c6f:	e9 56 f8 ff ff       	jmp    801064ca <alltraps>

80106c74 <vector85>:
.globl vector85
vector85:
  pushl $0
80106c74:	6a 00                	push   $0x0
  pushl $85
80106c76:	6a 55                	push   $0x55
  jmp alltraps
80106c78:	e9 4d f8 ff ff       	jmp    801064ca <alltraps>

80106c7d <vector86>:
.globl vector86
vector86:
  pushl $0
80106c7d:	6a 00                	push   $0x0
  pushl $86
80106c7f:	6a 56                	push   $0x56
  jmp alltraps
80106c81:	e9 44 f8 ff ff       	jmp    801064ca <alltraps>

80106c86 <vector87>:
.globl vector87
vector87:
  pushl $0
80106c86:	6a 00                	push   $0x0
  pushl $87
80106c88:	6a 57                	push   $0x57
  jmp alltraps
80106c8a:	e9 3b f8 ff ff       	jmp    801064ca <alltraps>

80106c8f <vector88>:
.globl vector88
vector88:
  pushl $0
80106c8f:	6a 00                	push   $0x0
  pushl $88
80106c91:	6a 58                	push   $0x58
  jmp alltraps
80106c93:	e9 32 f8 ff ff       	jmp    801064ca <alltraps>

80106c98 <vector89>:
.globl vector89
vector89:
  pushl $0
80106c98:	6a 00                	push   $0x0
  pushl $89
80106c9a:	6a 59                	push   $0x59
  jmp alltraps
80106c9c:	e9 29 f8 ff ff       	jmp    801064ca <alltraps>

80106ca1 <vector90>:
.globl vector90
vector90:
  pushl $0
80106ca1:	6a 00                	push   $0x0
  pushl $90
80106ca3:	6a 5a                	push   $0x5a
  jmp alltraps
80106ca5:	e9 20 f8 ff ff       	jmp    801064ca <alltraps>

80106caa <vector91>:
.globl vector91
vector91:
  pushl $0
80106caa:	6a 00                	push   $0x0
  pushl $91
80106cac:	6a 5b                	push   $0x5b
  jmp alltraps
80106cae:	e9 17 f8 ff ff       	jmp    801064ca <alltraps>

80106cb3 <vector92>:
.globl vector92
vector92:
  pushl $0
80106cb3:	6a 00                	push   $0x0
  pushl $92
80106cb5:	6a 5c                	push   $0x5c
  jmp alltraps
80106cb7:	e9 0e f8 ff ff       	jmp    801064ca <alltraps>

80106cbc <vector93>:
.globl vector93
vector93:
  pushl $0
80106cbc:	6a 00                	push   $0x0
  pushl $93
80106cbe:	6a 5d                	push   $0x5d
  jmp alltraps
80106cc0:	e9 05 f8 ff ff       	jmp    801064ca <alltraps>

80106cc5 <vector94>:
.globl vector94
vector94:
  pushl $0
80106cc5:	6a 00                	push   $0x0
  pushl $94
80106cc7:	6a 5e                	push   $0x5e
  jmp alltraps
80106cc9:	e9 fc f7 ff ff       	jmp    801064ca <alltraps>

80106cce <vector95>:
.globl vector95
vector95:
  pushl $0
80106cce:	6a 00                	push   $0x0
  pushl $95
80106cd0:	6a 5f                	push   $0x5f
  jmp alltraps
80106cd2:	e9 f3 f7 ff ff       	jmp    801064ca <alltraps>

80106cd7 <vector96>:
.globl vector96
vector96:
  pushl $0
80106cd7:	6a 00                	push   $0x0
  pushl $96
80106cd9:	6a 60                	push   $0x60
  jmp alltraps
80106cdb:	e9 ea f7 ff ff       	jmp    801064ca <alltraps>

80106ce0 <vector97>:
.globl vector97
vector97:
  pushl $0
80106ce0:	6a 00                	push   $0x0
  pushl $97
80106ce2:	6a 61                	push   $0x61
  jmp alltraps
80106ce4:	e9 e1 f7 ff ff       	jmp    801064ca <alltraps>

80106ce9 <vector98>:
.globl vector98
vector98:
  pushl $0
80106ce9:	6a 00                	push   $0x0
  pushl $98
80106ceb:	6a 62                	push   $0x62
  jmp alltraps
80106ced:	e9 d8 f7 ff ff       	jmp    801064ca <alltraps>

80106cf2 <vector99>:
.globl vector99
vector99:
  pushl $0
80106cf2:	6a 00                	push   $0x0
  pushl $99
80106cf4:	6a 63                	push   $0x63
  jmp alltraps
80106cf6:	e9 cf f7 ff ff       	jmp    801064ca <alltraps>

80106cfb <vector100>:
.globl vector100
vector100:
  pushl $0
80106cfb:	6a 00                	push   $0x0
  pushl $100
80106cfd:	6a 64                	push   $0x64
  jmp alltraps
80106cff:	e9 c6 f7 ff ff       	jmp    801064ca <alltraps>

80106d04 <vector101>:
.globl vector101
vector101:
  pushl $0
80106d04:	6a 00                	push   $0x0
  pushl $101
80106d06:	6a 65                	push   $0x65
  jmp alltraps
80106d08:	e9 bd f7 ff ff       	jmp    801064ca <alltraps>

80106d0d <vector102>:
.globl vector102
vector102:
  pushl $0
80106d0d:	6a 00                	push   $0x0
  pushl $102
80106d0f:	6a 66                	push   $0x66
  jmp alltraps
80106d11:	e9 b4 f7 ff ff       	jmp    801064ca <alltraps>

80106d16 <vector103>:
.globl vector103
vector103:
  pushl $0
80106d16:	6a 00                	push   $0x0
  pushl $103
80106d18:	6a 67                	push   $0x67
  jmp alltraps
80106d1a:	e9 ab f7 ff ff       	jmp    801064ca <alltraps>

80106d1f <vector104>:
.globl vector104
vector104:
  pushl $0
80106d1f:	6a 00                	push   $0x0
  pushl $104
80106d21:	6a 68                	push   $0x68
  jmp alltraps
80106d23:	e9 a2 f7 ff ff       	jmp    801064ca <alltraps>

80106d28 <vector105>:
.globl vector105
vector105:
  pushl $0
80106d28:	6a 00                	push   $0x0
  pushl $105
80106d2a:	6a 69                	push   $0x69
  jmp alltraps
80106d2c:	e9 99 f7 ff ff       	jmp    801064ca <alltraps>

80106d31 <vector106>:
.globl vector106
vector106:
  pushl $0
80106d31:	6a 00                	push   $0x0
  pushl $106
80106d33:	6a 6a                	push   $0x6a
  jmp alltraps
80106d35:	e9 90 f7 ff ff       	jmp    801064ca <alltraps>

80106d3a <vector107>:
.globl vector107
vector107:
  pushl $0
80106d3a:	6a 00                	push   $0x0
  pushl $107
80106d3c:	6a 6b                	push   $0x6b
  jmp alltraps
80106d3e:	e9 87 f7 ff ff       	jmp    801064ca <alltraps>

80106d43 <vector108>:
.globl vector108
vector108:
  pushl $0
80106d43:	6a 00                	push   $0x0
  pushl $108
80106d45:	6a 6c                	push   $0x6c
  jmp alltraps
80106d47:	e9 7e f7 ff ff       	jmp    801064ca <alltraps>

80106d4c <vector109>:
.globl vector109
vector109:
  pushl $0
80106d4c:	6a 00                	push   $0x0
  pushl $109
80106d4e:	6a 6d                	push   $0x6d
  jmp alltraps
80106d50:	e9 75 f7 ff ff       	jmp    801064ca <alltraps>

80106d55 <vector110>:
.globl vector110
vector110:
  pushl $0
80106d55:	6a 00                	push   $0x0
  pushl $110
80106d57:	6a 6e                	push   $0x6e
  jmp alltraps
80106d59:	e9 6c f7 ff ff       	jmp    801064ca <alltraps>

80106d5e <vector111>:
.globl vector111
vector111:
  pushl $0
80106d5e:	6a 00                	push   $0x0
  pushl $111
80106d60:	6a 6f                	push   $0x6f
  jmp alltraps
80106d62:	e9 63 f7 ff ff       	jmp    801064ca <alltraps>

80106d67 <vector112>:
.globl vector112
vector112:
  pushl $0
80106d67:	6a 00                	push   $0x0
  pushl $112
80106d69:	6a 70                	push   $0x70
  jmp alltraps
80106d6b:	e9 5a f7 ff ff       	jmp    801064ca <alltraps>

80106d70 <vector113>:
.globl vector113
vector113:
  pushl $0
80106d70:	6a 00                	push   $0x0
  pushl $113
80106d72:	6a 71                	push   $0x71
  jmp alltraps
80106d74:	e9 51 f7 ff ff       	jmp    801064ca <alltraps>

80106d79 <vector114>:
.globl vector114
vector114:
  pushl $0
80106d79:	6a 00                	push   $0x0
  pushl $114
80106d7b:	6a 72                	push   $0x72
  jmp alltraps
80106d7d:	e9 48 f7 ff ff       	jmp    801064ca <alltraps>

80106d82 <vector115>:
.globl vector115
vector115:
  pushl $0
80106d82:	6a 00                	push   $0x0
  pushl $115
80106d84:	6a 73                	push   $0x73
  jmp alltraps
80106d86:	e9 3f f7 ff ff       	jmp    801064ca <alltraps>

80106d8b <vector116>:
.globl vector116
vector116:
  pushl $0
80106d8b:	6a 00                	push   $0x0
  pushl $116
80106d8d:	6a 74                	push   $0x74
  jmp alltraps
80106d8f:	e9 36 f7 ff ff       	jmp    801064ca <alltraps>

80106d94 <vector117>:
.globl vector117
vector117:
  pushl $0
80106d94:	6a 00                	push   $0x0
  pushl $117
80106d96:	6a 75                	push   $0x75
  jmp alltraps
80106d98:	e9 2d f7 ff ff       	jmp    801064ca <alltraps>

80106d9d <vector118>:
.globl vector118
vector118:
  pushl $0
80106d9d:	6a 00                	push   $0x0
  pushl $118
80106d9f:	6a 76                	push   $0x76
  jmp alltraps
80106da1:	e9 24 f7 ff ff       	jmp    801064ca <alltraps>

80106da6 <vector119>:
.globl vector119
vector119:
  pushl $0
80106da6:	6a 00                	push   $0x0
  pushl $119
80106da8:	6a 77                	push   $0x77
  jmp alltraps
80106daa:	e9 1b f7 ff ff       	jmp    801064ca <alltraps>

80106daf <vector120>:
.globl vector120
vector120:
  pushl $0
80106daf:	6a 00                	push   $0x0
  pushl $120
80106db1:	6a 78                	push   $0x78
  jmp alltraps
80106db3:	e9 12 f7 ff ff       	jmp    801064ca <alltraps>

80106db8 <vector121>:
.globl vector121
vector121:
  pushl $0
80106db8:	6a 00                	push   $0x0
  pushl $121
80106dba:	6a 79                	push   $0x79
  jmp alltraps
80106dbc:	e9 09 f7 ff ff       	jmp    801064ca <alltraps>

80106dc1 <vector122>:
.globl vector122
vector122:
  pushl $0
80106dc1:	6a 00                	push   $0x0
  pushl $122
80106dc3:	6a 7a                	push   $0x7a
  jmp alltraps
80106dc5:	e9 00 f7 ff ff       	jmp    801064ca <alltraps>

80106dca <vector123>:
.globl vector123
vector123:
  pushl $0
80106dca:	6a 00                	push   $0x0
  pushl $123
80106dcc:	6a 7b                	push   $0x7b
  jmp alltraps
80106dce:	e9 f7 f6 ff ff       	jmp    801064ca <alltraps>

80106dd3 <vector124>:
.globl vector124
vector124:
  pushl $0
80106dd3:	6a 00                	push   $0x0
  pushl $124
80106dd5:	6a 7c                	push   $0x7c
  jmp alltraps
80106dd7:	e9 ee f6 ff ff       	jmp    801064ca <alltraps>

80106ddc <vector125>:
.globl vector125
vector125:
  pushl $0
80106ddc:	6a 00                	push   $0x0
  pushl $125
80106dde:	6a 7d                	push   $0x7d
  jmp alltraps
80106de0:	e9 e5 f6 ff ff       	jmp    801064ca <alltraps>

80106de5 <vector126>:
.globl vector126
vector126:
  pushl $0
80106de5:	6a 00                	push   $0x0
  pushl $126
80106de7:	6a 7e                	push   $0x7e
  jmp alltraps
80106de9:	e9 dc f6 ff ff       	jmp    801064ca <alltraps>

80106dee <vector127>:
.globl vector127
vector127:
  pushl $0
80106dee:	6a 00                	push   $0x0
  pushl $127
80106df0:	6a 7f                	push   $0x7f
  jmp alltraps
80106df2:	e9 d3 f6 ff ff       	jmp    801064ca <alltraps>

80106df7 <vector128>:
.globl vector128
vector128:
  pushl $0
80106df7:	6a 00                	push   $0x0
  pushl $128
80106df9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106dfe:	e9 c7 f6 ff ff       	jmp    801064ca <alltraps>

80106e03 <vector129>:
.globl vector129
vector129:
  pushl $0
80106e03:	6a 00                	push   $0x0
  pushl $129
80106e05:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106e0a:	e9 bb f6 ff ff       	jmp    801064ca <alltraps>

80106e0f <vector130>:
.globl vector130
vector130:
  pushl $0
80106e0f:	6a 00                	push   $0x0
  pushl $130
80106e11:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106e16:	e9 af f6 ff ff       	jmp    801064ca <alltraps>

80106e1b <vector131>:
.globl vector131
vector131:
  pushl $0
80106e1b:	6a 00                	push   $0x0
  pushl $131
80106e1d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106e22:	e9 a3 f6 ff ff       	jmp    801064ca <alltraps>

80106e27 <vector132>:
.globl vector132
vector132:
  pushl $0
80106e27:	6a 00                	push   $0x0
  pushl $132
80106e29:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106e2e:	e9 97 f6 ff ff       	jmp    801064ca <alltraps>

80106e33 <vector133>:
.globl vector133
vector133:
  pushl $0
80106e33:	6a 00                	push   $0x0
  pushl $133
80106e35:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106e3a:	e9 8b f6 ff ff       	jmp    801064ca <alltraps>

80106e3f <vector134>:
.globl vector134
vector134:
  pushl $0
80106e3f:	6a 00                	push   $0x0
  pushl $134
80106e41:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106e46:	e9 7f f6 ff ff       	jmp    801064ca <alltraps>

80106e4b <vector135>:
.globl vector135
vector135:
  pushl $0
80106e4b:	6a 00                	push   $0x0
  pushl $135
80106e4d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106e52:	e9 73 f6 ff ff       	jmp    801064ca <alltraps>

80106e57 <vector136>:
.globl vector136
vector136:
  pushl $0
80106e57:	6a 00                	push   $0x0
  pushl $136
80106e59:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106e5e:	e9 67 f6 ff ff       	jmp    801064ca <alltraps>

80106e63 <vector137>:
.globl vector137
vector137:
  pushl $0
80106e63:	6a 00                	push   $0x0
  pushl $137
80106e65:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106e6a:	e9 5b f6 ff ff       	jmp    801064ca <alltraps>

80106e6f <vector138>:
.globl vector138
vector138:
  pushl $0
80106e6f:	6a 00                	push   $0x0
  pushl $138
80106e71:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106e76:	e9 4f f6 ff ff       	jmp    801064ca <alltraps>

80106e7b <vector139>:
.globl vector139
vector139:
  pushl $0
80106e7b:	6a 00                	push   $0x0
  pushl $139
80106e7d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106e82:	e9 43 f6 ff ff       	jmp    801064ca <alltraps>

80106e87 <vector140>:
.globl vector140
vector140:
  pushl $0
80106e87:	6a 00                	push   $0x0
  pushl $140
80106e89:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106e8e:	e9 37 f6 ff ff       	jmp    801064ca <alltraps>

80106e93 <vector141>:
.globl vector141
vector141:
  pushl $0
80106e93:	6a 00                	push   $0x0
  pushl $141
80106e95:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106e9a:	e9 2b f6 ff ff       	jmp    801064ca <alltraps>

80106e9f <vector142>:
.globl vector142
vector142:
  pushl $0
80106e9f:	6a 00                	push   $0x0
  pushl $142
80106ea1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106ea6:	e9 1f f6 ff ff       	jmp    801064ca <alltraps>

80106eab <vector143>:
.globl vector143
vector143:
  pushl $0
80106eab:	6a 00                	push   $0x0
  pushl $143
80106ead:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106eb2:	e9 13 f6 ff ff       	jmp    801064ca <alltraps>

80106eb7 <vector144>:
.globl vector144
vector144:
  pushl $0
80106eb7:	6a 00                	push   $0x0
  pushl $144
80106eb9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106ebe:	e9 07 f6 ff ff       	jmp    801064ca <alltraps>

80106ec3 <vector145>:
.globl vector145
vector145:
  pushl $0
80106ec3:	6a 00                	push   $0x0
  pushl $145
80106ec5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106eca:	e9 fb f5 ff ff       	jmp    801064ca <alltraps>

80106ecf <vector146>:
.globl vector146
vector146:
  pushl $0
80106ecf:	6a 00                	push   $0x0
  pushl $146
80106ed1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106ed6:	e9 ef f5 ff ff       	jmp    801064ca <alltraps>

80106edb <vector147>:
.globl vector147
vector147:
  pushl $0
80106edb:	6a 00                	push   $0x0
  pushl $147
80106edd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106ee2:	e9 e3 f5 ff ff       	jmp    801064ca <alltraps>

80106ee7 <vector148>:
.globl vector148
vector148:
  pushl $0
80106ee7:	6a 00                	push   $0x0
  pushl $148
80106ee9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106eee:	e9 d7 f5 ff ff       	jmp    801064ca <alltraps>

80106ef3 <vector149>:
.globl vector149
vector149:
  pushl $0
80106ef3:	6a 00                	push   $0x0
  pushl $149
80106ef5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106efa:	e9 cb f5 ff ff       	jmp    801064ca <alltraps>

80106eff <vector150>:
.globl vector150
vector150:
  pushl $0
80106eff:	6a 00                	push   $0x0
  pushl $150
80106f01:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106f06:	e9 bf f5 ff ff       	jmp    801064ca <alltraps>

80106f0b <vector151>:
.globl vector151
vector151:
  pushl $0
80106f0b:	6a 00                	push   $0x0
  pushl $151
80106f0d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106f12:	e9 b3 f5 ff ff       	jmp    801064ca <alltraps>

80106f17 <vector152>:
.globl vector152
vector152:
  pushl $0
80106f17:	6a 00                	push   $0x0
  pushl $152
80106f19:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106f1e:	e9 a7 f5 ff ff       	jmp    801064ca <alltraps>

80106f23 <vector153>:
.globl vector153
vector153:
  pushl $0
80106f23:	6a 00                	push   $0x0
  pushl $153
80106f25:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106f2a:	e9 9b f5 ff ff       	jmp    801064ca <alltraps>

80106f2f <vector154>:
.globl vector154
vector154:
  pushl $0
80106f2f:	6a 00                	push   $0x0
  pushl $154
80106f31:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106f36:	e9 8f f5 ff ff       	jmp    801064ca <alltraps>

80106f3b <vector155>:
.globl vector155
vector155:
  pushl $0
80106f3b:	6a 00                	push   $0x0
  pushl $155
80106f3d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106f42:	e9 83 f5 ff ff       	jmp    801064ca <alltraps>

80106f47 <vector156>:
.globl vector156
vector156:
  pushl $0
80106f47:	6a 00                	push   $0x0
  pushl $156
80106f49:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106f4e:	e9 77 f5 ff ff       	jmp    801064ca <alltraps>

80106f53 <vector157>:
.globl vector157
vector157:
  pushl $0
80106f53:	6a 00                	push   $0x0
  pushl $157
80106f55:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106f5a:	e9 6b f5 ff ff       	jmp    801064ca <alltraps>

80106f5f <vector158>:
.globl vector158
vector158:
  pushl $0
80106f5f:	6a 00                	push   $0x0
  pushl $158
80106f61:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106f66:	e9 5f f5 ff ff       	jmp    801064ca <alltraps>

80106f6b <vector159>:
.globl vector159
vector159:
  pushl $0
80106f6b:	6a 00                	push   $0x0
  pushl $159
80106f6d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106f72:	e9 53 f5 ff ff       	jmp    801064ca <alltraps>

80106f77 <vector160>:
.globl vector160
vector160:
  pushl $0
80106f77:	6a 00                	push   $0x0
  pushl $160
80106f79:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106f7e:	e9 47 f5 ff ff       	jmp    801064ca <alltraps>

80106f83 <vector161>:
.globl vector161
vector161:
  pushl $0
80106f83:	6a 00                	push   $0x0
  pushl $161
80106f85:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106f8a:	e9 3b f5 ff ff       	jmp    801064ca <alltraps>

80106f8f <vector162>:
.globl vector162
vector162:
  pushl $0
80106f8f:	6a 00                	push   $0x0
  pushl $162
80106f91:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106f96:	e9 2f f5 ff ff       	jmp    801064ca <alltraps>

80106f9b <vector163>:
.globl vector163
vector163:
  pushl $0
80106f9b:	6a 00                	push   $0x0
  pushl $163
80106f9d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106fa2:	e9 23 f5 ff ff       	jmp    801064ca <alltraps>

80106fa7 <vector164>:
.globl vector164
vector164:
  pushl $0
80106fa7:	6a 00                	push   $0x0
  pushl $164
80106fa9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106fae:	e9 17 f5 ff ff       	jmp    801064ca <alltraps>

80106fb3 <vector165>:
.globl vector165
vector165:
  pushl $0
80106fb3:	6a 00                	push   $0x0
  pushl $165
80106fb5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106fba:	e9 0b f5 ff ff       	jmp    801064ca <alltraps>

80106fbf <vector166>:
.globl vector166
vector166:
  pushl $0
80106fbf:	6a 00                	push   $0x0
  pushl $166
80106fc1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106fc6:	e9 ff f4 ff ff       	jmp    801064ca <alltraps>

80106fcb <vector167>:
.globl vector167
vector167:
  pushl $0
80106fcb:	6a 00                	push   $0x0
  pushl $167
80106fcd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106fd2:	e9 f3 f4 ff ff       	jmp    801064ca <alltraps>

80106fd7 <vector168>:
.globl vector168
vector168:
  pushl $0
80106fd7:	6a 00                	push   $0x0
  pushl $168
80106fd9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106fde:	e9 e7 f4 ff ff       	jmp    801064ca <alltraps>

80106fe3 <vector169>:
.globl vector169
vector169:
  pushl $0
80106fe3:	6a 00                	push   $0x0
  pushl $169
80106fe5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106fea:	e9 db f4 ff ff       	jmp    801064ca <alltraps>

80106fef <vector170>:
.globl vector170
vector170:
  pushl $0
80106fef:	6a 00                	push   $0x0
  pushl $170
80106ff1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106ff6:	e9 cf f4 ff ff       	jmp    801064ca <alltraps>

80106ffb <vector171>:
.globl vector171
vector171:
  pushl $0
80106ffb:	6a 00                	push   $0x0
  pushl $171
80106ffd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107002:	e9 c3 f4 ff ff       	jmp    801064ca <alltraps>

80107007 <vector172>:
.globl vector172
vector172:
  pushl $0
80107007:	6a 00                	push   $0x0
  pushl $172
80107009:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010700e:	e9 b7 f4 ff ff       	jmp    801064ca <alltraps>

80107013 <vector173>:
.globl vector173
vector173:
  pushl $0
80107013:	6a 00                	push   $0x0
  pushl $173
80107015:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010701a:	e9 ab f4 ff ff       	jmp    801064ca <alltraps>

8010701f <vector174>:
.globl vector174
vector174:
  pushl $0
8010701f:	6a 00                	push   $0x0
  pushl $174
80107021:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107026:	e9 9f f4 ff ff       	jmp    801064ca <alltraps>

8010702b <vector175>:
.globl vector175
vector175:
  pushl $0
8010702b:	6a 00                	push   $0x0
  pushl $175
8010702d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107032:	e9 93 f4 ff ff       	jmp    801064ca <alltraps>

80107037 <vector176>:
.globl vector176
vector176:
  pushl $0
80107037:	6a 00                	push   $0x0
  pushl $176
80107039:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010703e:	e9 87 f4 ff ff       	jmp    801064ca <alltraps>

80107043 <vector177>:
.globl vector177
vector177:
  pushl $0
80107043:	6a 00                	push   $0x0
  pushl $177
80107045:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010704a:	e9 7b f4 ff ff       	jmp    801064ca <alltraps>

8010704f <vector178>:
.globl vector178
vector178:
  pushl $0
8010704f:	6a 00                	push   $0x0
  pushl $178
80107051:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107056:	e9 6f f4 ff ff       	jmp    801064ca <alltraps>

8010705b <vector179>:
.globl vector179
vector179:
  pushl $0
8010705b:	6a 00                	push   $0x0
  pushl $179
8010705d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107062:	e9 63 f4 ff ff       	jmp    801064ca <alltraps>

80107067 <vector180>:
.globl vector180
vector180:
  pushl $0
80107067:	6a 00                	push   $0x0
  pushl $180
80107069:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010706e:	e9 57 f4 ff ff       	jmp    801064ca <alltraps>

80107073 <vector181>:
.globl vector181
vector181:
  pushl $0
80107073:	6a 00                	push   $0x0
  pushl $181
80107075:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010707a:	e9 4b f4 ff ff       	jmp    801064ca <alltraps>

8010707f <vector182>:
.globl vector182
vector182:
  pushl $0
8010707f:	6a 00                	push   $0x0
  pushl $182
80107081:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107086:	e9 3f f4 ff ff       	jmp    801064ca <alltraps>

8010708b <vector183>:
.globl vector183
vector183:
  pushl $0
8010708b:	6a 00                	push   $0x0
  pushl $183
8010708d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107092:	e9 33 f4 ff ff       	jmp    801064ca <alltraps>

80107097 <vector184>:
.globl vector184
vector184:
  pushl $0
80107097:	6a 00                	push   $0x0
  pushl $184
80107099:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010709e:	e9 27 f4 ff ff       	jmp    801064ca <alltraps>

801070a3 <vector185>:
.globl vector185
vector185:
  pushl $0
801070a3:	6a 00                	push   $0x0
  pushl $185
801070a5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801070aa:	e9 1b f4 ff ff       	jmp    801064ca <alltraps>

801070af <vector186>:
.globl vector186
vector186:
  pushl $0
801070af:	6a 00                	push   $0x0
  pushl $186
801070b1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801070b6:	e9 0f f4 ff ff       	jmp    801064ca <alltraps>

801070bb <vector187>:
.globl vector187
vector187:
  pushl $0
801070bb:	6a 00                	push   $0x0
  pushl $187
801070bd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801070c2:	e9 03 f4 ff ff       	jmp    801064ca <alltraps>

801070c7 <vector188>:
.globl vector188
vector188:
  pushl $0
801070c7:	6a 00                	push   $0x0
  pushl $188
801070c9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801070ce:	e9 f7 f3 ff ff       	jmp    801064ca <alltraps>

801070d3 <vector189>:
.globl vector189
vector189:
  pushl $0
801070d3:	6a 00                	push   $0x0
  pushl $189
801070d5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801070da:	e9 eb f3 ff ff       	jmp    801064ca <alltraps>

801070df <vector190>:
.globl vector190
vector190:
  pushl $0
801070df:	6a 00                	push   $0x0
  pushl $190
801070e1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801070e6:	e9 df f3 ff ff       	jmp    801064ca <alltraps>

801070eb <vector191>:
.globl vector191
vector191:
  pushl $0
801070eb:	6a 00                	push   $0x0
  pushl $191
801070ed:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801070f2:	e9 d3 f3 ff ff       	jmp    801064ca <alltraps>

801070f7 <vector192>:
.globl vector192
vector192:
  pushl $0
801070f7:	6a 00                	push   $0x0
  pushl $192
801070f9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801070fe:	e9 c7 f3 ff ff       	jmp    801064ca <alltraps>

80107103 <vector193>:
.globl vector193
vector193:
  pushl $0
80107103:	6a 00                	push   $0x0
  pushl $193
80107105:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010710a:	e9 bb f3 ff ff       	jmp    801064ca <alltraps>

8010710f <vector194>:
.globl vector194
vector194:
  pushl $0
8010710f:	6a 00                	push   $0x0
  pushl $194
80107111:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107116:	e9 af f3 ff ff       	jmp    801064ca <alltraps>

8010711b <vector195>:
.globl vector195
vector195:
  pushl $0
8010711b:	6a 00                	push   $0x0
  pushl $195
8010711d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107122:	e9 a3 f3 ff ff       	jmp    801064ca <alltraps>

80107127 <vector196>:
.globl vector196
vector196:
  pushl $0
80107127:	6a 00                	push   $0x0
  pushl $196
80107129:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010712e:	e9 97 f3 ff ff       	jmp    801064ca <alltraps>

80107133 <vector197>:
.globl vector197
vector197:
  pushl $0
80107133:	6a 00                	push   $0x0
  pushl $197
80107135:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010713a:	e9 8b f3 ff ff       	jmp    801064ca <alltraps>

8010713f <vector198>:
.globl vector198
vector198:
  pushl $0
8010713f:	6a 00                	push   $0x0
  pushl $198
80107141:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107146:	e9 7f f3 ff ff       	jmp    801064ca <alltraps>

8010714b <vector199>:
.globl vector199
vector199:
  pushl $0
8010714b:	6a 00                	push   $0x0
  pushl $199
8010714d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107152:	e9 73 f3 ff ff       	jmp    801064ca <alltraps>

80107157 <vector200>:
.globl vector200
vector200:
  pushl $0
80107157:	6a 00                	push   $0x0
  pushl $200
80107159:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010715e:	e9 67 f3 ff ff       	jmp    801064ca <alltraps>

80107163 <vector201>:
.globl vector201
vector201:
  pushl $0
80107163:	6a 00                	push   $0x0
  pushl $201
80107165:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010716a:	e9 5b f3 ff ff       	jmp    801064ca <alltraps>

8010716f <vector202>:
.globl vector202
vector202:
  pushl $0
8010716f:	6a 00                	push   $0x0
  pushl $202
80107171:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107176:	e9 4f f3 ff ff       	jmp    801064ca <alltraps>

8010717b <vector203>:
.globl vector203
vector203:
  pushl $0
8010717b:	6a 00                	push   $0x0
  pushl $203
8010717d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107182:	e9 43 f3 ff ff       	jmp    801064ca <alltraps>

80107187 <vector204>:
.globl vector204
vector204:
  pushl $0
80107187:	6a 00                	push   $0x0
  pushl $204
80107189:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010718e:	e9 37 f3 ff ff       	jmp    801064ca <alltraps>

80107193 <vector205>:
.globl vector205
vector205:
  pushl $0
80107193:	6a 00                	push   $0x0
  pushl $205
80107195:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010719a:	e9 2b f3 ff ff       	jmp    801064ca <alltraps>

8010719f <vector206>:
.globl vector206
vector206:
  pushl $0
8010719f:	6a 00                	push   $0x0
  pushl $206
801071a1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801071a6:	e9 1f f3 ff ff       	jmp    801064ca <alltraps>

801071ab <vector207>:
.globl vector207
vector207:
  pushl $0
801071ab:	6a 00                	push   $0x0
  pushl $207
801071ad:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801071b2:	e9 13 f3 ff ff       	jmp    801064ca <alltraps>

801071b7 <vector208>:
.globl vector208
vector208:
  pushl $0
801071b7:	6a 00                	push   $0x0
  pushl $208
801071b9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801071be:	e9 07 f3 ff ff       	jmp    801064ca <alltraps>

801071c3 <vector209>:
.globl vector209
vector209:
  pushl $0
801071c3:	6a 00                	push   $0x0
  pushl $209
801071c5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801071ca:	e9 fb f2 ff ff       	jmp    801064ca <alltraps>

801071cf <vector210>:
.globl vector210
vector210:
  pushl $0
801071cf:	6a 00                	push   $0x0
  pushl $210
801071d1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801071d6:	e9 ef f2 ff ff       	jmp    801064ca <alltraps>

801071db <vector211>:
.globl vector211
vector211:
  pushl $0
801071db:	6a 00                	push   $0x0
  pushl $211
801071dd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801071e2:	e9 e3 f2 ff ff       	jmp    801064ca <alltraps>

801071e7 <vector212>:
.globl vector212
vector212:
  pushl $0
801071e7:	6a 00                	push   $0x0
  pushl $212
801071e9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801071ee:	e9 d7 f2 ff ff       	jmp    801064ca <alltraps>

801071f3 <vector213>:
.globl vector213
vector213:
  pushl $0
801071f3:	6a 00                	push   $0x0
  pushl $213
801071f5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801071fa:	e9 cb f2 ff ff       	jmp    801064ca <alltraps>

801071ff <vector214>:
.globl vector214
vector214:
  pushl $0
801071ff:	6a 00                	push   $0x0
  pushl $214
80107201:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107206:	e9 bf f2 ff ff       	jmp    801064ca <alltraps>

8010720b <vector215>:
.globl vector215
vector215:
  pushl $0
8010720b:	6a 00                	push   $0x0
  pushl $215
8010720d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107212:	e9 b3 f2 ff ff       	jmp    801064ca <alltraps>

80107217 <vector216>:
.globl vector216
vector216:
  pushl $0
80107217:	6a 00                	push   $0x0
  pushl $216
80107219:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010721e:	e9 a7 f2 ff ff       	jmp    801064ca <alltraps>

80107223 <vector217>:
.globl vector217
vector217:
  pushl $0
80107223:	6a 00                	push   $0x0
  pushl $217
80107225:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010722a:	e9 9b f2 ff ff       	jmp    801064ca <alltraps>

8010722f <vector218>:
.globl vector218
vector218:
  pushl $0
8010722f:	6a 00                	push   $0x0
  pushl $218
80107231:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107236:	e9 8f f2 ff ff       	jmp    801064ca <alltraps>

8010723b <vector219>:
.globl vector219
vector219:
  pushl $0
8010723b:	6a 00                	push   $0x0
  pushl $219
8010723d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107242:	e9 83 f2 ff ff       	jmp    801064ca <alltraps>

80107247 <vector220>:
.globl vector220
vector220:
  pushl $0
80107247:	6a 00                	push   $0x0
  pushl $220
80107249:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010724e:	e9 77 f2 ff ff       	jmp    801064ca <alltraps>

80107253 <vector221>:
.globl vector221
vector221:
  pushl $0
80107253:	6a 00                	push   $0x0
  pushl $221
80107255:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010725a:	e9 6b f2 ff ff       	jmp    801064ca <alltraps>

8010725f <vector222>:
.globl vector222
vector222:
  pushl $0
8010725f:	6a 00                	push   $0x0
  pushl $222
80107261:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107266:	e9 5f f2 ff ff       	jmp    801064ca <alltraps>

8010726b <vector223>:
.globl vector223
vector223:
  pushl $0
8010726b:	6a 00                	push   $0x0
  pushl $223
8010726d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107272:	e9 53 f2 ff ff       	jmp    801064ca <alltraps>

80107277 <vector224>:
.globl vector224
vector224:
  pushl $0
80107277:	6a 00                	push   $0x0
  pushl $224
80107279:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010727e:	e9 47 f2 ff ff       	jmp    801064ca <alltraps>

80107283 <vector225>:
.globl vector225
vector225:
  pushl $0
80107283:	6a 00                	push   $0x0
  pushl $225
80107285:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010728a:	e9 3b f2 ff ff       	jmp    801064ca <alltraps>

8010728f <vector226>:
.globl vector226
vector226:
  pushl $0
8010728f:	6a 00                	push   $0x0
  pushl $226
80107291:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107296:	e9 2f f2 ff ff       	jmp    801064ca <alltraps>

8010729b <vector227>:
.globl vector227
vector227:
  pushl $0
8010729b:	6a 00                	push   $0x0
  pushl $227
8010729d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801072a2:	e9 23 f2 ff ff       	jmp    801064ca <alltraps>

801072a7 <vector228>:
.globl vector228
vector228:
  pushl $0
801072a7:	6a 00                	push   $0x0
  pushl $228
801072a9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801072ae:	e9 17 f2 ff ff       	jmp    801064ca <alltraps>

801072b3 <vector229>:
.globl vector229
vector229:
  pushl $0
801072b3:	6a 00                	push   $0x0
  pushl $229
801072b5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801072ba:	e9 0b f2 ff ff       	jmp    801064ca <alltraps>

801072bf <vector230>:
.globl vector230
vector230:
  pushl $0
801072bf:	6a 00                	push   $0x0
  pushl $230
801072c1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801072c6:	e9 ff f1 ff ff       	jmp    801064ca <alltraps>

801072cb <vector231>:
.globl vector231
vector231:
  pushl $0
801072cb:	6a 00                	push   $0x0
  pushl $231
801072cd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801072d2:	e9 f3 f1 ff ff       	jmp    801064ca <alltraps>

801072d7 <vector232>:
.globl vector232
vector232:
  pushl $0
801072d7:	6a 00                	push   $0x0
  pushl $232
801072d9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801072de:	e9 e7 f1 ff ff       	jmp    801064ca <alltraps>

801072e3 <vector233>:
.globl vector233
vector233:
  pushl $0
801072e3:	6a 00                	push   $0x0
  pushl $233
801072e5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801072ea:	e9 db f1 ff ff       	jmp    801064ca <alltraps>

801072ef <vector234>:
.globl vector234
vector234:
  pushl $0
801072ef:	6a 00                	push   $0x0
  pushl $234
801072f1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801072f6:	e9 cf f1 ff ff       	jmp    801064ca <alltraps>

801072fb <vector235>:
.globl vector235
vector235:
  pushl $0
801072fb:	6a 00                	push   $0x0
  pushl $235
801072fd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107302:	e9 c3 f1 ff ff       	jmp    801064ca <alltraps>

80107307 <vector236>:
.globl vector236
vector236:
  pushl $0
80107307:	6a 00                	push   $0x0
  pushl $236
80107309:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010730e:	e9 b7 f1 ff ff       	jmp    801064ca <alltraps>

80107313 <vector237>:
.globl vector237
vector237:
  pushl $0
80107313:	6a 00                	push   $0x0
  pushl $237
80107315:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010731a:	e9 ab f1 ff ff       	jmp    801064ca <alltraps>

8010731f <vector238>:
.globl vector238
vector238:
  pushl $0
8010731f:	6a 00                	push   $0x0
  pushl $238
80107321:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107326:	e9 9f f1 ff ff       	jmp    801064ca <alltraps>

8010732b <vector239>:
.globl vector239
vector239:
  pushl $0
8010732b:	6a 00                	push   $0x0
  pushl $239
8010732d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107332:	e9 93 f1 ff ff       	jmp    801064ca <alltraps>

80107337 <vector240>:
.globl vector240
vector240:
  pushl $0
80107337:	6a 00                	push   $0x0
  pushl $240
80107339:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010733e:	e9 87 f1 ff ff       	jmp    801064ca <alltraps>

80107343 <vector241>:
.globl vector241
vector241:
  pushl $0
80107343:	6a 00                	push   $0x0
  pushl $241
80107345:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010734a:	e9 7b f1 ff ff       	jmp    801064ca <alltraps>

8010734f <vector242>:
.globl vector242
vector242:
  pushl $0
8010734f:	6a 00                	push   $0x0
  pushl $242
80107351:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107356:	e9 6f f1 ff ff       	jmp    801064ca <alltraps>

8010735b <vector243>:
.globl vector243
vector243:
  pushl $0
8010735b:	6a 00                	push   $0x0
  pushl $243
8010735d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107362:	e9 63 f1 ff ff       	jmp    801064ca <alltraps>

80107367 <vector244>:
.globl vector244
vector244:
  pushl $0
80107367:	6a 00                	push   $0x0
  pushl $244
80107369:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010736e:	e9 57 f1 ff ff       	jmp    801064ca <alltraps>

80107373 <vector245>:
.globl vector245
vector245:
  pushl $0
80107373:	6a 00                	push   $0x0
  pushl $245
80107375:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010737a:	e9 4b f1 ff ff       	jmp    801064ca <alltraps>

8010737f <vector246>:
.globl vector246
vector246:
  pushl $0
8010737f:	6a 00                	push   $0x0
  pushl $246
80107381:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107386:	e9 3f f1 ff ff       	jmp    801064ca <alltraps>

8010738b <vector247>:
.globl vector247
vector247:
  pushl $0
8010738b:	6a 00                	push   $0x0
  pushl $247
8010738d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107392:	e9 33 f1 ff ff       	jmp    801064ca <alltraps>

80107397 <vector248>:
.globl vector248
vector248:
  pushl $0
80107397:	6a 00                	push   $0x0
  pushl $248
80107399:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010739e:	e9 27 f1 ff ff       	jmp    801064ca <alltraps>

801073a3 <vector249>:
.globl vector249
vector249:
  pushl $0
801073a3:	6a 00                	push   $0x0
  pushl $249
801073a5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801073aa:	e9 1b f1 ff ff       	jmp    801064ca <alltraps>

801073af <vector250>:
.globl vector250
vector250:
  pushl $0
801073af:	6a 00                	push   $0x0
  pushl $250
801073b1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801073b6:	e9 0f f1 ff ff       	jmp    801064ca <alltraps>

801073bb <vector251>:
.globl vector251
vector251:
  pushl $0
801073bb:	6a 00                	push   $0x0
  pushl $251
801073bd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801073c2:	e9 03 f1 ff ff       	jmp    801064ca <alltraps>

801073c7 <vector252>:
.globl vector252
vector252:
  pushl $0
801073c7:	6a 00                	push   $0x0
  pushl $252
801073c9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801073ce:	e9 f7 f0 ff ff       	jmp    801064ca <alltraps>

801073d3 <vector253>:
.globl vector253
vector253:
  pushl $0
801073d3:	6a 00                	push   $0x0
  pushl $253
801073d5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801073da:	e9 eb f0 ff ff       	jmp    801064ca <alltraps>

801073df <vector254>:
.globl vector254
vector254:
  pushl $0
801073df:	6a 00                	push   $0x0
  pushl $254
801073e1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801073e6:	e9 df f0 ff ff       	jmp    801064ca <alltraps>

801073eb <vector255>:
.globl vector255
vector255:
  pushl $0
801073eb:	6a 00                	push   $0x0
  pushl $255
801073ed:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801073f2:	e9 d3 f0 ff ff       	jmp    801064ca <alltraps>
801073f7:	66 90                	xchg   %ax,%ax
801073f9:	66 90                	xchg   %ax,%ax
801073fb:	66 90                	xchg   %ax,%ax
801073fd:	66 90                	xchg   %ax,%ax
801073ff:	90                   	nop

80107400 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107400:	55                   	push   %ebp
80107401:	89 e5                	mov    %esp,%ebp
80107403:	57                   	push   %edi
80107404:	56                   	push   %esi
80107405:	53                   	push   %ebx
80107406:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107408:	c1 ea 16             	shr    $0x16,%edx
8010740b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010740e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80107411:	8b 07                	mov    (%edi),%eax
80107413:	a8 01                	test   $0x1,%al
80107415:	74 29                	je     80107440 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107417:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010741c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80107422:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107425:	c1 eb 0a             	shr    $0xa,%ebx
80107428:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010742e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80107431:	5b                   	pop    %ebx
80107432:	5e                   	pop    %esi
80107433:	5f                   	pop    %edi
80107434:	5d                   	pop    %ebp
80107435:	c3                   	ret    
80107436:	8d 76 00             	lea    0x0(%esi),%esi
80107439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107440:	85 c9                	test   %ecx,%ecx
80107442:	74 2c                	je     80107470 <walkpgdir+0x70>
80107444:	e8 07 be ff ff       	call   80103250 <kalloc>
80107449:	85 c0                	test   %eax,%eax
8010744b:	89 c6                	mov    %eax,%esi
8010744d:	74 21                	je     80107470 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010744f:	83 ec 04             	sub    $0x4,%esp
80107452:	68 00 10 00 00       	push   $0x1000
80107457:	6a 00                	push   $0x0
80107459:	50                   	push   %eax
8010745a:	e8 71 dd ff ff       	call   801051d0 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010745f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107465:	83 c4 10             	add    $0x10,%esp
80107468:	83 c8 07             	or     $0x7,%eax
8010746b:	89 07                	mov    %eax,(%edi)
8010746d:	eb b3                	jmp    80107422 <walkpgdir+0x22>
8010746f:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
80107470:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80107473:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80107475:	5b                   	pop    %ebx
80107476:	5e                   	pop    %esi
80107477:	5f                   	pop    %edi
80107478:	5d                   	pop    %ebp
80107479:	c3                   	ret    
8010747a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107480 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107480:	55                   	push   %ebp
80107481:	89 e5                	mov    %esp,%ebp
80107483:	57                   	push   %edi
80107484:	56                   	push   %esi
80107485:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107486:	89 d3                	mov    %edx,%ebx
80107488:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010748e:	83 ec 1c             	sub    $0x1c,%esp
80107491:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107494:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107498:	8b 7d 08             	mov    0x8(%ebp),%edi
8010749b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801074a0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801074a3:	8b 45 0c             	mov    0xc(%ebp),%eax
801074a6:	29 df                	sub    %ebx,%edi
801074a8:	83 c8 01             	or     $0x1,%eax
801074ab:	89 45 dc             	mov    %eax,-0x24(%ebp)
801074ae:	eb 15                	jmp    801074c5 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801074b0:	f6 00 01             	testb  $0x1,(%eax)
801074b3:	75 45                	jne    801074fa <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
801074b5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801074b8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801074bb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801074bd:	74 31                	je     801074f0 <mappages+0x70>
      break;
    a += PGSIZE;
801074bf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801074c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074c8:	b9 01 00 00 00       	mov    $0x1,%ecx
801074cd:	89 da                	mov    %ebx,%edx
801074cf:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801074d2:	e8 29 ff ff ff       	call   80107400 <walkpgdir>
801074d7:	85 c0                	test   %eax,%eax
801074d9:	75 d5                	jne    801074b0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801074db:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
801074de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801074e3:	5b                   	pop    %ebx
801074e4:	5e                   	pop    %esi
801074e5:	5f                   	pop    %edi
801074e6:	5d                   	pop    %ebp
801074e7:	c3                   	ret    
801074e8:	90                   	nop
801074e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
801074f3:	31 c0                	xor    %eax,%eax
}
801074f5:	5b                   	pop    %ebx
801074f6:	5e                   	pop    %esi
801074f7:	5f                   	pop    %edi
801074f8:	5d                   	pop    %ebp
801074f9:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
801074fa:	83 ec 0c             	sub    $0xc,%esp
801074fd:	68 cc 89 10 80       	push   $0x801089cc
80107502:	e8 b9 92 ff ff       	call   801007c0 <panic>
80107507:	89 f6                	mov    %esi,%esi
80107509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107510 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107510:	55                   	push   %ebp
80107511:	89 e5                	mov    %esp,%ebp
80107513:	57                   	push   %edi
80107514:	56                   	push   %esi
80107515:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107516:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010751c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010751e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107524:	83 ec 1c             	sub    $0x1c,%esp
80107527:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010752a:	39 d3                	cmp    %edx,%ebx
8010752c:	73 66                	jae    80107594 <deallocuvm.part.0+0x84>
8010752e:	89 d6                	mov    %edx,%esi
80107530:	eb 3d                	jmp    8010756f <deallocuvm.part.0+0x5f>
80107532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107538:	8b 10                	mov    (%eax),%edx
8010753a:	f6 c2 01             	test   $0x1,%dl
8010753d:	74 26                	je     80107565 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010753f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107545:	74 58                	je     8010759f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107547:	83 ec 0c             	sub    $0xc,%esp
8010754a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107550:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107553:	52                   	push   %edx
80107554:	e8 47 bb ff ff       	call   801030a0 <kfree>
      *pte = 0;
80107559:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010755c:	83 c4 10             	add    $0x10,%esp
8010755f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80107565:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010756b:	39 f3                	cmp    %esi,%ebx
8010756d:	73 25                	jae    80107594 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010756f:	31 c9                	xor    %ecx,%ecx
80107571:	89 da                	mov    %ebx,%edx
80107573:	89 f8                	mov    %edi,%eax
80107575:	e8 86 fe ff ff       	call   80107400 <walkpgdir>
    if(!pte)
8010757a:	85 c0                	test   %eax,%eax
8010757c:	75 ba                	jne    80107538 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010757e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107584:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010758a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107590:	39 f3                	cmp    %esi,%ebx
80107592:	72 db                	jb     8010756f <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107594:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107597:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010759a:	5b                   	pop    %ebx
8010759b:	5e                   	pop    %esi
8010759c:	5f                   	pop    %edi
8010759d:	5d                   	pop    %ebp
8010759e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
8010759f:	83 ec 0c             	sub    $0xc,%esp
801075a2:	68 6e 83 10 80       	push   $0x8010836e
801075a7:	e8 14 92 ff ff       	call   801007c0 <panic>
801075ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801075b0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801075b0:	55                   	push   %ebp
801075b1:	89 e5                	mov    %esp,%ebp
801075b3:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
801075b6:	e8 65 cf ff ff       	call   80104520 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801075bb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801075c1:	31 c9                	xor    %ecx,%ecx
801075c3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801075c8:	66 89 90 98 4b 12 80 	mov    %dx,-0x7fedb468(%eax)
801075cf:	66 89 88 9a 4b 12 80 	mov    %cx,-0x7fedb466(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801075d6:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801075db:	31 c9                	xor    %ecx,%ecx
801075dd:	66 89 90 a0 4b 12 80 	mov    %dx,-0x7fedb460(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801075e4:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801075e9:	66 89 88 a2 4b 12 80 	mov    %cx,-0x7fedb45e(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801075f0:	31 c9                	xor    %ecx,%ecx
801075f2:	66 89 90 a8 4b 12 80 	mov    %dx,-0x7fedb458(%eax)
801075f9:	66 89 88 aa 4b 12 80 	mov    %cx,-0x7fedb456(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107600:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80107605:	31 c9                	xor    %ecx,%ecx
80107607:	66 89 90 b0 4b 12 80 	mov    %dx,-0x7fedb450(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010760e:	c6 80 9c 4b 12 80 00 	movb   $0x0,-0x7fedb464(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80107615:	ba 2f 00 00 00       	mov    $0x2f,%edx
8010761a:	c6 80 9d 4b 12 80 9a 	movb   $0x9a,-0x7fedb463(%eax)
80107621:	c6 80 9e 4b 12 80 cf 	movb   $0xcf,-0x7fedb462(%eax)
80107628:	c6 80 9f 4b 12 80 00 	movb   $0x0,-0x7fedb461(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010762f:	c6 80 a4 4b 12 80 00 	movb   $0x0,-0x7fedb45c(%eax)
80107636:	c6 80 a5 4b 12 80 92 	movb   $0x92,-0x7fedb45b(%eax)
8010763d:	c6 80 a6 4b 12 80 cf 	movb   $0xcf,-0x7fedb45a(%eax)
80107644:	c6 80 a7 4b 12 80 00 	movb   $0x0,-0x7fedb459(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010764b:	c6 80 ac 4b 12 80 00 	movb   $0x0,-0x7fedb454(%eax)
80107652:	c6 80 ad 4b 12 80 fa 	movb   $0xfa,-0x7fedb453(%eax)
80107659:	c6 80 ae 4b 12 80 cf 	movb   $0xcf,-0x7fedb452(%eax)
80107660:	c6 80 af 4b 12 80 00 	movb   $0x0,-0x7fedb451(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107667:	66 89 88 b2 4b 12 80 	mov    %cx,-0x7fedb44e(%eax)
8010766e:	c6 80 b4 4b 12 80 00 	movb   $0x0,-0x7fedb44c(%eax)
80107675:	c6 80 b5 4b 12 80 f2 	movb   $0xf2,-0x7fedb44b(%eax)
8010767c:	c6 80 b6 4b 12 80 cf 	movb   $0xcf,-0x7fedb44a(%eax)
80107683:	c6 80 b7 4b 12 80 00 	movb   $0x0,-0x7fedb449(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
8010768a:	05 90 4b 12 80       	add    $0x80124b90,%eax
8010768f:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80107693:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107697:	c1 e8 10             	shr    $0x10,%eax
8010769a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
8010769e:	8d 45 f2             	lea    -0xe(%ebp),%eax
801076a1:	0f 01 10             	lgdtl  (%eax)
}
801076a4:	c9                   	leave  
801076a5:	c3                   	ret    
801076a6:	8d 76 00             	lea    0x0(%esi),%esi
801076a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801076b0 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801076b0:	a1 44 78 12 80       	mov    0x80127844,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
801076b5:	55                   	push   %ebp
801076b6:	89 e5                	mov    %esp,%ebp
801076b8:	05 00 00 00 80       	add    $0x80000000,%eax
801076bd:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
801076c0:	5d                   	pop    %ebp
801076c1:	c3                   	ret    
801076c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801076d0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801076d0:	55                   	push   %ebp
801076d1:	89 e5                	mov    %esp,%ebp
801076d3:	57                   	push   %edi
801076d4:	56                   	push   %esi
801076d5:	53                   	push   %ebx
801076d6:	83 ec 1c             	sub    $0x1c,%esp
801076d9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801076dc:	85 f6                	test   %esi,%esi
801076de:	0f 84 cd 00 00 00    	je     801077b1 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
801076e4:	8b 46 08             	mov    0x8(%esi),%eax
801076e7:	85 c0                	test   %eax,%eax
801076e9:	0f 84 dc 00 00 00    	je     801077cb <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
801076ef:	8b 7e 04             	mov    0x4(%esi),%edi
801076f2:	85 ff                	test   %edi,%edi
801076f4:	0f 84 c4 00 00 00    	je     801077be <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
801076fa:	e8 21 d9 ff ff       	call   80105020 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801076ff:	e8 9c cd ff ff       	call   801044a0 <mycpu>
80107704:	89 c3                	mov    %eax,%ebx
80107706:	e8 95 cd ff ff       	call   801044a0 <mycpu>
8010770b:	89 c7                	mov    %eax,%edi
8010770d:	e8 8e cd ff ff       	call   801044a0 <mycpu>
80107712:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107715:	83 c7 08             	add    $0x8,%edi
80107718:	e8 83 cd ff ff       	call   801044a0 <mycpu>
8010771d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107720:	83 c0 08             	add    $0x8,%eax
80107723:	ba 67 00 00 00       	mov    $0x67,%edx
80107728:	c1 e8 18             	shr    $0x18,%eax
8010772b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80107732:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107739:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80107740:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80107747:	83 c1 08             	add    $0x8,%ecx
8010774a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80107750:	c1 e9 10             	shr    $0x10,%ecx
80107753:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107759:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
8010775e:	e8 3d cd ff ff       	call   801044a0 <mycpu>
80107763:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010776a:	e8 31 cd ff ff       	call   801044a0 <mycpu>
8010776f:	b9 10 00 00 00       	mov    $0x10,%ecx
80107774:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107778:	e8 23 cd ff ff       	call   801044a0 <mycpu>
8010777d:	8b 56 08             	mov    0x8(%esi),%edx
80107780:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80107786:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107789:	e8 12 cd ff ff       	call   801044a0 <mycpu>
8010778e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80107792:	b8 28 00 00 00       	mov    $0x28,%eax
80107797:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010779a:	8b 46 04             	mov    0x4(%esi),%eax
8010779d:	05 00 00 00 80       	add    $0x80000000,%eax
801077a2:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
801077a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077a8:	5b                   	pop    %ebx
801077a9:	5e                   	pop    %esi
801077aa:	5f                   	pop    %edi
801077ab:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
801077ac:	e9 5f d9 ff ff       	jmp    80105110 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
801077b1:	83 ec 0c             	sub    $0xc,%esp
801077b4:	68 d2 89 10 80       	push   $0x801089d2
801077b9:	e8 02 90 ff ff       	call   801007c0 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
801077be:	83 ec 0c             	sub    $0xc,%esp
801077c1:	68 fd 89 10 80       	push   $0x801089fd
801077c6:	e8 f5 8f ff ff       	call   801007c0 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
801077cb:	83 ec 0c             	sub    $0xc,%esp
801077ce:	68 e8 89 10 80       	push   $0x801089e8
801077d3:	e8 e8 8f ff ff       	call   801007c0 <panic>
801077d8:	90                   	nop
801077d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801077e0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801077e0:	55                   	push   %ebp
801077e1:	89 e5                	mov    %esp,%ebp
801077e3:	57                   	push   %edi
801077e4:	56                   	push   %esi
801077e5:	53                   	push   %ebx
801077e6:	83 ec 1c             	sub    $0x1c,%esp
801077e9:	8b 75 10             	mov    0x10(%ebp),%esi
801077ec:	8b 45 08             	mov    0x8(%ebp),%eax
801077ef:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
801077f2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801077f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
801077fb:	77 49                	ja     80107846 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
801077fd:	e8 4e ba ff ff       	call   80103250 <kalloc>
  memset(mem, 0, PGSIZE);
80107802:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80107805:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107807:	68 00 10 00 00       	push   $0x1000
8010780c:	6a 00                	push   $0x0
8010780e:	50                   	push   %eax
8010780f:	e8 bc d9 ff ff       	call   801051d0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107814:	58                   	pop    %eax
80107815:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010781b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107820:	5a                   	pop    %edx
80107821:	6a 06                	push   $0x6
80107823:	50                   	push   %eax
80107824:	31 d2                	xor    %edx,%edx
80107826:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107829:	e8 52 fc ff ff       	call   80107480 <mappages>
  memmove(mem, init, sz);
8010782e:	89 75 10             	mov    %esi,0x10(%ebp)
80107831:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107834:	83 c4 10             	add    $0x10,%esp
80107837:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010783a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010783d:	5b                   	pop    %ebx
8010783e:	5e                   	pop    %esi
8010783f:	5f                   	pop    %edi
80107840:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80107841:	e9 3a da ff ff       	jmp    80105280 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80107846:	83 ec 0c             	sub    $0xc,%esp
80107849:	68 11 8a 10 80       	push   $0x80108a11
8010784e:	e8 6d 8f ff ff       	call   801007c0 <panic>
80107853:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107860 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107860:	55                   	push   %ebp
80107861:	89 e5                	mov    %esp,%ebp
80107863:	57                   	push   %edi
80107864:	56                   	push   %esi
80107865:	53                   	push   %ebx
80107866:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107869:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107870:	0f 85 91 00 00 00    	jne    80107907 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107876:	8b 75 18             	mov    0x18(%ebp),%esi
80107879:	31 db                	xor    %ebx,%ebx
8010787b:	85 f6                	test   %esi,%esi
8010787d:	75 1a                	jne    80107899 <loaduvm+0x39>
8010787f:	eb 6f                	jmp    801078f0 <loaduvm+0x90>
80107881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107888:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010788e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107894:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107897:	76 57                	jbe    801078f0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107899:	8b 55 0c             	mov    0xc(%ebp),%edx
8010789c:	8b 45 08             	mov    0x8(%ebp),%eax
8010789f:	31 c9                	xor    %ecx,%ecx
801078a1:	01 da                	add    %ebx,%edx
801078a3:	e8 58 fb ff ff       	call   80107400 <walkpgdir>
801078a8:	85 c0                	test   %eax,%eax
801078aa:	74 4e                	je     801078fa <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801078ac:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801078ae:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
801078b1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801078b6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801078bb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801078c1:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801078c4:	01 d9                	add    %ebx,%ecx
801078c6:	05 00 00 00 80       	add    $0x80000000,%eax
801078cb:	57                   	push   %edi
801078cc:	51                   	push   %ecx
801078cd:	50                   	push   %eax
801078ce:	ff 75 10             	pushl  0x10(%ebp)
801078d1:	e8 3a ae ff ff       	call   80102710 <readi>
801078d6:	83 c4 10             	add    $0x10,%esp
801078d9:	39 c7                	cmp    %eax,%edi
801078db:	74 ab                	je     80107888 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
801078dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
801078e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
801078e5:	5b                   	pop    %ebx
801078e6:	5e                   	pop    %esi
801078e7:	5f                   	pop    %edi
801078e8:	5d                   	pop    %ebp
801078e9:	c3                   	ret    
801078ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801078f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
801078f3:	31 c0                	xor    %eax,%eax
}
801078f5:	5b                   	pop    %ebx
801078f6:	5e                   	pop    %esi
801078f7:	5f                   	pop    %edi
801078f8:	5d                   	pop    %ebp
801078f9:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
801078fa:	83 ec 0c             	sub    $0xc,%esp
801078fd:	68 2b 8a 10 80       	push   $0x80108a2b
80107902:	e8 b9 8e ff ff       	call   801007c0 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80107907:	83 ec 0c             	sub    $0xc,%esp
8010790a:	68 cc 8a 10 80       	push   $0x80108acc
8010790f:	e8 ac 8e ff ff       	call   801007c0 <panic>
80107914:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010791a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107920 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107920:	55                   	push   %ebp
80107921:	89 e5                	mov    %esp,%ebp
80107923:	57                   	push   %edi
80107924:	56                   	push   %esi
80107925:	53                   	push   %ebx
80107926:	83 ec 0c             	sub    $0xc,%esp
80107929:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010792c:	85 ff                	test   %edi,%edi
8010792e:	0f 88 ca 00 00 00    	js     801079fe <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80107934:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80107937:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
8010793a:	0f 82 82 00 00 00    	jb     801079c2 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80107940:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107946:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010794c:	39 df                	cmp    %ebx,%edi
8010794e:	77 43                	ja     80107993 <allocuvm+0x73>
80107950:	e9 bb 00 00 00       	jmp    80107a10 <allocuvm+0xf0>
80107955:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80107958:	83 ec 04             	sub    $0x4,%esp
8010795b:	68 00 10 00 00       	push   $0x1000
80107960:	6a 00                	push   $0x0
80107962:	50                   	push   %eax
80107963:	e8 68 d8 ff ff       	call   801051d0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107968:	58                   	pop    %eax
80107969:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010796f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107974:	5a                   	pop    %edx
80107975:	6a 06                	push   $0x6
80107977:	50                   	push   %eax
80107978:	89 da                	mov    %ebx,%edx
8010797a:	8b 45 08             	mov    0x8(%ebp),%eax
8010797d:	e8 fe fa ff ff       	call   80107480 <mappages>
80107982:	83 c4 10             	add    $0x10,%esp
80107985:	85 c0                	test   %eax,%eax
80107987:	78 47                	js     801079d0 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107989:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010798f:	39 df                	cmp    %ebx,%edi
80107991:	76 7d                	jbe    80107a10 <allocuvm+0xf0>
    mem = kalloc();
80107993:	e8 b8 b8 ff ff       	call   80103250 <kalloc>
    if(mem == 0){
80107998:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
8010799a:	89 c6                	mov    %eax,%esi
    if(mem == 0){
8010799c:	75 ba                	jne    80107958 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
8010799e:	83 ec 0c             	sub    $0xc,%esp
801079a1:	68 49 8a 10 80       	push   $0x80108a49
801079a6:	e8 85 8c ff ff       	call   80100630 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801079ab:	83 c4 10             	add    $0x10,%esp
801079ae:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801079b1:	76 4b                	jbe    801079fe <allocuvm+0xde>
801079b3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801079b6:	8b 45 08             	mov    0x8(%ebp),%eax
801079b9:	89 fa                	mov    %edi,%edx
801079bb:	e8 50 fb ff ff       	call   80107510 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
801079c0:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
801079c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079c5:	5b                   	pop    %ebx
801079c6:	5e                   	pop    %esi
801079c7:	5f                   	pop    %edi
801079c8:	5d                   	pop    %ebp
801079c9:	c3                   	ret    
801079ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
801079d0:	83 ec 0c             	sub    $0xc,%esp
801079d3:	68 61 8a 10 80       	push   $0x80108a61
801079d8:	e8 53 8c ff ff       	call   80100630 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801079dd:	83 c4 10             	add    $0x10,%esp
801079e0:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801079e3:	76 0d                	jbe    801079f2 <allocuvm+0xd2>
801079e5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801079e8:	8b 45 08             	mov    0x8(%ebp),%eax
801079eb:	89 fa                	mov    %edi,%edx
801079ed:	e8 1e fb ff ff       	call   80107510 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
801079f2:	83 ec 0c             	sub    $0xc,%esp
801079f5:	56                   	push   %esi
801079f6:	e8 a5 b6 ff ff       	call   801030a0 <kfree>
      return 0;
801079fb:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
801079fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80107a01:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80107a03:	5b                   	pop    %ebx
80107a04:	5e                   	pop    %esi
80107a05:	5f                   	pop    %edi
80107a06:	5d                   	pop    %ebp
80107a07:	c3                   	ret    
80107a08:	90                   	nop
80107a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a10:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107a13:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80107a15:	5b                   	pop    %ebx
80107a16:	5e                   	pop    %esi
80107a17:	5f                   	pop    %edi
80107a18:	5d                   	pop    %ebp
80107a19:	c3                   	ret    
80107a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107a20 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107a20:	55                   	push   %ebp
80107a21:	89 e5                	mov    %esp,%ebp
80107a23:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a26:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107a29:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80107a2c:	39 d1                	cmp    %edx,%ecx
80107a2e:	73 10                	jae    80107a40 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107a30:	5d                   	pop    %ebp
80107a31:	e9 da fa ff ff       	jmp    80107510 <deallocuvm.part.0>
80107a36:	8d 76 00             	lea    0x0(%esi),%esi
80107a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107a40:	89 d0                	mov    %edx,%eax
80107a42:	5d                   	pop    %ebp
80107a43:	c3                   	ret    
80107a44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107a50 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107a50:	55                   	push   %ebp
80107a51:	89 e5                	mov    %esp,%ebp
80107a53:	57                   	push   %edi
80107a54:	56                   	push   %esi
80107a55:	53                   	push   %ebx
80107a56:	83 ec 0c             	sub    $0xc,%esp
80107a59:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107a5c:	85 f6                	test   %esi,%esi
80107a5e:	74 59                	je     80107ab9 <freevm+0x69>
80107a60:	31 c9                	xor    %ecx,%ecx
80107a62:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107a67:	89 f0                	mov    %esi,%eax
80107a69:	e8 a2 fa ff ff       	call   80107510 <deallocuvm.part.0>
80107a6e:	89 f3                	mov    %esi,%ebx
80107a70:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107a76:	eb 0f                	jmp    80107a87 <freevm+0x37>
80107a78:	90                   	nop
80107a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a80:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107a83:	39 fb                	cmp    %edi,%ebx
80107a85:	74 23                	je     80107aaa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107a87:	8b 03                	mov    (%ebx),%eax
80107a89:	a8 01                	test   $0x1,%al
80107a8b:	74 f3                	je     80107a80 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80107a8d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107a92:	83 ec 0c             	sub    $0xc,%esp
80107a95:	83 c3 04             	add    $0x4,%ebx
80107a98:	05 00 00 00 80       	add    $0x80000000,%eax
80107a9d:	50                   	push   %eax
80107a9e:	e8 fd b5 ff ff       	call   801030a0 <kfree>
80107aa3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107aa6:	39 fb                	cmp    %edi,%ebx
80107aa8:	75 dd                	jne    80107a87 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80107aaa:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107aad:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ab0:	5b                   	pop    %ebx
80107ab1:	5e                   	pop    %esi
80107ab2:	5f                   	pop    %edi
80107ab3:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80107ab4:	e9 e7 b5 ff ff       	jmp    801030a0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80107ab9:	83 ec 0c             	sub    $0xc,%esp
80107abc:	68 7d 8a 10 80       	push   $0x80108a7d
80107ac1:	e8 fa 8c ff ff       	call   801007c0 <panic>
80107ac6:	8d 76 00             	lea    0x0(%esi),%esi
80107ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107ad0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107ad0:	55                   	push   %ebp
80107ad1:	89 e5                	mov    %esp,%ebp
80107ad3:	56                   	push   %esi
80107ad4:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107ad5:	e8 76 b7 ff ff       	call   80103250 <kalloc>
80107ada:	85 c0                	test   %eax,%eax
80107adc:	74 6a                	je     80107b48 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
80107ade:	83 ec 04             	sub    $0x4,%esp
80107ae1:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107ae3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80107ae8:	68 00 10 00 00       	push   $0x1000
80107aed:	6a 00                	push   $0x0
80107aef:	50                   	push   %eax
80107af0:	e8 db d6 ff ff       	call   801051d0 <memset>
80107af5:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107af8:	8b 43 04             	mov    0x4(%ebx),%eax
80107afb:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107afe:	83 ec 08             	sub    $0x8,%esp
80107b01:	8b 13                	mov    (%ebx),%edx
80107b03:	ff 73 0c             	pushl  0xc(%ebx)
80107b06:	50                   	push   %eax
80107b07:	29 c1                	sub    %eax,%ecx
80107b09:	89 f0                	mov    %esi,%eax
80107b0b:	e8 70 f9 ff ff       	call   80107480 <mappages>
80107b10:	83 c4 10             	add    $0x10,%esp
80107b13:	85 c0                	test   %eax,%eax
80107b15:	78 19                	js     80107b30 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107b17:	83 c3 10             	add    $0x10,%ebx
80107b1a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107b20:	75 d6                	jne    80107af8 <setupkvm+0x28>
80107b22:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80107b24:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107b27:	5b                   	pop    %ebx
80107b28:	5e                   	pop    %esi
80107b29:	5d                   	pop    %ebp
80107b2a:	c3                   	ret    
80107b2b:	90                   	nop
80107b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80107b30:	83 ec 0c             	sub    $0xc,%esp
80107b33:	56                   	push   %esi
80107b34:	e8 17 ff ff ff       	call   80107a50 <freevm>
      return 0;
80107b39:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
80107b3c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
80107b3f:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80107b41:	5b                   	pop    %ebx
80107b42:	5e                   	pop    %esi
80107b43:	5d                   	pop    %ebp
80107b44:	c3                   	ret    
80107b45:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80107b48:	31 c0                	xor    %eax,%eax
80107b4a:	eb d8                	jmp    80107b24 <setupkvm+0x54>
80107b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107b50 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107b50:	55                   	push   %ebp
80107b51:	89 e5                	mov    %esp,%ebp
80107b53:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107b56:	e8 75 ff ff ff       	call   80107ad0 <setupkvm>
80107b5b:	a3 44 78 12 80       	mov    %eax,0x80127844
80107b60:	05 00 00 00 80       	add    $0x80000000,%eax
80107b65:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80107b68:	c9                   	leave  
80107b69:	c3                   	ret    
80107b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107b70 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107b70:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107b71:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107b73:	89 e5                	mov    %esp,%ebp
80107b75:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107b78:	8b 55 0c             	mov    0xc(%ebp),%edx
80107b7b:	8b 45 08             	mov    0x8(%ebp),%eax
80107b7e:	e8 7d f8 ff ff       	call   80107400 <walkpgdir>
  if(pte == 0)
80107b83:	85 c0                	test   %eax,%eax
80107b85:	74 05                	je     80107b8c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107b87:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107b8a:	c9                   	leave  
80107b8b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107b8c:	83 ec 0c             	sub    $0xc,%esp
80107b8f:	68 8e 8a 10 80       	push   $0x80108a8e
80107b94:	e8 27 8c ff ff       	call   801007c0 <panic>
80107b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107ba0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107ba0:	55                   	push   %ebp
80107ba1:	89 e5                	mov    %esp,%ebp
80107ba3:	57                   	push   %edi
80107ba4:	56                   	push   %esi
80107ba5:	53                   	push   %ebx
80107ba6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107ba9:	e8 22 ff ff ff       	call   80107ad0 <setupkvm>
80107bae:	85 c0                	test   %eax,%eax
80107bb0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107bb3:	0f 84 b2 00 00 00    	je     80107c6b <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107bb9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107bbc:	85 c9                	test   %ecx,%ecx
80107bbe:	0f 84 9c 00 00 00    	je     80107c60 <copyuvm+0xc0>
80107bc4:	31 f6                	xor    %esi,%esi
80107bc6:	eb 4a                	jmp    80107c12 <copyuvm+0x72>
80107bc8:	90                   	nop
80107bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107bd0:	83 ec 04             	sub    $0x4,%esp
80107bd3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107bd9:	68 00 10 00 00       	push   $0x1000
80107bde:	57                   	push   %edi
80107bdf:	50                   	push   %eax
80107be0:	e8 9b d6 ff ff       	call   80105280 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107be5:	58                   	pop    %eax
80107be6:	5a                   	pop    %edx
80107be7:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
80107bed:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107bf0:	ff 75 e4             	pushl  -0x1c(%ebp)
80107bf3:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107bf8:	52                   	push   %edx
80107bf9:	89 f2                	mov    %esi,%edx
80107bfb:	e8 80 f8 ff ff       	call   80107480 <mappages>
80107c00:	83 c4 10             	add    $0x10,%esp
80107c03:	85 c0                	test   %eax,%eax
80107c05:	78 3e                	js     80107c45 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107c07:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107c0d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107c10:	76 4e                	jbe    80107c60 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107c12:	8b 45 08             	mov    0x8(%ebp),%eax
80107c15:	31 c9                	xor    %ecx,%ecx
80107c17:	89 f2                	mov    %esi,%edx
80107c19:	e8 e2 f7 ff ff       	call   80107400 <walkpgdir>
80107c1e:	85 c0                	test   %eax,%eax
80107c20:	74 5a                	je     80107c7c <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107c22:	8b 18                	mov    (%eax),%ebx
80107c24:	f6 c3 01             	test   $0x1,%bl
80107c27:	74 46                	je     80107c6f <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107c29:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
80107c2b:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80107c31:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107c34:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80107c3a:	e8 11 b6 ff ff       	call   80103250 <kalloc>
80107c3f:	85 c0                	test   %eax,%eax
80107c41:	89 c3                	mov    %eax,%ebx
80107c43:	75 8b                	jne    80107bd0 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80107c45:	83 ec 0c             	sub    $0xc,%esp
80107c48:	ff 75 e0             	pushl  -0x20(%ebp)
80107c4b:	e8 00 fe ff ff       	call   80107a50 <freevm>
  return 0;
80107c50:	83 c4 10             	add    $0x10,%esp
80107c53:	31 c0                	xor    %eax,%eax
}
80107c55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c58:	5b                   	pop    %ebx
80107c59:	5e                   	pop    %esi
80107c5a:	5f                   	pop    %edi
80107c5b:	5d                   	pop    %ebp
80107c5c:	c3                   	ret    
80107c5d:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107c60:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80107c63:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c66:	5b                   	pop    %ebx
80107c67:	5e                   	pop    %esi
80107c68:	5f                   	pop    %edi
80107c69:	5d                   	pop    %ebp
80107c6a:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
80107c6b:	31 c0                	xor    %eax,%eax
80107c6d:	eb e6                	jmp    80107c55 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80107c6f:	83 ec 0c             	sub    $0xc,%esp
80107c72:	68 b2 8a 10 80       	push   $0x80108ab2
80107c77:	e8 44 8b ff ff       	call   801007c0 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80107c7c:	83 ec 0c             	sub    $0xc,%esp
80107c7f:	68 98 8a 10 80       	push   $0x80108a98
80107c84:	e8 37 8b ff ff       	call   801007c0 <panic>
80107c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107c90 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107c90:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107c91:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107c93:	89 e5                	mov    %esp,%ebp
80107c95:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107c98:	8b 55 0c             	mov    0xc(%ebp),%edx
80107c9b:	8b 45 08             	mov    0x8(%ebp),%eax
80107c9e:	e8 5d f7 ff ff       	call   80107400 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107ca3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107ca5:	89 c2                	mov    %eax,%edx
80107ca7:	83 e2 05             	and    $0x5,%edx
80107caa:	83 fa 05             	cmp    $0x5,%edx
80107cad:	75 11                	jne    80107cc0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107caf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107cb4:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107cb5:	05 00 00 00 80       	add    $0x80000000,%eax
}
80107cba:	c3                   	ret    
80107cbb:	90                   	nop
80107cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80107cc0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80107cc2:	c9                   	leave  
80107cc3:	c3                   	ret    
80107cc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107cca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107cd0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107cd0:	55                   	push   %ebp
80107cd1:	89 e5                	mov    %esp,%ebp
80107cd3:	57                   	push   %edi
80107cd4:	56                   	push   %esi
80107cd5:	53                   	push   %ebx
80107cd6:	83 ec 1c             	sub    $0x1c,%esp
80107cd9:	8b 5d 14             	mov    0x14(%ebp),%ebx
80107cdc:	8b 55 0c             	mov    0xc(%ebp),%edx
80107cdf:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107ce2:	85 db                	test   %ebx,%ebx
80107ce4:	75 40                	jne    80107d26 <copyout+0x56>
80107ce6:	eb 70                	jmp    80107d58 <copyout+0x88>
80107ce8:	90                   	nop
80107ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107cf0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107cf3:	89 f1                	mov    %esi,%ecx
80107cf5:	29 d1                	sub    %edx,%ecx
80107cf7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80107cfd:	39 d9                	cmp    %ebx,%ecx
80107cff:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107d02:	29 f2                	sub    %esi,%edx
80107d04:	83 ec 04             	sub    $0x4,%esp
80107d07:	01 d0                	add    %edx,%eax
80107d09:	51                   	push   %ecx
80107d0a:	57                   	push   %edi
80107d0b:	50                   	push   %eax
80107d0c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107d0f:	e8 6c d5 ff ff       	call   80105280 <memmove>
    len -= n;
    buf += n;
80107d14:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107d17:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80107d1a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107d20:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107d22:	29 cb                	sub    %ecx,%ebx
80107d24:	74 32                	je     80107d58 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107d26:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107d28:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80107d2b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107d2e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107d34:	56                   	push   %esi
80107d35:	ff 75 08             	pushl  0x8(%ebp)
80107d38:	e8 53 ff ff ff       	call   80107c90 <uva2ka>
    if(pa0 == 0)
80107d3d:	83 c4 10             	add    $0x10,%esp
80107d40:	85 c0                	test   %eax,%eax
80107d42:	75 ac                	jne    80107cf0 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107d44:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107d47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107d4c:	5b                   	pop    %ebx
80107d4d:	5e                   	pop    %esi
80107d4e:	5f                   	pop    %edi
80107d4f:	5d                   	pop    %ebp
80107d50:	c3                   	ret    
80107d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d58:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80107d5b:	31 c0                	xor    %eax,%eax
}
80107d5d:	5b                   	pop    %ebx
80107d5e:	5e                   	pop    %esi
80107d5f:	5f                   	pop    %edi
80107d60:	5d                   	pop    %ebp
80107d61:	c3                   	ret    
