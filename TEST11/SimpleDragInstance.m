//
//  SimpleDragInstance.m
//  TEST11
//
//  Created by dongjl on 15-8-14.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "SimpleDragInstance.h"
#import "HSCButton.h"
@interface SimpleDragInstance ()

@end

@implementation SimpleDragInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    HSCButton* button  = [[HSCButton alloc] initWithFrame:CGRectMake(0, 64, 80, 80)];
    button.dragEnable = YES;
    [self.view addSubview:button];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
