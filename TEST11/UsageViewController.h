//
//  UsageViewController.h
//  TEST11
//
//  Created by 董金亮 on 15/8/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsageViewController : UIViewController

@property(weak,nonatomic) IBOutlet UILabel* lab;
-(IBAction)sortAction:(id)sender;
-(IBAction)quchongAction:(id)sender;
-(IBAction)filterAction:(id)sender;
-(IBAction)observeLab:(id)sender;
@end

