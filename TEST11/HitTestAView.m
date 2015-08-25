//
//  HitTestView.m
//  TEST11
//
//  Created by dongjl on 15-8-25.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "HitTestAView.h"
#import "HiTestBView.h"
#import "HitTestCView.h"
#import "HiTestDview.h"
@implementation HitTestAView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor redColor];
        
        HiTestBView* bView = [[HiTestBView alloc] initWithFrame:CGRectMake(0, 64, 100, 100)];
        bView.backgroundColor = [UIColor greenColor];
        [self addSubview:bView];
        
        HitTestCView* cView = [[HitTestCView alloc] initWithFrame:CGRectMake(0, 180, 200, 200)];
        cView.backgroundColor = [UIColor blueColor];
        [self addSubview:cView];
        
        HiTestDview* dView = [[HiTestDview alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
        dView.backgroundColor = [UIColor yellowColor];
        [cView addSubview:dView];
    }
    return self;
}


/*
hitTest的作用:当在一个view上添加一个屏蔽罩，但又不影响对下面view的操作，也就是可以透过屏蔽罩对下面的view进行操作，这个函数就很好用了。


hitTest的用法：将下面的函数添加到UIView的子类中，也就是屏蔽罩类中即可。

-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self)
    {
        return nil;
    }
    else
    {
        return hitView;
    }
}
*/
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if (self.hidden || !self.userInteractionEnabled || self.alpha < 0.01)
//    {
//        return nil;
//    }
//    
//    if (![self pointInside:point withEvent:event])
//    {
//        return nil;
//    }
//    
//    __block UIView *hitView = self;
//    
//    [self.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        
//        CGPoint thePoint = [self convertPoint:point toView:obj];
//        
//        UIView *theSubHitView = [obj hitTest:thePoint withEvent:event];
//        
//        if (theSubHitView != nil)
//        {
//            hitView = theSubHitView;
//            
//            *stop = YES;
//        }
//        
//    }];
//    
//    return hitView;
//}



@end
