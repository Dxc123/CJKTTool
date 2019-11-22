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
//保存到自定义的一个相册中
+(void)saveImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
