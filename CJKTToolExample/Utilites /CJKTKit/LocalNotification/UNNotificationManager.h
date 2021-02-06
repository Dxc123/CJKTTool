//
//  UNNotificationManager.h
//  AUNewProject
//
//  Created by daixingchuang on 2020/12/2.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//本地推送弹窗,(需要配置AppDelegate.m推送代理方法)

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UNNotificationManager : NSObject

/**
 检测通知权限
 */
+(void)checkNotificationAuthorizationStatus;
/**
 横幅弹窗
 */
+(void)showPushMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
