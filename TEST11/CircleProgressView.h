//
//  CircleProgressView.h
//  TEST11
//
//  Created by 董金亮 on 15/8/14.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgressView : UIView
/**起始值（0-1）*/
@property(nonatomic,assign)CGFloat fstartValue;

/**边框宽度*/
@property(nonatomic,assign)CGFloat flineWidth;

/**线条颜色*/
@property(nonatomic,strong)UIColor *lineColor;

/**变化的值*/
@property(nonatomic,assign)CGFloat fvalue;
@end
