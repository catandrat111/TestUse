//
//  DrawViewController.m
//  TEST11
//
//  Created by dongjl on 15/11/12.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "DrawViewController.h"
//#import "KCView3.h"
#import "KCView.h"
@interface DrawViewController ()

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KCView* v1 = [[KCView alloc] initWithFrame:self.view.bounds];
    v1.type = self.type;
    v1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:v1];
    
        //KCView3* v3 = [[KCView3 alloc] initWithFrame:self.view.bounds];
        //[self.view addSubview:v3];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
