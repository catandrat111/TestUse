//
//  TempObject.m
//  TEST11
//
//  Created by dongjl on 17/2/21.
//  Copyright © 2017年 djl. All rights reserved.
//
#import "MJExtension.h"
#import "TempObject.h"

@implementation TempObject
MJCodingImplementation
@end


@implementation UserModel {
    NSMutableSet *_frends;
}


- (void)setName:(NSString *)name {
    _name = [name copy];
}

- (instancetype)initWithUserName:(NSString*)name
                                age:(NSUInteger)age
                             sex:(NSUInteger)sex {
    if (self = [super init]) {
        _name = [name copy];
        _age = age;
        _sex = sex;
        _frends = [[NSMutableSet alloc] init];
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    UserModel *model = [[[self class] allocWithZone:zone]
                        initWithUserName:_name age:_age sex:_sex];
    return model;
}
@end
