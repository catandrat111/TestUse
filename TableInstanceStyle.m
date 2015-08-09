//
//  TableInstanceStyle.m
//  TEST11
//
//  Created by 董金亮 on 15/7/12.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "TableInstanceStyle.h"
#import "UITableView+iOS7Style.h"
@interface TableInstanceStyle ()<UITableViewDataSource,UITableViewDelegate>{
 NSDictionary* dataSource;
    NSMutableArray* dataArray;
    NSMutableArray* selectedArray;
}
@end

@implementation TableInstanceStyle

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @{@"section0":@[@"a"], @"section1":@[@"a",@"b"],@"section2":@[@"a",@"b",@"c"]};
   // dataArray = @[@"section0",@"section1",@"section2"];
    
//    dataSource = @{@"section0":@[@"a"]};
//    dataArray = @[@"section0"];
    
    dataArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 10; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [dataArray addObject:str];
    }

    UIView* v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    UIButton* b1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    [b1 setTitle:@"edit" forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(tableViewEdit:) forControlEvents:UIControlEventTouchUpInside];
    [b1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    UIButton* b2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 80, 44)];
    [b2 setTitle:@"multiedit" forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(tableViewMultiEdit:) forControlEvents:UIControlEventTouchUpInside];
    [b2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [v1 addSubview:b1];
    [v1 addSubview:b2];
   
//    UIBarButtonItem* item2 =  [[UIBarButtonItem alloc] initWithTitle:@"multiedit" style:UIBarButtonItemStyleDone target:self action:@selector(tableViewEdit:)];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    selectedArray = [NSMutableArray new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:v1];
    // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStyleDone target:self action:@selector(tableViewEdit:)];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.allowsMultipleSelection = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableViewEdit:(id)sender{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}

- (void)tableViewMultiEdit:(id)sender{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
}


#pragma mark uitabkeview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSArray* arr = dataSource[ dataArray[section]];
//    return arr.count;
    
    return  dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = nil;
    NSString* cellIndentifier = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    //static NSString* cellIndentifier = str;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        if(indexPath.row == 0){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
       else if(indexPath.row == 1){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
        }
       else if(indexPath.row == 2){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIndentifier];
        }
       else if(indexPath.row == 3){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifier];
        }
        else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }

    }
    
    
//    NSString* str1 = dataArray[indexPath.section];
//    NSArray* arr = dataSource[str1];
//    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.text = dataArray[indexPath.row];
    cell.detailTextLabel.text = dataArray[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:@"Selected"];
    //[self.tableView applyiOS7SettingsStyleGrouping:cell forRowAtIndexPath:indexPath];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  //  return dataArray.count;
    return 1;
}

#pragma mark ---- uitableviewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [selectedArray addObject:indexPath];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//哪几行可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 4) {
        return NO;
    }
    return YES;
}

//哪几行可以移动(可移动的行数小于等于可编辑的行数)
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 2) {
        return NO;
    }
    return YES;
}

//移动cell时的操作
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    
    if (sourceIndexPath != destinationIndexPath) {
        
        id object = [dataArray objectAtIndex:sourceIndexPath.row];
        
        [dataArray removeObjectAtIndex:sourceIndexPath.row];
        if (destinationIndexPath.row > [dataArray count]) {
            [dataArray addObject:object];
        }
        else {
            [dataArray insertObject:object atIndex:destinationIndexPath.row];
        }
        
    }
}

//继承该方法时,左右滑动会出现删除按钮(自定义按钮),点击按钮时的操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [dataArray removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        
        return @"测试捏";
    }
    return @"删除";
}


//移动 cell,防止移动 cell到不支持移动的列表下面
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    if (proposedDestinationIndexPath.row > 3) {
        return sourceIndexPath;
    }
    return proposedDestinationIndexPath;
}



@end
