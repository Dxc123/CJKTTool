//
//  CJKTAlert.m
//  CJKTAlert
//
//  Created by Dxc_iOS on 2018/9/28.
//  Copyright © 2018 超级课堂. All rights reserved.
//
#import "CJKTAlert.h"
#import "UIView+CJKTExtension.h"
#import "NSString+CJKTAttributedString.h"
#define kCJKTAlertScreenWidth [UIScreen mainScreen].bounds.size.width
#define kCJKTAlertScreenHeight [UIScreen mainScreen].bounds.size.height
static const CGFloat kDefaultAnimateDuration = 0.35;
typedef void(^FinishBlock)(NSInteger index);

@interface CJKTAlert ()

/** 选中按钮之后的回调block */
@property (nonatomic,   copy) FinishBlock finishBlock;

/** bgView */
@property (nonatomic, strong) UIView * maskView;
@property (nonatomic, strong) UIView *contentView;
/** 标题*/
@property (nonatomic, strong) UILabel * titleLabel;

/** 副标题或描述 */
@property (nonatomic, strong) UILabel * messageLabel;

/** 副标题或描述的Alignment */
@property (nonatomic, assign) NSTextAlignment messageAlignment;

/** 副标题或描述的部分字体颜色 */
@property (nonatomic, assign) NSRange range;

/** 横线 */
@property (nonatomic, strong) UIView * lineView;

/** 接收装按钮文字数组的 */
@property (nonatomic, strong) NSArray * itemArr;

/** 接收传进来的titleString */
@property (nonatomic,   copy) NSString * titleString;

/** 接收传进来的messageString */
@property (nonatomic,   copy) NSString * messageString;

/** 装竖线的数组 */
@property (nonatomic, strong) NSMutableArray<UIView *> * btnLineArr;

/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray<UIButton *> * buttonArr;

@end

@implementation CJKTAlert
{
    /** 这里是可修改的一些基本属性 */
    
    CGFloat viewWith;//自身弹出alertView的宽度 屏幕宽*（0.5~0.9之间最佳）
    
    CGFloat viewTop;//title距离顶部的距离 适当调
    
    CGFloat viewLeftRight;//副标题或描述距离左右的距离 适当调
    
    CGFloat messageLabelFont;//副标题或描述的字体大小
    
    CGFloat messageLineSpace;//副标题或描述多行情况下上下两行间的行距 适当调
    
    CGFloat msgAndLineViewSpace;//副标题或描述与横线之间的距离 大于0 适当调
    
    CGFloat titleHeight;//titleLabel最顶上大标题占的高度 适当调
    
    CGFloat btnHeight;//底部按钮item占的高度 适当调
    
    CGFloat bgViewAlpha;//自身背景灰色的alpha 0~1 越大越灰
    
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message messageAlignment:(NSTextAlignment)textAlignment Item:(NSArray<NSString *> *)itemArr selectBlock:(void(^)(NSInteger index))selectBlock
{
    self = [super initWithFrame:CGRectMake(0, 0, kCJKTAlertScreenWidth, kCJKTAlertScreenHeight)];
    if (self) {
        
        //基本配置调用放最前面
        [self defaultValueMethod];
        
        self.finishBlock = selectBlock;
        
        self.messageAlignment = textAlignment;
        
        self.titleString = title;
        
        self.messageString = message;
        
        self.itemArr = itemArr;
        
        //上面收到数据之后 UI布局放最后面，内容决定布局
        [self addConstraintsAndActions];
        
    }
    return self;
}

/*********基本配置 可根据自身UI风格适当修改**********/
/** 属性赋值配置不可删除 删除之后可能因为取不到值就蹦了 */
- (void)defaultValueMethod
{
    //自身背景色
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
     [self addSubview:self.contentView];
    //自身弹出alertView的宽度 屏幕宽*（0.5~0.9之间最佳）
    viewWith = [UIScreen mainScreen].bounds.size.width*0.8;
    
    //title距离顶部的距离 可适当修改
    viewTop = 30;
    
    //副标题或描述距离左右的距离 可适当修改
    viewLeftRight = 20;
    
    //副标题或描述的字体大小
    messageLabelFont = 16;
    
    //副标题或描述多行情况下上下两行间的行距 可适当修改
    messageLineSpace = 4;
    
    //副标题或描述与横线之间的距离 大于0 适当调
    msgAndLineViewSpace = 20;
    
    //titleLabel最顶上大标题占的高度 可适当修改
    titleHeight = 22;
    
    //底部按钮item占的高度 可适当修改
    btnHeight = 50;
    
    //自身背景灰色的alpha 0~1 可适当修改 越大越灰
    bgViewAlpha = 0.5;
    
}


#pragma mark - 懒加载 UI
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 10.f;
        _contentView.alpha = 0;
        
    }
    return _contentView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:18 weight:500];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        _messageLabel.font = [UIFont systemFontOfSize:messageLabelFont];
        _messageLabel.textAlignment = self.messageAlignment;
        _messageLabel.numberOfLines = 0;
        [_contentView addSubview:_messageLabel];
    }
    return _messageLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor grayColor];
        [_contentView addSubview:_lineView];
    }
    return _lineView;
}

