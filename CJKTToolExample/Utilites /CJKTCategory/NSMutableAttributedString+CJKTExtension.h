//
//  NSMutableAttributedString+CJKTExtension.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/24.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (CJKTExtension)
#pragma mark - 富文本操作

#pragma mark - 单纯改变一句话中的某些字的颜色（一种颜色）
/**
 *  单纯改变一句话中的某些字的颜色（一种颜色）
 *  @param color    需要改变成的颜色
 *  @param totalStr 总的字符串
 *  @param subArray 需要改变颜色的文字数组(要是有相同的 只取第一个)
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)cjkt_changeCorlorWithColor:(UIColor *)color TotalString:(NSString *)totalStr SubStringArray:(NSArray *)subArray;

#pragma mark - 单纯改变句子的字间距（需要 <CoreText/CoreText.h>）
/**
 *  单纯改变句子的字间距
 *  @param totalString 需要更改的字符串
 *  @param space       字间距
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)cjkt_changeSpaceWithTotalString:(NSString *)totalString Space:(CGFloat)space;

#pragma mark - 单纯改变段落的行间距
/**
 *  单纯改变段落的行间距
 *  @param totalString 需要更改的字符串
 *  @param lineSpace   行间距
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)cjkt_changeLineSpaceWithTotalString:(NSString *)totalString LineSpace:(CGFloat)lineSpace;


#pragma mark - 同时更改行间距和字间距
/**
 *  同时更改行间距和字间距
 *  @param totalString 需要改变的字符串
 *  @param lineSpace   行间距
 *  @param textSpace   字间距
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)cjkt_changeLineAndTextSpaceWithTotalString:(NSString *)totalString LineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace;

#pragma mark - 改变某些文字的颜色 并单独设置其字体
/**
 *  改变某些文字的颜色 并单独设置其字体
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)cjkt_changeFontAndColor:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray;

#pragma mark - 为某些文字改为链接形式
/**
 *  为某些文字改为链接形式
 *  @param totalString 总的字符串
 *  @param subArray    需要改变颜色的文字数组(要是有相同的 只取第一个)
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)cjkt_addLinkWithTotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray;


#pragma mark - 获取某个子字符串在某个总字符串中位置数组
/**
 *  获取某个字符串中子字符串的位置数组
 *  @param totalString 总的字符串
 *  @param subString   子字符串
 *  @return 位置数组
 */
+ (NSMutableArray *)cjkt_getRangeWithTotalString:(NSString *)totalString SubString:(NSString *)subString;
@end

NS_ASSUME_NONNULL_END
