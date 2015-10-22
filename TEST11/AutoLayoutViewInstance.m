//
//  AutoLayoutViewInstance.m
//  TEST11
//
//  Created by dongjl on 15-8-13.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "AutoLayoutViewInstance.h"

@interface AutoLayoutViewInstance ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray* dataSource;
    NSDictionary* dict;
}


@end

@implementation AutoLayoutViewInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[@"Collapsible View Demo",@"Collapsible Cell Demo",@"Custom",@"Masonry+FDTemp",@"Custom1",@"Custom2"];
    dict = @{@"Collapsible View Demo":@"AutoLayoutFDViewController",@"Collapsible Cell Demo":@"FDTableViewController",@"Custom":@"AutoLayoutCustomController",@"Masonry+FDTemp":@"YFAutoLayoutCellViewController",@"Custom1":@"AutoCustom1ViewController",@"Custom2":@"AutoCustom2ViewController"};
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
