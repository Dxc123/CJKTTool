//
//  LoginUserModel.h
//  AUNewProject
//
//  Created by daixingchuang on 2020/12/16.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface LoginUserModel : NSObject
//额外的字段
@property (nonatomic, assign) NSInteger createdate;

//个人信息
@property(nonatomic,copy)  NSString   *uid;               // 用户ID
@property(nonatomic,copy)  NSString   *nickname;          // 昵称
@property(nonatomic,copy)  NSString   *portrait;          // 头像
@property(nonatomic,assign)NSInteger  gender;             // 性别
/**
@property(nonatomic,assign)NSInteger        likeCount;           被关注数
@property(nonatomic,assign)NSInteger        followCount;        // 关注数
@property(nonatomic,assign)long       birthday;           // 出生日期 时间戳
@property(nonatomic,assign)NSInteger auth;// 认证状态，0是未认证，1是认证中，2是认证成功，-1是认证失敗

@property(nonatomic,assign)NSInteger  isDND;              // 是否设置了免打扰 1已设置
@property(nonatomic,assign)NSInteger  deposit;            // 剩余钻石数
@property(nonatomic,assign)NSInteger  totalInpour;        // 总儲值的鑽石数量
@property(nonatomic,assign)NSInteger  penalty;// 该用户是否被封禁 1是, 0不是
@property (nonatomic, assign) BOOL    created;// 是否是新用户  1 是，0 不是

//VIP相关
@property(nonatomic,assign)long       vipEndTime; // vip到期时间
@property(nonatomic,assign)int        level;      // 用户头衔 0无等级；1周订阅; 2月订阅
@property(nonatomic,assign)int        status;     // 等级状态，用户订阅状态. 0 没订阅；1 新订阅；2 续订；3变更订阅，4退订
@property(nonatomic,assign)int        isValid;   // 该订阅是否有效 0:无效  1:有效
@property(nonatomic,assign)long       beginDate; // 订阅起始时间
@property(nonatomic,assign)long       endDate;    // 订阅结束时间
@property(nonatomic,assign)int        changeLevel; // 变更订阅后的等级
@property(nonatomic,assign)long       effectiveDate; // 变更订阅的生效日期



//@property(nonatomic,retain) NSArray    *charges;           // 收费设置数组，和charge搭配使用
@property(nonatomic,assign)int        charge;             // 筛选收费标志


@property(nonatomic,copy)  NSString   *photo;//展示图片的地址，以后存在多张的情况，返回第一张
@property(nonatomic,copy)  NSString   *phone;             //电话号码

@property(nonatomic,copy)  NSString   *domain;            // 行业
//@property(nonatomic,copy)  NSArray    *leaderboardArr;    // 用户排行榜
@property(nonatomic,assign)int        country;            // 国家
@property(nonatomic,assign)int        province;           // 省份
@property(nonatomic,assign)int        city;               // 城市
@property(nonatomic,assign)int        preferOfflineOption;// 偏好下线时间
@property(nonatomic,assign)int        preferOnlineOption; // 偏好上线时间
@property(nonatomic,copy)  NSString   *intro;             // 个人简介
@property(nonatomic,assign)int        activated;          // 是否接受过邀请奖励
@property(nonatomic,copy)  NSString   *bindPhoneNumberGift;//用户绑定手机赠送的钻石数

@property(nonatomic,assign)int        shells;             // 剩余贝壳数
@property(nonatomic,assign)int        income;             // 账户总收益，积分




*/

@end

NS_ASSUME_NONNULL_END
