//
//  CJKTUtility.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2021/2/7.
//  Copyright © 2021 CJKT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJKTUtility : NSObject

#pragma mark -- openURL工具类

/**跳转到app设置页面*/
+ (void)openSettings;

/**
 携带信息跳转whatsapp指定联系人界面
 // wa.me/ + 用户手机号码
 //  跳转后附带上文字 格式：wa.me/手机号码/?text=…
 */
+(void)jumpToWhatsapp:(NSString *)number otherInfo:(NSString *)otherInfo;

@end

NS_ASSUME_NONNULL_END
