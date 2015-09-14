//
//  TableViewLayoutCell.m
//  TEST11
//
//  Created by dongjl on 15-9-14.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "TableViewLayoutCell.h"

@implementation TableViewLayoutCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

- (void)setModel:(LayoutModel *)model{
    self.name1.text = model.name1;
    self.name2.text = model.name2;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat totalHeight = 0;
    totalHeight += [self.name1 sizeThatFits:size].height;
    totalHeight += [self.name2 sizeThatFits:size].height;
    totalHeight += 10; // margins
    return CGSizeMake(size.width, totalHeight);
}


@end
