//
//  AUNetWorkManager.h
//  AUNewProject
//
//  Created by daixingchuang on 2020/8/10.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//


#import "YYCacheManager.h"
#import "YYCache.h"

//NSString *const kCaches = @"YYCache";
@interface YYCacheManager ()
@property(nonatomic,strong) YYCache *cache;
@end
@implementation YYCacheManager

- (instancetype)init{
    self = [super init];
    if (self) {
        
        _cache = [[YYCache alloc] initWithName:@"YYCachePlist"];
        _cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
        _cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    }
    return self;
}


+ (instancetype)shared {
    static YYCacheManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[YYCacheManager alloc] init];
    });
    return _sharedInstance;
}

/**缓存中是否有该key的缓存，同步操作*/
- (BOOL)containsObjectForKey:(NSString *)key {
    return [self.cache containsObjectForKey:key];
}
/**缓存中是否有该key的缓存，异步操作*/
- (void)containsObjectForKey:(NSString *)key withBlock:(void (^)(NSString *, BOOL))block {
    [self.cache containsObjectForKey:key withBlock:block];
}

#pragma mark -- Get 操作
/**获取该key的值，同步操作*/
- (id)objectForKey:(NSString *)key {
    return [self.cache objectForKey:key];
}

/**获取该key的值，异步操作*/
- (void)objectForKey:(NSString *)key withBlock:(void (^)(NSString *, id<NSCoding>))block {
    [self.cache objectForKey:key withBlock:block];
}
/**获取布尔值*/
- (BOOL)boolForKey:(NSString *)key{
    NSNumber *number = (NSNumber *)[self.cache objectForKey:key];
    return [number boolValue];
}
/**获取NSInteger值*/
- (NSInteger)integerForKey:(NSString *)key{
    NSNumber *number = (NSNumber *)[self.cache objectForKey:key];
    return [number integerValue];
}
/**获取long long值*/
- (long long)longLongForKey:(NSString *)key{
    NSNumber *number = (NSNumber *)[self.cache objectForKey:key];
    return [number longLongValue];
}
/**获取float值*/
- (float)floatForKey:(NSString *)key{
    NSNumber *number = (NSNumber *)[self.cache objectForKey:key];
    return [number floatValue];
}
/**获取double*/
- (double)doubleForKey:(NSString *)key{
    NSNumber *number = (NSNumber *)[self.cache objectForKey:key];
    return [number doubleValue];
}
/**获取string值*/
- (nullable NSString *)stringForKey:(NSString *)key{
    NSNumber *number = (NSNumber *)[self.cache objectForKey:key];
    return [number stringValue];
}
#pragma mark -- Save 操作
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    [self setObject:object forKey:key alsoSaveInMemory:NO];
}
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key alsoSaveInMemory:(BOOL)alsoSaveInMemory {
    if (alsoSaveInMemory) {
        [self.cache setObject:object forKey:key];
    } else {
        [self.cache.memoryCache removeObjectForKey:key];//保证下次读取不会有问题
        [self.cache.diskCache setObject:object forKey:key];
    }
}
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void (^)(void))block {
    [self setObject:object forKey:key alsoSaveInMemory:NO withBlock:block];
}
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key alsoSaveInMemory:(BOOL)alsoSaveInMemory withBlock:(void (^)(void))block {
    if (alsoSaveInMemory) {
        [self.cache setObject:object forKey:key withBlock:block];
    } else {
        [self.cache.diskCache setObject:object forKey:key withBlock:block];
    }
}

#pragma mark -- 删除操作
- (void)removeObjectForKey:(NSString *)key {
    [self.cache removeObjectForKey:key];
}
- (void)removeObjectForKey:(NSString *)key withBlock:(void (^)(NSString *))block {
    [self.cache removeObjectForKey:key withBlock:block];
}
- (void)removeAllObjects {
    [self.cache removeAllObjects];
}
- (void)removeAllObjectsWithBlock:(void(^)(void))block {
    [self.cache removeAllObjectsWithBlock:block];
}
- (void)removeAllObjectsWithProgressBlock:(void (^)(int, int))progress endBlock:(void (^)(BOOL))end {
    [self.cache removeAllObjectsWithProgressBlock:progress endBlock:end];
}

/////////////////////////
///

/**
 获取缓存字典
*/
- (id)getCacheData:(NSString *)cacheKey{
    id cacheData;
    cacheData = [self.cache objectForKey:cacheKey];
    id myResult;
    if (cacheData != 0) {
        myResult = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
    }
    
    return myResult;
    
}


/**
缓存字典
*/
- (void)setCacheData:(NSDictionary *)data WithKey:(NSString *)cacheKey{
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *dataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    dataString = [self deleteSpecialCodeWithStr:dataString];
    NSData *requestData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.cache setObject:requestData forKey:cacheKey];
    //:(id<NSCoding>)object
    
}


/**
删除缓存数据
 */
- (void)removeCacheData:(NSString *)cacheKey{
    [self.cache removeObjectForKey:cacheKey];
    
}






///**
//缓存资源媒体数组
// */
//- (void)saveMyMediaDataArr:(NSMutableArray *)array{
//    NSMutableArray *arrayl=[NSMutableArray array];
//    for (int i=0; i<array.count; i++) {
//        AUMyMediaModel *Model = array[i];
//        NSDictionary *dict = [Model modelToJSONObject];
//        [arrayl addObject:dict];
//    }
//    
//    //保存数组在本地
//    NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
//    NSString * fileName = [docDir stringByAppendingPathComponent:@"AUMyMediaModel"];
//    [arrayl writeToFile:fileName atomically:YES];
//}
//
///**
//资源媒体获取
//*/
//- (NSMutableArray *)getMyMediaData{
//    NSString * docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
//    NSString * fileName = [docDir stringByAppendingPathComponent:@"AUMyMediaModel"];
//    NSArray * models = [NSArray arrayWithContentsOfFile:fileName];
//    //将取出来的字典数组转化为模型数组
//    NSMutableArray *arrayArr = [NSMutableArray array];
//    for (int i= 0; i< models.count; i++) {
//        NSDictionary *dict = models[i];
//        //字典转模型
//        AUMyMediaModel *Model = [AUMyMediaModel modelWithJSON:dict];
//        [arrayArr addObject:Model];
//    }
//    return arrayArr;
//}
//
///**
//资源媒体删除
//*/
//-(void)removeMyMediaCache {
//    NSFileManager* fileManager=[NSFileManager defaultManager];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"AUMyMediaModel"];
//    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
//    if (!blHave) {
//        NSLog(@"no  have");
//        return;
//    }else {
//        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
//        if (blDele) {
//            NSLog(@"dele success");
//        }else {
//            NSLog(@"dele fail");
//        }
//    }
//}



#pragma mark --Private:  处理json格式的字符串中的换行符、回车符
- (NSString *)deleteSpecialCodeWithStr:(NSString *)str {
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
