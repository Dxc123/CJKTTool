//
//  UILabel+CJKTExtention.m
//  CJKTCategory
//
//  Created by Dxc_iOS on 2018/11/7.
//  Copyright © 2018 超级课堂. All rights reserved.
//

#import "UILabel+CJKTExtention.h"
#import <objc/runtime.h>


@implementation UILabel (CJKTExtention)
static char kContentInsetsKey;
static char kShowContentInsetsKey;


/**
 根据字符串，字体，计算UILabel宽度
 */
+ (CGFloat)cjkt_getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    CGFloat width = label.frame.size.width;
    return ceil(width);
}

/**
 根据字符串，字体，宽度，计算UILabel高度
 */
+ (CGFloat)cjkt_getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return ceil(height);
}



#pragma mark -- UILabel设置内边距

- (void)setContentInsets:(UIEdgeInsets)contentInsets{
    objc_setAssociatedObject(self, &kContentInsetsKey, NSStringFromUIEdgeInsets(contentInsets), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &kShowContentInsetsKey, @YES, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (UIEdgeInsets)contentInsets{
    return UIEdgeInsetsFromString(objc_getAssociatedObject(self, &kContentInsetsKey));
}
+ (void)load{
    [super load];
// class_getInstanceMethod()
    Method fromMethod = class_getInstanceMethod([self class], @selector(drawTextInRect:));
    Method toMethod = class_getInstanceMethod([self class], @selector(tt__drawTextInRect:));
// class_addMethod()
    if (!class_addMethod([self class], @selector(drawTextInRect:), method_getImplementation(toMethod),
                         method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

- (void)tt__drawTextInRect:(CGRect)rect{
    id show = objc_getAssociatedObject(self, &kShowContentInsetsKey);
    if (show) {
        rect = UIEdgeInsetsInsetRect(rect, self.contentInsets);
    }
    [self tt__drawTextInRect:rect];
}




@end
