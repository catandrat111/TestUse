//
//  UsageViewController.m
//  TEST11
//
//  Created by 董金亮 on 15/8/4.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "UsageViewController.h"
#import "User.h"
#import <objc/runtime.h>
#import "NSNull+XY_InternalNullExtention.h"
@interface UsageViewController ()
@property(strong,nonatomic) NSMutableArray* array;
@end

@implementation UsageViewController
+ (void)load
{
    [super load];
    [self registerClassPair];
}

+ (void)registerClassPair
{
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);
    class_addMethod(newClass, @selector(testMetaClass), (IMP)TestMetaClass, "v@:");
    objc_registerClassPair(newClass);
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    [instance performSelector:@selector(testMetaClass)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray new];
    User* user1 = [User new];
    user1.age = @(10);
    user1.name = @"g";
   
    [self.array addObject:user1];
    
    
    User* user2 = [User new];
    user2.age = @(1);
    user2.name = @"d";
    [self.array addObject:user2];
    
    User* user3 = [User new];
    user3.age = @(11);
    user1.name = @"v";
    [self.array addObject:user3];
    
    Person* p1 = [Person new];
    p1.name = @"S";
    p1.age = @(3);
    p1.test = @"ddd";
    p1.sex = @(7);
    
   // NSMutableArray* deepArr = [[NSMutableArray alloc] initWithArray:self.array copyItems:YES];
  //  NSLog(@"%@",deepArr);
   
    NSMutableArray *deepArr1 = [self.array mutableCopy];
    User* u2 = deepArr1[0];
    NSLog(@"%@",u2);
    user1.name = @"ddd";
    NSMutableArray *deepArr2 = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject: self.array]];
    NSLog(@"%@",deepArr2);
    
    User* user4 = [User new];
    user4.age = @(11);
    user4.name = @"v";
    [self.array addObject:user4];

    [self copyTest];
    [self TestMetaClass1];
    [self methodTransmit1];
    [self methodTransmit2];
    [self methodTransmit3];
    [p1 blocktest];
    
    
    NSDictionary *dict = @{
        @"名字":@"漂亮妹子",
        @"备胎们":[NSNull null],
        @"年纪":@(1)
    };
    
    NSArray *arr = dict[@"备胎们1"];
    
    UXY_EXPECTED( ((NSArray *)[NSNull null])[1] == nil );

 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(IBAction)sortAction:(id)sender{
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES],[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    NSArray *sortedArray =  [self.array sortedArrayUsingDescriptors:sortDescriptors];
    NSLog(@"%@",sortedArray);
    
    //第二种用法
    NSArray *sortedArray1 = [self.array sortedArrayUsingComparator:^NSComparisonResult(User *user1, User *user2){
        return [user1.age compare:user2.age];
        
    }];
    NSLog(@"%@",sortedArray1);
    
    //第三种用法
    NSArray *sortedArray2 = [self.array sortedArrayUsingSelector:@selector(compare:)];
     NSLog(@"%@",sortedArray2);
    
}


-(IBAction)quchongAction:(id)sender{
    NSArray *result1 = [self.array valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"%@",result1);
    //只想返回一个由user数组中的姓名组成的不重复的新数组
    NSArray *result2 = [self.array valueForKeyPath:@"@distinctUnionOfObjects.name"];
    NSLog(@"%@",result2);
    
}

- (IBAction)filterAction:(id)sender{
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"((age >= %@) AND (age < %@))",@2,@30];
    NSArray *result1 = [self.array filteredArrayUsingPredicate:predicate1];

    NSLog(@"%@",result1);
    
    //第二种
    NSPredicate *predicate2 = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        
        return  [((User *)evaluatedObject).age integerValue] >= 2 && [((User *)evaluatedObject).age integerValue]<= 30;
        
    }];
    
    NSArray *result2 = [self.array filteredArrayUsingPredicate:predicate2];
    NSLog(@"%@",result2);
}

- (void)keychainMethod{
    //跟程序的bundleid有关  如果id变了 uuid换成新的  如果两个id属于一个组 一个已保存，另一个则有相同的uuid
    //组 target -> capabllity -> share key -> 添加组
    NSString* uuid = [UIDevice  getUDID];
    DLog(@"%@",uuid);

    //6EAA3C6E-3DC6-4F52-B57A-6C29041C33CE//com.test com.test.b com.test8 --- bundle id
    /*
    <key>Entitlements</key>
    <dict>
    <key>application-identifier</key>
    <string>A1B2C3D4E5.com.example.MyApp</string>
    <key>get-task-allow</key>
    <false/>
    <key>keychain-access-groups</key> //授予客户端访问app的权限  可以访问钥匙串 
    <array>
    <string>A1B2C3D4E5.*</string>
    </array>
    </dict>
    
    codesign -d --entitlements - Foo.app/Foo | vis (查看entitlement)
     */

}

