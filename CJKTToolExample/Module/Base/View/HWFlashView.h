//
//  HWFlashView.h
//  WannyEnglish
//
//  Created by caoran on 2020/1/12.
//  Copyright © 2020 wanny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HWFlashView : UIView
- (instancetype)initWithFrontView:(UIView *)frontView;
- (void)stopShow;
@end

NS_ASSUME_NONNULL_END
