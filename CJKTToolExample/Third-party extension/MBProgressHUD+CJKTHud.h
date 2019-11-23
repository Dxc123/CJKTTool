//
//  MBProgressHUD+CJKTHud.h
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2019/8/26.
//  Copyright © 2019 CJKT. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (CJKTHud)

/**
 *  显示文字信息(w文字+默认菊花圈圈)
 */
+ (void)showMessage:(NSString *)message
             toView:(UIView *)view;
/**
 *  显示成功的消息 (文字+默认图片）
 */
+ (void)showSuccessMsg:(NSString *)message
                toView:(UIView *)toView;


/**
 *  显示错误的消息 (文字+默认图片）
 */
+ (void)showErrorMsg:(NSString *)message
              toView:(UIView *)toView;

/**
 * 显示自定义动画(自定义动画序列帧  找UI做就可以了)
 */

+(void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry toView:(UIView *)toView;


/**
 *  隐藏
 */
+ (void)hideHUDForView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
