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
    return [self unArchivedObjectWithKey:HWUSERKEY];
}
- (void)saveToLocal {
    // 单独存userId
    [[NSUserDefaults standardUserDefaults] setValue:@(self.user_id) forKey:HWUSER_USER_ID_KEY];
    // 单独存token
    [[NSUserDefaults standardUserDefaults] setValue:self.token forKey:HWUSER_TOKEN_KEY];
    [self archivedDataWithKey:HWUSERKEY];
}
@end
