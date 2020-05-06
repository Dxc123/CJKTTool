//
//  HWRequestConst.h
//  
//
//  Created by caoran on 17/3/15.
//  Copyright © 2017年 caoran. All rights reserved.
//

#ifndef HWRequestConst_h
#define HWRequestConst_h

NS_ASSUME_NONNULL_BEGIN

#define HW_SAFE_BLOCK(BlockName, ...) ({ !BlockName ? nil : BlockName(__VA_ARGS__); })
#define HWSelfLock() dispatch_semaphore_wait(self->_selfLock, DISPATCH_TIME_FOREVER)
#define HWSelfUnlock() dispatch_semaphore_signal(self->_selfLock)

/*
 * 判断是否有效字符串
 */
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
/**
 判断数组是否为空
 */
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
/**
 判断字典是否为空
 */
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys.count == 0 || dic.allKeys == nil)
/**
 data是否为空
 */
#define kDataIsEmpty(data) (![data isKindOfClass:[NSData class]] || data == nil || [data length] < 1 ? YES : NO )


@class HWRequestItem;

//服务器返回的正确校验码
static NSInteger kCorrectReturnCode = 0;


typedef NS_ENUM(NSInteger, HWHTTPMethodType) {
    kHWHTTPMethodPOST   = 0,    // POST
    kHWHTTPMethodGET    = 1,    // GET
};

typedef NS_ENUM(NSInteger, HWRequestSerializerType) {
    kHWRequestSerializerHTTP     = 0, // 默认POST的请求数据方式
    kHWRequestSerializerJSON    = 1, // GET的请求数据方式
};

typedef NS_ENUM(NSInteger, HWResponseSerializerType) {
    kHWResponseSerializerHTTP    = 0,
    kHWResponseSerializerJSON   = 1,  //默认响应的数据形式
};

NS_ENUM(NSInteger)
{
    KHWNetWorkResponseObjectError  =                     -1,   //返回数据错误
    kHWNetworkStatusAvailableError =                     2004, //当前网络状态不可用
    kHWNetWorkFrequentRequestError =                     2005, //网络频繁请求
};
    
typedef void (^HWConfigItemBlock)(HWRequestItem *item);
typedef void (^HWSuccessBlock)(id _Nullable responseObject);
typedef void (^HWFailureBlock)(NSError * _Nullable error);
typedef void (^HWFinishedBlock)(id _Nullable responseObject, NSError * _Nullable error);
typedef void (^HWCancelBlock)(void);


NS_ASSUME_NONNULL_END

#endif /* HWRequestConst_h */
