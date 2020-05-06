//
//  UIColor+Extension.h
//  FinancialServices
//
//  Created by kfx_mac on 16/4/18.
//  Copyright © 2016年 Harvie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HWExtension)

+ (UIColor *)colorWithHexString: (NSString *) stringToConvert;

+ (UIColor *)hw_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)hw_colorWithHex:(NSInteger)hexValue;

//app 主色调
+ (UIColor *)hw_mainColor;
///导航栏背景色
+ (UIColor *)hw_navigationBarBgColor;
+ (UIColor *)hw_navigationBarShadowColor;
///导航栏title 颜色
+ (UIColor *)hw_navigationBarTextColor;
///导航栏 Item 颜色
+ (UIColor *)hw_barButtonTextColor;

///标签栏背景色
+ (UIColor *)hw_tabBarBgColor;
///标签栏title颜色
+ (UIColor *)hw_tabBarTitleColor;
///标签栏title选中颜色
+ (UIColor *)hw_tabBarTitleSelectedColor;

///页面背景色
+ (UIColor *)hw_backgroudColor;
///分割线颜色
+ (UIColor *)hw_separateLineColor;

///白色文本
+ (UIColor *)hw_textWhite;
///绿色文本
+ (UIColor *)hw_textGreen;
///黑色文本
+ (UIColor *)hw_textBlack;
///浅黑
+ (UIColor *)hw_textLightBlack;
///灰色文本
+ (UIColor *)hw_textGray;
///橘黄色文本
+ (UIColor *)hw_textOrange;
///红色
+ (UIColor *)hw_textRed;
///蓝色
+ (UIColor *)hw_textBlue;
///控件不可用时的颜色
+ (UIColor *)hw_disableColor;

@end
