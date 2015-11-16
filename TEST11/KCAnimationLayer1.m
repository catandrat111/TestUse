//
//  KCAnimationLayer1.m
//  TEST11
//
//  Created by dongjl on 15/11/13.
//  Copyright © 2015年 djl. All rights reserved.
//在自定义图层中绘图时只要自己编写一个类继承于CALayer然后在drawInContext:中绘图即可。同前面在代理方法绘图一样，要显示图层中绘制的内容也要调用图层的setNeedDisplay方法，否则drawInContext方法将不会调用。


//图层绘图有两种方法，不管使用哪种方法绘制完必须调用图层的setNeedDisplay方法（注意是图层的方法，不是UIView的方法，前面我们介绍过UIView也有此方法）

//通过图层代理drawLayer: inContext:方法绘制
//通过自定义图层drawInContext:方法绘制

#import "KCAnimationLayer1.h"

@implementation KCAnimationLayer1
-(void)drawInContext:(CGContextRef)ctx{
    NSLog(@"3-drawInContext:");
    NSLog(@"CGContext:%@",ctx);
//    CGContextRotateCTM(ctx, M_PI_4);
    CGContextSetRGBFillColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
    CGContextSetRGBStrokeColor(ctx, 135.0/255.0, 232.0/255.0, 84.0/255.0, 1);
//    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
//    CGContextFillEllipseInRect(ctx, CGRectMake(50, 50, 100, 100));
    CGContextMoveToPoint(ctx, 94.5, 33.5);

    //// Star Drawing
    CGContextAddLineToPoint(ctx,104.02, 47.39);
    CGContextAddLineToPoint(ctx,120.18, 52.16);
    CGContextAddLineToPoint(ctx,109.91, 65.51);
    CGContextAddLineToPoint(ctx,110.37, 82.34);
    CGContextAddLineToPoint(ctx,94.5, 76.7);
    CGContextAddLineToPoint(ctx,78.63, 82.34);
    CGContextAddLineToPoint(ctx,79.09, 65.51);
    CGContextAddLineToPoint(ctx,68.82, 52.16);
    CGContextAddLineToPoint(ctx,84.98, 47.39);
    CGContextClosePath(ctx);


    CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end
