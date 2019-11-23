//
//  CJKTTool.h
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2018/12/29.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, OpenType) {
    OpenTypeWeibo,
    OpenTypeWechat,
    OpenTypeQQ,
    OpenTypeAlipay,
};


@interface CJKTTool : NSObject

#pragma mark - 判断是否是iPhone X系列
/**
 判断是否是iPhone X系列
 */
+ (BOOL)IsiPhoneX;

#pragma mark - 时间格式化
//获取当前时间戳方法，返回10位。
+(NSString *)getCurrentTime;
//时间转化成“刚刚、几分钟前、几小时前、几天前、某月某日几点几分”格式
//注意：后台返回的时间类型  "2016-10-11 12:33:33"
+(NSString *)compareCurrentTime:(NSString *)str;
//注意：后台返回的时间戳包括10位或者有小数点。
//eg：“1480064761” 1480064761.000000
+(NSString *)distanceTimeWithBeforeTime:(double)beTime;

/**
 全面判断字符串为空
 */
+(BOOL)isBlankString:(NSString *)aStr;


#pragma mark - 判断打开QQ、微信、微博
/**
判断打开QQ、微信、微博
 */
+(BOOL)openOtherAppWithOpenType:(OpenType )OpenType;

#pragma mark -  快速创建UILabel
/**
 快速创建UILabel
 */
+(UILabel *)initUILabelWithFrame:(CGRect)frame title:(NSString *)title numberOfLines:(NSInteger)number textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor font:(UIFont *)font;

#pragma mark -  快速创建UIButton
/**
 快速创建UIButton
 */
+ (UIButton *)basicButtonWithFrame:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag backGround:(UIColor *)bgColor textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius font:(UIFont *)font;

#pragma mark -  获取Window当前显示的ViewController
/**
 获取Window当前显示的ViewController
 */
+ (UIViewController *)currentController;

#pragma mark -   AlertViewWithMessage
/**
 AlertViewWithMessage
 */
+ (void)showAlertViewWithMessage:(NSString *)message presentViewController:(UIViewController*)viewController;


#pragma mark-- 16进制数 --> 颜色
/**
 *
 * 16进制颜色(html颜色值)字符串转为UIColor
 *
 **/
+(UIColor *)hexStringToColor:(NSString *)stringToConvert;

#pragma mark --  16进制数 --> 颜色
/**
 根据16进制数生成颜色
 */
+ (UIColor *)uiColorFromString:(NSString *)clrString;



#pragma mark - 格式化时间  （YYYY-MM-dd HH:mm:ss组合 ）
/**
 获取当前时间的时间戳
 */
+ (NSString *)cjkt_getNowTimestamp;

/**
 时间戳—>字符串时间  （YYYY-MM-dd HH:mm:ss 自由组合 ）
 */
+ (NSString *)formatterTimeWithStr:(NSString *)timeInterval fomatter:(NSString *)formatter ;

/**
 时间戳—>字符串时间  （YYYY-MM-dd HH:mm:ss 自由组合 ）
 */
+ (NSString *)cjkt_timeStampToStringWithTimeStampStr:(NSString *)timeStampStr formatter:(NSString *)format;
#pragma mark - 拼接URL
+(NSString *)getUrlWithParametersDic:(NSDictionary *)parametersDic  urlString:(NSString *)urlString;


#pragma mark -- 判断某个界面是否是第一次加载

/**
 判断某个界面是否是第一次加载
 @param key 某个界面的标志
 @return yes：第一次加载 no：反之
 */
+(BOOL)judgeIsFirstLoad:(NSString *)key;


#pragma mark --银行卡号中间部分格式化 如 6222***********5879

+(NSString*)changeBankNum:(NSString*)bankNum;




#pragma mark - 富文本操作

/**
 *  单纯改变一句话中的某些字的颜色（一种颜色）
 *
 *  @param color    需要改变成的颜色
 *  @param totalStr 总的字符串
 *  @param subArray 需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)pj_changeCorlorWithColor:(UIColor *)color TotalString:(NSString *)totalStr SubStringArray:(NSArray *)subArray;
/**
 *  单纯改变句子的字间距（需要 <CoreText/CoreText.h>）
 *
 *  @param totalString 需要更改的字符串
 *  @param space       字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)pj_changeSpaceWithTotalString:(NSString *)totalString Space:(CGFloat)space;

/**
 *  单纯改变段落的行间距
 *
 *  @param totalString 需要更改的字符串
 *  @param lineSpace   行间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)pj_changeLineSpaceWithTotalString:(NSString *)totalString LineSpace:(CGFloat)lineSpace;

/**
 *  同时更改行间距和字间距
 *
 *  @param totalString 需要改变的字符串
 *  @param lineSpace   行间距
 *  @param textSpace   字间距
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)pj_changeLineAndTextSpaceWithTotalString:(NSString *)totalString LineSpace:(CGFloat)lineSpace textSpace:(CGFloat)textSpace;
/**
 *  改变某些文字的颜色 并单独设置其字体
 *
 *  @param font        设置的字体
 *  @param color       颜色
 *  @param totalString 总的字符串
 *  @param subArray    想要变色的字符数组
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)pj_changeFontAndColor:(UIFont *)font Color:(UIColor *)color TotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray;

/**
 *  为某些文字改为链接形式
 *
 *  @param totalString 总的字符串
 *  @param subArray    需要改变颜色的文字数组(要是有相同的 只取第一个)
 *
 *  @return 生成的富文本
 */
+ (NSMutableAttributedString *)pj_addLinkWithTotalString:(NSString *)totalString SubStringArray:(NSArray *)subArray;
#pragma mark - 获取某个子字符串在某个总字符串中位置数组
/**
 *  获取某个字符串中子字符串的位置数组
 *
 *  @param totalString 总的字符串
 *  @param subString   子字符串
 *
 *  @return 位置数组
 */
+ (NSMutableArray *)pj_getRangeWithTotalString:(NSString *)totalString SubString:(NSString *)subString;

#pragma mark -- 设备信息
/**
 app名称
 */
+(NSString *)cjkt_getAPPName;

/**
 app版本
 */
+(NSString *)cjkt_getAPPVersion;

#pragma mark -将所有的空格及字符串去掉
/*将所有的空格及字符串去掉*/
+ (NSString *)removeAllSpaceAndNewline:(NSString *)str;
#pragma mark -去掉字符串两端的空格及回车换行符
/*去掉字符串两端的空格及回车换行符*/
+ (NSString *)removeSpaceAndNewline:(NSString *)str;

#pragma mark --判断输入的字符串是否全为数字
/** 判断输入的字符串是否全为数字*/
+(BOOL)isNum:(NSString *)checkedNumString;

/**
 判断是否更新版本 （服务器请求的版本号>本地版本才跟新 标准格式：1.0.0）
 */
+ (BOOL)checkWithNewVersion: (NSString *)version;


/**
 按字符串本身的长度 拆分成数组
 */
+(NSMutableArray *)DividedByStringLengthWithString:(NSString *)string;

/**
 字符串每隔几位添加一个分割符
 */
+(NSString *)addSeparateStr:(NSString *)separateStr index:(NSInteger )index totalString:(NSString *)totalString;
@end




NS_ASSUME_NONNULL_END
