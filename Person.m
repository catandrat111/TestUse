//
//  Person.m
//  TEST11
//
//  Created by 董金亮 on 15/8/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "Person.h"
#import "User.h"
#import <objc/runtime.h>
@implementation Person


//Objective-C对象的内存空间仅分配在“堆空间”（heap space）中，肯定是不会分配在“栈”（stack）上。 我们知道，“栈”的占用和回收是有严格的数据操作规则，简称“先入后出”。函数执行时，传入的变量（当然包括对象变量）会按照确定的序列规则自动压入“栈”（占有内存资源），函数执行结束时，这些变量又会按照相反的序列规则自动弹出（释放内存资源）。因此，我们可以看出，“栈”其实是无法实施“引用计数”机制的，Objective-C否定使用“栈”存储对象的设想。在语法上，Objective-C也无法像C++那样直接声明并创建一个对象变量，更无法直接操作该对象，Objective-C都是需要以类似C语言申请堆内存块的语法(alloc)那样创建一个对象变量，并且必须通过对象指针作为访问句柄，这跟C语言申请堆内存块非常类似。Objective-C这一“任性”的设计，也使得对象嵌套（一个对象作为另一个对象的成员变量）时，对象基于引用计数机制，其成员变量也必须递归地遵循引用计数机制。因为成员变量实际都是一枚枚对象指针，很可能是与其它对象共享同一个对象（指针都指向同一块内存），引用计数机制正是适合用于支持这种“共享”内存的管理。需要特别说明，如果可以 像C++那样创建一个对象变量做成员变量，那么该成员变量会被存储在该对象所在的一块连续内存块 ，该对象销毁时能够自动把成员变量的占有的内存块全部释放收回，这与引用计数的机制并不太符合，所以，在Objective-C中对象变量不被支持也进一步得到理解。

- (BOOL)isEqualToPerson:(Person *)person
{
    if (self == person)
    {
        return YES;
    }
    if (!([_name isEqualToString:person.name] || _name == person.name))
    {
        return NO;
    }
    
    if (!([_age isEqualToNumber:person.age] || _age == person.age))
    {
        return NO;
    }
    
    return YES;
    
}

- (BOOL)isEqual:(id)object
{
    if ([self class] == [object class])
    {
        return [self isEqualToPerson: (Person *)object];
    }
    else
    {
        return [super isEqual:object];
    }
}

- (NSUInteger)hash
{
    return [_name hash] ^ [_age hash];
}


-(void)dealloc{
    
}

void dynamicMethodIMP(id self, SEL _cmd)
{
    printf("SEL %s did not exist\n",sel_getName(_cmd));
}
//当某个对象不能接受某个selector时，向对象所属的类动态添加所需的selector：
//这个函数与forwardingTargetForSelector类似，都会在对象不能接受某个selector时触发，执行起来略有差别。前者的目 的主要在于给客户一个机会来向该对象添加所需的selector，后者的目的在于允许用户将selector转发给另一个对象。另外触发时机也不完全一 样，该函数是个类函数，在程序刚启动，界面尚未显示出时，就会被调用。

//在类不能处理某个selector的情况下，如果类重载了该函数，并使用class_addMethod添加了相应的selector，并返回YES，那么后面forwardingTargetForSelector 就不会被调用，如果在该函数中没有添加相应的selector，那么不管返回什么，后面都会继续调用 forwardingTargetForSelector，如果在forwardingTargetForSelector并未返回能接受该 selector的对象，那么resolveInstanceMethod会再次被触发，这一次，如果仍然不添加selector，程序就会报异常
+ (BOOL) resolveInstanceMethod:(SEL)aSEL
{
    if (aSEL == @selector(userTest))
    {
        class_addMethod([self class], aSEL, (IMP) dynamicMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:aSEL];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
//    if (aSelector == @selector(uppercaseString))
//    {
//        return@"hello world";
//    }
//    else return [super forwardingTargetForSelector: aSelector];
    
    User *none = [[User alloc] init];
    if ([none respondsToSelector: aSelector]) {
        return none;
    }
    
    return [super forwardingTargetForSelector: aSelector];
}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSString *sel = NSStringFromSelector(selector);
    if ([sel rangeOfString:@"set"].location == 0) {
        //动态造一个 setter函数
        return [NSMethodSignature signatureWithObjCTypes:"v@:@:@"]; //v代表返回void，@：代表方法 后面再接@表示参数
    } else {
        //动态造一个 getter函数
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];//第一个@表示有返回值
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    //拿到函数名
    NSString *key = NSStringFromSelector([invocation selector]);
    if ([key rangeOfString:@"set"].location == 0) {
        //setter函数形如 setXXX: 拆掉 set和冒号
        key = [[key substringWithRange:NSMakeRange(3, [key length]-4)] lowercaseString];
        NSString *obj;
        //从参数列表中找到值
        [invocation getArgument:&obj atIndex:3];
        NSLog(@"%@",obj);
    } else {
        //getter函数就相对简单了，直接把函数名做 key就好了。
        NSString *obj = @"forwardInvocation";
        [invocation setReturnValue:&obj];
    }
}

//NSConcreteGlobalBlock 全局的静态block，不会访问任何外部变量。

//_NSConcreteStackBlock 保存在栈中的block，当函数返回时会被销毁。

//_NSConcreteMallocBlock 保存在堆中的block，当引用计数为0时会被销毁。


typedef void (^dBlock)();

dBlock exampleD_getBlock() {
    char d = 'D';
    dBlock db = ^{
        printf("%c\n", d);
    };

    return db;
}

void exampleD() {
    dBlock db = exampleD_getBlock();
    db();
}


- (void)printmethod {
    u_int               count;
    Method*    methods= class_copyMethodList([UIView class], &count);
    for (int i = 0; i < count ; i++)
    {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString  stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strName);
    }
}


- (void)printProperty {
    u_int               count;
    objc_property_t*    properties= class_copyPropertyList([UIView class], &count);
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        NSString *strName = [NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strName);
    }

}

- (void)blocktest {
    exampleD();
}


//解释NSInvocation
- (void)invocationTest{
    Person *myClass = [[Person alloc] init];
    NSString *myString = @"My string";
    
    //普通调用
    // NSString *normalInvokeString = [myClass appendMyString:myString age:5];
    NSString *normalInvokeString = [myClass appendTestMyString:myString];
    NSLog(@"The normal invoke string is: %@", normalInvokeString);
    
    //NSInvocation调用
    SEL mySelector = @selector(appendTestMyString:);
    NSMethodSignature * sig = [[myClass class] instanceMethodSignatureForSelector: mySelector];
    
    NSInvocation * myInvocation = [NSInvocation invocationWithMethodSignature: sig];
    [myInvocation setTarget: myClass];
    [myInvocation setSelector: mySelector];
    
    [myInvocation setArgument: &myString atIndex: 2];
    
    NSString * result = nil;
    [myInvocation retainArguments];
    [myInvocation invoke];
    [myInvocation getReturnValue: &result];
    NSLog(@"The NSInvocation invoke string is: %@", result);
}

@end

@implementation PersonModel



@end

@implementation Personsubmodel



@end
