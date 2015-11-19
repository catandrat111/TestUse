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
#import "NSInvocation+Improved.h"
#import "UserList.h"
#import "NSDecimalNumber+Extensions.h"
#import "NSNumber+Round.h"
#import "DateTools.h"
#import "NSDate+Utilities.h"
#import "FBKVOController.h"
int global_val = 1;
static int static_global_val = 2;
@interface UsageViewController ()
@property(strong,nonatomic) NSMutableArray* array;

@property(strong,nonatomic) User* observeUser;
@property (strong,nonatomic) FBKVOController* KVOController;
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
    char* aaa = @encode(Class);
    NSLog(@"%@",[NSString stringWithUTF8String:aaa]);
    self.array = [NSMutableArray new];
    User* user1 = [User new];
    user1.age = @(10);
    user1.name = @"u1";
   
    [self.array addObject:user1];
    
    
    User* user2 = [User new];
    user2.age = @(1);
    user2.name = @"u2";
    [self.array addObject:user2];
    
    User* user3 = [User new];
    user3.age = @(11);
    user1.name = @"u3";
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
    user4.name = @"u4";
    [self.array addObject:user4];

//    [self copyTest];
//    [self TestMetaClass1];
//    [self methodTransmit1];
//    [self methodTransmit2];
//    [self methodTransmit3];
//    [p1 blocktest];
   
    
    
    NSDictionary *dict = @{
        @"名字":@"漂亮妹子",
        @"备胎们":[NSNull null],
        @"年纪":@(1)
    };
    
  //  NSArray *arr = dict[@"备胎们1"];
    [self invocationTest];
    [self commonOperation];
    [self improvedOperation];
   
    self.observeUser = [User new];
    self.observeUser.name = @"sdfvgfs";
    self.observeUser.age = @(10);
;
    //:NSKeyValueObservingOptionOld 带就值 NSKeyValueObservingOptionNew 带新值
    //[self.observeUser addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld  context:nil];
   // [self.observeUser addObserver:self forKeyPath:@"age" options: NSKeyValueObservingOptionNew context:nil];
    //NSKeyValueObservingOptionPrior 分2次调用。在值改变之前和值改变之后。 里面么有新旧值
    //NSKeyValueObservingOptionInitial 把初始化的值提供给处理方法，一旦注册，立马就会调用一次。通常它会带有新值，而不会带有旧值。
//    [self.observeUser addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionInitial  context:nil];
//    [self.observeUser addObserver:self forKeyPath:@"age" options: NSKeyValueObservingOptionPrior context:nil];
//    [self decimalTest];
//    [self numberTest];
//    [self arrayTest];
//    [self stringTest];
//    [self dateTest];
    
    
    
    [self dateTest1];
    [self vaFunc:@"var1",@"var2",@"var3",nil];
    [self observerTest];
    
    [self testblock1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [self.observeUser removeObserver:self forKeyPath:@"name"];
    [self.observeUser removeObserver:self forKeyPath:@"age"];

}


- (void) arrayTest {
    User* u1 = [User new];
    u1.age = @(21);
    u1.name = @"r4";
    
    User* u2 = [User new];
    u2.age = @(11);
    u2.name = @"u4";
    NSMutableArray * array = [NSMutableArray new];
    [array addObject:u1];
    [array addObject:u2];
    
     User* u2copy = [User copy];
    
    if ([array containsObject:u2copy]) {
        NSLog(@"have yes");
    }
    [array removeObject:u2copy];
    NSLog(@"%@",array);
   
}

- (NSInteger)giveMeFive {
    NSString *foo;
 #pragma unused (foo)
    return 5;
}

- (void)decimalTest{
    float testFloat = 2.689;
    NSDecimalNumber *decimal = [[NSDecimalNumber alloc]initWithFloat:testFloat];
    NSDecimalNumber *testFloat1 = [decimal roundToScale:2.0];
    NSLog(@"%@",testFloat1);
    
   NSDecimalNumber *testFloat2 = [decimal decimalNumberWithPercentage:100];
    NSLog(@"%@",testFloat1);
}

