//
//  CJKTActionSheet.m
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2018/11/28.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import "CJKTActionSheet.h"
#import "AlertHeader.h"
#import "CJKTActionSheet.h"
@interface CJKTActionSheet()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *sheetTableView;
@property (nonatomic,assign) CJKTActionSheetStyle actionsheetStyle;
@property (nonatomic,strong) NSArray *iconArr;
@property (nonatomic,strong) NSArray *sheetTitleArr;
@property (nonatomic,strong) UIButton *cancleBtn;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *footerView;
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
        [self setDefaultConfig];
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
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ksheetTableViewWidth, _titleHeight)];
        self.headerView.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ksheetTableViewWidth/2-100,0, 200, _cancleHeight)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.text = _sheetTitle;
        [self.headerView addSubview:self.titleLabel];
    }
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ksheetTableViewWidth, _cancleHeight)];
    footerView.backgroundColor = [UIColor whiteColor];
    self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
    self.cancleBtn.frame = CGRectMake(ksheetTableViewWidth/2-100,0, 200, _cancleHeight);
    [self.cancleBtn setTitle:_cancleTitle forState:(UIControlStateNormal)];
    [self.cancleBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.cancleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.cancleBtn setBackgroundColor:[UIColor whiteColor]];
    [self.cancleBtn addTarget:self action:@selector(actionSheetCancle:) forControlEvents:(UIControlEventTouchUpInside)];
    [footerView addSubview:self.cancleBtn];
    self.footerView = footerView;

    self.sheetTableView = [[UITableView alloc] init];
    self.sheetTableView.frame = CGRectMake(10, kActionSheetScreenHeight-CF_TabbarSafeBottomMargin, ksheetTableViewWidth, _tableHeight);
    self.sheetTableView.backgroundColor = [UIColor clearColor];
    self.sheetTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.sheetTableView.delegate = self;
    self.sheetTableView.dataSource = self;
    self.sheetTableView.scrollEnabled = NO;
    self.sheetTableView.showsVerticalScrollIndicator = NO;
    self.sheetTableView.tableHeaderView = self.headerView;
    self.sheetTableView.tableFooterView = footerView;
    [self addSubview:self.sheetTableView];
//    self.sheetTableView.backgroundColor = [UIColor cyanColor];
}


- (void)setDefaultConfig{
    _titleColor = [UIColor blackColor];
    _titlebgColor = [UIColor whiteColor];
    
    _subtitlebgColor = [UIColor whiteColor];
    _subtitleColor =  [UIColor blackColor];
    _subtitleFont = [UIFont systemFontOfSize:15];
    
    _canclebgColor = [UIColor whiteColor];
    
    _isCorner = NO;
}

#pragma mark -- set

- (void)setIsCorner:(BOOL)isCorner {
    _isCorner = isCorner;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_headerView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CORNER, CORNER)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _headerView.bounds;
    maskLayer.path = maskPath.CGPath;
    _headerView.layer.mask = maskLayer;
    
}
//标题
-(void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    _titleLabel.font  = titleFont;;
}
//ActionItem
- (void)setSubtitleColor:(UIColor *)subtitleColor {
    _subtitleColor = subtitleColor;
}

- (void)setSubtitleFont:(UIFont *)subtitleFont {
    _subtitleFont = subtitleFont;
}
- (void)setSubtitlebgColor:(UIColor *)subtitlebgColor {
    _subtitlebgColor = subtitlebgColor;
}
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
}


//取消按钮

- (void)setCanclebgColor:(UIColor *)canclebgColor {
    _canclebgColor  = canclebgColor;
    _cancleBtn.backgroundColor = canclebgColor;
}
- (void)setCancleHeight:(CGFloat)cancleHeight {
    _cancleHeight  = cancleHeight;
    _cancleBtn.height = cancleHeight;
}



