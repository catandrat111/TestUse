//
//  TableViewLayoutCell.h
//  TEST11
//
//  Created by dongjl on 15-9-14.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutModel.h"
@interface TableViewLayoutCell : UITableViewCell
@property(strong,nonatomic) LayoutModel *model;
@property(strong,nonatomic) IBOutlet UILabel *name1;
@property(strong,nonatomic) IBOutlet UILabel *name2;
@end
