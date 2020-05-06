//
//  MBProgressHUD+CJKTHud.m
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2019/8/26.
//  Copyright © 2019 CJKT. All rights reserved.
//

#import "MBProgressHUD+CJKTHud.h"

@implementation MBProgressHUD (CJKTHud)
/**
 *  显示文字信息(文字+默认菊花圈圈)
 */
+ (void)showMessage:(NSString *)message
             toView:(UIView *)view{
    [self showMessage:message
          detailsText:nil
                 icon:nil
               toView:view
                delay:-1
                 mode:MBProgressHUDModeIndeterminate
           completion:nil];
}
//显示成功的消息（文字+默认图片）
+ (void)showSuccessMsg:(NSString *)message toView:(UIView *)toView{
    [self showMessage:message
          detailsText:nil
                 icon:@"success"
               toView:toView
                delay:1.5
                 mode:MBProgressHUDModeCustomView
           completion:nil];
}
//显示错误的消息（文字+默认图片）
+ (void)showErrorMsg:(NSString *)message toView:(UIView *)toView{
    [self showMessage:message
          detailsText:nil
                 icon:@"error"
               toView:toView
                delay:1.5
                 mode:MBProgressHUDModeCustomView
           completion:nil];
}



/**
 *  隐藏
 */
+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [self hideHUDForView:view animated:YES];
}

+(void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry toView:(UIView *)toView{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:toView animated:YES];
    
    hud.label.text = msg;
    hud.mode = MBProgressHUDModeCustomView;
    // 设置图片
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.animationImages = imgArry;
    [showImageView setAnimationRepeatCount:0];
    [showImageView setAnimationDuration:(imgArry.count + 1) * 0.075];
    [showImageView startAnimating];
    
    hud.customView = showImageView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
}


/**
 公共方法：显示消息
 
 @param message 消息内容
 @param detailsText 消息详情
 @param icon 图片
 @param view superView
 @param delay  延迟时间
 @param mode 模式
 @param completion 回调
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
    hud.label.text = message;
    hud.label.font = [UIFont boldSystemFontOfSize:16];
    
    // 设置图片
    if (mode == MBProgressHUDModeCustomView) {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    }
    
    // 再设置模式
    hud.mode = mode;
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.68];
    hud.margin = 36.f;
    hud.layer.cornerRadius = 8.f;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 设置关闭回调通知
    hud.completionBlock = completion;
    
    if (delay < 0.0) {
        return;
    }
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:delay];
}

@end
