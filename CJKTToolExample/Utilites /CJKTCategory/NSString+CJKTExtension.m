//
//  NSString+CJKTExtension.m
//  CJKTCategory
//
//  Created by Dxc_iOS on 2018/11/7.
//  Copyright © 2018 超级课堂. All rights reserved.
//

#import "NSString+CJKTExtension.h"
#import <CoreText/CoreText.h>

@implementation NSString (CJKTExtension)

- (NSString *(^)(NSString *))add{
return ^(NSString *str){
return [self stringByAppendingString:str];
};
}
#pragma mark --  证字符串的类型（手机号、邮箱、验证码、密码等）
+ (BOOL)cjkt_checkStringTypeWithString:(NSString *)string checkingType:(CJKTCheckingType)type {
    
    if (type&captchaChecking) {
        return string.length ==6? YES:NO;
    }
    
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSRange stringRange =NSMakeRange(0, string.length);
    
    if (type&phoneChecking) {
        NSRegularExpression *phoneRE = [NSRegularExpression regularExpressionWithPattern:@"^1[\\d]{10}$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *phoneArray = [phoneRE matchesInString:string options:NSMatchingReportProgress range:stringRange];
        if (phoneArray.count) {
            return YES;
        }
    }
    
    if (type&passwordChecking) { //^[a-zA-Z]\w{5,17}$
        
        NSRegularExpression *passwordRE = [NSRegularExpression regularExpressionWithPattern:@"^[a-zA-Z0-9]{6,18}$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *passwordArr = [passwordRE matchesInString:string options:NSMatchingReportProgress range:stringRange];
        
        if(passwordArr.count) {
            
            return YES;
            
        }
        
        
    }
    
    if (type&EmailChecking) {
        NSRegularExpression *mailRE = [NSRegularExpression regularExpressionWithPattern:@"^([a-zA-Z0-9]+[_|\\_|\\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\\_|\\.]?)*[a-zA-Z0-9]+\\.[a-zA-Z]{2,3}$" options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray *mailArray = [mailRE matchesInString:string options:NSMatchingReportProgress range:stringRange];
        if (mailArray.count) {
            return YES;
        }
        
    }
    
    if(type&qqChecking) {
        
        NSRegularExpression *qqRE = [NSRegularExpression regularExpressionWithPattern:@"^[1-9]\\d{4,14}$" options:NSRegularExpressionCaseInsensitive error:nil];
        
        NSArray *qqArray = [qqRE matchesInString:string options:NSMatchingReportProgress range:stringRange];
        if (qqArray.count) {
            return YES;
        }
        
    }
    
    if(type&nicknameChecking) {
        
        NSRegularExpression *nicknameRE = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5a-zA-Z0-9_]{4,12}$" options:NSRegularExpressionCaseInsensitive error:nil];
        
        NSArray *nickArray = [nicknameRE matchesInString:string options:NSMatchingReportProgress range:stringRange];
        if (nickArray.count) {
            return YES;
        }
        
    }
    
    if(type&usernameCHecking) {
        
        NSRegularExpression *usernameRE = [NSRegularExpression regularExpressionWithPattern:@"^[\u4e00-\u9fa5]{2,5}$" options:NSRegularExpressionCaseInsensitive error:nil];
        
        NSArray *usernameArray = [usernameRE matchesInString:string options:NSMatchingReportProgress range:stringRange];
        if (usernameArray.count) {
            return YES;
        }
        
    }
    
    
    return NO;
}








/**
去除字符串前后的空白,不包含换行符
*/
- (NSString *)cjkt_removebBothSidesWhiteSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)cjkt_removeWhiteSpace
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
}

- (NSString *)cjkt_removeNewLine
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
}

/******************************************************************/
//
//                        NSString文本计算
//
/******************************************************************/

#pragma mark --   计算普通文本 CGSize

- (CGSize)cjkt_getSizeCalculateWithSize:(CGSize)size font:(UIFont *)font {
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
}



#pragma mark --   设置富文本的高度（根据富文本的行间距、字体、宽度）

- (CGSize)cjkt_getAttributionHeightWithString:(NSString *)string lineSpace:(CGFloat)lineSpace font:(UIFont *)font width:(CGFloat)width {
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = lineSpace;
    
    NSDictionary *dict = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:dict
                                       context:nil].size;
    return size;
    
}



/******************************************************************/
//
//                        NSMutableAttributedString富文本操作
//
/******************************************************************/


#pragma mark -- 整句文本设置删除线
+ (NSMutableAttributedString *)cjkt_setDeleteLineWith:(NSString *)string deleteLineColor:(UIColor *)lineColor font:(UIFont *)font{
    
    NSMutableAttributedString * contentStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    //    为某一范围内文字添加多个属性
    [contentStr addAttributes:@{
                                NSStrikethroughStyleAttributeName://(删除线)(无删除线、细单实线、粗单实线、细双实线)
                                @(NSUnderlineStyleSingle),//细单实线
                                NSForegroundColorAttributeName://字体颜色
                                lineColor,
                                NSBaselineOffsetAttributeName://基准线偏移
                                @(0),
                                NSFontAttributeName://字体
                                font
                                } range:NSMakeRange(0, [string length])];
    
    return contentStr;
}

