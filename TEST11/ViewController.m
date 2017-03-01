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
#import "Masonry.h"
#if DEBUG
// FLEX should only be compiled and used in debug builds.
#import "FLEX.h"
#endif

static NSUInteger CalendarViewInterReturnCount = 0;
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UITableView* tableView_;
    NSArray* dataSource;
    NSDictionary* dict;
}
@property(nonatomic,strong) UIView* headerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CalendarViewInterReturnCount =  CalendarViewInterReturnCount +1;
    NSLog(@"%@",@(CalendarViewInterReturnCount));
    self.title = @"主页";
    self.view.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1.0];
    
    DDLogInfo(@"topLayoutGuide-%@ bottomLayoutGuide-%@",self.topLayoutGuide,self.bottomLayoutGuide);
   
#if DEBUG
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"FLEX" style:UIBarButtonItemStylePlain target:self action:@selector(flexButtonTapped:)];
#endif

    tableView_ = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, self.view.frameWidth - 20, self.view.frameHeight - 74)];
    [tableView_ setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView_.backgroundColor = [UIColor colorWithRed:242 green:242 blue:242 alpha:1.0];
//    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
    tableView_.delegate = self;
    tableView_.dataSource = self;
    tableView_.backgroundColor = [UIColor clearColor];
    dataSource = @[@"GTView",@"UILABEL",@"UIBUTTON",@"UITABLEVIEW",@"UISTATUSBAR",@"UINAVIGATIONBAR",@"UISLIDER",@"UITEXTFILED",@"AUTOSIZE",@"Gesture",@"UISEARCHBAR",@"Algorithm",@"RunLoop",@"UISegmentControl",@"Animation",@"Usage",@"AutoLayout",@"GCD",@"DESIGNATEINIT",@"GIF",@"HUDView",@"DrawView",@"MultiThread",@"TransitionAnimation",@"CollectionView",@"WebView",@"Imageview",@"alterview",@"SystemSetting",@"kvo",@"BackGround",@"scrollview",@"TestFrameWork",@"dispatchprotocol",@"APPGROUP",@"ddlogexception",@"HTTPStubs",@"shake"];
    dict = @{@"UITABLEVIEW":@"TableInstanceView",@"UILABEL":@"LabelInstance",@"UISLIDER":@"SliderInstance",@"UIBUTTON":@"ButtonInstance",@"UINAVIGATIONBAR":@"NavigationBarInstanceView",@"UITEXTFILED":@"TextFieldInstanceView",@"AUTOSIZE":@"AutoSizeViewInstance",@"Gesture":@"GestureViewController",@"UISEARCHBAR":@"SearchControllerInstanceView",@"DrawView":@"DrawViewInstance",@"Algorithm":@"AlgorithmClass",@"RunLoop":@"RunLoopInstance",@"UISegmentControl":@"SegmentControlInstanceView",@"Animation":@"AnimationInstanceView",@"Usage":@"UsageViewController",@"AutoLayout":@"AutoLayoutViewInstance",@"GCD":@"GCDViewInstance",@"DESIGNATEINIT":@"ZOCKintsugiPhotoViewController_iPad",@"GIF":@"GifViewController",@"HUDView":@"HUDViewController",@"MultiThread":@"MultiThreadViewInstance",@"TransitionAnimation":@"TWTExamplesListViewController",@"CollectionView":@"CollectionViewInstance",@"WebView":@"WebViewInstanceView",@"Imageview":@"ImageviewInstance",@"alterview":@"AlterViewController",@"GTView":@"GTViewController",@"SystemSetting":@"SystemSettingInstance",@"kvo":@"KVOInstance",@"BackGround":@"BackgroundModeInstanceView",@"scrollview":@"ScrollViewInstance",@"TestFrameWork":@"TestFrameWorkViewController",@"dispatchprotocol":@"DIspatchProtocolViewController",@"APPGROUP":@"AppExtensionViewController",@"ddlogexception":@"loggerTableViewController",@"HTTPStubs":@"HTTPStubsViewController",@"shake":@"ShakeViewController"};

    [self.view addSubview:tableView_];
    
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.cancelsTouchesInView = NO;//1种解决方案 //默认yes不接受touch事件 只响应UITapGestureRecognizer事件 为no 则传递touch事件响应didselect
    //[self.view addGestureRecognizer:tap];
    
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = [UIColor yellowColor];
    header.height = 80;
    header.frameWidth = tableView_.frameWidth;
    header.frameY = - header.height;
    [tableView_ addSubview:header];
    self.headerView = header;
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.text = @"下拉可以刷新";
    headerLabel.frameWidth = tableView_.frameWidth;
    headerLabel.frameHeight = header.frameHeight;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:headerLabel];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)flexButtonTapped:(id)sender
{
#if DEBUG
    [[FLEXManager sharedManager] showExplorer];
#endif
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"view disappear");
}


//2种解决方案
- (void)tap :(UITapGestureRecognizer*)gestureRecognizer{
    UIEvent *event = [[UIEvent alloc] init];
    CGPoint location = [gestureRecognizer locationInView:self.view];
    
    //check actually view you hit via hitTest
    UIView *view = [self.view hitTest:location withEvent:event];
    
    if ([view.gestureRecognizers containsObject:gestureRecognizer]) {
        //your UIView
        //do something
    }
    else {
        //your UITableView or some thing else...
        //ignore
        NSLog(@"TABLEVIEW EVENT");
    }
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
   // self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"Selected"];
   // self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"Selected"];
    //
   // return;
    NSString* classKey = dataSource[indexPath.row];
    NSString* className = dict[classKey];
//    if ([className isEqualToString:@"ZOCKintsugiPhotoViewController_iPad"]) {
//        ZOCKintsugiPhotoViewController_iPad * ipad = [[ZOCKintsugiPhotoViewController_iPad alloc] initWithPhotos:nil];
//        [self.navigationController pushViewController:ipad animated:YES];
//        return;
//    }
    Class contrllerClass = NSClassFromString(className);
    UIViewController* controller = [[contrllerClass alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 处理下拉刷新
    NSLog(@"%@",scrollView);
}


/**
 * 当用户手松开(停止拖拽),就会调用这个代理方法
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    
    // 增加顶部的内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = tableView_.contentInset;
        inset.top += self.headerView.height;
        tableView_.contentInset = inset;
    }];
    
}
@end
