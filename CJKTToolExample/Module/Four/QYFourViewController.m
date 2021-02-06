//
//  QYFourViewController.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/10.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "QYFourViewController.h"
#import "CJKTRecordView.h"
#import "MCAlertView.h"
#import "CJKTPopMenuView.h"
@interface QYFourViewController ()<CJKTPopMenuViewDelegate>
@property (nonatomic, strong) CJKTRecordView *recordView;
@property (nonatomic, strong) UILabel *label;
@end

@implementation QYFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.recordView  = [[CJKTRecordView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 220)];
//    self.recordView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.recordView];
//
   
    UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [moreButton setImage:[UIImage imageNamed:@"用户名"] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(rightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
    self.navigationItem.rightBarButtonItem = moreItem;
  

}

/**
 *对导航栏右侧的按钮（即视图右上角按钮）进行初始化，创建对应的popView
 */
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

/**
 *CJKTPopMenuViewDelegate
 */
- (void)popView:(CJKTPopMenuView *)popView didSelectRowAtIndex:(NSInteger)index
{
    CJKTLog(@"点击了%ld",index);
    
//    [KHelper showSVLoading];
//    [KHelper showSVSuccessToast:@"点击了"];
    [KHelper showSVErrorToast:@"cccccc"];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
