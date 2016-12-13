//
//  AnimationInstanceView.m
//  TEST11
//
//  Created by dongjl on 15-9-6.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "AnimationInstanceView.h"

@interface AnimationInstanceView ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray* dataSource;
    NSDictionary* dict;
}


@end

@implementation AnimationInstanceView

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = @[@"BasicUsage",@"BascicAnimation",@"DR_popAnimation",@"AnimationGroup",@"KCAnimation1",@"KCAnimation2",@"KCAnimation3",@"KCAnimation4",@"KCAnimation5",@"KCAnimation6",@"KCAnimation7",@"KCAnimation8",@"KCAnimationBacicAnimation",@"KCAnimationBacicAnimation11",@"KCAnimationBacicAnimation12",@"KCAnimationBacicAnimation13",@"KCAnimationKeyPathAnimation11",@"KCAnimationKeyPathAnimation12",@"KCAnimationGroup11",@"KCAnimationSwitchView",@"KCAnimationSpring",@"maskAni",@"waveAni"];
    dict = @{@"BasicUsage":@"BasicUsageViewController",@"BascicAnimation":@"BasicAnimationController",@"DR_popAnimation":@"DR_popAnimationController",@"AnimationGroup":@"AnimationGroupController",@"KCAnimation1":@"KCAnimationViewController1",@"KCAnimation2":@"KCAnimationViewController2",@"KCAnimation3":@"KCAnimationViewController3",@"KCAnimation4":@"KCAnimationViewController4",@"KCAnimation5":@"KCAnimationViewController5",@"KCAnimation6":@"KCAnimationViewController6",@"KCAnimation7":@"KCAnimationViewController7",@"KCAnimation8":@"KCAnimationViewController8",@"KCAnimationBacicAnimation":@"KCAnimationBacicAnimationViewController1",@"KCAnimationBacicAnimation11":@"KCAnimationBacicAnimationViewController11",@"KCAnimationBacicAnimation12":@"KCAnimationBacicAnimationViewController12",@"KCAnimationBacicAnimation13":@"KCAnimationBacicAnimationViewController13",@"KCAnimationKeyPathAnimation11":@"KCAnimationKeyPathAnimationViewController11",@"KCAnimationKeyPathAnimation12":@"KCAnimationKeyPathAnimationViewController12",@"KCAnimationGroup11":@"KCAnimationGroupViewController11",@"KCAnimationSwitchView":@"KCAnimationSwitchViewController",@"KCAnimationSpring":@"KCAnimationSpringViewController",@"maskAni":@"KCAnimationViewController8",@"waveAni":@"WaveAnimationViewController"};
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
    UITableViewCell* cell = nil;
    static NSString* cellIndentifier = @"cell";
    cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];;
    }
    cell.textLabel.text = dataSource[indexPath.row];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark ---- uitableviewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* classKey = dataSource[indexPath.row];
    NSString* className = dict[classKey];
    Class contrllerClass = NSClassFromString(className);
    UIViewController* controller = [[contrllerClass alloc] init];
    controller.title = classKey;
    [self.navigationController pushViewController:controller animated:YES];
}


@end
