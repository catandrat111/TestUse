//
//  Source.h
//  DeepIntoKVO
//
//  Created by  on 12-11-15.
//  Copyright (c) 2012年 kesalin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Target : NSObject
{
    int age;
}

@property (nonatomic, readwrite) int grade;

// for manual KVO - age
//- (int) age;
//- (void) setAge:(int)theAge;

// for automatic KVO - age
@property (nonatomic, readwrite) int age;

@end
