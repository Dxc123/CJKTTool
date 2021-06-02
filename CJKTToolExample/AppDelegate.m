//
//  AppDelegate.m
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2018/11/28.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import "AppDelegate.h"
#import "QYTabBarViewController.h"
#import "QYLoginViewController.h"
#import "QYNavigationViewController.h"
#import "KSGuaidViewManager.h"

#ifdef DEBUG
#import <DoraemonKit/DoraemonManager.h>
#endif
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [LanguageConfig setSystemLanguage];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunchKey"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLaunchKey"];
        CJKTLog(@"第一次进入");
//       KSGuaidManager.images = @[[UIImage imageNamed:@"guid01"],
//                                    [UIImage imageNamed:@"guid02"],
//                                    [UIImage imageNamed:@"guid03"],
//                                    [UIImage imageNamed:@"guid04"]];
//          KSGuaidManager.shouldDismissWhenDragging = YES;
//          [KSGuaidManager begin];
          self.window.rootViewController = [[QYNavigationViewController alloc] initWithRootViewController:[QYLoginViewController new]]; ;
    }else {
          CJKTLog(@"再次进入");
           self.window.rootViewController = [QYTabBarViewController new]; ;
    }
   
//   #ifdef DEBUG
//   [[DoraemonManager shareInstance] installWithPid:@"productId"];//productId为在“平台端操作指南”中申请的产品id
//   #endif
  
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
