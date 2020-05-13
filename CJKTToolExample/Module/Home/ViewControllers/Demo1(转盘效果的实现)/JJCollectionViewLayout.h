//
//  JJCollectionViewLayout.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/5/9.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJCollectionViewLayout : UICollectionViewLayout
@property (nonatomic, assign) CGSize cellItemSize;// 单元格大小
@property (nonatomic, assign) CGFloat radius; // 圆环半径
@property (nonatomic, strong) NSIndexPath *selectedIndexPath; // 选中的单元格
@property (nonatomic, assign) CGFloat scrollContentOffsetX;

@end

@interface JJCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, assign) CGPoint anchorPoint; // 锚点
@property (nonatomic, assign) CGFloat angle; // 角度

@end
NS_ASSUME_NONNULL_END
