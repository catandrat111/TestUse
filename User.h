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
- (void)userTest;
@end