- (NSMutableArray *)buttonArr
{
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}

- (NSMutableArray *)btnLineArr
{
    if (!_btnLineArr) {
        _btnLineArr = [NSMutableArray array];
    }
    return _btnLineArr;
}

#pragma mark - layout
- (void)addConstraintsAndActions
{
    
    if (!self.titleString.length && !self.messageString.length) {
        
        self.lineView.frame = CGRectMake(0, 0, viewWith, 0.8);
        
        NSLog(@"没有title和message");
    }else if (self.titleString.length && !self.messageString.length) {
        
        self.titleLabel.frame = CGRectMake(viewLeftRight, viewTop, viewWith-viewLeftRight*2, titleHeight);
        
        self.lineView.frame   = CGRectMake(0, self.titleLabel.bottom+msgAndLineViewSpace, viewWith, 0.8);
        
    }else if (!self.titleString.length && self.messageString.length) {
        
        CGFloat height = [self.messageString getSpaceLabelHeightwithSpeace:messageLineSpace withLabel:self.messageLabel andAlignment:self.messageAlignment andWidth:viewWith-viewLeftRight*2];
        
       
        self.messageLabel.frame = CGRectMake(viewLeftRight, viewTop, viewWith-viewLeftRight*2, height);
        
        self.lineView.frame     = CGRectMake(0, self.messageLabel.bottom+msgAndLineViewSpace, viewWith, 0.8);
        
    }else
    {
        self.titleLabel.frame = CGRectMake(viewLeftRight, viewTop, viewWith-viewLeftRight*2, titleHeight);
        
        self.messageLabel.frame = CGRectMake(viewLeftRight, self.titleLabel.bottom+12, viewWith-viewLeftRight*2, [self.messageString getSpaceLabelHeightwithSpeace:messageLineSpace withLabel:self.messageLabel andAlignment:self.messageAlignment andWidth:viewWith-viewLeftRight*2]);
        
        self.lineView.frame     = CGRectMake(0, self.messageLabel.bottom+msgAndLineViewSpace, viewWith, 0.8);
        
    }
    
    if (!self.itemArr.count) {
        NSLog(@"没有item点击事件，视图无法消失");
//        if (self.showType == CJKTAlertShowType_SlideInFromTop) {
//            self.contentView.frame = CGRectMake(0, -kCJKTAlertScreenHeight, viewWith, self.lineView.bottom);
//            self.lineView.hidden = YES;
//        }else{
//            self.contentView.frame = CGRectMake(0,  0, viewWith, self.lineView.bottom);
//            self.lineView.hidden = YES;
//        }
    }else{
//        if (self.showType == CJKTAlertShowType_SlideInFromTop) {
//
//             self.contentView.frame = CGRectMake(kCJKTAlertScreenWidth/2-viewWith/2, -kCJKTAlertScreenHeight, viewWith, self.lineView.bottom+btnHeight);
//
//        }
//        else if (self.showType == CJKTAlertShowType_SlideInFromBottom){
//
//            self.contentView.frame = CGRectMake(kCJKTAlertScreenWidth/2-viewWith/2, kCJKTAlertScreenHeight, viewWith, self.lineView.bottom+btnHeight);
//
//        }
//        else if (self.showType == CJKTAlertShowType_SlideInFromLeft){
//            self.contentView.centerY = self.centerY;
//            self.contentView.frame = CGRectMake(-kCJKTAlertScreenWidth, 0, viewWith, self.lineView.bottom+btnHeight);
//
//        }
//        else if (self.showType == CJKTAlertShowType_SlideInFromRight){
//            self.contentView.centerY = self.centerY;
//            self.contentView.frame = CGRectMake(kCJKTAlertScreenWidth, 0, viewWith, self.lineView.bottom+btnHeight);
//
//        }
//        else{
//
//            self.contentView.frame = CGRectMake(kCJKTAlertScreenWidth/2-viewWith/2,  kCJKTAlertScreenHeight/2-(self.lineView.bottom+btnHeight)/2 ,viewWith, self.lineView.bottom+btnHeight);
//
//        }
//
          self.contentView.frame = CGRectMake(kCJKTAlertScreenWidth/2-viewWith/2,  kCJKTAlertScreenHeight/2-(self.lineView.bottom+btnHeight)/2 ,viewWith, self.lineView.bottom+btnHeight);
       
       
        
        //只做最多3个按钮
        [self creatButtonWithCount:(self.itemArr.count > 3 ? 3 : self.itemArr.count)];
        
    }
    
}

