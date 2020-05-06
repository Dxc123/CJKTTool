//
//  UITextView+CJKTInputLimit.h
//  CarPooling
//
//  Created by Dxc_iOS on 2018/5/30.
//  Copyright © 2018年 代星创. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (CJKTInputLimit)
/**
 UITextView限制最大字符数 （<=0,没限制）
 */
@property (assign, nonatomic)  NSInteger cjkt_maxLength;
@end
