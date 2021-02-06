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
#define kBase_Url @""
#else
#define kBase_Url @""
#endif

//屏幕宽高
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

///精准打印log
#ifdef DEBUG
#define CJKTLog(s, ... ) printf("[ %s:(%d) ] %s :%s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String])
#else
#define CJKTLog(s, ... )
#endif
//#pragma mark - iOS版本判断
#define CJKTAvailable(version) @available(iOS version, *)

#pragma mark - 适配iPhoneX 系列

//#define iPhoneX (kScreenH == 812.f || kScreenH == 896.f ? YES : NO)
// 根据 keyWindow safeAreaInsets 的 bottom 是否等于 34.0 或者 21.0 来判断设备是否为 iPhone X系列
#define  iPhoneX  [CJKTTool IsiPhoneX]
// 适配刘海屏状态栏高度
#define CF_StatusBarHeight (iPhoneX ? 44.f : 20.f)
// 适配iPhone X 导航栏高度
#define CF_NavHeight (iPhoneX ? 88.f : 64.f)
// 适配iPhone X Tabbar距离底部的距离
#define CF_TabbarSafeBottomMargin (iPhoneX ? 34.f : 0.f)
// 适配iPhone X Tabbar高度
#define CF_TabbarHeight (iPhoneX ? (49.f+34.f) : 49.f)


//按375的屏幕来算的
#define px(a)  a*SCREEN_WIDTH/375
//按667高度的屏幕来的
#define py(a)  a*SCREENH_HEIGHT/667
//按375的屏幕来算的 但是不会超过的最大值
#define pxMax(a) ((SCREEN_WIDTH/375 * a) > a ? a : SCREEN_WIDTH/375 * a)



#pragma mark - 颜色相关
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
///随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

 ///分割线颜色
#define kSepareLineColor RGB(223,229,238)


///图片Original
#define kIMAGE_Original(imageName) [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
///图片
#define kIMAGE(s) [UIImage imageNamed:s]



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

#endif /* DefineMarco_h */
