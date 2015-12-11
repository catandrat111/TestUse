//
//  UIView+Extension.h
//  TEST11
//
//  Created by dongjl on 15/12/10.
//  Copyright © 2015年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic) IBInspectable CGFloat layerCornerRadius;
@property (nonatomic,strong) IBInspectable UIColor* layerBorderColor;
@property (nonatomic) IBInspectable CGFloat layerBorderWidth;
@end
