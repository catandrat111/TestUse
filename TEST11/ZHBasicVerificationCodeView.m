//
//  ZHBasicVerificationCodeView.m
//  zsch
//
//  Created by dongjl on 15/11/26.
//  Copyright © 2015年 WYD. All rights reserved.
//

#import "ZHBasicVerificationCodeView.h"

@implementation ZHBasicVerificationCodeView

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (BOOL)judegeVerificationCode  {
    return NO;
}


- (IBAction)getVerificationCodeAction:(id)sender {
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.verificationCodeTextField resignFirstResponder];
    return YES;
}
@end
