//
//  ButtonInstance.h
//  TEST11
//
//  Created by 董金亮 on 15/7/19.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DQAlertView.h"
@interface ButtonInstance : UIViewController
@property(weak,nonatomic) IBOutlet UIButton* button1;
@property(weak,nonatomic) IBOutlet UIButton* button2;
@property(weak,nonatomic) IBOutlet UIButton* button3;
@property(weak,nonatomic) IBOutlet UIButton* button4;
@property(weak,nonatomic) IBOutlet UIButton* button5;
@property(weak,nonatomic) IBOutlet UIButton* stretchButton;
@property(weak,nonatomic) IBOutlet UILabel* lab;
@property(weak,nonatomic) IBOutlet UIImageView* imgView;
@property(weak,nonatomic) IBOutlet UIImageView* imgView2;
@property(strong,nonatomic) NSURL* sourceURL; //@s///
@property(strong,nonatomic) NSString* testStr;
@property(nonatomic) BOOL isFinish; //@s///

-(IBAction)p1:(id)sender;
-(IBAction)p2:(id)sender;
-(IBAction)p3:(id)sender;
-(IBAction)p4:(id)sender;

-(IBAction)p5:(id)sender;

-(IBAction)p12:(id)sender;
@end
