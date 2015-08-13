//
//  ZHPopBaseView.m
//  zsch
//
//  Created by dongjl on 15-4-28.
//  Copyright (c) 2015年 WYD. All rights reserved.
//

#import "ZHPopBaseView.h"

@implementation ZHPopBaseView

-(instancetype)initWithFrame:(CGRect)frame nibName :(NSString*)nibName{
    self = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];
    if (self) {
    }
    return self;
}



-(void)perFormCommonBlock:(ZHCommonBlock)block{
    self.defaultBlock = block;
}

-(void)perFormDismissBlock:(ZHDismisBlock)block{
    self.dismisBlock = block;
}

@end
