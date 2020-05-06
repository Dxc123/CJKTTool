//
//  TWHPopTool.h
//  JPQ
//
//  Created by LetengMacbook on 2018/12/26.
//  Copyright © 2018年 LTTangWenHong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HWPopTool : NSObject
//弹出视图工具类

/**
 弹出视图

 @param view 动画视图
 @param addView 添加到窗口的视图
 */
+ (void)showWithAnimationView:(UIView *)view addView:(UIView *)addView;


/**
 动画移除视图

 @param view 动画视图
 @param removeView 从窗口移除的视图
 @param animated 是否动画移除
 */
+ (void)dismissView:(UIView *)view removeView:(UIView *)removeView animated:(BOOL)animated;

/**
 淡入弹出视图

 @param view 动画视图
 @param size 动画View的尺寸
 @param offsetY 中心点Y值得偏移量
 */
+ (void)showWithFadeAnimationView:(UIView *)view size:(CGSize)size offsetY:(CGFloat)offsetY radius:(CGFloat)radius blackBackView:(BOOL)blackBackView canTapDismiss:(BOOL)canTap;


/**
 淡出动画移除视图

 @param view 动画视图
 @param animated 是否动画移除
 */
+ (void)fadeDismissView:(UIView *)view animated:(BOOL)animated;

/**
 从下至上弹出视图

 @param view 要弹出的视图
 @param animated 是否有动画
 */
+ (void)showDownToUpView:(UIView *)view animated:(BOOL)animated radius:(CGFloat)radius size:(CGSize)size canTapDismiss:(BOOL)canTap;

/**
 从上至下隐藏视图

 @param view 要隐藏的视图
 @param animated 是否动画
 */
+ (void)dissmissUpToDown:(UIView *)view animated:(BOOL)animated;
+ (void)addView:(UIView *)view withBlackColorBack:(BOOL)blackBack;
+ (void)addView:(UIView *)view;
+ (void)removeView:(UIView *)view;
+ (void)bringViewToFront:(UIView *)view;
+ (void)addView:(UIView *)view frame:(CGRect)frame withBlackColorBack:(BOOL)blackBack canTapCancel:(BOOL)canTap;

/**
 隐藏
 */
+ (void)hidden:(BOOL)hide;

/**
 移除所有已经添加的视图
 */
+ (void)userPushToOtherPage;
@end


@interface WindowBackView:UIView<UIGestureRecognizerDelegate>

@end
