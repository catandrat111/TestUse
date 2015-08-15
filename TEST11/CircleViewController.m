//
//  CircleViewController.m
//  TEST11
//
//  Created by 董金亮 on 15/8/14.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "CircleViewController.h"
#import "CircleProgressView.h"
@interface CircleViewController ()
{
    CircleProgressView *progress;
}
@end

@implementation CircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    progress = [[CircleProgressView alloc] initWithFrame:CGRectMake(0, 64, 60, 60)];
    progress.fstartValue = 0;
    progress.flineWidth = 2.0f;
    progress.lineColor = [UIColor redColor];
    //view.fvalue = 1.0f;
    [self.view addSubview:progress];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(circleAnimation) userInfo:nil repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)circleAnimation
{
    progress.fvalue = arc4random()%100/100.f;
}


@end
