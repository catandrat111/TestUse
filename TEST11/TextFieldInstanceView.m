//
//  TextFieldInstanceView.m
//  TEST11
//
//  Created by 董金亮 on 15/8/3.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "TextFieldInstanceView.h"

@interface TextFieldInstanceView ()

@end

@implementation TextFieldInstanceView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.inputView = self.footerview;//弹出INPUTVIEW
    //self.textField.text = @"ssss";
    self.textField.placeholder = @"ddd";
    NSAttributedString *strUser = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
    self.textField.attributedPlaceholder = strUser;//更改PLACEHOLDER颜色
    
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
