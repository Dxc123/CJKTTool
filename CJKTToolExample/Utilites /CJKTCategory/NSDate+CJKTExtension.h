//
//  NSDate+CJKTExtension.h
//  CJKTCategoryExample
//
//  Created by Dxc_iOS on 2019/11/23.
//  Copyright © 2019 CJKT. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (CJKTExtension)

/** 获取系统当前的时间戳，即当前时间距1970的秒数（以毫秒为单位） */
+ (NSString *)cjkt_timestamp;

/** 获取当前的时间(yyyy-MM-dd HH:mm:ss) */
+ (NSString *)cjkt_currentDateString;

/**
 *  按指定格式获取当前的时间
 *  @param  formatterStr  设置格式：yyyy-MM-dd HH:mm:ss
 */
+ (nullable NSString *)cjkt_currentDateStringWithFormat:(NSString *)formatterStr;

/**
 *  按指定格式返回时间字符串
 *  @param  dateString  日期字符串
 *  @param  oldFormat   旧格式
 *  @param  newFormat   新格式
 */
+ (nullable NSString *)cjkt_dateString:(NSString *)dateString oldFormat:(NSString *)oldFormat newFormat:(NSString *)newFormat;

/** 日期和字符串之间的转换：NSDate --> NSString */
+ (nullable  NSString *)cjkt_getDateString:(NSDate *)date format:(NSString *)format;

/** 日期和字符串之间的转换：NSString --> NSDate */
+ (nullable  NSDate *)cjkt_getDate:(NSString *)dateString format:(NSString *)format;

/**
 *  返回指定时间差值的日期字符串
 *  @param delta 时间差值
 *  @return 日期字符串，格式：yyyy-MM-dd HH:mm:ss
 */
+ (nullable NSString *)cjkt_dateStringWithDelta:(NSTimeInterval)delta;

/**
 * @cjktief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)cjkt_numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

/**
 计算两个时间相差多少天多少小时多少分多少秒
 @param startTime 开始时间
 @param endTime 结束时间
 @return 时间差
 */
- (nullable NSString *)cjkt_dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

/**
 *  返回日期格式字符串
 *  @param dateStr 需要转换的时间点
 *  @return 日期字符串
 *    返回具体格式如下：
 *      - 刚刚(一分钟内)
 *      - X分钟前(一小时内)
 *      - X小时前(当天)
 *      - MM-dd HH:mm(一年内)
 *      - yyyy-MM-dd HH:mm(更早期)
 */
+ (nullable NSString *)cjkt_dateDescriptionWithTargetDate:(NSString *)dateStr andTargetDateFormat:(NSString *)dateFormatStr;




- (BOOL)isToday;

- (BOOL)isYesterday;

- (NSString *)shortTimeTextOfDate;

- (NSString *)timeTextOfDate;

- (NSString *)showWeekDay;

- (NSString *)showMonthDay;
@end

NS_ASSUME_NONNULL_END