#pragma mark -- 整句文本中某些文字设置删除线
+ (NSMutableAttributedString *)cjkt_setDeleteLineWith:(NSString *)string  deleteLineColor:(UIColor *)lineColor font:(UIFont *)font SubStringArray:(NSArray *)subArray{
    
    NSMutableAttributedString * contentStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    for (NSString *rangeStr in subArray) {
        NSRange range = [string rangeOfString:rangeStr options:NSBackwardsSearch];
        
        //    为某一范围内文字添加多个属性
        [contentStr addAttributes:@{
                                    NSStrikethroughStyleAttributeName://(删除线)(无删除线、细单实线、粗单实线、细双实线)
                                    @(NSUnderlineStyleSingle),//细单实线
                                    NSForegroundColorAttributeName://字体颜色
                                    lineColor,
                                    NSBaselineOffsetAttributeName://基准线偏移
                                    @(0),
                                    NSFontAttributeName://字体
                                    font
                                    } range:range];
    }
    
    
    return contentStr;
}

#pragma mark --  整句富文本设置下划线
+ (NSMutableAttributedString *)cjkt_setUnderLineWith:(NSString *)string underLineColor:(UIColor *)lineColor font:(UIFont *)font{
    NSMutableAttributedString * contentStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    
    [contentStr addAttributes:@{
                                NSUnderlineStyleAttributeName://下划线
                                @(NSUnderlineStyleSingle),
                                NSForegroundColorAttributeName:
                                    lineColor,
                                NSBaselineOffsetAttributeName:
                                    @(0),
                                NSFontAttributeName:
                                    font
                                } range:NSMakeRange(0, [string length])];
    
    return contentStr;
}




#pragma mark --  整句富文本某些文字设置下划线
+ (NSMutableAttributedString *)cjkt_setUnderLineWith:(NSString *)string underLineColor:(UIColor *)lineColor font:(UIFont *)font SubStringArray:(NSArray *)subArray{
    NSMutableAttributedString * contentStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    for (NSString *rangeStr in subArray) {
        NSRange range = [string rangeOfString:rangeStr options:NSBackwardsSearch];
        
        [contentStr addAttributes:@{
                                    NSUnderlineStyleAttributeName://下划线
                                    @(NSUnderlineStyleSingle),
                                    NSForegroundColorAttributeName:
                                        lineColor,
                                    NSBaselineOffsetAttributeName:
                                        @(0),
                                    NSFontAttributeName:
                                        font
                                    } range:range];
    }
    
    
    return contentStr;
}


#pragma mark --  设置文本中的某些字的颜色
+ (NSMutableAttributedString *)cjkt_setCorlorWithColor:(UIColor *)color TotalString:(NSString *)totalStr SubStringArray:(NSArray *)subArray{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalStr];
    for (NSString *rangeStr in subArray) {
        NSRange range = [totalStr rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSForegroundColorAttributeName//颜色
                              value:color range:range];
    }
    return attributedStr;
}

#pragma mark --   设置文本的某些文字的颜色以及其字体
+ (NSMutableAttributedString *)cjkt_setColorAndFont:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    for (NSString *rangeStr in subArray) {
        NSRange range = [totalString rangeOfString:rangeStr options:NSBackwardsSearch];
        [attributedStr addAttribute:NSForegroundColorAttributeName
                              value:color range:range];
        [attributedStr addAttribute:NSFontAttributeName
                              value:font range:range];
    }
    return attributedStr;
}


#pragma mark --   设置富文本行间距

-(NSAttributedString*)cjkt_setAttributedStringWithLineSpace:(CGFloat)lineSpace {
    NSMutableParagraphStyle*paragraphStyle = [NSMutableParagraphStyle new];
    //调整行间距
    paragraphStyle.lineSpacing= lineSpace;
    NSDictionary*attriDict =@{NSParagraphStyleAttributeName:paragraphStyle};
    NSMutableAttributedString*attributedString = [[NSMutableAttributedString  alloc] initWithString:self attributes:attriDict];
    
    return attributedString;
}

#pragma mark --   设置文本的行间距和字间距

+ (NSMutableAttributedString *)cjkt_setLineAndTextSpaceWithTotalString:(NSString *)totalString LineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace {
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:totalString];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [totalString length])];
    long number = textSpace;
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attributedStr addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedStr length])];
    CFRelease(num);
    return attributedStr;
}






/******************************************************************/
//
//                            格式化字符串
//
/******************************************************************/

#pragma mark-- 格式化电话号码(中间四位*号表示)

+(NSString *)cjkt_formatWithPhoneNum:(NSString *)phoneNum{
    //转化成NSMutableString
    NSMutableString *newString = [NSMutableString stringWithString:phoneNum];
    //获得要替换成*号的字符串的range
    NSRange range = NSMakeRange(3, 4);
    //将要替换的字符串替换在指定的range处
    [newString replaceCharactersInRange:range withString:@"****"];
    return newString;
}

