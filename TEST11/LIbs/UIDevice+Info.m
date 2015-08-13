//
//  UIDevice+Info.m
//  zsch
//
//  Created by dongjl on 15-8-7.
//  Copyright (c) 2015年 WYD. All rights reserved.
//

#import "UIDevice+Info.h"
#import "SSKeychain.h"
@implementation UIDevice (Info)
+(bool)checkDevice:(NSString*)name
{
    NSString* deviceType = [[self class] currentDevice].model;
    NSLog(@"deviceType = %@", deviceType);
    
    NSRange range = [deviceType rangeOfString:name];
    return range.location != NSNotFound;
}

+(NSString*)getDeviceType{
    NSString *  strIphone=@"iPhone";
    NSString *  strIpod=@"iPod";
    NSString *  strIpad=@"iPad";
    if([[self class] checkDevice:strIphone]){
        return @"1";
    }else if ([[self class] checkDevice:strIpad]){
        return @"2";
    }
    else  if([[self class]checkDevice:strIpod]){
        return @"3";
        
    }
    
    NSAssert(NO, @"无法检测设备");
    return @"-1";
}


+ (NSString *)createUuidString
{
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    NSString *uuidString = (__bridge NSString*)CFUUIDCreateString(NULL, uuid);
    
    // release the UUID
    CFRelease(uuid);
    
    // transfer ownership of the string
    // to the autorelease pool
    return uuidString;
}


+(NSString*)getUDID{
    NSString* udid = @"";
    if(![SSKeychain passwordForService:@"com.hello" account:@"hello"]){
        NSString* uuidStr = [[self class] createUuidString];
        [SSKeychain setPassword:uuidStr forService: @"com.hello" account:@"hello"];
    }
    udid = [SSKeychain passwordForService:@"com.hello" account:@"hello"];
    return udid;
}


@end
