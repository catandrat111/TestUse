//
//  FadeString.h
//  TEST11
//
//  Created by dongjl on 15/12/28.
//  Copyright © 2015年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FadeString : UIView
/**

* 输入文本

*/

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) UIColor *color;



/**
 
 * 向右渐变消失
 
 */

- (void)fadeRight;

- (void)fadeRightWithDuration:(NSTimeInterval)druation animaited:(BOOL)animated;
@end
