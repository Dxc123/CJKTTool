//
//  CJKTNetWorkManager.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/9/15.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "CJKTNetWorkManager.h"
#import <AdSupport/AdSupport.h>
#import <AFNetworking/AFNetworking.h>
#define HTTP_SUCCESS 200
NSString *const BASE_URL = @"";
NSString *const RCDUserCookiesKey = @"UserCookies";
static AFHTTPSessionManager *manager;

@implementation CJKTNetWorkManager

+ (AFHTTPSessionManager *)sharedHTTPManager {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [AFHTTPSessionManager manager];
        manager.completionQueue = dispatch_queue_create("cn.rongcloud.sealtalk.httpqueue", DISPATCH_QUEUE_SERIAL);
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy = securityPolicy;
        manager.requestSerializer.HTTPShouldHandleCookies = YES;
        [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    });
    return manager;
}
//  [manager.requestSerializer setValue:appkey forHTTPHeaderField:@"appkey"];
//设置请求头（公共参数）
//+(NSDictionary *)getHeadersWithToken:(BOOL)needToken{
//    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
//        [headers setObject:@"application/json" forKey:@"Accept"];
//       [headers setObject:@"application/json; charset=utf-8" forKey:@"Content-Type"];
//
//       NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//
//       [headers setObject:adId forKey:@"device-id"];
//       NSString *appVersion   = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//       NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
//      NSString *agent;
//      NSString *lang = kUserDefaultGetKey(@"AnduService");
//       if ([lang hasPrefix:@"id"]){
//          agent = [NSString stringWithFormat:@"%@,%@,ios,%@,102",@"andu",appVersion,phoneVersion];
//
//           [headers setObject:@"id-id" forKey:@"user-language"];
//
//       }else if ([lang hasPrefix:@"ar"]){
//          agent = [NSString stringWithFormat:@"%@,%@,ios,%@,101",@"andu",appVersion,phoneVersion];
//           [headers setObject:@"ar-sa" forKey:@"user-language"];
//
//       }else if ([lang hasPrefix:@"en"]){
//          agent = [NSString stringWithFormat:@"%@,%@,ios,%@,100",@"andu",appVersion,phoneVersion];
//           [headers setObject:@"us-oa" forKey:@"user-language"];
//       }else{
//          agent = [NSString stringWithFormat:@"%@,%@,ios,%@,100",@"andu",appVersion,phoneVersion];
//          [headers setObject:@"zh-cn" forKey:@"user-language"];
//       }
//        [headers setObject:agent forKey:@"User-Agent"];
//       //        AULog(@"agent=%@",agent);
//       //        AULog(@"appkey=%@",[AUUserDefaultsTool getKey:APPKEY]);
//    if (needToken) {
//        if (kUserDefaultGetKey(@"appkey")) {
//          NSString *appkey = kUserDefaultGetKey(@"appkey");
//         [headers setObject:appkey forKey:@"appkey"];
//        }
//    }
//
//
//    return headers;
//}
//



+ (void)requestWithHTTPMethod:(HTTPMethod)method
                    URLString:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                     response:(void (^)(RCDHTTPResult *))responseBlock {
    AFHTTPSessionManager *manager = [CJKTNetWorkManager sharedHTTPManager];
    NSString *url = [BASE_URL stringByAppendingPathComponent:URLString];

    switch (method) {
    case HTTPMethodGet: {
        [manager GET:url
            parameters:parameters
            progress:nil
            success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                if (responseBlock) {
                    responseBlock([[self class] httpSuccessResult:task response:responseObject]);
                }
            }
            failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                NSLog(@"GET url is %@, error is %@", URLString, error.localizedDescription);
                if (responseBlock) {
                    responseBlock([[self class] httpFailureResult:task]);
                }
            }];
        break;
    }

    case HTTPMethodPost: {
        [manager POST:url
            parameters:parameters
            progress:nil
            success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                [self saveCookieIfHave:task];
                if (responseBlock) {
                    responseBlock([[self class] httpSuccessResult:task response:responseObject]);
                }
            }
            failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
                NSLog(@"POST url is %@, error is %@", URLString, error.localizedDescription);
                if (responseBlock) {
                    responseBlock([[self class] httpFailureResult:task]);
                }
            }];
        break;
    }
    default:
        break;
    }
}

+ (RCDHTTPResult *)httpSuccessResult:(NSURLSessionDataTask *)task response:(id)responseObject {
    RCDHTTPResult *result = [[RCDHTTPResult alloc] init];
    result.httpCode = ((NSHTTPURLResponse *)task.response).statusCode;

    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        result.errorCode = [responseObject[@"code"] integerValue];
        result.content = responseObject[@"result"];
        result.success = (result.errorCode == HTTP_SUCCESS);
        if (!result.success) {
            NSLog(@"%@, {%@}", task.currentRequest.URL, result);
        }
    } else {
        result.success = NO;
    }

    return result;
}

+ (RCDHTTPResult *)httpFailureResult:(NSURLSessionDataTask *)task {
    RCDHTTPResult *result = [[RCDHTTPResult alloc] init];
    result.success = NO;
    result.httpCode = ((NSHTTPURLResponse *)task.response).statusCode;
    NSLog(@"%@, {%@}", task.currentRequest.URL, result);
    return result;
}

+ (void)saveCookieIfHave:(NSURLSessionDataTask *)task {
    NSString *cookieString = [[(NSHTTPURLResponse *)task.response allHeaderFields] valueForKey:@"Set-Cookie"];
    NSMutableString *finalCookie = [NSMutableString new];
    NSArray *cookieStrings = [cookieString componentsSeparatedByString:@","];
    for (NSString *temp in cookieStrings) {
        NSArray *tempArr = [temp componentsSeparatedByString:@";"];
        [finalCookie appendString:[NSString stringWithFormat:@"%@;", tempArr[0]]];
    }
    if (finalCookie.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:finalCookie forKey:RCDUserCookiesKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[CJKTNetWorkManager sharedHTTPManager].requestSerializer setValue:finalCookie forHTTPHeaderField:@"Cookie"];
    }
}

@end
