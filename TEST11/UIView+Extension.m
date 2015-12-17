//
//  UIView+Extension.m
//  TEST11
//
//  Created by dongjl on 15/12/10.
//  Copyright © 2015年 djl. All rights reserved.
///http://nshipster.cn/ibinspectable-ibdesignable/

#import "UIView+Extension.h"

@implementation UIView (Extension)
@dynamic layer_CornerRadius;
@dynamic layer_BorderColor;
@dynamic layer_BorderWidth;

- (void)setLayer_CornerRadius:(CGFloat)layerCornerRadius {
    self.layer.cornerRadius = layerCornerRadius;
}


- (CGFloat)layer_CornerRadius {
    return  self.layer.cornerRadius;
}

- (void)setLayer_BorderWidth:(CGFloat)layerBorderWidth {
    self.layer.borderWidth = layerBorderWidth;
}

- (void)setLayer_BorderColor:(UIColor *)layerBorderColor {
    self.layer.borderColor = layerBorderColor.CGColor;
}
@end
