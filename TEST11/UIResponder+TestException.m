//
//  NSObject+TestException.m
//  TEST11
//
//  Created by dongjl on 16/12/26.
//  Copyright © 2016年 djl. All rights reserved.
//

#import "UIResponder+TestException.h"

@implementation UIResponder (TestException)
#ifdef _FOR_DEBUG_

- (BOOL) respondsToSelector:(SEL)aSelector {
    NSLog(@"SELECTOR: %s",[NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];
}
#endif
@end
