//
//  WCDBManager.m
//  WCDBTest
//
//  Created by iosdev on 2017/9/18.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import "WCDBManager.h"
#import <WCDB/WCDB.h>
#import "LoginUserModel+WCTTableCoding.h"

//static NSString *const UserTable = @"user";
//static NSString *const LoginUserTable = @"LoginUserTable";

@interface WCDBManager ()
@property (nonatomic,strong) WCTDatabase *dataBase;
@property (nonatomic,strong) WCTTable    *table;
@end

@implementation WCDBManager

+(WCDBManager *)shared {
   static WCDBManager *instance = nil;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       instance = [[WCDBManager alloc] init];
   });
   return instance;
}

//- (instancetype)init {
//    if (self = [super init]) {
//        NSString *databasePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database/userID"];
//        databasePath = [databasePath stringByAppendingPathComponent:@"user.db"];
//        NSLog(@"DBPath:%@",databasePath);
//        self.dataBase = [[WCTDatabase alloc]initWithPath:databasePath];
//    }
//    return self;
//}



-(NSString *)getDatabasePath {
    //获取沙盒根目录
       NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
       
       // 文件路径
       NSString *filePath = [documentsPath stringByAppendingPathComponent:@"Wechat.sqlite"];
    return filePath;
}

-(WCTDatabase *)getDatabase {
    if (!_dataBase) {
        NSString *filePath = [self getDatabasePath];
        NSLog(@"wChatDatapath = %@",filePath);
        _dataBase = [[WCTDatabase alloc]initWithPath:filePath];
    }
    return _dataBase;
}

-(WCTTable *)getDataTable:(NSString *)tableName {
    if (!_table) {
      _table    = [self.dataBase getTableOfName:tableName withClass:NSClassFromString(tableName)];
    }
    return _table;
}


-(BOOL)creatDataBaseWithName:(NSString *)tableName{
    
    [self getDatabase];
    
    // 数据库加密
    //NSData *password = [@"MyPassword" dataUsingEncoding:NSASCIIStringEncoding];
    //[database setCipherKey:password];
    //测试数据库是否能够打开
    if ([_dataBase canOpen]) {
        
        // WCDB大量使用延迟初始化（Lazy initialization）的方式管理对象，因此SQLite连接会在第一次被访问时被打开。开发者不需要手动打开数据库。
        // 先判断表是不是已经存在
        if ([_dataBase isOpened]) {
            if ([_dataBase isTableExists:tableName]) {
                CJKTLog(@"表已经存在");
                return NO;
            }else{
                CJKTLog(@"创建表");
                return [_dataBase createTableAndIndexesOfName:tableName withClass:NSClassFromString(tableName)];
            }
        }
    }
    return NO;
}


@end
