//
//  CJKTUserModel.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/25.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "CJKTBaseModel.h"
#define HWUSERKEY @"HWUSERKEY"
#define HWUSER_USER_ID_KEY @"HWUSER_USER_ID_KEY"
#define HWUSER_TOKEN_KEY @"HWUSER_TOKEN_KEY"
NS_ASSUME_NONNULL_BEGIN

@interface CJKTUserModel : CJKTBaseModel
@property (nonatomic,copy)   NSString *token;
@property (nonatomic,assign) NSInteger user_id;
@property (nonatomic,copy)   NSString *nick_name;
@property (nonatomic,copy)   NSString *head_img;
@property (nonatomic,assign) NSInteger is_vip;
@property (nonatomic,assign) NSInteger sex;
@property (nonatomic,copy)   NSString *share_url;
@property (nonatomic,copy)   NSString *create_at;


//获取数据
+ (instancetype)getFromLocal;
//储存数据
- (void)saveToLocal;

@end

NS_ASSUME_NONNULL_END
