//
//  TableInstanceInitCell.m
//  TEST11
//
//  Created by 董金亮 on 15/7/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "TableInstanceInitCell.h"
#import "TableInstanceInitCellNoXib.h"
#import "TableInstanceInitCellXib.h"
static NSString* cellIdentifier = @"cell";
@interface TableInstanceInitCell ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray* dataSource;
}
@property(weak,nonatomic) IBOutlet UITableView* tableView;
@end

@implementation TableInstanceInitCell

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[self.title];
    
    switch (self.initType) {
        case UITableViewCellNoRegisterNoXib:
            
            break;
        case UITableViewCellNoRegisterXib:
            break;
        case UITableViewCellRegisterNoXib:
            //注册用法  不包含XIB
            [self.tableView registerClass:[TableInstanceInitCellNoXib class] forCellReuseIdentifier:cellIdentifier];
            break;
        case UITableViewCellRegisterXib:
            //注册用法 包含XIB
            [self.tableView registerNib:[UINib nibWithNibName:@"TableInstanceInitCellXib" bundle:nil] forCellReuseIdentifier:cellIdentifier];
            break;
    }
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
    switch (self.initType) {
        case UITableViewCellNoRegisterNoXib:{
            //非注册 用法 非XIB
             TableInstanceInitCellNoXib* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
             if(cell == nil){
                 cell = [[TableInstanceInitCellNoXib alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
             }
             cell.lab1.text = dataSource[indexPath.row];
             cell.lab1.textColor = [UIColor redColor];
             return cell;
             break;
        }
          case UITableViewCellNoRegisterXib:
            //非注册用法 XIB 用法
        {
             TableInstanceInitCellXib* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
             if(cell == nil){
                 NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"TableInstanceInitCellXib" owner:self options:nil];
                 cell = [array objectAtIndex:0];
             }
             
             cell.lab1.text = dataSource[indexPath.row];
             cell.lab1.textColor = [UIColor yellowColor];
              return cell;
            break;
        }
        case UITableViewCellRegisterNoXib:{
            //注册 用法 不包含XIB
            TableInstanceInitCellNoXib* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            cell.lab1.text = dataSource[indexPath.row];
            cell.lab1.textColor = [UIColor blueColor];
            return cell;
            break;
        }
            
        case UITableViewCellRegisterXib:{
             //注册 用法 包含XIB
            TableInstanceInitCellXib* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            cell.lab1.text = dataSource[indexPath.row];
            cell.lab1.textColor = [UIColor greenColor];
            return cell;
            break;
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark ---- uitableviewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}


@end
