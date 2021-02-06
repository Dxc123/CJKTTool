//
//  CJKTRecordView.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/29.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "CJKTRecordView.h"
#define NoneImage           kIMAGE(@"mine_btn_luyin")
#define RecordingImage      kIMAGE(@"mine_btn_tingzhi")
#define RecordFinishImage   kIMAGE(@"mine_btn_bofang")
#define RecordPlayingImgae  kIMAGE(@"mine_btn_zanting")
@interface CJKTRecordView ()
@property (nonatomic,strong) UIButton *recordBtn;
@property (nonatomic,strong) UILabel *bottomTipsLabel;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UIButton *confirmBtn;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,assign) BOOL leftRightOpen;
@property (nonatomic,strong) UIView *shadowView;
@property (nonatomic,strong) UIView *volumeView;
@end
@implementation CJKTRecordView

-(instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    self.recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.recordBtn.backgroundColor = [UIColor clearColor];
    [self.recordBtn setImage:kIMAGE(@"") forState:UIControlStateNormal];
    self.recordBtn.mas_key = @"";
    [self addSubview:self.recordBtn];
    self.recordBtn.mas_key = @"recordBtn";
    [self.recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(self.mas_top).offset(80);
        make.width.height.offset(83);
    }];
    [self.recordBtn addTarget:self action:@selector(recordBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.bottomTipsLabel = [[UILabel alloc] init];
    self.bottomTipsLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomTipsLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.bottomTipsLabel.textColor = UIColorFromRGB(0xA7B1CE);
    self.bottomTipsLabel.numberOfLines = 0;
    [self addSubview:self.bottomTipsLabel];
    self.bottomTipsLabel.text = @"点击录音";
    self.bottomTipsLabel.mas_key = @"bottomTipsLabel";
    [self.bottomTipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(self.recordBtn.mas_bottom).offset(40);
    }];
    
    self.cancelBtn = [[UIButton alloc] init];
    [self insertSubview:self.cancelBtn belowSubview:self.recordBtn];
    self.cancelBtn.mas_key = @"cancelBtn";
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.mas_equalTo(self.recordBtn.mas_centerY).offset(0);
        make.width.height.mas_equalTo(80);
    }];
    [self.cancelBtn setImage:kIMAGE(@"mine_btn_delete") forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelRecordAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmBtn = [[UIButton alloc] init];
    [self insertSubview:self.confirmBtn belowSubview:self.recordBtn];
    self.confirmBtn.mas_key = @"confirmBtn";
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.mas_equalTo(self.recordBtn.mas_centerY).offset(0);
        make.width.height.mas_equalTo(80);
    }];
    [self.confirmBtn setImage:kIMAGE(@"mine_btn_save") forState:UIControlStateNormal];
    [self.confirmBtn addTarget:self action:@selector(confirmRecordAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.timeLabel.textColor = UIColorFromRGB(0x737B93);
    self.timeLabel.numberOfLines = 0;
    
    
    [self addSubview:self.timeLabel];
    self.timeLabel.mas_key = @"timeLabel";
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.mas_equalTo(self.mas_top).offset(30);
    }];
    self.state = CJKTRecordStateNone;
    
    
    self.shadowView = [self creatShadowView:0.03 width:80 height:80];
    [self insertSubview:self.shadowView atIndex:0];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.recordBtn.mas_centerY).offset(0);
        make.centerX.mas_equalTo(self.recordBtn.mas_centerX).offset(0);
        make.width.height.offset(80);
    }];
    self.shadowView.hidden = YES;
    
    self.volumeView = [self creatShadowView:0.14 width:83 height:83];
    [self insertSubview:self.volumeView aboveSubview:self.shadowView];
    [self.volumeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.recordBtn.mas_centerY).offset(0);
        make.centerX.mas_equalTo(self.recordBtn.mas_centerX).offset(0);
        make.width.height.offset(83);
    }];
    self.volumeView.hidden = YES;
}
- (UIView *)creatShadowView:(CGFloat)alpha width:(CGFloat)width height:(CGFloat)height {
    UIView *view = [[UIView alloc] init];
    view.layer.shadowColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1.0].CGColor;
    view.layer.shadowOffset = CGSizeMake(0,3);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 5;
    view.layer.cornerRadius = 40;
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,width,height);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    //    gl.colors = @[(__bridge id)[UIColor colorWithRed:253/255.0 green:172/255.0 blue:36/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:90/255.0 blue:35/255.0 alpha:1.0].CGColor];
    gl.colors = @[(__bridge id)UIColorFromRGBA(0xFDAC24, alpha).CGColor,(__bridge id)UIColorFromRGBA(0xFF5A23,alpha).CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    gl.cornerRadius = 0.5*width;
    [view.layer addSublayer:gl];
    return view;
}
- (void)setVolume:(float)volume {
    _volume = volume;
    NSLog(@"音量 -- %f",volume);
    [UIView animateWithDuration:0.01 animations:^{
        self.volumeView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1+volume, 1+volume, 0);
    }];
}
- (void)closeAction {
    !self.closeBlock?:self.closeBlock();
   
}
- (void)confirmRecordAction {
    !self.confirmRecordBlock?:self.confirmRecordBlock();
}
- (void)cancelRecordAction {
    !self.cancelRecordBlock?:self.cancelRecordBlock();
    self.state = CJKTRecordStateNone;
}
- (void)setState:(CJKTRecordState)state {
    _state = state;
    switch (state) {
        case CJKTRecordStateNone:
            [self showLeftRightBtnAnimationClose];
            self.volumeView.hidden = YES;
            self.timeLabel.hidden = YES;
            self.bottomTipsLabel.hidden = NO;
            self.bottomTipsLabel.text = @"点击开始录音";
            [self.recordBtn setImage:NoneImage forState:UIControlStateNormal];
            break;
        case CJKTRecordStateRecording:
            [self shadowViewAnimation];
            self.volumeView.hidden = NO;
            self.timeLabel.hidden = NO;

            self.bottomTipsLabel.text = @"录音中";
            [self.recordBtn setImage:RecordingImage forState:UIControlStateNormal];
            break;
            
        case CJKTRecordStateFinishRecord:
            [self showLeftRightBtnAnimationOpen];
            [self stopShadowAnimation];
            self.volumeView.hidden = YES;
            self.timeLabel.hidden = NO;

            self.bottomTipsLabel.text = @"点击播放";
            [self.recordBtn setImage:RecordFinishImage forState:UIControlStateNormal];
            break;
        case CJKTRecordStatePlaying:
            self.time = 0;
            self.volumeView.hidden = YES;
            [self.recordBtn setImage:RecordPlayingImgae forState:UIControlStateNormal];
            self.bottomTipsLabel.text = @"录音播放中";
            break;
        default:
            break;
    }
}
- (void)shadowViewAnimation {
    self.shadowView.hidden = NO;
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.fromValue = @1.3;
    animation.toValue = @2.3;
    animation.duration = 1.6;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT;
    [self.shadowView.layer addAnimation:animation forKey:nil];
}
- (void)stopShadowAnimation {
    [self.shadowView.layer removeAllAnimations];
    self.shadowView.hidden = YES;
}
- (void)showLeftRightBtnAnimationOpen {
    if (self.leftRightOpen) {
        return;
    }
    self.leftRightOpen = YES;
    self.confirmBtn.alpha = 0;
    self.confirmBtn.layer.transform = CATransform3DRotate(CATransform3DIdentity, M_PI, 0, 0, 1);
    [self.confirmBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(px(100));
        make.centerY.mas_equalTo(self.recordBtn.mas_centerY).offset(0);
    }];
    
    self.cancelBtn.alpha = 0;
    self.cancelBtn.layer.transform = CATransform3DRotate(CATransform3DIdentity, M_PI, 0, 0, 1);
    [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(px(-100));
        make.centerY.mas_equalTo(self.recordBtn.mas_centerY).offset(0);

    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
        self.confirmBtn.layer.transform = CATransform3DIdentity;
        self.confirmBtn.alpha = 1;
        self.cancelBtn.layer.transform = CATransform3DIdentity;
        self.cancelBtn.alpha = 1;
    }];
    
}
- (void)showLeftRightBtnAnimationClose {
    if (!self.leftRightOpen) {
        return;
    }
    self.leftRightOpen = NO;
    [self.confirmBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.mas_equalTo(self.recordBtn.mas_centerY).offset(0);
    }];
    [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.mas_equalTo(self.recordBtn.mas_centerY).offset(0);
        
    }];
    [UIView animateWithDuration:0.3 animations:^{
        self.confirmBtn.layer.transform = CATransform3DRotate(CATransform3DIdentity, M_PI, 0, 0, 1);
        self.cancelBtn.layer.transform = CATransform3DRotate(CATransform3DIdentity, M_PI, 0, 0, 1);
        self.confirmBtn.alpha = 0;
        self.cancelBtn.alpha = 0;
        [self layoutIfNeeded];
    }];
}
- (void)recordBtnClicked:(UIButton *)sender {
    switch (self.state) {
        case CJKTRecordStateNone:
            !self.startRecordBlock?:self.startRecordBlock();
            self.state = CJKTRecordStateRecording;
            break;
        case CJKTRecordStateRecording:
            !self.stopRecordBlock?:self.stopRecordBlock();
            self.state = CJKTRecordStateFinishRecord;
            break;
        case CJKTRecordStateFinishRecord:
            !self.startPlayBlock?:self.startPlayBlock();
            self.state = CJKTRecordStatePlaying;
            break;
        case CJKTRecordStatePlaying:
            !self.stopPlayBlock?:self.stopPlayBlock();
            self.state = CJKTRecordStateFinishRecord;
        default:
            break;
    }
}


- (void)setTime:(NSUInteger)time {
    _time = time;
    self.timeLabel.text = [NSString stringWithFormat:@"%tus",time];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
