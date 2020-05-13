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

/**
iOS13适配presentViewController:问题
 */


+(void)load{
    
    Method presentViewController = class_getInstanceMethod(self, @selector(presentViewController:animated:completion:));
    Method cjkt_presentViewController = class_getInstanceMethod(self, @selector(cjkt_presentViewController:animated:completion:));
//    交换
    method_exchangeImplementations(presentViewController, cjkt_presentViewController);
}


-(void)cjkt_presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion API_AVAILABLE(ios(5.0)){
    if (@available(iOS 13.0,*)) {
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        [self cjkt_presentViewController:viewControllerToPresent animated:flag completion:completion];
    }else{
        [self cjkt_presentViewController:viewControllerToPresent animated:flag completion:completion];
    }
    
}


@end
