//
//  ActionSheetDemo.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/6/4.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "ActionSheetDemo.h"
#import "CJKTActionSheet.h"
@interface ActionSheetDemo ()

@end

@implementation ActionSheetDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [CJKTTool initUIButtonWithFrame:CGRectMake(40, 100, 100, 44) font:[UIFont systemFontOfSize:15] title:@"保存" textColor:[UIColor blackColor] backGround:[UIColor cyanColor] borderWidth:0 borderColor:[UIColor clearColor] cornerRadius:0];
    [self.view addSubview:btn];
    [btn addBlockEvents:UIControlEventTouchUpInside action:^(id sender) {
        [self showActionSheet];
    }];
}

- (void)showActionSheet {
    // 文字
//    CJKTActionSheet *actionSheet = [[CJKTActionSheet alloc] initWithTitle:@"标题" sheetTitles:@[@"sheet1",@"sheet2"] sheetIcons:@[] cancleBtnTitle:@"取消" sheetStyle:(CJKTActionSheetDefault)];
//    actionSheet.isCorner = YES;
//    actionSheet.titleColor = [UIColor redColor];

    //文字+图标样式
            CJKTActionSheet *actionSheet = [[CJKTActionSheet alloc] initWithTitle:@"图标+标题" sheetTitles:@[@"sheet1",@"sheet2",@"sheet3"]  sheetIcons:@[@"test01",@"test02",@"test03"] cancleBtnTitle:@"取消" sheetStyle:(CJKTActionSheetIconAndTitle)];
    
//     图标样式
//                CJKTActionSheet *actionSheet = [[CJKTActionSheet alloc] initWithTitle:@"图标" sheetTitles:@[] sheetIcons:@[@"test01",@"test02",@"test03"] cancleBtnTitle:@"取消" sheetStyle:(CJKTActionSheetIcon) ];
    
    actionSheet.ActionSheetClickBlock = ^(NSInteger actionSheetIndex) {
        NSLog(@"Block点击了sheet%ld",actionSheetIndex+1);
    };
    
    actionSheet.ActionSheetCancelClickBlock = ^{
        
        NSLog(@"点击");;
    };

    [actionSheet show];
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
