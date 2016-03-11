//
//  ScrollViewInstance.m
//  TEST11
//
//  Created by dongjl on 16/3/9.
//  Copyright © 2016年 djl. All rights reserved.
//

#import "ScrollViewInstance.h"

@implementation ScrollViewInstance 
{
    NSArray* dataSource;
     NSDictionary* dict;
}

- (void)viewDidLoad {
    dataSource = @[@"scroll"];
    dict = @{@"scroll":@"ScrollViewScrollViewController"};

}
#pragma mark uitabkeview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* cellIndentifier = @"cell";
    UITableViewCell*    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            cell.textLabel.font = [UIFont systemFontOfSize:14.f];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textLabel.text = dataSource[indexPath.row];
        return cell;
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}

#pragma mark ---- uitableviewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* classKey = dataSource[indexPath.row];
    NSString* className = dict[classKey];
    Class contrllerClass = NSClassFromString(className);
    UIViewController* controller = [[contrllerClass alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView* view = nil;
//    //if (section == 0) {
//    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
//    view.backgroundColor = [UIColor blueColor];
//    //}
//    
//    return view;
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return 40;
//    }
//    return 40;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 1;
//    }
//    return 0.1;
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView* view = [UIView new];;
//    //if (section == 0) {
//    
//    //}
//    
//    return view;
//}
//
//
////- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
////{
////    if (editingStyle == UITableViewCellEditingStyleInsert) {
////        dispatch_async(dispatch_get_main_queue(), ^{
////
////        });
////    }
////
////}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 50.0f;
//}
//
//
////- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
////    if (indexPath.row == 0) {
////        return 0;
////    }else {
////        return 1;
////    }
////}
//

@end
