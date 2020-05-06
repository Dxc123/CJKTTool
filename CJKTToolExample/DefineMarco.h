//
//  DefineMarco.h
//  SingleSubjectProject
//
//  Created by Westbrook on 2018/5/22.
//  Copyright © 2018年 cjkt. All rights reserved.
//

#ifndef DefineMarco_h
#define DefineMarco_h

#if DEBUG
#define kBase_UrlLink @"http://cc.cxy616.com"
#else
#define kBase_UrlLink @"https://api.wanny.com.cn"
#endif

//屏幕宽高
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

///精准打印log
#ifdef DEBUG
#define CJKTLog(s, ... ) printf("[ %s:(%d) ] %s :%s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String])
#else
#define CJKTLog(s, ... )
#endif



#pragma mark - 适配iPhoneX 系列

//#define iPhoneX (kScreenH == 812.f || kScreenH == 896.f ? YES : NO)
// 根据 keyWindow safeAreaInsets 的 bottom 是否等于 34.0 或者 21.0 来判断设备是否为 iPhone X系列
#define  iPhoneX  [CJKTTool isiPhoneX]
// 适配刘海屏状态栏高度
#define CF_StatusBarHeight (iPhoneX ? 44.f : 20.f)
// 适配iPhone X 导航栏高度
#define CF_NavHeight (iPhoneX ? 88.f : 64.f)
// 适配iPhone X Tabbar距离底部的距离
#define CF_TabbarSafeBottomMargin (iPhoneX ? 34.f : 0.f)
// 适配iPhone X Tabbar高度
#define CF_TabbarHeight (iPhoneX ? (49.f+34.f) : 49.f)


//按375的屏幕来算的
#define px(a)  a*kScreenW/375
//按667高度的屏幕来的
#define py(a)  a*kScreenW/667
//按375的屏幕来算的 但是不会超过的最大值
#define pxMax(a) ((K_WIDTH/375 * a) > a ? a : K_WIDTH/375 * a)



#pragma mark - 颜色
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
///随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]
///随机颜色
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
 ///分割线颜色
#define kSepareLineColor RGB(206,206,206)


///图片Original
#define IMAGE_Original(imageName) [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
///图片
#define IMAGE(imageName) [UIImage imageNamed:imageName]
#define KIMAGE(s) [UIImage imageNamed:s]
///设置RGB颜色



///字符串是否为空
#define kIsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
///数组是否为空
#define kIsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

///通过key判断字典对应value是否有实际内容 
#define kDicValueEmpty(dic,key) ([[dic allKeys] containsObject:key] && (dic[key] != nil) && ![dic[key] isKindOfClass:[NSNull class]])


#pragma mark - 界面跳转
#define kPushNav(x) [self.navigationController pushViewController:(x) animated:YES]
#define kWeakPush(x) [weakSelf.navigationController pushViewController:(x) animated:YES]
#define kPopNav [self.navigationController popViewControllerAnimated:YES]
#define kWeakPop [weakSelf.navigationController popViewControllerAnimated:YES]

#pragma mark - 通知
// 通知中心
#define kNoti_Default   [NSNotificationCenter defaultCenter]
// 发通知参数
#define kNoti_Post_Param(name,userInfoDict)  [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfoDict]
// 发送通知
#define kNotifPost(n, o)  [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]
// 监听通知
#define kNotifAdd(Name,sel)  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sel) name:Name object:nil]
// 通知移除
#define kNotifRemove()  [[NSNotificationCenter defaultCenter] removeObserver:self]

#pragma mark - NSUserDefaults
#define kUserDefaultAdd(o,k)  [[NSUserDefaults standardUserDefaults] setObject:o forKey:k]
#define kGetUserDefault(k)    [[NSUserDefaults standardUserDefaults] objectForKey:k]
#define kRemoveUserDefault(k)    [[NSUserDefaults standardUserDefaults] removeObjectForKey:k]


#pragma mark - block中使用@weakify和@strongify使用
//YYKit和RAC中都有
/**
Synthsize a weak or strong reference.

Example:
   @weakify(self)
   [self doSomething^{
       @strongify(self)
       if (!self) return;
       ...
   }];

*/


/****************************************/
// 用户登录通知
#define NOTIFICATION_USER_LONGIN @"NOTIFICATION_USER_LONGIN"
// 用户登出通知
#define NOTIFICATION_USER_LOGOUT @"NOTIFICATION_USER_LOGOUT"
// 用户登录过期等(400 401),需重新登录
#define NOTIFICATION_USER_RELOGIN @"NOTIFICATION_USER_RELOGIN"
// 用户威钻不足(10000),充值页面
#define NOTIFICATION_USER_V_DIAMONDS_NOT_ENOUGH @"NOTIFICATION_USER_V_DIAMONDS_NOT_ENOUGH"




#endif /* DefineMarco_h */
