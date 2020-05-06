//
//  UIImage+CJKTExtension.h
//  CJKTCategory
//
//  Created by Dxc_iOS on 2018/11/7.
//  Copyright © 2018 超级课堂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
/**
 原理：一种生成渐变颜色UIImage的方法，从而可以使用UIColor的api
 + (UIColor *)colorWithPatternImage:(UIImage *)image
 来设置背景色。
 */
/**<定义了渐变方向的类型*/
typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到小
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};


@interface UIImage (CJKTExtension)

+ (UIImage *)imageConvertFromColor:(UIColor *)color;

+ (UIImage *)scale:(UIImage *)image size:(CGSize)size;

+ (UIImage *)circleImage:(NSString *)image;

- (UIImage *)circleImage;

+ (UIImage *)circleImageWithName:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor size:(CGSize)originImageSize;



#pragma mark --UIImage 指定宽度按比例缩放
/**
 UIImage指定宽度按比例缩放
 */
+(UIImage *) cjkt_imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;


#pragma mark -- 生成渐变颜色UIImage的方法
/**
  生成渐变颜色UIImage的方法
 */
+ (UIImage *)cjkt_gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;

/**
 使用方法如下:
 UIColor *topleftColor = [UIColor colorWithRed:48/255.0f green:127/255.0f blue:202/255.0f alpha:1.0f];
 UIColor *bottomrightColor = [UIColor colorWithRed:35/255.0f green:195/255.0f blue:95/255.0f alpha:1.0f];
 UIImage *bgImg = [UIImage cjkt_gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeUpleftToLowright imgSize:SCREEN_SIZE];
 
 self.view.backgroundColor = [UIColor colorWithPatternImage:CGSizeMake(100 ,100);];
 
 */


#pragma mark --  通过IconFont的形式创建图片
/**
 通过IconFont的形式创建图片
 * 例如 [UIImage cjkt_imageWithIconFontName:@"iconfont" fontSize:100 text:@"\U0000e603" color:[UIColor greenColor]]
 
 @param iconFontName iconFont的name
 @param fontSize 字体的大小
 @param text 文本信息<unicode>
 @param color 颜色
 @return 创建的图片
 */
+ (UIImage *)cjkt_imageWithIconFontName:(NSString *)iconFontName fontSize:(CGFloat)fontSize text:(NSString *)text color:(UIColor *)color;

/*****************************************/




/**
 根据颜色生成图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)image_WithColor:(nullable UIColor *)color;



/**
 给图片添加文字水印
 
 @param text 水印文字
 @param point 添加位置
 @param attributed 文字的富文本属性
 @return 图片
 */
+ (UIImage *_Nonnull)image_WithWaterMarkText:(nullable NSString *)text textPoint:(CGPoint)point attributedString:(nullable NSDictionary *)attributed;



/**
 给图片添加图片水印
 
 @param markImage 水印图片
 @return 图片
 */
+ (UIImage *_Nonnull)image_WithWaterMarkImage:(nullable UIImage *)markImage;



/**
 获得裁剪后的圆形图片 如果图片是长方形,则获得椭圆形图片
 
 @return 图片
 */
+ (UIImage *_Nonnull)image_Circular;



/**
 获得裁剪后的圆形图片 带边框
 
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 图片
 */
+ (UIImage *_Nonnull)image_CircularBorder:(CGFloat)borderWidth color:(nonnull UIColor *)borderColor;









@end
