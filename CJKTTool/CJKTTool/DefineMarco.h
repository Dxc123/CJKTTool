//
//  DefineMarco.h
//  SingleSubjectProject
//
//  Created by Westbrook on 2018/5/22.
//  Copyright © 2018年 cjkt. All rights reserved.
//

#ifndef DefineMarco_h
#define DefineMarco_h


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

/**适配iPhoneX 系列*/

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


///图片Original
#define IMAGE_Original(imageName) [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
///图片
#define IMAGE(imageName) [UIImage imageNamed:imageName]
///设置RGB颜色
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
///随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))



#endif /* DefineMarco_h */
