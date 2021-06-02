//
//  FFPopupDemo.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/6/2.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "FFPopupDemo.h"
#import "UIView+MMLayout.h"
#import "CJKTShareMenuView.h"
#import "CJKTActionSheet.h"
#import "CJKTAlert.h"
#import "YYCacheManager.h"
#import "ExternMethods.h"
@interface FFPopupDemo ()
<CJKTActionSheetDelegate>
@end

@implementation FFPopupDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn1 = [CJKTTool initUIButtonWithFrame:CGRectZero font:[UIFont systemFontOfSize:15] title:@"点击FFPopup" textColor:[UIColor whiteColor] backGround:[UIColor redColor] borderWidth:0 borderColor:[UIColor whiteColor] cornerRadius:0];
    [self.view addSubview:btn1];
    [btn1 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [self shownFFPopup];
//        [self ButtonClicked];
//        [self Button2Clicked];
//        [self btn3Clicked];
    }];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(100);
        make.leading.mas_equalTo(100);
    }];
    CJKTLog(@"状态栏高度 = %f",kStatusBarHeight());
    NSString *str = nil;
    CJKTLog(@" == %d",kStrIsEmpty(str));
    
}
- (void)shownFFPopup{
        FFPopup *popup = [FFPopup popupWithContentView:[self getView]];
        popup.showType = FFPopupShowType_GrowIn;
        popup.dismissType = FFPopupDismissType_GrowOut;
        popup.maskType = FFPopupMaskType_None;
        popup.shouldDismissOnBackgroundTouch = YES;
        popup.shouldDismissOnContentTouch = NO;
        FFPopupLayout layout = FFPopupLayoutMake(FFPopupHorizontalLayout_Center, FFPopupVerticalLayout_Center);
       [popup showWithLayout:layout duration: 0];
        
        FFPopup *popup2 = [FFPopup popupWithContentView:[self getView] showType:FFPopupShowType_BounceInFromBottom dismissType:FFPopupDismissType_SlideOutToBottom maskType:FFPopupMaskType_None dismissOnBackgroundTouch:YES dismissOnContentTouch:YES];
        FFPopupLayout layout2 = FFPopupLayoutMake(FFPopupHorizontalLayout_Center, FFPopupVerticalLayout_Bottom);
    //    [popup2 showWithLayout:layout2 duration: 0];
       
}
- (UIView *)getView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 300)];
    view.backgroundColor = [UIColor blueColor];
    return view;
}

-(void)ButtonClicked{
    [CJKTShareMenuView showShareMenuViewWithTitleArray:@[@"拍发票",@"看照片",@"拍发票",@"看照片"] imgNameArray:@[@"拍发票",@"看照片",@"拍发票",@"看照片"] completionHandler:^(CJKTSharePlatformType platformType) {
        CJKTLog(@"platformType = %ld",(long)platformType);
    }];
    
    
}
-(void)Button2Clicked{
    // 初始化 默认样式
    CJKTActionSheet *actionSheet = [[CJKTActionSheet alloc] initWithTitle:@"温馨提示" sheetTitles:@[@"sheet1",@"sheet2"] sheetIcons:@[] cancleBtnTitle:@"确定" sheetStyle:(CJKTActionSheetDefault) ];
    
    //
    //     文字+图标样式 要为actionSheet的iconArr属性赋值
    //    CJKTActionSheet *actionSheet = [[CJKTActionSheet alloc] initWithTitle:@"图标+标题" sheetTitles:@[@"sheet1",@"sheet2",@"sheet3"]  sheetIcons:@[@"test01",@"test02",@"test03"] cancleBtnTitle:@"取消" sheetStyle:(CJKTActionSheetIconAndTitle)];
    
    // 图标样式 要为actionSheet的iconArr属性赋值
    //        CJKTActionSheet *actionSheet = [[CJKTActionSheet alloc] initWithTitle:@"图标" sheetTitles:@[] sheetIcons:@[@"test01",@"test02",@"test03"] cancleBtnTitle:@"取消" sheetStyle:(CJKTActionSheetIcon) ];
    
    //    Block
    //    actionSheet.ActionSheetClickBlock = ^(NSInteger actionSheetIndex) {
    //         NSLog(@"Block点击了sheet%ld",actionSheetIndex+1);
    //    };
    //
    //    actionSheet.ActionSheetCancelClickBlock = ^{
    //
    //        NSLog(@"点击");;
    //    };
    
    actionSheet.delegate = self;
    
    [actionSheet show];
}
-(void)btn3Clicked{
    //CJKTAlert 自定义
    CJKTAlert *alert = [[CJKTAlert alloc] initWithTitle:@"重大新闻" message:@"上海港货物吞吐量和集装箱吞吐量均居世界第一，设有中国大陆首个自贸区中国（上海）自由贸易试验区。上海市与安徽、江苏、浙江共同构成了长江三角洲城市群，是世界六大城市群之一。" messageAlignment:NSTextAlignmentCenter Item:@[@"取消",@"确定"]  selectBlock:^(NSInteger index) {
        CJKTLog(@"index->%ld",index);
    }];
    
    [alert messageLabelTextColorWith:NSMakeRange(3, 5) andColor:[UIColor redColor]];
    alert.itemTitleColorArr = @[[UIColor grayColor],[UIColor greenColor]];;
    //    alert.showType = CJKTAlertShowType_ShrinkIn;
    //    alert.dismissType = CJKTAlertDismissType_ShrinkOut;
    
    [alert show];
    
}

#pragma mark -- CJKTActionSheetDelegate
- (void)actionSheet:(CJKTActionSheet *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex{
    CJKTLog(@"delegate点击了sheet%ld",(long)buttonIndex+1);
}

- (void)actionSheetCancle:(CJKTActionSheet *)actionSheet{
    
    CJKTLog(@"点击取消");
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
