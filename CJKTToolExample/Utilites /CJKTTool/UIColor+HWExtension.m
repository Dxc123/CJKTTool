//
//  UIColor+Extension.m
//  FinancialServices
//
//  Created by kfx_mac on 16/4/18.
//  Copyright © 2016年 Harvie. All rights reserved.
//

#define WHITE_HEX_COLOR @"c1c1c1"
#define RED_HEX_COLOR @"#ff4746"
#define YELLOW_HEX_COLOR @"ffff00"
#define GREEN_HEX_COLOR @"77d850"
#define SELECT_HEX_COLOR @"0f2439"
#define DEFAULT_VOID_COLOR [UIColor whiteColor]

#import "UIColor+HWExtension.h"

@implementation UIColor (HWExtension)

+ (UIColor *)colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)hw_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}
+ (UIColor *)hw_colorWithHex:(NSInteger)hexValue
{
    return [UIColor hw_colorWithHex:hexValue alpha:1.0];
}

//app 主色调
+ (UIColor *)hw_mainColor
{
    return [UIColor hw_colorWithHex:0xffc71a];
}
//导航栏背景色
+ (UIColor *)hw_navigationBarBgColor
{
//    return [UIColor hw_colorWithHex:0xffc71a];
    return [UIColor whiteColor];
}
+ (UIColor *)hw_navigationBarShadowColor
{
//    return [UIColor hw_colorWithHex:0xcac8c8];
    return [UIColor hw_colorWithHex:0xe2e2e2];
}
///导航栏title 颜色
+ (UIColor *)hw_navigationBarTextColor
{
    return [UIColor hw_colorWithHex:0x000000];
}
///导航栏 Item 颜色
+ (UIColor *)hw_barButtonTextColor
{
    return [UIColor hw_navigationBarTextColor];
}

//标签栏背景色
+ (UIColor *)hw_tabBarBgColor
{
    return [UIColor whiteColor];
}
//标签栏title颜色
+ (UIColor *)hw_tabBarTitleColor
{
    return [UIColor hw_colorWithHex:0x626262];
}
//标签栏title选中颜色
+ (UIColor *)hw_tabBarTitleSelectedColor
{
    return [UIColor hw_colorWithHex:0x626262];
}
//页面背景色
+ (UIColor *)hw_backgroudColor
{
    return [UIColor hw_colorWithHex:0xf5f7fb];
}
//分割线颜色
+ (UIColor *)hw_separateLineColor
{
    return [UIColor hw_colorWithHex:0xdedede];
}

///白色文本
+ (UIColor *)hw_textWhite
{
    return [UIColor whiteColor];
}
///绿色文本
+ (UIColor *)hw_textGreen
{
    return [UIColor hw_colorWithHex:0x5cb531];
}
///黑色文本
+ (UIColor *)hw_textBlack
{
    return [UIColor hw_colorWithHex:0x454545];
}
///浅黑
+ (UIColor *)hw_textLightBlack
{
    return [UIColor hw_colorWithHex:0x606060];
}
///灰色文本
+ (UIColor *)hw_textGray
{
    return [UIColor hw_colorWithHex:0x838383];
}
///橘黄色文本
+ (UIColor *)hw_textOrange
{
    return [UIColor hw_colorWithHex:0xff7f00];
}
///红色
+ (UIColor *)hw_textRed
{
    return [UIColor hw_colorWithHex:0xf30000];
}
///蓝色
+ (UIColor *)hw_textBlue
{
    return [UIColor hw_colorWithHex:0x14b3f5];
}
///控件不可用时的颜色
+ (UIColor *)hw_disableColor
{
    return [UIColor hw_colorWithHex:0xbebebe];
}

@end
