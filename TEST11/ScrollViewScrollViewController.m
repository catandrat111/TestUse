//
//  ScrollViewScrollViewController.m
//  TEST11
//
//  Created by dongjl on 16/3/9.
//  Copyright © 2016年 djl. All rights reserved.
//http://www.2cto.com/kf/201412/364522.html

#import "ScrollViewScrollViewController.h"

@interface ScrollViewScrollViewController ()<UIScrollViewDelegate>

@end

@implementation ScrollViewScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageControl.numberOfPages = 3;
    self.pageControl.currentPage = 0;
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    //[self singleScroll];
    [self twoScroll1];
}
//单项循环

- (void)singleScroll {
    
    UIView* v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    v1.backgroundColor = [UIColor redColor];
    
    UIView* v2 = [[UIView alloc] initWithFrame:CGRectMake(1* [UIScreen mainScreen].bounds.size.width,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    v2.backgroundColor = [UIColor greenColor];
    
    UIView* v3 = [[UIView alloc] initWithFrame:CGRectMake(2*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    v3.backgroundColor = [UIColor blueColor];
    
    [self.scrollView addSubview:v1];
    [self.scrollView addSubview:v2];
    [self.scrollView addSubview:v3];
    
    
    
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(3*[UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height);

}

- (void)twoScroll1 {
    UIView* v1 = [[UIView alloc] initWithFrame:CGRectMake(1* [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    v1.backgroundColor = [UIColor redColor];
    
    UIView* v2 = [[UIView alloc] initWithFrame:CGRectMake(2* [UIScreen mainScreen].bounds.size.width,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    v2.backgroundColor = [UIColor greenColor];
    
    UIView* v3 = [[UIView alloc] initWithFrame:CGRectMake(3*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    v3.backgroundColor = [UIColor blueColor];
    
    [self.scrollView addSubview:v1];
    [self.scrollView addSubview:v2];
    [self.scrollView addSubview:v3];
    
    
    UIView* v4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    v4.backgroundColor = [UIColor blueColor];
    [self.scrollView addSubview:v4];
    
    UIView* v5 = [[UIView alloc] initWithFrame:CGRectMake(4*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    v5.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:v5];
    
    
    
    
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(5*[UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height);
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width, 0)];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changePage:(id)sender {
    CGRect rect = self.scrollView.frame;
    //设置视图的横坐标，一幅图为320*460，横坐标一次增加或减少320像素
    rect.origin.x = self.pageControl.currentPage * self.scrollView.frame.size.width;
    //设置视图纵坐标为0
    rect.origin.y = 0;
    //scrollView可视区域
    [self.scrollView scrollRectToVisible:rect animated:YES];
}


#pragma mark --- Scroll Delegate
//单项循环
//-(void)scrollViewDidScroll:(UIScrollView *)sender {
////    
//    CGFloat pageWidth = sender.frame.size.width;
//    // 根据当前的x坐标和页宽度计算出当前页数
//    int currentPage = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    self.pageControl.currentPage=currentPage;
//}

//twoscroll1
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage=page-1;
    // 如果当前页是第0页就跳转到数组中最后一个地方进行跳转
    if (page == 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * (3), 0)];
        self.pageControl.currentPage=3;
    }else if (page == 3 + 1){
        // 如果是第最后一页就跳转到数组第一个元素的地点
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0)];
        self.pageControl.currentPage=0;

    }
}

@end
