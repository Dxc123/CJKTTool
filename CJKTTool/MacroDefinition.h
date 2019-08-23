//
//  MacroDefinition.h
//  CarPooling
//
//  Created by Dxc_iOS on 2018/5/14.
//  Copyright © 2018年 代星创. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h

/**
 获取屏幕 宽度、高度
 */
#define  HDScreenWidth  [UIScreen mainScreen].bounds.size.width
#define  HDScreenHeight [UIScreen mainScreen].bounds.size.height
#define  SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define  SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
/**
 适配iPhoneX
 */
#define IsIphoneX  ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(1125, 2436),[[UIScreen mainScreen] currentMode].size):NO)

#define NaviHight       (IsIphoneX?88:64)
#define TabBarHight     (IsIphoneX?83:49)
#define StatusBarHight  (IsIphoneX?44:20)
#define BottomHight     (IsIphoneX?34:0)

#define HightNoNav            HDScreenHeight-NaviHight
#define HightNoNavAndTabbar   HDScreenHeight-NaviHight-TabBarHight
#define HightNoTabbar         HDScreenHeight-TabBarHight

/**适配iPhoneX 系列*/

//名称                屏幕分辨率    代码获取屏幕大小    使用几倍图    宽高比
//iPhone X           2436×1125    {375, 812}      @3x          0.46182266
//iPhone XS          2436×1125    {375, 812}      @3x          0.46182266
//iPhone XS Max      2688x1242    {414, 896}      @3x          0.46205357
//iPhone XR          1792x828     {414, 896}      @2x          0.46205357

//                           width  height
//5s、se                     {320.0f, 568.0f}
//6、6s、7、8                 {375.0f  667.0f}
//6plus、6splus、7plus、8plus {414.0f 736.0f}

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
//根据屏幕高做的判断
#define iPhoneX (kScreenH == 812.f && kScreenH == 896.f ? YES : NO)
//根据宽高比近似做的判断
//#define iPhoneX ((kScreenW/kScreenH*100) == 46? YES : NO)
#define CF_StatusBarHeight (iPhoneX ? 44.f : 20.f)
#define CF_NavHeight (iPhoneX ? 88.f : 64.f)
#define CF_TabbarSafeBottomMargin (iPhoneX ? 34.f : 0.f)
#define CF_TabbarHeight (iPhoneX ? (49.f+34.f) : 49.f)

/**宽度比例*/
#define ScaleW(__VA_ARGS__)  (kScreenW/375.f)*(__VA_ARGS__)

/**高度比例*/
#define ScaleH(__VA_ARGS__)  (iPhoneX?((kScreenH/812.0f)*(__VA_ARGS__)):((kScreenH/667.0f)*(__VA_ARGS__)))


/**
 打印
 */
#define CJKTLog( s, ... ) printf("[ %s:(%d) ] %s :%s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String])

/**
 全局字体
 */
#define HDFont(__VA_ARGS__) ([UIFont systemFontOfSize:ScaleW(__VA_ARGS__)])

/**
 图片
 */
#define IMAGE_Original(imageName) [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
#define IMAGE(imageName) [UIImage imageNamed:imageName]
/**
 设置颜色
 */
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
/**
 随机颜色
 */
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]
/**
 分割线颜色
 */
#define separeLineColor RGB(206,206,206)

//themeColor
#define themedColor        [Tools hexStringToColor:@"ff6e3c"]
#define BgColor            [Tools hexStringToColor:@"F4F4F7"]
#define BgBlueColor        [Tools hexStringToColor:@"599efe"]
#define BgRedColor         [Tools hexStringToColor:@"fe6f4e"]
#define TextBigColor       [Tools hexStringToColor:@"333333"]
#define TextColor          [Tools hexStringToColor:@"5E5E5E"]
#define TextLightColor     [Tools hexStringToColor:@"cccccc"]
#define LineColor          [Tools hexStringToColor:@"CCCCCC"]
#define LoginBtnColor      [Tools hexStringToColor:@"#424241"]
#define PriceColor         [UIColor colorWithHexString:@"#ee2742"]
/**
 weakSelf
 */
#define HDWeakSelf(type)  __weak typeof(type) weak##type = type;
#define HDStrongSelf(type)  __strong typeof(type) type = weak##type;

#endif /* MacroDefinition_h */
