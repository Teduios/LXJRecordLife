//
//  LXJHeaderView.h
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/20.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXJHeaderView : UIView
/** 城市列表按钮 **/
@property (nonatomic, strong)UIButton *cityList;
/** 城市标签 **/
@property (nonatomic, strong)UILabel *cityLable;
/** 图片view **/
@property (nonatomic, strong)UIImageView *iconImageView;
/** 当前天气的label **/
@property (nonatomic, strong)UILabel *conditionsLabel;
/** 当前天气温度 **/
@property (nonatomic, strong)UILabel *temperatureLabel;
/** 高低温度 **/
@property (nonatomic, strong)UILabel *hiloLabel;

/** 背景图 **/
@property (nonatomic, strong)UIImageView *backImageView;

@end
