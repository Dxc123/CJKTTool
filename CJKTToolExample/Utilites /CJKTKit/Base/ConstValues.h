//
//  AUConstValues.h
//  AUNewProject
//
//  Created by daixingchuang on 2020/12/2.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConstValues : NSObject


/*** 常量 key*/

// 多语言相关


///对应的语言
UIKIT_EXTERN NSString *const Language_Key;

UIKIT_EXTERN NSString * const kIsSetLanguage;

//语言
///简体中文
UIKIT_EXTERN NSString *const Chinese_Simple;
///繁体中文
UIKIT_EXTERN NSString *const Chinese_Traditional;

///英文
UIKIT_EXTERN NSString *const English_US ;
///印尼
UIKIT_EXTERN NSString *const Indonesian ;
///中东阿拉伯
UIKIT_EXTERN NSString *const Arabic;

@end

NS_ASSUME_NONNULL_END
