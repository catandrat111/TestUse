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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window  =[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController* main = [[ViewController alloc] init];
    UINavigationController* navi = [[UINavigationController alloc] initWithRootViewController:main];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
  //  navi.navigationBar.translucent = YES;
   // navi.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    //更改STATUSBAR
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    

    NSString* uuid = [UIDevice  getUDID];
    DLog(@"%@",uuid);
    //6EAA3C6E-3DC6-4F52-B57A-6C29041C33CE//com.test
 
    NSString* uuid1 = [UIDevice  getUDID1];
    DLog(@"%@",uuid1);
  //  [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0xd7000f)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: [UIColor whiteColor],
                                                           }];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];

    [UIDevice removePwd];
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
