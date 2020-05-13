//
//  ThirdViewController.m
//  QYBaseProject
//
//  Created by Dxc_iOS on 2018/7/18.
//  Copyright © 2018年 代星创. All rights reserved.
//

#import "QYThirdViewController.h"
#import "CRTimer.h"
#import <FFPopup/FFPopup.h>
#import "CJKTTool.h"
#import "CJKTCategory.h"
#import "AnimationKit.h"
@interface QYThirdViewController ()
@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation QYThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *lab1 = [CJKTTool initUILabelWithFrame:CGRectMake(20, 100, 150, 40) title:@"你好你哈哈哦哦" numberOfLines:0 textAlignment:NSTextAlignmentCenter textColor:[UIColor redColor] font:[UIFont systemFontOfSize:15]];
      
    lab1.attributedText = [NSMutableAttributedString  cjkt_addLinkWithTotalString:lab1.text SubStringArray:@[@"哈哈哦哦"]];
    [self.view addSubview:lab1];
    
    UIButton *btn = [CJKTTool initUIButtonWithFrame:CGRectMake(20, 200, 200, 40) title:@"你好你哈哈哦哦" tag:0 backGround:[UIColor clearColor] textColor:[UIColor blackColor] borderWidth:0 borderColor:[UIColor clearColor] cornerRadius:0 font:[UIFont systemFontOfSize:15]];
    
    btn.titleLabel.attributedText = [NSMutableAttributedString  cjkt_addLinkWithTotalString:lab1.text SubStringArray:@[@"哈哈哦哦"]];
    [self.view addSubview:btn];
    
    UIButton *timeBtn = [CJKTTool initUIButtonWithFrame:CGRectMake(20, 250, 40, 40) imgNormal:@"icon_next" imgSelected:@""];//login_icon_hides
    [timeBtn addTarget:self action:@selector(timeBtnActione:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeBtn];
    self.timeBtn = timeBtn;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor cyanColor];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.frame = CGRectMake(20, 330, 200, 40);
    
    
    
    

    
    
}
-(void)buttonClicked{
    NSLog(@"点击");
    FFPopup *popup = [FFPopup popupWithContentView:self.contentView];
          popup.showType = FFPopupShowType_GrowIn;
          popup.dismissType = FFPopupDismissType_SlideOutToBottom;
          popup.maskType = FFPopupMaskType_None;
          popup.shouldDismissOnBackgroundTouch = YES;
          popup.shouldDismissOnContentTouch = NO;
        FFPopupLayout layout = FFPopupLayoutMake(FFPopupHorizontalLayout_Center, FFPopupVerticalLayout_Center);
//     [popup showWithLayout:layout duration: 0];
    
    FFPopup *popup2 = [FFPopup popupWithContentView:self.contentView showType:FFPopupShowType_BounceInFromBottom dismissType:FFPopupDismissType_SlideOutToBottom maskType:FFPopupMaskType_None dismissOnBackgroundTouch:YES dismissOnContentTouch:YES];
       FFPopupLayout layout2 = FFPopupLayoutMake(FFPopupHorizontalLayout_Center, FFPopupVerticalLayout_Bottom);
    
    
          [popup2 showWithLayout:layout2 duration: 0];
         
}
-(void)timeBtnActione:(UIButton *)sender{
    NSLog(@"点击timeBtn");
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        [self.timeBtn rotationWithAngle_ML:90];
    }else{
        [self.timeBtn rotationWithAngle_ML:0];
    }
   
    
    
    
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,280, 300)];
        _contentView.backgroundColor = [UIColor redColor];
    }
    return _contentView;
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
