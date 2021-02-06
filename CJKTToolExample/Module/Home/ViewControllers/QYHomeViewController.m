//
//  QYHomeViewController.m
//  CarPooling
//
//  Created by Dxc_iOS on 2018/5/14.
//  Copyright © 2018年 代星创. All rights reserved.
//

#import "QYHomeViewController.h"
#import "CJKTHomeCell.h"
@interface QYHomeViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)NSArray *classNames;
@end

@implementation QYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.titles =@[
         @"Demo1(转盘效果的实现)"
     ];

    self.classNames = @[
        @"QYDemoViewController"
    ];
    
    [self.view addSubview:self.tableView];
    
    UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [moreButton setTitle:@"编辑" forState: UIControlStateNormal];
    [moreButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(rightbarbtnclick:) forControlEvents:UIControlEventTouchUpInside];
      
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(rightbarbtnclick:)];
   
    
    
}
-(void)rightbarbtnclick:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        [self.tableView setEditing:YES animated:YES];
    }else{
        [self.tableView setEditing:NO animated:YES];
    }
    
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
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.textLabel.text = self.titles[indexPath.section];;
    
    CJKTHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CJKTHomeCell"];
       if (!cell) {
           cell = [[CJKTHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CJKTHomeCell"];
       }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = self.titles[indexPath.section];;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44+44;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}

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


#pragma mark -
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return NO;
    return YES;
}
//定义左滑多按钮
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        CJKTLog(@"删除");
        // 点击删除按钮需要执行的方法
        [tableView setEditing:NO animated:YES];
    }];
    action.backgroundColor = [UIColor redColor];//修改背景颜色
    
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        CJKTLog(@"置顶");
        [tableView setEditing:NO animated:YES];
       }];

    UITableViewRowAction *action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        CJKTLog(@"更多");
        [tableView setEditing:NO animated:YES];
    }];

    
    return @[action,action2,action3];
}

//监听即将开启编辑状态的事件
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
     [tableView setEditing:YES animated:YES];
    // 在 iOS11 以下系统,因为方法线程问题,需要放到主线程执行, 不然没有效果
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self setupSlideBtnWithEditingIndexPath:indexPath];
    });
}
//监听编辑结束状态的事件
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath {
    [tableView setEditing:NO animated:YES];
};
//提交删除等操作(左滑多按钮时,该方法不执行)
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        //只要实现这个方法，就实现了默认滑动删除！！！！！
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            CJKTLog(@"删除");
            // 删除数据
//            [self _deleteSelectIndexPath:indexPath];
        }
}

//返回Cell的编辑样式：多选模式（cell 最左侧显示蓝色选择按钮）
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

//编辑状态下的Cell是否需要缩进 (使用分组的样式 tableView)
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//全选按钮事件
- (void)allSelectAction:(UIButton*)sender {
    [self.classNames enumerateObjectsUsingBlock:^(id _Nonnull obj,NSUInteger idx,BOOL*_Nonnull stop) {
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }];
    
}
//全不选按钮事件

- (void)allUnSelectAction:(UIButton*)sender {
    [self.tableView reloadData];
    //    或者
//    [[self.tableView indexPathsForSelectedRows]enumerateObjectsUsingBlock:^(NSIndexPath*_Nonnull obj,NSUInteger idx,BOOL*_Nonnullstop) {
//        [self.tableView deselectRowAtIndexPath:obj animated:NO];
//    }];
    
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
