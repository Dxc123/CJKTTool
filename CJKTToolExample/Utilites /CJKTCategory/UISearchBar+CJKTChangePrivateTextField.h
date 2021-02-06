//
//  UISearchBar+CJKTChangePrivateTextField.h
//  AUNewProject
//
//  Created by daixingchuang on 2020/9/23.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
iOS13以后,不在允许通过KVC的方式去访问私有属性；
UITextField *searchTextField = [_searchBar valueForKey:@"_searchField"];会造成崩溃
 故分类修改SearchBar系统自带的TextField
 */
@interface UISearchBar (CJKTChangePrivateTextField)
/**
 修改SearchBar系统自带的TextField
 */
- (void)changeSearchTextFieldWithCompletionBlock:(void(^)(UITextField *textField))completionBlock ;
@end

NS_ASSUME_NONNULL_END
