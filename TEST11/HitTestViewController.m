//
//  HitTestViewController.m
//  TEST11
//
//  Created by dongjl on 15-8-25.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "HitTestViewController.h"
#import "HitTestAView.h"
@interface HitTestViewController ()

@end

@implementation HitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HitTestAView* testView = [[HitTestAView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:testView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
