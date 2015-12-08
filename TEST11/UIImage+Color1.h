//
//  UIImage+Color.h
//  TEST11
//
//  Created by dongjl on 15/12/3.
//  Copyright © 2015年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef struct {
    Byte A;
    Byte R;
    Byte G;
    Byte B;
}Color2;

@interface UIImage (Color1)
-(Byte*)getImageData;
-(Color2)GetImageColorAtPointX:(int)X
                       PointY:(int)Y;
+ (UIImage*)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end
