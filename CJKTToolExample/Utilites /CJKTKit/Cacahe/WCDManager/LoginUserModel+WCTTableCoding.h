//
//  LoginUserModel+WCTTableCoding.h
//  AUNewProject
//
//  Created by daixingchuang on 2020/12/16.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

#import "LoginUserModel.h"
#import <WCDB/WCDB.h>
NS_ASSUME_NONNULL_BEGIN

@interface LoginUserModel (WCTTableCoding)<WCTTableCoding>
/*
 需要绑定到表中的字段在这里声明，在LoginUserModel.mm中去绑定
 使用WCDB_PROPERTY宏在头文件声明需要绑定到数据库表的字段。
 */

WCDB_PROPERTY(uid)
WCDB_PROPERTY(nickname)
WCDB_PROPERTY(portrait)
WCDB_PROPERTY(gender)
WCDB_PROPERTY(likeCount)
WCDB_PROPERTY(followCount)
WCDB_PROPERTY(birthday)
WCDB_PROPERTY(auth)


WCDB_PROPERTY(isDND)
WCDB_PROPERTY(deposit)
WCDB_PROPERTY(totalInpour)
WCDB_PROPERTY(penalty)
WCDB_PROPERTY(created)


WCDB_PROPERTY(vipEndTime)
WCDB_PROPERTY(level)
WCDB_PROPERTY(status)
WCDB_PROPERTY(isValid)
WCDB_PROPERTY(beginDate)
WCDB_PROPERTY(endDate)
WCDB_PROPERTY(changeLevel)
WCDB_PROPERTY(effectiveDate)


WCDB_PROPERTY(createdate)


@end

NS_ASSUME_NONNULL_END
/**
 @property(nonatomic,copy)  NSString   *uid;               // 用户ID
 @property(nonatomic,copy)  NSString   *nickname;          // 昵称
 @property(nonatomic,copy)  NSString   *portrait;          // 头像
 @property(nonatomic,assign)int        gender;             // 性别
 @property(nonatomic,assign)int        likeCount;          // 被关注数
 @property(nonatomic,assign)int        followCount;        // 关注数
 @property(nonatomic,assign)long       birthday;           // 出生日期 时间戳
 @property(nonatomic,assign)int auth;// 认证状态，0是未认证，1是认证中，2是认证成功，-1是认证失敗

 @property(nonatomic,assign)int        isDND;              // 是否设置了免打扰 1已设置
 @property(nonatomic,assign)int        deposit;            // 剩余钻石数
 @property(nonatomic,assign)int        totalInpour;        // 总儲值的鑽石数量
 @property(nonatomic,assign)int        penalty;// 该用户是否被封禁 1是, 0不是
 @property (nonatomic, assign) BOOL    created;// 是否是新用户  1 是，0 不是

 //VIP相关
 @property(nonatomic,assign)long       vipEndTime; // vip到期时间
 @property(nonatomic,assign)int        level;      // 用户头衔 0无等级；1周订阅; 2月订阅
 @property(nonatomic,assign)int        status;     // 等级状态，用户订阅状态. 0 没订阅；1 新订阅；2 续订；3变更订阅，4退订
 @property(nonatomic,assign)int        isValid;   // 该订阅是否有效 0:无效  1:有效
 @property(nonatomic,assign)long       beginDate; // 订阅起始时间
 @property(nonatomic,assign)long       endDate;    // 订阅结束时间
 @property(nonatomic,assign)int        changeLevel; // 变更订阅后的等级
 @property(nonatomic,assign)long       effectiveDate; // 变更订阅的生效日期

 */
