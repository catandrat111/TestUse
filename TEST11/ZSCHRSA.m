//
//  RSADemo.m
//  encryptDemo
//
//  Created by bhxiaobo on 14-8-4.
//  Copyright (c) 2014年 com.miaomiaobase. All rights reserved.
//

#import "ZSCHRSA.h"
#import <CommonCrypto/CommonDigest.h>
@implementation ZSCHRSA


+ (SecKeyRef) getPrivateKeywithRawKey:(NSData *)pfxkeydata
{
    
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init] ;
    
    // Set the public key query dictionary
    //change to your .pfx  password here
    [options setObject:@"bewinner" forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    
    OSStatus securityError = SecPKCS12Import
    ((__bridge CFDataRef) pfxkeydata,
                                             (__bridge CFDictionaryRef)options, &items);
    
    CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
    SecIdentityRef identityApp =
    (SecIdentityRef)CFDictionaryGetValue(identityDict,
                                         kSecImportItemIdentity);
    //NSLog(@"%@", securityError);
    
    assert(securityError == noErr);
    SecKeyRef privateKeyRef;
    SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
    
    return privateKeyRef;
    
}
//static NSString *CLIENT_PRIVATE_KEY=@"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";
//
//static NSString  *SERVER_PUBLIC_KEY=@"MIICazCCAdQCCQDqx3ZpyAY2nzANBgkqhkiG9w0BAQUFADB6MQswCQYDVQQGEwJDTjELMAkGA1UECAwCQkoxCzAJBgNVBAcMAkJKMREwDwYDVQQKDAhiZXdpbm5lcjENMAsGA1UECwwEeHRqYzEPMA0GA1UEAwwGbGlqaW5nMR4wHAYJKoZIhvcNAQkBFg9saWppbmdAYnczMC5jb20wHhcNMTUwNzMxMDYyNTAzWhcNMjUwNzI4MDYyNTAzWjB6MQswCQYDVQQGEwJDTjELMAkGA1UECAwCQkoxCzAJBgNVBAcMAkJKMREwDwYDVQQKDAhiZXdpbm5lcjENMAsGA1UECwwEeHRqYzEPMA0GA1UEAwwGbGlqaW5nMR4wHAYJKoZIhvcNAQkBFg9saWppbmdAYnczMC5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBANLcDw6zq2ndxNLm6vx7MNJ7IeV+m6Ig6ponEvB3Jrhz43Fd9teErM/ux0BY/eJeikb6Ezx4HuVecySmhNKDsRDU2wpUiPA8Z3/wKCkNFylz705KUQAsHbECAGcY/PXovEE6cICTwwTcsOJNII8ccHYfGx8ydCc4UPjLGjCnuq6TAgMBAAEwDQYJKoZIhvcNAQEFBQADgYEAs44m6eB2Ef85sX54GCQCzhR1huV0f2e3bGwDfcyoZir10X4CfXNyWWVBhQC0g9evX4wx+UFH8sCMTgOxFB470cOAsuX3MlPaadUt8urPAU4Iun4g5R3sFAw/QoaK8nQMu4Kpyq7vWCKHXFZXHQT0XYNwa2MmD3KAukWMMQRXOgQ=";


static NSString *CLIENT_PRIVATE_KEY=@"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";

static NSString  *SERVER_PUBLIC_KEY=@"MIICLTCCAZYCCQCEGRlWoK9/hzANBgkqhkiG9w0BAQUFADBbMQswCQYDVQQGEwJBWjEKMAgGA1UECBMBQTEKMAgGA1UEBxMBQTEKMAgGA1UEChMBQTEKMAgGA1UECxMBQTEKMAgGA1UEAxMBQTEQMA4GCSqGSIb3DQEJARYBQTAeFw0xNjA3MDUwMDMyMTZaFw0yNjA3MDMwMDMyMTZaMFsxCzAJBgNVBAYTAkFaMQowCAYDVQQIEwFBMQowCAYDVQQHEwFBMQowCAYDVQQKEwFBMQowCAYDVQQLEwFBMQowCAYDVQQDEwFBMRAwDgYJKoZIhvcNAQkBFgFBMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC944ZV02FXOBjIatpkfv78BHE53JPGlXPMcJUHkXKLvsvR/HqKMeCQX8SDgkDVlpNfJsXVMChI/xPf7MBgibl+gPHBAVi3tw4gko21xb/02Mo1B62EElH9juwVoXjKBEPGLnU5lpmuAGgDaijZQYL6Pc8Ytl74vMyrtabsLuI9uwIDAQABMA0GCSqGSIb3DQEBBQUAA4GBADZHBbjLKzB7RMmpnGDZQJY6AU4+waBUPAxgE76gcOfBurjqBm7q24YaDaSkcD62arNLz3sYFmRICZQeOdoDcvsLYumwAnNS4GooM2y0XNggedXkMwOWDlRgCQCK83EkIJMMj4z+T32hLEOLEOUt2szQZyhL9Qjt8KrJIPqVv3YN";


