//
//  UIViewController+CJKTExtension.m
//  CJKTCategoryExample
//
//  Created by Dxc_iOS on 2018/11/10.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import "UIViewController+CJKTExtension.h"

@implementation UIViewController (CJKTExtension)

#pragma mark -- 多级Push页面后返回指定控制器
-(void)cjkt_popToViewController:(NSString *)viewControllerName animated:(BOOL )animaed{
    if (self.navigationController) {
        NSArray *controllers = self.navigationController.viewControllers;
        NSArray *result = [controllers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            return [evaluatedObject isKindOfClass:NSClassFromString(viewControllerName)];
        }]];
        if (result.count > 0) {
            [self.navigationController popToViewController:result[0] animated:YES];
        }
    }
}
@end
