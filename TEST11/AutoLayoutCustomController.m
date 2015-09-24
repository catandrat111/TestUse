//
//  AutoLayoutCustomController.m
//  TEST11
//
//  Created by dongjl on 15/9/24.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "AutoLayoutCustomController.h"
#import "UIView+FDCollapsibleConstraints.h"
@interface AutoLayoutCustomController ()
@property(nonatomic,weak) IBOutlet UILabel *lab;
@property(nonatomic,weak) IBOutlet UILabel *lab1;
@property(nonatomic,weak) IBOutlet UILabel *lab2;
@property(nonatomic,weak) IBOutlet UIView *redView;
@property(nonatomic,weak) IBOutlet UIView *blueView;
@property (nonatomic, assign) BOOL expanding;
@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, weak) IBOutlet UIImageView *logoImageView1;
@end

@implementation AutoLayoutCustomController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lab.text = @"dsjndjkdsnjsdjndsjndsjkndsjkndsjkdsnjkdsjkn";
    self.lab1.text = @"dsjndjkdsnjsdjndsjndsjkndsjkndsjkdsnjkdsjkndsjndjkdsnjsdjndsjndsjkndsjkndsjkdsnjkdsjkn";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)expand:(id)sender {

    [sender setTitle:self.expanding ? @"Expand" : @"Collapse" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
        self.redView.fd_collapsed = self.expanding;
       // self.blueView.fd_autoCollapse = self.expanding;
         self.logoImageView.fd_collapsed = self.expanding;
        [self.view layoutSubviews];
    } completion:^(BOOL finished) {
        self.expanding = !self.expanding;
    }];

}

- (IBAction)expand1:(id)sender {
    
    [sender setTitle:self.expanding ? @"Expand" : @"Collapse" forState:UIControlStateNormal];
//    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
//        self.logoImageView1.fd_collapsed = self.expanding;
//        [self.view layoutSubviews];
//    } completion:^(BOOL finished) {
//        self.expanding = !self.expanding;
//    }];
    self.logoImageView1.fd_collapsed = self.expanding;
    [self.view layoutSubviews];
    self.expanding = !self.expanding;
}

@end
