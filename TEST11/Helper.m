//
//  Helper.m
//  TestGT
//
//  Created by dongjl on 15/11/26.
//  Copyright © 2015年 gt. All rights reserved.
//

#import "Helper.h"

#import <GTFramework/GTFramework.h>
@implementation Helper
/**
 *  向custom服务器请求gt验证
 */
- (void)requestGTest{
    __weak __typeof(self) weakSelf = self;
    
    /* TODO 在此写入客户端首次向网站主服务端请求gt验证的链接(api_1) (replace demo api_1 with yours)*/
    NSURL *requestGTestURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://testcenter.geetest.com/webapi/apis/start-mobile-captcha/"]];
    GTManager *manager = [GTManager sharedGTManger];
    
    NSDictionary *retDict = [[NSDictionary alloc] init];
    //从字典中取出返回的数据
    //retDict = [manager requestCustomServerForGTest:requestGTestURL];
    NSLog(@"retDict === %@",retDict);
    NSString *GT_captcha_id = [retDict objectForKey:@"gt"];
    NSNumber *gt_success = [retDict objectForKey:@"success"];
    NSString *gt_chanllenge = [retDict objectForKey:@"challenge"];
    
    //在此设置验证背景遮罩的透明度
    manager.backgroundAlpha = 0.4;
    //开启验证视图的阴影
    manager.cornerViewShadow = NO;
    //验证背景颜色(例:yellow 0xffc832 rgb(255,200,50))
    manager.colorWithHexInt = 0xa0a0a0;
    
    NSLog(@"sessionID === %@",manager.sessionID);
    NSLog(@"从网站主服务器获取的id === %@",GT_captcha_id);

    
   BOOL b2 =   [manager serverStatusWithCaptcha_id:@"8f94938d139a3776cfc7e694c9089a63" ];
    BOOL b1 =   [manager requestGTest:@"8f94938d139a3776cfc7e694c9089a63" withChallenge: gt_chanllenge];
    if (YES) {
        [manager openGTViewAddFinishHandler:^(NSString *code, NSDictionary *result, NSString *message) {
             //__strong __typeof(weakSelf)strongSelf = weakSelf;
            if ([code isEqualToString:@"1"]) {
                //在用户服务器进行二次验证(start Secondery-Validate)
                //[weakSelf seconderyValidate:code result:result message:message];
                //                    [weakSelf performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:nil];
            } else {
                NSLog(@"code : %@, message : %@",code,message);
            }
            
        } closeHandler:^{
            //用户关闭验证后执行的方法
            NSLog(@"close geetest");
        } animated:YES];
    } else {
        // TODO 写上检测网络的方法，或者不做任何处理(network error,check your network)
                   NSLog(@"连接网站主服务器异常,网络不通畅");
    }
    
    
//    if ([gt_success intValue] == 1 ) {
//        //根据custom server的返回字段判断是否开启failback
//        if (GT_captcha_id.length == 32) {
//            //打开极速验证，在此处完成gt验证结果的返回
//            [manager openGTViewAddFinishHandler:^(NSString *code, NSDictionary *result, NSString *message) {
//                
//                if ([code isEqualToString:@"1"]) {
//                    //在用户服务器进行二次验证(start Secondery-Validate)
//                    [weakSelf seconderyValidate:code result:result message:message];
//                    //                    [weakSelf performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:nil];
//                } else {
//                    NSLog(@"code : %@, message : %@",code,message);
//                }
//                
//            } closeHandler:^{
//                //用户关闭验证后执行的方法
//                NSLog(@"close geetest");
//            } animated:YES];
//        } else {
//            // TODO 写上检测网络的方法，或者不做任何处理(network error,check your network)
//            NSLog(@"连接网站主服务器异常,网络不通畅");
//        }
//    }else{
//        //TODO 当极验服务器不可用时，将执行此处网站主的自定义验证方法或者其他处理方法(gt-server is not available, add your hanle methods)
//        /*请网站主务必考虑这一处的逻辑处理，否者当极验服务不可用的时候会导致用户的业务无法正常执行*/
//        NSLog(@"极验验证服务暂时不可用,请网站主在此写入启用备用验证的方法");
//    }
    
}

/**
 *  二次验证是验证的必要环节,此方法的构造供参考,可根据需求自行调整
 *
 *  @param code    <#code description#>
 *  @param result  <#result description#>
 *  @param message <#message description#>
 */
//- (void)seconderyValidate:(NSString *)code result:(NSDictionary *)result message:(NSString *)message {
//    if (code && result) {
//        @try {
//            if ([code isEqualToString:@"1"]) {
//                //TODO行为判定通过，进行二次验证,替换成你的api_2(replace this demo api_2 with yours)
//                /* custom_server_validate_url 网站主部署的二次验证链接 (api_2)*/
//                NSString *custom_server_validate_url = @"http://testcenter.geetest.com/gtweb/android_sdk_demo_server_validate/";
//                NSDictionary *headerFields = @{@"Content-Type":@"application/x-www-form-urlencoded;charset=UTF-8"};
//                MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:nil customHeaderFields:headerFields];
//                
//                MKNetworkOperation *operation = [engine operationWithURLString:custom_server_validate_url
//                                                                        params:result
//                                                                    httpMethod:@"POST"];
//                
//                [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//                    
//                    if (completedOperation.HTTPStatusCode == 200) {
//                        //TODO 二次验证成功后执行的方法(after finish Secondery-Validate, to do something)
//                        NSLog(@"client captcha response:%@",completedOperation.responseString);
//                        
//                        [self showSuccessView:YES];
//                    } else {
//                        NSLog(@"client captcha response:%@",completedOperation.responseString);
//                        
//                        [self showSuccessView:NO];
//                    }
//                    
//                } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//                    NSLog(@"client captcha response error:%@",error.localizedDescription);
//                }];
//                
//                [engine enqueueOperation:operation];
//                
//            } else {
//                // TODO 验证失败(Secondery-Validate fail)
//                NSLog(@"client captcha failed:\ncode :%@ message:%@ result:%@", code, message, result);
//            }
//        }
//        @catch (NSException *exception) {
//            NSLog(@"client captcha exception:%@", exception.description);
//        }
//        @finally {
//            
//        }
//    }
//}

- (void)showSuccessView:(BOOL)result{
    NSString *message = [[NSString alloc] init];
    if (result) {
        message = @"成功";
    }else{
        message = @"失败";
    }
    UIAlertView *seconderyResult = [[UIAlertView alloc] initWithTitle:@"二次验证结果"
                                                              message:message
                                                             delegate:self
                                                    cancelButtonTitle:@"确定"
                                                    otherButtonTitles:nil, nil];
    [seconderyResult show];
}

@end
