//
//  CJKTAPIs.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 CJKT. All rights reserved.
//

#ifndef CJKTAPIs_h
#define CJKTAPIs_h

//API字符串

/**
 验证码登录
 */
UIKIT_EXTERN NSString * const auth_logIn_code_api;
/**
 获取验证码  code_type: Reg注册 Forget忘记密码 Login 登录
 */
UIKIT_EXTERN NSString * const auth_get_verification_code_api;
/**
 密码登录
 */
UIKIT_EXTERN NSString * const auth_logIn_secret_api;

#endif /* CJKTAPIs_h */
