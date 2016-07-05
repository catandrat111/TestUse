//
//  RSADemo.h
//  encryptDemo
//
//  Created by bhxiaobo on 14-8-4.
//  Copyright (c) 2014年 com.miaomiaobase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Base64.h"
@interface ZSCHRSA : NSObject
{
    
    SecKeyRef publicKey;
    
    SecKeyRef privateKey;
    
    SecCertificateRef certificate;
    
    SecPolicyRef policy;
    
    SecTrustRef trust;
    
    size_t maxPlainLen;
    
}

+ (NSString*)  rsaEncryptString:(NSString*) plainText;
+ (NSString *) rsaDescryptString:(NSString *)encryptString ;
+(NSString *) getReqSign:(NSString *)plainText;

@end
