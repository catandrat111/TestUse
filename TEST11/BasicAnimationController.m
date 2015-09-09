//
//  BasicAnimationController.m
//  TEST11
//
//  Created by dongjl on 15-9-7.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "BasicAnimationController.h"
#import "DRInspectionLayer.h"
#import <QuartzCore/QuartzCore.h>
@interface BasicAnimationController (){
    DRInspectionView* v1;
    DRInspectionView* v2;
}

@end

//Core Animation 维护了两个平行 layer 层次结构： model layer tree（模型层树） 和 presentation layer tree（表示层树）。前者中的 layers 反映了我们能直接看到的 layers 的状态，而后者的 layers 则是动画正在表现的值的近似。

//timingFunction可选的值有：
//kCAMediaTimingFunctionLinear（线性）：匀速，给你一个相对静态的感觉
//kCAMediaTimingFunctionEaseIn（渐进）：动画缓慢进入，然后加速离开
//kCAMediaTimingFunctionEaseOut（渐出）：动画全速进入，然后减速的到达目的地
//kCAMediaTimingFunctionEaseInEaseOut（渐进渐出）：动画缓慢的进入，中间加速，然后减速的到达目的地。这个是默认的动画行为。

@implementation BasicAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    v1 = [[DRInspectionView alloc] initWithFrame:CGRectMake(60, 80, 100, 100)];
    v1.backgroundColor = [UIColor redColor];
    [self.view addSubview:v1];
    
    v2 = [[DRInspectionView alloc] initWithFrame:CGRectMake(160, 80, 100, 100)];
    v2.backgroundColor = [UIColor greenColor];

    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(60, 180, 60, 60)];
    [button setTitle:@"p1" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(p1) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton* button1 = [[UIButton alloc] initWithFrame:CGRectMake(160, 180, 60, 60)];
    [button1 setTitle:@"p2" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(p2) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button1];
    
    UIButton* button2 = [[UIButton alloc] initWithFrame:CGRectMake(230, 180, 60, 60)];
    [button2 setTitle:@"p3" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(p3) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button2];
    
    UIButton* button3 = [[UIButton alloc] initWithFrame:CGRectMake(60, 250, 60, 60)];
    [button3 setTitle:@"p4" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(p4) forControlEvents:UIControlEventTouchUpInside];
    [button3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button3];
    
    UIButton* button4 = [[UIButton alloc] initWithFrame:CGRectMake(160, 250, 60, 60)];
    [button4 setTitle:@"p5" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(p5) forControlEvents:UIControlEventTouchUpInside];
    [button4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button4];
    
    UIButton* button5 = [[UIButton alloc] initWithFrame:CGRectMake(230, 250, 60, 60)];
    [button5 setTitle:@"p6" forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(p6) forControlEvents:UIControlEventTouchUpInside];
    [button5 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button5];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)p1{
    //    当我们运行该代码时，我们意识到火箭在完成动画后马上回到了初始位置。这是因为在默认情况下，动画不会在超出其持续时间后还修改 presentation layer。实际上，在结束时它甚至会被彻底移除。
    //
    //    一旦动画被移除，presentation layer 将回到 model layer 的值，并且因为我们从未修改该 layer 的 position 属性，所以我们的飞船将重新出现在它开始的地方。
    //
    //    这里有两种解决这个问题的方法：
    //
    //    第一种方法是直接在 model layer 上更新属性。这是推荐的的做法，因为它使得动画完全可选。
    //
    //    一旦动画完成并且从 layer 中移除，presentation layer 将回到 model layer 设置的值，而这个值恰好与动画最后一个步骤相匹配。
     //一旦动画完成并且从 layer 中移除，presentation layer 将回到 model layer 设置的值，而这个值恰好与动画最后一个步骤相匹配。
//    v1.frame = CGRectMake(60, 80, 100, 100);
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"position.x";
//    animation.fromValue = @60;
//    animation.toValue = @200;
//    animation.duration = 1;
//    
//    [v1.layer addAnimation:animation forKey:@"basic"];
//    v1.layer.position = CGPointMake(200, 80);
    
    v1.frame = CGRectMake(60, 80, 100, 100);
     CABasicAnimation *animation5 = [CABasicAnimation animation];
    animation5.keyPath = @"position.y";
    animation5.fromValue = @130;
    animation5.toValue = @400;
    animation5.duration = 1;
    [animation5 setValue:v1 forKey:@"animateLayertest"];//带参数
    animation5.delegate = self;//必须放到addAnimation方法前否则不执行
    [v1.layer addAnimation:animation5 forKey:@"basic1"];
    v1.layer.position = CGPointMake(110, 400);

}


-(void)p2{
   // 或者，你可以通过设置动画的 fillMode 属性为 kCAFillModeForward 以留在最终状态，并设置removedOnCompletion 为 NO 以防止它被自动移除： 如果将已完成的动画保持在 layer 上时，会造成额外的开销，因为渲染器会去进行额外的绘画工作。
       v1.frame = CGRectMake(60, 80, 100, 100);
       CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"position.x";
        animation.fromValue = @110;
        animation.toValue = @320;
        animation.duration = 3;
    
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
    animation.delegate  =self;
        [v1.layer addAnimation:animation forKey:@"basic"];
}

-(void)p3{
    [v2 removeFromSuperview];
    [self.view addSubview:v2];
    
    v1.frame = CGRectMake(60, 80, 100, 100);
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.byValue = @110;
    animation.duration = 1;
    
    [v1.layer addAnimation:animation forKey:@"basic"];
    v1.layer.position = CGPointMake(160, 130);
    
    animation.beginTime = CACurrentMediaTime() + 0.5;
    
    [v2.layer addAnimation:animation forKey:@"basic"];
    v2.layer.position = CGPointMake(200, 130);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
     NSLog(@"end");
    
    id value = [anim valueForKey:@"animateLayertest"];
    if([value isKindOfClass:[NSString class]]){
        if ([value isEqualToString:@"Animation1"])
        {
            
            return;
        }
        
        
        if ([value isEqualToString:@"Animation2"])
        {
            
            return;
        }
    }
    else if([value isKindOfClass:[DRInspectionView class]]){
        DRInspectionView* drView = (DRInspectionView*)value;
        NSLog(@"%@",drView);
    }
    
}

-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"start");
    id value = [anim valueForKey:@"animateLayertest"];
    if([value isKindOfClass:[DRInspectionView class]]){
        DRInspectionView* drView = (DRInspectionView*)value;
        NSLog(@"%@",drView);
    }

}


-(void)p4{
    
    CGRect boundingRect = CGRectMake(-100, -100, 300, 300);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;//使用 calculationMode 是控制关键帧动画时间的另一种方法。我们通过将其设置为 kCAAnimationPaced，让 Core Animation 向被驱动的对象施加一个恒定速度，不管路径的各个线段有多长。将其设置为 kCAAnimationPaced 将无视所有我们已经设置的 keyTimes。
    orbit.rotationMode = kCAAnimationRotateAuto;//设置 rotationMode 属性为 kCAAnimationRotateAuto 确保飞船沿着路径旋转
    
    [v1.layer addAnimation:orbit forKey:@"orbit"];
}


-(void)p5{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";
    animation.fromValue = @110;
    animation.toValue = @200;
    animation.duration = 1;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5:0:0.9:0.7];//参考bezier.png
    
    [v1.layer addAnimation:animation forKey:@"basic"];
    
    v1.layer.position = CGPointMake(150, 130);
}

-(void)p6{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 10.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [v1.layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];}


@end
