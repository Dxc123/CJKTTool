//
//  KHelper.m
//  AUNewProject
//
//  Created by daixingchuang on 2020/8/13.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

#import "KHelper.h"

#import <Toast/Toast.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <LEEAlert/LEEAlert.h>
@implementation KHelper

//Toast
+ (void)makeToast:(NSString *)str
{
    [[UIApplication sharedApplication].keyWindow makeToast:str duration:1 position:CSToastPositionCenter];
}


+ (void)makeToastActivity
{
    [[UIApplication sharedApplication].keyWindow makeToastActivity:CSToastPositionCenter];
}

+ (void)hideToastActivity
{
    [[UIApplication sharedApplication].keyWindow hideToastActivity];
}

////////////////////////////////////
//MBProgressHUD
+(void)showHUD:(NSString *)hint{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[CJKTTool keyWindow] animated:YES];
    hud.label.text = hint;
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    // hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:1.2];
}

+(void)showHudActivity{
    [MBProgressHUD showHUDAddedTo:[CJKTTool keyWindow] animated:YES];
}
+(void)showHudActivity:(NSString *)str{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[CJKTTool keyWindow] animated:YES];
    hud.label.text = str;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.userInteractionEnabled = NO;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
//   hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
}
+ (void)hideHudActivity{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[CJKTTool keyWindow] animated:YES];
//    });
   
}


////////////////////////////////////
//SVProgressHUD
+ (void)initialize
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setMinimumSize:CGSizeMake(110, 110)];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
}

+ (void)showSVLoading{
    [SVProgressHUD show];
}
+ (void)showSVLoading:(NSString *)hintText
{
    [SVProgressHUD showWithStatus:hintText];
}
+ (void)dismissSV
{
    [SVProgressHUD dismissWithCompletion:nil];
}

+ (BOOL)isVisibleSV
{
    return [SVProgressHUD isVisible];
}



+ (void)showSVProgress:(CGFloat)progress
{
    [SVProgressHUD showProgress:progress];
}



+ (void)showSVSuccessToast:(NSString *)message
{
    [SVProgressHUD showSuccessWithStatus:message];
}

+ (void)showSVErrorToast:(NSString *)message
{
    [SVProgressHUD showErrorWithStatus:message];
}

+ (void)showSVWarningToast:(NSString *)message
{
    [SVProgressHUD showInfoWithStatus:message];
}




@end
