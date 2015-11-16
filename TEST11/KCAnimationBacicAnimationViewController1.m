//
//  KCAnimationBacicAnimationViewController1.m
//  TEST11
//
//  Created by dongjl on 15/11/16.
//  Copyright © 2015年 djl. All rights reserved.
//图层动画的本质就是将图层内部的内容转化为位图经硬件操作形成一种动画效果，其实图层本身并没有任何的变化。上面的动画中图层并没有因为动画效果而改变它的位置（对于缩放动画其大小也是不会改变的），所以动画完成之后图层还是在原来的显示位置没有任何变化，如果这个图层在一个UIView中你会发现在UIView移动过程中你要触发UIView的点击事件也只能点击原来的位置（即使它已经运动到了别的位置），因为它的位置从来没有变过。当然解决这个问题方法比较多，这里不妨在动画完成之后重新设置它的位置。

#import "KCAnimationBacicAnimationViewController1.h"

@interface KCAnimationBacicAnimationViewController1 (){
    CALayer *_layer;
}

@end

@implementation KCAnimationBacicAnimationViewController1

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 移动动画
-(void)translatonAnimation:(CGPoint)location{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"position"];
    
    //2.设置动画属性初始值和结束值
    //    basicAnimation.fromValue=[NSNumber numberWithInteger:50];//可以不设置，默认为图层初始状态
    basicAnimation.toValue=[NSValue valueWithCGPoint:location];
    
    //设置其他动画属性
    basicAnimation.duration=5.0;//动画时间5秒
    //basicAnimation.repeatCount=HUGE_VALF;//设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效果
    //    basicAnimation.removedOnCompletion=NO;//运行一次是否移除动画
    
    
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];
}

#pragma mark 点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=touches.anyObject;
    CGPoint location= [touch locationInView:self.view];
    //创建并开始动画
    [self translatonAnimation:location];
}


@end
