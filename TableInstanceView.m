//
//  TableInstanceView.m
//  TEST11
//
//  Created by 董金亮 on 15/7/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "TableInstanceView.h"
#import "TableInstanceInitCell.h"
#import "UITableView+iOS7Style.h"
#import "TableGroupViewController.h"
@interface TableInstanceView ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray* dataSource;
    NSDictionary* dict;
    UIRefreshControl* refreshControl1;
}

@end

@implementation TableInstanceView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1.0];
    self.tableView.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1.0];
    dataSource = @[@"register nib",@"register no xib",@"no register nib",@"no register no nib",@"tableviewstyle",@"tableviewlayout",@"lazytable",@"TableGroupViewController",@"TestCorner"];
    dict = @{@"register nib":@"TableInstanceInitCell",@"register no xib":@"TableInstanceInitCell",@"no register nib":@"TableInstanceInitCell",@"no register no nib":@"TableInstanceInitCell",@"tableviewstyle":@"TableInstanceStyle",@"tableviewlayout":@"TableViewLayout",@"lazytable":@"LazyTableViewController",@"TableGroupViewController":@"TableGroupViewController",@"TestCorner":@"TestCornerViewController"};
 
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl ];
  
    refreshControl1 = refreshControl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)refresh {
    [refreshControl1 endRefreshing];
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
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.detailTextLabel setTextColor:[UIColor blackColor]];

        cell.frame = CGRectMake(0, 0, self.tableView.frameWidth, 44);
    }
    [self.tableView applyiOS7SettingsStyleGrouping:cell forRowAtIndexPath:indexPath];
    //cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
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
    
    if ([className isEqualToString:@"TableGroupViewController"]) {
       TableGroupViewController* controller1 = [[TableGroupViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:controller1 animated:YES];
        return;
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });
//    }
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}


@end
