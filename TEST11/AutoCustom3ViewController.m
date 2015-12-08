//
//  AutoCustom3ViewController.m
//  TEST11
//
//  Created by dongjl on 15/12/3.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "AutoCustom3ViewController.h"

@interface AutoCustom3ViewController ()

@end

@implementation AutoCustom3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)p1:(id)sender {
    self.v1.transform = CGAffineTransformRotate(self.v1.transform, M_PI/5);
    CGPoint po = {0,0.5};
    self.v1.layer.anchorPoint = po;
   // self.v1.transform = CGAffineTransformMakeScale(0.8, 0.8);
}
@end
