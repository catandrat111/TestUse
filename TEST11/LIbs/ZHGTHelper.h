//
//  ZHGTHelper.h
//  zsch
//
//  Created by dongjl on 15/11/26.
//  Copyright © 2015年 WYD. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^GTResult) (BOOL result);

@interface ZHGTHelper : NSObject
@property (nonatomic, copy) GTResult GTResultBlock;

- (void)requestGTest;
@end
