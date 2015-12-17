//
//  NSObject+LXD_KVO.m
//  LXD_KeyValueObserveDemo
//
//  Created by linxinda on 15/3/15.
//  Copyright (c) 2015年 Personal. All rights reserved.
//

#import "NSObject+LXD_KVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

//http://www.csdn.net/article/2015-07-06/2825133-objective-c-runtime/3
//typedef struct objc_method *Method;
//struct objc_method {
//    SEL method_name                                          OBJC2_UNAVAILABLE;
//    char *method_types                                       OBJC2_UNAVAILABLE;
//    IMP method_imp                                           OBJC2_UNAVAILABLE;
//}

//其实Method就是一个指向objc_method结构体指针，它存储了方法名(method_name)、方法类型(method_types)和方法实现(method_imp)等信息。而method_imp的数据类型是IMP，它是一个函数指针


//Ivar表示类中的实例变量，在runtime.h文件中找到它的定义：
/// An opaque type that represents an instance variable.
//typedef struct objc_ivar *Ivar;
//
//struct objc_ivar {
//    char *ivar_name                                          OBJC2_UNAVAILABLE;
//    char *ivar_type                                          OBJC2_UNAVAILABLE;
//    int ivar_offset                                          OBJC2_UNAVAILABLE;
//#ifdef __LP64__
//    int space                                                OBJC2_UNAVAILABLE;
//#endif
//}

//iMP本质上就是一个函数指针，指向方法的实现，在objc.h找到它的定义：
///// A pointer to the function of a method implementation.
//#if !OBJC_OLD_DISPATCH_PROTOTYPES
//typedef void (*IMP)(void /* id, SEL, ... */ );
//#else
//typedef id (*IMP)(id, SEL, ...);
//#endif

//顾名思义，Cache主要用来缓存，那它缓存什么呢？我们先在runtime.h文件看看它的定义：
//
//[cpp] view plaincopy
//typedef struct objc_cache *Cache                             OBJC2_UNAVAILABLE;
//
//struct objc_cache {
//    unsigned int mask /* total = mask + 1 */                 OBJC2_UNAVAILABLE;
//    unsigned int occupied                                    OBJC2_UNAVAILABLE;
//    Method buckets[1]                                        OBJC2_UNAVAILABLE;
//};
//Cache其实就是一个存储Method的链表，主要是为了优化方法调用的性能。当对象receiver调用方法message时，首先根据对象receiver的isa指针查找到它对应的类，然后在类的methodLists中搜索方法，如果没有找到，就使用super_class指针到父类中的methodLists查找，一旦找到就调用方法。如果没有找到，有可能消息转发，也可能忽略它。但这样查找方式效率太低，因为往往一个类大概只有20%的方法经常被调用，占总调用次数的80%。所以使用Cache来缓存经常调用的方法，当调用方法时，优先在Cache查找，如果没有找到，再到methodLists查找。

//更改当前类的isa指针，定义一个子类继承当前类原来的isa指针
//as prefix string of kvo class
static NSString * const kLXDkvoClassPrefix = @"LXDObserver_";
static NSString * const kLXDkvoAssiociateObserver = @"LXDAssiociateObserver";

@interface LXD_ObserverInfo : NSObject

@property (nonatomic, weak) NSObject * observer;
@property (nonatomic, copy) NSString * key;
@property (nonatomic, copy) LXD_ObservingHandler handler;

@end





@implementation LXD_ObserverInfo

- (instancetype)initWithObserver: (NSObject *)observer forKey: (NSString *)key observeHandler: (LXD_ObservingHandler)handler
{
    if (self = [super init]) {
        
        _observer = observer;
        self.key = key;
        self.handler = handler;
    }
    return self;
}

@end



#pragma mark -- Debug Method
static NSArray * ClassMethodsName(Class class)
{
    NSMutableArray * methodsArr = [NSMutableArray array];
    
    unsigned methodCount = 0;
    Method * methodList = class_copyMethodList(class, &methodCount);
    for (int i = 0; i < methodCount; i++) {
        
        [methodsArr addObject: NSStringFromSelector(method_getName(methodList[i]))];
    }
    free(methodList);
    
    return methodsArr;
}



#pragma mark -- Transform setter or getter to each other Methods
static NSString * setterForGetter(NSString * getter)
{
    if (getter.length <= 0) { return nil; }
    NSString * firstString = [[getter substringToIndex: 1] uppercaseString];
    NSString * leaveString = [getter substringFromIndex: 1];
    
    return [NSString stringWithFormat: @"set%@%@:", firstString, leaveString];
}


static NSString * getterForSetter(NSString * setter)
{
    if (setter.length <= 0 || ![setter hasPrefix: @"set"] || ![setter hasSuffix: @":"]) {
        
        return nil;
    }
    
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString * getter = [setter substringWithRange: range];
    
    NSString * firstString = [[getter substringToIndex: 1] lowercaseString];
    getter = [getter stringByReplacingCharactersInRange: NSMakeRange(0, 1) withString: firstString];
    
    return getter;
}

