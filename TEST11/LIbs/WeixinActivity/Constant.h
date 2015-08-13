//
//  Constant.h
//  RouteShop
//
//  Created by 王一丁 on 14-1-6.
//  Copyright (c) 2014年 WYD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Position.h"

#define WEIBO_SERVICE_URL @"http://service.weibo.com/share/share.php?url=&pic=&title=&appkey=&ralateUid="

#ifdef DEBUG
#ifndef DLog
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#endif
#ifndef ELog
#   define ELog(err) {if(err) DLog(@"%@", err)}
#endif
#else
#ifndef DLog
#   define DLog(...)
#endif
#ifndef ELog
#   define ELog(err)
#endif
#endif



#define REPLACE_NIL_OBJECT(object) [NSString stringWithFormat:@"%@",(object != nil) ? object : @""]



#define SQKeyPath(object, keyPath) ({ if (NO) { (void)((object).keyPath); } @#keyPath; })

#define SQSelfKeyPath(keyPath) SQKeyPath(self, keyPath)
#define SQTypedKeyPath(ObjectClass, keyPath) SQKeyPath(((ObjectClass *)nil), keyPath)
#define SQProtocolKeyPath(Protocol, keyPath) SQKeyPath(((id <Protocol>)nil), keyPath)

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define iOS7Blue [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define XAppDelegate ((ZHPAppDelegate *)[[UIApplication sharedApplication] delegate])
#define IXAppDelegate ((ZHAppDelegate *)[UIApplication sharedApplication].delegate)

#define Constant_Line_Width  (1.0/[UIScreen mainScreen].scale)


NS_INLINE NSRange NSRangeMake(NSUInteger loc, NSUInteger len) {
    return NSMakeRange(loc, len);
}

NS_INLINE NSUInteger NSRangeMax(NSRange range) {
    return NSMaxRange(range);
}

NS_INLINE BOOL NSRangeContainsLocation(NSUInteger loc, NSRange range) {
    return NSLocationInRange(loc, range);
}

NS_INLINE BOOL NSRangeEqualToRange(NSRange range1, NSRange range2) {
    return NSEqualRanges(range1, range2);
}

NS_INLINE NSRange NSRangeZero() {
    NSRange range;
    return range;
}
//test
NS_INLINE NSRange NSRangeUnion(NSRange range1, NSRange range2) {
    return NSUnionRange(range1, range2);
}

NS_INLINE NSRange NSRangeIntersection(NSRange range1, NSRange range2) {
    return NSIntersectionRange(range1, range2);
}

NS_INLINE NSDictionary * NSRangeCreateDictionaryRepresentation(NSRange range) {
    return @{@"location": @(range.location), @"length": @(range.length)};
}

NS_INLINE BOOL NSRangeMakeFromDictionaryRepresentation(NSDictionary *representation, NSRangePointer range) {
    if (!representation[@"location"] || !representation[@"length"]) {
        return NO;
    }
    
    NSRange r;
    r.location = [representation[@"location"] unsignedIntegerValue];
    r.length = [representation[@"length"] unsignedIntegerValue];
    range = &r;
    
    return YES;
}

NS_INLINE NSDateFormatter *cachedNormalDateFormatter() {
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:@"cachedNormalDateFormatter"];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [threadDictionary setObject:dateFormatter forKey:@"cachedNormalDateFormatter"];
    }
    return dateFormatter;
}

NS_INLINE NSDateFormatter *cachedGMT8DateFormatter() {
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:@"cachedGMT8DateFormatter"];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        [threadDictionary setObject:dateFormatter forKey:@"cachedGMT8DateFormatter"];
    }
    return dateFormatter;
}

NS_INLINE NSDate *dateDisplayWithDateString(id dateString)
{
    if ([dateString isKindOfClass:[NSNumber class]]) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateString longLongValue] * 0.001];
        
        NSDateFormatter *dateformatter = cachedGMT8DateFormatter();
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        dateString = [dateformatter stringFromDate:date];
        
        
    }else if([dateString isKindOfClass:[NSDate class]]){
        
        return dateString;
        
    }
    
    
    [cachedNormalDateFormatter() setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [cachedNormalDateFormatter() dateFromString:dateString];
    
}

NS_INLINE NSString *dateStringDisplayWithFormat(NSString *format , id dateString)
{
    NSDate *date = dateDisplayWithDateString(dateString);
    
    cachedNormalDateFormatter().dateFormat = format;
    
    return [cachedNormalDateFormatter() stringFromDate:date];
}

NS_INLINE NSDate *dateDisplayWithDateStringFormat(NSString *format , NSString *dateString)
{
    
    cachedNormalDateFormatter().dateFormat = format;
    
    NSDate *date = [cachedNormalDateFormatter() dateFromString:dateString];
    
    return date;
}

NS_INLINE NSString *dateStringDisplayWithDateStringFormat(NSString *dateFormat ,NSString *displayFormat ,  NSString *dateString)
{

    NSDate *date = dateDisplayWithDateStringFormat(dateFormat, dateString);
    
    cachedNormalDateFormatter().dateFormat = displayFormat;
    
    return [cachedNormalDateFormatter() stringFromDate:date];
}


NS_INLINE NSComparisonResult compareDate(NSDate *firstDate , NSDate* secondDate)
{
    //firstdate 小与seconddate
    if([firstDate timeIntervalSinceDate:secondDate] < 0.0) {
        return NSOrderedAscending;
    }
    else if([firstDate timeIntervalSinceDate:secondDate] == 0.0){
        return NSOrderedSame;
    }
    else return NSOrderedDescending;
}


@interface Constant : NSObject

@end
