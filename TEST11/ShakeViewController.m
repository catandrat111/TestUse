//
//  ShakeViewController.m
//  TEST11
//
//  Created by dongjl on 16/11/21.
//  Copyright © 2016年 djl. All rights reserved.
//

#import "ShakeViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "FLAnimatedImage.h"
#import <CoreMotion/CoreMotion.h> 
#import "YLGIFImage.h"
#import "YLImageView.h"
#import <AVFoundation/AVFoundation.h>

#define SOUNDID  4099
@interface ShakeViewController ()<AVAudioRecorderDelegate>

@property (strong,nonatomic) UIImageView* imgView;
@property (strong,nonatomic) CMMotionManager *motionManager;
@property (strong,nonatomic) YLImageView* imgView1;
@property (strong,nonatomic) AVAudioPlayer *movePlayer;;
@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 105)];
  //  UIImage* img = [UIImage imageNamed:@"shake.png"];
   // self.imgView.image = img;
   // [self.view addSubview:self.imgView];
   // [self method1];
    
       //[self method3];
    [self method3];
    
    //UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 30, 30)];
   // [button setTitle:@"aaa" forState:UIControlStateNormal];
   // [button addTarget:self action:@selector(p1) forControlEvents:UIControlEventTouchUpInside];
   // [self.view addSubview:button];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)p1 {
    SystemSoundID   soundID;  // shake_sound_male.mp3
    NSString *path = [[NSBundle mainBundle ] pathForResource:@"5018" ofType:@"mp3"];
    OSStatus errorCode =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    if (errorCode != 0) {
        NSLog(@"create sound failed");
    }else{
        AudioServicesPlaySystemSound(soundID);
    }
    //AudioServicesPlaySystemSound (SOUNDID);
    
    NSData *data = [[NSData data]initWithContentsOfFile:path];
    NSError *playerError;
    
   self.movePlayer = [[AVAudioPlayer alloc] initWithData:data error:&playerError];
   self.movePlayer .volume = 1;
    
    NSLog(@"-----%f",self.movePlayer.duration) ;
   [self.movePlayer prepareToPlay];//分配播
    if (playerError != nil) {
        NSLog(@"文件错误");
    }
    else {
         [self.movePlayer play];//播放
    }

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

- (void)method3  {
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"天将红包1" withExtension:@"gif"];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data1];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    
    imageView.frame = CGRectMake(100.0, 100.0, 100.0, 105.0);
    [self.view addSubview:imageView];
}

-(void)method4 {
    self.imgView1 = [[YLImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 300)];
    [self.view addSubview:self.imgView1];
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"天将红包1" withExtension:@"gif"];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    self.imgView1.image = [[YLGIFImage alloc] initWithData:data1];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}
#pragma mark - ShakeToEdit 摇动手机之后的回调方法

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //检测到摇动开始
    if (motion == UIEventSubtypeMotionShake) {
        //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); //震动效果
        
//        NSString *path = [[NSBundle mainBundle ] pathForResource:@"5018" ofType:@"mp3"];
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
//        AudioServicesPlaySystemSound (soundID);
       // [self shakeView:self.imgView];  //这里的phoneImgView是需要摇动效果的图片控件
        [self addAnimations];
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

//        //设置震动
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
    
    
}

#pragma mark - 动画
-(void)shakeView:(UIView*)viewToShake
{
    CGFloat t = 14.0;
    viewToShake.layer.anchorPoint = CGPointMake(0.5, 0.3);
   // CGAffineTransform translateRight = CGAffineTransformTranslate(CGAffineTransformIdentity, t, 0.0);
   // CGAffineTransform translateLeft = CGAffineTransformTranslate(CGAffineTransformIdentity, -t, 0.0);
    CGAffineTransform translateRight = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI/18);
    CGAffineTransform translateLeft  = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI/18);
    viewToShake.transform = translateLeft;
    //[UIView  setAnimationRepeatAutoreverses:YES];
    //0.08
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionAutoreverse|UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:5.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
       
//        if(finished){
//            [UIView animateWithDuration:2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//                 viewToShake.transform =CGAffineTransformIdentity;
//            } completion:^(BOOL finished) {
//               
//            }];
//        }
    }];
}

-(void)addAnimations
{
    [self p1];
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"transform"];
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4/2, 0, 0, 100)];
    
    
    
    translation.duration = 0.16;
    translation.repeatCount = 3;
    translation.autoreverses = YES;
    
    [self.imgView.layer addAnimation:translation forKey:@"translation"];
    
}


@end
