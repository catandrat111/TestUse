//
//  AppDelegate.m
//  DevDiv_CollectionView_CircleLayout_Demo
//
//  Created by BeyondVincent on 12-7-3.
//  Copyright (c) 2012年 DevDiv. All rights reserved.
//

#import "CircleCell.h"

@implementation CircleCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius = 10.0;
        [self.contentView setFrame:CGRectMake(0, 0, 75, 75)];
        self.contentView.layer.borderWidth = 1.0f;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.contentView.backgroundColor = [UIColor underPageBackgroundColor];
        
        self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"98_avatar_big.jpg"]];
        
        self.imageView.layer.masksToBounds = YES;  
        self.imageView.layer.cornerRadius = 10.0;
        [self.imageView setFrame:self.contentView.frame];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
