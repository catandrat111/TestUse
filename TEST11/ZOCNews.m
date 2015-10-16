//
//  ZOCNews.m
//  TEST11
//
//  Created by dongjl on 15/9/29.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "ZOCNews.h"

@implementation ZOCNews

- (instancetype)initWithTitle:(NSString *)title
                         date:(NSDate *)date
                     location:(NSString *)location {
    self = [super init];
    if (self) {
        _title = title; _date = date; _location = location;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title date:(NSDate *)date
{
    return [self initWithTitle:title date:date location:nil];
}

- (instancetype)initWithTitle:(NSString *)title {
    return [self initWithTitle:title date:[NSDate date] location:nil];
}

@end
