//
//  CJKTUserModel.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/25.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "CJKTUserModel.h"

@implementation CJKTUserModel

+ (instancetype)getFromLocal {
    return [self cjkt_unArchivedObjectWithKey:NSStringFromClass(self)];
}
- (void)saveToLocal {
//    NSString *str = NSStringFromClass(self);
//    CJKTLog(@"str");
    [self cjkt_archivedDataWithKey:@"CJKTUserModel"];
}

//清空所有数据
+ (void)deleteAllData{
    [self cjkt_clearAllData:NSStringFromClass(self)];
}
@end
