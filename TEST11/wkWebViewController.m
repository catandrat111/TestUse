//
//  wkWebViewController.m
//  TEST11
//
//  Created by dongjl on 16/11/22.
//  Copyright © 2016年 djl. All rights reserved.
//

#import "wkWebViewController.h"
#import <WebKit/WebKit.h>
#import <libkern/OSAtomic.h>

@interface wkWebViewController ()<WKNavigationDelegate,NSURLSessionDelegate,NSURLConnectionDelegate>
{
    NSURLSession* _session;
    
}

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong)NSMutableURLRequest *request;

@property NSURLRequest *FailedRequest;

@property NSURLResponse *response;

@property NSURLConnection *connection;

@property NSMutableSet *whiteList;

@property NSMutableData *data;

@property OSSpinLock lock;


@end

@implementation wkWebViewController

- (instancetype)init {
    if (self = [super init]) {
        _whiteList = [[NSMutableSet alloc] initWithCapacity:0];
        
        _data = [[NSMutableData alloc] init];
        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.wkWebView.frame = self.view.bounds;
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"支付";
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero];
    //[self.webView loadHTMLString:self.htmlString baseURL:nil];
    self.wkWebView.navigationDelegate = self;
    [self.view addSubview:self.wkWebView];
    // [self loadData];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test2" ofType:@"html"];//银联
    path = [[NSBundle mainBundle] pathForResource:@"testhuifu" ofType:@"html"];//huipu 新webview在ios不行
    NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
  //  request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.16.10.237:8989/gateway/openPrize?businessType=0&memberid=959255754&foid=131025198911302418&foidType=0&name=qwr&mobile=18310325118"]];
    //request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.sichuanair.com/gateway/openpay?businessType=2&memberid=959300705&foid=430524199404263237&foidType=0&name=qw&mobile=15810509173"]];
    
   // request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.sichuanair.com/gateway/openPrize?encParams=51+7c8tNcs3oNwcYaSt3KMvTIfw770igEqhuu7XzSPXAR6h8mAlEEPWf/+iLXbgm8GypynJCUFY600GvgZaXTZhIA//187fskc3ExasTIoo3RNhg4qQ7K0QlMV9munc2"]];//网上兑奖
   // request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.sichuanair.com/gateway/openpay?encParams=51+7c8tNcs0NSPbIjzonnA80AUQVSqckiomCKVzdvWwHwqb3TpzWqoXu+/Ls9Qhw3xs4cWublwzlTAGg4u8kHHt/0PRg+gQ3xx+1NjPfXl8b4FvQjAWiGi0l73gAGR3N"]];//"添加银行卡"
  //request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.sichuanair.com/gateway/cardAdd?encParams=QMyEHJ+EXwl2Bn4tqmSY0x/ayFgZj+OlHwVbDchftWjGOzDi7dVj5U6zWEHklCWBU58X7EgWAXpUtdnck7PLLkwQeHJys3wCr2nOUpRRosmCyYkGPU0ryZd6o2agZpsMHvf/coLAfpN1Sn00alr7NJH8MyGvhpef7VrukjLlLt97IfVxWgNI3c4Ec1PiPJ5d657QqKpC6LYzvqk8UbQPAkde/KZy0DyC9Q4+odb3gGQ=&orderid=DZHA161130005643&price=1"]];//
    [self.wkWebView loadRequest:request1];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//有些https请求需要带参数user-agent的参数，则可以通过一下方法获取

#pragma URLSession Delegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    
    NSLog(@"willPerformHTTPRedirection:%@",request);
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
    didReceiveData:(NSData *)data {
    [_data appendData:data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    completionHandler(NSURLSessionResponseAllow);
    
    [self _lock];
    // pthread_mutex_lock(&pLock);
    [_whiteList addObject:[_FailedRequest URL]];
    
    [self _unlock];
    //pthread_mutex_unlock(&pLock);
    
    _FailedRequest = nil;
    
    _response = response;
    
    
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSString *str = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    
    [_wkWebView loadHTMLString:str baseURL:[_response URL]];
    
    [_data setLength:0];
    
    _response = nil;
    
}




- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        _whiteList = [[NSMutableSet alloc] initWithCapacity:0];
        
        _data = [[NSMutableData alloc] init];
        
    }
    
    return self;
    
}

