//
//  TableViewLayoutCell1.m
//  TEST11
//
//  Created by dongjl on 15-9-15.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "TableViewLayoutCell1.h"

@implementation TableViewLayoutCell1

- (void)awakeFromNib {
        [super awakeFromNib];
     self.contentView.bounds = [UIScreen mainScreen].bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(LayoutModel *)model{
    _model = model;
    self.name1.text = model.name1;
    self.name2.text = model.name2;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 0;
    totalHeight += [self.name1 sizeThatFits:size].height;
    totalHeight += [self.name2 sizeThatFits:size].height;
    totalHeight += 60; // margins
    NSLog(@"%f",totalHeight);
    return CGSizeMake(size.width, totalHeight);
}


@end
