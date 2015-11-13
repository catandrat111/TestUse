//
//  Thread_MultiViewController.m
//  TEST11
//
//  Created by dongjl on 15/11/13.
//  Copyright © 2015年 djl. All rights reserved.
//
//演示多个子线程操作之间的关系，现在不妨在界面中多加载几张图片，每个图片都来自远程请求。
#import "Thread_MultiViewController.h"
#import "KCImageData.h"
#define ROW_COUNT 5
#define COLUMN_COUNT 3
#define ROW_HEIGHT 100
#define ROW_WIDTH ROW_HEIGHT
#define CELL_SPACING 10
@interface Thread_MultiViewController (){
    NSMutableArray *_imageViews;
}

@end

@implementation Thread_MultiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}

#pragma mark 界面布局
-(void)layoutUI{
    //创建多个图片控件用于显示图片
    _imageViews=[NSMutableArray array];
    for (int r=0; r<ROW_COUNT; r++) {
        for (int c=0; c<COLUMN_COUNT; c++) {
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING                           ), ROW_WIDTH, ROW_HEIGHT)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            //            imageView.backgroundColor=[UIColor redColor];
            [self.view addSubview:imageView];
            [_imageViews addObject:imageView];
            
        }
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame=CGRectMake(50, 500, 220, 25);
    [button setTitle:@"加载图片" forState:UIControlStateNormal];
    //添加方法
    [button addTarget:self action:@selector(loadImageWithMultiThread) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark 将图片显示到界面
-(void)updateImage:(KCImageData *)imageData{
    UIImage *image=[UIImage imageWithData:imageData.data];
    UIImageView *imageView= _imageViews[imageData.index];
    imageView.image=image;
}

#pragma mark 请求图片数据
-(NSData *)requestData:(NSInteger )index{
    NSURL *url=[NSURL URLWithString:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_1.jpg"];
    NSData *data=[NSData dataWithContentsOfURL:url];
    return data;
}

//在线程操作过程中可以让某个线程休眠等待，优先执行其他线程操作，而且在这个过程中还可以修改某个线程的状态或者终止某个指定线程。为了解决上面优先加载最后一张图片的问题，不妨让其他线程先休眠一会等待最后一个线程执行。修改图片加载方法如下即可：
//-(NSData *)requestData1:(int )index{
//    //对非最后一张图片加载线程休眠2秒
//    if (index!=(ROW_COUNT*COLUMN_COUNT-1)) {
//        [NSThread sleepForTimeInterval:2.0];
//    }
//    NSURL *url=[NSURL URLWithString:_imageNames[index]];
//    NSData *data=[NSData dataWithContentsOfURL:url];
//    
//    return data;
//}

#pragma mark 加载图片
-(void)loadImage:(NSNumber *)index{
    //    NSLog(@"%i",i);
    //currentThread方法可以取得当前操作线程
    NSLog(@"current thread:%@",[NSThread currentThread]);
    
    NSInteger i =[index integerValue];
    
    //    NSLog(@"%i",i);//未必按顺序输出
    
    NSData *data= [self requestData:i];
    
    KCImageData *imageData=[[KCImageData alloc]init];
    imageData.index=i;
    imageData.data=data;
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:imageData waitUntilDone:YES];
}

#pragma mark 多线程下载图片
-(void)loadImageWithMultiThread{
    //创建多个线程用于填充图片
    for (int i=0; i<ROW_COUNT*COLUMN_COUNT; ++i) {
        //        [NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:self withObject:[NSNumber numberWithInt:i]];
        NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(loadImage:) object:[NSNumber numberWithInt:i]];
        thread.name=[NSString stringWithFormat:@"myThread%i",i];//设置线程名称
        [thread start];
    }
}

//可以改变线程的优先级，让15个线程优先执行某个线程。线程优先级范围为0~1，值越大优先级越高，每个线程的优先级默认为0.5。修改图片下载方法如下，改变最后一张图片加载的优先级，这样可以提高它被优先加载的几率，但是它也未必就第一个加载。因为首先其他线程是先启动的
-(void)loadImageWithMultiThread1{
    NSMutableArray *threads=[NSMutableArray array];
    int count=ROW_COUNT*COLUMN_COUNT;
    //创建多个线程用于填充图片
    for (int i=0; i<count; ++i) {
        //        [NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:self withObject:[NSNumber numberWithInt:i]];
        NSThread *thread=[[NSThread alloc]initWithTarget:self selector:@selector(loadImage:) object:[NSNumber numberWithInt:i]];
        thread.name=[NSString stringWithFormat:@"myThread%i",i];//设置线程名称
        if(i==(count-1)){
            thread.threadPriority=1.0;
        }else{
            thread.threadPriority=0.0;
        }
        [threads addObject:thread];
    }
    
    for (int i=0; i<count; i++) {
        NSThread *thread=threads[i];
        [thread start];
    }
}
@end
