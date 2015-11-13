//
//  ConditionViewController.h
//  TEST11
//
//  Created by dongjl on 15/11/13.
//  Copyright © 2015年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConditionViewController : UIViewController
@property (atomic,strong) NSMutableArray *imageNames;
#pragma mark 当前加载的图片索引（图片链接地址连续）
@property (atomic,assign) int currentIndex;
@end
