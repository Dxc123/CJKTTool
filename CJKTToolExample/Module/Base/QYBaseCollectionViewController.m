//
//  QYBaseCollectionViewController.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/25.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "QYBaseCollectionViewController.h"
#import "HWNetworkStatus.h"
@interface QYBaseCollectionViewController ()

@end

@implementation QYBaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    CJKTCollectionView *collectionView = [[CJKTCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.emptyDataSetDelegate = self;
    self.collectionView.emptyDataSetSource = self;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.edges.equalTo(self.view);
        }
    }];
    
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
- (void)networkRetry {
}
#pragma mark - Empty
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if (!self.stopShowEmpty) {
        NSString *string;
        // 先看是否是有网络
        if (![[HWNetworkStatus shareNetworkStatus] isReachable]) {
            string = @"网络好像开小差了,请检查设置";
        }else{
            string = self.emptyString?self.emptyString:@"没有数据";
        }
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium],NSForegroundColorAttributeName:UIColorFromRGB(0x999999)}];
        return attr;
    }
    return nil;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.stopShowEmpty) {
        return nil;
    }
    // 先看是否是有网络
    if (![[HWNetworkStatus shareNetworkStatus] isReachable]) {
        self.haveNoNetWorkStatus = YES;
        return KIMAGE(@"network_404");
    }
    if (self.emptyImage) {
        return self.emptyImage;
    }else {
        return KIMAGE(@"table_view_empty");
    }
}
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.haveNoNetWorkStatus) {
        [self networkRetry];
    }
}
#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
