//
//  ZOCNewsViewController.m
//  TEST11
//
//  Created by dongjl on 15/9/29.
//  Copyright © 2015年 djl. All rights reserved.
//

#import "ZOCNewsViewController.h"
NSString *const ZOCNewsViewControllerDidClearCacheNotification = @"fff";
@interface ZOCNewsViewController ()
@property (nonatomic, strong) NSMutableArray *mutableElements;

@end
//NSString ,NSArray ,NSURLRequest 有可变的话 属性用copy
@implementation ZOCNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//自定义初始化
//不需要重载任何初始化函数
//重载designated initializer
//定义一个新的designated initializer
- (id)initWithNews:(ZOCNews *)news {
    // call to the immediate superclass's designated initializer 􏰺调􏱂􏱽􏱻􏴋类􏰙 designated initializer􏰽
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _news = news;
    }
    return self;
}

// Override the immediate superclass's designated initializer 􏰺􏰜载􏱽􏱻􏶗类􏰙 designated initializer􏰽
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // call the new designated initializer
    return [self initWithNews:nil];
}


- (NSArray *)elements {
    return [self.mutableElements copy];
}

//lazy loading
//- (NSDateFormatter *)dateFormatter {
//    if (!_dateFormatter) {
//    _dateFormatter = [[NSDateFormatter alloc] init];
//    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
//        [_dateFormatter setLocale:enUSPOSIXLocale];
//    [_dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];//􏷃􏸠􏰄SSS􏰫􏱏􏱛SSSSS
//}
//    return _dateFormatter;
//}

//￼￼￼￼- (void)someMethod {
//    if (![someOther boolValue]) {
//        return;
//    }
//    //Do something important
//}

////不推荐
//- (void)someMethod {
//    if ([someOther boolValue]) {
//        //Do something important
//    } }


//BOOL nameContainsSwift = [sessionName containsString:@"Swift"];
//BOOL isCurrentYear = [sessionDateCompontents year] == 2014;
//BOOL isSwiftSession = nameContainsSwift && isCurrentYear;
//if (isSwiftSession) {
//    // Do something very cool
//}

//推荐
//result = object ? : [self createObject];
//不推荐
//result = object ? object : [self createObject];

//错误处理
//￼NSError *error = nil;
//if (![self trySomethingWithError:&error]) {
//    // Handle Error
//}
//一些苹果的api在成功的情况下会对error参数（如果它非null）写入垃圾值，所以检查error的值可能导致错误

//switch (condition) {
//    case 1:
//        // ...
//    break;
//    case 2: {
//            // ...
//            // Multi-line example using braces break;
//        }
//    case 3:
//        // ...
//        break; default:
//        // ...
//    break;
//}

//switch (menuType) {
//    case ZOCEnumNone:
//        // ...
//        break;
//    case ZOCEnumValue1:
//        // ...
//        break;
//    case ZOCEnumValue2:
//        // ...
//    break;
//}

//￼typedef NS_ENUM(NSUInteger, ZOCMachineState) {
//    ZOCMachineStateNone,
//    ZOCMachineStateIdle,
//    ZOCMachineStateRunning,
//    ZOCMachineStatePaused
//};

//UIButton *settingsButton;
//static const NSTimeInterval ZOCSignInViewControllerFadeOutAnimationDuration = 0.4;
//static NSString * const ZOCCacheControllerDidClearCacheNotification = @"ZOCCacheControllerDidClearCacheNotification";
//static const CGFloat ZOCImageThumbnailHeight = 50.0f;


//推荐
//- (void)setExampleText:(NSString *)text image:(UIImage *)image;
//- (void)sendAction:(SEL)aSelector to:(id)anObject forAllCells:(BOOL)flag; - (id)viewWithTag:(NSInteger)tag;
//- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height;

//不推荐
//- (void)setT:(NSString *)text i:(UIImage *)image;
//- (void)sendAction:(SEL)aSelector :(id)anObject :(BOOL)flag;
//- (id)taggedView:(NSInteger)tag;
//- (instancetype)initWithWidth:(CGFloat)width andHeight:(CGFloat)height; - (instancetype)initWith:(int)width and:(int)height; // Never do this.

//推荐
//NSArray *names = @[@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul"];
//NSDictionary *productManagers = @{@"iPhone" : @"Kate", @"iPad" : @"Kamal", @"Mobile Web" : @"Bill"}; NSNumber *shouldUseLiterals = @YES;
//NSNumber *buildingZIPCode = @10018;

