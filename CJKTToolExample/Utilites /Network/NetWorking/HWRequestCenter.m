//
//  HWRequestCenter.m
//  caoran
//
//  Created by caoran on 17/3/15.
//  Copyright © 2017年 caoran. All rights reserved.
//

#import "HWRequestCenter.h"
#import "HWRequestItem.h"
#import "HWRequestEngine.h"
#import "HWNetworkStatus.h"

NSString *const HW_HTTP_DOMAIN = @"WannyEnglish.httpServer.host";

@interface HWRequestCenter ()
{
    dispatch_semaphore_t _selfLock;
}
@property (nonatomic, strong) HWRequestConfig *requestConfig;

@property (nonatomic, strong) NSMutableDictionary *requestTimestampPool;

@property (nonatomic, strong) dispatch_source_t clearnTimer;

@end

@implementation HWRequestCenter

+ (nullable NSString *)sendRequest:(HWConfigItemBlock)configBlock
{
    return [[HWRequestCenter defaultCenter] sendRequest:configBlock onSuccess:NULL onFailure:NULL onFinished:NULL];
}

+ (nullable NSString *)sendRequest:(HWConfigItemBlock)configBlock onSuccess:(HWSuccessBlock)successBlock
{
    return [[HWRequestCenter defaultCenter] sendRequest:configBlock onSuccess:successBlock onFailure:NULL onFinished:NULL];
}

+ (nullable NSString *)sendRequest:(HWConfigItemBlock)configBlock onFailure:(HWFailureBlock)failureBlock
{
    return [[HWRequestCenter defaultCenter] sendRequest:configBlock onSuccess:NULL onFailure:failureBlock onFinished:NULL];
}

+ (nullable NSString *)sendRequest:(HWConfigItemBlock)configBlock onFinished:(HWFinishedBlock)finishedBlock
{
    return [[HWRequestCenter defaultCenter] sendRequest:configBlock onSuccess:NULL onFailure:NULL onFinished:finishedBlock];
}
+ (nullable NSString *)sendRequest:(HWConfigItemBlock)configBlock onSuccess:(nullable HWSuccessBlock)successBlock onFailure:(HWFailureBlock)failureBlock
{
    return [[HWRequestCenter defaultCenter] sendRequest:configBlock onSuccess:successBlock onFailure:failureBlock onFinished:NULL];
}

+ (nullable NSString *)sendRequest:(HWConfigItemBlock)configBlock onSuccess:(nullable HWSuccessBlock)successBlock onFailure:(nullable HWFailureBlock)failureBlock onFinished:(HWFinishedBlock)finishedBlock
{
    return [[HWRequestCenter defaultCenter] sendRequest:configBlock onSuccess:successBlock onFailure:failureBlock onFinished:finishedBlock];
}

+ (void)setupConfig:(void(^)(HWRequestConfig *config))configBlock
{
    [[HWRequestCenter defaultCenter] setupConfig:configBlock];
}

+ (void)cancelRequest:(NSString *)identifier
{
    [[HWRequestCenter defaultCenter] cancelRequest:identifier onCancel:nil];
}

+ (void)cancelRequest:(NSString *)identifier onCancel:(nullable HWCancelBlock)cancelBlock
{
    [[HWRequestCenter defaultCenter] cancelRequest:identifier onCancel:cancelBlock];
}

#pragma mark - 私有方法

+ (instancetype)defaultCenter {
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
        _selfLock = dispatch_semaphore_create(1);
        [self creatCleanTimer];
    }
    return self;
}

- (void)dealloc
{
    [_requestTimestampPool removeAllObjects];
    [self stopClearnTimer];
}

- (void)setupConfig:(void(^)(HWRequestConfig *config))configBlock
{
    HW_SAFE_BLOCK(configBlock,self.requestConfig);
    NSAssert(!kStringIsEmpty(self.requestConfig.generalServer), @"generalServer is nil ...");
}

- (void)cancelRequest:(NSString *)identifier onCancel:(nullable HWCancelBlock)cancelBlock
{
    [[HWRequestEngine defaultEngine] cancelRequestByIdentifier:identifier];
    HW_SAFE_BLOCK(cancelBlock);
}

- (NSString *)sendRequest:(HWConfigItemBlock)configBlock onSuccess:(nullable HWSuccessBlock)successBlock onFailure:(nullable HWFailureBlock)failureBlock onFinished:(HWFinishedBlock)finishedBlock
{
    HWRequestItem *requestItem = [HWRequestItem requestItem];
    HW_SAFE_BLOCK(configBlock,requestItem);
    __block NSString *identifier;
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self processRequestItem:requestItem onSuccess:successBlock onFailure:failureBlock onFinished:finishedBlock];
        if ([self checkNetworkWithRequestItem:requestItem]) {
            [self sendRequestItem:requestItem];
            identifier = requestItem.identifier;
        }
    });
    return identifier;
}

