//
//  CJKTPopMenuView.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/5/17.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "CJKTPopMenuView.h"

@interface CJKTPopMenuView()
<UITableViewDelegate, UITableViewDataSource,
UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation CJKTPopMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setupViews];
    }
    return self;
}

- (void)setData:(NSMutableArray *)data
{
    _data = data;
    [_tableView reloadData];
}

- (void)showInWindow:(UIWindow *)window
{
    [window addSubview:self];
    __weak typeof(self) ws = self;
    self.alpha = 0;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.alpha = 1;
    } completion:nil];
}

- (void)setupViews
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    self.backgroundColor = PopView_Background_Color;
    CGSize arrowSize = PopView_Arrow_Size;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + arrowSize.height, self.frame.size.width, self.frame.size.height - arrowSize.height)];
    _tableView.layer.cornerRadius = 6;
    _tableView.layer.masksToBounds = YES;
    self.frame = [UIScreen mainScreen].bounds;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.scrollEnabled = NO;
    [self addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TPopCell getHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPopCell *cell = [tableView dequeueReusableCellWithIdentifier:PopCell_ReuseId];
    if(!cell){
        cell = [[TPopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PopCell_ReuseId];
    }
    [cell setData:_data[indexPath.row]];
    if(indexPath.row == _data.count - 1){
        cell.separatorInset = UIEdgeInsetsMake(0, self.bounds.size.width, 0, 0);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(_delegate && [_delegate respondsToSelector:@selector(popView:didSelectRowAtIndex:)]){
        [_delegate popView:self didSelectRowAtIndex:indexPath.row];
    }
    [self hide];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor whiteColor] set];

    CGSize arrowSize = PopView_Arrow_Size;
    UIBezierPath *arrowPath = [[UIBezierPath alloc] init];
    [arrowPath moveToPoint:_arrowPoint];
    [arrowPath addLineToPoint:CGPointMake(_arrowPoint.x + arrowSize.width * 0.5, _arrowPoint.y + arrowSize.height)];
    [arrowPath addLineToPoint:CGPointMake(_arrowPoint.x - arrowSize.width * 0.5, _arrowPoint.y + arrowSize.height)];
    [arrowPath closePath];
    [arrowPath fill];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]){
        return NO;
     }
    return YES;
}

- (void)onTap:(UIGestureRecognizer *)recognizer
{
    [self hide];
}

- (void)hide
{
    __weak typeof(self) ws = self;
    self.alpha = 1;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        ws.alpha = 0;
    } completion:^(BOOL finished) {
        if([ws superview]){
            [ws removeFromSuperview];
        }
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



@implementation TPopCellData
@end

@implementation TPopCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.backgroundColor = [UIColor clearColor];

    CGFloat headHeight = PopCell_Height - 2 * PopCell_Padding;
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(PopCell_Padding, PopCell_Padding, headHeight, headHeight)];
    _image.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_image];

    CGFloat titleWidth = self.frame.size.width - 2 * PopCell_Padding - PopCell_Margin - _image.frame.size.width;
    _title = [[UILabel alloc] initWithFrame:CGRectMake(_image.frame.origin.x + _image.frame.size.width + PopCell_Margin, PopCell_Padding, titleWidth, headHeight)];
    _title.font = [UIFont systemFontOfSize:15];
    _title.textColor = [UIColor blackColor];
    [self addSubview:_title];

    [self setSeparatorInset:UIEdgeInsetsMake(0, PopCell_Padding, 0, 0)];
}

- (void)setData:(TPopCellData *)data
{
    _image.image = [UIImage imageNamed:data.image];
    _title.text = data.title;
}

+ (CGFloat)getHeight
{
    return PopCell_Height;
}
@end
