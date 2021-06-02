//
//  YYLabelDemo.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/6/2.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "YYLabelDemo.h"

@interface YYLabelDemo ()

@end

@implementation YYLabelDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *text  = @"登录注册即表示同意《用户注册协议》";
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{
        NSFontAttributeName:[UIFont systemFontOfSize:12],
        NSForegroundColorAttributeName:[UIColor grayColor],
    }];
    
    NSRange range = [text rangeOfString:@"《用户注册协议》"];
    [attr setTextHighlightRange:range color:[UIColor redColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        CJKTLog(@"点击");
    }];
    YYLabel *yylab = [[YYLabel alloc] init];
    [self.view addSubview:yylab];
    [yylab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(250);
        make.top.mas_equalTo(380);
        make.leading.mas_equalTo(50);
    }];
    yylab.attributedText = attr;
    
    
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
