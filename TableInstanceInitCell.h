//
//  TableInstanceInitCell.h
//  TEST11
//
//  Created by 董金亮 on 15/7/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UITableViewCellInitType) {
    UITableViewCellRegisterNoXib,
    UITableViewCellRegisterXib,
    UITableViewCellNoRegisterNoXib,
    UITableViewCellNoRegisterXib
};

@interface TableInstanceInitCell : UIViewController
@property(nonatomic) UITableViewCellInitType initType;
@end
