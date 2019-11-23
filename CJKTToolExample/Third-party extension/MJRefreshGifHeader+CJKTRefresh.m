//
//  MJRefreshGifHeader+CJKTRefresh.m
//  橙子数学
//
//  Created by mac-01 on 2017/9/8.
//  Copyright © 2017年 杭州秀铂科技网络有限公司. All rights reserved.
//

#import "MJRefreshGifHeader+CJKTRefresh.h"

const NSTimeInterval CJKTRefreshTime = 1.0;

@implementation MJRefreshGifHeader (CJKTRefresh)

+ (instancetype)refreshWithCJKTGif:(MJRefreshComponentRefreshingBlock)refreshBlock {

    NSMutableArray *images = [NSMutableArray arrayWithCapacity:38];
    for (int i =0; i<40; i++) {
        NSString *imageName = [NSString stringWithFormat:@"supermanRefresh_000%02d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [images addObject:image];
    }
    
    MJRefreshGifHeader *header =  [MJRefreshGifHeader headerWithRefreshingBlock:refreshBlock];
    
    [header setImages:@[[UIImage imageNamed:@"supermanRefresh_00000"]]  duration:CJKTRefreshTime forState:MJRefreshStateIdle];
    [header setImages:@[[UIImage imageNamed:@"supermanRefresh_00000"]] duration:CJKTRefreshTime forState:MJRefreshStatePulling];
    [header setImages:images duration:CJKTRefreshTime forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    
    return header;
    
}

@end
