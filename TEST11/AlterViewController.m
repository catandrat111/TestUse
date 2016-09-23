//
//  AlterViewController.m
//  TEST11
//
//  Created by dongjl on 15/12/9.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "AlterViewController.h"
#import "ZHBasicVerificationCodeView.h"
#import "DQAlertView.h"
#import "ZHTelephonyVoiceVerificationCodeView.h"
#import "FBKVOController.h"
#import "UIAlertView+Blocks.h"
#import "SVProgressHUD.h"
//#import <TestFrame/TestFrameTest.h>

//UIWindowLevelNormal;

//UIWindowLevelAlert;
//
//UIWindowLevelStatusBar;
//
//打印出来一次为0.000000   2000.000000  1000.000000


@interface AlterViewController ()
@property (strong,nonatomic) FBKVOController* KVOController;
@property (strong,nonatomic) UIWindow* test_Window;
@property (strong,nonatomic) DQAlertView * alertView;
@end

@implementation AlterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 60, 100, 100)];
    [self.view addSubview:view1];
    
//    UILayoutGuide* layoutGuideA = [[UILayoutGuide alloc] init];
//    UILayoutGuide* layoutGuideB = [[UILayoutGuide alloc] init];
//    [view1 addLayoutGuide:layoutGuideA];
//    [view1 addLayoutGuide:layoutGuideB];
//   // layoutGuideA.heightAnchor.constraintEqualToAnchor(layoutGuideB.heightAnchor).active = true
//    [layoutGuideA.heightAnchor constraintEqualToAnchor:layoutGuideB.heightAnchor].active = YES;
//    // 设置Identifier，为了方便DEBUG
//    
//       [view1 addLayoutGuide:layoutGuideA];
//    [view1 addLayoutGuide:layoutGuideB];
    
  //  NSLog(@"layoutGuideA :%@    /n layoutGuideB:%@",layoutGuideA,layoutGuideB);
   // [self testEWindow1];
    
//    TestFrameTest* test = [[TestFrameTest alloc] init];
//    [test test];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)p1:(UIButton*)sender {
//    sender.titleLabel.text = @"";
//    [sender setTitle:@"" forState:UIControlStateNormal];
    
    
    ZHTelephonyVoiceVerificationCodeView* contentView = [ZHTelephonyVoiceVerificationCodeView new];
//    self.alertView = [[DQAlertView alloc] initWithTitle:@"alterviewalterview" message:nil cancelButtonTitle:@"取消" otherButtonTitle:nil];
//    self.alertView.contentView = contentView;
//    
//    [self.alertView show];
//     //__weak __typeof(alertView)weakSelf = alertView;
//   
//    self.alertView.otherButtonAction = ^{
//        DLog(@"OK Cicked");
//        
//       // [weakSelf dismiss];
//        
//    };
  //    self.name = @"bbb";
//    FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
//    self.KVOController = KVOController;
//    [self performSelector:@selector(test) withObject:nil afterDelay:10];

    // observe clock date property
    //__weak __typeof(self)weakSelf1 = self;
//    [self.KVOController observe:self keyPath:@"name" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
//         __strong __typeof(weakSelf)strongSelf = weakSelf;
//        // update clock view with new value
//        NSString* name1 = change[NSKeyValueChangeNewKey];
//        
//        if ([name1 isEqualToString:@"aaa"]) {
//            if (strongSelf) {
//                [strongSelf dismiss];
//            }
//        }
//    }];
    
    
    self.test_Window = nil;//将当前window释放 原先的window晋级为keywindow
     NSLog(@"%@",UIApplication.sharedApplication.keyWindow);
}

- (void)test {
    self.name = @"aaa";
}

- (void)testWindow {
    for (UIWindow* window in [UIApplication sharedApplication].windows) {
        NSLog(@"%@",window);
    }
    NSLog(@"%@",UIApplication.sharedApplication.keyWindow);
    UIAlertView* alterView = [UIAlertView  showWithTitle:@"dd" message:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        for (UIWindow* window in [UIApplication sharedApplication].windows) {
            NSLog(@"%@",window);
        }
        
        NSLog(@"%@",UIApplication.sharedApplication.keyWindow);
    }];
    
    NSLog(@"%@",UIApplication.sharedApplication.keyWindow);
}

- (void)testEWindow1 {
    NSLog(@"%@",UIApplication.sharedApplication.keyWindow);
    
    self.test_Window = [[UIWindow alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    self.test_Window .backgroundColor = [UIColor redColor];
    [self.test_Window  makeKeyAndVisible];
    NSLog(@"testwindow:%@",UIApplication.sharedApplication.keyWindow);
    for (UIWindow* window in [UIApplication sharedApplication].windows) {
        NSLog(@"%@",window);
    }
    
//    <UIWindow: 0x1568edb0; frame = (0 0; 320 480); gestureRecognizers = <NSArray: 0x156df590>; layer = <UIWindowLayer: 0x156c16c0>>
//    2015-12-15 10:18:14.969 TEST11[2639:121770] testwindow:<UIWindow: 0x156f8b50; frame = (100 300; 100 100); gestureRecognizers = <NSArray: 0x156f8410>; layer = <UIWindowLayer: 0x156f7c40>>
    
    //算上自定义window
//    2015-12-15 10:18:31.510 TEST11[2639:121770] <UIWindow: 0x1568edb0; frame = (0 0; 320 480); gestureRecognizers = <NSArray: 0x156df590>; layer = <UIWindowLayer: 0x156c16c0>>
//    2015-12-15 10:18:34.803 TEST11[2639:121770] <UIWindow: 0x156f8b50; frame = (100 300; 100 100); gestureRecognizers = <NSArray: 0x156f8410>; layer = <UIWindowLayer: 0x156f7c40>>
//    2015-12-15 10:19:21.111 TEST11[2639:121770] <UITextEffectsWindow: 0x1554cc90; frame = (0 0; 320 480); opaque = NO; gestureRecognizers = <NSArray: 0x1554c620>; layer = <UIWindowLayer: 0x1554cb10>>
}
@end
