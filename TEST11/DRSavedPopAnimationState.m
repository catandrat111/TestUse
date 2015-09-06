//
//  DRSavedPopAnimationState.m
//  TEST11
//
//  Created by dongjl on 15-9-6.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "DRSavedPopAnimationState.h"

@implementation DRSavedPopAnimationState
+ (instancetype)savedStateWithLayer:(CALayer *)layer
                            keyPath:(NSString *)keyPath
{
    DRSavedPopAnimationState *savedState = [DRSavedPopAnimationState new];
    savedState.layer    = layer;
    savedState.keyPath  = keyPath;
    savedState.oldValue = [layer valueForKeyPath:keyPath];
    return savedState;
}

@end
