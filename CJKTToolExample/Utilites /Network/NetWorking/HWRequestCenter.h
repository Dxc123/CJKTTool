//
//  HWRequestCenter.h
//  
//
//  Created by caoran on 17/3/15.
//  Copyright © 2017年 caoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWRequestConst.h"
#import "HWRequestItem.h"

NS_ASSUME_NONNULL_BEGIN

@class HWRequestConfig;

@interface HWRequestCenter : NSObject

@property (nonatomic, strong, readonly) HWRequestConfig *requestConfig;
/**
 请求配置信息
 */
+ (void)setupConfig:(void(^)(HWRequestConfig *config))configBlock;

+ (nullable NSString *)sendRequest:(HWConfigItemBlock)configBlock;
+ (nullable NSString *)sendRequest:(HWConfigItemBlock)configBlock onSuccess:(HWSuccessBlock)successBlock;
+ (nullable NSString *)sendRequest:(HWConfigItemBlock)configBlock onFailure:(HWFailureBlock)failureBlock;
+ (nullable NSString *)sendRequest:(HWConfigItemBlock)configBlock onFinished:(HWFinishedBlock)finishedBlock;
+ (nullable NSString *)sendRequest:(HWConfigItemBlock)configBlock onSuccess:(nullable HWSuccessBlock)successBlock onFailure:(nullable HWFailureBlock)failureBlock;
/**
 发送请求的方法

 @param configBlock 配置请求的item
 @param successBlock 成功回调
 @param failureBlock 失败回调
 @param finishedBlock 无论成功或失败,完成的回调
 @return 请求的task的表示符,可以用来取消
 */
+ (nullable NSString *)sendRequest:(HWConfigItemBlock)configBlock onSuccess:(nullable HWSuccessBlock)successBlock onFailure:(nullable HWFailureBlock)failureBlock onFinished:(HWFinishedBlock)finishedBlock;
/**
 取消一个请求
 @param identifier 发送请求时返回的标识符
 */
+ (void)cancelRequest:(NSString *)identifier;
+ (void)cancelRequest:(NSString *)identifier onCancel:(nullable HWCancelBlock)cancelBlock;

@end


@interface HWRequestConfig : NSObject
/**
 配置服务器地址
 */
@property (nonatomic, copy, nullable) NSString *generalServer;
/**
 固定公共参数
 */
@property (nonatomic, strong, nullable) NSDictionary<NSString *, id> *generalParameters;
/**
 不固定的公共参数
 */
@property (nonatomic, copy) NSDictionary* (^realTimeParametersBlock)(void);
/**
 回调的线程(如果不设置,则在请求回调的异步线程)
 */
@property (nonatomic, strong, nullable) dispatch_queue_t callbackQueue;

@end

NS_ASSUME_NONNULL_END
