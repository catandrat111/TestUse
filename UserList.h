//
//  UserList.h
//  TEST11
//
//  Created by dongjl on 15-9-11.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface UserList : NSObject

@property (readonly, nonatomic, strong) NSMutableOrderedSet *contacts;

@end
