//
//  LXJWeatherTModel.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJWeatherTModel.h"

@implementation LXJWeatherTModel
+(instancetype)parseDailyJSON:(NSDictionary *)dict
{
    LXJWeatherTModel *daily = [[self alloc]init];
    
    daily.maxtempC = [NSString stringWithFormat:@"%@˚C",dict[@"maxtempC"]];
    
    daily.mintempC = [NSString stringWithFormat:@"%@˚C",dict[@"mintempC"]];
    
    return daily;
}

@end
