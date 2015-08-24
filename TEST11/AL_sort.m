//
//  AL_sort.m
//  TEST11
//
//  Created by dongjl on 15-8-21.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "AL_sort.h"
@interface AL_sort()
 -(void)quickSortWithArray:(NSArray *)aData left:(NSInteger)left right:(NSInteger)right;
@end


@implementation AL_sort
- (id)init
 {
         self = [super init];
         if (self) {
                 // Initialization code here.
             }
    
         return self;
     }

 -(void)selectSortWithArray:(NSArray *)aData{
         NSMutableArray *data = [[NSMutableArray alloc]initWithArray:aData];
         for (int i=0; i<[data count]-1; i++) {
                 int m =i;
                 for (int j =i+1; j<[data count]; j++) {
                         if ([data objectAtIndex:j] < [data objectAtIndex:m]) {
                                 m = j;
                             }
                     }
                 if (m != i) {
                         [self swapWithData:data index1:m index2:i];
                     }
             }
         NSLog(@"选择排序后的结果：%@",[data description]);
   
     }

 -(void)insertSortWithArray:(NSArray *)aData{
         NSMutableArray *data = [[NSMutableArray alloc]initWithArray:aData];
         for (int i = 1; i < [data count]; i++) {
                 id tmp = [data objectAtIndex:i];
                 int j = i-1;
                 while (j != -1 && [data objectAtIndex:j] > tmp) {
                         [data replaceObjectAtIndex:j+1 withObject:[data objectAtIndex:j]];
                         j--;
                     }
                 [data replaceObjectAtIndex:j+1 withObject:tmp];
             }
         NSLog(@"插入排序后的结果：%@",[data description]);
  
     }

 -(void)quickSortWithArray:(NSArray *)aData{
         NSMutableArray *data = [[NSMutableArray alloc] initWithArray:aData];
         [self quickSortWithArray:data left:0 right:[aData count]-1];
         NSLog(@"快速排序后的结果：%@",[data description]);
   
    
     }

 -(void)quickSortWithArray:(NSMutableArray *)aData left:(NSInteger)left right:(NSInteger)right{
         if (right > left) {
                 NSInteger i = left;
                 NSInteger j = right + 1;
                 while (true) {
                         while (i+1 < [aData count] && [aData objectAtIndex:++i] < [aData objectAtIndex:left]) ;
                         while (j-1 > -1 && [aData objectAtIndex:--j] > [aData objectAtIndex:left]) ;
                         if (i >= j) {
                                 break;
                             }
                         [self swapWithData:aData index1:i index2:j];
                     }
                 [self swapWithData:aData index1:left index2:j];
                 [self quickSortWithArray:aData left:left right:j-1];
                 [self quickSortWithArray:aData left:j+1 right:right];
             }
     }


 -(void)dealloc{
     
     }

 -(void)swapWithData:(NSMutableArray *)aData index1:(NSInteger)index1 index2:(NSInteger)index2{
         NSNumber *tmp = [aData objectAtIndex:index1];
         [aData replaceObjectAtIndex:index1 withObject:[aData objectAtIndex:index2]];
         [aData replaceObjectAtIndex:index2 withObject:tmp];
     }

@end
