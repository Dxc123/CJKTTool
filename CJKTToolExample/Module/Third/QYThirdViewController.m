//
//  ThirdViewController.m
//  QYBaseProject
//
//  Created by Dxc_iOS on 2018/7/18.
//  Copyright © 2018年 代星创. All rights reserved.
//

#import "QYThirdViewController.h"
#import "CRTimer.h"
#import "AnimationKit.h"
#import "NSKeyedArchiverDemo.h"
#import "QYCategoryDemoViewController.h"
#import "WCDBViewController.h"

@interface QYThirdViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *classNames;

@property (nonatomic, strong) UIButton *timeBtn;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation QYThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    UILabel *lab1 = [CJKTTool initUILabelWithFrame:CGRectMake(20, 100, 200, 40) font:[UIFont systemFontOfSize:15] title:@"哈哈哦哦" textColor:[UIColor redColor] numberOfLines:0 textAlignment:NSTextAlignmentCenter];
//
//    lab1.attributedText = [NSMutableAttributedString  cjkt_addLinkWithTotalString:lab1.text SubStringArray:@[@"哈哈哦哦"]];
//    [self.view addSubview:lab1];
//
//    UIButton *btn = [CJKTTool initUIButtonWithFrame:CGRectMake(20, 100, 200, 40) font:[UIFont systemFontOfSize:15] title:@"哈哈哦哦" textColor:[UIColor cyanColor] backGround:[UIColor whiteColor] borderWidth:0 borderColor:[UIColor clearColor] cornerRadius:0];
//    
//    btn.titleLabel.attributedText = [NSMutableAttributedString  cjkt_addLinkWithTotalString:lab1.text SubStringArray:@[@"哈哈哦哦"]];
//    [self.view addSubview:btn];
//    
//    UIButton *timeBtn = [CJKTTool initUIButtonWithFrame:CGRectMake(20, 250, 40, 40) imgNormal:@"icon_next" imgSelected:@""];//login_icon_hides
//    [timeBtn addTarget:self action:@selector(timeBtnActione:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:timeBtn];
//    self.timeBtn = timeBtn;
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = [UIColor cyanColor];
//    button.titleLabel.font = [UIFont systemFontOfSize:15];
//    [button setTitle:@"点击" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
////    button.frame = CGRectMake(20, 330, 200, 40);
//    
//    button.m_height(40).m_width(200).m_top(330).m_left(20);
//    
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    button2.backgroundColor = [UIColor cyanColor];
//    button2.titleLabel.font = [UIFont systemFontOfSize:15];
//    [button2 setTitle:@"点击" forState:UIControlStateNormal];
//    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    //       [button2 addTarget:self action:@selector(button2Clicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button2];
    
    
    self.navigationItem.title = @"自定义封装使用示例";
    self.titles =@[
         @"Mode归档Demo",
         @"ActionSheetDemo",
         @"切换语言",
         @"NSAttributedString属性链式编程实现",
         @"WCDB封装",
     ];

    self.classNames = @[
        @"NSKeyedArchiverDemo",
        @"ActionSheetDemo",
        @"ChangeLangueViewController",
        @"QYCategoryDemoViewController",
        @"WCDBViewController",
    ];
    
    [self.view addSubview:self.tableView];
    
   
}
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.classNames.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titles[indexPath.section];;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.isEditing) {
        return;
    }
    NSString *className = self.classNames[indexPath.section];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = self.classNames[indexPath.section];
        
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


-(void)timeBtnActione:(UIButton *)sender{
    NSLog(@"点击timeBtn");
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        [self.timeBtn rotationWithAngle_ML:90];
    }else{
        [self.timeBtn rotationWithAngle_ML:0];
    }
    
}
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,280, 300)];
        _contentView.backgroundColor = [UIColor redColor];
    }
    return _contentView;
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