- (void)creatButtonWithCount:(NSInteger)btncount
{
    CGFloat btnW = viewWith/btncount;
    CGFloat btnH = btnHeight;
    CGFloat btnY = self.lineView.bottom;
    
    for (int  i = 0; i < btncount; i ++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(btnW*i, btnY, btnW, btnH)];
        [button setTitle:self.itemArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:button];
        [button addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArr addObject:button];
        button.tag = 10+i;
        
    }
    
    if (btncount > 1) {
        for (int i = 1; i < btncount; i ++) {
            
            UIView *btnLineView = [[UIView alloc] initWithFrame:CGRectMake(btnW*i, btnY, 0.5, btnH)];
            btnLineView.backgroundColor = [UIColor grayColor];
            [self.contentView addSubview:btnLineView];
            [self.btnLineArr addObject:btnLineView];
            
        }
    }
    
}

#pragma mark - 点击事件

- (void)cancelButtonAction:(UIButton *)btn
{
    __weak typeof(self) weakSelf = self;
    if (self.dismissType) {
        switch (self.dismissType) {
            case CJKTAlertDismissType_None:
            {
                weakSelf.contentView.transform = CGAffineTransformIdentity;
                [UIView animateWithDuration:kDefaultAnimateDuration animations:^{
                    weakSelf.contentView.alpha = 0;
                    weakSelf.alpha = 0;
                } completion:^(BOOL finished) {
                    [weakSelf removeFromSuperview];
                    weakSelf.contentView = nil;
                    if (weakSelf.finishBlock) {
                        weakSelf.finishBlock(btn.tag-10);
                    }
                }];
            }
                break;
            case CJKTAlertDismissType_ShrinkOut:
            {
                weakSelf.contentView.transform = CGAffineTransformIdentity;
                [UIView animateWithDuration:kDefaultAnimateDuration animations:^{
                    weakSelf.contentView.alpha = 0;
                    weakSelf.alpha = 0;
                    weakSelf.contentView.transform = CGAffineTransformMakeScale(0.0001,0.0001);
                } completion:^(BOOL finished) {
                    [weakSelf removeFromSuperview];
                    weakSelf.contentView = nil;
                    if (weakSelf.finishBlock) {
                        weakSelf.finishBlock(btn.tag-10);
                    }
                }];
            }
                break;
            default:
                break;
        }
    
    }else{
        weakSelf.contentView.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:kDefaultAnimateDuration animations:^{
            weakSelf.contentView.alpha = 0;
            weakSelf.alpha = 0;
           
        } completion:^(BOOL finished) {
            [weakSelf removeFromSuperview];
            weakSelf.contentView = nil;
            if (weakSelf.finishBlock) {
                weakSelf.finishBlock(btn.tag-10);
            }
        }];
    }
    


    
}

