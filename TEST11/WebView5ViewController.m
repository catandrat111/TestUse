//
//  WebView5ViewController.m
//  TEST11
//
//  Created by dongjl on 16/11/16.
//  Copyright © 2016年 djl. All rights reserved.
//http://www.jianshu.com/p/285a7ad73936  iOS https访问如何绕过无效证书权限访问

#import "WebView5ViewController.h"
#import <libkern/OSAtomic.h>
#import "UIWebView+AFNetworking.h"
#import "AFNetworking.h"
#import "NSString+Util.h"
#import <pthread.h>
static pthread_mutex_t pLock;


@interface WebView5ViewController () <UIWebViewDelegate,NSURLSessionDelegate>{
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

@property(nonatomic,strong)NSString *userAgent;
@end

@implementation WebView5ViewController

- (instancetype)init {
    if (self = [super init]) {
        _whiteList = [[NSMutableSet alloc] initWithCapacity:0];
        
        _data = [[NSMutableData alloc] init];
        pthread_mutex_init(&pLock, NULL);
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
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test4" ofType:@"html"];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    // request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://172.16.10.237:8989/gateway/openPrize?businessType=0&memberid=959255754&foid=131025198911302418&foidType=0&name=qwr&mobile=18310325118"]];
   //  request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.sichuanair.com/gateway/openpay?businessType=2&memberid=959300705&foid=430524199404263237&foidType=0&name=??&mobile=15810509173"]];
   // request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cocoachina.com"]];
    
 request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.sichuanair.com/gateway/openPrizehtml?encParams=51+7c8tNcs2SvlO6RDnKPQFenoKNpdgfLR2IBJdkUounQkW7c6Wc2zjdSm3HCC4/yXKAP0yeTaOvIhOHFxdUMYKQTeNQL/qGgCV7zqKSP8B6GXMUUshgkr4Pnd2kvTx44VNO+dC+DuA="]];//http://m.sichuanair.com/gateway/openPrize?encParams=51+7c8tNcs3oNwcYaSt3KMvTIfw770igwxGIyOa/Dij6apRSCQlapTMKakM6spmMndv2IU0aIHg29NW6RJaylV9CHMp0YqhjKrVijOJZNTfCex51H4spsw2QWcALQhl4
    [self.webView loadRequest:request1];
    
    //AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    //securityPolicy.allowInvalidCertificates = YES;
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO
    //主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
   // securityPolicy.validatesDomainName = NO;
    //validatesCertificateChain 是否验证整个证书链，默认为YES
    //设置为YES，会将服务器返回的Trust Object上的证书链与本地导入的证书进行对比，这就意味着，假如你的证书链是这样的：
    //GeoTrust Global CA
    //    Google Internet Authority G2
    //        *.google.com
    //那么，除了导入*.google.com之外，还需要导入证书链上所有的CA证书（GeoTrust Global CA, Google Internet Authority G2）；
    //如是自建证书的时候，可以设置为YES，增强安全性；假如是信任的CA所签发的证书，则建议关闭该验证；
    
   // self.webView.sessionManager.securityPolicy = securityPolicy;
    
    
    //[self createHttpRequest];

}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//有些https请求需要带参数user-agent的参数，则可以通过一下方法获取
- (void)createHttpRequest {
    
//    _web = [[UIWebView alloc] init];
//    
//    _web.delegate = self;
//    
//    [_web loadRequest:[NSURLRequest requestWithURL:
//                       
//                       [NSURL URLWithString:@"http://www.eoe.cn"]]];
    
    NSLog(@"%@", [self userAgentString]);
    
}

-(NSString *)userAgentString

{
    
    while (self.userAgent == nil)
        
    {
        
        NSLog(@"%@", @"in while");
        
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
    }
    
    return self.userAgent;
    
}

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
    
//    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
//    __block NSURLCredential *credential = nil;
//    
//    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
//        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
//        if (credential) {
//            disposition = NSURLSessionAuthChallengeUseCredential;
//        } else {
//            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
//        }
//    } else {
//        disposition = NSURLSessionAuthChallengePerformDefaultHandling;
//    }
//    
//    if (completionHandler) {
//        completionHandler(disposition, credential);
//    }
    
    if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCredential = [NSURLCredential  credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, newCredential);
    } else {
        // Inform the user that the user name and password are incorrect
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
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
    
    [_webView loadHTMLString:str baseURL:[_response URL]];
    
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



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType

{
    _userAgent = [request valueForHTTPHeaderField:@"User-Agent"];
    
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
            
                       
            
            _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            
            /*
            NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
           
            _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[[NSOperationQueue alloc]init]];
            NSURLSessionTask *task =  [_session dataTaskWithRequest:request];
            [task resume];
            
            
            [_webView stopLoading];
             */
            
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
    
   // [_webView loadHTMLString:str baseURL:[_response URL]];
    NSMutableData* mdata = [_data mutableCopy];
    [_webView loadData:mdata MIMEType:_response.MIMEType textEncodingName:_response.textEncodingName baseURL:[_response URL]];

    
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

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@",error);
}

- (void)_lock {
    
    OSSpinLockLock(&_lock);
    
}

- (void)_unlock {
    
    OSSpinLockUnlock(&_lock);
    
}


@end
