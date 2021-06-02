//
//  LoginUserModel.m
//  AUNewProject
//
//  Created by daixingchuang on 2020/12/16.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

#import "LoginUserModel.h"
#import "LoginUserModel+WCTTableCoding.h"

@implementation LoginUserModel
// 定义绑定到数据库表的类
WCDB_IMPLEMENTATION(LoginUserModel)

// 定义需要绑定到数据库表的字段
WCDB_SYNTHESIZE(LoginUserModel, uid)
WCDB_SYNTHESIZE(LoginUserModel, nickname)
WCDB_SYNTHESIZE(LoginUserModel, portrait)
WCDB_SYNTHESIZE(LoginUserModel, gender)


//WCDB_SYNTHESIZE(LoginUserModel, likeCount)
//WCDB_SYNTHESIZE(LoginUserModel, followCount)
//WCDB_SYNTHESIZE(LoginUserModel, birthday)
//WCDB_SYNTHESIZE(LoginUserModel, auth)
//
//WCDB_SYNTHESIZE(LoginUserModel, isDND)
//WCDB_SYNTHESIZE(LoginUserModel, deposit)
//WCDB_SYNTHESIZE(LoginUserModel, totalInpour)
//WCDB_SYNTHESIZE(LoginUserModel, penalty)
//WCDB_SYNTHESIZE(LoginUserModel, created)
//
//
//WCDB_SYNTHESIZE(LoginUserModel, vipEndTime)
//WCDB_SYNTHESIZE(LoginUserModel, level)
//WCDB_SYNTHESIZE(LoginUserModel, status)
//WCDB_SYNTHESIZE(LoginUserModel, isValid)
//WCDB_SYNTHESIZE(LoginUserModel, beginDate)
//WCDB_SYNTHESIZE(LoginUserModel, endDate)
//WCDB_SYNTHESIZE(LoginUserModel, changeLevel)
//WCDB_SYNTHESIZE(LoginUserModel, effectiveDate)


WCDB_SYNTHESIZE(LoginUserModel, createdate)

#pragma mark - 设置主键
WCDB_PRIMARY(LoginUserModel, createdate)

//#pragma mark - 设置索引
WCDB_INDEX(LoginUserModel, "_index", createdate)

@end
