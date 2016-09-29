//
//  WebView3ViewController.m
//  TEST11
//
//  Created by dongjl on 16/9/29.
//  Copyright © 2016年 djl. All rights reserved.
//
//用af实现https连接
#import "WebView3ViewController.h"
#import "UIWebView+AFNetworking.h"

@interface WebView3ViewController ()  <UIWebViewDelegate>
@property (nonatomic,strong) UIWebView* webView;
@end

@implementation WebView3ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    [self testHttps];
    
}


- (void)testHttps {
    NSString* urlStr = @"https://mapi.alipay.com/gateway.do?sign=7abb084d4493890e144fdb3ac90a1285&body=%E5%9B%9B%E5%B7%9D%E8%88%AA%E7%A9%BA%E5%A4%A7%E5%AE%A2%E6%88%B7%E4%B8%93%E5%8C%BA%E6%9C%BA%E7%A5%A8&_input_charset=UTF-8&exter_invoke_ip=172.16.5.109&it_b_pay=30m&subject=%E5%9B%9B%E5%B7%9D%E8%88%AA%E7%A9%BA%E5%A4%A7%E5%AE%A2%E6%88%B7%E4%B8%93%E5%8C%BA%E6%9C%BA%E7%A5%A8&total_fee=0.01&sign_type=MD5&service=create_direct_pay_by_user&notify_url=http%3A%2F%2F114.242.187.254%3A4135%2Fpay-center%2Fnotify%2FALPC%2F2&qr_pay_mode=2&partner=2088101054133484&seller_id=2088101054133484&out_trade_no=JSWFALPC201609271802389NR1&payment_type=1&return_url=http%3A%2F%2Fm.scal.com.cn%2Fheavybuyer_port_service%2FpaySuccessForIOS.jsp";
    //
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    self.webView.delegate = self;
    NSProgress* progress = [NSProgress progressWithTotalUnitCount:100];
    [self.webView loadRequest:request progress:&progress
                      success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
                          NSLog(@"hello");
                          [self.webView loadHTMLString:HTML baseURL:[NSURL URLWithString:urlStr]];
                          return nil;
                      } failure:^(NSError * _Nonnull error) {
                          
                      }];
    
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
@end
