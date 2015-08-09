//
//  Person.m
//  TEST11
//
//  Created by 董金亮 on 15/8/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "Person.h"

@implementation Person
- (BOOL)isEqualToPerson:(Person *)person
{
    if (self == person)
    {
        return YES;
    }
    if (!([_name isEqualToString:person.name] || _name == person.name))
    {
        return NO;
    }
    
    if (!([_age isEqualToNumber:person.age] || _age == person.age))
    {
        return NO;
    }
    
    return YES;
    
}

- (BOOL)isEqual:(id)object
{
    if ([self class] == [object class])
    {
        return [self isEqualToPerson: (Person *)object];
    }
    else
    {
        return [super isEqual:object];
    }
}

- (NSUInteger)hash
{
    return [_name hash] ^ [_age hash];
}
@end
