//
//  WebView2ViewController.m
//  TEST11
//
//  Created by dongjl on 15/11/27.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "WebView2ViewController.h"
#import "MyWebView.h"
@interface WebView2ViewController ()

@end

@implementation WebView2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyWebView* webview = [[MyWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webview];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"html1" ofType:@"html"];
     NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [webview loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
    //webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;//自动检测网页上的电话号码，单击可以拨打

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
