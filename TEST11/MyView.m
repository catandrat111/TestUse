//
//  MyView.m
//  TEST11
//
//  Created by dongjl on 15/10/22.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "MyView.h"

@implementation MyView

//改写UIView的intrinsicContentSize
- (CGSize)intrinsicContentSize
{
    return CGSizeMake(70, 40);
}

@end
