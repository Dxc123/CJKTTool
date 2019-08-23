//
//  QYNavigationViewController.m
//  CarPooling
//
//  Created by Dxc_iOS on 2018/5/14.
//  Copyright © 2018年 代星创. All rights reserved.
//

#import "QYNavigationViewController.h"

@interface QYNavigationViewController ()

@end

@implementation QYNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark 重写这个方法目的：能够拦截所有push进来的控制器
#pragma mark viewController这个参数是即将push进来的控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0 ) {
        // 如果push进来的控制器viewController，不是根控制器
    
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
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
