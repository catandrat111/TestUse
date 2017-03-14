//
//  JSViewController.m
//  TEST11
//
//  Created by dongjl on 17/3/14.
//  Copyright © 2017年 djl. All rights reserved.
//

#import "JSViewController.h"
#import "ExampleUIWebViewController.h"
#import "ExampleWKWebViewController.h"

@interface JSViewController ()

@end

@implementation JSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ExampleUIWebViewController* UIWebViewExampleController = [[ExampleUIWebViewController alloc] init];
    UIWebViewExampleController.tabBarItem.title             = @"UIWebView";
    
    // 2. Create the tab footer and add the UIWebView example
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController addChildViewController:UIWebViewExampleController];
    
    // 3. Create the  WKWebView example for devices >= iOS 8
    if([WKWebView class]) {
        ExampleWKWebViewController* WKWebViewExampleController = [[ExampleWKWebViewController alloc] init];
        WKWebViewExampleController.tabBarItem.title             = @"WKWebView";
        [tabBarController addChildViewController:WKWebViewExampleController];
    }
    [self addChildViewController:tabBarController];
    [self.view addSubview:tabBarController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
