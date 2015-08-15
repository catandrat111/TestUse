//
//  DrawViewInstance.m
//  TEST11
//
//  Created by 董金亮 on 15/8/14.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "DrawViewInstance.h"

@interface DrawViewInstance ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) IBOutlet UITableView* tableView;
@property(nonatomic,strong) NSArray* dataSource;
@property(nonatomic,strong) NSDictionary* dataSourceDict;


@end

@implementation DrawViewInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"circle"];
    self.dataSourceDict = @{@"circle" :@"CircleViewController"};

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
