//
//  LXJAlertViewController.h
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXJAlertViewController : UIViewController
//此控制器需要知道从哪个视图，哪个位置弹出来，弹出的内容多大
- (instancetype)initWithSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect contentSize:(CGSize)contentSize;

@property(nonatomic,readonly)UIView *sourceView;
@property(nonatomic,readonly)CGRect sourceRect;
@property(nonatomic,readonly)CGSize contentSize;

@end
