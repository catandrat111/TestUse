//
//  MyWebView.m
//  TEST11
//
//  Created by dongjl on 15/11/27.
//  Copyright © 2015年 djl. All rights reserved.
//http://www.cocoachina.com/bbs/read.php?tid=150899

#import "MyWebView.h"

@implementation MyWebView
//没经测试
- (id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if(self) {
        UIMenuItem *flag = [[UIMenuItem alloc] initWithTitle:@"定义"action:@selector(flag:)];
        UIMenuController *menu =[UIMenuController sharedMenuController];
        [menu setMenuItems:[NSArray arrayWithObjects:flag, nil]];
        
    }
    return self;
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action ==@selector(_define:)) {
        return NO;
}
    if (action ==@selector(selectAll:)) {
        return YES;
}
    if (action ==@selector(flag:)) {
        return YES;
}
    
    
return[super canPerformAction:action withSender:sender];
    
    
}

- (void)flag:(id)sender{
    [self copy:nil];
    UIPasteboard *pasteBoard =[UIPasteboard generalPasteboard];
    if (pasteBoard.string !=nil) {
        //DLog(@"%@", pasteBoard.string);
    }
}

@end
