//
//  QiCodePreviewView.h
//  QiQRCode
//
//  Created by huangxianshuai on 2018/11/13.
//  Copyright © 2018年 QiShare. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class QiCodePreviewView;
@protocol QiCodePreviewViewDelegate <NSObject>
//打开闪光灯
- (void)codeScanningView:(QiCodePreviewView *)scanningView didClickedTorchSwitch:(UIButton *)switchButton;

@end

@interface QiCodePreviewView : UIView

@property (nonatomic, assign, readonly) CGRect rectFrame;
@property (nonatomic, weak) id<QiCodePreviewViewDelegate> delegate;


/**
 QiCodePreviewView初始化方法

 @param frame 扫码界面frame
 @param rectFrame 扫码区域frame
 @param rectColor 扫码区域四角以及扫描线的颜色
 @return QiCodePreviewView对象
 */
- (instancetype)initWithFrame:(CGRect)frame rectFrame:(CGRect)rectFrame rectColor:(UIColor *)rectColor;
- (instancetype)initWithFrame:(CGRect)frame rectColor:(UIColor *)rectColor;
- (instancetype)initWithFrame:(CGRect)frame rectFrame:(CGRect)rectFrame;
/**
 开始扫描
 */
- (void)startScanning;

/**
 停止扫描
 */
- (void)stopScanning;

/**
 开始菊花转圈动画
 */
- (void)startIndicating;

/**
 开始菊花转圈动画
 */
- (void)stopIndicating;

/**
 显示闪光灯
 */
- (void)showTorchSwitch;

/**
 隐藏闪光灯
 */
- (void)hideTorchSwitch;

@end

NS_ASSUME_NONNULL_END
