//
//  MCAlertView.m
//  ZFGT
//
//  Created by apple on 2018/1/30.
//  Copyright © 2018年 allyoubank.com. All rights reserved.
//

#import "MCAlertView.h"
@interface MCAlertView ()

@property(nonatomic,strong)UIAlertController *alertController;

/** 取消按钮 */
@property(nonatomic,strong)UIAlertAction *cancelAlertAction;

/** 默认按钮 */
@property(nonatomic,strong)UIAlertAction *defalutAlertAction;

/** AlertView Title */
@property(nonatomic,copy)NSString *temTitle;

@end    // MCAlertView

@implementation MCAlertView


- (instancetype)init
{
    self = [super init];
    if (self) {
       
        [self setUpConfig];
    }
    return self;
}

- (void)setUpConfig
{
    _cancleAlertActionColor = [UIColor blackColor];
    _defaultAlertActionColor = [UIColor grayColor];
    
    _alertViewTitleColor = [UIColor blackColor];
    _alertViewMessagerColor = [UIColor blackColor];
}

//MARK: - 外部调用方法
//只含有确定按钮的弹窗
+ (MCAlertView *)alertControllerWithViewController:(UIViewController *)vc
                                             title:(NSString *)title
                                           message:(NSString *)message
                                       actionTitle:(NSString *)actionTitle
                                             style:(UIAlertActionStyle)style
                                           handler:(void (^)(UIAlertAction *action))handler
{
    MCAlertView *alertView = [[self alloc] init];
    [alertView setUpAlertControllerWithTitle:title message:message];
    [alertView setUpActionWithTitle:actionTitle style:style handler:handler];
    [alertView presentViewController:vc];
    [alertView setUpDefaultConfig];
    return alertView;
}

//含有取消和确定按钮
+ (MCAlertView *)alertControllerWithViewController:(UIViewController *)vc
                                             title:(NSString *)title
                                           message:(NSString *)message
                                       actionTitle:(NSString *)actionTitle
                                 cancelActionTitle:(NSString *)cancelActionTitle
                                    defalutHandler:(void (^)(UIAlertAction *action))defalutHandler
                                     cancleHandler:(void (^)(UIAlertAction *action))cancleHandler
{
    MCAlertView *alertView = [[self alloc] init];
    [alertView setUpAlertControllerWithTitle:title message:message];
    [alertView setUpCancleAlertActionWithTitle:cancelActionTitle style:UIAlertActionStyleDefault handler:cancleHandler];
    [alertView setUpActionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:defalutHandler];
    [alertView presentViewController:vc];
    [alertView setUpDefaultConfig];
    return alertView;
}

//MARK: - set 方法
- (void)setCancleAlertActionColor:(UIColor *)cancleAlertActionColor
{
    _cancleAlertActionColor = cancleAlertActionColor;
    if (_cancelAlertAction == nil) {
        return;
    }
    
    [self setUpAlertAction:_cancelAlertAction color:cancleAlertActionColor];
}

- (void)setDefaultAlertActionColor:(UIColor *)defaultAlertActionColor
{
    _defaultAlertActionColor = defaultAlertActionColor;
    if (_defalutAlertAction == nil) {
        return;
    }
    
    [self setUpAlertAction:_defalutAlertAction color:defaultAlertActionColor];
}

- (void)setAlertViewTitleColor:(UIColor *)alertViewTitleColor
{
    _alertViewTitleColor = alertViewTitleColor;
    if (_alertController == nil) {
        return;
    }
    [self setUpAlertControllerTitleColor:alertViewTitleColor];
}

- (void)setAlertViewMessagerColor:(UIColor *)alertViewMessagerColor
{
    _alertViewMessagerColor = alertViewMessagerColor;
    if (_alertController == nil) {
        return;
    }
    
    [self setUpAlertControllerMessagerColor:alertViewMessagerColor];
}

//MARK: -  内部实现方法
- (void)setUpAlertAction:(UIAlertAction *)action color:(UIColor *)color
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.3) {
          [action setValue:color forKey:@"titleTextColor"];
    }
 
}

- (void)setUpAlertControllerTitleColor:(UIColor *)color
{
    NSString *title = _alertController.title;
    if ([self isEmptyString:title]) {
        return;
    }
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:title];
    [string addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, title.length)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, title.length)];
    [_alertController setValue:string forKey:@"attributedTitle"];
}

- (void)setUpAlertControllerMessagerColor:(UIColor *)color
{
    NSString *title = _alertController.message;
    if ([self isEmptyString:title]) {
        return;
    }
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:title];
    [string addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, title.length)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, title.length)];
    [_alertController setValue:string forKey:@"attributedMessage"];
}

- (void)setUpDefaultConfig
{
    self.defaultAlertActionColor = _defaultAlertActionColor;
    self.cancleAlertActionColor = _cancleAlertActionColor;
    self.alertViewTitleColor = _alertViewTitleColor;
    self.alertViewMessagerColor = _alertViewMessagerColor;
}

//UIAlertController
- (void)setUpAlertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    _alertController = alertController;
}

//确定UIAlertAction
- (void)setUpActionWithTitle:(nullable NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:handler];
    _defalutAlertAction = action;
    
    [_alertController addAction:action];
}

//取消UIAlertAction
- (void)setUpCancleAlertActionWithTitle:(nullable NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(UIAlertAction *action))handler
{
    UIAlertAction *cancleAlert = [UIAlertAction actionWithTitle:title style:style handler:handler];
    _cancelAlertAction = cancleAlert;
    
    [_alertController addAction:cancleAlert];
}

//presentViewController
- (void)presentViewController:(UIViewController *)vc
{
    [vc presentViewController:_alertController animated:YES completion:nil];
}


- (BOOL)isEmptyString:(NSString *)str
{
    if (str == nil) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([str isEqualToString:@""] ||[str isEqualToString:@"<null>"] || [str isEqualToString:@"(null)"] ) {
        return YES;
    }
    
    if (str.length == 0) {
        return YES;
    }
    return NO;
}
@end
