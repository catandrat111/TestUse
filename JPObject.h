//
//  JPObject.h
//  TEST11
//
//  Created by dongjl on 16/9/29.
//  Copyright © 2016年 djl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPObject : NSObject
+ (void)request:(void(^)(NSString *content, BOOL success))callback;
@end
