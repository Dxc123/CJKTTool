//
//  UNNotificationManager.m
//  AUNewProject
//
//  Created by daixingchuang on 2020/12/2.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

#import "UNNotificationManager.h"
#import <UserNotifications/UserNotifications.h>
#import <AudioToolbox/AudioToolbox.h>
@implementation UNNotificationManager
+(void)showPushMessage:(NSString *)message {
           
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
//    content.title = [NSString localizedUserNotificationStringForKey:@"APP_NAME" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:message arguments:nil];;
    content.sound = [UNNotificationSound defaultSound];
    AudioServicesPlaySystemSound(1002);
    UNNotificationRequest *request =  [UNNotificationRequest requestWithIdentifier:@"com.UNNotificationManager" content:content trigger:nil];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
}
/**
 //检测通知权限
 */
+(void)checkNotificationAuthorizationStatus{
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        switch (settings.authorizationStatus) {
            case UNAuthorizationStatusAuthorized :
                CJKTLog(@"允许通知");
                break;
            case UNAuthorizationStatusNotDetermined :
                //不允许通知，请求授权弹窗
                [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions: UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (!granted) {
                        CJKTLog(@"不允许通知");
                    }
                }];
                break;
            case UNAuthorizationStatusDenied :
                //主动去弹窗请求授权
                kDispatch_mainQueue(^{
                    [self showQequestAlert];
                });
              
               break;
            default:
                break;
        }
        
    }];
}
+(void)showQequestAlert{
    UIAlertController *alertVC =  [UIAlertController alertControllerWithTitle:@"消息推送已关闭" message:@"点击“设置”,开启通知." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *setting = [UIAlertAction actionWithTitle:@"Setting" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}
                completionHandler:^(BOOL success) {}];
           }else {
               BOOL success = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
           }
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:setting];
    [[CJKTTool currentController] presentViewController:alertVC animated:YES completion:nil];
    
}
@end
