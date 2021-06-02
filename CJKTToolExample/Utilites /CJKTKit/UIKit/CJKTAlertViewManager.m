//
//  CJKTAlertViewManager.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2021/2/6.
//  Copyright © 2021 CJKT. All rights reserved.
//

#import "CJKTAlertViewManager.h"

@implementation CJKTAlertViewManager
//////////////////////////////
//系统Alert
//////////////////////////////
+ (void)showOneAlertWithTitle:(NSString*)title
                   message:(NSString*)message
              confirmTitle:(NSString*)confirmTitle
              confirmBlock:(void(^)(UIAlertAction *action))confirmBlock
       presentedController:(UIViewController *)presentedController
                completion:(void(^)(void))completion {
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmBlock];
    NSArray *actions = @[confirmAction];
    [self alertWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert actions:actions presentedController:presentedController popoverView:nil completion:completion];
    
}
+ (void)showTwoAlertWithTitle:(NSString*)title
                   message:(NSString*)message
              confirmTitle:(NSString*)confirmTitle
              confirmBlock:(void(^)(UIAlertAction *action))confirmBlock
               canceltitle:(NSString*)cancelTitle
               cancelBlock:(void(^)(UIAlertAction *action))cancelBlock
       presentedController:(UIViewController *)presentedController
                completion:(void(^)(void))completion{
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmBlock];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    NSArray *actions = @[cancelAction,confirmAction];
    [self alertWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert actions:actions presentedController:presentedController popoverView:nil completion:completion];
}

+ (void)showManyAlertWithTitle:(NSString *)title
            message:(NSString *)message
            actions:(NSArray *)actions
presentedController:(UIViewController *)presentedController
               popoverView:(UIView *)popverView
                completion:(void(^)(void))completion{
    [self alertWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert actions:actions presentedController:presentedController popoverView:popverView completion:completion];
}



//////////////////////////////
//系统SheetAction
//////////////////////////////
+ (void)showOneSheetActionWithTitle:(NSString *)title
                        message:(NSString*)message
                   confirmTitle:(NSString*)confirmTitle
                   confirmBlock:(void(^)(UIAlertAction *action))confirmBlock
            presentedController:(UIViewController *)presentedController
                    popoverView:(UIView *)popverView
                     completion:(void(^)(void))completion

{
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmBlock];
    NSArray *actions = @[confirmAction];
    [self alertWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert actions:actions presentedController:presentedController popoverView:popverView completion:completion];
    
}

+ (void)showTwoSheetActionWithTitle:(NSString*)title
                        message:(NSString*)message
                   confirmTitle:(NSString*)confirmTitle
                   confirmBlock:(void(^)(UIAlertAction *action))confirmBlock
                    canceltitle:(NSString*)cancelTitle
                    cancelBlock:(void(^)(UIAlertAction *action))cancelBlock
            presentedController:(UIViewController *)presentedController
                    popoverView:(UIView *)popverView
                     completion:(void(^)(void))completion
{
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmBlock];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelBlock];
    NSArray *actions = @[cancelAction,confirmAction];
    [self alertWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet actions:actions presentedController:presentedController popoverView:popverView completion:completion];
    
}
+ (void)showManySheetActionWithTitle:(NSString *)title
                         message:(NSString *)message
                         actions:(NSArray *)actions
             presentedController:(UIViewController *)presentedController
                     popoverView:(UIView *)popverView
                      completion:(void(^)(void))completion {
    [self alertWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet actions:actions presentedController:presentedController popoverView:popverView completion:completion];
}




#pragma mark -- 公共方法
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
        preferredStyle:(UIAlertControllerStyle)style
               actions:(NSArray *)actions
   presentedController:(UIViewController *)presentedController
           popoverView:(UIView *)popoverView
            completion:(void(^)(void))completion {
    if (!presentedController) return;
    if (!actions.count) return;
    if (style == UIAlertControllerStyleActionSheet && !popoverView) {
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    if (style == UIAlertControllerStyleActionSheet) {
        UIPopoverPresentationController *popover = alert.popoverPresentationController;
        
        if (popover) {
            
            popover.sourceView = popoverView;
            popover.sourceRect = popoverView.bounds;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
    for (UIAlertAction *action in actions) {
        [alert addAction:action];
    }
    [presentedController presentViewController:alert animated:YES completion:completion];
    
}
@end
