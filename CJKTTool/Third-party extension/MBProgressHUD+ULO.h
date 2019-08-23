//
//  MBProgressHUD+ZWX.h
//  ULOSDKDemo
//
//  Created by sky-red on 16/7/28.
//  Copyright © 2016年 深圳优络科技发展有限公司. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (ULO)

/**
 *  显示加载中...
 *
 *  @param view
 */
+ (void)showLoadingToView:(UIView *)view;


/**
 *  显示成功的消息
 *
 *  @param message    消息内容
 *  @param toView     显示的父视图
 */
+ (void)showSuccessMsg:(NSString *)message
                toView:(UIView *)toView;

/**
 *  显示错误的消息
 *
 *  @param message    消息内容
 *  @param toView     显示的父视图
 */
+ (void)showErrorMsg:(NSString *)message
              toView:(UIView *)toView;

/**
 *  隐藏
 */
+ (void)hideHUDForView:(UIView *)view;


@end