- (BOOL)checkLimitTimeWithRequestItem:(HWRequestItem *)requestItem
{
    BOOL isAllow = NO;
    NSInteger currentTime = [self getCurrentTimestamp];
    HWSelfLock();
    NSNumber *lastTime = [self.requestTimestampPool objectForKey:requestItem.api];
    HWSelfUnlock();
    if (lastTime && currentTime < lastTime.integerValue) {
        if (!requestItem.isFrequentContinue){
            NSError *error = [self generateErrorWithErrorReason:@"频繁的发送同一个请求" errorCode:kHWNetWorkFrequentRequestError];
            [self failureWithError:error forRequestItem:requestItem];
            return isAllow;
        }
        NSInteger nextRequestTime = lastTime.integerValue - currentTime;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(nextRequestTime * NSEC_PER_SEC)),dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self sendRequestItem:requestItem];
        });
        return isAllow;
    }
    NSNumber *limitTime = @(currentTime + requestItem.requestInterval);
    HWSelfLock();
    [self.requestTimestampPool setObject:limitTime forKey:requestItem.api];
    HWSelfUnlock();
    return isAllow = YES;
}

- (void)processRequestItem:(HWRequestItem *)requestItem onSuccess:(HWSuccessBlock)successBlock onFailure:(HWFailureBlock)failureBlock onFinished:(HWFinishedBlock)finishedBlock
{
    NSAssert(!kStringIsEmpty(requestItem.api), @"The request api can't be null.");
    if (successBlock) {
        [requestItem setValue:successBlock forKey:@"_successBlock"];
    }
    if (failureBlock) {
        [requestItem setValue:failureBlock forKey:@"_failureBlock"];
    }
    if (finishedBlock) {
        [requestItem setValue:finishedBlock forKey:@"_finishedBlock"];
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (!kDictIsEmpty(self.requestConfig.generalParameters)) {
        [parameters addEntriesFromDictionary:self.requestConfig.generalParameters];
    }
    NSDictionary *realTimeParameters = HW_SAFE_BLOCK(self.requestConfig.realTimeParametersBlock);
    if (!kDictIsEmpty(realTimeParameters)) {
        [parameters addEntriesFromDictionary:realTimeParameters];
    }
    if (!kDictIsEmpty(requestItem.parameters)) {
        [parameters addEntriesFromDictionary:requestItem.parameters];
    }
    requestItem.parameters = parameters;
    if (kStringIsEmpty(requestItem.separateServer)) {
        requestItem.separateServer = self.requestConfig.generalServer;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",requestItem.separateServer,requestItem.api];
    [requestItem setValue:url forKey:@"_url"];
}

- (BOOL)checkNetworkWithRequestItem:(HWRequestItem *)requestItem
{
    if (![[HWNetworkStatus shareNetworkStatus] isReachable]) {
        NSError *error = [self generateErrorWithErrorReason:@"当前网络不可用" errorCode:kHWNetworkStatusAvailableError];
        [self failureWithError:error forRequestItem:requestItem];
        return NO;
    }
    return YES;
}

- (void)sendRequestItem:(HWRequestItem *)requestItem
{
    if ([self checkLimitTimeWithRequestItem:requestItem]) {
        [[HWRequestEngine defaultEngine] sendRequest:requestItem completionHandler:^(id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                [self failureWithError:error forRequestItem:requestItem];
            }
            else{
                [self successWithResponse:responseObject forRequestItem:requestItem];
            }
        }];
    }
}

- (void)successWithResponse:(id)responseObject forRequestItem:(HWRequestItem *)requestItem
{
    NSError *error;
    if ([self checkOutResult:responseObject forRequestItem:requestItem error:&error])
    {
        if (self.requestConfig.callbackQueue) {
            dispatch_async(self.requestConfig.callbackQueue, ^{
                [self execureSuccessBlockWithResponse:responseObject forRequest:requestItem];
            });
        }
        else{
            [self execureSuccessBlockWithResponse:responseObject forRequest:requestItem];
        }
    }
    else
    {
        [self failureWithError:error forRequestItem:requestItem];
    }
}

- (void)execureSuccessBlockWithResponse:(id)responseObject forRequest:(HWRequestItem *)requestItem
{
    @autoreleasepool {
        if (requestItem.responseSerializerType == kHWResponseSerializerJSON && [responseObject isKindOfClass:[NSDictionary class]]) {
            responseObject = (NSDictionary *)responseObject[@"data"];
        }
        CJKTLog(@"REQUEST SUCCESS...%@",responseObject);
        HW_SAFE_BLOCK(requestItem.successBlock,responseObject);
        HW_SAFE_BLOCK(requestItem.finishedBlock,responseObject,nil);
        [requestItem cleanCallbackBlocks];
    }
}

- (void)failureWithError:(NSError *)error forRequestItem:(HWRequestItem *)requestItem
{
    if (requestItem.retryCount > 0) {
        requestItem.retryCount --;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self sendRequestItem:requestItem];
        });
        return;
    }
    CJKTLog(@"api:%@ http request error...%@",requestItem.api,error);
    if (self.requestConfig.callbackQueue) {
        dispatch_async(self.requestConfig.callbackQueue, ^{
            [self execureFailureBlockWithError:error forRequest:requestItem];
        });
    }else{
        [self execureFailureBlockWithError:error forRequest:requestItem];
    }
}

