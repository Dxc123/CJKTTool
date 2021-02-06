//
//  JJGiftCollectionView.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/5/9.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "JJGiftCollectionView.h"
#import "JJCollectionViewLayout.h"
#import "JJCollectionViewCell.h"

@interface JJGiftCollectionView() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) NSInteger selectedItemIndex;
@property (nonatomic, assign) BOOL isScrolling;
@property (nonatomic, assign) NSInteger itemCount;

@end
extern CGFloat radius_;

@implementation JJGiftCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    JJCollectionViewLayout *layout = [[JJCollectionViewLayout alloc] init];
    layout.cellItemSize = CGSizeMake(86, 100);
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[JJCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass(JJCollectionViewCell.class)];
        _itemCount = 10;
        _selectedItemIndex = 0;
    }
    return self;
}

#pragma mark - Object Private Function

- (UIColor *)randomColor
{
    CGFloat red = random() % 255 / 255.0;
    CGFloat green = random() % 255 / 255.0;
    CGFloat blue = random() % 255 / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.];
}

- (void)scrollToSelectedIndex:(NSInteger)index
{
    self.selectedItemIndex = index;
    [self setContentOffset:CGPointMake([self itemPerWidthFromIphone]*index, 0) animated: YES];
}

#pragma mark - Object Public Function

- (void)scrollToCenter
{
    if (_itemCount == 0) {
        return ;
    }
    [self scrollToSelectedIndex:floorf(_itemCount/2)];
}

- (CGFloat)itemPerWidthFromIphone
{
    CGFloat width = self.contentSize.width;
    NSInteger count = _itemCount;
    CGFloat anglePerItem = atan((width/count) / (radius_+25));
    CGFloat angleAtExtreme = [self numberOfItemsInSection:0] > 0 ? -([self numberOfItemsInSection:0] -1)*anglePerItem : 0;
    CGFloat factor = -angleAtExtreme/(self.contentSize.width - CGRectGetWidth(self.bounds));
    return anglePerItem/factor;
}

#pragma - mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(JJCollectionViewCell.class) forIndexPath:indexPath];
    cell.backgroundColor = [self randomColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CJKTLog(@"点击了%ld",(long)indexPath.row);
    if (indexPath.row == _selectedItemIndex || indexPath.row >= _itemCount) {
        return ;
    }
    _selectedItemIndex = indexPath.row;
    [self scrollToSelectedIndex:_selectedItemIndex];
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat perItemWidth = [self itemPerWidthFromIphone];
    CGFloat index = (scrollView.contentOffset.x)/perItemWidth;
    NSInteger selectIndex = round(index);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:selectIndex inSection:0];
    [self collectionView:self didSelectItemAtIndexPath:indexPath];
    self.isScrolling = NO;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    self.isScrolling = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isScrolling = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.isScrolling = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
