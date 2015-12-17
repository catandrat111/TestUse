//
//  Source.m
//  DeepIntoKVO
//
//  Created by  on 12-11-15.
//  Copyright (c) 2012年 kesalin. All rights reserved.
//

#import "Target.h"

@implementation Target

@synthesize age; // for automatic KVO - age
@synthesize grade;

- (id) init
{
    self = [super init];
    if (nil != self)
    {
        age = 10;
        grade = 0;
    }
    
    return self;
}

// for manual KVO - age
//- (int) age
//{
//    return age;
//}
//
//- (void) setAge:(int)theAge
//{
//	[self willChangeValueForKey:@"age"];
//	age = theAge;
//	[self didChangeValueForKey:@"age"];
//}
//
//+ (BOOL) automaticallyNotifiesObserversForKey:(NSString *)key {
//    if ([key isEqualToString:@"age"]) {
//        return NO;
//    }
//
//	return [super automaticallyNotifiesObserversForKey:key];
//}

@end
