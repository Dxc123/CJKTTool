//
//  LanguageManager.h
//  AUNewProject
//
//  Created by daixingchuang on 2020/11/19.
//  Copyright © 2020 cc. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface LanguageManager : NSObject

+ (instancetype)shared;
/**
 设置语言
 */
-(void)setUserLanguage:(NSString *)language;

@end

NS_ASSUME_NONNULL_END
