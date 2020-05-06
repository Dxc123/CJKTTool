//
//  CJKTInPurchaseManager.h
//  橙子数学
//
//  Created by MacBook on 2018/2/5.
//  Copyright © 2018年 杭州秀铂科技网络有限公司. All rights reserved.
//
// 利用IAPHelper第三库
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,payTag){
    
    IAP0p100 = 20,
    IAP1p300,
    IAP2p500,
    IAP3p1000,
    IAP4p2000,
    IAP5p3000,
    IAP5p3998,
    IAP5p4998,
    IAP5p5898
    
};

//沙盒测试环境验证
#define SANDBOX @"http://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"http://buy.itunes.apple.com/verifyReceipt"
#define ProduceID_IAP0p100 @"orangeMath98"
#define ProduceID_IAP1p300 @"orangeMath298"
#define ProduceID_IAP2p500 @"orangeMath488"
#define ProduceID_IAP3p1000 @"orangeMath998"
#define ProduceID_IAP4p2000 @"orangeMath1998"
#define ProduceID_IAP5p3000 @"orangeMath2998"
#define ProduceID_IAP5p3998 @"orangeMath3998"
#define ProduceID_IAP5p4998 @"orangeMath4998"
#define ProduceID_IAP5p5898 @"orangeMath5898"

#import "IAPHelper.h"
#import "IAPShare.h"

@interface CJKTInPurchaseManager : NSObject

@property (nonatomic, copy) void (^UnpermissionBlock)(void);

@property (nonatomic, copy) void (^payCompelete)(NSError *error);

+ (instancetype)sharePayManager;

- (void)buy:(NSInteger)type orderId:(NSString *)orderid fee:(NSString *)fee;

@end
