//
//  KCAnimationViewController2.m
//  TEST11
//
//  Created by dongjl on 15/11/13.
//  Copyright © 2015年 djl. All rights reserved.
//通过代理方法进行图层绘图只要指定图层的代理，然后在代理对象中重写-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx方法即可。需要注意这个方法虽然是代理方法但是不用手动实现CALayerDelegate，因为CALayer定义中给NSObject做了分类扩展，所有的NSObject都包含这个方法。另外设置完代理后必须要调用图层的setNeedDisplay方法，否则绘制的内容无法显示。

#import "KCAnimationViewController2.h"
#define PHOTO_HEIGHT 150
@interface KCAnimationViewController2 ()

@end

@implementation KCAnimationViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
     //自定义图层
    CALayer *layer=[[CALayer alloc]init];
    layer.bounds=CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
    layer.position=CGPointMake(160, 200);
    layer.backgroundColor=[UIColor redColor].CGColor;
    layer.cornerRadius=PHOTO_HEIGHT/2;
    //注意仅仅设置圆角，对于集合图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
    //如果想要正确显示则必须设置masksToBounds=YES，剪切子图层
    layer.masksToBounds=YES;
    //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
    //而阴影效果刚好在外边框
//    layer.shadowColor=[UIColor grayColor].CGColor;
//    layer.shadowOffset=CGSizeMake(2, 2);
//    layer.shadowOpacity=1;
    //设置边框
    layer.borderColor=[UIColor whiteColor].CGColor;
    layer.borderWidth=2;

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
    CGContextSaveGState(ctx);

    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);

    UIImage *image=[UIImage imageNamed:@"photo1"];
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);

//    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
//    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    CGContextRestoreGState(ctx);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
