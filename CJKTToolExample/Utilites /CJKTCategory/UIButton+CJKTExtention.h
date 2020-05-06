//
//  UIButton+CJKTExtention.h
//  CJKTCategory
//
//  Created by Dxc_iOS on 2018/11/7.
//  Copyright © 2018 超级课堂. All rights reserved.
//

#import <UIKit/UIKit.h>
//UIButton分类： 图片和文字布局调整
// 定义一个枚举（包含了四种类型的button）
typedef enum : NSUInteger  {
    QYImagePositionStyleLeft,    // image在左，label在右
    QYImagePositionStyleTop,    // image在上，label在下
    QYImagePositionStyleBottom, // image在下，label在上
    QYImagePositionStyleRight ,  // image在右，label在左
} QYImagePositionStyle;

//点击Block
typedef void(^clickBlock)(UIButton *button);


//倒计时回调Block

typedef void(^QYCountdownCompletionBlock)(void);

@interface UIButton (CJKTExtention)

@property (nonatomic, copy) clickBlock click;

- (void)verticalImageAndTitle:(CGFloat)spacing;

- (void)rightImageAndLeftTitle:(CGFloat)spacing;


/**
 自定义响应边界 UIEdgeInsetsMake(-3, -4, -5, -6). 表示扩大
 */
@property (nonatomic, assign) UIEdgeInsets hitEdgeInsets;


/**
 自定义响应边界 自定义的边界的范围 范围扩大3.0
 例如：self.btn.hitScale = 3.0;
 */
@property (nonatomic, assign) CGFloat hitScale;


/**
 自定义响应边界 自定义的宽度的范围 范围扩大3.0
 例如：self.btn.hitWidthScale = 3.0;
 */
@property (nonatomic, assign) CGFloat hitWidthScale;

/*
 自定义响应边界 自定义的高度的范围 范围扩大3.0
 例如：self.btn.hitHeightScale = 3.0;
 */
@property (nonatomic, assign) CGFloat hitHeightScale;






#pragma mark -- 设置UIButton 图片和文字布局调整
/**
 *  设置图片与文字样式
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 */
- (void)QY_imagePositionStyle:(QYImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing;


#pragma mark -- 设置图片与文字样式（推荐使用）
/**
 *  设置图片与文字样式（推荐使用）
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 *  @param imagePositionBlock     在此 Block 中设置按钮的图片、文字以及 contentHorizontalAlignment 属性
 */
- (void)QY_imagePositionStyle:(QYImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing imagePositionBlock:(void (^)(UIButton *button))imagePositionBlock;



/**
 // 推荐使用
 [_defaultBtn QY_imagePositionStyle:(QYImagePositionStyleLeft) spacing:5 imagePositionBlock:^(UIButton *button) {
 [button setTitle:@"间距调整" forState:(UIControlStateNormal)];
 [button setImage:[UIImage imageNamed:@"image"] forState:(UIControlStateNormal)];
 }];
 
 // right
 
 [_rightBtn QY_imagePositionStyle:(QYImagePositionStyleRight) spacing:10];
 */




#pragma mark --倒计时，s倒计
/**
 *倒计时，s倒计
 */
- (void)QY_countdownWithSec:(NSInteger)time;

#pragma mark --倒计时，秒字倒计
/**
 *倒计时，秒字倒计
 */
- (void)QY_countdownWithSecond:(NSInteger)second;

#pragma mark --倒计时，s倒计,带有回调
/**
 *倒计时，s倒计,带有回调
 */
- (void)QY_countdownWithSec:(NSInteger)sec completion:(QYCountdownCompletionBlock)block;

#pragma mark --倒计时,秒字倒计，带有回调
/**
 *倒计时,秒字倒计，带有回调
 */
- (void)QY_countdownWithSecond:(NSInteger)second completion:(QYCountdownCompletionBlock)block;


/**使用
 
 //s倒计
 [button QY_countdownWithSec:30];
 
 //秒字倒计
 [button QY_countdownWithSecond:31];
 
 // s倒计,带有回调
 [button QY_countdownWithSec:30 completion:^{
 [button setTitle:@"重新获取" forState:(UIControlStateNormal)];
 }];
 
 //秒字倒计，带有回调
 [button QY_countdownWithSecond:30 completion:^{
 [button setTitle:@"重新获取" forState:(UIControlStateNormal)];
 }];
 */



#pragma mark -- UIButton事件回调block
//模仿的BlocksKit
//本质就是利用category和runtime给UIButton添加了一个block属性，单击的时候回调这个block。

/**
 UIButton事件回调block
 
 @param block 回调的block
 @param controlEvents 回调block的事件
 */
- (void)cjkt__addButtonEventHandler:(void(^)(void))block forControlEvents:(UIControlEvents)controlEvents;

/**
 使用：
 [button qy_addEventHandler:^{
 NSLog(@"单击了button");
 } forControlEvents:UIControlEventTouchUpInside];
 
 */





@end
