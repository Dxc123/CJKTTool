//
//  NSString+CJKTExtension.h
//  CJKTCategory
//
//  Created by Dxc_iOS on 2018/11/7.
//  Copyright © 2018 超级课堂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CJKTCheckingType) {
    phoneChecking       =  1 << 0,//手机号
    EmailChecking       =  1 << 1,//邮箱
    captchaChecking     =  1 << 2,//验证码
    passwordChecking    =  1 << 3,//密码
    qqChecking          =  1 << 4,//qq号
    nicknameChecking    =  1 << 5,//昵称
    usernameCHecking    =  1 << 6 //真实姓名
};




@interface NSString (CJKTExtension)
//拼接字符串
@property (nonatomic,readonly) NSString *(^add)(NSString* str);

#pragma mark --  验证字符串的类型（手机号、邮箱、验证码、密码等）

/**
 验证手机号
 @param string 字符串
 @param type 类型
 @return 返回是、否
 */
+ (BOOL)cjkt_checkStringTypeWithString:(NSString *)string checkingType:(CJKTCheckingType)type;


#pragma mark --   计算普通文本 CGSize
/**
 计算普通文本 CGSize
 @param size 限定最大大小
 @param font 字体
 @return 字符串大小
 */
- (CGSize)cjkt_getSizeCalculateWithSize:(CGSize)size font:(UIFont *)font;


#pragma mark --  设置富文本的高度（根据富文本的行间距、字体、宽度）

/**
 设置富文本的高度（根据富文本的行间距、字体、宽度）
 @param string 需要改变的字符串
 @param lineSpace 行间距
 @param font 字体大小
 @param width 宽度
 @return 生成的富文本
 */
- (CGSize)cjkt_getAttributionHeightWithString:(NSString *)string lineSpace:(CGFloat)lineSpace font:(UIFont *)font width:(CGFloat)width;


#pragma mark --  整句文本设置删除线
/**
 整句文本设置删除线
 */
+ (NSMutableAttributedString *)cjkt_setDeleteLineWith:(NSString *)string deleteLineColor:(UIColor *)lineColor font:(UIFont *)font;

#pragma mark -- 整句文本中某些文字设置删除线
/**
 整句文本中某些文字设置删除线
 */

/**例如
 deleteLab.text = @"￥100喔喔是按部就班不能看你千千万";
  NSMutableAttributedString *attritu = [NSString cjkt_setDeleteLineWith:deleteLab.text deleteLineColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:16.f] SubStringArray:@[@"按部就班",@"千千万"]];
  [deleteLab setAttributedText:attritu];
 */
+ (NSMutableAttributedString *)cjkt_setDeleteLineWith:(NSString *)string deleteLineColor:(UIColor *)lineColor font:(UIFont *)font SubStringArray:(NSArray *)subArray;

#pragma mark -- 整句文本设置下划线
/**
 整句文本设置下划线
 */
+ (NSMutableAttributedString *)cjkt_setUnderLineWith:(NSString *)string underLineColor:(UIColor *)lineColor font:(UIFont *)font;

#pragma mark --  整句文本的某些文字设置下划线
/**
 整句文本的某些文字设置下划线
 */
+ (NSMutableAttributedString *)cjkt_setUnderLineWith:(NSString *)string underLineColor:(UIColor *)lineColor font:(UIFont *)font SubStringArray:(NSArray *)subArray;

#pragma mark --  设置文本中的某些字的颜色
/**
 *  设置文本中的某些字的颜色
 *  @param color    需要改变成的颜色
 *  @param totalStr 总的字符串
 *  @param subArray 需要改变颜色的文字数组
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)cjkt_setCorlorWithColor:(UIColor *)color TotalString:(NSString *)totalStr SubStringArray:(NSArray *)subArray;


#pragma mark --   设置文本的某些文字的颜色以及其字体
/**
 *  设置文本的某些文字的颜色以及其字体
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)cjkt_setColorAndFont:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray;



#pragma mark --   设置富文本的行间距
/**
 设置 富文本的行间距
 @param lineSpace 行间距
 @return 富文本
 */
-(NSAttributedString*)cjkt_setAttributedStringWithLineSpace:(CGFloat)lineSpace;


#pragma mark --   设置文本的行间距和字间距
/**
 *  设置文本的行间距和字间距
 *
 *  @param totalString 需要改变的字符串
 *  @param lineSpace   行间距
 *  @param textSpace   字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)cjkt_setLineAndTextSpaceWithTotalString:(NSString *)totalString LineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace;

/***********************************************************/




#pragma mark -- 格式化电话号码（中间四位*号表示）
/**
 格式化电话号码（中间四位*号表示）
 */
+(NSString *)cjkt_formatWithPhoneNum:(NSString *)phoneNum;

#pragma mark -- 电话号码格式化(如151 5816 4437)
/**
 电话号码格式化(如151 5816 4437)
 */
+ (NSString*)cjkt_formatWithMobileStr:(NSString*)mobile;

#pragma mark -- 格式化银行卡号（前后留4位 中间8位用*号表示)
/**
格式化银行卡号（前后留4位 中间8位用*号表示)
 */
+(NSString *)cjkt_formatWithBankCardNum:(NSString *)bankCardNum;

#pragma mark -- 银行卡号校验
/**
 银行卡号校验
 */
- (BOOL)isValidBankCardNumber;

#pragma mark --  替换银行名
/**
 替换银行名
 */
- (NSString *)getBankName;


//#pragma mark --  格式化金额 (分转元,保留两位小数)
///**
//  格式化金额 (分转元,保留两位小数)
// */ 格式化金额 (分转元,保留两位小数)
//- (NSString *)formatToTwoDecimal;
@end
