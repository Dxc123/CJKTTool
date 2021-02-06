//
//  HWAlertViewCenter.m
//  WannyEnglish
//
//  Created by caoran on 2020/2/7.
//  Copyright © 2020 wanny. All rights reserved.
//

#import "HWAlertViewCenter.h"

@implementation HWAlertViewCenter

+ (void)oneActionWithTitle:(NSString*)title
                   message:(NSString*)message
              confirmTitle:(NSString*)confirmTitle
              confirmBlock:(void(^)(UIAlertAction *action))confirmBlock
       presentedController:(UIViewController *)presentedController
                completion:(void(^)(void))completion {
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmBlock];
    NSArray *actions = @[confirmAction];
    [self alertWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert actions:actions presentedController:presentedController popoverView:nil completion:completion];
    
}
+ (void)twoActionWithTitle:(NSString*)title
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
+ (void)oneSheetActionWithTitle:(NSString *)title
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

+ (void)twoSheetActionWithTitle:(NSString*)title
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
+ (void)manySheetActionWithTitle:(NSString *)title
                         message:(NSString *)message
                         actions:(NSArray *)actions
             presentedController:(UIViewController *)presentedController
                     popoverView:(UIView *)popverView
                      completion:(void(^)(void))completion {
    [self alertWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet actions:actions presentedController:presentedController popoverView:popverView completion:completion];
}
@end
