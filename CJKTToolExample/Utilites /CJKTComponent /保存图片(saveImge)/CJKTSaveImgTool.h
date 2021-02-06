//
//  CJKTSaveImgTool.h
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2019/11/22.
//  Copyright © 2019 CJKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJKTSaveImgTool : NSObject

+ (instancetype)sharedInstance;


/**
 将图片保存到系统相册(方法一)
 */
- (void)cjkt_saveImage:(UIImage *)image
       completion:(void(^)(NSString *_Nonnull title))completion;

/**
 保存图片到系统相册（方法二）
 */
- (void)cjkt_saveImageToUserPhotoAlbum:(UIImage *)image
                       completion:(void(^)(BOOL success, NSError * _Nullable error))completion;


/**
 保存到自定义的一个相册中(创建和APP同名的相册保存在【自定义相册】里面)
 */
- (void)cjkt_savePhotosImage:(UIImage *)image
      completion:(void(^)(NSString *_Nonnull title))completion;


//【自定义相册】
//1.先保存图片到【相机胶卷】(不能直接保存到自定义相册中)
//2.拥有一个【自定义相册】
//3.将刚才保存到【相机胶卷】里面的图片引用到【自定义相册】
@end

NS_ASSUME_NONNULL_END
