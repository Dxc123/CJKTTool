//
//  MBProgressHUD+ZWX.m
//  ULOSDKDemo
//
//  Created by sky-red on 16/7/28.
//  Copyright © 2016年 深圳优络科技发展有限公司. All rights reserved.
//

#import "MBProgressHUD+ULO.h"

@implementation MBProgressHUD (ULO)

+ (void)showLoadingToView:(UIView *)view
{
    [self showMessage:@"加载中"
          detailsText:nil
                 icon:nil
               toView:view
                delay:-1
                 mode:MBProgressHUDModeIndeterminate
           completion:nil];
}

+ (void)showSuccessMsg:(NSString *)message toView:(UIView *)toView
{
    [self showMessage:message
          detailsText:nil
                 icon:@"success"
               toView:toView
                delay:1.5
                 mode:MBProgressHUDModeCustomView
           completion:nil];
}

+ (void)showErrorMsg:(NSString *)message toView:(UIView *)toView
{
    [self showMessage:message
          detailsText:nil
                 icon:@"error"
               toView:toView
                delay:1.8
                 mode:MBProgressHUDModeCustomView
           completion:nil];
}

/**
 *  隐藏
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

/**
 *  显示消息
 *
 *  @param message       消息内容
 *  @param detailsText   消息详情
 *  @param view          显示的视图
 */
+ (void)showMessage:(NSString *)message
        detailsText:(NSString *)detailsText
               icon:(NSString *)icon
             toView:(UIView *)view
              delay:(CGFloat)delay
               mode:(MBProgressHUDMode)mode
         completion:(MBProgressHUDCompletionBlock)completion
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.labelFont = [UIFont boldSystemFontOfSize:16];
    
    // 设置图片
    if (mode == MBProgressHUDModeCustomView) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    }
    
    // 再设置模式
    hud.mode = mode;
    hud.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.68];
    hud.margin = 36.f;
    hud.cornerRadius = 8.f;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 设置关闭回调通知
    hud.completionBlock = completion;
    
    if (delay < 0.0) {
        return;
    }
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:delay];
}

@end
