//
//  CollectionViewInstance.m
//  TEST11
//
//  Created by dongjl on 15/11/24.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "CollectionViewInstance.h"
#import "LineLayout.h"
#import "CircleLayout.h"
#import "CLCircleViewController.h"
#import "CLLineViewController.h"
@interface CollectionViewInstance ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray* dataSource;
    NSDictionary* dict;

}

@property (nonatomic,strong) UITableView* tableView;
@end

@implementation CollectionViewInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1.0];
   
    dataSource = @[@"basicinstance",@"CLCircle",@"CLLine"];
    dict = @{@"basicinstance":@"CollectionViewBscic",@"CLCircle":@"CLCircleViewController",@"CLLine":@"CLLineViewController"};
    
    [self setupTableView];

}


- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.separatorColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1.0];
    [self.view addSubview:self.tableView];
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
    
    if ([classKey isEqualToString:@"CLCircle"]) {
        CircleLayout* layout = [[CircleLayout alloc] init];
        
        controller = [[CLCircleViewController alloc] initWithCollectionViewLayout:layout];
    }
    if ([classKey isEqualToString:@"CLLine"]) {
        LineLayout* layout = [[LineLayout alloc] init];
        
        controller = [[CLLineViewController alloc] initWithCollectionViewLayout:layout];
    }
    
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

@end
