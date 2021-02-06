//
//  QYTabBarViewController.m
//  CarPooling
//
//  Created by Dxc_iOS on 2018/5/14.
//  Copyright © 2018年 代星创. All rights reserved.
//

#import "QYTabBarViewController.h"
#import "QYHomeViewController.h"
#import "QYNavigationViewController.h"
#import "QYSecondViewController.h"
#import "QYThirdViewController.h"
#import "QYFourViewController.h"
@interface QYTabBarViewController ()

@end

@implementation QYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildViewControllers];
}
/***  添加所有子控制器*/

-(void)setUpChildViewControllers{
    QYHomeViewController *homeVC = [[QYHomeViewController alloc] init];
    [self setUpOneChildViewController:homeVC image:[UIImage imageNamed:@"tab_home_nor"]  selectedImage:[UIImage imageNamed:@"tab_home_pre"]  title:@"Frist"];
    QYSecondViewController *second = [[QYSecondViewController alloc] init];
    [self setUpOneChildViewController:second image:[UIImage imageNamed:@"tab_found_nor"]  selectedImage:[UIImage imageNamed:@"tab_fond_pre"]  title:@"Second"];
    QYThirdViewController *third = [[QYThirdViewController alloc] init];
    [self setUpOneChildViewController:third image:[UIImage imageNamed:@"tab_mine_nor"]  selectedImage:[UIImage imageNamed:@"tab_mine_pre"]  title:@"Third"];
    QYFourViewController *four = [[QYFourViewController alloc] init];
    [self setUpOneChildViewController:four image:[UIImage imageNamed:@"tab_mine_nor"]  selectedImage:[UIImage imageNamed:@"tab_mine_pre"]  title:@"four"];
   
}

/**添加一个子控制器的方法*/
- (void)setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image selectedImage:(UIImage *)selectedImage  title:(NSString *)title{
    QYNavigationViewController *BaseNav = [[QYNavigationViewController alloc] initWithRootViewController:viewController];
    viewController.title = title;
    //    viewController.tabBarItem.title=title;
    
    //    tabBarItem 的选中和不选中文字属性
//    [viewController .tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
//    [viewController .tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(204, 62, 62)} forState:UIControlStateSelected];
    
    if (@available(iOS 13.0, *)) {
        // iOS 13以上
        self.tabBar.tintColor = RGB(204, 62, 62);
        self.tabBar.unselectedItemTintColor = [UIColor grayColor];
       
    } else {
        // iOS 13以下
         [viewController .tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(204, 62, 62)} forState:UIControlStateSelected];
        [viewController .tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    }
    
    //    tabBarItem 的选中和不选中图片属性
    [viewController.tabBarItem setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [viewController.tabBarItem setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self addChildViewController:BaseNav];
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
