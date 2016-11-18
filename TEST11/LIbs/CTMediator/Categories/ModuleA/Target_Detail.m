//
//  Target_Detail.m
//  CTMediator
//
//  Created by yehot on 16/5/28.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "Target_Detail.h"
#import "DetailViewController.h"

@implementation Target_Detail

/**
 *  在这个文件里，我们主要生成我们的 DetailViewController 和为我们生成的VC进行一些必要的赋值。
 */

- (UIViewController *)Action_NativeToDetailViewController:(NSDictionary *)params
{
    DetailViewController *viewController = [[DetailViewController alloc] init];
    
    // 这里完全可以使用 model。但会对model 耦合
    viewController.name = params[@"name"];
    return viewController;
}

@end
