//
//  NSString+CJKTAttributedString.m
//  CJKTAlert
//
//  Created by Dxc_iOS on 2018/9/28.
//  Copyright © 2018 超级课堂. All rights reserved.
//

#import "NSString+CJKTAttributedString.h"

@implementation NSString (CJKTAttributedString)
/**
 *  设置富文本段落样式
 *  @param lineSpeace 行距
 *  @param label      传入前先给label设置好
 *  @返回 富文本
 */
- (NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpeace andAlignment:(NSTextAlignment)alignment andLabel:(UILabel *)label
{
    // 设置段落
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    // 行间距
    paragraphStyle.lineSpacing = lineSpeace;
    
    paragraphStyle.alignment = alignment;
    
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    // NSKernAttributeName字体间距
    NSDictionary *attributes = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@0.8f };
    
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    
    // 创建文字属性
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:label.textColor, NSFontAttributeName:label.font};
    
    [attriStr addAttributes:attriBute range:NSMakeRange(0, self.length)];
    
    return attriStr;
}

/**
 *  计算富文本字体高度
 *  @param lineSpeace 行距
 *  @param label      传入前先给label设置好
 *  @param width      字体所占宽度
 *  @返回 富文本高度
 */
- (CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withLabel:(UILabel *)label andAlignment:(NSTextAlignment)alignment andWidth:(CGFloat)width;
{
    // 段落样式
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    // 行间距
    paragraphStyle.lineSpacing = lineSpeace;
    //    对齐方式
    paragraphStyle.alignment = alignment;
    //   截断模式
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    //NSKernAttributeName字体间距
    NSDictionary *attributes = @{NSFontAttributeName:label.font, NSParagraphStyleAttributeName:paragraphStyle, NSKernAttributeName:@0.8f };
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size.height;
}

@end
