//
//  RRPSectionFootView.m
//  TEST11
//
//  Created by dongjl on 15-8-27.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "RRPSectionFootView.h"

@implementation RRPSectionFootView

-(void)setFrame:(CGRect)frame{
    
    CGRect sectionRect = [self.tableView rectForFooterInSection:self.section]; // 重写MinY的坐标  如何想重写head   rectForHeaderInSection 就用这个函数替换上面的函数
    CGRect newFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(sectionRect), CGRectGetWidth(frame), CGRectGetHeight(frame));
    [super setFrame:newFrame];
}

@end
