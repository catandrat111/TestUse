//
//  BackgroundModeViewController.m
//  TEST11
//
//  Created by dongjl on 16/2/18.
//  Copyright © 2016年 djl. All rights reserved.
//http://blog.csdn.net/dongtaochen2039/article/details/41577011

#import "BackgroundModeViewController.h"
#import "TBFirstViewController.h"
#import "TBSecondViewController.h"
#import "TBThirdViewController.h"
#import "TBFourthViewController.h"
#import "TBFifthViewController.h"

@interface BackgroundModeViewController ()
@property (strong, nonatomic) UITabBarController *tabBarController;

@end

@implementation BackgroundModeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIViewController *viewController1 = [[TBFirstViewController alloc] initWithNibName:@"TBFirstViewController" bundle:nil];
//    UIViewController *viewController2 = [[TBSecondViewController alloc] initWithNibName:@"TBSecondViewController" bundle:nil];
//    UIViewController *viewController3 = [[TBThirdViewController alloc] initWithNibName:@"TBThirdViewController" bundle:nil];
//    UIViewController *viewController4 = [[TBFourthViewController alloc] initWithNibName:@"TBFourthViewController" bundle:nil];
//    UIViewController *viewController5 = [[TBFifthViewController alloc] initWithNibName:@"TBFifthViewController" bundle:nil];
//    
//    self.tabBarController = [[UITabBarController alloc] init];
//
//    self.tabBarController.viewControllers = @[viewController1, viewController2, viewController3, viewController4, viewController5];
//   有问题 采用自定义继承没有问题
//    [self.navigationController pushViewController:self.tabBarController animated:YES];
   
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nil bundle:nil])
    {
           UIViewController *viewController1 = [[TBFirstViewController alloc] initWithNibName:@"TBFirstViewController" bundle:nil];
            UIViewController *viewController2 = [[TBSecondViewController alloc] initWithNibName:@"TBSecondViewController" bundle:nil];
            UIViewController *viewController3 = [[TBThirdViewController alloc] initWithNibName:@"TBThirdViewController" bundle:nil];
            UIViewController *viewController4 = [[TBFourthViewController alloc] initWithNibName:@"TBFourthViewController" bundle:nil];
            UIViewController *viewController5 = [[TBFifthViewController alloc] initWithNibName:@"TBFifthViewController" bundle:nil];        // 组装TabBar
        self.viewControllers = @[viewController1, viewController2, viewController3, viewController4, viewController5];
        
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
