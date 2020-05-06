//
//  CJKTSingleton.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/25.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CJKTUserModel;
@interface CJKTSingleton : NSObject
@property (nonatomic,strong) CJKTUserModel *myUser;


+ (instancetype)sharedInstance;

//是否登录
- (BOOL)isLogin;

- (void)clearUser;
@end

NS_ASSUME_NONNULL_END
