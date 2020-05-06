//
//  CJKTAgrementView.h
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2018/11/28.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^eventBlock)(NSAttributedString *contentStr);
typedef void(^leftAgreeBtnBlock)(UIButton *btn);

@interface CJKTAgrementView : UIView <UITextViewDelegate>

@property (nonatomic, strong)UIButton *leftAgreeBtn;            // 左侧同意按钮
@property (nonatomic, strong)UITextView *myTextView;
@property (nonatomic, assign)int numClickEvent;                 // 内容里面有几个点击事件
@property (nonatomic, assign)int fontSize;                      // 可点击的字体大小
@property (nonatomic, assign)int oneClickLeftBeginNum;          // 第一个点击的起点
@property (nonatomic, assign)int oneTitleLength;                // 第一个点击长度
@property (nonatomic, assign)int twoClickLeftBeginNum;          // 第二个点击的起点
@property (nonatomic, assign)int twoTitleLength;                // 第二个点击长度
@property (nonatomic, strong)NSString *content;                 // 内容
@property (nonatomic, strong)eventBlock eventblock;             // 内容点击事件
@property (nonatomic, strong)leftAgreeBtnBlock agreeBtnClick;   // 左侧按钮点击事件



/**
 示例：
 CJKTAgrementView *myTextView = [[CJKTAgrementView alloc]initWithFrame:CGRectMake(10, 300, self.view.bounds.size.width - 20, 50)];
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
 
 */
@end

NS_ASSUME_NONNULL_END