- (void)execureFailureBlockWithError:(NSError *)error forRequest:(HWRequestItem *)requestItem
{
    // 400 401 用户登录过期,需重新登录
    if ((error.code == 400 || error.code == 401 )&& (![requestItem.api isEqualToString:auth_logIn_code_api] && ! [requestItem.api isEqualToString: auth_get_verification_code_api])) {
        CJKTLog(@"-------用户登录过期------");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            kNoti_Post_Param(NOTIFICATION_USER_RELOGIN, nil);
        });
    }

    // 10000 威钻不足
    if (error.code == 10000) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            kNoti_Post_Param(NOTIFICATION_USER_V_DIAMONDS_NOT_ENOUGH, nil);
        });
    }
    HW_SAFE_BLOCK(requestItem.failureBlock,error);
    HW_SAFE_BLOCK(requestItem.finishedBlock,nil,error);
    [requestItem cleanCallbackBlocks];
}

- (void)creatCleanTimer
{
    if (_clearnTimer) return;
    self.clearnTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(self.clearnTimer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.clearnTimer, ^{
        [self cleanTimestampPool];
    });
    dispatch_resume(self.clearnTimer);
}

- (void)cleanTimestampPool
{
    if (kDictIsEmpty(self.requestTimestampPool)) return;
    HWSelfLock();
    NSDictionary *tempDict = [self.requestTimestampPool mutableCopy];
    HWSelfUnlock();
    NSInteger currentTime = [self getCurrentTimestamp];
    for (NSString *api in tempDict) {
        NSInteger limitTime = [[self.requestTimestampPool objectForKey:api] integerValue];
        if (currentTime >= limitTime) {
            HWSelfLock();
            [self.requestTimestampPool removeObjectForKey:api];
            HWSelfUnlock();
        }
    }
}

- (void)stopClearnTimer
{
    if (_clearnTimer) {
        dispatch_source_cancel(_clearnTimer);
        _clearnTimer = NULL;
    }
}

- (NSInteger)getCurrentTimestamp
{
    return ((NSInteger)[[NSDate date] timeIntervalSince1970] * 1000);
}

- (BOOL)checkOutResult:(id)responseObject forRequestItem:(HWRequestItem *)requestItem error:(NSError **)error
{
    BOOL isSuccess = NO;
    if (!responseObject)
    {
        if (error != NULL) *error = [self generateErrorWithErrorReason:@"responseObject is nil - 返回数据为空" errorCode:KHWNetWorkResponseObjectError];
        return isSuccess;
    }
    // JSON格式
    if (requestItem.responseSerializerType == kHWResponseSerializerJSON)
    {
        if (![responseObject isKindOfClass:[NSDictionary class]])
        {
            if (error != NULL) *error = [self generateErrorWithErrorReason:@"responseObject type is not right - 返回数据类型错误" errorCode:KHWNetWorkResponseObjectError];
            return isSuccess;
        }
        NSNumber *code = ((NSDictionary *)responseObject)[@"code"];
        if ([code isEqualToNumber:@(kCorrectReturnCode)])
        {
            return isSuccess = YES;
        }
        else
        {
            if (error != NULL) *error = [self generateErrorWithErrorReason:((NSDictionary *)responseObject)[@"msg"] errorCode:code.integerValue];
            return isSuccess;
        }
    }
    // data格式
    else
    {
        if (![responseObject isKindOfClass:[NSData class]])
        {
            if (error != NULL) *error = [self generateErrorWithErrorReason:@"responseObject type is not right - 返回数据类型错误" errorCode:KHWNetWorkResponseObjectError];
            return isSuccess;
        }
        return isSuccess = YES;
    }
}

- (NSError *)generateErrorWithErrorReason:(NSString *)errorReason errorCode:(NSInteger)errorCode
{
    NSDictionary *errorInfo = @{NSLocalizedDescriptionKey: NSLocalizedString(errorReason, @""),NSLocalizedFailureReasonErrorKey:NSLocalizedString(errorReason, @"")};
    NSError *error = [[NSError alloc] initWithDomain:HW_HTTP_DOMAIN code:errorCode userInfo:errorInfo];
    return error;
}

- (HWRequestConfig *)requestConfig
{
    if (!_requestConfig) {
        _requestConfig = [[HWRequestConfig alloc] init];
    }
    return _requestConfig;
}

- (NSMutableDictionary *)requestTimestampPool
{
    if (!_requestTimestampPool) {
        _requestTimestampPool = [NSMutableDictionary dictionary];
    }
    return _requestTimestampPool;
}

@end

@implementation HWRequestConfig

@end


