//
//  TableInstanceInitCellNoXib.m
//  TEST11
//
//  Created by 董金亮 on 15/7/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "TableInstanceInitCellNoXib.h"

@implementation TableInstanceInitCellNoXib

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//TableInstanceRegisterNoXib* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath]; 来自这个方法
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.lab1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 200, 30)];
        self.lab1.textColor = [UIColor blackColor];
        [self addSubview:self.lab1];
        
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame{
    return nil;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    return nil;
}


@end
