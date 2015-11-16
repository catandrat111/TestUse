//
//  KCAnimationKeyPathAnimationViewController11.m
//  TEST11
//
//  Created by dongjl on 15/11/16.
//  Copyright © 2015年 djl. All rights reserved.
//关键帧动画开发分为两种形式：一种是通过设置不同的属性值进行关键帧控制，另一种是通过绘制路径进行关键帧控制。后者优先级高于前者，如果设置了路径则属性值就不再起作用。

#import "KCAnimationKeyPathAnimationViewController11.h"

@interface KCAnimationKeyPathAnimationViewController11 () {
    CALayer *_layer;
}

@end

@implementation KCAnimationKeyPathAnimationViewController11

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景(注意这个图片其实在根图层)
    UIImage *backgroundImage=[UIImage imageNamed:@"background"];
    self.view.backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
    
    //自定义一个图层
    _layer=[[CALayer alloc]init];
    _layer.bounds=CGRectMake(0, 0, 10, 20);
    _layer.position=CGPointMake(50, 150);
    _layer.contents=(id)[UIImage imageNamed:@"petal.png"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    //创建动画
    [self translationAnimation];
}

#pragma mark 关键帧动画
////keyTimes：各个关键帧的时间控制。前面使用values设置了四个关键帧，默认情况下每两帧之间的间隔为:8/(4-1)秒。如果想要控制动画从第一帧到第二针占用时间4秒，从第二帧到第三帧时间为2秒，而从第三帧到第四帧时间2秒的话，就可以通过keyTimes进行设置。keyTimes中存储的是时间占用比例点，此时可以设置keyTimes的值为0.0，0.5，0.75，1.0（当然必须转换为NSNumber），也就是说1到2帧运行到总时间的50%，2到3帧运行到总时间的75%，3到4帧运行到8秒结束。

-(void)translationAnimation{
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //2.设置关键帧,这里有四个关键帧
    NSValue *key1=[NSValue valueWithCGPoint:_layer.position];//对于关键帧动画初始值不能省略
    NSValue *key2=[NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue *key3=[NSValue valueWithCGPoint:CGPointMake(45, 300)];
    NSValue *key4=[NSValue valueWithCGPoint:CGPointMake(55, 400)];
    NSArray *values=@[key1,key2,key3,key4];
    keyframeAnimation.values=values;
    //设置其他属性
    keyframeAnimation.duration=8.0;
    keyframeAnimation.beginTime=CACurrentMediaTime()+2;//设置延迟2秒执行
    
    
    //3.添加动画到图层，添加动画后就会执行动画
    [_layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
