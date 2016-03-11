//
//  AutoCustom3ViewController.m
//  TEST11
//
//  Created by dongjl on 15/12/3.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "AutoCustom3ViewController.h"
#import "masonry.h"
@interface AutoCustom3ViewController ()

@end

@implementation AutoCustom3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)p1:(id)sender {
    self.v1.transform = CGAffineTransformRotate(self.v1.transform, M_PI/5);
    CGPoint po = {0,0.5};
    self.v1.layer.anchorPoint = po;
   // self.v1.transform = CGAffineTransformMakeScale(0.8, 0.8);
}

//宽高约束放在view本身
//其他约束放在fuview上 可参考xib观察constraint
- (IBAction)p2:(id)sender {
   
   // [self.view layoutIfNeeded];
    [UIView animateWithDuration:3.0 animations:^{
        //遍历查找view的heigh约束，并修改它
        NSArray *constrains = self.view.constraints;
        for (NSLayoutConstraint* constraint in constrains) {
            if (constraint.firstAttribute == NSLayoutAttributeLeading && constraint.firstItem == self.v2) {
                constraint.constant = 100;
            }
        }
        //更新约束  在某个时刻约束会被还原成frame使视图显示
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

//http://www.cocoachina.com/ios/20151022/13872.html
//masonry 动画 支持masonr的代码实现 （如果在xib中constraint 则不支持 ）
- (IBAction)p3:(id)sender {
    
    UIView *subView = [[UIView alloc] init];
    [subView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:subView];
    //layout 子view
    __weak __typeof(self)weakSelf  = self;
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        //子view的上边缘离父view的上边缘100个像素
        make.top.equalTo(weakSelf.view).with.offset(270);
        //子view的左边缘离父view的左边缘50个像素
        make.left.equalTo(weakSelf.view).with.offset(30);
        //子view的高度为1
        make.height.equalTo(@50);
        make.width.equalTo(@50);

    }];
    
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:3.0 animations:^{
        [subView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@300);
        }];
        //更新约束  在某个时刻约束会被还原成frame使视图显示
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}


+(NSLayoutConstraint *) findFirstConstraint:(UIView *)parentView firstItem:(id)firstItem  attribute:(NSLayoutAttribute)attribute{
    for (NSLayoutConstraint *constraint in parentView.constraints) {
        
        if((constraint.firstItem == firstItem) && (constraint.firstAttribute == attribute)){
            NSLog(@"find! %@",firstItem);
            return constraint;
        }
    }
    return nil;
    
}

+(NSLayoutConstraint *) findSecondConstraint:(UIView *)parentView secondItem:(id)secondItem  attribute:(NSLayoutAttribute)attribute
{
    for (NSLayoutConstraint *constraint in parentView.constraints) {
        
        if((constraint.secondItem == secondItem) && (constraint.secondAttribute == attribute)){
            NSLog(@"find! %@",secondItem);
            return constraint;
        }
    }
    
    return nil;
}

@end
