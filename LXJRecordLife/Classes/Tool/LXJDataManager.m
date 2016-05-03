//
//  LXJDataManager.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/21.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJDataManager.h"

@implementation LXJDataManager

+ (NSArray *)getallDrivingLicenseData:(id)responseObject
{
    NSArray *arr = responseObject[@"result"];
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        LXJDrivingLicenseModel *model = [LXJDrivingLicenseModel parseDrivingLicenseWithJSON:dic];
        [mutableArr addObject:model];
    }
    NSLog(@"%ld",mutableArr.count);
    return [mutableArr copy];
}

static NSArray *_cityGroups = nil;
+ (NSArray *)getAllCityGroups
{
    if (!_cityGroups) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cityGroups.plist" ofType:@""];
        NSArray *cityGroupArray = [NSArray arrayWithContentsOfFile:plistPath];
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSDictionary *dict in cityGroupArray) {
            LXJCityGroupModel *group = [[LXJCityGroupModel alloc]init];
            [group setValuesForKeysWithDictionary:dict];
            [mutableArray addObject:group];
        }
        _cityGroups = mutableArray;
    }
    return  _cityGroups;
}
+ (NSArray *)getWisdomData:(id)responseObject
{
    NSArray *arr = responseObject[@"result"];
    NSMutableArray *mutableArr = [NSMutableArray array];
    for (NSDictionary *dic in arr) {
        LXJWisdomModel *model = [LXJWisdomModel parseWisdomWithJSON:dic];
        [mutableArr addObject:model];
    }
    return [mutableArr copy];
}

+ (NSArray *)getAllDailyData:(id)responseObject
{
    //从responseObject中取出weather对应的值（数组）
    NSArray *weatherArray = responseObject[@"data"][@"weather"];
    
    //将每一个weather中的字典，变成Daily对象
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in weatherArray) {
        LXJWeatherTModel *daily = [LXJWeatherTModel parseDailyJSON:dict];
        [array addObject:daily];
    }
    return array;
}

+ (NSArray *)getAllHourlyData:(id)responseObject
{
    NSArray *hourlyArray = responseObject[@"data"][@"weather"][0][@"hourly"];
    //循环把数组中的字典转成TRHourly对象
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in hourlyArray) {
        LXJWeatherModel *hourly = [LXJWeatherModel parseHourlyJSON:dict];
        [array addObject:hourly];
    }
    return [array copy];
}


@end
