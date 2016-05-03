//
//  UIScrollView+LXJRefresh.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "UIScrollView+LXJRefresh.h"

@implementation UIScrollView (LXJRefresh)
- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)block
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
}
- (void)beginHeaderRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_header beginRefreshing];
    });
    
}
- (void)endHeaderRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_header endRefreshing];
    });
    
}
- (void)addfooterRefresh:(MJRefreshComponentRefreshingBlock)block
{
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
}
- (void)beginFooterRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_footer beginRefreshing];
    });
    
}
- (void)endFooterRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_footer endRefreshing];
    });
    
}

@end
