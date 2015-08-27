//
//  TableInstanceStyle.m
//  TEST11
//
//  Created by 董金亮 on 15/7/12.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "TableInstanceStyle.h"
#import "UIImage+Color.h"
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
    //self.tableView.allowsMultipleSelection = YES;
    
    // 设置毛玻璃 //记得要把cell 设置成透明效果 适用于8。0后
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    self.tableView.separatorEffect = vibrancyEffect;
    self.tableView.separatorColor = UIColorFromRGB(0xff0000);
   self.tableView.backgroundColor=[UIColor clearColor];
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor blueColor]]];

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
    cell.backgroundColor = [UIColor clearColor];
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

//将要出现删除按钮时的回调，调整subview的位置
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
//    UIButton* b = (UIButton*)[cell viewWithTag:1];
//    [UIView beginAnimations:@"" context:nil];
//    [UIView animateWithDuration:0.5 animations:^{
//        b.frame = CGRectMake(b.frame.origin.x-15, b.frame.origin.y, b.frame.size.width, b.frame.size.height);
//        
//    }];
//    [UIView commitAnimations];
}

//删除按钮消失后的回调，用于重新调整subview到原来位置
-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
//    UIButton* b = (UIButton*)[cell viewWithTag:1];
//    [UIView beginAnimations:@"" context:nil];
//    [UIView animateWithDuration:0.5 animations:^{
//        b.frame = CGRectMake(b.frame.origin.x+15, b.frame.origin.y, b.frame.size.width, b.frame.size.height);
//        
//    }];
//    [UIView commitAnimations];
}


//回调设置长按cell时会否弹出菜单栏
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0){
    
    return YES;
}

//回调设置哪些菜单选项能显示给用户使用
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender NS_AVAILABLE_IOS(5_0){
    /*
     
     – copy:
     – cut:
     – delete:
     – paste:
     
     Handling Selection Commands
     
     – select:
     – selectAll:
     
     Handling Styled Text Editing
     
     – toggleBoldface:
     – toggleItalics:
     – toggleUnderline:
     
     Handling Writing Direction Changes
     
     – makeTextWritingDirectionLeftToRight:
     – makeTextWritingDirectionRightToLeft:
     */
    return YES;
}

//回调当点击了菜单栏选项后的事件，根据不同SEL进行动作的实现
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender NS_AVAILABLE_IOS(5_0){
    
    if(action==@selector(copy:)){
        //[UIPasteboard generalPasteboard].string = [_value objectAtIndex:indexPath.row];
    }
    
    
}

//适用于8.0后 编辑模式 删除按钮前加上收藏和置顶
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        [dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }];
    
    //设置收藏按钮
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏"handler:^(UITableViewRowAction *action,NSIndexPath *indexPath) {
        
        
        collectRowAction.backgroundColor = [UIColor greenColor];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"收藏" message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
        
    }];
    //设置置顶按钮
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        
        [dataArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
        
    }];
    
    collectRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    topRowAction.backgroundColor = [UIColor blueColor];
    collectRowAction.backgroundColor = [UIColor grayColor];
    
    return  @[deleteRowAction,collectRowAction,topRowAction];
}
@end