#pragma mark -- 电话号码格式化(如151 5816 4437)
/**
 电话号码格式化(如151 5816 4437)
 */
+ (NSString*)cjkt_formatWithMobileStr:(NSString*)mobile{
    NSMutableString *phoneNum = [[NSMutableString alloc]initWithString:mobile];
    [phoneNum insertString:@" " atIndex:3];
    [phoneNum insertString:@" " atIndex:8];
    return phoneNum;
}

#pragma mark -- 格式化银行卡号（前后留4位 中间8位用*号表示)
//+(NSString *)cjkt_formatWithBankCardNum:(NSString *)bankCardNum {
//    if(self.length > 8){
//        NSString *s1 = [self substringWithRange:NSMakeRange(0, 4)];
//        NSString *s2 = [self substringFromIndex:self.length-4];
//        NSString *str = [NSString stringWithFormat:@"%@%@%@",s1,@"**********",s2];
//        return str;
//    }
//    return self;
    
//    //转化成NSMutableString
//    NSMutableString *newString = [NSMutableString stringWithString:bankCardNum];
//    //获得要替换成*号的字符串的range
//    NSRange range = NSMakeRange(3, 4);
//    //将要替换的字符串替换在指定的range处
//    [newString replaceCharactersInRange:range withString:@"****"];
//    return newString;
//}

#pragma mark-- 检查银行卡是否合法
/*
 * 常用信用卡卡号规则
 * Issuer Identifier  Card Number                            Length
 * Diner's Club       300xxx-305xxx, 3095xx, 36xxxx, 38xxxx  14
 * American Express   34xxxx, 37xxxx                         15
 * VISA               4xxxxx                                 13, 16
 * MasterCard         51xxxx-55xxxx                          16
 * JCB                3528xx-358xxx                          16
 * Discover           6011xx                                 16
 * 银联                622126-622925                          16
 *
 * 信用卡号验证基本算法：
 * 偶数位卡号奇数位上数字*2，奇数位卡号偶数位上数字*2。
 * 大于10的位数减9。
 * 全部数字加起来。
 * 结果不是10的倍数的卡号非法。
 * prefrences link:http://www.truevue.org/licai/credit-card-no
 *
 */
- (BOOL)isValidBankCardNumber {
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (int i = (int)self.length - 1; i >= 0; i--) {
        digit = [self characterAtIndex:i] - '0';
        if (timesTwo) {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        } else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

#pragma mark-- 替换银行名
- (NSString *)getBankName {
    if([@"ICBC" isEqualToString:self]){
        return @"工商银行";
    }else if([@"ABC" isEqualToString:self]){
        return @"农业银行";
    }else if([@"BOC" isEqualToString:self]){
        return @"中国银行";
    }else if([@"CCB" isEqualToString:self]){
        return @"建设银行";
    }else if([@"PSBC" isEqualToString:self]){
        return @"邮政储蓄银行";
    }else if([@"CITIC" isEqualToString:self]){
        return @"中信银行";
    }else if([@"CEB" isEqualToString:self]){
        return @"光大银行";
    }else if([@"CMBC" isEqualToString:self]){
        return @"民生银行";
    }else if([@"PAYH" isEqualToString:self]){
        return @"平安银行";
    }else if([@"CIB" isEqualToString:self]){
        return @"兴业银行";
    }else if([@"CMB" isEqualToString:self]){
        return @"招商银行";
    }else if([@"CGB" isEqualToString:self]){
        return @"广发银行";
    }else if([@"HXB" isEqualToString:self]){
        return @"华夏银行";
    }else if([@"SPDB" isEqualToString:self]){
        return @"浦发银行";
    }else if([@"BCCB" isEqualToString:self]){
        return @"北京银行";
    }else if([@"SHBANK" isEqualToString:self]){
        return @"上海银行";
    }else if([@"BOCM" isEqualToString:self]){
        return @"交通银行";
    }
    return @"";
}


#pragma mark -- 格式化金额 分转元 保留两位小数
- (NSString *)formatToTwoDecimal {

    NSDecimalNumber *one = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *two = [NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber *thr = [one decimalNumberByDividingBy:two];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    formatter.positiveFormat = @",###.##";
    NSString *money = [formatter stringFromNumber:[NSNumber numberWithDouble:[thr doubleValue]]];
    
    NSString *result = [NSString stringWithFormat:@"￥%@",money];
    
    if (![result containsString:@"."]) {  //被整除的情况
        result = [NSString stringWithFormat:@"%@.00",result];
    } else {                              //小数不足两位
        NSArray *array = [result componentsSeparatedByString:@"."];
        NSString *subNumber = array.lastObject;
        if (subNumber.length == 1) {
            result = [NSString stringWithFormat:@"%@.%@0",array.firstObject, array.lastObject];
        }
    }
    return result;
}






/******************************************************************/
//
//                            截取字符串
//
/******************************************************************/

/// 截取字符串
/// @param from 开始Index
/// @param to 结束Index
-(NSString*)substringFromIndex:(int)from toIndex:(int)to{
    NSRange range;
    range.location = from;
    range.length = to - from;
    return [self substringWithRange: range];
}
@end
