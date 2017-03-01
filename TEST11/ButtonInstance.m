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
#import "DQAlertView.h"
#import "RMUniversalAlert.h"
#import <DIOpenSDK/DIOpenSDK.h>
#define alterViewDisapperTime 0.5
#import <PassKit/PassKit.h>
#import "AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "PHPhotoLibrary+ZHCustomPhotoAlbum.h"
#import "SVProgressHUD.h"
#import "WXApi.h"
#import "ZHGTHelper.h"
#include <CoreFoundation/CFRunLoop.h>
#import "ReactiveCocoa.h"
@interface ButtonInstance ()<DIOpenSDKDelegate>
@property(nonatomic,strong) ZHGTHelper* helper;
@end

@implementation ButtonInstance

- (void)viewDidLoad {
    [super viewDidLoad];
//[self.button1 setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
   // [self.button1 showIndicator];
    
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
    
  //  self.imgView.image = [UIImage imageNamed:@"Selected"];
    [self configureButton];
    

    CABasicAnimation* animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.duration = 2;
    animation.fromValue = @(0);
    animation.toValue = @(2* M_PI);
    animation.repeatCount = 10000;
    [self.imgView2.layer addAnimation:animation forKey:nil];
    
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 50, 80) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = UIColorFromRGB(0xff3476).CGColor;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    shapeLayer.lineWidth = 2.0f;
    [self.view.layer addSublayer:shapeLayer];
   
    self.navigationController.navigationBar.translucent = YES;
    @weakify(self);
    
    [RACObserve(self, testStr) subscribeNext:^(NSString *newName) {
        NSLog(@"%@", newName);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"Button appear");
}

-(IBAction)p1:(UIButton*)sender{
    //[self.button1 endSubmitting];
    NSLog(@"hello");
    // self.testStr = @"aaa";
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [NSRunLoop currentRunLoop];
//        CFRunLoopRun();
//       // CFRunLoopRunResult  result1 = CFRunLoopRunInMode( kCFRunLoopDefaultMode, 1.0e10, NO);
//        NSLog(@"End RunLoop");
//    
//    });
    
//    while (!self.isFinish) {
//        NSLog(@"Begin RunLoop");
//       // [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//      CFRunLoopRunResult  result = CFRunLoopRunInMode( kCFRunLoopDefaultMode, 1.0e10, NO);
//        NSLog(@"End RunLoop");
//    }
    [self useSafe];
}

- (void)useSafe {
    NSArray* arr = @[@"df",nil];
    NSString* a =  [arr objectAtIndex:1];
}

-(IBAction)p12:(id)sender {
      [SVProgressHUD showErrorWithStatus:@"系统原因，无法访问相册"];
     return;
}

- (void)p55 {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        //[SVProgressHUD dismiss];
//    });

}

-(IBAction)p5:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [SVProgressHUD showWithStatus:@"请稍候" maskType:SVProgressHUDMaskTypeGradient];
       
    });
    
    [self performSelector:@selector(p55) withObject:nil afterDelay:5];
  //[SVProgressHUD showWithStatus:@"请稍候" maskType:SVProgressHUDMaskTypeGradient];
    

    
    //  [SVProgressHUD showErrorWithStatus:@"保存成功"];
    return;
    
    NSArray *test=@[@"123",@"444"];
    id testID=test[5];
    return;
       
    [WXApi registerApp:@"wxeb8210e6bb741258"];
    PayReq* req =[[PayReq alloc] init];
    req.partnerId = @"1298908101";
    req.prepayId = @"wx201610251336580a2765a3150671000179";
    req.nonceStr = @"P4FDX2Z9J46057R7Y5I53620R2IF54RX";
    
    req.timeStamp = 1477373554;
    req.package = @"Sign=WXPay";
    req.sign = @"DB683F25806102A75AD02DA444FB4CDC";
   // DLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    [WXApi sendReq:req];
    return;
    
    [PHPhotoLibrary saveImage:[UIImage imageNamed:@"stretch2.png"] toAlbum:@"hello" withCompletionBlock:^(NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showErrorWithStatus:@"保存失败"];
            });
           
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                 [SVProgressHUD showErrorWithStatus:@"保存成功"];
            });
          
            
        }
    }];

    return;
    
//    self.lab.text = @"HELLO ";
//    self.view.backgroundColor = [UIColor redColor];
//    self.button5.backgroundColor = [UIColor yellowColor];
//    self.button5.layer.cornerRadius = 5.0f;
//    self.button5.frameHeight = 90;
//    NSArray* arr = @[@"asd"];
//    
//    CGFloat alpha = self.navigationController.navigationBar.alpha;
//    self.navigationController.navigationBar.alpha = (alpha==1.f)?0:1;
//    NSString *A = arr[1];
    
//  RMUniversalAlert* alert =  [RMUniversalAlert showAlertInViewController:self withTitle:@"title" message:@"message" cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@[@"confirm"] tapBlock:^(RMUniversalAlert *  alert, NSInteger buttonIndex) {
//        
//        if (buttonIndex == 0) {
//            NSLog(@"0");
//        }
//        
//        else if (buttonIndex == 1){
//            NSLog(@"1");
//        }
//    }];
//    
//    [self performSelector:@selector(dis:) withObject:alert afterDelay:3];
    
