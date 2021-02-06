//
//  UIView+CJKTExtension.h
//  CJKTCategory
//
//  Created by Dxc_iOS on 2018/11/7.
//  Copyright © 2018 超级课堂. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ShakeDirection) {
     ShakeTypeHorizontal,
     ShakeTypeVertical,
};
NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJKTExtension)

#pragma mark -- 快速设置控件frame
//注意 view 与 view 之间互相计算时，需要保证处于同一个坐标系内
/**  起点x坐标  */
@property (nonatomic, assign) CGFloat cjkt_x;
/**  起点y坐标  */
@property (nonatomic, assign) CGFloat cjkt_y;
/**  中心点x坐标  */
@property (nonatomic, assign) CGFloat cjkt_centerX;
/**  中心点y坐标  */
@property (nonatomic, assign) CGFloat cjkt_centerY;
/**  宽度  */
@property (nonatomic, assign) CGFloat cjkt_width;
/**  高度  */
@property (nonatomic, assign) CGFloat cjkt_height;
/**  顶部  */
@property (nonatomic, assign) CGFloat cjkt_top;
/**  底部  */
@property (nonatomic, assign) CGFloat cjkt_bottom;
/**  左边  */
@property (nonatomic, assign) CGFloat cjkt_left;
/**  右边  */
@property (nonatomic, assign) CGFloat cjkt_right;
/**  size  */
@property (nonatomic, assign) CGSize  cjkt_size;
/**  origin */
@property (nonatomic, assign) CGPoint cjkt_origin;

#pragma mark -- 获取当前View的控制器对象
/**
 获取当前View的控制器对象
 */
-(UIViewController *)cjkt_getCurrentViewController;
#pragma mark -- 把view加在window上
/**
 把view加在window上
 */
- (void)cjkt_addToWindow;

#pragma mark -- 屏幕截图
/**
 屏幕截图
 */
-(UIImage *)cjkt_getScreenShot;


#pragma mark --  UIView绑定的点击事件回调block
/**
 *UIView绑定的事件回调block
 *本质就是利用category和runtime给UIView添加了一个block属性，单击的时候回调这个block。
 *使用：
 [self.view cjkt_addViewTapped:^{
 NSLog(@"单击了view");
 }];
 */

- (void)cjkt_addViewTapped:(void(^_Nonnull)(void))tappedBlock;



#pragma mark --  画圆角(贝塞尔曲线\避免离屏渲染)
/**
 画圆角(贝塞尔曲线)
 @param radius 半径
 @param corners UIRectCorner 类型
 */
- (void)cjkt_drawCircleAngle:(CGFloat)radius corners:(UIRectCorner)corners;

#pragma mark -- 画虚线(CAShapeLayer)

/**
  画出一条横向的虚线 (CAShapeLayer)
 @param Frame Frame
 @param lineColor 虚线颜色
 @param lineWidth 单端虚线长度
 @param lineSpace 虚线间隔
 */
- (void)cjkt_drawImaginaryLineWithFrame:(CGRect)Frame
                              lineColor:(UIColor*)lineColor
                              lineWidth:(CGFloat)lineWidth
                              lineSpace:(CGFloat)lineSpace;





////摇动动画
-(void)cjkt_startShakeAnimation;

////停止摇动动画
-(void)cjkt_stopShakeAnimation;

////360度旋转动画
-(void)cjkt_startRotateAnimation;

////停止360度旋转动画
-(void)cjkt_stopRotateAnimation;

////放大的弹簧动画
-(void)cjkt_startSpringingAnimation;

////停止放大的弹簧动画
-(void)cjkt_stopSpringingAnimation;

////围绕Z轴旋转180度
-(void)cjkt_startTrans180DegreeAnimation;


//淡入
- (void)fadeIn;
- (void)fadeInOnComplet:(void(^)(BOOL))complet;
//淡出
- (void)fadeOut;
- (void)fadeOutOnComplet:(void(^)(BOOL))complet;

//移除视图
- (void)removeAllSubviews;
- (void)removeSubviewWithTag:(int)tag;
- (void)removeSubviewExceptTag:(int)tag;







@end

NS_ASSUME_NONNULL_END
