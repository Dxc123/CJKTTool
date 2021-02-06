//
//  CJKTBaseModel.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/25.
//  Copyright © 2020 CJKT. All rights reserved.
//
/**
model基类 ，继承这个model基类的 Model 类就具有了归档功能
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJKTBaseModel : NSObject
//编码
- (void)cjkt_archivedDataWithKey:(NSString *)key;
//解码
+ (instancetype)cjkt_unArchivedObjectWithKey:(NSString *)key;
//清空所有数据
+ (void)cjkt_clearAllData:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
