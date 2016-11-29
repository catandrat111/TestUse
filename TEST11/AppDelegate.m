










//
//  AppDelegate.m
//  TEST11
//
//  Created by 董金亮 on 15-3-16.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//file 可执行文件  查看编译架构 例如 armv7 等。 otool -h 查看头文件 -l 查看主题

//发布时上传的截图（ 1）图片名不能包含中文；（2）图片格式为jpg（图片不能带有透明通道）xcode6中选择iphone5的模拟器，快捷键command+s截图，桌面上得到规格为640*1136的截图。

//typedef struct objc_class *Class;
//typedef struct objc_object {
//    Class isa;
//} *id;
//struct objc_class {
//    Class isa;
//    Class super_class;
//    const charchar *name;
//    long version;
//    long info;
//    long instance_size;
//    struct objc_ivar_list *ivars;
//    struct objc_method_list **methodLists;
//    struct objc_cache *cache;
//    struct objc_protocol_list *protocols;
//    
//} OBJC2_UNAVAILABLE

//navigationitem backbaritem 自定义支持init title 和image 不支持cistomview，定义是再父级中，实现在子级中， 默认值是父级的title，若自定义的title过长则用back代替。  lleftbaritem 和backbaritem 默认不支持同时显示 可以使用leftItemsSupplementBackButton打开
//hidesBarsOnTap  hidesBarsWhenKeyboardAppears hidesBarsOnSwipe(上下滑动) yes表示具有某种功能 而不是表示点击就隐藏 隐藏点击显现 在点击隐藏  点击事件是view默认就是别的  不用另加手势   hidesBarsOnSwipe tableview上下滑动时隐藏 （不能互斥 比如上滑动隐藏下滑东出现）
//
//[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
 //forBarMetrics:UIBarMetricsDefault]; 改变文字距离

//url 转码 ：将指定的字符转意，就是用%加上对应的ascii码的16进制   NSString* obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)originalURLString,  NULL,  (CFStringRef)@"1!*'();:@&;=+$,/?%#[]",  kCFStringEncodingUTF8));


//uitableview 优化 ：1 来自苹果官方例子 lazytable,针对图片异步加载，拖动或滑动结束时，得到当前可视cell,让每个cell下载图片，有个下载类（包含CELL所需的model数据，也包括图片数据）专门下载图片，有个全局字典存放每个cell的下载类，首先检查cell中有没有他对应的下载类，没有建立实力对象加入字典，执行下载， 下载完封装进相应的Model，并从字典中删除相应的下载类  2 http://blog.sunnyxx.com/2015/05/17/cell-height-calculation/  注册观察者 ，当runloop即将休眠时，查找缓存中是否有cell的高度（一个数组用来存贮高度，一个用来存所用的indexpath）,将休眠时取出一个indexpoath，查看缓存中是否有。

#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])
#import "AppDelegate.h"


#import "ViewController.h"
#import "ButtonInstance.h"
#import "CoreLaunchLite.h"
#import "CoreLaunchCool.h"
#import "CoreLaunchPro.h"
#import "CoreLaunchPlus.h"
#import "CoreLaunchFlip.h"
#import "EZNavigationController.h"
#import <objc/runtime.h>
#import "Person.h"
#import "MJExtension.h"
//import "NSDictionary+Log.h"
#import "Constant.h"
//#import "iConsole.h"

//#import <KSCrash/KSCrashInstallationStandard.h>
#import "RSAEncryptor.h"
#import "ZSCHRSA.h"
#import "User.h"
#import "NSDictionary+HYBUnicodeReadable.h"
#import "JPUSHService.h"

#import <DIOpenSDK/DIOpenSDK.h>
#import <Photos/Photos.h>
#import "SVProgressHUD.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "PHPhotoLibrary+ZHCustomPhotoAlbum.h"
#import "WXApi.h"
#import "CocoaLumberjack.h"
#import "DDLegacyMacros.h"
//#import <PonyDebugger/PonyDebugger.h>
//@interface AppDelegate ()<iConsoleDelegate>
#import "CocoaLumberjack.h"
#import "MyCustomFormatter.h"
#import "MyExceptionHandler.h"
#import "MyFileLogger.h"
#import "NSDate+DateTools.h"
//static const int ddLogLevel = DDLogLevelVerbose;//定义日志级别


