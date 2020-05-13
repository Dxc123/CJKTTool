//
//  CJKTTool.m
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2018/12/29.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import "CJKTTool.h"
#import "CJKTMessageAlertView.h"
#import <CoreText/CoreText.h>
#define BASE_SERVICE  @"http://client.17laizhuanqian.com/client"
@implementation CJKTTool

#pragma mark - 判断是否是iPhone X系列
+ (BOOL)IsiPhoneX {
    if (@available(iOS 11.0,*)) {
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        
        //  iPhone X系列 在竖屏下，keyWindow 的 safeAreaInsets 值为：{top: 44, left: 0, bottom: 34, right: 0}
        //   而在横屏下，其值为：{top: 0, left: 44, bottom: 21, right: 44}
        //   因此，我们可以比较 safeAreaInsets 的 bottom 是否等于 34.0 或者 21.0 来判断设备是否为 iPhone X，因为其他设备对应的 bottom 横竖屏下都为 0
        
        //        获取底部安全域高度，
        CGFloat bottomSafeInset  = keyWindow.safeAreaInsets.bottom;
        
        if (bottomSafeInset == 34.0f || bottomSafeInset == 21.0f) {
            return YES;
        }
    }
    return NO;
    
    
}

+(UIWindow*)keyWindow{
    UIWindow        *foundWindow = nil;
    NSArray         *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow   *window in windows) {
        if (window.isKeyWindow) {
            foundWindow = window;
            break;
        }
    }
    return foundWindow;
}

/**
  延迟执行
 */
void GCD_AFTER(CGFloat time,dispatch_block_t block)
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

/**
 注册通知
 */
void MM_AddObserver(id observer,SEL aSelector,NSNotificationName aName)
{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:aName object:nil];
}

/**
 发送通知
 */
void MM_PostNotification(NSNotificationName aName,id anObject)
{
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
}


#pragma mark -- 时间格式化******/
#pragma mark -- 获取当前时间戳
+(NSString *)getCurrentTime{
    NSDate *senddata = [NSDate date];
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddata timeIntervalSince1970]];
    return date2;
}
+(NSString *) compareCurrentTime:(NSString *)str
{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    // timeInterval = timeInterval - 86060;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    else if((temp = timeInterval/60) <60){
        
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
        
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
//    else{
//        temp = temp/12;
//        result = [NSString stringWithFormat:@"%ld年前",temp];
//    }
    else{
        if (str.length>5) {
            NSArray *strArr = [str componentsSeparatedByString:@" "];
             result = [strArr firstObject];
        }else{
            result = str;
        }
       
    }
    
    return  result;
    
}

+(NSString *)distanceTimeWithBeforeTime:(double)beTime
{
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString *distanceStr;
    
    NSDate *beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString *nowDay = [df stringFromDate:[NSDate date]];
    NSString *lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {
        
        distanceStr = @"刚刚";
        
    }
    else if (distanceTime <60*60) {
        
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
        
    }
    else if(distanceTime <246060 && [nowDay integerValue] == [lastDay integerValue]){
        
        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
        
    }
    else if(distanceTime<246060*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        
    }
    else if(distanceTime <246060*365){
        
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
        
    }
    else{
        
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
        
    }
    return distanceStr;
}

/***#pragma mark -- 时间格式化******/
/********************************/

/**
 全面判断字符串为空
 */
+(BOOL)isBlankString:(NSString *)aStr {
    if (!aStr) {//只要aStr的指针值为0, 就可断定它为空
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {//NSNull类
        return YES;
    }
    if (!aStr.length) {//字符串中没有任何字符, 也就是长度为0
        return YES;
    }
    //    字符串中除了空格和换行以外没有任何字符
    // 创建一个字符集对象, 包含所有的空格和换行字符
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    // 从字符串中过滤掉首尾的空格和换行, 得到一个新的字符串
    NSString *trimmedStr = [aStr stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {// 判断新字符串的长度是否为0
        return YES;
    }
    return NO;
}

#pragma mark - 判断打开QQ、微信、微博
+(BOOL)openOtherAppWithOpenType:(OpenType )OpenType{
    
    switch (OpenType) {
        case OpenTypeWeibo:
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sinaweibo://"]]) {
                return YES;
            }else{
                
                return NO;
            }
            break;
        }
        case OpenTypeQQ:
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
                return YES;
                
            }else{
                return NO;
            }
            
            break;
        }
        case OpenTypeWechat:
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://wx977b586715e97e2a"]]) {
                return YES;
            }else{
                return NO;
            }
            
            break;
            
        }
        case OpenTypeAlipay:
        {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"alipay://"]]) {
                return YES;
            }else{
                return NO;
            }
            
            break;
            
        }
        default:
            break;
    }
    
    return NO;
}

