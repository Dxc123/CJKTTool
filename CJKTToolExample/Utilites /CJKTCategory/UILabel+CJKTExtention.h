//
//  UILabel+CJKTExtention.h
//  CJKTCategory
//
//  Created by Dxc_iOS on 2018/11/7.
//  Copyright © 2018 超级课堂. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (CJKTExtention)
//内边距属性
@property (nonatomic, assign) UIEdgeInsets contentInset;

#pragma mark --根据字符串，字体，计算UILabel宽度
/**
 根据字符串，字体，计算UILabel宽度
 */
+ (CGFloat)cjkt_getWidthWithTitle:(NSString *)title font:(UIFont *)font;

#pragma mark --根据字符串，字体，宽度，计算UILabel高度
/**
 根据字符串，字体，宽度，计算UILabel高度
 */
+ (CGFloat)cjkt_getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

@end

NS_ASSUME_NONNULL_END
