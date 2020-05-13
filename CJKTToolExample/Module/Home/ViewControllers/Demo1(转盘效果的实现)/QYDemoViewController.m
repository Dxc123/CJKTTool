//
//  QYDemoViewController.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/5/9.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "QYDemoViewController.h"
#import "JJGiftCollectionView.h"

#define kCollectionViewHeight   300.0
//#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
//#define kScreenHeight           [UIScreen mainScreen].bounds.size.height

CGFloat radius_ = 308;
@interface QYDemoViewController ()
@property (nonatomic, strong) JJGiftCollectionView *collectionView;

@end

@implementation QYDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - Object Private Function

- (void)initUI
{
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.contentOffset = CGPointMake(86 * 5, 0.0);
}

#pragma mark - Getter && Setter

- (JJGiftCollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[JJGiftCollectionView alloc] initWithFrame:CGRectMake(0.0, kScreenHeight - kCollectionViewHeight, kScreenWidth, kCollectionViewHeight)];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
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
