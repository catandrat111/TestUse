//
//  LockViewController.m
//  TEST11
//
//  Created by dongjl on 15/11/13.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "LockViewController.h"
#import "KCImageData.h"
#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10
#define IMAGE_COUNT 9

//假设现在有9张图片，但是有15个线程都准备加载这9张图片，约定不能重复加载同一张图片，这样就形成了一个资源抢夺的情况。在下面的程序中将创建9张图片，每次读取照片链接时首先判断当前链接数是否大于1，用完一个则立即移除，最多只有9个。在使用同步方法之前先来看一下错误的写法：

//OS中对于资源抢占的问题可以使用同步锁NSLock来解决，使用时把需要加锁的代码（以后暂时称这段代码为”加锁代码“）放到NSLock的lock和unlock之间，一个线程A进入加锁代码之后由于已经加锁，另一个线程B就无法访问，只有等待前一个线程A执行完加锁代码后解锁，B线程才能访问加锁代码。需要注意的是lock和unlock之间的”加锁代码“应该是抢占资源的读取和修改代码，不要将过多的其他操作代码放到里面，否则一个线程执行的时候另一个线程就一直在等待，就无法发挥多线程的作用了。

//另外，在上面的代码中”抢占资源“_imageNames定义成了成员变量，这么做是不明智的，应该定义为“原子属性”。对于被抢占资源来说将其定义为原子属性是一个很好的习惯，因为有时候很难保证同一个资源不在别处读取和修改。nonatomic属性读取的是内存数据（寄存器计算好的结果），而atomic就保证直接读取寄存器的数据，这样一来就不会出现一个线程正在修改数据，而另一个线程读取了修改之前（存储在内存中）的数据，永远保证同时只有一个线程在访问一个属性。
//
//下面的代码演示了如何使用NSLock进行线程同步：
@interface LockViewController (){
    NSMutableArray *_imageViews;
    NSLock *_lock;
    dispatch_semaphore_t _semaphore;//定义一个信号量
}

@end

@implementation LockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}

#pragma mark 界面布局
-(void)layoutUI{
    //创建多个图片控件用于显示图片
    _imageViews=[NSMutableArray array];
    for (int r=0; r<ROW_COUNT; r++) {
        for (int c=0; c<COLUMN_COUNT; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING                           ), ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
            
        }
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //创建图片链接
    _imageNames=[NSMutableArray array];
    for (int i=0; i<IMAGE_COUNT; i++) {
        [_imageNames addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i]];
    }
    
    //初始化锁对象
    _lock=[[NSLock alloc]init];
    /*初始化信号量
     参数是信号量初始值
     */
    _semaphore=dispatch_semaphore_create(1);
    
}

#pragma mark 将图片显示到界面
-(void)updateImageWithData:(NSData *)data andIndex:(NSInteger )index{
    UIImage *image=[UIImage imageWithData:data];
    UIImageView *imageView= _imageViews[index];
    imageView.image=image;
}

#pragma mark 请求图片数据
-(NSData *)requestData:(NSInteger )index{
    NSData *data;
    NSString *name;
    //加锁
    [_lock lock];
    if (_imageNames.count>0) {
        name=[_imageNames lastObject];
        [_imageNames removeObject:name];
    }
    //使用完解锁
    [_lock unlock];
    if(name){
        NSURL *url=[NSURL URLWithString:name];
        data=[NSData dataWithContentsOfURL:url];
    }
    return data;
}
//使用@synchronized解决线程同步问题相比较NSLock要简单一些，日常开发中也更推荐使用此方法。首先选择一个对象作为同步对象（一般使用self），然后将”加锁代码”（争夺资源的读取、修改代码）放到代码块中。@synchronized中的代码执行时先检查同步对象是否被另一个线程占用，如果占用该线程就会处于等待状态，直到同步对象被释放。下面的代码演示了如何使用@synchronized进行线程同步：


-(NSData *)requestData1:(int )index{
    NSData *data;
    NSString *name;
    //线程同步
    @synchronized(self){
        if (_imageNames.count>0) {
            name=[_imageNames lastObject];
            [NSThread sleepForTimeInterval:0.001f];
            [_imageNames removeObject:name];
        }
    }
    if(name){
        NSURL *url=[NSURL URLWithString:name];
        data=[NSData dataWithContentsOfURL:url];
    }
    return data;
}
//GCD中信号量是dispatch_semaphore_t类型，支持信号通知和信号等待。每当发送一个信号通知，则信号量+1；每当发送一个等待信号时信号量-1,；如果信号量为0则信号会处于等待状态，直到信号量大于0开始执行。根据这个原理我们可以初始化一个信号量变量，默认信号量设置为1，每当有线程进入“加锁代码”之后就调用信号等待命令（此时信号量为0）开始等待，此时其他线程无法进入，执行完后发送信号通知（此时信号量为1），其他线程开始进入执行，如此一来就达到了线程同步目的。
-(NSData *)requestData2:(NSInteger )index{
    NSData *data;
    NSString *name;
    
    /*信号等待
     第二个参数：等待时间
     */
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    if (_imageNames.count>0) {
        name=[_imageNames lastObject];
        [_imageNames removeObject:name];
    }
    //信号通知
    dispatch_semaphore_signal(_semaphore);
    
    
    if(name){
        NSURL *url=[NSURL URLWithString:name];
        data=[NSData dataWithContentsOfURL:url];
    }
    
    return data;
}

#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index{
    NSInteger i=[index integerValue];
    //请求数据
    NSData *data= [self requestData:i];
    //更新UI界面,此处调用了GCD主线程队列的方法
    dispatch_queue_t mainQueue= dispatch_get_main_queue();
    dispatch_sync(mainQueue, ^{
        [self updateImageWithData:data andIndex:i];
    });
}

#pragma mark 多线程下载图片
////前面也说过使用同步锁时如果一个线程A已经加锁，线程B就无法进入。那么B怎么知道是否资源已经被其他线程锁住呢？可以通过tryLock方法，此方法会返回一个BOOL型的值，如果为YES说明获取锁成功，否则失败。另外还有一个lockBeforeData:方法指定在某个时间内获取锁，同样返回一个BOOL值，如果在这个时间内加锁成功则返回YES，失败则返回NO。
-(void)loadImageWithMultiThread{
    int count=ROW_COUNT*COLUMN_COUNT;
    
    dispatch_queue_t globalQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建多个线程用于填充图片
    for (int i=0; i<count; ++i) {
        //异步执行队列任务
        dispatch_async(globalQueue, ^{
            [self loadImage:[NSNumber numberWithInt:i]];
        });
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
