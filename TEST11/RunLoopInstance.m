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
static int count;
@interface RunLoopInstance ()
{
    
    __weak id reference;
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
    reference = str;
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
    (kCFAllocatorDefault, kCFRunLoopBeforeWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity _) {
        NSLog(@"reference:%@", reference);
        NSLog(@"reference1:%@", reference1);
    
    });
    
    //CFRunLoopAddObserver(runLoop, observer, runLoopMode);
}




-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@", reference);
     NSLog(@"%@", reference1);
    
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"%@", reference);
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
    
    @autoreleasepool {
       // Person* person = [Person new];
    }//到这释放
    NSLog(@"%@",[NSThread currentThread]);
    [self test];

    

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
        NSRunLoop* loop = [NSRunLoop currentRunLoop];
        CFRunLoopObserverRef observerRef = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runloopObserverCallback, &context);
        CFRunLoopAddObserver([[NSRunLoop currentRunLoop] getCFRunLoop], observerRef, kCFRunLoopCommonModes);
        [loop run];

    }
   
    
}

-(void)p3{
    GestureViewController* ges = [GestureViewController new];
    [self.navigationController pushViewController:ges animated:YES];
}

-(void)onTimerFired:(id)sender{
    
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
