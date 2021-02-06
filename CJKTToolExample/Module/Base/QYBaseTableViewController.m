//
//  QYBaseTableViewController.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/24.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "QYBaseTableViewController.h"
#import <UIScrollView+EmptyDataSet.h>
#import <MBProgressHUD.h>

@interface QYBaseTableViewController ()
@property (nonatomic,strong) HWFlashView *flashView;
@property (nonatomic,assign) BOOL endShowEmpty;
@end

@implementation QYBaseTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [self initWithNibName:nil bundle:nil]) {
        self.tableView = [[CJKTTableView alloc] initWithFrame:CGRectZero style:style];
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _isSafeAreaLayout = YES;
        self.tableView = [[CJKTTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return self;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kSepareLineColor;
    [self _initTableView];
    
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.flashMaskView) {
        self.flashView.frame = self.view.bounds;
        [self.flashMaskView layoutIfNeeded];
    }
}

- (void)_initTableView
{
    [self.view addSubview:self.tableView];
    self.tableView.separatorColor = kSepareLineColor;
    self.tableView.layoutMargins = UIEdgeInsetsZero;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.isSafeAreaLayout) {
            if (@available(iOS 11.0, *)) {
                make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
                make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.edges.equalTo(self.view);
            }
        } else {
            make.edges.equalTo(self.view);
        }
    }];
    NSString *sysFirst = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."][0];
    if (sysFirst.integerValue < 11) {
        self.tableView.estimatedRowHeight = 50;
    }
}

#pragma mark - public
- (void)startShowFlashView {
    if (self.flashMaskView) {
        self.endShowEmpty = YES;
        [self.tableView reloadEmptyDataSet];
        if (!self.flashView) {
            
            self.flashView = [[HWFlashView alloc] initWithFrontView:self.flashMaskView];
            self.flashView.userInteractionEnabled = NO;
            if (self.flashViewBackgroundColor) {
                self.flashView.backgroundColor = self.flashViewBackgroundColor;
            }
        }
        [self.view addSubview:self.flashView];
        self.flashView.frame = self.view.bounds;
        [self.flashMaskView layoutIfNeeded];
        
    }
}

- (void)networkRetry {
}

- (void)endShowFlashView {
    [self.flashView stopShow];
    [self.flashView removeFromSuperview];
    self.endShowEmpty = NO;
    [self.tableView reloadEmptyDataSet];
}
#pragma mark    -   UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"section = %ld, row = %ld", (long)indexPath.section, (long)indexPath.row];
    
    return cell;
}
#pragma mark - empty
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.endShowEmpty) return nil;
    
    if (!self.stopShowEmpty) {
        NSString *string;
        // 先看是否是有网络
        if (![[YYReachability reachability] isReachable]) {
            string = @"网络好像开小差了,请检查设置";
        }else{
            string = self.emptyString?self.emptyString:@"没有数据";
        }
        NSAttributedString *attr = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13 weight:UIFontWeightMedium],NSForegroundColorAttributeName:[UIColor grayColor]}];
        return attr;
    }
    return nil;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.endShowEmpty) return nil;
    if (self.stopShowEmpty) {
        return nil;
    }
    // 先看是否是有网络
    if (![[YYReachability reachability] isReachable]) {
        self.haveNoNetWorkStatus = YES;
        return kIMAGE(@"network_404");
    }
    self.haveNoNetWorkStatus = NO;
    if (self.emptyImage) {
        return self.emptyImage;
    }else {
        return kIMAGE(@"table_view_empty");
    }
}
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.haveNoNetWorkStatus || self.emptyCanTouch) {
        [self networkRetry];
    }
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