- (void)numberTest{
//    NSNumberFormatterNoStyle = kCFNumberFormatterNoStyle, [1243:403] Formatted number string:123456789
//    
//    NSNumberFormatterDecimalStyle = kCFNumberFormatterDecimalStyle,  [1243:403] Formatted number string:123,456,789
//    
//    NSNumberFormatterCurrencyStyle = kCFNumberFormatterCurrencyStyle, [1243:403] Formatted number string:￥123,456,789.00
//    
//    NSNumberFormatterPercentStyle = kCFNumberFormatterPercentStyle,  [1243:403] Formatted number string:-539,222,988%
//    
//    NSNumberFormatterScientificStyle = kCFNumberFormatterScientificStyle,   [1243:403] Formatted number string:1.23456789E8
//    
//    NSNumberFormatterSpellOutStyle = kCFNumberFormatterSpellOutStyle  [1243:403] Formatted number string:一亿二千三百四十五万六千七百八十九
    
//    [1243:403] Formatted number string:123456789
//    NSNumberFormatterRoundCeiling =
//    kCFNumberFormatterRoundCeiling,//四舍五入，原值2.7999999999,直接输出3
//    NSNumberFormatterRoundFloor =
//    kCFNumberFormatterRoundFloor,//保留小数输出2.8 正是想要的
//    NSNumberFormatterRoundDown =
//    kCFNumberFormatterRoundDown,//加上了人民币标志，原值输出￥2.8
//    NSNumberFormatterRoundUp =
//    kCFNumberFormatterRoundUp,//本身数值乘以100后用百分号表示,输出280%
//    NSNumberFormatterRoundHalfEven =
//    kCFNumberFormatterRoundHalfEven,//原值表示，输出2.799999999E0
//    NSNumberFormatterRoundHalfDown =
//    kCFNumberFormatterRoundHalfDown,//原值的中文表示，输出二点七九九九。。。。
//    NSNumberFormatterRoundHalfUp =
//    kCFNumberFormatterRoundHalfUp //原值中文表示，输出第三
    
    NSNumber *numTest = [NSNumber numberWithFloat:12342.45657];
    NSLog(@"%@", [numTest doCeilWithDigit:2]); //TEST11[3014:159534] 12342.46
     NSLog(@"%@", [numTest doFloorWithDigit:2]);//TEST11[3014:159534] 12342.45
     NSLog(@"%@", [numTest doRoundWithDigit:2]);//TEST11[3014:159534] 12342.46
    
    NSLog(@"%@", [numTest toDisplayNumberWithDigit:2]);// TEST11[3014:159534] 12,342.46
    NSLog(@"%@", [numTest toDisplayPercentageWithDigit:2]);//TEST11[3014:159534] 1,234,245.75%


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

//简单集合运算符共有@avg，@count，@max，@min，@sum
-(IBAction)quchongAction:(id)sender{
    //对象运算符 比集合运算符稍微复杂，能以数组的方式返回指定的内容，一共有两种：
//    @distinctUnionOfObjects
//    @unionOfObjects
    NSArray *result1 = [self.array valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"%@",result1);
    //只想返回一个由user数组中的姓名组成的不重复的新数组
    NSArray *result2 = [self.array valueForKeyPath:@"@distinctUnionOfObjects.name"];
    NSLog(@"%@",result2);
    //返回的元素是全集
    NSArray *result3 = [self.array valueForKeyPath:@"@unionOfObjects.name"];
    NSLog(@"%@",result3);
    
    //简单集合运算符共有@avg，@count，@max，@min，@sum
    //获取age的平均值
     NSNumber *averageAge = [self.array valueForKeyPath:@"@avg.age"];
     NSLog(@"%@",averageAge);
    
    //要获取transactions集合中元素数目可以这样：@count是这些集合运算符中比较特殊的一个，因为它没有右路经，原因很容易理解。
    NSNumber *numberOfArray = [self.array  valueForKeyPath:@"@count"];
    NSLog(@"%@",numberOfArray);
    
  //  Array和Set操作符
    //@distinctUnionOfArrays
   // @unionOfArrays
    //@distinctUnionOfSets
    
    NSMutableArray* arrays = [[NSMutableArray alloc] init];
    NSMutableArray* array1 = [NSMutableArray new];
    User *user = [User new];
    user.name = @"d";
    user.age = @(5);
    [array1 addObject:user];
    [arrays addObject:self.array];
    [arrays addObject:array1];
    NSArray *names = [arrays valueForKeyPath:@"@unionOfArrays.name"];
    NSLog(@"%@",names);

    NSArray *names1 = [self.array valueForKey:@"name"];
    NSLog(@"%@",names1);
    
    UserList* list = [UserList new];
    NSLog(@"The list prime is %@", list);
//    NSLog(@"The last prime is %@", [user.primes lastObject]);
//     NSLog(@"The last prime is %@", [user valueForKey:@"primes"]);
//    
//    NSLog(@"The last prime is %@", [[user contacts] lastObject]);
    
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


//解释NSInvocation
- (void)invocationTest{
    User *myClass = [[User alloc] init];
    NSString *myString = @"My string";
    
    //普通调用
   // NSString *normalInvokeString = [myClass appendMyString:myString age:5];
     NSString *normalInvokeString = [myClass appendTestMyString:myString];
    NSLog(@"The normal invoke string is: %@", normalInvokeString);

    //NSInvocation调用
    SEL mySelector = @selector(appendTestMyString:);
    NSMethodSignature * sig = [[myClass class] instanceMethodSignatureForSelector:mySelector];
     NSLog(@"%@",sig);
    NSInvocation * myInvocation = [NSInvocation invocationWithMethodSignature: sig];
    NSLog(@"%@",myInvocation);
    [myInvocation setTarget: myClass];
    [myInvocation setSelector: mySelector];

    [myInvocation setArgument: &myString atIndex: 2];

    [myInvocation retainArguments];
    [myInvocation invoke];
    
    //获得返回值类型
    const char *returnType = sig.methodReturnType;
    //声明返回值变量
   __autoreleasing id returnValue;//不加会报错returnValue会被释放  __autoreleasing
    //如果没有返回值，也就是消息声明为void，那么returnValue=nil
    if( !strcmp(returnType, @encode(void)) ){
        returnValue =  nil;
    }
    //如果返回值为对象，那么为变量赋值
    else if( !strcmp(returnType, @encode(id)) ){
        [myInvocation getReturnValue:&returnValue];
    }
    else{
        //如果返回值为普通类型NSInteger  BOOL
        
        //返回值长度
        NSUInteger length = [sig methodReturnLength];
        //根据长度申请内存
        void *buffer = (void *)malloc(length);
        //为变量赋值
        [myInvocation getReturnValue:buffer];
    
        if( !strcmp(returnType, @encode(BOOL)) ) {
            returnValue = [NSNumber numberWithBool:*((BOOL*)buffer)];
        }
        else if( !strcmp(returnType, @encode(NSInteger)) ){
            returnValue = [NSNumber numberWithInteger:*((NSInteger*)buffer)];
        }
        returnValue = [NSValue valueWithBytes:buffer objCType:returnType];
    }
    
   NSLog(@"The NSInvocation invoke string is: %@", returnValue);
    
}



- (void)commonOperation
{
    NSDate *date = [NSDate date];
    NSDictionary *user = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", nil];
    SEL method = @selector(fireTimer:andDate:);
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:method];
    NSLog(@"%@",signature);
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    NSLog(@"%@",invocation);
    [invocation setTarget:self];
    [invocation setSelector:method];
    [invocation setArgument:&user atIndex:2];
    [invocation setArgument:&date atIndex:3];
    //    [NSTimer scheduledTimerWithTimeInterval:0.1 invocation:invocation repeats:YES];
    [invocation invoke];
}

- (void)improvedOperation
{
    //1.创建一个没有参数的NSInvocation
    //    SEL selector = @selector(fireTimer:andDate:);
    //    NSInvocation *invocation = [NSInvocation invocationWithTarget:self andSelector:selector];
    
    //2.创建带有两个参数的NSInvocation
    NSDate *date = [NSDate date];
    NSDictionary *user = [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", nil];
    NSInvocation *invocation = [NSInvocation invocationWithTarget:self andSelector:@selector(fireTimer:andDate:) andArguments:&user, &date];
    [invocation invoke];
}

- (void)fireTimer:(NSDictionary *)user andDate:(NSDate *)startTime
{
    /*
     sleep 与 sleepForTimeInterval的区别
     sleep直接让线程停掉，sleepForTimeInterval是让runLoop停掉。比如说，你有2个APP，分别是A和B，A启动B，然后去取B的进程号，如果你用sleep等B启动再去取，你会发现取不到，因为你只是把代码加到runloop里面去，而runloop并没有执行到这句，sleep就直接让系统停在那里，所以取不到，而后者就没问题，因为它是让runloop执行到这句的时候停1s
     */
     NSLog(@"user: %@", user);
    [NSThread sleepForTimeInterval:2];
    NSTimeInterval timeInterval = -1 * [startTime timeIntervalSinceNow];
    NSString *timeStr = [NSString stringWithFormat:@"%.2f", timeInterval];
    NSLog(@"fireTime: %@", timeStr);
}


/**
 *  OBSERVE
 */
- (IBAction)observeLab:(id)sender {
    self.lab.text = @"asd";
    self.observeUser.name = @"test";
    self.observeUser.age = @(13);
    
    //手动触发
//    [self willChangeValueForKey:@"name"];
//    
//    self.observeUser.name = @"name1";
//    
//    [self didChangeValueForKey:@"name"];
    
}

- (void)observerTest {
    // create KVO controller with observer
    FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
    self.KVOController = KVOController;

    // observe clock date property
    __weak __typeof(self)weakSelf = self;
    [self.KVOController observe:self.observeUser keyPath:@"name" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew block:^(id observer, User *user, NSDictionary *change) {
        
        // update clock view with new value
        weakSelf.lab.text = change[NSKeyValueChangeNewKey];
    }];
    self.observeUser.name = @"test";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"%@",change);
       NSString* newstr =  [change objectForKey:NSKeyValueChangeNewKey];
       newstr = change[@"new"];
        NSLog(@"%@",newstr);
        NSString* oldstr =  [change objectForKey:NSKeyValueChangeOldKey];
        oldstr = change[@"old"];
         NSLog(@"%@",oldstr);
        self.lab.text = newstr;
    }
    
    if([keyPath isEqualToString:@"age"]){
        NSLog(@"%@",change);
        NSString* newstr =  [change objectForKey:NSKeyValueChangeNewKey];
        newstr = change[@"new"];
         NSLog(@"%@",newstr);
        NSString* oldstr =  [change objectForKey:NSKeyValueChangeOldKey];
        oldstr = change[@"old"];
         NSLog(@"%@",oldstr);
        
        NSString* priorStr =  [change objectForKey:NSKeyValueChangeNotificationIsPriorKey];
        NSLog(@"%@",priorStr);
    }
    
}

