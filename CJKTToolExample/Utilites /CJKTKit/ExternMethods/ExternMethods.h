//
//  ExternMethods.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2021/2/5.
//  Copyright © 2021 CJKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ExternMethods : NSObject
// OC,Swift通用方法：参考美团开源日志框架 Logan.h Logan.m
//extern viod  ，意思就是外部调用函数(extern 也可省略)
//static viod  指函数是内部函数，不允许外部调用。
/**
  延迟执行
 */
extern void kDispatch_after(CGFloat time,dispatch_block_t block);
/**
 主线程更新UI
 */
extern void kDispatch_mainQueue(dispatch_block_t block);
/**
  异步执行(耗时的操作)
 */
extern void kDispatch_GlobalQueue(dispatch_block_t block);
/**
 注册通知
 */
extern void kNoti_AddObserver(id observer,SEL aSelector,NSNotificationName aName);
/**
 发送通知
 */
extern void kNoti_Post(NSNotificationName aName);

/**
移除通知
*/
extern void kNoti_RemoveObserver(id observer,NSNotificationName aName);

/**
 UserDefaults保存key
*/
extern void kUserDefaultsSaveKey(id object, NSString *key);
extern void kUserDefaultsSaveBool(_Bool value, NSString *key);
 
 
/**
UserDefaults移除key
*/
extern void kUserDefaultsRemoveKey(NSString *key);
extern void kUserDefaultsRemoveAllKey(NSString *key);
//extern void kUserDefaultsPrintAllKey;

/**
UserDefaults get key
 */
NSString *_Nonnull kUserDefaultsGetKey(NSString *key);

#pragma mark--  Device设备 app相关的工具方法
///////////
//Device设备工具方法
//////////

/**systemVersion*/
double  kGetSystemVersion(void);

/**appVersion*/
NSString *_Nonnull kGetAppVersion(void);

/**appBuildVersion*/
NSString *_Nonnull kGetAppBuildVersion(void);

/**appName*/
NSString *_Nonnull kGetAppName(void);

/**bundleIdentifier*/
NSString *_Nonnull kGetBundleIdentifier(void);

/**idfa广告标示符*/
NSString *_Nonnull kGetIdfa(void);


#pragma mark - 适配iPhoneX 系列
///////////
// 适配iPhoneX 系列
//////////


/**屏幕宽*/
CGFloat  kSCREEN_W(void);

/**屏幕高*/
CGFloat  kSCREENH_H(void);

/**是否是全面屏*/
BOOL kIsIPhoneX(void);
/**
   获取keyWindow(兼容iOS13)
*/
UIWindow * kGetKeyWindow(void);
/**状态栏高度*/
CGFloat  kStatusBarH(void);
/**导航栏高度*/
CGFloat  kNavBarH(void);
/**Tabbar高度*/
CGFloat  kTabbarH(void);
/**获取底部安全域高度*/
CGFloat kSafeAreaBottomH(void);
/**获取顶部安全域高度*/
CGFloat kSafeAreaTopH(void);

#pragma mark - 颜色相关

/**RGB颜色*/
UIColor* kRGB(CGFloat r,CGFloat g,CGFloat b,CGFloat a);
/**RGBA颜色*/
UIColor* kRGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a);
/**随机颜色*/
UIColor* kRandomColor(void);

#pragma mark - 图片相关
/**获取图片*/
UIImage* kIMG(NSString* key);
/**获取原色图片*/
UIImage* kIMG_Original(NSString* key);


/**判断字符串是否为空*/
BOOL kStrIsEmpty(NSString* key);
/**判断s数组是否为空*/
BOOL kArrIsEmpty(NSArray* arr);
/**通过key判断字典对应value是否有实际内容*/
BOOL kDicValueIsEmpty(NSDictionary* dic ,NSString* key);
@end

NS_ASSUME_NONNULL_END
