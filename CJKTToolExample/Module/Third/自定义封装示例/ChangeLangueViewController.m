//
//  ChangeLangueViewController.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2021/2/6.
//  Copyright © 2021 CJKT. All rights reserved.
//

#import "ChangeLangueViewController.h"

@interface ChangeLangueViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation ChangeLangueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[kAUSring(@"Indonesian"),kAUSring(@"Arabic"),kAUSring(@"English"),kAUSring(@"Chinese")];

    self.navigationItem.title = kAUSring(@"choose Language");

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view.mas_leading);
        make.trailing.mas_equalTo(self.view.mas_trailing);
        make.top.mas_equalTo(self.view.mas_top).offset(kStatusBarHeight()+kNavHeight());
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];

    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[self getIndex] inSection:0] animated:YES scrollPosition: UITableViewScrollPositionTop];
      
}


-(NSUInteger)getIndex{
    NSUInteger index = 0;
    NSString *currentLang = [LanguageConfig getAppLanguage];
    CJKTLog(@"当前语言 = %@",currentLang);
    if ([currentLang hasPrefix:@"id"]){
        index = 0;
    }else if ([currentLang hasPrefix:@"ar"]){
        index = 1;
    }else if ([currentLang hasPrefix:@"en"]){
        index = 2;
    }
    else {
           index = 3;
    }
    return index;
    
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [_tableView registerClass:[AUselectLanguageCell class] forCellReuseIdentifier:@"AUselectLanguageCell"];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
     
    }
    return _tableView;
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AUselectLanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AUselectLanguageCell" forIndexPath:indexPath];
    cell.titleLab.text = self.titles[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CJKTLog(@"点击section == %ld,row == %ld",(long)indexPath.section,(long)indexPath.row);
     NSString *currentLang = [LanguageConfig getAppLanguage];
    
     if (indexPath.row == 0){
         if ([currentLang hasPrefix:@"id"]) {

             return;
         }
         CJKTLog(@"选择印尼语");
         [self selectLanguageWithType:@"id"];
    }else if (indexPath.row == 1){
        if ([currentLang hasPrefix:@"ar"]) {

            return;
        }
        CJKTLog(@"选择阿拉伯语");
        [self selectLanguageWithType:@"ar"];
    }
    
    else if (indexPath.row == 2){
       
         if ([currentLang hasPrefix:@"en"]) {
           return;
        }
         CJKTLog(@"选择英语");

        [self selectLanguageWithType:@"en"];
    }
    
    
    
    else{
       
         if ([currentLang hasPrefix:@"zh-Hans"]) {
           return;
        }
         CJKTLog(@"选择简体中文");

        [self selectLanguageWithType:@"zh-Hans"];
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *head = [UIView new];
    head.backgroundColor = [UIColor clearColor];
    return head;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = [UIView new];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (void)selectLanguageWithType:(NSString *)type{
    [LanguageConfig setAppLanguage:type];
}

-(void)selectLanguageWithEnglish{

    
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

@interface AUselectLanguageCell ()

@end

@implementation AUselectLanguageCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCellUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setupCellUI{
  
    [self.contentView addSubview:self.titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(10);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
   [self.contentView addSubview:self.avartV];
   [self.avartV mas_makeConstraints:^(MASConstraintMaker *make) {
       make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-15);
       make.centerY.mas_equalTo(self.contentView.mas_centerY);
       make.width.mas_equalTo(25);
       make.height.mas_equalTo(25);
   }];
}
- (UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentNatural;
        _titleLab.font = [UIFont boldSystemFontOfSize:16];
        _titleLab.text = @"";
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

-(UIImageView *)avartV{
    if (!_avartV) {
        _avartV = [[UIImageView alloc] init];
        _avartV.image = kIMAGE(@"icon_opinionsFalse");
    }
    return _avartV;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if (selected) {
        self.titleLab.textColor = [UIColor redColor];
        self.avartV.image = kIMAGE(@"correct");
    }else{
        self.titleLab.textColor = [UIColor blackColor];
        self.avartV.image = kIMAGE(@"wrong");
    }
}
@end

