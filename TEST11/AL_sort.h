//
//  AL_sort.h
//  TEST11
//
//  Created by dongjl on 15-8-21.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AL_sort : NSObject
//选择排序
 -(void)selectSortWithArray:(NSArray *)aData;
 //插入排序
 -(void)insertSortWithArray:(NSArray *)aData;
 //快速排序
 -(void)quickSortWithArray:(NSArray *)aData;

 -(void)swapWithData:(NSMutableArray *)aData index1:(NSInteger)index1 index2:(NSInteger)index2;

@end
