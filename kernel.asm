
kernel：     文件格式 elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 10 c6 10 80       	mov    $0x8010c610,%esp
8010002d:	b8 70 3d 10 80       	mov    $0x80103d70,%eax
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
8010004c:	68 c0 7e 10 80       	push   $0x80107ec0
80100051:	68 20 c6 10 80       	push   $0x8010c620
80100056:	e8 55 50 00 00       	call   801050b0 <initlock>

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
80100092:	68 c7 7e 10 80       	push   $0x80107ec7
80100097:	50                   	push   %eax
80100098:	e8 03 4f 00 00       	call   80104fa0 <initsleeplock>
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
801000e4:	e8 c7 50 00 00       	call   801051b0 <acquire>

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
80100162:	e8 69 51 00 00       	call   801052d0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 4e 00 00       	call   80104fe0 <acquiresleep>
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
8010017e:	e8 7d 2e 00 00       	call   80103000 <iderw>
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
80100193:	68 ce 7e 10 80       	push   $0x80107ece
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
801001ae:	e8 cd 4e 00 00       	call   80105080 <holdingsleep>
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
801001c4:	e9 37 2e 00 00       	jmp    80103000 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 df 7e 10 80       	push   $0x80107edf
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
801001ef:	e8 8c 4e 00 00       	call   80105080 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 3c 4e 00 00       	call   80105040 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 20 c6 10 80 	movl   $0x8010c620,(%esp)
8010020b:	e8 a0 4f 00 00       	call   801051b0 <acquire>
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
8010025c:	e9 6f 50 00 00       	jmp    801052d0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 e6 7e 10 80       	push   $0x80107ee6
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
80100280:	e8 ab 23 00 00       	call   80102630 <iunlock>
  target = n;
  acquire(&input.lock);
80100285:	c7 04 24 80 0f 11 80 	movl   $0x80110f80,(%esp)
8010028c:	e8 1f 4f 00 00       	call   801051b0 <acquire>
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
801002bd:	e8 7e 49 00 00       	call   80104c40 <sleep>

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
801002d2:	e8 b9 43 00 00       	call   80104690 <myproc>
801002d7:	8b 40 24             	mov    0x24(%eax),%eax
801002da:	85 c0                	test   %eax,%eax
801002dc:	74 d2                	je     801002b0 <consoleread+0x40>
        release(&input.lock);
801002de:	83 ec 0c             	sub    $0xc,%esp
801002e1:	68 80 0f 11 80       	push   $0x80110f80
801002e6:	e8 e5 4f 00 00       	call   801052d0 <release>
        ilock(ip);
801002eb:	89 3c 24             	mov    %edi,(%esp)
801002ee:	e8 5d 22 00 00       	call   80102550 <ilock>
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
80100346:	e8 85 4f 00 00       	call   801052d0 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 fd 21 00 00       	call   80102550 <ilock>

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
801004d1:	e8 fa 4e 00 00       	call   801053d0 <memmove>
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
801004e9:	e8 32 4e 00 00       	call   80105320 <memset>
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
80100564:	e8 27 65 00 00       	call   80106a90 <uartputc>
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
8010057c:	e8 0f 65 00 00       	call   80106a90 <uartputc>
80100581:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100588:	e8 03 65 00 00       	call   80106a90 <uartputc>
8010058d:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100594:	e8 f7 64 00 00       	call   80106a90 <uartputc>
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
801005e1:	0f b6 92 b8 82 10 80 	movzbl -0x7fef7d48(%edx),%edx
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
801006dd:	e8 ee 4b 00 00       	call   801052d0 <release>
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
80100758:	b8 ed 7e 10 80       	mov    $0x80107eed,%eax
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
80100798:	e8 13 4a 00 00       	call   801051b0 <acquire>
8010079d:	83 c4 10             	add    $0x10,%esp
801007a0:	e9 a4 fe ff ff       	jmp    80100649 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007a5:	83 ec 0c             	sub    $0xc,%esp
801007a8:	68 f4 7e 10 80       	push   $0x80107ef4
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
801007e1:	c7 04 24 bb 8b 10 80 	movl   $0x80108bbb,(%esp)
801007e8:	e8 43 fe ff ff       	call   80100630 <cprintf>
  getcallerpcs(&s, pcs);
801007ed:	58                   	pop    %eax
801007ee:	8d 45 08             	lea    0x8(%ebp),%eax
801007f1:	5a                   	pop    %edx
801007f2:	53                   	push   %ebx
801007f3:	50                   	push   %eax
801007f4:	e8 d7 48 00 00       	call   801050d0 <getcallerpcs>
801007f9:	83 c4 10             	add    $0x10,%esp
801007fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
80100800:	83 ec 08             	sub    $0x8,%esp
80100803:	ff 33                	pushl  (%ebx)
80100805:	83 c3 04             	add    $0x4,%ebx
80100808:	68 fd 7e 10 80       	push   $0x80107efd
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
8010083f:	e8 ec 1d 00 00       	call   80102630 <iunlock>
  acquire(&cons.lock);
80100844:	c7 04 24 60 b5 10 80 	movl   $0x8010b560,(%esp)
8010084b:	e8 60 49 00 00       	call   801051b0 <acquire>
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
80100877:	e8 54 4a 00 00       	call   801052d0 <release>
  ilock(ip);
8010087c:	58                   	pop    %eax
8010087d:	ff 75 08             	pushl  0x8(%ebp)
80100880:	e8 cb 1c 00 00       	call   80102550 <ilock>

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
80100c0b:	e8 c0 47 00 00       	call   801053d0 <memmove>
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
80100c27:	e8 f4 46 00 00       	call   80105320 <memset>
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
80100f62:	e8 49 42 00 00       	call   801051b0 <acquire>
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
80100fe2:	e8 e9 42 00 00       	call   801052d0 <release>
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
8010103e:	e8 1d 45 00 00       	call   80105560 <strlen>
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
80101091:	e8 ca 44 00 00       	call   80105560 <strlen>
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
801010f1:	e9 9a 59 00 00       	jmp    80106a90 <uartputc>
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
801011c9:	e8 e2 3f 00 00       	call   801051b0 <acquire>
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
80101241:	ff 24 85 10 7f 10 80 	jmp    *-0x7fef80f0(,%eax,4)
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
80101293:	e9 38 40 00 00       	jmp    801052d0 <release>
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
801012cc:	e8 1f 3b 00 00       	call   80104df0 <wakeup>
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
80101420:	e8 bb 3a 00 00       	call   80104ee0 <procdump>
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
80101458:	e8 c3 3e 00 00       	call   80105320 <memset>
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
8010157e:	e8 6d 38 00 00       	call   80104df0 <wakeup>
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
801016bd:	e8 ee 3a 00 00       	call   801051b0 <acquire>
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
80101756:	68 01 7f 10 80       	push   $0x80107f01
8010175b:	68 60 b5 10 80       	push   $0x8010b560
80101760:	e8 4b 39 00 00       	call   801050b0 <initlock>
  initlock(&input.lock, "input");
80101765:	58                   	pop    %eax
80101766:	5a                   	pop    %edx
80101767:	68 09 7f 10 80       	push   $0x80107f09
8010176c:	68 80 0f 11 80       	push   $0x80110f80
80101771:	e8 3a 39 00 00       	call   801050b0 <initlock>
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
8010179a:	e8 11 1a 00 00       	call   801031b0 <ioapicenable>
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

801017b0 <datetime>:
#include "proc.h"
#include "x86.h"


void datetime(void* date)
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
  cmostime(date);
}
801017b3:	5d                   	pop    %ebp
#include "x86.h"


void datetime(void* date)
{
  cmostime(date);
801017b4:	e9 27 1f 00 00       	jmp    801036e0 <cmostime>
801017b9:	66 90                	xchg   %ax,%ax
801017bb:	66 90                	xchg   %ax,%ax
801017bd:	66 90                	xchg   %ax,%ax
801017bf:	90                   	nop

801017c0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	57                   	push   %edi
801017c4:	56                   	push   %esi
801017c5:	53                   	push   %ebx
801017c6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801017cc:	e8 bf 2e 00 00       	call   80104690 <myproc>
801017d1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801017d7:	e8 84 22 00 00       	call   80103a60 <begin_op>

  if((ip = namei(path)) == 0){
801017dc:	83 ec 0c             	sub    $0xc,%esp
801017df:	ff 75 08             	pushl  0x8(%ebp)
801017e2:	e8 e9 15 00 00       	call   80102dd0 <namei>
801017e7:	83 c4 10             	add    $0x10,%esp
801017ea:	85 c0                	test   %eax,%eax
801017ec:	0f 84 9c 01 00 00    	je     8010198e <exec+0x1ce>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801017f2:	83 ec 0c             	sub    $0xc,%esp
801017f5:	89 c3                	mov    %eax,%ebx
801017f7:	50                   	push   %eax
801017f8:	e8 53 0d 00 00       	call   80102550 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
801017fd:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101803:	6a 34                	push   $0x34
80101805:	6a 00                	push   $0x0
80101807:	50                   	push   %eax
80101808:	53                   	push   %ebx
80101809:	e8 32 10 00 00       	call   80102840 <readi>
8010180e:	83 c4 20             	add    $0x20,%esp
80101811:	83 f8 34             	cmp    $0x34,%eax
80101814:	74 22                	je     80101838 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80101816:	83 ec 0c             	sub    $0xc,%esp
80101819:	53                   	push   %ebx
8010181a:	e8 c1 0f 00 00       	call   801027e0 <iunlockput>
    end_op();
8010181f:	e8 ac 22 00 00       	call   80103ad0 <end_op>
80101824:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80101827:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010182c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010182f:	5b                   	pop    %ebx
80101830:	5e                   	pop    %esi
80101831:	5f                   	pop    %edi
80101832:	5d                   	pop    %ebp
80101833:	c3                   	ret    
80101834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80101838:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
8010183f:	45 4c 46 
80101842:	75 d2                	jne    80101816 <exec+0x56>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80101844:	e8 d7 63 00 00       	call   80107c20 <setupkvm>
80101849:	85 c0                	test   %eax,%eax
8010184b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101851:	74 c3                	je     80101816 <exec+0x56>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101853:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
8010185a:	00 
8010185b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101861:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80101868:	00 00 00 
8010186b:	0f 84 c5 00 00 00    	je     80101936 <exec+0x176>
80101871:	31 ff                	xor    %edi,%edi
80101873:	eb 18                	jmp    8010188d <exec+0xcd>
80101875:	8d 76 00             	lea    0x0(%esi),%esi
80101878:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
8010187f:	83 c7 01             	add    $0x1,%edi
80101882:	83 c6 20             	add    $0x20,%esi
80101885:	39 f8                	cmp    %edi,%eax
80101887:	0f 8e a9 00 00 00    	jle    80101936 <exec+0x176>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
8010188d:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80101893:	6a 20                	push   $0x20
80101895:	56                   	push   %esi
80101896:	50                   	push   %eax
80101897:	53                   	push   %ebx
80101898:	e8 a3 0f 00 00       	call   80102840 <readi>
8010189d:	83 c4 10             	add    $0x10,%esp
801018a0:	83 f8 20             	cmp    $0x20,%eax
801018a3:	75 7b                	jne    80101920 <exec+0x160>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
801018a5:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
801018ac:	75 ca                	jne    80101878 <exec+0xb8>
      continue;
    if(ph.memsz < ph.filesz)
801018ae:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
801018b4:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
801018ba:	72 64                	jb     80101920 <exec+0x160>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
801018bc:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801018c2:	72 5c                	jb     80101920 <exec+0x160>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801018c4:	83 ec 04             	sub    $0x4,%esp
801018c7:	50                   	push   %eax
801018c8:	ff b5 ec fe ff ff    	pushl  -0x114(%ebp)
801018ce:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
801018d4:	e8 97 61 00 00       	call   80107a70 <allocuvm>
801018d9:	83 c4 10             	add    $0x10,%esp
801018dc:	85 c0                	test   %eax,%eax
801018de:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
801018e4:	74 3a                	je     80101920 <exec+0x160>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
801018e6:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
801018ec:	a9 ff 0f 00 00       	test   $0xfff,%eax
801018f1:	75 2d                	jne    80101920 <exec+0x160>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
801018f3:	83 ec 0c             	sub    $0xc,%esp
801018f6:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
801018fc:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80101902:	53                   	push   %ebx
80101903:	50                   	push   %eax
80101904:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
8010190a:	e8 a1 60 00 00       	call   801079b0 <loaduvm>
8010190f:	83 c4 20             	add    $0x20,%esp
80101912:	85 c0                	test   %eax,%eax
80101914:	0f 89 5e ff ff ff    	jns    80101878 <exec+0xb8>
8010191a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80101920:	83 ec 0c             	sub    $0xc,%esp
80101923:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80101929:	e8 72 62 00 00       	call   80107ba0 <freevm>
8010192e:	83 c4 10             	add    $0x10,%esp
80101931:	e9 e0 fe ff ff       	jmp    80101816 <exec+0x56>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80101936:	83 ec 0c             	sub    $0xc,%esp
80101939:	53                   	push   %ebx
8010193a:	e8 a1 0e 00 00       	call   801027e0 <iunlockput>
  end_op();
8010193f:	e8 8c 21 00 00       	call   80103ad0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80101944:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
8010194a:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
8010194d:	05 ff 0f 00 00       	add    $0xfff,%eax
80101952:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101957:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
8010195d:	52                   	push   %edx
8010195e:	50                   	push   %eax
8010195f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80101965:	e8 06 61 00 00       	call   80107a70 <allocuvm>
8010196a:	83 c4 10             	add    $0x10,%esp
8010196d:	85 c0                	test   %eax,%eax
8010196f:	89 c6                	mov    %eax,%esi
80101971:	75 3a                	jne    801019ad <exec+0x1ed>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80101973:	83 ec 0c             	sub    $0xc,%esp
80101976:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
8010197c:	e8 1f 62 00 00       	call   80107ba0 <freevm>
80101981:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80101984:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101989:	e9 9e fe ff ff       	jmp    8010182c <exec+0x6c>
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
8010198e:	e8 3d 21 00 00       	call   80103ad0 <end_op>
    cprintf("exec: fail\n");
80101993:	83 ec 0c             	sub    $0xc,%esp
80101996:	68 c9 82 10 80       	push   $0x801082c9
8010199b:	e8 90 ec ff ff       	call   80100630 <cprintf>
    return -1;
801019a0:	83 c4 10             	add    $0x10,%esp
801019a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801019a8:	e9 7f fe ff ff       	jmp    8010182c <exec+0x6c>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801019ad:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
801019b3:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
801019b6:	31 ff                	xor    %edi,%edi
801019b8:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801019ba:	50                   	push   %eax
801019bb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
801019c1:	e8 fa 62 00 00       	call   80107cc0 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
801019c6:	8b 45 0c             	mov    0xc(%ebp),%eax
801019c9:	83 c4 10             	add    $0x10,%esp
801019cc:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
801019d2:	8b 00                	mov    (%eax),%eax
801019d4:	85 c0                	test   %eax,%eax
801019d6:	74 79                	je     80101a51 <exec+0x291>
801019d8:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
801019de:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
801019e4:	eb 13                	jmp    801019f9 <exec+0x239>
801019e6:	8d 76 00             	lea    0x0(%esi),%esi
801019e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(argc >= MAXARG)
801019f0:	83 ff 20             	cmp    $0x20,%edi
801019f3:	0f 84 7a ff ff ff    	je     80101973 <exec+0x1b3>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801019f9:	83 ec 0c             	sub    $0xc,%esp
801019fc:	50                   	push   %eax
801019fd:	e8 5e 3b 00 00       	call   80105560 <strlen>
80101a02:	f7 d0                	not    %eax
80101a04:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101a06:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a09:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101a0a:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101a0d:	ff 34 b8             	pushl  (%eax,%edi,4)
80101a10:	e8 4b 3b 00 00       	call   80105560 <strlen>
80101a15:	83 c0 01             	add    $0x1,%eax
80101a18:	50                   	push   %eax
80101a19:	8b 45 0c             	mov    0xc(%ebp),%eax
80101a1c:	ff 34 b8             	pushl  (%eax,%edi,4)
80101a1f:	53                   	push   %ebx
80101a20:	56                   	push   %esi
80101a21:	e8 fa 63 00 00       	call   80107e20 <copyout>
80101a26:	83 c4 20             	add    $0x20,%esp
80101a29:	85 c0                	test   %eax,%eax
80101a2b:	0f 88 42 ff ff ff    	js     80101973 <exec+0x1b3>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80101a31:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80101a34:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80101a3b:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80101a3e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80101a44:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101a47:	85 c0                	test   %eax,%eax
80101a49:	75 a5                	jne    801019f0 <exec+0x230>
80101a4b:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101a51:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80101a58:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80101a5a:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80101a61:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80101a65:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80101a6c:	ff ff ff 
  ustack[1] = argc;
80101a6f:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101a75:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80101a77:	83 c0 0c             	add    $0xc,%eax
80101a7a:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101a7c:	50                   	push   %eax
80101a7d:	52                   	push   %edx
80101a7e:	53                   	push   %ebx
80101a7f:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101a85:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101a8b:	e8 90 63 00 00       	call   80107e20 <copyout>
80101a90:	83 c4 10             	add    $0x10,%esp
80101a93:	85 c0                	test   %eax,%eax
80101a95:	0f 88 d8 fe ff ff    	js     80101973 <exec+0x1b3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80101a9b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9e:	0f b6 10             	movzbl (%eax),%edx
80101aa1:	84 d2                	test   %dl,%dl
80101aa3:	74 19                	je     80101abe <exec+0x2fe>
80101aa5:	8b 4d 08             	mov    0x8(%ebp),%ecx
80101aa8:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80101aab:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80101aae:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80101ab1:	0f 44 c8             	cmove  %eax,%ecx
80101ab4:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80101ab7:	84 d2                	test   %dl,%dl
80101ab9:	75 f0                	jne    80101aab <exec+0x2eb>
80101abb:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80101abe:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101ac4:	50                   	push   %eax
80101ac5:	6a 10                	push   $0x10
80101ac7:	ff 75 08             	pushl  0x8(%ebp)
80101aca:	89 f8                	mov    %edi,%eax
80101acc:	83 c0 6c             	add    $0x6c,%eax
80101acf:	50                   	push   %eax
80101ad0:	e8 4b 3a 00 00       	call   80105520 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80101ad5:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80101adb:	89 f8                	mov    %edi,%eax
80101add:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->pgdir = pgdir;
  curproc->sz = sz;
80101ae0:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
80101ae2:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80101ae5:	89 c1                	mov    %eax,%ecx
80101ae7:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80101aed:	8b 40 18             	mov    0x18(%eax),%eax
80101af0:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101af3:	8b 41 18             	mov    0x18(%ecx),%eax
80101af6:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80101af9:	89 0c 24             	mov    %ecx,(%esp)
80101afc:	e8 1f 5d 00 00       	call   80107820 <switchuvm>
  freevm(oldpgdir);
80101b01:	89 3c 24             	mov    %edi,(%esp)
80101b04:	e8 97 60 00 00       	call   80107ba0 <freevm>
  return 0;
80101b09:	83 c4 10             	add    $0x10,%esp
80101b0c:	31 c0                	xor    %eax,%eax
80101b0e:	e9 19 fd ff ff       	jmp    8010182c <exec+0x6c>
80101b13:	66 90                	xchg   %ax,%ax
80101b15:	66 90                	xchg   %ax,%ax
80101b17:	66 90                	xchg   %ax,%ax
80101b19:	66 90                	xchg   %ax,%ax
80101b1b:	66 90                	xchg   %ax,%ax
80101b1d:	66 90                	xchg   %ax,%ax
80101b1f:	90                   	nop

80101b20 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101b20:	55                   	push   %ebp
80101b21:	89 e5                	mov    %esp,%ebp
80101b23:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101b26:	68 d5 82 10 80       	push   $0x801082d5
80101b2b:	68 60 23 12 80       	push   $0x80122360
80101b30:	e8 7b 35 00 00       	call   801050b0 <initlock>
}
80101b35:	83 c4 10             	add    $0x10,%esp
80101b38:	c9                   	leave  
80101b39:	c3                   	ret    
80101b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101b40 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101b44:	bb 94 23 12 80       	mov    $0x80122394,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80101b49:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80101b4c:	68 60 23 12 80       	push   $0x80122360
80101b51:	e8 5a 36 00 00       	call   801051b0 <acquire>
80101b56:	83 c4 10             	add    $0x10,%esp
80101b59:	eb 10                	jmp    80101b6b <filealloc+0x2b>
80101b5b:	90                   	nop
80101b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101b60:	83 c3 18             	add    $0x18,%ebx
80101b63:	81 fb f4 2c 12 80    	cmp    $0x80122cf4,%ebx
80101b69:	74 25                	je     80101b90 <filealloc+0x50>
    if(f->ref == 0){
80101b6b:	8b 43 04             	mov    0x4(%ebx),%eax
80101b6e:	85 c0                	test   %eax,%eax
80101b70:	75 ee                	jne    80101b60 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101b72:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80101b75:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80101b7c:	68 60 23 12 80       	push   $0x80122360
80101b81:	e8 4a 37 00 00       	call   801052d0 <release>
      return f;
80101b86:	89 d8                	mov    %ebx,%eax
80101b88:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80101b8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b8e:	c9                   	leave  
80101b8f:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80101b90:	83 ec 0c             	sub    $0xc,%esp
80101b93:	68 60 23 12 80       	push   $0x80122360
80101b98:	e8 33 37 00 00       	call   801052d0 <release>
  return 0;
80101b9d:	83 c4 10             	add    $0x10,%esp
80101ba0:	31 c0                	xor    %eax,%eax
}
80101ba2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101ba5:	c9                   	leave  
80101ba6:	c3                   	ret    
80101ba7:	89 f6                	mov    %esi,%esi
80101ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bb0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101bb0:	55                   	push   %ebp
80101bb1:	89 e5                	mov    %esp,%ebp
80101bb3:	53                   	push   %ebx
80101bb4:	83 ec 10             	sub    $0x10,%esp
80101bb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80101bba:	68 60 23 12 80       	push   $0x80122360
80101bbf:	e8 ec 35 00 00       	call   801051b0 <acquire>
  if(f->ref < 1)
80101bc4:	8b 43 04             	mov    0x4(%ebx),%eax
80101bc7:	83 c4 10             	add    $0x10,%esp
80101bca:	85 c0                	test   %eax,%eax
80101bcc:	7e 1a                	jle    80101be8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80101bce:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101bd1:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80101bd4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101bd7:	68 60 23 12 80       	push   $0x80122360
80101bdc:	e8 ef 36 00 00       	call   801052d0 <release>
  return f;
}
80101be1:	89 d8                	mov    %ebx,%eax
80101be3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101be6:	c9                   	leave  
80101be7:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80101be8:	83 ec 0c             	sub    $0xc,%esp
80101beb:	68 dc 82 10 80       	push   $0x801082dc
80101bf0:	e8 cb eb ff ff       	call   801007c0 <panic>
80101bf5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c00 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101c00:	55                   	push   %ebp
80101c01:	89 e5                	mov    %esp,%ebp
80101c03:	57                   	push   %edi
80101c04:	56                   	push   %esi
80101c05:	53                   	push   %ebx
80101c06:	83 ec 28             	sub    $0x28,%esp
80101c09:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80101c0c:	68 60 23 12 80       	push   $0x80122360
80101c11:	e8 9a 35 00 00       	call   801051b0 <acquire>
  if(f->ref < 1)
80101c16:	8b 47 04             	mov    0x4(%edi),%eax
80101c19:	83 c4 10             	add    $0x10,%esp
80101c1c:	85 c0                	test   %eax,%eax
80101c1e:	0f 8e 9b 00 00 00    	jle    80101cbf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80101c24:	83 e8 01             	sub    $0x1,%eax
80101c27:	85 c0                	test   %eax,%eax
80101c29:	89 47 04             	mov    %eax,0x4(%edi)
80101c2c:	74 1a                	je     80101c48 <fileclose+0x48>
    release(&ftable.lock);
80101c2e:	c7 45 08 60 23 12 80 	movl   $0x80122360,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101c35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c38:	5b                   	pop    %ebx
80101c39:	5e                   	pop    %esi
80101c3a:	5f                   	pop    %edi
80101c3b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80101c3c:	e9 8f 36 00 00       	jmp    801052d0 <release>
80101c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80101c48:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80101c4c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101c4e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101c51:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80101c54:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101c5a:	88 45 e7             	mov    %al,-0x19(%ebp)
80101c5d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101c60:	68 60 23 12 80       	push   $0x80122360
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80101c65:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101c68:	e8 63 36 00 00       	call   801052d0 <release>

  if(ff.type == FD_PIPE)
80101c6d:	83 c4 10             	add    $0x10,%esp
80101c70:	83 fb 01             	cmp    $0x1,%ebx
80101c73:	74 13                	je     80101c88 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101c75:	83 fb 02             	cmp    $0x2,%ebx
80101c78:	74 26                	je     80101ca0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101c7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c7d:	5b                   	pop    %ebx
80101c7e:	5e                   	pop    %esi
80101c7f:	5f                   	pop    %edi
80101c80:	5d                   	pop    %ebp
80101c81:	c3                   	ret    
80101c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80101c88:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101c8c:	83 ec 08             	sub    $0x8,%esp
80101c8f:	53                   	push   %ebx
80101c90:	56                   	push   %esi
80101c91:	e8 6a 25 00 00       	call   80104200 <pipeclose>
80101c96:	83 c4 10             	add    $0x10,%esp
80101c99:	eb df                	jmp    80101c7a <fileclose+0x7a>
80101c9b:	90                   	nop
80101c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80101ca0:	e8 bb 1d 00 00       	call   80103a60 <begin_op>
    iput(ff.ip);
80101ca5:	83 ec 0c             	sub    $0xc,%esp
80101ca8:	ff 75 e0             	pushl  -0x20(%ebp)
80101cab:	e8 d0 09 00 00       	call   80102680 <iput>
    end_op();
80101cb0:	83 c4 10             	add    $0x10,%esp
  }
}
80101cb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cb6:	5b                   	pop    %ebx
80101cb7:	5e                   	pop    %esi
80101cb8:	5f                   	pop    %edi
80101cb9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80101cba:	e9 11 1e 00 00       	jmp    80103ad0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80101cbf:	83 ec 0c             	sub    $0xc,%esp
80101cc2:	68 e4 82 10 80       	push   $0x801082e4
80101cc7:	e8 f4 ea ff ff       	call   801007c0 <panic>
80101ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101cd0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101cd0:	55                   	push   %ebp
80101cd1:	89 e5                	mov    %esp,%ebp
80101cd3:	53                   	push   %ebx
80101cd4:	83 ec 04             	sub    $0x4,%esp
80101cd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80101cda:	83 3b 02             	cmpl   $0x2,(%ebx)
80101cdd:	75 31                	jne    80101d10 <filestat+0x40>
    ilock(f->ip);
80101cdf:	83 ec 0c             	sub    $0xc,%esp
80101ce2:	ff 73 10             	pushl  0x10(%ebx)
80101ce5:	e8 66 08 00 00       	call   80102550 <ilock>
    stati(f->ip, st);
80101cea:	58                   	pop    %eax
80101ceb:	5a                   	pop    %edx
80101cec:	ff 75 0c             	pushl  0xc(%ebp)
80101cef:	ff 73 10             	pushl  0x10(%ebx)
80101cf2:	e8 09 0b 00 00       	call   80102800 <stati>
    iunlock(f->ip);
80101cf7:	59                   	pop    %ecx
80101cf8:	ff 73 10             	pushl  0x10(%ebx)
80101cfb:	e8 30 09 00 00       	call   80102630 <iunlock>
    return 0;
80101d00:	83 c4 10             	add    $0x10,%esp
80101d03:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80101d05:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d08:	c9                   	leave  
80101d09:	c3                   	ret    
80101d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80101d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101d15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101d18:	c9                   	leave  
80101d19:	c3                   	ret    
80101d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d20 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101d20:	55                   	push   %ebp
80101d21:	89 e5                	mov    %esp,%ebp
80101d23:	57                   	push   %edi
80101d24:	56                   	push   %esi
80101d25:	53                   	push   %ebx
80101d26:	83 ec 0c             	sub    $0xc,%esp
80101d29:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101d2c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101d2f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101d32:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101d36:	74 60                	je     80101d98 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101d38:	8b 03                	mov    (%ebx),%eax
80101d3a:	83 f8 01             	cmp    $0x1,%eax
80101d3d:	74 41                	je     80101d80 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101d3f:	83 f8 02             	cmp    $0x2,%eax
80101d42:	75 5b                	jne    80101d9f <fileread+0x7f>
    ilock(f->ip);
80101d44:	83 ec 0c             	sub    $0xc,%esp
80101d47:	ff 73 10             	pushl  0x10(%ebx)
80101d4a:	e8 01 08 00 00       	call   80102550 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101d4f:	57                   	push   %edi
80101d50:	ff 73 14             	pushl  0x14(%ebx)
80101d53:	56                   	push   %esi
80101d54:	ff 73 10             	pushl  0x10(%ebx)
80101d57:	e8 e4 0a 00 00       	call   80102840 <readi>
80101d5c:	83 c4 20             	add    $0x20,%esp
80101d5f:	85 c0                	test   %eax,%eax
80101d61:	89 c6                	mov    %eax,%esi
80101d63:	7e 03                	jle    80101d68 <fileread+0x48>
      f->off += r;
80101d65:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101d68:	83 ec 0c             	sub    $0xc,%esp
80101d6b:	ff 73 10             	pushl  0x10(%ebx)
80101d6e:	e8 bd 08 00 00       	call   80102630 <iunlock>
    return r;
80101d73:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101d76:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80101d78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d7b:	5b                   	pop    %ebx
80101d7c:	5e                   	pop    %esi
80101d7d:	5f                   	pop    %edi
80101d7e:	5d                   	pop    %ebp
80101d7f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101d80:	8b 43 0c             	mov    0xc(%ebx),%eax
80101d83:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80101d86:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d89:	5b                   	pop    %ebx
80101d8a:	5e                   	pop    %esi
80101d8b:	5f                   	pop    %edi
80101d8c:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101d8d:	e9 0e 26 00 00       	jmp    801043a0 <piperead>
80101d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80101d98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d9d:	eb d9                	jmp    80101d78 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80101d9f:	83 ec 0c             	sub    $0xc,%esp
80101da2:	68 ee 82 10 80       	push   $0x801082ee
80101da7:	e8 14 ea ff ff       	call   801007c0 <panic>
80101dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101db0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101db0:	55                   	push   %ebp
80101db1:	89 e5                	mov    %esp,%ebp
80101db3:	57                   	push   %edi
80101db4:	56                   	push   %esi
80101db5:	53                   	push   %ebx
80101db6:	83 ec 1c             	sub    $0x1c,%esp
80101db9:	8b 75 08             	mov    0x8(%ebp),%esi
80101dbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80101dbf:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101dc3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101dc6:	8b 45 10             	mov    0x10(%ebp),%eax
80101dc9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80101dcc:	0f 84 aa 00 00 00    	je     80101e7c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101dd2:	8b 06                	mov    (%esi),%eax
80101dd4:	83 f8 01             	cmp    $0x1,%eax
80101dd7:	0f 84 c2 00 00 00    	je     80101e9f <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101ddd:	83 f8 02             	cmp    $0x2,%eax
80101de0:	0f 85 d8 00 00 00    	jne    80101ebe <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101de6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101de9:	31 ff                	xor    %edi,%edi
80101deb:	85 c0                	test   %eax,%eax
80101ded:	7f 34                	jg     80101e23 <filewrite+0x73>
80101def:	e9 9c 00 00 00       	jmp    80101e90 <filewrite+0xe0>
80101df4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101df8:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
80101dfb:	83 ec 0c             	sub    $0xc,%esp
80101dfe:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101e01:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101e04:	e8 27 08 00 00       	call   80102630 <iunlock>
      end_op();
80101e09:	e8 c2 1c 00 00       	call   80103ad0 <end_op>
80101e0e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e11:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101e14:	39 d8                	cmp    %ebx,%eax
80101e16:	0f 85 95 00 00 00    	jne    80101eb1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
80101e1c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101e1e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101e21:	7e 6d                	jle    80101e90 <filewrite+0xe0>
      int n1 = n - i;
80101e23:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101e26:	b8 00 06 00 00       	mov    $0x600,%eax
80101e2b:	29 fb                	sub    %edi,%ebx
80101e2d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101e33:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101e36:	e8 25 1c 00 00       	call   80103a60 <begin_op>
      ilock(f->ip);
80101e3b:	83 ec 0c             	sub    $0xc,%esp
80101e3e:	ff 76 10             	pushl  0x10(%esi)
80101e41:	e8 0a 07 00 00       	call   80102550 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101e46:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e49:	53                   	push   %ebx
80101e4a:	ff 76 14             	pushl  0x14(%esi)
80101e4d:	01 f8                	add    %edi,%eax
80101e4f:	50                   	push   %eax
80101e50:	ff 76 10             	pushl  0x10(%esi)
80101e53:	e8 e8 0a 00 00       	call   80102940 <writei>
80101e58:	83 c4 20             	add    $0x20,%esp
80101e5b:	85 c0                	test   %eax,%eax
80101e5d:	7f 99                	jg     80101df8 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
80101e5f:	83 ec 0c             	sub    $0xc,%esp
80101e62:	ff 76 10             	pushl  0x10(%esi)
80101e65:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101e68:	e8 c3 07 00 00       	call   80102630 <iunlock>
      end_op();
80101e6d:	e8 5e 1c 00 00       	call   80103ad0 <end_op>

      if(r < 0)
80101e72:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e75:	83 c4 10             	add    $0x10,%esp
80101e78:	85 c0                	test   %eax,%eax
80101e7a:	74 98                	je     80101e14 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101e7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101e7f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101e84:	5b                   	pop    %ebx
80101e85:	5e                   	pop    %esi
80101e86:	5f                   	pop    %edi
80101e87:	5d                   	pop    %ebp
80101e88:	c3                   	ret    
80101e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101e90:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101e93:	75 e7                	jne    80101e7c <filewrite+0xcc>
  }
  panic("filewrite");
}
80101e95:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e98:	89 f8                	mov    %edi,%eax
80101e9a:	5b                   	pop    %ebx
80101e9b:	5e                   	pop    %esi
80101e9c:	5f                   	pop    %edi
80101e9d:	5d                   	pop    %ebp
80101e9e:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80101e9f:	8b 46 0c             	mov    0xc(%esi),%eax
80101ea2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101ea5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ea8:	5b                   	pop    %ebx
80101ea9:	5e                   	pop    %esi
80101eaa:	5f                   	pop    %edi
80101eab:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80101eac:	e9 ef 23 00 00       	jmp    801042a0 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80101eb1:	83 ec 0c             	sub    $0xc,%esp
80101eb4:	68 f7 82 10 80       	push   $0x801082f7
80101eb9:	e8 02 e9 ff ff       	call   801007c0 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
80101ebe:	83 ec 0c             	sub    $0xc,%esp
80101ec1:	68 fd 82 10 80       	push   $0x801082fd
80101ec6:	e8 f5 e8 ff ff       	call   801007c0 <panic>
80101ecb:	66 90                	xchg   %ax,%ax
80101ecd:	66 90                	xchg   %ax,%ax
80101ecf:	90                   	nop

80101ed0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101ed0:	55                   	push   %ebp
80101ed1:	89 e5                	mov    %esp,%ebp
80101ed3:	57                   	push   %edi
80101ed4:	56                   	push   %esi
80101ed5:	53                   	push   %ebx
80101ed6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101ed9:	8b 0d 60 2d 12 80    	mov    0x80122d60,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101edf:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101ee2:	85 c9                	test   %ecx,%ecx
80101ee4:	0f 84 85 00 00 00    	je     80101f6f <balloc+0x9f>
80101eea:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101ef1:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101ef4:	83 ec 08             	sub    $0x8,%esp
80101ef7:	89 f0                	mov    %esi,%eax
80101ef9:	c1 f8 0c             	sar    $0xc,%eax
80101efc:	03 05 78 2d 12 80    	add    0x80122d78,%eax
80101f02:	50                   	push   %eax
80101f03:	ff 75 d8             	pushl  -0x28(%ebp)
80101f06:	e8 c5 e1 ff ff       	call   801000d0 <bread>
80101f0b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101f0e:	a1 60 2d 12 80       	mov    0x80122d60,%eax
80101f13:	83 c4 10             	add    $0x10,%esp
80101f16:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101f19:	31 c0                	xor    %eax,%eax
80101f1b:	eb 2d                	jmp    80101f4a <balloc+0x7a>
80101f1d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101f20:	89 c1                	mov    %eax,%ecx
80101f22:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101f27:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
80101f2a:	83 e1 07             	and    $0x7,%ecx
80101f2d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101f2f:	89 c1                	mov    %eax,%ecx
80101f31:	c1 f9 03             	sar    $0x3,%ecx
80101f34:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101f39:	85 d7                	test   %edx,%edi
80101f3b:	74 43                	je     80101f80 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101f3d:	83 c0 01             	add    $0x1,%eax
80101f40:	83 c6 01             	add    $0x1,%esi
80101f43:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101f48:	74 05                	je     80101f4f <balloc+0x7f>
80101f4a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80101f4d:	72 d1                	jb     80101f20 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101f4f:	83 ec 0c             	sub    $0xc,%esp
80101f52:	ff 75 e4             	pushl  -0x1c(%ebp)
80101f55:	e8 86 e2 ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101f5a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101f61:	83 c4 10             	add    $0x10,%esp
80101f64:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f67:	39 05 60 2d 12 80    	cmp    %eax,0x80122d60
80101f6d:	77 82                	ja     80101ef1 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101f6f:	83 ec 0c             	sub    $0xc,%esp
80101f72:	68 07 83 10 80       	push   $0x80108307
80101f77:	e8 44 e8 ff ff       	call   801007c0 <panic>
80101f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101f80:	09 fa                	or     %edi,%edx
80101f82:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101f85:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101f88:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101f8c:	57                   	push   %edi
80101f8d:	e8 ae 1c 00 00       	call   80103c40 <log_write>
        brelse(bp);
80101f92:	89 3c 24             	mov    %edi,(%esp)
80101f95:	e8 46 e2 ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
80101f9a:	58                   	pop    %eax
80101f9b:	5a                   	pop    %edx
80101f9c:	56                   	push   %esi
80101f9d:	ff 75 d8             	pushl  -0x28(%ebp)
80101fa0:	e8 2b e1 ff ff       	call   801000d0 <bread>
80101fa5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101fa7:	8d 40 5c             	lea    0x5c(%eax),%eax
80101faa:	83 c4 0c             	add    $0xc,%esp
80101fad:	68 00 02 00 00       	push   $0x200
80101fb2:	6a 00                	push   $0x0
80101fb4:	50                   	push   %eax
80101fb5:	e8 66 33 00 00       	call   80105320 <memset>
  log_write(bp);
80101fba:	89 1c 24             	mov    %ebx,(%esp)
80101fbd:	e8 7e 1c 00 00       	call   80103c40 <log_write>
  brelse(bp);
80101fc2:	89 1c 24             	mov    %ebx,(%esp)
80101fc5:	e8 16 e2 ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
80101fca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fcd:	89 f0                	mov    %esi,%eax
80101fcf:	5b                   	pop    %ebx
80101fd0:	5e                   	pop    %esi
80101fd1:	5f                   	pop    %edi
80101fd2:	5d                   	pop    %ebp
80101fd3:	c3                   	ret    
80101fd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101fe0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101fe0:	55                   	push   %ebp
80101fe1:	89 e5                	mov    %esp,%ebp
80101fe3:	57                   	push   %edi
80101fe4:	56                   	push   %esi
80101fe5:	53                   	push   %ebx
80101fe6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101fe8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101fea:	bb b4 2d 12 80       	mov    $0x80122db4,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101fef:	83 ec 28             	sub    $0x28,%esp
80101ff2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101ff5:	68 80 2d 12 80       	push   $0x80122d80
80101ffa:	e8 b1 31 00 00       	call   801051b0 <acquire>
80101fff:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102002:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102005:	eb 1b                	jmp    80102022 <iget+0x42>
80102007:	89 f6                	mov    %esi,%esi
80102009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80102010:	85 f6                	test   %esi,%esi
80102012:	74 44                	je     80102058 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102014:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010201a:	81 fb d4 49 12 80    	cmp    $0x801249d4,%ebx
80102020:	74 4e                	je     80102070 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102022:	8b 4b 08             	mov    0x8(%ebx),%ecx
80102025:	85 c9                	test   %ecx,%ecx
80102027:	7e e7                	jle    80102010 <iget+0x30>
80102029:	39 3b                	cmp    %edi,(%ebx)
8010202b:	75 e3                	jne    80102010 <iget+0x30>
8010202d:	39 53 04             	cmp    %edx,0x4(%ebx)
80102030:	75 de                	jne    80102010 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80102032:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80102035:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80102038:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010203a:	68 80 2d 12 80       	push   $0x80122d80

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010203f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80102042:	e8 89 32 00 00       	call   801052d0 <release>
      return ip;
80102047:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010204a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010204d:	89 f0                	mov    %esi,%eax
8010204f:	5b                   	pop    %ebx
80102050:	5e                   	pop    %esi
80102051:	5f                   	pop    %edi
80102052:	5d                   	pop    %ebp
80102053:	c3                   	ret    
80102054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80102058:	85 c9                	test   %ecx,%ecx
8010205a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010205d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80102063:	81 fb d4 49 12 80    	cmp    $0x801249d4,%ebx
80102069:	75 b7                	jne    80102022 <iget+0x42>
8010206b:	90                   	nop
8010206c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80102070:	85 f6                	test   %esi,%esi
80102072:	74 2d                	je     801020a1 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80102074:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80102077:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80102079:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010207c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80102083:	c7 46 50 00 00 00 00 	movl   $0x0,0x50(%esi)
  release(&icache.lock);
8010208a:	68 80 2d 12 80       	push   $0x80122d80
8010208f:	e8 3c 32 00 00       	call   801052d0 <release>

  return ip;
80102094:	83 c4 10             	add    $0x10,%esp
}
80102097:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010209a:	89 f0                	mov    %esi,%eax
8010209c:	5b                   	pop    %ebx
8010209d:	5e                   	pop    %esi
8010209e:	5f                   	pop    %edi
8010209f:	5d                   	pop    %ebp
801020a0:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801020a1:	83 ec 0c             	sub    $0xc,%esp
801020a4:	68 1d 83 10 80       	push   $0x8010831d
801020a9:	e8 12 e7 ff ff       	call   801007c0 <panic>
801020ae:	66 90                	xchg   %ax,%ax

801020b0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801020b0:	55                   	push   %ebp
801020b1:	89 e5                	mov    %esp,%ebp
801020b3:	57                   	push   %edi
801020b4:	56                   	push   %esi
801020b5:	53                   	push   %ebx
801020b6:	89 c6                	mov    %eax,%esi
801020b8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801020bb:	83 fa 0a             	cmp    $0xa,%edx
801020be:	77 18                	ja     801020d8 <bmap+0x28>
801020c0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
801020c3:	8b 43 60             	mov    0x60(%ebx),%eax
801020c6:	85 c0                	test   %eax,%eax
801020c8:	74 76                	je     80102140 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801020ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020cd:	5b                   	pop    %ebx
801020ce:	5e                   	pop    %esi
801020cf:	5f                   	pop    %edi
801020d0:	5d                   	pop    %ebp
801020d1:	c3                   	ret    
801020d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801020d8:	8d 5a f5             	lea    -0xb(%edx),%ebx

  if(bn < NINDIRECT){
801020db:	83 fb 7f             	cmp    $0x7f,%ebx
801020de:	0f 87 83 00 00 00    	ja     80102167 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801020e4:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801020ea:	85 c0                	test   %eax,%eax
801020ec:	74 6a                	je     80102158 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801020ee:	83 ec 08             	sub    $0x8,%esp
801020f1:	50                   	push   %eax
801020f2:	ff 36                	pushl  (%esi)
801020f4:	e8 d7 df ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801020f9:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
801020fd:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80102100:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80102102:	8b 1a                	mov    (%edx),%ebx
80102104:	85 db                	test   %ebx,%ebx
80102106:	75 1d                	jne    80102125 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80102108:	8b 06                	mov    (%esi),%eax
8010210a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010210d:	e8 be fd ff ff       	call   80101ed0 <balloc>
80102112:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80102115:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80102118:	89 c3                	mov    %eax,%ebx
8010211a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010211c:	57                   	push   %edi
8010211d:	e8 1e 1b 00 00       	call   80103c40 <log_write>
80102122:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80102125:	83 ec 0c             	sub    $0xc,%esp
80102128:	57                   	push   %edi
80102129:	e8 b2 e0 ff ff       	call   801001e0 <brelse>
8010212e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80102131:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80102134:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80102136:	5b                   	pop    %ebx
80102137:	5e                   	pop    %esi
80102138:	5f                   	pop    %edi
80102139:	5d                   	pop    %ebp
8010213a:	c3                   	ret    
8010213b:	90                   	nop
8010213c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80102140:	8b 06                	mov    (%esi),%eax
80102142:	e8 89 fd ff ff       	call   80101ed0 <balloc>
80102147:	89 43 60             	mov    %eax,0x60(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010214a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010214d:	5b                   	pop    %ebx
8010214e:	5e                   	pop    %esi
8010214f:	5f                   	pop    %edi
80102150:	5d                   	pop    %ebp
80102151:	c3                   	ret    
80102152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80102158:	8b 06                	mov    (%esi),%eax
8010215a:	e8 71 fd ff ff       	call   80101ed0 <balloc>
8010215f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80102165:	eb 87                	jmp    801020ee <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80102167:	83 ec 0c             	sub    $0xc,%esp
8010216a:	68 2d 83 10 80       	push   $0x8010832d
8010216f:	e8 4c e6 ff ff       	call   801007c0 <panic>
80102174:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010217a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102180 <dateToTimestamp>:
*历史来源：三字班方案二代码
*整合作者：程嘉梁
*整合时间：2018/04/16
*/
uint dateToTimestamp(rtcdate* date)
{
80102180:	55                   	push   %ebp
80102181:	89 e5                	mov    %esp,%ebp
80102183:	56                   	push   %esi
80102184:	53                   	push   %ebx
80102185:	83 ec 30             	sub    $0x30,%esp
80102188:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint ret = 946684800; //utc+0 2000/1/1 0:0:0 946684800
  int days[]={31,28,31,30,31,30,31,31,30,31,30,31};
8010218b:	c7 45 c8 1f 00 00 00 	movl   $0x1f,-0x38(%ebp)
80102192:	c7 45 cc 1c 00 00 00 	movl   $0x1c,-0x34(%ebp)
80102199:	c7 45 d0 1f 00 00 00 	movl   $0x1f,-0x30(%ebp)
801021a0:	c7 45 d4 1e 00 00 00 	movl   $0x1e,-0x2c(%ebp)
801021a7:	c7 45 d8 1f 00 00 00 	movl   $0x1f,-0x28(%ebp)
  int year4num = (date->year - 2000) / 4;
801021ae:	8b 43 14             	mov    0x14(%ebx),%eax
*整合时间：2018/04/16
*/
uint dateToTimestamp(rtcdate* date)
{
  uint ret = 946684800; //utc+0 2000/1/1 0:0:0 946684800
  int days[]={31,28,31,30,31,30,31,31,30,31,30,31};
801021b1:	c7 45 dc 1e 00 00 00 	movl   $0x1e,-0x24(%ebp)
801021b8:	c7 45 e0 1f 00 00 00 	movl   $0x1f,-0x20(%ebp)
801021bf:	c7 45 e4 1f 00 00 00 	movl   $0x1f,-0x1c(%ebp)
801021c6:	c7 45 e8 1e 00 00 00 	movl   $0x1e,-0x18(%ebp)
801021cd:	c7 45 ec 1f 00 00 00 	movl   $0x1f,-0x14(%ebp)
  int year4num = (date->year - 2000) / 4;
801021d4:	8d 90 30 f8 ff ff    	lea    -0x7d0(%eax),%edx
*整合时间：2018/04/16
*/
uint dateToTimestamp(rtcdate* date)
{
  uint ret = 946684800; //utc+0 2000/1/1 0:0:0 946684800
  int days[]={31,28,31,30,31,30,31,31,30,31,30,31};
801021da:	c7 45 f0 1e 00 00 00 	movl   $0x1e,-0x10(%ebp)
801021e1:	c7 45 f4 1f 00 00 00 	movl   $0x1f,-0xc(%ebp)
  int year4num = (date->year - 2000) / 4;
801021e8:	89 d1                	mov    %edx,%ecx
801021ea:	c1 e9 02             	shr    $0x2,%ecx
  ret += year4num*(365*4+1)*86400;
801021ed:	69 c1 80 1f 86 07    	imul   $0x7861f80,%ecx,%eax
  int yearfor4 = date->year - year4num * 4 - 2000;
801021f3:	c1 e1 02             	shl    $0x2,%ecx
801021f6:	29 ca                	sub    %ecx,%edx
  if(yearfor4>0)
801021f8:	85 d2                	test   %edx,%edx
801021fa:	7e 6c                	jle    80102268 <dateToTimestamp+0xe8>
  {
    ret += 366 * 86400;
    yearfor4--;
    ret += yearfor4 * 365 * 86400;
801021fc:	83 ea 01             	sub    $0x1,%edx
801021ff:	69 d2 80 33 e1 01    	imul   $0x1e13380,%edx,%edx
80102205:	8d 84 10 80 c8 4f 3a 	lea    0x3a4fc880(%eax,%edx,1),%eax
  }
  else
    days[1] = 29;
  int i;
  for(i = 1; i < date->month; i++)
8010220c:	8b 53 10             	mov    0x10(%ebx),%edx
8010220f:	83 fa 01             	cmp    $0x1,%edx
80102212:	76 25                	jbe    80102239 <dateToTimestamp+0xb9>
80102214:	8d 74 95 c4          	lea    -0x3c(%ebp,%edx,4),%esi
80102218:	8d 4d cc             	lea    -0x34(%ebp),%ecx
8010221b:	ba 1f 00 00 00       	mov    $0x1f,%edx
80102220:	eb 0b                	jmp    8010222d <dateToTimestamp+0xad>
80102222:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102228:	8b 11                	mov    (%ecx),%edx
8010222a:	83 c1 04             	add    $0x4,%ecx
    ret += days[i-1]*86400;
8010222d:	69 d2 80 51 01 00    	imul   $0x15180,%edx,%edx
80102233:	01 d0                	add    %edx,%eax
    ret += yearfor4 * 365 * 86400;
  }
  else
    days[1] = 29;
  int i;
  for(i = 1; i < date->month; i++)
80102235:	39 f1                	cmp    %esi,%ecx
80102237:	75 ef                	jne    80102228 <dateToTimestamp+0xa8>
    ret += days[i-1]*86400;
  ret += (date->day - 1) * 86400;
  ret += (date->hour * 3600 + date->minute * 60 + date->second);
80102239:	69 4b 0c 80 51 01 00 	imul   $0x15180,0xc(%ebx),%ecx
80102240:	8b 13                	mov    (%ebx),%edx
80102242:	8d 8c 11 80 ae fe ff 	lea    -0x15180(%ecx,%edx,1),%ecx
80102249:	69 53 08 10 0e 00 00 	imul   $0xe10,0x8(%ebx),%edx
80102250:	01 d1                	add    %edx,%ecx
80102252:	6b 53 04 3c          	imul   $0x3c,0x4(%ebx),%edx
  return ret;
}
80102256:	83 c4 30             	add    $0x30,%esp
80102259:	5b                   	pop    %ebx
8010225a:	5e                   	pop    %esi
8010225b:	5d                   	pop    %ebp
    days[1] = 29;
  int i;
  for(i = 1; i < date->month; i++)
    ret += days[i-1]*86400;
  ret += (date->day - 1) * 86400;
  ret += (date->hour * 3600 + date->minute * 60 + date->second);
8010225c:	01 ca                	add    %ecx,%edx
8010225e:	01 d0                	add    %edx,%eax
  return ret;
}
80102260:	c3                   	ret    
80102261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
uint dateToTimestamp(rtcdate* date)
{
  uint ret = 946684800; //utc+0 2000/1/1 0:0:0 946684800
  int days[]={31,28,31,30,31,30,31,31,30,31,30,31};
  int year4num = (date->year - 2000) / 4;
  ret += year4num*(365*4+1)*86400;
80102268:	05 80 43 6d 38       	add    $0x386d4380,%eax
    ret += 366 * 86400;
    yearfor4--;
    ret += yearfor4 * 365 * 86400;
  }
  else
    days[1] = 29;
8010226d:	c7 45 cc 1d 00 00 00 	movl   $0x1d,-0x34(%ebp)
80102274:	eb 96                	jmp    8010220c <dateToTimestamp+0x8c>
80102276:	8d 76 00             	lea    0x0(%esi),%esi
80102279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102280 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80102280:	55                   	push   %ebp
80102281:	89 e5                	mov    %esp,%ebp
80102283:	56                   	push   %esi
80102284:	53                   	push   %ebx
80102285:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80102288:	83 ec 08             	sub    $0x8,%esp
8010228b:	6a 01                	push   $0x1
8010228d:	ff 75 08             	pushl  0x8(%ebp)
80102290:	e8 3b de ff ff       	call   801000d0 <bread>
80102295:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80102297:	8d 40 5c             	lea    0x5c(%eax),%eax
8010229a:	83 c4 0c             	add    $0xc,%esp
8010229d:	6a 1c                	push   $0x1c
8010229f:	50                   	push   %eax
801022a0:	56                   	push   %esi
801022a1:	e8 2a 31 00 00       	call   801053d0 <memmove>
  brelse(bp);
801022a6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801022a9:	83 c4 10             	add    $0x10,%esp
}
801022ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022af:	5b                   	pop    %ebx
801022b0:	5e                   	pop    %esi
801022b1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801022b2:	e9 29 df ff ff       	jmp    801001e0 <brelse>
801022b7:	89 f6                	mov    %esi,%esi
801022b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022c0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801022c0:	55                   	push   %ebp
801022c1:	89 e5                	mov    %esp,%ebp
801022c3:	56                   	push   %esi
801022c4:	53                   	push   %ebx
801022c5:	89 d3                	mov    %edx,%ebx
801022c7:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801022c9:	83 ec 08             	sub    $0x8,%esp
801022cc:	68 60 2d 12 80       	push   $0x80122d60
801022d1:	50                   	push   %eax
801022d2:	e8 a9 ff ff ff       	call   80102280 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801022d7:	58                   	pop    %eax
801022d8:	5a                   	pop    %edx
801022d9:	89 da                	mov    %ebx,%edx
801022db:	c1 ea 0c             	shr    $0xc,%edx
801022de:	03 15 78 2d 12 80    	add    0x80122d78,%edx
801022e4:	52                   	push   %edx
801022e5:	56                   	push   %esi
801022e6:	e8 e5 dd ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801022eb:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801022ed:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
801022f3:	ba 01 00 00 00       	mov    $0x1,%edx
801022f8:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801022fb:	c1 fb 03             	sar    $0x3,%ebx
801022fe:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80102301:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80102303:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80102308:	85 d1                	test   %edx,%ecx
8010230a:	74 27                	je     80102333 <bfree+0x73>
8010230c:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010230e:	f7 d2                	not    %edx
80102310:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80102312:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80102315:	21 d0                	and    %edx,%eax
80102317:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010231b:	56                   	push   %esi
8010231c:	e8 1f 19 00 00       	call   80103c40 <log_write>
  brelse(bp);
80102321:	89 34 24             	mov    %esi,(%esp)
80102324:	e8 b7 de ff ff       	call   801001e0 <brelse>
}
80102329:	83 c4 10             	add    $0x10,%esp
8010232c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010232f:	5b                   	pop    %ebx
80102330:	5e                   	pop    %esi
80102331:	5d                   	pop    %ebp
80102332:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80102333:	83 ec 0c             	sub    $0xc,%esp
80102336:	68 40 83 10 80       	push   $0x80108340
8010233b:	e8 80 e4 ff ff       	call   801007c0 <panic>

80102340 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80102340:	55                   	push   %ebp
80102341:	89 e5                	mov    %esp,%ebp
80102343:	53                   	push   %ebx
80102344:	bb c4 2d 12 80       	mov    $0x80122dc4,%ebx
80102349:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
8010234c:	68 53 83 10 80       	push   $0x80108353
80102351:	68 80 2d 12 80       	push   $0x80122d80
80102356:	e8 55 2d 00 00       	call   801050b0 <initlock>
8010235b:	83 c4 10             	add    $0x10,%esp
8010235e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80102360:	83 ec 08             	sub    $0x8,%esp
80102363:	68 5a 83 10 80       	push   $0x8010835a
80102368:	53                   	push   %ebx
80102369:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010236f:	e8 2c 2c 00 00       	call   80104fa0 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80102374:	83 c4 10             	add    $0x10,%esp
80102377:	81 fb e4 49 12 80    	cmp    $0x801249e4,%ebx
8010237d:	75 e1                	jne    80102360 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010237f:	83 ec 08             	sub    $0x8,%esp
80102382:	68 60 2d 12 80       	push   $0x80122d60
80102387:	ff 75 08             	pushl  0x8(%ebp)
8010238a:	e8 f1 fe ff ff       	call   80102280 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010238f:	ff 35 78 2d 12 80    	pushl  0x80122d78
80102395:	ff 35 74 2d 12 80    	pushl  0x80122d74
8010239b:	ff 35 70 2d 12 80    	pushl  0x80122d70
801023a1:	ff 35 6c 2d 12 80    	pushl  0x80122d6c
801023a7:	ff 35 68 2d 12 80    	pushl  0x80122d68
801023ad:	ff 35 64 2d 12 80    	pushl  0x80122d64
801023b3:	ff 35 60 2d 12 80    	pushl  0x80122d60
801023b9:	68 c0 83 10 80       	push   $0x801083c0
801023be:	e8 6d e2 ff ff       	call   80100630 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801023c3:	83 c4 30             	add    $0x30,%esp
801023c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023c9:	c9                   	leave  
801023ca:	c3                   	ret    
801023cb:	90                   	nop
801023cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801023d0 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
801023d3:	57                   	push   %edi
801023d4:	56                   	push   %esi
801023d5:	53                   	push   %ebx
801023d6:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801023d9:	83 3d 68 2d 12 80 01 	cmpl   $0x1,0x80122d68
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
801023e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801023e3:	8b 75 08             	mov    0x8(%ebp),%esi
801023e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801023e9:	0f 86 91 00 00 00    	jbe    80102480 <ialloc+0xb0>
801023ef:	bb 01 00 00 00       	mov    $0x1,%ebx
801023f4:	eb 21                	jmp    80102417 <ialloc+0x47>
801023f6:	8d 76 00             	lea    0x0(%esi),%esi
801023f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80102400:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80102403:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80102406:	57                   	push   %edi
80102407:	e8 d4 dd ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010240c:	83 c4 10             	add    $0x10,%esp
8010240f:	39 1d 68 2d 12 80    	cmp    %ebx,0x80122d68
80102415:	76 69                	jbe    80102480 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80102417:	89 d8                	mov    %ebx,%eax
80102419:	83 ec 08             	sub    $0x8,%esp
8010241c:	c1 e8 03             	shr    $0x3,%eax
8010241f:	03 05 74 2d 12 80    	add    0x80122d74,%eax
80102425:	50                   	push   %eax
80102426:	56                   	push   %esi
80102427:	e8 a4 dc ff ff       	call   801000d0 <bread>
8010242c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010242e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80102430:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80102433:	83 e0 07             	and    $0x7,%eax
80102436:	c1 e0 06             	shl    $0x6,%eax
80102439:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010243d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80102441:	75 bd                	jne    80102400 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80102443:	83 ec 04             	sub    $0x4,%esp
80102446:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102449:	6a 40                	push   $0x40
8010244b:	6a 00                	push   $0x0
8010244d:	51                   	push   %ecx
8010244e:	e8 cd 2e 00 00       	call   80105320 <memset>
      dip->type = type;
80102453:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80102457:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010245a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010245d:	89 3c 24             	mov    %edi,(%esp)
80102460:	e8 db 17 00 00       	call   80103c40 <log_write>
      brelse(bp);
80102465:	89 3c 24             	mov    %edi,(%esp)
80102468:	e8 73 dd ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010246d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80102470:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80102473:	89 da                	mov    %ebx,%edx
80102475:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80102477:	5b                   	pop    %ebx
80102478:	5e                   	pop    %esi
80102479:	5f                   	pop    %edi
8010247a:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010247b:	e9 60 fb ff ff       	jmp    80101fe0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80102480:	83 ec 0c             	sub    $0xc,%esp
80102483:	68 60 83 10 80       	push   $0x80108360
80102488:	e8 33 e3 ff ff       	call   801007c0 <panic>
8010248d:	8d 76 00             	lea    0x0(%esi),%esi

80102490 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	56                   	push   %esi
80102494:	53                   	push   %ebx
80102495:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102498:	83 ec 08             	sub    $0x8,%esp
8010249b:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  dip->ctime = ip->ctime;//更新时间参数
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010249e:	83 c3 60             	add    $0x60,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801024a1:	c1 e8 03             	shr    $0x3,%eax
801024a4:	03 05 74 2d 12 80    	add    0x80122d74,%eax
801024aa:	50                   	push   %eax
801024ab:	ff 73 a0             	pushl  -0x60(%ebx)
801024ae:	e8 1d dc ff ff       	call   801000d0 <bread>
801024b3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801024b5:	8b 43 a4             	mov    -0x5c(%ebx),%eax
  dip->type = ip->type;
801024b8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  dip->ctime = ip->ctime;//更新时间参数
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801024bc:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801024bf:	83 e0 07             	and    $0x7,%eax
801024c2:	c1 e0 06             	shl    $0x6,%eax
801024c5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801024c9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801024cc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  dip->ctime = ip->ctime;//更新时间参数
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801024d0:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
801024d3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801024d7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801024db:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801024df:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801024e3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801024e7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801024ea:	89 50 fc             	mov    %edx,-0x4(%eax)
  dip->ctime = ip->ctime;//更新时间参数
801024ed:	8b 53 ac             	mov    -0x54(%ebx),%edx
801024f0:	89 50 30             	mov    %edx,0x30(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801024f3:	6a 30                	push   $0x30
801024f5:	53                   	push   %ebx
801024f6:	50                   	push   %eax
801024f7:	e8 d4 2e 00 00       	call   801053d0 <memmove>
  log_write(bp);
801024fc:	89 34 24             	mov    %esi,(%esp)
801024ff:	e8 3c 17 00 00       	call   80103c40 <log_write>
  brelse(bp);
80102504:	89 75 08             	mov    %esi,0x8(%ebp)
80102507:	83 c4 10             	add    $0x10,%esp
}
8010250a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010250d:	5b                   	pop    %ebx
8010250e:	5e                   	pop    %esi
8010250f:	5d                   	pop    %ebp
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  dip->ctime = ip->ctime;//更新时间参数
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
80102510:	e9 cb dc ff ff       	jmp    801001e0 <brelse>
80102515:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102520 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80102520:	55                   	push   %ebp
80102521:	89 e5                	mov    %esp,%ebp
80102523:	53                   	push   %ebx
80102524:	83 ec 10             	sub    $0x10,%esp
80102527:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010252a:	68 80 2d 12 80       	push   $0x80122d80
8010252f:	e8 7c 2c 00 00       	call   801051b0 <acquire>
  ip->ref++;
80102534:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102538:	c7 04 24 80 2d 12 80 	movl   $0x80122d80,(%esp)
8010253f:	e8 8c 2d 00 00       	call   801052d0 <release>
  return ip;
}
80102544:	89 d8                	mov    %ebx,%eax
80102546:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102549:	c9                   	leave  
8010254a:	c3                   	ret    
8010254b:	90                   	nop
8010254c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102550 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	56                   	push   %esi
80102554:	53                   	push   %ebx
80102555:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80102558:	85 db                	test   %ebx,%ebx
8010255a:	0f 84 bd 00 00 00    	je     8010261d <ilock+0xcd>
80102560:	8b 53 08             	mov    0x8(%ebx),%edx
80102563:	85 d2                	test   %edx,%edx
80102565:	0f 8e b2 00 00 00    	jle    8010261d <ilock+0xcd>
    panic("ilock");

  acquiresleep(&ip->lock);
8010256b:	8d 43 10             	lea    0x10(%ebx),%eax
8010256e:	83 ec 0c             	sub    $0xc,%esp
80102571:	50                   	push   %eax
80102572:	e8 69 2a 00 00       	call   80104fe0 <acquiresleep>

  if(ip->valid == 0){
80102577:	8b 43 50             	mov    0x50(%ebx),%eax
8010257a:	83 c4 10             	add    $0x10,%esp
8010257d:	85 c0                	test   %eax,%eax
8010257f:	74 0f                	je     80102590 <ilock+0x40>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80102581:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102584:	5b                   	pop    %ebx
80102585:	5e                   	pop    %esi
80102586:	5d                   	pop    %ebp
80102587:	c3                   	ret    
80102588:	90                   	nop
80102589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102590:	8b 43 04             	mov    0x4(%ebx),%eax
80102593:	83 ec 08             	sub    $0x8,%esp
80102596:	c1 e8 03             	shr    $0x3,%eax
80102599:	03 05 74 2d 12 80    	add    0x80122d74,%eax
8010259f:	50                   	push   %eax
801025a0:	ff 33                	pushl  (%ebx)
801025a2:	e8 29 db ff ff       	call   801000d0 <bread>
801025a7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801025a9:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    ip->ctime = dip->ctime;//添加时间参数
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801025ac:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801025af:	83 e0 07             	and    $0x7,%eax
801025b2:	c1 e0 06             	shl    $0x6,%eax
801025b5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801025b9:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    ip->ctime = dip->ctime;//添加时间参数
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801025bc:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801025bf:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->major = dip->major;
801025c3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801025c7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->minor = dip->minor;
801025cb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801025cf:	66 89 53 58          	mov    %dx,0x58(%ebx)
    ip->nlink = dip->nlink;
801025d3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801025d7:	66 89 53 5a          	mov    %dx,0x5a(%ebx)
    ip->size = dip->size;
801025db:	8b 50 fc             	mov    -0x4(%eax),%edx
801025de:	89 53 5c             	mov    %edx,0x5c(%ebx)
    ip->ctime = dip->ctime;//添加时间参数
801025e1:	8b 50 30             	mov    0x30(%eax),%edx
801025e4:	89 53 0c             	mov    %edx,0xc(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801025e7:	6a 30                	push   $0x30
801025e9:	50                   	push   %eax
801025ea:	8d 43 60             	lea    0x60(%ebx),%eax
801025ed:	50                   	push   %eax
801025ee:	e8 dd 2d 00 00       	call   801053d0 <memmove>
    brelse(bp);
801025f3:	89 34 24             	mov    %esi,(%esp)
801025f6:	e8 e5 db ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
801025fb:	83 c4 10             	add    $0x10,%esp
801025fe:	66 83 7b 54 00       	cmpw   $0x0,0x54(%ebx)
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    ip->ctime = dip->ctime;//添加时间参数
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    brelse(bp);
    ip->valid = 1;
80102603:	c7 43 50 01 00 00 00 	movl   $0x1,0x50(%ebx)
    if(ip->type == 0)
8010260a:	0f 85 71 ff ff ff    	jne    80102581 <ilock+0x31>
      panic("ilock: no type");
80102610:	83 ec 0c             	sub    $0xc,%esp
80102613:	68 78 83 10 80       	push   $0x80108378
80102618:	e8 a3 e1 ff ff       	call   801007c0 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
8010261d:	83 ec 0c             	sub    $0xc,%esp
80102620:	68 72 83 10 80       	push   $0x80108372
80102625:	e8 96 e1 ff ff       	call   801007c0 <panic>
8010262a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102630 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	56                   	push   %esi
80102634:	53                   	push   %ebx
80102635:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102638:	85 db                	test   %ebx,%ebx
8010263a:	74 28                	je     80102664 <iunlock+0x34>
8010263c:	8d 73 10             	lea    0x10(%ebx),%esi
8010263f:	83 ec 0c             	sub    $0xc,%esp
80102642:	56                   	push   %esi
80102643:	e8 38 2a 00 00       	call   80105080 <holdingsleep>
80102648:	83 c4 10             	add    $0x10,%esp
8010264b:	85 c0                	test   %eax,%eax
8010264d:	74 15                	je     80102664 <iunlock+0x34>
8010264f:	8b 43 08             	mov    0x8(%ebx),%eax
80102652:	85 c0                	test   %eax,%eax
80102654:	7e 0e                	jle    80102664 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80102656:	89 75 08             	mov    %esi,0x8(%ebp)
}
80102659:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010265c:	5b                   	pop    %ebx
8010265d:	5e                   	pop    %esi
8010265e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010265f:	e9 dc 29 00 00       	jmp    80105040 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80102664:	83 ec 0c             	sub    $0xc,%esp
80102667:	68 87 83 10 80       	push   $0x80108387
8010266c:	e8 4f e1 ff ff       	call   801007c0 <panic>
80102671:	eb 0d                	jmp    80102680 <iput>
80102673:	90                   	nop
80102674:	90                   	nop
80102675:	90                   	nop
80102676:	90                   	nop
80102677:	90                   	nop
80102678:	90                   	nop
80102679:	90                   	nop
8010267a:	90                   	nop
8010267b:	90                   	nop
8010267c:	90                   	nop
8010267d:	90                   	nop
8010267e:	90                   	nop
8010267f:	90                   	nop

80102680 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80102680:	55                   	push   %ebp
80102681:	89 e5                	mov    %esp,%ebp
80102683:	57                   	push   %edi
80102684:	56                   	push   %esi
80102685:	53                   	push   %ebx
80102686:	83 ec 28             	sub    $0x28,%esp
80102689:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
8010268c:	8d 7e 10             	lea    0x10(%esi),%edi
8010268f:	57                   	push   %edi
80102690:	e8 4b 29 00 00       	call   80104fe0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80102695:	8b 56 50             	mov    0x50(%esi),%edx
80102698:	83 c4 10             	add    $0x10,%esp
8010269b:	85 d2                	test   %edx,%edx
8010269d:	74 07                	je     801026a6 <iput+0x26>
8010269f:	66 83 7e 5a 00       	cmpw   $0x0,0x5a(%esi)
801026a4:	74 32                	je     801026d8 <iput+0x58>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
801026a6:	83 ec 0c             	sub    $0xc,%esp
801026a9:	57                   	push   %edi
801026aa:	e8 91 29 00 00       	call   80105040 <releasesleep>

  acquire(&icache.lock);
801026af:	c7 04 24 80 2d 12 80 	movl   $0x80122d80,(%esp)
801026b6:	e8 f5 2a 00 00       	call   801051b0 <acquire>
  ip->ref--;
801026bb:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
801026bf:	83 c4 10             	add    $0x10,%esp
801026c2:	c7 45 08 80 2d 12 80 	movl   $0x80122d80,0x8(%ebp)
}
801026c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801026cc:	5b                   	pop    %ebx
801026cd:	5e                   	pop    %esi
801026ce:	5f                   	pop    %edi
801026cf:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
801026d0:	e9 fb 2b 00 00       	jmp    801052d0 <release>
801026d5:	8d 76 00             	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
801026d8:	83 ec 0c             	sub    $0xc,%esp
801026db:	68 80 2d 12 80       	push   $0x80122d80
801026e0:	e8 cb 2a 00 00       	call   801051b0 <acquire>
    int r = ip->ref;
801026e5:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
801026e8:	c7 04 24 80 2d 12 80 	movl   $0x80122d80,(%esp)
801026ef:	e8 dc 2b 00 00       	call   801052d0 <release>
    if(r == 1){
801026f4:	83 c4 10             	add    $0x10,%esp
801026f7:	83 fb 01             	cmp    $0x1,%ebx
801026fa:	75 aa                	jne    801026a6 <iput+0x26>
801026fc:	8d 8e 8c 00 00 00    	lea    0x8c(%esi),%ecx
80102702:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102705:	8d 5e 60             	lea    0x60(%esi),%ebx
80102708:	89 cf                	mov    %ecx,%edi
8010270a:	eb 0b                	jmp    80102717 <iput+0x97>
8010270c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102710:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102713:	39 fb                	cmp    %edi,%ebx
80102715:	74 19                	je     80102730 <iput+0xb0>
    if(ip->addrs[i]){
80102717:	8b 13                	mov    (%ebx),%edx
80102719:	85 d2                	test   %edx,%edx
8010271b:	74 f3                	je     80102710 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010271d:	8b 06                	mov    (%esi),%eax
8010271f:	e8 9c fb ff ff       	call   801022c0 <bfree>
      ip->addrs[i] = 0;
80102724:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010272a:	eb e4                	jmp    80102710 <iput+0x90>
8010272c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80102730:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80102736:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102739:	85 c0                	test   %eax,%eax
8010273b:	75 33                	jne    80102770 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010273d:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80102740:	c7 46 5c 00 00 00 00 	movl   $0x0,0x5c(%esi)
  iupdate(ip);
80102747:	56                   	push   %esi
80102748:	e8 43 fd ff ff       	call   80102490 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
8010274d:	31 c0                	xor    %eax,%eax
8010274f:	66 89 46 54          	mov    %ax,0x54(%esi)
      iupdate(ip);
80102753:	89 34 24             	mov    %esi,(%esp)
80102756:	e8 35 fd ff ff       	call   80102490 <iupdate>
      ip->valid = 0;
8010275b:	c7 46 50 00 00 00 00 	movl   $0x0,0x50(%esi)
80102762:	83 c4 10             	add    $0x10,%esp
80102765:	e9 3c ff ff ff       	jmp    801026a6 <iput+0x26>
8010276a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80102770:	83 ec 08             	sub    $0x8,%esp
80102773:	50                   	push   %eax
80102774:	ff 36                	pushl  (%esi)
80102776:	e8 55 d9 ff ff       	call   801000d0 <bread>
8010277b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80102781:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102784:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80102787:	8d 58 5c             	lea    0x5c(%eax),%ebx
8010278a:	83 c4 10             	add    $0x10,%esp
8010278d:	89 cf                	mov    %ecx,%edi
8010278f:	eb 0e                	jmp    8010279f <iput+0x11f>
80102791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102798:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
8010279b:	39 fb                	cmp    %edi,%ebx
8010279d:	74 0f                	je     801027ae <iput+0x12e>
      if(a[j])
8010279f:	8b 13                	mov    (%ebx),%edx
801027a1:	85 d2                	test   %edx,%edx
801027a3:	74 f3                	je     80102798 <iput+0x118>
        bfree(ip->dev, a[j]);
801027a5:	8b 06                	mov    (%esi),%eax
801027a7:	e8 14 fb ff ff       	call   801022c0 <bfree>
801027ac:	eb ea                	jmp    80102798 <iput+0x118>
    }
    brelse(bp);
801027ae:	83 ec 0c             	sub    $0xc,%esp
801027b1:	ff 75 e4             	pushl  -0x1c(%ebp)
801027b4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801027b7:	e8 24 da ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801027bc:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801027c2:	8b 06                	mov    (%esi),%eax
801027c4:	e8 f7 fa ff ff       	call   801022c0 <bfree>
    ip->addrs[NDIRECT] = 0;
801027c9:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801027d0:	00 00 00 
801027d3:	83 c4 10             	add    $0x10,%esp
801027d6:	e9 62 ff ff ff       	jmp    8010273d <iput+0xbd>
801027db:	90                   	nop
801027dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027e0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
801027e0:	55                   	push   %ebp
801027e1:	89 e5                	mov    %esp,%ebp
801027e3:	53                   	push   %ebx
801027e4:	83 ec 10             	sub    $0x10,%esp
801027e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801027ea:	53                   	push   %ebx
801027eb:	e8 40 fe ff ff       	call   80102630 <iunlock>
  iput(ip);
801027f0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801027f3:	83 c4 10             	add    $0x10,%esp
}
801027f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027f9:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
801027fa:	e9 81 fe ff ff       	jmp    80102680 <iput>
801027ff:	90                   	nop

80102800 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102800:	55                   	push   %ebp
80102801:	89 e5                	mov    %esp,%ebp
80102803:	8b 55 08             	mov    0x8(%ebp),%edx
80102806:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80102809:	8b 0a                	mov    (%edx),%ecx
8010280b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010280e:	8b 4a 04             	mov    0x4(%edx),%ecx
80102811:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80102814:	0f b7 4a 54          	movzwl 0x54(%edx),%ecx
80102818:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010281b:	0f b7 4a 5a          	movzwl 0x5a(%edx),%ecx
8010281f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80102823:	8b 4a 5c             	mov    0x5c(%edx),%ecx
80102826:	89 48 10             	mov    %ecx,0x10(%eax)
  st->ctime = ip->ctime;//拷贝时间变量
80102829:	8b 52 0c             	mov    0xc(%edx),%edx
8010282c:	89 50 14             	mov    %edx,0x14(%eax)
}
8010282f:	5d                   	pop    %ebp
80102830:	c3                   	ret    
80102831:	eb 0d                	jmp    80102840 <readi>
80102833:	90                   	nop
80102834:	90                   	nop
80102835:	90                   	nop
80102836:	90                   	nop
80102837:	90                   	nop
80102838:	90                   	nop
80102839:	90                   	nop
8010283a:	90                   	nop
8010283b:	90                   	nop
8010283c:	90                   	nop
8010283d:	90                   	nop
8010283e:	90                   	nop
8010283f:	90                   	nop

80102840 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102840:	55                   	push   %ebp
80102841:	89 e5                	mov    %esp,%ebp
80102843:	57                   	push   %edi
80102844:	56                   	push   %esi
80102845:	53                   	push   %ebx
80102846:	83 ec 1c             	sub    $0x1c,%esp
80102849:	8b 45 08             	mov    0x8(%ebp),%eax
8010284c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010284f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102852:	66 83 78 54 03       	cmpw   $0x3,0x54(%eax)
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80102857:	89 7d e0             	mov    %edi,-0x20(%ebp)
8010285a:	8b 7d 14             	mov    0x14(%ebp),%edi
8010285d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102860:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102863:	0f 84 a7 00 00 00    	je     80102910 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80102869:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010286c:	8b 40 5c             	mov    0x5c(%eax),%eax
8010286f:	39 f0                	cmp    %esi,%eax
80102871:	0f 82 c1 00 00 00    	jb     80102938 <readi+0xf8>
80102877:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010287a:	89 fa                	mov    %edi,%edx
8010287c:	01 f2                	add    %esi,%edx
8010287e:	0f 82 b4 00 00 00    	jb     80102938 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80102884:	89 c1                	mov    %eax,%ecx
80102886:	29 f1                	sub    %esi,%ecx
80102888:	39 d0                	cmp    %edx,%eax
8010288a:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010288d:	31 ff                	xor    %edi,%edi
8010288f:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80102891:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102894:	74 6d                	je     80102903 <readi+0xc3>
80102896:	8d 76 00             	lea    0x0(%esi),%esi
80102899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801028a0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801028a3:	89 f2                	mov    %esi,%edx
801028a5:	c1 ea 09             	shr    $0x9,%edx
801028a8:	89 d8                	mov    %ebx,%eax
801028aa:	e8 01 f8 ff ff       	call   801020b0 <bmap>
801028af:	83 ec 08             	sub    $0x8,%esp
801028b2:	50                   	push   %eax
801028b3:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
801028b5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801028ba:	e8 11 d8 ff ff       	call   801000d0 <bread>
801028bf:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801028c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801028c4:	89 f1                	mov    %esi,%ecx
801028c6:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801028cc:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
801028cf:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801028d2:	29 cb                	sub    %ecx,%ebx
801028d4:	29 f8                	sub    %edi,%eax
801028d6:	39 c3                	cmp    %eax,%ebx
801028d8:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801028db:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
801028df:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801028e0:	01 df                	add    %ebx,%edi
801028e2:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
801028e4:	50                   	push   %eax
801028e5:	ff 75 e0             	pushl  -0x20(%ebp)
801028e8:	e8 e3 2a 00 00       	call   801053d0 <memmove>
    brelse(bp);
801028ed:	8b 55 dc             	mov    -0x24(%ebp),%edx
801028f0:	89 14 24             	mov    %edx,(%esp)
801028f3:	e8 e8 d8 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801028f8:	01 5d e0             	add    %ebx,-0x20(%ebp)
801028fb:	83 c4 10             	add    $0x10,%esp
801028fe:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102901:	77 9d                	ja     801028a0 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80102903:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102906:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102909:	5b                   	pop    %ebx
8010290a:	5e                   	pop    %esi
8010290b:	5f                   	pop    %edi
8010290c:	5d                   	pop    %ebp
8010290d:	c3                   	ret    
8010290e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102910:	0f bf 40 56          	movswl 0x56(%eax),%eax
80102914:	66 83 f8 09          	cmp    $0x9,%ax
80102918:	77 1e                	ja     80102938 <readi+0xf8>
8010291a:	8b 04 c5 00 2d 12 80 	mov    -0x7fedd300(,%eax,8),%eax
80102921:	85 c0                	test   %eax,%eax
80102923:	74 13                	je     80102938 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80102925:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80102928:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010292b:	5b                   	pop    %ebx
8010292c:	5e                   	pop    %esi
8010292d:	5f                   	pop    %edi
8010292e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
8010292f:	ff e0                	jmp    *%eax
80102931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80102938:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010293d:	eb c7                	jmp    80102906 <readi+0xc6>
8010293f:	90                   	nop

80102940 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102940:	55                   	push   %ebp
80102941:	89 e5                	mov    %esp,%ebp
80102943:	57                   	push   %edi
80102944:	56                   	push   %esi
80102945:	53                   	push   %ebx
80102946:	83 ec 3c             	sub    $0x3c,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102949:	8b 45 08             	mov    0x8(%ebp),%eax
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
8010294c:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010294f:	66 83 78 54 03       	cmpw   $0x3,0x54(%eax)
80102954:	0f 84 de 00 00 00    	je     80102a38 <writei+0xf8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
8010295a:	8b 45 08             	mov    0x8(%ebp),%eax
8010295d:	39 70 5c             	cmp    %esi,0x5c(%eax)
80102960:	0f 82 1a 01 00 00    	jb     80102a80 <writei+0x140>
80102966:	8b 45 14             	mov    0x14(%ebp),%eax
80102969:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
8010296b:	3d 00 16 81 00       	cmp    $0x811600,%eax
80102970:	0f 87 0a 01 00 00    	ja     80102a80 <writei+0x140>
80102976:	39 c6                	cmp    %eax,%esi
80102978:	0f 87 02 01 00 00    	ja     80102a80 <writei+0x140>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010297e:	8b 45 14             	mov    0x14(%ebp),%eax
80102981:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
80102988:	85 c0                	test   %eax,%eax
8010298a:	74 77                	je     80102a03 <writei+0xc3>
8010298c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102990:	8b 45 08             	mov    0x8(%ebp),%eax
80102993:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102995:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010299a:	c1 ea 09             	shr    $0x9,%edx
8010299d:	e8 0e f7 ff ff       	call   801020b0 <bmap>
801029a2:	83 ec 08             	sub    $0x8,%esp
801029a5:	50                   	push   %eax
801029a6:	8b 45 08             	mov    0x8(%ebp),%eax
801029a9:	ff 30                	pushl  (%eax)
801029ab:	e8 20 d7 ff ff       	call   801000d0 <bread>
801029b0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
801029b2:	8b 45 14             	mov    0x14(%ebp),%eax
801029b5:	2b 45 c4             	sub    -0x3c(%ebp),%eax
801029b8:	89 f1                	mov    %esi,%ecx
801029ba:	83 c4 0c             	add    $0xc,%esp
801029bd:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801029c3:	29 cb                	sub    %ecx,%ebx
801029c5:	39 c3                	cmp    %eax,%ebx
801029c7:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
801029ca:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
801029ce:	53                   	push   %ebx
801029cf:	ff 75 0c             	pushl  0xc(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801029d2:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
801029d4:	50                   	push   %eax
801029d5:	e8 f6 29 00 00       	call   801053d0 <memmove>
    log_write(bp);
801029da:	89 3c 24             	mov    %edi,(%esp)
801029dd:	e8 5e 12 00 00       	call   80103c40 <log_write>
    brelse(bp);
801029e2:	89 3c 24             	mov    %edi,(%esp)
801029e5:	e8 f6 d7 ff ff       	call   801001e0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801029ea:	01 5d c4             	add    %ebx,-0x3c(%ebp)
801029ed:	01 5d 0c             	add    %ebx,0xc(%ebp)
801029f0:	83 c4 10             	add    $0x10,%esp
801029f3:	8b 55 c4             	mov    -0x3c(%ebp),%edx
801029f6:	39 55 14             	cmp    %edx,0x14(%ebp)
801029f9:	77 95                	ja     80102990 <writei+0x50>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
801029fb:	8b 45 08             	mov    0x8(%ebp),%eax
801029fe:	3b 70 5c             	cmp    0x5c(%eax),%esi
80102a01:	77 6d                	ja     80102a70 <writei+0x130>
    ip->size = off;
  }
  
  //设置文件节点时间
  rtcdate date;
  datetime(&date);
80102a03:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80102a06:	83 ec 0c             	sub    $0xc,%esp
80102a09:	53                   	push   %ebx
80102a0a:	e8 a1 ed ff ff       	call   801017b0 <datetime>
  ip->ctime = dateToTimestamp(&date);
80102a0f:	89 1c 24             	mov    %ebx,(%esp)
80102a12:	e8 69 f7 ff ff       	call   80102180 <dateToTimestamp>
80102a17:	8b 75 08             	mov    0x8(%ebp),%esi
80102a1a:	89 46 0c             	mov    %eax,0xc(%esi)

  iupdate(ip);
80102a1d:	89 34 24             	mov    %esi,(%esp)
80102a20:	e8 6b fa ff ff       	call   80102490 <iupdate>
  return n;
80102a25:	8b 45 14             	mov    0x14(%ebp),%eax
80102a28:	83 c4 10             	add    $0x10,%esp
}
80102a2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a2e:	5b                   	pop    %ebx
80102a2f:	5e                   	pop    %esi
80102a30:	5f                   	pop    %edi
80102a31:	5d                   	pop    %ebp
80102a32:	c3                   	ret    
80102a33:	90                   	nop
80102a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102a38:	0f bf 40 56          	movswl 0x56(%eax),%eax
80102a3c:	66 83 f8 09          	cmp    $0x9,%ax
80102a40:	77 3e                	ja     80102a80 <writei+0x140>
80102a42:	8b 04 c5 04 2d 12 80 	mov    -0x7fedd2fc(,%eax,8),%eax
80102a49:	85 c0                	test   %eax,%eax
80102a4b:	74 33                	je     80102a80 <writei+0x140>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80102a4d:	83 ec 04             	sub    $0x4,%esp
80102a50:	ff 75 14             	pushl  0x14(%ebp)
80102a53:	ff 75 0c             	pushl  0xc(%ebp)
80102a56:	ff 75 08             	pushl  0x8(%ebp)
80102a59:	ff d0                	call   *%eax
80102a5b:	83 c4 10             	add    $0x10,%esp
  datetime(&date);
  ip->ctime = dateToTimestamp(&date);

  iupdate(ip);
  return n;
}
80102a5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a61:	5b                   	pop    %ebx
80102a62:	5e                   	pop    %esi
80102a63:	5f                   	pop    %edi
80102a64:	5d                   	pop    %ebp
80102a65:	c3                   	ret    
80102a66:	8d 76 00             	lea    0x0(%esi),%esi
80102a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80102a70:	8b 45 08             	mov    0x8(%ebp),%eax
80102a73:	89 70 5c             	mov    %esi,0x5c(%eax)
80102a76:	eb 8b                	jmp    80102a03 <writei+0xc3>
80102a78:	90                   	nop
80102a79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80102a80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102a85:	eb a4                	jmp    80102a2b <writei+0xeb>
80102a87:	89 f6                	mov    %esi,%esi
80102a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a90 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102a90:	55                   	push   %ebp
80102a91:	89 e5                	mov    %esp,%ebp
80102a93:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102a96:	6a 0e                	push   $0xe
80102a98:	ff 75 0c             	pushl  0xc(%ebp)
80102a9b:	ff 75 08             	pushl  0x8(%ebp)
80102a9e:	e8 ad 29 00 00       	call   80105450 <strncmp>
}
80102aa3:	c9                   	leave  
80102aa4:	c3                   	ret    
80102aa5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ab0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102ab0:	55                   	push   %ebp
80102ab1:	89 e5                	mov    %esp,%ebp
80102ab3:	57                   	push   %edi
80102ab4:	56                   	push   %esi
80102ab5:	53                   	push   %ebx
80102ab6:	83 ec 1c             	sub    $0x1c,%esp
80102ab9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102abc:	66 83 7b 54 01       	cmpw   $0x1,0x54(%ebx)
80102ac1:	0f 85 80 00 00 00    	jne    80102b47 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102ac7:	8b 53 5c             	mov    0x5c(%ebx),%edx
80102aca:	31 ff                	xor    %edi,%edi
80102acc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102acf:	85 d2                	test   %edx,%edx
80102ad1:	75 0d                	jne    80102ae0 <dirlookup+0x30>
80102ad3:	eb 5b                	jmp    80102b30 <dirlookup+0x80>
80102ad5:	8d 76 00             	lea    0x0(%esi),%esi
80102ad8:	83 c7 10             	add    $0x10,%edi
80102adb:	39 7b 5c             	cmp    %edi,0x5c(%ebx)
80102ade:	76 50                	jbe    80102b30 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102ae0:	6a 10                	push   $0x10
80102ae2:	57                   	push   %edi
80102ae3:	56                   	push   %esi
80102ae4:	53                   	push   %ebx
80102ae5:	e8 56 fd ff ff       	call   80102840 <readi>
80102aea:	83 c4 10             	add    $0x10,%esp
80102aed:	83 f8 10             	cmp    $0x10,%eax
80102af0:	75 48                	jne    80102b3a <dirlookup+0x8a>
      panic("dirlookup read");
    if(de.inum == 0)
80102af2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102af7:	74 df                	je     80102ad8 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80102af9:	8d 45 da             	lea    -0x26(%ebp),%eax
80102afc:	83 ec 04             	sub    $0x4,%esp
80102aff:	6a 0e                	push   $0xe
80102b01:	50                   	push   %eax
80102b02:	ff 75 0c             	pushl  0xc(%ebp)
80102b05:	e8 46 29 00 00       	call   80105450 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80102b0a:	83 c4 10             	add    $0x10,%esp
80102b0d:	85 c0                	test   %eax,%eax
80102b0f:	75 c7                	jne    80102ad8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80102b11:	8b 45 10             	mov    0x10(%ebp),%eax
80102b14:	85 c0                	test   %eax,%eax
80102b16:	74 05                	je     80102b1d <dirlookup+0x6d>
        *poff = off;
80102b18:	8b 45 10             	mov    0x10(%ebp),%eax
80102b1b:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80102b1d:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80102b21:	8b 03                	mov    (%ebx),%eax
80102b23:	e8 b8 f4 ff ff       	call   80101fe0 <iget>
    }
  }

  return 0;
}
80102b28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b2b:	5b                   	pop    %ebx
80102b2c:	5e                   	pop    %esi
80102b2d:	5f                   	pop    %edi
80102b2e:	5d                   	pop    %ebp
80102b2f:	c3                   	ret    
80102b30:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80102b33:	31 c0                	xor    %eax,%eax
}
80102b35:	5b                   	pop    %ebx
80102b36:	5e                   	pop    %esi
80102b37:	5f                   	pop    %edi
80102b38:	5d                   	pop    %ebp
80102b39:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80102b3a:	83 ec 0c             	sub    $0xc,%esp
80102b3d:	68 a1 83 10 80       	push   $0x801083a1
80102b42:	e8 79 dc ff ff       	call   801007c0 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80102b47:	83 ec 0c             	sub    $0xc,%esp
80102b4a:	68 8f 83 10 80       	push   $0x8010838f
80102b4f:	e8 6c dc ff ff       	call   801007c0 <panic>
80102b54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102b60 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102b60:	55                   	push   %ebp
80102b61:	89 e5                	mov    %esp,%ebp
80102b63:	57                   	push   %edi
80102b64:	56                   	push   %esi
80102b65:	53                   	push   %ebx
80102b66:	89 cf                	mov    %ecx,%edi
80102b68:	89 c3                	mov    %eax,%ebx
80102b6a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102b6d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102b70:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80102b73:	0f 84 53 01 00 00    	je     80102ccc <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80102b79:	e8 12 1b 00 00       	call   80104690 <myproc>
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80102b7e:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80102b81:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80102b84:	68 80 2d 12 80       	push   $0x80122d80
80102b89:	e8 22 26 00 00       	call   801051b0 <acquire>
  ip->ref++;
80102b8e:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102b92:	c7 04 24 80 2d 12 80 	movl   $0x80122d80,(%esp)
80102b99:	e8 32 27 00 00       	call   801052d0 <release>
80102b9e:	83 c4 10             	add    $0x10,%esp
80102ba1:	eb 08                	jmp    80102bab <namex+0x4b>
80102ba3:	90                   	nop
80102ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80102ba8:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80102bab:	0f b6 03             	movzbl (%ebx),%eax
80102bae:	3c 2f                	cmp    $0x2f,%al
80102bb0:	74 f6                	je     80102ba8 <namex+0x48>
    path++;
  if(*path == 0)
80102bb2:	84 c0                	test   %al,%al
80102bb4:	0f 84 e3 00 00 00    	je     80102c9d <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102bba:	0f b6 03             	movzbl (%ebx),%eax
80102bbd:	89 da                	mov    %ebx,%edx
80102bbf:	84 c0                	test   %al,%al
80102bc1:	0f 84 ac 00 00 00    	je     80102c73 <namex+0x113>
80102bc7:	3c 2f                	cmp    $0x2f,%al
80102bc9:	75 09                	jne    80102bd4 <namex+0x74>
80102bcb:	e9 a3 00 00 00       	jmp    80102c73 <namex+0x113>
80102bd0:	84 c0                	test   %al,%al
80102bd2:	74 0a                	je     80102bde <namex+0x7e>
    path++;
80102bd4:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102bd7:	0f b6 02             	movzbl (%edx),%eax
80102bda:	3c 2f                	cmp    $0x2f,%al
80102bdc:	75 f2                	jne    80102bd0 <namex+0x70>
80102bde:	89 d1                	mov    %edx,%ecx
80102be0:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80102be2:	83 f9 0d             	cmp    $0xd,%ecx
80102be5:	0f 8e 8d 00 00 00    	jle    80102c78 <namex+0x118>
    memmove(name, s, DIRSIZ);
80102beb:	83 ec 04             	sub    $0x4,%esp
80102bee:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80102bf1:	6a 0e                	push   $0xe
80102bf3:	53                   	push   %ebx
80102bf4:	57                   	push   %edi
80102bf5:	e8 d6 27 00 00       	call   801053d0 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80102bfa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80102bfd:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80102c00:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102c02:	80 3a 2f             	cmpb   $0x2f,(%edx)
80102c05:	75 11                	jne    80102c18 <namex+0xb8>
80102c07:	89 f6                	mov    %esi,%esi
80102c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80102c10:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102c13:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102c16:	74 f8                	je     80102c10 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102c18:	83 ec 0c             	sub    $0xc,%esp
80102c1b:	56                   	push   %esi
80102c1c:	e8 2f f9 ff ff       	call   80102550 <ilock>
    if(ip->type != T_DIR){
80102c21:	83 c4 10             	add    $0x10,%esp
80102c24:	66 83 7e 54 01       	cmpw   $0x1,0x54(%esi)
80102c29:	0f 85 7f 00 00 00    	jne    80102cae <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102c2f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80102c32:	85 d2                	test   %edx,%edx
80102c34:	74 09                	je     80102c3f <namex+0xdf>
80102c36:	80 3b 00             	cmpb   $0x0,(%ebx)
80102c39:	0f 84 a3 00 00 00    	je     80102ce2 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102c3f:	83 ec 04             	sub    $0x4,%esp
80102c42:	6a 00                	push   $0x0
80102c44:	57                   	push   %edi
80102c45:	56                   	push   %esi
80102c46:	e8 65 fe ff ff       	call   80102ab0 <dirlookup>
80102c4b:	83 c4 10             	add    $0x10,%esp
80102c4e:	85 c0                	test   %eax,%eax
80102c50:	74 5c                	je     80102cae <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80102c52:	83 ec 0c             	sub    $0xc,%esp
80102c55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102c58:	56                   	push   %esi
80102c59:	e8 d2 f9 ff ff       	call   80102630 <iunlock>
  iput(ip);
80102c5e:	89 34 24             	mov    %esi,(%esp)
80102c61:	e8 1a fa ff ff       	call   80102680 <iput>
80102c66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102c69:	83 c4 10             	add    $0x10,%esp
80102c6c:	89 c6                	mov    %eax,%esi
80102c6e:	e9 38 ff ff ff       	jmp    80102bab <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102c73:	31 c9                	xor    %ecx,%ecx
80102c75:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80102c78:	83 ec 04             	sub    $0x4,%esp
80102c7b:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102c7e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102c81:	51                   	push   %ecx
80102c82:	53                   	push   %ebx
80102c83:	57                   	push   %edi
80102c84:	e8 47 27 00 00       	call   801053d0 <memmove>
    name[len] = 0;
80102c89:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102c8c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80102c8f:	83 c4 10             	add    $0x10,%esp
80102c92:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80102c96:	89 d3                	mov    %edx,%ebx
80102c98:	e9 65 ff ff ff       	jmp    80102c02 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102c9d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102ca0:	85 c0                	test   %eax,%eax
80102ca2:	75 54                	jne    80102cf8 <namex+0x198>
80102ca4:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80102ca6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102ca9:	5b                   	pop    %ebx
80102caa:	5e                   	pop    %esi
80102cab:	5f                   	pop    %edi
80102cac:	5d                   	pop    %ebp
80102cad:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80102cae:	83 ec 0c             	sub    $0xc,%esp
80102cb1:	56                   	push   %esi
80102cb2:	e8 79 f9 ff ff       	call   80102630 <iunlock>
  iput(ip);
80102cb7:	89 34 24             	mov    %esi,(%esp)
80102cba:	e8 c1 f9 ff ff       	call   80102680 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80102cbf:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102cc2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80102cc5:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102cc7:	5b                   	pop    %ebx
80102cc8:	5e                   	pop    %esi
80102cc9:	5f                   	pop    %edi
80102cca:	5d                   	pop    %ebp
80102ccb:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80102ccc:	ba 01 00 00 00       	mov    $0x1,%edx
80102cd1:	b8 01 00 00 00       	mov    $0x1,%eax
80102cd6:	e8 05 f3 ff ff       	call   80101fe0 <iget>
80102cdb:	89 c6                	mov    %eax,%esi
80102cdd:	e9 c9 fe ff ff       	jmp    80102bab <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80102ce2:	83 ec 0c             	sub    $0xc,%esp
80102ce5:	56                   	push   %esi
80102ce6:	e8 45 f9 ff ff       	call   80102630 <iunlock>
      return ip;
80102ceb:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102cee:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80102cf1:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80102cf3:	5b                   	pop    %ebx
80102cf4:	5e                   	pop    %esi
80102cf5:	5f                   	pop    %edi
80102cf6:	5d                   	pop    %ebp
80102cf7:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80102cf8:	83 ec 0c             	sub    $0xc,%esp
80102cfb:	56                   	push   %esi
80102cfc:	e8 7f f9 ff ff       	call   80102680 <iput>
    return 0;
80102d01:	83 c4 10             	add    $0x10,%esp
80102d04:	31 c0                	xor    %eax,%eax
80102d06:	eb 9e                	jmp    80102ca6 <namex+0x146>
80102d08:	90                   	nop
80102d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d10 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102d10:	55                   	push   %ebp
80102d11:	89 e5                	mov    %esp,%ebp
80102d13:	57                   	push   %edi
80102d14:	56                   	push   %esi
80102d15:	53                   	push   %ebx
80102d16:	83 ec 20             	sub    $0x20,%esp
80102d19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102d1c:	6a 00                	push   $0x0
80102d1e:	ff 75 0c             	pushl  0xc(%ebp)
80102d21:	53                   	push   %ebx
80102d22:	e8 89 fd ff ff       	call   80102ab0 <dirlookup>
80102d27:	83 c4 10             	add    $0x10,%esp
80102d2a:	85 c0                	test   %eax,%eax
80102d2c:	75 67                	jne    80102d95 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102d2e:	8b 7b 5c             	mov    0x5c(%ebx),%edi
80102d31:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102d34:	85 ff                	test   %edi,%edi
80102d36:	74 29                	je     80102d61 <dirlink+0x51>
80102d38:	31 ff                	xor    %edi,%edi
80102d3a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102d3d:	eb 09                	jmp    80102d48 <dirlink+0x38>
80102d3f:	90                   	nop
80102d40:	83 c7 10             	add    $0x10,%edi
80102d43:	39 7b 5c             	cmp    %edi,0x5c(%ebx)
80102d46:	76 19                	jbe    80102d61 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102d48:	6a 10                	push   $0x10
80102d4a:	57                   	push   %edi
80102d4b:	56                   	push   %esi
80102d4c:	53                   	push   %ebx
80102d4d:	e8 ee fa ff ff       	call   80102840 <readi>
80102d52:	83 c4 10             	add    $0x10,%esp
80102d55:	83 f8 10             	cmp    $0x10,%eax
80102d58:	75 4e                	jne    80102da8 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80102d5a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102d5f:	75 df                	jne    80102d40 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80102d61:	8d 45 da             	lea    -0x26(%ebp),%eax
80102d64:	83 ec 04             	sub    $0x4,%esp
80102d67:	6a 0e                	push   $0xe
80102d69:	ff 75 0c             	pushl  0xc(%ebp)
80102d6c:	50                   	push   %eax
80102d6d:	e8 4e 27 00 00       	call   801054c0 <strncpy>
  de.inum = inum;
80102d72:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102d75:	6a 10                	push   $0x10
80102d77:	57                   	push   %edi
80102d78:	56                   	push   %esi
80102d79:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80102d7a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102d7e:	e8 bd fb ff ff       	call   80102940 <writei>
80102d83:	83 c4 20             	add    $0x20,%esp
80102d86:	83 f8 10             	cmp    $0x10,%eax
80102d89:	75 2a                	jne    80102db5 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80102d8b:	31 c0                	xor    %eax,%eax
}
80102d8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d90:	5b                   	pop    %ebx
80102d91:	5e                   	pop    %esi
80102d92:	5f                   	pop    %edi
80102d93:	5d                   	pop    %ebp
80102d94:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80102d95:	83 ec 0c             	sub    $0xc,%esp
80102d98:	50                   	push   %eax
80102d99:	e8 e2 f8 ff ff       	call   80102680 <iput>
    return -1;
80102d9e:	83 c4 10             	add    $0x10,%esp
80102da1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102da6:	eb e5                	jmp    80102d8d <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80102da8:	83 ec 0c             	sub    $0xc,%esp
80102dab:	68 b0 83 10 80       	push   $0x801083b0
80102db0:	e8 0b da ff ff       	call   801007c0 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80102db5:	83 ec 0c             	sub    $0xc,%esp
80102db8:	68 a2 89 10 80       	push   $0x801089a2
80102dbd:	e8 fe d9 ff ff       	call   801007c0 <panic>
80102dc2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102dd0 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80102dd0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102dd1:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80102dd3:	89 e5                	mov    %esp,%ebp
80102dd5:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102dd8:	8b 45 08             	mov    0x8(%ebp),%eax
80102ddb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102dde:	e8 7d fd ff ff       	call   80102b60 <namex>
}
80102de3:	c9                   	leave  
80102de4:	c3                   	ret    
80102de5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102df0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102df0:	55                   	push   %ebp
  return namex(path, 1, name);
80102df1:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80102df6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102df8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102dfb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102dfe:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80102dff:	e9 5c fd ff ff       	jmp    80102b60 <namex>
80102e04:	66 90                	xchg   %ax,%ax
80102e06:	66 90                	xchg   %ax,%ax
80102e08:	66 90                	xchg   %ax,%ax
80102e0a:	66 90                	xchg   %ax,%ax
80102e0c:	66 90                	xchg   %ax,%ax
80102e0e:	66 90                	xchg   %ax,%ax

80102e10 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102e10:	55                   	push   %ebp
  if(b == 0)
80102e11:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102e13:	89 e5                	mov    %esp,%ebp
80102e15:	56                   	push   %esi
80102e16:	53                   	push   %ebx
  if(b == 0)
80102e17:	0f 84 ad 00 00 00    	je     80102eca <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102e1d:	8b 58 08             	mov    0x8(%eax),%ebx
80102e20:	89 c1                	mov    %eax,%ecx
80102e22:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80102e28:	0f 87 8f 00 00 00    	ja     80102ebd <idestart+0xad>
80102e2e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102e33:	90                   	nop
80102e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e38:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102e39:	83 e0 c0             	and    $0xffffffc0,%eax
80102e3c:	3c 40                	cmp    $0x40,%al
80102e3e:	75 f8                	jne    80102e38 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e40:	31 f6                	xor    %esi,%esi
80102e42:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102e47:	89 f0                	mov    %esi,%eax
80102e49:	ee                   	out    %al,(%dx)
80102e4a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102e4f:	b8 01 00 00 00       	mov    $0x1,%eax
80102e54:	ee                   	out    %al,(%dx)
80102e55:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102e5a:	89 d8                	mov    %ebx,%eax
80102e5c:	ee                   	out    %al,(%dx)
80102e5d:	89 d8                	mov    %ebx,%eax
80102e5f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102e64:	c1 f8 08             	sar    $0x8,%eax
80102e67:	ee                   	out    %al,(%dx)
80102e68:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102e6d:	89 f0                	mov    %esi,%eax
80102e6f:	ee                   	out    %al,(%dx)
80102e70:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80102e74:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102e79:	83 e0 01             	and    $0x1,%eax
80102e7c:	c1 e0 04             	shl    $0x4,%eax
80102e7f:	83 c8 e0             	or     $0xffffffe0,%eax
80102e82:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80102e83:	f6 01 04             	testb  $0x4,(%ecx)
80102e86:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102e8b:	75 13                	jne    80102ea0 <idestart+0x90>
80102e8d:	b8 20 00 00 00       	mov    $0x20,%eax
80102e92:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102e93:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102e96:	5b                   	pop    %ebx
80102e97:	5e                   	pop    %esi
80102e98:	5d                   	pop    %ebp
80102e99:	c3                   	ret    
80102e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102ea0:	b8 30 00 00 00       	mov    $0x30,%eax
80102ea5:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80102ea6:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80102eab:	8d 71 5c             	lea    0x5c(%ecx),%esi
80102eae:	b9 80 00 00 00       	mov    $0x80,%ecx
80102eb3:	fc                   	cld    
80102eb4:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102eb6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102eb9:	5b                   	pop    %ebx
80102eba:	5e                   	pop    %esi
80102ebb:	5d                   	pop    %ebp
80102ebc:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80102ebd:	83 ec 0c             	sub    $0xc,%esp
80102ec0:	68 1c 84 10 80       	push   $0x8010841c
80102ec5:	e8 f6 d8 ff ff       	call   801007c0 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80102eca:	83 ec 0c             	sub    $0xc,%esp
80102ecd:	68 13 84 10 80       	push   $0x80108413
80102ed2:	e8 e9 d8 ff ff       	call   801007c0 <panic>
80102ed7:	89 f6                	mov    %esi,%esi
80102ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ee0 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102ee0:	55                   	push   %ebp
80102ee1:	89 e5                	mov    %esp,%ebp
80102ee3:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80102ee6:	68 2e 84 10 80       	push   $0x8010842e
80102eeb:	68 c0 b5 10 80       	push   $0x8010b5c0
80102ef0:	e8 bb 21 00 00       	call   801050b0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102ef5:	58                   	pop    %eax
80102ef6:	a1 a0 50 12 80       	mov    0x801250a0,%eax
80102efb:	5a                   	pop    %edx
80102efc:	83 e8 01             	sub    $0x1,%eax
80102eff:	50                   	push   %eax
80102f00:	6a 0e                	push   $0xe
80102f02:	e8 a9 02 00 00       	call   801031b0 <ioapicenable>
80102f07:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f0a:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102f0f:	90                   	nop
80102f10:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102f11:	83 e0 c0             	and    $0xffffffc0,%eax
80102f14:	3c 40                	cmp    $0x40,%al
80102f16:	75 f8                	jne    80102f10 <ideinit+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f18:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102f1d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102f22:	ee                   	out    %al,(%dx)
80102f23:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f28:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102f2d:	eb 06                	jmp    80102f35 <ideinit+0x55>
80102f2f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102f30:	83 e9 01             	sub    $0x1,%ecx
80102f33:	74 0f                	je     80102f44 <ideinit+0x64>
80102f35:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102f36:	84 c0                	test   %al,%al
80102f38:	74 f6                	je     80102f30 <ideinit+0x50>
      havedisk1 = 1;
80102f3a:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
80102f41:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f44:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102f49:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102f4e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
80102f4f:	c9                   	leave  
80102f50:	c3                   	ret    
80102f51:	eb 0d                	jmp    80102f60 <ideintr>
80102f53:	90                   	nop
80102f54:	90                   	nop
80102f55:	90                   	nop
80102f56:	90                   	nop
80102f57:	90                   	nop
80102f58:	90                   	nop
80102f59:	90                   	nop
80102f5a:	90                   	nop
80102f5b:	90                   	nop
80102f5c:	90                   	nop
80102f5d:	90                   	nop
80102f5e:	90                   	nop
80102f5f:	90                   	nop

80102f60 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
80102f60:	55                   	push   %ebp
80102f61:	89 e5                	mov    %esp,%ebp
80102f63:	57                   	push   %edi
80102f64:	56                   	push   %esi
80102f65:	53                   	push   %ebx
80102f66:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102f69:	68 c0 b5 10 80       	push   $0x8010b5c0
80102f6e:	e8 3d 22 00 00       	call   801051b0 <acquire>

  if((b = idequeue) == 0){
80102f73:	8b 1d a4 b5 10 80    	mov    0x8010b5a4,%ebx
80102f79:	83 c4 10             	add    $0x10,%esp
80102f7c:	85 db                	test   %ebx,%ebx
80102f7e:	74 34                	je     80102fb4 <ideintr+0x54>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102f80:	8b 43 58             	mov    0x58(%ebx),%eax
80102f83:	a3 a4 b5 10 80       	mov    %eax,0x8010b5a4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102f88:	8b 33                	mov    (%ebx),%esi
80102f8a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102f90:	74 3e                	je     80102fd0 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102f92:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102f95:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102f98:	83 ce 02             	or     $0x2,%esi
80102f9b:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
80102f9d:	53                   	push   %ebx
80102f9e:	e8 4d 1e 00 00       	call   80104df0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102fa3:	a1 a4 b5 10 80       	mov    0x8010b5a4,%eax
80102fa8:	83 c4 10             	add    $0x10,%esp
80102fab:	85 c0                	test   %eax,%eax
80102fad:	74 05                	je     80102fb4 <ideintr+0x54>
    idestart(idequeue);
80102faf:	e8 5c fe ff ff       	call   80102e10 <idestart>

  // First queued buffer is the active request.
  acquire(&idelock);

  if((b = idequeue) == 0){
    release(&idelock);
80102fb4:	83 ec 0c             	sub    $0xc,%esp
80102fb7:	68 c0 b5 10 80       	push   $0x8010b5c0
80102fbc:	e8 0f 23 00 00       	call   801052d0 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80102fc1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fc4:	5b                   	pop    %ebx
80102fc5:	5e                   	pop    %esi
80102fc6:	5f                   	pop    %edi
80102fc7:	5d                   	pop    %ebp
80102fc8:	c3                   	ret    
80102fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fd0:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102fd5:	8d 76 00             	lea    0x0(%esi),%esi
80102fd8:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102fd9:	89 c1                	mov    %eax,%ecx
80102fdb:	83 e1 c0             	and    $0xffffffc0,%ecx
80102fde:	80 f9 40             	cmp    $0x40,%cl
80102fe1:	75 f5                	jne    80102fd8 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102fe3:	a8 21                	test   $0x21,%al
80102fe5:	75 ab                	jne    80102f92 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80102fe7:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
80102fea:	b9 80 00 00 00       	mov    $0x80,%ecx
80102fef:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102ff4:	fc                   	cld    
80102ff5:	f3 6d                	rep insl (%dx),%es:(%edi)
80102ff7:	8b 33                	mov    (%ebx),%esi
80102ff9:	eb 97                	jmp    80102f92 <ideintr+0x32>
80102ffb:	90                   	nop
80102ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103000 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	53                   	push   %ebx
80103004:	83 ec 10             	sub    $0x10,%esp
80103007:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010300a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010300d:	50                   	push   %eax
8010300e:	e8 6d 20 00 00       	call   80105080 <holdingsleep>
80103013:	83 c4 10             	add    $0x10,%esp
80103016:	85 c0                	test   %eax,%eax
80103018:	0f 84 ad 00 00 00    	je     801030cb <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010301e:	8b 03                	mov    (%ebx),%eax
80103020:	83 e0 06             	and    $0x6,%eax
80103023:	83 f8 02             	cmp    $0x2,%eax
80103026:	0f 84 b9 00 00 00    	je     801030e5 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010302c:	8b 53 04             	mov    0x4(%ebx),%edx
8010302f:	85 d2                	test   %edx,%edx
80103031:	74 0d                	je     80103040 <iderw+0x40>
80103033:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
80103038:	85 c0                	test   %eax,%eax
8010303a:	0f 84 98 00 00 00    	je     801030d8 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80103040:	83 ec 0c             	sub    $0xc,%esp
80103043:	68 c0 b5 10 80       	push   $0x8010b5c0
80103048:	e8 63 21 00 00       	call   801051b0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010304d:	8b 15 a4 b5 10 80    	mov    0x8010b5a4,%edx
80103053:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80103056:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010305d:	85 d2                	test   %edx,%edx
8010305f:	75 09                	jne    8010306a <iderw+0x6a>
80103061:	eb 58                	jmp    801030bb <iderw+0xbb>
80103063:	90                   	nop
80103064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103068:	89 c2                	mov    %eax,%edx
8010306a:	8b 42 58             	mov    0x58(%edx),%eax
8010306d:	85 c0                	test   %eax,%eax
8010306f:	75 f7                	jne    80103068 <iderw+0x68>
80103071:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
80103074:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
80103076:	3b 1d a4 b5 10 80    	cmp    0x8010b5a4,%ebx
8010307c:	74 44                	je     801030c2 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010307e:	8b 03                	mov    (%ebx),%eax
80103080:	83 e0 06             	and    $0x6,%eax
80103083:	83 f8 02             	cmp    $0x2,%eax
80103086:	74 23                	je     801030ab <iderw+0xab>
80103088:	90                   	nop
80103089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
80103090:	83 ec 08             	sub    $0x8,%esp
80103093:	68 c0 b5 10 80       	push   $0x8010b5c0
80103098:	53                   	push   %ebx
80103099:	e8 a2 1b 00 00       	call   80104c40 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010309e:	8b 03                	mov    (%ebx),%eax
801030a0:	83 c4 10             	add    $0x10,%esp
801030a3:	83 e0 06             	and    $0x6,%eax
801030a6:	83 f8 02             	cmp    $0x2,%eax
801030a9:	75 e5                	jne    80103090 <iderw+0x90>
    sleep(b, &idelock);
  }


  release(&idelock);
801030ab:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
801030b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030b5:	c9                   	leave  
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
801030b6:	e9 15 22 00 00       	jmp    801052d0 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801030bb:	ba a4 b5 10 80       	mov    $0x8010b5a4,%edx
801030c0:	eb b2                	jmp    80103074 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801030c2:	89 d8                	mov    %ebx,%eax
801030c4:	e8 47 fd ff ff       	call   80102e10 <idestart>
801030c9:	eb b3                	jmp    8010307e <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801030cb:	83 ec 0c             	sub    $0xc,%esp
801030ce:	68 32 84 10 80       	push   $0x80108432
801030d3:	e8 e8 d6 ff ff       	call   801007c0 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
801030d8:	83 ec 0c             	sub    $0xc,%esp
801030db:	68 5d 84 10 80       	push   $0x8010845d
801030e0:	e8 db d6 ff ff       	call   801007c0 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
801030e5:	83 ec 0c             	sub    $0xc,%esp
801030e8:	68 48 84 10 80       	push   $0x80108448
801030ed:	e8 ce d6 ff ff       	call   801007c0 <panic>
801030f2:	66 90                	xchg   %ax,%ax
801030f4:	66 90                	xchg   %ax,%ax
801030f6:	66 90                	xchg   %ax,%ax
801030f8:	66 90                	xchg   %ax,%ax
801030fa:	66 90                	xchg   %ax,%ax
801030fc:	66 90                	xchg   %ax,%ax
801030fe:	66 90                	xchg   %ax,%ax

80103100 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80103100:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80103101:	c7 05 d4 49 12 80 00 	movl   $0xfec00000,0x801249d4
80103108:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010310b:	89 e5                	mov    %esp,%ebp
8010310d:	56                   	push   %esi
8010310e:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
8010310f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80103116:	00 00 00 
  return ioapic->data;
80103119:	8b 15 d4 49 12 80    	mov    0x801249d4,%edx
8010311f:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80103122:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80103128:	8b 0d d4 49 12 80    	mov    0x801249d4,%ecx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010312e:	0f b6 15 00 4b 12 80 	movzbl 0x80124b00,%edx
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80103135:	89 f0                	mov    %esi,%eax
80103137:	c1 e8 10             	shr    $0x10,%eax
8010313a:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010313d:	8b 41 10             	mov    0x10(%ecx),%eax
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80103140:	c1 e8 18             	shr    $0x18,%eax
80103143:	39 d0                	cmp    %edx,%eax
80103145:	74 16                	je     8010315d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80103147:	83 ec 0c             	sub    $0xc,%esp
8010314a:	68 7c 84 10 80       	push   $0x8010847c
8010314f:	e8 dc d4 ff ff       	call   80100630 <cprintf>
80103154:	8b 0d d4 49 12 80    	mov    0x801249d4,%ecx
8010315a:	83 c4 10             	add    $0x10,%esp
8010315d:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
80103160:	ba 10 00 00 00       	mov    $0x10,%edx
80103165:	b8 20 00 00 00       	mov    $0x20,%eax
8010316a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80103170:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
80103172:	8b 0d d4 49 12 80    	mov    0x801249d4,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80103178:	89 c3                	mov    %eax,%ebx
8010317a:	81 cb 00 00 01 00    	or     $0x10000,%ebx
80103180:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80103183:	89 59 10             	mov    %ebx,0x10(%ecx)
80103186:	8d 5a 01             	lea    0x1(%edx),%ebx
80103189:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010318c:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010318e:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80103190:	8b 0d d4 49 12 80    	mov    0x801249d4,%ecx
80103196:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010319d:	75 d1                	jne    80103170 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010319f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801031a2:	5b                   	pop    %ebx
801031a3:	5e                   	pop    %esi
801031a4:	5d                   	pop    %ebp
801031a5:	c3                   	ret    
801031a6:	8d 76 00             	lea    0x0(%esi),%esi
801031a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801031b0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801031b0:	55                   	push   %ebp
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801031b1:	8b 0d d4 49 12 80    	mov    0x801249d4,%ecx
  }
}

void
ioapicenable(int irq, int cpunum)
{
801031b7:	89 e5                	mov    %esp,%ebp
801031b9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801031bc:	8d 50 20             	lea    0x20(%eax),%edx
801031bf:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801031c3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801031c5:	8b 0d d4 49 12 80    	mov    0x801249d4,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801031cb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801031ce:	89 51 10             	mov    %edx,0x10(%ecx)
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801031d1:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801031d4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801031d6:	a1 d4 49 12 80       	mov    0x801249d4,%eax
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801031db:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801031de:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801031e1:	5d                   	pop    %ebp
801031e2:	c3                   	ret    
801031e3:	66 90                	xchg   %ax,%ax
801031e5:	66 90                	xchg   %ax,%ax
801031e7:	66 90                	xchg   %ax,%ax
801031e9:	66 90                	xchg   %ax,%ax
801031eb:	66 90                	xchg   %ax,%ax
801031ed:	66 90                	xchg   %ax,%ax
801031ef:	90                   	nop

801031f0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801031f0:	55                   	push   %ebp
801031f1:	89 e5                	mov    %esp,%ebp
801031f3:	53                   	push   %ebx
801031f4:	83 ec 04             	sub    $0x4,%esp
801031f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801031fa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80103200:	75 70                	jne    80103272 <kfree+0x82>
80103202:	81 fb 48 78 12 80    	cmp    $0x80127848,%ebx
80103208:	72 68                	jb     80103272 <kfree+0x82>
8010320a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80103210:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80103215:	77 5b                	ja     80103272 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80103217:	83 ec 04             	sub    $0x4,%esp
8010321a:	68 00 10 00 00       	push   $0x1000
8010321f:	6a 01                	push   $0x1
80103221:	53                   	push   %ebx
80103222:	e8 f9 20 00 00       	call   80105320 <memset>

  if(kmem.use_lock)
80103227:	8b 15 14 4a 12 80    	mov    0x80124a14,%edx
8010322d:	83 c4 10             	add    $0x10,%esp
80103230:	85 d2                	test   %edx,%edx
80103232:	75 2c                	jne    80103260 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80103234:	a1 18 4a 12 80       	mov    0x80124a18,%eax
80103239:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010323b:	a1 14 4a 12 80       	mov    0x80124a14,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80103240:	89 1d 18 4a 12 80    	mov    %ebx,0x80124a18
  if(kmem.use_lock)
80103246:	85 c0                	test   %eax,%eax
80103248:	75 06                	jne    80103250 <kfree+0x60>
    release(&kmem.lock);
}
8010324a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010324d:	c9                   	leave  
8010324e:	c3                   	ret    
8010324f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80103250:	c7 45 08 e0 49 12 80 	movl   $0x801249e0,0x8(%ebp)
}
80103257:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010325a:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
8010325b:	e9 70 20 00 00       	jmp    801052d0 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80103260:	83 ec 0c             	sub    $0xc,%esp
80103263:	68 e0 49 12 80       	push   $0x801249e0
80103268:	e8 43 1f 00 00       	call   801051b0 <acquire>
8010326d:	83 c4 10             	add    $0x10,%esp
80103270:	eb c2                	jmp    80103234 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80103272:	83 ec 0c             	sub    $0xc,%esp
80103275:	68 ae 84 10 80       	push   $0x801084ae
8010327a:	e8 41 d5 ff ff       	call   801007c0 <panic>
8010327f:	90                   	nop

80103280 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80103280:	55                   	push   %ebp
80103281:	89 e5                	mov    %esp,%ebp
80103283:	56                   	push   %esi
80103284:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80103285:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
80103288:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010328b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103291:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103297:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010329d:	39 de                	cmp    %ebx,%esi
8010329f:	72 23                	jb     801032c4 <freerange+0x44>
801032a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801032a8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801032ae:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801032b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801032b7:	50                   	push   %eax
801032b8:	e8 33 ff ff ff       	call   801031f0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801032bd:	83 c4 10             	add    $0x10,%esp
801032c0:	39 f3                	cmp    %esi,%ebx
801032c2:	76 e4                	jbe    801032a8 <freerange+0x28>
    kfree(p);
}
801032c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801032c7:	5b                   	pop    %ebx
801032c8:	5e                   	pop    %esi
801032c9:	5d                   	pop    %ebp
801032ca:	c3                   	ret    
801032cb:	90                   	nop
801032cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801032d0 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801032d0:	55                   	push   %ebp
801032d1:	89 e5                	mov    %esp,%ebp
801032d3:	56                   	push   %esi
801032d4:	53                   	push   %ebx
801032d5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801032d8:	83 ec 08             	sub    $0x8,%esp
801032db:	68 b4 84 10 80       	push   $0x801084b4
801032e0:	68 e0 49 12 80       	push   $0x801249e0
801032e5:	e8 c6 1d 00 00       	call   801050b0 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801032ea:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801032ed:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
801032f0:	c7 05 14 4a 12 80 00 	movl   $0x0,0x80124a14
801032f7:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801032fa:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103300:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103306:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010330c:	39 de                	cmp    %ebx,%esi
8010330e:	72 1c                	jb     8010332c <kinit1+0x5c>
    kfree(p);
80103310:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80103316:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103319:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010331f:	50                   	push   %eax
80103320:	e8 cb fe ff ff       	call   801031f0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103325:	83 c4 10             	add    $0x10,%esp
80103328:	39 de                	cmp    %ebx,%esi
8010332a:	73 e4                	jae    80103310 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010332c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010332f:	5b                   	pop    %ebx
80103330:	5e                   	pop    %esi
80103331:	5d                   	pop    %ebp
80103332:	c3                   	ret    
80103333:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103340 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80103340:	55                   	push   %ebp
80103341:	89 e5                	mov    %esp,%ebp
80103343:	56                   	push   %esi
80103344:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80103345:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80103348:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010334b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103351:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103357:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010335d:	39 de                	cmp    %ebx,%esi
8010335f:	72 23                	jb     80103384 <kinit2+0x44>
80103361:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103368:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010336e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103371:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103377:	50                   	push   %eax
80103378:	e8 73 fe ff ff       	call   801031f0 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010337d:	83 c4 10             	add    $0x10,%esp
80103380:	39 de                	cmp    %ebx,%esi
80103382:	73 e4                	jae    80103368 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
80103384:	c7 05 14 4a 12 80 01 	movl   $0x1,0x80124a14
8010338b:	00 00 00 
}
8010338e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103391:	5b                   	pop    %ebx
80103392:	5e                   	pop    %esi
80103393:	5d                   	pop    %ebp
80103394:	c3                   	ret    
80103395:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801033a0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801033a0:	55                   	push   %ebp
801033a1:	89 e5                	mov    %esp,%ebp
801033a3:	53                   	push   %ebx
801033a4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801033a7:	a1 14 4a 12 80       	mov    0x80124a14,%eax
801033ac:	85 c0                	test   %eax,%eax
801033ae:	75 30                	jne    801033e0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801033b0:	8b 1d 18 4a 12 80    	mov    0x80124a18,%ebx
  if(r)
801033b6:	85 db                	test   %ebx,%ebx
801033b8:	74 1c                	je     801033d6 <kalloc+0x36>
    kmem.freelist = r->next;
801033ba:	8b 13                	mov    (%ebx),%edx
801033bc:	89 15 18 4a 12 80    	mov    %edx,0x80124a18
  if(kmem.use_lock)
801033c2:	85 c0                	test   %eax,%eax
801033c4:	74 10                	je     801033d6 <kalloc+0x36>
    release(&kmem.lock);
801033c6:	83 ec 0c             	sub    $0xc,%esp
801033c9:	68 e0 49 12 80       	push   $0x801249e0
801033ce:	e8 fd 1e 00 00       	call   801052d0 <release>
801033d3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
801033d6:	89 d8                	mov    %ebx,%eax
801033d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801033db:	c9                   	leave  
801033dc:	c3                   	ret    
801033dd:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801033e0:	83 ec 0c             	sub    $0xc,%esp
801033e3:	68 e0 49 12 80       	push   $0x801249e0
801033e8:	e8 c3 1d 00 00       	call   801051b0 <acquire>
  r = kmem.freelist;
801033ed:	8b 1d 18 4a 12 80    	mov    0x80124a18,%ebx
  if(r)
801033f3:	83 c4 10             	add    $0x10,%esp
801033f6:	a1 14 4a 12 80       	mov    0x80124a14,%eax
801033fb:	85 db                	test   %ebx,%ebx
801033fd:	75 bb                	jne    801033ba <kalloc+0x1a>
801033ff:	eb c1                	jmp    801033c2 <kalloc+0x22>
80103401:	66 90                	xchg   %ax,%ax
80103403:	66 90                	xchg   %ax,%ax
80103405:	66 90                	xchg   %ax,%ax
80103407:	66 90                	xchg   %ax,%ax
80103409:	66 90                	xchg   %ax,%ax
8010340b:	66 90                	xchg   %ax,%ax
8010340d:	66 90                	xchg   %ax,%ax
8010340f:	90                   	nop

80103410 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80103410:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103411:	ba 64 00 00 00       	mov    $0x64,%edx
80103416:	89 e5                	mov    %esp,%ebp
80103418:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80103419:	a8 01                	test   $0x1,%al
8010341b:	0f 84 af 00 00 00    	je     801034d0 <kbdgetc+0xc0>
80103421:	ba 60 00 00 00       	mov    $0x60,%edx
80103426:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80103427:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010342a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80103430:	74 7e                	je     801034b0 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80103432:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80103434:	8b 0d f4 b5 10 80    	mov    0x8010b5f4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010343a:	79 24                	jns    80103460 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010343c:	f6 c1 40             	test   $0x40,%cl
8010343f:	75 05                	jne    80103446 <kbdgetc+0x36>
80103441:	89 c2                	mov    %eax,%edx
80103443:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80103446:	0f b6 82 e0 85 10 80 	movzbl -0x7fef7a20(%edx),%eax
8010344d:	83 c8 40             	or     $0x40,%eax
80103450:	0f b6 c0             	movzbl %al,%eax
80103453:	f7 d0                	not    %eax
80103455:	21 c8                	and    %ecx,%eax
80103457:	a3 f4 b5 10 80       	mov    %eax,0x8010b5f4
    return 0;
8010345c:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010345e:	5d                   	pop    %ebp
8010345f:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80103460:	f6 c1 40             	test   $0x40,%cl
80103463:	74 09                	je     8010346e <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80103465:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80103468:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010346b:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
8010346e:	0f b6 82 e0 85 10 80 	movzbl -0x7fef7a20(%edx),%eax
80103475:	09 c1                	or     %eax,%ecx
80103477:	0f b6 82 e0 84 10 80 	movzbl -0x7fef7b20(%edx),%eax
8010347e:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80103480:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80103482:	89 0d f4 b5 10 80    	mov    %ecx,0x8010b5f4
  c = charcode[shift & (CTL | SHIFT)][data];
80103488:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
8010348b:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010348e:	8b 04 85 c0 84 10 80 	mov    -0x7fef7b40(,%eax,4),%eax
80103495:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80103499:	74 c3                	je     8010345e <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010349b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010349e:	83 fa 19             	cmp    $0x19,%edx
801034a1:	77 1d                	ja     801034c0 <kbdgetc+0xb0>
      c += 'A' - 'a';
801034a3:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801034a6:	5d                   	pop    %ebp
801034a7:	c3                   	ret    
801034a8:	90                   	nop
801034a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
801034b0:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801034b2:	83 0d f4 b5 10 80 40 	orl    $0x40,0x8010b5f4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801034b9:	5d                   	pop    %ebp
801034ba:	c3                   	ret    
801034bb:	90                   	nop
801034bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801034c0:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801034c3:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
801034c6:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
801034c7:	83 f9 19             	cmp    $0x19,%ecx
801034ca:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
801034cd:	c3                   	ret    
801034ce:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801034d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801034d5:	5d                   	pop    %ebp
801034d6:	c3                   	ret    
801034d7:	89 f6                	mov    %esi,%esi
801034d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801034e0 <kbdintr>:

void
kbdintr(void)
{
801034e0:	55                   	push   %ebp
801034e1:	89 e5                	mov    %esp,%ebp
801034e3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801034e6:	68 10 34 10 80       	push   $0x80103410
801034eb:	e8 b0 dc ff ff       	call   801011a0 <consoleintr>
}
801034f0:	83 c4 10             	add    $0x10,%esp
801034f3:	c9                   	leave  
801034f4:	c3                   	ret    
801034f5:	66 90                	xchg   %ax,%ax
801034f7:	66 90                	xchg   %ax,%ax
801034f9:	66 90                	xchg   %ax,%ax
801034fb:	66 90                	xchg   %ax,%ax
801034fd:	66 90                	xchg   %ax,%ax
801034ff:	90                   	nop

80103500 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80103500:	a1 1c 4a 12 80       	mov    0x80124a1c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80103505:	55                   	push   %ebp
80103506:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80103508:	85 c0                	test   %eax,%eax
8010350a:	0f 84 c8 00 00 00    	je     801035d8 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103510:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80103517:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010351a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010351d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103524:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103527:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010352a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80103531:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80103534:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103537:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010353e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80103541:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103544:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010354b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010354e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103551:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103558:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010355b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010355e:	8b 50 30             	mov    0x30(%eax),%edx
80103561:	c1 ea 10             	shr    $0x10,%edx
80103564:	80 fa 03             	cmp    $0x3,%dl
80103567:	77 77                	ja     801035e0 <lapicinit+0xe0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103569:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80103570:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103573:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103576:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010357d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103580:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103583:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010358a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010358d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103590:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103597:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010359a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010359d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801035a4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801035a7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801035aa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801035b1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801035b4:	8b 50 20             	mov    0x20(%eax),%edx
801035b7:	89 f6                	mov    %esi,%esi
801035b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801035c0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801035c6:	80 e6 10             	and    $0x10,%dh
801035c9:	75 f5                	jne    801035c0 <lapicinit+0xc0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801035cb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801035d2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801035d5:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801035d8:	5d                   	pop    %ebp
801035d9:	c3                   	ret    
801035da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801035e0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801035e7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801035ea:	8b 50 20             	mov    0x20(%eax),%edx
801035ed:	e9 77 ff ff ff       	jmp    80103569 <lapicinit+0x69>
801035f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103600 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
80103600:	a1 1c 4a 12 80       	mov    0x80124a1c,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
80103605:	55                   	push   %ebp
80103606:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80103608:	85 c0                	test   %eax,%eax
8010360a:	74 0c                	je     80103618 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
8010360c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010360f:	5d                   	pop    %ebp
int
lapicid(void)
{
  if (!lapic)
    return 0;
  return lapic[ID] >> 24;
80103610:	c1 e8 18             	shr    $0x18,%eax
}
80103613:	c3                   	ret    
80103614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
lapicid(void)
{
  if (!lapic)
    return 0;
80103618:	31 c0                	xor    %eax,%eax
  return lapic[ID] >> 24;
}
8010361a:	5d                   	pop    %ebp
8010361b:	c3                   	ret    
8010361c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103620 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80103620:	a1 1c 4a 12 80       	mov    0x80124a1c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80103625:	55                   	push   %ebp
80103626:	89 e5                	mov    %esp,%ebp
  if(lapic)
80103628:	85 c0                	test   %eax,%eax
8010362a:	74 0d                	je     80103639 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010362c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103633:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103636:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80103639:	5d                   	pop    %ebp
8010363a:	c3                   	ret    
8010363b:	90                   	nop
8010363c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103640 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80103640:	55                   	push   %ebp
80103641:	89 e5                	mov    %esp,%ebp
}
80103643:	5d                   	pop    %ebp
80103644:	c3                   	ret    
80103645:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103650 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103650:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103651:	ba 70 00 00 00       	mov    $0x70,%edx
80103656:	b8 0f 00 00 00       	mov    $0xf,%eax
8010365b:	89 e5                	mov    %esp,%ebp
8010365d:	53                   	push   %ebx
8010365e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103661:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103664:	ee                   	out    %al,(%dx)
80103665:	ba 71 00 00 00       	mov    $0x71,%edx
8010366a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010366f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103670:	31 c0                	xor    %eax,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103672:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103675:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010367b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010367d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80103680:	c1 e8 04             	shr    $0x4,%eax

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80103683:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80103685:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80103688:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010368e:	a1 1c 4a 12 80       	mov    0x80124a1c,%eax
80103693:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103699:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010369c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801036a3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801036a6:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801036a9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801036b0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801036b3:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801036b6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801036bc:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801036bf:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801036c5:	8b 58 20             	mov    0x20(%eax),%ebx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801036c8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801036ce:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801036d1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801036d7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801036da:	5b                   	pop    %ebx
801036db:	5d                   	pop    %ebp
801036dc:	c3                   	ret    
801036dd:	8d 76 00             	lea    0x0(%esi),%esi

801036e0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801036e0:	55                   	push   %ebp
801036e1:	ba 70 00 00 00       	mov    $0x70,%edx
801036e6:	b8 0b 00 00 00       	mov    $0xb,%eax
801036eb:	89 e5                	mov    %esp,%ebp
801036ed:	57                   	push   %edi
801036ee:	56                   	push   %esi
801036ef:	53                   	push   %ebx
801036f0:	83 ec 4c             	sub    $0x4c,%esp
801036f3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801036f4:	ba 71 00 00 00       	mov    $0x71,%edx
801036f9:	ec                   	in     (%dx),%al
801036fa:	83 e0 04             	and    $0x4,%eax
801036fd:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103700:	31 db                	xor    %ebx,%ebx
80103702:	88 45 b7             	mov    %al,-0x49(%ebp)
80103705:	bf 70 00 00 00       	mov    $0x70,%edi
8010370a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103710:	89 d8                	mov    %ebx,%eax
80103712:	89 fa                	mov    %edi,%edx
80103714:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103715:	b9 71 00 00 00       	mov    $0x71,%ecx
8010371a:	89 ca                	mov    %ecx,%edx
8010371c:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010371d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103720:	89 fa                	mov    %edi,%edx
80103722:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103725:	b8 02 00 00 00       	mov    $0x2,%eax
8010372a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010372b:	89 ca                	mov    %ecx,%edx
8010372d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
8010372e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103731:	89 fa                	mov    %edi,%edx
80103733:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103736:	b8 04 00 00 00       	mov    $0x4,%eax
8010373b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010373c:	89 ca                	mov    %ecx,%edx
8010373e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
8010373f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103742:	89 fa                	mov    %edi,%edx
80103744:	89 45 c0             	mov    %eax,-0x40(%ebp)
80103747:	b8 07 00 00 00       	mov    $0x7,%eax
8010374c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010374d:	89 ca                	mov    %ecx,%edx
8010374f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80103750:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103753:	89 fa                	mov    %edi,%edx
80103755:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103758:	b8 08 00 00 00       	mov    $0x8,%eax
8010375d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010375e:	89 ca                	mov    %ecx,%edx
80103760:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80103761:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103764:	89 fa                	mov    %edi,%edx
80103766:	89 45 c8             	mov    %eax,-0x38(%ebp)
80103769:	b8 09 00 00 00       	mov    $0x9,%eax
8010376e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010376f:	89 ca                	mov    %ecx,%edx
80103771:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80103772:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103775:	89 fa                	mov    %edi,%edx
80103777:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010377a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010377f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103780:	89 ca                	mov    %ecx,%edx
80103782:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103783:	84 c0                	test   %al,%al
80103785:	78 89                	js     80103710 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103787:	89 d8                	mov    %ebx,%eax
80103789:	89 fa                	mov    %edi,%edx
8010378b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010378c:	89 ca                	mov    %ecx,%edx
8010378e:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010378f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103792:	89 fa                	mov    %edi,%edx
80103794:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103797:	b8 02 00 00 00       	mov    $0x2,%eax
8010379c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010379d:	89 ca                	mov    %ecx,%edx
8010379f:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801037a0:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037a3:	89 fa                	mov    %edi,%edx
801037a5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801037a8:	b8 04 00 00 00       	mov    $0x4,%eax
801037ad:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037ae:	89 ca                	mov    %ecx,%edx
801037b0:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
801037b1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037b4:	89 fa                	mov    %edi,%edx
801037b6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801037b9:	b8 07 00 00 00       	mov    $0x7,%eax
801037be:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037bf:	89 ca                	mov    %ecx,%edx
801037c1:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
801037c2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037c5:	89 fa                	mov    %edi,%edx
801037c7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801037ca:	b8 08 00 00 00       	mov    $0x8,%eax
801037cf:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037d0:	89 ca                	mov    %ecx,%edx
801037d2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801037d3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037d6:	89 fa                	mov    %edi,%edx
801037d8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801037db:	b8 09 00 00 00       	mov    $0x9,%eax
801037e0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037e1:	89 ca                	mov    %ecx,%edx
801037e3:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
801037e4:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801037e7:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
801037ea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801037ed:	8d 45 b8             	lea    -0x48(%ebp),%eax
801037f0:	6a 18                	push   $0x18
801037f2:	56                   	push   %esi
801037f3:	50                   	push   %eax
801037f4:	e8 77 1b 00 00       	call   80105370 <memcmp>
801037f9:	83 c4 10             	add    $0x10,%esp
801037fc:	85 c0                	test   %eax,%eax
801037fe:	0f 85 0c ff ff ff    	jne    80103710 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80103804:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80103808:	75 78                	jne    80103882 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010380a:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010380d:	89 c2                	mov    %eax,%edx
8010380f:	83 e0 0f             	and    $0xf,%eax
80103812:	c1 ea 04             	shr    $0x4,%edx
80103815:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103818:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010381b:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
8010381e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103821:	89 c2                	mov    %eax,%edx
80103823:	83 e0 0f             	and    $0xf,%eax
80103826:	c1 ea 04             	shr    $0x4,%edx
80103829:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010382c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010382f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103832:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103835:	89 c2                	mov    %eax,%edx
80103837:	83 e0 0f             	and    $0xf,%eax
8010383a:	c1 ea 04             	shr    $0x4,%edx
8010383d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103840:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103843:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103846:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103849:	89 c2                	mov    %eax,%edx
8010384b:	83 e0 0f             	and    $0xf,%eax
8010384e:	c1 ea 04             	shr    $0x4,%edx
80103851:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103854:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103857:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010385a:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010385d:	89 c2                	mov    %eax,%edx
8010385f:	83 e0 0f             	and    $0xf,%eax
80103862:	c1 ea 04             	shr    $0x4,%edx
80103865:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103868:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010386b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
8010386e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103871:	89 c2                	mov    %eax,%edx
80103873:	83 e0 0f             	and    $0xf,%eax
80103876:	c1 ea 04             	shr    $0x4,%edx
80103879:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010387c:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010387f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103882:	8b 75 08             	mov    0x8(%ebp),%esi
80103885:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103888:	89 06                	mov    %eax,(%esi)
8010388a:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010388d:	89 46 04             	mov    %eax,0x4(%esi)
80103890:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103893:	89 46 08             	mov    %eax,0x8(%esi)
80103896:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103899:	89 46 0c             	mov    %eax,0xc(%esi)
8010389c:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010389f:	89 46 10             	mov    %eax,0x10(%esi)
801038a2:	8b 45 cc             	mov    -0x34(%ebp),%eax
801038a5:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
801038a8:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
801038af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038b2:	5b                   	pop    %ebx
801038b3:	5e                   	pop    %esi
801038b4:	5f                   	pop    %edi
801038b5:	5d                   	pop    %ebp
801038b6:	c3                   	ret    
801038b7:	66 90                	xchg   %ax,%ax
801038b9:	66 90                	xchg   %ax,%ax
801038bb:	66 90                	xchg   %ax,%ax
801038bd:	66 90                	xchg   %ax,%ax
801038bf:	90                   	nop

801038c0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801038c0:	8b 0d 68 4a 12 80    	mov    0x80124a68,%ecx
801038c6:	85 c9                	test   %ecx,%ecx
801038c8:	0f 8e 85 00 00 00    	jle    80103953 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
801038ce:	55                   	push   %ebp
801038cf:	89 e5                	mov    %esp,%ebp
801038d1:	57                   	push   %edi
801038d2:	56                   	push   %esi
801038d3:	53                   	push   %ebx
801038d4:	31 db                	xor    %ebx,%ebx
801038d6:	83 ec 0c             	sub    $0xc,%esp
801038d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801038e0:	a1 54 4a 12 80       	mov    0x80124a54,%eax
801038e5:	83 ec 08             	sub    $0x8,%esp
801038e8:	01 d8                	add    %ebx,%eax
801038ea:	83 c0 01             	add    $0x1,%eax
801038ed:	50                   	push   %eax
801038ee:	ff 35 64 4a 12 80    	pushl  0x80124a64
801038f4:	e8 d7 c7 ff ff       	call   801000d0 <bread>
801038f9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801038fb:	58                   	pop    %eax
801038fc:	5a                   	pop    %edx
801038fd:	ff 34 9d 6c 4a 12 80 	pushl  -0x7fedb594(,%ebx,4)
80103904:	ff 35 64 4a 12 80    	pushl  0x80124a64
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010390a:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010390d:	e8 be c7 ff ff       	call   801000d0 <bread>
80103912:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103914:	8d 47 5c             	lea    0x5c(%edi),%eax
80103917:	83 c4 0c             	add    $0xc,%esp
8010391a:	68 00 02 00 00       	push   $0x200
8010391f:	50                   	push   %eax
80103920:	8d 46 5c             	lea    0x5c(%esi),%eax
80103923:	50                   	push   %eax
80103924:	e8 a7 1a 00 00       	call   801053d0 <memmove>
    bwrite(dbuf);  // write dst to disk
80103929:	89 34 24             	mov    %esi,(%esp)
8010392c:	e8 6f c8 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80103931:	89 3c 24             	mov    %edi,(%esp)
80103934:	e8 a7 c8 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80103939:	89 34 24             	mov    %esi,(%esp)
8010393c:	e8 9f c8 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103941:	83 c4 10             	add    $0x10,%esp
80103944:	39 1d 68 4a 12 80    	cmp    %ebx,0x80124a68
8010394a:	7f 94                	jg     801038e0 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
8010394c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010394f:	5b                   	pop    %ebx
80103950:	5e                   	pop    %esi
80103951:	5f                   	pop    %edi
80103952:	5d                   	pop    %ebp
80103953:	f3 c3                	repz ret 
80103955:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103960 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103960:	55                   	push   %ebp
80103961:	89 e5                	mov    %esp,%ebp
80103963:	53                   	push   %ebx
80103964:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103967:	ff 35 54 4a 12 80    	pushl  0x80124a54
8010396d:	ff 35 64 4a 12 80    	pushl  0x80124a64
80103973:	e8 58 c7 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80103978:	8b 0d 68 4a 12 80    	mov    0x80124a68,%ecx
  for (i = 0; i < log.lh.n; i++) {
8010397e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80103981:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103983:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80103985:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80103988:	7e 1f                	jle    801039a9 <write_head+0x49>
8010398a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80103991:	31 d2                	xor    %edx,%edx
80103993:	90                   	nop
80103994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80103998:	8b 8a 6c 4a 12 80    	mov    -0x7fedb594(%edx),%ecx
8010399e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
801039a2:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801039a5:	39 c2                	cmp    %eax,%edx
801039a7:	75 ef                	jne    80103998 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
801039a9:	83 ec 0c             	sub    $0xc,%esp
801039ac:	53                   	push   %ebx
801039ad:	e8 ee c7 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
801039b2:	89 1c 24             	mov    %ebx,(%esp)
801039b5:	e8 26 c8 ff ff       	call   801001e0 <brelse>
}
801039ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039bd:	c9                   	leave  
801039be:	c3                   	ret    
801039bf:	90                   	nop

801039c0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	53                   	push   %ebx
801039c4:	83 ec 2c             	sub    $0x2c,%esp
801039c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
801039ca:	68 e0 86 10 80       	push   $0x801086e0
801039cf:	68 20 4a 12 80       	push   $0x80124a20
801039d4:	e8 d7 16 00 00       	call   801050b0 <initlock>
  readsb(dev, &sb);
801039d9:	58                   	pop    %eax
801039da:	8d 45 dc             	lea    -0x24(%ebp),%eax
801039dd:	5a                   	pop    %edx
801039de:	50                   	push   %eax
801039df:	53                   	push   %ebx
801039e0:	e8 9b e8 ff ff       	call   80102280 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
801039e5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
801039e8:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
801039eb:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
801039ec:	89 1d 64 4a 12 80    	mov    %ebx,0x80124a64

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
801039f2:	89 15 58 4a 12 80    	mov    %edx,0x80124a58
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
801039f8:	a3 54 4a 12 80       	mov    %eax,0x80124a54

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
801039fd:	5a                   	pop    %edx
801039fe:	50                   	push   %eax
801039ff:	53                   	push   %ebx
80103a00:	e8 cb c6 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80103a05:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103a08:	83 c4 10             	add    $0x10,%esp
80103a0b:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80103a0d:	89 0d 68 4a 12 80    	mov    %ecx,0x80124a68
  for (i = 0; i < log.lh.n; i++) {
80103a13:	7e 1c                	jle    80103a31 <initlog+0x71>
80103a15:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80103a1c:	31 d2                	xor    %edx,%edx
80103a1e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80103a20:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80103a24:	83 c2 04             	add    $0x4,%edx
80103a27:	89 8a 68 4a 12 80    	mov    %ecx,-0x7fedb598(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80103a2d:	39 da                	cmp    %ebx,%edx
80103a2f:	75 ef                	jne    80103a20 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80103a31:	83 ec 0c             	sub    $0xc,%esp
80103a34:	50                   	push   %eax
80103a35:	e8 a6 c7 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80103a3a:	e8 81 fe ff ff       	call   801038c0 <install_trans>
  log.lh.n = 0;
80103a3f:	c7 05 68 4a 12 80 00 	movl   $0x0,0x80124a68
80103a46:	00 00 00 
  write_head(); // clear the log
80103a49:	e8 12 ff ff ff       	call   80103960 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80103a4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a51:	c9                   	leave  
80103a52:	c3                   	ret    
80103a53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a60 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103a60:	55                   	push   %ebp
80103a61:	89 e5                	mov    %esp,%ebp
80103a63:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103a66:	68 20 4a 12 80       	push   $0x80124a20
80103a6b:	e8 40 17 00 00       	call   801051b0 <acquire>
80103a70:	83 c4 10             	add    $0x10,%esp
80103a73:	eb 18                	jmp    80103a8d <begin_op+0x2d>
80103a75:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103a78:	83 ec 08             	sub    $0x8,%esp
80103a7b:	68 20 4a 12 80       	push   $0x80124a20
80103a80:	68 20 4a 12 80       	push   $0x80124a20
80103a85:	e8 b6 11 00 00       	call   80104c40 <sleep>
80103a8a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80103a8d:	a1 60 4a 12 80       	mov    0x80124a60,%eax
80103a92:	85 c0                	test   %eax,%eax
80103a94:	75 e2                	jne    80103a78 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103a96:	a1 5c 4a 12 80       	mov    0x80124a5c,%eax
80103a9b:	8b 15 68 4a 12 80    	mov    0x80124a68,%edx
80103aa1:	83 c0 01             	add    $0x1,%eax
80103aa4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103aa7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103aaa:	83 fa 1e             	cmp    $0x1e,%edx
80103aad:	7f c9                	jg     80103a78 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80103aaf:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80103ab2:	a3 5c 4a 12 80       	mov    %eax,0x80124a5c
      release(&log.lock);
80103ab7:	68 20 4a 12 80       	push   $0x80124a20
80103abc:	e8 0f 18 00 00       	call   801052d0 <release>
      break;
    }
  }
}
80103ac1:	83 c4 10             	add    $0x10,%esp
80103ac4:	c9                   	leave  
80103ac5:	c3                   	ret    
80103ac6:	8d 76 00             	lea    0x0(%esi),%esi
80103ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ad0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	57                   	push   %edi
80103ad4:	56                   	push   %esi
80103ad5:	53                   	push   %ebx
80103ad6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103ad9:	68 20 4a 12 80       	push   $0x80124a20
80103ade:	e8 cd 16 00 00       	call   801051b0 <acquire>
  log.outstanding -= 1;
80103ae3:	a1 5c 4a 12 80       	mov    0x80124a5c,%eax
  if(log.committing)
80103ae8:	8b 1d 60 4a 12 80    	mov    0x80124a60,%ebx
80103aee:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80103af1:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80103af4:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80103af6:	a3 5c 4a 12 80       	mov    %eax,0x80124a5c
  if(log.committing)
80103afb:	0f 85 23 01 00 00    	jne    80103c24 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103b01:	85 c0                	test   %eax,%eax
80103b03:	0f 85 f7 00 00 00    	jne    80103c00 <end_op+0x130>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103b09:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80103b0c:	c7 05 60 4a 12 80 01 	movl   $0x1,0x80124a60
80103b13:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80103b16:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103b18:	68 20 4a 12 80       	push   $0x80124a20
80103b1d:	e8 ae 17 00 00       	call   801052d0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103b22:	8b 0d 68 4a 12 80    	mov    0x80124a68,%ecx
80103b28:	83 c4 10             	add    $0x10,%esp
80103b2b:	85 c9                	test   %ecx,%ecx
80103b2d:	0f 8e 8a 00 00 00    	jle    80103bbd <end_op+0xed>
80103b33:	90                   	nop
80103b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103b38:	a1 54 4a 12 80       	mov    0x80124a54,%eax
80103b3d:	83 ec 08             	sub    $0x8,%esp
80103b40:	01 d8                	add    %ebx,%eax
80103b42:	83 c0 01             	add    $0x1,%eax
80103b45:	50                   	push   %eax
80103b46:	ff 35 64 4a 12 80    	pushl  0x80124a64
80103b4c:	e8 7f c5 ff ff       	call   801000d0 <bread>
80103b51:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103b53:	58                   	pop    %eax
80103b54:	5a                   	pop    %edx
80103b55:	ff 34 9d 6c 4a 12 80 	pushl  -0x7fedb594(,%ebx,4)
80103b5c:	ff 35 64 4a 12 80    	pushl  0x80124a64
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103b62:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103b65:	e8 66 c5 ff ff       	call   801000d0 <bread>
80103b6a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103b6c:	8d 40 5c             	lea    0x5c(%eax),%eax
80103b6f:	83 c4 0c             	add    $0xc,%esp
80103b72:	68 00 02 00 00       	push   $0x200
80103b77:	50                   	push   %eax
80103b78:	8d 46 5c             	lea    0x5c(%esi),%eax
80103b7b:	50                   	push   %eax
80103b7c:	e8 4f 18 00 00       	call   801053d0 <memmove>
    bwrite(to);  // write the log
80103b81:	89 34 24             	mov    %esi,(%esp)
80103b84:	e8 17 c6 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80103b89:	89 3c 24             	mov    %edi,(%esp)
80103b8c:	e8 4f c6 ff ff       	call   801001e0 <brelse>
    brelse(to);
80103b91:	89 34 24             	mov    %esi,(%esp)
80103b94:	e8 47 c6 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103b99:	83 c4 10             	add    $0x10,%esp
80103b9c:	3b 1d 68 4a 12 80    	cmp    0x80124a68,%ebx
80103ba2:	7c 94                	jl     80103b38 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103ba4:	e8 b7 fd ff ff       	call   80103960 <write_head>
    install_trans(); // Now install writes to home locations
80103ba9:	e8 12 fd ff ff       	call   801038c0 <install_trans>
    log.lh.n = 0;
80103bae:	c7 05 68 4a 12 80 00 	movl   $0x0,0x80124a68
80103bb5:	00 00 00 
    write_head();    // Erase the transaction from the log
80103bb8:	e8 a3 fd ff ff       	call   80103960 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80103bbd:	83 ec 0c             	sub    $0xc,%esp
80103bc0:	68 20 4a 12 80       	push   $0x80124a20
80103bc5:	e8 e6 15 00 00       	call   801051b0 <acquire>
    log.committing = 0;
    wakeup(&log);
80103bca:	c7 04 24 20 4a 12 80 	movl   $0x80124a20,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80103bd1:	c7 05 60 4a 12 80 00 	movl   $0x0,0x80124a60
80103bd8:	00 00 00 
    wakeup(&log);
80103bdb:	e8 10 12 00 00       	call   80104df0 <wakeup>
    release(&log.lock);
80103be0:	c7 04 24 20 4a 12 80 	movl   $0x80124a20,(%esp)
80103be7:	e8 e4 16 00 00       	call   801052d0 <release>
80103bec:	83 c4 10             	add    $0x10,%esp
  }
}
80103bef:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bf2:	5b                   	pop    %ebx
80103bf3:	5e                   	pop    %esi
80103bf4:	5f                   	pop    %edi
80103bf5:	5d                   	pop    %ebp
80103bf6:	c3                   	ret    
80103bf7:	89 f6                	mov    %esi,%esi
80103bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
80103c00:	83 ec 0c             	sub    $0xc,%esp
80103c03:	68 20 4a 12 80       	push   $0x80124a20
80103c08:	e8 e3 11 00 00       	call   80104df0 <wakeup>
  }
  release(&log.lock);
80103c0d:	c7 04 24 20 4a 12 80 	movl   $0x80124a20,(%esp)
80103c14:	e8 b7 16 00 00       	call   801052d0 <release>
80103c19:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80103c1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c1f:	5b                   	pop    %ebx
80103c20:	5e                   	pop    %esi
80103c21:	5f                   	pop    %edi
80103c22:	5d                   	pop    %ebp
80103c23:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80103c24:	83 ec 0c             	sub    $0xc,%esp
80103c27:	68 e4 86 10 80       	push   $0x801086e4
80103c2c:	e8 8f cb ff ff       	call   801007c0 <panic>
80103c31:	eb 0d                	jmp    80103c40 <log_write>
80103c33:	90                   	nop
80103c34:	90                   	nop
80103c35:	90                   	nop
80103c36:	90                   	nop
80103c37:	90                   	nop
80103c38:	90                   	nop
80103c39:	90                   	nop
80103c3a:	90                   	nop
80103c3b:	90                   	nop
80103c3c:	90                   	nop
80103c3d:	90                   	nop
80103c3e:	90                   	nop
80103c3f:	90                   	nop

80103c40 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	53                   	push   %ebx
80103c44:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103c47:	8b 15 68 4a 12 80    	mov    0x80124a68,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103c4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103c50:	83 fa 1d             	cmp    $0x1d,%edx
80103c53:	0f 8f 97 00 00 00    	jg     80103cf0 <log_write+0xb0>
80103c59:	a1 58 4a 12 80       	mov    0x80124a58,%eax
80103c5e:	83 e8 01             	sub    $0x1,%eax
80103c61:	39 c2                	cmp    %eax,%edx
80103c63:	0f 8d 87 00 00 00    	jge    80103cf0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103c69:	a1 5c 4a 12 80       	mov    0x80124a5c,%eax
80103c6e:	85 c0                	test   %eax,%eax
80103c70:	0f 8e 87 00 00 00    	jle    80103cfd <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103c76:	83 ec 0c             	sub    $0xc,%esp
80103c79:	68 20 4a 12 80       	push   $0x80124a20
80103c7e:	e8 2d 15 00 00       	call   801051b0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103c83:	8b 15 68 4a 12 80    	mov    0x80124a68,%edx
80103c89:	83 c4 10             	add    $0x10,%esp
80103c8c:	83 fa 00             	cmp    $0x0,%edx
80103c8f:	7e 50                	jle    80103ce1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103c91:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80103c94:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103c96:	3b 0d 6c 4a 12 80    	cmp    0x80124a6c,%ecx
80103c9c:	75 0b                	jne    80103ca9 <log_write+0x69>
80103c9e:	eb 38                	jmp    80103cd8 <log_write+0x98>
80103ca0:	39 0c 85 6c 4a 12 80 	cmp    %ecx,-0x7fedb594(,%eax,4)
80103ca7:	74 2f                	je     80103cd8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80103ca9:	83 c0 01             	add    $0x1,%eax
80103cac:	39 d0                	cmp    %edx,%eax
80103cae:	75 f0                	jne    80103ca0 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80103cb0:	89 0c 95 6c 4a 12 80 	mov    %ecx,-0x7fedb594(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80103cb7:	83 c2 01             	add    $0x1,%edx
80103cba:	89 15 68 4a 12 80    	mov    %edx,0x80124a68
  b->flags |= B_DIRTY; // prevent eviction
80103cc0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80103cc3:	c7 45 08 20 4a 12 80 	movl   $0x80124a20,0x8(%ebp)
}
80103cca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ccd:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80103cce:	e9 fd 15 00 00       	jmp    801052d0 <release>
80103cd3:	90                   	nop
80103cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80103cd8:	89 0c 85 6c 4a 12 80 	mov    %ecx,-0x7fedb594(,%eax,4)
80103cdf:	eb df                	jmp    80103cc0 <log_write+0x80>
80103ce1:	8b 43 08             	mov    0x8(%ebx),%eax
80103ce4:	a3 6c 4a 12 80       	mov    %eax,0x80124a6c
  if (i == log.lh.n)
80103ce9:	75 d5                	jne    80103cc0 <log_write+0x80>
80103ceb:	eb ca                	jmp    80103cb7 <log_write+0x77>
80103ced:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80103cf0:	83 ec 0c             	sub    $0xc,%esp
80103cf3:	68 f3 86 10 80       	push   $0x801086f3
80103cf8:	e8 c3 ca ff ff       	call   801007c0 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80103cfd:	83 ec 0c             	sub    $0xc,%esp
80103d00:	68 09 87 10 80       	push   $0x80108709
80103d05:	e8 b6 ca ff ff       	call   801007c0 <panic>
80103d0a:	66 90                	xchg   %ax,%ax
80103d0c:	66 90                	xchg   %ax,%ax
80103d0e:	66 90                	xchg   %ax,%ax

80103d10 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103d10:	55                   	push   %ebp
80103d11:	89 e5                	mov    %esp,%ebp
80103d13:	53                   	push   %ebx
80103d14:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103d17:	e8 54 09 00 00       	call   80104670 <cpuid>
80103d1c:	89 c3                	mov    %eax,%ebx
80103d1e:	e8 4d 09 00 00       	call   80104670 <cpuid>
80103d23:	83 ec 04             	sub    $0x4,%esp
80103d26:	53                   	push   %ebx
80103d27:	50                   	push   %eax
80103d28:	68 24 87 10 80       	push   $0x80108724
80103d2d:	e8 fe c8 ff ff       	call   80100630 <cprintf>
  idtinit();       // load idt register
80103d32:	e8 a9 29 00 00       	call   801066e0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103d37:	e8 b4 08 00 00       	call   801045f0 <mycpu>
80103d3c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103d3e:	b8 01 00 00 00       	mov    $0x1,%eax
80103d43:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80103d4a:	e8 01 0c 00 00       	call   80104950 <scheduler>
80103d4f:	90                   	nop

80103d50 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103d50:	55                   	push   %ebp
80103d51:	89 e5                	mov    %esp,%ebp
80103d53:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103d56:	e8 a5 3a 00 00       	call   80107800 <switchkvm>
  seginit();
80103d5b:	e8 a0 39 00 00       	call   80107700 <seginit>
  lapicinit();
80103d60:	e8 9b f7 ff ff       	call   80103500 <lapicinit>
  mpmain();
80103d65:	e8 a6 ff ff ff       	call   80103d10 <mpmain>
80103d6a:	66 90                	xchg   %ax,%ax
80103d6c:	66 90                	xchg   %ax,%ax
80103d6e:	66 90                	xchg   %ax,%ax

80103d70 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80103d70:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103d74:	83 e4 f0             	and    $0xfffffff0,%esp
80103d77:	ff 71 fc             	pushl  -0x4(%ecx)
80103d7a:	55                   	push   %ebp
80103d7b:	89 e5                	mov    %esp,%ebp
80103d7d:	53                   	push   %ebx
80103d7e:	51                   	push   %ecx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103d7f:	bb 20 4b 12 80       	mov    $0x80124b20,%ebx
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103d84:	83 ec 08             	sub    $0x8,%esp
80103d87:	68 00 00 40 80       	push   $0x80400000
80103d8c:	68 48 78 12 80       	push   $0x80127848
80103d91:	e8 3a f5 ff ff       	call   801032d0 <kinit1>
  kvmalloc();      // kernel page table
80103d96:	e8 05 3f 00 00       	call   80107ca0 <kvmalloc>
  mpinit();        // detect other processors
80103d9b:	e8 70 01 00 00       	call   80103f10 <mpinit>
  lapicinit();     // interrupt controller
80103da0:	e8 5b f7 ff ff       	call   80103500 <lapicinit>
  seginit();       // segment descriptors
80103da5:	e8 56 39 00 00       	call   80107700 <seginit>
  picinit();       // disable pic
80103daa:	e8 31 03 00 00       	call   801040e0 <picinit>
  ioapicinit();    // another interrupt controller
80103daf:	e8 4c f3 ff ff       	call   80103100 <ioapicinit>
  consoleinit();   // console hardware
80103db4:	e8 97 d9 ff ff       	call   80101750 <consoleinit>
  uartinit();      // serial port
80103db9:	e8 12 2c 00 00       	call   801069d0 <uartinit>
  pinit();         // process table
80103dbe:	e8 0d 08 00 00       	call   801045d0 <pinit>
  tvinit();        // trap vectors
80103dc3:	e8 78 28 00 00       	call   80106640 <tvinit>
  binit();         // buffer cache
80103dc8:	e8 73 c2 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103dcd:	e8 4e dd ff ff       	call   80101b20 <fileinit>
  ideinit();       // disk 
80103dd2:	e8 09 f1 ff ff       	call   80102ee0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103dd7:	83 c4 0c             	add    $0xc,%esp
80103dda:	68 8a 00 00 00       	push   $0x8a
80103ddf:	68 8c b4 10 80       	push   $0x8010b48c
80103de4:	68 00 70 00 80       	push   $0x80007000
80103de9:	e8 e2 15 00 00       	call   801053d0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103dee:	69 05 a0 50 12 80 b0 	imul   $0xb0,0x801250a0,%eax
80103df5:	00 00 00 
80103df8:	83 c4 10             	add    $0x10,%esp
80103dfb:	05 20 4b 12 80       	add    $0x80124b20,%eax
80103e00:	39 d8                	cmp    %ebx,%eax
80103e02:	76 6f                	jbe    80103e73 <main+0x103>
80103e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80103e08:	e8 e3 07 00 00       	call   801045f0 <mycpu>
80103e0d:	39 d8                	cmp    %ebx,%eax
80103e0f:	74 49                	je     80103e5a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103e11:	e8 8a f5 ff ff       	call   801033a0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80103e16:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80103e1b:	c7 05 f8 6f 00 80 50 	movl   $0x80103d50,0x80006ff8
80103e22:	3d 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103e25:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103e2c:	a0 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80103e2f:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103e34:	0f b6 03             	movzbl (%ebx),%eax
80103e37:	83 ec 08             	sub    $0x8,%esp
80103e3a:	68 00 70 00 00       	push   $0x7000
80103e3f:	50                   	push   %eax
80103e40:	e8 0b f8 ff ff       	call   80103650 <lapicstartap>
80103e45:	83 c4 10             	add    $0x10,%esp
80103e48:	90                   	nop
80103e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103e50:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103e56:	85 c0                	test   %eax,%eax
80103e58:	74 f6                	je     80103e50 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80103e5a:	69 05 a0 50 12 80 b0 	imul   $0xb0,0x801250a0,%eax
80103e61:	00 00 00 
80103e64:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103e6a:	05 20 4b 12 80       	add    $0x80124b20,%eax
80103e6f:	39 c3                	cmp    %eax,%ebx
80103e71:	72 95                	jb     80103e08 <main+0x98>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103e73:	83 ec 08             	sub    $0x8,%esp
80103e76:	68 00 00 00 8e       	push   $0x8e000000
80103e7b:	68 00 00 40 80       	push   $0x80400000
80103e80:	e8 bb f4 ff ff       	call   80103340 <kinit2>
  userinit();      // first user process
80103e85:	e8 36 08 00 00       	call   801046c0 <userinit>
  mpmain();        // finish this processor's setup
80103e8a:	e8 81 fe ff ff       	call   80103d10 <mpmain>
80103e8f:	90                   	nop

80103e90 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	57                   	push   %edi
80103e94:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103e95:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103e9b:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
80103e9c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103e9f:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103ea2:	39 de                	cmp    %ebx,%esi
80103ea4:	73 48                	jae    80103eee <mpsearch1+0x5e>
80103ea6:	8d 76 00             	lea    0x0(%esi),%esi
80103ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103eb0:	83 ec 04             	sub    $0x4,%esp
80103eb3:	8d 7e 10             	lea    0x10(%esi),%edi
80103eb6:	6a 04                	push   $0x4
80103eb8:	68 38 87 10 80       	push   $0x80108738
80103ebd:	56                   	push   %esi
80103ebe:	e8 ad 14 00 00       	call   80105370 <memcmp>
80103ec3:	83 c4 10             	add    $0x10,%esp
80103ec6:	85 c0                	test   %eax,%eax
80103ec8:	75 1e                	jne    80103ee8 <mpsearch1+0x58>
80103eca:	8d 7e 10             	lea    0x10(%esi),%edi
80103ecd:	89 f2                	mov    %esi,%edx
80103ecf:	31 c9                	xor    %ecx,%ecx
80103ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103ed8:	0f b6 02             	movzbl (%edx),%eax
80103edb:	83 c2 01             	add    $0x1,%edx
80103ede:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103ee0:	39 fa                	cmp    %edi,%edx
80103ee2:	75 f4                	jne    80103ed8 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103ee4:	84 c9                	test   %cl,%cl
80103ee6:	74 10                	je     80103ef8 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103ee8:	39 fb                	cmp    %edi,%ebx
80103eea:	89 fe                	mov    %edi,%esi
80103eec:	77 c2                	ja     80103eb0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
80103eee:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103ef1:	31 c0                	xor    %eax,%eax
}
80103ef3:	5b                   	pop    %ebx
80103ef4:	5e                   	pop    %esi
80103ef5:	5f                   	pop    %edi
80103ef6:	5d                   	pop    %ebp
80103ef7:	c3                   	ret    
80103ef8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103efb:	89 f0                	mov    %esi,%eax
80103efd:	5b                   	pop    %ebx
80103efe:	5e                   	pop    %esi
80103eff:	5f                   	pop    %edi
80103f00:	5d                   	pop    %ebp
80103f01:	c3                   	ret    
80103f02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f10 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103f10:	55                   	push   %ebp
80103f11:	89 e5                	mov    %esp,%ebp
80103f13:	57                   	push   %edi
80103f14:	56                   	push   %esi
80103f15:	53                   	push   %ebx
80103f16:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103f19:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103f20:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103f27:	c1 e0 08             	shl    $0x8,%eax
80103f2a:	09 d0                	or     %edx,%eax
80103f2c:	c1 e0 04             	shl    $0x4,%eax
80103f2f:	85 c0                	test   %eax,%eax
80103f31:	75 1b                	jne    80103f4e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103f33:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103f3a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103f41:	c1 e0 08             	shl    $0x8,%eax
80103f44:	09 d0                	or     %edx,%eax
80103f46:	c1 e0 0a             	shl    $0xa,%eax
80103f49:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
80103f4e:	ba 00 04 00 00       	mov    $0x400,%edx
80103f53:	e8 38 ff ff ff       	call   80103e90 <mpsearch1>
80103f58:	85 c0                	test   %eax,%eax
80103f5a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103f5d:	0f 84 37 01 00 00    	je     8010409a <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103f63:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103f66:	8b 58 04             	mov    0x4(%eax),%ebx
80103f69:	85 db                	test   %ebx,%ebx
80103f6b:	0f 84 43 01 00 00    	je     801040b4 <mpinit+0x1a4>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103f71:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
80103f77:	83 ec 04             	sub    $0x4,%esp
80103f7a:	6a 04                	push   $0x4
80103f7c:	68 3d 87 10 80       	push   $0x8010873d
80103f81:	56                   	push   %esi
80103f82:	e8 e9 13 00 00       	call   80105370 <memcmp>
80103f87:	83 c4 10             	add    $0x10,%esp
80103f8a:	85 c0                	test   %eax,%eax
80103f8c:	0f 85 22 01 00 00    	jne    801040b4 <mpinit+0x1a4>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103f92:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
80103f99:	3c 01                	cmp    $0x1,%al
80103f9b:	74 08                	je     80103fa5 <mpinit+0x95>
80103f9d:	3c 04                	cmp    $0x4,%al
80103f9f:	0f 85 0f 01 00 00    	jne    801040b4 <mpinit+0x1a4>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103fa5:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103fac:	85 ff                	test   %edi,%edi
80103fae:	74 21                	je     80103fd1 <mpinit+0xc1>
80103fb0:	31 d2                	xor    %edx,%edx
80103fb2:	31 c0                	xor    %eax,%eax
80103fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103fb8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
80103fbf:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103fc0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103fc3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103fc5:	39 c7                	cmp    %eax,%edi
80103fc7:	75 ef                	jne    80103fb8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103fc9:	84 d2                	test   %dl,%dl
80103fcb:	0f 85 e3 00 00 00    	jne    801040b4 <mpinit+0x1a4>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103fd1:	85 f6                	test   %esi,%esi
80103fd3:	0f 84 db 00 00 00    	je     801040b4 <mpinit+0x1a4>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103fd9:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103fdf:	a3 1c 4a 12 80       	mov    %eax,0x80124a1c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103fe4:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103feb:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
80103ff1:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103ff6:	01 d6                	add    %edx,%esi
80103ff8:	90                   	nop
80103ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104000:	39 c6                	cmp    %eax,%esi
80104002:	76 23                	jbe    80104027 <mpinit+0x117>
80104004:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
80104007:	80 fa 04             	cmp    $0x4,%dl
8010400a:	0f 87 c0 00 00 00    	ja     801040d0 <mpinit+0x1c0>
80104010:	ff 24 95 7c 87 10 80 	jmp    *-0x7fef7884(,%edx,4)
80104017:	89 f6                	mov    %esi,%esi
80104019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80104020:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80104023:	39 c6                	cmp    %eax,%esi
80104025:	77 dd                	ja     80104004 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80104027:	85 db                	test   %ebx,%ebx
80104029:	0f 84 92 00 00 00    	je     801040c1 <mpinit+0x1b1>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010402f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104032:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80104036:	74 15                	je     8010404d <mpinit+0x13d>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104038:	ba 22 00 00 00       	mov    $0x22,%edx
8010403d:	b8 70 00 00 00       	mov    $0x70,%eax
80104042:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80104043:	ba 23 00 00 00       	mov    $0x23,%edx
80104048:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104049:	83 c8 01             	or     $0x1,%eax
8010404c:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
8010404d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104050:	5b                   	pop    %ebx
80104051:	5e                   	pop    %esi
80104052:	5f                   	pop    %edi
80104053:	5d                   	pop    %ebp
80104054:	c3                   	ret    
80104055:	8d 76 00             	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80104058:	8b 0d a0 50 12 80    	mov    0x801250a0,%ecx
8010405e:	83 f9 07             	cmp    $0x7,%ecx
80104061:	7f 19                	jg     8010407c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80104063:	0f b6 50 01          	movzbl 0x1(%eax),%edx
80104067:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
8010406d:	83 c1 01             	add    $0x1,%ecx
80104070:	89 0d a0 50 12 80    	mov    %ecx,0x801250a0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80104076:	88 97 20 4b 12 80    	mov    %dl,-0x7fedb4e0(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010407c:	83 c0 14             	add    $0x14,%eax
      continue;
8010407f:	e9 7c ff ff ff       	jmp    80104000 <mpinit+0xf0>
80104084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80104088:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010408c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010408f:	88 15 00 4b 12 80    	mov    %dl,0x80124b00
      p += sizeof(struct mpioapic);
      continue;
80104095:	e9 66 ff ff ff       	jmp    80104000 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010409a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010409f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801040a4:	e8 e7 fd ff ff       	call   80103e90 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801040a9:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801040ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801040ae:	0f 85 af fe ff ff    	jne    80103f63 <mpinit+0x53>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
801040b4:	83 ec 0c             	sub    $0xc,%esp
801040b7:	68 42 87 10 80       	push   $0x80108742
801040bc:	e8 ff c6 ff ff       	call   801007c0 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801040c1:	83 ec 0c             	sub    $0xc,%esp
801040c4:	68 5c 87 10 80       	push   $0x8010875c
801040c9:	e8 f2 c6 ff ff       	call   801007c0 <panic>
801040ce:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801040d0:	31 db                	xor    %ebx,%ebx
801040d2:	e9 30 ff ff ff       	jmp    80104007 <mpinit+0xf7>
801040d7:	66 90                	xchg   %ax,%ax
801040d9:	66 90                	xchg   %ax,%ax
801040db:	66 90                	xchg   %ax,%ax
801040dd:	66 90                	xchg   %ax,%ax
801040df:	90                   	nop

801040e0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801040e0:	55                   	push   %ebp
801040e1:	ba 21 00 00 00       	mov    $0x21,%edx
801040e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801040eb:	89 e5                	mov    %esp,%ebp
801040ed:	ee                   	out    %al,(%dx)
801040ee:	ba a1 00 00 00       	mov    $0xa1,%edx
801040f3:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801040f4:	5d                   	pop    %ebp
801040f5:	c3                   	ret    
801040f6:	66 90                	xchg   %ax,%ax
801040f8:	66 90                	xchg   %ax,%ax
801040fa:	66 90                	xchg   %ax,%ax
801040fc:	66 90                	xchg   %ax,%ax
801040fe:	66 90                	xchg   %ax,%ax

80104100 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	57                   	push   %edi
80104104:	56                   	push   %esi
80104105:	53                   	push   %ebx
80104106:	83 ec 0c             	sub    $0xc,%esp
80104109:	8b 75 08             	mov    0x8(%ebp),%esi
8010410c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010410f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104115:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010411b:	e8 20 da ff ff       	call   80101b40 <filealloc>
80104120:	85 c0                	test   %eax,%eax
80104122:	89 06                	mov    %eax,(%esi)
80104124:	0f 84 a8 00 00 00    	je     801041d2 <pipealloc+0xd2>
8010412a:	e8 11 da ff ff       	call   80101b40 <filealloc>
8010412f:	85 c0                	test   %eax,%eax
80104131:	89 03                	mov    %eax,(%ebx)
80104133:	0f 84 87 00 00 00    	je     801041c0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104139:	e8 62 f2 ff ff       	call   801033a0 <kalloc>
8010413e:	85 c0                	test   %eax,%eax
80104140:	89 c7                	mov    %eax,%edi
80104142:	0f 84 b0 00 00 00    	je     801041f8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80104148:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010414b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80104152:	00 00 00 
  p->writeopen = 1;
80104155:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010415c:	00 00 00 
  p->nwrite = 0;
8010415f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104166:	00 00 00 
  p->nread = 0;
80104169:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104170:	00 00 00 
  initlock(&p->lock, "pipe");
80104173:	68 90 87 10 80       	push   $0x80108790
80104178:	50                   	push   %eax
80104179:	e8 32 0f 00 00       	call   801050b0 <initlock>
  (*f0)->type = FD_PIPE;
8010417e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80104180:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80104183:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80104189:	8b 06                	mov    (%esi),%eax
8010418b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010418f:	8b 06                	mov    (%esi),%eax
80104191:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80104195:	8b 06                	mov    (%esi),%eax
80104197:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010419a:	8b 03                	mov    (%ebx),%eax
8010419c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801041a2:	8b 03                	mov    (%ebx),%eax
801041a4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801041a8:	8b 03                	mov    (%ebx),%eax
801041aa:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801041ae:	8b 03                	mov    (%ebx),%eax
801041b0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801041b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801041b6:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801041b8:	5b                   	pop    %ebx
801041b9:	5e                   	pop    %esi
801041ba:	5f                   	pop    %edi
801041bb:	5d                   	pop    %ebp
801041bc:	c3                   	ret    
801041bd:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801041c0:	8b 06                	mov    (%esi),%eax
801041c2:	85 c0                	test   %eax,%eax
801041c4:	74 1e                	je     801041e4 <pipealloc+0xe4>
    fileclose(*f0);
801041c6:	83 ec 0c             	sub    $0xc,%esp
801041c9:	50                   	push   %eax
801041ca:	e8 31 da ff ff       	call   80101c00 <fileclose>
801041cf:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801041d2:	8b 03                	mov    (%ebx),%eax
801041d4:	85 c0                	test   %eax,%eax
801041d6:	74 0c                	je     801041e4 <pipealloc+0xe4>
    fileclose(*f1);
801041d8:	83 ec 0c             	sub    $0xc,%esp
801041db:	50                   	push   %eax
801041dc:	e8 1f da ff ff       	call   80101c00 <fileclose>
801041e1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801041e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801041e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041ec:	5b                   	pop    %ebx
801041ed:	5e                   	pop    %esi
801041ee:	5f                   	pop    %edi
801041ef:	5d                   	pop    %ebp
801041f0:	c3                   	ret    
801041f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801041f8:	8b 06                	mov    (%esi),%eax
801041fa:	85 c0                	test   %eax,%eax
801041fc:	75 c8                	jne    801041c6 <pipealloc+0xc6>
801041fe:	eb d2                	jmp    801041d2 <pipealloc+0xd2>

80104200 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	56                   	push   %esi
80104204:	53                   	push   %ebx
80104205:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104208:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010420b:	83 ec 0c             	sub    $0xc,%esp
8010420e:	53                   	push   %ebx
8010420f:	e8 9c 0f 00 00       	call   801051b0 <acquire>
  if(writable){
80104214:	83 c4 10             	add    $0x10,%esp
80104217:	85 f6                	test   %esi,%esi
80104219:	74 45                	je     80104260 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010421b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80104221:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80104224:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010422b:	00 00 00 
    wakeup(&p->nread);
8010422e:	50                   	push   %eax
8010422f:	e8 bc 0b 00 00       	call   80104df0 <wakeup>
80104234:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104237:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010423d:	85 d2                	test   %edx,%edx
8010423f:	75 0a                	jne    8010424b <pipeclose+0x4b>
80104241:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80104247:	85 c0                	test   %eax,%eax
80104249:	74 35                	je     80104280 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010424b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010424e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104251:	5b                   	pop    %ebx
80104252:	5e                   	pop    %esi
80104253:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80104254:	e9 77 10 00 00       	jmp    801052d0 <release>
80104259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80104260:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80104266:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80104269:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80104270:	00 00 00 
    wakeup(&p->nwrite);
80104273:	50                   	push   %eax
80104274:	e8 77 0b 00 00       	call   80104df0 <wakeup>
80104279:	83 c4 10             	add    $0x10,%esp
8010427c:	eb b9                	jmp    80104237 <pipeclose+0x37>
8010427e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80104280:	83 ec 0c             	sub    $0xc,%esp
80104283:	53                   	push   %ebx
80104284:	e8 47 10 00 00       	call   801052d0 <release>
    kfree((char*)p);
80104289:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010428c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010428f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104292:	5b                   	pop    %ebx
80104293:	5e                   	pop    %esi
80104294:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80104295:	e9 56 ef ff ff       	jmp    801031f0 <kfree>
8010429a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042a0 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	57                   	push   %edi
801042a4:	56                   	push   %esi
801042a5:	53                   	push   %ebx
801042a6:	83 ec 28             	sub    $0x28,%esp
801042a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801042ac:	53                   	push   %ebx
801042ad:	e8 fe 0e 00 00       	call   801051b0 <acquire>
  for(i = 0; i < n; i++){
801042b2:	8b 45 10             	mov    0x10(%ebp),%eax
801042b5:	83 c4 10             	add    $0x10,%esp
801042b8:	85 c0                	test   %eax,%eax
801042ba:	0f 8e b9 00 00 00    	jle    80104379 <pipewrite+0xd9>
801042c0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801042c3:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801042c9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801042cf:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
801042d5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801042d8:	03 4d 10             	add    0x10(%ebp),%ecx
801042db:	89 4d e0             	mov    %ecx,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801042de:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801042e4:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
801042ea:	39 d0                	cmp    %edx,%eax
801042ec:	74 38                	je     80104326 <pipewrite+0x86>
801042ee:	eb 59                	jmp    80104349 <pipewrite+0xa9>
      if(p->readopen == 0 || myproc()->killed){
801042f0:	e8 9b 03 00 00       	call   80104690 <myproc>
801042f5:	8b 48 24             	mov    0x24(%eax),%ecx
801042f8:	85 c9                	test   %ecx,%ecx
801042fa:	75 34                	jne    80104330 <pipewrite+0x90>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801042fc:	83 ec 0c             	sub    $0xc,%esp
801042ff:	57                   	push   %edi
80104300:	e8 eb 0a 00 00       	call   80104df0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104305:	58                   	pop    %eax
80104306:	5a                   	pop    %edx
80104307:	53                   	push   %ebx
80104308:	56                   	push   %esi
80104309:	e8 32 09 00 00       	call   80104c40 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010430e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80104314:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010431a:	83 c4 10             	add    $0x10,%esp
8010431d:	05 00 02 00 00       	add    $0x200,%eax
80104322:	39 c2                	cmp    %eax,%edx
80104324:	75 2a                	jne    80104350 <pipewrite+0xb0>
      if(p->readopen == 0 || myproc()->killed){
80104326:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010432c:	85 c0                	test   %eax,%eax
8010432e:	75 c0                	jne    801042f0 <pipewrite+0x50>
        release(&p->lock);
80104330:	83 ec 0c             	sub    $0xc,%esp
80104333:	53                   	push   %ebx
80104334:	e8 97 0f 00 00       	call   801052d0 <release>
        return -1;
80104339:	83 c4 10             	add    $0x10,%esp
8010433c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80104341:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104344:	5b                   	pop    %ebx
80104345:	5e                   	pop    %esi
80104346:	5f                   	pop    %edi
80104347:	5d                   	pop    %ebp
80104348:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104349:	89 c2                	mov    %eax,%edx
8010434b:	90                   	nop
8010434c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104350:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104353:	8d 42 01             	lea    0x1(%edx),%eax
80104356:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010435a:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80104360:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80104366:	0f b6 09             	movzbl (%ecx),%ecx
80104369:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
8010436d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80104370:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
80104373:	0f 85 65 ff ff ff    	jne    801042de <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80104379:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
8010437f:	83 ec 0c             	sub    $0xc,%esp
80104382:	50                   	push   %eax
80104383:	e8 68 0a 00 00       	call   80104df0 <wakeup>
  release(&p->lock);
80104388:	89 1c 24             	mov    %ebx,(%esp)
8010438b:	e8 40 0f 00 00       	call   801052d0 <release>
  return n;
80104390:	83 c4 10             	add    $0x10,%esp
80104393:	8b 45 10             	mov    0x10(%ebp),%eax
80104396:	eb a9                	jmp    80104341 <pipewrite+0xa1>
80104398:	90                   	nop
80104399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043a0 <piperead>:
}

int
piperead(struct pipe *p, char *addr, int n)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	57                   	push   %edi
801043a4:	56                   	push   %esi
801043a5:	53                   	push   %ebx
801043a6:	83 ec 18             	sub    $0x18,%esp
801043a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801043af:	53                   	push   %ebx
801043b0:	e8 fb 0d 00 00       	call   801051b0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801043b5:	83 c4 10             	add    $0x10,%esp
801043b8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801043be:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801043c4:	75 6a                	jne    80104430 <piperead+0x90>
801043c6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801043cc:	85 f6                	test   %esi,%esi
801043ce:	0f 84 cc 00 00 00    	je     801044a0 <piperead+0x100>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801043d4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801043da:	eb 2d                	jmp    80104409 <piperead+0x69>
801043dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043e0:	83 ec 08             	sub    $0x8,%esp
801043e3:	53                   	push   %ebx
801043e4:	56                   	push   %esi
801043e5:	e8 56 08 00 00       	call   80104c40 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801043ea:	83 c4 10             	add    $0x10,%esp
801043ed:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801043f3:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
801043f9:	75 35                	jne    80104430 <piperead+0x90>
801043fb:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80104401:	85 d2                	test   %edx,%edx
80104403:	0f 84 97 00 00 00    	je     801044a0 <piperead+0x100>
    if(myproc()->killed){
80104409:	e8 82 02 00 00       	call   80104690 <myproc>
8010440e:	8b 48 24             	mov    0x24(%eax),%ecx
80104411:	85 c9                	test   %ecx,%ecx
80104413:	74 cb                	je     801043e0 <piperead+0x40>
      release(&p->lock);
80104415:	83 ec 0c             	sub    $0xc,%esp
80104418:	53                   	push   %ebx
80104419:	e8 b2 0e 00 00       	call   801052d0 <release>
      return -1;
8010441e:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80104421:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
      return -1;
80104424:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80104429:	5b                   	pop    %ebx
8010442a:	5e                   	pop    %esi
8010442b:	5f                   	pop    %edi
8010442c:	5d                   	pop    %ebp
8010442d:	c3                   	ret    
8010442e:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104430:	8b 45 10             	mov    0x10(%ebp),%eax
80104433:	85 c0                	test   %eax,%eax
80104435:	7e 69                	jle    801044a0 <piperead+0x100>
    if(p->nread == p->nwrite)
80104437:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010443d:	31 c9                	xor    %ecx,%ecx
8010443f:	eb 15                	jmp    80104456 <piperead+0xb6>
80104441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104448:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010444e:	3b 83 38 02 00 00    	cmp    0x238(%ebx),%eax
80104454:	74 5a                	je     801044b0 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104456:	8d 70 01             	lea    0x1(%eax),%esi
80104459:	25 ff 01 00 00       	and    $0x1ff,%eax
8010445e:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80104464:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
80104469:	88 04 0f             	mov    %al,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010446c:	83 c1 01             	add    $0x1,%ecx
8010446f:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80104472:	75 d4                	jne    80104448 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80104474:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
8010447a:	83 ec 0c             	sub    $0xc,%esp
8010447d:	50                   	push   %eax
8010447e:	e8 6d 09 00 00       	call   80104df0 <wakeup>
  release(&p->lock);
80104483:	89 1c 24             	mov    %ebx,(%esp)
80104486:	e8 45 0e 00 00       	call   801052d0 <release>
  return i;
8010448b:	8b 45 10             	mov    0x10(%ebp),%eax
8010448e:	83 c4 10             	add    $0x10,%esp
}
80104491:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104494:	5b                   	pop    %ebx
80104495:	5e                   	pop    %esi
80104496:	5f                   	pop    %edi
80104497:	5d                   	pop    %ebp
80104498:	c3                   	ret    
80104499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801044a0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801044a7:	eb cb                	jmp    80104474 <piperead+0xd4>
801044a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044b0:	89 4d 10             	mov    %ecx,0x10(%ebp)
801044b3:	eb bf                	jmp    80104474 <piperead+0xd4>
801044b5:	66 90                	xchg   %ax,%ax
801044b7:	66 90                	xchg   %ax,%ax
801044b9:	66 90                	xchg   %ax,%ax
801044bb:	66 90                	xchg   %ax,%ax
801044bd:	66 90                	xchg   %ax,%ax
801044bf:	90                   	nop

801044c0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044c4:	bb f4 50 12 80       	mov    $0x801250f4,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801044c9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801044cc:	68 c0 50 12 80       	push   $0x801250c0
801044d1:	e8 da 0c 00 00       	call   801051b0 <acquire>
801044d6:	83 c4 10             	add    $0x10,%esp
801044d9:	eb 10                	jmp    801044eb <allocproc+0x2b>
801044db:	90                   	nop
801044dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044e0:	83 c3 7c             	add    $0x7c,%ebx
801044e3:	81 fb f4 6f 12 80    	cmp    $0x80126ff4,%ebx
801044e9:	74 75                	je     80104560 <allocproc+0xa0>
    if(p->state == UNUSED)
801044eb:	8b 43 0c             	mov    0xc(%ebx),%eax
801044ee:	85 c0                	test   %eax,%eax
801044f0:	75 ee                	jne    801044e0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801044f2:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
801044f7:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801044fa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
80104501:	68 c0 50 12 80       	push   $0x801250c0
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80104506:	8d 50 01             	lea    0x1(%eax),%edx
80104509:	89 43 10             	mov    %eax,0x10(%ebx)
8010450c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004

  release(&ptable.lock);
80104512:	e8 b9 0d 00 00       	call   801052d0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104517:	e8 84 ee ff ff       	call   801033a0 <kalloc>
8010451c:	83 c4 10             	add    $0x10,%esp
8010451f:	85 c0                	test   %eax,%eax
80104521:	89 43 08             	mov    %eax,0x8(%ebx)
80104524:	74 51                	je     80104577 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104526:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010452c:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
8010452f:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104534:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80104537:	c7 40 14 32 66 10 80 	movl   $0x80106632,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010453e:	6a 14                	push   $0x14
80104540:	6a 00                	push   $0x0
80104542:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80104543:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80104546:	e8 d5 0d 00 00       	call   80105320 <memset>
  p->context->eip = (uint)forkret;
8010454b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010454e:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80104551:	c7 40 10 80 45 10 80 	movl   $0x80104580,0x10(%eax)

  return p;
80104558:	89 d8                	mov    %ebx,%eax
}
8010455a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010455d:	c9                   	leave  
8010455e:	c3                   	ret    
8010455f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80104560:	83 ec 0c             	sub    $0xc,%esp
80104563:	68 c0 50 12 80       	push   $0x801250c0
80104568:	e8 63 0d 00 00       	call   801052d0 <release>
  return 0;
8010456d:	83 c4 10             	add    $0x10,%esp
80104570:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80104572:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104575:	c9                   	leave  
80104576:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80104577:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010457e:	eb da                	jmp    8010455a <allocproc+0x9a>

80104580 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104580:	55                   	push   %ebp
80104581:	89 e5                	mov    %esp,%ebp
80104583:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104586:	68 c0 50 12 80       	push   $0x801250c0
8010458b:	e8 40 0d 00 00       	call   801052d0 <release>

  if (first) {
80104590:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80104595:	83 c4 10             	add    $0x10,%esp
80104598:	85 c0                	test   %eax,%eax
8010459a:	75 04                	jne    801045a0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010459c:	c9                   	leave  
8010459d:	c3                   	ret    
8010459e:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801045a0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801045a3:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801045aa:	00 00 00 
    iinit(ROOTDEV);
801045ad:	6a 01                	push   $0x1
801045af:	e8 8c dd ff ff       	call   80102340 <iinit>
    initlog(ROOTDEV);
801045b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801045bb:	e8 00 f4 ff ff       	call   801039c0 <initlog>
801045c0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801045c3:	c9                   	leave  
801045c4:	c3                   	ret    
801045c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045d0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801045d6:	68 95 87 10 80       	push   $0x80108795
801045db:	68 c0 50 12 80       	push   $0x801250c0
801045e0:	e8 cb 0a 00 00       	call   801050b0 <initlock>
}
801045e5:	83 c4 10             	add    $0x10,%esp
801045e8:	c9                   	leave  
801045e9:	c3                   	ret    
801045ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045f0 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	56                   	push   %esi
801045f4:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801045f5:	9c                   	pushf  
801045f6:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
801045f7:	f6 c4 02             	test   $0x2,%ah
801045fa:	75 5b                	jne    80104657 <mycpu+0x67>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
801045fc:	e8 ff ef ff ff       	call   80103600 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80104601:	8b 35 a0 50 12 80    	mov    0x801250a0,%esi
80104607:	85 f6                	test   %esi,%esi
80104609:	7e 3f                	jle    8010464a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010460b:	0f b6 15 20 4b 12 80 	movzbl 0x80124b20,%edx
80104612:	39 d0                	cmp    %edx,%eax
80104614:	74 30                	je     80104646 <mycpu+0x56>
80104616:	b9 d0 4b 12 80       	mov    $0x80124bd0,%ecx
8010461b:	31 d2                	xor    %edx,%edx
8010461d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80104620:	83 c2 01             	add    $0x1,%edx
80104623:	39 f2                	cmp    %esi,%edx
80104625:	74 23                	je     8010464a <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80104627:	0f b6 19             	movzbl (%ecx),%ebx
8010462a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80104630:	39 d8                	cmp    %ebx,%eax
80104632:	75 ec                	jne    80104620 <mycpu+0x30>
      return &cpus[i];
80104634:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010463a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010463d:	5b                   	pop    %ebx
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
8010463e:	05 20 4b 12 80       	add    $0x80124b20,%eax
  }
  panic("unknown apicid\n");
}
80104643:	5e                   	pop    %esi
80104644:	5d                   	pop    %ebp
80104645:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80104646:	31 d2                	xor    %edx,%edx
80104648:	eb ea                	jmp    80104634 <mycpu+0x44>
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
8010464a:	83 ec 0c             	sub    $0xc,%esp
8010464d:	68 9c 87 10 80       	push   $0x8010879c
80104652:	e8 69 c1 ff ff       	call   801007c0 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
80104657:	83 ec 0c             	sub    $0xc,%esp
8010465a:	68 78 88 10 80       	push   $0x80108878
8010465f:	e8 5c c1 ff ff       	call   801007c0 <panic>
80104664:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010466a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104670 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104676:	e8 75 ff ff ff       	call   801045f0 <mycpu>
8010467b:	2d 20 4b 12 80       	sub    $0x80124b20,%eax
}
80104680:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
80104681:	c1 f8 04             	sar    $0x4,%eax
80104684:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010468a:	c3                   	ret    
8010468b:	90                   	nop
8010468c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104690 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
80104690:	55                   	push   %ebp
80104691:	89 e5                	mov    %esp,%ebp
80104693:	53                   	push   %ebx
80104694:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80104697:	e8 d4 0a 00 00       	call   80105170 <pushcli>
  c = mycpu();
8010469c:	e8 4f ff ff ff       	call   801045f0 <mycpu>
  p = c->proc;
801046a1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801046a7:	e8 b4 0b 00 00       	call   80105260 <popcli>
  return p;
}
801046ac:	83 c4 04             	add    $0x4,%esp
801046af:	89 d8                	mov    %ebx,%eax
801046b1:	5b                   	pop    %ebx
801046b2:	5d                   	pop    %ebp
801046b3:	c3                   	ret    
801046b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801046c0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	53                   	push   %ebx
801046c4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801046c7:	e8 f4 fd ff ff       	call   801044c0 <allocproc>
801046cc:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801046ce:	a3 f8 b5 10 80       	mov    %eax,0x8010b5f8
  if((p->pgdir = setupkvm()) == 0)
801046d3:	e8 48 35 00 00       	call   80107c20 <setupkvm>
801046d8:	85 c0                	test   %eax,%eax
801046da:	89 43 04             	mov    %eax,0x4(%ebx)
801046dd:	0f 84 bd 00 00 00    	je     801047a0 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801046e3:	83 ec 04             	sub    $0x4,%esp
801046e6:	68 2c 00 00 00       	push   $0x2c
801046eb:	68 60 b4 10 80       	push   $0x8010b460
801046f0:	50                   	push   %eax
801046f1:	e8 3a 32 00 00       	call   80107930 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
801046f6:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
801046f9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801046ff:	6a 4c                	push   $0x4c
80104701:	6a 00                	push   $0x0
80104703:	ff 73 18             	pushl  0x18(%ebx)
80104706:	e8 15 0c 00 00       	call   80105320 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010470b:	8b 43 18             	mov    0x18(%ebx),%eax
8010470e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104713:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104718:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010471b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010471f:	8b 43 18             	mov    0x18(%ebx),%eax
80104722:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104726:	8b 43 18             	mov    0x18(%ebx),%eax
80104729:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010472d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104731:	8b 43 18             	mov    0x18(%ebx),%eax
80104734:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104738:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010473c:	8b 43 18             	mov    0x18(%ebx),%eax
8010473f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104746:	8b 43 18             	mov    0x18(%ebx),%eax
80104749:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80104750:	8b 43 18             	mov    0x18(%ebx),%eax
80104753:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010475a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010475d:	6a 10                	push   $0x10
8010475f:	68 c5 87 10 80       	push   $0x801087c5
80104764:	50                   	push   %eax
80104765:	e8 b6 0d 00 00       	call   80105520 <safestrcpy>
  p->cwd = namei("/");
8010476a:	c7 04 24 ce 87 10 80 	movl   $0x801087ce,(%esp)
80104771:	e8 5a e6 ff ff       	call   80102dd0 <namei>
80104776:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80104779:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
80104780:	e8 2b 0a 00 00       	call   801051b0 <acquire>

  p->state = RUNNABLE;
80104785:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
8010478c:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
80104793:	e8 38 0b 00 00       	call   801052d0 <release>
}
80104798:	83 c4 10             	add    $0x10,%esp
8010479b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010479e:	c9                   	leave  
8010479f:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801047a0:	83 ec 0c             	sub    $0xc,%esp
801047a3:	68 ac 87 10 80       	push   $0x801087ac
801047a8:	e8 13 c0 ff ff       	call   801007c0 <panic>
801047ad:	8d 76 00             	lea    0x0(%esi),%esi

801047b0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	56                   	push   %esi
801047b4:	53                   	push   %ebx
801047b5:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
801047b8:	e8 b3 09 00 00       	call   80105170 <pushcli>
  c = mycpu();
801047bd:	e8 2e fe ff ff       	call   801045f0 <mycpu>
  p = c->proc;
801047c2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047c8:	e8 93 0a 00 00       	call   80105260 <popcli>
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
801047cd:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
801047d0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801047d2:	7e 34                	jle    80104808 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801047d4:	83 ec 04             	sub    $0x4,%esp
801047d7:	01 c6                	add    %eax,%esi
801047d9:	56                   	push   %esi
801047da:	50                   	push   %eax
801047db:	ff 73 04             	pushl  0x4(%ebx)
801047de:	e8 8d 32 00 00       	call   80107a70 <allocuvm>
801047e3:	83 c4 10             	add    $0x10,%esp
801047e6:	85 c0                	test   %eax,%eax
801047e8:	74 36                	je     80104820 <growproc+0x70>
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
801047ea:	83 ec 0c             	sub    $0xc,%esp
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
801047ed:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801047ef:	53                   	push   %ebx
801047f0:	e8 2b 30 00 00       	call   80107820 <switchuvm>
  return 0;
801047f5:	83 c4 10             	add    $0x10,%esp
801047f8:	31 c0                	xor    %eax,%eax
}
801047fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047fd:	5b                   	pop    %ebx
801047fe:	5e                   	pop    %esi
801047ff:	5d                   	pop    %ebp
80104800:	c3                   	ret    
80104801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80104808:	74 e0                	je     801047ea <growproc+0x3a>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010480a:	83 ec 04             	sub    $0x4,%esp
8010480d:	01 c6                	add    %eax,%esi
8010480f:	56                   	push   %esi
80104810:	50                   	push   %eax
80104811:	ff 73 04             	pushl  0x4(%ebx)
80104814:	e8 57 33 00 00       	call   80107b70 <deallocuvm>
80104819:	83 c4 10             	add    $0x10,%esp
8010481c:	85 c0                	test   %eax,%eax
8010481e:	75 ca                	jne    801047ea <growproc+0x3a>
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
80104820:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104825:	eb d3                	jmp    801047fa <growproc+0x4a>
80104827:	89 f6                	mov    %esi,%esi
80104829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104830 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80104830:	55                   	push   %ebp
80104831:	89 e5                	mov    %esp,%ebp
80104833:	57                   	push   %edi
80104834:	56                   	push   %esi
80104835:	53                   	push   %ebx
80104836:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104839:	e8 32 09 00 00       	call   80105170 <pushcli>
  c = mycpu();
8010483e:	e8 ad fd ff ff       	call   801045f0 <mycpu>
  p = c->proc;
80104843:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104849:	e8 12 0a 00 00       	call   80105260 <popcli>
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
8010484e:	e8 6d fc ff ff       	call   801044c0 <allocproc>
80104853:	85 c0                	test   %eax,%eax
80104855:	89 c7                	mov    %eax,%edi
80104857:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010485a:	0f 84 b5 00 00 00    	je     80104915 <fork+0xe5>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80104860:	83 ec 08             	sub    $0x8,%esp
80104863:	ff 33                	pushl  (%ebx)
80104865:	ff 73 04             	pushl  0x4(%ebx)
80104868:	e8 83 34 00 00       	call   80107cf0 <copyuvm>
8010486d:	83 c4 10             	add    $0x10,%esp
80104870:	85 c0                	test   %eax,%eax
80104872:	89 47 04             	mov    %eax,0x4(%edi)
80104875:	0f 84 a1 00 00 00    	je     8010491c <fork+0xec>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
8010487b:	8b 03                	mov    (%ebx),%eax
8010487d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104880:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80104882:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80104885:	89 c8                	mov    %ecx,%eax
80104887:	8b 79 18             	mov    0x18(%ecx),%edi
8010488a:	8b 73 18             	mov    0x18(%ebx),%esi
8010488d:	b9 13 00 00 00       	mov    $0x13,%ecx
80104892:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80104894:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104896:	8b 40 18             	mov    0x18(%eax),%eax
80104899:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
801048a0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801048a4:	85 c0                	test   %eax,%eax
801048a6:	74 13                	je     801048bb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
801048a8:	83 ec 0c             	sub    $0xc,%esp
801048ab:	50                   	push   %eax
801048ac:	e8 ff d2 ff ff       	call   80101bb0 <filedup>
801048b1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801048b4:	83 c4 10             	add    $0x10,%esp
801048b7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801048bb:	83 c6 01             	add    $0x1,%esi
801048be:	83 fe 10             	cmp    $0x10,%esi
801048c1:	75 dd                	jne    801048a0 <fork+0x70>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
801048c3:	83 ec 0c             	sub    $0xc,%esp
801048c6:	ff 73 68             	pushl  0x68(%ebx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801048c9:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
801048cc:	e8 4f dc ff ff       	call   80102520 <idup>
801048d1:	8b 7d e4             	mov    -0x1c(%ebp),%edi

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801048d4:	83 c4 0c             	add    $0xc,%esp
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
801048d7:	89 47 68             	mov    %eax,0x68(%edi)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801048da:	8d 47 6c             	lea    0x6c(%edi),%eax
801048dd:	6a 10                	push   $0x10
801048df:	53                   	push   %ebx
801048e0:	50                   	push   %eax
801048e1:	e8 3a 0c 00 00       	call   80105520 <safestrcpy>

  pid = np->pid;
801048e6:	8b 5f 10             	mov    0x10(%edi),%ebx

  acquire(&ptable.lock);
801048e9:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
801048f0:	e8 bb 08 00 00       	call   801051b0 <acquire>

  np->state = RUNNABLE;
801048f5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)

  release(&ptable.lock);
801048fc:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
80104903:	e8 c8 09 00 00       	call   801052d0 <release>

  return pid;
80104908:	83 c4 10             	add    $0x10,%esp
8010490b:	89 d8                	mov    %ebx,%eax
}
8010490d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104910:	5b                   	pop    %ebx
80104911:	5e                   	pop    %esi
80104912:	5f                   	pop    %edi
80104913:	5d                   	pop    %ebp
80104914:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80104915:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010491a:	eb f1                	jmp    8010490d <fork+0xdd>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
8010491c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010491f:	83 ec 0c             	sub    $0xc,%esp
80104922:	ff 77 08             	pushl  0x8(%edi)
80104925:	e8 c6 e8 ff ff       	call   801031f0 <kfree>
    np->kstack = 0;
8010492a:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80104931:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80104938:	83 c4 10             	add    $0x10,%esp
8010493b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104940:	eb cb                	jmp    8010490d <fork+0xdd>
80104942:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104950 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	57                   	push   %edi
80104954:	56                   	push   %esi
80104955:	53                   	push   %ebx
80104956:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80104959:	e8 92 fc ff ff       	call   801045f0 <mycpu>
8010495e:	8d 78 04             	lea    0x4(%eax),%edi
80104961:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80104963:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010496a:	00 00 00 
8010496d:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80104970:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104971:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104974:	bb f4 50 12 80       	mov    $0x801250f4,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104979:	68 c0 50 12 80       	push   $0x801250c0
8010497e:	e8 2d 08 00 00       	call   801051b0 <acquire>
80104983:	83 c4 10             	add    $0x10,%esp
80104986:	eb 13                	jmp    8010499b <scheduler+0x4b>
80104988:	90                   	nop
80104989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104990:	83 c3 7c             	add    $0x7c,%ebx
80104993:	81 fb f4 6f 12 80    	cmp    $0x80126ff4,%ebx
80104999:	74 45                	je     801049e0 <scheduler+0x90>
      if(p->state != RUNNABLE)
8010499b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
8010499f:	75 ef                	jne    80104990 <scheduler+0x40>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
801049a1:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
801049a4:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
801049aa:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049ab:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
801049ae:	e8 6d 2e 00 00       	call   80107820 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
801049b3:	58                   	pop    %eax
801049b4:	5a                   	pop    %edx
801049b5:	ff 73 a0             	pushl  -0x60(%ebx)
801049b8:	57                   	push   %edi
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
801049b9:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)

      swtch(&(c->scheduler), p->context);
801049c0:	e8 b6 0b 00 00       	call   8010557b <swtch>
      switchkvm();
801049c5:	e8 36 2e 00 00       	call   80107800 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
801049ca:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049cd:	81 fb f4 6f 12 80    	cmp    $0x80126ff4,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
801049d3:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
801049da:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049dd:	75 bc                	jne    8010499b <scheduler+0x4b>
801049df:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
801049e0:	83 ec 0c             	sub    $0xc,%esp
801049e3:	68 c0 50 12 80       	push   $0x801250c0
801049e8:	e8 e3 08 00 00       	call   801052d0 <release>

  }
801049ed:	83 c4 10             	add    $0x10,%esp
801049f0:	e9 7b ff ff ff       	jmp    80104970 <scheduler+0x20>
801049f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104a00 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	56                   	push   %esi
80104a04:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104a05:	e8 66 07 00 00       	call   80105170 <pushcli>
  c = mycpu();
80104a0a:	e8 e1 fb ff ff       	call   801045f0 <mycpu>
  p = c->proc;
80104a0f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104a15:	e8 46 08 00 00       	call   80105260 <popcli>
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
80104a1a:	83 ec 0c             	sub    $0xc,%esp
80104a1d:	68 c0 50 12 80       	push   $0x801250c0
80104a22:	e8 09 07 00 00       	call   80105130 <holding>
80104a27:	83 c4 10             	add    $0x10,%esp
80104a2a:	85 c0                	test   %eax,%eax
80104a2c:	74 4f                	je     80104a7d <sched+0x7d>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80104a2e:	e8 bd fb ff ff       	call   801045f0 <mycpu>
80104a33:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104a3a:	75 68                	jne    80104aa4 <sched+0xa4>
    panic("sched locks");
  if(p->state == RUNNING)
80104a3c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104a40:	74 55                	je     80104a97 <sched+0x97>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104a42:	9c                   	pushf  
80104a43:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80104a44:	f6 c4 02             	test   $0x2,%ah
80104a47:	75 41                	jne    80104a8a <sched+0x8a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80104a49:	e8 a2 fb ff ff       	call   801045f0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104a4e:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80104a51:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104a57:	e8 94 fb ff ff       	call   801045f0 <mycpu>
80104a5c:	83 ec 08             	sub    $0x8,%esp
80104a5f:	ff 70 04             	pushl  0x4(%eax)
80104a62:	53                   	push   %ebx
80104a63:	e8 13 0b 00 00       	call   8010557b <swtch>
  mycpu()->intena = intena;
80104a68:	e8 83 fb ff ff       	call   801045f0 <mycpu>
}
80104a6d:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
80104a70:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104a76:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104a79:	5b                   	pop    %ebx
80104a7a:	5e                   	pop    %esi
80104a7b:	5d                   	pop    %ebp
80104a7c:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80104a7d:	83 ec 0c             	sub    $0xc,%esp
80104a80:	68 d0 87 10 80       	push   $0x801087d0
80104a85:	e8 36 bd ff ff       	call   801007c0 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80104a8a:	83 ec 0c             	sub    $0xc,%esp
80104a8d:	68 fc 87 10 80       	push   $0x801087fc
80104a92:	e8 29 bd ff ff       	call   801007c0 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80104a97:	83 ec 0c             	sub    $0xc,%esp
80104a9a:	68 ee 87 10 80       	push   $0x801087ee
80104a9f:	e8 1c bd ff ff       	call   801007c0 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80104aa4:	83 ec 0c             	sub    $0xc,%esp
80104aa7:	68 e2 87 10 80       	push   $0x801087e2
80104aac:	e8 0f bd ff ff       	call   801007c0 <panic>
80104ab1:	eb 0d                	jmp    80104ac0 <exit>
80104ab3:	90                   	nop
80104ab4:	90                   	nop
80104ab5:	90                   	nop
80104ab6:	90                   	nop
80104ab7:	90                   	nop
80104ab8:	90                   	nop
80104ab9:	90                   	nop
80104aba:	90                   	nop
80104abb:	90                   	nop
80104abc:	90                   	nop
80104abd:	90                   	nop
80104abe:	90                   	nop
80104abf:	90                   	nop

80104ac0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	57                   	push   %edi
80104ac4:	56                   	push   %esi
80104ac5:	53                   	push   %ebx
80104ac6:	83 ec 0c             	sub    $0xc,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104ac9:	e8 a2 06 00 00       	call   80105170 <pushcli>
  c = mycpu();
80104ace:	e8 1d fb ff ff       	call   801045f0 <mycpu>
  p = c->proc;
80104ad3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104ad9:	e8 82 07 00 00       	call   80105260 <popcli>
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80104ade:	39 35 f8 b5 10 80    	cmp    %esi,0x8010b5f8
80104ae4:	8d 5e 28             	lea    0x28(%esi),%ebx
80104ae7:	8d 7e 68             	lea    0x68(%esi),%edi
80104aea:	0f 84 e7 00 00 00    	je     80104bd7 <exit+0x117>
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80104af0:	8b 03                	mov    (%ebx),%eax
80104af2:	85 c0                	test   %eax,%eax
80104af4:	74 12                	je     80104b08 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80104af6:	83 ec 0c             	sub    $0xc,%esp
80104af9:	50                   	push   %eax
80104afa:	e8 01 d1 ff ff       	call   80101c00 <fileclose>
      curproc->ofile[fd] = 0;
80104aff:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104b05:	83 c4 10             	add    $0x10,%esp
80104b08:	83 c3 04             	add    $0x4,%ebx

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80104b0b:	39 df                	cmp    %ebx,%edi
80104b0d:	75 e1                	jne    80104af0 <exit+0x30>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80104b0f:	e8 4c ef ff ff       	call   80103a60 <begin_op>
  iput(curproc->cwd);
80104b14:	83 ec 0c             	sub    $0xc,%esp
80104b17:	ff 76 68             	pushl  0x68(%esi)
80104b1a:	e8 61 db ff ff       	call   80102680 <iput>
  end_op();
80104b1f:	e8 ac ef ff ff       	call   80103ad0 <end_op>
  curproc->cwd = 0;
80104b24:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

  acquire(&ptable.lock);
80104b2b:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
80104b32:	e8 79 06 00 00       	call   801051b0 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80104b37:	8b 56 14             	mov    0x14(%esi),%edx
80104b3a:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b3d:	b8 f4 50 12 80       	mov    $0x801250f4,%eax
80104b42:	eb 0e                	jmp    80104b52 <exit+0x92>
80104b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b48:	83 c0 7c             	add    $0x7c,%eax
80104b4b:	3d f4 6f 12 80       	cmp    $0x80126ff4,%eax
80104b50:	74 1c                	je     80104b6e <exit+0xae>
    if(p->state == SLEEPING && p->chan == chan)
80104b52:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104b56:	75 f0                	jne    80104b48 <exit+0x88>
80104b58:	3b 50 20             	cmp    0x20(%eax),%edx
80104b5b:	75 eb                	jne    80104b48 <exit+0x88>
      p->state = RUNNABLE;
80104b5d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b64:	83 c0 7c             	add    $0x7c,%eax
80104b67:	3d f4 6f 12 80       	cmp    $0x80126ff4,%eax
80104b6c:	75 e4                	jne    80104b52 <exit+0x92>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80104b6e:	8b 0d f8 b5 10 80    	mov    0x8010b5f8,%ecx
80104b74:	ba f4 50 12 80       	mov    $0x801250f4,%edx
80104b79:	eb 10                	jmp    80104b8b <exit+0xcb>
80104b7b:	90                   	nop
80104b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b80:	83 c2 7c             	add    $0x7c,%edx
80104b83:	81 fa f4 6f 12 80    	cmp    $0x80126ff4,%edx
80104b89:	74 33                	je     80104bbe <exit+0xfe>
    if(p->parent == curproc){
80104b8b:	39 72 14             	cmp    %esi,0x14(%edx)
80104b8e:	75 f0                	jne    80104b80 <exit+0xc0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80104b90:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80104b94:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104b97:	75 e7                	jne    80104b80 <exit+0xc0>
80104b99:	b8 f4 50 12 80       	mov    $0x801250f4,%eax
80104b9e:	eb 0a                	jmp    80104baa <exit+0xea>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104ba0:	83 c0 7c             	add    $0x7c,%eax
80104ba3:	3d f4 6f 12 80       	cmp    $0x80126ff4,%eax
80104ba8:	74 d6                	je     80104b80 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80104baa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104bae:	75 f0                	jne    80104ba0 <exit+0xe0>
80104bb0:	3b 48 20             	cmp    0x20(%eax),%ecx
80104bb3:	75 eb                	jne    80104ba0 <exit+0xe0>
      p->state = RUNNABLE;
80104bb5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104bbc:	eb e2                	jmp    80104ba0 <exit+0xe0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80104bbe:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80104bc5:	e8 36 fe ff ff       	call   80104a00 <sched>
  panic("zombie exit");
80104bca:	83 ec 0c             	sub    $0xc,%esp
80104bcd:	68 1d 88 10 80       	push   $0x8010881d
80104bd2:	e8 e9 bb ff ff       	call   801007c0 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80104bd7:	83 ec 0c             	sub    $0xc,%esp
80104bda:	68 10 88 10 80       	push   $0x80108810
80104bdf:	e8 dc bb ff ff       	call   801007c0 <panic>
80104be4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104bf0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	53                   	push   %ebx
80104bf4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104bf7:	68 c0 50 12 80       	push   $0x801250c0
80104bfc:	e8 af 05 00 00       	call   801051b0 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104c01:	e8 6a 05 00 00       	call   80105170 <pushcli>
  c = mycpu();
80104c06:	e8 e5 f9 ff ff       	call   801045f0 <mycpu>
  p = c->proc;
80104c0b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104c11:	e8 4a 06 00 00       	call   80105260 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
80104c16:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104c1d:	e8 de fd ff ff       	call   80104a00 <sched>
  release(&ptable.lock);
80104c22:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
80104c29:	e8 a2 06 00 00       	call   801052d0 <release>
}
80104c2e:	83 c4 10             	add    $0x10,%esp
80104c31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c34:	c9                   	leave  
80104c35:	c3                   	ret    
80104c36:	8d 76 00             	lea    0x0(%esi),%esi
80104c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c40 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	57                   	push   %edi
80104c44:	56                   	push   %esi
80104c45:	53                   	push   %ebx
80104c46:	83 ec 0c             	sub    $0xc,%esp
80104c49:	8b 7d 08             	mov    0x8(%ebp),%edi
80104c4c:	8b 75 0c             	mov    0xc(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104c4f:	e8 1c 05 00 00       	call   80105170 <pushcli>
  c = mycpu();
80104c54:	e8 97 f9 ff ff       	call   801045f0 <mycpu>
  p = c->proc;
80104c59:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104c5f:	e8 fc 05 00 00       	call   80105260 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
80104c64:	85 db                	test   %ebx,%ebx
80104c66:	0f 84 87 00 00 00    	je     80104cf3 <sleep+0xb3>
    panic("sleep");

  if(lk == 0)
80104c6c:	85 f6                	test   %esi,%esi
80104c6e:	74 76                	je     80104ce6 <sleep+0xa6>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104c70:	81 fe c0 50 12 80    	cmp    $0x801250c0,%esi
80104c76:	74 50                	je     80104cc8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104c78:	83 ec 0c             	sub    $0xc,%esp
80104c7b:	68 c0 50 12 80       	push   $0x801250c0
80104c80:	e8 2b 05 00 00       	call   801051b0 <acquire>
    release(lk);
80104c85:	89 34 24             	mov    %esi,(%esp)
80104c88:	e8 43 06 00 00       	call   801052d0 <release>
  }
  // Go to sleep.
  p->chan = chan;
80104c8d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104c90:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104c97:	e8 64 fd ff ff       	call   80104a00 <sched>

  // Tidy up.
  p->chan = 0;
80104c9c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80104ca3:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
80104caa:	e8 21 06 00 00       	call   801052d0 <release>
    acquire(lk);
80104caf:	89 75 08             	mov    %esi,0x8(%ebp)
80104cb2:	83 c4 10             	add    $0x10,%esp
  }
}
80104cb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cb8:	5b                   	pop    %ebx
80104cb9:	5e                   	pop    %esi
80104cba:	5f                   	pop    %edi
80104cbb:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80104cbc:	e9 ef 04 00 00       	jmp    801051b0 <acquire>
80104cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80104cc8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104ccb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)

  sched();
80104cd2:	e8 29 fd ff ff       	call   80104a00 <sched>

  // Tidy up.
  p->chan = 0;
80104cd7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80104cde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ce1:	5b                   	pop    %ebx
80104ce2:	5e                   	pop    %esi
80104ce3:	5f                   	pop    %edi
80104ce4:	5d                   	pop    %ebp
80104ce5:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80104ce6:	83 ec 0c             	sub    $0xc,%esp
80104ce9:	68 2f 88 10 80       	push   $0x8010882f
80104cee:	e8 cd ba ff ff       	call   801007c0 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80104cf3:	83 ec 0c             	sub    $0xc,%esp
80104cf6:	68 29 88 10 80       	push   $0x80108829
80104cfb:	e8 c0 ba ff ff       	call   801007c0 <panic>

80104d00 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104d00:	55                   	push   %ebp
80104d01:	89 e5                	mov    %esp,%ebp
80104d03:	56                   	push   %esi
80104d04:	53                   	push   %ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
80104d05:	e8 66 04 00 00       	call   80105170 <pushcli>
  c = mycpu();
80104d0a:	e8 e1 f8 ff ff       	call   801045f0 <mycpu>
  p = c->proc;
80104d0f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104d15:	e8 46 05 00 00       	call   80105260 <popcli>
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
80104d1a:	83 ec 0c             	sub    $0xc,%esp
80104d1d:	68 c0 50 12 80       	push   $0x801250c0
80104d22:	e8 89 04 00 00       	call   801051b0 <acquire>
80104d27:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80104d2a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d2c:	bb f4 50 12 80       	mov    $0x801250f4,%ebx
80104d31:	eb 10                	jmp    80104d43 <wait+0x43>
80104d33:	90                   	nop
80104d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d38:	83 c3 7c             	add    $0x7c,%ebx
80104d3b:	81 fb f4 6f 12 80    	cmp    $0x80126ff4,%ebx
80104d41:	74 1d                	je     80104d60 <wait+0x60>
      if(p->parent != curproc)
80104d43:	39 73 14             	cmp    %esi,0x14(%ebx)
80104d46:	75 f0                	jne    80104d38 <wait+0x38>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80104d48:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104d4c:	74 30                	je     80104d7e <wait+0x7e>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d4e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80104d51:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d56:	81 fb f4 6f 12 80    	cmp    $0x80126ff4,%ebx
80104d5c:	75 e5                	jne    80104d43 <wait+0x43>
80104d5e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80104d60:	85 c0                	test   %eax,%eax
80104d62:	74 70                	je     80104dd4 <wait+0xd4>
80104d64:	8b 46 24             	mov    0x24(%esi),%eax
80104d67:	85 c0                	test   %eax,%eax
80104d69:	75 69                	jne    80104dd4 <wait+0xd4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104d6b:	83 ec 08             	sub    $0x8,%esp
80104d6e:	68 c0 50 12 80       	push   $0x801250c0
80104d73:	56                   	push   %esi
80104d74:	e8 c7 fe ff ff       	call   80104c40 <sleep>
  }
80104d79:	83 c4 10             	add    $0x10,%esp
80104d7c:	eb ac                	jmp    80104d2a <wait+0x2a>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80104d7e:	83 ec 0c             	sub    $0xc,%esp
80104d81:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80104d84:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104d87:	e8 64 e4 ff ff       	call   801031f0 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80104d8c:	5a                   	pop    %edx
80104d8d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80104d90:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104d97:	e8 04 2e 00 00       	call   80107ba0 <freevm>
        p->pid = 0;
80104d9c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104da3:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104daa:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104dae:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104db5:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104dbc:	c7 04 24 c0 50 12 80 	movl   $0x801250c0,(%esp)
80104dc3:	e8 08 05 00 00       	call   801052d0 <release>
        return pid;
80104dc8:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104dcb:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80104dce:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104dd0:	5b                   	pop    %ebx
80104dd1:	5e                   	pop    %esi
80104dd2:	5d                   	pop    %ebp
80104dd3:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80104dd4:	83 ec 0c             	sub    $0xc,%esp
80104dd7:	68 c0 50 12 80       	push   $0x801250c0
80104ddc:	e8 ef 04 00 00       	call   801052d0 <release>
      return -1;
80104de1:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104de4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
80104de7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104dec:	5b                   	pop    %ebx
80104ded:	5e                   	pop    %esi
80104dee:	5d                   	pop    %ebp
80104def:	c3                   	ret    

80104df0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	53                   	push   %ebx
80104df4:	83 ec 10             	sub    $0x10,%esp
80104df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104dfa:	68 c0 50 12 80       	push   $0x801250c0
80104dff:	e8 ac 03 00 00       	call   801051b0 <acquire>
80104e04:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104e07:	b8 f4 50 12 80       	mov    $0x801250f4,%eax
80104e0c:	eb 0c                	jmp    80104e1a <wakeup+0x2a>
80104e0e:	66 90                	xchg   %ax,%ax
80104e10:	83 c0 7c             	add    $0x7c,%eax
80104e13:	3d f4 6f 12 80       	cmp    $0x80126ff4,%eax
80104e18:	74 1c                	je     80104e36 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80104e1a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104e1e:	75 f0                	jne    80104e10 <wakeup+0x20>
80104e20:	3b 58 20             	cmp    0x20(%eax),%ebx
80104e23:	75 eb                	jne    80104e10 <wakeup+0x20>
      p->state = RUNNABLE;
80104e25:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104e2c:	83 c0 7c             	add    $0x7c,%eax
80104e2f:	3d f4 6f 12 80       	cmp    $0x80126ff4,%eax
80104e34:	75 e4                	jne    80104e1a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104e36:	c7 45 08 c0 50 12 80 	movl   $0x801250c0,0x8(%ebp)
}
80104e3d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e40:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104e41:	e9 8a 04 00 00       	jmp    801052d0 <release>
80104e46:	8d 76 00             	lea    0x0(%esi),%esi
80104e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e50 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	53                   	push   %ebx
80104e54:	83 ec 10             	sub    $0x10,%esp
80104e57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104e5a:	68 c0 50 12 80       	push   $0x801250c0
80104e5f:	e8 4c 03 00 00       	call   801051b0 <acquire>
80104e64:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104e67:	b8 f4 50 12 80       	mov    $0x801250f4,%eax
80104e6c:	eb 0c                	jmp    80104e7a <kill+0x2a>
80104e6e:	66 90                	xchg   %ax,%ax
80104e70:	83 c0 7c             	add    $0x7c,%eax
80104e73:	3d f4 6f 12 80       	cmp    $0x80126ff4,%eax
80104e78:	74 3e                	je     80104eb8 <kill+0x68>
    if(p->pid == pid){
80104e7a:	39 58 10             	cmp    %ebx,0x10(%eax)
80104e7d:	75 f1                	jne    80104e70 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104e7f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104e83:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104e8a:	74 1c                	je     80104ea8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
80104e8c:	83 ec 0c             	sub    $0xc,%esp
80104e8f:	68 c0 50 12 80       	push   $0x801250c0
80104e94:	e8 37 04 00 00       	call   801052d0 <release>
      return 0;
80104e99:	83 c4 10             	add    $0x10,%esp
80104e9c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104e9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ea1:	c9                   	leave  
80104ea2:	c3                   	ret    
80104ea3:	90                   	nop
80104ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80104ea8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104eaf:	eb db                	jmp    80104e8c <kill+0x3c>
80104eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104eb8:	83 ec 0c             	sub    $0xc,%esp
80104ebb:	68 c0 50 12 80       	push   $0x801250c0
80104ec0:	e8 0b 04 00 00       	call   801052d0 <release>
  return -1;
80104ec5:	83 c4 10             	add    $0x10,%esp
80104ec8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ecd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ed0:	c9                   	leave  
80104ed1:	c3                   	ret    
80104ed2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ee0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	57                   	push   %edi
80104ee4:	56                   	push   %esi
80104ee5:	53                   	push   %ebx
80104ee6:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104ee9:	bb 60 51 12 80       	mov    $0x80125160,%ebx
80104eee:	83 ec 3c             	sub    $0x3c,%esp
80104ef1:	eb 24                	jmp    80104f17 <procdump+0x37>
80104ef3:	90                   	nop
80104ef4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104ef8:	83 ec 0c             	sub    $0xc,%esp
80104efb:	68 bb 8b 10 80       	push   $0x80108bbb
80104f00:	e8 2b b7 ff ff       	call   80100630 <cprintf>
80104f05:	83 c4 10             	add    $0x10,%esp
80104f08:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f0b:	81 fb 60 70 12 80    	cmp    $0x80127060,%ebx
80104f11:	0f 84 81 00 00 00    	je     80104f98 <procdump+0xb8>
    if(p->state == UNUSED)
80104f17:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104f1a:	85 c0                	test   %eax,%eax
80104f1c:	74 ea                	je     80104f08 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104f1e:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104f21:	ba 40 88 10 80       	mov    $0x80108840,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104f26:	77 11                	ja     80104f39 <procdump+0x59>
80104f28:	8b 14 85 a0 88 10 80 	mov    -0x7fef7760(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
80104f2f:	b8 40 88 10 80       	mov    $0x80108840,%eax
80104f34:	85 d2                	test   %edx,%edx
80104f36:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104f39:	53                   	push   %ebx
80104f3a:	52                   	push   %edx
80104f3b:	ff 73 a4             	pushl  -0x5c(%ebx)
80104f3e:	68 44 88 10 80       	push   $0x80108844
80104f43:	e8 e8 b6 ff ff       	call   80100630 <cprintf>
    if(p->state == SLEEPING){
80104f48:	83 c4 10             	add    $0x10,%esp
80104f4b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104f4f:	75 a7                	jne    80104ef8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104f51:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104f54:	83 ec 08             	sub    $0x8,%esp
80104f57:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104f5a:	50                   	push   %eax
80104f5b:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104f5e:	8b 40 0c             	mov    0xc(%eax),%eax
80104f61:	83 c0 08             	add    $0x8,%eax
80104f64:	50                   	push   %eax
80104f65:	e8 66 01 00 00       	call   801050d0 <getcallerpcs>
80104f6a:	83 c4 10             	add    $0x10,%esp
80104f6d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104f70:	8b 17                	mov    (%edi),%edx
80104f72:	85 d2                	test   %edx,%edx
80104f74:	74 82                	je     80104ef8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104f76:	83 ec 08             	sub    $0x8,%esp
80104f79:	83 c7 04             	add    $0x4,%edi
80104f7c:	52                   	push   %edx
80104f7d:	68 fd 7e 10 80       	push   $0x80107efd
80104f82:	e8 a9 b6 ff ff       	call   80100630 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104f87:	83 c4 10             	add    $0x10,%esp
80104f8a:	39 f7                	cmp    %esi,%edi
80104f8c:	75 e2                	jne    80104f70 <procdump+0x90>
80104f8e:	e9 65 ff ff ff       	jmp    80104ef8 <procdump+0x18>
80104f93:	90                   	nop
80104f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104f98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f9b:	5b                   	pop    %ebx
80104f9c:	5e                   	pop    %esi
80104f9d:	5f                   	pop    %edi
80104f9e:	5d                   	pop    %ebp
80104f9f:	c3                   	ret    

80104fa0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104fa0:	55                   	push   %ebp
80104fa1:	89 e5                	mov    %esp,%ebp
80104fa3:	53                   	push   %ebx
80104fa4:	83 ec 0c             	sub    $0xc,%esp
80104fa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104faa:	68 b8 88 10 80       	push   $0x801088b8
80104faf:	8d 43 04             	lea    0x4(%ebx),%eax
80104fb2:	50                   	push   %eax
80104fb3:	e8 f8 00 00 00       	call   801050b0 <initlock>
  lk->name = name;
80104fb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104fbb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104fc1:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
80104fc4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
80104fcb:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
80104fce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fd1:	c9                   	leave  
80104fd2:	c3                   	ret    
80104fd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104fe0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104fe0:	55                   	push   %ebp
80104fe1:	89 e5                	mov    %esp,%ebp
80104fe3:	56                   	push   %esi
80104fe4:	53                   	push   %ebx
80104fe5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104fe8:	83 ec 0c             	sub    $0xc,%esp
80104feb:	8d 73 04             	lea    0x4(%ebx),%esi
80104fee:	56                   	push   %esi
80104fef:	e8 bc 01 00 00       	call   801051b0 <acquire>
  while (lk->locked) {
80104ff4:	8b 13                	mov    (%ebx),%edx
80104ff6:	83 c4 10             	add    $0x10,%esp
80104ff9:	85 d2                	test   %edx,%edx
80104ffb:	74 16                	je     80105013 <acquiresleep+0x33>
80104ffd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105000:	83 ec 08             	sub    $0x8,%esp
80105003:	56                   	push   %esi
80105004:	53                   	push   %ebx
80105005:	e8 36 fc ff ff       	call   80104c40 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010500a:	8b 03                	mov    (%ebx),%eax
8010500c:	83 c4 10             	add    $0x10,%esp
8010500f:	85 c0                	test   %eax,%eax
80105011:	75 ed                	jne    80105000 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80105013:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105019:	e8 72 f6 ff ff       	call   80104690 <myproc>
8010501e:	8b 40 10             	mov    0x10(%eax),%eax
80105021:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105024:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105027:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010502a:	5b                   	pop    %ebx
8010502b:	5e                   	pop    %esi
8010502c:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010502d:	e9 9e 02 00 00       	jmp    801052d0 <release>
80105032:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105040 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
80105043:	56                   	push   %esi
80105044:	53                   	push   %ebx
80105045:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105048:	83 ec 0c             	sub    $0xc,%esp
8010504b:	8d 73 04             	lea    0x4(%ebx),%esi
8010504e:	56                   	push   %esi
8010504f:	e8 5c 01 00 00       	call   801051b0 <acquire>
  lk->locked = 0;
80105054:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010505a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105061:	89 1c 24             	mov    %ebx,(%esp)
80105064:	e8 87 fd ff ff       	call   80104df0 <wakeup>
  release(&lk->lk);
80105069:	89 75 08             	mov    %esi,0x8(%ebp)
8010506c:	83 c4 10             	add    $0x10,%esp
}
8010506f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105072:	5b                   	pop    %ebx
80105073:	5e                   	pop    %esi
80105074:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80105075:	e9 56 02 00 00       	jmp    801052d0 <release>
8010507a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105080 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	56                   	push   %esi
80105084:	53                   	push   %ebx
80105085:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80105088:	83 ec 0c             	sub    $0xc,%esp
8010508b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010508e:	53                   	push   %ebx
8010508f:	e8 1c 01 00 00       	call   801051b0 <acquire>
  r = lk->locked;
80105094:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80105096:	89 1c 24             	mov    %ebx,(%esp)
80105099:	e8 32 02 00 00       	call   801052d0 <release>
  return r;
}
8010509e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050a1:	89 f0                	mov    %esi,%eax
801050a3:	5b                   	pop    %ebx
801050a4:	5e                   	pop    %esi
801050a5:	5d                   	pop    %ebp
801050a6:	c3                   	ret    
801050a7:	66 90                	xchg   %ax,%ax
801050a9:	66 90                	xchg   %ax,%ax
801050ab:	66 90                	xchg   %ax,%ax
801050ad:	66 90                	xchg   %ax,%ax
801050af:	90                   	nop

801050b0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801050b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801050b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801050bf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
801050c2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801050c9:	5d                   	pop    %ebp
801050ca:	c3                   	ret    
801050cb:	90                   	nop
801050cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050d0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801050d0:	55                   	push   %ebp
801050d1:	89 e5                	mov    %esp,%ebp
801050d3:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801050d4:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801050d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801050da:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801050dd:	31 c0                	xor    %eax,%eax
801050df:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801050e0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801050e6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801050ec:	77 1a                	ja     80105108 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801050ee:	8b 5a 04             	mov    0x4(%edx),%ebx
801050f1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801050f4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801050f7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801050f9:	83 f8 0a             	cmp    $0xa,%eax
801050fc:	75 e2                	jne    801050e0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801050fe:	5b                   	pop    %ebx
801050ff:	5d                   	pop    %ebp
80105100:	c3                   	ret    
80105101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80105108:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010510f:	83 c0 01             	add    $0x1,%eax
80105112:	83 f8 0a             	cmp    $0xa,%eax
80105115:	74 e7                	je     801050fe <getcallerpcs+0x2e>
    pcs[i] = 0;
80105117:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010511e:	83 c0 01             	add    $0x1,%eax
80105121:	83 f8 0a             	cmp    $0xa,%eax
80105124:	75 e2                	jne    80105108 <getcallerpcs+0x38>
80105126:	eb d6                	jmp    801050fe <getcallerpcs+0x2e>
80105128:	90                   	nop
80105129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105130 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105130:	55                   	push   %ebp
80105131:	89 e5                	mov    %esp,%ebp
80105133:	53                   	push   %ebx
80105134:	83 ec 04             	sub    $0x4,%esp
80105137:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
8010513a:	8b 02                	mov    (%edx),%eax
8010513c:	85 c0                	test   %eax,%eax
8010513e:	75 10                	jne    80105150 <holding+0x20>
}
80105140:	83 c4 04             	add    $0x4,%esp
80105143:	31 c0                	xor    %eax,%eax
80105145:	5b                   	pop    %ebx
80105146:	5d                   	pop    %ebp
80105147:	c3                   	ret    
80105148:	90                   	nop
80105149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80105150:	8b 5a 08             	mov    0x8(%edx),%ebx
80105153:	e8 98 f4 ff ff       	call   801045f0 <mycpu>
80105158:	39 c3                	cmp    %eax,%ebx
8010515a:	0f 94 c0             	sete   %al
}
8010515d:	83 c4 04             	add    $0x4,%esp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80105160:	0f b6 c0             	movzbl %al,%eax
}
80105163:	5b                   	pop    %ebx
80105164:	5d                   	pop    %ebp
80105165:	c3                   	ret    
80105166:	8d 76 00             	lea    0x0(%esi),%esi
80105169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105170 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	53                   	push   %ebx
80105174:	83 ec 04             	sub    $0x4,%esp
80105177:	9c                   	pushf  
80105178:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80105179:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010517a:	e8 71 f4 ff ff       	call   801045f0 <mycpu>
8010517f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105185:	85 c0                	test   %eax,%eax
80105187:	75 11                	jne    8010519a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80105189:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010518f:	e8 5c f4 ff ff       	call   801045f0 <mycpu>
80105194:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010519a:	e8 51 f4 ff ff       	call   801045f0 <mycpu>
8010519f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801051a6:	83 c4 04             	add    $0x4,%esp
801051a9:	5b                   	pop    %ebx
801051aa:	5d                   	pop    %ebp
801051ab:	c3                   	ret    
801051ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801051b0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801051b0:	55                   	push   %ebp
801051b1:	89 e5                	mov    %esp,%ebp
801051b3:	56                   	push   %esi
801051b4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801051b5:	e8 b6 ff ff ff       	call   80105170 <pushcli>
  if(holding(lk))
801051ba:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801051bd:	8b 03                	mov    (%ebx),%eax
801051bf:	85 c0                	test   %eax,%eax
801051c1:	75 7d                	jne    80105240 <acquire+0x90>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801051c3:	ba 01 00 00 00       	mov    $0x1,%edx
801051c8:	eb 09                	jmp    801051d3 <acquire+0x23>
801051ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801051d0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801051d3:	89 d0                	mov    %edx,%eax
801051d5:	f0 87 03             	lock xchg %eax,(%ebx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801051d8:	85 c0                	test   %eax,%eax
801051da:	75 f4                	jne    801051d0 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801051dc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801051e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801051e4:	e8 07 f4 ff ff       	call   801045f0 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801051e9:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
801051eb:	8d 4b 0c             	lea    0xc(%ebx),%ecx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801051ee:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801051f1:	31 c0                	xor    %eax,%eax
801051f3:	90                   	nop
801051f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801051f8:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801051fe:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105204:	77 1a                	ja     80105220 <acquire+0x70>
      break;
    pcs[i] = ebp[1];     // saved %eip
80105206:	8b 5a 04             	mov    0x4(%edx),%ebx
80105209:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010520c:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
8010520f:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105211:	83 f8 0a             	cmp    $0xa,%eax
80105214:	75 e2                	jne    801051f8 <acquire+0x48>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80105216:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105219:	5b                   	pop    %ebx
8010521a:	5e                   	pop    %esi
8010521b:	5d                   	pop    %ebp
8010521c:	c3                   	ret    
8010521d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80105220:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105227:	83 c0 01             	add    $0x1,%eax
8010522a:	83 f8 0a             	cmp    $0xa,%eax
8010522d:	74 e7                	je     80105216 <acquire+0x66>
    pcs[i] = 0;
8010522f:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105236:	83 c0 01             	add    $0x1,%eax
80105239:	83 f8 0a             	cmp    $0xa,%eax
8010523c:	75 e2                	jne    80105220 <acquire+0x70>
8010523e:	eb d6                	jmp    80105216 <acquire+0x66>

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
80105240:	8b 73 08             	mov    0x8(%ebx),%esi
80105243:	e8 a8 f3 ff ff       	call   801045f0 <mycpu>
80105248:	39 c6                	cmp    %eax,%esi
8010524a:	0f 85 73 ff ff ff    	jne    801051c3 <acquire+0x13>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80105250:	83 ec 0c             	sub    $0xc,%esp
80105253:	68 c3 88 10 80       	push   $0x801088c3
80105258:	e8 63 b5 ff ff       	call   801007c0 <panic>
8010525d:	8d 76 00             	lea    0x0(%esi),%esi

80105260 <popcli>:
  mycpu()->ncli += 1;
}

void
popcli(void)
{
80105260:	55                   	push   %ebp
80105261:	89 e5                	mov    %esp,%ebp
80105263:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105266:	9c                   	pushf  
80105267:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80105268:	f6 c4 02             	test   $0x2,%ah
8010526b:	75 52                	jne    801052bf <popcli+0x5f>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010526d:	e8 7e f3 ff ff       	call   801045f0 <mycpu>
80105272:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80105278:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010527b:	85 d2                	test   %edx,%edx
8010527d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80105283:	78 2d                	js     801052b2 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105285:	e8 66 f3 ff ff       	call   801045f0 <mycpu>
8010528a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105290:	85 d2                	test   %edx,%edx
80105292:	74 0c                	je     801052a0 <popcli+0x40>
    sti();
}
80105294:	c9                   	leave  
80105295:	c3                   	ret    
80105296:	8d 76 00             	lea    0x0(%esi),%esi
80105299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801052a0:	e8 4b f3 ff ff       	call   801045f0 <mycpu>
801052a5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801052ab:	85 c0                	test   %eax,%eax
801052ad:	74 e5                	je     80105294 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
801052af:	fb                   	sti    
    sti();
}
801052b0:	c9                   	leave  
801052b1:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
801052b2:	83 ec 0c             	sub    $0xc,%esp
801052b5:	68 e2 88 10 80       	push   $0x801088e2
801052ba:	e8 01 b5 ff ff       	call   801007c0 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
801052bf:	83 ec 0c             	sub    $0xc,%esp
801052c2:	68 cb 88 10 80       	push   $0x801088cb
801052c7:	e8 f4 b4 ff ff       	call   801007c0 <panic>
801052cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052d0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	56                   	push   %esi
801052d4:	53                   	push   %ebx
801052d5:	8b 5d 08             	mov    0x8(%ebp),%ebx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801052d8:	8b 03                	mov    (%ebx),%eax
801052da:	85 c0                	test   %eax,%eax
801052dc:	75 12                	jne    801052f0 <release+0x20>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
801052de:	83 ec 0c             	sub    $0xc,%esp
801052e1:	68 e9 88 10 80       	push   $0x801088e9
801052e6:	e8 d5 b4 ff ff       	call   801007c0 <panic>
801052eb:	90                   	nop
801052ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == mycpu();
801052f0:	8b 73 08             	mov    0x8(%ebx),%esi
801052f3:	e8 f8 f2 ff ff       	call   801045f0 <mycpu>
801052f8:	39 c6                	cmp    %eax,%esi
801052fa:	75 e2                	jne    801052de <release+0xe>
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");

  lk->pcs[0] = 0;
801052fc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105303:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
8010530a:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010530f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80105315:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105318:	5b                   	pop    %ebx
80105319:	5e                   	pop    %esi
8010531a:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
8010531b:	e9 40 ff ff ff       	jmp    80105260 <popcli>

80105320 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	57                   	push   %edi
80105324:	53                   	push   %ebx
80105325:	8b 55 08             	mov    0x8(%ebp),%edx
80105328:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010532b:	f6 c2 03             	test   $0x3,%dl
8010532e:	75 05                	jne    80105335 <memset+0x15>
80105330:	f6 c1 03             	test   $0x3,%cl
80105333:	74 13                	je     80105348 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80105335:	89 d7                	mov    %edx,%edi
80105337:	8b 45 0c             	mov    0xc(%ebp),%eax
8010533a:	fc                   	cld    
8010533b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010533d:	5b                   	pop    %ebx
8010533e:	89 d0                	mov    %edx,%eax
80105340:	5f                   	pop    %edi
80105341:	5d                   	pop    %ebp
80105342:	c3                   	ret    
80105343:	90                   	nop
80105344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80105348:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
8010534c:	c1 e9 02             	shr    $0x2,%ecx
8010534f:	89 fb                	mov    %edi,%ebx
80105351:	89 f8                	mov    %edi,%eax
80105353:	c1 e3 18             	shl    $0x18,%ebx
80105356:	c1 e0 10             	shl    $0x10,%eax
80105359:	09 d8                	or     %ebx,%eax
8010535b:	09 f8                	or     %edi,%eax
8010535d:	c1 e7 08             	shl    $0x8,%edi
80105360:	09 f8                	or     %edi,%eax
80105362:	89 d7                	mov    %edx,%edi
80105364:	fc                   	cld    
80105365:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105367:	5b                   	pop    %ebx
80105368:	89 d0                	mov    %edx,%eax
8010536a:	5f                   	pop    %edi
8010536b:	5d                   	pop    %ebp
8010536c:	c3                   	ret    
8010536d:	8d 76 00             	lea    0x0(%esi),%esi

80105370 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	57                   	push   %edi
80105374:	56                   	push   %esi
80105375:	8b 45 10             	mov    0x10(%ebp),%eax
80105378:	53                   	push   %ebx
80105379:	8b 75 0c             	mov    0xc(%ebp),%esi
8010537c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010537f:	85 c0                	test   %eax,%eax
80105381:	74 29                	je     801053ac <memcmp+0x3c>
    if(*s1 != *s2)
80105383:	0f b6 13             	movzbl (%ebx),%edx
80105386:	0f b6 0e             	movzbl (%esi),%ecx
80105389:	38 d1                	cmp    %dl,%cl
8010538b:	75 2b                	jne    801053b8 <memcmp+0x48>
8010538d:	8d 78 ff             	lea    -0x1(%eax),%edi
80105390:	31 c0                	xor    %eax,%eax
80105392:	eb 14                	jmp    801053a8 <memcmp+0x38>
80105394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105398:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010539d:	83 c0 01             	add    $0x1,%eax
801053a0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801053a4:	38 ca                	cmp    %cl,%dl
801053a6:	75 10                	jne    801053b8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801053a8:	39 f8                	cmp    %edi,%eax
801053aa:	75 ec                	jne    80105398 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801053ac:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
801053ad:	31 c0                	xor    %eax,%eax
}
801053af:	5e                   	pop    %esi
801053b0:	5f                   	pop    %edi
801053b1:	5d                   	pop    %ebp
801053b2:	c3                   	ret    
801053b3:	90                   	nop
801053b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801053b8:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
801053bb:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801053bc:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
801053be:	5e                   	pop    %esi
801053bf:	5f                   	pop    %edi
801053c0:	5d                   	pop    %ebp
801053c1:	c3                   	ret    
801053c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801053d0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	56                   	push   %esi
801053d4:	53                   	push   %ebx
801053d5:	8b 45 08             	mov    0x8(%ebp),%eax
801053d8:	8b 75 0c             	mov    0xc(%ebp),%esi
801053db:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801053de:	39 c6                	cmp    %eax,%esi
801053e0:	73 2e                	jae    80105410 <memmove+0x40>
801053e2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801053e5:	39 c8                	cmp    %ecx,%eax
801053e7:	73 27                	jae    80105410 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
801053e9:	85 db                	test   %ebx,%ebx
801053eb:	8d 53 ff             	lea    -0x1(%ebx),%edx
801053ee:	74 17                	je     80105407 <memmove+0x37>
      *--d = *--s;
801053f0:	29 d9                	sub    %ebx,%ecx
801053f2:	89 cb                	mov    %ecx,%ebx
801053f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053f8:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801053fc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801053ff:	83 ea 01             	sub    $0x1,%edx
80105402:	83 fa ff             	cmp    $0xffffffff,%edx
80105405:	75 f1                	jne    801053f8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105407:	5b                   	pop    %ebx
80105408:	5e                   	pop    %esi
80105409:	5d                   	pop    %ebp
8010540a:	c3                   	ret    
8010540b:	90                   	nop
8010540c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105410:	31 d2                	xor    %edx,%edx
80105412:	85 db                	test   %ebx,%ebx
80105414:	74 f1                	je     80105407 <memmove+0x37>
80105416:	8d 76 00             	lea    0x0(%esi),%esi
80105419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
80105420:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80105424:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105427:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010542a:	39 d3                	cmp    %edx,%ebx
8010542c:	75 f2                	jne    80105420 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010542e:	5b                   	pop    %ebx
8010542f:	5e                   	pop    %esi
80105430:	5d                   	pop    %ebp
80105431:	c3                   	ret    
80105432:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105440 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105443:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105444:	eb 8a                	jmp    801053d0 <memmove>
80105446:	8d 76 00             	lea    0x0(%esi),%esi
80105449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105450 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	57                   	push   %edi
80105454:	56                   	push   %esi
80105455:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105458:	53                   	push   %ebx
80105459:	8b 7d 08             	mov    0x8(%ebp),%edi
8010545c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010545f:	85 c9                	test   %ecx,%ecx
80105461:	74 37                	je     8010549a <strncmp+0x4a>
80105463:	0f b6 17             	movzbl (%edi),%edx
80105466:	0f b6 1e             	movzbl (%esi),%ebx
80105469:	84 d2                	test   %dl,%dl
8010546b:	74 3f                	je     801054ac <strncmp+0x5c>
8010546d:	38 d3                	cmp    %dl,%bl
8010546f:	75 3b                	jne    801054ac <strncmp+0x5c>
80105471:	8d 47 01             	lea    0x1(%edi),%eax
80105474:	01 cf                	add    %ecx,%edi
80105476:	eb 1b                	jmp    80105493 <strncmp+0x43>
80105478:	90                   	nop
80105479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105480:	0f b6 10             	movzbl (%eax),%edx
80105483:	84 d2                	test   %dl,%dl
80105485:	74 21                	je     801054a8 <strncmp+0x58>
80105487:	0f b6 19             	movzbl (%ecx),%ebx
8010548a:	83 c0 01             	add    $0x1,%eax
8010548d:	89 ce                	mov    %ecx,%esi
8010548f:	38 da                	cmp    %bl,%dl
80105491:	75 19                	jne    801054ac <strncmp+0x5c>
80105493:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80105495:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80105498:	75 e6                	jne    80105480 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010549a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010549b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010549d:	5e                   	pop    %esi
8010549e:	5f                   	pop    %edi
8010549f:	5d                   	pop    %ebp
801054a0:	c3                   	ret    
801054a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054a8:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801054ac:	0f b6 c2             	movzbl %dl,%eax
801054af:	29 d8                	sub    %ebx,%eax
}
801054b1:	5b                   	pop    %ebx
801054b2:	5e                   	pop    %esi
801054b3:	5f                   	pop    %edi
801054b4:	5d                   	pop    %ebp
801054b5:	c3                   	ret    
801054b6:	8d 76 00             	lea    0x0(%esi),%esi
801054b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054c0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	56                   	push   %esi
801054c4:	53                   	push   %ebx
801054c5:	8b 45 08             	mov    0x8(%ebp),%eax
801054c8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801054cb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801054ce:	89 c2                	mov    %eax,%edx
801054d0:	eb 19                	jmp    801054eb <strncpy+0x2b>
801054d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054d8:	83 c3 01             	add    $0x1,%ebx
801054db:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801054df:	83 c2 01             	add    $0x1,%edx
801054e2:	84 c9                	test   %cl,%cl
801054e4:	88 4a ff             	mov    %cl,-0x1(%edx)
801054e7:	74 09                	je     801054f2 <strncpy+0x32>
801054e9:	89 f1                	mov    %esi,%ecx
801054eb:	85 c9                	test   %ecx,%ecx
801054ed:	8d 71 ff             	lea    -0x1(%ecx),%esi
801054f0:	7f e6                	jg     801054d8 <strncpy+0x18>
    ;
  while(n-- > 0)
801054f2:	31 c9                	xor    %ecx,%ecx
801054f4:	85 f6                	test   %esi,%esi
801054f6:	7e 17                	jle    8010550f <strncpy+0x4f>
801054f8:	90                   	nop
801054f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80105500:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105504:	89 f3                	mov    %esi,%ebx
80105506:	83 c1 01             	add    $0x1,%ecx
80105509:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010550b:	85 db                	test   %ebx,%ebx
8010550d:	7f f1                	jg     80105500 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010550f:	5b                   	pop    %ebx
80105510:	5e                   	pop    %esi
80105511:	5d                   	pop    %ebp
80105512:	c3                   	ret    
80105513:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105520 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	56                   	push   %esi
80105524:	53                   	push   %ebx
80105525:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105528:	8b 45 08             	mov    0x8(%ebp),%eax
8010552b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010552e:	85 c9                	test   %ecx,%ecx
80105530:	7e 26                	jle    80105558 <safestrcpy+0x38>
80105532:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105536:	89 c1                	mov    %eax,%ecx
80105538:	eb 17                	jmp    80105551 <safestrcpy+0x31>
8010553a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105540:	83 c2 01             	add    $0x1,%edx
80105543:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105547:	83 c1 01             	add    $0x1,%ecx
8010554a:	84 db                	test   %bl,%bl
8010554c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010554f:	74 04                	je     80105555 <safestrcpy+0x35>
80105551:	39 f2                	cmp    %esi,%edx
80105553:	75 eb                	jne    80105540 <safestrcpy+0x20>
    ;
  *s = 0;
80105555:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105558:	5b                   	pop    %ebx
80105559:	5e                   	pop    %esi
8010555a:	5d                   	pop    %ebp
8010555b:	c3                   	ret    
8010555c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105560 <strlen>:

int
strlen(const char *s)
{
80105560:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105561:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80105563:	89 e5                	mov    %esp,%ebp
80105565:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80105568:	80 3a 00             	cmpb   $0x0,(%edx)
8010556b:	74 0c                	je     80105579 <strlen+0x19>
8010556d:	8d 76 00             	lea    0x0(%esi),%esi
80105570:	83 c0 01             	add    $0x1,%eax
80105573:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105577:	75 f7                	jne    80105570 <strlen+0x10>
    ;
  return n;
}
80105579:	5d                   	pop    %ebp
8010557a:	c3                   	ret    

8010557b <swtch>:
8010557b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010557f:	8b 54 24 08          	mov    0x8(%esp),%edx
80105583:	55                   	push   %ebp
80105584:	53                   	push   %ebx
80105585:	56                   	push   %esi
80105586:	57                   	push   %edi
80105587:	89 20                	mov    %esp,(%eax)
80105589:	89 d4                	mov    %edx,%esp
8010558b:	5f                   	pop    %edi
8010558c:	5e                   	pop    %esi
8010558d:	5b                   	pop    %ebx
8010558e:	5d                   	pop    %ebp
8010558f:	c3                   	ret    

80105590 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	53                   	push   %ebx
80105594:	83 ec 04             	sub    $0x4,%esp
80105597:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010559a:	e8 f1 f0 ff ff       	call   80104690 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010559f:	8b 00                	mov    (%eax),%eax
801055a1:	39 d8                	cmp    %ebx,%eax
801055a3:	76 1b                	jbe    801055c0 <fetchint+0x30>
801055a5:	8d 53 04             	lea    0x4(%ebx),%edx
801055a8:	39 d0                	cmp    %edx,%eax
801055aa:	72 14                	jb     801055c0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801055ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801055af:	8b 13                	mov    (%ebx),%edx
801055b1:	89 10                	mov    %edx,(%eax)
  return 0;
801055b3:	31 c0                	xor    %eax,%eax
}
801055b5:	83 c4 04             	add    $0x4,%esp
801055b8:	5b                   	pop    %ebx
801055b9:	5d                   	pop    %ebp
801055ba:	c3                   	ret    
801055bb:	90                   	nop
801055bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
801055c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055c5:	eb ee                	jmp    801055b5 <fetchint+0x25>
801055c7:	89 f6                	mov    %esi,%esi
801055c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801055d0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	53                   	push   %ebx
801055d4:	83 ec 04             	sub    $0x4,%esp
801055d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801055da:	e8 b1 f0 ff ff       	call   80104690 <myproc>

  if(addr >= curproc->sz)
801055df:	39 18                	cmp    %ebx,(%eax)
801055e1:	76 29                	jbe    8010560c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801055e3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801055e6:	89 da                	mov    %ebx,%edx
801055e8:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
801055ea:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
801055ec:	39 c3                	cmp    %eax,%ebx
801055ee:	73 1c                	jae    8010560c <fetchstr+0x3c>
    if(*s == 0)
801055f0:	80 3b 00             	cmpb   $0x0,(%ebx)
801055f3:	75 10                	jne    80105605 <fetchstr+0x35>
801055f5:	eb 29                	jmp    80105620 <fetchstr+0x50>
801055f7:	89 f6                	mov    %esi,%esi
801055f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105600:	80 3a 00             	cmpb   $0x0,(%edx)
80105603:	74 1b                	je     80105620 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80105605:	83 c2 01             	add    $0x1,%edx
80105608:	39 d0                	cmp    %edx,%eax
8010560a:	77 f4                	ja     80105600 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
8010560c:	83 c4 04             	add    $0x4,%esp
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
8010560f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80105614:	5b                   	pop    %ebx
80105615:	5d                   	pop    %ebp
80105616:	c3                   	ret    
80105617:	89 f6                	mov    %esi,%esi
80105619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105620:	83 c4 04             	add    $0x4,%esp
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80105623:	89 d0                	mov    %edx,%eax
80105625:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80105627:	5b                   	pop    %ebx
80105628:	5d                   	pop    %ebp
80105629:	c3                   	ret    
8010562a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105630 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	56                   	push   %esi
80105634:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105635:	e8 56 f0 ff ff       	call   80104690 <myproc>
8010563a:	8b 40 18             	mov    0x18(%eax),%eax
8010563d:	8b 55 08             	mov    0x8(%ebp),%edx
80105640:	8b 40 44             	mov    0x44(%eax),%eax
80105643:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
80105646:	e8 45 f0 ff ff       	call   80104690 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010564b:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010564d:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105650:	39 c6                	cmp    %eax,%esi
80105652:	73 1c                	jae    80105670 <argint+0x40>
80105654:	8d 53 08             	lea    0x8(%ebx),%edx
80105657:	39 d0                	cmp    %edx,%eax
80105659:	72 15                	jb     80105670 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
8010565b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010565e:	8b 53 04             	mov    0x4(%ebx),%edx
80105661:	89 10                	mov    %edx,(%eax)
  return 0;
80105663:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80105665:	5b                   	pop    %ebx
80105666:	5e                   	pop    %esi
80105667:	5d                   	pop    %ebp
80105668:	c3                   	ret    
80105669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80105670:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105675:	eb ee                	jmp    80105665 <argint+0x35>
80105677:	89 f6                	mov    %esi,%esi
80105679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105680 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	56                   	push   %esi
80105684:	53                   	push   %ebx
80105685:	83 ec 10             	sub    $0x10,%esp
80105688:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010568b:	e8 00 f0 ff ff       	call   80104690 <myproc>
80105690:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105692:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105695:	83 ec 08             	sub    $0x8,%esp
80105698:	50                   	push   %eax
80105699:	ff 75 08             	pushl  0x8(%ebp)
8010569c:	e8 8f ff ff ff       	call   80105630 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801056a1:	c1 e8 1f             	shr    $0x1f,%eax
801056a4:	83 c4 10             	add    $0x10,%esp
801056a7:	84 c0                	test   %al,%al
801056a9:	75 2d                	jne    801056d8 <argptr+0x58>
801056ab:	89 d8                	mov    %ebx,%eax
801056ad:	c1 e8 1f             	shr    $0x1f,%eax
801056b0:	84 c0                	test   %al,%al
801056b2:	75 24                	jne    801056d8 <argptr+0x58>
801056b4:	8b 16                	mov    (%esi),%edx
801056b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056b9:	39 c2                	cmp    %eax,%edx
801056bb:	76 1b                	jbe    801056d8 <argptr+0x58>
801056bd:	01 c3                	add    %eax,%ebx
801056bf:	39 da                	cmp    %ebx,%edx
801056c1:	72 15                	jb     801056d8 <argptr+0x58>
    return -1;
  *pp = (char*)i;
801056c3:	8b 55 0c             	mov    0xc(%ebp),%edx
801056c6:	89 02                	mov    %eax,(%edx)
  return 0;
801056c8:	31 c0                	xor    %eax,%eax
}
801056ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
801056cd:	5b                   	pop    %ebx
801056ce:	5e                   	pop    %esi
801056cf:	5d                   	pop    %ebp
801056d0:	c3                   	ret    
801056d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
801056d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056dd:	eb eb                	jmp    801056ca <argptr+0x4a>
801056df:	90                   	nop

801056e0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
801056e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056e9:	50                   	push   %eax
801056ea:	ff 75 08             	pushl  0x8(%ebp)
801056ed:	e8 3e ff ff ff       	call   80105630 <argint>
801056f2:	83 c4 10             	add    $0x10,%esp
801056f5:	85 c0                	test   %eax,%eax
801056f7:	78 17                	js     80105710 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
801056f9:	83 ec 08             	sub    $0x8,%esp
801056fc:	ff 75 0c             	pushl  0xc(%ebp)
801056ff:	ff 75 f4             	pushl  -0xc(%ebp)
80105702:	e8 c9 fe ff ff       	call   801055d0 <fetchstr>
80105707:	83 c4 10             	add    $0x10,%esp
}
8010570a:	c9                   	leave  
8010570b:	c3                   	ret    
8010570c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80105710:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80105715:	c9                   	leave  
80105716:	c3                   	ret    
80105717:	89 f6                	mov    %esi,%esi
80105719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105720 <syscall>:

};

void
syscall(void)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	56                   	push   %esi
80105724:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
80105725:	e8 66 ef ff ff       	call   80104690 <myproc>

  num = curproc->tf->eax;
8010572a:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
8010572d:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010572f:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105732:	8d 50 ff             	lea    -0x1(%eax),%edx
80105735:	83 fa 15             	cmp    $0x15,%edx
80105738:	77 1e                	ja     80105758 <syscall+0x38>
8010573a:	8b 14 85 20 89 10 80 	mov    -0x7fef76e0(,%eax,4),%edx
80105741:	85 d2                	test   %edx,%edx
80105743:	74 13                	je     80105758 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80105745:	ff d2                	call   *%edx
80105747:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010574a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010574d:	5b                   	pop    %ebx
8010574e:	5e                   	pop    %esi
8010574f:	5d                   	pop    %ebp
80105750:	c3                   	ret    
80105751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105758:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105759:	8d 43 6c             	lea    0x6c(%ebx),%eax

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
8010575c:	50                   	push   %eax
8010575d:	ff 73 10             	pushl  0x10(%ebx)
80105760:	68 f1 88 10 80       	push   $0x801088f1
80105765:	e8 c6 ae ff ff       	call   80100630 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
8010576a:	8b 43 18             	mov    0x18(%ebx),%eax
8010576d:	83 c4 10             	add    $0x10,%esp
80105770:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80105777:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010577a:	5b                   	pop    %ebx
8010577b:	5e                   	pop    %esi
8010577c:	5d                   	pop    %ebp
8010577d:	c3                   	ret    
8010577e:	66 90                	xchg   %ax,%ax

80105780 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	57                   	push   %edi
80105784:	56                   	push   %esi
80105785:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105786:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105789:	83 ec 44             	sub    $0x44,%esp
8010578c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010578f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105792:	56                   	push   %esi
80105793:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105794:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105797:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010579a:	e8 51 d6 ff ff       	call   80102df0 <nameiparent>
8010579f:	83 c4 10             	add    $0x10,%esp
801057a2:	85 c0                	test   %eax,%eax
801057a4:	0f 84 f6 00 00 00    	je     801058a0 <create+0x120>
    return 0;
  ilock(dp);
801057aa:	83 ec 0c             	sub    $0xc,%esp
801057ad:	89 c7                	mov    %eax,%edi
801057af:	50                   	push   %eax
801057b0:	e8 9b cd ff ff       	call   80102550 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801057b5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801057b8:	83 c4 0c             	add    $0xc,%esp
801057bb:	50                   	push   %eax
801057bc:	56                   	push   %esi
801057bd:	57                   	push   %edi
801057be:	e8 ed d2 ff ff       	call   80102ab0 <dirlookup>
801057c3:	83 c4 10             	add    $0x10,%esp
801057c6:	85 c0                	test   %eax,%eax
801057c8:	89 c3                	mov    %eax,%ebx
801057ca:	74 54                	je     80105820 <create+0xa0>
    iunlockput(dp);
801057cc:	83 ec 0c             	sub    $0xc,%esp
801057cf:	57                   	push   %edi
801057d0:	e8 0b d0 ff ff       	call   801027e0 <iunlockput>
    ilock(ip);
801057d5:	89 1c 24             	mov    %ebx,(%esp)
801057d8:	e8 73 cd ff ff       	call   80102550 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801057dd:	83 c4 10             	add    $0x10,%esp
801057e0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
801057e5:	75 19                	jne    80105800 <create+0x80>
801057e7:	66 83 7b 54 02       	cmpw   $0x2,0x54(%ebx)
801057ec:	89 d8                	mov    %ebx,%eax
801057ee:	75 10                	jne    80105800 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801057f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801057f3:	5b                   	pop    %ebx
801057f4:	5e                   	pop    %esi
801057f5:	5f                   	pop    %edi
801057f6:	5d                   	pop    %ebp
801057f7:	c3                   	ret    
801057f8:	90                   	nop
801057f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80105800:	83 ec 0c             	sub    $0xc,%esp
80105803:	53                   	push   %ebx
80105804:	e8 d7 cf ff ff       	call   801027e0 <iunlockput>
    return 0;
80105809:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010580c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
8010580f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105811:	5b                   	pop    %ebx
80105812:	5e                   	pop    %esi
80105813:	5f                   	pop    %edi
80105814:	5d                   	pop    %ebp
80105815:	c3                   	ret    
80105816:	8d 76 00             	lea    0x0(%esi),%esi
80105819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105820:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105824:	83 ec 08             	sub    $0x8,%esp
80105827:	50                   	push   %eax
80105828:	ff 37                	pushl  (%edi)
8010582a:	e8 a1 cb ff ff       	call   801023d0 <ialloc>
8010582f:	83 c4 10             	add    $0x10,%esp
80105832:	85 c0                	test   %eax,%eax
80105834:	89 c3                	mov    %eax,%ebx
80105836:	0f 84 cc 00 00 00    	je     80105908 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
8010583c:	83 ec 0c             	sub    $0xc,%esp
8010583f:	50                   	push   %eax
80105840:	e8 0b cd ff ff       	call   80102550 <ilock>
  ip->major = major;
80105845:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80105849:	66 89 43 56          	mov    %ax,0x56(%ebx)
  ip->minor = minor;
8010584d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105851:	66 89 43 58          	mov    %ax,0x58(%ebx)
  ip->nlink = 1;
80105855:	b8 01 00 00 00       	mov    $0x1,%eax
8010585a:	66 89 43 5a          	mov    %ax,0x5a(%ebx)
  iupdate(ip);
8010585e:	89 1c 24             	mov    %ebx,(%esp)
80105861:	e8 2a cc ff ff       	call   80102490 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80105866:	83 c4 10             	add    $0x10,%esp
80105869:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010586e:	74 40                	je     801058b0 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105870:	83 ec 04             	sub    $0x4,%esp
80105873:	ff 73 04             	pushl  0x4(%ebx)
80105876:	56                   	push   %esi
80105877:	57                   	push   %edi
80105878:	e8 93 d4 ff ff       	call   80102d10 <dirlink>
8010587d:	83 c4 10             	add    $0x10,%esp
80105880:	85 c0                	test   %eax,%eax
80105882:	78 77                	js     801058fb <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
80105884:	83 ec 0c             	sub    $0xc,%esp
80105887:	57                   	push   %edi
80105888:	e8 53 cf ff ff       	call   801027e0 <iunlockput>

  return ip;
8010588d:	83 c4 10             	add    $0x10,%esp
}
80105890:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80105893:	89 d8                	mov    %ebx,%eax
}
80105895:	5b                   	pop    %ebx
80105896:	5e                   	pop    %esi
80105897:	5f                   	pop    %edi
80105898:	5d                   	pop    %ebp
80105899:	c3                   	ret    
8010589a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
801058a0:	31 c0                	xor    %eax,%eax
801058a2:	e9 49 ff ff ff       	jmp    801057f0 <create+0x70>
801058a7:	89 f6                	mov    %esi,%esi
801058a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
801058b0:	66 83 47 5a 01       	addw   $0x1,0x5a(%edi)
    iupdate(dp);
801058b5:	83 ec 0c             	sub    $0xc,%esp
801058b8:	57                   	push   %edi
801058b9:	e8 d2 cb ff ff       	call   80102490 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801058be:	83 c4 0c             	add    $0xc,%esp
801058c1:	ff 73 04             	pushl  0x4(%ebx)
801058c4:	68 98 89 10 80       	push   $0x80108998
801058c9:	53                   	push   %ebx
801058ca:	e8 41 d4 ff ff       	call   80102d10 <dirlink>
801058cf:	83 c4 10             	add    $0x10,%esp
801058d2:	85 c0                	test   %eax,%eax
801058d4:	78 18                	js     801058ee <create+0x16e>
801058d6:	83 ec 04             	sub    $0x4,%esp
801058d9:	ff 77 04             	pushl  0x4(%edi)
801058dc:	68 97 89 10 80       	push   $0x80108997
801058e1:	53                   	push   %ebx
801058e2:	e8 29 d4 ff ff       	call   80102d10 <dirlink>
801058e7:	83 c4 10             	add    $0x10,%esp
801058ea:	85 c0                	test   %eax,%eax
801058ec:	79 82                	jns    80105870 <create+0xf0>
      panic("create dots");
801058ee:	83 ec 0c             	sub    $0xc,%esp
801058f1:	68 8b 89 10 80       	push   $0x8010898b
801058f6:	e8 c5 ae ff ff       	call   801007c0 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
801058fb:	83 ec 0c             	sub    $0xc,%esp
801058fe:	68 9a 89 10 80       	push   $0x8010899a
80105903:	e8 b8 ae ff ff       	call   801007c0 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80105908:	83 ec 0c             	sub    $0xc,%esp
8010590b:	68 7c 89 10 80       	push   $0x8010897c
80105910:	e8 ab ae ff ff       	call   801007c0 <panic>
80105915:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105920 <argfd.constprop.0>:
}

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	56                   	push   %esi
80105924:	53                   	push   %ebx
80105925:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105927:	8d 45 f4             	lea    -0xc(%ebp),%eax
}

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
8010592a:	89 d3                	mov    %edx,%ebx
8010592c:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010592f:	50                   	push   %eax
80105930:	6a 00                	push   $0x0
80105932:	e8 f9 fc ff ff       	call   80105630 <argint>
80105937:	83 c4 10             	add    $0x10,%esp
8010593a:	85 c0                	test   %eax,%eax
8010593c:	78 32                	js     80105970 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010593e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105942:	77 2c                	ja     80105970 <argfd.constprop.0+0x50>
80105944:	e8 47 ed ff ff       	call   80104690 <myproc>
80105949:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010594c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105950:	85 c0                	test   %eax,%eax
80105952:	74 1c                	je     80105970 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
80105954:	85 f6                	test   %esi,%esi
80105956:	74 02                	je     8010595a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105958:	89 16                	mov    %edx,(%esi)
  if(pf)
8010595a:	85 db                	test   %ebx,%ebx
8010595c:	74 22                	je     80105980 <argfd.constprop.0+0x60>
    *pf = f;
8010595e:	89 03                	mov    %eax,(%ebx)
  return 0;
80105960:	31 c0                	xor    %eax,%eax
}
80105962:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105965:	5b                   	pop    %ebx
80105966:	5e                   	pop    %esi
80105967:	5d                   	pop    %ebp
80105968:	c3                   	ret    
80105969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105970:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80105973:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
80105978:	5b                   	pop    %ebx
80105979:	5e                   	pop    %esi
8010597a:	5d                   	pop    %ebp
8010597b:	c3                   	ret    
8010597c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80105980:	31 c0                	xor    %eax,%eax
80105982:	eb de                	jmp    80105962 <argfd.constprop.0+0x42>
80105984:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010598a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105990 <sys_setconsole>:
int consolemode = 0;

//Edit console output
int 
sys_setconsole(void)
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	57                   	push   %edi
80105994:	56                   	push   %esi
80105995:	53                   	push   %ebx
    int pos, ch, color, cursor, mode;
    if (argint(0, &pos) < 0 || argint(1, &ch) < 0)
80105996:	8d 45 d4             	lea    -0x2c(%ebp),%eax
int consolemode = 0;

//Edit console output
int 
sys_setconsole(void)
{
80105999:	83 ec 34             	sub    $0x34,%esp
    int pos, ch, color, cursor, mode;
    if (argint(0, &pos) < 0 || argint(1, &ch) < 0)
8010599c:	50                   	push   %eax
8010599d:	6a 00                	push   $0x0
8010599f:	e8 8c fc ff ff       	call   80105630 <argint>
801059a4:	83 c4 10             	add    $0x10,%esp
801059a7:	85 c0                	test   %eax,%eax
801059a9:	0f 88 e9 00 00 00    	js     80105a98 <sys_setconsole+0x108>
801059af:	8d 45 d8             	lea    -0x28(%ebp),%eax
801059b2:	83 ec 08             	sub    $0x8,%esp
801059b5:	50                   	push   %eax
801059b6:	6a 01                	push   $0x1
801059b8:	e8 73 fc ff ff       	call   80105630 <argint>
801059bd:	83 c4 10             	add    $0x10,%esp
801059c0:	85 c0                	test   %eax,%eax
801059c2:	0f 88 d0 00 00 00    	js     80105a98 <sys_setconsole+0x108>
        return -1;
    if (argint(2, &color) < 0)
801059c8:	8d 45 dc             	lea    -0x24(%ebp),%eax
801059cb:	83 ec 08             	sub    $0x8,%esp
801059ce:	50                   	push   %eax
801059cf:	6a 02                	push   $0x2
801059d1:	e8 5a fc ff ff       	call   80105630 <argint>
801059d6:	83 c4 10             	add    $0x10,%esp
801059d9:	85 c0                	test   %eax,%eax
801059db:	0f 88 97 00 00 00    	js     80105a78 <sys_setconsole+0xe8>
        color = 0x0700;
    if (argint(3, &cursor) < 0)
801059e1:	8d 45 e0             	lea    -0x20(%ebp),%eax
801059e4:	83 ec 08             	sub    $0x8,%esp
801059e7:	50                   	push   %eax
801059e8:	6a 03                	push   $0x3
801059ea:	e8 41 fc ff ff       	call   80105630 <argint>
801059ef:	83 c4 10             	add    $0x10,%esp
801059f2:	85 c0                	test   %eax,%eax
801059f4:	0f 88 8e 00 00 00    	js     80105a88 <sys_setconsole+0xf8>
        cursor = -1;
    if (argint(4, &mode) < 0)
801059fa:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801059fd:	83 ec 08             	sub    $0x8,%esp
80105a00:	50                   	push   %eax
80105a01:	6a 04                	push   $0x4
80105a03:	e8 28 fc ff ff       	call   80105630 <argint>
        mode = 0;
    if (pos >= 0){
80105a08:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        return -1;
    if (argint(2, &color) < 0)
        color = 0x0700;
    if (argint(3, &cursor) < 0)
        cursor = -1;
    if (argint(4, &mode) < 0)
80105a0b:	83 c4 10             	add    $0x10,%esp
80105a0e:	b9 00 00 00 00       	mov    $0x0,%ecx
80105a13:	85 c0                	test   %eax,%eax
80105a15:	0f 49 4d e4          	cmovns -0x1c(%ebp),%ecx
        mode = 0;
    if (pos >= 0){
80105a19:	85 d2                	test   %edx,%edx
80105a1b:	78 10                	js     80105a2d <sys_setconsole+0x9d>
        crt[pos] = (ch & 0xff) | color;
80105a1d:	0f b6 45 d8          	movzbl -0x28(%ebp),%eax
80105a21:	66 0b 45 dc          	or     -0x24(%ebp),%ax
80105a25:	66 89 84 12 00 80 0b 	mov    %ax,-0x7ff48000(%edx,%edx,1)
80105a2c:	80 
    }
    if (cursor >= 0){
80105a2d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80105a30:	85 db                	test   %ebx,%ebx
80105a32:	78 27                	js     80105a5b <sys_setconsole+0xcb>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105a34:	bf d4 03 00 00       	mov    $0x3d4,%edi
80105a39:	b8 0e 00 00 00       	mov    $0xe,%eax
80105a3e:	89 fa                	mov    %edi,%edx
80105a40:	ee                   	out    %al,(%dx)
80105a41:	be d5 03 00 00       	mov    $0x3d5,%esi
80105a46:	89 d8                	mov    %ebx,%eax
80105a48:	c1 f8 08             	sar    $0x8,%eax
80105a4b:	89 f2                	mov    %esi,%edx
80105a4d:	ee                   	out    %al,(%dx)
80105a4e:	b8 0f 00 00 00       	mov    $0xf,%eax
80105a53:	89 fa                	mov    %edi,%edx
80105a55:	ee                   	out    %al,(%dx)
80105a56:	89 d8                	mov    %ebx,%eax
80105a58:	89 f2                	mov    %esi,%edx
80105a5a:	ee                   	out    %al,(%dx)
        outb(CRTPORT, 15);
        outb(CRTPORT+1, cursor);
    }
    if (mode < 0)
        mode = 0;
    consolemode = mode;
80105a5b:	85 c9                	test   %ecx,%ecx
80105a5d:	b8 00 00 00 00       	mov    $0x0,%eax
80105a62:	0f 4e c8             	cmovle %eax,%ecx
80105a65:	89 0d fc b5 10 80    	mov    %ecx,0x8010b5fc
    return 0;
}
80105a6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a6e:	5b                   	pop    %ebx
80105a6f:	5e                   	pop    %esi
80105a70:	5f                   	pop    %edi
80105a71:	5d                   	pop    %ebp
80105a72:	c3                   	ret    
80105a73:	90                   	nop
80105a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
    int pos, ch, color, cursor, mode;
    if (argint(0, &pos) < 0 || argint(1, &ch) < 0)
        return -1;
    if (argint(2, &color) < 0)
        color = 0x0700;
80105a78:	c7 45 dc 00 07 00 00 	movl   $0x700,-0x24(%ebp)
80105a7f:	e9 5d ff ff ff       	jmp    801059e1 <sys_setconsole+0x51>
80105a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (argint(3, &cursor) < 0)
        cursor = -1;
80105a88:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
80105a8f:	e9 66 ff ff ff       	jmp    801059fa <sys_setconsole+0x6a>
80105a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int 
sys_setconsole(void)
{
    int pos, ch, color, cursor, mode;
    if (argint(0, &pos) < 0 || argint(1, &ch) < 0)
        return -1;
80105a98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a9d:	eb cc                	jmp    80105a6b <sys_setconsole+0xdb>
80105a9f:	90                   	nop

80105aa0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80105aa0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105aa1:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80105aa3:	89 e5                	mov    %esp,%ebp
80105aa5:	56                   	push   %esi
80105aa6:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105aa7:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80105aaa:	83 ec 10             	sub    $0x10,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80105aad:	e8 6e fe ff ff       	call   80105920 <argfd.constprop.0>
80105ab2:	85 c0                	test   %eax,%eax
80105ab4:	78 1a                	js     80105ad0 <sys_dup+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105ab6:	31 db                	xor    %ebx,%ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
80105ab8:	8b 75 f4             	mov    -0xc(%ebp),%esi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80105abb:	e8 d0 eb ff ff       	call   80104690 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80105ac0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105ac4:	85 d2                	test   %edx,%edx
80105ac6:	74 18                	je     80105ae0 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80105ac8:	83 c3 01             	add    $0x1,%ebx
80105acb:	83 fb 10             	cmp    $0x10,%ebx
80105ace:	75 f0                	jne    80105ac0 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80105ad0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80105ad3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80105ad8:	5b                   	pop    %ebx
80105ad9:	5e                   	pop    %esi
80105ada:	5d                   	pop    %ebp
80105adb:	c3                   	ret    
80105adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80105ae0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80105ae4:	83 ec 0c             	sub    $0xc,%esp
80105ae7:	ff 75 f4             	pushl  -0xc(%ebp)
80105aea:	e8 c1 c0 ff ff       	call   80101bb0 <filedup>
  return fd;
80105aef:	83 c4 10             	add    $0x10,%esp
}
80105af2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80105af5:	89 d8                	mov    %ebx,%eax
}
80105af7:	5b                   	pop    %ebx
80105af8:	5e                   	pop    %esi
80105af9:	5d                   	pop    %ebp
80105afa:	c3                   	ret    
80105afb:	90                   	nop
80105afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b00 <sys_read>:

int
sys_read(void)
{
80105b00:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105b01:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80105b03:	89 e5                	mov    %esp,%ebp
80105b05:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105b08:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105b0b:	e8 10 fe ff ff       	call   80105920 <argfd.constprop.0>
80105b10:	85 c0                	test   %eax,%eax
80105b12:	78 4c                	js     80105b60 <sys_read+0x60>
80105b14:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b17:	83 ec 08             	sub    $0x8,%esp
80105b1a:	50                   	push   %eax
80105b1b:	6a 02                	push   $0x2
80105b1d:	e8 0e fb ff ff       	call   80105630 <argint>
80105b22:	83 c4 10             	add    $0x10,%esp
80105b25:	85 c0                	test   %eax,%eax
80105b27:	78 37                	js     80105b60 <sys_read+0x60>
80105b29:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b2c:	83 ec 04             	sub    $0x4,%esp
80105b2f:	ff 75 f0             	pushl  -0x10(%ebp)
80105b32:	50                   	push   %eax
80105b33:	6a 01                	push   $0x1
80105b35:	e8 46 fb ff ff       	call   80105680 <argptr>
80105b3a:	83 c4 10             	add    $0x10,%esp
80105b3d:	85 c0                	test   %eax,%eax
80105b3f:	78 1f                	js     80105b60 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80105b41:	83 ec 04             	sub    $0x4,%esp
80105b44:	ff 75 f0             	pushl  -0x10(%ebp)
80105b47:	ff 75 f4             	pushl  -0xc(%ebp)
80105b4a:	ff 75 ec             	pushl  -0x14(%ebp)
80105b4d:	e8 ce c1 ff ff       	call   80101d20 <fileread>
80105b52:	83 c4 10             	add    $0x10,%esp
}
80105b55:	c9                   	leave  
80105b56:	c3                   	ret    
80105b57:	89 f6                	mov    %esi,%esi
80105b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80105b60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80105b65:	c9                   	leave  
80105b66:	c3                   	ret    
80105b67:	89 f6                	mov    %esi,%esi
80105b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b70 <sys_write>:

int
sys_write(void)
{
80105b70:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105b71:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80105b73:	89 e5                	mov    %esp,%ebp
80105b75:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105b78:	8d 55 ec             	lea    -0x14(%ebp),%edx
80105b7b:	e8 a0 fd ff ff       	call   80105920 <argfd.constprop.0>
80105b80:	85 c0                	test   %eax,%eax
80105b82:	78 4c                	js     80105bd0 <sys_write+0x60>
80105b84:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b87:	83 ec 08             	sub    $0x8,%esp
80105b8a:	50                   	push   %eax
80105b8b:	6a 02                	push   $0x2
80105b8d:	e8 9e fa ff ff       	call   80105630 <argint>
80105b92:	83 c4 10             	add    $0x10,%esp
80105b95:	85 c0                	test   %eax,%eax
80105b97:	78 37                	js     80105bd0 <sys_write+0x60>
80105b99:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b9c:	83 ec 04             	sub    $0x4,%esp
80105b9f:	ff 75 f0             	pushl  -0x10(%ebp)
80105ba2:	50                   	push   %eax
80105ba3:	6a 01                	push   $0x1
80105ba5:	e8 d6 fa ff ff       	call   80105680 <argptr>
80105baa:	83 c4 10             	add    $0x10,%esp
80105bad:	85 c0                	test   %eax,%eax
80105baf:	78 1f                	js     80105bd0 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80105bb1:	83 ec 04             	sub    $0x4,%esp
80105bb4:	ff 75 f0             	pushl  -0x10(%ebp)
80105bb7:	ff 75 f4             	pushl  -0xc(%ebp)
80105bba:	ff 75 ec             	pushl  -0x14(%ebp)
80105bbd:	e8 ee c1 ff ff       	call   80101db0 <filewrite>
80105bc2:	83 c4 10             	add    $0x10,%esp
}
80105bc5:	c9                   	leave  
80105bc6:	c3                   	ret    
80105bc7:	89 f6                	mov    %esi,%esi
80105bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80105bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80105bd5:	c9                   	leave  
80105bd6:	c3                   	ret    
80105bd7:	89 f6                	mov    %esi,%esi
80105bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105be0 <sys_close>:

int
sys_close(void)
{
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80105be6:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105be9:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105bec:	e8 2f fd ff ff       	call   80105920 <argfd.constprop.0>
80105bf1:	85 c0                	test   %eax,%eax
80105bf3:	78 2b                	js     80105c20 <sys_close+0x40>
    return -1;
  myproc()->ofile[fd] = 0;
80105bf5:	e8 96 ea ff ff       	call   80104690 <myproc>
80105bfa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105bfd:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
80105c00:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105c07:	00 
  fileclose(f);
80105c08:	ff 75 f4             	pushl  -0xc(%ebp)
80105c0b:	e8 f0 bf ff ff       	call   80101c00 <fileclose>
  return 0;
80105c10:	83 c4 10             	add    $0x10,%esp
80105c13:	31 c0                	xor    %eax,%eax
}
80105c15:	c9                   	leave  
80105c16:	c3                   	ret    
80105c17:	89 f6                	mov    %esi,%esi
80105c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80105c20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80105c25:	c9                   	leave  
80105c26:	c3                   	ret    
80105c27:	89 f6                	mov    %esi,%esi
80105c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c30 <sys_fstat>:

int
sys_fstat(void)
{
80105c30:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105c31:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80105c33:	89 e5                	mov    %esp,%ebp
80105c35:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105c38:	8d 55 f0             	lea    -0x10(%ebp),%edx
80105c3b:	e8 e0 fc ff ff       	call   80105920 <argfd.constprop.0>
80105c40:	85 c0                	test   %eax,%eax
80105c42:	78 2c                	js     80105c70 <sys_fstat+0x40>
80105c44:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c47:	83 ec 04             	sub    $0x4,%esp
80105c4a:	6a 18                	push   $0x18
80105c4c:	50                   	push   %eax
80105c4d:	6a 01                	push   $0x1
80105c4f:	e8 2c fa ff ff       	call   80105680 <argptr>
80105c54:	83 c4 10             	add    $0x10,%esp
80105c57:	85 c0                	test   %eax,%eax
80105c59:	78 15                	js     80105c70 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80105c5b:	83 ec 08             	sub    $0x8,%esp
80105c5e:	ff 75 f4             	pushl  -0xc(%ebp)
80105c61:	ff 75 f0             	pushl  -0x10(%ebp)
80105c64:	e8 67 c0 ff ff       	call   80101cd0 <filestat>
80105c69:	83 c4 10             	add    $0x10,%esp
}
80105c6c:	c9                   	leave  
80105c6d:	c3                   	ret    
80105c6e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80105c70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80105c75:	c9                   	leave  
80105c76:	c3                   	ret    
80105c77:	89 f6                	mov    %esi,%esi
80105c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c80 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	57                   	push   %edi
80105c84:	56                   	push   %esi
80105c85:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105c86:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105c89:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105c8c:	50                   	push   %eax
80105c8d:	6a 00                	push   $0x0
80105c8f:	e8 4c fa ff ff       	call   801056e0 <argstr>
80105c94:	83 c4 10             	add    $0x10,%esp
80105c97:	85 c0                	test   %eax,%eax
80105c99:	0f 88 fb 00 00 00    	js     80105d9a <sys_link+0x11a>
80105c9f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105ca2:	83 ec 08             	sub    $0x8,%esp
80105ca5:	50                   	push   %eax
80105ca6:	6a 01                	push   $0x1
80105ca8:	e8 33 fa ff ff       	call   801056e0 <argstr>
80105cad:	83 c4 10             	add    $0x10,%esp
80105cb0:	85 c0                	test   %eax,%eax
80105cb2:	0f 88 e2 00 00 00    	js     80105d9a <sys_link+0x11a>
    return -1;

  begin_op();
80105cb8:	e8 a3 dd ff ff       	call   80103a60 <begin_op>
  if((ip = namei(old)) == 0){
80105cbd:	83 ec 0c             	sub    $0xc,%esp
80105cc0:	ff 75 d4             	pushl  -0x2c(%ebp)
80105cc3:	e8 08 d1 ff ff       	call   80102dd0 <namei>
80105cc8:	83 c4 10             	add    $0x10,%esp
80105ccb:	85 c0                	test   %eax,%eax
80105ccd:	89 c3                	mov    %eax,%ebx
80105ccf:	0f 84 f3 00 00 00    	je     80105dc8 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80105cd5:	83 ec 0c             	sub    $0xc,%esp
80105cd8:	50                   	push   %eax
80105cd9:	e8 72 c8 ff ff       	call   80102550 <ilock>
  if(ip->type == T_DIR){
80105cde:	83 c4 10             	add    $0x10,%esp
80105ce1:	66 83 7b 54 01       	cmpw   $0x1,0x54(%ebx)
80105ce6:	0f 84 c4 00 00 00    	je     80105db0 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80105cec:	66 83 43 5a 01       	addw   $0x1,0x5a(%ebx)
  iupdate(ip);
80105cf1:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105cf4:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80105cf7:	53                   	push   %ebx
80105cf8:	e8 93 c7 ff ff       	call   80102490 <iupdate>
  iunlock(ip);
80105cfd:	89 1c 24             	mov    %ebx,(%esp)
80105d00:	e8 2b c9 ff ff       	call   80102630 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80105d05:	58                   	pop    %eax
80105d06:	5a                   	pop    %edx
80105d07:	57                   	push   %edi
80105d08:	ff 75 d0             	pushl  -0x30(%ebp)
80105d0b:	e8 e0 d0 ff ff       	call   80102df0 <nameiparent>
80105d10:	83 c4 10             	add    $0x10,%esp
80105d13:	85 c0                	test   %eax,%eax
80105d15:	89 c6                	mov    %eax,%esi
80105d17:	74 5b                	je     80105d74 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80105d19:	83 ec 0c             	sub    $0xc,%esp
80105d1c:	50                   	push   %eax
80105d1d:	e8 2e c8 ff ff       	call   80102550 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105d22:	83 c4 10             	add    $0x10,%esp
80105d25:	8b 03                	mov    (%ebx),%eax
80105d27:	39 06                	cmp    %eax,(%esi)
80105d29:	75 3d                	jne    80105d68 <sys_link+0xe8>
80105d2b:	83 ec 04             	sub    $0x4,%esp
80105d2e:	ff 73 04             	pushl  0x4(%ebx)
80105d31:	57                   	push   %edi
80105d32:	56                   	push   %esi
80105d33:	e8 d8 cf ff ff       	call   80102d10 <dirlink>
80105d38:	83 c4 10             	add    $0x10,%esp
80105d3b:	85 c0                	test   %eax,%eax
80105d3d:	78 29                	js     80105d68 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80105d3f:	83 ec 0c             	sub    $0xc,%esp
80105d42:	56                   	push   %esi
80105d43:	e8 98 ca ff ff       	call   801027e0 <iunlockput>
  iput(ip);
80105d48:	89 1c 24             	mov    %ebx,(%esp)
80105d4b:	e8 30 c9 ff ff       	call   80102680 <iput>

  end_op();
80105d50:	e8 7b dd ff ff       	call   80103ad0 <end_op>

  return 0;
80105d55:	83 c4 10             	add    $0x10,%esp
80105d58:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80105d5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d5d:	5b                   	pop    %ebx
80105d5e:	5e                   	pop    %esi
80105d5f:	5f                   	pop    %edi
80105d60:	5d                   	pop    %ebp
80105d61:	c3                   	ret    
80105d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80105d68:	83 ec 0c             	sub    $0xc,%esp
80105d6b:	56                   	push   %esi
80105d6c:	e8 6f ca ff ff       	call   801027e0 <iunlockput>
    goto bad;
80105d71:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80105d74:	83 ec 0c             	sub    $0xc,%esp
80105d77:	53                   	push   %ebx
80105d78:	e8 d3 c7 ff ff       	call   80102550 <ilock>
  ip->nlink--;
80105d7d:	66 83 6b 5a 01       	subw   $0x1,0x5a(%ebx)
  iupdate(ip);
80105d82:	89 1c 24             	mov    %ebx,(%esp)
80105d85:	e8 06 c7 ff ff       	call   80102490 <iupdate>
  iunlockput(ip);
80105d8a:	89 1c 24             	mov    %ebx,(%esp)
80105d8d:	e8 4e ca ff ff       	call   801027e0 <iunlockput>
  end_op();
80105d92:	e8 39 dd ff ff       	call   80103ad0 <end_op>
  return -1;
80105d97:	83 c4 10             	add    $0x10,%esp
}
80105d9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80105d9d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105da2:	5b                   	pop    %ebx
80105da3:	5e                   	pop    %esi
80105da4:	5f                   	pop    %edi
80105da5:	5d                   	pop    %ebp
80105da6:	c3                   	ret    
80105da7:	89 f6                	mov    %esi,%esi
80105da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80105db0:	83 ec 0c             	sub    $0xc,%esp
80105db3:	53                   	push   %ebx
80105db4:	e8 27 ca ff ff       	call   801027e0 <iunlockput>
    end_op();
80105db9:	e8 12 dd ff ff       	call   80103ad0 <end_op>
    return -1;
80105dbe:	83 c4 10             	add    $0x10,%esp
80105dc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dc6:	eb 92                	jmp    80105d5a <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80105dc8:	e8 03 dd ff ff       	call   80103ad0 <end_op>
    return -1;
80105dcd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dd2:	eb 86                	jmp    80105d5a <sys_link+0xda>
80105dd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105dda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105de0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105de0:	55                   	push   %ebp
80105de1:	89 e5                	mov    %esp,%ebp
80105de3:	57                   	push   %edi
80105de4:	56                   	push   %esi
80105de5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105de6:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80105de9:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105dec:	50                   	push   %eax
80105ded:	6a 00                	push   $0x0
80105def:	e8 ec f8 ff ff       	call   801056e0 <argstr>
80105df4:	83 c4 10             	add    $0x10,%esp
80105df7:	85 c0                	test   %eax,%eax
80105df9:	0f 88 7a 01 00 00    	js     80105f79 <sys_unlink+0x199>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80105dff:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80105e02:	e8 59 dc ff ff       	call   80103a60 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105e07:	83 ec 08             	sub    $0x8,%esp
80105e0a:	53                   	push   %ebx
80105e0b:	ff 75 c0             	pushl  -0x40(%ebp)
80105e0e:	e8 dd cf ff ff       	call   80102df0 <nameiparent>
80105e13:	83 c4 10             	add    $0x10,%esp
80105e16:	85 c0                	test   %eax,%eax
80105e18:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105e1b:	0f 84 62 01 00 00    	je     80105f83 <sys_unlink+0x1a3>
    end_op();
    return -1;
  }

  ilock(dp);
80105e21:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105e24:	83 ec 0c             	sub    $0xc,%esp
80105e27:	56                   	push   %esi
80105e28:	e8 23 c7 ff ff       	call   80102550 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105e2d:	58                   	pop    %eax
80105e2e:	5a                   	pop    %edx
80105e2f:	68 98 89 10 80       	push   $0x80108998
80105e34:	53                   	push   %ebx
80105e35:	e8 56 cc ff ff       	call   80102a90 <namecmp>
80105e3a:	83 c4 10             	add    $0x10,%esp
80105e3d:	85 c0                	test   %eax,%eax
80105e3f:	0f 84 f8 00 00 00    	je     80105f3d <sys_unlink+0x15d>
80105e45:	83 ec 08             	sub    $0x8,%esp
80105e48:	68 97 89 10 80       	push   $0x80108997
80105e4d:	53                   	push   %ebx
80105e4e:	e8 3d cc ff ff       	call   80102a90 <namecmp>
80105e53:	83 c4 10             	add    $0x10,%esp
80105e56:	85 c0                	test   %eax,%eax
80105e58:	0f 84 df 00 00 00    	je     80105f3d <sys_unlink+0x15d>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105e5e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105e61:	83 ec 04             	sub    $0x4,%esp
80105e64:	50                   	push   %eax
80105e65:	53                   	push   %ebx
80105e66:	56                   	push   %esi
80105e67:	e8 44 cc ff ff       	call   80102ab0 <dirlookup>
80105e6c:	83 c4 10             	add    $0x10,%esp
80105e6f:	85 c0                	test   %eax,%eax
80105e71:	89 c3                	mov    %eax,%ebx
80105e73:	0f 84 c4 00 00 00    	je     80105f3d <sys_unlink+0x15d>
    goto bad;
  ilock(ip);
80105e79:	83 ec 0c             	sub    $0xc,%esp
80105e7c:	50                   	push   %eax
80105e7d:	e8 ce c6 ff ff       	call   80102550 <ilock>

  if(ip->nlink < 1)
80105e82:	83 c4 10             	add    $0x10,%esp
80105e85:	66 83 7b 5a 00       	cmpw   $0x0,0x5a(%ebx)
80105e8a:	0f 8e 1c 01 00 00    	jle    80105fac <sys_unlink+0x1cc>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105e90:	66 83 7b 54 01       	cmpw   $0x1,0x54(%ebx)
80105e95:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105e98:	74 66                	je     80105f00 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80105e9a:	83 ec 04             	sub    $0x4,%esp
80105e9d:	6a 10                	push   $0x10
80105e9f:	6a 00                	push   $0x0
80105ea1:	56                   	push   %esi
80105ea2:	e8 79 f4 ff ff       	call   80105320 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105ea7:	6a 10                	push   $0x10
80105ea9:	ff 75 c4             	pushl  -0x3c(%ebp)
80105eac:	56                   	push   %esi
80105ead:	ff 75 b4             	pushl  -0x4c(%ebp)
80105eb0:	e8 8b ca ff ff       	call   80102940 <writei>
80105eb5:	83 c4 20             	add    $0x20,%esp
80105eb8:	83 f8 10             	cmp    $0x10,%eax
80105ebb:	0f 85 de 00 00 00    	jne    80105f9f <sys_unlink+0x1bf>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105ec1:	66 83 7b 54 01       	cmpw   $0x1,0x54(%ebx)
80105ec6:	0f 84 94 00 00 00    	je     80105f60 <sys_unlink+0x180>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80105ecc:	83 ec 0c             	sub    $0xc,%esp
80105ecf:	ff 75 b4             	pushl  -0x4c(%ebp)
80105ed2:	e8 09 c9 ff ff       	call   801027e0 <iunlockput>

  ip->nlink--;
80105ed7:	66 83 6b 5a 01       	subw   $0x1,0x5a(%ebx)
  iupdate(ip);
80105edc:	89 1c 24             	mov    %ebx,(%esp)
80105edf:	e8 ac c5 ff ff       	call   80102490 <iupdate>
  iunlockput(ip);
80105ee4:	89 1c 24             	mov    %ebx,(%esp)
80105ee7:	e8 f4 c8 ff ff       	call   801027e0 <iunlockput>

  end_op();
80105eec:	e8 df db ff ff       	call   80103ad0 <end_op>

  return 0;
80105ef1:	83 c4 10             	add    $0x10,%esp
80105ef4:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105ef6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ef9:	5b                   	pop    %ebx
80105efa:	5e                   	pop    %esi
80105efb:	5f                   	pop    %edi
80105efc:	5d                   	pop    %ebp
80105efd:	c3                   	ret    
80105efe:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105f00:	83 7b 5c 20          	cmpl   $0x20,0x5c(%ebx)
80105f04:	76 94                	jbe    80105e9a <sys_unlink+0xba>
80105f06:	bf 20 00 00 00       	mov    $0x20,%edi
80105f0b:	eb 0b                	jmp    80105f18 <sys_unlink+0x138>
80105f0d:	8d 76 00             	lea    0x0(%esi),%esi
80105f10:	83 c7 10             	add    $0x10,%edi
80105f13:	3b 7b 5c             	cmp    0x5c(%ebx),%edi
80105f16:	73 82                	jae    80105e9a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105f18:	6a 10                	push   $0x10
80105f1a:	57                   	push   %edi
80105f1b:	56                   	push   %esi
80105f1c:	53                   	push   %ebx
80105f1d:	e8 1e c9 ff ff       	call   80102840 <readi>
80105f22:	83 c4 10             	add    $0x10,%esp
80105f25:	83 f8 10             	cmp    $0x10,%eax
80105f28:	75 68                	jne    80105f92 <sys_unlink+0x1b2>
      panic("isdirempty: readi");
    if(de.inum != 0)
80105f2a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105f2f:	74 df                	je     80105f10 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80105f31:	83 ec 0c             	sub    $0xc,%esp
80105f34:	53                   	push   %ebx
80105f35:	e8 a6 c8 ff ff       	call   801027e0 <iunlockput>
    goto bad;
80105f3a:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105f3d:	83 ec 0c             	sub    $0xc,%esp
80105f40:	ff 75 b4             	pushl  -0x4c(%ebp)
80105f43:	e8 98 c8 ff ff       	call   801027e0 <iunlockput>
  end_op();
80105f48:	e8 83 db ff ff       	call   80103ad0 <end_op>
  return -1;
80105f4d:	83 c4 10             	add    $0x10,%esp
}
80105f50:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80105f53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f58:	5b                   	pop    %ebx
80105f59:	5e                   	pop    %esi
80105f5a:	5f                   	pop    %edi
80105f5b:	5d                   	pop    %ebp
80105f5c:	c3                   	ret    
80105f5d:	8d 76 00             	lea    0x0(%esi),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105f60:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105f63:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105f66:	66 83 68 5a 01       	subw   $0x1,0x5a(%eax)
    iupdate(dp);
80105f6b:	50                   	push   %eax
80105f6c:	e8 1f c5 ff ff       	call   80102490 <iupdate>
80105f71:	83 c4 10             	add    $0x10,%esp
80105f74:	e9 53 ff ff ff       	jmp    80105ecc <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105f79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f7e:	e9 73 ff ff ff       	jmp    80105ef6 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
80105f83:	e8 48 db ff ff       	call   80103ad0 <end_op>
    return -1;
80105f88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f8d:	e9 64 ff ff ff       	jmp    80105ef6 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
80105f92:	83 ec 0c             	sub    $0xc,%esp
80105f95:	68 bc 89 10 80       	push   $0x801089bc
80105f9a:	e8 21 a8 ff ff       	call   801007c0 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105f9f:	83 ec 0c             	sub    $0xc,%esp
80105fa2:	68 ce 89 10 80       	push   $0x801089ce
80105fa7:	e8 14 a8 ff ff       	call   801007c0 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105fac:	83 ec 0c             	sub    $0xc,%esp
80105faf:	68 aa 89 10 80       	push   $0x801089aa
80105fb4:	e8 07 a8 ff ff       	call   801007c0 <panic>
80105fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105fc0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105fc0:	55                   	push   %ebp
80105fc1:	89 e5                	mov    %esp,%ebp
80105fc3:	57                   	push   %edi
80105fc4:	56                   	push   %esi
80105fc5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105fc6:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105fc9:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105fcc:	50                   	push   %eax
80105fcd:	6a 00                	push   $0x0
80105fcf:	e8 0c f7 ff ff       	call   801056e0 <argstr>
80105fd4:	83 c4 10             	add    $0x10,%esp
80105fd7:	85 c0                	test   %eax,%eax
80105fd9:	0f 88 9e 00 00 00    	js     8010607d <sys_open+0xbd>
80105fdf:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105fe2:	83 ec 08             	sub    $0x8,%esp
80105fe5:	50                   	push   %eax
80105fe6:	6a 01                	push   $0x1
80105fe8:	e8 43 f6 ff ff       	call   80105630 <argint>
80105fed:	83 c4 10             	add    $0x10,%esp
80105ff0:	85 c0                	test   %eax,%eax
80105ff2:	0f 88 85 00 00 00    	js     8010607d <sys_open+0xbd>
    return -1;

  begin_op();
80105ff8:	e8 63 da ff ff       	call   80103a60 <begin_op>

  if(omode & O_CREATE){
80105ffd:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106001:	0f 85 89 00 00 00    	jne    80106090 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80106007:	83 ec 0c             	sub    $0xc,%esp
8010600a:	ff 75 e0             	pushl  -0x20(%ebp)
8010600d:	e8 be cd ff ff       	call   80102dd0 <namei>
80106012:	83 c4 10             	add    $0x10,%esp
80106015:	85 c0                	test   %eax,%eax
80106017:	89 c6                	mov    %eax,%esi
80106019:	0f 84 8e 00 00 00    	je     801060ad <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010601f:	83 ec 0c             	sub    $0xc,%esp
80106022:	50                   	push   %eax
80106023:	e8 28 c5 ff ff       	call   80102550 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106028:	83 c4 10             	add    $0x10,%esp
8010602b:	66 83 7e 54 01       	cmpw   $0x1,0x54(%esi)
80106030:	0f 84 d2 00 00 00    	je     80106108 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80106036:	e8 05 bb ff ff       	call   80101b40 <filealloc>
8010603b:	85 c0                	test   %eax,%eax
8010603d:	89 c7                	mov    %eax,%edi
8010603f:	74 2b                	je     8010606c <sys_open+0xac>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106041:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80106043:	e8 48 e6 ff ff       	call   80104690 <myproc>
80106048:	90                   	nop
80106049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80106050:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106054:	85 d2                	test   %edx,%edx
80106056:	74 68                	je     801060c0 <sys_open+0x100>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106058:	83 c3 01             	add    $0x1,%ebx
8010605b:	83 fb 10             	cmp    $0x10,%ebx
8010605e:	75 f0                	jne    80106050 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80106060:	83 ec 0c             	sub    $0xc,%esp
80106063:	57                   	push   %edi
80106064:	e8 97 bb ff ff       	call   80101c00 <fileclose>
80106069:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010606c:	83 ec 0c             	sub    $0xc,%esp
8010606f:	56                   	push   %esi
80106070:	e8 6b c7 ff ff       	call   801027e0 <iunlockput>
    end_op();
80106075:	e8 56 da ff ff       	call   80103ad0 <end_op>
    return -1;
8010607a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010607d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80106080:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80106085:	5b                   	pop    %ebx
80106086:	5e                   	pop    %esi
80106087:	5f                   	pop    %edi
80106088:	5d                   	pop    %ebp
80106089:	c3                   	ret    
8010608a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80106090:	83 ec 0c             	sub    $0xc,%esp
80106093:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106096:	31 c9                	xor    %ecx,%ecx
80106098:	6a 00                	push   $0x0
8010609a:	ba 02 00 00 00       	mov    $0x2,%edx
8010609f:	e8 dc f6 ff ff       	call   80105780 <create>
    if(ip == 0){
801060a4:	83 c4 10             	add    $0x10,%esp
801060a7:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801060a9:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801060ab:	75 89                	jne    80106036 <sys_open+0x76>
      end_op();
801060ad:	e8 1e da ff ff       	call   80103ad0 <end_op>
      return -1;
801060b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060b7:	eb 43                	jmp    801060fc <sys_open+0x13c>
801060b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801060c0:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801060c3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801060c7:	56                   	push   %esi
801060c8:	e8 63 c5 ff ff       	call   80102630 <iunlock>
  end_op();
801060cd:	e8 fe d9 ff ff       	call   80103ad0 <end_op>

  f->type = FD_INODE;
801060d2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801060d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801060db:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
801060de:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801060e1:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801060e8:	89 d0                	mov    %edx,%eax
801060ea:	83 e0 01             	and    $0x1,%eax
801060ed:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801060f0:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801060f3:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801060f6:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
801060fa:	89 d8                	mov    %ebx,%eax
}
801060fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060ff:	5b                   	pop    %ebx
80106100:	5e                   	pop    %esi
80106101:	5f                   	pop    %edi
80106102:	5d                   	pop    %ebp
80106103:	c3                   	ret    
80106104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80106108:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010610b:	85 c9                	test   %ecx,%ecx
8010610d:	0f 84 23 ff ff ff    	je     80106036 <sys_open+0x76>
80106113:	e9 54 ff ff ff       	jmp    8010606c <sys_open+0xac>
80106118:	90                   	nop
80106119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106120 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80106120:	55                   	push   %ebp
80106121:	89 e5                	mov    %esp,%ebp
80106123:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106126:	e8 35 d9 ff ff       	call   80103a60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010612b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010612e:	83 ec 08             	sub    $0x8,%esp
80106131:	50                   	push   %eax
80106132:	6a 00                	push   $0x0
80106134:	e8 a7 f5 ff ff       	call   801056e0 <argstr>
80106139:	83 c4 10             	add    $0x10,%esp
8010613c:	85 c0                	test   %eax,%eax
8010613e:	78 30                	js     80106170 <sys_mkdir+0x50>
80106140:	83 ec 0c             	sub    $0xc,%esp
80106143:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106146:	31 c9                	xor    %ecx,%ecx
80106148:	6a 00                	push   $0x0
8010614a:	ba 01 00 00 00       	mov    $0x1,%edx
8010614f:	e8 2c f6 ff ff       	call   80105780 <create>
80106154:	83 c4 10             	add    $0x10,%esp
80106157:	85 c0                	test   %eax,%eax
80106159:	74 15                	je     80106170 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010615b:	83 ec 0c             	sub    $0xc,%esp
8010615e:	50                   	push   %eax
8010615f:	e8 7c c6 ff ff       	call   801027e0 <iunlockput>
  end_op();
80106164:	e8 67 d9 ff ff       	call   80103ad0 <end_op>
  return 0;
80106169:	83 c4 10             	add    $0x10,%esp
8010616c:	31 c0                	xor    %eax,%eax
}
8010616e:	c9                   	leave  
8010616f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80106170:	e8 5b d9 ff ff       	call   80103ad0 <end_op>
    return -1;
80106175:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010617a:	c9                   	leave  
8010617b:	c3                   	ret    
8010617c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106180 <sys_mknod>:

int
sys_mknod(void)
{
80106180:	55                   	push   %ebp
80106181:	89 e5                	mov    %esp,%ebp
80106183:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106186:	e8 d5 d8 ff ff       	call   80103a60 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010618b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010618e:	83 ec 08             	sub    $0x8,%esp
80106191:	50                   	push   %eax
80106192:	6a 00                	push   $0x0
80106194:	e8 47 f5 ff ff       	call   801056e0 <argstr>
80106199:	83 c4 10             	add    $0x10,%esp
8010619c:	85 c0                	test   %eax,%eax
8010619e:	78 60                	js     80106200 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801061a0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061a3:	83 ec 08             	sub    $0x8,%esp
801061a6:	50                   	push   %eax
801061a7:	6a 01                	push   $0x1
801061a9:	e8 82 f4 ff ff       	call   80105630 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
801061ae:	83 c4 10             	add    $0x10,%esp
801061b1:	85 c0                	test   %eax,%eax
801061b3:	78 4b                	js     80106200 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801061b5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061b8:	83 ec 08             	sub    $0x8,%esp
801061bb:	50                   	push   %eax
801061bc:	6a 02                	push   $0x2
801061be:	e8 6d f4 ff ff       	call   80105630 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801061c3:	83 c4 10             	add    $0x10,%esp
801061c6:	85 c0                	test   %eax,%eax
801061c8:	78 36                	js     80106200 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801061ca:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801061ce:	83 ec 0c             	sub    $0xc,%esp
801061d1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801061d5:	ba 03 00 00 00       	mov    $0x3,%edx
801061da:	50                   	push   %eax
801061db:	8b 45 ec             	mov    -0x14(%ebp),%eax
801061de:	e8 9d f5 ff ff       	call   80105780 <create>
801061e3:	83 c4 10             	add    $0x10,%esp
801061e6:	85 c0                	test   %eax,%eax
801061e8:	74 16                	je     80106200 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
801061ea:	83 ec 0c             	sub    $0xc,%esp
801061ed:	50                   	push   %eax
801061ee:	e8 ed c5 ff ff       	call   801027e0 <iunlockput>
  end_op();
801061f3:	e8 d8 d8 ff ff       	call   80103ad0 <end_op>
  return 0;
801061f8:	83 c4 10             	add    $0x10,%esp
801061fb:	31 c0                	xor    %eax,%eax
}
801061fd:	c9                   	leave  
801061fe:	c3                   	ret    
801061ff:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80106200:	e8 cb d8 ff ff       	call   80103ad0 <end_op>
    return -1;
80106205:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010620a:	c9                   	leave  
8010620b:	c3                   	ret    
8010620c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106210 <sys_chdir>:

int
sys_chdir(void)
{
80106210:	55                   	push   %ebp
80106211:	89 e5                	mov    %esp,%ebp
80106213:	56                   	push   %esi
80106214:	53                   	push   %ebx
80106215:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106218:	e8 73 e4 ff ff       	call   80104690 <myproc>
8010621d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010621f:	e8 3c d8 ff ff       	call   80103a60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106224:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106227:	83 ec 08             	sub    $0x8,%esp
8010622a:	50                   	push   %eax
8010622b:	6a 00                	push   $0x0
8010622d:	e8 ae f4 ff ff       	call   801056e0 <argstr>
80106232:	83 c4 10             	add    $0x10,%esp
80106235:	85 c0                	test   %eax,%eax
80106237:	78 77                	js     801062b0 <sys_chdir+0xa0>
80106239:	83 ec 0c             	sub    $0xc,%esp
8010623c:	ff 75 f4             	pushl  -0xc(%ebp)
8010623f:	e8 8c cb ff ff       	call   80102dd0 <namei>
80106244:	83 c4 10             	add    $0x10,%esp
80106247:	85 c0                	test   %eax,%eax
80106249:	89 c3                	mov    %eax,%ebx
8010624b:	74 63                	je     801062b0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010624d:	83 ec 0c             	sub    $0xc,%esp
80106250:	50                   	push   %eax
80106251:	e8 fa c2 ff ff       	call   80102550 <ilock>
  if(ip->type != T_DIR){
80106256:	83 c4 10             	add    $0x10,%esp
80106259:	66 83 7b 54 01       	cmpw   $0x1,0x54(%ebx)
8010625e:	75 30                	jne    80106290 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106260:	83 ec 0c             	sub    $0xc,%esp
80106263:	53                   	push   %ebx
80106264:	e8 c7 c3 ff ff       	call   80102630 <iunlock>
  iput(curproc->cwd);
80106269:	58                   	pop    %eax
8010626a:	ff 76 68             	pushl  0x68(%esi)
8010626d:	e8 0e c4 ff ff       	call   80102680 <iput>
  end_op();
80106272:	e8 59 d8 ff ff       	call   80103ad0 <end_op>
  curproc->cwd = ip;
80106277:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010627a:	83 c4 10             	add    $0x10,%esp
8010627d:	31 c0                	xor    %eax,%eax
}
8010627f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106282:	5b                   	pop    %ebx
80106283:	5e                   	pop    %esi
80106284:	5d                   	pop    %ebp
80106285:	c3                   	ret    
80106286:	8d 76 00             	lea    0x0(%esi),%esi
80106289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80106290:	83 ec 0c             	sub    $0xc,%esp
80106293:	53                   	push   %ebx
80106294:	e8 47 c5 ff ff       	call   801027e0 <iunlockput>
    end_op();
80106299:	e8 32 d8 ff ff       	call   80103ad0 <end_op>
    return -1;
8010629e:	83 c4 10             	add    $0x10,%esp
801062a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062a6:	eb d7                	jmp    8010627f <sys_chdir+0x6f>
801062a8:	90                   	nop
801062a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
801062b0:	e8 1b d8 ff ff       	call   80103ad0 <end_op>
    return -1;
801062b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062ba:	eb c3                	jmp    8010627f <sys_chdir+0x6f>
801062bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801062c0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
801062c0:	55                   	push   %ebp
801062c1:	89 e5                	mov    %esp,%ebp
801062c3:	57                   	push   %edi
801062c4:	56                   	push   %esi
801062c5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801062c6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
801062cc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801062d2:	50                   	push   %eax
801062d3:	6a 00                	push   $0x0
801062d5:	e8 06 f4 ff ff       	call   801056e0 <argstr>
801062da:	83 c4 10             	add    $0x10,%esp
801062dd:	85 c0                	test   %eax,%eax
801062df:	78 7f                	js     80106360 <sys_exec+0xa0>
801062e1:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801062e7:	83 ec 08             	sub    $0x8,%esp
801062ea:	50                   	push   %eax
801062eb:	6a 01                	push   $0x1
801062ed:	e8 3e f3 ff ff       	call   80105630 <argint>
801062f2:	83 c4 10             	add    $0x10,%esp
801062f5:	85 c0                	test   %eax,%eax
801062f7:	78 67                	js     80106360 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801062f9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801062ff:	83 ec 04             	sub    $0x4,%esp
80106302:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80106308:	68 80 00 00 00       	push   $0x80
8010630d:	6a 00                	push   $0x0
8010630f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106315:	50                   	push   %eax
80106316:	31 db                	xor    %ebx,%ebx
80106318:	e8 03 f0 ff ff       	call   80105320 <memset>
8010631d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106320:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106326:	83 ec 08             	sub    $0x8,%esp
80106329:	57                   	push   %edi
8010632a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010632d:	50                   	push   %eax
8010632e:	e8 5d f2 ff ff       	call   80105590 <fetchint>
80106333:	83 c4 10             	add    $0x10,%esp
80106336:	85 c0                	test   %eax,%eax
80106338:	78 26                	js     80106360 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
8010633a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80106340:	85 c0                	test   %eax,%eax
80106342:	74 2c                	je     80106370 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106344:	83 ec 08             	sub    $0x8,%esp
80106347:	56                   	push   %esi
80106348:	50                   	push   %eax
80106349:	e8 82 f2 ff ff       	call   801055d0 <fetchstr>
8010634e:	83 c4 10             	add    $0x10,%esp
80106351:	85 c0                	test   %eax,%eax
80106353:	78 0b                	js     80106360 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80106355:	83 c3 01             	add    $0x1,%ebx
80106358:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010635b:	83 fb 20             	cmp    $0x20,%ebx
8010635e:	75 c0                	jne    80106320 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80106360:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80106363:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80106368:	5b                   	pop    %ebx
80106369:	5e                   	pop    %esi
8010636a:	5f                   	pop    %edi
8010636b:	5d                   	pop    %ebp
8010636c:	c3                   	ret    
8010636d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106370:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106376:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80106379:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106380:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106384:	50                   	push   %eax
80106385:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010638b:	e8 30 b4 ff ff       	call   801017c0 <exec>
80106390:	83 c4 10             	add    $0x10,%esp
}
80106393:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106396:	5b                   	pop    %ebx
80106397:	5e                   	pop    %esi
80106398:	5f                   	pop    %edi
80106399:	5d                   	pop    %ebp
8010639a:	c3                   	ret    
8010639b:	90                   	nop
8010639c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801063a0 <sys_pipe>:

int
sys_pipe(void)
{
801063a0:	55                   	push   %ebp
801063a1:	89 e5                	mov    %esp,%ebp
801063a3:	57                   	push   %edi
801063a4:	56                   	push   %esi
801063a5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801063a6:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
801063a9:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801063ac:	6a 08                	push   $0x8
801063ae:	50                   	push   %eax
801063af:	6a 00                	push   $0x0
801063b1:	e8 ca f2 ff ff       	call   80105680 <argptr>
801063b6:	83 c4 10             	add    $0x10,%esp
801063b9:	85 c0                	test   %eax,%eax
801063bb:	78 4a                	js     80106407 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801063bd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801063c0:	83 ec 08             	sub    $0x8,%esp
801063c3:	50                   	push   %eax
801063c4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801063c7:	50                   	push   %eax
801063c8:	e8 33 dd ff ff       	call   80104100 <pipealloc>
801063cd:	83 c4 10             	add    $0x10,%esp
801063d0:	85 c0                	test   %eax,%eax
801063d2:	78 33                	js     80106407 <sys_pipe+0x67>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801063d4:	31 db                	xor    %ebx,%ebx
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801063d6:	8b 7d e0             	mov    -0x20(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801063d9:	e8 b2 e2 ff ff       	call   80104690 <myproc>
801063de:	66 90                	xchg   %ax,%ax

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801063e0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801063e4:	85 f6                	test   %esi,%esi
801063e6:	74 30                	je     80106418 <sys_pipe+0x78>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801063e8:	83 c3 01             	add    $0x1,%ebx
801063eb:	83 fb 10             	cmp    $0x10,%ebx
801063ee:	75 f0                	jne    801063e0 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801063f0:	83 ec 0c             	sub    $0xc,%esp
801063f3:	ff 75 e0             	pushl  -0x20(%ebp)
801063f6:	e8 05 b8 ff ff       	call   80101c00 <fileclose>
    fileclose(wf);
801063fb:	58                   	pop    %eax
801063fc:	ff 75 e4             	pushl  -0x1c(%ebp)
801063ff:	e8 fc b7 ff ff       	call   80101c00 <fileclose>
    return -1;
80106404:	83 c4 10             	add    $0x10,%esp
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80106407:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
8010640a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
8010640f:	5b                   	pop    %ebx
80106410:	5e                   	pop    %esi
80106411:	5f                   	pop    %edi
80106412:	5d                   	pop    %ebp
80106413:	c3                   	ret    
80106414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80106418:	8d 73 08             	lea    0x8(%ebx),%esi
8010641b:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010641f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80106422:	e8 69 e2 ff ff       	call   80104690 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80106427:	31 d2                	xor    %edx,%edx
80106429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106430:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106434:	85 c9                	test   %ecx,%ecx
80106436:	74 18                	je     80106450 <sys_pipe+0xb0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106438:	83 c2 01             	add    $0x1,%edx
8010643b:	83 fa 10             	cmp    $0x10,%edx
8010643e:	75 f0                	jne    80106430 <sys_pipe+0x90>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80106440:	e8 4b e2 ff ff       	call   80104690 <myproc>
80106445:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
8010644c:	00 
8010644d:	eb a1                	jmp    801063f0 <sys_pipe+0x50>
8010644f:	90                   	nop
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80106450:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106454:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106457:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106459:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010645c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
8010645f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80106462:	31 c0                	xor    %eax,%eax
}
80106464:	5b                   	pop    %ebx
80106465:	5e                   	pop    %esi
80106466:	5f                   	pop    %edi
80106467:	5d                   	pop    %ebp
80106468:	c3                   	ret    
80106469:	66 90                	xchg   %ax,%ax
8010646b:	66 90                	xchg   %ax,%ax
8010646d:	66 90                	xchg   %ax,%ax
8010646f:	90                   	nop

80106470 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106470:	55                   	push   %ebp
80106471:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106473:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106474:	e9 b7 e3 ff ff       	jmp    80104830 <fork>
80106479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106480 <sys_exit>:
}

int
sys_exit(void)
{
80106480:	55                   	push   %ebp
80106481:	89 e5                	mov    %esp,%ebp
80106483:	83 ec 08             	sub    $0x8,%esp
  exit();
80106486:	e8 35 e6 ff ff       	call   80104ac0 <exit>
  return 0;  // not reached
}
8010648b:	31 c0                	xor    %eax,%eax
8010648d:	c9                   	leave  
8010648e:	c3                   	ret    
8010648f:	90                   	nop

80106490 <sys_wait>:

int
sys_wait(void)
{
80106490:	55                   	push   %ebp
80106491:	89 e5                	mov    %esp,%ebp
  return wait();
}
80106493:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80106494:	e9 67 e8 ff ff       	jmp    80104d00 <wait>
80106499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801064a0 <sys_kill>:
}

int
sys_kill(void)
{
801064a0:	55                   	push   %ebp
801064a1:	89 e5                	mov    %esp,%ebp
801064a3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801064a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064a9:	50                   	push   %eax
801064aa:	6a 00                	push   $0x0
801064ac:	e8 7f f1 ff ff       	call   80105630 <argint>
801064b1:	83 c4 10             	add    $0x10,%esp
801064b4:	85 c0                	test   %eax,%eax
801064b6:	78 18                	js     801064d0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801064b8:	83 ec 0c             	sub    $0xc,%esp
801064bb:	ff 75 f4             	pushl  -0xc(%ebp)
801064be:	e8 8d e9 ff ff       	call   80104e50 <kill>
801064c3:	83 c4 10             	add    $0x10,%esp
}
801064c6:	c9                   	leave  
801064c7:	c3                   	ret    
801064c8:	90                   	nop
801064c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
801064d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
801064d5:	c9                   	leave  
801064d6:	c3                   	ret    
801064d7:	89 f6                	mov    %esi,%esi
801064d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801064e0 <sys_getpid>:

int
sys_getpid(void)
{
801064e0:	55                   	push   %ebp
801064e1:	89 e5                	mov    %esp,%ebp
801064e3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801064e6:	e8 a5 e1 ff ff       	call   80104690 <myproc>
801064eb:	8b 40 10             	mov    0x10(%eax),%eax
}
801064ee:	c9                   	leave  
801064ef:	c3                   	ret    

801064f0 <sys_sbrk>:

int
sys_sbrk(void)
{
801064f0:	55                   	push   %ebp
801064f1:	89 e5                	mov    %esp,%ebp
801064f3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801064f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
801064f7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801064fa:	50                   	push   %eax
801064fb:	6a 00                	push   $0x0
801064fd:	e8 2e f1 ff ff       	call   80105630 <argint>
80106502:	83 c4 10             	add    $0x10,%esp
80106505:	85 c0                	test   %eax,%eax
80106507:	78 27                	js     80106530 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106509:	e8 82 e1 ff ff       	call   80104690 <myproc>
  if(growproc(n) < 0)
8010650e:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
80106511:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106513:	ff 75 f4             	pushl  -0xc(%ebp)
80106516:	e8 95 e2 ff ff       	call   801047b0 <growproc>
8010651b:	83 c4 10             	add    $0x10,%esp
8010651e:	85 c0                	test   %eax,%eax
80106520:	78 0e                	js     80106530 <sys_sbrk+0x40>
    return -1;
  return addr;
80106522:	89 d8                	mov    %ebx,%eax
}
80106524:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106527:	c9                   	leave  
80106528:	c3                   	ret    
80106529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80106530:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106535:	eb ed                	jmp    80106524 <sys_sbrk+0x34>
80106537:	89 f6                	mov    %esi,%esi
80106539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106540 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80106540:	55                   	push   %ebp
80106541:	89 e5                	mov    %esp,%ebp
80106543:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106544:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80106547:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010654a:	50                   	push   %eax
8010654b:	6a 00                	push   $0x0
8010654d:	e8 de f0 ff ff       	call   80105630 <argint>
80106552:	83 c4 10             	add    $0x10,%esp
80106555:	85 c0                	test   %eax,%eax
80106557:	0f 88 8a 00 00 00    	js     801065e7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010655d:	83 ec 0c             	sub    $0xc,%esp
80106560:	68 00 70 12 80       	push   $0x80127000
80106565:	e8 46 ec ff ff       	call   801051b0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010656a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010656d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80106570:	8b 1d 40 78 12 80    	mov    0x80127840,%ebx
  while(ticks - ticks0 < n){
80106576:	85 d2                	test   %edx,%edx
80106578:	75 27                	jne    801065a1 <sys_sleep+0x61>
8010657a:	eb 54                	jmp    801065d0 <sys_sleep+0x90>
8010657c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106580:	83 ec 08             	sub    $0x8,%esp
80106583:	68 00 70 12 80       	push   $0x80127000
80106588:	68 40 78 12 80       	push   $0x80127840
8010658d:	e8 ae e6 ff ff       	call   80104c40 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106592:	a1 40 78 12 80       	mov    0x80127840,%eax
80106597:	83 c4 10             	add    $0x10,%esp
8010659a:	29 d8                	sub    %ebx,%eax
8010659c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010659f:	73 2f                	jae    801065d0 <sys_sleep+0x90>
    if(myproc()->killed){
801065a1:	e8 ea e0 ff ff       	call   80104690 <myproc>
801065a6:	8b 40 24             	mov    0x24(%eax),%eax
801065a9:	85 c0                	test   %eax,%eax
801065ab:	74 d3                	je     80106580 <sys_sleep+0x40>
      release(&tickslock);
801065ad:	83 ec 0c             	sub    $0xc,%esp
801065b0:	68 00 70 12 80       	push   $0x80127000
801065b5:	e8 16 ed ff ff       	call   801052d0 <release>
      return -1;
801065ba:	83 c4 10             	add    $0x10,%esp
801065bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
801065c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801065c5:	c9                   	leave  
801065c6:	c3                   	ret    
801065c7:	89 f6                	mov    %esi,%esi
801065c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801065d0:	83 ec 0c             	sub    $0xc,%esp
801065d3:	68 00 70 12 80       	push   $0x80127000
801065d8:	e8 f3 ec ff ff       	call   801052d0 <release>
  return 0;
801065dd:	83 c4 10             	add    $0x10,%esp
801065e0:	31 c0                	xor    %eax,%eax
}
801065e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801065e5:	c9                   	leave  
801065e6:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
801065e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065ec:	eb d4                	jmp    801065c2 <sys_sleep+0x82>
801065ee:	66 90                	xchg   %ax,%ax

801065f0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801065f0:	55                   	push   %ebp
801065f1:	89 e5                	mov    %esp,%ebp
801065f3:	53                   	push   %ebx
801065f4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801065f7:	68 00 70 12 80       	push   $0x80127000
801065fc:	e8 af eb ff ff       	call   801051b0 <acquire>
  xticks = ticks;
80106601:	8b 1d 40 78 12 80    	mov    0x80127840,%ebx
  release(&tickslock);
80106607:	c7 04 24 00 70 12 80 	movl   $0x80127000,(%esp)
8010660e:	e8 bd ec ff ff       	call   801052d0 <release>
  return xticks;
}
80106613:	89 d8                	mov    %ebx,%eax
80106615:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106618:	c9                   	leave  
80106619:	c3                   	ret    

8010661a <alltraps>:
8010661a:	1e                   	push   %ds
8010661b:	06                   	push   %es
8010661c:	0f a0                	push   %fs
8010661e:	0f a8                	push   %gs
80106620:	60                   	pusha  
80106621:	66 b8 10 00          	mov    $0x10,%ax
80106625:	8e d8                	mov    %eax,%ds
80106627:	8e c0                	mov    %eax,%es
80106629:	54                   	push   %esp
8010662a:	e8 e1 00 00 00       	call   80106710 <trap>
8010662f:	83 c4 04             	add    $0x4,%esp

80106632 <trapret>:
80106632:	61                   	popa   
80106633:	0f a9                	pop    %gs
80106635:	0f a1                	pop    %fs
80106637:	07                   	pop    %es
80106638:	1f                   	pop    %ds
80106639:	83 c4 08             	add    $0x8,%esp
8010663c:	cf                   	iret   
8010663d:	66 90                	xchg   %ax,%ax
8010663f:	90                   	nop

80106640 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106640:	31 c0                	xor    %eax,%eax
80106642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106648:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
8010664f:	b9 08 00 00 00       	mov    $0x8,%ecx
80106654:	c6 04 c5 44 70 12 80 	movb   $0x0,-0x7fed8fbc(,%eax,8)
8010665b:	00 
8010665c:	66 89 0c c5 42 70 12 	mov    %cx,-0x7fed8fbe(,%eax,8)
80106663:	80 
80106664:	c6 04 c5 45 70 12 80 	movb   $0x8e,-0x7fed8fbb(,%eax,8)
8010666b:	8e 
8010666c:	66 89 14 c5 40 70 12 	mov    %dx,-0x7fed8fc0(,%eax,8)
80106673:	80 
80106674:	c1 ea 10             	shr    $0x10,%edx
80106677:	66 89 14 c5 46 70 12 	mov    %dx,-0x7fed8fba(,%eax,8)
8010667e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010667f:	83 c0 01             	add    $0x1,%eax
80106682:	3d 00 01 00 00       	cmp    $0x100,%eax
80106687:	75 bf                	jne    80106648 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106689:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010668a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010668f:	89 e5                	mov    %esp,%ebp
80106691:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106694:	a1 08 b1 10 80       	mov    0x8010b108,%eax

  initlock(&tickslock, "time");
80106699:	68 dd 89 10 80       	push   $0x801089dd
8010669e:	68 00 70 12 80       	push   $0x80127000
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801066a3:	66 89 15 42 72 12 80 	mov    %dx,0x80127242
801066aa:	c6 05 44 72 12 80 00 	movb   $0x0,0x80127244
801066b1:	66 a3 40 72 12 80    	mov    %ax,0x80127240
801066b7:	c1 e8 10             	shr    $0x10,%eax
801066ba:	c6 05 45 72 12 80 ef 	movb   $0xef,0x80127245
801066c1:	66 a3 46 72 12 80    	mov    %ax,0x80127246

  initlock(&tickslock, "time");
801066c7:	e8 e4 e9 ff ff       	call   801050b0 <initlock>
}
801066cc:	83 c4 10             	add    $0x10,%esp
801066cf:	c9                   	leave  
801066d0:	c3                   	ret    
801066d1:	eb 0d                	jmp    801066e0 <idtinit>
801066d3:	90                   	nop
801066d4:	90                   	nop
801066d5:	90                   	nop
801066d6:	90                   	nop
801066d7:	90                   	nop
801066d8:	90                   	nop
801066d9:	90                   	nop
801066da:	90                   	nop
801066db:	90                   	nop
801066dc:	90                   	nop
801066dd:	90                   	nop
801066de:	90                   	nop
801066df:	90                   	nop

801066e0 <idtinit>:

void
idtinit(void)
{
801066e0:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
801066e1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801066e6:	89 e5                	mov    %esp,%ebp
801066e8:	83 ec 10             	sub    $0x10,%esp
801066eb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801066ef:	b8 40 70 12 80       	mov    $0x80127040,%eax
801066f4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801066f8:	c1 e8 10             	shr    $0x10,%eax
801066fb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801066ff:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106702:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106705:	c9                   	leave  
80106706:	c3                   	ret    
80106707:	89 f6                	mov    %esi,%esi
80106709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106710 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106710:	55                   	push   %ebp
80106711:	89 e5                	mov    %esp,%ebp
80106713:	57                   	push   %edi
80106714:	56                   	push   %esi
80106715:	53                   	push   %ebx
80106716:	83 ec 1c             	sub    $0x1c,%esp
80106719:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
8010671c:	8b 47 30             	mov    0x30(%edi),%eax
8010671f:	83 f8 40             	cmp    $0x40,%eax
80106722:	0f 84 88 01 00 00    	je     801068b0 <trap+0x1a0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106728:	83 e8 20             	sub    $0x20,%eax
8010672b:	83 f8 1f             	cmp    $0x1f,%eax
8010672e:	77 10                	ja     80106740 <trap+0x30>
80106730:	ff 24 85 84 8a 10 80 	jmp    *-0x7fef757c(,%eax,4)
80106737:	89 f6                	mov    %esi,%esi
80106739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106740:	e8 4b df ff ff       	call   80104690 <myproc>
80106745:	85 c0                	test   %eax,%eax
80106747:	0f 84 d7 01 00 00    	je     80106924 <trap+0x214>
8010674d:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
80106751:	0f 84 cd 01 00 00    	je     80106924 <trap+0x214>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106757:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010675a:	8b 57 38             	mov    0x38(%edi),%edx
8010675d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80106760:	89 55 dc             	mov    %edx,-0x24(%ebp)
80106763:	e8 08 df ff ff       	call   80104670 <cpuid>
80106768:	8b 77 34             	mov    0x34(%edi),%esi
8010676b:	8b 5f 30             	mov    0x30(%edi),%ebx
8010676e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106771:	e8 1a df ff ff       	call   80104690 <myproc>
80106776:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106779:	e8 12 df ff ff       	call   80104690 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010677e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106781:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106784:	51                   	push   %ecx
80106785:	52                   	push   %edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106786:	8b 55 e0             	mov    -0x20(%ebp),%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106789:	ff 75 e4             	pushl  -0x1c(%ebp)
8010678c:	56                   	push   %esi
8010678d:	53                   	push   %ebx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010678e:	83 c2 6c             	add    $0x6c,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106791:	52                   	push   %edx
80106792:	ff 70 10             	pushl  0x10(%eax)
80106795:	68 40 8a 10 80       	push   $0x80108a40
8010679a:	e8 91 9e ff ff       	call   80100630 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010679f:	83 c4 20             	add    $0x20,%esp
801067a2:	e8 e9 de ff ff       	call   80104690 <myproc>
801067a7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
801067ae:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801067b0:	e8 db de ff ff       	call   80104690 <myproc>
801067b5:	85 c0                	test   %eax,%eax
801067b7:	74 0c                	je     801067c5 <trap+0xb5>
801067b9:	e8 d2 de ff ff       	call   80104690 <myproc>
801067be:	8b 50 24             	mov    0x24(%eax),%edx
801067c1:	85 d2                	test   %edx,%edx
801067c3:	75 4b                	jne    80106810 <trap+0x100>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801067c5:	e8 c6 de ff ff       	call   80104690 <myproc>
801067ca:	85 c0                	test   %eax,%eax
801067cc:	74 0b                	je     801067d9 <trap+0xc9>
801067ce:	e8 bd de ff ff       	call   80104690 <myproc>
801067d3:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801067d7:	74 4f                	je     80106828 <trap+0x118>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801067d9:	e8 b2 de ff ff       	call   80104690 <myproc>
801067de:	85 c0                	test   %eax,%eax
801067e0:	74 1d                	je     801067ff <trap+0xef>
801067e2:	e8 a9 de ff ff       	call   80104690 <myproc>
801067e7:	8b 40 24             	mov    0x24(%eax),%eax
801067ea:	85 c0                	test   %eax,%eax
801067ec:	74 11                	je     801067ff <trap+0xef>
801067ee:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
801067f2:	83 e0 03             	and    $0x3,%eax
801067f5:	66 83 f8 03          	cmp    $0x3,%ax
801067f9:	0f 84 da 00 00 00    	je     801068d9 <trap+0x1c9>
    exit();
}
801067ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106802:	5b                   	pop    %ebx
80106803:	5e                   	pop    %esi
80106804:	5f                   	pop    %edi
80106805:	5d                   	pop    %ebp
80106806:	c3                   	ret    
80106807:	89 f6                	mov    %esi,%esi
80106809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106810:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106814:	83 e0 03             	and    $0x3,%eax
80106817:	66 83 f8 03          	cmp    $0x3,%ax
8010681b:	75 a8                	jne    801067c5 <trap+0xb5>
    exit();
8010681d:	e8 9e e2 ff ff       	call   80104ac0 <exit>
80106822:	eb a1                	jmp    801067c5 <trap+0xb5>
80106824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106828:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
8010682c:	75 ab                	jne    801067d9 <trap+0xc9>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
8010682e:	e8 bd e3 ff ff       	call   80104bf0 <yield>
80106833:	eb a4                	jmp    801067d9 <trap+0xc9>
80106835:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80106838:	e8 33 de ff ff       	call   80104670 <cpuid>
8010683d:	85 c0                	test   %eax,%eax
8010683f:	0f 84 ab 00 00 00    	je     801068f0 <trap+0x1e0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80106845:	e8 d6 cd ff ff       	call   80103620 <lapiceoi>
    break;
8010684a:	e9 61 ff ff ff       	jmp    801067b0 <trap+0xa0>
8010684f:	90                   	nop
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106850:	e8 8b cc ff ff       	call   801034e0 <kbdintr>
    lapiceoi();
80106855:	e8 c6 cd ff ff       	call   80103620 <lapiceoi>
    break;
8010685a:	e9 51 ff ff ff       	jmp    801067b0 <trap+0xa0>
8010685f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106860:	e8 5b 02 00 00       	call   80106ac0 <uartintr>
    lapiceoi();
80106865:	e8 b6 cd ff ff       	call   80103620 <lapiceoi>
    break;
8010686a:	e9 41 ff ff ff       	jmp    801067b0 <trap+0xa0>
8010686f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106870:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
80106874:	8b 77 38             	mov    0x38(%edi),%esi
80106877:	e8 f4 dd ff ff       	call   80104670 <cpuid>
8010687c:	56                   	push   %esi
8010687d:	53                   	push   %ebx
8010687e:	50                   	push   %eax
8010687f:	68 e8 89 10 80       	push   $0x801089e8
80106884:	e8 a7 9d ff ff       	call   80100630 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80106889:	e8 92 cd ff ff       	call   80103620 <lapiceoi>
    break;
8010688e:	83 c4 10             	add    $0x10,%esp
80106891:	e9 1a ff ff ff       	jmp    801067b0 <trap+0xa0>
80106896:	8d 76 00             	lea    0x0(%esi),%esi
80106899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801068a0:	e8 bb c6 ff ff       	call   80102f60 <ideintr>
801068a5:	eb 9e                	jmp    80106845 <trap+0x135>
801068a7:	89 f6                	mov    %esi,%esi
801068a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
801068b0:	e8 db dd ff ff       	call   80104690 <myproc>
801068b5:	8b 58 24             	mov    0x24(%eax),%ebx
801068b8:	85 db                	test   %ebx,%ebx
801068ba:	75 2c                	jne    801068e8 <trap+0x1d8>
      exit();
    myproc()->tf = tf;
801068bc:	e8 cf dd ff ff       	call   80104690 <myproc>
801068c1:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801068c4:	e8 57 ee ff ff       	call   80105720 <syscall>
    if(myproc()->killed)
801068c9:	e8 c2 dd ff ff       	call   80104690 <myproc>
801068ce:	8b 48 24             	mov    0x24(%eax),%ecx
801068d1:	85 c9                	test   %ecx,%ecx
801068d3:	0f 84 26 ff ff ff    	je     801067ff <trap+0xef>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
801068d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068dc:	5b                   	pop    %ebx
801068dd:	5e                   	pop    %esi
801068de:	5f                   	pop    %edi
801068df:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
801068e0:	e9 db e1 ff ff       	jmp    80104ac0 <exit>
801068e5:	8d 76 00             	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
801068e8:	e8 d3 e1 ff ff       	call   80104ac0 <exit>
801068ed:	eb cd                	jmp    801068bc <trap+0x1ac>
801068ef:	90                   	nop
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
801068f0:	83 ec 0c             	sub    $0xc,%esp
801068f3:	68 00 70 12 80       	push   $0x80127000
801068f8:	e8 b3 e8 ff ff       	call   801051b0 <acquire>
      ticks++;
      wakeup(&ticks);
801068fd:	c7 04 24 40 78 12 80 	movl   $0x80127840,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80106904:	83 05 40 78 12 80 01 	addl   $0x1,0x80127840
      wakeup(&ticks);
8010690b:	e8 e0 e4 ff ff       	call   80104df0 <wakeup>
      release(&tickslock);
80106910:	c7 04 24 00 70 12 80 	movl   $0x80127000,(%esp)
80106917:	e8 b4 e9 ff ff       	call   801052d0 <release>
8010691c:	83 c4 10             	add    $0x10,%esp
8010691f:	e9 21 ff ff ff       	jmp    80106845 <trap+0x135>
80106924:	0f 20 d6             	mov    %cr2,%esi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106927:	8b 5f 38             	mov    0x38(%edi),%ebx
8010692a:	e8 41 dd ff ff       	call   80104670 <cpuid>
8010692f:	83 ec 0c             	sub    $0xc,%esp
80106932:	56                   	push   %esi
80106933:	53                   	push   %ebx
80106934:	50                   	push   %eax
80106935:	ff 77 30             	pushl  0x30(%edi)
80106938:	68 0c 8a 10 80       	push   $0x80108a0c
8010693d:	e8 ee 9c ff ff       	call   80100630 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80106942:	83 c4 14             	add    $0x14,%esp
80106945:	68 e2 89 10 80       	push   $0x801089e2
8010694a:	e8 71 9e ff ff       	call   801007c0 <panic>
8010694f:	90                   	nop

80106950 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106950:	a1 00 b6 10 80       	mov    0x8010b600,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80106955:	55                   	push   %ebp
80106956:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106958:	85 c0                	test   %eax,%eax
8010695a:	74 1c                	je     80106978 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010695c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106961:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106962:	a8 01                	test   $0x1,%al
80106964:	74 12                	je     80106978 <uartgetc+0x28>
80106966:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010696b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010696c:	0f b6 c0             	movzbl %al,%eax
}
8010696f:	5d                   	pop    %ebp
80106970:	c3                   	ret    
80106971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80106978:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
8010697d:	5d                   	pop    %ebp
8010697e:	c3                   	ret    
8010697f:	90                   	nop

80106980 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80106980:	55                   	push   %ebp
80106981:	89 e5                	mov    %esp,%ebp
80106983:	57                   	push   %edi
80106984:	56                   	push   %esi
80106985:	53                   	push   %ebx
80106986:	89 c7                	mov    %eax,%edi
80106988:	bb 80 00 00 00       	mov    $0x80,%ebx
8010698d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106992:	83 ec 0c             	sub    $0xc,%esp
80106995:	eb 1b                	jmp    801069b2 <uartputc.part.0+0x32>
80106997:	89 f6                	mov    %esi,%esi
80106999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
801069a0:	83 ec 0c             	sub    $0xc,%esp
801069a3:	6a 0a                	push   $0xa
801069a5:	e8 96 cc ff ff       	call   80103640 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801069aa:	83 c4 10             	add    $0x10,%esp
801069ad:	83 eb 01             	sub    $0x1,%ebx
801069b0:	74 07                	je     801069b9 <uartputc.part.0+0x39>
801069b2:	89 f2                	mov    %esi,%edx
801069b4:	ec                   	in     (%dx),%al
801069b5:	a8 20                	test   $0x20,%al
801069b7:	74 e7                	je     801069a0 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801069b9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801069be:	89 f8                	mov    %edi,%eax
801069c0:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
801069c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069c4:	5b                   	pop    %ebx
801069c5:	5e                   	pop    %esi
801069c6:	5f                   	pop    %edi
801069c7:	5d                   	pop    %ebp
801069c8:	c3                   	ret    
801069c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801069d0 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801069d0:	55                   	push   %ebp
801069d1:	31 c9                	xor    %ecx,%ecx
801069d3:	89 c8                	mov    %ecx,%eax
801069d5:	89 e5                	mov    %esp,%ebp
801069d7:	57                   	push   %edi
801069d8:	56                   	push   %esi
801069d9:	53                   	push   %ebx
801069da:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801069df:	89 da                	mov    %ebx,%edx
801069e1:	83 ec 0c             	sub    $0xc,%esp
801069e4:	ee                   	out    %al,(%dx)
801069e5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801069ea:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801069ef:	89 fa                	mov    %edi,%edx
801069f1:	ee                   	out    %al,(%dx)
801069f2:	b8 0c 00 00 00       	mov    $0xc,%eax
801069f7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801069fc:	ee                   	out    %al,(%dx)
801069fd:	be f9 03 00 00       	mov    $0x3f9,%esi
80106a02:	89 c8                	mov    %ecx,%eax
80106a04:	89 f2                	mov    %esi,%edx
80106a06:	ee                   	out    %al,(%dx)
80106a07:	b8 03 00 00 00       	mov    $0x3,%eax
80106a0c:	89 fa                	mov    %edi,%edx
80106a0e:	ee                   	out    %al,(%dx)
80106a0f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106a14:	89 c8                	mov    %ecx,%eax
80106a16:	ee                   	out    %al,(%dx)
80106a17:	b8 01 00 00 00       	mov    $0x1,%eax
80106a1c:	89 f2                	mov    %esi,%edx
80106a1e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106a1f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106a24:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106a25:	3c ff                	cmp    $0xff,%al
80106a27:	74 5a                	je     80106a83 <uartinit+0xb3>
    return;
  uart = 1;
80106a29:	c7 05 00 b6 10 80 01 	movl   $0x1,0x8010b600
80106a30:	00 00 00 
80106a33:	89 da                	mov    %ebx,%edx
80106a35:	ec                   	in     (%dx),%al
80106a36:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106a3b:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80106a3c:	83 ec 08             	sub    $0x8,%esp
80106a3f:	bb 04 8b 10 80       	mov    $0x80108b04,%ebx
80106a44:	6a 00                	push   $0x0
80106a46:	6a 04                	push   $0x4
80106a48:	e8 63 c7 ff ff       	call   801031b0 <ioapicenable>
80106a4d:	83 c4 10             	add    $0x10,%esp
80106a50:	b8 78 00 00 00       	mov    $0x78,%eax
80106a55:	eb 13                	jmp    80106a6a <uartinit+0x9a>
80106a57:	89 f6                	mov    %esi,%esi
80106a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106a60:	83 c3 01             	add    $0x1,%ebx
80106a63:	0f be 03             	movsbl (%ebx),%eax
80106a66:	84 c0                	test   %al,%al
80106a68:	74 19                	je     80106a83 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80106a6a:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
80106a70:	85 d2                	test   %edx,%edx
80106a72:	74 ec                	je     80106a60 <uartinit+0x90>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106a74:	83 c3 01             	add    $0x1,%ebx
80106a77:	e8 04 ff ff ff       	call   80106980 <uartputc.part.0>
80106a7c:	0f be 03             	movsbl (%ebx),%eax
80106a7f:	84 c0                	test   %al,%al
80106a81:	75 e7                	jne    80106a6a <uartinit+0x9a>
    uartputc(*p);
}
80106a83:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a86:	5b                   	pop    %ebx
80106a87:	5e                   	pop    %esi
80106a88:	5f                   	pop    %edi
80106a89:	5d                   	pop    %ebp
80106a8a:	c3                   	ret    
80106a8b:	90                   	nop
80106a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106a90 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80106a90:	8b 15 00 b6 10 80    	mov    0x8010b600,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80106a96:	55                   	push   %ebp
80106a97:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80106a99:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80106a9b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80106a9e:	74 10                	je     80106ab0 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106aa0:	5d                   	pop    %ebp
80106aa1:	e9 da fe ff ff       	jmp    80106980 <uartputc.part.0>
80106aa6:	8d 76 00             	lea    0x0(%esi),%esi
80106aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106ab0:	5d                   	pop    %ebp
80106ab1:	c3                   	ret    
80106ab2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ac0 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80106ac0:	55                   	push   %ebp
80106ac1:	89 e5                	mov    %esp,%ebp
80106ac3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106ac6:	68 50 69 10 80       	push   $0x80106950
80106acb:	e8 d0 a6 ff ff       	call   801011a0 <consoleintr>
}
80106ad0:	83 c4 10             	add    $0x10,%esp
80106ad3:	c9                   	leave  
80106ad4:	c3                   	ret    

80106ad5 <vector0>:
80106ad5:	6a 00                	push   $0x0
80106ad7:	6a 00                	push   $0x0
80106ad9:	e9 3c fb ff ff       	jmp    8010661a <alltraps>

80106ade <vector1>:
80106ade:	6a 00                	push   $0x0
80106ae0:	6a 01                	push   $0x1
80106ae2:	e9 33 fb ff ff       	jmp    8010661a <alltraps>

80106ae7 <vector2>:
80106ae7:	6a 00                	push   $0x0
80106ae9:	6a 02                	push   $0x2
80106aeb:	e9 2a fb ff ff       	jmp    8010661a <alltraps>

80106af0 <vector3>:
80106af0:	6a 00                	push   $0x0
80106af2:	6a 03                	push   $0x3
80106af4:	e9 21 fb ff ff       	jmp    8010661a <alltraps>

80106af9 <vector4>:
80106af9:	6a 00                	push   $0x0
80106afb:	6a 04                	push   $0x4
80106afd:	e9 18 fb ff ff       	jmp    8010661a <alltraps>

80106b02 <vector5>:
80106b02:	6a 00                	push   $0x0
80106b04:	6a 05                	push   $0x5
80106b06:	e9 0f fb ff ff       	jmp    8010661a <alltraps>

80106b0b <vector6>:
80106b0b:	6a 00                	push   $0x0
80106b0d:	6a 06                	push   $0x6
80106b0f:	e9 06 fb ff ff       	jmp    8010661a <alltraps>

80106b14 <vector7>:
80106b14:	6a 00                	push   $0x0
80106b16:	6a 07                	push   $0x7
80106b18:	e9 fd fa ff ff       	jmp    8010661a <alltraps>

80106b1d <vector8>:
80106b1d:	6a 08                	push   $0x8
80106b1f:	e9 f6 fa ff ff       	jmp    8010661a <alltraps>

80106b24 <vector9>:
80106b24:	6a 00                	push   $0x0
80106b26:	6a 09                	push   $0x9
80106b28:	e9 ed fa ff ff       	jmp    8010661a <alltraps>

80106b2d <vector10>:
80106b2d:	6a 0a                	push   $0xa
80106b2f:	e9 e6 fa ff ff       	jmp    8010661a <alltraps>

80106b34 <vector11>:
80106b34:	6a 0b                	push   $0xb
80106b36:	e9 df fa ff ff       	jmp    8010661a <alltraps>

80106b3b <vector12>:
80106b3b:	6a 0c                	push   $0xc
80106b3d:	e9 d8 fa ff ff       	jmp    8010661a <alltraps>

80106b42 <vector13>:
80106b42:	6a 0d                	push   $0xd
80106b44:	e9 d1 fa ff ff       	jmp    8010661a <alltraps>

80106b49 <vector14>:
80106b49:	6a 0e                	push   $0xe
80106b4b:	e9 ca fa ff ff       	jmp    8010661a <alltraps>

80106b50 <vector15>:
80106b50:	6a 00                	push   $0x0
80106b52:	6a 0f                	push   $0xf
80106b54:	e9 c1 fa ff ff       	jmp    8010661a <alltraps>

80106b59 <vector16>:
80106b59:	6a 00                	push   $0x0
80106b5b:	6a 10                	push   $0x10
80106b5d:	e9 b8 fa ff ff       	jmp    8010661a <alltraps>

80106b62 <vector17>:
80106b62:	6a 11                	push   $0x11
80106b64:	e9 b1 fa ff ff       	jmp    8010661a <alltraps>

80106b69 <vector18>:
80106b69:	6a 00                	push   $0x0
80106b6b:	6a 12                	push   $0x12
80106b6d:	e9 a8 fa ff ff       	jmp    8010661a <alltraps>

80106b72 <vector19>:
80106b72:	6a 00                	push   $0x0
80106b74:	6a 13                	push   $0x13
80106b76:	e9 9f fa ff ff       	jmp    8010661a <alltraps>

80106b7b <vector20>:
80106b7b:	6a 00                	push   $0x0
80106b7d:	6a 14                	push   $0x14
80106b7f:	e9 96 fa ff ff       	jmp    8010661a <alltraps>

80106b84 <vector21>:
80106b84:	6a 00                	push   $0x0
80106b86:	6a 15                	push   $0x15
80106b88:	e9 8d fa ff ff       	jmp    8010661a <alltraps>

80106b8d <vector22>:
80106b8d:	6a 00                	push   $0x0
80106b8f:	6a 16                	push   $0x16
80106b91:	e9 84 fa ff ff       	jmp    8010661a <alltraps>

80106b96 <vector23>:
80106b96:	6a 00                	push   $0x0
80106b98:	6a 17                	push   $0x17
80106b9a:	e9 7b fa ff ff       	jmp    8010661a <alltraps>

80106b9f <vector24>:
80106b9f:	6a 00                	push   $0x0
80106ba1:	6a 18                	push   $0x18
80106ba3:	e9 72 fa ff ff       	jmp    8010661a <alltraps>

80106ba8 <vector25>:
80106ba8:	6a 00                	push   $0x0
80106baa:	6a 19                	push   $0x19
80106bac:	e9 69 fa ff ff       	jmp    8010661a <alltraps>

80106bb1 <vector26>:
80106bb1:	6a 00                	push   $0x0
80106bb3:	6a 1a                	push   $0x1a
80106bb5:	e9 60 fa ff ff       	jmp    8010661a <alltraps>

80106bba <vector27>:
80106bba:	6a 00                	push   $0x0
80106bbc:	6a 1b                	push   $0x1b
80106bbe:	e9 57 fa ff ff       	jmp    8010661a <alltraps>

80106bc3 <vector28>:
80106bc3:	6a 00                	push   $0x0
80106bc5:	6a 1c                	push   $0x1c
80106bc7:	e9 4e fa ff ff       	jmp    8010661a <alltraps>

80106bcc <vector29>:
80106bcc:	6a 00                	push   $0x0
80106bce:	6a 1d                	push   $0x1d
80106bd0:	e9 45 fa ff ff       	jmp    8010661a <alltraps>

80106bd5 <vector30>:
80106bd5:	6a 00                	push   $0x0
80106bd7:	6a 1e                	push   $0x1e
80106bd9:	e9 3c fa ff ff       	jmp    8010661a <alltraps>

80106bde <vector31>:
80106bde:	6a 00                	push   $0x0
80106be0:	6a 1f                	push   $0x1f
80106be2:	e9 33 fa ff ff       	jmp    8010661a <alltraps>

80106be7 <vector32>:
80106be7:	6a 00                	push   $0x0
80106be9:	6a 20                	push   $0x20
80106beb:	e9 2a fa ff ff       	jmp    8010661a <alltraps>

80106bf0 <vector33>:
80106bf0:	6a 00                	push   $0x0
80106bf2:	6a 21                	push   $0x21
80106bf4:	e9 21 fa ff ff       	jmp    8010661a <alltraps>

80106bf9 <vector34>:
80106bf9:	6a 00                	push   $0x0
80106bfb:	6a 22                	push   $0x22
80106bfd:	e9 18 fa ff ff       	jmp    8010661a <alltraps>

80106c02 <vector35>:
80106c02:	6a 00                	push   $0x0
80106c04:	6a 23                	push   $0x23
80106c06:	e9 0f fa ff ff       	jmp    8010661a <alltraps>

80106c0b <vector36>:
80106c0b:	6a 00                	push   $0x0
80106c0d:	6a 24                	push   $0x24
80106c0f:	e9 06 fa ff ff       	jmp    8010661a <alltraps>

80106c14 <vector37>:
80106c14:	6a 00                	push   $0x0
80106c16:	6a 25                	push   $0x25
80106c18:	e9 fd f9 ff ff       	jmp    8010661a <alltraps>

80106c1d <vector38>:
80106c1d:	6a 00                	push   $0x0
80106c1f:	6a 26                	push   $0x26
80106c21:	e9 f4 f9 ff ff       	jmp    8010661a <alltraps>

80106c26 <vector39>:
80106c26:	6a 00                	push   $0x0
80106c28:	6a 27                	push   $0x27
80106c2a:	e9 eb f9 ff ff       	jmp    8010661a <alltraps>

80106c2f <vector40>:
80106c2f:	6a 00                	push   $0x0
80106c31:	6a 28                	push   $0x28
80106c33:	e9 e2 f9 ff ff       	jmp    8010661a <alltraps>

80106c38 <vector41>:
80106c38:	6a 00                	push   $0x0
80106c3a:	6a 29                	push   $0x29
80106c3c:	e9 d9 f9 ff ff       	jmp    8010661a <alltraps>

80106c41 <vector42>:
80106c41:	6a 00                	push   $0x0
80106c43:	6a 2a                	push   $0x2a
80106c45:	e9 d0 f9 ff ff       	jmp    8010661a <alltraps>

80106c4a <vector43>:
80106c4a:	6a 00                	push   $0x0
80106c4c:	6a 2b                	push   $0x2b
80106c4e:	e9 c7 f9 ff ff       	jmp    8010661a <alltraps>

80106c53 <vector44>:
80106c53:	6a 00                	push   $0x0
80106c55:	6a 2c                	push   $0x2c
80106c57:	e9 be f9 ff ff       	jmp    8010661a <alltraps>

80106c5c <vector45>:
80106c5c:	6a 00                	push   $0x0
80106c5e:	6a 2d                	push   $0x2d
80106c60:	e9 b5 f9 ff ff       	jmp    8010661a <alltraps>

80106c65 <vector46>:
80106c65:	6a 00                	push   $0x0
80106c67:	6a 2e                	push   $0x2e
80106c69:	e9 ac f9 ff ff       	jmp    8010661a <alltraps>

80106c6e <vector47>:
80106c6e:	6a 00                	push   $0x0
80106c70:	6a 2f                	push   $0x2f
80106c72:	e9 a3 f9 ff ff       	jmp    8010661a <alltraps>

80106c77 <vector48>:
80106c77:	6a 00                	push   $0x0
80106c79:	6a 30                	push   $0x30
80106c7b:	e9 9a f9 ff ff       	jmp    8010661a <alltraps>

80106c80 <vector49>:
80106c80:	6a 00                	push   $0x0
80106c82:	6a 31                	push   $0x31
80106c84:	e9 91 f9 ff ff       	jmp    8010661a <alltraps>

80106c89 <vector50>:
80106c89:	6a 00                	push   $0x0
80106c8b:	6a 32                	push   $0x32
80106c8d:	e9 88 f9 ff ff       	jmp    8010661a <alltraps>

80106c92 <vector51>:
80106c92:	6a 00                	push   $0x0
80106c94:	6a 33                	push   $0x33
80106c96:	e9 7f f9 ff ff       	jmp    8010661a <alltraps>

80106c9b <vector52>:
80106c9b:	6a 00                	push   $0x0
80106c9d:	6a 34                	push   $0x34
80106c9f:	e9 76 f9 ff ff       	jmp    8010661a <alltraps>

80106ca4 <vector53>:
80106ca4:	6a 00                	push   $0x0
80106ca6:	6a 35                	push   $0x35
80106ca8:	e9 6d f9 ff ff       	jmp    8010661a <alltraps>

80106cad <vector54>:
80106cad:	6a 00                	push   $0x0
80106caf:	6a 36                	push   $0x36
80106cb1:	e9 64 f9 ff ff       	jmp    8010661a <alltraps>

80106cb6 <vector55>:
80106cb6:	6a 00                	push   $0x0
80106cb8:	6a 37                	push   $0x37
80106cba:	e9 5b f9 ff ff       	jmp    8010661a <alltraps>

80106cbf <vector56>:
80106cbf:	6a 00                	push   $0x0
80106cc1:	6a 38                	push   $0x38
80106cc3:	e9 52 f9 ff ff       	jmp    8010661a <alltraps>

80106cc8 <vector57>:
80106cc8:	6a 00                	push   $0x0
80106cca:	6a 39                	push   $0x39
80106ccc:	e9 49 f9 ff ff       	jmp    8010661a <alltraps>

80106cd1 <vector58>:
80106cd1:	6a 00                	push   $0x0
80106cd3:	6a 3a                	push   $0x3a
80106cd5:	e9 40 f9 ff ff       	jmp    8010661a <alltraps>

80106cda <vector59>:
80106cda:	6a 00                	push   $0x0
80106cdc:	6a 3b                	push   $0x3b
80106cde:	e9 37 f9 ff ff       	jmp    8010661a <alltraps>

80106ce3 <vector60>:
80106ce3:	6a 00                	push   $0x0
80106ce5:	6a 3c                	push   $0x3c
80106ce7:	e9 2e f9 ff ff       	jmp    8010661a <alltraps>

80106cec <vector61>:
80106cec:	6a 00                	push   $0x0
80106cee:	6a 3d                	push   $0x3d
80106cf0:	e9 25 f9 ff ff       	jmp    8010661a <alltraps>

80106cf5 <vector62>:
80106cf5:	6a 00                	push   $0x0
80106cf7:	6a 3e                	push   $0x3e
80106cf9:	e9 1c f9 ff ff       	jmp    8010661a <alltraps>

80106cfe <vector63>:
80106cfe:	6a 00                	push   $0x0
80106d00:	6a 3f                	push   $0x3f
80106d02:	e9 13 f9 ff ff       	jmp    8010661a <alltraps>

80106d07 <vector64>:
80106d07:	6a 00                	push   $0x0
80106d09:	6a 40                	push   $0x40
80106d0b:	e9 0a f9 ff ff       	jmp    8010661a <alltraps>

80106d10 <vector65>:
80106d10:	6a 00                	push   $0x0
80106d12:	6a 41                	push   $0x41
80106d14:	e9 01 f9 ff ff       	jmp    8010661a <alltraps>

80106d19 <vector66>:
80106d19:	6a 00                	push   $0x0
80106d1b:	6a 42                	push   $0x42
80106d1d:	e9 f8 f8 ff ff       	jmp    8010661a <alltraps>

80106d22 <vector67>:
80106d22:	6a 00                	push   $0x0
80106d24:	6a 43                	push   $0x43
80106d26:	e9 ef f8 ff ff       	jmp    8010661a <alltraps>

80106d2b <vector68>:
80106d2b:	6a 00                	push   $0x0
80106d2d:	6a 44                	push   $0x44
80106d2f:	e9 e6 f8 ff ff       	jmp    8010661a <alltraps>

80106d34 <vector69>:
80106d34:	6a 00                	push   $0x0
80106d36:	6a 45                	push   $0x45
80106d38:	e9 dd f8 ff ff       	jmp    8010661a <alltraps>

80106d3d <vector70>:
80106d3d:	6a 00                	push   $0x0
80106d3f:	6a 46                	push   $0x46
80106d41:	e9 d4 f8 ff ff       	jmp    8010661a <alltraps>

80106d46 <vector71>:
80106d46:	6a 00                	push   $0x0
80106d48:	6a 47                	push   $0x47
80106d4a:	e9 cb f8 ff ff       	jmp    8010661a <alltraps>

80106d4f <vector72>:
80106d4f:	6a 00                	push   $0x0
80106d51:	6a 48                	push   $0x48
80106d53:	e9 c2 f8 ff ff       	jmp    8010661a <alltraps>

80106d58 <vector73>:
80106d58:	6a 00                	push   $0x0
80106d5a:	6a 49                	push   $0x49
80106d5c:	e9 b9 f8 ff ff       	jmp    8010661a <alltraps>

80106d61 <vector74>:
80106d61:	6a 00                	push   $0x0
80106d63:	6a 4a                	push   $0x4a
80106d65:	e9 b0 f8 ff ff       	jmp    8010661a <alltraps>

80106d6a <vector75>:
80106d6a:	6a 00                	push   $0x0
80106d6c:	6a 4b                	push   $0x4b
80106d6e:	e9 a7 f8 ff ff       	jmp    8010661a <alltraps>

80106d73 <vector76>:
80106d73:	6a 00                	push   $0x0
80106d75:	6a 4c                	push   $0x4c
80106d77:	e9 9e f8 ff ff       	jmp    8010661a <alltraps>

80106d7c <vector77>:
80106d7c:	6a 00                	push   $0x0
80106d7e:	6a 4d                	push   $0x4d
80106d80:	e9 95 f8 ff ff       	jmp    8010661a <alltraps>

80106d85 <vector78>:
80106d85:	6a 00                	push   $0x0
80106d87:	6a 4e                	push   $0x4e
80106d89:	e9 8c f8 ff ff       	jmp    8010661a <alltraps>

80106d8e <vector79>:
80106d8e:	6a 00                	push   $0x0
80106d90:	6a 4f                	push   $0x4f
80106d92:	e9 83 f8 ff ff       	jmp    8010661a <alltraps>

80106d97 <vector80>:
80106d97:	6a 00                	push   $0x0
80106d99:	6a 50                	push   $0x50
80106d9b:	e9 7a f8 ff ff       	jmp    8010661a <alltraps>

80106da0 <vector81>:
80106da0:	6a 00                	push   $0x0
80106da2:	6a 51                	push   $0x51
80106da4:	e9 71 f8 ff ff       	jmp    8010661a <alltraps>

80106da9 <vector82>:
80106da9:	6a 00                	push   $0x0
80106dab:	6a 52                	push   $0x52
80106dad:	e9 68 f8 ff ff       	jmp    8010661a <alltraps>

80106db2 <vector83>:
80106db2:	6a 00                	push   $0x0
80106db4:	6a 53                	push   $0x53
80106db6:	e9 5f f8 ff ff       	jmp    8010661a <alltraps>

80106dbb <vector84>:
80106dbb:	6a 00                	push   $0x0
80106dbd:	6a 54                	push   $0x54
80106dbf:	e9 56 f8 ff ff       	jmp    8010661a <alltraps>

80106dc4 <vector85>:
80106dc4:	6a 00                	push   $0x0
80106dc6:	6a 55                	push   $0x55
80106dc8:	e9 4d f8 ff ff       	jmp    8010661a <alltraps>

80106dcd <vector86>:
80106dcd:	6a 00                	push   $0x0
80106dcf:	6a 56                	push   $0x56
80106dd1:	e9 44 f8 ff ff       	jmp    8010661a <alltraps>

80106dd6 <vector87>:
80106dd6:	6a 00                	push   $0x0
80106dd8:	6a 57                	push   $0x57
80106dda:	e9 3b f8 ff ff       	jmp    8010661a <alltraps>

80106ddf <vector88>:
80106ddf:	6a 00                	push   $0x0
80106de1:	6a 58                	push   $0x58
80106de3:	e9 32 f8 ff ff       	jmp    8010661a <alltraps>

80106de8 <vector89>:
80106de8:	6a 00                	push   $0x0
80106dea:	6a 59                	push   $0x59
80106dec:	e9 29 f8 ff ff       	jmp    8010661a <alltraps>

80106df1 <vector90>:
80106df1:	6a 00                	push   $0x0
80106df3:	6a 5a                	push   $0x5a
80106df5:	e9 20 f8 ff ff       	jmp    8010661a <alltraps>

80106dfa <vector91>:
80106dfa:	6a 00                	push   $0x0
80106dfc:	6a 5b                	push   $0x5b
80106dfe:	e9 17 f8 ff ff       	jmp    8010661a <alltraps>

80106e03 <vector92>:
80106e03:	6a 00                	push   $0x0
80106e05:	6a 5c                	push   $0x5c
80106e07:	e9 0e f8 ff ff       	jmp    8010661a <alltraps>

80106e0c <vector93>:
80106e0c:	6a 00                	push   $0x0
80106e0e:	6a 5d                	push   $0x5d
80106e10:	e9 05 f8 ff ff       	jmp    8010661a <alltraps>

80106e15 <vector94>:
80106e15:	6a 00                	push   $0x0
80106e17:	6a 5e                	push   $0x5e
80106e19:	e9 fc f7 ff ff       	jmp    8010661a <alltraps>

80106e1e <vector95>:
80106e1e:	6a 00                	push   $0x0
80106e20:	6a 5f                	push   $0x5f
80106e22:	e9 f3 f7 ff ff       	jmp    8010661a <alltraps>

80106e27 <vector96>:
80106e27:	6a 00                	push   $0x0
80106e29:	6a 60                	push   $0x60
80106e2b:	e9 ea f7 ff ff       	jmp    8010661a <alltraps>

80106e30 <vector97>:
80106e30:	6a 00                	push   $0x0
80106e32:	6a 61                	push   $0x61
80106e34:	e9 e1 f7 ff ff       	jmp    8010661a <alltraps>

80106e39 <vector98>:
80106e39:	6a 00                	push   $0x0
80106e3b:	6a 62                	push   $0x62
80106e3d:	e9 d8 f7 ff ff       	jmp    8010661a <alltraps>

80106e42 <vector99>:
80106e42:	6a 00                	push   $0x0
80106e44:	6a 63                	push   $0x63
80106e46:	e9 cf f7 ff ff       	jmp    8010661a <alltraps>

80106e4b <vector100>:
80106e4b:	6a 00                	push   $0x0
80106e4d:	6a 64                	push   $0x64
80106e4f:	e9 c6 f7 ff ff       	jmp    8010661a <alltraps>

80106e54 <vector101>:
80106e54:	6a 00                	push   $0x0
80106e56:	6a 65                	push   $0x65
80106e58:	e9 bd f7 ff ff       	jmp    8010661a <alltraps>

80106e5d <vector102>:
80106e5d:	6a 00                	push   $0x0
80106e5f:	6a 66                	push   $0x66
80106e61:	e9 b4 f7 ff ff       	jmp    8010661a <alltraps>

80106e66 <vector103>:
80106e66:	6a 00                	push   $0x0
80106e68:	6a 67                	push   $0x67
80106e6a:	e9 ab f7 ff ff       	jmp    8010661a <alltraps>

80106e6f <vector104>:
80106e6f:	6a 00                	push   $0x0
80106e71:	6a 68                	push   $0x68
80106e73:	e9 a2 f7 ff ff       	jmp    8010661a <alltraps>

80106e78 <vector105>:
80106e78:	6a 00                	push   $0x0
80106e7a:	6a 69                	push   $0x69
80106e7c:	e9 99 f7 ff ff       	jmp    8010661a <alltraps>

80106e81 <vector106>:
80106e81:	6a 00                	push   $0x0
80106e83:	6a 6a                	push   $0x6a
80106e85:	e9 90 f7 ff ff       	jmp    8010661a <alltraps>

80106e8a <vector107>:
80106e8a:	6a 00                	push   $0x0
80106e8c:	6a 6b                	push   $0x6b
80106e8e:	e9 87 f7 ff ff       	jmp    8010661a <alltraps>

80106e93 <vector108>:
80106e93:	6a 00                	push   $0x0
80106e95:	6a 6c                	push   $0x6c
80106e97:	e9 7e f7 ff ff       	jmp    8010661a <alltraps>

80106e9c <vector109>:
80106e9c:	6a 00                	push   $0x0
80106e9e:	6a 6d                	push   $0x6d
80106ea0:	e9 75 f7 ff ff       	jmp    8010661a <alltraps>

80106ea5 <vector110>:
80106ea5:	6a 00                	push   $0x0
80106ea7:	6a 6e                	push   $0x6e
80106ea9:	e9 6c f7 ff ff       	jmp    8010661a <alltraps>

80106eae <vector111>:
80106eae:	6a 00                	push   $0x0
80106eb0:	6a 6f                	push   $0x6f
80106eb2:	e9 63 f7 ff ff       	jmp    8010661a <alltraps>

80106eb7 <vector112>:
80106eb7:	6a 00                	push   $0x0
80106eb9:	6a 70                	push   $0x70
80106ebb:	e9 5a f7 ff ff       	jmp    8010661a <alltraps>

80106ec0 <vector113>:
80106ec0:	6a 00                	push   $0x0
80106ec2:	6a 71                	push   $0x71
80106ec4:	e9 51 f7 ff ff       	jmp    8010661a <alltraps>

80106ec9 <vector114>:
80106ec9:	6a 00                	push   $0x0
80106ecb:	6a 72                	push   $0x72
80106ecd:	e9 48 f7 ff ff       	jmp    8010661a <alltraps>

80106ed2 <vector115>:
80106ed2:	6a 00                	push   $0x0
80106ed4:	6a 73                	push   $0x73
80106ed6:	e9 3f f7 ff ff       	jmp    8010661a <alltraps>

80106edb <vector116>:
80106edb:	6a 00                	push   $0x0
80106edd:	6a 74                	push   $0x74
80106edf:	e9 36 f7 ff ff       	jmp    8010661a <alltraps>

80106ee4 <vector117>:
80106ee4:	6a 00                	push   $0x0
80106ee6:	6a 75                	push   $0x75
80106ee8:	e9 2d f7 ff ff       	jmp    8010661a <alltraps>

80106eed <vector118>:
80106eed:	6a 00                	push   $0x0
80106eef:	6a 76                	push   $0x76
80106ef1:	e9 24 f7 ff ff       	jmp    8010661a <alltraps>

80106ef6 <vector119>:
80106ef6:	6a 00                	push   $0x0
80106ef8:	6a 77                	push   $0x77
80106efa:	e9 1b f7 ff ff       	jmp    8010661a <alltraps>

80106eff <vector120>:
80106eff:	6a 00                	push   $0x0
80106f01:	6a 78                	push   $0x78
80106f03:	e9 12 f7 ff ff       	jmp    8010661a <alltraps>

80106f08 <vector121>:
80106f08:	6a 00                	push   $0x0
80106f0a:	6a 79                	push   $0x79
80106f0c:	e9 09 f7 ff ff       	jmp    8010661a <alltraps>

80106f11 <vector122>:
80106f11:	6a 00                	push   $0x0
80106f13:	6a 7a                	push   $0x7a
80106f15:	e9 00 f7 ff ff       	jmp    8010661a <alltraps>

80106f1a <vector123>:
80106f1a:	6a 00                	push   $0x0
80106f1c:	6a 7b                	push   $0x7b
80106f1e:	e9 f7 f6 ff ff       	jmp    8010661a <alltraps>

80106f23 <vector124>:
80106f23:	6a 00                	push   $0x0
80106f25:	6a 7c                	push   $0x7c
80106f27:	e9 ee f6 ff ff       	jmp    8010661a <alltraps>

80106f2c <vector125>:
80106f2c:	6a 00                	push   $0x0
80106f2e:	6a 7d                	push   $0x7d
80106f30:	e9 e5 f6 ff ff       	jmp    8010661a <alltraps>

80106f35 <vector126>:
80106f35:	6a 00                	push   $0x0
80106f37:	6a 7e                	push   $0x7e
80106f39:	e9 dc f6 ff ff       	jmp    8010661a <alltraps>

80106f3e <vector127>:
80106f3e:	6a 00                	push   $0x0
80106f40:	6a 7f                	push   $0x7f
80106f42:	e9 d3 f6 ff ff       	jmp    8010661a <alltraps>

80106f47 <vector128>:
80106f47:	6a 00                	push   $0x0
80106f49:	68 80 00 00 00       	push   $0x80
80106f4e:	e9 c7 f6 ff ff       	jmp    8010661a <alltraps>

80106f53 <vector129>:
80106f53:	6a 00                	push   $0x0
80106f55:	68 81 00 00 00       	push   $0x81
80106f5a:	e9 bb f6 ff ff       	jmp    8010661a <alltraps>

80106f5f <vector130>:
80106f5f:	6a 00                	push   $0x0
80106f61:	68 82 00 00 00       	push   $0x82
80106f66:	e9 af f6 ff ff       	jmp    8010661a <alltraps>

80106f6b <vector131>:
80106f6b:	6a 00                	push   $0x0
80106f6d:	68 83 00 00 00       	push   $0x83
80106f72:	e9 a3 f6 ff ff       	jmp    8010661a <alltraps>

80106f77 <vector132>:
80106f77:	6a 00                	push   $0x0
80106f79:	68 84 00 00 00       	push   $0x84
80106f7e:	e9 97 f6 ff ff       	jmp    8010661a <alltraps>

80106f83 <vector133>:
80106f83:	6a 00                	push   $0x0
80106f85:	68 85 00 00 00       	push   $0x85
80106f8a:	e9 8b f6 ff ff       	jmp    8010661a <alltraps>

80106f8f <vector134>:
80106f8f:	6a 00                	push   $0x0
80106f91:	68 86 00 00 00       	push   $0x86
80106f96:	e9 7f f6 ff ff       	jmp    8010661a <alltraps>

80106f9b <vector135>:
80106f9b:	6a 00                	push   $0x0
80106f9d:	68 87 00 00 00       	push   $0x87
80106fa2:	e9 73 f6 ff ff       	jmp    8010661a <alltraps>

80106fa7 <vector136>:
80106fa7:	6a 00                	push   $0x0
80106fa9:	68 88 00 00 00       	push   $0x88
80106fae:	e9 67 f6 ff ff       	jmp    8010661a <alltraps>

80106fb3 <vector137>:
80106fb3:	6a 00                	push   $0x0
80106fb5:	68 89 00 00 00       	push   $0x89
80106fba:	e9 5b f6 ff ff       	jmp    8010661a <alltraps>

80106fbf <vector138>:
80106fbf:	6a 00                	push   $0x0
80106fc1:	68 8a 00 00 00       	push   $0x8a
80106fc6:	e9 4f f6 ff ff       	jmp    8010661a <alltraps>

80106fcb <vector139>:
80106fcb:	6a 00                	push   $0x0
80106fcd:	68 8b 00 00 00       	push   $0x8b
80106fd2:	e9 43 f6 ff ff       	jmp    8010661a <alltraps>

80106fd7 <vector140>:
80106fd7:	6a 00                	push   $0x0
80106fd9:	68 8c 00 00 00       	push   $0x8c
80106fde:	e9 37 f6 ff ff       	jmp    8010661a <alltraps>

80106fe3 <vector141>:
80106fe3:	6a 00                	push   $0x0
80106fe5:	68 8d 00 00 00       	push   $0x8d
80106fea:	e9 2b f6 ff ff       	jmp    8010661a <alltraps>

80106fef <vector142>:
80106fef:	6a 00                	push   $0x0
80106ff1:	68 8e 00 00 00       	push   $0x8e
80106ff6:	e9 1f f6 ff ff       	jmp    8010661a <alltraps>

80106ffb <vector143>:
80106ffb:	6a 00                	push   $0x0
80106ffd:	68 8f 00 00 00       	push   $0x8f
80107002:	e9 13 f6 ff ff       	jmp    8010661a <alltraps>

80107007 <vector144>:
80107007:	6a 00                	push   $0x0
80107009:	68 90 00 00 00       	push   $0x90
8010700e:	e9 07 f6 ff ff       	jmp    8010661a <alltraps>

80107013 <vector145>:
80107013:	6a 00                	push   $0x0
80107015:	68 91 00 00 00       	push   $0x91
8010701a:	e9 fb f5 ff ff       	jmp    8010661a <alltraps>

8010701f <vector146>:
8010701f:	6a 00                	push   $0x0
80107021:	68 92 00 00 00       	push   $0x92
80107026:	e9 ef f5 ff ff       	jmp    8010661a <alltraps>

8010702b <vector147>:
8010702b:	6a 00                	push   $0x0
8010702d:	68 93 00 00 00       	push   $0x93
80107032:	e9 e3 f5 ff ff       	jmp    8010661a <alltraps>

80107037 <vector148>:
80107037:	6a 00                	push   $0x0
80107039:	68 94 00 00 00       	push   $0x94
8010703e:	e9 d7 f5 ff ff       	jmp    8010661a <alltraps>

80107043 <vector149>:
80107043:	6a 00                	push   $0x0
80107045:	68 95 00 00 00       	push   $0x95
8010704a:	e9 cb f5 ff ff       	jmp    8010661a <alltraps>

8010704f <vector150>:
8010704f:	6a 00                	push   $0x0
80107051:	68 96 00 00 00       	push   $0x96
80107056:	e9 bf f5 ff ff       	jmp    8010661a <alltraps>

8010705b <vector151>:
8010705b:	6a 00                	push   $0x0
8010705d:	68 97 00 00 00       	push   $0x97
80107062:	e9 b3 f5 ff ff       	jmp    8010661a <alltraps>

80107067 <vector152>:
80107067:	6a 00                	push   $0x0
80107069:	68 98 00 00 00       	push   $0x98
8010706e:	e9 a7 f5 ff ff       	jmp    8010661a <alltraps>

80107073 <vector153>:
80107073:	6a 00                	push   $0x0
80107075:	68 99 00 00 00       	push   $0x99
8010707a:	e9 9b f5 ff ff       	jmp    8010661a <alltraps>

8010707f <vector154>:
8010707f:	6a 00                	push   $0x0
80107081:	68 9a 00 00 00       	push   $0x9a
80107086:	e9 8f f5 ff ff       	jmp    8010661a <alltraps>

8010708b <vector155>:
8010708b:	6a 00                	push   $0x0
8010708d:	68 9b 00 00 00       	push   $0x9b
80107092:	e9 83 f5 ff ff       	jmp    8010661a <alltraps>

80107097 <vector156>:
80107097:	6a 00                	push   $0x0
80107099:	68 9c 00 00 00       	push   $0x9c
8010709e:	e9 77 f5 ff ff       	jmp    8010661a <alltraps>

801070a3 <vector157>:
801070a3:	6a 00                	push   $0x0
801070a5:	68 9d 00 00 00       	push   $0x9d
801070aa:	e9 6b f5 ff ff       	jmp    8010661a <alltraps>

801070af <vector158>:
801070af:	6a 00                	push   $0x0
801070b1:	68 9e 00 00 00       	push   $0x9e
801070b6:	e9 5f f5 ff ff       	jmp    8010661a <alltraps>

801070bb <vector159>:
801070bb:	6a 00                	push   $0x0
801070bd:	68 9f 00 00 00       	push   $0x9f
801070c2:	e9 53 f5 ff ff       	jmp    8010661a <alltraps>

801070c7 <vector160>:
801070c7:	6a 00                	push   $0x0
801070c9:	68 a0 00 00 00       	push   $0xa0
801070ce:	e9 47 f5 ff ff       	jmp    8010661a <alltraps>

801070d3 <vector161>:
801070d3:	6a 00                	push   $0x0
801070d5:	68 a1 00 00 00       	push   $0xa1
801070da:	e9 3b f5 ff ff       	jmp    8010661a <alltraps>

801070df <vector162>:
801070df:	6a 00                	push   $0x0
801070e1:	68 a2 00 00 00       	push   $0xa2
801070e6:	e9 2f f5 ff ff       	jmp    8010661a <alltraps>

801070eb <vector163>:
801070eb:	6a 00                	push   $0x0
801070ed:	68 a3 00 00 00       	push   $0xa3
801070f2:	e9 23 f5 ff ff       	jmp    8010661a <alltraps>

801070f7 <vector164>:
801070f7:	6a 00                	push   $0x0
801070f9:	68 a4 00 00 00       	push   $0xa4
801070fe:	e9 17 f5 ff ff       	jmp    8010661a <alltraps>

80107103 <vector165>:
80107103:	6a 00                	push   $0x0
80107105:	68 a5 00 00 00       	push   $0xa5
8010710a:	e9 0b f5 ff ff       	jmp    8010661a <alltraps>

8010710f <vector166>:
8010710f:	6a 00                	push   $0x0
80107111:	68 a6 00 00 00       	push   $0xa6
80107116:	e9 ff f4 ff ff       	jmp    8010661a <alltraps>

8010711b <vector167>:
8010711b:	6a 00                	push   $0x0
8010711d:	68 a7 00 00 00       	push   $0xa7
80107122:	e9 f3 f4 ff ff       	jmp    8010661a <alltraps>

80107127 <vector168>:
80107127:	6a 00                	push   $0x0
80107129:	68 a8 00 00 00       	push   $0xa8
8010712e:	e9 e7 f4 ff ff       	jmp    8010661a <alltraps>

80107133 <vector169>:
80107133:	6a 00                	push   $0x0
80107135:	68 a9 00 00 00       	push   $0xa9
8010713a:	e9 db f4 ff ff       	jmp    8010661a <alltraps>

8010713f <vector170>:
8010713f:	6a 00                	push   $0x0
80107141:	68 aa 00 00 00       	push   $0xaa
80107146:	e9 cf f4 ff ff       	jmp    8010661a <alltraps>

8010714b <vector171>:
8010714b:	6a 00                	push   $0x0
8010714d:	68 ab 00 00 00       	push   $0xab
80107152:	e9 c3 f4 ff ff       	jmp    8010661a <alltraps>

80107157 <vector172>:
80107157:	6a 00                	push   $0x0
80107159:	68 ac 00 00 00       	push   $0xac
8010715e:	e9 b7 f4 ff ff       	jmp    8010661a <alltraps>

80107163 <vector173>:
80107163:	6a 00                	push   $0x0
80107165:	68 ad 00 00 00       	push   $0xad
8010716a:	e9 ab f4 ff ff       	jmp    8010661a <alltraps>

8010716f <vector174>:
8010716f:	6a 00                	push   $0x0
80107171:	68 ae 00 00 00       	push   $0xae
80107176:	e9 9f f4 ff ff       	jmp    8010661a <alltraps>

8010717b <vector175>:
8010717b:	6a 00                	push   $0x0
8010717d:	68 af 00 00 00       	push   $0xaf
80107182:	e9 93 f4 ff ff       	jmp    8010661a <alltraps>

80107187 <vector176>:
80107187:	6a 00                	push   $0x0
80107189:	68 b0 00 00 00       	push   $0xb0
8010718e:	e9 87 f4 ff ff       	jmp    8010661a <alltraps>

80107193 <vector177>:
80107193:	6a 00                	push   $0x0
80107195:	68 b1 00 00 00       	push   $0xb1
8010719a:	e9 7b f4 ff ff       	jmp    8010661a <alltraps>

8010719f <vector178>:
8010719f:	6a 00                	push   $0x0
801071a1:	68 b2 00 00 00       	push   $0xb2
801071a6:	e9 6f f4 ff ff       	jmp    8010661a <alltraps>

801071ab <vector179>:
801071ab:	6a 00                	push   $0x0
801071ad:	68 b3 00 00 00       	push   $0xb3
801071b2:	e9 63 f4 ff ff       	jmp    8010661a <alltraps>

801071b7 <vector180>:
801071b7:	6a 00                	push   $0x0
801071b9:	68 b4 00 00 00       	push   $0xb4
801071be:	e9 57 f4 ff ff       	jmp    8010661a <alltraps>

801071c3 <vector181>:
801071c3:	6a 00                	push   $0x0
801071c5:	68 b5 00 00 00       	push   $0xb5
801071ca:	e9 4b f4 ff ff       	jmp    8010661a <alltraps>

801071cf <vector182>:
801071cf:	6a 00                	push   $0x0
801071d1:	68 b6 00 00 00       	push   $0xb6
801071d6:	e9 3f f4 ff ff       	jmp    8010661a <alltraps>

801071db <vector183>:
801071db:	6a 00                	push   $0x0
801071dd:	68 b7 00 00 00       	push   $0xb7
801071e2:	e9 33 f4 ff ff       	jmp    8010661a <alltraps>

801071e7 <vector184>:
801071e7:	6a 00                	push   $0x0
801071e9:	68 b8 00 00 00       	push   $0xb8
801071ee:	e9 27 f4 ff ff       	jmp    8010661a <alltraps>

801071f3 <vector185>:
801071f3:	6a 00                	push   $0x0
801071f5:	68 b9 00 00 00       	push   $0xb9
801071fa:	e9 1b f4 ff ff       	jmp    8010661a <alltraps>

801071ff <vector186>:
801071ff:	6a 00                	push   $0x0
80107201:	68 ba 00 00 00       	push   $0xba
80107206:	e9 0f f4 ff ff       	jmp    8010661a <alltraps>

8010720b <vector187>:
8010720b:	6a 00                	push   $0x0
8010720d:	68 bb 00 00 00       	push   $0xbb
80107212:	e9 03 f4 ff ff       	jmp    8010661a <alltraps>

80107217 <vector188>:
80107217:	6a 00                	push   $0x0
80107219:	68 bc 00 00 00       	push   $0xbc
8010721e:	e9 f7 f3 ff ff       	jmp    8010661a <alltraps>

80107223 <vector189>:
80107223:	6a 00                	push   $0x0
80107225:	68 bd 00 00 00       	push   $0xbd
8010722a:	e9 eb f3 ff ff       	jmp    8010661a <alltraps>

8010722f <vector190>:
8010722f:	6a 00                	push   $0x0
80107231:	68 be 00 00 00       	push   $0xbe
80107236:	e9 df f3 ff ff       	jmp    8010661a <alltraps>

8010723b <vector191>:
8010723b:	6a 00                	push   $0x0
8010723d:	68 bf 00 00 00       	push   $0xbf
80107242:	e9 d3 f3 ff ff       	jmp    8010661a <alltraps>

80107247 <vector192>:
80107247:	6a 00                	push   $0x0
80107249:	68 c0 00 00 00       	push   $0xc0
8010724e:	e9 c7 f3 ff ff       	jmp    8010661a <alltraps>

80107253 <vector193>:
80107253:	6a 00                	push   $0x0
80107255:	68 c1 00 00 00       	push   $0xc1
8010725a:	e9 bb f3 ff ff       	jmp    8010661a <alltraps>

8010725f <vector194>:
8010725f:	6a 00                	push   $0x0
80107261:	68 c2 00 00 00       	push   $0xc2
80107266:	e9 af f3 ff ff       	jmp    8010661a <alltraps>

8010726b <vector195>:
8010726b:	6a 00                	push   $0x0
8010726d:	68 c3 00 00 00       	push   $0xc3
80107272:	e9 a3 f3 ff ff       	jmp    8010661a <alltraps>

80107277 <vector196>:
80107277:	6a 00                	push   $0x0
80107279:	68 c4 00 00 00       	push   $0xc4
8010727e:	e9 97 f3 ff ff       	jmp    8010661a <alltraps>

80107283 <vector197>:
80107283:	6a 00                	push   $0x0
80107285:	68 c5 00 00 00       	push   $0xc5
8010728a:	e9 8b f3 ff ff       	jmp    8010661a <alltraps>

8010728f <vector198>:
8010728f:	6a 00                	push   $0x0
80107291:	68 c6 00 00 00       	push   $0xc6
80107296:	e9 7f f3 ff ff       	jmp    8010661a <alltraps>

8010729b <vector199>:
8010729b:	6a 00                	push   $0x0
8010729d:	68 c7 00 00 00       	push   $0xc7
801072a2:	e9 73 f3 ff ff       	jmp    8010661a <alltraps>

801072a7 <vector200>:
801072a7:	6a 00                	push   $0x0
801072a9:	68 c8 00 00 00       	push   $0xc8
801072ae:	e9 67 f3 ff ff       	jmp    8010661a <alltraps>

801072b3 <vector201>:
801072b3:	6a 00                	push   $0x0
801072b5:	68 c9 00 00 00       	push   $0xc9
801072ba:	e9 5b f3 ff ff       	jmp    8010661a <alltraps>

801072bf <vector202>:
801072bf:	6a 00                	push   $0x0
801072c1:	68 ca 00 00 00       	push   $0xca
801072c6:	e9 4f f3 ff ff       	jmp    8010661a <alltraps>

801072cb <vector203>:
801072cb:	6a 00                	push   $0x0
801072cd:	68 cb 00 00 00       	push   $0xcb
801072d2:	e9 43 f3 ff ff       	jmp    8010661a <alltraps>

801072d7 <vector204>:
801072d7:	6a 00                	push   $0x0
801072d9:	68 cc 00 00 00       	push   $0xcc
801072de:	e9 37 f3 ff ff       	jmp    8010661a <alltraps>

801072e3 <vector205>:
801072e3:	6a 00                	push   $0x0
801072e5:	68 cd 00 00 00       	push   $0xcd
801072ea:	e9 2b f3 ff ff       	jmp    8010661a <alltraps>

801072ef <vector206>:
801072ef:	6a 00                	push   $0x0
801072f1:	68 ce 00 00 00       	push   $0xce
801072f6:	e9 1f f3 ff ff       	jmp    8010661a <alltraps>

801072fb <vector207>:
801072fb:	6a 00                	push   $0x0
801072fd:	68 cf 00 00 00       	push   $0xcf
80107302:	e9 13 f3 ff ff       	jmp    8010661a <alltraps>

80107307 <vector208>:
80107307:	6a 00                	push   $0x0
80107309:	68 d0 00 00 00       	push   $0xd0
8010730e:	e9 07 f3 ff ff       	jmp    8010661a <alltraps>

80107313 <vector209>:
80107313:	6a 00                	push   $0x0
80107315:	68 d1 00 00 00       	push   $0xd1
8010731a:	e9 fb f2 ff ff       	jmp    8010661a <alltraps>

8010731f <vector210>:
8010731f:	6a 00                	push   $0x0
80107321:	68 d2 00 00 00       	push   $0xd2
80107326:	e9 ef f2 ff ff       	jmp    8010661a <alltraps>

8010732b <vector211>:
8010732b:	6a 00                	push   $0x0
8010732d:	68 d3 00 00 00       	push   $0xd3
80107332:	e9 e3 f2 ff ff       	jmp    8010661a <alltraps>

80107337 <vector212>:
80107337:	6a 00                	push   $0x0
80107339:	68 d4 00 00 00       	push   $0xd4
8010733e:	e9 d7 f2 ff ff       	jmp    8010661a <alltraps>

80107343 <vector213>:
80107343:	6a 00                	push   $0x0
80107345:	68 d5 00 00 00       	push   $0xd5
8010734a:	e9 cb f2 ff ff       	jmp    8010661a <alltraps>

8010734f <vector214>:
8010734f:	6a 00                	push   $0x0
80107351:	68 d6 00 00 00       	push   $0xd6
80107356:	e9 bf f2 ff ff       	jmp    8010661a <alltraps>

8010735b <vector215>:
8010735b:	6a 00                	push   $0x0
8010735d:	68 d7 00 00 00       	push   $0xd7
80107362:	e9 b3 f2 ff ff       	jmp    8010661a <alltraps>

80107367 <vector216>:
80107367:	6a 00                	push   $0x0
80107369:	68 d8 00 00 00       	push   $0xd8
8010736e:	e9 a7 f2 ff ff       	jmp    8010661a <alltraps>

80107373 <vector217>:
80107373:	6a 00                	push   $0x0
80107375:	68 d9 00 00 00       	push   $0xd9
8010737a:	e9 9b f2 ff ff       	jmp    8010661a <alltraps>

8010737f <vector218>:
8010737f:	6a 00                	push   $0x0
80107381:	68 da 00 00 00       	push   $0xda
80107386:	e9 8f f2 ff ff       	jmp    8010661a <alltraps>

8010738b <vector219>:
8010738b:	6a 00                	push   $0x0
8010738d:	68 db 00 00 00       	push   $0xdb
80107392:	e9 83 f2 ff ff       	jmp    8010661a <alltraps>

80107397 <vector220>:
80107397:	6a 00                	push   $0x0
80107399:	68 dc 00 00 00       	push   $0xdc
8010739e:	e9 77 f2 ff ff       	jmp    8010661a <alltraps>

801073a3 <vector221>:
801073a3:	6a 00                	push   $0x0
801073a5:	68 dd 00 00 00       	push   $0xdd
801073aa:	e9 6b f2 ff ff       	jmp    8010661a <alltraps>

801073af <vector222>:
801073af:	6a 00                	push   $0x0
801073b1:	68 de 00 00 00       	push   $0xde
801073b6:	e9 5f f2 ff ff       	jmp    8010661a <alltraps>

801073bb <vector223>:
801073bb:	6a 00                	push   $0x0
801073bd:	68 df 00 00 00       	push   $0xdf
801073c2:	e9 53 f2 ff ff       	jmp    8010661a <alltraps>

801073c7 <vector224>:
801073c7:	6a 00                	push   $0x0
801073c9:	68 e0 00 00 00       	push   $0xe0
801073ce:	e9 47 f2 ff ff       	jmp    8010661a <alltraps>

801073d3 <vector225>:
801073d3:	6a 00                	push   $0x0
801073d5:	68 e1 00 00 00       	push   $0xe1
801073da:	e9 3b f2 ff ff       	jmp    8010661a <alltraps>

801073df <vector226>:
801073df:	6a 00                	push   $0x0
801073e1:	68 e2 00 00 00       	push   $0xe2
801073e6:	e9 2f f2 ff ff       	jmp    8010661a <alltraps>

801073eb <vector227>:
801073eb:	6a 00                	push   $0x0
801073ed:	68 e3 00 00 00       	push   $0xe3
801073f2:	e9 23 f2 ff ff       	jmp    8010661a <alltraps>

801073f7 <vector228>:
801073f7:	6a 00                	push   $0x0
801073f9:	68 e4 00 00 00       	push   $0xe4
801073fe:	e9 17 f2 ff ff       	jmp    8010661a <alltraps>

80107403 <vector229>:
80107403:	6a 00                	push   $0x0
80107405:	68 e5 00 00 00       	push   $0xe5
8010740a:	e9 0b f2 ff ff       	jmp    8010661a <alltraps>

8010740f <vector230>:
8010740f:	6a 00                	push   $0x0
80107411:	68 e6 00 00 00       	push   $0xe6
80107416:	e9 ff f1 ff ff       	jmp    8010661a <alltraps>

8010741b <vector231>:
8010741b:	6a 00                	push   $0x0
8010741d:	68 e7 00 00 00       	push   $0xe7
80107422:	e9 f3 f1 ff ff       	jmp    8010661a <alltraps>

80107427 <vector232>:
80107427:	6a 00                	push   $0x0
80107429:	68 e8 00 00 00       	push   $0xe8
8010742e:	e9 e7 f1 ff ff       	jmp    8010661a <alltraps>

80107433 <vector233>:
80107433:	6a 00                	push   $0x0
80107435:	68 e9 00 00 00       	push   $0xe9
8010743a:	e9 db f1 ff ff       	jmp    8010661a <alltraps>

8010743f <vector234>:
8010743f:	6a 00                	push   $0x0
80107441:	68 ea 00 00 00       	push   $0xea
80107446:	e9 cf f1 ff ff       	jmp    8010661a <alltraps>

8010744b <vector235>:
8010744b:	6a 00                	push   $0x0
8010744d:	68 eb 00 00 00       	push   $0xeb
80107452:	e9 c3 f1 ff ff       	jmp    8010661a <alltraps>

80107457 <vector236>:
80107457:	6a 00                	push   $0x0
80107459:	68 ec 00 00 00       	push   $0xec
8010745e:	e9 b7 f1 ff ff       	jmp    8010661a <alltraps>

80107463 <vector237>:
80107463:	6a 00                	push   $0x0
80107465:	68 ed 00 00 00       	push   $0xed
8010746a:	e9 ab f1 ff ff       	jmp    8010661a <alltraps>

8010746f <vector238>:
8010746f:	6a 00                	push   $0x0
80107471:	68 ee 00 00 00       	push   $0xee
80107476:	e9 9f f1 ff ff       	jmp    8010661a <alltraps>

8010747b <vector239>:
8010747b:	6a 00                	push   $0x0
8010747d:	68 ef 00 00 00       	push   $0xef
80107482:	e9 93 f1 ff ff       	jmp    8010661a <alltraps>

80107487 <vector240>:
80107487:	6a 00                	push   $0x0
80107489:	68 f0 00 00 00       	push   $0xf0
8010748e:	e9 87 f1 ff ff       	jmp    8010661a <alltraps>

80107493 <vector241>:
80107493:	6a 00                	push   $0x0
80107495:	68 f1 00 00 00       	push   $0xf1
8010749a:	e9 7b f1 ff ff       	jmp    8010661a <alltraps>

8010749f <vector242>:
8010749f:	6a 00                	push   $0x0
801074a1:	68 f2 00 00 00       	push   $0xf2
801074a6:	e9 6f f1 ff ff       	jmp    8010661a <alltraps>

801074ab <vector243>:
801074ab:	6a 00                	push   $0x0
801074ad:	68 f3 00 00 00       	push   $0xf3
801074b2:	e9 63 f1 ff ff       	jmp    8010661a <alltraps>

801074b7 <vector244>:
801074b7:	6a 00                	push   $0x0
801074b9:	68 f4 00 00 00       	push   $0xf4
801074be:	e9 57 f1 ff ff       	jmp    8010661a <alltraps>

801074c3 <vector245>:
801074c3:	6a 00                	push   $0x0
801074c5:	68 f5 00 00 00       	push   $0xf5
801074ca:	e9 4b f1 ff ff       	jmp    8010661a <alltraps>

801074cf <vector246>:
801074cf:	6a 00                	push   $0x0
801074d1:	68 f6 00 00 00       	push   $0xf6
801074d6:	e9 3f f1 ff ff       	jmp    8010661a <alltraps>

801074db <vector247>:
801074db:	6a 00                	push   $0x0
801074dd:	68 f7 00 00 00       	push   $0xf7
801074e2:	e9 33 f1 ff ff       	jmp    8010661a <alltraps>

801074e7 <vector248>:
801074e7:	6a 00                	push   $0x0
801074e9:	68 f8 00 00 00       	push   $0xf8
801074ee:	e9 27 f1 ff ff       	jmp    8010661a <alltraps>

801074f3 <vector249>:
801074f3:	6a 00                	push   $0x0
801074f5:	68 f9 00 00 00       	push   $0xf9
801074fa:	e9 1b f1 ff ff       	jmp    8010661a <alltraps>

801074ff <vector250>:
801074ff:	6a 00                	push   $0x0
80107501:	68 fa 00 00 00       	push   $0xfa
80107506:	e9 0f f1 ff ff       	jmp    8010661a <alltraps>

8010750b <vector251>:
8010750b:	6a 00                	push   $0x0
8010750d:	68 fb 00 00 00       	push   $0xfb
80107512:	e9 03 f1 ff ff       	jmp    8010661a <alltraps>

80107517 <vector252>:
80107517:	6a 00                	push   $0x0
80107519:	68 fc 00 00 00       	push   $0xfc
8010751e:	e9 f7 f0 ff ff       	jmp    8010661a <alltraps>

80107523 <vector253>:
80107523:	6a 00                	push   $0x0
80107525:	68 fd 00 00 00       	push   $0xfd
8010752a:	e9 eb f0 ff ff       	jmp    8010661a <alltraps>

8010752f <vector254>:
8010752f:	6a 00                	push   $0x0
80107531:	68 fe 00 00 00       	push   $0xfe
80107536:	e9 df f0 ff ff       	jmp    8010661a <alltraps>

8010753b <vector255>:
8010753b:	6a 00                	push   $0x0
8010753d:	68 ff 00 00 00       	push   $0xff
80107542:	e9 d3 f0 ff ff       	jmp    8010661a <alltraps>
80107547:	66 90                	xchg   %ax,%ax
80107549:	66 90                	xchg   %ax,%ax
8010754b:	66 90                	xchg   %ax,%ax
8010754d:	66 90                	xchg   %ax,%ax
8010754f:	90                   	nop

80107550 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	57                   	push   %edi
80107554:	56                   	push   %esi
80107555:	53                   	push   %ebx
80107556:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107558:	c1 ea 16             	shr    $0x16,%edx
8010755b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010755e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80107561:	8b 07                	mov    (%edi),%eax
80107563:	a8 01                	test   $0x1,%al
80107565:	74 29                	je     80107590 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107567:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010756c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80107572:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107575:	c1 eb 0a             	shr    $0xa,%ebx
80107578:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010757e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80107581:	5b                   	pop    %ebx
80107582:	5e                   	pop    %esi
80107583:	5f                   	pop    %edi
80107584:	5d                   	pop    %ebp
80107585:	c3                   	ret    
80107586:	8d 76 00             	lea    0x0(%esi),%esi
80107589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107590:	85 c9                	test   %ecx,%ecx
80107592:	74 2c                	je     801075c0 <walkpgdir+0x70>
80107594:	e8 07 be ff ff       	call   801033a0 <kalloc>
80107599:	85 c0                	test   %eax,%eax
8010759b:	89 c6                	mov    %eax,%esi
8010759d:	74 21                	je     801075c0 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010759f:	83 ec 04             	sub    $0x4,%esp
801075a2:	68 00 10 00 00       	push   $0x1000
801075a7:	6a 00                	push   $0x0
801075a9:	50                   	push   %eax
801075aa:	e8 71 dd ff ff       	call   80105320 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801075af:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801075b5:	83 c4 10             	add    $0x10,%esp
801075b8:	83 c8 07             	or     $0x7,%eax
801075bb:	89 07                	mov    %eax,(%edi)
801075bd:	eb b3                	jmp    80107572 <walkpgdir+0x22>
801075bf:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
801075c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
801075c3:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801075c5:	5b                   	pop    %ebx
801075c6:	5e                   	pop    %esi
801075c7:	5f                   	pop    %edi
801075c8:	5d                   	pop    %ebp
801075c9:	c3                   	ret    
801075ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801075d0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801075d0:	55                   	push   %ebp
801075d1:	89 e5                	mov    %esp,%ebp
801075d3:	57                   	push   %edi
801075d4:	56                   	push   %esi
801075d5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801075d6:	89 d3                	mov    %edx,%ebx
801075d8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801075de:	83 ec 1c             	sub    $0x1c,%esp
801075e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801075e4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801075e8:	8b 7d 08             	mov    0x8(%ebp),%edi
801075eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801075f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801075f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801075f6:	29 df                	sub    %ebx,%edi
801075f8:	83 c8 01             	or     $0x1,%eax
801075fb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801075fe:	eb 15                	jmp    80107615 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107600:	f6 00 01             	testb  $0x1,(%eax)
80107603:	75 45                	jne    8010764a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107605:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80107608:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010760b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010760d:	74 31                	je     80107640 <mappages+0x70>
      break;
    a += PGSIZE;
8010760f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107615:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107618:	b9 01 00 00 00       	mov    $0x1,%ecx
8010761d:	89 da                	mov    %ebx,%edx
8010761f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107622:	e8 29 ff ff ff       	call   80107550 <walkpgdir>
80107627:	85 c0                	test   %eax,%eax
80107629:	75 d5                	jne    80107600 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
8010762b:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
8010762e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80107633:	5b                   	pop    %ebx
80107634:	5e                   	pop    %esi
80107635:	5f                   	pop    %edi
80107636:	5d                   	pop    %ebp
80107637:	c3                   	ret    
80107638:	90                   	nop
80107639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107640:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107643:	31 c0                	xor    %eax,%eax
}
80107645:	5b                   	pop    %ebx
80107646:	5e                   	pop    %esi
80107647:	5f                   	pop    %edi
80107648:	5d                   	pop    %ebp
80107649:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
8010764a:	83 ec 0c             	sub    $0xc,%esp
8010764d:	68 0c 8b 10 80       	push   $0x80108b0c
80107652:	e8 69 91 ff ff       	call   801007c0 <panic>
80107657:	89 f6                	mov    %esi,%esi
80107659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107660 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107660:	55                   	push   %ebp
80107661:	89 e5                	mov    %esp,%ebp
80107663:	57                   	push   %edi
80107664:	56                   	push   %esi
80107665:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107666:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010766c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010766e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107674:	83 ec 1c             	sub    $0x1c,%esp
80107677:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
8010767a:	39 d3                	cmp    %edx,%ebx
8010767c:	73 66                	jae    801076e4 <deallocuvm.part.0+0x84>
8010767e:	89 d6                	mov    %edx,%esi
80107680:	eb 3d                	jmp    801076bf <deallocuvm.part.0+0x5f>
80107682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107688:	8b 10                	mov    (%eax),%edx
8010768a:	f6 c2 01             	test   $0x1,%dl
8010768d:	74 26                	je     801076b5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010768f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107695:	74 58                	je     801076ef <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107697:	83 ec 0c             	sub    $0xc,%esp
8010769a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801076a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801076a3:	52                   	push   %edx
801076a4:	e8 47 bb ff ff       	call   801031f0 <kfree>
      *pte = 0;
801076a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801076ac:	83 c4 10             	add    $0x10,%esp
801076af:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801076b5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801076bb:	39 f3                	cmp    %esi,%ebx
801076bd:	73 25                	jae    801076e4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
801076bf:	31 c9                	xor    %ecx,%ecx
801076c1:	89 da                	mov    %ebx,%edx
801076c3:	89 f8                	mov    %edi,%eax
801076c5:	e8 86 fe ff ff       	call   80107550 <walkpgdir>
    if(!pte)
801076ca:	85 c0                	test   %eax,%eax
801076cc:	75 ba                	jne    80107688 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801076ce:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
801076d4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801076da:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801076e0:	39 f3                	cmp    %esi,%ebx
801076e2:	72 db                	jb     801076bf <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801076e4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801076e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076ea:	5b                   	pop    %ebx
801076eb:	5e                   	pop    %esi
801076ec:	5f                   	pop    %edi
801076ed:	5d                   	pop    %ebp
801076ee:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
801076ef:	83 ec 0c             	sub    $0xc,%esp
801076f2:	68 ae 84 10 80       	push   $0x801084ae
801076f7:	e8 c4 90 ff ff       	call   801007c0 <panic>
801076fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107700 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107700:	55                   	push   %ebp
80107701:	89 e5                	mov    %esp,%ebp
80107703:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80107706:	e8 65 cf ff ff       	call   80104670 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010770b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107711:	31 c9                	xor    %ecx,%ecx
80107713:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80107718:	66 89 90 98 4b 12 80 	mov    %dx,-0x7fedb468(%eax)
8010771f:	66 89 88 9a 4b 12 80 	mov    %cx,-0x7fedb466(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107726:	ba ff ff ff ff       	mov    $0xffffffff,%edx
8010772b:	31 c9                	xor    %ecx,%ecx
8010772d:	66 89 90 a0 4b 12 80 	mov    %dx,-0x7fedb460(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107734:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107739:	66 89 88 a2 4b 12 80 	mov    %cx,-0x7fedb45e(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107740:	31 c9                	xor    %ecx,%ecx
80107742:	66 89 90 a8 4b 12 80 	mov    %dx,-0x7fedb458(%eax)
80107749:	66 89 88 aa 4b 12 80 	mov    %cx,-0x7fedb456(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107750:	ba ff ff ff ff       	mov    $0xffffffff,%edx
80107755:	31 c9                	xor    %ecx,%ecx
80107757:	66 89 90 b0 4b 12 80 	mov    %dx,-0x7fedb450(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010775e:	c6 80 9c 4b 12 80 00 	movb   $0x0,-0x7fedb464(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80107765:	ba 2f 00 00 00       	mov    $0x2f,%edx
8010776a:	c6 80 9d 4b 12 80 9a 	movb   $0x9a,-0x7fedb463(%eax)
80107771:	c6 80 9e 4b 12 80 cf 	movb   $0xcf,-0x7fedb462(%eax)
80107778:	c6 80 9f 4b 12 80 00 	movb   $0x0,-0x7fedb461(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010777f:	c6 80 a4 4b 12 80 00 	movb   $0x0,-0x7fedb45c(%eax)
80107786:	c6 80 a5 4b 12 80 92 	movb   $0x92,-0x7fedb45b(%eax)
8010778d:	c6 80 a6 4b 12 80 cf 	movb   $0xcf,-0x7fedb45a(%eax)
80107794:	c6 80 a7 4b 12 80 00 	movb   $0x0,-0x7fedb459(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010779b:	c6 80 ac 4b 12 80 00 	movb   $0x0,-0x7fedb454(%eax)
801077a2:	c6 80 ad 4b 12 80 fa 	movb   $0xfa,-0x7fedb453(%eax)
801077a9:	c6 80 ae 4b 12 80 cf 	movb   $0xcf,-0x7fedb452(%eax)
801077b0:	c6 80 af 4b 12 80 00 	movb   $0x0,-0x7fedb451(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801077b7:	66 89 88 b2 4b 12 80 	mov    %cx,-0x7fedb44e(%eax)
801077be:	c6 80 b4 4b 12 80 00 	movb   $0x0,-0x7fedb44c(%eax)
801077c5:	c6 80 b5 4b 12 80 f2 	movb   $0xf2,-0x7fedb44b(%eax)
801077cc:	c6 80 b6 4b 12 80 cf 	movb   $0xcf,-0x7fedb44a(%eax)
801077d3:	c6 80 b7 4b 12 80 00 	movb   $0x0,-0x7fedb449(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
801077da:	05 90 4b 12 80       	add    $0x80124b90,%eax
801077df:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
801077e3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801077e7:	c1 e8 10             	shr    $0x10,%eax
801077ea:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
801077ee:	8d 45 f2             	lea    -0xe(%ebp),%eax
801077f1:	0f 01 10             	lgdtl  (%eax)
}
801077f4:	c9                   	leave  
801077f5:	c3                   	ret    
801077f6:	8d 76 00             	lea    0x0(%esi),%esi
801077f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107800 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107800:	a1 44 78 12 80       	mov    0x80127844,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107805:	55                   	push   %ebp
80107806:	89 e5                	mov    %esp,%ebp
80107808:	05 00 00 00 80       	add    $0x80000000,%eax
8010780d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80107810:	5d                   	pop    %ebp
80107811:	c3                   	ret    
80107812:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107820 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107820:	55                   	push   %ebp
80107821:	89 e5                	mov    %esp,%ebp
80107823:	57                   	push   %edi
80107824:	56                   	push   %esi
80107825:	53                   	push   %ebx
80107826:	83 ec 1c             	sub    $0x1c,%esp
80107829:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010782c:	85 f6                	test   %esi,%esi
8010782e:	0f 84 cd 00 00 00    	je     80107901 <switchuvm+0xe1>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80107834:	8b 46 08             	mov    0x8(%esi),%eax
80107837:	85 c0                	test   %eax,%eax
80107839:	0f 84 dc 00 00 00    	je     8010791b <switchuvm+0xfb>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
8010783f:	8b 7e 04             	mov    0x4(%esi),%edi
80107842:	85 ff                	test   %edi,%edi
80107844:	0f 84 c4 00 00 00    	je     8010790e <switchuvm+0xee>
    panic("switchuvm: no pgdir");

  pushcli();
8010784a:	e8 21 d9 ff ff       	call   80105170 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010784f:	e8 9c cd ff ff       	call   801045f0 <mycpu>
80107854:	89 c3                	mov    %eax,%ebx
80107856:	e8 95 cd ff ff       	call   801045f0 <mycpu>
8010785b:	89 c7                	mov    %eax,%edi
8010785d:	e8 8e cd ff ff       	call   801045f0 <mycpu>
80107862:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107865:	83 c7 08             	add    $0x8,%edi
80107868:	e8 83 cd ff ff       	call   801045f0 <mycpu>
8010786d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107870:	83 c0 08             	add    $0x8,%eax
80107873:	ba 67 00 00 00       	mov    $0x67,%edx
80107878:	c1 e8 18             	shr    $0x18,%eax
8010787b:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80107882:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107889:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80107890:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80107897:	83 c1 08             	add    $0x8,%ecx
8010789a:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801078a0:	c1 e9 10             	shr    $0x10,%ecx
801078a3:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
  mycpu()->gdt[SEG_TSS].s = 0;
  mycpu()->ts.ss0 = SEG_KDATA << 3;
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801078a9:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    panic("switchuvm: no pgdir");

  pushcli();
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
801078ae:	e8 3d cd ff ff       	call   801045f0 <mycpu>
801078b3:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801078ba:	e8 31 cd ff ff       	call   801045f0 <mycpu>
801078bf:	b9 10 00 00 00       	mov    $0x10,%ecx
801078c4:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801078c8:	e8 23 cd ff ff       	call   801045f0 <mycpu>
801078cd:	8b 56 08             	mov    0x8(%esi),%edx
801078d0:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
801078d6:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801078d9:	e8 12 cd ff ff       	call   801045f0 <mycpu>
801078de:	66 89 58 6e          	mov    %bx,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
801078e2:	b8 28 00 00 00       	mov    $0x28,%eax
801078e7:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801078ea:	8b 46 04             	mov    0x4(%esi),%eax
801078ed:	05 00 00 00 80       	add    $0x80000000,%eax
801078f2:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
801078f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078f8:	5b                   	pop    %ebx
801078f9:	5e                   	pop    %esi
801078fa:	5f                   	pop    %edi
801078fb:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
801078fc:	e9 5f d9 ff ff       	jmp    80105260 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80107901:	83 ec 0c             	sub    $0xc,%esp
80107904:	68 12 8b 10 80       	push   $0x80108b12
80107909:	e8 b2 8e ff ff       	call   801007c0 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
8010790e:	83 ec 0c             	sub    $0xc,%esp
80107911:	68 3d 8b 10 80       	push   $0x80108b3d
80107916:	e8 a5 8e ff ff       	call   801007c0 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
8010791b:	83 ec 0c             	sub    $0xc,%esp
8010791e:	68 28 8b 10 80       	push   $0x80108b28
80107923:	e8 98 8e ff ff       	call   801007c0 <panic>
80107928:	90                   	nop
80107929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107930 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107930:	55                   	push   %ebp
80107931:	89 e5                	mov    %esp,%ebp
80107933:	57                   	push   %edi
80107934:	56                   	push   %esi
80107935:	53                   	push   %ebx
80107936:	83 ec 1c             	sub    $0x1c,%esp
80107939:	8b 75 10             	mov    0x10(%ebp),%esi
8010793c:	8b 45 08             	mov    0x8(%ebp),%eax
8010793f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80107942:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107948:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
8010794b:	77 49                	ja     80107996 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
8010794d:	e8 4e ba ff ff       	call   801033a0 <kalloc>
  memset(mem, 0, PGSIZE);
80107952:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80107955:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107957:	68 00 10 00 00       	push   $0x1000
8010795c:	6a 00                	push   $0x0
8010795e:	50                   	push   %eax
8010795f:	e8 bc d9 ff ff       	call   80105320 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107964:	58                   	pop    %eax
80107965:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010796b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107970:	5a                   	pop    %edx
80107971:	6a 06                	push   $0x6
80107973:	50                   	push   %eax
80107974:	31 d2                	xor    %edx,%edx
80107976:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107979:	e8 52 fc ff ff       	call   801075d0 <mappages>
  memmove(mem, init, sz);
8010797e:	89 75 10             	mov    %esi,0x10(%ebp)
80107981:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107984:	83 c4 10             	add    $0x10,%esp
80107987:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010798a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010798d:	5b                   	pop    %ebx
8010798e:	5e                   	pop    %esi
8010798f:	5f                   	pop    %edi
80107990:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80107991:	e9 3a da ff ff       	jmp    801053d0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80107996:	83 ec 0c             	sub    $0xc,%esp
80107999:	68 51 8b 10 80       	push   $0x80108b51
8010799e:	e8 1d 8e ff ff       	call   801007c0 <panic>
801079a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801079a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801079b0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801079b0:	55                   	push   %ebp
801079b1:	89 e5                	mov    %esp,%ebp
801079b3:	57                   	push   %edi
801079b4:	56                   	push   %esi
801079b5:	53                   	push   %ebx
801079b6:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801079b9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801079c0:	0f 85 91 00 00 00    	jne    80107a57 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801079c6:	8b 75 18             	mov    0x18(%ebp),%esi
801079c9:	31 db                	xor    %ebx,%ebx
801079cb:	85 f6                	test   %esi,%esi
801079cd:	75 1a                	jne    801079e9 <loaduvm+0x39>
801079cf:	eb 6f                	jmp    80107a40 <loaduvm+0x90>
801079d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079d8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801079de:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801079e4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801079e7:	76 57                	jbe    80107a40 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801079e9:	8b 55 0c             	mov    0xc(%ebp),%edx
801079ec:	8b 45 08             	mov    0x8(%ebp),%eax
801079ef:	31 c9                	xor    %ecx,%ecx
801079f1:	01 da                	add    %ebx,%edx
801079f3:	e8 58 fb ff ff       	call   80107550 <walkpgdir>
801079f8:	85 c0                	test   %eax,%eax
801079fa:	74 4e                	je     80107a4a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801079fc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801079fe:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80107a01:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80107a06:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107a0b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107a11:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107a14:	01 d9                	add    %ebx,%ecx
80107a16:	05 00 00 00 80       	add    $0x80000000,%eax
80107a1b:	57                   	push   %edi
80107a1c:	51                   	push   %ecx
80107a1d:	50                   	push   %eax
80107a1e:	ff 75 10             	pushl  0x10(%ebp)
80107a21:	e8 1a ae ff ff       	call   80102840 <readi>
80107a26:	83 c4 10             	add    $0x10,%esp
80107a29:	39 c7                	cmp    %eax,%edi
80107a2b:	74 ab                	je     801079d8 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80107a2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80107a30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80107a35:	5b                   	pop    %ebx
80107a36:	5e                   	pop    %esi
80107a37:	5f                   	pop    %edi
80107a38:	5d                   	pop    %ebp
80107a39:	c3                   	ret    
80107a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a40:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80107a43:	31 c0                	xor    %eax,%eax
}
80107a45:	5b                   	pop    %ebx
80107a46:	5e                   	pop    %esi
80107a47:	5f                   	pop    %edi
80107a48:	5d                   	pop    %ebp
80107a49:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80107a4a:	83 ec 0c             	sub    $0xc,%esp
80107a4d:	68 6b 8b 10 80       	push   $0x80108b6b
80107a52:	e8 69 8d ff ff       	call   801007c0 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80107a57:	83 ec 0c             	sub    $0xc,%esp
80107a5a:	68 0c 8c 10 80       	push   $0x80108c0c
80107a5f:	e8 5c 8d ff ff       	call   801007c0 <panic>
80107a64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107a70 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107a70:	55                   	push   %ebp
80107a71:	89 e5                	mov    %esp,%ebp
80107a73:	57                   	push   %edi
80107a74:	56                   	push   %esi
80107a75:	53                   	push   %ebx
80107a76:	83 ec 0c             	sub    $0xc,%esp
80107a79:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80107a7c:	85 ff                	test   %edi,%edi
80107a7e:	0f 88 ca 00 00 00    	js     80107b4e <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
80107a84:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80107a87:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80107a8a:	0f 82 82 00 00 00    	jb     80107b12 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80107a90:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107a96:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80107a9c:	39 df                	cmp    %ebx,%edi
80107a9e:	77 43                	ja     80107ae3 <allocuvm+0x73>
80107aa0:	e9 bb 00 00 00       	jmp    80107b60 <allocuvm+0xf0>
80107aa5:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80107aa8:	83 ec 04             	sub    $0x4,%esp
80107aab:	68 00 10 00 00       	push   $0x1000
80107ab0:	6a 00                	push   $0x0
80107ab2:	50                   	push   %eax
80107ab3:	e8 68 d8 ff ff       	call   80105320 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107ab8:	58                   	pop    %eax
80107ab9:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107abf:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107ac4:	5a                   	pop    %edx
80107ac5:	6a 06                	push   $0x6
80107ac7:	50                   	push   %eax
80107ac8:	89 da                	mov    %ebx,%edx
80107aca:	8b 45 08             	mov    0x8(%ebp),%eax
80107acd:	e8 fe fa ff ff       	call   801075d0 <mappages>
80107ad2:	83 c4 10             	add    $0x10,%esp
80107ad5:	85 c0                	test   %eax,%eax
80107ad7:	78 47                	js     80107b20 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107ad9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107adf:	39 df                	cmp    %ebx,%edi
80107ae1:	76 7d                	jbe    80107b60 <allocuvm+0xf0>
    mem = kalloc();
80107ae3:	e8 b8 b8 ff ff       	call   801033a0 <kalloc>
    if(mem == 0){
80107ae8:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80107aea:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80107aec:	75 ba                	jne    80107aa8 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80107aee:	83 ec 0c             	sub    $0xc,%esp
80107af1:	68 89 8b 10 80       	push   $0x80108b89
80107af6:	e8 35 8b ff ff       	call   80100630 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80107afb:	83 c4 10             	add    $0x10,%esp
80107afe:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107b01:	76 4b                	jbe    80107b4e <allocuvm+0xde>
80107b03:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107b06:	8b 45 08             	mov    0x8(%ebp),%eax
80107b09:	89 fa                	mov    %edi,%edx
80107b0b:	e8 50 fb ff ff       	call   80107660 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80107b10:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80107b12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b15:	5b                   	pop    %ebx
80107b16:	5e                   	pop    %esi
80107b17:	5f                   	pop    %edi
80107b18:	5d                   	pop    %ebp
80107b19:	c3                   	ret    
80107b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80107b20:	83 ec 0c             	sub    $0xc,%esp
80107b23:	68 a1 8b 10 80       	push   $0x80108ba1
80107b28:	e8 03 8b ff ff       	call   80100630 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80107b2d:	83 c4 10             	add    $0x10,%esp
80107b30:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107b33:	76 0d                	jbe    80107b42 <allocuvm+0xd2>
80107b35:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107b38:	8b 45 08             	mov    0x8(%ebp),%eax
80107b3b:	89 fa                	mov    %edi,%edx
80107b3d:	e8 1e fb ff ff       	call   80107660 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80107b42:	83 ec 0c             	sub    $0xc,%esp
80107b45:	56                   	push   %esi
80107b46:	e8 a5 b6 ff ff       	call   801031f0 <kfree>
      return 0;
80107b4b:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80107b4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80107b51:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
80107b53:	5b                   	pop    %ebx
80107b54:	5e                   	pop    %esi
80107b55:	5f                   	pop    %edi
80107b56:	5d                   	pop    %ebp
80107b57:	c3                   	ret    
80107b58:	90                   	nop
80107b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b60:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107b63:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80107b65:	5b                   	pop    %ebx
80107b66:	5e                   	pop    %esi
80107b67:	5f                   	pop    %edi
80107b68:	5d                   	pop    %ebp
80107b69:	c3                   	ret    
80107b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107b70 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107b70:	55                   	push   %ebp
80107b71:	89 e5                	mov    %esp,%ebp
80107b73:	8b 55 0c             	mov    0xc(%ebp),%edx
80107b76:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107b79:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80107b7c:	39 d1                	cmp    %edx,%ecx
80107b7e:	73 10                	jae    80107b90 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107b80:	5d                   	pop    %ebp
80107b81:	e9 da fa ff ff       	jmp    80107660 <deallocuvm.part.0>
80107b86:	8d 76 00             	lea    0x0(%esi),%esi
80107b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107b90:	89 d0                	mov    %edx,%eax
80107b92:	5d                   	pop    %ebp
80107b93:	c3                   	ret    
80107b94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107b9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107ba0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107ba0:	55                   	push   %ebp
80107ba1:	89 e5                	mov    %esp,%ebp
80107ba3:	57                   	push   %edi
80107ba4:	56                   	push   %esi
80107ba5:	53                   	push   %ebx
80107ba6:	83 ec 0c             	sub    $0xc,%esp
80107ba9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107bac:	85 f6                	test   %esi,%esi
80107bae:	74 59                	je     80107c09 <freevm+0x69>
80107bb0:	31 c9                	xor    %ecx,%ecx
80107bb2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107bb7:	89 f0                	mov    %esi,%eax
80107bb9:	e8 a2 fa ff ff       	call   80107660 <deallocuvm.part.0>
80107bbe:	89 f3                	mov    %esi,%ebx
80107bc0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107bc6:	eb 0f                	jmp    80107bd7 <freevm+0x37>
80107bc8:	90                   	nop
80107bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107bd0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107bd3:	39 fb                	cmp    %edi,%ebx
80107bd5:	74 23                	je     80107bfa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107bd7:	8b 03                	mov    (%ebx),%eax
80107bd9:	a8 01                	test   $0x1,%al
80107bdb:	74 f3                	je     80107bd0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
80107bdd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107be2:	83 ec 0c             	sub    $0xc,%esp
80107be5:	83 c3 04             	add    $0x4,%ebx
80107be8:	05 00 00 00 80       	add    $0x80000000,%eax
80107bed:	50                   	push   %eax
80107bee:	e8 fd b5 ff ff       	call   801031f0 <kfree>
80107bf3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107bf6:	39 fb                	cmp    %edi,%ebx
80107bf8:	75 dd                	jne    80107bd7 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80107bfa:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107bfd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c00:	5b                   	pop    %ebx
80107c01:	5e                   	pop    %esi
80107c02:	5f                   	pop    %edi
80107c03:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80107c04:	e9 e7 b5 ff ff       	jmp    801031f0 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80107c09:	83 ec 0c             	sub    $0xc,%esp
80107c0c:	68 bd 8b 10 80       	push   $0x80108bbd
80107c11:	e8 aa 8b ff ff       	call   801007c0 <panic>
80107c16:	8d 76 00             	lea    0x0(%esi),%esi
80107c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107c20 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107c20:	55                   	push   %ebp
80107c21:	89 e5                	mov    %esp,%ebp
80107c23:	56                   	push   %esi
80107c24:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107c25:	e8 76 b7 ff ff       	call   801033a0 <kalloc>
80107c2a:	85 c0                	test   %eax,%eax
80107c2c:	74 6a                	je     80107c98 <setupkvm+0x78>
    return 0;
  memset(pgdir, 0, PGSIZE);
80107c2e:	83 ec 04             	sub    $0x4,%esp
80107c31:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107c33:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80107c38:	68 00 10 00 00       	push   $0x1000
80107c3d:	6a 00                	push   $0x0
80107c3f:	50                   	push   %eax
80107c40:	e8 db d6 ff ff       	call   80105320 <memset>
80107c45:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107c48:	8b 43 04             	mov    0x4(%ebx),%eax
80107c4b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107c4e:	83 ec 08             	sub    $0x8,%esp
80107c51:	8b 13                	mov    (%ebx),%edx
80107c53:	ff 73 0c             	pushl  0xc(%ebx)
80107c56:	50                   	push   %eax
80107c57:	29 c1                	sub    %eax,%ecx
80107c59:	89 f0                	mov    %esi,%eax
80107c5b:	e8 70 f9 ff ff       	call   801075d0 <mappages>
80107c60:	83 c4 10             	add    $0x10,%esp
80107c63:	85 c0                	test   %eax,%eax
80107c65:	78 19                	js     80107c80 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107c67:	83 c3 10             	add    $0x10,%ebx
80107c6a:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107c70:	75 d6                	jne    80107c48 <setupkvm+0x28>
80107c72:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80107c74:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107c77:	5b                   	pop    %ebx
80107c78:	5e                   	pop    %esi
80107c79:	5d                   	pop    %ebp
80107c7a:	c3                   	ret    
80107c7b:	90                   	nop
80107c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80107c80:	83 ec 0c             	sub    $0xc,%esp
80107c83:	56                   	push   %esi
80107c84:	e8 17 ff ff ff       	call   80107ba0 <freevm>
      return 0;
80107c89:	83 c4 10             	add    $0x10,%esp
    }
  return pgdir;
}
80107c8c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
80107c8f:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80107c91:	5b                   	pop    %ebx
80107c92:	5e                   	pop    %esi
80107c93:	5d                   	pop    %ebp
80107c94:	c3                   	ret    
80107c95:	8d 76 00             	lea    0x0(%esi),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80107c98:	31 c0                	xor    %eax,%eax
80107c9a:	eb d8                	jmp    80107c74 <setupkvm+0x54>
80107c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107ca0 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107ca0:	55                   	push   %ebp
80107ca1:	89 e5                	mov    %esp,%ebp
80107ca3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107ca6:	e8 75 ff ff ff       	call   80107c20 <setupkvm>
80107cab:	a3 44 78 12 80       	mov    %eax,0x80127844
80107cb0:	05 00 00 00 80       	add    $0x80000000,%eax
80107cb5:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80107cb8:	c9                   	leave  
80107cb9:	c3                   	ret    
80107cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107cc0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107cc0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107cc1:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107cc3:	89 e5                	mov    %esp,%ebp
80107cc5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107cc8:	8b 55 0c             	mov    0xc(%ebp),%edx
80107ccb:	8b 45 08             	mov    0x8(%ebp),%eax
80107cce:	e8 7d f8 ff ff       	call   80107550 <walkpgdir>
  if(pte == 0)
80107cd3:	85 c0                	test   %eax,%eax
80107cd5:	74 05                	je     80107cdc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107cd7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107cda:	c9                   	leave  
80107cdb:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107cdc:	83 ec 0c             	sub    $0xc,%esp
80107cdf:	68 ce 8b 10 80       	push   $0x80108bce
80107ce4:	e8 d7 8a ff ff       	call   801007c0 <panic>
80107ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107cf0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107cf0:	55                   	push   %ebp
80107cf1:	89 e5                	mov    %esp,%ebp
80107cf3:	57                   	push   %edi
80107cf4:	56                   	push   %esi
80107cf5:	53                   	push   %ebx
80107cf6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107cf9:	e8 22 ff ff ff       	call   80107c20 <setupkvm>
80107cfe:	85 c0                	test   %eax,%eax
80107d00:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107d03:	0f 84 b2 00 00 00    	je     80107dbb <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107d09:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107d0c:	85 c9                	test   %ecx,%ecx
80107d0e:	0f 84 9c 00 00 00    	je     80107db0 <copyuvm+0xc0>
80107d14:	31 f6                	xor    %esi,%esi
80107d16:	eb 4a                	jmp    80107d62 <copyuvm+0x72>
80107d18:	90                   	nop
80107d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107d20:	83 ec 04             	sub    $0x4,%esp
80107d23:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107d29:	68 00 10 00 00       	push   $0x1000
80107d2e:	57                   	push   %edi
80107d2f:	50                   	push   %eax
80107d30:	e8 9b d6 ff ff       	call   801053d0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107d35:	58                   	pop    %eax
80107d36:	5a                   	pop    %edx
80107d37:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
80107d3d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d40:	ff 75 e4             	pushl  -0x1c(%ebp)
80107d43:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107d48:	52                   	push   %edx
80107d49:	89 f2                	mov    %esi,%edx
80107d4b:	e8 80 f8 ff ff       	call   801075d0 <mappages>
80107d50:	83 c4 10             	add    $0x10,%esp
80107d53:	85 c0                	test   %eax,%eax
80107d55:	78 3e                	js     80107d95 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107d57:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107d5d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107d60:	76 4e                	jbe    80107db0 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107d62:	8b 45 08             	mov    0x8(%ebp),%eax
80107d65:	31 c9                	xor    %ecx,%ecx
80107d67:	89 f2                	mov    %esi,%edx
80107d69:	e8 e2 f7 ff ff       	call   80107550 <walkpgdir>
80107d6e:	85 c0                	test   %eax,%eax
80107d70:	74 5a                	je     80107dcc <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107d72:	8b 18                	mov    (%eax),%ebx
80107d74:	f6 c3 01             	test   $0x1,%bl
80107d77:	74 46                	je     80107dbf <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107d79:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
80107d7b:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80107d81:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107d84:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80107d8a:	e8 11 b6 ff ff       	call   801033a0 <kalloc>
80107d8f:	85 c0                	test   %eax,%eax
80107d91:	89 c3                	mov    %eax,%ebx
80107d93:	75 8b                	jne    80107d20 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80107d95:	83 ec 0c             	sub    $0xc,%esp
80107d98:	ff 75 e0             	pushl  -0x20(%ebp)
80107d9b:	e8 00 fe ff ff       	call   80107ba0 <freevm>
  return 0;
80107da0:	83 c4 10             	add    $0x10,%esp
80107da3:	31 c0                	xor    %eax,%eax
}
80107da5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107da8:	5b                   	pop    %ebx
80107da9:	5e                   	pop    %esi
80107daa:	5f                   	pop    %edi
80107dab:	5d                   	pop    %ebp
80107dac:	c3                   	ret    
80107dad:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107db0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80107db3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107db6:	5b                   	pop    %ebx
80107db7:	5e                   	pop    %esi
80107db8:	5f                   	pop    %edi
80107db9:	5d                   	pop    %ebp
80107dba:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
80107dbb:	31 c0                	xor    %eax,%eax
80107dbd:	eb e6                	jmp    80107da5 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80107dbf:	83 ec 0c             	sub    $0xc,%esp
80107dc2:	68 f2 8b 10 80       	push   $0x80108bf2
80107dc7:	e8 f4 89 ff ff       	call   801007c0 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80107dcc:	83 ec 0c             	sub    $0xc,%esp
80107dcf:	68 d8 8b 10 80       	push   $0x80108bd8
80107dd4:	e8 e7 89 ff ff       	call   801007c0 <panic>
80107dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107de0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107de0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107de1:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107de3:	89 e5                	mov    %esp,%ebp
80107de5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107de8:	8b 55 0c             	mov    0xc(%ebp),%edx
80107deb:	8b 45 08             	mov    0x8(%ebp),%eax
80107dee:	e8 5d f7 ff ff       	call   80107550 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107df3:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107df5:	89 c2                	mov    %eax,%edx
80107df7:	83 e2 05             	and    $0x5,%edx
80107dfa:	83 fa 05             	cmp    $0x5,%edx
80107dfd:	75 11                	jne    80107e10 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107dff:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107e04:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107e05:	05 00 00 00 80       	add    $0x80000000,%eax
}
80107e0a:	c3                   	ret    
80107e0b:	90                   	nop
80107e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80107e10:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80107e12:	c9                   	leave  
80107e13:	c3                   	ret    
80107e14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107e1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107e20 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107e20:	55                   	push   %ebp
80107e21:	89 e5                	mov    %esp,%ebp
80107e23:	57                   	push   %edi
80107e24:	56                   	push   %esi
80107e25:	53                   	push   %ebx
80107e26:	83 ec 1c             	sub    $0x1c,%esp
80107e29:	8b 5d 14             	mov    0x14(%ebp),%ebx
80107e2c:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e2f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107e32:	85 db                	test   %ebx,%ebx
80107e34:	75 40                	jne    80107e76 <copyout+0x56>
80107e36:	eb 70                	jmp    80107ea8 <copyout+0x88>
80107e38:	90                   	nop
80107e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107e40:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107e43:	89 f1                	mov    %esi,%ecx
80107e45:	29 d1                	sub    %edx,%ecx
80107e47:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80107e4d:	39 d9                	cmp    %ebx,%ecx
80107e4f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107e52:	29 f2                	sub    %esi,%edx
80107e54:	83 ec 04             	sub    $0x4,%esp
80107e57:	01 d0                	add    %edx,%eax
80107e59:	51                   	push   %ecx
80107e5a:	57                   	push   %edi
80107e5b:	50                   	push   %eax
80107e5c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107e5f:	e8 6c d5 ff ff       	call   801053d0 <memmove>
    len -= n;
    buf += n;
80107e64:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107e67:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80107e6a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107e70:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107e72:	29 cb                	sub    %ecx,%ebx
80107e74:	74 32                	je     80107ea8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107e76:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107e78:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80107e7b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107e7e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107e84:	56                   	push   %esi
80107e85:	ff 75 08             	pushl  0x8(%ebp)
80107e88:	e8 53 ff ff ff       	call   80107de0 <uva2ka>
    if(pa0 == 0)
80107e8d:	83 c4 10             	add    $0x10,%esp
80107e90:	85 c0                	test   %eax,%eax
80107e92:	75 ac                	jne    80107e40 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107e94:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107e97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107e9c:	5b                   	pop    %ebx
80107e9d:	5e                   	pop    %esi
80107e9e:	5f                   	pop    %edi
80107e9f:	5d                   	pop    %ebp
80107ea0:	c3                   	ret    
80107ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ea8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80107eab:	31 c0                	xor    %eax,%eax
}
80107ead:	5b                   	pop    %ebx
80107eae:	5e                   	pop    %esi
80107eaf:	5f                   	pop    %edi
80107eb0:	5d                   	pop    %ebp
80107eb1:	c3                   	ret    
