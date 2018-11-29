//
//  CJKTActionSheet.m
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2018/11/28.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import "CJKTActionSheet.h"
// 默认设置
#define CORNER 15 //圆角大小
#define SHEETHEIGHT 50
#define CANCLEHEIGHT 50
#define TITLEHEIGHT 50
#define SECTIONHEIGHT 5
#define kActionSheetScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kActionSheetScreenHeight ([UIScreen mainScreen].bounds.size.height)

#import "CJKTActionSheet.h"

@interface CJKTActionSheet()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *sheetTable;
@property (nonatomic,assign) CJKTActionSheetStyle actionsheetStyle;
@property (nonatomic,strong) NSArray *iconArr;
@property (nonatomic,strong) NSArray *sheetTitleArr;
@property (nonatomic,strong) UIButton *cancleBtn;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation CJKTActionSheet
{
    NSString *_sheetTitle;
    NSString *_cancleTitle;
    CGFloat _tableHeight;
    CGFloat _cellHeight;
    CGFloat _titleHeight;
    CGFloat _cancleHeight;
   
}

- (instancetype)initWithTitle:(NSString *)title
                  sheetTitles:(NSArray *)sheetTitles
                   sheetIcons:(NSArray *)sheetIcons
               cancleBtnTitle:(NSString *)cancleBtnTitle
                   sheetStyle:(CJKTActionSheetStyle)sheetStyle{
    
    if (self = [super init]) {
        
        self.frame = CGRectMake(0, 0, kActionSheetScreenWidth, kActionSheetScreenHeight);
        
        _actionsheetStyle = sheetStyle;
        _sheetTitle = title;
        _cancleTitle = cancleBtnTitle;
        _sheetTitleArr = sheetTitles;
        self.iconArr = sheetIcons;
        self.sheetTitleArr = sheetTitles;

        [self setupView]; //创建视图
        [self setSheetProperty]; //设置自定义属性
        [self show];
    }
    return self;
}

- (void)setupView{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    _cellHeight = (_sheetHeight)?_sheetHeight:SHEETHEIGHT;
    _titleHeight = (_titleHeight)?_titleHeight:TITLEHEIGHT;
    _cancleHeight = (_cancleHeight)?_cancleHeight:CANCLEHEIGHT;
    _tableHeight = (_sheetTitle.length == 0)?(self.sheetTitleArr.count*_cellHeight + _cancleHeight + SECTIONHEIGHT):((self.sheetTitleArr.count)*_cellHeight + _titleHeight + _cancleHeight + SECTIONHEIGHT*2);
    
    if (_sheetTitle.length != 0) {
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kActionSheetScreenWidth, _titleHeight)];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kActionSheetScreenWidth, _titleHeight)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.text = _sheetTitle;
        [self.headerView addSubview:self.titleLabel];
    }
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kActionSheetScreenWidth, _cancleHeight)];
    self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    self.cancleBtn.frame = CGRectMake(0, 0, kActionSheetScreenWidth, _cancleHeight);
    [self.cancleBtn setTitle:_cancleTitle forState:(UIControlStateNormal)];
    [self.cancleBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.cancleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.cancleBtn setBackgroundColor:[UIColor whiteColor]];
    [self.cancleBtn addTarget:self action:@selector(actionSheetCancle:) forControlEvents:(UIControlEventTouchUpInside)];
    [footerView addSubview:self.cancleBtn];
    
    self.sheetTable = [[UITableView alloc] init];
    self.sheetTable.frame = CGRectMake(0, kActionSheetScreenHeight, kActionSheetScreenWidth, _tableHeight);
    self.sheetTable.backgroundColor = [UIColor clearColor];
    self.sheetTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.sheetTable.delegate = self;
    self.sheetTable.dataSource = self;
    self.sheetTable.scrollEnabled = NO;
    self.sheetTable.tableHeaderView = self.headerView;
    self.sheetTable.tableFooterView = footerView;
    [self addSubview:self.sheetTable];
}


