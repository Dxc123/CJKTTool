//
//  HWGIfHeader.m
//  WannyEnglish
//
//  Created by edz on 2020/4/2.
//  Copyright © 2020 wanny. All rights reserved.
//

#import "HWGIfHeader.h"
#import "HWRefreshGifImages.h"
#import "CRTimer.h"
#define refreshingTime 2
@interface HWGIfHeader ()
@property (nonatomic,assign) NSUInteger timeCount;
@property (nonatomic,assign) BOOL stopRefreshing;
@end
@implementation HWGIfHeader

- (void)prepare {
    [super prepare];
    //GIF数据
    NSArray * idleImages = [self getRefreshingImageArrayWithStartIndex:[HWRefreshGifImages sharedInstance].images.count - 1 endIndex:[HWRefreshGifImages sharedInstance].images.count - 1];
    NSArray * refreshingImages = [self getRefreshingImageArrayWithStartIndex:0 endIndex:[HWRefreshGifImages sharedInstance].images.count - 1];
    NSArray * willRefreshImages = [self getRefreshingImageArrayWithStartIndex:38 endIndex:55];
    //普通状态
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    //即将刷新状态
    [self setImages:willRefreshImages duration:1 forState:MJRefreshStatePulling];
    
    //正在刷新状态
    [self setImages:refreshingImages duration:refreshingTime forState:MJRefreshStateRefreshing];
    
}
- (void)placeSubviews {
    //隐藏状态显示文字
    self.stateLabel.hidden = YES;
    //隐藏更新时间文字
    self.lastUpdatedTimeLabel.hidden = YES;
    [super placeSubviews];
    
    CGFloat width = 30;
    CGFloat height = 30;
    self.gifView.frame = CGRectMake((self.cjkt_width - width)*0.5, (self.cjkt_height - height)*0.5, width, height);
    self.gifView.contentMode = UIViewContentModeScaleToFill;
    
//    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden) {
//        self.gifView.contentMode = UIViewContentModeCenter;
//    } else {
//        self.gifView.contentMode = UIViewContentModeRight;
//
//        CGFloat stateWidth = self.stateLabel.mj_textWidth;
//        CGFloat timeWidth = 0.0;
//        if (!self.lastUpdatedTimeLabel.hidden) {
//            timeWidth = self.lastUpdatedTimeLabel.mj_textWidth;
//        }
//        CGFloat textWidth = MAX(stateWidth, timeWidth);
//        self.gifView.mj_w = self.mj_w * 0.5 - textWidth * 0.5 - self.labelLeftInset;
//    }
}
- (void)beginRefreshing {
    if (self.isRefreshing) {
        return;
    }
    self.stopRefreshing = NO;
    [super beginRefreshing];
    @weakify(self);
    [CRTimer execTask:^{
        @strongify(self);
        self.timeCount += 1;
        if (self.stopRefreshing && self.timeCount % refreshingTime == 0) {
            [super endRefreshing];
            [CRTimer cancelTask:[NSString stringWithFormat:@"%p",self]];
            self.timeCount = 0;
        }
    } start:1 interval:1 repeats:YES async:NO name:[NSString stringWithFormat:@"%p",self]];
}
- (void)endRefreshing {
    self.stopRefreshing = YES;
    if (self.timeCount == 0) {
        return;
    }
    if (self.timeCount % refreshingTime == 0) {
        [super endRefreshing];
        self.timeCount = 0;
    }
}
-(void)dealloc {
    [CRTimer cancelTask:[NSString stringWithFormat:@"%p",self]];
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
