//
//  NSString+CJKTAttributedString.h
//  CJKTAlert
//
//  Created by Dxc_iOS on 2018/9/28.
//  Copyright © 2018 超级课堂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (CJKTAttributedString)
/**
 *  设置富文本段落样式
 *  @param lineSpeace 行距
 *  @param label      传入前先给label设置好
 *  @返回 富文本
 */
- (NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpeace andAlignment:(NSTextAlignment)alignment andLabel:(UILabel *)label;

/**
 *  计算富文本字体高度
 *  @param lineSpeace 行距
 *  @param label      传入前先给label设置好
 *  @param width      字体所占宽度
 *  @返回 富文本高度
 */
- (CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withLabel:(UILabel *)label andAlignment:(NSTextAlignment)alignment andWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