@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate
//升级9.0  Xcode7.0之后微信API提示未安装微信客户端的问题怎么解决？
//增加白名单
//<key>LSApplicationQueriesSchemes</key>
//<array>
//<string>weixin</string>
//<string>wechat</string>
//<string>tbopen</string>
//<string>TencentWeibo</string>
//<string>tencentweiboSdkv2</string>
//<string>sinaweibo</string>
//<string>sinaweibohd</string>
//<string>sinaweibosso</string>
//<string>sinaweibohdsso</string>
//<string>alipay</string>
//<string>alipayshare</string>
//<string>mqzoneopensdk</string>
//<string>mqzoneopensdkapi</string>
//<string>mqzoneopensdkapi19</string>
//<string>mqzoneopensdkapiV2</string>
//<string>mqqOpensdkSSoLogin</string>
//<string>mqqopensdkapiV2</string>
//<string>mqqopensdkapiV3</string>
//<string>wtloginmqq2</string>
//<string>mqqapi</string>
//<string>mqqwpa</string>
//<string>mqzone</string>
//<string>mqq</string>
//</array>

//画一像素 http://www.cnblogs.com/smileEvday/p/iOS_PixelVsPoint.html
typedef int (^frd)(NSString* st);
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

//CGFloat xPos = 5;
//UIView *view = [[UIView alloc] initWithFrame:CGrect(x - SINGLE_LINE_ADJUST_OFFSET, 0, SINGLE_LINE_WIDTH, 100)];


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   //[self save];
    
   // self.window = [[iConsoleWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window  =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController* main = [[ViewController alloc] init];
    EZNavigationController* navi = [[EZNavigationController alloc] initWithRootViewController:main];
    navi.hidesBarsOnSwipe = YES;
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    navi.navigationBar.translucent = YES;//决定视图是否从0开始
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xd7000f)];
    //本地化
    NSString* h1 = NSLocalizedString(@"hello", @"comment");//
    NSLog(@"%@",h1);//你好
    
    NSString* h2 = NSLocalizedStringFromTable(@"hello", @"Localizable1", nil);
    NSLog(@"%@",h2);//你好1
    [DIOpenSDK registerApp:@"didi646E47504F336C793047717354734344" secret:@"eb28cd9512f46460882947a33b6a186d"];
    [JPEngine startEngine];
   // navi.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    //更改STATUSBAR
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    //_objc_autoreleasePoolPrint();

   // NSString* uuid = [UIDevice  getUDID];
    //DLog(@"%@",uuid);
    //6EAA3C6E-3DC6-4F52-B57A-6C29041C33CE//com.test
 
    //NSString* uuid1 = [UIDevice  getUDID1];
   // DLog(@"%@",uuid1);
  //  [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xd7000f)];
//    [[UINavigationBar appearance] setTitleTextAttributes:@{
//                                                           UITextAttributeTextColor: [UIColor whiteColor],
//                                                           }];
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
//                                      forBarPosition:UIBarPositionAny
//                                          barMetrics:UIBarMetricsDefault];
//    
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];

    //[UIDevice removePwd];
    //[self testVersion ];
    //[self test];
    
    /** Lite版本 */
       // [CoreLaunchLite animWithWindow:self.window image:nil];
    
    /** Plus版本 */
    //    [CoreLaunchPlus animWithWindow:self.window image:nil];
    
    /** Cool版本 */
    //    [CoreLaunchCool animWithWindow:self.window image:nil];
    
    /** Pro版本 */
    //[CoreLaunchPro animWithWindow:self.window image:nil];
    
    /** Flip版本 */
     //[CoreLaunchFlip animWithWindow:self.window image:nil];
    
    
    //http://www.cnblogs.com/smileEvday/archive/2012/11/16/UIWindow.html
    //程序默认的window先显示出来
    
//    　　2、默认的window再变成keyWindow
//    
//    　　3、AlertView的window显示出来
//    
//    　　4、默认的window变成非keyWindow
//    
//    　　5、最终AlertView的window变成keyWindow
//    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    // Override point for customization after application launch.
//    self.viewController = [[[SvUIWindowViewController alloc] initWithNibName:@"SvUIWindowViewController" bundle:nil] autorelease];
//    self.window.rootViewController = self.viewController;
//    [self.window makeKeyAndVisible];
//    
//    UIWindow *window1 = [[UIWindow alloc] initWithFrame:CGRectMake(0, 80, 320, 320)];
//    window1.backgroundColor = [UIColor redColor];
//    window1.windowLevel = UIWindowLevelAlert;
//    [window1 makeKeyAndVisible];
    
