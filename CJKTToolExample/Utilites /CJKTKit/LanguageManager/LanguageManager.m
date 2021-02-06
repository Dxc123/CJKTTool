//
//  LanguageManager.m
//  AUNewProject
//
//  Created by daixingchuang on 2020/11/19.
//  Copyright © 2020 cc. All rights reserved.
//

#import "LanguageManager.h"
#import "ConstValues.h"


#define kLanguage(key) [AppConfigUtils au_getLanguageString:(key)]

@interface LanguageManager ()
@property (nonatomic, strong) NSBundle *bundle;

@end
@implementation LanguageManager

+ (instancetype)shared
{
    static LanguageManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initLangage];
        
    }
    return self;
}
-(void)initLangage{
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:Language_Key];
//   languageStr 为语言包的前缀，比如Base.lproj 传入Base、前提是工程中已经提前加入了语言包，工程里可查看
//如中文语言包zh-Hans.lproj传入zh-Hans，
/**
 
 */

    NSString *languageStr =  @"en";
    if (kIsStrEmpty(language)) {
        if ([language hasPrefix:@"ar"]) {
            languageStr = @"ar";
        }else if ([language hasPrefix:@"id"]) {
            languageStr = @"id";
        }else if ([language hasPrefix:@"tr"]) {
            languageStr = @"tr";
        }else if ([language hasPrefix:@"hi"]) {
            languageStr = @"hi";
        }else if ([language hasPrefix:@"zh-Hans"]) {
            languageStr = @"zh-Hans";
        }else{
            languageStr = @"en";
        }
        
        NSString * bundlePath = [[NSBundle mainBundle] pathForResource:languageStr ofType:@"lproj"];
        self.bundle =  [NSBundle bundleWithPath:bundlePath];
        
    }else{
        //获取当前系统语言
        NSString *language22 = [NSLocale preferredLanguages].firstObject;
        [[NSUserDefaults standardUserDefaults] setObject:language22 forKey:Language_Key];
        if ([language22 hasPrefix:@"ar"]) {
            language22 = @"ar";
        }else if ([language hasPrefix:@"id"]) {
            language22 = @"id";
        }else if ([language22 hasPrefix:@"tr"]) {
            language22 = @"tr";
        }else if ([language22 hasPrefix:@"hi"]) {
            language22 = @"hi";
        }else if ([language hasPrefix:@"zh-Hans"]) {
            language22 = @"zh-Hans";
        }else{
            language22 = @"en";
        }
        [[NSUserDefaults standardUserDefaults] setObject:language22 forKey:Language_Key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString * bundlePath = [[NSBundle mainBundle] pathForResource:languageStr ofType:@"lproj"];
        self.bundle =  [NSBundle bundleWithPath:bundlePath];
        
    }
}



/**
设置语言
*/
-(void)setUserLanguage:(NSString *)language{
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:Language_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString * bundlePath = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    self.bundle =  [NSBundle bundleWithPath:bundlePath];
}




@end
