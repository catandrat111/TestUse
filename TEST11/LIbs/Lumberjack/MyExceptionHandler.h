//
//  MyExceptionHandler.h
//  TEST11
//
//  Created by dongjl on 16/11/8.
//  Copyright © 2016年 djl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaLumberjack.h"

@interface MyExceptionHandler : NSObject

+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler *)getHandler;
+ (void)TakeException:(NSException *) exception;

@end
