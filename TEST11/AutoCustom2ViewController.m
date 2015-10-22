//
//  AutoCustom2ViewController.m
//  TEST11
//
//  Created by dongjl on 15/10/22.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "AutoCustom2ViewController.h"
#import "UIView+FDCollapsibleConstraints.h"
@interface AutoCustom2ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray* dataSource;
    int status;

}



@end

@implementation AutoCustom2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[@"1",@"2"];
    self.tableView.tableFooterView = self.footerView;
    self.fromContactButton.fd_collapsed = YES;
    self.fromContactButton.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
       

        self.fromContactButton.fd_collapsed = YES;
        self.fromContactButton.hidden = YES;
        [self.tableView reloadData];
    }
    
    if (indexPath.row == 1) {
        self.tongxunButton.fd_collapsed = YES;
        self.tongxunButton.hidden = YES;
        [self.tableView reloadData];
    }
    
}
@end
