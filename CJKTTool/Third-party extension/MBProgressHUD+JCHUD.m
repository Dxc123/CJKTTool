//
//  MBProgressHUD+JCHUD.m
//  JiCaiLottery
//
//  Created by 风外杏林香 on 2017/3/18.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import "MBProgressHUD+JCHUD.h"

@implementation MBProgressHUD (JCHUD)

+ (void)showError:(NSString *)error toView:(UIView *)view
{
    [self show:error icon:@"mb_error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"mb_success.png" view:view];
}

//快速显示文字图片信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    [self show:text icon:icon view:view afterDelay:1.5];
}

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view afterDelay:(NSTimeInterval)delay
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // xx秒之后再消失
    [hud hide:YES afterDelay:delay];
}
+ (void)alertRedMessage:(NSString *)text view:(UIView *)view afterDelay:(NSTimeInterval)delay
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //    hud.color = CCCUIColorFromHex(0xF8425A);
    hud.cornerRadius = 3;
    hud.margin = 10;
    hud.animationType = MBProgressHUDAnimationZoomIn;
    hud.detailsLabelText = text;
    //    hud.yOffset = 160.f;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:delay];
}


@end
