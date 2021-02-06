//
//  CJKTNetWorkManager.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/9/15.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCDHTTPResult.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, HTTPMethod) {
    HTTPMethodGet = 1,
    HTTPMethodPost = 2,
   
};
@interface CJKTNetWorkManager : NSObject

+ (void)requestWithHTTPMethod:(HTTPMethod)method
                    URLString:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                     response:(void (^)(RCDHTTPResult *result))responseBlock;

@end

NS_ASSUME_NONNULL_END