//    首先ActionSheet的window变成非keyWindow
//    
//    　　2、程序默认的window变成keyWindow
//    
//    　　3、ActionSheet的window在隐藏掉
//    
//    　　总体就是“想隐居幕后可以，但得先交出权利”。
    //[self testModel];
   // [self test];
    //[self assetrtTest];
    //[self testPony];
    
    //后台抓取
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
   // [self testConsole];
   // [self testLogger];
    //[self testFirim];

    
    [self testRsa];
    
    NSString* test111 = @"<fdg<fdg<GG";
   NSString* sdd = [test111 stringByReplacingOccurrencesOfString:@"<" withString:@"1"];
    NSLog(@"sdd:%@",sdd);
    NSString* add = [test111 stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@"11111"];
    NSLog(@"add:%@",add);
    
    
    NSMutableString* mustr = [[NSMutableString alloc] initWithString:@"f"];
   
    CFDictionaryKeyCallBacks keyallbacks = {0,0,0,0,CFEqual,CFHash};
    
    CFDictionaryValueCallBacks valueallbacks = {0,0,0,0,CFEqual};
    
    CFMutableDictionaryRef acfdic =CFDictionaryCreateMutable(NULL,0, &keyallbacks, &valueallbacks);
    
    
    NSMutableDictionary * adicc = (__bridge_transfer NSMutableDictionary * )acfdic;
    [adicc setObject:@"g" forKey:mustr];
    
     NSString* aaa2 = adicc.allKeys[0];
    
    NSError * keyError = [NSError errorWithDomain:@"domian"code:123 userInfo:nil];
    
    NSError * numError = [NSError errorWithDomain:@"domian"code:456 userInfo:nil];
    
    
    [adicc setObject:numError forKey:keyError];
   // [adicc setObject:@"g" forKey:asd];
    
    [self test1:mustr];
    
    
    NSString *str = @"我是转换成data格式的字符串";
    NSData *dataString = [NSData dataWithBytes:str.UTF8String length:str.length];
    NSDictionary *dataSet = @{@"key": @"字典转成data",
                              @"key1": @"在set、数组、字典中嵌套"};
    NSData *dataSetItem = [NSJSONSerialization dataWithJSONObject:dataSet options:NSJSONWritingPrettyPrinted error:nil];
    
    
    NSDictionary *dict = @{@"name"  : @"标哥的技术博客",
                           @"title" :dataSetItem,
                          };
//    NSMutableSet *set = [NSMutableSet setWithArray:@[@"可变集合", @"字典->不可变集合->可变集合", dataSetItem]];
//    NSDictionary *dict = @{@"name"  : @"标哥的技术博客",
//                           @"title" : @"http://www.henishuo.com",
//                           @"count" : @(11),
//                           @"dataString" : dataString,
//                           @"results" : [NSSet setWithObjects:@"集合值1", @"集合值2", set , nil],
//                           @"summaries" : @[@"sm1", @"sm2", @{@"keysm": @{@"stkey": @"字典->数组->字典->字典"}}, dataSetItem],
//                           @"parameters" : @{@"key1" : @"value1", @"key2": @{@"key11" : @"value11", @"key12" : @[@"三层", @"字典->字典->数组"]}, @"key13": dataSetItem},
//                           @"hasBug": @[@"YES",@"NO"],
//                           @"contact" : @[@"关注博客地址：http://www.henishuo.com", @"QQ群: 324400294", @"关注微博：标哥Jacky", @"关注GITHUB：CoderJackyHuang"]};
    NSLog(@"%@", dict);
    
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                          UIUserNotificationTypeSound |
//                                                          UIUserNotificationTypeAlert)
//                                              categories:nil];
//    } else {
//        //categories 必须为nil
//        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                          UIRemoteNotificationTypeSound |
//                                                          UIRemoteNotificationTypeAlert)
//                                              categories:nil];
//    }
//
//    //如不需要使用IDFA，advertisingIdentifier 可为nil
//    [JPUSHService setupWithOption:launchOptions appKey:@"ff0f4de59f7adb84e5c34f76"
//                          channel:@"public"
//                 apsForProduction:FALSE
//            advertisingIdentifier:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getRegisterID) name:kJPFNetworkDidRegisterNotification object:nil];
//
   // [self testJSPatch];
    NSDate* testDate = [self replaceMethodWithJSPatch];
    TICK;
    //[self testJS];
    TOCK;
    NSLog(@"%@",testDate);
    
   // [self testPrintCNText];
    [self stringWithHourAndMinute:@"03:02"];
    NSObject* bn = [NSObject new];
    NSObject * bn2 = [NSObject new];
    BOOL b3 = [self isZHKindOfClass:[bn class] otherClass:[bn2 class]];
    

   
    [self testLumberjack];
    [self setupLocalNotification];
    return YES;
}

- (BOOL) isZHKindOfClass :(Class)suBclass otherClass:(Class)otherClass {
    Class subclass1 = suBclass;
    BOOL b = NO;
    while (subclass1) {
        if ([NSStringFromClass(subclass1) isEqualToString:NSStringFromClass(otherClass)]) {
            b = YES;
            break;
        }
        subclass1 = [subclass1 superclass];
        
    }
    return b;
    
}

- (NSString*)stringWithHourAndMinute:(NSString*)timeStr {
    NSString* result = @"";
    NSArray* arr = [timeStr componentsSeparatedByString:@":"];
    NSInteger d = [arr[0] integerValue];
    NSInteger d1 = [arr[1] integerValue];
    if (arr.count > 0) {
        result = [NSString stringWithFormat:@"停留%@小时%@分",@(d),@(d1)];
    }
    return result;
}


