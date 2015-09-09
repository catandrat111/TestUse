//
//  DRInspectionLayer.m
//  TEST11
//
//  Created by dongjl on 15-9-6.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "DRInspectionLayer.h"

@implementation DRInspectionLayer
- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key
{
    NSLog(@"adding animation: %@", [anim debugDescription]);
    [super addAnimation:anim forKey:key];
}


@end


@implementation DRInspectionView
+ (Class)layerClass
{
    return [DRInspectionLayer class];
}

@end
