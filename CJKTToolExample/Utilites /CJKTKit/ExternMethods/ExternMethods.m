//
//  ExternMethods.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2021/2/5.
//  Copyright © 2021 CJKT. All rights reserved.
//

#import "ExternMethods.h"
#import <AdSupport/AdSupport.h>
@implementation ExternMethods

/**
  延迟执行
 */
void kDispatch_after(CGFloat time,dispatch_block_t block){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);

}
/**
主线程更新UI
 */
void kDispatch_mainQueue(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
   
}
/**
  异步执行
 */
void kDispatch_GlobalQueue(dispatch_block_t block) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block();
    });
   
}

/**
 注册通知
 */
void kNoti_AddObserver(id observer,SEL aSelector,NSNotificationName aName){
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:aName object:nil];
}
/**
 发送通知
 */
void kNoti_Post(NSNotificationName aName){
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:nil];
}
/**
移除通知
*/
void kNoti_RemoveObserver(id observer,NSNotificationName aName){
   [[NSNotificationCenter defaultCenter] removeObserver:observer name:aName object:nil];
}

/**
UserDefaults保存key
*/
void kUserDefaultsSaveKey(id object, NSString *key){
     [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
     [[NSUserDefaults standardUserDefaults] synchronize];
}
void kUserDefaultsSaveBool(_Bool value, NSString *key){
     [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
     [[NSUserDefaults standardUserDefaults] synchronize];
}


/**
UserDefaults移除key
*/
void kUserDefaultsRemoveKey(NSString *key){
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
     [[NSUserDefaults standardUserDefaults] synchronize];
}

void kUserDefaultsRemoveAllKey(NSString *key) {
      NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
      NSDictionary *dictionary = userDefatluts.dictionaryRepresentation;;
      for(NSString* key in [dictionary allKeys]){
          if ([key isEqualToString:@"isLogin"]) {
              //除了特殊标识
              continue;
          }
          [userDefatluts removeObjectForKey:key];
          [userDefatluts synchronize];
      }
}


/**
UserDefaults get key
 */
NSString *_Nonnull kUserDefaultsGetKey(NSString *key){
    return  [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
//extern void kUserDefaultsPrintAllKey {
//       NSDictionary *dic = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
//       NSLog(@"所有UserDefaults存储的集合 dic = %@", dic);
//
//}



#pragma mark--  Device设备相关的工具方法
///////////
//Device设备工具方法
//////////


/**systemVersion*/
double  kGetSystemVersion(void){
    return [UIDevice currentDevice].systemVersion.doubleValue;
}





/**appVersion*/
NSString *_Nonnull kGetAppVersion(void){
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

/**appBuildVersion*/
NSString *_Nonnull kGetAppBuildVersion(void){
    return  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}

/**appName*/
NSString *_Nonnull kGetAppName(void){
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

/**bundleIdentifier*/
NSString *_Nonnull kGetBundleIdentifier(void){
    return [[NSBundle mainBundle] bundleIdentifier];
}

/**idfa广告标示符*/
NSString *_Nonnull kGetIdfa(void){
    return [ASIdentifierManager sharedManager].advertisingIdentifier.UUIDString;
}





#pragma mark - 适配iPhoneX 系列
///////////
// 适配iPhoneX 系列
//////////
///


/**屏幕宽*/
CGFloat  kSCREEN_W(void){
    return [UIScreen mainScreen].bounds.size.width;
}

/**屏幕高*/
CGFloat  kSCREENH_H(void){
    return [UIScreen mainScreen].bounds.size.height;
}


/**是否是全面屏*/
BOOL kIsIPhoneX(void){
    if (@available(iOS 11.0,*)) {
           //  iPhone X系列 在竖屏下，keyWindow 的 safeAreaInsets 值为：{top: 44, left: 0, bottom: 34, right: 0}
           //   而在横屏下，其值为：{top: 0, left: 44, bottom: 21, right: 44}
           //   因此，我们可以比较 safeAreaInsets 的 bottom 是否等于 34.0 或者 21.0 来判断设备是否为 iPhone X，因为其他设备对应的 bottom 横竖屏下都为 0
           
           //        获取底部安全域高度，
           CGFloat bottomSafeInset  = [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom;
           
           if (bottomSafeInset == 34.0f || bottomSafeInset == 21.0f) {
               return YES;
           }
       }
       return NO;
}


/**
   获取keyWindow(兼容iOS13)
*/
UIWindow * kGetKeyWindow(void){
    UIWindow        *foundWindow = nil;
    NSArray         *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow   *window in windows) {
        if (window.isKeyWindow) {
            foundWindow = window;
            break;
        }
    }
    return foundWindow;
}

/**状态栏高度*/
CGFloat  kStatusBarHeight(void){
    if (@available(iOS 13.0, *)) {
        return  [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        return  [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}

/**导航栏高度*/
CGFloat  kNavHeight(void){
    if (kIsIPhoneX()) {
        return 88.f;
    }else{
        return 64.f;
    }
}

/**Tabbar高度*/
CGFloat  kTabbarHeight(void){
    if (kIsIPhoneX()) {
        return 49.f + 34.f;
    }else{
        return  49.f ;
    }
}



/**获取底部安全域高度*/
CGFloat kSafeAreaBottomH(void){
    if (@available(iOS 11.0,*)) {
      return [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom;
    }else{
        return 0;
    }
}

/**获取顶部安全域高度*/
CGFloat kSafeAreaTopH(void){
    if (@available(iOS 11.0,*)) {
      return [[[UIApplication sharedApplication] delegate] window].safeAreaInsets.top;
    }else{
        return 0;
    }
}



#pragma mark - 颜色相关

/**RGB颜色*/
UIColor* kRGB(CGFloat r,CGFloat g,CGFloat b,CGFloat a){
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}
UIColor* kRGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a){
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}
/**随机颜色*/
UIColor* kRandomColor(void){
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
}
#pragma mark - 图片相关
/**获取图片*/
UIImage* kIMG(NSString* key){
    return [UIImage imageNamed:key];
}
/**获取原色图片*/
UIImage* kIMG_Original(NSString* key){
    return [[UIImage imageNamed:key]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

/**判断字符串是否为空*/
BOOL kStrIsEmpty(NSString* key){
    return ((key) == nil) || ([(key) isEqual:[NSNull null]]) ||([(key)isEqualToString:@""]);
}
/**判断s数组是否为空*/
BOOL kArrIsEmpty(NSArray* arr){
    return ((arr) == nil) || ([(arr) isEqual:[NSNull null]]) ||([(arr) count] == 0);
}
/**通过key判断字典对应value是否有实际内容*/
BOOL kDicValueIsEmpty(NSDictionary* dic ,NSString* key){
    return ([[dic allKeys] containsObject:key] && (dic[key] != nil) && ![dic[key] isKindOfClass:[NSNull class]]);
}
@end