//    UIImage *image = [UIImage imageNamed:@"11"];
//    LogImageData(@"image", 0, 320, 240, UIImagePNGRepresentation(image));
//    
//    LoggerApp(1, @"Hello world! Today is: %@", [NSDate date]);
//    
//    NSArray* arr = @[@"asd"];
//     NSString *A = arr[1];
//    LoggerApp(1, @"arr[1] is: %@",arr[0] );
//    
//    NSLog(@"hello world");
//    
//    [iConsole info:@"Said '%@'", self.lab.text];
    
//    DQAlertView* alterview = [[DQAlertView alloc] initWithTitle:@"tilte" message:@"message" cancelButtonTitle:@"cancel" otherButtonTitle:@"confirm"];
//    [alterview.cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [alterview show];
//     __weak __typeof(DQAlertView*)weakSelf = alterview;
//    [alterview actionWithBlocksCancelButtonHandler:^{
//        
//    } otherButtonHandler:^{
//        [weakSelf dismiss];
//    }];
//
    
//    UIButton *nameField = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0, 50, 50.0)];
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
//    [nameField setImage:[UIImage imageNamed:@"stretch2"] forState:UIControlStateNormal];
//    
//    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 190, 40)];
//    lab.font = [UIFont systemFontOfSize:15];
//    lab.text = @"我接受此免责申明所有内容";
//    [v addSubview:lab];
//    [v addSubview:nameField];
//    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"TEST" message:@"subview" delegate:nil cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
//    [av setValue:v  forKey:@"accessoryView"];
//    [av show];
//    DIOpenSDKRegisterOptions* options = [[DIOpenSDKRegisterOptions alloc] init];
//    [DIOpenSDK showDDPage:self animated:YES params:nil delegate:self];
    
    
//    NSString* passjson = [[[NSBundle mainBundle] resourcePath]
//                          stringByAppendingPathComponent: @"pass.json"];
//    NSData* jsonData = [NSData dataWithContentsOfFile:passjson];
//    NSError*errorJson;
//    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&errorJson];
//
//
//    
//    NSString* passFile = [[[NSBundle mainBundle] resourcePath]
//                          stringByAppendingPathComponent: @"freehugcoupon.pkpass"];
//    NSData* passData = [NSData dataWithContentsOfFile:passFile];
//    NSError* error = nil;
//    PKPass *newPass = [[PKPass alloc] initWithData:passData
//                                             error:&error];
//    //5
//    if (error!=nil) {
//        [[[UIAlertView alloc] initWithTitle:@"Passes error"
//                                    message:[error
//                                             localizedDescription]
//                                   delegate:nil
//                          cancelButtonTitle:@"Ooops"
//                          otherButtonTitles: nil] show];
//        return;
//    }
//    
//    
//    PKAddPassesViewController *addController =
//    [[PKAddPassesViewController alloc] initWithPass:newPass];
//    
//    addController.delegate = self;
//    [self presentViewController:addController
//                       animated:YES
//                     completion:nil];
    
//    DQAlertView* alertView = [[DQAlertView alloc] initWithTitle:nil message:@"根据民航总局指示，凡购买到达或者途径中转西藏拉萨、林芝的旅客，非中国公民身份证持有者需持《进藏批准函》进藏，如因旅客违反此规定造成无法进藏等损失，将由旅客自行承担。感谢您的配合！" cancelButtonTitle:@"否" otherButtonTitle:@"是"];
//    __weak __typeof(DQAlertView*)weakSelf = alertView;
//    alertView.messageLabel.font = [UIFont systemFontOfSize:16.0];
//    [alertView show];
//    
//    [alertView actionWithBlocksCancelButtonHandler:^{
//        
//    } otherButtonHandler:^{
//        [weakSelf dismiss];
//        NSLog(@"test");
//    }];
    
//    [UIAlertView showWithTitle:@"提示" message:@"取消座位成功" cancelButtonTitle:@"返回" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            NSLog(@"test");
//            
//        });
//    }];


    //self.button5.center = self.view.center;
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
   // 申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    NSString* url = @"http://www.nghttp2.org/httpbin/image/png";
    url = @"http://7xt5rm.com2.z0.glb.clouddn.com/picjumbo.com_download.jpg";
    [manager GET:url parameters:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        UIImage* img = [[UIImage alloc] initWithData:responseObject];
        NSLog(@"%@",img);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];
    
   
    
}

- (void)dis:(RMUniversalAlert *)alert {
   // [alert dismiss];
    
}

-(IBAction)p2:(UIButton*)sender{
    [self.button1 hideIndicator];
    [self.button3 endSubmitting];
    self.lab.frameHeight = 20.f;
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
    [self showGTView];
}

-(IBAction)p4:(id)sender {
    
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

- (void)injected
{
    NSLog(@"I've been injected: %@", self);
}


- (void)showGTView {
    self.helper = [[ZHGTHelper alloc] init];
    [self.helper requestGTest];
    __weak __typeof(self)weakSelf = self;
    self.helper.GTResultBlock = ^(BOOL result) {
        if (result) {
           
           
        }
    };
}


@end
