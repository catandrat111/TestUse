//
//  AppDelegate.m
//  TEST11
//
//  Created by 董金亮 on 15-3-16.
//  Copyright (c) 2015年 董金亮. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ButtonInstance.h"
#import "CoreLaunchLite.h"
#import "CoreLaunchCool.h"
#import "CoreLaunchPro.h"
#import "CoreLaunchPlus.h"
#import "CoreLaunchFlip.h"

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
    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:main];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    navi.navigationBar.translucent = NO;
    
    
   // navi.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    //更改STATUSBAR
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    

    NSString* uuid = [UIDevice  getUDID];
    DLog(@"%@",uuid);
    //6EAA3C6E-3DC6-4F52-B57A-6C29041C33CE//com.test
 
    NSString* uuid1 = [UIDevice  getUDID1];
    DLog(@"%@",uuid1);
  //  [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xd7000f)];
//    [[UINavigationBar appearance] setTitleTextAttributes:@{
//                                                           UITextAttributeTextColor: [UIColor whiteColor],
//                                                           }];
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
//                                      forBarPosition:UIBarPositionAny
//                                          barMetrics:UIBarMetricsDefault];
//    
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];

    [UIDevice removePwd];
    [self testVersion ];
    
    /** Lite版本 */
       // [CoreLaunchLite animWithWindow:self.window image:nil];
    
    /** Plus版本 */
    //    [CoreLaunchPlus animWithWindow:self.window image:nil];
    
    /** Cool版本 */
    //    [CoreLaunchCool animWithWindow:self.window image:nil];
    
    /** Pro版本 */
    [CoreLaunchPro animWithWindow:self.window image:nil];
    
    /** Flip版本 */
     [CoreLaunchFlip animWithWindow:self.window image:nil];

    return YES;
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
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

@end
