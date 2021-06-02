//
//  QYDemoViewController.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2021/2/16.
//  Copyright © 2021 CJKT. All rights reserved.
//

#import "QYCategoryDemoViewController.h"
@interface QYCategoryDemoViewController ()

@end

@implementation QYCategoryDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
  
    NSMutableAttributedString *attrtb = [[NSMutableAttributedString alloc] initWithString:@"NSMutableAttributedString"];
    [attrtb addAttributes:@{
        NSForegroundColorAttributeName : [UIColor yellowColor],
        NSBackgroundColorAttributeName: [UIColor redColor],
    } range:NSMakeRange(0, attrtb.length)];
    
 
    
    UILabel *labb = [[UILabel alloc] init];
    labb.mk_Frame(CGRectMake(50, 100, 200, 100))
    .mk_Font([UIFont systemFontOfSize:14])
    .mk_Text(@"1111")
    .mk_TextColor([UIColor redColor])
    .mk_CornerRadius(10)
    .mk_TextAlignment(NSTextAlignmentCenter)
    .mk_BackgroundColor([UIColor cyanColor])
    .mk_AddTo(self.view);
   
    UILabel *lab2 = [[UILabel alloc] init];
    lab2.mk_AddTo(self.view)
    .mk_Completed(^(UILabel * _Nonnull lab) {
        lab.frame = CGRectMake(50, 250, 300, 100);
        lab.backgroundColor = [UIColor redColor];
        lab.attributedText = attrtb;
    });
   
   
    
    
    UIButton *btn = [UIButton customButton];
    btn.mk_AddTo(self.view)
    .mk_Font([UIFont systemFontOfSize:15])
    .mk_Frame(CGRectMake(50, 450, 200, 100))
    .mk_NormalText(@"按钮按钮")
    .mk_BackgroundColor([UIColor orangeColor]);
    
    UIButton *btn2 = [UIButton customButton];
    btn2.mk_AddTo(self.view)
    .mk_Font([UIFont systemFontOfSize:20])
    .mk_NormalText(@"按钮按钮22")
    .mk_BackgroundColor([UIColor orangeColor]);
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.view.mas_trailing).offset(-10);
        make.top.mas_equalTo(self.view.mas_top).offset(150);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    
    
    UITextField *tf = [UITextField textField];
    tf.mk_Frame(CGRectMake(50, 550, 200, 100))
//    .mk_PlaceHolder(@"111")
//    .mk_PlaceHolderColor([UIColor cyanColor])
//    .mk_BackgroundColor([UIColor redColor])
//    .mk_AttributedPlaceholder(NSAttributedString * _Nonnull value)
    .mk_AddTo(self.view);
    
  
   
    
    
     UILabel *lab3 = [[UILabel alloc] init];
     lab3.mk_AddTo(self.view)
     .mk_Completed(^(UILabel * _Nonnull lab) {
         lab.frame = CGRectMake(50, 550, 300, 100);
         lab.font = [UIFont systemFontOfSize:20.0];
         lab.numberOfLines = 0;
//         lab.backgroundColor = [UIColor redColor];
         lab.attributedText = @"Hello World Hello GitHub".mk_attributedString
         .mk_LineSpacing(10)
        .mk_From(0).mk_To(5)
        .mk_FontSize(12.0)
        .mk_Color([UIColor purpleColor])
        .mk_Underline(NSUnderlineStyleSingle)
        .mk_UnderlineColor([UIColor cyanColor])
        .mk_MatchLast(@"Hello")
        .mk_Strikethrough(NSUnderlineStyleDouble)
        .mk_StrikethroughColor([UIColor redColor])
         .mk_BaselineOffset(0);
       
     });
    
    UILabel *lab4 = [[UILabel alloc] init];
    lab4.mk_AddTo(self.view);
   
    lab4.frame = CGRectMake(50, 650, 300, 100);
    lab4.font = [UIFont systemFontOfSize:20.0];
    lab4.numberOfLines = 0;
    lab4.attributedText = @"Hello World Hello GitHub".mk_attributedString
    .mk_LineSpacing(10)
    .mk_From(0).mk_To(5)
    .mk_FontSize(12.0)
    .mk_Color([UIColor purpleColor])
    .mk_Underline(NSUnderlineStyleSingle)
    .mk_UnderlineColor([UIColor cyanColor])
    .mk_MatchLast(@"Hello")
    .mk_Strikethrough(NSUnderlineStyleDouble)
    .mk_StrikethroughColor([UIColor redColor])
    .mk_MatchLast(@"World")
    .mk_Underline(NSUnderlineStyleSingle)
    .mk_UnderlineColor([UIColor orangeColor])
    .mk_MatchLast(@"GitHub")
    .mk_Underline(NSUnderlineStyleSingle)
    .mk_UnderlineColor([UIColor orangeColor]);

  
    
    
    UIImageView *imgeView = [UIImageView imgeView];
    imgeView.mk_AddTo(self.view)
    .mk_BackgroundColor([UIColor redColor])
    .mk_CornerRadius(10)
    .mk_Frame(CGRectMake(200, 400, 50, 40));
    
    

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
