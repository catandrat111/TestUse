//
//  UIView+Corner.m
//  TEST11
//
//  Created by dongjl on 16/3/7.
//  Copyright © 2016年 djl. All rights reserved.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)


double roundbyunit(double num, double unit) {
    double remain = modf(num, &unit);
    if (remain > unit / 2.0) {
        return ceilbyunit(num, &unit);
    } else {
        return floorbyunit(num, &unit);
    }
}

//private func roundbyunit(num: Double, inout _ unit: Double) -> Double {
//    let remain = modf(num, &unit)
//    if (remain > unit / 2.0) {
//        return ceilbyunit(num, &unit)
//    } else {
//        return floorbyunit(num, &unit)
//    }
//}

double ceilbyunit(double num ,double* unit) {
    return num - modf(num, unit) + *unit;
}
//private func ceilbyunit(num: Double, inout _ unit: Double) -> Double {
//    return num - modf(num, &unit) + unit
//}

double floorbyunit(double num, double* unit) {
    return num - modf(num, unit);
}

//private func floorbyunit(num: Double, inout _ unit: Double) -> Double {
//    return num - modf(num, &unit)
//}


double pixel(double num) {
    double unit;
    switch ((int)[UIScreen mainScreen].scale) {
        case 1: unit = 1.0 / 1.0;
        case 2: unit = 1.0 / 2.0;
        case 3: unit = 1.0 / 3.0;
        default: unit = 0.0;

    }
    return roundbyunit(num, unit);
}

//private func pixel(num: Double) -> Double {
//    var unit: Double
//    switch Int(UIScreen.mainScreen().scale) {
//    case 1: unit = 1.0 / 1.0
//    case 2: unit = 1.0 / 2.0
//    case 3: unit = 1.0 / 3.0
//    default: unit = 0.0
//    }
//    return roundbyunit(num, &unit)
//}


- (void)kt_addCorner:(CGFloat)radius {
    [self kt_addCorner:radius borderWidth:1 backgroundColor:[UIColor clearColor] borderColor:[UIColor blackColor]];
}

- (void)kt_addCorner:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor*)backgroundColor borderColor:(UIColor*)borderColor {
    UIImage* image = [self kt_drawRectWithRoundedCorner:radius borderWidth:borderWidth backgroundColor:backgroundColor borderColor:borderColor];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    [self insertSubview:imageView atIndex:0];
}

- (UIImage*)kt_drawRectWithRoundedCorner:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor*)backgroundColor borderColor:(UIColor*)borderColor {
    
    //let sizeToFit = CGSize(width: pixel(Double(self.bounds.size.width)), height: Double(self.bounds.size.height))
    CGSize sizeToFit = CGSizeMake(pixel(self.bounds.size.width), (double)self.bounds.size.height);
    
    CGFloat halfBorderWidth = borderWidth / 2.0;
    
    UIGraphicsBeginImageContextWithOptions(sizeToFit, false, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    
    CGFloat width = sizeToFit.width;
    CGFloat height = sizeToFit.height;
    CGContextMoveToPoint(context, width - halfBorderWidth, radius + halfBorderWidth);  // 开始坐标右边开始
    CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius);  // 右下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius); // 左下角角度
    CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius); // 左上角
    CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius); // 右上角
    
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
  
    UIImage* output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;

}

//extension UIView {
//    func kt_addCorner(radius radius: CGFloat) {
//        self.kt_addCorner(radius: radius, borderWidth: 1, backgroundColor: UIColor.clearColor(), borderColor: UIColor.blackColor())
//    }
//    
//    func kt_addCorner(radius radius: CGFloat,
//                      borderWidth: CGFloat,
//                      backgroundColor: UIColor,
//                      borderColor: UIColor) {
//        let imageView = UIImageView(image: kt_drawRectWithRoundedCorner(radius: radius,
//                                                                        borderWidth: borderWidth,
//                                                                        backgroundColor: backgroundColor,
//                                                                        borderColor: borderColor))
//        self.insertSubview(imageView, atIndex: 0)
//    }
//    
//    func kt_drawRectWithRoundedCorner(radius radius: CGFloat,
//                                      borderWidth: CGFloat,
//                                      backgroundColor: UIColor,
//                                      borderColor: UIColor) -> UIImage {
//        let sizeToFit = CGSize(width: pixel(Double(self.bounds.size.width)), height: Double(self.bounds.size.height))
//        let halfBorderWidth = CGFloat(borderWidth / 2.0)
//        
//        UIGraphicsBeginImageContextWithOptions(sizeToFit, false, UIScreen.mainScreen().scale)
//        let context = UIGraphicsGetCurrentContext()
//        
//        CGContextSetLineWidth(context, borderWidth)
//        CGContextSetStrokeColorWithColor(context, borderColor.CGColor)
//        CGContextSetFillColorWithColor(context, backgroundColor.CGColor)
//        
//        let width = sizeToFit.width, height = sizeToFit.height
//        CGContextMoveToPoint(context, width - halfBorderWidth, radius + halfBorderWidth)  // 开始坐标右边开始
//        CGContextAddArcToPoint(context, width - halfBorderWidth, height - halfBorderWidth, width - radius - halfBorderWidth, height - halfBorderWidth, radius)  // 右下角角度
//        CGContextAddArcToPoint(context, halfBorderWidth, height - halfBorderWidth, halfBorderWidth, height - radius - halfBorderWidth, radius) // 左下角角度
//        CGContextAddArcToPoint(context, halfBorderWidth, halfBorderWidth, width - halfBorderWidth, halfBorderWidth, radius) // 左上角
//        CGContextAddArcToPoint(context, width - halfBorderWidth, halfBorderWidth, width - halfBorderWidth, radius + halfBorderWidth, radius) // 右上角
//        
//        CGContextDrawPath(UIGraphicsGetCurrentContext(), .FillStroke)
//        let output = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return output
//    }
//}

@end
