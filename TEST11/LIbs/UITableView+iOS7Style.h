//
//  UITableView+iOS7Style.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/6/1.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (iOS7Style)
//有边框
-(void)applyiOS7SettingsStyleGrouping:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

//无边框
-(void)applyiOS7SettingsStyleGroupingWithoutBorder:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

//修改分割线
-(void)modifySeparatorInset:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
@end
