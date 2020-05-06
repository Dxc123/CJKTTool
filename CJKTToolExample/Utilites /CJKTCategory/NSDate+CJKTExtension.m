//
//  NSDate+CJKTExtension.m
//  CJKTCategoryExample
//
//  Created by Dxc_iOS on 2019/11/23.
//  Copyright © 2019 CJKT. All rights reserved.
//

#import "NSDate+CJKTExtension.h"

#define kMinuteTimeInterval (60)
#define kHourTimeInterval   (60 * kMinuteTimeInterval)
#define kDayTimeInterval    (24 * kHourTimeInterval)
#define kWeekTimeInterval   (7  * kDayTimeInterval)
#define kMonthTimeInterval  (30 * kDayTimeInterval)
#define kYearTimeInterval   (12 * kMonthTimeInterval)
@implementation NSDate (CJKTExtension)
#pragma mark - 获取系统当前的时间戳，即当前时间距1970的秒数（以毫秒为单位）
+ (NSString *)cjkt_timestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    /** 当前时间距1970的秒数。*1000 是精确到毫秒，不乘就是精确到秒 */
    NSTimeInterval interval = [date timeIntervalSince1970] * 1000;
    NSString *timeString = [NSString stringWithFormat:@"%0.f", interval];
    
    return timeString;
}

#pragma mark - 获取当前的时间
+ (NSString *)cjkt_currentDateString {
    return [self cjkt_currentDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

#pragma mark - 按指定格式获取当前的时间
+ (NSString *)cjkt_currentDateStringWithFormat:(NSString *)formatterStr {
    // 获取系统当前时间
    NSDate *currentDate = [NSDate date];
    // 用于格式化NSDate对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = formatterStr;
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    // 输出currentDateStr
    return currentDateStr;
}

#pragma mark - 按指定格式返回时间字符串
+ (NSString *)cjkt_dateString:(NSString *)dateString oldFormat:(NSString *)oldFormat newFormat:(NSString *)newFormat {
    // 获取系统当前时间
    NSDate *oldDate = [self cjkt_getDate:dateString format:oldFormat];
    // 用于格式化 NSDate 对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置格式：yyyy-MM-dd HH:mm:ss
    formatter.dateFormat = newFormat;
    // 将 NSDate 按 formatter格式 转成 NSString
    NSString *newDateString = [formatter stringFromDate:oldDate];
    // 输出 newDateString
    return newDateString;
}

#pragma mark - 日期和字符串之间的转换：NSDate --> NSString
+ (NSString *)cjkt_getDateString:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    dateFormatter.dateFormat = format;
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

#pragma mark - 日期和字符串之间的转换：NSString --> NSDate
+ (NSDate *)cjkt_getDate:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    dateFormatter.dateFormat = format;
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    
    return destDate;
}

#pragma mark - 返回指定时间差值的日期字符串
+ (NSString *)cjkt_dateStringWithDelta:(NSTimeInterval)delta {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:delta];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:date];
}

/**
 * @method
 *
 * @cjktief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)cjkt_numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:NSCalendarWrapComponents];
    return comp.day;
}

/**
 计算两个时间相差多少天多少小时多少分多少秒

 @param startTime 开始时间
 @param endTime 结束时间
 @return 时间差
 */
- (NSString *)cjkt_dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate =[date dateFromString:startTime];
    NSDate *endDdate = [date dateFromString:endTime];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponents = [cal components:unitFlags fromDate:startDate toDate:endDdate options:0];
    // 天
    NSInteger day = [dateComponents day];
    // 小时
    NSInteger house = [dateComponents hour];
    // 分
    NSInteger minute = [dateComponents minute];
    // 秒
    NSInteger second = [dateComponents second];
    NSString *timeStr;
    if (day != 0) {
        timeStr = [NSString stringWithFormat:@"%zd天%zd小时%zd分%zd秒", day, house, minute, second];
    } else if (day == 0 && house != 0) {
        timeStr = [NSString stringWithFormat:@"%zd小时%zd分%zd秒", house, minute, second];
    } else if (day == 0 && house == 0 && minute != 0) {
        timeStr = [NSString stringWithFormat:@"%zd分%zd秒", minute, second];
    } else {
        timeStr = [NSString stringWithFormat:@"%zd秒", second];
    }
    
    return timeStr;
}

