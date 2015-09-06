//
//  UIView+DR_CustomBlockAnimations.h
//  TEST11
//
//  Created by dongjl on 15-9-6.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DRSavedPopAnimationState.h"
@interface UIView (DR_CustomBlockAnimations)
+(NSMutableArray*)DR_savedPopAnimationStates;
+ (void)DR_popAnimationWithDuration:(NSTimeInterval)duration
                         animations:(void (^)(void))animations;
@end
