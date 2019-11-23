//
//  CJKTMessageAlertView.m
//  橙子数学
//
//  Created by mac-01 on 2016/12/28.
//  Copyright © 2016年 杭州秀铂科技网络有限公司. All rights reserved.
//

#import "CJKTMessageAlertView.h"
#import "Masonry.h"
//#import "UIColor+CJKTExtention.h"
//屏幕宽高
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
@interface CJKTMessageAlertView ()
{
    UIView *_backView;
    
    BOOL _isShowing;
    
}

@property (nonatomic, strong) UILabel *alert;

@property (nonatomic, strong) NSMutableArray *messageArr;

@end

static const NSTimeInterval kAlertTimeInterval = 1.5;

@implementation CJKTMessageAlertView


#pragma mark -animation Show (从下往上)

-(void)alertViewAnimationWithShow:(BOOL)show{
    
    CGFloat endOringY = CGRectGetHeight(self.frame) - 100;
    
    CGFloat originY = show ? endOringY : kScreenH + 20;
    
    [self layoutIfNeeded];
    [_backView layoutIfNeeded];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect alertViewRect = self.alert.frame;
        alertViewRect.origin.y =originY;
        self.alert.frame = alertViewRect;
        
        CGRect backViewRect = self->_backView.frame;
        backViewRect.origin.y  = originY-10;
        self->_backView.frame = backViewRect;
        
        [self layoutIfNeeded];
        [self->_backView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (!show) {
            
            if (self->_alertViewDidDismissBlock) {
                weakSelf.alertViewDidDismissBlock();
            }
            [self removeFromSuperview];
        }
    }];
}


#pragma mark - setter getter
-(void)setMessage:(NSString *)message{
    
    _message =message;
    
    self.alert.text=message;

    [self.alert sizeToFit];

    [_backView setNeedsLayout];
    [_backView layoutIfNeeded];
   
    _backView.layer.cornerRadius = CGRectGetHeight(_backView.frame)/2;
    _backView.layer.masksToBounds =YES;
    
    [self alertViewAnimationWithShow:YES];
    
    
    NSTimeInterval timeInteval = self.dismissInterval == 0 ? kAlertTimeInterval : self.dismissInterval;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInteval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self alertViewAnimationWithShow:NO];
    
    });
    
}
-(UILabel *)alert{
    if (!_alert) {
        
        _backView =[[UIView alloc]init];
        [self addSubview:_backView];
        
        _alert =[[UILabel alloc]init];
        
        [self addSubview:_alert];
        [_alert mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(self.mas_bottom).with.offset(10);
            make.left.mas_greaterThanOrEqualTo(50);
            
            make.width.and.height.mas_greaterThanOrEqualTo(10);
        }];
        _alert.numberOfLines = 0;
        _alert.textColor =[UIColor whiteColor];
        _alert.textAlignment = NSTextAlignmentCenter;
        _alert.font =[UIFont systemFontOfSize:15];
       
        
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self->_alert.mas_top).offset(-10);
            make.bottom.equalTo(self->_alert.mas_bottom).offset(10);
            make.left.equalTo(self->_alert.mas_left).offset(-30);
            make.right.equalTo(self->_alert.mas_right).offset(30);
        }];
        _backView.backgroundColor =[[UIColor blackColor] colorWithAlphaComponent:0.7];
        
       
    }
    return _alert;
}

- (NSMutableArray *)messageArr {
    
    if(!_messageArr) {
        
        _messageArr = [NSMutableArray array];
        
    }
    
    return _messageArr;
    
}

- (BOOL)readMessageFromPool {
    
    if(self.messageArr.count == 0) {
        
        return NO;
        
    }
    
    NSString *message = [self.messageArr firstObject];
    
    self.message = message;
    
    [self.messageArr removeObject:message];
    
    return YES;
    
}

- (void)addMessageInPool:(NSString *)message {
    
    [self.messageArr addObject:message];
    
    [self readMessageFromPool];
    
}



@end
