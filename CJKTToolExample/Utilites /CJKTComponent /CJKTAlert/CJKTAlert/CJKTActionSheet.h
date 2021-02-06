//
//  CJKTActionSheet.h
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2018/11/28.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,CJKTActionSheetStyle){
    CJKTActionSheetDefault,//文字样式
    CJKTActionSheetIcon,//图标样式
    CJKTActionSheetIconAndTitle,//文字+图标样式
};

@class CJKTActionSheet;
@protocol CJKTActionSheetDelegate <NSObject>
/**
 点击actionSheet代理方法
 */
- (void)actionSheet:(CJKTActionSheet *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex;
/**
 点击ActionSheet取消按钮
 */
- (void)actionSheetCancle:(CJKTActionSheet *)actionSheet;
@end

@interface CJKTActionSheet : UIView
/**
 点击actionSheetBlock
 */
@property (nonatomic, copy) void (^ActionSheetClickBlock)(NSInteger actionSheetIndex);
/**
 点击CancelClickBlock
 */
@property (nonatomic, copy) void (^ActionSheetCancelClickBlock)(void);

/**
 actionSheetDelegate
 */
@property (nonatomic,weak) id<CJKTActionSheetDelegate> delegate;
/**
 圆角效果 ,默认否
 */
@property (nonatomic,assign) BOOL isCorner;

/**
 标题颜色
 */
@property (nonatomic,strong) UIColor *titleColor;

/**
 标题字体
 */
@property (nonatomic,strong) UIFont *titleFont;

/**
 标题背景颜色
 */
@property (nonatomic,strong) UIColor *titlebgColor;


/**
 ActionItem颜色
 */
@property (nonatomic,assign) UIColor *subtitleColor;

/**
 ActionItem字体
 */
@property (nonatomic,strong) UIFont *subtitleFont;;

/**
ActionItem隔线颜色
 */
@property (nonatomic,strong) UIColor *lineColor;

/**
 ActionItem背景色
 */
@property (nonatomic,strong) UIColor *subtitlebgColor;

/**
 取消标题按钮颜色
 */
@property (nonatomic,strong) UIColor *canclebgColor;

/**
 标题栏高度 默认50
 */
@property (nonatomic,assign,readonly) CGFloat titleHeight;

/**
ActionItem高度 默认50
 */
@property (nonatomic,assign,readonly) CGFloat sheetHeight;

/**
 取消按钮高度，默认50
 */
@property (nonatomic,assign,readonly) CGFloat cancleHeight;



/**
 创建ActionSheet
 @param title 标题
 @param sheetTitles 选项标题数组 (CJKTActionSheetDefault时,可为空数组)
 @param sheetIcons  图标数组
 @param cancleBtnTitle 取消按钮标题
 @param sheetStyle sheetStyle类型
 */
- (instancetype)initWithTitle:(NSString *)title
                  sheetTitles:(NSArray *)sheetTitles
                  sheetIcons:(NSArray *)sheetIcons
               cancleBtnTitle:(NSString *)cancleBtnTitle
                   sheetStyle:(CJKTActionSheetStyle)sheetStyle;
- (void)show;
- (void)dissmiss;
@end

@interface CJKTActionSheetCell : UITableViewCell
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UIImageView *iconImg;
@property (nonatomic,strong)UIView *bottomLine;
@property (nonatomic,strong)UIView *coverView;

/**
标题
 */

- (void)setupCJKTActionSheetDefaultCellWithTitle:(NSString *)title
                                       titleFont:(UIFont *)titleFont
                                      titleColor:(UIColor *)titleColor
                                      cellHeight:(CGFloat)height
                                         bgColor:(UIColor *)bgColor;

/**
图标
 */
- (void)setupCJKTActionSheetIconAndTitleWithIcon:(UIImage *)icon
                                    cellHeight:(CGFloat)height;
/**
 图标+标题
 */
- (void)setupCJKTActionSheetIconAndTitleWithTitle:(NSString *)title
                                        titleFont:(UIFont *)font
                                       titleColor:(UIColor *)titleColor
                                             icon:(NSString *)icon
                                       cellHeight:(CGFloat)height;

@end







NS_ASSUME_NONNULL_END
