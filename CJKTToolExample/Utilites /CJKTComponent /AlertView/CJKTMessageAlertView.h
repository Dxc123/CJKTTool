//
//  CJKTMessageAlertView.h
//  橙子数学
//
//  Created by mac-01 on 2016/12/28.
//  Copyright © 2016年 杭州秀铂科技网络有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJKTMessageAlertView : UIView

@property (nonatomic, copy)void(^alertViewDidDismissBlock)(void);

@property (copy,nonatomic) NSString *message;

@property (nonatomic, assign) NSTimeInterval dismissInterval;

/**
animation Show (从下往上)
 */

-(void)alertViewAnimationWithShow:(BOOL)show;

@end
