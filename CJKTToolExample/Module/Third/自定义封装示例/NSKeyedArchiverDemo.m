//
//  NSKeyedArchiverDemo.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/6/3.
//  Copyright © 2020 CJKT. All rights reserved.
//

/**
 model 储存与取值
 */
#import "NSKeyedArchiverDemo.h"
#import "CJKTUserModel.h"
@interface NSKeyedArchiverDemo ()

@end

@implementation NSKeyedArchiverDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CJKTUserModel * model = [[CJKTUserModel alloc] init];
    model.nick_name = @"二年级三班";
    model.user_id = 100;
    
    
    UIButton *btn = [CJKTTool initUIButtonWithFrame:CGRectMake(40, 100, 100, 44) font:[UIFont systemFontOfSize:15] title:@"保存" textColor:[UIColor blackColor] backGround:[UIColor cyanColor] borderWidth:0 borderColor:[UIColor clearColor] cornerRadius:0];
    [self.view addSubview:btn];
//    [btn addBlockEvents:UIControlEventTouchUpInside action:^(id sender) {
//        CJKTLog(@"保存");
//        [model saveToLocal];
//    }];
    [btn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        CJKTLog(@"保存");
       [model saveToLocal];
    }];
    UIButton *btn2 = [CJKTTool initUIButtonWithFrame:CGRectMake(40, 200, 100, 44) font:[UIFont systemFontOfSize:15] title:@"取值" textColor:[UIColor blackColor] backGround:[UIColor cyanColor] borderWidth:0 borderColor:[UIColor clearColor] cornerRadius:0];
    [self.view addSubview:btn2];
    [btn2 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        CJKTLog(@"取值");
        CJKTUserModel * result =  [CJKTUserModel getFromLocal];
        NSLog(@"nick_name = %@",result.nick_name);
    }];
    
    UIButton *btn3 = [CJKTTool initUIButtonWithFrame:CGRectMake(40, 300, 100, 44) font:[UIFont systemFontOfSize:15] title:@"清空" textColor:[UIColor blackColor] backGround:[UIColor cyanColor] borderWidth:0 borderColor:[UIColor clearColor] cornerRadius:0];
    [self.view addSubview:btn3];
    [btn3 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        CJKTLog(@"清空");
               [CJKTUserModel deleteAllData];
    }];
    
    UIButton *btn4 = [CJKTTool initUIButtonWithFrame:CGRectMake(40, 400, 100, 44) font:[UIFont systemFontOfSize:15] title:@"渐变色" textColor:[UIColor blackColor] backGround:[UIColor cyanColor] borderWidth:0 borderColor:[UIColor clearColor] cornerRadius:0];
    [self.view addSubview:btn4];
    UIColor *topleftColor = [UIColor colorWithRed:48/255.0f green:127/255.0f blue:202/255.0f alpha:1.0f];
    UIColor *bottomrightColor = [UIColor colorWithRed:35/255.0f green:195/255.0f blue:95/255.0f alpha:1.0f];
    UIImage *bgImg = [UIImage cjkt_gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeLeftToRight imgSize:btn4.size];
    btn4.backgroundColor = [UIColor colorWithPatternImage:bgImg];
    
    
    
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
