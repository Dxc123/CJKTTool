//
//  MCAlertView.h
//  ZFGT
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 allyoubank.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define MC_RGBColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define MC_blackColor  [UIColor blackColor]
@interface MCAlertView : NSObject

/**
 *  设置取消按钮的字体颜色 默认：MC_RGBColor(153, 153, 153)
 */
@property(nonatomic,strong)UIColor *cancleAlertActionColor;

/**
 设置默认按钮的字体颜色 默认：MC_orangeColor
 */
@property(nonatomic,strong)UIColor *defaultAlertActionColor;

/**
 *  设置alertView title 的字体颜色 默认：MC_blackColor
 */
@property(nonatomic,strong)UIColor *alertViewTitleColor;

/**
 *  设置alertView messager 的字体颜色  默认：MC_blackColor
 */
@property(nonatomic,strong)UIColor *alertViewMessagerColor;


/**
 *  只含有确定按钮的弹窗
 *
 *  @param vc 弹窗所在的控制器对象
 *  @param title 弹窗的标题
 *  @param message 弹窗的副标题
 *  @param actionTitle 按钮的tile
 *  @param style 按钮的样式
 *  @param handler 按钮点击回调
 *  @return 返回MCAlertView 对象
 */
+ (MCAlertView *)alertControllerWithViewController:(UIViewController *)vc
                                             title:(NSString *)title
                                           message:(NSString *)message
                                       actionTitle:(NSString *)actionTitle
                                             style:(UIAlertActionStyle)style
                                           handler:(void (^)(UIAlertAction *action))handler;

/**
 *  含有取消、确定按钮
 *
 *  @param vc 弹窗所在的控制器对象
 *  @param title 弹窗的标题
 *  @param message 弹窗的副标题
 *  @param actionTitle 确定按钮的tile
 *  @param cancelActionTitle 取消按钮的tile
 *  @param defalutHandler 点击确定按钮回调
 *  @param cancleHandler 点击取消按钮回调
 *  @return 返回MCAlertView 对象
 */
+ (MCAlertView *)alertControllerWithViewController:(UIViewController *)vc
                                             title:(NSString *)title
                                           message:(NSString *)message
                                       actionTitle:(NSString *)actionTitle
                                 cancelActionTitle:(NSString *)cancelActionTitle
                                    defalutHandler:(void (^)(UIAlertAction *action))defalutHandler
                                    cancleHandler:(void (^)(UIAlertAction *action))cancleHandler;



@end
