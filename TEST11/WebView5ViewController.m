//
//  WebView5ViewController.m
//  TEST11
//
//  Created by dongjl on 16/11/16.
//  Copyright © 2016年 djl. All rights reserved.
//http://www.jianshu.com/p/285a7ad73936  iOS https访问如何绕过无效证书权限访问

#import "WebView5ViewController.h"
#import <libkern/OSAtomic.h>

@interface WebView5ViewController () <UIWebViewDelegate,NSURLSessionDelegate>{
    BOOL _authenticated;
    NSURLSession* _session;

}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic) BOOL isSucceed;
@property (nonatomic, strong)NSMutableURLRequest *request;

@property NSURLRequest *FailedRequest;

@property NSURLResponse *response;

@property NSURLConnection *connection;

@property NSMutableSet *whiteList;

@property NSMutableData *data;

@property OSSpinLock lock;


@end

@implementation WebView5ViewController

- (instancetype)init {
    if (self = [super init]) {
        _whiteList = [[NSMutableSet alloc] initWithCapacity:0];
        
        _data = [[NSMutableData alloc] init];

    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.webView.frame = self.view.bounds;
    self.webView.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"支付";
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    //[self.webView loadHTMLString:self.htmlString baseURL:nil];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
   // [self loadData];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    
    [self.webView loadRequest:request1];

}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    didReceiveData:(NSData *)data {
     [_data appendData:data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    completionHandler(NSURLSessionResponseAllow);
    
    
    //_authenticated = YES;
   // [self.webView loadRequest:_request];
    [self _lock];
    
    [_whiteList addObject:[_FailedRequest URL]];
    
    [self _unlock];
    
    _FailedRequest = nil;
    
    _response = response;

    
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        _whiteList = [[NSMutableSet alloc] initWithCapacity:0];
        
        _data = [[NSMutableData alloc] init];
        
    }
    
    return self;
    
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
        
        BOOL result = [_whiteList containsObject:[request URL]];
        
        [self _unlock];
        
        if (!result) {
            
            _FailedRequest = request;
            
            _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            
            [_webView stopLoading];
            
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
    
    [_whiteList addObject:[_FailedRequest URL]];
    
    [self _unlock];
    
    _FailedRequest = nil;
    
    _response = response;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [_data appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *str = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    
    [_webView loadHTMLString:str baseURL:[_response URL]];
    
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
