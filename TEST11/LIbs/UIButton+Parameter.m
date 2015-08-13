//
//  UIButton+Parameter.m
//  zsch
//
//  Created by 董金亮 on 15/7/4.
//  Copyright (c) 2015年 WYD. All rights reserved.
//

#import "UIButton+Parameter.h"
#import <objc/runtime.h>
static const void *UIButtonParameterKey = &UIButtonParameterKey;
@implementation UIButton (Parameter)

-(void)bindParameter:(id)parameter{
    objc_setAssociatedObject(self, UIButtonParameterKey, parameter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
-(instancetype)getParameter{
    id  result = objc_getAssociatedObject(self, UIButtonParameterKey);
    return result;
}
//-(id)instance{
//    id  result = objc_getAssociatedObject(self, UIButtonParameterKey);
//    return result;
//}
@end
