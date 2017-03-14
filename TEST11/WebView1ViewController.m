//
//  WebView1ViewController.m
//  TEST11
//
//  Created by dongjl on 15/11/27.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "WebView1ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface WebView1ViewController ()<UIWebViewDelegate>

@end

@implementation WebView1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TEST1111" ofType:@"html"];
   // NSURLRequest *request1 = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
     NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ffp.sichuanair.com/html5appweb"]];
    self.webview.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    self.webview.dataDetectorTypes = UIDataDetectorTypePhoneNumber;//自动检测网页上的电话号码，单击可以拨打

    [self.webview loadRequest:request2];
    
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    // NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //[webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    //webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;//自动检测网页上的电话号码，单击可以拨打

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"%@",[request URL]);
    if([request.mainDocumentURL.relativePath isEqualToString:@"/getInfo/name"])
    {
        NSString *info = [[UIDevice currentDevice] name];
        NSString *js = [NSString stringWithFormat:@"showInfo(\"name\",\"%@\")",info];
        [self.webview stringByEvaluatingJavaScriptFromString:js];
        return false;
    }
    if([request.mainDocumentURL.relativePath isEqualToString:@"/getInfo/systemVersion"])
    {
        NSString *info = [[UIDevice currentDevice] systemVersion];
        NSString *js = [NSString stringWithFormat:@"showInfo(\"systemVersion\",\"%@\")",info];
        [self.webview stringByEvaluatingJavaScriptFromString:js];
        return false;
    }
    return true;
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //开始加载网页调用此方法
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //网页加载完成调用此方法
   
    
    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
   // JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
   // NSString *alertJS=@"alert('test js OC')"; //准备执行的js代码
   // [context evaluateScript:alertJS];//通过oc方法调用js的alert

}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //网页加载失败 调用此方法
}



@end
