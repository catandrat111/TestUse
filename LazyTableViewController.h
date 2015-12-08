//
//  LazyTableViewController.h
//  TEST11
//
//  Created by dongjl on 15/12/8.
//  Copyright © 2015年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LazyTableViewController : UITableViewController
// the main data model for our UITableView
@property (nonatomic, strong) NSArray *entries;
@end
