//
//  ZHPopBaseView.h
//  zsch
//
//  Created by dongjl on 15-4-28.
//  Copyright (c) 2015年 WYD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RNBlurModalView;
typedef void (^ ZHCommonBlock)(void);
typedef void (^ ZHDismisBlock)(void);
@interface ZHPopBaseView : UIView
@property (nonatomic, copy) ZHCommonBlock defaultBlock;
@property (nonatomic, copy) ZHCommonBlock dismisBlock;
@property (nonatomic, weak) RNBlurModalView* modalView;
-(instancetype)initWithFrame:(CGRect)frame nibName :(NSString*)nibName;
-(void)perFormCommonBlock:(ZHCommonBlock)block;
-(void)perFormDismissBlock:(ZHDismisBlock)block;
@end
