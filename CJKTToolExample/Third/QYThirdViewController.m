//
//  ThirdViewController.m
//  QYBaseProject
//
//  Created by Dxc_iOS on 2018/7/18.
//  Copyright © 2018年 代星创. All rights reserved.
//

#import "QYThirdViewController.h"
#import <Masonry.h>
#import "CJKTTextField.h"
@interface QYThirdViewController ()
@property (nonatomic, strong) CJKTTextField *textField;
@end

@implementation QYThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.textField];
    
   
    
}
-(CJKTTextField *)textField{
    if (!_textField) {
        _textField = [[CJKTTextField alloc] initWithFrame:CGRectMake(0, 100, 200, 40)];
//        _textField.keyboardType =  UIKeyboardTypeNumberPad;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.secureTextEntry = YES;
        //_phoneTF.placeholder = @"请输入手机号码";
        _textField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号" attributes:@{
            NSForegroundColorAttributeName:[UIColor grayColor],
            NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
            
        }];;
        _textField.font = [UIFont systemFontOfSize:16.f];
//        _textField.delegate = self;
        UIImageView *leftImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        leftImgV.image = IMAGE(@"手机号");
        _textField.leftView = leftImgV;
        _textField.leftViewMode = UITextFieldViewModeAlways;
    }
    return _textField;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textField resignFirstResponder];
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
