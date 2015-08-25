//
//  HitTestCView.m
//  TEST11
//
//  Created by dongjl on 15-8-25.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "HitTestCView.h"

@implementation HitTestCView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor blueColor];
        UIButton* bu = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 130, 80)];
        [bu setTitle:@"press" forState:UIControlStateNormal];
        [bu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:bu];
        [bu addTarget:self action:@selector(p1) forControlEvents:UIControlEventTouchUpInside];
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
//    return YES;
//}

-(void)p1{
    NSLog(@"p1");
}
@end
