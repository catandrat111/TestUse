//
//  ZOCNewsViewController.h
//  TEST11
//
//  Created by dongjl on 15/9/29.
//  Copyright © 2015年 djl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZOCNews.h"
extern NSString *const ZOCNewsViewControllerDidClearCacheNotification;
@interface ZOCNewsViewController : UIViewController

@property(nonatomic,strong) ZOCNews *news;
@property (nonatomic, readonly) NSArray *elements;
@end
