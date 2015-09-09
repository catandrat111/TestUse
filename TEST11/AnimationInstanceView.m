//
//  AnimationInstanceView.m
//  TEST11
//
//  Created by dongjl on 15-9-6.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "AnimationInstanceView.h"

@interface AnimationInstanceView ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray* dataSource;
    NSDictionary* dict;
}


@end

@implementation AnimationInstanceView

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[@"BasicUsage",@"BascicAnimation",@"DR_popAnimation",@"AnimationGroup"];
    dict = @{@"BasicUsage":@"BasicUsageViewController",@"BascicAnimation":@"BasicAnimationController",@"DR_popAnimation":@"DR_popAnimationController",@"AnimationGroup":@"AnimationGroupController"};
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
    UIViewController* controller = [[contrllerClass alloc] init];
    controller.title = classKey;
    [self.navigationController pushViewController:controller animated:YES];
}


@end
