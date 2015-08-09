//
//  TableInstanceView.m
//  TEST11
//
//  Created by 董金亮 on 15/7/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "TableInstanceView.h"
#import "TableInstanceInitCell.h"
@interface TableInstanceView ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray* dataSource;
    NSDictionary* dict;
}

@end

@implementation TableInstanceView

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[@"register nib",@"register no xib",@"no register nib",@"no register no nib",@"tableviewstyle"];
    dict = @{@"register nib":@"TableInstanceInitCell",@"register no xib":@"TableInstanceInitCell",@"no register nib":@"TableInstanceInitCell",@"no register no nib":@"TableInstanceInitCell",@"tableviewstyle":@"TableInstanceStyle"};
 
    
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
    TableInstanceInitCell* controller = [[contrllerClass alloc] init];
    controller.title = classKey;
    if(indexPath.row == 0){
        controller.initType = UITableViewCellRegisterXib;
    }
    else if(indexPath.row == 1){
        controller.initType = UITableViewCellRegisterNoXib;
    }
    else if(indexPath.row == 2){
        controller.initType = UITableViewCellNoRegisterXib;
    }
    else if(indexPath.row == 3){
        controller.initType = UITableViewCellNoRegisterNoXib;
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}


@end
