//
//  UIView+Corner.h
//  TEST11
//
//  Created by dongjl on 16/3/7.
//  Copyright © 2016年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Corner)
- (void)kt_addCorner:(CGFloat)radius ;
- (void)kt_addCorner:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor*)backgroundColor borderColor:(UIColor*)borderColor;
@end
