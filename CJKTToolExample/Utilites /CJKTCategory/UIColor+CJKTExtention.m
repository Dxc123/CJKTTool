//
//  UIColor+CJKTExtention.m
//  CJKTCategory
//
//  Created by Dxc_iOS on 2018/11/7.
//  Copyright © 2018 超级课堂. All rights reserved.
//

#import "UIColor+CJKTExtention.h"

@implementation UIColor (CJKTExtention)

+ (UIColor *)cjkt_colorWithRGBWithAlpha:(CGFloat)R green:(CGFloat)G blue:(CGFloat)B alpha:(CGFloat)alpha {
    
    return [UIColor colorWithRed:R / 255.0f green:G / 255.0f blue:B / 255.0f alpha:alpha];
    
}

+ (UIColor *)cjkt_colorWithRGB:(CGFloat)R green:(CGFloat)G blue:(CGFloat)B {
    
    return [self cjkt_colorWithRGBWithAlpha:R green:G blue:B alpha:1.0f];
    
}

//例:@"#eef4f4"得到UIColor
+ (UIColor *)cjkt_colorWithHexString:(NSString *) hexString
{
    
    return [self cjkt_colorWithHexString:hexString alpha:1.0];
    
}

+ (UIColor *)cjkt_colorWithHexString:(NSString *)hexString alpha:(double)alpha
{
    
    if ([hexString length] == 0) {
        
        return [UIColor clearColor];
        
    }
    
    if ( [hexString caseInsensitiveCompare:@"clear"] == NSOrderedSame) {
        
        return [UIColor clearColor];
        
    }
    
    if([hexString characterAtIndex:0] == 0x0023 && [hexString length]<8)
    {
        
        const char * strBuf= [hexString UTF8String];
        
        NSInteger iColor = strtol((strBuf+1), NULL, 16);
        
        typedef struct colorByte
        {
            unsigned char b;
            unsigned char g;
            unsigned char r;
        }CLRBYTE;
        
        CLRBYTE * pclr = (CLRBYTE *)&iColor;
        
        return [UIColor colorWithRed:((double)pclr->r/255.f) green:((double)pclr->g/255.f) blue:((double)pclr->b/255) alpha:alpha];
        
    }
    
    return [UIColor blackColor];
    
}

#pragma mark -- 产生一个随机色，大部分情况下用于测试
+ (UIColor *)cjkt_randomColor{
    CGFloat red = ( arc4random() % 255 / 255.0 );
    CGFloat green = ( arc4random() % 255 / 255.0 );
    CGFloat blue = ( arc4random() % 255 / 255.0 );
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
@end
