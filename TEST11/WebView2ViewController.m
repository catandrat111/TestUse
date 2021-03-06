//
//  WebView2ViewController.m
//  TEST11
//
//  Created by dongjl on 15/11/27.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "WebView2ViewController.h"
#import "MyWebView.h"
#import "UIWebView+AFNetworking.h"
#import "AFHTTPSessionManager.h"
@interface WebView2ViewController ()
@property (nonatomic,strong) MyWebView* webView;
@end

@implementation WebView2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[MyWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"html1" ofType:@"html"];
     NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    //webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;//自动检测网页上的电话号码，单击可以拨打
  //  [self testHttps];
    

}

- (void)testHttps {
    NSString* urlStr = @"https://mapi.alipay.com/gateway.do?sign=7abb084d4493890e144fdb3ac90a1285&body=%E5%9B%9B%E5%B7%9D%E8%88%AA%E7%A9%BA%E5%A4%A7%E5%AE%A2%E6%88%B7%E4%B8%93%E5%8C%BA%E6%9C%BA%E7%A5%A8&_input_charset=UTF-8&exter_invoke_ip=172.16.5.109&it_b_pay=30m&subject=%E5%9B%9B%E5%B7%9D%E8%88%AA%E7%A9%BA%E5%A4%A7%E5%AE%A2%E6%88%B7%E4%B8%93%E5%8C%BA%E6%9C%BA%E7%A5%A8&total_fee=0.01&sign_type=MD5&service=create_direct_pay_by_user&notify_url=http%3A%2F%2F114.242.187.254%3A4135%2Fpay-center%2Fnotify%2FALPC%2F2&qr_pay_mode=2&partner=2088101054133484&seller_id=2088101054133484&out_trade_no=JSWFALPC201609271802389NR1&payment_type=1&return_url=http%3A%2F%2Fm.scal.com.cn%2Fheavybuyer_port_service%2FpaySuccessForIOS.jsp";
    //
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    self.webView.delegate = self.webView;
    NSProgress* progress = [NSProgress progressWithTotalUnitCount:100];
    [self.webView loadRequest:request progress:&progress
                 success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
                     NSLog(@"hello");
                     [self.webView loadHTMLString:HTML baseURL:[NSURL URLWithString:urlStr]];
                     return nil;
                 } failure:^(NSError * _Nonnull error) {
                     
                 }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if([request.mainDocumentURL.relativePath isEqualToString:@"/getInfo/name"])
    {
        NSString *info = [[UIDevice currentDevice] name];
        NSString *js = [NSString stringWithFormat:@"showInfo(\"name\",\"%@\")",info];
        [webView stringByEvaluatingJavaScriptFromString:js];
        return false;
    }
    if([request.mainDocumentURL.relativePath isEqualToString:@"/getInfo/systemVersion"])
    {
        NSString *info = [[UIDevice currentDevice] systemVersion];
        NSString *js = [NSString stringWithFormat:@"showInfo(\"systemVersion\",\"%@\")",info];
       [ webView stringByEvaluatingJavaScriptFromString:js];
        return false;
    }
    return true;
}



@end
