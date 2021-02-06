//
//  HWAlertViewCenter.h
//  WannyEnglish
//
//  Created by caoran on 2020/2/7.
//  Copyright © 2020 wanny. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HWAlertViewCenter : NSObject
//封装系统的UIAlertController

+ (void)oneActionWithTitle:(NSString*)title
                   message:(NSString*)message
              confirmTitle:(NSString*)confirmTitle
              confirmBlock:(void(^)(UIAlertAction *action))confirmBlock
       presentedController:(UIViewController *)presentedController
                completion:(void(^)(void))completion;

+ (void)twoActionWithTitle:(NSString*)title
                   message:(NSString*)message
              confirmTitle:(NSString*)confirmTitle
              confirmBlock:(void(^)(UIAlertAction *action))confirmBlock
               canceltitle:(NSString*)cancelTitle
               cancelBlock:(void(^)(UIAlertAction *action))cancelBlock
       presentedController:(UIViewController *)presentedController
                completion:(void(^)(void))completion;

+ (void)oneSheetActionWithTitle:(NSString *)title
                        message:(NSString*)message
                   confirmTitle:(NSString*)confirmTitle
                   confirmBlock:(void(^)(UIAlertAction *action))confirmBlock
            presentedController:(UIViewController *)presentedController
                    popoverView:(UIView *)popverView
                     completion:(void(^)(void))completion;

+ (void)twoSheetActionWithTitle:(NSString*)title
                        message:(NSString*)message
                   confirmTitle:(NSString*)confirmTitle
                   confirmBlock:(void(^)(UIAlertAction *action))confirmBlock
                    canceltitle:(NSString*)cancelTitle
                    cancelBlock:(void(^)(UIAlertAction *action))cancelBlock
            presentedController:(UIViewController *)presentedController
                    popoverView:(UIView *)popverView
                     completion:(void(^)(void))completion;

+ (void)manySheetActionWithTitle:(NSString *)title
                         message:(NSString *)message
                         actions:(NSArray *)actions
             presentedController:(UIViewController *)presentedController
                     popoverView:(UIView *)popverView
                      completion:(void(^)(void))completion;


//+ (void)alertWithTitle:(NSString *)title
//               message:(NSString *)message
//        preferredStyle:(UIAlertControllerStyle)style
//               actions:(NSArray *)actions
//   presentedController:(UIViewController *)presentedController
//            completion:(void(^)(void))completion;
@end

