//
//  CALayer+Extension.h
//  TEST11
//
//  Created by dongjl on 15/12/10.
//  Copyright © 2015年 djl. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Extension)
@property (nonatomic) IBInspectable CGFloat layer_CornerRadius;
@property (nonatomic,strong) IBInspectable UIColor* layer_BorderColor;
@property (nonatomic) IBInspectable CGFloat layer_BorderWidth;
@end
