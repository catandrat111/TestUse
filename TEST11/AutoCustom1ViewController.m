//
//  AutoCustom1ViewController.m
//  TEST11
//
//  Created by dongjl on 15/10/22.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "AutoCustom1ViewController.h"
#import "MyView.h"
@interface AutoCustom1ViewController () {
    UIButton *btn;
}

@end

@implementation AutoCustom1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    //[self test1];
    //[self test2];
    //[self test3];
    [self test4];
}


- (void)test1 {
    //但是运行后会发现，界面上不会显示任何东西。原因就是上面讲的，UIView默认是没有intrinsicContentSize的。我们可以通过创建一个自定义的UIView来改写intrinsicContentSize。
    
    //view1
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor yellowColor];
    //不允许AutoresizingMask转换成Autolayout
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:view1];
    //设置左，上，右边距为20.
    [self setEdge:self.view view:view1 attr:NSLayoutAttributeLeft constant:20];
    [self setEdge:self.view view:view1 attr:NSLayoutAttributeTop constant:20];
    [self setEdge:self.view view:view1 attr:NSLayoutAttributeRight constant:-20];
}


- (void)test2 {
    //view1
    MyView *view1 = [MyView new];
    view1.backgroundColor = [UIColor yellowColor];
    //不允许AutoresizingMask转换成Autolayout
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:view1];
    //设置左，上，右边距为20.
    [self setEdge:self.view view:view1 attr:NSLayoutAttributeLeft constant:20];
    [self setEdge:self.view view:view1 attr:NSLayoutAttributeTop constant:20];
    [self setEdge:self.view view:view1 attr:NSLayoutAttributeRight constant:-20];
    
    NSLog(@"%@",view1);
    
    //view2
    MyView *view2 = [MyView new];
    view2.backgroundColor = [UIColor yellowColor];
    //不允许AutoresizingMask转换成Autolayout
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:view2];
    //设置左，下，右边距为20.
    [self setEdge:self.view view:view2 attr:NSLayoutAttributeLeft constant:20];
    [self setEdge:self.view view:view2 attr:NSLayoutAttributeBottom constant:-20];
    [self setEdge:self.view view:view2 attr:NSLayoutAttributeRight constant:-20];
    
    //设置两个View上下间距为20
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20]];
    
    //Content Hugging Priority代表控件拒绝拉伸的优先级。优先级越高，控件会越不容易被拉伸。
    //而下面的Content Compression Resistance Priority代表控件拒绝压缩内置空间的优先级。优先级越高，控件的内置空间会越不容易被压缩。而这里的内置空间，就是上面讲的UIView的intrinsicContentSize。
    [view2 setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
}


// 定义高度是父View的三分之一 设置btn最小高度为150 运行后，横向屏幕中的Button高度成了150：
- (void)test3 {
    //创建UIButton，不需要设置frame
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"mgen" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
    
    //禁止自动转换AutoresizingMask
    btn.translatesAutoresizingMaskIntoConstraints = NO;
   
    //居中
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:btn
                              attribute:NSLayoutAttributeCenterX
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeCenterX
                              multiplier:1
                              constant:0]];
    
    //距离底部20单位
    //注意NSLayoutConstraint创建的constant是加在toItem参数的，所以需要-20。
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:btn
                              attribute:NSLayoutAttributeBottom
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeBottom
                              multiplier:1
                              constant:-20]];
    
    //定义高度是父View的三分之一
    //设置优先级低于UILayoutPriorityRequired(1000)，UILayoutPriorityDefaultHigh是750
    NSLayoutConstraint *con = [NSLayoutConstraint
                               constraintWithItem:btn
                               attribute:NSLayoutAttributeHeight
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.view
                               attribute:NSLayoutAttributeHeight
                               multiplier:0.3
                               constant:0];
    con.priority = UILayoutPriorityDefaultHigh;
    
    //设置btn最小高度为150
    [btn addConstraint:[NSLayoutConstraint
                        constraintWithItem:btn
                        attribute:NSLayoutAttributeHeight
                        relatedBy:NSLayoutRelationGreaterThanOrEqual
                        toItem:nil
                        attribute:NSLayoutAttributeNotAnAttribute
                        multiplier:1
                        constant:150]];

    
    //注册KVO方法
    [btn addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:nil];

}

//TEST Hugging priority
//Hugging priority 确定view有多大的优先级阻止自己变大。

//Compression Resistance priority确定有多大的优先级阻止自己变小。
//右边的constraint的优先级我们设置的为751.0，此时autolayout系统会去首先满足此constraint，再去满足Content Compression Resistance（其优先级为750，小于751）。
- (void)test4 {
    UIButton*  button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    [button1 setTitle:@"button 1 button 2" forState:UIControlStateNormal];
    [button1 sizeToFit];//有宽高
    NSLog(@"%@",button1);
    
    [self.view addSubview:button1];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:100.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:100.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-150.0f];
    //constraint.priority = 751.0f;
    constraint.priority = 749.0f;
    [self.view addConstraint:constraint];
}

- (void)test5 {
    UIButton*  button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    [button1 setTitle:@"button 1 button 2" forState:UIControlStateNormal];
    [button1 sizeToFit];
    
    [self.view addSubview:button1];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:100.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:100.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-10.0f];
    constraint.priority = 251.0f;
    [self.view addConstraint:constraint];
}

//KVO回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == btn && [keyPath isEqualToString:@"bounds"])
    {
        [btn setTitle:NSStringFromCGSize(btn.bounds.size) forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置Autolayout中的边距辅助方法
- (void)setEdge:(UIView*)superview view:(UIView*)view attr:(NSLayoutAttribute)attr constant:(CGFloat)constant
{
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:attr relatedBy:NSLayoutRelationEqual toItem:superview attribute:attr multiplier:1.0 constant:constant]];
}

@end
