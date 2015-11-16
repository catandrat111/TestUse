//
//  KCAnimationViewController5.m
//  TEST11
//
//  Created by dongjl on 15/11/13.
//  Copyright © 2015年 djl. All rights reserved.
//大家不难发现使用Core Graphics绘制图片时会倒立显示，对图层的图形上下文进行了反转。在前一篇文章中也采用了类似的方法去解决这个问题，但是在那篇文章中也提到过如果直接让图像沿着x轴旋转180度同样可以达到正确显示的目的，只是当时的旋转靠图形上下文还无法绕x轴旋转。今天学习了图层之后，其实可以控制图层直接旋转而不用借助于图形上下文的形变操作，而且这么操作起来会更加简单和直观。对于上面的程序，只需要设置图层的transform属性即可。需要注意的是transform是CATransform3D类型，形变可以在三个维度上进行，使用方法和前面介绍的二维形变是类似的，而且都有对应的形变设置方法（如：CATransform3DMakeTranslation()、CATransform3DMakeScale()、CATransform3DMakeRotation()）。下面的代码通过CATransform3DMakeRotation()方法在x轴旋转180度解决倒立问题：

#import "KCAnimationViewController5.h"
#define PHOTO_HEIGHT 150
@interface KCAnimationViewController5 ()

@end

@implementation KCAnimationViewController5

- (void)viewDidLoad {
    [super viewDidLoad];
    CGPoint position= CGPointMake(160, 200);
    CGRect bounds=CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    CGFloat cornerRadius=PHOTO_HEIGHT/2;
    CGFloat borderWidth=2;

    //阴影图层
    CALayer *layerShadow=[[CALayer alloc]init];
    layerShadow.bounds=bounds;
    layerShadow.position=position;
    layerShadow.cornerRadius=cornerRadius;
    layerShadow.shadowColor=[UIColor grayColor].CGColor;
    layerShadow.shadowOffset=CGSizeMake(2, 1);
    layerShadow.shadowOpacity=1;
    layerShadow.borderColor=[UIColor whiteColor].CGColor;
    layerShadow.borderWidth=borderWidth;
    [self.view.layer addSublayer:layerShadow];

    //容器图层
    CALayer *layer=[[CALayer alloc]init];
    layer.bounds=bounds;
    layer.position=position;
    layer.backgroundColor=[UIColor redColor].CGColor;
    layer.cornerRadius=cornerRadius;
    layer.masksToBounds=YES;
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=borderWidth;

    //利用图层形变解决图像倒立问题
    layer.transform=CATransform3DMakeRotation(M_PI, 1, 0, 0);

    //设置图层代理
    layer.delegate=self;

    //添加图层到根图层
    [self.view.layer addSublayer:layer];

    //调用图层setNeedDisplay,否则代理方法不会被调用
    [layer setNeedsDisplay];
}

#pragma mark 绘制图形、图像到图层，注意参数中的ctx时图层的图形上下文，其中绘图位置也是相对图层而言的
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    //    NSLog(@"%@",layer);//这个图层正是上面定义的图层
    UIImage *image=[UIImage imageNamed:@"photo"];
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);
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
