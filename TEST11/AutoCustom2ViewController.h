//
//  AutoCustom2ViewController.h
//  TEST11
//
//  Created by dongjl on 15/10/22.
//  Copyright © 2015年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoCustom2ViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITableView* tableView;
@property (nonatomic,strong) IBOutlet UIView* footerView;

@property (nonatomic,strong) IBOutlet UIButton* confirmButton;
@property (nonatomic,strong) IBOutlet UIButton* fromContactButton;
@property (nonatomic,strong) IBOutlet UIButton* tongxunButton;
@property (nonatomic,strong) IBOutlet UILabel* lab1;
@end
