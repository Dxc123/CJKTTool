//
//  CJKTCollectionView.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/25.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJKTCollectionView : UICollectionView
@property (nonatomic, assign) BOOL enableRefresh;  //是否开启刷新
@property (nonatomic, assign) BOOL enableFooter;  //是否开启加载
@property (nonatomic, copy) void(^refreshBlock)(void);
@property (nonatomic, copy) void(^loadMoreBlock)(void);

- (void)refreshAction;
- (void)loadMoreAction;
- (void)stopRefresh;
- (void)noMoreData;
@end

NS_ASSUME_NONNULL_END
