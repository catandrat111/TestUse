//
//  Person.h
//  TEST11
//
//  Created by 董金亮 on 15/8/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import <Foundation/Foundation.h>
//判断相等
@interface Person : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *age;

@property (nonatomic, strong) NSString *test;

@property (nonatomic, strong) NSNumber *sex;


- (void)blocktest;
//解释NSInvocation
- (NSString *)appendMyString:(NSString *)string age:(NSInteger)age;
- (NSString *)appendTestMyString:(NSString *)string;
@end
