//
//  HWFlashView.m
//  WannyEnglish
//
//  Created by caoran on 2020/1/12.
//  Copyright © 2020 wanny. All rights reserved.
//

#import "HWFlashView.h"
@interface HWFlashView ()
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@property (nonatomic,strong) UIView *frontView;
@end
@implementation HWFlashView
- (instancetype)initWithFrontView:(UIView *)frontView {
    if (self = [super initWithFrame:CGRectZero]) {
        self.backgroundColor = kSepareLineColor;
        self.frontView = frontView;
    }
    return self;
}

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
//        _gradientLayer.colors = @[(__bridge id)[UIColor lightGrayColor].CGColor,(__bridge id)[UIColor grayColor].CGColor,(__bridge id)[UIColor grayColor].CGColor,(__bridge id)[UIColor lightGrayColor].CGColor];
        _gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0xdedede).CGColor,
                                  (__bridge id)UIColorFromRGBA(0xeaeaea, 1).CGColor,
                                  (__bridge id)UIColorFromRGBA(0xeaeaea, 1).CGColor,
                                  (__bridge id)UIColorFromRGB(0xdedede).CGColor];
//        _gradientLayer.locations = @[@(0.4),@(0.39),@(0.24),@(0.23)];
        _gradientLayer.locations = @[@(-0.4),@(0.-39),@(0.-35),@(0.-34)];
//        _gradientLayer.locations = @[];
        _gradientLayer.startPoint = CGPointMake(0.5, 0);
        _gradientLayer.endPoint = CGPointMake(0.5, 1);
//        _gradientLayer.startPoint = CGPointMake(0.5, 1);
//        _gradientLayer.endPoint = CGPointMake(0.5, 0);
        
    }
    return _gradientLayer;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self configFrame];
    
}
- (void)configFrame {
    self.gradientLayer.frame = self.bounds;
    self.gradientLayer.mask = self.frontView.layer;
    self.frontView.frame = self.gradientLayer.bounds;
}
- (void)didMoveToWindow {
    [super didMoveToWindow];
    [self.layer addSublayer:self.gradientLayer];
    [self configFrame];
    [self show];
}

- (void)show {
    self.frontView.hidden = NO;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
//    animation.fromValue = @[@(-0.8),@(-0.79),@(-0.64),@(-0.63)];
//    animation.toValue = @[@(1.5),@(1.51),@(1.76),@(1.77)];
    animation.fromValue = @[@(-1.5),@(-1),@(-0.5),@(0)];
    animation.toValue = @[@(5),@(5.5),@(6),@(6.5)];
    animation.duration = 2;
    animation.repeatCount = HUGE;
    animation.timeOffset = 0.5;
    animation.removedOnCompletion = NO;
    [self.gradientLayer addAnimation:animation forKey:nil];
}
- (void)stopShow {
    [self.gradientLayer removeAllAnimations];
    self.gradientLayer.mask = nil;
}
@end
