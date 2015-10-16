//
//  UITableView+iOS7Style.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/6/1.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UITableView+iOS7Style.h"

@implementation UITableView (iOS7Style)
// http://stackoverflow.com/questions/18822619/ios-7-tableview-like-in-settings-app-on-ipad

static NSInteger linewidth = 1;

//带边框
-(void)applyiOS7SettingsStyleGrouping:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(tintColor)]) {
        CGFloat cornerRadius = 5;
        cell.backgroundColor = UIColor.clearColor;
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        //CGRect bounds = cell.bounds;
        CGRect bounds = CGRectInset(cell.bounds, 0, 0);
        BOOL addLine = NO;
        layer.path = pathRef;
       // CFRelease(pathRef);
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        [testView.layer insertSublayer:layer atIndex:0];
        testView.backgroundColor = UIColor.clearColor;
        testView.clipsToBounds = YES;
        cell.backgroundView = testView;
        cell.backgroundColor  = [UIColor clearColor];
        
        if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
            CGRect bound1 = CGRectInset(cell.bounds, 1, 1);
            CGPathAddRoundedRect(pathRef, nil, bound1, cornerRadius, cornerRadius);
        } else if (indexPath.row == 0) {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds)+linewidth, CGRectGetMaxY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds)+linewidth, CGRectGetMinY(bounds) + linewidth, CGRectGetMidX(bounds), CGRectGetMinY(bounds)+1, cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds)-linewidth, CGRectGetMinY(bounds)+linewidth, CGRectGetMaxX(bounds), CGRectGetMidY(bounds)-linewidth/2, cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds)-linewidth, CGRectGetMaxY(bounds));
            
            addLine = YES;
        } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds)+linewidth, CGRectGetMinY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds)+linewidth, CGRectGetMaxY(bounds)-linewidth, CGRectGetMidX(bounds), CGRectGetMaxY(bounds)-linewidth, cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds)-linewidth, CGRectGetMaxY(bounds)-linewidth, CGRectGetMaxX(bounds), CGRectGetMidY(bounds)-linewidth/2, cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds)-linewidth, CGRectGetMinY(bounds));
            
        } else {
            //中间
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds)+linewidth, CGRectGetMinY(bounds));
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMinX(bounds)+linewidth, CGRectGetMaxY(bounds));
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMaxX(bounds)-linewidth, CGRectGetMinY(bounds));
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds)-linewidth, CGRectGetMaxY(bounds));
            cell.backgroundColor = [UIColor whiteColor];
            addLine = YES;
        }
        
        layer.fillColor = UIColorFromRGB(0xffffff).CGColor;
        layer.strokeColor = UIColorFromRGB(0xe3e3e3).CGColor;
        layer.lineWidth= linewidth;
        CFRelease(pathRef);
        if (addLine == YES) {
            CAShapeLayer *lineLayer = [[CAShapeLayer alloc] init];
            CGMutablePathRef linePathRef = CGPathCreateMutable();
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            CGPathMoveToPoint(linePathRef, nil, CGRectGetMinX(bounds)+0, bounds.size.height-lineHeight);
            CGPathAddLineToPoint(linePathRef, nil, CGRectGetMaxX(bounds)-0, bounds.size.height-lineHeight);
            lineLayer.path = linePathRef;
            CFRelease(linePathRef);
            
            lineLayer.strokeColor = UIColorFromRGB(0xe3e3e3).CGColor;
            [layer addSublayer:lineLayer];
            [lineLayer setLineJoin:kCALineJoinRound];
            // 3=线的宽度 1=每条线的间距
            [lineLayer setLineDashPattern:@[@3,@1]];
        }
    }
}

//没有边框
-(void)applyiOS7SettingsStyleGroupingWithoutBorder:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        CGFloat cornerRadius = 5.f;
        cell.backgroundColor = UIColor.clearColor;
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGMutablePathRef pathRef = CGPathCreateMutable();
        //CGRect bounds = cell.bounds;
        CGRect bounds = CGRectInset(cell.bounds, 0, 0);
        BOOL addLine = NO;
        
        if (indexPath.row == 0 && indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            
            addLine = YES;
            
        } else if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            
        } else {
            CGPathAddRect(pathRef, nil, bounds);
            addLine = YES;
        }
        
        layer.path = pathRef;
        CFRelease(pathRef);
        layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
        
        if (addLine == YES) {
            CALayer *lineLayer = [[CALayer alloc] init];
            CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
            lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10, lineHeight);
            lineLayer.backgroundColor = self.separatorColor.CGColor;
            [layer addSublayer:lineLayer];
        }
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        [testView.layer insertSublayer:layer atIndex:0];
        testView.backgroundColor = UIColor.clearColor;
        cell.backgroundView = testView;
    }
    
}

-(void)modifySeparatorInset:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [self numberOfRowsInSection:indexPath.section]-1) {
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            cell.preservesSuperviewLayoutMargins = NO;
            cell.layoutMargins = UIEdgeInsetsZero;
        }
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

@end
