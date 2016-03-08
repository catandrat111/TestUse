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

- (void)setLayer_CornerRadius:(CGFloat)layer_CornerRadius {
    self.layer.cornerRadius = layer_CornerRadius;
}


- (CGFloat)layer_CornerRadius {
    return  self.layer.cornerRadius;
}

- (void)setLayer_BorderWidth:(CGFloat)layer_BorderWidth {
    self.layer.borderWidth = layer_BorderWidth;
}

- (void)setLayer_BorderColor:(UIColor *)layer_BorderColor {
    self.layer.borderColor = layer_BorderColor.CGColor;
}


@end