- (void)setSheetProperty{
    
    if (self.titleColor) {
        self.titleLabel.textColor = self.titleColor;
    }
    if (self.titleFont) {
        self.titleLabel.font = self.titleFont;
    }
    if (self.titlebgColor) {
        self.titleLabel.backgroundColor = self.titlebgColor;
    }
    if (self.canclebgColor) {
        [self.cancleBtn setBackgroundColor:self.canclebgColor];
    }
    if (self.isCorner) {
        self.titleLabel.layer.cornerRadius = CORNER;
        self.titleLabel.layer.masksToBounds = YES;
        self.cancleBtn.layer.cornerRadius = CORNER;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sheetTitleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"sheetCell";
    CJKTActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CJKTActionSheetCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    if (_actionsheetStyle == CJKTActionSheetDefault) {
        [cell setupCJKTActionSheetDefaultCellWithTitle:_sheetTitleArr[indexPath.row] CellHeight:_cellHeight];
    }else if (_actionsheetStyle == CJKTActionSheetIconAndTitle){
        UIFont *font = _subtitleFont?_subtitleFont:[UIFont systemFontOfSize:17];
        [cell setupCJKTActionSheetIconAndTitleWithTitle:_sheetTitleArr[indexPath.row] titleFont:font icon:_iconArr[indexPath.row] cellHeight:_cellHeight];
    }else if (_actionsheetStyle == CJKTActionSheetIcon){
        [cell setupCJKTActionSheetIconAndTitleWithIcon:_iconArr[indexPath.row] cellHeight:_cellHeight];
    }
    
    if (self.subtitleColor) {
        cell.titleLab.textColor = self.subtitleColor;
    }
    if (self.subtitleFont) {
        cell.titleLab.font = self.subtitleFont;
    }
    if (self.subtitlebgColor) {
        cell.coverView.backgroundColor = self.subtitlebgColor;
    }
    if (self.lineColor) {
        cell.bottomLine.backgroundColor = self.lineColor;
    }
    if (self.isCorner) {
        UIBezierPath *maskPath;
        if (indexPath.row == 0) {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.coverView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CORNER, CORNER)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cell.bounds;
            maskLayer.path = maskPath.CGPath;
            cell.layer.mask = maskLayer;
        }else if (indexPath.row == self.sheetTitleArr.count-1){
            maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.coverView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(CORNER, CORNER)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cell.bounds;
            maskLayer.path = maskPath.CGPath;
            cell.layer.mask = maskLayer;
        }
        
    }
    if (indexPath.row == self.sheetTitleArr.count-1) {
        cell.bottomLine.hidden = YES;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (_sheetTitle.length != 0) {
        return 1;//SECTIONHEIGHT;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kActionSheetScreenWidth, 1)];//SECTIONHEIGHT
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kActionSheetScreenWidth, SECTIONHEIGHT)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SECTIONHEIGHT;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self actionSheet:self clickButtonAtIndex:indexPath.row];
}

#pragma mark CJKTActionSheetDelegate 和 Blcok
- (void)actionSheet:(CJKTActionSheet *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex{
    //    代理方法
    if ( !_delegate||[self.delegate respondsToSelector:@selector(actionSheet:clickButtonAtIndex:)]) {
        
        [self.delegate actionSheet:self clickButtonAtIndex:buttonIndex];
    }
    //  Blcok方法
    if (self.ActionSheetClickBlock) {
        
        self.ActionSheetClickBlock(buttonIndex);
    }
    
    [self dissmiss];
    
}
- (void)actionSheetCancle:(CJKTActionSheet *)actionSheet{
    //    代理方法
    if ( !_delegate|| [self.delegate respondsToSelector:@selector(actionSheetCancle:)]) {
        [self.delegate actionSheetCancle:self];
    }
    //  Blcok方法
    if (self.ActionSheetCancelClickBlock) {
        
        self.ActionSheetCancelClickBlock();
    }
    [self dissmiss];
}

#pragma mark -- 显示
- (void)show{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        
        self.sheetTable.transform = CGAffineTransformMakeTranslation(0,  -self->_tableHeight);
    }];
    
    
}

#pragma mark --隐藏
- (void)dissmiss{
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        self.sheetTable.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
   
}

// 点击阴影部分是让视图消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] != self.sheetTable) {
        [self dissmiss];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
