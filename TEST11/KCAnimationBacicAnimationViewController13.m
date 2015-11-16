//
//  KCAnimationBacicAnimationViewController13.m
//  TEST11
//
//  Created by dongjl on 15/11/16.
//  Copyright © 2015年 djl. All rights reserved.
//下面的代码演示了移动动画结束后旋转动画暂停，并且当再次点击动画时旋转恢复的过程(注意在移动过程中如果再次点击屏幕可以暂停移动和旋转动画，再次点击可以恢复两种动画。但是当移动结束后触发了移动动画的完成事件如果再次点击屏幕则只能恢复旋转动画，因为此时移动动画已经结束而不是暂停，无法再恢复)。

#import "KCAnimationBacicAnimationViewController13.h"

@interface KCAnimationBacicAnimationViewController13 () {
    CALayer *_layer;
}

@end

@implementation KCAnimationBacicAnimationViewController13

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景(注意这个图片其实在根图层)
    UIImage *backgroundImage=[UIImage imageNamed:@"background"];
    self.view.backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
    
    //自定义一个图层
    _layer=[[CALayer alloc]init];
    _layer.bounds=CGRectMake(0, 0, 10, 20);
    _layer.position=CGPointMake(50, 150);
    _layer.anchorPoint=CGPointMake(0.5, 0.6);//设置锚点
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
    
    //2.设置动画属性初始值、结束值
    //    basicAnimation.fromValue=[NSNumber numberWithInteger:50];//可以不设置，默认为图层初始状态
    basicAnimation.toValue=[NSValue valueWithCGPoint:location];
    
    //设置其他动画属性
    basicAnimation.duration=5.0;//动画时间5秒
    //    basicAnimation.repeatCount=HUGE_VALF;//设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效果
    basicAnimation.removedOnCompletion=NO;//运行一次是否移除动画
    basicAnimation.delegate=self;
    //存储当前位置在动画结束后使用
    [basicAnimation setValue:[NSValue valueWithCGPoint:location] forKey:@"KCBasicAnimationLocation"];
    
    //3.添加动画到图层，注意key相当于给动画进行命名，以后获得该图层时可以使用此名称获取
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
    //判断是否已经常见过动画，如果已经创建则不再创建动画
    CAAnimation *animation= [_layer animationForKey:@"KCBasicAnimation_Translation"];
    if(animation){
        if (_layer.speed==0) {
            [self animationResume];
        }else{
            [self animationPause];
        }
    }else{
        //创建并开始动画
        [self translatonAnimation:location];
        
        [self rotationAnimation];
    }
}

#pragma mark 动画暂停
-(void)animationPause{
    //取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要
    CFTimeInterval interval=[_layer convertTime:CACurrentMediaTime() fromLayer:nil];
    //设置时间偏移量，保证暂停时停留在旋转的位置
    [_layer setTimeOffset:interval];
    //速度设置为0，暂停动画
    _layer.speed=0;
}

#pragma mark 动画恢复
-(void)animationResume{
    //获得暂停的时间
    CFTimeInterval beginTime= CACurrentMediaTime()- _layer.timeOffset;
    //设置偏移量
    _layer.timeOffset=0;
    //设置开始时间
    _layer.beginTime=beginTime;
    //设置动画速度，开始运动
    _layer.speed=1.0;
}

#pragma mark - 动画代理方法
#pragma mark 动画开始
-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animation(%@) start.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    NSLog(@"%@",[_layer animationForKey:@"KCBasicAnimation_Translation"]);//通过前面的设置的key获得动画
}

#pragma mark 动画结束
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"animation(%@) stop.\r_layer.frame=%@",anim,NSStringFromCGRect(_layer.frame));
    
    //开启事务
    [CATransaction begin];
    //禁用隐式动画
    [CATransaction setDisableActions:YES];
    
    _layer.position=[[anim valueForKey:@"KCBasicAnimationLocation"] CGPointValue];
    
    //提交事务
    [CATransaction commit];
    
    //暂停动画
    [self animationPause];
    
}

@end
