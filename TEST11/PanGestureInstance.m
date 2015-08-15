//
//  PanGestureInstance.m
//  TEST11
//
//  Created by 董金亮 on 15/8/14.
//  Copyright (c) 2015年 djl. All rights reserved.
//

#import "PanGestureInstance.h"

@interface PanGestureInstance (){
  CGFloat  firstX ;
  CGFloat  firstY;
}
@property(weak,nonatomic) IBOutlet UIView *v1;
@property(weak,nonatomic) IBOutlet UIView *v2;
@end

@implementation PanGestureInstance

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.v1 addGestureRecognizer:pan];
    
    UIPanGestureRecognizer* handlePan2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector( handlePan2:)];
    [self.v2 addGestureRecognizer:handlePan2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pan:(UIPanGestureRecognizer*)ges{
    CGPoint point = [ges translationInView:self.view];
    NSLog(@"%f,%f",point.x,point.y);
    ges.view.center = CGPointMake(ges.view.center.x + point.x, ges.view.center.y + point.y);
    [ges setTranslation:CGPointMake(0, 0) inView:self.view];
}


- (void)handlePan2:(UIPanGestureRecognizer *)recognizer
{
    // NSLog(@"gesture translatedPoint  xxoo xxoo");
    CGPoint translatedPoint = [recognizer translationInView:self.view];
    
    if ([(UIPanGestureRecognizer *)recognizer state] == UIGestureRecognizerStateBegan) {
        firstX = recognizer.view.center.x;
        firstY = recognizer.view.center.y;
        NSLog(@"self.view bounds is %@", NSStringFromCGRect(self.view.bounds));
        NSLog(@"pan gesture testPanView begin  is %@,%@", NSStringFromCGPoint([recognizer view].center), NSStringFromCGRect([recognizer view].frame));
    }
    
    if ([(UIPanGestureRecognizer *)recognizer state] == UIGestureRecognizerStateChanged) {
        CGFloat x = firstX + translatedPoint.x;
        CGFloat y = firstX + translatedPoint.y;
        
        if (x < recognizer.view.width / 2.0) {
            x = recognizer.view.width / 2.0;
        } else if (x + recognizer.view.width / 2.0 > self.view.width) {
            x = self.view.width - recognizer.view.width / 2.0;
        }
        
        if (y < recognizer.view.height / 2.0) {
            y = recognizer.view.height / 2.0;
        } else if (y + recognizer.view.height / 2.0 > self.view.height) {
            y = self.view.height - recognizer.view.height / 2.0;
        }
        
        NSLog(@"gesture translatedPoint moving  is %@", NSStringFromCGPoint(translatedPoint));
        
        recognizer.view.center = CGPointMake(x, y);
    }
    
    if (([(UIPanGestureRecognizer *)recognizer state] == UIGestureRecognizerStateEnded) || ([(UIPanGestureRecognizer *)recognizer state] == UIGestureRecognizerStateCancelled)) {
        CGFloat x = recognizer.view.center.x;
        CGFloat y = recognizer.view.center.y;
        
        if (x > firstX) {
            x = self.view.width - recognizer.view.width / 2.0;
        } else {
            x = recognizer.view.width / 2.0;
        }
        
        if (y > firstY) {
            y = self.view.height - recognizer.view.height / 2.0;
        } else {
            y = recognizer.view.height / 2.0;
        }
        
        CGFloat velocityX = (0.2 *[recognizer velocityInView:self.view].x);
        
        [UIView beginAnimations:nil context:NULL];
        
        [UIView setAnimationDuration:ABS(velocityX * 0.00002 + 0.2)];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        
        recognizer.view.center = CGPointMake(x, y);
        
        [UIView commitAnimations];
        
        NSLog(@"gesture translatedPoint  end is %@", NSStringFromCGPoint(translatedPoint));
        
        NSLog(@"pan gesture testPanView end  is %@,%@", NSStringFromCGPoint([recognizer view].center), NSStringFromCGRect([recognizer view].frame));
    }
}
@end
