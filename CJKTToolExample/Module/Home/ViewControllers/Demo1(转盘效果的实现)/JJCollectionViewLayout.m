//
//  JJCollectionViewLayout.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/5/9.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "JJCollectionViewLayout.h"
@interface JJCollectionViewLayout ()

@property (nonatomic, strong) NSMutableArray <JJCollectionViewLayoutAttributes *> *attributeItems;
@property (nonatomic, assign) CGRect changeRect;

@end

extern CGFloat radius_;
@implementation JJCollectionViewLayout

- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
    
    [self invalidateLayout];
}

+ (Class)layoutAttributesClass
{
    return JJCollectionViewLayoutAttributes.class;
}

// 当滑到极端时  第0个item的角度
- (CGFloat)angleAtExtreme
{
    return [self.collectionView numberOfItemsInSection:0] > 0 ? -([self.collectionView numberOfItemsInSection:0] -1)*self.anglePerItem : 0;
}
// 滑动时 第0个角度
- (CGFloat)angle
{
    return (self.angleAtExtreme * self.collectionView.contentOffset.x)/(self.collectionViewContentSize.width - self.collectionView.bounds.size.width);
}

- (CGFloat)anglePerItem
{
    return atan((self.cellItemSize.width) / self.radius);
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake([self.collectionView numberOfItemsInSection:0] * self.cellItemSize.width, CGRectGetHeight(self.collectionView.bounds));
}

- (void)setCellItemSize:(CGSize)cellItemSize
{
    _cellItemSize = cellItemSize;
}

- (instancetype)init
{
    if (self == [super init]) {
        _radius = radius_ - 50;
        _attributeItems = [[NSMutableArray alloc] init];
        _cellItemSize = CGSizeMake(86, 100);
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    CGFloat centerX = self.collectionView.contentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2.0;
    CGFloat anchorPointY = ((self.cellItemSize.height/2.0) + self.radius)/self.cellItemSize.height;
    
    // 只计算在屏幕中的item 正切
    CGFloat theTan = atan2(CGRectGetWidth(self.collectionView.bounds)/2.0, self.radius + self.cellItemSize.height/2.0 - CGRectGetHeight(self.collectionView.bounds)/2.0);
    
    NSInteger startIndex = 0;
    NSInteger endIndex = [self.collectionView numberOfItemsInSection:0] - 1;
    if (self.angle < -theTan) {
        startIndex = floor((-theTan - self.angle)/self.anglePerItem);
    }
    endIndex = MIN(endIndex, ceil((theTan - self.angle)/self.anglePerItem));
    if (endIndex < startIndex) {
        endIndex = 0;
        startIndex = 0;
    }
    
    for (NSInteger index = startIndex; index <= endIndex; index ++) {
        JJCollectionViewLayoutAttributes *attributes = [JJCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        attributes.size = self.cellItemSize;
        attributes.center = CGPointMake(centerX, CGRectGetMidY(self.collectionView.bounds) - 25);
        attributes.angle = self.angle + (self.anglePerItem * index);
        attributes.anchorPoint = CGPointMake(0.5, anchorPointY);
        [self.attributeItems addObject:attributes];
    }
}
// 固定item在中间位置
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGPoint finalContentOffset = proposedContentOffset;
    CGFloat factor = -self.angleAtExtreme/(self.collectionViewContentSize.width - CGRectGetWidth(self.collectionView.bounds));
    CGFloat proposedAngle = proposedContentOffset.x * factor;
    CGFloat ratio = proposedAngle/self.anglePerItem;
    CGFloat multiplier = 0.0;
    if (velocity.x > 0) {
        multiplier = ceil(ratio);
    } else if (velocity.x < 0) {
        multiplier = floor(ratio);
    } else {
        multiplier = round(ratio);
    }
    finalContentOffset.x = multiplier*self.anglePerItem/factor;
    self.scrollContentOffsetX = finalContentOffset.x;
    return finalContentOffset;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributeItems;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.attributeItems[indexPath.item];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end


@implementation JJCollectionViewLayoutAttributes

#pragma mark - Override Base Function

- (instancetype)init
{
    if (self = [super init]) {
        _anchorPoint = CGPointMake(0.5, 0.5);
        _angle = 0;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    JJCollectionViewLayoutAttributes *attributes = [super copyWithZone:zone];
    attributes.anchorPoint = self.anchorPoint;
    attributes.angle = self.angle;
    return attributes;
}

#pragma mark - Getter && Setter

- (void)setAnchorPoint:(CGPoint)anchorPoint
{
    _anchorPoint = anchorPoint;
}

- (void)setAngle:(CGFloat)angle
{
    _angle = angle;
    self.zIndex = angle * 1000000;
    self.transform = CGAffineTransformMakeRotation(angle);
}

@end
