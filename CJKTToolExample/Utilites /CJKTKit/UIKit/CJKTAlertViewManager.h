//
//  CJKTAlertViewManager.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2021/2/6.
//  Copyright © 2021 CJKT. All rights reserved.
////封装系统的UIAlertController

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJKTAlertViewManager : NSObject
//////////////////////////////
//系统Alert
//////////////////////////////
+ (void)showOneAlertWithTitle:(NSString*)title
                   message:(NSString*)message
              confirmTitle:(NSString*)confirmTitle
              confirmBlock:(void(^)(UIAlertAction *action))confirmBlock
       presentedController:(UIViewController *)presentedController
                completion:(void(^)(void))completion;

+ (void)showTwoAlertWithTitle:(NSString*)title
                   message:(NSString*)message
              confirmTitle:(NSString*)confirmTitle
              confirmBlock:(void(^)(UIAlertAction *action))confirmBlock
               canceltitle:(NSString*)cancelTitle
               cancelBlock:(void(^)(UIAlertAction *action))cancelBlock
       presentedController:(UIViewController *)presentedController
                completion:(void(^)(void))completion;

+ (void)showManyAlertWithTitle:(NSString *)title
               message:(NSString *)message
               actions:(NSArray *)actions
   presentedController:(UIViewController *)presentedController
               popoverView:(UIView *)popverView
            completion:(void(^)(void))completion;

//////////////////////////////
//系统SheetAction
//////////////////////////////
+ (void)showOneSheetActionWithTitle:(NSString *)title
                        message:(NSString*)message
                   confirmTitle:(NSString*)confirmTitle
                   confirmBlock:(void(^)(UIAlertAction *action))confirmBlock
            presentedController:(UIViewController *)presentedController
                    popoverView:(UIView *)popverView
                     completion:(void(^)(void))completion;

+ (void)showTwoSheetActionWithTitle:(NSString*)title
                        message:(NSString*)message
                   confirmTitle:(NSString*)confirmTitle
                   confirmBlock:(void(^)(UIAlertAction *action))confirmBlock
                    canceltitle:(NSString*)cancelTitle
                    cancelBlock:(void(^)(UIAlertAction *action))cancelBlock
            presentedController:(UIViewController *)presentedController
                    popoverView:(UIView *)popverView
                     completion:(void(^)(void))completion;

+ (void)showManySheetActionWithTitle:(NSString *)title
                         message:(NSString *)message
                         actions:(NSArray *)actions
             presentedController:(UIViewController *)presentedController
                     popoverView:(UIView *)popverView
                      completion:(void(^)(void))completion;

@end

NS_ASSUME_NONNULL_END
