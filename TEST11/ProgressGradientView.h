//
//  ProgressGradientView.h
//  TEST11
//
//  Created by dongjl on 15/11/18.
//  Copyright © 2015年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressGradientView : UIView
@property (nonatomic, readonly) CALayer *maskLayer;
@property (nonatomic, assign) CGFloat progress;

- (instancetype)initWithFrame:(CGRect)frame ;
- (void)performAnimation ;
@end
