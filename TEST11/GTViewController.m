//
//  GTViewController.m
//  TEST11
//
//  Created by dongjl on 15/12/11.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "GTViewController.h"

#import "GTFramework/GTFramework.h"
#import "Helper.h"
@implementation GTViewController

- (void)viewDidLoad {
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(testAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (IBAction)testAction:(id)sender {
    self.helper =   [[Helper alloc]init];
    [self.helper requestGTest];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.view.transform = CGAffineTransformMakeRotation(-M_2_PI);
    });
}
@end
