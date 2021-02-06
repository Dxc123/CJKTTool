//
//  CJKTCollectionViewCell.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/5/20.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJKTCollectionViewCell : UICollectionViewCell
+ (NSString *)currentIdentifier;

+ (UINib *)currentNib;
@end

NS_ASSUME_NONNULL_END
