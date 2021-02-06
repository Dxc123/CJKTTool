//
//  CJKTCollectionViewCell.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/5/20.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "CJKTCollectionViewCell.h"

@implementation CJKTCollectionViewCell
+ (NSString *)currentIdentifier
{
    return [NSString stringWithFormat:@"%@Identifier", NSStringFromClass(self)];
}

+ (UINib *)currentNib
{
    return [UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil];
}

@end
