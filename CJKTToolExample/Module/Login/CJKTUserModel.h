//
//  CJKTUserModel.h
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/25.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "CJKTBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CJKTUserModel : CJKTBaseModel
@property (nonatomic,copy)   NSString *token;
@property (nonatomic,assign) NSInteger user_id;
@property (nonatomic,copy)   NSString *nick_name;
@property (nonatomic,copy)   NSString *head_img;


//获取数据
+ (instancetype)getFromLocal;

//储存数据
- (void)saveToLocal;

//清空所有数据
+ (void)deleteAllData;
@end

NS_ASSUME_NONNULL_END
