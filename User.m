//
//  User.m
//  TEST11
//
//  Created by 董金亮 on 15/8/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "User.h"

@implementation User
- (NSComparisonResult)compare:(User *)otherUser {
    
    return [self.age compare:otherUser.age];
}
@end
