//
//  MLScaleAnimationPush.m
//  AnimationKit-demo
//
//  Created by caomenglin on 2019/10/16.
//  Copyright © 2019 caomenglin. All rights reserved.
//

#import "MLScaleAnimationPush.h"

@implementation MLScaleAnimationPush

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView* toView = nil;
    UIView* fromView = nil;
    UIView* transView = nil;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    transView = toView;
    [[transitionContext containerView] addSubview:toView];
    
     transView.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
         transView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
         [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end