static SecKeyRef privateKey=nil;
+ (NSString *) rsaDescryptString:(NSString *)encryptString {
    NSData *wrappedSymmetricKey = [encryptString base64DecodedData];
    // NSString *path=  @"/Users/bhxiaobo/Desktop/certificate/rsaPrivate.p12";
    // NSString *path= [[NSBundle mainBundle] pathForResource:@"zsch_client_private_key" ofType:@"p12"];
    
    NSData *data= [CLIENT_PRIVATE_KEY base64DecodedData];;
    privateKey=  [self getPrivateKeywithRawKey:data];
    
    size_t cipherBufferSize = SecKeyGetBlockSize(privateKey);
    size_t keyBufferSize = [wrappedSymmetricKey length];
    
    NSMutableData *bits = [NSMutableData dataWithLength:keyBufferSize];
    OSStatus sanityCheck = SecKeyDecrypt(privateKey,
                                         kSecPaddingNone,
                                         (const uint8_t *) [wrappedSymmetricKey bytes],
                                         cipherBufferSize,
                                         [bits mutableBytes],
                                         &keyBufferSize);
    NSAssert(sanityCheck == noErr, @"Error decrypting, OSStatus == %ld.", sanityCheck);
    [bits setLength:keyBufferSize];
    return [[NSString alloc] initWithData:bits  encoding:NSUTF8StringEncoding];
    
}

static SecKeyRef _public_key=nil;
+ (SecKeyRef) getPublicKey{ // 从公钥证书文件中获取到公钥的SecKeyRef指针
    if(_public_key == nil){
        //  NSString *path= [[NSBundle mainBundle]pathForResource:@"zsch_client_public_key" ofType:@"der"];
        // NSLog(@"public key%@",SERVER_PUBLIC_KEY);
        //NSData *data=[SERVER_PUBLIC_KEY base64DecodedData];
        
        NSData *certificateData = [NSData dataWithBase64EncodedString:SERVER_PUBLIC_KEY];
        
        
        SecCertificateRef myCertificate =  SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)certificateData);
        SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
        SecTrustRef myTrust;
        OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
        SecTrustResultType trustResult;
        if (status == noErr) {
            status = SecTrustEvaluate(myTrust, &trustResult);
        }
        _public_key = SecTrustCopyPublicKey(myTrust);
        CFRelease(myCertificate);
        CFRelease(myPolicy);
        CFRelease(myTrust);
    }
    return _public_key;
}

+ (NSString *) rsaEncryptString:(NSString*) string{
    SecKeyRef key = [self getPublicKey];
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    NSData *stringBytes = [string dataUsingEncoding:NSUTF8StringEncoding];
    size_t blockSize = cipherBufferSize - 11;
    size_t blockCount = (size_t)ceil([stringBytes length] / (double)blockSize);
    NSMutableData *encryptedData = [[NSMutableData alloc] init] ;
    for (int i=0; i<blockCount; i++) {
        int bufferSize = MIN(blockSize,[stringBytes length] - i * blockSize);
        NSData *buffer = [stringBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(key, kSecPaddingNone, (const uint8_t *)[buffer bytes],
                                        [buffer length], cipherBuffer, &cipherBufferSize);
        if (status == noErr){
            NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
            // [encryptedBytes release];
        }else{
            if (cipherBuffer) free(cipherBuffer);
            return nil;
        }
    }
    if (cipherBuffer) free(cipherBuffer);
    if (encryptedData!=NULL) {
        
    }
    
    return [encryptedData base64EncodedString];
    
}

+(NSString *)getReqSign:(NSString *)plainText{
    
    @synchronized([NSObject class]){
        const char *cStr = [plainText UTF8String];
        
        unsigned char result[16];
        CC_MD5(cStr, (int)strlen(cStr), result);
        
        NSString *md5String = [NSString stringWithFormat:
                @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                result[0], result[1], result[2], result[3],
                result[4], result[5], result[6], result[7],
                result[8], result[9], result[10], result[11],
                result[12], result[13], result[14], result[15]
                               ];
        
        SecKeyRef key = [self getPublicKey];
        size_t cipherBufferSize = SecKeyGetBlockSize(key);
        uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
        NSData *stringBytes = [md5String dataUsingEncoding:NSUTF8StringEncoding];
        
        NSString *base64Md5=   [stringBytes base64EncodedString];
        NSLog(@"string bytes %@",base64Md5);
        size_t blockSize = cipherBufferSize - 11;
        
        size_t blockCount = (size_t)ceil([stringBytes length] / (double)blockSize);
        NSMutableData *encryptedData = [[NSMutableData alloc] init] ;
        for (int i=0; i<blockCount; i++) {
            int bufferSize = MIN(blockSize,[stringBytes length] - i * blockSize);
            NSData *buffer = [stringBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
            OSStatus status = SecKeyEncrypt(key, kSecPaddingNone, (const uint8_t *)[buffer bytes],
                                            [buffer length], cipherBuffer, &cipherBufferSize);
            if (status == noErr){
                NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
                [encryptedData appendData:encryptedBytes];
                // [encryptedBytes release];
            }else{
                if (cipherBuffer) free(cipherBuffer);
                return nil;
            }
        }
        if (cipherBuffer) free(cipherBuffer);
        if (encryptedData!=NULL) {
            
        }
        
        
        
        return [self hexStringFromString:encryptedData];
    
    }
    
    
}

+ (NSString *)hexStringFromString:(NSData *)data{

    Byte *bytes = (Byte *)[data bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];   
    }   
    return hexStr;   
}

- (void)dealloc{
    CFRelease(certificate);
    CFRelease(trust);
    CFRelease(policy);
    CFRelease(publicKey);
}



@end
