//
//  TableViewLayoutCell1.h
//  TEST11
//
//  Created by dongjl on 15-9-15.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LayoutModel.h"
@interface TableViewLayoutCell1 : UITableViewCell
@property(strong,nonatomic) LayoutModel *model;
@property(weak,nonatomic) IBOutlet UILabel *name1;
@property(weak,nonatomic) IBOutlet UILabel *name2;
@end
