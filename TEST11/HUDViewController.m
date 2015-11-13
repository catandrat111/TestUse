//
//  HUDViewController.m
//  TEST11
//
//  Created by dongjl on 15/11/12.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "HUDViewController.h"

@interface HUDViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray* dataSource;
    NSDictionary* dict;
}



@end

@implementation HUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1.0];
    self.tableView.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1.0];
    dataSource = @[@"MBProgressHUD",@"MBProgressHUDController"];
    dict = @{@"MBProgressHUD":@"MBProgressHUDController",@"SVProgressHUD":@"SVProgressHUDController"};
    

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
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
    [self.navigationController pushViewController:controller animated:YES];
}


@end
