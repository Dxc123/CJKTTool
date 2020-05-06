//
//  CAShapeLayer+CJKTViewMask.m
//  CJKTCategoryExample
//
//  Created by Dxc_iOS on 2018/12/22.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import "CAShapeLayer+CJKTViewMask.h"

@implementation CAShapeLayer (CJKTViewMask)
+ (instancetype)createMaskLayerWithView : (UIView *)view{
    
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    CGFloat viewHeight = CGRectGetHeight(view.frame);
    
    CGFloat rightSpace = 10.;
    CGFloat topSpace = 15.;
    
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(viewWidth-rightSpace, 0);
    CGPoint point3 = CGPointMake(viewWidth-rightSpace, topSpace);
    CGPoint point4 = CGPointMake(viewWidth, topSpace);
    CGPoint point5 = CGPointMake(viewWidth-rightSpace, topSpace+10.);
    CGPoint point6 = CGPointMake(viewWidth-rightSpace, viewHeight);
    CGPoint point7 = CGPointMake(0, viewHeight);
    
 // 使用UIBezierPath创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
// path移动到开始画图的位置
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point5];
    [path addLineToPoint:point6];
    [path addLineToPoint:point7];
    
    //关闭path
    [path closePath];
    
    // 设置CAShapeLayer与UIBezierPath关联
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    
    return layer;
}

@end
