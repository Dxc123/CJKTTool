//
//  PINCacheHelper.h
//  AUNewProject
//
//  Created by daixingchuang on 2020/9/25.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PINCacheHelper : NSObject


+ (instancetype)shared;


/**缓存数据(直接存数组、字典数据)*/

- (void)saveCache:(id <NSCoding>)cache forKey:(NSString *)key;
/**取出缓存的数据*/
- (id)getCacheForKey:(NSString *)key ;



////////////////////////////
/**
 缓存json字典数据（处理去除jsonDic里的特殊字典）
 */
- (void)saveResponseDicCache:(NSDictionary *)jsonDic  forKey:(NSString *)key;

/**取出缓存的数据*/
- (id)getResponseCacheForKey:(NSString *)key;


/**删除缓存 */
- (void)removeResponseCacheForKey:(NSString *)key;


/** 删除所有的缓存*/
//退出登录删除所有的缓存
- (void)removeAllResponseCache;
@end

NS_ASSUME_NONNULL_END
