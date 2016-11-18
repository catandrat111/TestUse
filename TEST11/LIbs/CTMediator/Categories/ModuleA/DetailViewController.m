//
//  DetailViewController.m
//  CTMediator
//
//  Created by yehot on 16/5/28.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"详情";
    
    [self.view addSubview:self.nameLabel];
    
    self.nameLabel.text = self.name;
}

#pragma mark - getter

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 100)];
        _nameLabel.backgroundColor = [UIColor grayColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

@end