#pragma mark -- 显示
- (void)show{
    if (self.showType) {
        __weak typeof(self) weakSelf = self;
        switch (self.showType) {
           
            case CJKTAlertShowType_FadeIn:{
                 self.contentView.frame = CGRectMake(kCJKTAlertScreenWidth/2-viewWith/2,  kCJKTAlertScreenHeight/2-(self.lineView.bottom+btnHeight)/2 ,viewWith, self.lineView.bottom+btnHeight);
                self.contentView.transform = CGAffineTransformMakeScale(0.0, 0.0);
                [UIView animateWithDuration:kDefaultAnimateDuration animations:^{
                    weakSelf.alpha = 1;
                    weakSelf.contentView.alpha = 1;
                    weakSelf.contentView.transform = CGAffineTransformIdentity;
                } completion:nil];
            }
                break;
                
            case CJKTAlertShowType_ShrinkIn:{
               self.contentView.frame = CGRectMake(kCJKTAlertScreenWidth/2-viewWith/2,  kCJKTAlertScreenHeight/2-(self.lineView.bottom+btnHeight)/2 ,viewWith, self.lineView.bottom+btnHeight);
                self.contentView.transform = CGAffineTransformMakeScale(1.5,1.5);
                [UIView animateWithDuration:kDefaultAnimateDuration animations:^{
                    weakSelf.alpha = 1;
                    weakSelf.contentView.alpha = 1;
                    weakSelf.contentView.transform = CGAffineTransformIdentity;
                } completion:nil];
                
            }
                break;
                
            case CJKTAlertShowType_SlideInFromTop:{
             
               CGRect startFrame = CGRectMake(kCJKTAlertScreenWidth/2-viewWith/2,  kCJKTAlertScreenHeight/2-(self.lineView.bottom+btnHeight)/2 ,viewWith, self.lineView.bottom+btnHeight);
                startFrame.origin.y = - CGRectGetHeight(startFrame);
                weakSelf.contentView.frame = startFrame;
                [UIView animateWithDuration:kDefaultAnimateDuration animations:^{
                  
                    weakSelf.contentView.transform = CGAffineTransformMakeTranslation(0, 2*CGRectGetHeight(startFrame));
                    weakSelf.alpha = 1;
                    weakSelf.contentView.alpha = 1;
                } completion:^(BOOL finished) {
             
                }];
               
                
            }
                break;
                
            case CJKTAlertShowType_SlideInFromBottom:{
               
                CGRect startFrame = CGRectMake(kCJKTAlertScreenWidth/2-viewWith/2,  kCJKTAlertScreenHeight/2-(self.lineView.bottom+btnHeight)/2 ,viewWith, self.lineView.bottom+btnHeight);
                startFrame.origin.y = 2*CGRectGetHeight(startFrame);
                weakSelf.contentView.frame = startFrame;
                [UIView animateWithDuration:kDefaultAnimateDuration animations:^{
                    
                    weakSelf.contentView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(startFrame));
                    
                    weakSelf.alpha = 1;
                    weakSelf.contentView.alpha = 1;
                    
                } completion:^(BOOL finished) {
//                 weakSelf.contentView.transform = CGAffineTransformIdentity;
                }];
                
            }
                break;
                
            case CJKTAlertShowType_SlideInFromLeft:{
              
                CGRect startFrame = CGRectMake(kCJKTAlertScreenWidth/2-viewWith/2,  kCJKTAlertScreenHeight/2-(self.lineView.bottom+btnHeight)/2 ,viewWith, self.lineView.bottom+btnHeight);
                startFrame.origin.x = - CGRectGetWidth(startFrame);
                weakSelf.contentView.frame = startFrame;
                [UIView animateWithDuration:kDefaultAnimateDuration animations:^{
//                    weakSelf.contentView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(startFrame), 0);
                    weakSelf.contentView.frame = CGRectMake(kCJKTAlertScreenWidth/2-self->viewWith/2,  kCJKTAlertScreenHeight/2-(self.lineView.bottom+self->btnHeight)/2 ,self->viewWith, self.lineView.bottom+self->btnHeight);
                    weakSelf.alpha = 1;
                    weakSelf.contentView.alpha = 1;
                    
                } completion:^(BOOL finished) {
                }];
            }
                break;
                
                
            case CJKTAlertShowType_SlideInFromRight:{
                CGRect startFrame = CGRectMake(kCJKTAlertScreenWidth/2-viewWith/2,  kCJKTAlertScreenHeight/2-(self.lineView.bottom+btnHeight)/2 ,viewWith, self.lineView.bottom+btnHeight);
                startFrame.origin.x = 2*CGRectGetWidth(self.bounds);
                weakSelf.contentView.frame = startFrame;
                [UIView animateWithDuration:kDefaultAnimateDuration animations:^{
                    //                    weakSelf.contentView.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(startFrame), 0);
                    weakSelf.contentView.frame = CGRectMake(kCJKTAlertScreenWidth/2-self->viewWith/2,  kCJKTAlertScreenHeight/2-(self.lineView.bottom+self->btnHeight)/2 ,self->viewWith, self.lineView.bottom+self->btnHeight);
                    weakSelf.alpha = 1;
                    weakSelf.contentView.alpha = 1;
                    
                } completion:^(BOOL finished) {
                }];
                
            }
                break;
                
                
            default:{
               
            }
                break;
        }
    }else{
        __weak typeof(self) weakSelf = self;
        weakSelf.contentView.center = self.center;
        
        [UIView animateWithDuration:kDefaultAnimateDuration delay:0.0
                            options:UIViewAnimationOptionCurveLinear // 动画的过渡效果：匀速执行
                         animations:^{
                             weakSelf.alpha = 1;
                             weakSelf.contentView.alpha = 1;
                             weakSelf.contentView.transform = CGAffineTransformIdentity;
                            
                         } completion:^(BOOL finished) {
                             
                         }];
    }
    
    
    
    
    
}

