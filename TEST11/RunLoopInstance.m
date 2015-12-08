//
//  RunLoopViewInstanceViewController.m
//  TEST11
//
//  Created by dongjl on 15-8-26.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "RunLoopInstance.h"
#import "Person.h"
#import "User.h"
#import "GestureViewController.h"
#import "RunLoopTestModel.h"
#define kCheckinMessage 100
#import "MyWorkerClass.h"
static int count;
@interface RunLoopInstance ()<NSMachPortDelegate>
{
    
    __weak id reference2;
     __weak id reference1;

}
@end

@implementation RunLoopInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    count = 0;
   // User* user = [User new];
    UIButton* button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, 100, 60)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"1" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(p2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton* button1  = [[UIButton alloc] initWithFrame:CGRectMake(0, 130, 100, 60)];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 setTitle:@"2" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(p3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton* button2  = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 100, 60)];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button2 setTitle:@"3" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(p4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];


    
      NSLog(@"%@",[NSThread currentThread]);
    RunLoopTestModel* model = [RunLoopTestModel new];
    
    NSString *str = [NSString stringWithFormat:@"sunnyxx"];
    // str是一个autorelease对象，设置一个weak的引用来观察它
    @autoreleasepool {
         reference2 = [NSString stringWithFormat:@"sunnyxx"];
    }
  
    reference1 = model;
    NSLog(@"%@", reference1);
      NSLog(@"%@",[NSThread currentThread]);
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    
    // This is a idle mode of RunLoop, when UIScrollView scrolls, it jumps into "UITrackingRunLoopMode"
    // and won't perform any cache task to keep a smooth scroll.
    CFStringRef runLoopMode = kCFRunLoopDefaultMode;
    
    // Collect all index paths to be precached.
    
    // Setup a observer to get a perfect moment for precaching tasks.
    // We use a "kCFRunLoopBeforeWaiting" state to keep RunLoop has done everything and about to sleep
    // (mach_msg_trap), when all tasks finish, it will remove itself.
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler
    (kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity _) {
        NSLog(@"reference:%@", reference2);
        NSLog(@"reference1:%@", reference1);
    
    });
    
    CFRunLoopAddObserver(runLoop, observer, runLoopMode);
//    [self  runUntilBlock:^BOOL{
//        NSLog(@"reference:%@", reference2);
//        NSLog(@"reference1:%@", reference1);
//        return YES;
//    } timeout:180000];
 
}




-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@", reference2);
     NSLog(@"%@", reference1);
    
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"%@", reference2);
     NSLog(@"%@", reference1);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)p4 {
   
        [self test];

   
}

+(void)initialize{
    
}

/*
typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
    kCFRunLoopEntry         = (1UL << 0), // 即将进入Loop
    kCFRunLoopBeforeTimers  = (1UL << 1), // 即将处理 Timer
    kCFRunLoopBeforeSources = (1UL << 2), // 即将处理 Source
    kCFRunLoopBeforeWaiting = (1UL << 5), // 即将进入休眠
    kCFRunLoopAfterWaiting  = (1UL << 6), // 刚从休眠中唤醒
    kCFRunLoopExit          = (1UL << 7), // 即将退出Loop
};
 */

static void runloopObserverCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    CFRunLoopActivity currentActivity = activity;
    switch (currentActivity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry \n");
            break;
            
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers \n");
            break;
            
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources \n");
            break;
            
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting \n");
            break;
            
        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopAfterWaiting \n");
            break;
            
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit \n");
            break;
            
        default:
            NSLog(@"Activity not recognized!\n");
            break;
    }
}

