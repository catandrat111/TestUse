//
//  DrawViewInstance.m
//  TEST11
//
//  Created by 董金亮 on 15/8/14.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "DrawViewInstance.h"
#import "DrawViewController.h"
#import "KCMainViewController.h"
@interface DrawViewInstance ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) IBOutlet UITableView* tableView;
@property(nonatomic,strong) NSArray* dataSource;
@property(nonatomic,strong) NSDictionary* dataSourceDict;


@end

@implementation DrawViewInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"circle",@"drawLine1",@"drawLine2",@"drawRectWithContext",@"drawArc",@"drawRectByUIKitWithContext",@"drawEllipse",@"drawRectWithLinearGradientFill",@"drawCurve",@"drawText",@"drawImage",@"drawImage1",@"drawImage2",@"drawImage3",@"drawBackgroundWithColoredPattern",@"drawBackgroundWithPattern",@"drawRectByUIKitWithContext2",@"drawLinearGradient",@"drawRadialGradient",@"drawUpdateStr",@"drawBerzer",@"drawBitImage",@"drawContentToPdfContext",@"drawCIFilter",@"drawBezierPathLine1",@"drawBezierPathLine2",@"drawBezierPathLine3",@"drawBezierPathLine4",@"drawBezierPathLine5",@"drawProgress"];
    self.dataSourceDict = @{@"circle" :@"CircleViewController",@"drawLine1":@"DrawViewController",@"drawLine2":@"DrawViewController",@"drawRectWithContext":@"DrawViewController",@"drawArc":@"DrawViewController",@"drawRectByUIKitWithContext":@"DrawViewController",@"drawEllipse":@"DrawViewController",@"drawRectWithLinearGradientFill":@"DrawViewController",@"drawCurve":@"DrawViewController",@"drawText":@"DrawViewController",@"drawImage":@"DrawViewController",@"drawImage1":@"DrawViewController",@"drawImage2":@"DrawViewController",@"drawImage3":@"DrawViewController",@"drawBackgroundWithColoredPattern":@"DrawViewController",@"drawBackgroundWithPattern":@"DrawViewController",@"drawRectByUIKitWithContext2":@"DrawViewController",@"drawLinearGradient":@"DrawViewController",@"drawRadialGradient":@"DrawViewController",@"drawBerzer":@"DrawViewController",@"drawUpdateStr":@"KCMainViewController",@"drawBitImage":@"KCMainViewController",@"drawContentToPdfContext":@"KCMainViewController",@"drawCIFilter":@"KCMainViewController",@"drawBezierPathLine1":@"KCMainViewController",@"drawBezierPathLine2":@"KCMainViewController",@"drawBezierPathLine3":@"KCMainViewController",@"drawBezierPathLine4":@"KCMainViewController",@"drawBezierPathLine5":@"KCMainViewController",@"drawProgress":@"KCMainViewController"};
    
    // 创建path
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 添加路径[1条点(100,100)到点(200,100)的线段]到path
    [path moveToPoint:CGPointMake(100 , 100)];
    [path addLineToPoint:CGPointMake(200, 100)];
    // 将path绘制出来
    [path stroke];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* className = self.dataSourceDict[self.dataSource[indexPath.row]];
    Class cs = NSClassFromString(className);

    UIViewController* controller = [cs new];
    DrawViewController* controller1;
    KCMainViewController* controller2;
    if ([controller isKindOfClass:[DrawViewController class]]) {
        controller1 = (DrawViewController*)controller;
        controller1.type  = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:controller1 animated:YES];
        return;
    }
    
    if ([controller isKindOfClass:[KCMainViewController class]]) {
        controller2 = (KCMainViewController*)controller;
        controller2.type  = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:controller2 animated:YES];
        return;
    }
    
    
    
    [self.navigationController pushViewController:controller animated:YES];
}

@end
