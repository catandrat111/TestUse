//
//  ButtonInstance.m
//  TEST11
//
//  Created by 董金亮 on 15/7/19.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "ButtonInstance.h"
#import "UIButton+BackgroundColor.h"
#import "UIButton+CountDown.h"
#import "UIButton+Indicator.h"
#import "UIButton+Submitting.h"

#import "NSString+Score.h"

@interface ButtonInstance ()

@end

@implementation ButtonInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.button1 setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.button1 showIndicator];
    
    [self.button2 startTime:5 title:@"hello" waitTittle:@"world"];
    
     [self.button3 beginSubmitting:@"ddd"];
    
    NSString* foidStr = @"124325";
    NSMutableString* matchstr = [[NSMutableString alloc] init];
    for (int i = 0; i < foidStr.length -2 ;i++) {
       [matchstr appendString:@"*"];
    }
    foidStr = [foidStr stringByReplacingCharactersInRange:NSMakeRange(1, foidStr.length -2) withString:matchstr];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)p1:(UIButton*)sender{
    [self.button1 endSubmitting];
}

-(IBAction)p2:(UIButton*)sender{
    [self.button1 hideIndicator];
    [self.button3 endSubmitting];
}
-(IBAction)p3:(UIButton*)sender{
    
}
@end
