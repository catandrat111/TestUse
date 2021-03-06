//
//  GCDBasicViewController.m
//  TEST11
//
//  Created by dongjl on 15/9/24.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "GCDBasicViewController.h"



@interface GCDBasicViewController ()

@end

@implementation GCDBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //新建一个串行队列,第一个参数是队列名称，第二个参数对于串行队列必须为NULL或者DISPATCH_QUEUE_SERIAL
    dispatch_queue_t mySerialDispatchQueue = dispatch_queue_create("com.example.gcd.mySerialDispatchQueue", NULL);
    //创建一个并行队列，第一个参数是队列名称，第二个参数必须为
    dispatch_queue_t myConcurrentDispatchQueue = dispatch_queue_create("com.example.gcd.MyConcurrentDispatchQueue", DISPATCH_QUEUE_CONCURRENT);
    
    
    //当我们添加一个任务到队列以后马上释放他，并不会把队列删除，因为往队列中每添加一个任务都会对队列执行retain操作，执行结束以后release。知道最后一个队列执行结束以后，队列自动删除。
    dispatch_async(myConcurrentDispatchQueue, ^{
        NSLog(@"异步操作");
    });
    
    //在Deployment Info小于ios 6的项目来说， dispatch_queue_create函数生成的队列必须要手动释放。在这个版本以后，就是ARC自动释放了。
    //下面这个宏是SDK6.0以后引入的。
#if !OS_OBJECT_USE_OBJC
    dispatch_release(mySerialDispatchQueue);
    dispatch_release(myConcurrentDispatchQueue);
#endif
    //下面这个宏可以得到项目的最低部署SDK版本。
  //  __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000;
    
    
    
    
    //系统提供一个串行主队列，只在主线程上执行代码
    dispatch_queue_t mainDispathQueue = dispatch_get_main_queue();
    
    //调用系统提供的并行队列，总共有四个优先级，内核根据这四种队列的优先级执行里面的任务。
    dispatch_queue_t globalDispatchQueueHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    
    //一般使用模式
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //在这里执行异步的处理
        
        //处理结束后，在主线程执行界面操作
        dispatch_async(dispatch_get_main_queue(), ^{
            //只能在主线程中执行的处理
        });
    });
    
    
    
    //通过dispatch_queue_create生成的队列的优先级都是DISPATCH_QUEUE_PRIORITY_DEFAULT一样的优先级
    //可以通过下面的函数设置队列的优先级
    dispatch_queue_t globalDispatchQueueBackground = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    //把第一个参数的优先级指定与第二个参数的优先级一样。如果第一个参数是系统提供的队列，则结果未确定
    dispatch_set_target_queue(mySerialDispatchQueue, globalDispatchQueueBackground);
    
    
    //如果将必须不可并行执行的处理追加到多个串行队列中。如果使用了dispatch_set_target_queue函数将目标指定为某一个串行队列，则可以防止处理并行执行。
    
    //在指定时间后追加任务到队列，主线程的RunLoop每隔1/60秒循环一次。
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"至少等待3秒钟以后再执行");
    });
//    该方法在那个线程调用，那么run就在哪个线程执行（当前线程），通常是主线程。
//    [self performSelector:@selector(run) withObject:nil afterDelay:3.0];
//    
//    说明：在3秒钟之后，执行run函数
    
    
    dispatch_time_t nowtime = [self getDispatchTimeByDate:[NSDate date]];
    NSLog(@"%@",@(nowtime));
    
    [self test_block];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//把一个NSDate类型转换为dispatch_time_t类型
-(dispatch_time_t) getDispatchTimeByDate:(NSDate *)date{
    NSTimeInterval interval;
    double second,subsecond;
    struct timespec time;
    dispatch_time_t milestone;
    
    interval  = [date timeIntervalSince1970];
    subsecond = modf(interval, &second);
    time.tv_sec = second;
    time.tv_nsec = subsecond * NSEC_PER_SEC;
    milestone = dispatch_walltime(&time, 0);
    
    return milestone;
    
}

//
//_NSConcreteStackBlock
//_NSConcreteGlobalBlock
//_NSConcreteMallocBlock
//他们分别对应的存储区域如下所示：
//
//类	设置对象的存储区域
//_NSConcreteStackBlock	栈
//_NSConcreteGlobalBlock	程序的数据区域(.data区域)
//_NSConcreteMallocBlock	堆

