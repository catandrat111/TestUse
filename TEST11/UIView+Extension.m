//
//  UIView+Extension.m
//  TEST11
//
//  Created by dongjl on 15/12/10.
//  Copyright © 2015年 djl. All rights reserved.
///http://nshipster.cn/ibinspectable-ibdesignable/

#import "UIView+Extension.h"

@implementation UIView (Extension)
@dynamic layerCornerRadius;
@dynamic layerBorderColor;
@dynamic layerBorderWidth;

- (void)setLayerCornerRadius:(CGFloat)layerCornerRadius {
    self.layer.cornerRadius = layerCornerRadius;
}


- (CGFloat)layerCornerRadius {
    return  self.layer.cornerRadius;
}

- (void)setLayerBorderWidth:(CGFloat)layerBorderWidth {
    self.layer.borderWidth = layerBorderWidth;
}

- (void)setLayerBorderColor:(UIColor *)layerBorderColor {
    self.layer.borderColor = layerBorderColor.CGColor;
}
@end