#pragma mark -- 隐藏
-(void)dissMiss{
    
}

#pragma mark - data

- (void)setTitleString:(NSString *)titleString
{
    if (_titleString != titleString) {
        _titleString = titleString;
    }
    
    if (!_titleString.length) return;
    
    self.titleLabel.text = titleString;
    
}

- (void)setMessageString:(NSString *)messageString
{
    if (_messageString != messageString) {
        _messageString = messageString;
    }
    
    if (!_messageString.length) return;
    
    self.messageLabel.text = messageString;
    self.messageLabel.attributedText = [messageString stringWithParagraphlineSpeace:messageLineSpace andAlignment:self.messageAlignment andLabel:self.messageLabel];
    
}

- (void)setLineViewColor:(UIColor *)lineViewColor
{
    if (_lineViewColor != lineViewColor) {
        _lineViewColor = lineViewColor;
    }
    
    _lineView.backgroundColor = lineViewColor;
    
    for (int i = 0; i < self.btnLineArr.count; i ++) {
        
        UIView *btnLineView = self.btnLineArr[i];
        btnLineView.backgroundColor = lineViewColor;
    }
    
}

- (void)setItemTitleColorArr:(NSArray<UIColor *> *)itemTitleColorArr
{
    if (_itemTitleColorArr != itemTitleColorArr) {
        _itemTitleColorArr = itemTitleColorArr;
    }
    
    if (self.buttonArr.count < 1) {
        
        NSLog(@"没有item");
        return;
    }
    if (itemTitleColorArr.count < 1) {
        
        NSLog(@"没有颜色");
        return;
    }
    
    if (self.buttonArr.count > self.itemTitleColorArr.count) {
        
        for (int i = 0; i < itemTitleColorArr.count; i ++) {
            
            UIButton *button = self.buttonArr[i];
            [button setTitleColor:self.itemTitleColorArr[i] forState:UIControlStateNormal];
        }
    }else{
        
        for (int i = 0; i < self.buttonArr.count; i ++) {
            
            UIButton *button = self.buttonArr[i];
            [button setTitleColor:self.itemTitleColorArr[i] forState:UIControlStateNormal];
        }
    }
}

