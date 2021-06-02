//
//  CJKTKit.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2021/2/5.
//  Copyright © 2021 CJKT. All rights reserved.
//

#ifndef CJKTKit_h
#define CJKTKit_h

///精准打印log
#ifdef DEBUG
#define CJKTLog(s, ... ) printf("[ %s:(%d) ] %s :%s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(s), ##__VA_ARGS__] UTF8String])
#else
#define CJKTLog(s, ... )
#endif

#define kAUSring(key) [LanguageConfig setLocalizedString:(key)]

#import "ConstValues.h"

//Utility
#import "CJKTUtility.h"

//ExternMethods
#import "ExternMethods.h"
#import "GlobalInlineMethod.h"

//UIKit
#import "CJKTTextField.h"
#import "CJKTLabel.h"
//HUD
#import "KHelper.h"

//FileManager
#import "CJKTFileManager.h"

//Cache
#import "PINCacheHelper.h"
#import "YYCacheManager.h"

//LanguageManager
#import "LanguageManager.h"
#import "LanguageConfig.h"

#endif /* CJKTKit_h */
