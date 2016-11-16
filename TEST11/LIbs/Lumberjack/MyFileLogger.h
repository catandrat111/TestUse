//
//  MyFileLogger.h
//  TEST11
//
//  Created by dongjl on 16/11/8.
//  Copyright © 2016年 djl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaLumberjack.h"

@interface MyFileLogger : NSObject
@property (nonatomic, strong, readwrite) DDFileLogger *fileLogger;

+(MyFileLogger *)sharedManager;

@end
