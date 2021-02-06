//
//  CJKTTableViewCell.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/5/20.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "CJKTTableViewCell.h"

@implementation CJKTTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)currentIdentifier
{
    return [NSString stringWithFormat:@"%@Identifier", NSStringFromClass(self)];
}

+ (UINib *)currentNib
{
    return [UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil];
}
@end