-(void)p2{
    // 子线程加入timer 需要timer周期性唤醒 如果加入输入源 输入员有事件才会唤醒
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            // Person* person = [Person new];
        }//到这释放
        NSLog(@"%@",[NSThread currentThread]);
        //[self test];
        
        
        
        if (count == 0) {
            count++;
            NSRunLoop *runloop = [NSRunLoop currentRunLoop];
            if (!runloop) {
                return ;
            }
            
            // NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(onTimerFired:) userInfo:nil repeats:NO];
            //[runloop addTimer:timer forMode:NSRunLoopCommonModes];
            CFRunLoopObserverContext context = {
                0,
                (__bridge void *)(self),
                NULL,
                NULL,
                NULL
            };
           
            CFRunLoopObserverRef observerRef = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runloopObserverCallback, &context);
            CFRunLoopAddObserver([[NSRunLoop currentRunLoop] getCFRunLoop], observerRef, kCFRunLoopCommonModes);
           // [loop run];
            
            // Create and schedule the timer.
            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self
                                           selector:@selector(doFireTimer:) userInfo:nil repeats:YES];
            
            NSInteger    loopCount = 10;
            do
            {
                // Run the run loop 10 times to let the timer fire.
                [runloop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
                loopCount--;
            }
            while (loopCount);
            
        }

    });
    
}


- (void)doFireTimer:(NSTimer*)timer {
    
}

- (void)p3 {
    GestureViewController* ges = [GestureViewController new];
    [self.navigationController pushViewController:ges animated:YES];
}

- (void)p5 {
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopTimerContext context = {0, NULL, NULL, NULL, NULL};
    CFRunLoopTimerRef timer = CFRunLoopTimerCreate(kCFAllocatorDefault, 0.1, 0.3, 0, 0,
                                                   &myCFTimerCallback, &context);
    
    CFRunLoopAddTimer(runLoop, timer, kCFRunLoopCommonModes);
    
    
    NSRunLoop* myRunLoop = [NSRunLoop currentRunLoop];
    // Create and schedule the first timer.
    NSDate* futureDate = [NSDate dateWithTimeIntervalSinceNow:1.0];
    NSTimer* myTimer = [[NSTimer alloc] initWithFireDate:futureDate
                                                interval:0.1
                                                  target:self
                                                selector:@selector(myDoFireTimer1:)
                                                userInfo:nil
                                                 repeats:YES];
    [myRunLoop addTimer:myTimer forMode:NSDefaultRunLoopMode];
    
    // Create and schedule the second timer.
    [NSTimer scheduledTimerWithTimeInterval:0.2
                                     target:self
                                   selector:@selector(myDoFireTimer2:)
                                   userInfo:nil
                                    repeats:YES];

}

static void myCFTimerCallback() {
    
}

-(void)onTimerFired:(id)sender{
    
}

// Handle responses from the worker thread.
- (void)handlePortMessage:(NSPortMessage *)portMessage
{
//    unsigned int message = [portMessage msgid];
//    NSPort* distantPort = nil;
//    
//    if (message == kCheckinMessage)
//    {
//        // Get the worker thread’s communications port.
//        distantPort = [portMessage sendPort];
//        
//        // Retain and save the worker port for later use.
//        [self storeDistantPort:distantPort];
//    }
//    else
//    {
//        // Handle other messages.
//    }
}


- (void)launchThread
{
    NSPort* myPort = [NSMachPort port];
    if (myPort)
    {
        // This class handles incoming port messages.
        [myPort setDelegate:self];
        
        // Install the port as an input source on the current run loop.
        [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
        
        // Detach the thread. Let the worker release the port.
        [NSThread detachNewThreadSelector:@selector(LaunchThreadWithPort:)
                                 toTarget:self withObject:myPort];
    }
}

- (void)LaunchThreadWithPort:(id)sender {
    
}

- (BOOL)runUntilBlock:(BOOL(^)())block timeout:(NSTimeInterval)timeout{
     NSLog(@"%@",[NSThread currentThread]);
    __block Boolean fulfilled = NO;
    void (^beforeWaiting) (CFRunLoopObserverRef observer, CFRunLoopActivity activity) =
    ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        fulfilled = block();
        if (fulfilled) {
            CFRunLoopStop(CFRunLoopGetCurrent());
        }
    };
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopBeforeWaiting, true, 0, beforeWaiting);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    // Run!
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, timeout, false);
    
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
    
    return fulfilled;
}

-(Person*)strWithWithTest{
    Person* p1 = [[Person alloc] init];
    return p1;
}

-(void)test{
    Person* person = [self strWithWithTest];
    sleep(5.0);
    NSLog(@"%@",person);
}

@end
