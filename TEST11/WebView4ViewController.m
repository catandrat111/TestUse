//
//  WebView4ViewController.m
//  TEST11
//
//  Created by dongjl on 16/9/29.
//  Copyright © 2016年 djl. All rights reserved.
//
//用urlconnection 或urlsession 实现https
#import "WebView4ViewController.h"

@interface WebView4ViewController ()<UIWebViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,NSURLSessionDelegate>

{
    NSURLConnection *_urlConnection;
    BOOL _authenticated;
    NSURLRequest *_request;
    NSURLSession* _session;
}

@property (strong,nonatomic) NSString *urlStr; //url请求
@property (strong,nonatomic) NSString *lastUrl;//最后一次的url请求
@property (strong,nonatomic) UIWebView *showView;
@property(nonatomic,strong)NSMutableData *dataM;

@end

@implementation WebView4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testHttps];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)testHttps {
    
    // 某个页面 https://test.hd.paipian.leying.com:445/
    
    self.urlStr = @"https://mapi.alipay.com/gateway.do?sign=7abb084d4493890e144fdb3ac90a1285&body=%E5%9B%9B%E5%B7%9D%E8%88%AA%E7%A9%BA%E5%A4%A7%E5%AE%A2%E6%88%B7%E4%B8%93%E5%8C%BA%E6%9C%BA%E7%A5%A8&_input_charset=UTF-8&exter_invoke_ip=172.16.5.109&it_b_pay=30m&subject=%E5%9B%9B%E5%B7%9D%E8%88%AA%E7%A9%BA%E5%A4%A7%E5%AE%A2%E6%88%B7%E4%B8%93%E5%8C%BA%E6%9C%BA%E7%A5%A8&total_fee=0.01&sign_type=MD5&service=create_direct_pay_by_user&notify_url=http%3A%2F%2F114.242.187.254%3A4135%2Fpay-center%2Fnotify%2FALPC%2F2&qr_pay_mode=2&partner=2088101054133484&seller_id=2088101054133484&out_trade_no=JSWFALPC201609271802389NR1&payment_type=1&return_url=http%3A%2F%2Fm.scal.com.cn%2Fheavybuyer_port_service%2FpaySuccessForIOS.jsp";
    
    NSURL *url = [[NSURL alloc] initWithString:self.urlStr];
    _request = [NSURLRequest requestWithURL:url];
 
    self.showView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.showView.delegate = self;
    
    self.showView.scrollView.bounces = NO;//webview滑动的弹簧效果
    //    self.showView.scrollView.scrollEnabled = YES;
    [self.showView loadRequest:_request];
    self.showView.backgroundColor = [UIColor colorWithRed:90/255.0 green:196/255.0 blue:211/255.0 alpha:1.0];
    
    
    [self.view addSubview:self.showView];
}


#pragma mark == webViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"加载数据中。。。。");
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成！！！！");
    
    self.lastUrl = [NSString stringWithFormat:@"%@",webView.request.URL.absoluteString];
    NSLog(@"测试当前页面的 url ------- %@",webView.request.URL.absoluteString);
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载失败");
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType

{
    NSLog(@"the URL is : %@ auth:%d", [[request URL]absoluteString],_authenticated);
    
    if (!_authenticated) {
        
        _authenticated = NO;
        
        
        _urlConnection = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
        [_urlConnection start];
        
        
//        NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
//        NSURLSessionTask *task =  [_session dataTaskWithRequest:_request];
//        [task resume];
        
        return NO;
    }
    
    
    
    return YES;
    
}



#pragma mark === connectDelegate

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    //    NSLog(@"验证签名证书");
    //
    if ([challenge previousFailureCount] == 0)
    {
        _authenticated = YES;
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        
    } else
    {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"WebController received response via NSURLConnection");
    
    // remake a webview call now that authentication has passed ok.
    
    _authenticated = YES;
    [self.showView loadRequest:_request];
    
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}



- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    
    NSLog(@"willPerformHTTPRedirection");
    completionHandler(request);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    }
    
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    completionHandler(NSURLSessionResponseAllow);
    
    
    _authenticated = YES;
    [self.showView loadRequest:_request];
    
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
    
    
}






@end
