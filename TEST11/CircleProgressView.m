//
//  CircleProgressView.m
//  TEST11
//
//  Created by 董金亮 on 15/8/14.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "CircleProgressView.h"

@interface CircleProgressView ()
{
    CAShapeLayer *_shapeLayer;
}
@end
@implementation CircleProgressView
@synthesize fstartValue=_fstartValue;
@synthesize flineWidth=_flineWidth;
@synthesize lineColor=_lineColor;
@synthesize fvalue=_fvalue;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        /**创建带形状的图层*/
        _shapeLayer=[CAShapeLayer layer];
        _shapeLayer.frame     = self.bounds;
        _shapeLayer.strokeEnd = 0.f;
        
        /*创建布赛尔曲线*/
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        
        /**把图层和不塞尔曲线通过path进行关联*/
        _shapeLayer.path   = path.CGPath;
        
        /**设置图层的填充颜色、宽度、边框颜色*/
        _shapeLayer.fillColor   = [UIColor clearColor].CGColor;
        _shapeLayer.lineWidth   = 1.0f;
        _shapeLayer.strokeColor = [UIColor redColor].CGColor;
        
        [self.layer addSublayer:_shapeLayer];

    }
    return self;
}
/**
 *  @brief  重写fstartValue的setter方法
 *  @param fstartValue  设置圆形strokeStart起始值
 *  @since
 */
- (void)setFstartValue:(CGFloat)fstartValue
{
    _fstartValue          = fstartValue;
    _shapeLayer.strokeStart = fstartValue;
    
}
- (CGFloat)fstartValue
{
    return _fstartValue;
}
/**
 *  @brief  重写flineWidth的setter方法
 *  @param flineWidth  设置圆形边框宽度
 *  @since
 */

- (void)setFlineWidth:(CGFloat)flineWidth
{
    _flineWidth           = flineWidth;
    _shapeLayer.lineWidth = flineWidth;
}
/**
 *  @brief  重写lineColor的setter方法
 *  @param lineColor  设置圆形边框颜色
 *  @since
 */

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor              = lineColor;
    _shapeLayer.strokeColor = lineColor.CGColor;
}
- (UIColor *)lineColor
{
    return _lineColor;
}
/**
 *  @brief  重写fvalue的setter方法
 *  @param lineColor  设置圆形的strokeEnd值
 *  @since
 */
- (void)setFvalue:(CGFloat)fvalue
{
    _fvalue                = fvalue;
    _shapeLayer.strokeEnd = fvalue;
}

- (CGFloat)fvalue
{
    return _fvalue;
}

@end

