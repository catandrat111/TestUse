//
//  MultiThreadViewController.m
//  TEST11
//
//  Created by dongjl on 15/11/13.
//  Copyright © 2015年 djl. All rights reserved.
//http://www.cnblogs.com/kenshincui/p/3983982.html

#import "Thread_SingleViewController.h"
//在资源下载过程中，由于网络原因有时候很难保证下载时间，如果不使用多线程可能用户完成一个下载操作需要长时间的等待，这个过程中无法进行其他操作。下面演示一个采用多线程下载图片的过程，在这个示例中点击按钮会启动一个线程去下载图片，下载完成后使用UIImageView将图片显示到界面中。可以看到用户点击完下载按钮后，不管图片是否下载完成都可以继续操作界面，不会造成阻塞。
@interface Thread_SingleViewController (){
    UIImageView *_imageView;
}

@end

@implementation Thread_SingleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}

#pragma mark 界面布局
-(void)layoutUI{
    _imageView =[[UIImageView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    _imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark 将图片显示到界面
-(void)updateImage:(NSData *)imageData{
    UIImage *image=[UIImage imageWithData:imageData];
    _imageView.image=image;
}

#pragma mark 请求图片数据
-(NSData *)requestData{
    NSURL *url=[NSURL URLWithString:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_1.jpg"];
    NSData *data=[NSData dataWithContentsOfURL:url];
    return data;
}

#pragma mark 加载图片
-(void)loadImage{
    //请求数据
    NSData *data= [self requestData];
    /*将数据显示到UI控件,注意只能在主线程中更新UI,
     另外performSelectorOnMainThread方法是NSObject的分类方法，每个NSObject对象都有此方法，
     它调用的selector方法是当前调用控件的方法，例如使用UIImageView调用的时候selector就是UIImageView的方法
     Object：代表调用方法的参数,不过只能传递一个参数(如果有多个参数请使用对象进行封装)
     waitUntilDone:是否线程任务完成执行
     */
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:data waitUntilDone:YES];
}

#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread{
    //方法1：使用对象方法
    //创建一个线程，第一个参数是请求的操作，第二个参数是操作方法的参数
    //    NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(loadImage) object:nil];
    //    //启动一个线程，注意启动一个线程并非就一定立即执行，而是处于就绪状态，当系统调度时才真正执行
    //    [thread start];
    
    //方法2：使用类方法
    [NSThread detachNewThreadSelector:@selector(loadImage) toTarget:self withObject:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
