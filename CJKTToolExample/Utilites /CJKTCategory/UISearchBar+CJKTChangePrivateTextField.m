//
//  UISearchBar+CJKTChangePrivateTextField.m
//  AUNewProject
//
//  Created by daixingchuang on 2020/9/23.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

#import "UISearchBar+CJKTChangePrivateTextField.h"

@implementation UISearchBar (CJKTChangePrivateTextField)
// 修改SearchBar系统自带的TextField
- (void)changeSearchTextFieldWithCompletionBlock:(void(^)(UITextField *textField))completionBlock {
    
    if (!completionBlock) {
        return;
    }
    UITextField *textField = [self findTextFieldWithView:self];
    if (textField) {
        completionBlock(textField);
    }
}


/// 递归遍历UISearchBar的子视图，找到UITextField
- (UITextField *)findTextFieldWithView:(UIView *)view {


    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            return (UITextField *)subview;
        }else if (subview.subviews.count > 0) {
            return [self findTextFieldWithView:subview];
        }
    }
    return nil;
}
@end
