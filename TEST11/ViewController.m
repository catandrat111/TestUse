//
//  ViewController.m
//  TEST11
//
//  Created by 董金亮 on 15-3-16.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "ViewController.h"
#import "ZOCKintsugiPhotoViewController_iPad.h"
#import "UITableView+iOS7Style.h"
#import "GifViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* tableView_;
    NSArray* dataSource;
    NSDictionary* dict;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    self.view.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1.0];


    tableView_ = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, self.view.frameWidth - 20, self.view.frameHeight - 74)];
    [tableView_ setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView_.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1.0];
//    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
    tableView_.delegate = self;
    tableView_.dataSource = self;
    tableView_.backgroundColor = [UIColor clearColor];
    dataSource = @[@"UILABEL",@"UIBUTTON",@"UITABLEVIEW",@"UISTATUSBAR",@"UINAVIGATIONBAR",@"UISLIDER",@"UITEXTFILED",@"AUTOSIZE",@"Gesture",@"UISEARCHBAR",@"Algorithm",@"RunLoop",@"UISegmentControl",@"Animation",@"Usage",@"AutoLayout",@"GCD",@"DESIGNATEINIT",@"GIF",@"HUDView",@"DrawView",@"MultiThread",@"TransitionAnimation",@"CollectionView",@"WebView",@"Imageview",@"alterview",@"GTView"];
    dict = @{@"UITABLEVIEW":@"TableInstanceView",@"UILABEL":@"LabelInstance",@"UISLIDER":@"SliderInstance",@"UIBUTTON":@"ButtonInstance",@"UINAVIGATIONBAR":@"NavigationBarInstanceView",@"UITEXTFILED":@"TextFieldInstanceView",@"AUTOSIZE":@"AutoSizeViewInstance",@"Gesture":@"GestureViewController",@"UISEARCHBAR":@"SearchBarInstanceView",@"DrawView":@"DrawViewInstance",@"Algorithm":@"AlgorithmClass",@"RunLoop":@"RunLoopInstance",@"UISegmentControl":@"SegmentControlInstanceView",@"Animation":@"AnimationInstanceView",@"Usage":@"UsageViewController",@"AutoLayout":@"AutoLayoutViewInstance",@"GCD":@"GCDViewInstance",@"DESIGNATEINIT":@"ZOCKintsugiPhotoViewController_iPad",@"GIF":@"GifViewController",@"HUDView":@"HUDViewController",@"MultiThread":@"MultiThreadViewInstance",@"TransitionAnimation":@"TWTExamplesListViewController",@"CollectionView":@"CollectionViewInstance",@"WebView":@"WebViewInstanceView",@"Imageview":@"ImageviewInstance",@"alterview":@"AlterViewController",@"GTView":@"GTViewController"};

    [self.view addSubview:tableView_];
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
       // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;


        cell.frame = CGRectMake(0, 0, tableView_.frameWidth, 80);
    }
    [tableView_ applyiOS7SettingsStyleGrouping:cell forRowAtIndexPath:indexPath];//需要UITableViewCellStyleValue1
    cell.textLabel.text = dataSource[indexPath.row];
    cell.textLabel.textColor = [UIColor redColor];//可以更改
    cell.textLabel.frame = CGRectMake(100,0, 100, 30);//更改不了距离
    

    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark ---- uitableviewdelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //更改返回按钮图片 同是设置
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"Selected"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"Selected"];
    //
    
    NSString* classKey = dataSource[indexPath.row];
    NSString* className = dict[classKey];
    if ([className isEqualToString:@"ZOCKintsugiPhotoViewController_iPad"]) {
        ZOCKintsugiPhotoViewController_iPad * ipad = [[ZOCKintsugiPhotoViewController_iPad alloc] initWithPhotos:nil];
        [self.navigationController pushViewController:ipad animated:YES];
        return;
    }
    Class contrllerClass = NSClassFromString(className);
    UIViewController* controller = [[contrllerClass alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}
@end
