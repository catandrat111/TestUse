//
//  NavigationBarInstanceView.m
//  TEST11
//
//  Created by 董金亮 on 15/8/1.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "NavigationBarInstanceView.h"

@interface NavigationBarInstanceView ()

@end

@implementation NavigationBarInstanceView

- (void)viewDidLoad {
/*
: 导航栏的按钮(如返回)颜色
titleTextAttributes: 标题颜色
barTintColor: 背景颜色
translucent: 是否透明
 */
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    self.bar1.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    self.bar1.tintColor = [UIColor redColor];
    self.bar1.barTintColor = [UIColor yellowColor];
    self.bar1.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;

    //导航栏的按钮(如返回)颜色
    self.navigationController.navigationBar.tintColor = [UIColor  greenColor];
    
    self.title = @"test";
   // 方法中设置所有返回按钮文字的偏移量 //也可以直接设置LEFTBAIBUTTON 字体设为空就看不到字体  它的优先级高
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(20, 20) forBarMetrics:UIBarMetricsDefault];
    
    //标题垂直偏移
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:20 forBarMetrics:UIBarMetricsDefault];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