- (void)onResp:(BaseResp *)resp {
    if(!resp.errCode){
        if([resp isKindOfClass:[SendAuthResp class]]){
            //            SendAuthResp* sendResq = (SendAuthResp*)resp;
            //            self.wxCode = sendResq.code;
            //            [self getAccess_token];
        }
        if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
            if (resp.errCode == 0) {
                
            }
        }
        //发送成功
        if([resp isKindOfClass:[PayResp class]]){
            
        }
    }
    
}


- (void)testLumberjack {
   // setenv("XcodeColors", "YES", 0);
    [DDLog addLogger:[DDASLLogger sharedInstance]];//mac控制台
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
     [[DDTTYLogger sharedInstance] setColorsEnabled:YES];// 启用颜色区分
   // [DDTTYLogger sharedInstance].logFormatter = [MyCustomFormatter sharedInstance];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor grayColor] backgroundColor:nil forFlag:DDLogFlagVerbose];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:DDLogFlagDebug];
   
    DDLogVerbose(@"Verbose");
    DDLogInfo(@"Info");
    DDLogWarn(@"Warn");
    DDLogError(@"Error");
    
    DDLog *aDDLogInstance = [DDLog new];
    [aDDLogInstance addLogger:[DDTTYLogger sharedInstance]];
   
    DDLogVerboseToDDLog(aDDLogInstance, @"Verbose from aDDLogInstance");
    DDLogInfoToDDLog(aDDLogInstance, @"Info from aDDLogInstance");
    DDLogWarnToDDLog(aDDLogInstance, @"Warn from aDDLogInstance");
    DDLogErrorToDDLog(aDDLogInstance, @"Error from aDDLogInstance");
    
    [MyExceptionHandler setDefaultHandler];
    self.logger=[[MyFileLogger alloc]init];
    
    NSString *path = NSHomeDirectory();//主目录
    DDLogInfo(@"当前项目的路径:%@",path);
        
}

/**
 *  返回相册
 */
- (PHAssetCollection *)collection{
    // 先获得之前创建过的相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:@"川航登机牌"]) {
            return collection;
        }
    }
    
    // 如果相册不存在,就创建新的相册(文件夹)
    __block NSString *collectionId = nil; // __block修改block外部的变量的值
    // 这个方法会在相册创建完毕后才会返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 新建一个PHAssertCollectionChangeRequest对象, 用来创建一个新的相册
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"川航登机牌"].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}

- (void)save {
    
    [PHPhotoLibrary saveImage:[UIImage imageNamed:@"stretch2.png"] toAlbum:@"hello" withCompletionBlock:^(NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"保存失败"];
        }
        else {
            [SVProgressHUD showErrorWithStatus:@"保存成功"];

        }
    }];
    // 0.判断状态
//    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
//    if (status == PHAuthorizationStatusDenied) {
//        DLog(@"用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关");
//    }else if (status == PHAuthorizationStatusRestricted){
//        DLog(@"家长控制,不允许访问");
//    }else if (status == PHAuthorizationStatusNotDetermined){
//        DLog(@"用户还没有做出选择");
//        [self saveImage];
//    }else if (status == PHAuthorizationStatusAuthorized){
//        DLog(@"用户允许当前应用访问相册");
//        [self saveImage];
//    }
}

/**
 *  返回相册,避免重复创建相册引起不必要的错误
 */
- (void)saveImage{
    
//    ALAssetsLibrary* lib = [[ALAssetsLibrary alloc] init];
//    [lib saveImage:[UIImage imageNamed:@"stretch2.png"] toAlbum:@"test" withCompletionBlock:^(NSError *error) {
//        NSLog(@"test");
//    }];
//    return;
    
    UIImage* img = [UIImage imageNamed:@"stretch2.png"];
    /*
     PHAsset : 一个PHAsset对象就代表一个资源文件,比如一张图片
     PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
     */
    
    __block NSString *assetId = nil;
    // 1. 存储图片到"相机胶卷"
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{ // 这个block里保存一些"修改"性质的代码
        // 新建一个PHAssetCreationRequest对象, 保存图片到"相机胶卷"
        // 返回PHAsset(图片)的字符串标识
        id ff=   [PHAssetCreationRequest creationRequestForAssetFromImage:img];
        assetId = [PHAssetCreationRequest creationRequestForAssetFromImage:img].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            DLog(@"保存图片到相机胶卷中失败");
            return;
        }
        
        DLog(@"成功保存图片到相机胶卷中");
        
        // 2. 获得相册对象
        PHAssetCollection *collection = [self collection];
        
        // 3. 将“相机胶卷”中的图片添加到新的相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
            
            // 根据唯一标示获得相片对象
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
            // 添加图片到相册中
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                DLog(@"添加图片到相册中失败");
                return;
            }
            
            DLog(@"成功添加图片到相册中");
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
            }];
        }];
    }];
}


