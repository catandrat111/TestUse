//
//  NSDictionary+Log.m
//  TEST11
//
//  Created by dongjl on 16/2/16.
//  Copyright © 2016年 djl. All rights reserved.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)
-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
 {
         //初始化可变字符串
//         NSMutableString *string = [NSMutableString string];
//         //拼接开头[
//         [string appendString:@"["];
//    
//         //拼接字典中所有的键值对
//         [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//                 [string appendFormat:@"%@:",key];
//                 [string appendFormat:@"%@",obj];
//             }];
//    
//         //拼接结尾]
//         [string appendString:@"]"];
//     
//         return string;
     
    return  [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil] encoding:4];

     }
@end
