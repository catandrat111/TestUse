//
//  DIspatchProtocolViewController.m
//  TEST11
//
//  Created by dongjl on 16/10/19.
//  Copyright © 2016年 djl. All rights reserved.
//

#import "DIspatchProtocolViewController.h"
#import "DelegateSource.h"
#import "ProtocolDispatcher.h"

@interface DIspatchProtocolViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DelegateSource *delegateSource;


@end

@implementation DIspatchProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    
    self.delegateSource = [DelegateSource new];
    
    self.tableView.delegate = AOProtocolDispatcher(UITableViewDelegate, self, self.delegateSource);
    self.tableView.dataSource = self.delegateSource;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"%@", NSStringFromCGPoint(scrollView.contentOffset));
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"vc");
}


@end
