//
//  MBProgressHUD+CJKTGifAnimation.h
//  UQKTProject
//
//  Created by Westbrook on 2018/5/22.
//  Copyright © 2018年 cjkt. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (CJKTGifAnimation)

+(MBProgressHUD *)progressViewWithGif:(BOOL)gif message:(NSString *)message superView:(UIView *)superview;

@end
