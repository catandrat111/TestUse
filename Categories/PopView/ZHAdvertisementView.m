//
//  ZHAdvertisementView.m
//  zsch
//
//  Created by dongjl on 15-4-28.
//  Copyright (c) 2015年 WYD. All rights reserved.
//

#import "ZHAdvertisementView.h"
#import "RNBlurModalView.h"
@implementation ZHAdvertisementView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame nibName:@"ZHAdvertisementView"];
    if (self) {
        [self.watchDetailButton addTarget:self action:@selector(watchDetailAction) forControlEvents:UIControlEventTouchUpInside];
        [self.deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return self;
}

-(void)watchDetailAction{
    [self.modalView perFormDismisBlock:^{
        if(self.defaultBlock){
            self.defaultBlock();
        }
    }];
    [self.modalView hide];
}


-(void)deleteAction{
    [self.modalView hide];
}


-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    
    
    return hitView;
    
}


@end