//不推荐
//NSArray *names = [NSArray arrayWithObjects:@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul", nil];
//NSDictionary *productManagers = [NSDictionary dictionaryWithObjectsAndKeys: @"Kate", @"iPhone", @"Kamal", @"iPad", @"Bill" NSNumber *shouldUseLiterals = [NSNumber numberWithBool:YES];
//NSNumber *buildingZIPCode = [NSNumber numberWithInteger:10018];


//+ (instancetype)sharedInstance {
//    static id sharedInstance = nil; static dispatch_once_t onceToken = 0; dispatch_once(&onceToken, ^{
//        sharedInstance = [[self alloc] init];
//    });
//    return sharedInstance;
//}
//@property (nonatomic, readwrite, copy) NSString *name;

//@property (assign, getter=isEditable) BOOL editable; 形容词 setter不带is，getter带is


//推荐 category
//@interface NSDate (ZOCTimeExtensions)
//- (NSString *)zoc_timeAgoShort;
//@end
//@interface NSDate : NSObject <NSCopying, NSSecureCoding>
//@property (readonly) NSTimeInterval timeIntervalSinceReferenceDate; @end
//@interface NSDate (NSDateCreation)
//+ (instancetype)date;
//+ (instancetype)dateWithTimeIntervalSinceNow:(NSTimeInterval)secs;
//+ (instancetype)dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)ti;
//+ (instancetype)dateWithTimeIntervalSince1970:(NSTimeInterval)secs;
//+ (instancetype)dateWithTimeInterval:(NSTimeInterval)secsToBeAdded sinceDate:(NSDate *)date; // ...
//@end

//不推荐
//@interface NSDate (ZOCTimeExtensions)
//- (NSString *)timeAgoShort;
//@end


//nsnotification
// Foo.h
//extern NSString * const ZOCFooDidBecomeBarNotification // Foo.m
//NSString * const ZOCFooDidBecomeBarNotification = @"ZOCFooDidBecomeBarNotification";

//推荐
//[UIView animateWithDuration:1.0
//                 animations:^{
//    ￼
//   
//                 }
//                 completion:^(BOOL finished) {
//                     // something
//                 }];

//代码块
//NSURL *url = ({
//    NSString *urlString = [NSString stringWithFormat:@"%@/%@", baseURLString, endpoint]; [NSURL URLWithString:urlString];
//});


//代码组织
//- (void)dealloc { /* ... */ }
//- (instancetype)init { /* ... */ }
//#pragma mark - View Lifecycle 􏰺View 􏰙􏰅􏲔􏹆􏷚􏰽
//- (void)viewDidLoad { /* ... */ }
//- (void)viewWillAppear:(BOOL)animated { /* ... */ } - (void)didReceiveMemoryWarning { /* ... */ }
//#pragma mark - Custom Accessors 􏰺􏰁􏰒义访问􏳧􏰽
//- (void)setCustomProperty:(id)value { /* ... */ } - (id)customProperty { /* ... */ }
//#pragma mark - IBActions
//- (IBAction)submitData:(id)sender { /* ... */ } #pragma mark - Public
//- (void)publicMethod { /* ... */ }
//#pragma mark - Private
//- (void)zoc_privateMethod { /* ... */ }
//#pragma mark - UITableViewDataSource
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { /* ... */ } #pragma mark - ZOCSuperclass
//// ... 􏰜载􏰀􏰁 ZOCSuperclass 􏰙􏱀􏱞
//#pragma mark - NSObject
//- (NSString *)description { /* ... */ }



//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
//[myObj performSelector:mySelector withObject:name];
//#pragma clang diagnostic pop

//- (NSInteger)giveMeFive {
//    NSString *foo; #pragma unused (foo)
//    return 5; }


//- (NSInteger)divide:(NSInteger)dividend by:(NSInteger)divisor {
//#error Whoa, buddy, you need to check for zero here!
//    return (dividend / divisor); }

//- (float)divide:(float)dividend by:(float)divisor {
//#warning Dude, don't compare floating point numbers like this! if (divisor != 0.0) {
//    return (dividend / divisor); }
//else {
//    return NAN;
//} }


//__weak __typeof(self)weakSelf = self;
//[self executeBlock:^(NSData *data, NSError *error) {
//    __strong __typeof(weakSelf) strongSelf = weakSelf; if (strongSelf) {
//        [strongSelf doSomethingWithData:data];
//        [strongSelf doSomethingWithData:data]; }
//}];

@end
