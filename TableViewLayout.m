//
//  TableViewLayout.m
//  TEST11
//
//  Created by dongjl on 15-9-14.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "TableViewLayout.h"
#import "TableViewLayoutCell.h"
#import "TableViewLayoutCell1.h"
#import "LayoutModel.h"
#import "UITableView+FDTemplateLayoutCell.h"
@interface TableViewLayout ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *dataSource;
}
@property(weak,nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TableViewLayout

- (void)viewDidLoad {
    [super viewDidLoad];
    LayoutModel *model = [LayoutModel new];
    model.name1 = @"fdfggffgghghhjhjjhjkjkjkjkjkkjkjkjjkkjfdfggffgghghhjhjjhjkjkjkjkjkkjkjkjjkkj";
    model.name2 = @"dfgfcbvmjhliozxdfdfggpowrewtfreygdfgfcbvmjhliozxdfdfggpowrewtfdfgfcbvmjhliozxdfdfggpowrewtfreygdfgfcbvmjhliozxdfdfggpowrewtfdfgfcbvmjhliozxdfdfggpowrewtfreygdfgfcbvmjhliozxdfdfggpowrewtfdfgfcbvmjhliozxdfdfggpowrewtfreygdfgfcbvmjhliozxdfdfggpowrewtfdfgfcbvmjhliozxdfdfggpowrewtfreygdfgfcbvmjhliozxdfdfggpowrewtfdfgfcbvmjhliozxdfdfggpowrewtfreygdfgfcbvmjhliozxdfdfggpowrewtfdfgfcbvmjhliozxdfdfggpowrewtfreygdfgfcbvmjhliozxdfdfggpowrewtfdfgfcbvmjhliozxdfdfggpowrewtfreygdfgfcbvmjhliozxdfdfggpowrewtfaaaaaa";
    LayoutModel *model1 = [LayoutModel new];
    model1.name1 = @"dgvfdbgfhc bnbvthytjuyiebvnbnbv";
    model1.name2 = @"dfgfcbvmjhliozxdfdfggpowrewtfreygdfgfcbvmjhliozxdfdfggpowrewtfreygdfgfcbvmjhliozxdfdfggpowrewtfreygdfgfcbvmjhliozxdfdfggpowrewtfreygdfgfcbvmjhliozxdfdfggpowrewtfreygdfgfcbvmjhggfglzxmmmmm";
    
    dataSource = @[model,model1];
    //[self.tableView registerNib:[UINib nibWithNibName:@"TableViewLayoutCell" bundle:nil] forCellReuseIdentifier:@"layoutcell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewLayoutCell1" bundle:nil] forCellReuseIdentifier:@"layoutcell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark uitabkeview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewLayoutCell1* cell = nil;
    static NSString* cellIndentifier = @"layoutcell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
     [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(TableViewLayoutCell1 *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    if (indexPath.row % 2 == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.model = dataSource[indexPath.row];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"layoutcell" cacheByIndexPath:indexPath configuration:^(TableViewLayoutCell1 *cell) {
       [self configureCell:cell atIndexPath:indexPath];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark ---- uitableviewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}


@end
