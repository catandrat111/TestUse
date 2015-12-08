//
//  ImageviewInstance.m
//  TEST11
//
//  Created by dongjl on 15/12/2.
//  Copyright © 2015年 djl. All rights reserved.
//CGContextRef CGBitmapContextCreate (

//void *data,
//size_t width,
//size_t height,
//size_t bitsPerComponent,
//size_t bytesPerRow,
//CGColorSpaceRef colorspace,
//CGBitmapInfo bitmapInfo
//);

//data                                    指向要渲染的绘制内存的地址。这个内存块的大小至少是（bytesPerRow*height）个字节
//
//width                                  bitmap的宽度,单位为像素
//height                                bitmap的高度,单位为像素
//
//bitsPerComponent        内存中像素的每个组件的位数.例如，对于32位像素格式和RGB 颜色空间，你应该将这个值设为8.
//
//bytesPerRow                  bitmap的每一行在内存所占的比特数
//
//colorspace                      bitmap上下文使用的颜色空间。
//
//bitmapInfo                       指定bitmap是否包含alpha通道，像素中alpha通道的相对位置，像素组件是整形还是浮点型等信息的字符串。



#import "ImageviewInstance.h"
#import "ImageView.h"
@interface ImageviewInstance ()

@end

@implementation ImageviewInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    ImageView* imageView  = [[NSBundle mainBundle] loadNibNamed:@"ImageView" owner:self options:nil][0];
    [self.view addSubview:imageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