//拦截setter事件 转向他
#pragma mark -- Override setter and getter Methods
static void KVO_setter(id self, SEL _cmd, id newValue)
{
    NSString * setterName = NSStringFromSelector(_cmd);
    NSString * getterName = getterForSetter(setterName);
    if (!getterName) {
        @throw [NSException exceptionWithName: NSInvalidArgumentException reason: [NSString stringWithFormat: @"unrecognized selector sent to instance %p", self] userInfo: nil];
        return;
    }
    
    id oldValue = [self valueForKey: getterName];
    struct objc_super superClass = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    [self willChangeValueForKey: getterName];
    //http://southpeak.github.io/blog/2014/11/09/objective-c-runtime-yun-xing-shi-zhi-liu-:shi-yi/
    void (*objc_msgSendSuperKVO)(void *, SEL, id) = (void *)objc_msgSendSuper;
    objc_msgSendSuperKVO(&superClass, _cmd, newValue);//最终调用是这个对象原来的isa的setter方法
    [self didChangeValueForKey: getterName];
    
    //获取所有监听回调对象进行回调
    NSMutableArray * observers = objc_getAssociatedObject(self, (__bridge const void *)kLXDkvoAssiociateObserver);
    for (LXD_ObserverInfo * info in observers) {
        if ([info.key isEqualToString: getterName]) {
            dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                info.handler(self, getterName, oldValue, newValue);
            });
        }
    }
}


static Class kvo_Class(id self)
{
    return class_getSuperclass(object_getClass(self));
}



#pragma mark -- NSObject Category(KVO Reconstruct)
@implementation NSObject (LXD_KVO)

- (void)LXD_addObserver:(NSObject *)observer forKey:(NSString *)key withBlock:(LXD_ObservingHandler)observedHandler
{
    //step 1 get setter method, if not, throw exception
    SEL setterSelector = NSSelectorFromString(setterForGetter(key));
    Method setterMethod = class_getInstanceMethod([self class], setterSelector);
    if (!setterMethod) {
        @throw [NSException exceptionWithName: NSInvalidArgumentException reason: [NSString stringWithFormat: @"unrecognized selector sent to instance %@", self] userInfo: nil];
        return;
    }
    Class observedClass = object_getClass(self);
    NSString * className = NSStringFromClass(observedClass);
    
    //如果被监听者没有LXDObserver_，那么判断是否需要创建新类
    if (![className hasPrefix: kLXDkvoClassPrefix]) {
        observedClass = [self createKVOClassWithOriginalClassName: className];
        object_setClass(self, observedClass);
    }
    
    
    //add kvo setter method if its class(or superclass)hasn't implement setter
    if (![self hasSelector: setterSelector]) {
        const char * types = method_getTypeEncoding(setterMethod);
        class_addMethod(observedClass, setterSelector, (IMP)KVO_setter, types);
    }
    
    
    //add this observation info to saved new observer
    LXD_ObserverInfo * newInfo = [[LXD_ObserverInfo alloc] initWithObserver: observer forKey: key observeHandler: observedHandler];
    NSMutableArray * observers = objc_getAssociatedObject(self, (__bridge void *)kLXDkvoAssiociateObserver);
    
    if (!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge void *)kLXDkvoAssiociateObserver, observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [observers addObject: newInfo];
}


- (void)LXD_removeObserver:(NSObject *)object forKey:(NSString *)key
{
    NSMutableArray * observers = objc_getAssociatedObject(self, (__bridge void *)kLXDkvoAssiociateObserver);
    
    LXD_ObserverInfo * observerRemoved = nil;
    for (LXD_ObserverInfo * observerInfo in observers) {
        
        if (observerInfo.observer == object && [observerInfo.key isEqualToString: key]) {
            
            observerRemoved = observerInfo;
            break;
        }
    }
    [observers removeObject: observerRemoved];
}


- (Class)createKVOClassWithOriginalClassName: (NSString *)className
{
    NSString * kvoClassName = [kLXDkvoClassPrefix stringByAppendingString: className];
    Class observedClass = NSClassFromString(kvoClassName);
    
    if (observedClass) { return observedClass; }
    
    //创建新类，并且添加LXDObserver_为类名新前缀
    Class originalClass = object_getClass(self);
    //定义子类继承originalClass

    Class kvoClass = objc_allocateClassPair(originalClass, kvoClassName.UTF8String, 0);
    //获取监听对象的class方法实现代码，然后替换新建类的class实现
    Method classMethod = class_getInstanceMethod(originalClass, @selector(class));
    const char * types = method_getTypeEncoding(classMethod);
    class_addMethod(kvoClass, @selector(class), (IMP)kvo_Class, types);
    objc_registerClassPair(kvoClass);
    return kvoClass;
}


- (BOOL)hasSelector: (SEL)selector
{
    Class observedClass = object_getClass(self);
    unsigned int methodCount = 0;
    Method * methodList = class_copyMethodList(observedClass, &methodCount);
    for (int i = 0; i < methodCount; i++) {
        
        SEL thisSelector = method_getName(methodList[i]);
        if (thisSelector == selector) {
            
            free(methodList);
            return YES;
        }
    }
    
    free(methodList);
    return NO;
}


@end
