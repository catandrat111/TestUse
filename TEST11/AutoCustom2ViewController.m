//
//  AutoCustom2ViewController.m
//  TEST11
//
//  Created by dongjl on 15/10/22.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "AutoCustom2ViewController.h"
#import "UIView+FDCollapsibleConstraints.h"
#import "Masonry.h"

@interface AutoCustom2ViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray* dataSource;
    int status;

}



@end

@implementation AutoCustom2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[@"1",@"2",@"1",@"2"];
    CGRect rect = [[UIScreen mainScreen] bounds];
    NSLog(@"%@",rect);

    
    //[self test2];
    //[self test1];
    
}

- (void)viewWillLayoutSubviews {
    self.scroll.contentSize = CGSizeMake(2*self.scroll.frameWidth, self.scroll.frameHeight);
}

- (void)viewDidLayoutSubviews {
    
}
//heederview和footerview默认autosize 左上角和右上角固定 也是是说他的view宽度和高度固定不变，要想体现一个view随内部控件的是否呈现来显现变化，可以在加一个高度为1像素的view，背景透明，实现view的高度变化
- (void)test1 {
        self.tableView.tableFooterView = self.footerView;
    
        self.fromContactButton.fd_collapsed = YES;
        self.fromContactButton.hidden = YES;
    //self.confirmButton.hidden = YES;
        //[self.view layoutSubviews];

}

- (void)test2 {
    self.tableView.tableFooterView = self.footerView1;

    self.showTicketButton.fd_collapsed = YES;
    self.showTicketButton.hidden = YES;
   // self.showTicketView.hidden  =YES;
    [self.view layoutSubviews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)p1:(id)sender {
    
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