#pragma mark -- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sheetTitleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"sheetCell";
    CJKTActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CJKTActionSheetCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    if (_actionsheetStyle == CJKTActionSheetDefault) {//标题

        [cell setupCJKTActionSheetDefaultCellWithTitle:_sheetTitleArr[indexPath.row] titleFont:_subtitleFont titleColor:_subtitleColor cellHeight:_cellHeight bgColor:_subtitlebgColor];
    }else if (_actionsheetStyle == CJKTActionSheetIconAndTitle){//图片+标题
        [cell setupCJKTActionSheetIconAndTitleWithTitle:_sheetTitleArr[indexPath.row] titleFont:_subtitleFont titleColor:_subtitleColor icon:_iconArr[indexPath.row] cellHeight:_cellHeight];
    }else if (_actionsheetStyle == CJKTActionSheetIcon){//图片
        [cell setupCJKTActionSheetIconAndTitleWithIcon:_iconArr[indexPath.row] cellHeight:_cellHeight];
    }
    
    if (self.isCorner) {
        UIBezierPath *maskPath;
//        if (indexPath.row == 0) {
//            maskPath = [UIBezierPath bezierPathWithRoundedRect:cell.coverView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(CORNER, CORNER)];
//            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//            maskLayer.frame = cell.bounds;
//            maskLayer.path = maskPath.CGPath;
//            cell.layer.mask = maskLayer;
//        } else
        if (indexPath.row == self.sheetTitleArr.count-1){
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
    headerView.backgroundColor = kLineColor;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kActionSheetScreenWidth, SECTIONHEIGHT)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return SECTIONHEIGHT+2;
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
        
        self.sheetTableView.transform = CGAffineTransformMakeTranslation(0,  -self->_tableHeight);
    }];
    
    
}

#pragma mark --隐藏
- (void)dissmiss{
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        self.sheetTableView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
   
}

// 点击阴影部分是让视图消失
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view] != self.sheetTableView) {
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

- (void)setupCJKTActionSheetDefaultCellWithTitle:(NSString *)title
                                       titleFont:(UIFont *)titleFont
                                      titleColor:(UIColor *)titleColor
                                      cellHeight:(CGFloat)height
                                      bgColor:(UIColor *)bgColor
{
    _height = height;
    _coverView.frame = CGRectMake(0, 0, ksheetTableViewWidth, _height);
    
    self.titleLab = [[UILabel alloc] init];
    _titleLab.frame = CGRectMake(0, 0, ksheetTableViewWidth, _height);
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.text = title;
    _titleLab.font = titleFont;
    _titleLab.textColor = titleColor;
    _titleLab.backgroundColor = bgColor;
    [self.coverView addSubview:_titleLab];
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _height-0.5, kActionSheetScreenWidth-20, 0.5)];
    _bottomLine.backgroundColor = kLineColor;
    [self.coverView addSubview:_bottomLine];
    
}
- (void)setupCJKTActionSheetIconAndTitleWithTitle:(NSString *)title
                                        titleFont:(UIFont *)font
                                       titleColor:(UIColor *)titleColor
                                             icon:(NSString *)icon
                                       cellHeight:(CGFloat)height
{
    _height = height;
    _coverView.frame = CGRectMake(0, 0, ksheetTableViewWidth, _height);
    
    NSDictionary *attrs = @{NSFontAttributeName:font};
    CGSize size = [title sizeWithAttributes:attrs];
    CGFloat titleWidth = size.width+10;
    
    self.titleLab = [[UILabel alloc] init];
    _titleLab.frame = CGRectMake((ksheetTableViewWidth-titleWidth)/2, 0, titleWidth, _height);
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.text = title;
     _titleLab.textColor = titleColor;
    [self.coverView addSubview:_titleLab];
    
    CGFloat iconWidth = _height*0.4;
    self.iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLab.frame)-iconWidth-10, _height*0.3, iconWidth, iconWidth)];
    _iconImg.image = [UIImage imageNamed:icon];
    [self.coverView addSubview:_iconImg];
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _height-0.5, ksheetTableViewWidth, 0.5)];
    _bottomLine.backgroundColor = kLineColor;
    [self.coverView addSubview:_bottomLine];
    
}

- (void)setupCJKTActionSheetIconAndTitleWithIcon:(NSString *)icon
                                    cellHeight:(CGFloat)height
{
    _height = height;
    _coverView.frame = CGRectMake(0, 0, ksheetTableViewWidth, _height);
    
    CGFloat iconWidth = _height*0.4;
    
    self.iconImg = [[UIImageView alloc] initWithFrame:CGRectMake((ksheetTableViewWidth-iconWidth)/2, _height*0.3, iconWidth, iconWidth)];
    _iconImg.image = [UIImage imageNamed:icon];
    [self.coverView addSubview:_iconImg];
    
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _height-0.5, ksheetTableViewWidth, 0.5)];
    _bottomLine.backgroundColor = kLineColor;
    [self.coverView addSubview:_bottomLine];
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
@end
