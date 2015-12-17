//
//  CustomKVO1ViewController.m
//  TEST11
//
//  Created by dongjl on 15/12/16.
//  Copyright © 2015年 djl. All rights reserved.
//http://blog.csdn.net/kesalin/article/details/8194240

//当某个类的对象第一次被观察时，系统就会在运行期动态地创建该类的一个派生类，在这个派生类中重写基类中任何被观察属性的 setter 方法。

//派生类在被重写的 setter 方法实现真正的通知机制，就如前面手动实现键值观察那样。这么做是基于设置属性会调用 setter 方法，而通过重写就获得了 KVO 需要的通知机制。当然前提是要通过遵循 KVO 的属性设置方式来变更属性值，如果仅是直接修改属性对应的成员变量，是无法实现 KVO 的。
//
//同时派生类还重写了 class 方法以“欺骗”外部调用者它就是起初的那个类。然后系统将这个对象的 isa 指针指向这个新诞生的派生类，因此这个对象就成为该派生类的对象了，因而在该对象上对 setter 的调用就会调用重写的 setter，从而激活键值通知机制。此外，派生类还重写了 dealloc 方法来释放资源。


#import "CustomKVO1ViewController.h"
#import <objc/runtime.h>

#import "Target.h"
#import "Observer.h"
#import "Foo.h"
#import "TargetWrapper.h"
@interface CustomKVO1ViewController ()
@property (nonatomic,strong) Foo* anything;
@property (nonatomic,strong) Foo* x;
@property (nonatomic,strong) Foo* y;
@property (nonatomic,strong) Foo* xy;
@property (nonatomic,strong) Foo* control;

@end

@implementation CustomKVO1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static NSArray * ClassMethodNames(Class c)
{
    NSMutableArray * array = [NSMutableArray array];
    
    unsigned int methodCount = 0;
    Method * methodList = class_copyMethodList(c, &methodCount);
    unsigned int i;
    for(i = 0; i < methodCount; i++) {
        [array addObject: NSStringFromSelector(method_getName(methodList[i]))];
    }
    
    free(methodList);
    
    return array;
}

static void PrintDescription(NSString * name, id obj)
{
    NSString * str = [NSString stringWithFormat:
                      @"\n\t%@: %@\n\tNSObject class %s\n\tlibobjc class %s\n\timplements methods <%@>",
                      name,
                      obj,
                      class_getName([obj class]),
                      class_getName(object_getClass(obj)),
                      [ClassMethodNames(object_getClass(obj)) componentsJoinedByString:@", "]];
    NSLog(@"%@", str);
}

- (void)test
{
    
   
        
    // KVO demo
    //
    Observer * observer = [[Observer alloc] init];
    
    Target * target = [[Target alloc] init];
    [target addObserver:observer
             forKeyPath:@"age"
                options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                context:(__bridge void * _Nullable)([Target class])];
    
    [target setAge:30];
    //[target setValue:[NSNumber numberWithInt:30] forKey:@"age"];
    
    [target removeObserver:observer forKeyPath:@"age"];
    
    
    TargetWrapper * wrapper = [[TargetWrapper alloc] init:target];
    [wrapper addObserver:observer
              forKeyPath:@"information"
                 options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                 context:(__bridge void * _Nullable)([TargetWrapper class])];
    
    [target setGrade:1];
    [wrapper removeObserver:observer forKeyPath:@"information"];
    
    // Deep into KVO
    //
    self.anything = [[Foo alloc] init];
    self.x = [[Foo alloc] init];
    self.y = [[Foo alloc] init];
    self.xy = [[Foo alloc] init];
    self.control = [[Foo alloc] init];
    
    [self.x addObserver:self.anything forKeyPath:@"x" options:0 context:NULL];
    [self.y addObserver:self.anything forKeyPath:@"y" options:0 context:NULL];
    
    [self.xy addObserver:self.anything forKeyPath:@"x" options:0 context:NULL];
    [self.xy addObserver:self.anything forKeyPath:@"y" options:0 context:NULL];
    
    PrintDescription(@"control", self.control);
    PrintDescription(@"x", self.x);
    PrintDescription(@"y", self.y);
    PrintDescription(@"xy", self.xy);
    
    NSLog(@"\n\tUsing NSObject methods, normal setX: is %p, overridden setX: is %p\n",
          [self.control methodForSelector:@selector(setX:)],
          [self.x methodForSelector:@selector(setX:)]);
    NSLog(@"\n\tUsing libobjc functions, normal setX: is %p, overridden setX: is %p\n",
          method_getImplementation(class_getInstanceMethod(object_getClass(self.control),
                                                           @selector(setX:))),
          method_getImplementation(class_getInstanceMethod(object_getClass(self.x),
                                                           @selector(setX:))));
    
}


@end
