//
//  TargetWrapper.h
//  DeepIntoKVO
//
//  Created by  on 12-11-17.
//  Copyright (c) 2012年 kesalin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Target;

@interface TargetWrapper : NSObject
{
@private
    Target * _target;
}

@property(nonatomic, assign) NSString * information;
@property(nonatomic, retain) Target * target;

-(id) init:(Target *)aTarget;

@end
