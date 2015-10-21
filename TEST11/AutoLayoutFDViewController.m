//
//  FDViewController.m
//  Demo
//
//  Created by sunnyxx on 15/4/22.
//  Copyright (c) 2015年 Phil. All rights reserved.
//

#import "AutoLayoutFDViewController.h"
#import "UIView+FDCollapsibleConstraints.h"

@interface AutoLayoutFDViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;
@property (nonatomic, assign) BOOL expanding;

@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UILabel *label2;
@property (nonatomic, weak) IBOutlet UIButton *bu1;

@property (nonatomic, weak) IBOutlet UILabel *label3;
@property (nonatomic, weak) IBOutlet UILabel *label4;

@property (nonatomic, weak) IBOutlet UIView *v1;
@property (nonatomic, weak) IBOutlet UIView *v2;

@property (nonatomic, weak) IBOutlet UIView *v3;
@property (nonatomic, weak) IBOutlet UIView *v4;
@end

@implementation AutoLayoutFDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Default value
    self.logoImageView.fd_collapsed = YES;
    self.label.fd_collapsed = YES;
    self.label.autoCollapse = YES;
    
   // self.label3.fd_collapsed = YES;
    //self.bu1.fd_collapsed = YES;
    //self.label3.text = nil;
    [self performSelector:@selector(test1) withObject:nil afterDelay:0.01];
    self.v1.fd_collapsed = YES;

    
}


- (void)test1 {
    //self.label3.text = nil;
    self.label3.fd_collapsed = YES;
    self.v2.fd_collapsed = YES;
    self.v3.fd_collapsed = YES;
    self.v3 = nil;
    //self.v3.fd_collapsed = YES;
}

- (IBAction)expandButtonAction:(UIButton *)sender
{
    [sender setTitle:self.expanding ? @"Expand" : @"Collapse" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
        self.logoImageView.fd_collapsed = self.expanding;
        [self.view layoutSubviews];
    } completion:^(BOOL finished) {
        self.expanding = !self.expanding;
    }];
}

- (IBAction)buttonAction1:(UIButton *)sender
{
    [sender setTitle:self.expanding ? @"Expand" : @"Collapse" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
        self.label.fd_collapsed = self.expanding;
        //self.bu1.fd_collapsed = self.expanding;
        [self.view layoutSubviews];
    } completion:^(BOOL finished) {
        self.expanding = !self.expanding;
    }];

}

- (IBAction)buttonAction2:(UIButton *)sender
{
    [sender setTitle:self.expanding ? @"Expand" : @"Collapse" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
        self.label3.fd_collapsed = self.expanding;
       // self.label3.text=nil;
        self.v2.fd_collapsed = self.expanding;
        [self.view layoutSubviews];
    } completion:^(BOOL finished) {
        self.expanding = !self.expanding;
    }];
    
}

- (IBAction)buttonAction3:(UIButton *)sender
{
    [sender setTitle:self.expanding ? @"Expand" : @"Collapse" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
        // self.label3.fd_collapsed = self.expanding;
        //self.label3.text=nil;
        self.v1.fd_collapsed = self.expanding;
        [self.view layoutSubviews];
    } completion:^(BOOL finished) {
        self.expanding = !self.expanding;
    }];
    
}


@end
