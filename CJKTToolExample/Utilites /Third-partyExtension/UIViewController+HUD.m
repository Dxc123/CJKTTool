//
//  UIViewController+HUD.m
//  weiniyingyu
//
//  Created by LetengMac1 on 2018/4/8.
//  Copyright © 2018年 Harvie. All rights reserved.
//

#import "UIViewController+HUD.h"
#import <objc/runtime.h>
#import <MBProgressHUD.h>

static const void *HttpRequestHUDKey = &HttpRequestHUDKey;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)showSuccessWithHint:(NSString *)hint offset:(CGFloat)offset{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [self configStatusHud:hud hint:hint];
    hud.offset = CGPointMake(hud.offset.x, offset);
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *successImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"correct"]];
    hud.customView = successImgView;
    [hud  hideAnimated:YES afterDelay:2];
    
}

- (void)showSuccessWithHint:(NSString *)hint {
    [self showSuccessWithHint:hint offset:180];
}

- (void)showSuccessWithHint:(NSString *)hint onView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [self configStatusHud:hud hint:hint];
    hud.offset = CGPointZero;
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *successImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"correct"]];
    hud.customView = successImgView;
    [hud  hideAnimated:YES afterDelay:2];
}
- (void)configStatusHud:(MBProgressHUD*)hud hint:(NSString *)hint{
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.numberOfLines = 0;
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.userInteractionEnabled = NO;
    hud.backgroundView.userInteractionEnabled = NO;
    hud.progress = 0.5;
    hud.offset = CGPointMake(hud.offset.x, 180);
    hud.removeFromSuperViewOnHide = YES;
    hud.contentColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
}

- (void)showStatusWithHint:(NSString *)hint {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [self configStatusHud:hud hint:hint];
    [self setHUD:hud];
}

- (void)showStatusOnview:(UIView *)view hint:(NSString *)hint {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [self configStatusHud:hud hint:hint];
    hud.offset = CGPointZero;
    [self setHUD:hud];
}

- (void)showWrongWithHint:(NSString *)hint {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [self configStatusHud:hud hint:hint];
    hud.offset = CGPointMake(hud.offset.x, 180);
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *successImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
    hud.customView = successImgView;
    hud.label.numberOfLines = 0;
    [hud  hideAnimated:YES afterDelay:2];
}

- (void)showWrongWithHint:(NSString *)hint onView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [self configStatusHud:hud hint:hint];
    hud.offset = CGPointZero;
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *successImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong"]];
    hud.customView = successImgView;
    hud.label.numberOfLines = 0;
    [hud  hideAnimated:YES afterDelay:2];
}
- (void)showLoading:(NSString *)hint {
    UIView *window = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    [self configStatusHud:hud hint:hint];
    hud.backgroundView.userInteractionEnabled = YES;
    hud.userInteractionEnabled = YES;
    hud.offset = CGPointZero;
    hud.label.numberOfLines = 0;
    [self setHUD:hud];
}
- (void)showProgressLoading:(NSString *)hint {
    UIView *window = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    [self configStatusHud:hud hint:hint];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.backgroundView.userInteractionEnabled = YES;
    hud.userInteractionEnabled = YES;
    hud.progress = 0;
    hud.label.numberOfLines = 0;
    hud.offset = CGPointZero;
    hud.backgroundColor =    [[UIColor grayColor] colorWithAlphaComponent:0.5];//;UIColorFromRGBA(0x000000, 0.3);
    [self setHUD:hud];
}
- (void)setHudLoadingProgress:(CGFloat)progress {
    MBProgressHUD *hud = [self HUD];
    if (hud.mode == MBProgressHUDModeAnnularDeterminate || hud.mode == MBProgressHUDModeDeterminateHorizontalBar) {
        hud.progress = progress;
    }
}
- (void)setHudLoadingHint:(NSString *)hint {
    MBProgressHUD *hud = [self HUD];
    if (hud.mode == MBProgressHUDModeAnnularDeterminate || hud.mode == MBProgressHUDModeDeterminateHorizontalBar) {
        hud.label.text = hint;
    }
}
/************************************************/
- (void)configHintHud:(MBProgressHUD *)hud view:(UIView *)view hint:(NSString*)hint offset:(CGFloat)offset {
    hud.label.text = hint;
    hud.label.numberOfLines = 0;
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.backgroundView.userInteractionEnabled = NO;
    [view addSubview:hud];
    [hud showAnimated:YES];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.offset = CGPointMake(hud.offset.x, offset);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}
- (void)showHint:(NSString *)hint onView:(UIView *)view{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [self configHintHud:HUD view:view hint:hint offset:0];
}

- (void)showHint:(NSString *)hint
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [self configHintHud:hud view:view hint:hint offset:0];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [self configHintHud:hud view:view hint:hint offset:yOffset];
}

- (void)hideHud
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[self HUD] hideAnimated:YES];
    });
}

@end
