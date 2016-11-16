//
//  WebViewInstanceView.m
//  TEST11
//
//  Created by dongjl on 15/11/27.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "WebViewInstanceView.h"

@interface WebViewInstanceView ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray* dataSource;
    NSDictionary* dict;
    
}


@end

@implementation WebViewInstanceView

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[@"webview1",@"webview2",@"webview3",@"webview4",@"webview5"];
    dict = @{@"webview1":@"WebView1ViewController",@"webview2":@"WebView2ViewController",@"webview3":@"WebView3ViewController",@"webview4":@"WebView4ViewController",@"webview5":@"WebView5ViewController"};

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark uitabkeview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = nil;
    static NSString* cellIndentifier = @"cell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];;
    }
    cell.textLabel.text = dataSource[indexPath.row];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark ---- uitableviewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* classKey = dataSource[indexPath.row];
    NSString* className = dict[classKey];
    Class contrllerClass = NSClassFromString(className);
    UIViewController *controller = [[contrllerClass alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
