//
//  WCDBModelManager.m
//  AUNewProject
//
//  Created by daixingchuang on 2021/2/18.
//  Copyright © 2021 Dxc_iOS. All rights reserved.
//

#import "WCDBModelManager.h"
#import "WCDBManager.h"
#import <WCDB/WCDB.h>
#import "LoginUserModel.h"
#import "LoginUserModel+WCTTableCoding.h"

@implementation WCDBModelManager
//通过WCTDatabase和WCTTable两个类进行一般的增删改查操作

//插入数据
+ (BOOL)insertMessage:(LoginUserModel *)LoginUserModel {
 
    BOOL result =  [[[WCDBManager shared] getDatabase] insertObject:LoginUserModel into:@"LoginUserModel"];
    if (result) {
        CJKTLog(@"插入成功");
    } else{
        CJKTLog(@"插入失败");
    }

    return result;
}

////// WCTDatabase 事务操作，利用WCTTransaction
//+ (BOOL)insertMessageWithTransaction:(LoginUserModel *)LoginUserModel {
//
//    BOOL ret = [[[WCDBManager shared] getDatabase] beginTransaction];
//       ret = [self insertMessage:LoginUserModel];
//       if (ret) {
//           [[[WCDBManager shared] getDatabase] commitTransaction];
//       }else{
//           [[[WCDBManager shared] getDatabase] rollbackTransaction];
//       }
//       return ret;
//}
////// 另一种事务处理方法Block
//+ (BOOL)insertMessageWithBlock:(LoginUserModel *)LoginUserModel {
//    BOOL commit = [[[WCDBManager shared] getDatabase] runTransaction:^BOOL{
//           BOOL ret = [self insertMessage:LoginUserModel];
//           if (ret) {
//               return YES;
//           }else{
//               return NO;
//           }
//       } event:^(WCTTransactionEvent event) {
//           NSLog(@"Event %d", event);
//       }];
//       return commit;
//}
//    删除
+ (BOOL)deleteAllDatas:(NSString *)tableName {
    BOOL result = [[[WCDBManager shared] getDatabase] deleteAllObjectsFromTable:tableName];

    if (result) {
      CJKTLog(@"删除成功");
    } else{
      CJKTLog(@"删除失败");
    }
    return  result;
}


//查询 数组数据
//+ (NSArray *)getLoginUserModel {
//    NSArray<LoginUserModel *> * message = [[[WCDBManager shared] getDatabase] getObjectsOfClass:LoginUserModel.class fromTable:@"LoginUserModel" orderBy:LoginUserModel.uid.order()];
//       return message;
//}

//查询 某个模型数据
+ (LoginUserModel *)getUserModel{
    
//    return [[[WCDBManager shared] getDataTable:@"LoginUserModel"] getAllObjectsOnResults:LoginUserModel.AllProperties].firstObject;
    
    return  [[[WCDBManager shared] getDatabase] getAllObjectsOfClass:LoginUserModel.class fromTable:@"LoginUserModel"].firstObject;
}


//更新model某个字段
//+ (BOOL)updataOneProperty:(LoginUserModel *)model {
//
//    BOOL result =  [[[WCDBManager shared] getDatabase] updateAllRowsInTable:@"LoginUserModel" onProperty: LoginUserModel.nickname withObject:model];
//
//    if (result) {
//        CJKTLog(@"更新成功");
//    } else{
//        CJKTLog(@"更新失败");
//    }
//
//    return  result;
//
//}


//更新model多个字段
+ (BOOL)updataProperties:(LoginUserModel *)model {
    BOOL result = [[[WCDBManager shared] getDatabase] updateAllRowsInTable:@"LoginUserModel" onProperties:LoginUserModel.AllProperties withObject:model];

    if (result) {
       CJKTLog(@"更新成功");
    } else{
       CJKTLog(@"更新失败");
    }
    return  result;
}

@end