#pragma mark -- 快速创建UILabel
+(UILabel *)initUILabelWithFrame:(CGRect)frame title:(NSString *)title numberOfLines:(NSInteger)number textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor *)textColor font:(UIFont *)font{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = title;
    lab.textColor = textColor;
    lab.textAlignment = textAlignment;
    lab.font = font;
    lab.numberOfLines = number;
    return lab;
}


#pragma mark --  快速创建UIButton
+ (UIButton *)initUIButtonWithFrame:(CGRect)frame title:(NSString *)title tag:(NSInteger)tag backGround:(UIColor *)bgColor textColor:(UIColor *)textColor borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius font:(UIFont *)font
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    button.backgroundColor = bgColor;
    button.layer.borderWidth = borderWidth;
    button.layer.borderColor = borderColor.CGColor;
    button.layer.cornerRadius = cornerRadius;
    button.titleLabel.font = font;
    [button.titleLabel sizeToFit];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)initUIButtonWithFrame:(CGRect)frame imgNormal:(NSString *)imgNormal imgSelected:(NSString *)imgSelected{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imgSelected] forState:UIControlStateSelected];
    return button;
}



#pragma mark -- 获取Window当前显示的ViewController
//获取Window当前显示的ViewController
+ (UIViewController*)currentController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
     //方法2：遍历方法
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        else if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        else if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    
   
    
    return vc;
}




#pragma mark -- AlertViewWithMessage
+ (void)showAlertViewWithMessage:(NSString *)message presentViewController:(UIViewController*)viewController {
    
    if (!viewController) {
        
        viewController = [self currentController];
        
    }
    
    CGFloat timeInterval = 1.5;
    
    CJKTMessageAlertView *alertView =[[CJKTMessageAlertView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(viewController.view.frame), CGRectGetHeight(viewController.view.frame))];
    [viewController.view.window addSubview:alertView];
    alertView.dismissInterval = timeInterval;
    alertView.message = message;
    
}
#pragma mark---- 16进制数 --> 颜色
//16进制颜色(html颜色值)字符串转为UIColor

+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
#pragma mark --  16进制数 --> 颜色
//根据@"#eef4f4"得到UIColor
+ (UIColor *)uiColorFromString:(NSString *) clrString
{
    return [self uiColorFromString:clrString alpha:1.0];
}
+ (UIColor *)uiColorFromString:(NSString *) clrString alpha:(double)alpha
{
    if ([clrString length] == 0) {
        return [UIColor clearColor];
    }
    
    if ( [clrString caseInsensitiveCompare:@"clear"] == NSOrderedSame) {
        return [UIColor clearColor];
    }
    
    if([clrString characterAtIndex:0] == 0x0023 && [clrString length]<8)
    {
        const char * strBuf= [clrString UTF8String];
        
        NSInteger iColor = strtol((strBuf+1), NULL, 16);
        typedef struct colorByte
        {
            unsigned char b;
            unsigned char g;
            unsigned char r;
        }CLRBYTE;
        CLRBYTE * pclr = (CLRBYTE *)&iColor;
        return [UIColor colorWithRed:((double)pclr->r/255.f) green:((double)pclr->g/255.f) blue:((double)pclr->b/255) alpha:alpha];
    }
    return [UIColor blackColor];
}

#pragma mark - 格式化时间  （YYYY-MM-dd HH:mm:ss组合 ）
+ (NSString *)formatterTimeWithStr:(NSString *)timeInterval fomatter:(NSString *)formatter {
    
    return [self formatterTimeWithStr:timeInterval fomatter:formatter timeZone:@"Asia/Shanghai"];//@"Asia/Beijing"
    
}

