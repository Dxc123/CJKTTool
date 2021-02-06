//
//  AUNetWorkManager.h
//  AUNewProject
//
//  Created by daixingchuang on 2020/8/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYCacheManager : NSObject

+ (instancetype)shared;

/** Save中是否有该key的 Save，同步操作*/
- (BOOL)containsObjectForKey:(NSString *)key;

/** Save中是否有该key的 Save，异步操作*/
- (void)containsObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, BOOL contains))block;

#pragma mark -- Get 操作

/** Get该key的值，同步操作*/
- (nullable id)objectForKey:(NSString *)key;

/** Get该key的值，异步操作*/
- (void)objectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, id<NSCoding> object))block;

/** Get 布尔值*/
- (BOOL)boolForKey:(NSString *)key;
/** Get NSInteger值*/
- (NSInteger)integerForKey:(NSString *)key;
/** Get long long值*/
- (long long)longLongForKey:(NSString *)key;
/** Get float值*/
- (float)floatForKey:(NSString *)key;
/** Get double*/
- (double)doubleForKey:(NSString *)key;
/** Get string值*/
- (nullable NSString *)stringForKey:(NSString *)key;


#pragma mark -- Save 操作
/* Save该key的值，不存到内存 Save里，同步操作**/
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key;

/* Save该key的值，可设置存到内存 Save里，同步操作**/
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key alsoSaveInMemory:(BOOL)alsoSaveInMemory;

/** Save该key的值，不存到内存 Save里，异步操作*/
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key withBlock:(nullable void(^)(void))block;

/* Save该key的值，可设置存到内存 Save里，异步操作**/
- (void)setObject:(nullable id<NSCoding>)object forKey:(NSString *)key alsoSaveInMemory:(BOOL)alsoSaveInMemory withBlock:(nullable void(^)(void))block;


#pragma mark -- remove 操作


/**remove该key的 Save，异步操作*/
- (void)removeObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key))block;

/**remove所有缓存，同步操作*/
- (void)removeAllObjects;

/**remove所有缓存，异步操作*/
- (void)removeAllObjectsWithBlock:(void(^)(void))block;

/**remove所有缓存，并且 Get移除进度，异步操作*/
- (void)removeAllObjectsWithProgressBlock:(nullable void(^)(int removedCount, int totalCount))progress  endBlock:(nullable void(^)(BOOL error))end;


/////////////////////////
///
/**
 Save字典
*/
- (void)setCacheData:(NSDictionary *)data WithKey:(NSString *)cacheKey;

/**
  Get Save字典
 */
- (id)getCacheData:(NSString *)cacheKey;


/**remove该cacheKey Save数据*/
- (void)removeCacheData:(NSString *)cacheKey;

//
//////////////////////////
///// Save数组
/////////////////////////////
///**
//   Save数组（我的个人中心视频资源）
// */
//- (void)saveMyMediaDataArr:(NSMutableArray *)array;
//
///**
//  Get我的个人中心视频资源
// */
//- (NSMutableArray *)getMyMediaData;
//
///**
// remove Save-我的个人中心视频资源
// */
//- (void)removeMyMediaCache;

@end

NS_ASSUME_NONNULL_END
