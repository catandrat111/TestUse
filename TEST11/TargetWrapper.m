//
//  TargetWrapper.m
//  DeepIntoKVO
//
//  Created by  on 12-11-17.
//  Copyright (c) 2012年 kesalin. All rights reserved.
//

#import "TargetWrapper.h"
#import "Target.h"

@implementation TargetWrapper

@synthesize target = _target;

-(id) init:(Target *)aTarget
{
    self = [super init];
    if (nil != self) {
        _target = aTarget;
    }
    
    return self;
}

-(void) dealloc
{
    self.target = nil;
    
}

- (NSString *)information
{
    return [[NSString alloc] initWithFormat:@"%d#%d", [_target grade], [_target age]];
}

- (void)setInformation:(NSString *)theInformation
{
    NSArray * array = [theInformation componentsSeparatedByString:@"#"];
    [_target setGrade:[[array objectAtIndex:0] intValue]];
    [_target setAge:[[array objectAtIndex:1] intValue]];
}

+ (NSSet *)keyPathsForValuesAffectingInformation
{
    NSSet * keyPaths = [NSSet setWithObjects:@"target.age", @"target.grade", nil];
    return keyPaths;
}

//+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key
//{
//    NSSet * keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
//    NSArray * moreKeyPaths = nil;
//    
//    if ([key isEqualToString:@"information"])
//    {
//        moreKeyPaths = [NSArray arrayWithObjects:@"target.age", @"target.grade", nil];
//    }
//    
//    if (moreKeyPaths)
//    {
//        keyPaths = [keyPaths setByAddingObjectsFromArray:moreKeyPaths];
//    }
//    
//    return keyPaths;
//}

@end
