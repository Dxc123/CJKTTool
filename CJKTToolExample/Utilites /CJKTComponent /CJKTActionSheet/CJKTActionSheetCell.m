//
//  WHActionSheetCell.m
//  BeeBee
//
//  Created by quwan on 2017/6/15.
//  Copyright © 2017年 quwan. All rights reserved.
//
#define kActionSheetScreenWidth ([UIScreen mainScreen].bounds.size.width)

#import "CJKTActionSheetCell.h"

@implementation CJKTActionSheetCell
{
    CGFloat _height;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.coverView = [[UIView alloc] init];
        [self addSubview:_coverView];
    }
    return self;
}

- (void)setupCJKTActionSheetDefaultCellWithTitle:(NSString *)title CellHeight:(CGFloat)height
{
    _height = height;
    _coverView.frame = CGRectMake(0, 0, kActionSheetScreenWidth, _height);
    
    self.titleLab = [[UILabel alloc] init];
    _titleLab.frame = CGRectMake(0, 0, kActionSheetScreenWidth, _height);
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.text = title;
    [self.coverView addSubview:_titleLab];
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _height-0.5, kActionSheetScreenWidth, 0.5)];
    _bottomLine.backgroundColor = [UIColor grayColor];
    [self.coverView addSubview:_bottomLine];
    
}
- (void)setupCJKTActionSheetIconAndTitleWithTitle:(NSString *)title titleFont:(UIFont *)font icon:(NSString *)icon cellHeight:(CGFloat)height
{
    _height = height;
    _coverView.frame = CGRectMake(0, 0, kActionSheetScreenWidth, _height);
    
    NSDictionary *attrs = @{NSFontAttributeName:font};
    CGSize size = [title sizeWithAttributes:attrs];
    CGFloat titleWidth = size.width+10;
    
    self.titleLab = [[UILabel alloc] init];
    _titleLab.frame = CGRectMake((kActionSheetScreenWidth-titleWidth)/2, 0, titleWidth, _height);
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.text = title;
    [self.coverView addSubview:_titleLab];
    
    CGFloat iconWidth = _height*0.4;
    self.iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLab.frame)-iconWidth-10, _height*0.3, iconWidth, iconWidth)];
    _iconImg.image = [UIImage imageNamed:icon];
    [self.coverView addSubview:_iconImg];
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _height-0.5, kActionSheetScreenWidth, 0.5)];
    _bottomLine.backgroundColor = [UIColor grayColor];
    [self.coverView addSubview:_bottomLine];
    
}

- (void)setupCJKTActionSheetIconAndTitleWithIcon:(NSString *)icon
                                    cellHeight:(CGFloat)height
{
    _height = height;
    _coverView.frame = CGRectMake(0, 0, kActionSheetScreenWidth, _height);
    
    CGFloat iconWidth = _height*0.4;
    
    self.iconImg = [[UIImageView alloc] initWithFrame:CGRectMake((kActionSheetScreenWidth-iconWidth)/2, _height*0.3, iconWidth, iconWidth)];
    _iconImg.image = [UIImage imageNamed:icon];
    [self.coverView addSubview:_iconImg];
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _height-0.5, kActionSheetScreenWidth, 0.5)];
    _bottomLine.backgroundColor = [UIColor grayColor];
    [self.coverView addSubview:_bottomLine];
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
@end
