//
//  QYBaseCollectionViewController.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/25.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "QYBaseViewController.h"
#import <UIScrollView+EmptyDataSet.h>
#import "CJKTCollectionView.h"
NS_ASSUME_NONNULL_BEGIN

@interface QYBaseCollectionViewController : QYBaseViewController
<UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong)   CJKTCollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;
@property (nonatomic,assign) BOOL stopShowEmpty;
@property (nonatomic,strong) UIImage *emptyImage;
@property (nonatomic,strong) NSString *emptyString;
@property (nonatomic,assign) BOOL haveNoNetWorkStatus;
- (void)networkRetry;
@end

NS_ASSUME_NONNULL_END
