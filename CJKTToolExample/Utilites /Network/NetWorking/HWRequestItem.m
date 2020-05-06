//
//  HWRequestItem.m
//  caoran
//
//  Created by caoran on 17/3/15.
//  Copyright © 2017年 caoran. All rights reserved.
//

#import "HWRequestItem.h"
#import "MD5.h"
#define md5_tail @"weyqxyy#2019"
@implementation HWRequestItem

+ (instancetype)requestItem
{
    return [[[self class] alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpMethod = kHWHTTPMethodPOST;
        _requestSerializerType = kHWRequestSerializerJSON;
        _responseSerializerType = kHWResponseSerializerJSON;
        _requestInterval = 0.5f;
        _timeoutInterval = 15.0f;
        _retryCount = 0;
        _isFrequentContinue = NO;
        _separateServer = nil;
    }
    return self;
}

- (void)setHttpMethod:(HWHTTPMethodType)httpMethod
{
    _httpMethod = httpMethod;
    _requestSerializerType = kHWRequestSerializerHTTP;
}

- (void)cleanCallbackBlocks {
    _successBlock = nil;
    _failureBlock = nil;
}
- (NSMutableDictionary *)parmeters_encode {
    if (!_parmeters_encode) {
        if (!self.parameters || !self.parameters.count) return nil;
        _parmeters_encode = [NSMutableDictionary dictionaryWithDictionary:self.parameters];
        NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch|
        
        NSWidthInsensitiveSearch|NSForcedOrderingSearch;
        
        NSComparator sort = ^(NSString *obj1,NSString *obj2){
            
            NSRange range = NSMakeRange(0,obj1.length);
            
            return [obj1 compare:obj2 options:comparisonOptions range:range];
            
        };
        NSArray *resultArray = [self.parameters.allKeys sortedArrayUsingComparator:sort];
        NSMutableString *resultString = [NSMutableString string];
        [resultArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            id value = self.parameters[obj];
            [resultString appendString:[NSString stringWithFormat:@"%@:%@|",obj,value]];
        }];
        [resultString appendString:md5_tail];
        NSString *md5_string = [MD5 md532BitLower:resultString];
        if (md5_string != nil) {
            _parmeters_encode[@"param_sign"] = md5_string;
        }
    }
    return _parmeters_encode;
}
@end
