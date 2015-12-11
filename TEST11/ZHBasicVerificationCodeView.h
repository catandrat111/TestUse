//
//  ZHBasicVerificationCodeView.h
//  zsch
//
//  Created by dongjl on 15/11/26.
//  Copyright © 2015年 WYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"

@interface ZHBasicVerificationCodeView : UIView<UITextFieldDelegate>
@property (nonatomic,weak) IBOutlet UITextField* verificationCodeTextField;
@property (nonatomic,weak) IBOutlet UIButton* verificationCodeButton;
@property (nonatomic,copy) NSString* phoneNum;
- (IBAction)getVerificationCodeAction:(id)sender;
- (BOOL)judegeVerificationCode ;
@end
