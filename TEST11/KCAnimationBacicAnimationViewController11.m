//
//  KCAnimationBacicAnimationViewController11.m
//  TEST11
//
//  Created by dongjl on 15/11/16.
//  Copyright © 2015年 djl. All rights reserved.
//如果运行上面的代码大家可能会发现另外一个问题，那就是动画运行完成后会重新从起始点运动到终点。这个问题产生的原因就是前面提到的，对于非根图层，设置图层的可动画属性（在动画结束后重新设置了position，而position是可动画属性）会产生动画效果。解决这个问题有两种办法：关闭图层隐式动画、设置动画图层为根图层。显然这里不能采取后者，因为根图层当前已经作为动画的背景。

#import "KCAnimationBacicAnimationViewController11.h"

@interface KCAnimationBacicAnimationViewController11 () {
    CALayer *_layer;
}

@end

@implementation KCAnimationBacicAnimationViewController11

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
    basicAnimation.delegate=self;
    //存储当前位置在动画结束后使用
    [basicAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"KCBasicAnimationLocation"];
    
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Translation"];
}

#pragma mark 旋转动画
-(void)rotationAnimation{
    //1.创建动画并指定动画属性
    CABasicAnimation *basicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //2.设置动画属性初始值、结束值
    //    basicAnimation.fromValue=[NSNumber numberWithInt:M_PI_2];
    basicAnimation.toValue=[NSNumber numberWithFloat:M_PI_2*3];
    
    //设置其他动画属性
    basicAnimation.duration=6.0;
    basicAnimation.autoreverses=true;//旋转后在旋转到原来的位置
    basicAnimation.repeatCount=HUGE_VALF;//设置无限循环
    basicAnimation.removedOnCompletion=NO;
    //    basicAnimation.delegate=self;
    
    
    //4.添加动画到图层，注意key相当于给动画进行命名，以后获得该动画时可以使用此名称获取
    [_layer addAnimation:basicAnimation forKey:@"KCBasicAnimation_Rotation"];
}

#pragma mark 点击事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=touches.anyObject;
    CGPoint location= [touch locationInView:self.view];
    //创建并开始动画
    [self translatonAnimation:location];
}

#pragma mark - 动画代理方法
#pragma mark 动画开始
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animation(%@) start.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    NSLog(@"%@",[_layer animationForKey:@"KCBasicAnimation_Translation"]);//通过前面的设置的key获得动画
}
//-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
//    _layer.position=[[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
//    
//}


#pragma mark 动画结束 要关闭隐式动画需要用到动画事务CATransaction，在事务内将隐式动画关闭，例如上面的代码可以改为：
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    //开启事务
    [CATransaction begin];
    //禁用隐式动画
    [CATransaction setDisableActions:YES];
    
    _layer.position=[[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
    
    //提交事务
    [CATransaction commit];
}

@end
