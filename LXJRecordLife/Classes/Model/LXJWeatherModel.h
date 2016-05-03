//
//  LXJWeatherModel.h
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXJWeatherModel : NSObject
/** 当前时间点温度 */
@property(nonatomic,copy)NSString *tempStr;
/** 天气描述 */
@property(nonatomic,copy)NSString *value;
/** 图片url的string */
@property (nonatomic, copy) NSString *iconURLStr;
//给定每小时的字典数据，返回当前的模型类型
+ (instancetype)parseHourlyJSON:(NSDictionary *)dict;

@end
