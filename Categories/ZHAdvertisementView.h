//
//  ZHAdvertisementView.h
//  zsch
//
//  Created by dongjl on 15-4-28.
//  Copyright (c) 2015年 WYD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHPopBaseView.h"
@interface ZHAdvertisementView : ZHPopBaseView
@property(nonatomic,weak) IBOutlet UILabel* titleLab;
@property(nonatomic,weak) IBOutlet UILabel* activityLab1;
@property(nonatomic,weak) IBOutlet UIButton* watchDetailButton;
@property(nonatomic,weak) IBOutlet UIButton* deleteButton;
@end
