//
//  CALayer+Extension.m
//  TEST11
//
//  Created by dongjl on 15/12/10.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "CALayer+Extension.h"

@implementation CALayer (Extension)
@dynamic layer_CornerRadius;
@dynamic layer_BorderColor;
@dynamic layer_BorderWidth;

- (void)setLayer_CornerRadius:(CGFloat)layerCornerRadius {
    self.cornerRadius = layerCornerRadius;
}


- (CGFloat)layer_CornerRadius {
    return  self.cornerRadius;
}

- (void)setLayer_BorderWidth:(CGFloat)layerBorderWidth {
    self.borderWidth = layerBorderWidth;
}

- (void)setLayer_BorderColor:(UIColor *)layerBorderColor {
    self.borderColor = layerBorderColor.CGColor;
}
@end
