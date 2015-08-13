//
//  CALayer+Addition.m
//  Test222
//
//  Created by dongjl on 15-5-15.
//  Copyright (c) 2015年 DongJL. All rights reserved.
//

#import "CALayer+Addition.h"

@implementation CALayer (Addition)
-(void)setLayerBackgroundColor:(UIColor*)color{
    self.backgroundColor = color.CGColor;
    
}

-(void)setLayerBorderColor:(UIColor*)color{
    self.borderColor = color.CGColor;

}

-(void)setLayerBorderWidth:(NSNumber *)number
{
    self.borderWidth = number.floatValue;
}

@end
