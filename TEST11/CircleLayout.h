//
//  AppDelegate.m
//  DevDiv_CollectionView_CircleLayout_Demo
//
//  Created by BeyondVincent on 12-7-3.
//  Copyright (c) 2012年 DevDiv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleLayout : UICollectionViewLayout

@property (nonatomic, assign) CGPoint center;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSInteger cellCount;

@end
