//
//  HWGifFooter.m
//  WannyEnglish
//
//  Created by edz on 2020/4/3.
//  Copyright © 2020 wanny. All rights reserved.
//

#import "HWGifFooter.h"
#import "HWRefreshGifImages.h"
#define refreshingTime 2
@interface HWGifFooter ()

@end
@implementation HWGifFooter
- (void)prepare {
    [super prepare];
    //GIF数据
    NSArray * idleImages = [self getRefreshingImageArrayWithStartIndex:[HWRefreshGifImages sharedInstance].images.count - 1 endIndex:[HWRefreshGifImages sharedInstance].images.count - 1];
    NSArray * refreshingImages = [self getRefreshingImageArrayWithStartIndex:0 endIndex:[HWRefreshGifImages sharedInstance].images.count - 1];
    NSArray * willRefreshImages = [self getRefreshingImageArrayWithStartIndex:30 endIndex:50];
    //普通状态
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    //即将刷新状态
    [self setImages:willRefreshImages duration:1 forState:MJRefreshStatePulling];
    
    //正在刷新状态
    [self setImages:refreshingImages duration:refreshingTime forState:MJRefreshStateRefreshing];
}
- (void)placeSubviews {
    [super placeSubviews];
    CGFloat width = 30;
    CGFloat height = 30;
    self.gifView.frame = CGRectMake((self.width - width)*0.5, (self.height - height)*0.5, width, height);
    self.gifView.contentMode = UIViewContentModeScaleToFill;
}
- (UILabel *)hw_stateLabel {
    return self.stateLabel;
}


#pragma mark - 获取资源图片
- (NSArray *)getRefreshingImageArrayWithStartIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSMutableArray * imageArray = [NSMutableArray array];
    for (NSUInteger i = startIndex; i <= endIndex; i++) {
        UIImage * image = [HWRefreshGifImages sharedInstance].images[i];
        if (image) {
            [imageArray addObject:image];
        }
    }
    return imageArray;
}
@end
