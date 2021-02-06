//
//  PINCacheHelper.m
//  AUNewProject
//
//  Created by daixingchuang on 2020/9/25.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

#import "PINCacheHelper.h"
#import <PINCache/PINCache.h>
#import <CommonCrypto/CommonDigest.h>
static PINCache *_pinCache = nil;
@interface PINCacheHelper ()
//@property (nonatomic, strong) PINCache *pinCache;
@end
@implementation PINCacheHelper



- (instancetype)init{
    self = [super init];
    if (self) {
        
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        cachePath = [cachePath stringByAppendingPathComponent:@"PINCacheShared"];
        
        _pinCache = [[PINCache sharedCache] initWithName:@"PINCacheName" rootPath:cachePath];
        
        // 最大300M，时间为一周
        _pinCache.diskCache.byteLimit = 1024 * 1024 * 300;
        _pinCache.diskCache.ageLimit = 3600 * 24 * 7;
    }
    return self;
}

+ (instancetype)shared {
    static PINCacheHelper *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[PINCacheHelper alloc] init];
        
    });
    return _sharedInstance;
}


/**缓存数据(直接存数组、字典数据)*/
- (void)saveCache:(id <NSCoding>)cache forKey:(NSString *)key {

    if (_pinCache == nil) {
        _pinCache = [PINCache sharedCache];
    }
    [_pinCache setObject:cache forKey:key];
}

/**
 取出缓存数据
 */
- (id)getCacheForKey:(NSString *)key {
   
    if (_pinCache == nil) {
        _pinCache = [PINCache sharedCache];
    }
    return  [_pinCache objectForKey:key];
    


}


////////////////////////////

/**
 缓存json字典数据（处理去除jsonDic里的特殊字典）
 */
- (void)saveResponseDicCache:(NSDictionary *)jsonDic  forKey:(NSString *)key {
    
    NSData *responseCache  = [self handelJsonDic:jsonDic];
    
    if (_pinCache == nil) {
        _pinCache = [PINCache sharedCache];
    }
    [_pinCache setObject:responseCache forKey:key];
}
/**取出缓存的数据*/

- (id)getResponseCacheForKey:(NSString *)key {
   
    if (_pinCache == nil) {
        _pinCache = [PINCache sharedCache];
    }
    
    id cacheData;
    cacheData = [_pinCache objectForKey:key];//[self cachedFileNameForKey:key]
    id cacheResult;
    if (cacheData != 0) {
        cacheResult = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
    }
    
    return cacheResult;
    


}
/**删除缓存 */
- (void)removeResponseCacheForKey:(NSString *)key {
    if (_pinCache == nil) {
        _pinCache = [PINCache sharedCache];
    }
    [_pinCache removeObjectForKey:key];
}

/** 删除所有的缓存*/
- (void)removeAllResponseCache {
    if (_pinCache == nil) {
        _pinCache = [PINCache sharedCache];
    }
    [_pinCache removeAllObjects];
}
#pragma mark -- Private Methds

//加密 key
- (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = key.UTF8String;
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15], [key.pathExtension isEqualToString:@""] ? @"" : [NSString stringWithFormat:@".%@", key.pathExtension]];
    return filename;
}

//参数数组、字典 转成 json格式的字符串
- (NSString *)convertJsonStringFromDictionaryOrArray:(id)parameter {
    NSData *data = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return jsonStr;
}

//处理json字典里的特殊字符
- (NSData*)handelJsonDic:(NSDictionary *)jsonDic{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *dataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    dataString = [self removeSpecialCodeWithStr:dataString];
    
    NSData *requestData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    return requestData;
}




//   去除json格式的字符串中的换行符、回车符
- (NSString *)removeSpecialCodeWithStr:(NSString *)str {
    NSString *string = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@")" withString:@""];
    return string;
}
@end
