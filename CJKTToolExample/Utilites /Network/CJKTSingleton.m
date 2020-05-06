//
//  CJKTSingleton.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/25.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "CJKTSingleton.h"
#import "CJKTUserModel.h"
@implementation CJKTSingleton

+ (instancetype)sharedInstance {
    static CJKTSingleton *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[CJKTSingleton alloc] init];
        
    });
    return _sharedInstance;
}

- (BOOL)isLogin {
    return self.myUser.token.length;
}

- (void)clearUser {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:HWUSERKEY];
//    self.myUser = nil;
   
}
@end
