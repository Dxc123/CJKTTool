//
//  CJKTShareMenuView.h
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2018/11/28.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, CJKTSharePlatformType) {
    CJKTSharePlatformType_Sina               = 0, //新浪微博
    CJKTSharePlatformType_WechatSession      = 1, //微信聊天
    CJKTSharePlatformType_WechatTimeLine     = 2,//微信朋友圈
    CJKTSharePlatformType_QQ                 = 4,//QQ聊天页面
    CJKTSharePlatformType_Qzone              = 5,//QQ空间
};

@interface CJKTShareMenuView : UIView
/**
 从底部显示的按钮视图
 
 @param titleArray 标题名称
 @param imgNameArray 图片名称
 @param completionHandler 点击返回事件(返回顺序:左->右,上->下, 0,1,2,3...)
 */
+ (void)showShareMenuViewWithTitleArray:(NSArray *)titleArray
             imgNameArray:(NSArray *)imgNameArray
           completionHandler:(void(^)(CJKTSharePlatformType platformType))completionHandler;


/**
 [CJKTShareMenuView showShareMenuViewTitleArray:@[@"拍发票",@"看照片",@"拍发票",@"看照片",@"拍发票",@"看照片"] imgNameArray:@[@"拍发票",@"看照片",@"拍发票",@"看照片",@"拍发票",@"看照片"] completionHandler:^(CJKTSharePlatformType platformType) {
 
 NSLog(@"%ld",platformType);
 }];
 */
@end

NS_ASSUME_NONNULL_END
