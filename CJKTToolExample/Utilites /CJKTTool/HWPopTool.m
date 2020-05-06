//
//  TWHPopTool.m
//  JPQ
//
//  Created by LetengMacbook on 2018/12/26.
//  Copyright © 2018年 LTTangWenHong. All rights reserved.
//


#import "HWPopTool.h"
#import <Masonry.h>
#define kAPLWINDOW UIApplication.sharedApplication.delegate.window
#define backViewColor UIColorFromRGBA(0x000000, 0.7)
#define ViewKey @"ViewKey"
#define SelectorKey @"SelectorKey"
#define TapViewBackKey @"TapViewBackKey"
@interface HWPopTool ()<UIGestureRecognizerDelegate>

@end
@implementation HWPopTool
static UIView * backViewInstance;
static NSMutableArray *ViewCanTapArray_;
static NSMutableDictionary *dismissSelectorDict_;
void (^tapAction)(void);

+ (void)userPushToOtherPage {
    for (UIView *subView in backViewInstance.subviews) {
        [subView removeFromSuperview];
    }
    [[self backView] removeFromSuperview];
    [ViewCanTapArray_  removeAllObjects];
}

+ (UIView *)backView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        backViewInstance = [WindowBackView new];
        backViewInstance.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tap.delegate = backViewInstance;
        [backViewInstance addGestureRecognizer:tap];
        ViewCanTapArray_ = [NSMutableArray array];
        dismissSelectorDict_ = [NSMutableDictionary dictionary];
    });
    return backViewInstance;
}

//dismissSelector:(NSString *)dismissSelector
+ (void)configViewArray:(UIView*)view canTap:(BOOL)canTap {
    if (canTap) {
        [ViewCanTapArray_ addObject:view];
    }
}
- (BOOL)viewCanTap:(UIView *)view {
    return [ViewCanTapArray_ containsObject:view];
}
+ (void)showWithFadeAnimationView:(UIView *)view size:(CGSize)size offsetY:(CGFloat)offsetY radius:(CGFloat)radius blackBackView:(BOOL)blackBackView canTapDismiss:(BOOL)canTap {
    if (view) {
        UIView *backView = [self backView];
        backView.hidden = NO;
        backView.backgroundColor = [UIColor clearColor];
        [kAPLWINDOW addSubview:backView];
        backView.frame = kAPLWINDOW.bounds;
        [backView addSubview:view];
        view.layer.cornerRadius = radius;
        view.layer.masksToBounds = radius > 0;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(offsetY);
            make.width.offset(size.width);
            make.height.offset(size.height);
        }];
        view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -60);
        view.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            backView.backgroundColor = blackBackView?backViewColor:[UIColor clearColor];
            view.alpha = 1;
            view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
        } completion:nil];
        [self configViewArray:view canTap:canTap];
    }
}

+ (void)fadeDismissView:(UIView *)view animated:(BOOL)animated {
    if (view) {
        UIView *backView = [self backView];
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -60);
                view.alpha = 0;
                if (backView.subviews.count == 1) {
                    backView.backgroundColor = [UIColor clearColor];
                }
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
                if (backView.subviews.count == 0) {
                    [backView removeFromSuperview];
                }
            }];
        }else{
            [view removeFromSuperview];
            if (backView.subviews.count == 0) {
                [backView removeFromSuperview];
            }
        }
        [ViewCanTapArray_ removeObject:view];
    }
}

+ (void)showDownToUpView:(UIView *)view animated:(BOOL)animated radius:(CGFloat)radius size:(CGSize)size canTapDismiss:(BOOL)canTap {
    if (view) {
        UIView *backView = [self backView];
        backView.hidden = NO;
        backView.backgroundColor = [UIColor clearColor];
        [kAPLWINDOW addSubview:backView];
        backView.frame = kAPLWINDOW.bounds;
        [backView addSubview:view];
        view.layer.cornerRadius = radius;
        view.layer.masksToBounds = radius > 0;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.width.offset(size.width);
            make.height.offset(size.height);
            make.bottom.offset(0);
        }];
        if (animated) {
            view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, size.height);
            [UIView animateWithDuration:0.3 animations:^{
                backView.backgroundColor = backViewColor;
                view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
            } completion:nil];
        }
        [self configViewArray:view canTap:canTap];
    }
}

