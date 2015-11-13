//
//  MultiThreadViewInstance.m
//  TEST11
//
//  Created by dongjl on 15/11/13.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "MultiThreadViewInstance.h"

@interface MultiThreadViewInstance ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) IBOutlet UITableView* tableView;
@property(nonatomic,strong) NSArray* dataSource;
@property(nonatomic,strong) NSDictionary* dataSourceDict;

@end

@implementation MultiThreadViewInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"Thread_Single",@"Thread_Multi",@"Thread_Multi_1",@"InvocationOperation",@"BlockOperation",@"GCD_Sync",@"GCD_Async",@"LockView",@"ConditionView"];
    self.dataSourceDict = @{@"Thread_Single" :@"Thread_SingleViewController",@"Thread_Multi":@"Thread_MultiViewController",@"Thread_Multi_1":@"Thread_Multi_1ViewController",@"InvocationOperation":@"InvocationOperationViewController",@"BlockOperation":@"BlockOperationViewController",@"GCD_Sync":@"GCD_SyncViewController",@"GCD_Async":@"GCD_AsyncViewController",@"LockView":@"LockViewController",@"ConditionView":@"ConditionViewController"};
    
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
    
   UIViewController* controller = [cs new];
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
