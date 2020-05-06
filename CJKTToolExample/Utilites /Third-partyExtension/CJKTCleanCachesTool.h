//
//  CJKTCleanCachesTool.h
//  QYSearchProject
//
//  Created by Dxc_iOS on 2018/12/29.
//  Copyright © 2018 cjkt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 方法一： 利用SDWebImage计算并清理缓存
/**
 由于缓存文件是存在 App 的沙盒中，所以我们可以通过 NSFileManager API 来实现对缓存文件大小的计算和数据的删除操作。
 计算caches文件夹下内容的大小，然后根据其大小再判断是否清除缓存。(根据路径删除文件或文件夹)
 */
@interface CJKTCleanCachesTool : NSObject
/**
计算单个文件大小
 */
+ (float)fileSizeAtPath:(NSString *)path;

/**
 计算文件夹大小(要利用上面的1提供的方法)
 */
+ (float)folderSizeAtPath:(NSString *)path;


/**
 SDImag清除缓存
 */
+ (void)clearCache:(NSString *)path;


/**
示例：
 NSArray *pathsDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);//缓存路径
 NSString *path = [pathsDir objectAtIndex:0];//缓存
 NSString *str = [NSString stringWithFormat:@"是否清除缓存%.1fM", [CJKTCleanCachesTool folderSizeAtPath:path]];
 NSString *strs = [NSString stringWithFormat:@"已清除缓存%.1fM", [CJKTCleanCachesTool folderSizeAtPath:path]];
 
 */




/**
 方法二
 
 */

/**
*  获取path路径下文件夹的大小
*/
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path;

/**
 *  清除path路径下文件夹的缓存
 */
+ (BOOL)clearCacheWithFilePath:(NSString *)path;






@end

NS_ASSUME_NONNULL_END
