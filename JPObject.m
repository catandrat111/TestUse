//
//  JPObject.m
//  TEST11
//
//  Created by dongjl on 16/9/29.
//  Copyright © 2016年 djl. All rights reserved.
//

#import "JPObject.h"

@implementation JPObject

+ (void)request:(void(^)(NSString *content, BOOL success))callback
{
    callback(@"I'm content", YES);
}
@end
