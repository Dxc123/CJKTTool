//
//  MBProgressHUD+CJKTGifAnimation.m
//  UQKTProject
//
//  Created by Westbrook on 2018/5/22.
//  Copyright © 2018年 cjkt. All rights reserved.
//

#import "MBProgressHUD+CJKTGifAnimation.h"

@implementation MBProgressHUD (CJKTGifAnimation)

+(MBProgressHUD *)progressViewWithGif:(BOOL)gif message:(NSString *)message superView:(UIView *)superview {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:superview animated:YES];
    if (!message) {
        message =@"努力加载中...";
    }
    HUD.label.text =message;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"smallCycleBlue" ofType:@".gif"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image =[self isGIFImageWithData:data];
    UIImageView *hudView = [[UIImageView alloc]initWithImage:image];
    
    HUD.label.font =[UIFont systemFontOfSize:13];
    HUD.bezelView.layer.cornerRadius =10;
    
    HUD.customView = hudView;
    HUD.offset = CGPointMake(0, -30);
    
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.label.textColor = [UIColor grayColor];
    
    return HUD;
}

+ (UIImage *)isGIFImageWithData:(NSData *)data{
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            duration = 1;
            
            [images addObject:[UIImage imageWithCGImage:image scale:3 orientation:UIImageOrientationUp]];
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

@end
