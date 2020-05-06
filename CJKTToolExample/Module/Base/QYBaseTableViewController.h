//
//  QYBaseTableViewController.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/24.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "QYBaseViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "CJKTTableView.h"
#import "HWFlashView.h"
NS_ASSUME_NONNULL_BEGIN

@interface QYBaseTableViewController : QYBaseViewController
<UITableViewDelegate, UITableViewDataSource,
DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

- (instancetype)initWithStyle:(UITableViewStyle)style;
@property (nonatomic, strong) CJKTTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,assign) BOOL stopShowEmpty;
@property (nonatomic,strong) NSString *emptyString;
@property (nonatomic,strong) UIImage *emptyImage;
@property (nonatomic,strong) UIView *flashMaskView;
@property (nonatomic,assign) BOOL haveNoNetWorkStatus;
@property (nonatomic,assign) BOOL emptyCanTouch;
@property (nonatomic,strong) UIColor *flashViewBackgroundColor;
/// default is YES
@property (nonatomic, assign) BOOL isSafeAreaLayout;

- (void)startShowFlashView;
- (void)endShowFlashView;
- (void)networkRetry;
@end

NS_ASSUME_NONNULL_END
