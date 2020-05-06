//
//  HWRequestItem.h
//  caoran
//
//  Created by caoran on 17/3/15.
//  Copyright © 2017年 caoran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HWRequestConst.h"
NS_ASSUME_NONNULL_BEGIN

@interface HWRequestItem : NSObject

+ (instancetype)requestItem;
/**
 "/im/getServer"格式,拼接到服务器地址后面
 */
@property (nonatomic, copy) NSString *api;
/**
 最终请求的url
 */
@property (nonatomic, copy, readonly) NSString *url;
/**
 默认使用HWRequestConfig的generalServer地址,如果不为nil,则使用separateServer
 */
@property (nonatomic, copy, nullable) NSString *separateServer;
/**
 默认是HWMHTTPMethodPOST , 'POST'请求
 */
@property (nonatomic, assign) HWHTTPMethodType httpMethod;
/**
 请求的间隔,避免频繁发送请求给服务器,默认是:2s,如有需要单独设置
 */
@property (nonatomic, assign) NSTimeInterval requestInterval;
/**
 如果在间隔内发送请求,到时候是否继续处理,默认是NO,不做处理
 */
@property (nonatomic, assign) BOOL isFrequentContinue;
/**
 请求的超时时间,默认30秒
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/**
 请求发送后分配的标识符
 */
@property (nonatomic, copy, readonly) NSString *identifier;
/**
 请求发送数据格式,默认是JSON
 */
@property (nonatomic, assign) HWRequestSerializerType requestSerializerType;
/**
 请求返回的数据格式,默认是JSON
 */
@property (nonatomic, assign) HWResponseSerializerType responseSerializerType;
/**
 请求的参数
 */
@property (nonatomic, strong, nullable) NSDictionary *parameters;
/**
 加密后的请求参数
 */
@property (nonatomic,strong,nullable) NSMutableDictionary *parmeters_encode;
/**
 失败后的回调
 */
@property (nonatomic, copy, readonly, nullable) HWFailureBlock failureBlock;
/**
 成功后的回调
 */
@property (nonatomic, copy, readonly, nullable) HWSuccessBlock  successBlock;
/**
 结束后的回调
 */
@property (nonatomic, copy, readonly, nullable) HWFinishedBlock finishedBlock;
/**
 失败后重复次数,默认为0
 */
@property (nonatomic, assign) NSUInteger retryCount;
/**
 清除回调
 */
- (void)cleanCallbackBlocks;

@end
NS_ASSUME_NONNULL_END
