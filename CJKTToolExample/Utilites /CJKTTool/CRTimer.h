//
//  CRTimer.h
//  GCD定时器
//
//  Created by caoran on 2019/12/15.
//  Copyright © 2019 s. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CRTimer : NSObject


/// GCD定时器(Block)
/// @param task 执行任务
/// @param start 开始时间
/// @param interval 间隔时间
/// @param repeats 是否重复
/// @param async 是否异步
/// @param name 执行任务名称
+ (void)execTask:(void(^)(void))task
           start:(NSTimeInterval)start
        interval:(NSTimeInterval)interval
         repeats:(BOOL)repeats
           async:(BOOL)async
            name:(NSString *)name;


/// GCD定时器(target)
/// @param target target
/// @param selector selector
/// @param start 开始时间
/// @param interval 间隔时间
/// @param repeats 是否重复
/// @param async 是否异步
/// @param name 执行任务名称
+ (void)execTaskWithTarget:(id)target
                  selector:(SEL)selector
                     start:(NSTimeInterval)start
                  interval:(NSTimeInterval)interval
                   repeats:(BOOL)repeats
                     async:(BOOL)async
                      name:(NSString *)name;
                

/// 取消计时任务
/// @param name 执行任务名称
+ (void)cancelTask:(NSString *)name;

/**
 提前执行代码,并取消计时
 */

+ (void)advanceExecAndCancel:(NSString *)name;


/**
 int count = 60;
 @weakify(self)
 [CRTimer execTask:^{
 @strongify(self)
     if (count == 0) {
         self.VerificationBtn.titleLabel.text = @"获取验证码";
         [CRTimer cancelTask:@"loginVerification"];
     }
     [weakSelf.VerificationBtn setTitle:[NSString stringWithFormat:@"获取验证码(%d)",count--] forState:UIControlStateDisabled];
 } start:0 interval:1 repeats:YES async:NO name:@"loginVerification"];
 */

@end

NS_ASSUME_NONNULL_END