/// 是否允许加载网页 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    
    urlString = [urlString stringByRemovingPercentEncoding];
    
    
    NSLog(@"this is web url : %@",[navigationAction.request URL]);
    NSString* scheme = [[navigationAction.request URL] scheme];
    
    if ([scheme isEqualToString:@"https"]) {
        
        //如果是https:的话，那么就用NSURLConnection来重发请求。从而在请求的过程当中吧要请求的URL做信任处理。
        
        [self _lock];
        // pthread_mutex_lock(&pLock);
        BOOL result = [_whiteList containsObject:[navigationAction.request URL]];
        //pthread_mutex_unlock(&pLock);
        [self _unlock];
        
        if (!result) {
            
            _FailedRequest = navigationAction.request;
            
            
            
            //_connection = [[NSURLConnection alloc] initWithRequest:navigationAction.request delegate:self];
            
            
//            NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
//            _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
//            NSURLSessionTask *task =  [_session dataTaskWithRequest:navigationAction.request];
//            [task resume];
//
//            
          //  [_wkWebView stopLoading];
            
        }
        
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
        
    }

       decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"didCommitNavigation");
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"didFinishNavigation");
    
}



- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%@",navigation);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
     NSLog(@"%@",error);
    if([error code] == NSURLErrorCancelled)  {
       // [self.wkWebView loadRequest:_FailedRequest];
        return;
    }
}

//IOS 8种不支持自签名证书回调  在iOS 9种解决
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
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

    completionHandler(disposition, credential);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType

{
    
    
    NSURL *requestURL =[request URL];
    
    NSLog(@"this is web url : %@",requestURL);
    
    if  ( [ [ requestURL scheme ] isEqualToString: @"http" ])
        
    {
        
        NSString *requestString = [requestURL absoluteString];
        
        if ([requestString hasSuffix:@"callback.html" ]) {
            
            
        }
        
    }
    
    NSString* scheme = [[request URL] scheme];
    
    if ([scheme isEqualToString:@"https"]) {
        
        //如果是https:的话，那么就用NSURLConnection来重发请求。从而在请求的过程当中吧要请求的URL做信任处理。
        
        [self _lock];
        // pthread_mutex_lock(&pLock);
        BOOL result = [_whiteList containsObject:[request URL]];
        //pthread_mutex_unlock(&pLock);
        [self _unlock];
        
        if (!result) {
            
            _FailedRequest = request;
            
            //_connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            
            
            NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
            config.TLSMinimumSupportedProtocol = kSSLProtocol3    ;
            _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
            NSURLSessionTask *task =  [_session dataTaskWithRequest:request];
            [task resume];
            
            
            [_wkWebView stopLoading];
            
        }
        
        return result;
        
    }
    
    return YES;
    
}

//要服务器端单项HTTPS 验证，iOS 客户端忽略证书验证。

- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        
    }
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    
    [self _lock];
    //pthread_mutex_lock(&pLock);
    [_whiteList addObject:[_FailedRequest URL]];
    
    [self _unlock];
    // pthread_mutex_unlock(&pLock);
    
    _FailedRequest = nil;
    
    _response = response;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [_data appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *str = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    
    [_wkWebView loadHTMLString:str baseURL:[_response URL]];
    
    
    [_data setLength:0];
    
    _response = nil;
    
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
    
}

//NSURLConnection的委托方法，

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
    
}

- (void)_lock {
    
    OSSpinLockLock(&_lock);
    
}

- (void)_unlock {
    
    OSSpinLockUnlock(&_lock);
    
}



@end
