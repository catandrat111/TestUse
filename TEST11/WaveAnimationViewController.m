//
//  WaveAnimationViewController.m
//  TEST11
//
//  Created by dongjl on 16/12/8.
//  Copyright © 2016年 djl. All rights reserved.
//

#import "WaveAnimationViewController.h"
#import "YDWaveLoadingView.h"
@interface WaveAnimationViewController ()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) YDWaveLoadingView *loadingView;
@end

@implementation WaveAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _loadingView = [YDWaveLoadingView loadingView];
    [self.view addSubview:_loadingView];
    _loadingView.center = self.view.center;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_loadingView startLoading];
    });
}

- (void)beginLoading:(id)sender
{
    [_loadingView startLoading];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