-(void)testJSPatch {
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    [JPEngine evaluateScript:script];
}

- (void)testPrintCNText {
    NSString *str = @"我是转换成data格式的字符串";
    NSData *dataString = [NSData dataWithBytes:str.UTF8String length:str.length];
    NSDictionary *dataSet = @{@"key": @"字典转成data",
                              @"key1": @"在set、数组、字典中嵌套"};
    NSData *dataSetItem = [NSJSONSerialization dataWithJSONObject:dataSet options:NSJSONWritingPrettyPrinted error:nil];
    
    NSMutableSet *set = [NSMutableSet setWithArray:@[@"可变集合", @"字典->不可变集合->可变集合", dataSetItem]];
    NSDictionary *dict = @{@"name"  : @"标哥的技术博客",
                           @"title" : @"http://www.huangyibiao.com",
                           @"count" : @(11),
                           @"dataString" : dataString,
                           @"results" : [NSSet setWithObjects:@"集合值1", @"集合值2", set , nil],
                           @"summaries" : @[@"sm1", @"sm2", @{@"keysm": @{@"stkey": @"字典->数组->字典->字典"}}, dataSetItem],
                           @"parameters" : @{@"key1" : @"value1", @"key2": @{@"key11" : @"value11", @"key12" : @[@"三层", @"字典->字典->数组"]}, @"key13": dataSetItem},
                           @"hasBug": @[@"YES",@"NO"],
                           @"contact" : @[@"关注博客地址：http://www.huangyibiao.com", @"QQ群: 324400294", @"关注微博：标哥Jacky", @"关注GITHUB：CoderJackyHuang"]};
    NSLog(@"%@", dict);
}

- (void)testJS {
    NSLog(@"helllo");
    for (int i = 0; i < 1000; i++) {
        
    }
}

- (NSDate*)replaceMethodWithJSPatch {
    NSString* yearString = @"1986-05-04 00:59:01";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];;
    NSDate *userDate = [dateFormatter dateFromString:yearString];
    return userDate;
}

- (void)getRegisterID {
     NSString* jid = [JPUSHService registrationID];
    if ([jid isKindOfClass:[NSString class]]) {
        NSLog(@"%@",jid);
    }
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    DLog(@"%@",[JPUSHService registrationID]);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    //成功注册registerUserNotificationSettings:后，回调的方法
    NSLog(@"%@",notificationSettings);
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
    //在非本App界面时收到本地消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮，notification为消息内容
    NSLog(@"%@----%@",identifier,notification);
    completionHandler();//处理完消息，最后一定要调用这个代码块
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
   
}
#endif





- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    //收到本地推送消息后调用的方法
    NSLog(@"%@",notification);
    return;
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}




//http://blog.sina.com.cn/s/blog_4c925dca0102uzdi.html
- (void)assetrtTest {
    DLog(@"dlog test")
    NSString* h3 = nil;
    NSAssert(h3 != nil, @"名字不能为空！");
    
}


- (void)test1:(NSString* )ss
{
    NSLog(@"%@",ss);
    
    Son* son = [Son new];
    son.name = @"ddd";
    son.sex = @"ff";
    NSString* str =  son.user.name;
    Son* s1 = [son copy];
    
    NSString* testStr = @"hello o\n12334a\n";
    //NSStringEnumerationByWords 单词之间有空格
    //NSStringEnumerationByComposedCharacterSequences 单个字符也包括空格
    [testStr enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        NSLog(@"%@",line);
        [line enumerateSubstringsInRange:NSMakeRange(0, line.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            NSLog(@"%@",substring);
        }];
    }];
}


//const void * retaincallbak(CFAllocatorRef allocator,const void * value) {
//    
//    return CFRetain(value);
//    
//}
//
//
//void releasecallbak(CFAllocatorRef allocator,const void * value) {
//    
//    return CFRelease(value);
//    
//}
//
//CFStringRef copycallbak(const void * value) {
//    
//    return CFRetain(value);
//    
//}
//


