//
//  DR_popAnimationController.m
//  TEST11
//
//  Created by dongjl on 15-9-7.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "DR_popAnimationController.h"
#import "DRInspectionLayer.h"
#import "UIView+DR_CustomBlockAnimations.h"
@interface DR_popAnimationController ()
{
    DRInspectionView* v1;
}
@end

@implementation DR_popAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    v1 = [[DRInspectionView alloc] initWithFrame:CGRectMake(60, 80, 100, 100)];
    v1.backgroundColor = [UIColor redColor];
    [self.view addSubview:v1];

        [UIView DR_popAnimationWithDuration:8
                                 animations:^{
                                     v1.transform = CGAffineTransformMakeRotation(M_PI_2);
                                 }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
