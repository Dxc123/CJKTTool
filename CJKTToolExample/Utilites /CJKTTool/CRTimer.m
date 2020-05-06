//
//  CRTimer.m
//  GCD定时器
//
//  Created by caoran on 2019/12/15.
//  Copyright © 2019 s. All rights reserved.
//

#import "CRTimer.h"
static NSMutableDictionary *timeDic_;
static NSMutableDictionary *taskDic_;
static dispatch_semaphore_t semaphore_;
@implementation CRTimer
+  (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timeDic_ = [NSMutableDictionary dictionary];
        taskDic_ = [NSMutableDictionary dictionary];
        semaphore_ = dispatch_semaphore_create(1);
    });
}
+ (void)execTask:(void (^)(void))task
           start:(NSTimeInterval)start
        interval:(NSTimeInterval)interval
         repeats:(BOOL)repeats
           async:(BOOL)async
            name:(nonnull NSString *)name
{
    if (!task || (repeats && interval <= 0) || start < 0 || !name.length) {
        return;
    }
    
    // 队列
    dispatch_queue_t queue = async? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    
    // timer
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设定时间
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    [timeDic_ setObject:timer forKey:name];
    [taskDic_ setObject:task forKey:name];
    dispatch_semaphore_signal(semaphore_);
    
    // 设置回调
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeats) {
            [self cancelTask:name];
        }
    });
    
    dispatch_resume(timer);
    
    
}
+ (void)execTaskWithTarget:(id)target
                  selector:(SEL)selector
                     start:(NSTimeInterval)start
                  interval:(NSTimeInterval)interval
                   repeats:(BOOL)repeats
                     async:(BOOL)async
                      name:(nonnull NSString *)name {
    if (!target || !selector) return;
    __weak id weakTarget = target;
    [self execTask:^{
        if ([weakTarget respondsToSelector:selector]) {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [weakTarget performSelector:selector];
            #pragma clang diagnostic pop
        }
    } start:start interval:interval repeats:repeats async:async name:name];
}

+ (void)cancelTask:(NSString *)name {
    if (!name.length) return;
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    dispatch_source_t timer = timeDic_[name];
    if (timer) {
        dispatch_source_cancel(timer);
        [timeDic_ removeObjectForKey:name];
    }
    dispatch_semaphore_signal(semaphore_);
    
}
+ (void)advanceExecAndCancel:(NSString *)name{
    if (!name.length) return;
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    dispatch_source_t timer = timeDic_[name];
    if (timer) {
        dispatch_source_cancel(timer);
        [timeDic_ removeObjectForKey:name];
    }
    id task = taskDic_[name];
    if (task) {
        ((void(^)(void))task)();
    }
    dispatch_semaphore_signal(semaphore_);
}
@end
