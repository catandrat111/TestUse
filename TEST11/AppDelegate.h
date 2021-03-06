//
//  AppDelegate.h
//  TEST11
//
//  Created by 董金亮 on 15-3-16.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFileLogger.h"

#define BLog(formatString, ...) NSLog((@"%s " formatString), __PRETTY_FUNCTION__, ##__VA_ARGS__);
@class HelloWorldViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,NSURLSessionDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) UIBackgroundTaskIdentifier  backgroundUpdateTask;
@property (nonatomic, strong) MyFileLogger *logger;
@property (copy) void (^backgroundSessionCompletionHandler)();
- (NSDate*)replaceMethodWithJSPatch;
- (void)testJS;
@end


