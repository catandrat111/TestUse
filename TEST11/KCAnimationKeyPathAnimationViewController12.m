//
//  KCAnimationKeyPathAnimationViewController12.m
//  TEST11
//
//  Created by dongjl on 15/11/16.
//  Copyright © 2015年 djl. All rights reserved.
//，对于路径类型的关键帧动画系统是从描绘路径的位置开始路径，直到路径结束。如果上面的路径不是贝塞尔曲线而是矩形路径那么它会从矩形的左上角开始运行，顺时针一周回到左上角；如果指定的路径是一个椭圆，那么动画运行的路径是从椭圆右侧开始（0度）顺时针一周回到右侧。

#import "KCAnimationKeyPathAnimationViewController12.h"

@interface KCAnimationKeyPathAnimationViewController12 () {
    CALayer *_layer;
}

@end

@implementation KCAnimationKeyPathAnimationViewController12

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景(注意这个图片其实在根图层)
    UIImage *backgroundImage=[UIImage imageNamed:@"background.jpg"];
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
//keyTimes：各个关键帧的时间控制。前面使用values设置了四个关键帧，默认情况下每两帧之间的间隔为:8/(4-1)秒。如果想要控制动画从第一帧到第二针占用时间4秒，从第二帧到第三帧时间为2秒，而从第三帧到第四帧时间2秒的话，就可以通过keyTimes进行设置。keyTimes中存储的是时间占用比例点，此时可以设置keyTimes的值为0.0，0.5，0.75，1.0（当然必须转换为NSNumber），也就是说1到2帧运行到总时间的50%，2到3帧运行到总时间的75%，3到4帧运行到8秒结束。
#pragma mark 关键帧动画

//caculationMode：动画计算模式。还拿上面keyValues动画举例，之所以1到2帧能形成连贯性动画而不是直接从第1帧经过8/3秒到第2帧是因为动画模式是连续的（值为kCAAnimationLinear，这是计算模式的默认值）；而如果指定了动画模式为kCAAnimationDiscrete离散的那么你会看到动画从第1帧经过8/3秒直接到第2帧，中间没有任何过渡。其他动画模式还有：kCAAnimationPaced（均匀执行，会忽略keyTimes）、kCAAnimationCubic（平滑执行，对于位置变动关键帧动画运行轨迹更平滑）、kCAAnimationCubicPaced（平滑均匀执行）。
-(void)translationAnimation{
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation *keyframeAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //2.设置路径
    //绘制贝塞尔曲线
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);//移动到起始点
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);//绘制二次贝塞尔曲线
    
    keyframeAnimation.path=path;//设置path属性
    CGPathRelease(path);//释放路径对象
    //设置其他属性
    keyframeAnimation.duration=8.0;
    keyframeAnimation.beginTime=CACurrentMediaTime()+5;//设置延迟2秒执行
    
    
    //3.添加动画到图层，添加动画后就会执行动画
    [_layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
