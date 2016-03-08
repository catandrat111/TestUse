//
//  TableGroupViewController.m
//  TEST11
//
//  Created by dongjl on 15/12/29.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "TableGroupViewController.h"

@implementation TableGroupViewController {
    NSArray* dataSource;;
}

- (void)viewDidLoad {
    dataSource = @[@"register nib",@"register no xib"];
    self.tableView.separatorInset = UIEdgeInsetsMake(0.f, 100.f, 0.f, 0.f);
}
#pragma mark uitabkeview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString* cellIndentifier = @"cell";
    static NSString* cellIndentifier1 = @"cell1";
    if (indexPath.row == 0) {
      UITableViewCell*   cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
            
        }
        cell.textLabel.font = [UIFont systemFontOfSize:20];
      cell.textLabel.text = dataSource[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.f];
        cell.textLabel.textColor = UIColorFromRGB(0x0e6eb8);
        cell.detailTextLabel.textColor = [UIColor blackColor];
        cell.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0);
         return cell;
    }
    else {
     UITableViewCell*    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier1];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            cell.textLabel.font = [UIFont systemFontOfSize:14.f];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textLabel.text = dataSource[indexPath.row];
        return cell;

    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark ---- uitableviewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* view = nil;
    //if (section == 0) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        view.backgroundColor = [UIColor blueColor];
    //}
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 0.1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* view = [UIView new];;
    //if (section == 0) {
   
    //}
    
    return view;
}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleInsert) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });
//    }
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}


//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        return 0;
//    }else {
//        return 1;
//    }
//}

@end
