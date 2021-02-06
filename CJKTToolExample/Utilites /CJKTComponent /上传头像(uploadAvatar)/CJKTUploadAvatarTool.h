//
//  CJKTUploadAvatarTool.h
//  QYSearchProject
//
//  Created by Dxc_iOS on 2018/12/4.
//  Copyright © 2018 cjkt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

//上传头像工具类
@interface CJKTUploadAvatarTool : NSObject
+ (CJKTUploadAvatarTool *)shareManager;
- (void)cjkt_selectAvatarWithViewController:(UIViewController *)viewController WithFinishBlcok:(void(^)(UIImage *image))finishBlock;
@end

NS_ASSUME_NONNULL_END

