//
//  SegmentControlInstanceviewViewController.m
//  TEST11
//
//  Created by dongjl on 15-8-28.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "SegmentControlInstanceView.h"

@interface SegmentControlInstanceView ()

@end

@implementation SegmentControlInstanceView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.segment1.layer.cornerRadius = 18.f;//xib 无法改变  需要手动编写
    self.segment1.momentary = YES;//设置在点击后是否恢复原样
     [self.segment1 setWidth:90.0 forSegmentAtIndex:0];//设置指定索引选项的宽度
    [self.segment1 setWidth:70.0 forSegmentAtIndex:1];//设置指定索引选项的宽度
    [self.segment1 setWidth:40.0 forSegmentAtIndex:2];//设置指定索引选项的宽度
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:nil];
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar; //控件风格小按钮，适合导航栏：
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBezeled; //控件风格
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBordered; //控件风格黑边的大白按钮，适合表格单元
    segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain; //控件风格灰边大白按钮，适合偏好设置单元
    
    segmentedControl.tintColor = [UIColor yellowColor]; //渲染色彩 //默认 边框色和选中色一样
    segmentedControl.layer.borderWidth = 1.0f;
    segmentedControl.layer.borderColor = [UIColor redColor].CGColor;//修改边框色
    segmentedControl.layer.cornerRadius = 18.0f;
    segmentedControl.layer.masksToBounds = YES;
    
    //添加片段，从0单元开始 ,可加入标题或图片两种情况
    [segmentedControl insertSegmentWithTitle:@"First"atIndex:0 animated:NO];
    [segmentedControl insertSegmentWithTitle:@"Second"atIndex:1 animated:NO];
    segmentedControl.frame = CGRectMake(0, 64, 100, 50);
    [self.view addSubview:segmentedControl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