//- (void)observeValueForKeyPath:(NSString *)keyPath
//                      ofObject:(id)object
//                        change:(NSDictionary *)change
//                       context:(void *)context
//{
//    if (context == &PrivateKVOContext) {
//        
//        // 这里写相关的观察代码
//    } else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}

//重新实现NSObject类中的automaticallyNotifiesObserversForKey:方法，返回yes表示自动通知。
//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString*)key
//
//{
//    
//    //当这两个值改变时，使用自动通知已注册过的观察者，观察者需要实现observeValueForKeyPath:ofObject:change:context:方法
//    if ([key isEqualToString:@"name"])
//        
//    {
//        
//        return NO;
//        
//    }
//    
//    return [super automaticallyNotifiesObserversForKey:key];
//    
//} 



- (void)stringTest {
    NSString *s1 = @"The weather on \U0001F30D is \U0001F31E today.";
    // The weather on 🌍 is 🌞 today.
    NSRange fullRange = NSMakeRange(0, [s1 length]);
    [s1 enumerateSubstringsInRange:fullRange
                          options:NSStringEnumerationByComposedCharacterSequences
                       usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
    {
        NSLog(@"%@ %@", substring, NSStringFromRange(substringRange));
    }];
    
    NSString *s = @"\u00E9"; // é
    NSString *t = @"e\u0301"; // e + ´
    BOOL isEqual = [s isEqualToString:t];
    NSLog(@"%@ is %@ to %@", s, isEqual ? @"equal" : @"not equal", t);
    // => é is not equal to é
    
    // Normalizing to form C
    NSString *sNorm = [s precomposedStringWithCanonicalMapping];
    NSString *tNorm = [t precomposedStringWithCanonicalMapping];
    BOOL isEqualNorm = [sNorm isEqualToString:tNorm];
    NSLog(@"%@ is %@ to %@", sNorm, isEqualNorm ? @"equal" : @"not equal", tNorm);
    // => é is equal to é
}