- (void)testRsa {
    RSAEncryptor* rsaEncryptor = [[RSAEncryptor alloc] init];
    NSString* publicKeyPath = [[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"];
    NSString* privateKeyPath = [[NSBundle mainBundle] pathForResource:@"private_key" ofType:@"p12"];
    [rsaEncryptor loadPublicKeyFromFile: publicKeyPath];
    [rsaEncryptor loadPrivateKeyFromFile: privateKeyPath password:@"1234"];    // 这里，请换成你生成p12时的密码
    
    NSString* restrinBASE64STRING = [rsaEncryptor rsaEncryptString:@"hello"];
    NSLog(@"Encrypted: %@", restrinBASE64STRING);       // 请把这段字符串Copy到JAVA这边main()里做测试
    NSString* decryptString = [rsaEncryptor rsaDecryptString: restrinBASE64STRING];
    NSLog(@"Decrypted: %@", decryptString);
    
    
    
   // NSString* restrinBASE64STRING1 = [ZSCHRSA rsaEncryptString:@"hello"];//测试需要改key
    //NSString* decryptString1 = [ZSCHRSA rsaDescryptString: restrinBASE64STRING1];

}

- (void)testFirim {
//    KSCrashInstallationStandard* installation = [KSCrashInstallationStandard sharedInstance];
//    installation.url = [NSURL URLWithString:@"https://collector.bughd.com/kscrash?key=83d8534d790f6b8f13143c6067d0ec3c"];
//    [installation install];
//    [installation sendAllReportsWithCompletion:nil];
}

- (void)testConsole {
//    [iConsole sharedConsole].delegate = self;
//    
//    NSUInteger touches = (TARGET_IPHONE_SIMULATOR ? [iConsole sharedConsole].simulatorTouchesToShow: [iConsole sharedConsole].deviceTouchesToShow);
//    if (touches > 0 && touches < 11)
//    {
//         }
//    else if (TARGET_IPHONE_SIMULATOR ? [iConsole sharedConsole].simulatorShakeToShow: [iConsole sharedConsole].deviceShakeToShow)
//    {
//       
//    }
//    
    //关闭 iconsole
   // [iConsole sharedConsole].enabled = NO;

    
}


- (void)handleConsoleCommand:(NSString *)command
{
//    if ([command isEqualToString:@"version"])
//    {
//        [iConsole info:@"%@ version %@",
//         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"],
//         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
//    }
//    else
//    {
//        [iConsole error:@"unrecognised command:%@, try 'version' instead",command];
//    }
}


//- (void)testPony {
//    PDDebugger *debugger = [PDDebugger defaultInstance];
//    
//    [debugger enableNetworkTrafficDebugging];
//    
//    [debugger forwardAllNetworkTraffic];
//    
//    [debugger enableCoreDataDebugging];
//    
//    [debugger connectToURL:[NSURL URLWithString:@"ws://172.16.18.165/device"]];
//}

//os7新添加了两个可以在后台更新应用程序界面和内容的APIs。第一个API是后台获取（Background Fetch)，允许你在定期间隔内从网络获取新内容。第二个API是远程通知 （Remote Notification)，它是一个新特性，它在当新事件发生时利用推送通知（Push Notifications）去告知程序。这两个新的机制，帮助你保持程序界面最新，还可以在新的后台传输服务（Background Transfer Service）中安排任务，这允许你在进程外执行网络传输（下载和上传）
//In Xcode 5 Debug mode, you can force a background fetch from the menu: Debug > Simulate Background Fetch.
//从Project开始，接着是Capabilities，然后Put Background Modes ON，再选择Background Fetch
//http://blog.jobbole.com/51660/
-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    //在这里展示获取到数据后更新界面
   
    
    /*
     At the end of the fetch, invoke the completion handler.
     */
    //completionHandler(UIBackgroundFetchResultNewData);
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://172.16.18.140:8080/home/hots.json"];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            if (error) {
                                                completionHandler(UIBackgroundFetchResultFailed);
                                                return;
                                            }
                                            
                                            
                                            // Parse response/data and determine whether new content was available
                                            BOOL hasNewData = YES;
                                            if (hasNewData) {
                                                completionHandler(UIBackgroundFetchResultNewData);
                                            } else {
                                                completionHandler(UIBackgroundFetchResultNoData);
                                            }
                                        }];
    
    
    // Start the task
    [task resume];
    
}

- (void)testLogger {
//    LoggerSetViewerHost(NULL, (CFStringRef)@"172.16.16.165", (UInt32)50000);
//    LoggerSetOptions(NULL,						// configure the default logger
//                     kLoggerOption_BufferLogsUntilConnection |
//                     kLoggerOption_UseSSL |
//                     ( kLoggerOption_BrowseBonjour) |
//                     ( kLoggerOption_BrowseOnlyLocalDomain));
//    //    LoggerSetOptions(NULL,						// configure the default logger
//    //                     kLoggerOption_BufferLogsUntilConnection |
//    //                     kLoggerOption_UseSSL |
//    //                     ( 0) |
//    //                     (0));
//    
//    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *logPath = [cacheDirectory stringByAppendingPathComponent:@"log.rawnsloggerdata"];
//    
//    LoggerSetBufferFile(NULL, (__bridge CFStringRef)logPath);

}

- (NSURLSession *)backgroundURLSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *identifier = @"io.objc.backgroundTransferExample";
        NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration backgroundSessionConfiguration:identifier];
        session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                delegate:self
                                           delegateQueue:[NSOperationQueue mainQueue]];
    });
    
    return session;
}

