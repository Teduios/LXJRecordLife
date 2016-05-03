
//
//  LXJWeatherModel.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJWeatherModel.h"

@implementation LXJWeatherModel
+ (instancetype)parseHourlyJSON:(NSDictionary *)dict
{
    LXJWeatherModel *hourly = [LXJWeatherModel new];
    hourly.tempStr = [NSString stringWithFormat:@"%@˚C",dict[@"tempC"]];
    hourly.iconURLStr = dict[@"weatherIconUrl"][0][@"value"];
    hourly.value = dict[@"lang_zh"][0][@"value"];
    return hourly;
}

@end
