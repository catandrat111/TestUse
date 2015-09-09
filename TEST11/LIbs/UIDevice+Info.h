//
//  UIDevice+Info.h
//  zsch
//
//  Created by dongjl on 15-8-7.
//  Copyright (c) 2015年 WYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Info)
+(NSString*)getDeviceType;
+(NSString*)getUDID;
+(NSString*)getUDID1;

+(void)saveAccount:(NSString*)account;
+(NSString*)getAccount;
+(void)removeAccount;

+(void)savePwd:(NSString*)pwd;
+(NSString*)getPwd;
+(void)removePwd;
@end