#pragma mark - 返回日期格式字符串  @"2016-10-16 14:30:30"  @"yyyy-MM-dd HH:mm:ss"
// 注意：一个日期字符串必须 与 它相应的日期格式对应，这个才能被系统识别为日期
+ (NSString *)cjkt_dateDescriptionWithTargetDate:(NSString *)dateStr andTargetDateFormat:(NSString *)dateFormatStr {
    // 1.获取当前时间
    NSDate *currentDate = [NSDate date];
    // 2.目标时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormatStr;
    NSDate *targetDate = [formatter dateFromString:dateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *returnFormatter = [[NSDateFormatter alloc] init];
    if ([calendar isDate:targetDate equalToDate:currentDate toUnitGranularity:NSCalendarUnitYear]) {
        if ([calendar isDateInToday:targetDate]) {
            NSDateComponents *components = [calendar components:NSCalendarUnitMinute | NSCalendarUnitHour fromDate:targetDate toDate:currentDate options:0];
            if (components.hour == 0) {
                if (components.minute == 0) {
                    return @"刚刚";
                } else {
                    return [NSString stringWithFormat:@"%ld分钟前", (long)components.minute];
                }
            } else {
                return [NSString stringWithFormat:@"%ld小时前", (long)components.hour];
            }
        } else if ([calendar isDateInYesterday:targetDate]) {
            return @"昨天";
        } else {
            returnFormatter.dateFormat = @"M-d";
            return [returnFormatter stringFromDate:targetDate];
        }
    } else {
        returnFormatter.dateFormat = @"yyyy-M-d";
        return [returnFormatter stringFromDate:targetDate];
    }
    return nil;
}


- (BOOL)isToday
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    if([today isEqualToDate:otherDate])
    {
        return YES;
    }
    return NO;
}

- (BOOL)isYesterday
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    NSDate *yesterday = [today dateByAddingTimeInterval: -kDayTimeInterval];
    
    components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:self];
    NSDate *otherDate = [cal dateFromComponents:components];
    
    if([yesterday isEqualToDate:otherDate])
    {
        return YES;
    }
    return NO;

}

- (NSString *)shortTimeTextOfDate
{
    NSDate *date = self;
    
    NSTimeInterval interval = [date timeIntervalSinceDate:[NSDate date]];
    
    interval = -interval;
    
    if ([date isToday])
    {
        // 今天的消息
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"aHH:mm"];
        [dateFormat setAMSymbol:@"上午"];
        [dateFormat setPMSymbol:@"下午"];
        NSString *dateString = [dateFormat stringFromDate:date];
        return dateString;
    }
    else if ([date isYesterday])
    {
        // 昨天
        return @"昨天";
    }
    else if (interval < kWeekTimeInterval)
    {
        // 最近一周
        // 实例化一个NSDateFormatter对象
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [dateFormat setDateFormat:@"ccc"];
        NSString *dateString = [dateFormat stringFromDate:date];
        return dateString;
    }
    else
    {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
        
        NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        
        if ([components year] == [today year])
        {
            // 今年
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            
            [dateFormat setDateFormat:@"MM-dd"];
            NSString *dateString = [dateFormat stringFromDate:date];
            return dateString;
        }
        else
        {
            // 往年
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yy-MM-dd"];
            NSString *dateString = [dateFormat stringFromDate:date];
            return dateString;
            
        }
    }
    return nil;
}

- (NSString *)timeTextOfDate
{
    NSDate *date = self;
    
    NSTimeInterval interval = [date timeIntervalSinceDate:[NSDate date]];
    
    interval = -interval;
    
    // 今天的消息
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"aHH:mm"];
    [dateFormat setAMSymbol:@"上午"];
    [dateFormat setPMSymbol:@"下午"];
    NSString *dateString = [dateFormat stringFromDate:date];
    
    if ([date isToday])
    {
        // 今天的消息
        return dateString;
    }
    else if ([date isYesterday])
    {
        // 昨天
        return [NSString stringWithFormat:@"昨天 %@", dateString];
    }
    else if (interval < kWeekTimeInterval)
    {
        // 最近一周
        // 实例化一个NSDateFormatter对象
        NSDateFormatter* weekFor = [[NSDateFormatter alloc] init];
        weekFor.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [weekFor setDateFormat:@"ccc"];
        NSString *weekStr = [weekFor stringFromDate:date];
        return [NSString stringWithFormat:@"%@ %@", weekStr, dateString];
    }
    else
    {
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
        
        NSDateComponents *today = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
        
        if ([components year] == [today year])
        {
            // 今年
            NSDateFormatter *mdFor = [[NSDateFormatter alloc] init];
            [mdFor setDateFormat:@"MM-dd"];
            NSString *mdStr = [mdFor stringFromDate:date];
            return [NSString stringWithFormat:@"%@ %@", mdStr, dateString];
        }
        else
        {
            // 往年
            NSDateFormatter *ymdFormat = [[NSDateFormatter alloc] init];
            [ymdFormat setDateFormat:@"yy-MM-dd"];
            NSString *ymdString = [ymdFormat stringFromDate:date];
            return [NSString stringWithFormat:@"%@ %@", ymdString, dateString];;
            
        }
    }
    return nil;
}
- (NSString *)showWeekDay {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    comps = [calendar components:unitFlags fromDate:self];
    NSString *weekDay = @"";
    switch ([comps weekday]) {
        case 1:
            weekDay = @"周日";
            break;
        case 2:
            weekDay = @"周一";
            break;
        case 3:
            weekDay = @"周二";
            break;
        case 4:
            weekDay = @"周三";
            break;
        case 5:
            weekDay = @"周四";
            break;
        case 6:
            weekDay = @"周五";
            break;
        case 7:
            weekDay = @"周六";
            break;
        default:
            break;
    }
    return weekDay;
}

- (NSString *)showMonthDay {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    comps = [calendar components:unitFlags fromDate:self];
    NSInteger day = [comps day];
    NSInteger month = [comps month];
    return [NSString stringWithFormat:@"%ld/%ld",month,day];
}

@end
