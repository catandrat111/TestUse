//
//  MyCustomFormatter.h
//  TEST11
//
//  Created by dongjl on 16/11/8.
//  Copyright © 2016年 djl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDLog.h"

@interface MyCustomFormatter: NSObject<DDLogFormatter>
+(instancetype)sharedInstance;
@end
