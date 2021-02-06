//
//  LanguageConfig.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2021/2/6.
//  Copyright © 2021 CJKT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LanguageConfig : NSObject

/**
设置语言字符串文本翻译
 */
+(NSString *)setLocalizedString:(NSString *)key;


/**
 设置当前系统语言，并存储到本地 (app启动时候设置)
  (按导入ar,id,tr,hi,zh-Hans,en判断,未导入的默认英语)
 */
+ (void)setSystemLanguage ;
/**
 获取当前设置的语言
 */
+ (NSString *)getAppLanguage;


/**
 设置语言
 */
+ (void)setAppLanguage:(NSString *)lang ;
@end

NS_ASSUME_NONNULL_END
