//
//  UIColor+CJKTExtention.h
//  CJKTCategory
//
//  Created by Dxc_iOS on 2018/11/7.
//  Copyright © 2018 超级课堂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CJKTExtention)


#pragma mark -- 将rgb转换成颜色
/**
 将rgb转换成颜色
 @param R 红色
 @param G 绿色
 @param B 蓝色
 @return uicolor对象
 */
+ (UIColor *)cjkt_colorWithRGB:(CGFloat)R green:(CGFloat)G blue:(CGFloat)B;


#pragma mark -- 将rgba转换成颜色
/**
 将rgba转换成颜色
 @param R 红色
 @param G 绿色
 @param B 蓝色
 @param alpha 透明度
 @return uicolor对象
 */
+ (UIColor *)cjkt_colorWithRGBWithAlpha:(CGFloat)R green:(CGFloat)G blue:(CGFloat)B alpha:(CGFloat)alpha;


#pragma mark -- 根据16进制数生成颜色
/**
 根据16进制数生成颜色
 @param hexString 16进制
 @return uicolor对象
 */
+ (UIColor *)cjkt_colorWithHexString:(NSString *) hexString;


#pragma mark -- 根据16进制数生成颜色(带透明度)
/**
 根据16进制数生成颜色
 @param hexString 16进制
 @param alpha 透明度
 @return uicolor对象
 */
+ (UIColor *)cjkt_colorWithHexString:(NSString *) hexString alpha:(double)alpha;

#pragma mark -- 产生一个随机色，大部分情况下用于测试
/**
 *  产生一个随机色，大部分情况下用于测试
 */
+ (UIColor *)cjkt_randomColor;

@end
