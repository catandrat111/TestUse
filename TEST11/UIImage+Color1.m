//
//  UIImage+Color.m
//  TEST11
//
//  Created by dongjl on 15/12/3.
//  Copyright © 2015年 djl. All rights reserved.


//data : 指向要渲染的绘制内存的地址。这个内存块的大小至少是（bytesPerRow*height）个字节，在ios4.0或者OSX10.6以后可以直接用NULL表示自动分配内存块大小。
//width : bitmap的宽度,单位为像素
//height : bitmap的高度,单位为像素
//bitsPerComponent : 内存中像素的每个组件的位数.例如，对于32位像素格式和RGB 颜色空间，你应该将这个值设为8.
//bytesPerRow: bitmap的每一行在内存所占的比特数
//colorspace : bitmap上下文使用的颜色空间。
//bitmapInfo : 指定bitmap是否包含alpha通道，像素中alpha通道的相对位置，像素组件是整形还是浮点型等信息的字符串。
//typedef CF_ENUM(uint32_t, CGImageAlphaInfo) {
//    kCGImageAlphaNone,               /* For example, RGB. */
//    kCGImageAlphaPremultipliedLast,  /* For example, premultiplied RGBA */
//    kCGImageAlphaPremultipliedFirst, /* For example, premultiplied ARGB */
//    kCGImageAlphaLast,               /* For example, non-premultiplied RGBA */
//    kCGImageAlphaFirst,              /* For example, non-premultiplied ARGB */
//    kCGImageAlphaNoneSkipLast,       /* For example, RBGX. */
//    kCGImageAlphaNoneSkipFirst,      /* For example, XRGB. */
//    kCGImageAlphaOnly                /* No color data, alpha data only */
//};
#import "UIImage+Color1.h"
#import <stdlib.h>
@implementation UIImage (Color1)
-(Byte*)getImageData
{
    CGImageRef imageRef= [self CGImage];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    int bytesPerPixel = 4;
    size_t bytesPerRow=bytesPerPixel*width;
    int bitsPerComponent = 8;
    
    void* imageData ;//准备用来存储数据的数组
    //创建上下文,kCGImageAlphaPremultipliedLast表示像素点的排序是ARGB
    CGContextRef cgContexRef = CGBitmapContextCreate(NULL,
                                                     width,
                                                     height,
                                                     bitsPerComponent,
                                                     bytesPerRow,
                                                     colorSpace,
                                                     kCGImageAlphaPremultipliedFirst);
    
    CGRect theRect = CGRectMake(0,0, width, height);
    //将图片的数据写入上下文
    CGContextDrawImage(cgContexRef, theRect, imageRef);
    
    //Byte* tempData=(Byte*)CGBitmapContextGetData(cgContexRef);
    CGColorSpaceRelease(colorSpace);
    
    imageData = malloc(4*(width-1)+4*(height-1)*width+3);
    memcpy(imageData, (Byte*)CGBitmapContextGetData(cgContexRef), 4*(width-1)+4*(height-1)*width+3);
    //把data做一个深度拷贝，因为原来的数据在cgContexRef里边，要释放，要不会杯具
    CGContextRelease(cgContexRef);
    
    
    return (Byte*)imageData;
}
-(Color2)GetImageColorAtPointX:(int)X
                       PointY:(int)Y{
    Byte *imageData = [self getImageData];
    //每个像素由四个分量组成所以要乘以4,Y坐标表示有多少列，像素点在数据中的保存方式是从（0，0）开始依次排序，直到图像的（width，height）处的像素点。
    int index =4*X+4*Y*self.size.width;
    
    Color2 c;
    c.A=imageData [index];
    c.R=imageData[index+1];
    c.G=imageData[index+2];
    c.B=imageData[index+3];
    free(imageData);
    return c;
}

//CGContextRef MyCreateBitmapContext (int pixelsWide, int pixelsHigh)
// {
//         CGContextRef    context = NULL;
//         CGColorSpaceRef colorSpace;
//         void *          bitmapData;
//         int             bitmapByteCount;
//         int             bitmapBytesPerRow;
//         bitmapBytesPerRow   = (pixelsWide * 4);
//         bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
//         colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
//         bitmapData =  calloc( bitmapByteCount );
//         if (bitmapData == NULL)
//             {
//                     fprintf (stderr, "Memory not allocated!");
//                     return NULL;
//                 }
//         context = CGBitmapContextCreate (bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
//         if (context== NULL)
//             {
//                     free (bitmapData);
//                     fprintf (stderr, "Context not created!");
//                     return NULL;
//                 }
//         CGColorSpaceRelease( colorSpace );
//         return context;
//}

+ (UIImage*)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
