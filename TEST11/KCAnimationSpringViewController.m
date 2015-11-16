//
//  KCAnimationSpringViewController.m
//  TEST11
//
//  Created by dongjl on 15/11/16.
//  Copyright © 2015年 djl. All rights reserved.
//在动画方法中有一个option参数，UIViewAnimationOptions类型，它是一个枚举类型，动画参数分为三类，可以组合使用：

//1.常规动画属性设置（可以同时选择多个进行设置）
//
//UIViewAnimationOptionLayoutSubviews：动画过程中保证子视图跟随运动。
//
//UIViewAnimationOptionAllowUserInteraction：动画过程中允许用户交互。
//
//UIViewAnimationOptionBeginFromCurrentState：所有视图从当前状态开始运行。
//
//UIViewAnimationOptionRepeat：重复运行动画。
//
//UIViewAnimationOptionAutoreverse ：动画运行到结束点后仍然以动画方式回到初始点。
//
//UIViewAnimationOptionOverrideInheritedDuration：忽略嵌套动画时间设置。
//
//UIViewAnimationOptionOverrideInheritedCurve：忽略嵌套动画速度设置。
//
//UIViewAnimationOptionAllowAnimatedContent：动画过程中重绘视图（注意仅仅适用于转场动画）。
//
//UIViewAnimationOptionShowHideTransitionViews：视图切换时直接隐藏旧视图、显示新视图，而不是将旧视图从父视图移除（仅仅适用于转场动画）
//UIViewAnimationOptionOverrideInheritedOptions ：不继承父动画设置或动画类型。
//
//2.动画速度控制（可从其中选择一个设置）
//
//UIViewAnimationOptionCurveEaseInOut：动画先缓慢，然后逐渐加速。
//
//UIViewAnimationOptionCurveEaseIn ：动画逐渐变慢。
//
//UIViewAnimationOptionCurveEaseOut：动画逐渐加速。
//
//UIViewAnimationOptionCurveLinear ：动画匀速执行，默认值。
//
//3.转场类型（仅适用于转场动画设置，可以从中选择一个进行设置，基本动画、关键帧动画不需要设置）
//
//UIViewAnimationOptionTransitionNone：没有转场动画效果。
//
//UIViewAnimationOptionTransitionFlipFromLeft ：从左侧翻转效果。
//
//UIViewAnimationOptionTransitionFlipFromRight：从右侧翻转效果。
//
//UIViewAnimationOptionTransitionCurlUp：向后翻页的动画过渡效果。
//
//UIViewAnimationOptionTransitionCurlDown ：向前翻页的动画过渡效果。
//
//UIViewAnimationOptionTransitionCrossDissolve：旧视图溶解消失显示下一个新视图的效果。
//
//UIViewAnimationOptionTransitionFlipFromTop ：从上方翻转效果。
//
//UIViewAnimationOptionTransitionFlipFromBottom：从底部翻转效果。



#import "KCAnimationSpringViewController.h"

@interface KCAnimationSpringViewController () {
    UIImageView *_imageView;
}


@end

@implementation KCAnimationSpringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建图像显示控件
    _imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ball.png"]];
    _imageView.center=CGPointMake(160, 50);
    [self.view addSubview:_imageView];
    self.view.backgroundColor = [UIColor blueColor];
}

#pragma mark 点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=touches.anyObject;
    CGPoint location= [touch locationInView:self.view];
    /*创建弹性动画
     damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
     velocity:弹性复位的速度
     */
    [UIView animateWithDuration:5.0 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
        _imageView.center=location; //CGPointMake(160, 284);
    } completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
