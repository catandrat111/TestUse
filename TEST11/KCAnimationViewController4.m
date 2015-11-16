//
//  KCAnimationViewController4.m
//  TEST11
//
//  Created by dongjl on 15/11/13.
//  Copyright © 2015年 djl. All rights reserved.
//在使用Quartz 2D在UIView中绘制图形的本质也是绘制到图层中，为了说明这个问题下面演示自定义图层绘图时没有直接在视图控制器中调用自定义图层，而是在一个UIView将自定义图层添加到UIView的根图层中（例子中的UIView跟自定义图层绘图没有直接关系）。从下面的代码中可以看到：UIView在显示时其根图层会自动创建一个CGContextRef（CALayer本质使用的是位图上下文），同时调用图层代理（UIView创建图层会自动设置图层代理为其自身）的draw: inContext:方法并将图形上下文作为参数传递给这个方法。而在UIView的draw:inContext:方法中会调用其drawRect:方法，在drawRect:方法中使用UIGraphicsGetCurrentContext()方法得到的上下文正是前面创建的上下文。

#import "KCAnimationViewController4.h"
#import "KCAnimationView1.h"
@interface KCAnimationViewController4 ()

@end

@implementation KCAnimationViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    KCAnimationView1 *view=[[KCAnimationView1 alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor=[UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1];


    [self.view addSubview:view];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
