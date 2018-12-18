//
//  ViewController.m
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2018/11/28.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import "ViewController.h"
#import "CJKTShareMenuView.h"
#import "CJKTActionSheet.h"
#import "CJKTAlert.h"
#import "CJKTAgrementView.h"
@interface ViewController ()<CJKTActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 200, 40);
    [self.view addSubview:btn];
    [btn setTitle:@"分享" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(ButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(100, 250, 200, 40);
    [self.view addSubview:btn2];
    [btn2 setTitle:@"CJKTActionSheet" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(Button2Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(100, 300, 200, 40);
    [self.view addSubview:btn3];
    [btn3 setTitle:@"CJKTAlert" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btn3Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    CJKTAgrementView *myTextView = [[CJKTAgrementView alloc]initWithFrame:CGRectMake(10, 500, self.view.bounds.size.width - 20, 50)];
    myTextView.numClickEvent = 2;           // 有几个点击事件(只能设为1个或2个)
    myTextView.oneClickLeftBeginNum = 7;    // 第一个点击的起始坐标数字是几
    myTextView.oneTitleLength = 12;         // 第一个点击的文本长度是几
    myTextView.twoClickLeftBeginNum = 19;   // 第二个点击的起始坐标数字是几
    myTextView.twoTitleLength = 11;         // 第二个点击的文本长度是几
    myTextView.fontSize = 14;               // 可点击的字体大小
    // 设置了上面后要在最后设置内容
    myTextView.content = @"我已阅读并接受《XXXX注册服务协议》《XXXX风险提示书》";
    myTextView.agreeBtnClick = ^(UIButton *btn) {
        btn.selected = !btn.selected;
        if(btn.selected == YES){
            NSLog(@"左侧按钮选中状态为YES");
            
        }else{
            NSLog(@"左侧按钮选中状态为NO");
        }
    };
    myTextView.eventblock = ^(NSAttributedString *contentStr) {
        NSLog(@"点击了富文本--%@", contentStr.string);
    };
    [self.view addSubview:myTextView];
}
-(void)ButtonClicked{
//  ;@[@"拍发票",@"看照片",@"拍发票",@"看照片"]
    [CJKTShareMenuView showShareMenuViewWithTitleArray:@[@"拍发票",@"看照片",@"拍发票",@"看照片"] imgNameArray:@[@"拍发票",@"看照片",@"拍发票",@"看照片"] completionHandler:^(CJKTSharePlatformType platformType) {
        NSLog(@"platformType = %ld",(long)platformType);
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
        NSLog(@"index->%ld",index);
    }];
    
    [alert messageLabelTextColorWith:NSMakeRange(3, 5) andColor:[UIColor redColor]];
    alert.itemTitleColorArr = @[[UIColor grayColor],[UIColor greenColor]];;
    alert.showType = CJKTAlertShowType_SlideInFromRight;

    [alert show];

}

#pragma mark -- CJKTActionSheetDelegate
- (void)actionSheet:(CJKTActionSheet *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"delegate点击了sheet%ld",(long)buttonIndex+1);
}

- (void)actionSheetCancle:(CJKTActionSheet *)actionSheet{
    
    NSLog(@"点击取消");
}

   


@end
