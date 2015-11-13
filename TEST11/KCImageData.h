//
//  KCImageData.h
//  TEST11
//
//  Created by dongjl on 15/11/13.
//  Copyright © 2015年 djl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KCImageData : NSObject
#pragma mark 索引
@property (nonatomic,assign) NSInteger index;

#pragma mark 图片数据
@property (nonatomic,strong) NSData *data;
@end
