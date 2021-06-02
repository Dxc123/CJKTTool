//
//  GlobalInlineMethod.h
//  AUNewProject
//
//  Created by daixingchuang on 2021/1/21.
//  Copyright © 2021 Dxc_iOS. All rights reserved.
//
/**
 OC内联函数 inline（可参考YYKit里大量使用）
 static inline是一些框架经常出现的关键字组合
 作用:1.替代宏
 避免了宏的缺点:需要预编译.因为inline内联函数也是函数,不需要预编译
 2.提高函数调用的效率,一般只会用在函数内容非常简单的时候，因为内联函数的函数体过大,编译器会自动放弃内联
 3.不允许用循环语句和开关语句
 4.内联函数的定义须在调用之前
 */
/**
 可用于oc及swift
 */
#ifndef GlobalInlineMethod_h
#define GlobalInlineMethod_h
#import <Foundation/Foundation.h>
/**
 屏幕宽
 */
static inline CGFloat kGScreenWidth() {
    return [UIScreen mainScreen].bounds.size.width;
}
/**
屏幕高
*/
static inline CGFloat kGScreenHeight() {
    return [UIScreen mainScreen].bounds.size.height;
}
/**
  主线程更新UI
 */
static inline void kGDispatch_mainQueue(void(^block)(void)) {
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}

/**
  延迟执行
 */
static inline void kGDispatch_after(CGFloat time,dispatch_block_t block){
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);

}
/**
  异步执行
 */
static inline void kGDispatch_GlobalQueue(dispatch_block_t block) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block();
    });
   
}


//发送通知
static inline void kGPostNotification(NSString *name,id obj) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];
    });
}

/**
AppVersion
*/
static inline NSString* kGAppVersion() {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}
/**
 判断对象是否为空
 */
static inline BOOL kGNotNilAndNullObj(id _ref) {
    return (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]));
}
/**
判断字符串是否为空
*/
static inline BOOL kGNotNilAndNullString(id _ref) {
    return (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]) && (![(_ref)isEqualToString:@""]));
}


#endif /* GlobalInlineMethod_h */
