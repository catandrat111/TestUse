//
//  Person+GHAssociatedObject.h
//  TEST11
//
//  Created by 董金亮 on 15/8/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "Person.h"

@interface Person (GHAssociatedObject)
@property (nonatomic, strong) NSNumber *weight;
@end
