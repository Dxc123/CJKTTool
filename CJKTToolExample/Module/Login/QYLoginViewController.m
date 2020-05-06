//
//  QYLoginViewController.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/25.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "QYLoginViewController.h"
#import "CJKTSingleton.h"
#import "CJKTUserModel.h"

@interface QYLoginViewController ()

@end

@implementation QYLoginViewController

//登录界面储存user.token
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
/**
 
 CJKTUserModel *user = [HWUser mj_objectWithKeyValues:responseObject];
            SINGLETON.userId = user.user_id;
            SINGLETON.token = user.token;
            SINGLETON.myUser = user;
            [user saveToLocal];
 */
    
    
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
