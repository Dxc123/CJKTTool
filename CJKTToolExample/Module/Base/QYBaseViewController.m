//
//  QYBaseViewController.m
//  CarPooling
//
//  Created by Dxc_iOS on 2018/5/14.
//  Copyright © 2018年 代星创. All rights reserved.
//

#import "QYBaseViewController.h"

@interface QYBaseViewController ()

@end

@implementation QYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
    
//    [self.navigationController.navigationBar setBarTintColor:RGB(0, 175, 240)];
    //所有的返回按钮的title都是“返回”
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
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
