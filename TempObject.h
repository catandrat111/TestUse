//
//  TempObject.h
//  TEST11
//
//  Created by dongjl on 17/2/21.
//  Copyright © 2017年 djl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TempObject : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *age1;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, assign) NSUInteger age;
@end

typedef NS_ENUM(NSUInteger, UserSex) {
    UserSex_Unknown = 0,
    UserSex_Man,
    UserSex_Woman,
};

@interface UserModel : NSObject<NSCopying>

@property (nonatomic,copy,readonly) NSString *name;
@property (nonatomic,assign,readonly) NSUInteger age;
@property (nonatomic,assign,readonly) UserSex sex;

- (int (^)(int)) add;
@end
