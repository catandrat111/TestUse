//
//  DRSavedPopAnimationState.h
//  TEST11
//
//  Created by dongjl on 15-9-6.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRSavedPopAnimationState : NSObject
@property (strong) CALayer  *layer;
@property (copy  ) NSString *keyPath;
@property (strong) id       oldValue;

+ (instancetype)savedStateWithLayer:(CALayer *)layer
                            keyPath:(NSString *)keyPath;

@end