- (void)copyTest{
    User* user  = [User new];
    user.name = @"as";
    user.age = @(20);
    
    User* userCopy = [user copy];
    NSLog(@"%@",userCopy);
    
    
    NSArray *n = [[NSArray alloc] initWithObjects:[NSMutableString                  stringWithString:@"123"],@"456", nil];
    
    NSMutableArray *n1 = [n copyWithZone:nil];
    
    NSMutableArray *n2  = [n mutableCopyWithZone:nil];
    
    NSArray *n3 = [[NSArray alloc] initWithArray:n copyItems:NO];
    
    NSArray *n4 = [[NSArray alloc] initWithArray:n copyItems:YES];
    
    NSArray *n5 = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject: n]];
    
    NSLog(@"Array n = %@", n);
    NSLog(@"Array n1 = %@", n1);
    NSLog(@"Array n2 = %@", n2);
    NSLog(@"Array n3 = %@", n3);
    NSLog(@"Array n4 = %@", n4);
    NSLog(@"Array n5 = %@", n5);
    
    NSMutableString *nstr1 = [n objectAtIndex:0];
   // [nstr1 appendString:@"abc"];
    nstr1 = [[NSMutableString alloc] initWithString:@"123455"];
    
    [n2 addObject:@"xxx"];
    
    NSLog(@"Array n = %@", n);
    NSLog(@"Array n1 = %@", n1);
    NSLog(@"Array n2 = %@", n2);
    NSLog(@"Array n3 = %@", n3);
    NSLog(@"Array n4 = %@", n4);
    NSLog(@"Array n5 = %@", n5);
    
}

//meta-class是一个类对象的类当向一个对象发送消息时，runtime会在这个对象所属的这个类的方法列表中查找方法；而向一个类发送消息时，会在这个类的meta-class的方法列表中查找。meta-class之所以重要，是因为它存储着一个类的所有类方法。每个类都会有一个单独的meta-class，因为每个类的类方法基本不可能完全相同。

//运行时创建了一个NSError的子类TestClass，然后为这个子类添加一个方法testMetaClass，这个方法的实现是TestMetaClass函数。
void TestMetaClass(id self, SEL _cmd) {
    NSLog(@"This objcet is %p", self);
    NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
    Class currentClass = [self class];
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
         currentClass = objc_getClass((__bridge void *)currentClass);
       // currentClass = [currentClass class];//无法获取metaclass 只能得到自己
    }
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", objc_getClass((__bridge void *)[NSObject class]));
}

//typedef struct objc_class *Class;
/*
struct objc_class {
    Class isa; // 指向metaclass（metaclass 后面解释）
    Class super_class ;   // 指向其父类
    const charchar *name ;	// 类名
    long version ;	// 类的版本信息，初始化默认为0，可以通过runtime函数class_setVersion和class_getVersion进行修改、读取
    long info;   // 一些标识信息
    long instance_size ;   // 该类的实例变量大小(包括从父类继承下来的实例变量);
    struct objc_ivar_list *ivars;   // 成员变量链表，通过ivars可以访问所有的成员变量
    struct objc_method_list **methodLists ;   // 存储类的方法链表
    struct objc_cache *cache;   // 指向最近使用的方法列表，用于提升运行效率；
    struct objc_protocol_list *protocols;   // 协议链表
}
 Use `Class` instead of `struct objc_class */
//struct objc_object {
//Class isa  OBJC_ISA_AVAILABILITY;
//};
//typedef struct objc_object *id;

-(void)TestMetaClass1{
    NSLog(@"This objcet is %p", self);
    NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
    Class currentClass = [self class];
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = objc_getClass((__bridge void *)currentClass);
        // currentClass = [currentClass class];//无法获取metaclass 只能得到自己
    }

}

//当某个对象不能接受某个selector时，将对该selector的调用转发给另一个对象
// forwardingTargetForSelector是NSObject的函数，用户可以在派生类中对其重载,从而将无法处理的selector转 发给另一个对象。还是以上面的uppercaseString为例，如果用户自己定义的CA类的对象a，没有uppercaseString这样一个实例 函数，那么在不调用respondSelector的情况下，直接执行[a performSelector:@selector"uppercaseString"],那么执行时一定会crash，此时，如果CA实现了 forwardingTargetForSelector函数，并返回一个NSString对象，那么就相对于对该NSString对象执行了 uppercaseString函数，此时就不会crash了。当然实现这个函数的目的并不仅仅是为了程序不crash那么简单，在实现装饰者模式时，也 可以使用该函数进行消息转发
- (void)methodTransmit2 {
    Person* p1 = [Person new];
    NSString * s = [p1 performSelector:@selector(uppercaseString)];
    NSLog(@"%@",s);
}


- (void)methodTransmit1 {
     Person* p1 = [Person new];
    [p1 performSelector:@selector(userTest)];
}

- (void)methodTransmit3 {
    Person* p1 = [Person new];
    [p1 performSelector:@selector(setPersonName:)withObject:@"NAME" withObject:@"name"];
    NSString* result = [p1 performSelector:@selector(getPersonName:)];
    NSLog(@"%@",result);
}

@end
