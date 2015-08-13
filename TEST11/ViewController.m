//
//  ViewController.m
//  TEST11
//
//  Created by 董金亮 on 15-3-16.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* tableView_;
    NSArray* dataSource;
    NSDictionary* dict;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    tableView_ = [[UITableView alloc] initWithFrame:self.view.frame];
//    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
    tableView_.delegate = self;
    tableView_.dataSource = self;
    dataSource = @[@"UILABEL",@"UIBUTTON",@"UITABLEVIEW",@"UISTATUSBAR",@"UINSEARCHBAR",@"UINAVIGATIONBAR",@"UISLIDER",@"UITEXTFILED",@"AUTOSIZE"];
    dict = @{@"UITABLEVIEW":@"TableInstanceView",@"UILABEL":@"LabelInstance",@"UISLIDER":@"SliderInstance",@"UIBUTTON":@"ButtonInstance",@"UINAVIGATIONBAR":@"NavigationBarInstanceView",@"UITEXTFILED":@"TextFieldInstanceView",@"AUTOSIZE":@"AutoSizeViewInstance"};
    [self.view addSubview:tableView_];
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
    cell.textLabel.textColor = [UIColor redColor];//可以更改
    cell.textLabel.frame = CGRectMake(100,0, 100, 30);//更改不了距离
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark ---- uitableviewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //更改返回按钮图片 同是设置
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"Selected"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"Selected"];
    //
    
    NSString* classKey = dataSource[indexPath.row];
    NSString* className = dict[classKey];
    Class contrllerClass = NSClassFromString(className);
    UIViewController* controller = [[contrllerClass alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
