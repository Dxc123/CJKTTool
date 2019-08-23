//
//  SecondViewController.m
//  QYBaseProject
//
//  Created by Dxc_iOS on 2018/7/18.
//  Copyright © 2018年 代星创. All rights reserved.
//

#import "QYSecondViewController.h"


#define RedColor [UIColor redColor]
#define BlueColor [UIColor blueColor]
#define BlackColor [UIColor blackColor]

#define SFONT(a) [UIFont systemFontOfSize:a]

#import "CJKTTool.h"
#import "CJKTShareMenuView.h"
#import "CJKTActionSheet.h"
#import "CJKTAlert.h"
#import "CJKTAgrementView.h"
#import "TestViewController.h"
#import <Masonry/Masonry.h>
@interface QYSecondViewController ()<CJKTActionSheetDelegate>

@end

@implementation QYSecondViewController

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
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(100, 400, 200, 40);
    [self.view addSubview:btn3];
    [btn4 setTitle:@"CJKTAlert" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(btn4Clicked) forControlEvents:UIControlEventTouchUpInside];
    
    //1.  Masonry适配 UILabel的自动换行 无需设置高度约束
    UILabel *lab = [[UILabel alloc] init];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    lab.text = @"UILabel *lab = [[UILabel alloc] init];";
    lab.textColor =  [UIColor redColor];
    
    lab.numberOfLines = 0;//设置换行
    lab.preferredMaxLayoutWidth = 250;//给一个maxWidth
    [lab setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];//设置huggingPriority
    
    
    // 2.   UILabel的自动换行
    UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-60, 150)];
    lab2.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0 alpha:0.3f];  // 偏“黄色”
    lab2.text = @"abcdefghijklmnopqrstuvwxyz_abcdefghijklmnopqrstuvwxyz_abcdefghijklmnopqrstuvwxyz_abcdefghijklmnopqrstuvwxyz_abcdefghijklmnopqrstuvwxyz";
    // 自动换行
    lab2.numberOfLines = 0;  //必须设置为0行，才会自动换行
    lab2.lineBreakMode = NSLineBreakByCharWrapping;  //结尾时，按“字符”换行
    [self.view addSubview:lab2];
    
    
    //    3.使用NSstirng分类计算
    
    
    
    
    
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
    
    
    //        跳转QQ聊天界面
    BOOL isCanOpen = [CJKTTool openOtherAppWithOpenType:OpenTypeQQ];
    if (isCanOpen == YES) {
        NSLog(@"跳转QQ");
        
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",@"1462711230"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
        [self.view addSubview:webView];
    }else{
        NSLog(@"");
        
    }
    
    NSArray *buleNumArr = @[@"1",@"2",@"5",@"6"];
    NSArray *kaiBuleNumArr = @[@"2",@"3",@"6"];
    
    for (int y = 0 ; y<buleNumArr.count; y++) {
        
        for (int z = 0 ; z< kaiBuleNumArr.count; z++) {
            if (buleNumArr[y] == kaiBuleNumArr[z]) {
                NSLog(@"buleNumArr[y]= %@",buleNumArr[y]);
                
            }
            
        }
        
    }
    
    //    运用正则的API得出两个数组中相同与不同的数据
    //    1 查找相同的数据
    NSArray * arr2 = @[@4,@3,@2,@1];
    NSArray * arr1 = @[@2,@3,@4,@5];
    NSPredicate * filterPredicate_same = [NSPredicate predicateWithFormat:@"SELF IN %@",arr1];
    NSArray * filter_no = [arr2 filteredArrayUsingPredicate:filterPredicate_same];
    NSLog(@"%@",filter_no);
    
    //    2 查找不同的数据
    
    //    NSArray * arr2 = @[@4,@3,@2,@1];
    //    NSArray * arr1 = @[@2,@3,@4,@5];
    //    //找到在arr2中不在数组arr1中的数据
    //    NSPredicate * filterPredicate1 = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",arr1];
    //    NSArray * filter1 = [arr2 filteredArrayUsingPredicate:filterPredicate1];
    //    //找到在arr1中不在数组arr2中的数据
    //    NSPredicate * filterPredicate2 = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",arr2];
    //    NSArray * filter2 = [arr1 filteredArrayUsingPredicate:filterPredicate2];
    //    //拼接数组
    //    NSMutableArray *array = [NSMutableArray arrayWithArray:filter1];
    //    [array addObjectsFromArray:filter2];
    //    NSLog(@"%@",array);
    //
    //
    NSString *stttr = @"10%";
    NSLog(@"[stttr integerValue] = %ld" ,(long)[stttr integerValue]);
    NSString *tempStr = [NSString stringWithFormat:@"%ld%%" ,100- [stttr integerValue] ];
    NSLog(@"tempStr = %@" ,tempStr);
    
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
    //    alert.showType = CJKTAlertShowType_ShrinkIn;
    //    alert.dismissType = CJKTAlertDismissType_ShrinkOut;
    
    [alert show];
    
}

-(void)btn4Clicked{
    [self.navigationController pushViewController:[TestViewController new] animated:YES];
}

#pragma mark -- CJKTActionSheetDelegate
- (void)actionSheet:(CJKTActionSheet *)actionSheet clickButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"delegate点击了sheet%ld",(long)buttonIndex+1);
}

- (void)actionSheetCancle:(CJKTActionSheet *)actionSheet{
    
    NSLog(@"点击取消");
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
