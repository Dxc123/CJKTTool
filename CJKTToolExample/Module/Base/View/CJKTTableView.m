//
//  CJKTTableView.m
//  CJKTToolExample
//
//  Created by daixingchuang on 2020/4/24.
//  Copyright © 2020 CJKT. All rights reserved.
//

#import "CJKTTableView.h"
#import <MJRefresh/MJRefresh.h>
#import "HWGIfHeader.h"
#import "HWGifFooter.h"
@interface CJKTTableView ()
@property (nonatomic,strong) HWGIfHeader *gifHeader;
@property (nonatomic,strong) HWGifFooter *gifFooter;
@end
@implementation CJKTTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self=[super initWithFrame:frame style:style];
    if(self) {

    }
    return self;
}


- (void)refreshAction {
    if(self.refreshBlock) {
        self.refreshBlock();
    }
    [self.mj_footer resetNoMoreData];
//    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:3.0];
}

- (void)loadMoreAction {
    if(self.loadMoreBlock) {
        self.loadMoreBlock();
    }
//    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:3.0];
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    return YES;
}

- (void)setEnableRefresh:(BOOL)enableRefresh {
    if(!enableRefresh) {
        self.mj_header = nil;
    }else {
        @weakify(self)
        HWGIfHeader * head = [HWGIfHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self refreshAction];
        }];
        head.lastUpdatedTimeLabel.hidden = YES;
        head.stateLabel.hidden = YES;
        self.mj_header = head;
    }
}

- (void)setEnableFooter:(BOOL)enableFooter {
    _enableFooter = enableFooter;
    if(!enableFooter) {
        self.mj_footer = nil;
    }else {
        @weakify(self)
        HWGifFooter * footer =[HWGifFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self loadMoreAction];
        }];
        footer.hw_stateLabel.hidden = YES;
        self.mj_footer = footer;
    }
}


- (void)stopRefresh {
    if([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    
    if([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

- (void)noMoreData {
    ((HWGifFooter *)self.mj_footer).hw_stateLabel.hidden = NO;
    [self.mj_footer endRefreshingWithNoMoreData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
