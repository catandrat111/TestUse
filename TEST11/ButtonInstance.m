//
//  ButtonInstance.m
//  TEST11
//
//  Created by 董金亮 on 15/7/19.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "ButtonInstance.h"
#import "UIButton+BackgroundColor.h"
#import "UIButton+CountDown.h"
#import "UIButton+Indicator.h"
#import "UIButton+Submitting.h"
#import  <objc/runtime.h>
#import "NSString+Score.h"
#import "UIAlertView+Blocks.h"
#import "TextFieldInstanceView.h"
#import "ZHAdvertisementView.h"
#import "RNBlurModalView.h"

#define alterViewDisapperTime 0.5
@interface ButtonInstance ()

@end

@implementation ButtonInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.button1 setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.button1 showIndicator];
    
    //[self.button2 startTime:5 title:@"hello" waitTittle:@"world"];
    
     [self.button3 beginSubmitting:@"ddd"];
    
    NSString* foidStr = [NSString stringWithFormat:@"%@",@"12345"];
    NSMutableString* matchstr = [[NSMutableString alloc] init];
    for (int i = 0; i < foidStr.length -2 ;i++) {
       [matchstr appendString:@"*"];
    }
    
    
    foidStr = [foidStr stringByReplacingCharactersInRange:NSMakeRange(1, foidStr.length -2) withString:matchstr];
    
    
    self.lab.text = @"ffffsdfcdsfvdsgvf";
   CGSize size =  [self.lab sizeThatFits:CGSizeMake(self.lab.frameWidth, 0)];
    self.lab.frameHeight = size.height;
    
    self.imgView.image = [UIImage imageNamed:@"Selected"];
    [self configureButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)p1:(UIButton*)sender{
    [self.button1 endSubmitting];
}

-(IBAction)p2:(UIButton*)sender{
    [self.button1 hideIndicator];
    [self.button3 endSubmitting];
    self.lab.frameHeight = 41.0f;
     //NSString *message = [NSString stringWithFormat:@"\"%@\"，在去程飞机起飞日期时，年龄未超过12周岁，但在返程飞机起飞日期时，年龄已超过12周岁，因此无法以“儿童”身份购买往返儿童票。您可以重新预订两个单程订单，购买一张儿童票，一张成人票。",@"aa"];
//    [UIAlertView showWithTitle:@"提示" message:message cancelButtonTitle:nil otherButtonTitles:@[@"确定",@"返回"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
//        dispatch_async(dispatch_get_main_queue(), ^{//有cancle 为0 ，没有其他从0开始
//                       if (buttonIndex == 0) {
//                        }
//                       else if(buttonIndex == 1){
//                           
//                       }
//                       else {
//                       }
//        });
//        
//    }];
    
//    __weak __typeof(self)weakSelf = self;
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您已成功注册四川航空APP会员" delegate:nil  cancelButtonTitle:nil otherButtonTitles:nil];
//    [alert show];
//    [weakSelf performSelector:@selector(dimissAlert:) withObject:alert afterDelay:alterViewDisapperTime];
    
//    //TEST
//    ZHAdvertisementView* advertisementView = [[ZHAdvertisementView alloc] initWithFrame:CGRectZero];
//    advertisementView.titleLab.text = @"dd";
//    advertisementView.activityLab1.text = @"dddd";
//    advertisementView.backgroundColor = [UIColor greenColor];
//    
////    RNBlurModalView * modal = [[RNBlurModalView alloc] initWithView:advertisementView];
////    advertisementView.modalView = modal;
////    [modal show];
//    
//    [[[UIApplication sharedApplication].delegate window].rootViewController.view  addSubview:advertisementView];
//
//    advertisementView.center = [[UIApplication sharedApplication].delegate window].rootViewController.view.center;
//    TextFieldInstanceView* test = [[TextFieldInstanceView alloc] init];
//    [self.navigationController pushViewController:test animated:YES];
//    
//    for (UIView* v1 in [[UIApplication sharedApplication].delegate window].rootViewController.view.subviews) {
//        NSLog(@"%@",v1);;
//    }
    
}

-(IBAction)p3:(UIButton*)sender{
    
}


- (void) dimissAlert:(UIAlertView *)alert {
    if(alert)     {
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
//http://natashatherobot.com/ios-stretchable-button-uiedgeinsetsmake/
//STRETCG_FULL
- (void)configureButton
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIImage *backgroundButtonImage = [[UIImage imageNamed:@"purple_button.png"]
                                      resizableImageWithCapInsets:edgeInsets];
    [self.stretchButton setBackgroundImage:backgroundButtonImage
                                 forState:UIControlStateNormal];
}
//stretch_vertically
- (void)configureButton1
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
    UIImage *backgroundButtonImage = [[UIImage imageNamed:@"purple_button.png"]
                                      resizableImageWithCapInsets:edgeInsets];
    [self.stretchButton setBackgroundImage:backgroundButtonImage
                                 forState:UIControlStateNormal];
}

//stretch_horizontal
- (void)configureButton2
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(8, 0, 8, 0);
    UIImage *backgroundButtonImage = [[UIImage imageNamed:@"purple_button.png"]
                                      resizableImageWithCapInsets:edgeInsets];
    [self.stretchButton setBackgroundImage:backgroundButtonImage
                                 forState:UIControlStateNormal];
}

- (void)configureButton3
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    UIImage *backgroundButtonImage = [[UIImage imageNamed:@"purple_button.png"]
                                      resizableImageWithCapInsets:edgeInsets];
    [self.stretchButton setBackgroundImage:backgroundButtonImage
                                 forState:UIControlStateNormal];
}
@end
