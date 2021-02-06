//
//  CJKTHomeCell.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/5/22.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "CJKTHomeCell.h"
#import "UIView+MMLayout.h"
@implementation CJKTHomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor grayColor];
        label.numberOfLines = 0;
        [self.contentView addSubview:label];;
        self.titleLab = label;
//        self.titleLab.mm_sizeToFit().mm_left(self.contentView.mm_x+15.f).mm_centerX(self.contentView.mm_centerY);
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-30, 44));
        }];
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

@end
