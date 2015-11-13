//
//  ButtonInstance.h
//  TEST11
//
//  Created by 董金亮 on 15/7/19.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonInstance : UIViewController
@property(weak,nonatomic) IBOutlet UIButton* button1;
@property(weak,nonatomic) IBOutlet UIButton* button2;
@property(weak,nonatomic) IBOutlet UIButton* button3;
@property(weak,nonatomic) IBOutlet UIButton* stretchButton;
@property(weak,nonatomic) IBOutlet UILabel* lab;
@property(weak,nonatomic) IBOutlet UIImageView* imgView;
@property(strong,nonatomic) NSURL* sourceURL; //@s///

-(IBAction)p1:(id)sender;
-(IBAction)p2:(id)sender;
-(IBAction)p3:(id)sender;

@end
