//
//  CAShapeLayer+CJKTViewMask.h
//  CJKTCategoryExample
//
//  Created by Dxc_iOS on 2018/12/22.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
/**
 CAShapeLayer继承自CALayer,可使用CALayer的所有属性,但是比 CALayer 更灵活，可以画出各种图形.CAShapeLayer 有一个神奇的属性 path 用这个属性配合上 UIBezierPath 这个类就可以达到意想不到的效果.
 
 CAShapeLayer与UIBezierPath的关系：
 CAShapeLayer中shape代表形状的意思，所以需要形状才能生效,贝塞尔曲线可以为其提供形状，而单独使用CAShapeLayer是没有任何意义的.贝塞尔曲线可以创建基于矢量的路径，而UIBezierPath类是对CGPathRef的封装.
 贝塞尔曲线给CAShapeLayer提供路径，CAShapeLayer在提供的路径中进行渲染。路径会闭环，所以绘制出了Shape.用于CAShapeLayer的贝塞尔曲线作为path，其path是一个首尾相接的闭环的曲线，即使该贝塞尔曲线不是一个闭环的曲线.
 
实现CAShapeLayer和UIBezierPath的步骤吧
 1、创建出一个UIBezierPath对象
 2、创建CAShapeLayer对象
 3、将UIBezierPath对象的CGPath赋值给CAShapeLayer对象的path： shapeLayer.path = bezierPath.CGPath
 4、把CAShapeLayer添加到某个显示该图形的layer中
 */
@interface CAShapeLayer (CJKTViewMask)

+ (instancetype)createMaskLayerWithView : (UIView *)view;
@end

NS_ASSUME_NONNULL_END
