//
//  CJKTAlert.h
//  CJKTAlert
//
//  Created by Dxc_iOS on 2018/9/28.
//  Copyright © 2018 超级课堂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJKTAlertShowType) {
    CJKTAlertShowType_None,              //不使用动画
    CJKTAlertShowType_FadeIn,            //渐显
    CJKTAlertShowType_ShrinkIn,          //缩小
    CJKTAlertShowType_SlideInFromTop,    //从上向下
    CJKTAlertShowType_SlideInFromBottom, //从下向上
    CJKTAlertShowType_SlideInFromLeft,   //从左向右
    CJKTAlertShowType_SlideInFromRight,  //从右向左
   
};
typedef NS_ENUM(NSUInteger, CJKTAlertDismissType) {
    CJKTAlertDismissType_None,
    CJKTAlertDismissType_FadeOut,
    CJKTAlertDismissType_GrowOut,
    CJKTAlertDismissType_ShrinkOut,
    CJKTAlertDismissType_SlideOutToTop,
    CJKTAlertDismissType_SlideOutToBottom,
    CJKTAlertDismissType_SlideOutToLeft,
    CJKTAlertDismissType_SlideOutToRight,
    CJKTAlertDismissType_BounceOut,
    CJKTAlertDismissType_BounceOutToTop,
    CJKTAlertDismissType_BounceOutToBottom,
    CJKTAlertDismissType_BounceOutToLeft,
    CJKTAlertDismissType_BounceOutToRight
};
@interface CJKTAlert : UIView

/** 大标题title的字体大小 */
@property (nonatomic, strong) UIFont * titleLabelFont;

/** 大标题title的字体颜色 */
@property (nonatomic, strong) UIColor * titleLabelColor;

/** 副标题或描述message的字体颜色 */
@property (nonatomic, strong) UIColor * messageLabelColor;

/** 按钮item的字体大小 */
@property (nonatomic, strong) UIFont * buttonFont;

/** 横线和竖线的颜色 */
@property (nonatomic, strong) UIColor * lineViewColor;

/** 是否隐藏横线 默认为NO不隐藏 要隐藏设为YES*/
@property (nonatomic, assign) BOOL transverseLineHidden;

/** 总共最多3个item 按顺序把颜色放数组里面就行了，没item设置无效，多设置按顺序取 */
@property (nonatomic, strong) NSArray<UIColor *> * itemTitleColorArr;

//显示动画类型
@property (nonatomic, assign) CJKTAlertShowType showType;
//消失动画类型
@property (nonatomic, assign) CJKTAlertDismissType dismissType;
/**
 *  CJKTAlert初始化创建方法
 *  @param title     大标题
 *  @param message   副标题或描述
 *  @param textAlignment   副标题或描述 的字体位置 如果没有设置副标题，则设置无效
 *  @param itemArr   按钮item数组 不设置则弹出view无法消失，按钮最多3个，多设置取前3
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message messageAlignment:(NSTextAlignment)textAlignment Item:(NSArray<NSString *> *)itemArr selectBlock:(void(^)(NSInteger index))selectBlock;

/**
 *  CJKTAlertview显示方法
 */

- (void)show;

/** 设置副标题某段文字的颜色 如果设置了副标题颜色messageLabelColor，必须放在前面，否则此处设置无效，会被messageLabelColor覆盖，如果没有副标题则此处设置无效 */
- (void)messageLabelTextColorWith:(NSRange)range andColor:(UIColor *)color;


@end