+ (NSString *)formatterTimeWithStr:(NSString *)timeInterval fomatter:(NSString *)formatter timeZone:(NSString *)timeZone {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:timeZone];
    [dateFormatter setDateFormat:formatter];
    
    NSDate* nowDate = [NSDate dateWithTimeIntervalSince1970:[timeInterval doubleValue]];
    
    return [dateFormatter stringFromDate:nowDate];
    
}


/**
 获取当前时间的时间戳
 */
+ (NSString *)cjkt_getNowTimestamp {
    NSDate *newDate = [NSDate date];
    long int timeSp = (long)[newDate timeIntervalSince1970];
    NSString *tempTime = [NSString stringWithFormat:@"%ld",timeSp];
    return tempTime;
}
/**
 时间戳—>字符串时间 //@"yyyy-MM-dd HH:mm" 组合 ,hh与HH的区别:分别表示12小时制,24小时制
 */
+ (NSString *)cjkt_timeStampToStringWithTimeStampStr:(NSString *)timeStampStr formatter:(NSString *)format{
    if (timeStampStr.length == 0) {
        return @"";
    }
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStampStr doubleValue] / 1000.0 - 28800/**/;
    //如果不使用本地时区,因为时差问题要加8小时 == 28800 sec
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    //    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:format];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

#pragma mark - 拼接URL

+(NSString *)getUrlWithParametersDic:(NSDictionary *)parametersDic  urlString:(NSString *)urlString{
    NSMutableString *keyValue = [[NSMutableString alloc]init];
    [parametersDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [keyValue appendFormat:@"%@=%@&",key,(NSString *)obj];
    }];
    NSString *url = [NSString stringWithFormat:@"%@/%@?%@",BASE_SERVICE,urlString,keyValue];
    
    return  url;
}


#pragma mark -- 判断某个界面是否是第一次加载
+(BOOL)judgeIsFirstLoad:(NSString *)key {
    
    BOOL is_second = [[NSUserDefaults standardUserDefaults] boolForKey:key];
    
    if(!is_second) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
        
    }else {
        
        return NO;
        
    }
    
}

#pragma mark --银行卡号中间部分格式化 如 6222***********5879
//6222***********5879

+(NSString*)changeBankNum:(NSString*)bankNum{
    /**
     // 银行卡号
     
     NSString *originalString = bankNum;//@"6217613400004525213";
     
     // 转换成可变字符串
     
     NSMutableString *stringM = [NSMutableString stringWithFormat:@"%@",originalString];
     
     NSRange range = {4,stringM.length -4};
     
     [stringM deleteCharactersInRange:range];
     
     //    NSLog(@"留下前面需要的字符串%@",stringM);
     
     [stringM appendString:@"***********"];//个数根据银行卡号长度规则而定
     
     //    NSLog(@"拼接隐藏个数%@",stringM);
     NSMutableString *endString = [NSMutableString stringWithFormat:@"%@",originalString];
     
     NSRange endRange = {0,stringM.length};
     
     [endString deleteCharactersInRange:endRange];
     
     
     //    NSLog(@"留下末尾需要的字符串%@",endString);
     
     [stringM appendString:endString];
     
     //    NSLog(@"拼接后最终效果%@",stringM);
     
     
     return stringM;
     
     */
    
    
    NSString *formerStr = [bankNum substringToIndex:4];
    NSString *str1 = [bankNum stringByReplacingOccurrencesOfString:formerStr withString:@""];
    NSString *endStr = [bankNum substringFromIndex:bankNum.length-4];
    NSString *str2 = [str1 stringByReplacingOccurrencesOfString:endStr withString:@""];
    NSString *middleStr = [str2 stringByReplacingOccurrencesOfString:str2 withString:@"********"];//个数根据银行卡号长度规则而定
    NSString *CardNumberStr = [formerStr stringByAppendingFormat:@"%@%@",middleStr,endStr];
    return CardNumberStr;
    
    
    
}





/**
 app名称
 */
+(NSString *)cjkt_getAPPName{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];//获取信息
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return app_Name;
}
/**
 app版本
 */

