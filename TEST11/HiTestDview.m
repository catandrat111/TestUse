//
//  HiTestDview.m
//  TEST11
//
//  Created by dongjl on 15-8-25.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "HiTestDview.h"

@implementation HiTestDview

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor yellowColor];
        
    }
    return self;
}

//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    if([self pointInside:point withEvent:event]){
//        return self;
//    }
//    return nil;
//}

//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    return NO;
//}
@end