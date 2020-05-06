//
//  HWRequestEngine.m
//  caoran
//
//  Created by caoran on 17/3/15.
//  Copyright © 2017年 caoran. All rights reserved.
//

#import "HWRequestEngine.h"
#import "HWRequestItem.h"
#import "HWRequestConst.h"
#import "AFNetworking.h"
#import <objc/runtime.h>
#import "AFNetworkActivityIndicatorManager.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "HWNetworkStatus.h"
#import <AdSupport/AdSupport.h>
//#import "HWDevice.h"
#import "CJKTUserModel.h"

#define serviceVersion @"API1"

static dispatch_queue_t request_Completion_Callback_Queue() {
    static dispatch_queue_t request_Completion_Callback_Queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request_Completion_Callback_Queue = dispatch_queue_create("com.requestCompletionCallbackQueue.hw", DISPATCH_QUEUE_CONCURRENT);
    });
    return request_Completion_Callback_Queue;
}


@implementation NSObject (BindingHWRequestItem)

static NSString * const kHWRequestBindingKey = @"kHWRequestBindingKey";

- (void)bindingRequestItem:(HWRequestItem *)requestItem {
    objc_setAssociatedObject(self, (__bridge CFStringRef)kHWRequestBindingKey, requestItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HWRequestItem *)bindedRequestItem {
    HWRequestItem *item = objc_getAssociatedObject(self, (__bridge CFStringRef)kHWRequestBindingKey);
    return item;
}

@end


@interface HWRequestEngine ()
{
    dispatch_semaphore_t _selfLock;
}
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end


@implementation HWRequestEngine

+ (instancetype)defaultEngine
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        _selfLock = dispatch_semaphore_create(1);
    }
    return self;
}

- (void)sendRequest:(HWRequestItem *)item completionHandler:(nullable HWCompletionHandler)completionHandler
{
    [self dataTaskWithRequest:item completionHandler:completionHandler];
}

- (void)cancelRequestByIdentifier:(NSString *)identifier
{
    if (kStringIsEmpty(identifier)) return;
    HWSelfLock();
    NSArray *tasks = self.sessionManager.tasks;
    if (!kArrayIsEmpty(tasks)) {
        [tasks enumerateObjectsUsingBlock:^(NSURLSessionTask *task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.bindedRequestItem.identifier isEqualToString:identifier]) {
                [task cancel];
                *stop = YES;
            }
        }];
    }
    HWSelfUnlock();
}

#pragma mark - 私有方法

- (void)dataTaskWithRequest:(HWRequestItem *)item completionHandler:(HWCompletionHandler)completionHandler
{
    NSString *httpMethod = (item.httpMethod == kHWHTTPMethodGET) ? @"GET":@"POST";
    AFHTTPRequestSerializer *requestSerializer = [self getRequestSerializer:item];
    NSError *serializationError = nil;
    NSMutableURLRequest *urlRequest = [requestSerializer requestWithMethod:httpMethod URLString:item.url parameters:item.parmeters_encode error:&serializationError];
    if ([httpMethod isEqualToString:@"POST"]) {
        [self configPostHeader:urlRequest];
    }
    CJKTLog(@"最终请求地址 ... %@,参数 - %@",urlRequest.URL.absoluteString,item.parmeters_encode);
    if (serializationError) {
        if (completionHandler) {
            dispatch_async(request_Completion_Callback_Queue(), ^{
                completionHandler(nil, serializationError);
            });
        }
        return;
    }
    urlRequest.timeoutInterval = item.timeoutInterval;
    NSURLSessionDataTask *dataTask = nil;
    __weak __typeof(self)weakSelf = self;
    dataTask = [self.sessionManager dataTaskWithRequest:urlRequest uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf processResponse:response object:responseObject error:error requestItem:item completionHandler:completionHandler];
    }];
    NSString *identifier = [NSString stringWithFormat:@"%lu",(unsigned long)dataTask.taskIdentifier];
    [item setValue:identifier forKey:@"_identifier"];
    [dataTask bindingRequestItem:item];
    [dataTask resume];
}

- (void)processResponse:(NSURLResponse *)response object:(id)responseObject error:(NSError *)error requestItem:(HWRequestItem *)item completionHandler:(HWCompletionHandler)completionHandler {
    AFHTTPResponseSerializer *responseSerializer = [self getResponseSerializer:item];
    NSError *serializationError = nil;
    responseObject = [responseSerializer responseObjectForResponse:response data:responseObject error:&serializationError];
    if (completionHandler) {
        dispatch_async(request_Completion_Callback_Queue(), ^{
            if (serializationError) {
                completionHandler(nil, serializationError);
            } else {
                completionHandler(responseObject, error);
            }
        });
    }
}

- (void)configPostHeader:(NSMutableURLRequest*)urlRequest {
    NSString *idfa = [UIDevice currentDevice].identifierForVendor.UUIDString;
    NSString *channel = @"yqxyy_iOS";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *device = @"iOS";
    NSString *sysVersion = [UIDevice currentDevice].systemVersion;
    NSString *ua = [NSString stringWithFormat:@"%@;%@;%@;%@",app_Version,serviceVersion,device,sysVersion];
    NSString *token = [SINGLETON isLogin]?SINGLETON.myUser.token:@"";
    [urlRequest setValue:idfa forHTTPHeaderField:@"idfa"];
    [urlRequest setValue:channel forHTTPHeaderField:@"channel"];
    [urlRequest setValue:ua forHTTPHeaderField:@"ua"];
    [urlRequest setValue:token forHTTPHeaderField:@"token"];
}

- (AFHTTPRequestSerializer *)getRequestSerializer:(HWRequestItem *)item
{
    switch (item.requestSerializerType) {
        case kHWRequestSerializerHTTP:
            return [AFHTTPRequestSerializer serializer];
            break;
        case kHWRequestSerializerJSON:
            return [AFJSONRequestSerializer serializer];
            break;
        default:
            return [AFJSONRequestSerializer serializer];
            break;
    }
}

- (AFHTTPResponseSerializer *)getResponseSerializer:(HWRequestItem *)item
{
    switch (item.responseSerializerType) {
        case kHWResponseSerializerHTTP:
            return [AFHTTPResponseSerializer serializer];
            break;
        case kHWResponseSerializerJSON:
            return [AFJSONResponseSerializer serializer];
            break;
        default:
            return [AFJSONResponseSerializer serializer];
            break;
    }
}

#pragma mark - 懒加载

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        _sessionManager.securityPolicy.allowInvalidCertificates = YES;
        _sessionManager.securityPolicy.validatesDomainName = NO;
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.operationQueue.maxConcurrentOperationCount = 5;
        _sessionManager.completionQueue = request_Completion_Callback_Queue();
    }
    return _sessionManager;
}

@end
