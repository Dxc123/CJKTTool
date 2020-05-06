//
//  UIView+MLAnimation.h
//  AnimationKit-demo
//
//  Created by menglin on 2019/9/28.
//  Copyright © 2019 menglin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MLAnimation)

//横向平移

/**
 将x坐标设置成指定的点
 @param x 新的坐标
 @param completion 结束后回调
 */
-(void)setWithX:(CGFloat)x
    finished:(void (^ __nullable)(void))completion;

/**
将x坐标设置成指定的点

@param x 新的坐标
@param duration 动画持续时间
@param completion 结束后回调
*/
-(void)setWithX:(CGFloat)x
    duration:(NSTimeInterval)duration
    finished:(void (^ __nullable)(void))completion;

/**
在原有的坐标上向右移动x个像素
@param x 像素值
@param completion 结束后回调
*/
-(void)moveWithX:(CGFloat)x
   finished:(void (^ __nullable)(void))completion;

/**
在原有的坐标上向右移动x个像素
@param x 像素值
@param duration 动画持续时间
@param completion 结束后回调
*/
-(void)moveWithX:(CGFloat)x
   duration:(NSTimeInterval)duration
   finished:(void (^ __nullable)(void))completion;



//纵向平移
-(void)setWithY:(CGFloat)y
       finished:(void (^ __nullable)(void))completion;

-(void)setWithY:(CGFloat)y
       duration:(NSTimeInterval)duration
       finished:(void (^ __nullable)(void))completion;

-(void)moveWithY:(CGFloat)y
        finished:(void (^ __nullable)(void))completion;

-(void)moveWithY:(CGFloat)y
        duration:(NSTimeInterval)duration
        finished:(void (^ __nullable)(void))completion;
//缩放动画
-(void)scaleWithRatio:(CGFloat)ratio
             original:(BOOL)original
             duration:(NSTimeInterval)duration
             finished:(void (^ __nullable)(void))completion;

-(void)scaleWithRatio:(CGFloat)ratio
             duration:(NSTimeInterval)duration
             finished:(void (^ __nullable)(void))completion;

-(void)scaleWithRatio:(CGFloat)ratio
             original:(BOOL)original
             finished:(void (^ __nullable)(void))completion;

-(void)scaleWithRatio:(CGFloat)ratio
             finished:(void (^ __nullable)(void))completion;

-(void)scaleFromRatio:(CGFloat)fromRatio
              toRatio:(CGFloat)toRatio
             original:(BOOL)original
             duration:(NSTimeInterval)duration
             finished:(void (^ __nullable)(void))completion;

//旋转动画
-(void)rotationWithAngle:(CGFloat)angle
                finished:(void (^ __nullable)(void))completion;

-(void)rotationWithAngle:(CGFloat)angle
                duration:(NSTimeInterval)duration
                finished:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
