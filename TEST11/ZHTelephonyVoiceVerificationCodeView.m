//
//  ZHTelephonyVoiceVerifyCodeView.m
//  zsch
//
//  Created by dongjl on 15/11/26.
//  Copyright © 2015年 WYD. All rights reserved.
//

#import "ZHTelephonyVoiceVerificationCodeView.h"
//#import "ZHNetworkEngine.h"
//#import "UIAlertView+Blocks.h"
static int _timeOut = 0;
static UIButton *_timeOutButton = nil;
@implementation ZHTelephonyVoiceVerificationCodeView

- (instancetype)init {
    self = [[NSBundle mainBundle] loadNibNamed:@"ZHTelephonyVoiceVerificationCodeView" owner:self options:nil][0];
    if (self) {
        _timeOutButton = self.verificationCodeButton;
        self.verificationCodeTextField.delegate = self;
        if (_timeOut > 0) {
        [_timeOutButton setUserInteractionEnabled:NO];
            [_timeOutButton setTitle:[NSString stringWithFormat:@"%d秒后重新获取",_timeOut] forState:UIControlStateNormal];
            [_timeOutButton setNeedsDisplay];
        }

    }
    return self;
}

- (void)awakeFromNib {
   //    if (_timeOut > 0) {
//        //[_timeOutButton setUserInteractionEnabled:NO];
//        [_timeOutButton setTitle:[NSString stringWithFormat:@"%d秒后重新获取",_timeOut] forState:UIControlStateNormal];
//        [_timeOutButton setNeedsDisplay];
//    }
}

- (IBAction)getVerificationCodeAction:(id)sender {
    _timeOut = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(_timeOut<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _timeOut = 0;
                [_timeOutButton setTitle:@"获取短信验证" forState:UIControlStateNormal];
                [_timeOutButton setUserInteractionEnabled:YES];
                
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_timeOutButton setUserInteractionEnabled:NO];
                [_timeOutButton setTitle:[NSString stringWithFormat:@"%d秒后重新获取",_timeOut] forState:UIControlStateNormal];
                [_timeOutButton setNeedsDisplay];
            });
            _timeOut--;
            
        }
    });
    
    dispatch_resume(_timer);

//    _timeOut = [ZHNetworkEngine sharedInstance].msgCodeAgainSeconds > 0 ? [ZHNetworkEngine sharedInstance].msgCodeAgainSeconds : 60;//倒计时时间
//    //todo
//    
//    ZHSendMessageCodeReqBody *body =  [[ZHSendMessageCodeReqBody alloc] init];
//    body.type = kORDER;
//    body.mobile = self.phoneNum;
//    body.kind = kVEDIO_MSG;
//    
//    [[ZHNetworkEngine sharedInstance] sendMessageCodeWithReq:body OnFinished:^(id response) {
//        
//        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
//        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
//        dispatch_source_set_event_handler(_timer, ^{
//            if(_timeOut<=0){ //倒计时结束，关闭
//                dispatch_source_cancel(_timer);
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //设置界面的按钮显示 根据自己需求设置
//                    _timeOut = 0;
//                    [_timeOutButton setTitle:@"获取短信验证" forState:UIControlStateNormal];
//                    [_timeOutButton setUserInteractionEnabled:YES];
//                    
//                });
//            }else{
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    
//                    [_timeOutButton setUserInteractionEnabled:NO];
//                    [_timeOutButton setTitle:[NSString stringWithFormat:@"%d秒后重新获取",_timeOut] forState:UIControlStateNormal];
//                    [_timeOutButton setNeedsDisplay];
//                });
//                _timeOut--;
//                
//            }
//        });
//        
//        dispatch_resume(_timer);
//    }];

}

- (BOOL)judegeVerificationCode {
//    if ([self.phoneNum length] == 0) {
//        [[UIAlertView showWithTitle:@"提示" message:@"请填写手机号" cancelButtonTitle:@"返回" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
//            
//        }] show];
//        return NO;
//    }
//    
//    
//    if ([self.verificationCodeTextField.text length] == 0) {
//        [[UIAlertView showWithTitle:@"提示" message:@"请输入验证码" cancelButtonTitle:@"返回" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
//            
//        }] show];
//        return NO;
//    }
    return YES;
}


- (IBAction)closeKeyboard {
    [self.verificationCodeTextField resignFirstResponder];
}



@end
