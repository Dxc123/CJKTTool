//
//  CJKTPopMenuView.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/5/17.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//pop view
#define PopView_Arrow_Size CGSizeMake(15, 10)
#define PopView_Background_Color RGBA(188, 188, 188, 0.5)
//pop cell
#define PopCell_ReuseId @"TPopCell"
#define PopCell_Height 45
#define PopCell_Margin 18
#define PopCell_Padding 12

@class CJKTPopMenuView;
@protocol CJKTPopMenuViewDelegate <NSObject>
- (void)popView:(CJKTPopMenuView *)popView didSelectRowAtIndex:(NSInteger)index;
@end

@interface CJKTPopMenuView : UIView
@property (nonatomic, strong) UITableView *tableView;
/**
 箭头的位置
 */
@property (nonatomic, assign) CGPoint arrowPoint;
@property (nonatomic, weak) id<CJKTPopMenuViewDelegate> delegate;
/**
 设置数据源
 */
- (void)setData:(NSMutableArray *)data;
/**
 显示
 */
- (void)showInWindow:(UIWindow *)window;
@end


@interface TPopCellData : NSObject
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *title;
@end

@interface TPopCell : UITableViewCell
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *title;
/**
 cell高度
 */
+ (CGFloat)getHeight;
- (void)setData:(TPopCellData *)data;
@end
NS_ASSUME_NONNULL_END


/**
 示例：
//对导航栏右侧的按钮（即视图右上角按钮）进行初始化，创建对应的popView
- (void)rightBarButtonClick:(UIButton *)rightBarButton
{
    NSMutableArray *menus = [NSMutableArray array];
    TPopCellData *friend = [[TPopCellData alloc] init];
    friend.image = @"微博";
    friend.title = @"微博";
    [menus addObject:friend];

    TPopCellData *group3 = [[TPopCellData alloc] init];
    group3.image = @"微博";
    group3.title = @"微博";
    [menus addObject:group3];

    CGFloat height = [TPopCell getHeight] * menus.count + PopView_Arrow_Size.height;
    CGFloat orginY = CF_NavHeight;
    CJKTPopMenuView *popView = [[CJKTPopMenuView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 145, orginY, 135, height)];
    CGRect frameInNaviView = [self.navigationController.view convertRect:rightBarButton.frame fromView:rightBarButton.superview];
    popView.arrowPoint = CGPointMake(frameInNaviView.origin.x + frameInNaviView.size.width * 0.5, orginY);
    popView.delegate = self;
    [popView setData:menus];
    [popView showInWindow:self.view.window];
}

*/