- (void)setTransverseLineHidden:(BOOL)transverseLineHidden
{
    if (_transverseLineHidden != transverseLineHidden) {
        _transverseLineHidden = transverseLineHidden;
    }
    
    self.lineView.hidden = transverseLineHidden;
    
    if (transverseLineHidden) {
        
        for (int i = 0; i < self.btnLineArr.count; i ++) {
            
            UIView *btnLineView = self.btnLineArr[i];
            btnLineView.height = btnHeight*0.4;
            btnLineView.top += btnHeight*0.3;
            //btnLineView.hidden = YES;//设置隐藏竖线
        }
        
    }else{
        
        for (int i = 0; i < self.btnLineArr.count; i ++) {
            
            UIView *btnLineView = self.btnLineArr[i];
            btnLineView.height = btnHeight;
            btnLineView.top = self.lineView.bottom;
            //btnLineView.hidden = NO;
        }
    }
    
}

- (void)setButtonFont:(UIFont *)buttonFont
{
    if (_buttonFont != buttonFont) {
        _buttonFont = buttonFont;
    }
    
    for (int i = 0; i < self.buttonArr.count; i ++) {
        
        UIButton *button = self.buttonArr[i];
        button.titleLabel.font = buttonFont;
    }
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    if (_titleLabelFont != titleLabelFont) {
        _titleLabelFont = titleLabelFont;
    }
    
    if (!_titleLabel) return;
    
    _titleLabel.font = titleLabelFont;
    
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    if (_titleLabelColor != titleLabelColor) {
        _titleLabelColor = titleLabelColor;
    }
    
    if (!_titleLabel) return;
    
    _titleLabel.textColor = titleLabelColor;
    
}

- (void)setMessageLabelColor:(UIColor *)messageLabelColor
{
    if (_messageLabelColor != messageLabelColor) {
        _messageLabelColor = messageLabelColor;
    }
    
    if (!_messageLabel) return;
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithAttributedString:_messageLabel.attributedText];
    // 创建文字属性
    NSDictionary * attriBute = @{NSForegroundColorAttributeName:messageLabelColor, NSFontAttributeName:self.messageLabel.font };
    [attri addAttributes:attriBute range:NSMakeRange(0, self.messageString.length)];
    _messageLabel.attributedText = attri;
    
}

- (void)messageLabelTextColorWith:(NSRange)range andColor:(UIColor *)color
{
    if (!_messageLabel) return;
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithAttributedString:_messageLabel.attributedText];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
    _messageLabel.attributedText = attri;
}




- (void)dealloc
{
    NSLog(@"销毁");
}





@end