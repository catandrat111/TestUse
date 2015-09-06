//
//  BasicUsageViewController.m
//  TEST11
//
//  Created by dongjl on 15-9-6.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "BasicUsageViewController.h"
#import "DRInspectionLayer.h"
#import "UIView+DR_CustomBlockAnimations.h"
@interface BasicUsageViewController ()
{
    DRInspectionView* v1;
}
@end

@implementation BasicUsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    v1 = [[DRInspectionView alloc] initWithFrame:CGRectMake(60, 80, 100, 100)];
    v1.backgroundColor = [UIColor redColor];
    [self.view addSubview:v1];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(60, 180, 60, 60)];
    [button setTitle:@"p1" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(p1) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    
    //layer 通过向它的 delegate 发送 actionForLayer:forKey: 消息来询问提供一个对应属性变化的 action。delegate 可以通过返回以下三者之一来进行响应：
    
    //它可以返回一个动作对象，这种情况下 layer 将使用这个动作。
    //它可以返回一个 nil， 这样 layer 就会到其他地方继续寻找。
    //它可以返回一个 NSNull 对象，告诉 layer 这里不需要执行一个动作，搜索也会就此停止。
    //打印出的 NSNull 是带着一对尖括号的 ("<null>") 而打印 nil 的时候我们得到的是普通括号((null))
//    NSLog(@"outside animation block: %@",
//          [self.view actionForLayer:self.view.layer forKey:@"position"]);//UIVIEW 默认关闭动画
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        NSLog(@"inside animation block: %@",
//              [self.view actionForLayer:self.view.layer forKey:@"position"]);//block 打开动画
//    }];
    
    [UIView DR_popAnimationWithDuration:8
                             animations:^{
                                 v1.transform = CGAffineTransformMakeRotation(M_PI_2);
                             }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)p1{
    [UIView animateWithDuration:3 animations:^{
        v1.layer.position = CGPointMake(100, 80);
    }];
}

@end