- (void)dateTest {
    NSDate* date = [NSDate date];
    NSString * dateStr = [date formattedDateWithStyle: NSDateFormatterFullStyle];//2015年10月12日 星期一
    
    NSLog(@"%@", dateStr);
    
    dateStr =  [date formattedDateWithFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSLog(@"%@", dateStr);
    NSString* str = @"2014";
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSDate* date1 = [formatter dateFromString:str];
    date1 = [date dateBySubtractingYears:1];
    NSInteger yearsApart = [date yearsFrom:date1];
    NSInteger hoursApart = [date monthsFrom:date1];
    NSInteger h1 = date.hour;
    NSInteger m1 = date.minute;

    NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSinceNow:-4];
    NSLog(@"Time Ago: %@", timeAgoDate.timeAgoSinceNow);
    NSLog(@"Time Ago: %@", timeAgoDate.shortTimeAgoSinceNow);
    
    NSInteger oldYear = date.year;
    
    NSDate *newDate = [date dateByAddingYears:1];
    NSInteger newYear = newDate.year;
    
    NSLog(@"oldYear: %ld newYear: %ld", (long)oldYear, (long)newYear); // 输出: oldYear: 2015 newYear: 2016
    
    // 创建一个时间段,从现在开始,共5个小时.
    DTTimePeriod *timePeriod = [DTTimePeriod timePeriodWithSize:DTTimePeriodSizeHour amount:5 startingAt:[NSDate date]];
    DTTimePeriod *timePeriod1 = [[DTTimePeriod alloc] initWithStartDate:date endDate: [date dateByAddingDays: 10]];
    
    NSLog(@"相差 %g 天", [timePeriod1 durationInDays]); // 输出: 相差 10 天
}

