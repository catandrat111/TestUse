//
//  SliderInstance.m
//  TEST11
//
//  Created by 董金亮 on 15/7/11.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "SliderInstance.h"

@interface SliderInstance ()

@end

@implementation SliderInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 30, 200, 20)]; //初始化
    slider.minimumValue = 0;//指定可变最小值
    slider.maximumValue = 100;//指定可变最大值
    slider.value = 50;//指定初始值
    [slider addTarget:self action:@selector(updateValue:) forControlEvents:UIControlEventValueChanged];//设置响应事
    [self.view addSubview:slider];
    [slider setThumbTintColor:[UIColor greenColor]];
    [slider setMinimumTrackTintColor:[UIColor greenColor]];
    [slider setMaximumTrackTintColor:[UIColor redColor]];
  //  slider.backgroundColor = [UIColor redColor];
    
//    [slider setMinimumTrackImage:[UIImage imageNamed:@"slidermax.png"] forState:UIControlStateNormal];
//    
//    [slider setMaximumTrackImage:[UIImage imageNamed:@"slidermin.png"] forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)updateValue:(UISlider*)slider{
    float f = slider.value;
    NSLog(@"%f",f);
}
@end
