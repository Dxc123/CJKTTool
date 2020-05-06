//
//  HWNetworkStatus.h
//  
//
//  Created by caoran on 2017/9/22.
//  Copyright © 2017年 caoran. All rights reserved.


#import <Foundation/Foundation.h>

extern NSString * const kHWReachabilityChangedNotification;

typedef NS_ENUM(NSInteger, KHWNetworkModeStatus) {
    KHWNotReachable ,
    KHWReachableViaWiFi ,
    KHWReachableViaWWAN ,
};

@interface HWNetworkStatus : NSObject

+ (instancetype)shareNetworkStatus;
/**
 当前网络状态
 */
- (KHWNetworkModeStatus)currentNetworkStatus;
/**
 是否有网
 */
- (BOOL)isReachable;
/**
 具体的网络信息
 
 @return @"UnKnow" @"Wifi" @"NotReachable" @"2G" @"3G" @"4G"
 */
- (NSString *)specificNetworkMode;

@end