- (void)dateTest1 {
    NSDate* date1 = [NSDate date];
    NSDate* other = [date1 dateByAddingHours:2];
    BOOL b1 = [date1 isEqualToDate:other];

    NSLog(@"b1:%@",@(b1));
    
    BOOL b2 = [date1 isEqualToDateIgnoringTime:other];
    NSLog(@"b2:%@",@(b2));
}

- (void)vaFunc:(NSObject*)string,... {
    va_list args;
    va_start(args, string);
    NSMutableArray *mArray = [@[string] mutableCopy];
        
    for ( ;; )
    {
        id tempSpec = va_arg( args, id );
        if (tempSpec == nil)
            break;
        [mArray addObject:tempSpec];
        NSLog(@"%@",mArray);
    }
    NSLog(@"%@",mArray);
    va_end(args);
}

- (void)testblock1 {
    static int static_val = 3;
    void (^blk)(void) = ^(void) {
        global_val *= 2;
        static_global_val *= 3;
        static_val *= 4;
        
        NSLog(@"global_val:%d,static_global_val:%d,static_val:%d",global_val,static_global_val,static_val);
    };//2015-11-18 15:09:07.947 TEST11[5447:175041] global_val:2,static_global_val:6,static_val:12
    
    blk();
    
    NSLog(@"%@",blk);//TEST11[5550:184349] <__NSGlobalBlock__: 0x10685fd50>


}


@end
