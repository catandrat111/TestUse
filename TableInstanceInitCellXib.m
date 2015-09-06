//
//  TableInstanceInitCellXib.m
//  TEST11
//
//  Created by 董金亮 on 15/7/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "TableInstanceInitCellXib.h"

@implementation TableInstanceInitCellXib

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    UIView* view = [super hitTest:point withEvent:event];
//  
//    if(view.frameOrigin.x == 0){
//        return nil;
//    }
//    
//    return view;
//}



@end
