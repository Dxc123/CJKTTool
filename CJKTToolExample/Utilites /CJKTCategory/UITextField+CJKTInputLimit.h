//
//  UITextField+CJKTInputLimit.h
//  CJKTCategoryExample
//
//  Created by Dxc_iOS on 2018/11/16.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (CJKTInputLimit)
/**
 UITextField限制最大字符数 （<=0,没限制）
 */
@property (assign, nonatomic)  NSInteger cjkt_maxLength;

/**
 判断文本框是否为空（非正则表达式）
 */

- (BOOL)cjkt_isEmpty;

/**
 判断邮箱是否正确
 */

- (BOOL)cjkt_validateEmail;

/**
 判断验证码是否正确
 */

- (BOOL)cjkt_validateAuthen;

/**
 判断密码格式是否正确
 */

- (BOOL)cjkt_validatePassword;

/**
 判断手机号码是否正确
 */

- (BOOL)cjkt_validatePhoneNumber;

/**
 自己写正则传入进行判断
 */

- (BOOL)cjkt_validateWithRegExp: (NSString *)regExp;

/**
 校验密码
 */
- (BOOL)cjkt_isPassword:(NSString *)Password;

@end

NS_ASSUME_NONNULL_END
