//
//  ShakeViewController.m
//  TEST11
//
//  Created by dongjl on 16/11/21.
//  Copyright © 2016年 djl. All rights reserved.
//

#import "ShakeViewController.h"
#import <AudioToolbox/AudioToolbox.h>

#import <CoreMotion/CoreMotion.h>  
@interface ShakeViewController ()
@property (strong,nonatomic) CMMotionManager *motionManager;
@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self method1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self startAccelerometer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:UIApplicationWillEnterForegroundNotification object:nil];
}

-(void)startAccelerometer
{
    //以push的方式更新并在block中接收加速度
    [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc]init]
                                             withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                                 [self outputAccelertionData:accelerometerData.acceleration];
                                                 if (error) {
                                                     NSLog(@"motion error:%@",error);
                                                 }
                                             }];
}
-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    //综合3个方向的加速度
    double accelerameter =sqrt( pow( acceleration.x , 2 ) + pow( acceleration.y , 2 )
                               + pow( acceleration.z , 2) );
    //当综合加速度大于2.3时，就激活效果（此数值根据需求可以调整，数据越小，用户摇动的动作就越小，越容易激活，反之加大难度，但不容易误触发）
    if (accelerameter>2.3f) {
        //立即停止更新加速仪（很重要！）
        [self.motionManager stopAccelerometerUpdates];
        
        dispatch_async(dispatch_get_main_queue(), ^{  
            //UI线程必须在此block内执行，例如摇一摇动画、UIAlertView之类  
        });  
    }      
}  
-(void)viewDidDisappear:(BOOL)animated  
{  
    //停止加速仪更新（很重要！）  
    [self.motionManager stopAccelerometerUpdates];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification object:nil];
}

//对应上面的通知中心回调的消息接收
-(void)receiveNotification:(NSNotification *)notification
{
    if ([notification.name
         isEqualToString:UIApplicationDidEnterBackgroundNotification])
    {
        [self.motionManager stopAccelerometerUpdates];
    }else{
        [self startAccelerometer];
    }}


//暂用第一方法
- (void)method1 {
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];//配置支持摇动
    [self becomeFirstResponder];
}

// http://blog.csdn.net/u012894479/article/details/48629455 此方法也有缺陷
- (void)method2 {
    self.motionManager = [[CMMotionManager alloc] init];//一般在viewDidLoad中进行
    self.motionManager.accelerometerUpdateInterval = .1;//加速仪更新频率，以秒为单位

}

- (BOOL)canBecomeFirstResponder {
    return YES;
}
#pragma mark - ShakeToEdit 摇动手机之后的回调方法

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //检测到摇动开始
    
    if (motion == UIEventSubtypeMotionShake)
        
    {
        
        // your code
        
        DDLogInfo(@"begin animations");
        
    }
    
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //摇动取消
     DDLogInfo(@"摇动取消");
    
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //摇动结束
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   
    if (event.subtype == UIEventSubtypeMotionShake) {
        DDLogInfo(@"摇动结束");
        // your code
        //播放音效
        SystemSoundID   soundID;  // shake_sound_male.mp3
        NSString *path = [[NSBundle mainBundle ] pathForResource:@"shake_sound_male" ofType:@"mp3"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
        AudioServicesPlaySystemSound (soundID);
        //设置震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
    
    
}


@end
