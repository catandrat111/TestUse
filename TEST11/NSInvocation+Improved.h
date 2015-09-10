//
//  NSInvocation+Improved.h
//  TEST11
//
//  Created by dongjl on 15-9-10.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocation (Improved)
+ (NSInvocation *)invocationWithTarget:(id)_target andSelector:(SEL)_selector;
+ (NSInvocation *)invocationWithTarget:(id)_target andSelector:(SEL)_selector andArguments:(void *)_addressOfFirstArgument, ...;
- (void)invokeOnMainThreadWaitUntilDone:(BOOL)wait;
@end
