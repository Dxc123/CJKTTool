//
//  CJKTShareMenuView.h
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2018/11/28.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJKTShareMenuView : UIView
/**
 从底部显示的按钮视图
 
 @param titleArray 标题名称
 @param imgNameArray 图片名称
 @param blockTapAction 点击返回事件(返回顺序:左->右,上->下, 0,1,2,3...)
 */
+ (void)showShareMenuViewTitleArray:(NSArray *)titleArray
             imgNameArray:(NSArray *)imgNameArray
           blockTapAction:(void(^)(NSInteger index))blockTapAction;


/**
 [CJKTShareMenuView showShareMenuViewTitleArray:@[@"拍发票",@"看照片",@"拍发票",@"看照片",@"拍发票",@"看照片"] imgNameArray:@[@"拍发票",@"看照片",@"拍发票",@"看照片",@"拍发票",@"看照片"] blockTapAction:^(NSInteger index) {
 
 NSLog(@"%zd",index);
 }];
 */
@end

NS_ASSUME_NONNULL_END
