//
//  JJCollectionViewCell.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/5/9.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "JJCollectionViewCell.h"
#import "JJCollectionViewLayout.h"
@implementation JJCollectionViewCell
#pragma mark - Override Base Function

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    if ([layoutAttributes isKindOfClass:[JJCollectionViewLayoutAttributes class]]) {
        JJCollectionViewLayoutAttributes *attributes = (JJCollectionViewLayoutAttributes *)layoutAttributes;
        self.layer.anchorPoint = attributes.anchorPoint;
        CGFloat y = self.layer.position.y;
        y += (attributes.anchorPoint.y - 0.5) * CGRectGetHeight(self.bounds);
        CGPoint center = CGPointMake(self.layer.position.x, y);
        self.layer.position = center;
        
        self.contentView.transform = CGAffineTransformMakeRotation(-attributes.angle);
    }
}
@end
