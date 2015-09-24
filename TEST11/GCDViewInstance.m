//
//  GCDViewInstance.m
//  TEST11
//
//  Created by dongjl on 15/9/24.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "GCDViewInstance.h"

@interface GCDViewInstance ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray* dataSource;
    NSDictionary* dict;
}


@end

@implementation GCDViewInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[@"Basic",@"Apply"];
    dict = @{@"Basic":@"GCDBasicViewController",@"Apply":@"GCDApplyViewController"};
    

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
    cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
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
