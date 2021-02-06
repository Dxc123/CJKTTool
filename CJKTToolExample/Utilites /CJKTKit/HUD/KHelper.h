//
//  KHelper.h
//  AUNewProject
//
//  Created by daixingchuang on 2020/8/13.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//扩展第三方库
@interface KHelper : NSObject

//Toast
/**居中显示的Toast*/
+ (void)makeToast:(NSString *)str;
+ (void)makeToastActivity;
+ (void)hideToastActivity;

//MBProgressHUD
+(void)showHUD:(NSString *)hint;

+(void)showHudActivity;
+(void)showHudActivity:(NSString *)str;
+ (void)hideHudActivity;


//SVProgressHUD

+ (void)showSVLoading;
/**
 showSVLoading(不会自动消息)
 */
+ (void)showSVLoading:(NSString *)title;
/**
 dismissSV
 */
+ (void)dismissSV;
/**
 isVisibleSV
 */
+ (BOOL)isVisibleSV;
/**
 showSVProgress
 */
+ (void)showSVProgress:(CGFloat)progress;

/**
 showSVSuccessToast
 */
+ (void)showSVSuccessToast:(NSString *)message;
/**
 showSVErrorToast
 */
+ (void)showSVErrorToast:(NSString *)message;
/**
 showSVWarningToast
 */
+ (void)showSVWarningToast:(NSString *)message;


@end

NS_ASSUME_NONNULL_END
