//
//  GCDNotificationViewController.m
//  TEST11
//
//  Created by dongjl on 15/9/24.
//  Copyright © 2015年 djl. All rights reserved.
//
//参见http://southpeak.github.io/blog/2015/03/14/nsnotificationyu-duo-xian-cheng/
#import "GCDNotificationViewController.h"

@interface GCDNotificationViewController ()<NSMachPortDelegate>
@property (nonatomic) NSMutableArray    *notifications;         // 通知队列
@property (nonatomic) NSThread          *notificationThread;    // 期望线程
@property (nonatomic) NSLock            *notificationLock;      // 用于对通知队列加锁的锁对象，避免线程冲突
@property (nonatomic) NSMachPort        *notificationPort;      // 用于向期

@end

@implementation GCDNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testNotification1]; //测试Notification的发送与接收处理都是在同一个线程中
    [self testNotification2];//子线程推送 主线程接收  （一般推送和接收实在同一个线程）
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)testNotification1 {
    NSLog(@"current thread = %@", [NSThread currentThread]);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"TEST_NOTIFICATION" object:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TEST_NOTIFICATION" object:nil userInfo:nil];
    });

}
//Notification的发送与接收处理都是在同一个线程中 多线程应用中，Notification在哪个线程中post，就在哪个线程中被转发，而不一定是在注册观察者的那个线程中。
- (void)handleNotification:(NSNotification *)notification
{
    NSLog(@"current thread = %@", [NSThread currentThread]);
    
    NSLog(@"test notification");
//    2015-09-24 17:40:55.239 TEST11[3138:351319] current thread = <NSThread: 0x175246e0>{number = 1, name = main}
//    2015-09-24 17:40:55.243 TEST11[3138:351541] current thread = <NSThread: 0x17692220>{number = 2, name = (null)}
//    2015-09-24 17:40:55.244 TEST11[3138:351541] test notification
}

- (void)testNotification2 {
    NSLog(@"current thread = %@", [NSThread currentThread]);
    
    // 初始化
    self.notifications = [[NSMutableArray alloc] init];
    self.notificationLock = [[NSLock alloc] init];
    
    self.notificationThread = [NSThread currentThread];
    self.notificationPort = [[NSMachPort alloc] init];
    self.notificationPort.delegate = self;
    
    // 往当前线程的run loop添加端口源
    // 当Mach消息到达而接收线程的run loop没有运行时，则内核会保存这条消息，直到下一次进入run loop
    [[NSRunLoop currentRunLoop] addPort:self.notificationPort
                                forMode:(__bridge NSString *)kCFRunLoopCommonModes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processNotification:) name:@"TEST_NOTIFICATION" object:nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TEST_NOTIFICATION" object:nil userInfo:nil];
        
    });
    
}


#pragma mark NSMachPortDelegate代理方法
-(void)handleMachMessage:(void *)msg{
    [self.notificationLock lock];
    
    while ([self.notifications count]) {
        NSNotification *notification = [self.notifications objectAtIndex:0];
        [self.notifications removeObjectAtIndex:0];
        [self.notificationLock unlock];
        [self processNotification:notification];
        [self.notificationLock lock];
    };
    
    [self.notificationLock unlock];
}

- (void)processNotification:(NSNotification *)notification {
    
    if ([NSThread currentThread] != _notificationThread) {
        // 如果当前线程不在要求的线程。转换到那个线程。
        [self.notificationLock lock];
        [self.notifications addObject:notification];
        [self.notificationLock unlock];
        //会调用代理方法
        [self.notificationPort sendBeforeDate:[NSDate date]
                                   components:nil
                                         from:nil
                                     reserved:0];
    }
    else {
        // Process the notification here;
        NSLog(@"current thread = %@", [NSThread currentThread]);
        NSLog(@"process notification");
    }
}

@end
