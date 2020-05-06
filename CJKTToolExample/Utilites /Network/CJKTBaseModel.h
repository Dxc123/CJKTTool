//
//  CJKTBaseModel.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/25.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJKTBaseModel : NSObject
//编码
- (void)archivedDataWithKey:(NSString *)key;
//解码
+ (instancetype)unArchivedObjectWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