//这段代码我声明了全局的Block变量blk，然后在if语句中定义。如果你不理解block那么就很容易写出这样的代码，其实这段代码是很危险的。因为全局的blk变量是分配在栈上的。在if和else语句中定义的blk内容，编译器会给每个块分配好栈内存，然后等离开了相应的范围之后，编译器有可能把分配给块的内存覆写了。如果编译器未覆写这块栈内存则程序照常运行，如果这块内容被覆写那么程序就会崩溃。解决上面问题的方法就是使用copy方法，将block拷贝到堆中。拷贝完之后就是接下来要将的_NSConcreteMallocBlock类型。该类型是带有引用计数的对象，如果在ARC下，只要引用计数不为0，可以随意的访问，后继的内存管理就交给编译器来完成了
- (void)test_block {
    void (^blk)();
    if (/* DISABLES CODE */ (1)) {
        blk = ^{
            NSLog(@"Block A");
        };
    }else {
        blk = ^{
            NSLog(@"Block B");
        };
    }
    NSLog(@"%@",blk);//2015-09-25 11:21:40.917 TEST11[5181:97516] <__NSGlobalBlock__: 0x101dac270>
    blk();
    
    
    __block int val = 0;
    
    void (^blk1) (void) = [^{val++;} copy];
    
    ++val;
    
    blk1();
    
    NSLog(@"val:%d",val);
}

//http://blog.csdn.net/wuhanbo555/article/details/23770477
-(void)doDispatchSetTargetQueue
{
    NSLog(@"=====dispatch_set_target_queue 用于改变手动创建Queue的优先级=====");
    dispatch_queue_t serialDiapatchQueue=dispatch_queue_create("com.test.queue", NULL);
    dispatch_queue_t dispatchgetglobalqueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_set_target_queue(serialDiapatchQueue, dispatchgetglobalqueue);
    dispatch_async(serialDiapatchQueue, ^{
        NSLog(@"2");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"1");
    });
    //简单的理解为我们自己创建的queue其实是位于global_queue中执行,所以改变global_queue的优先级，也就改变了我们自己所创建的queue的优先级。
    //同时，我们用这个方法可以做到用队列管理子队列
}
//http://justsee.iteye.com/blog/2233252
//修改用户队列的目标队列，使多个serial queue在目标queue上一次只有一个执行：
//它会把需要执行的任务对象指定到不同的队列中去处理，这个任务对象可以是dispatch队列，也可以是dispatch源。而且这个过程可以是动态的，可以实现队列的动态调度管理等等。比如说有两个队列dispatchA和dispatchB，这时把dispatchA指派到dispatchB：
//dispatch_set_target_queue(dispatchA, dispatchB);
//那么dispatchA上还未运行的block会在dispatchB上运行。这时如果暂停dispatchA运行：
//dispatch_suspend(dispatchA);
//则只会暂停dispatchA上原来的block的执行，dispatchB的block则不受影响。而如果暂停dispatchB的运行，则会暂停dispatchA的运行。
//demo：
//一般都是把一个任务放到一个串行的queue中，如果这个任务被拆分了，被放置到多个串行的queue中，但实际还是需要这个任务同步执行，那么就会有问题，因为多个串行queue之间是并行的。这时使用dispatch_set_target_queue将多个串行的queue指定到了同一目标，那么着多个串行queue在目标queue上就是同步执行的，不再是并行执行。
+(void)testTargetQueue {
    dispatch_queue_t targetQueue = dispatch_queue_create("test.target.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue1 = dispatch_queue_create("test.1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("test.2", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue3 = dispatch_queue_create("test.3", DISPATCH_QUEUE_SERIAL);
    
    dispatch_set_target_queue(queue1, targetQueue);
    dispatch_set_target_queue(queue2, targetQueue);
    dispatch_set_target_queue(queue3, targetQueue);
    
    
    dispatch_async(queue1, ^{
        NSLog(@"1 in");
        [NSThread sleepForTimeInterval:3.f];
        NSLog(@"1 out");
    });
    
    dispatch_async(queue2, ^{
        NSLog(@"2 in");
        [NSThread sleepForTimeInterval:2.f];
        NSLog(@"2 out");
    });
    dispatch_async(queue3, ^{
        NSLog(@"3 in");
        [NSThread sleepForTimeInterval:1.f];
        NSLog(@"3 out");
    });
    
}

//输出
//1 in
//1 out
//2 in
//2 out
//3 in
//3 out
@end
