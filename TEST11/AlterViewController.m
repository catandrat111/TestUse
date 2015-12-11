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
@interface AlterViewController ()
@property (strong,nonatomic) FBKVOController* KVOController;
@end

@implementation AlterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)p1:(UIButton*)sender {
//    sender.titleLabel.text = @"";
//    [sender setTitle:@"" forState:UIControlStateNormal];
    
    
    ZHTelephonyVoiceVerificationCodeView* contentView = [ZHTelephonyVoiceVerificationCodeView new];
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:@"alterviewalterview" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确认"];
    alertView.contentView = contentView;
    
    [alertView show];
     //__weak __typeof(alertView)weakSelf = alertView;
   
    alertView.otherButtonAction = ^{
        DLog(@"OK Cicked");
        
       // [weakSelf dismiss];
        
    };
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

}

- (void)test {
    self.name = @"aaa";
}
@end
