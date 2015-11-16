//
//  KCAnimationStepViewController.m
//  TEST11
//
//  Created by dongjl on 15/11/16.
//  Copyright © 2015年 djl. All rights reserved.

//，在动画制作中还有一种动画类型“逐帧动画”。说到逐帧动画相信很多朋友第一个想到的就是UIImageView，通过设置UIImageView的animationImages属性，然后调用它的startAnimating方法去播放这组图片。当然这种方法在某些场景下是可以达到逐帧的动画效果，但是它也存在着很大的性能问题，并且这种方法一旦设置完图片中间的过程就无法控制了。当然，也许有朋友会想到利用iOS的定时器NSTimer定时更新图片来达到逐帧动画的效果。这种方式确实可以解决UIImageView一次性加载大量图片的问题，而且让播放过程可控，唯一的缺点就是定时器方法调用有时可能会因为当前系统执行某种比较占用时间的任务造成动画连续性出现问题。
//OS程序在运行后就进入一个消息循环中（这个消息循环称为“主运行循环”），整个程序相当于进入一个死循环中，始终等待用户输入。将CADisplayLink加入到主运行循环队列后，它的时钟周期就和主运行循环保持一致，而主运行循环周期就是屏幕刷新周期。在CADisplayLink加入到主运行循环队列后就会循环调用目标方法，在这个方法中更新视图内容就可以完成逐帧动画。

//当然这里不得不强调的是逐帧动画性能势必较低，但是对于一些事物的运动又不得不选择使用逐帧动画，例如人的运动，这是一个高度复杂的运动，基本动画、关键帧动画是不可能解决的。所大家一定要注意在循环方法中尽可能的降低算法复杂度，同时保证循环过程中内存峰值尽可能低。下面以一个鱼的运动为例为大家演示一下逐帧动画。

#import "KCAnimationStepViewController.h"
#define IMAGE_COUNT 2
@interface KCAnimationStepViewController ()
{
    CALayer *_layer;
    int _index;
    NSMutableArray *_images;
}

@end

@implementation KCAnimationStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    self.view.layer.contents=(id)[UIImage imageNamed:@"bg.png"].CGImage;
    
    //创建图像显示图层
    _layer=[[CALayer alloc]init];
    _layer.bounds=CGRectMake(0, 0, 87, 32);
    _layer.position=CGPointMake(160, 284);
    [self.view.layer addSublayer:_layer];
    
    //由于鱼的图片在循环中会不断创建，而10张鱼的照片相对都很小
    //与其在循环中不断创建UIImage不如直接将10张图片缓存起来
    _images=[NSMutableArray array];
    for (int i=0; i<10; ++i) {
        NSString *imageName=[NSString stringWithFormat:@"fish%i.png",i];
        UIImage *image=[UIImage imageNamed:imageName];
        [_images addObject:image];
    }
    
    
    //定义时钟对象
    CADisplayLink *displayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    //添加时钟对象到主运行循环
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

#pragma mark 每次屏幕刷新就会执行一次此方法(每秒接近60次)
-(void)step{
    //定义一个变量记录执行次数
    static int s=0;
    //每秒执行6次
    if (++s%10==0) {
        UIImage *image=_images[_index];
        _layer.contents=(id)image.CGImage;//更新图片
        _index=(_index+1)%IMAGE_COUNT;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
