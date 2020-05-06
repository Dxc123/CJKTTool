//
//  UIViewController+CJKTExtension.h
//  CJKTCategoryExample
//
//  Created by Dxc_iOS on 2018/11/10.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CJKTExtension)
#pragma mark -- 多级Push页面后返回指定控制器


/**
 多级Push页面后返回指定控制器
 */
-(void)cjkt_popToViewController:(NSString *)ViewControllerName animated:(BOOL )animaed;
@end

NS_ASSUME_NONNULL_END
/**
 if(self.navigationController.viewControllers.count <= 1)
 {
 [self dismissViewControllerAnimated:YES completion:nil];
 }
 else
 {
 [self cjkt_popToViewController:@"ViewController" animated:YES];
 }
 */