- (void)           application:(UIApplication *)application
  didReceiveRemoteNotification:(NSDictionary *)userInfo
        fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    NSLog(@"Received remote notification with userInfo %@", userInfo);
    
    NSNumber *contentID = userInfo[@"content-id"];
    NSString *downloadURLString = [NSString stringWithFormat:@"http://yourserver.com/downloads/%d.mp3", [contentID intValue]];
    NSURL* downloadURL = [NSURL URLWithString:downloadURLString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
    NSURLSessionDownloadTask *task = [[self backgroundURLSession] downloadTaskWithRequest:request];
    task.taskDescription = [NSString stringWithFormat:@"Podcast Episode %d", [contentID intValue]];
    [task resume];
    
    completionHandler(UIBackgroundFetchResultNewData);
}


- (void)setupLocalNotification {    
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
    action.identifier = @"action";//按钮的标示
    action.title=@"Accept";//按钮的标题
    action.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    //    action.authenticationRequired = YES;
    //    action.destructive = YES;
    
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
    action2.identifier = @"action2";
    action2.title=@"Reject";
    action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
    action.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    action.destructive = YES;
    
    //2.创建动作(按钮)的类别集合
    UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
    categorys.identifier = @"alert";//这组动作的唯一标示
    [categorys setActions:@[action,action2] forContext:(UIUserNotificationActionContextMinimal)];
    
    //3.创建UIUserNotificationSettings，并设置消息的显示类类型
    UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil]];
    
    //4.注册推送
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    
    //5.发起本地推送消息
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:5];
    notification.timeZone=[NSTimeZone defaultTimeZone];
    notification.alertBody=@"测试推送的快捷回复";
    notification.category = @"alert";
    [[UIApplication sharedApplication]  scheduleLocalNotification:notification];
    

}

- (void)registerLocalMessage {
   
        //register remoteNotification types
    UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
    action1.identifier = @"action1_identifier";
    action1.title=@"Accept";
    action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
    action2.identifier = @"action2_identifier";
    action2.title=@"Reject";
    action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
    action2.authenticationRequired = YES;
    //需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    action2.destructive = YES;
    
    UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
    categorys.identifier = @"category1";//这组动作的唯一标示
    [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
    
    UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                 categories:[NSSet setWithObject:categorys]];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:userSettings];
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
        
   
    
}

- (void)testModel {
    
    
    PersonModel* model = [[PersonModel alloc] init];
    //model.cabinNo = @"F";
    model.flightDate = @"2014-01-02";
//    model.flightNo = @"3U8549";
//    model.orderId = @"16N4379767";
//    model.ticketIdList = @[@"aSj6rbN3Z7UPKC2CD1GyZQ=="];
    
    NSDictionary *param = @{
                            @"head": @{
                                    @"proVersion": @"2.0",
                                    @"action": @"QUERY_ORDER_FLIGHT_CAN_CHANGE_DATE",
                                    @"transAction": @"bfifacjhhfedijahdjej",
                                    @"timestamp": @"20140211000000",
                                    @"verify": @"",
                                    @"platformId": @"ios",
                                    @"channelId":@"appstore",
                                    },
                            @"body": [model keyValues]
                            };
    NSError* error = nil;
    
    NSData* str =  [NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:&error];
    
    NSLog(@"%@",[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil] encoding:4]);


    NSDictionary *param2 = @{
                            @"head": @{
                                    @"proVersion": @"2.0",
                                    @"action": @"QUERY_ORDER_FLIGHT_CAN_CHANGE_DATE",
                                    @"transAction": @"bfifacjhhfedijahdjej",
                                    @"timestamp": @"20140211000000",
                                    @"verify": @"",
                                    @"platformId": @"ios",
                                    @"channelId":@"appstore",
                                    },
                            @"body":@"fff"
                            };
    
    NSLog(@"%@",param2);
    
}

