//
//  CJKTUtility.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2021/2/7.
//  Copyright © 2021 CJKT. All rights reserved.
//

#import "CJKTUtility.h"

@implementation CJKTUtility

#pragma mark -- openURL工具类

+ (void)openSettings {
    NSURL *settingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL: settingUrl]) {
         [UIApplication.sharedApplication openURL:settingUrl options:@{} completionHandler:^(BOOL success) {
              CJKTLog(@"open success");
           }];
    } else {
        CJKTLog(@"open faile");
        
    }
}

/**
 跳转whatsapp指定联系人界面
 */
+(void)jumpToWhatsapp:(NSString *)number otherInfo:(NSString *)otherInfo{
    if (!kIsStrEmpty(number)) {
      NSString *url = [NSString stringWithFormat:@"https://wa.me/%@/?text=%@",number,otherInfo];
      NSURL *ChatsURL = [NSURL URLWithString: url];
      NSURL *whatsAppURL = [NSURL URLWithString: @"whatsapp://"];
     //判断本地是否存在WhatsApp应用，存在才进行跳转
      if ([[UIApplication sharedApplication] canOpenURL: whatsAppURL]) {
           [UIApplication.sharedApplication openURL:ChatsURL options:@{} completionHandler:^(BOOL success) {
                    if (!success) {
                      
                        CJKTLog(@"Can't open whatsapp");
                      
                    }
             }];
      } else {
           CJKTLog(@"Can't open whatsapp");
          
      }
  }
}

@end
