//
//  GestureViewController.m
//  TEST11
//
//  Created by dongjl on 15-8-14.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "GestureViewController.h"

@interface GestureViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) IBOutlet UITableView* tableView;
@property(nonatomic,strong) NSArray* dataSource;
@property(nonatomic,strong) NSDictionary* dataSourceDict;
@end

@implementation GestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"simpleDrag",@"PanGesture",@"hitTest"];
    self.dataSourceDict = @{@"simpleDrag" :@"SimpleDragInstance",@"PanGesture":@"PanGestureInstance",@"hitTest":@"HitTestViewController"};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* className = self.dataSourceDict[self.dataSource[indexPath.row]];
    Class cs = NSClassFromString(className);
    [self.navigationController pushViewController:[cs new] animated:YES];
}

@end
