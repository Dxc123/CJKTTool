//
//  WCDBModelManager.h
//  AUNewProject
//
//  Created by daixingchuang on 2021/2/18.
//  Copyright © 2021 Dxc_iOS. All rights reserved.
//WCDBModelManager :model统一管理类

#import <Foundation/Foundation.h>
@class LoginUserModel;
NS_ASSUME_NONNULL_BEGIN

@interface WCDBModelManager : NSObject
/**插入model数据*/
+ (BOOL)insertMessage:(LoginUserModel *)LoginUserModel;

/**删除数据*/    
+ (BOOL)deleteAllDatas:(NSString *)tableName ;


/**查询某个模型数据*/
+ (LoginUserModel *)getUserModel;


//更新model多个字段
+ (BOOL)updataProperties:(LoginUserModel *)model ;
@end

NS_ASSUME_NONNULL_END
