//
//  UIScrollView+LXJRefresh.h
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

@interface UIScrollView (LXJRefresh)
//添加头部刷新
- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)block;
//开始头部刷新
- (void)beginHeaderRefresh;
//结束头部刷新
- (void)endHeaderRefresh;

/** 添加尾部刷新 */
- (void)addfooterRefresh:(MJRefreshComponentRefreshingBlock)block;
/** 开始尾部刷新 */
- (void)beginFooterRefresh;
/** 结束尾部刷新 */
- (void)endFooterRefresh;


@end
