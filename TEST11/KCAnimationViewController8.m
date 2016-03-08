//
//  KCAnimationViewController8.m
//  TEST11
//
//  Created by dongjl on 15/12/28.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "KCAnimationViewController8.h"
#import "FadeString.h"
@implementation KCAnimationViewController8
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    //[self maskLayerAnimation];
    [self addMaskView];
    //[self addGradientLayer];
}


- (void)maskLayerAnimation {
    self.view.backgroundColor = [UIColor blackColor];
    
    FadeString *fadeString1 = [[FadeString alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    
    fadeString1.text = @"hello world";
    fadeString1.color = [UIColor yellowColor];
    fadeString1.center = self.view.center;
    [self.view addSubview:fadeString1];
    
    // 创建FadeString
    
    FadeString *fadeString = [[FadeString alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    
    fadeString.text = @"hello world";
    
    fadeString.center = self.view.center;
    
    [self.view addSubview:fadeString];
    
    // 执行动画效果
    
    [fadeString fadeRight];
    
}

- (void)maskImageAnimation {
    
}

- (void)addGradientLayer {
    
    // 加载图片
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
    
    imageView.image = [UIImage imageNamed:@"mask_1"];
    
    [self.view addSubview:imageView];
    
    // 创建出CAGradientLayer，
    
    //可以对gradientLayer的frame,colors.locations.startPoint,endPoint进行动画效果
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.frame = imageView.bounds;
    
    gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                             
                             (__bridge id)[UIColor blackColor].CGColor,
                             
                             (__bridge id)[UIColor clearColor].CGColor];
    
    gradientLayer.locations = @[@(0.25), @(0.5), @(0.75)];//设置位置点
    
    gradientLayer.startPoint = CGPointMake(0, 0);//设置方向
    
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    
    
    // 容器view --> 用于加载创建出的CAGradientLayer
    
    UIView *containerView = [[UIView alloc] initWithFrame:imageView.bounds];
    
    [containerView.layer addSublayer:gradientLayer];
    
    // 设定maskView
    
    imageView.maskView = containerView;
    
    CGRect frame = containerView.frame;
    
    frame.origin.x -= 200;
    
    // 重新赋值
    
    containerView.frame = frame;
    
    // 给maskView做动画效果
    
    [UIView animateWithDuration:3.f animations:^{
        
        // 改变位移
        
        CGRect frame = containerView.frame;
        
        frame.origin.x += 400;
        containerView.frame = frame;
    }];
}


- (void)addMaskView

{
    
    CGFloat width = 120;
    
    // 使用maskView的情况
    
    UIImageView *addImageView= [[UIImageView alloc] initWithFrame:CGRectMake(20, 20 , width, width)];
    
    [self.view addSubview : addImageView];
    
    addImageView.image = [UIImage imageNamed:@"mask_1"];
    
    UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    
    mask.image = [UIImage imageNamed:@"mask_2"];
    
    // maskView并不能用addSubview来添加遮罩,这点千万注意
    
    addImageView.maskView = mask;
    
}
@end
