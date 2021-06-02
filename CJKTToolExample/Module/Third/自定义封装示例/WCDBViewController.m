//
//  WCDBViewController.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2021/2/18.
//  Copyright © 2021 CJKT. All rights reserved.
//

#import "WCDBViewController.h"
#import "WCDBManager.h"
#import "WCDBModelManager.h"
#import "LoginUserModel.h"
@interface WCDBViewController ()

@end

@implementation WCDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton customButton];
    btn.mk_AddTo(self.view)
    .mk_Font([UIFont systemFontOfSize:15])
    .mk_Frame(CGRectMake(50, 100, 100, 50))
    .mk_NormalText(@"创建表")
    .mk_NormalTextColor([UIColor redColor])
    .mk_BackgroundColor([UIColor cyanColor])
    .mk_Selector(self, @selector(createTable), UIControlEventTouchUpInside);

    UIButton *btn2 = [UIButton customButton];
    btn2.mk_AddTo(self.view)
    .mk_Font([UIFont systemFontOfSize:15])
    .mk_Frame(CGRectMake(50, 200, 100, 50))
    .mk_NormalText(@"插入数据")
    .mk_NormalTextColor([UIColor redColor])
    .mk_BackgroundColor([UIColor cyanColor])
    .mk_Selector(self, @selector(insertTable), UIControlEventTouchUpInside);

    UIButton *btn22 = [UIButton customButton];
    btn22.mk_AddTo(self.view)
    .mk_Font([UIFont systemFontOfSize:15])
    .mk_Frame(CGRectMake(250, 200, 100, 50))
    .mk_NormalText(@"获取数据")
    .mk_NormalTextColor([UIColor redColor])
    .mk_BackgroundColor([UIColor cyanColor])
    .mk_Selector(self, @selector(getTable), UIControlEventTouchUpInside);

    

    UIButton *btn3 = [UIButton customButton];
    btn3.mk_AddTo(self.view)
    .mk_Font([UIFont systemFontOfSize:15])
    .mk_Frame(CGRectMake(50, 300, 100, 50))
    .mk_NormalText(@"更新数据")
    .mk_NormalTextColor([UIColor redColor])
    .mk_BackgroundColor([UIColor cyanColor])
    .mk_Selector(self, @selector(updateTable), UIControlEventTouchUpInside);
    
//    UIButton *btn4 = [UIButton customButton];
//    btn4.mk_AddTo(self.view)
//    .mk_Font([UIFont systemFontOfSize:15])
//    .mk_Frame(CGRectMake(50, 400, 100, 50))
//    .mk_NormalText(@"删除数据")
//    .mk_NormalTextColor([UIColor redColor])
//    .mk_BackgroundColor([UIColor cyanColor])
//    .mk_Selector(self, @selector(deleteTable), UIControlEventTouchUpInside);

    
    UIButton *btn44 = [UIButton customButton];
    btn44.mk_AddTo(self.view)
       .mk_Font([UIFont systemFontOfSize:15])
       .mk_Frame(CGRectMake(250, 400, 100, 50))
       .mk_NormalText(@"删除数据库")
       .mk_NormalTextColor([UIColor redColor])
       .mk_BackgroundColor([UIColor cyanColor])
       .mk_Selector(self, @selector(deleteTableBase), UIControlEventTouchUpInside);

    

}
- (void)createTable{
    [[WCDBManager shared] creatDataBaseWithName:NSStringFromClass([LoginUserModel class])];
}
-(void)insertTable{
    CJKTLog(@"插入数据");
    LoginUserModel *model = [[LoginUserModel alloc] init];
    model.uid = @"11223344";
    model.nickname = @"Dxc";
    model.gender = 1;
    model.portrait = @"portrait";
//    WCDBModelManager *manager = [[WCDBModelManager alloc] init];
    [WCDBModelManager insertMessage:model];

   
}
-(void)getTable{
    CJKTLog(@"获取数据");
//    WCDBModelManager *manager = [[WCDBModelManager alloc] init];
    LoginUserModel *model =  [WCDBModelManager getUserModel];
    CJKTLog(@"nickname = %@",model.nickname);
    CJKTLog(@"gender = %ld",(long)model.gender);
    CJKTLog(@"portrait = %@",model.portrait);
}
-(void)updateTable{
    CJKTLog(@"更新数据");
    LoginUserModel *model = [[LoginUserModel alloc] init];
    model.nickname = @"Dxc123";
    model.gender = 0;
    model.portrait = @"portrait22";
//    WCDBModelManager *manager = [[WCDBModelManager alloc] init];
    [WCDBModelManager updataProperties:model];
    

}
-(void)deleteTable{
    CJKTLog(@"删除数据");
//    LoginUserModel *model = [[LoginUserModel alloc] init];
//    WCDBModelManager *manager = [[WCDBModelManager alloc] init];
//    [manager deleteMessage:model];
}
-(void)deleteTableBase{
    CJKTLog(@"删除数据");
//    WCDBModelManager *manager = [[WCDBModelManager alloc] init];
    [WCDBModelManager deleteAllDatas:@"LoginUserModel"];
    
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
