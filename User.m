//
//  User.m
//  TEST11
//
//  Created by 董金亮 on 15/8/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "User.h"

@implementation User{
    NSMutableSet *_friends;
}
- (NSComparisonResult)compare:(User *)otherUser {
    
    return [self.age compare:otherUser.age];
}

-(void)dealloc{
    
}

- (id)copyWithZone:(NSZone *)zone
{
    User *user = [[[self class] allocWithZone:zone] init];
    user.name = self.name;
    user.age = self.age;
    user -> _friends = [_friends mutableCopy];
    return user;
}


- (void)userTest {
    NSLog(@"user:test");
}

//解释NSInvocation
- (NSString *)appendMyString:(NSString *)string age:(NSInteger)age
{
    NSString *mString = [NSString stringWithFormat:@"%@ after append method", string];
    return mString;
}

- (NSString *)appendTestMyString:(NSString *)string {
    NSString *mString = [NSString stringWithFormat:@"%@ after append method", string];
    return mString;
    
}


@end


