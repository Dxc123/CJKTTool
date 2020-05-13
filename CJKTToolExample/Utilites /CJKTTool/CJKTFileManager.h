//
//  CJKTFileManager.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/5/11.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 沙盒目录下有三个文件夹：
 Documents: 应用程序的数据文件
 Library：
         Library/Caches     主要是缓存文件
         Library/Preferences 应用程序的偏好设置文件（NSUserDefaults写的设置数据都会保存到该目录）
 temp：   各种临时文件
 */


//一般来说，文件要么放在Document,要么放在Labrary下的Cache里面
@interface CJKTFileManager : NSObject
#pragma mark - 沙盒目录相关
// 沙盒的主目录路径
+ (NSString *)homeDir;
// 沙盒中Documents的目录路径
+ (NSString *)documentsDir;
// 沙盒中Library的目录路径
+ (NSString *)libraryDir;
// 沙盒中Libarary/Preferences的目录路径
+ (NSString *)preferencesDir;
// 沙盒中Library/Caches的目录路径
+ (NSString *)cachesDir;
// 沙盒中tmp的目录路径
+ (NSString *)tmpDir;


/// 获取一个完整的文件路径
/// @param filePathName 某个路径名称
/// @param fileName 文件名称
/// @param fileType 文件后缀(如.mp3)
+ (NSString *)cjkt_getFilePath:(NSString *)filePathName
                      FileName:(NSString *)fileName
                      fileType:(NSString *)fileType;


///  获取某个路径名称
/// @param PathName 路径名称
+ (NSString *)cjkt_getFolderPath:(NSString *)PathName;

/// 获取文件名称
/// @param fileName 文件名称
/// @param fileType 文件后缀(如.mp3)
+ (NSString *)cjkt_getFileName:(NSString *)fileName
                      fileType:(NSString *)fileType;


/// 移除文件
/// @param filePath 文件路径
+ (BOOL)cjkt_removeFile:(NSString *)filePath;


@end

NS_ASSUME_NONNULL_END
