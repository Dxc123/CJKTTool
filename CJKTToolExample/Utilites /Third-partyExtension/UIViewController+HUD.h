//
//  UIViewController+HUD.h
//  weiniyingyu
//
//  Created by LetengMac1 on 2018/4/8.
//  Copyright © 2018年 Harvie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

- (void)showHint:(NSString *)hint onView:(UIView *)view;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

- (void)showStatusWithHint:(NSString *)hint;

- (void)showStatusOnview:(UIView *)view hint:(NSString *)hint;

- (void)showSuccessWithHint:(NSString *)hint offset:(CGFloat)offset;

- (void)showSuccessWithHint:(NSString *)hint onView:(UIView *)view;

- (void)showSuccessWithHint:(NSString *)hint;

- (void)showWrongWithHint:(NSString *)hint onView:(UIView *)view;

- (void)showWrongWithHint:(NSString *)hint;

- (void)showLoading:(NSString *)hint;

- (void)showProgressLoading:(NSString *)hint;

- (void)setHudLoadingProgress:(CGFloat)progress;

- (void)setHudLoadingHint:(NSString *)hint;
@end
