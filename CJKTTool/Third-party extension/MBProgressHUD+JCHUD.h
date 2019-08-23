//
//  MBProgressHUD+JCHUD.h
//  JiCaiLottery
//
//  Created by 风外杏林香 on 2017/3/18.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (JCHUD)

#pragma mark -- 显示失败时候调用的方法
+ (void)showError:(NSString *)error toView:(UIView *)view;

#pragma mark -- 显示成功时候调用的方法
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

#pragma mark -- 显示文字、图片信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

#pragma mark -- 请求完成加载图片、文字、及时间
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view afterDelay:(NSTimeInterval)delay;
#pragma mark -- 快速弹出一个提示信息
+ (void)alertRedMessage:(NSString *)text view:(UIView *)view afterDelay:(NSTimeInterval)delay;

@end
