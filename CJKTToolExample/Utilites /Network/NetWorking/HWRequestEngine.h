//
//  HWRequestEngine.h
//
//
//  Created by caoran on 17/3/15.
//  Copyright © 2017年 caoran. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@class HWRequestItem,AFNetworkReachabilityManager;

typedef void (^HWCompletionHandler) (id _Nullable responseObject, NSError * _Nullable error);

@interface HWRequestEngine : NSObject

+ (instancetype)defaultEngine;

- (void)sendRequest:(HWRequestItem *)item completionHandler:(nullable HWCompletionHandler)completionHandler;

- (void)cancelRequestByIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END

