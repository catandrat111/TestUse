//
//  DES3Util.h
//  TestRSA
//
//  Created by bhxiaobo on 14-8-8.
//  Copyright (c) 2014年 先花. All rights reserved.
//
//
//  DES3Util.h
//

#import <Foundation/Foundation.h>
#import "Base64.h"
@interface DES3Util : NSObject {
    
}
// 加密方法
+ (NSString*)encrypt:(NSString*)plainText key: (NSString *)key;

// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText key:(NSString *)key;

@end

