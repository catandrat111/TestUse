//
//  ImageView.m
//  TEST11
//
//  Created by dongjl on 15/12/3.
//  Copyright © 2015年 djl. All rights reserved.
//http://www.keakon.net/2011/07/26/利用预渲染加速iOS设备的图像显示

#import "ImageView.h"
#include <mach/mach_time.h>
#import "UIImage+Color1.h"
#define LABEL_TAG 1

static const CGRect imageRect = {{0, 0}, {100, 100}};
//static const CGPoint imagePoint = {0, 0};
static const CGSize imageSize = {100, 100};
@implementation ImageView
@synthesize image;


- (void)awakeFromNib1 {
    if (!self.image) {
        self.image = [UIImage imageNamed:@"1"];
        Color2 color = [image GetImageColorAtPointX:314 PointY:65];
        NSLog(@"color.A = %d,color.R = %d,color.G =%d,color.B=%d",color.A,color.R,color.G,color.B);
        
    }
    
}

- (void)awakeFromNib {
    if (!self.image) {
        //self.image = [UIImage imageNamed:@"1"];
        UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
        [image drawInRect:imageRect];
        self.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        Color2 color = [image GetImageColorAtPointX:314 PointY:65];
        NSLog(@"color.A = %d,color.R = %d,color.G =%d,color.B=%d",color.A,color.R,color.G,color.B);

    }
}

- (void)drawRect:(CGRect)rect {
 
        uint64_t start = mach_absolute_time();
        [image drawInRect:imageRect];
        uint64_t drawTime = mach_absolute_time() - start;
        
        NSString *text = [[NSString alloc] initWithFormat:@"%lld", drawTime];// 纳秒级
        NSLog(@"%@",text);
        self.label.text = text;
        
    
}

- (void)dealloc {
   
}


@end
