//
//  WCDManager.h
//  WCDBTest
//
//  Created by iosdev on 2017/9/18.
//  Copyright © 2017年 iosdev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WCTDatabase;
@class WCTTable;
@interface WCDBManager : NSObject

+(WCDBManager *)shared;

- (WCTDatabase *)getDatabase;
-(WCTTable *)getDataTable:(NSString *)tableName ;
/**
 创建数据库
 @param tableName 表名称
 @return 是否创建成功
 */
- (BOOL)creatDataBaseWithName:(NSString *)tableName;

@end
