//
//  QYHomeViewController.m
//  CarPooling
//
//  Created by Dxc_iOS on 2018/5/14.
//  Copyright © 2018年 代星创. All rights reserved.
//

#import "QYHomeViewController.h"
#import <YYKit/YYKit.h>
extern CFAbsoluteTime StartTime;
@interface QYHomeViewController ()
@property (nonatomic, copy) NSArray<NSString *> *weathers;
@end

@implementation QYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 
    NSString * msg=@"苹果发布了没有太多更新的 iOS 13 beta 8；一次编码、到处运行；SwiftUI 的两个特性；如何让网站加载更快,苹果发布了没有太多更新的 iOS 13 beta 8；一次编码、到处运行；SwiftUI 的两个特性；如何让网站加载更快苹果发布了没有太多更新的 iOS 13 beta 8；一次编码、到处运行；SwiftUI 的两个特性；如何让网站加载更快";
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:msg];
    
   
    //    高亮
    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setColor:[UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000]];
    [one setTextHighlight:highlight range:one.rangeOfAll];
    
    
    YYLabel *label = [YYLabel new];
    label.font = [UIFont systemFontOfSize:16];
    label.text = msg;
//    label.attributedText = one;
    label.textAlignment = NSTextAlignmentCenter;
    label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.textContainerInset = UIEdgeInsetsMake(5, 10, 5, 10);
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor colorWithWhite:0.933 alpha:1.000];
    label.top = 100;
    label.width = self.view.width;
//   根据文字 计算高度
    label.height = [msg heightForFont:label.font width:label.width] + 2 * 10;
     NSLog(@"label.height=%f",label.height);
    [self.view addSubview:label];
    

//    点击事件
    label.textTapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
          NSLog(@"点击lab");
    };
//    label.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//         NSLog(@"点击lab");
//    };
    
   
    
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
