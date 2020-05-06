//
//  HWRefreshGifImages.m
//  WannyEnglish
//
//  Created by edz on 2020/4/2.
//  Copyright © 2020 wanny. All rights reserved.
//

#import "HWRefreshGifImages.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation HWRefreshGifImages
+ (instancetype)sharedInstance {
    static HWRefreshGifImages *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HWRefreshGifImages alloc] init];
    });
    return _instance;
}

- (NSArray *)images {
    if (!_images) {
        NSMutableArray *imgs = [NSMutableArray array];
        for (int i = 0; i <= 69 ; i++) {
            NSString *imgName = [NSString stringWithFormat:@"loading_%02d",i];
            [imgs addObject:KIMAGE(imgName)];
        }
        _images = imgs.copy;
//        //获取Gif文件
//        NSURL *gifImageUrl = [[NSBundle mainBundle] URLForResource:@"global_refresh" withExtension:@"gif"];
//
//        //获取Gif图的原数据
//        CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)gifImageUrl, NULL);
//
//        //获取Gif图有多少帧
//        size_t gifcount = CGImageSourceGetCount(gifSource);
//
//
//        NSMutableArray *images = [[NSMutableArray alloc] init];
//
//
//        for (NSInteger i = 0; i < gifcount; i++) {
//
//            //由数据源gifSource生成一张CGImageRef类型的图片
//
//            CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
//
//            UIImage *image = [UIImage imageWithCGImage:imageRef];
//            [images addObject:image];
//            CGImageRelease(imageRef);
//        }
//        _images = images.copy;
//        CFRelease(gifSource);
    }
    return _images;
}
@end
