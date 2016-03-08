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
#import "NSDictionary+Log.h"
#import "Constant.h"
@interface AppDelegate ()

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


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window  =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController* main = [[ViewController alloc] init];
    EZNavigationController* navi = [[EZNavigationController alloc] initWithRootViewController:main];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    navi.navigationBar.translucent = NO;
    
    //本地化
    NSString* h1 = NSLocalizedString(@"hello", @"comment");//
    NSLog(@"%@",h1);//你好
    
    NSString* h2 = NSLocalizedStringFromTable(@"hello", @"Localizable1", nil);
    NSLog(@"%@",h2);//你好1
    
   
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
    [self testModel];
    //[self assetrtTest];
    
    //后台抓取
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];

    return YES;
}
//http://blog.sina.com.cn/s/blog_4c925dca0102uzdi.html
- (void)assetrtTest {
    DLog(@"dlog test")
    NSString* h3 = nil;
    NSAssert(h3 != nil, @"名字不能为空！");
}

//os7新添加了两个可以在后台更新应用程序界面和内容的APIs。第一个API是后台获取（Background Fetch)，允许你在定期间隔内从网络获取新内容。第二个API是远程通知 （Remote Notification)，它是一个新特性，它在当新事件发生时利用推送通知（Push Notifications）去告知程序。这两个新的机制，帮助你保持程序界面最新，还可以在新的后台传输服务（Background Transfer Service）中安排任务，这允许你在进程外执行网络传输（下载和上传）
//In Xcode 5 Debug mode, you can force a background fetch from the menu: Debug > Simulate Background Fetch.
//从Project开始，接着是Capabilities，然后Put Background Modes ON，再选择Background Fetch
//http://blog.jobbole.com/51660/
-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    //在这里展示获取到数据后更新界面
    BLog();
    
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
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([[url scheme] isEqualToString:@"testddd"]) {
       
        return YES;
    }
    return NO;
}



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



@end