+ (void)dissmissUpToDown:(UIView *)view animated:(BOOL)animated {
    if (view) {
        UIView *backView = [self backView];
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, view.frame.size.height);
                if (backView.subviews.count == 1) {
                    backView.backgroundColor = [UIColor clearColor];
                }
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
                if (backView.subviews.count == 0) {
                    [backView removeFromSuperview];
                }
            }];
        }else{
            [view removeFromSuperview];
            if (backView.subviews.count == 0) {
                [backView removeFromSuperview];
            }
        }
        [ViewCanTapArray_ removeObject:view];
    }
}

+ (void)tap {
    kNotifPost(TapViewBackKey, nil);
    if ([ViewCanTapArray_ containsObject:backViewInstance.subviews.lastObject]) {
        UIView *lastView = (UIView *)backViewInstance.subviews.lastObject;
        [self removeView:lastView];
        if (![self backView].subviews.count) {
             [[self backView] removeFromSuperview];
        }
    }
}

+ (void)hidden:(BOOL)hide {
    if (backViewInstance.subviews.count == 0) return;
    [self backView].hidden = hide;
}
+ (void)addView:(UIView *)view withBlackColorBack:(BOOL)blackBack {
    [self addView:view];
    [self backView].backgroundColor = blackBack?backViewColor:[UIColor clearColor];
}
+ (void)addView:(UIView *)view{
    UIView *backView = [self backView];
    backView.hidden = NO;
    backView.backgroundColor = [UIColor clearColor];
    [kAPLWINDOW addSubview:backView];
    backView.frame = kAPLWINDOW.bounds;
    [backView addSubview:view];
    view.frame = [self backView].bounds;
}
+ (void)addView:(UIView *)view frame:(CGRect)frame withBlackColorBack:(BOOL)blackBack canTapCancel:(BOOL)canTap {
    UIView *backView = [self backView];
    backView.hidden = NO;
    backView.backgroundColor = [UIColor clearColor];
    [kAPLWINDOW addSubview:backView];
    backView.frame = kAPLWINDOW.bounds;
    [backView addSubview:view];
    view.frame = frame;
    [self backView].backgroundColor = blackBack?backViewColor:[UIColor clearColor];
    [self configViewArray:view canTap:canTap];
}
+ (void)removeView:(UIView *)view {
    [view removeFromSuperview];
    [[self backView] removeFromSuperview];
    [ViewCanTapArray_ removeObject:view];
}
+ (void)bringViewToFront:(UIView *)view {
    [[self backView] bringSubviewToFront:view];
}
/*************************************************************************************************/

+ (void)showWithAnimationView:(UIView *)view addView:(UIView *)addView{
    if (view) {
        [kAPLWINDOW addSubview:addView ?  : view];
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, CGFLOAT_MIN, CGFLOAT_MIN);
        [UIView animateWithDuration:0.3 animations:^{
            // 以动画的形式将view慢慢放大至原始大小的1.2倍
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                // 以动画的形式将view恢复至原始大小
                view.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}


+ (void)dismissView:(UIView *)view removeView:(UIView *)removeView animated:(BOOL)animated {
    if (view && view.superview) {
        if (animated) {
            [UIView animateWithDuration:0.2 animations:^{
                view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 animations:^{
                    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                } completion:^(BOOL finished) {
                    if (removeView) {
                        [removeView removeFromSuperview];
                    }else{
                        [view removeFromSuperview];
                    }
                }];
            }];
        }else{
            if (removeView) {
                [removeView removeFromSuperview];
            }else{
                [view removeFromSuperview];
            }
        }
    }
}

@end
@implementation WindowBackView

#pragma mark - 解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UIView *lastView = (UIView *)backViewInstance.subviews.lastObject;
    CGPoint touchPoint = [touch locationInView:self];
    if (CGRectContainsPoint(lastView.frame, touchPoint)) {
        return NO;
    }
    return YES;
}

@end