+(NSString *)cjkt_getAPPVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];//获取信息
    
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //      NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    //    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    //    NSString* userPhoneName = [[UIDevice currentDevice] name];//用户定义的名称
    //    NSString* deviceName = [[UIDevice currentDevice] systemName]; //设备名称
    //    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion]; //手机系统版本
    //    NSString* phoneModel = [[UIDevice currentDevice] model];//手机型号
    //    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel]; //地方型号  （国际化区域名称）
    
    return app_Version;
}

#pragma mark -将所有的空格及回车换行符
+ (NSString *)removeAllSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}
#pragma mark -去掉字符串两端的空格及回车换行符
+ (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    return text;
}


#pragma mark --判断输入的字符串是否全为数字
+(BOOL)isNum:(NSString *)checkedNumString {
    //   1、利用NSCharacterSet的stringByTrimmingCharactersInSet方法。
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
    /**
     //    2、用NSScanner类来判断 ,NSScanner是一个类，用于在字符串中扫描指定的字符。
     
     NSScanner* scan = [NSScanner scannerWithString:checkedNumString];
     int val;
     return[scan scanInt:&val] && [scan isAtEnd];
     
     //    3、正则
     if (checkedNumString.length == 0) {
     return NO;
     }
     NSString *regex = @"[0-9]*";
     NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
     if ([pred evaluateWithObject:checkedNumString]) {
     return YES;
     }
     return NO;
     */
    
    
}



// 判断是否更新版本 （服务器请求的版本号>本地版本才跟新 标准格式：1.0.0）
+ (BOOL)checkWithNewVersion: (NSString *)version
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *first = infoDict[@"CFBundleShortVersionString"];
    NSArray *versions1 = [first componentsSeparatedByString:@"."];
    NSArray *versions2 = [version componentsSeparatedByString:@"."];
    NSMutableArray *ver1Array = [NSMutableArray arrayWithArray:versions1];
    NSMutableArray *ver2Array = [NSMutableArray arrayWithArray:versions2];
    // 确定最大数组
    NSInteger a = (ver1Array.count> ver2Array.count)?ver1Array.count : ver2Array.count;
    // 补成相同位数数组
    if (ver1Array.count < a) {
        for(NSInteger j = ver1Array.count; j < a; j++)
        {
            [ver1Array addObject:@"0"];
        }
    }
    else
    {
        for(NSInteger j = ver2Array.count; j < a; j++)
        {
            [ver2Array addObject:@"0"];
        }
    }
    // 比较版本号
    int result = [self compareArray1:ver1Array andArray2:ver2Array];
    if(result == 1)
    {
        return NO;
    }
    else if (result == -1)
    {
        return YES;
    }
    else if (result ==0 )
    {
        return NO;
    }else{
        return NO;
    }
}
// 比较版本号
+ (int)compareArray1:(NSMutableArray *)array1 andArray2:(NSMutableArray *)array2
{
    for (int i = 0; i< array2.count; i++) {
        NSInteger a = [[array1 objectAtIndex:i] integerValue];
        NSInteger b = [[array2 objectAtIndex:i] integerValue];
        if (a > b) {
            return 1;
        }
        else if (a < b)
        {
            return -1;
        }
    }
    return 0;
}

#pragma mark -- 按字符串本身的长度 拆分成数组
+(NSMutableArray *)DividedByStringLengthWithString:(NSString *)string{
    NSMutableArray *resultArr = [NSMutableArray array];
    NSString *text = [string copy];
    for (int j = 0; j<string.length; j++) {
        
        NSString *str = [text substringToIndex:1];
        text = [text substringFromIndex:1];
        [resultArr addObject:str];
    }
    return resultArr;
}
#pragma mark -- 字符串每隔几位添加一个分割符
+(NSString *)addSeparateStr:(NSString *)separateStr index:(NSInteger )index totalString:(NSString *)totalString{
    
    NSString *temStr = @"";
    int count = 0;
    for (int i = 0; i < totalString.length; i++) {
        
        count++;
        temStr = [temStr stringByAppendingString:[totalString substringWithRange:NSMakeRange(i, index)]];
        
        if (count == index) {
            temStr = [NSString stringWithFormat:@"%@%@", temStr,separateStr];
            count = 0;
            
        }
        
    }
    if (count == totalString.length) {//最后一位后面不添加分隔符 (待优化)
        return temStr ;
    }
    return temStr;
    
}

@end
