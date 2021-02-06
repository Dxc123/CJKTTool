//
//  CJKTFileManager.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/5/11.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "CJKTFileManager.h"

@implementation CJKTFileManager
#pragma mark - 沙盒目录相关
+ (NSString *)homeDir {
    return NSHomeDirectory();
}

+ (NSString *)documentsDir {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)libraryDir {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];;
}

+ (NSString *)preferencesDir {
    NSString *libraryDir = [self libraryDir];
    return [libraryDir stringByAppendingPathComponent:@"Preferences"];
}

+ (NSString *)cachesDir {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)tmpDir {
    return NSTemporaryDirectory();
}



/// 获取一个完整的文件路径
/// @param filePathName 某个路径名称
/// @param fileName 文件名称
/// @param fileType 文件后缀(如.mp3)
+ (NSString *)cjkt_getFilePath:(NSString *)filePathName
                      FileName:(NSString *)fileName
                      fileType:(NSString *)fileType{
    NSString *path = [CJKTFileManager cjkt_getFolderPath:filePathName];
    NSString *filename = [CJKTFileManager cjkt_getFileName:filePathName fileType:fileType];
    
    return [path stringByAppendingPathComponent:filename];
}




///  获取某个路径名称
/// @param PathName 路径名称
+ (NSString *)cjkt_getFolderPath:(NSString *)PathName {
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *cwFolderPath = [NSString stringWithFormat:@"%@/%@",documentDir, PathName];
    BOOL isExist =  [[NSFileManager defaultManager]fileExistsAtPath:cwFolderPath];
    if (!isExist) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cwFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return cwFolderPath;
}

/// 获取文件名称
/// @param fileName 文件名称
/// @param fileType 文件后缀(如.mp3)
+ (NSString *)cjkt_getFileName:(NSString *)fileName fileType:(NSString *)fileType{
    NSString *file = [NSString stringWithFormat:@"%@_%lld%@",fileName,(long long)[NSDate timeIntervalSinceReferenceDate],fileType];
    return file;
}


/// 移除文件
/// @param filePath 文件路径
+ (BOOL)cjkt_removeFile:(NSString *)filePath{
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return YES;
    }
    
    
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    
    if (success) {
        NSLog(@"--%@移除了", filePath);
        return YES;
    } else {
        return NO;
    }
}

@end