- (void)test {
    NSString *jsonString = @"[{\"@(3)\": \"1\", \"name\":\"Aaa\"}, {\"id\": \"2\", \"name\":\"Bbb\"}]";
    jsonString = @"fff";
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"Test1" ofType:@"json"];
    jsonData = [NSData dataWithContentsOfFile:path];

    NSError *e = nil;
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&e];
    NSLog(@"%@", json);
    
    NSError *e1= nil;
    NSDictionary *JSON = [NSJSONSerialization
                          JSONObjectWithData: jsonData
                          options: NSJSONReadingMutableContainers
                          error: &e1];
    
    NSLog(@"%@",JSON);
    
    BOOL b1 = [json isKindOfClass:[NSDictionary class]];
    NSString* str2 = [JSON valueForKeyPath:@"ss"];
    if ([str2 isKindOfClass:[NSString class]]) {
        BOOL b3 = [str2 isEqualToString:@"aa"];
    }
    
    BOOL b = [[JSON valueForKeyPath:@"ss"] isEqualToString:@"aa"];
     NSLog(@"%@",@(b));
    
     NSString *jsonString1 = @"{\"name\":\"Aaa\\n gg \",\"test\":\"自中国始发 \\n free for noshow. 每航段改期费300 人民币. 每航段退票费300 人民币. 不能同舱位延期 unless the whole tichet to an appropriate fare level. fare difference should be paid.\"}";
     NSData *jsonData1 = [jsonString1 dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *JSON1 = [NSJSONSerialization
                          JSONObjectWithData: jsonData1
                          options: NSJSONReadingMutableContainers
                          error: &e1];
    
    Person* p1 = [Person objectWithKeyValues:JSON1];
    Personsubmodel* p2 = [Personsubmodel  objectWithKeyValues:JSON1];
    NSData *archiveAddressData = [NSKeyedArchiver archivedDataWithRootObject:p1];
    [[NSUserDefaults standardUserDefaults] setObject:archiveAddressData forKey:@"p1"];
    
    
    NSData *p1data1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"p1"];
    
   Person* p11  = [NSKeyedUnarchiver unarchiveObjectWithData:p1data1];

    

}

//testddd://?action=my_action_1&sourceurl=http://weibo.com/1692391497/CkirQtS1I?from=page_1005051692391497_profile&wvr=6&mod=weibotime&type=comment#_rnd1433007524429

//http://tinyurl.com/ 制作网址别名
//http://tinyurl.com/psobuqp
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    if ([[url scheme] isEqualToString:@"testddd"]) {
//        // Get a dictionary with the query items from the external url
//        NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
//        NSArray *queryItemsArray = [urlComponents queryItems];
//        NSMutableDictionary *queryItems = [NSMutableDictionary dictionary];
//        for (NSURLQueryItem *item in queryItemsArray) {
//            [queryItems setObject:item.value forKey:item.name];
//        }
//        if ([[queryItems valueForKey:@"action"] isEqualToString:@"my_action_1"]) {
//            // code to call your view controller for my_action_1
//            NSURL *sourceURL = [NSURL URLWithString:[queryItems objectForKey:@"sourceurl"]];
//            ButtonInstance *controller = [ButtonInstance new];
//            controller.sourceURL = sourceURL;
//            [(UINavigationController *)self.window.rootViewController pushViewController:controller animated:YES];
//            return YES;
//        } else if ([[queryItems valueForKey:@"action"] isEqualToString:@"my_action_2"]) {
//            // code to call the view controller for my_action_2
//            return YES;
//        }
//    }
//    return NO;
//}



//版本号 Version：在plist文件中的key是“CFBundleShortVersionString”，和AppStore上的版本号保持一致；
//Version: 程序版本号{主版本号.次版本号.维护号}
//Build: 编译次数统计
//Build：在plist中的key是“CFBundleVersion”，代表build的版本号，该值每次build之后都应该增加1；//通过脚本实现
- (void)testVersion {
    NSString* version1 = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString* version2 =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString* build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    DLog(@"version1:%@,version2:%@,build:%@",version1,version2,build);
}

//testd:// 浏览器输入
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    if ([[url scheme] isEqualToString:@"testddd"]) {
//       
//        return YES;
//    }
//    
//    
//    return NO;
//}
//


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self beginBackgroundUpdateTask];
        NSURLResponse * response = nil;
        NSError  * error = nil;
        NSURL *downloadURL = [NSURL URLWithString:@"http://172.16.18.140:8080/home/hots.json"];
        NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];

        NSData * responseData = [NSURLConnection sendSynchronousRequest: request returningResponse: &response error: &error];
        // Do something with the result
        [self endBackgroundUpdateTask];
    });
}

- (void) beginBackgroundUpdateTask
{
    self.backgroundUpdateTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self endBackgroundUpdateTask];
    }];
}

- (void) endBackgroundUpdateTask
{
    [[UIApplication sharedApplication] endBackgroundTask: self.backgroundUpdateTask];
    self.backgroundUpdateTask = UIBackgroundTaskInvalid;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
     DLog(@"强制退出");
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier
  completionHandler:(void (^)())completionHandler
{
    BLog();
    /*
     Store the completion handler. The completion handler is invoked by the view controller's checkForAllDownloadsHavingCompleted method (if all the download tasks have been completed).
     */
    self.backgroundSessionCompletionHandler = completionHandler;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    //    [self parse:url application:application];
    
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    
    
    if ([sourceApplication isEqualToString:@"com.tencent.xin"]) {
        BOOL b = [WXApi handleOpenURL:url delegate:self];
        return b;
    }
else{
        return YES;
    }
    
}





@end
