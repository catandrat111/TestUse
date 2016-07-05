//
//  User.h
//  TEST11
//
//  Created by 董金亮 on 15/8/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
@interface User : NSObject<NSCopying>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *age;


@property (readonly, nonatomic, strong) NSArray *primes;
@property (readonly, nonatomic, strong) NSArray *arraTest;

@property (nonatomic, strong) NSMutableOrderedSet *contacts;
//可以实现一个支持 KVC 而不用 @property 和 @synthesize 或是自动 synthesize 的属性。最直接的方式是添加 -<key> 和 -set<Key>: 方法。例如我们想要 name ，我们这样做： 这完全等于 @property 的实现方式。

//- (NSString *)username;
//- (void)setUsername:(NSString *)username;
//
////当标量和 struct 的值被传入 nil 的时候尤其需要注意。假设我们要 height 属性支持 KVC 我们写了以下的方法：
//
//- (CGFloat)height;
//- (void)setHeight:(CGFloat)height;




- (void)userTest;
//解释NSInvocation
- (NSString *)appendMyString:(NSString *)string age:(NSInteger)age;
- (NSString *)appendTestMyString:(NSString *)string;
@end


@interface Father : NSObject

@end

@interface Son : Father
- (id)init;
@end