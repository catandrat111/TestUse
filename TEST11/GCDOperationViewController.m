//
//  GCDOperationViewController.m
//  TEST11
//
//  Created by dongjl on 15/9/25.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "GCDOperationViewController.h"
#import "HCDCreateInvocationOperation.h"
#import "HCDCreateBlockOperation.h"
#import "HCDNonConcurrentOperation.h"
#import "HCDConcurrentOperation.h"

@interface GCDOperationViewController ()

@end

@implementation GCDOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //================================================
    [self FVC_excuteInvocationOperation];
    //================================================
   // [self FVC_excuteBlockOperation];
    //===========================================
    //[self FVC_excuteNonCurrentOperation];
    //==========================================
    //[self FVC_executeCurrentOperation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 在默认情况下，operation 是同步执行的，也就是说在调用它的 start 方法的线程中执行它们的任务。而在 operation 和 operation queue 结合使用时，operation queue 可以为非并发的 operation 提供线程，因此，大部分的 operation 仍然可以异步执行。但是，如果你想要手动地执行一个 operation ，又想这个 operation 能够异步执行的话，你需要做一些额外的配置来让你的 operation 支持并发执行。
 */
#pragma mark 执行并发执行的operation,并且可以手动启动
- (void)FVC_executeCurrentOperation{
    HCDConcurrentOperation *currentOperation = [[HCDConcurrentOperation alloc]init];
    [currentOperation setCompletionBlock:^{
        NSLog(@"====完成了===");
    }];
    [currentOperation start];
    NSLog(@"自定义ConcurrentOperation实现异步执行");
}


#pragma mark 执行非并发执行的operation
- (void)FVC_excuteNonCurrentOperation{
    NSData *data = [@"hello world" dataUsingEncoding:NSUTF8StringEncoding];
    HCDNonConcurrentOperation *nonCurrentOpreation = [[HCDNonConcurrentOperation alloc]initWithData:data];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:nonCurrentOpreation];
    [queue addOperationWithBlock:^{
        NSLog(@"当前线程%@",[NSThread currentThread]);
    }];
    NSLog(@"自定义NonConcurrentOperation是异步执行");
}

#pragma mark 执行BlockOperation
- (void)FVC_excuteBlockOperation{
    HCDCreateBlockOperation *creatBlockOperation = [[HCDCreateBlockOperation alloc]init];
    NSBlockOperation *blockOperation = [creatBlockOperation blockOperation];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:blockOperation];
    [queue addOperationWithBlock:^{
        NSLog(@"当前线程%@",[NSThread currentThread]);
    }];
    NSLog(@"NSBlockOperation是异步执行");
    
    
//    2015-09-25 14:23:08.734 TEST11[6057:162314] NSBlockOperation是异步执行
//    2015-09-25 14:23:08.734 TEST11[6057:162606] 当前线程<NSThread: 0x7fd8e1579af0>{number = 2, name = (null)}
//    2015-09-25 14:23:08.735 TEST11[6057:162652] Start executing block3, mainThread: <NSThread: 0x7fd8e1601a40>{number = 1, name = (null)}, currentThread: <NSThread: 0x7fd8e160a850>{number = 5, name = (null)}
//    2015-09-25 14:23:08.735 TEST11[6057:162603] Start executing block2, mainThread: <NSThread: 0x7fd8e1601a40>{number = 1, name = (null)}, currentThread: <NSThread: 0x7fd8e157a400>{number = 4, name = (null)}
//    2015-09-25 14:23:08.735 TEST11[6057:162420] Start executing block1, mainThread: <NSThread: 0x7fd8e1601a40>{number = 1, name = (null)}, currentThread: <NSThread: 0x7fd8e170e600>{number = 3, name = (null)}
//    2015-09-25 14:23:11.796 TEST11[6057:162420] Finish executing block1
//    2015-09-25 14:23:11.796 TEST11[6057:162652] Finish executing block3
//    2015-09-25 14:23:11.796 TEST11[6057:162603] Finish executing block2
}

#pragma mark 执行InvocationOperation
- (void)FVC_excuteInvocationOperation{
    HCDCreateInvocationOperation *createInvocationOperation = [[HCDCreateInvocationOperation alloc] init];
    
    NSData *data = [@"hello world" dataUsingEncoding:NSUTF8StringEncoding];
    NSInvocationOperation *invocationOperation = [createInvocationOperation invocationOperationWithData:data];
    NSInvocationOperation *invocationOperationWithSelecter = [createInvocationOperation invocationOperationWithData:data userInput:@"myTaskMethod2"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:invocationOperation];
    [queue addOperation:invocationOperationWithSelecter];
    [queue addOperationWithBlock:^{
        NSLog(@"当前线程%@",[NSThread currentThread]);
    }];
    NSLog(@"NSInvocationOperation是异步执行");
    
//    2015-09-25 14:33:43.605 TEST11[6168:166698] NSInvocationOperation是异步执行
//    2015-09-25 14:33:43.605 TEST11[6168:166877] 当前线程<NSThread: 0x7fc78603b930>{number = 3, name = (null)}
//    2015-09-25 14:33:43.605 TEST11[6168:166782] Start executing myTaskMethod2: with dataString: hello world, mainThread: <NSThread: 0x7fc783d02040>{number = 1, name = (null)}, currentThread: <NSThread: 0x7fc783e5c390>{number = 2, name = (null)}
//    2015-09-25 14:33:43.606 TEST11[6168:166774] Start executing myTaskMethod1: with dataString: hello world, mainThread: <NSThread: 0x7fc783d02040>{number = 1, name = (null)}, currentThread: <NSThread: 0x7fc783c0d410>{number = 4, name = (null)}
//    2015-09-25 14:33:46.678 TEST11[6168:166782] Finish executing myTaskMethod2:
//    2015-09-25 14:33:46.678 TEST11[6168:166774] Finish executing myTaskMethod1:

}

@end
