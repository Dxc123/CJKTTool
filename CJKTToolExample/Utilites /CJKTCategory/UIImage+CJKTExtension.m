//
//  UIImage+CJKTExtension.m
//  CJKTCategory
//
//  Created by Dxc_iOS on 2018/11/7.
//  Copyright © 2018 超级课堂. All rights reserved.
//

#import "UIImage+CJKTExtension.h"
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@implementation UIImage (CJKTExtension)

+ (UIImage *)imageConvertFromColor:(UIColor *)color {

    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

+ (UIImage *)scale:(UIImage *)image size:(CGSize)size
{
    UIImage *newImage;
    if (image == nil) {
        newImage = nil;
    } else {
        CGSize oldSize = image.size;
        CGRect rect;
        if (size.width / size.height > oldSize.width / oldSize.height) {
            rect.size.width = size.height * oldSize.width / oldSize.height;
            rect.size.height = size.height;
            rect.origin.x = (size.width - rect.size.width) / 2;
            rect.origin.y = 0;
        } else {
            rect.size.width = size.width;
            rect.size.height = size.width * oldSize.height / oldSize.width;
            rect.origin.x = 0;
            rect.origin.y = (size.height - rect.size.height) / 2 ;
        }
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        UIRectFill(CGRectMake(0, 0, size.width, size.height));
        [image drawInRect:rect];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newImage;
}

- (UIImage *)circleImage
{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)circleImageWithName:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor size:(CGSize)originImageSize
{
    
    // 2.开启上下文
    CGFloat imageW = originImageSize.width + 22 * borderWidth;
    CGFloat imageH = originImageSize.height + 22 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文,这里得到的就是上面刚创建的那个图片上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆。As a side effect when you call this function, Quartz clears the current path.
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)circleImage:(NSString *)image
{
    return [[self imageNamed:image] circleImage];
}



#pragma mark --UIImage 指定宽度按比例缩放
+(UIImage *) cjkt_imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -- 生成渐变颜色UIImage的方法
+ (UIImage *)cjkt_gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        case GradientTypeUpleftToLowright:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, imgSize.height);
            break;
        case GradientTypeUprightToLowleft:
            start = CGPointMake(imgSize.width, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}




/**
 通过IconFont的形式创建图片
 
 @param iconFontName iconFont的name
 @param fontSize 字体的大小
 @param text 文案
 @param color 颜色
 @return 创建的图片
 */
+ (UIImage *)cjkt_imageWithIconFontName:(NSString *)iconFontName fontSize:(CGFloat)fontSize text:(NSString *)text color:(UIColor *)color
{
    
    CGFloat size = fontSize;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat realSize = size * scale;
    UIFont *font = [self fontWithSize:realSize withFontName:iconFontName];
    UIGraphicsBeginImageContext(CGSizeMake(realSize, realSize));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if ([text respondsToSelector:@selector(drawAtPoint:withAttributes:)]) {
        /**
         * 如果这里抛出异常，请打开断点列表，右击All Exceptions -> Edit Breakpoint -> All修改为Objective-C
         * See: http://stackoverflow.com/questions/1163981/how-to-add-a-breakpoint-to-objc-exception-throw/14767076#14767076
         */
        [text drawAtPoint:CGPointZero withAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color}];
    } else {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGContextSetFillColorWithColor(context, color.CGColor);
        [text drawAtPoint:CGPointMake(0, 0) withFont:font];
#pragma clang pop
    }
    
    UIImage *image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    
    return image;
}


/**
 iconFont 转化font
 
 @param size 字体大小
 @param fontName 字体的名称
 @return 字体的font
 */
+ (UIFont *)fontWithSize:(CGFloat)size withFontName:(NSString *)fontName {
    
    UIFont *font = [UIFont fontWithName:fontName size:size];
    if (font == nil) {
        
        NSURL *fontFileUrl = [[NSBundle mainBundle] URLForResource:fontName withExtension:@"ttf"];
        [self registerFontWithURL: fontFileUrl];
        font = [UIFont fontWithName:fontName size:size];
        NSAssert(font, @"UIFont object should not be nil, check if the font file is added to the application bundle and you're using the correct font name.");
    }
    return font;
}

// 如果没有在info.plist中声明，在这注册一下也可以。
+ (void)registerFontWithURL:(NSURL *)url {
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath:[url path]], @"Font file doesn't exist");
    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithURL((__bridge CFURLRef)url);
    CGFontRef newFont = CGFontCreateWithDataProvider(fontDataProvider);
    CGDataProviderRelease(fontDataProvider);
    CTFontManagerRegisterGraphicsFont(newFont, nil);
    CGFontRelease(newFont);
}





/******************************/
#pragma mark - 根据颜色生成图片
+ (UIImage *)image_WithColor:(nullable UIColor *)color {
    color = nil == color ? [UIColor blackColor] : color;
    // 矩形描述
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    //获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //使用 color 演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    //结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}


#pragma mark - 给图片添加文字水印
- (UIImage *)image_WithWaterMarkText:(nullable NSString *)text textPoint:(CGPoint)point attributedString:(nullable NSDictionary *)attributed {
    //1.开启上下文  尺寸 / 透明度 / 缩放
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //2.绘制图片
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //添加水印文字
    [text drawAtPoint:point withAttributes:attributed];
    //3.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
    UIGraphicsEndImageContext();
    //返回图片
    return newImage;
}

#pragma mark - 给图片添加图片水印
- (UIImage *)image_WithWaterMarkImage:(nullable UIImage *)markImage {
    if (!markImage) { return self; }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    CGFloat scale = 0.3;
    CGFloat margin = 5;
    CGFloat waterW = markImage.size.width * scale;
    CGFloat waterH = markImage.size.height * scale;
    CGFloat waterX = self.size.width - waterW - margin;
    CGFloat waterY = self.size.height - waterH - margin;
    [markImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


#pragma mark - 获得裁剪后的圆形图片
- (UIImage *)image_Circular {
    //开启图片上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //裁切范围
    UIBezierPath *path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    //绘制图片
    [self drawAtPoint:CGPointZero];
    //从上下文中获得裁切好的图片
    UIImage *cricleImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭图片上下文
    UIGraphicsEndImageContext();
    return cricleImage;
}

#pragma mark - 获得裁剪后的圆形图片 带边框
- (UIImage *)image_CircularBorder:(CGFloat)borderWidth color:(nonnull UIColor *)borderColor {
    //定义尺寸, 图片的尺寸 + 边框的尺寸
    CGSize size = CGSizeMake(self.size.width + 2 * borderWidth, self.size.height + 2 * borderWidth);
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //绘制大圆 作为边框填充
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [borderColor set];
    [path fill];
    //绘制小圆,裁剪图片
    UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, self.size.width, self.size.height)];
    //添加裁剪区域
    [imgPath addClip];
    //把图片绘制到上下文当中
    [self drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    //从上下文当中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

@end
