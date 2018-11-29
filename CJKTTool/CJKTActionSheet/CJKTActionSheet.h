//
//  CJKTActionSheet.h
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2018/11/28.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJKTActionSheetCell.h"
NS_ASSUME_NONNULL_BEGIN

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
 副标题颜色
 */
@property (nonatomic,assign) UIColor *subtitleColor;

/**
 副标题字体
 */
@property (nonatomic,strong) UIFont *subtitleFont;;

/**
 副标题间隔线颜色
 */
@property (nonatomic,strong) UIColor *lineColor;

/**
 副标题背景色
 */
@property (nonatomic,strong) UIColor *subtitlebgColor;

/**
 标题颜色
 */
@property (nonatomic,strong) UIColor *titlebgColor;

/**
 取消标题按钮颜色
 */
@property (nonatomic,strong) UIColor *canclebgColor;

/**
 标题栏高度 默认50
 */
@property (nonatomic,assign) CGFloat titleHeight;

/**
 副标题栏高度 默认50
 */
@property (nonatomic,assign) CGFloat sheetHeight;

/**
 取消按钮高度，默认50
 */
@property (nonatomic,assign) CGFloat cancleHeight;



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
/**
 显示actionSheet
 */
- (void)show;


/**
 视图消失
 */
- (void)dissmiss;

/**
 // 初始化 默认样式
 CJKTActionSheet *actionSheet = [[CJKTActionSheet alloc] initWithTitle:@"温馨提示" sheetTitles:@[@"sheet1",@"sheet2"] sheetIcons:@[] cancleBtnTitle:@"确定" sheetStyle:(CJKTActionSheetDefault) ];
 
 //
 //     文字+图标样式 要为actionSheet的iconArr属性赋值
 //    CJKTActionSheet *actionSheet = [[CJKTActionSheet alloc] initWithTitle:@"图标+标题" sheetTitles:@[@"sheet1",@"sheet2",@"sheet3"]  sheetIcons:@[@"test01",@"test02",@"test03"] cancleBtnTitle:@"取消" sheetStyle:(CJKTActionSheetIconAndTitle)];
 
 // 图标样式 要为actionSheet的iconArr属性赋值
 //        CJKTActionSheet *actionSheet = [[CJKTActionSheet alloc] initWithTitle:@"图标" sheetTitles:@[] sheetIcons:@[@"test01",@"test02",@"test03"] cancleBtnTitle:@"取消" sheetStyle:(CJKTActionSheetIcon) ];
 
 //    Block
 //    actionSheet.ActionSheetClickBlock = ^(NSInteger actionSheetIndex) {
 //         NSLog(@"Block点击了sheet%ld",actionSheetIndex+1);
 //    };
 //
 //    actionSheet.ActionSheetCancelClickBlock = ^{
 //
 //        NSLog(@"点击");;
 //    };
 
 actionSheet.delegate = self;
 
 [actionSheet show];
 }
 
 
 #pragma mark -- CJKTActionSheetDelegate
 - (void)actionSheet:(CJKTActionSheet *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex{
 
 NSLog(@"delegate点击了sheet%ld",(long)buttonIndex+1);
 }
 
 - (void)actionSheetCancle:(CJKTActionSheet *)actionSheet{
 
 NSLog(@"点击取消");
 }
 
 
 */

@end

NS_ASSUME_NONNULL_END
