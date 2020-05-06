//
//  HWRefreshGifImages.h
//  WannyEnglish
//
//  Created by edz on 2020/4/2.
//  Copyright © 2020 wanny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWRefreshGifImages : NSObject
@property (nonatomic,strong) NSArray *images;

+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
