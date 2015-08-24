//
//  AlgorithmClass.m
//  TEST11
//
//  Created by dongjl on 15-8-21.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "AlgorithmClass.h"
#import "AL_sort.h"

#define kSize 20
 #define kMax 100

@implementation AlgorithmClass

- (void)viewDidLoad{
    UIButton* bu = [UIButton buttonWithType:UIButtonTypeCustom];
    [bu setTitle:@"test" forState:UIControlStateNormal];
    [bu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bu];
}


-(void)dealloc{
    
}


-(void)test{
     NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:kSize];
    
     for (int i =0;i<kSize;i++) {
             u_int32_t x = arc4random() % kMax;//0~kMax
             NSNumber *num = [[NSNumber alloc] initWithInt:x];
             [data addObject:num];
         }

     NSLog(@"排序前的数据：%@",[data description]);

     AL_sort *sort = [[AL_sort alloc] init];
     [sort selectSortWithArray:data];
     [sort insertSortWithArray:data];
     [sort quickSortWithArray:data];
}
@end
