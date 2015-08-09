//
//  Person+GHAssociatedObject.m
//  TEST11
//
//  Created by 董金亮 on 15/8/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//


//不应该用 objc_removeAssociatedObjects() 来删除对象的属性，因为可能会导致其他客户对其添加的属性也被移除了。规范的方法是：调用 objc_setAssociatedObject 方法并传入一个 nil 值来清除一个关联。
//应该小心使用对象关联，不要滥用，因为可能会引起难以调试的bug。

#import "Person+GHAssociatedObject.h"
#import <objc/runtime.h>
static char weightKey;

@implementation Person (GHAssociatedObject)
@dynamic weight;

- (void)setWeight:(NSNumber *)weight
{
    objc_setAssociatedObject (self,&weightKey,weight,OBJC_ASSOCIATION_RETAIN);
    
}

- (NSNumber *)weight
{
    return (NSNumber *)objc_getAssociatedObject(self, &weightKey);
}
@end
