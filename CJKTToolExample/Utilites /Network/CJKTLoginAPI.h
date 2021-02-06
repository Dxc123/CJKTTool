//
//  CJKTLoginAPI.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/9/16.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJKTLoginAPI : NSObject
//获取 token
+ (void)getToken:(void (^)(BOOL success, NSString *token, NSString *userId))completeBlock;

/**用户注册*/
+ (void)registerWithNickname:(NSString *)nickname
        password:(NSString *)password
verificationCode:(NSString *)verificationCode
        completeBlock:(void (^)(BOOL success))completeBlock;
//修改密码
+ (void)changePassword:(NSString *)oldPwd
                newPwd:(NSString *)newPwd
         completeBlock:(void (^)(BOOL success))completeBlock;
@end

NS_ASSUME_NONNULL_END
