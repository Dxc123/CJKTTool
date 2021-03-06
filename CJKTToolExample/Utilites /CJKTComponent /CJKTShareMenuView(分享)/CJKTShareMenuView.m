//
//  CJKTShareMenuView.m
//  CJKTToolExample
//
//  Created by Dxc_iOS on 2018/11/28.
//  Copyright © 2018 CJKT. All rights reserved.
//

#import "CJKTShareMenuView.h"
#define kkScreenWidth [UIScreen mainScreen].bounds.size.width
#define kkScreenHeight [UIScreen mainScreen].bounds.size.height
#define ItemH kw(100)
#define kw(R)   (R) * (kScreenWidth) / 375.0
@interface CJKTShareMenuView ()
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imgNameArray;
@property (nonatomic, copy) void (^blockTapAction)(CJKTSharePlatformType platformType);
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end

@implementation CJKTShareMenuView
+ (void)showShareMenuViewWithTitleArray:(NSArray *)titleArray
                           imgNameArray:(NSArray *)imgNameArray
                      completionHandler:(void(^)(CJKTSharePlatformType platformType))completionHandler{
    if (titleArray.count != imgNameArray.count || !titleArray.count) {
        return;
    }
    
    CJKTShareMenuView * modeView = [[CJKTShareMenuView alloc] initWithFrame:CGRectMake(0, 0, kkScreenWidth, kkScreenHeight)];
    modeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    modeView.alpha = 0;
    modeView.titleArray = titleArray;
    modeView.imgNameArray = imgNameArray;
    modeView.blockTapAction = completionHandler;
    
    [[UIApplication sharedApplication].keyWindow addSubview:modeView];
    
    // 创建内容
    [modeView setupContentView];
    
    [modeView show];
    [modeView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:modeView action:@selector(dismiss)]];
}

- (void)setupContentView{
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kkScreenHeight, kkScreenWidth, kw(50) + ((self.titleArray.count-1)/4+1)*ItemH + kw(30)*2)];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(kw(20), kw(15))];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.contentView.layer addSublayer:shapeLayer];
    [self addSubview:self.contentView];
    
    [self setupContent];
    [self setupCancleBtn];
}

- (void)setupContent{
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.bounds.size.width/2-kw(50),kw(15), kw(100), kw(30))];
    titleLab.text = @"分享给好友";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:15.f];
   
    [self.contentView addSubview:titleLab];
    self.buttonArray = [[NSMutableArray alloc] init];
    CGFloat itemW = (self.contentView.bounds.size.width-kw(30))/4;
    for (int i = 0; i < self.titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.frame = CGRectMake(kw(15) + i%4*itemW, kw(45) + i/4*ItemH, itemW, ItemH);
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.46f green:0.50f blue:0.54f alpha:1.00f] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.imgNameArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        
        // button标题/图片的偏移量
        button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.bounds.size.height + kw(10), -button.imageView.bounds.size.width, 0,0);
        button.imageEdgeInsets = UIEdgeInsetsMake(kw(5), button.titleLabel.bounds.size.width/2, button.titleLabel.bounds.size.height + kw(5), -button.titleLabel.bounds.size.width/2);
        [self.buttonArray addObject:button];
        
        button.alpha = 0;
        button.transform = CGAffineTransformMakeTranslation(0, self.contentView.bounds.size.height);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showButtonAnimate];
    });
}

#pragma mark --showButton 动画
- (void)showButtonAnimate{
    
    for (int i = 0; i < self.buttonArray.count; i++) {
        
        UIButton *button = self.buttonArray[i];
//        弹簧动画
        [UIView animateWithDuration:0.7 delay:i*0.05 - i/4*0.2 usingSpringWithDamping:0.7 initialSpringVelocity:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            button.alpha = 1;
            button.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
}

// 取消按钮
- (void)setupCancleBtn{
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(0, self.contentView.bounds.size.height - kw(50), self.contentView.bounds.size.width, kw(50));
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    cancleButton.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, cancleButton.bounds.size.width, 1);
    layer.backgroundColor = [UIColor colorWithRed:0.98f green:0.98f blue:0.98f alpha:1.00f].CGColor;
    [cancleButton.layer addSublayer:layer];
    
    [self.contentView addSubview:cancleButton];
}

#pragma mark -- 显示
- (void)show{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.contentView.transform = CGAffineTransformMakeTranslation(0, -self.contentView.bounds.size.height);
    }];
}
#pragma mark -- 隐藏
- (void)dismiss{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0;
        self.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark -- 点击事件
- (void)tapAction:(UIButton *)button{
    
    [self dismiss];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.blockTapAction) {
            self.blockTapAction(button.tag);
        }
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
