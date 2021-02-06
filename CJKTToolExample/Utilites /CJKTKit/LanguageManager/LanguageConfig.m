//
//  LanguageConfig.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2021/2/6.
//  Copyright © 2021 CJKT. All rights reserved.
//

#import "LanguageConfig.h"
#import "ConstValues.h"
@implementation LanguageConfig
/**
设置语言字符串文本翻译
 */

+(NSString *)setLocalizedString:(NSString *)key{
     NSString *result = NSLocalizedString(key, nil);
     NSString *lang = [[NSUserDefaults standardUserDefaults] objectForKey:Language_Key];

      NSString * langBundlePath = nil;
      if ([lang hasPrefix:@"id"]){//印尼
          langBundlePath = [[NSBundle mainBundle] pathForResource:@"id" ofType:@"lproj"];
          
      }else if ([lang hasPrefix:@"hi"]){//印地语
          langBundlePath = [[NSBundle mainBundle] pathForResource:@"hi" ofType:@"lproj"];
      }else if ([lang hasPrefix:@"ar"]){//阿拉伯
          langBundlePath = [[NSBundle mainBundle] pathForResource:@"ar" ofType:@"lproj"];
      }else if ([lang hasPrefix:@"tr"]){//土耳其
          langBundlePath = [[NSBundle mainBundle] pathForResource:@"tr" ofType:@"lproj"];
      }else if ([lang hasPrefix:@"zh-Hans"]){//简体中文
          langBundlePath = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
      }else {//英语
          langBundlePath = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
      }
      if (langBundlePath.length) {
          NSBundle *languageBundle = [NSBundle bundleWithPath:langBundlePath];
          result = [languageBundle localizedStringForKey:key value:@"" table:nil];
      }
      return result;
    
}


/**
获取当前系统语言，并存储到本地
(按导入ar,id,tr,hi,zh-Hans,en语言包判断)
 */
+ (void)setSystemLanguage {
    //获取当前系统语言
          NSString *language22 = [NSLocale preferredLanguages].firstObject;
          CJKTLog(@"当前系统userLanguage = %@",language22);
          if ([language22 hasPrefix:@"ar"]) {
             [[LanguageManager shared] setUserLanguage:@"ar"];
          }else if ([language22 hasPrefix:@"id"]) {
              [[LanguageManager shared] setUserLanguage:@"id"];
          }else if ([language22 hasPrefix:@"tr"]) {
               [[LanguageManager shared] setUserLanguage:@"tr"];
          }else if ([language22 hasPrefix:@"hi"]) {
              [[LanguageManager shared] setUserLanguage:@"hi"];
          }else if ([language22 hasPrefix:@"zh-Hans"]) {
              [[LanguageManager shared] setUserLanguage:@"zh-Hans"];
          }
          else{
               [[LanguageManager shared] setUserLanguage:@"en"];
          }
      
}


/**
 获取当前设置的语言
 
 */
+ (NSString *)getAppLanguage {
    return [[NSUserDefaults standardUserDefaults] objectForKey:Language_Key];
}

/**
 设置语言
 */
+ (void)setAppLanguage:(NSString *)lang {
    CJKTLog(@"lang = %@",lang);
    [[LanguageManager shared] setUserLanguage:lang];
    
}
@end
