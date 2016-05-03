//
//  LXJDataManager.h
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/21.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LXJCityGroupModel.h"
#import "LXJWisdomModel.h"
#import "LXJDrivingLicenseModel.h"
#import "LXJWeatherModel.h"
#import "LXJWeatherTModel.h"

@interface LXJDataManager : NSObject
//获取驾照考试所有试题的数组
+ (NSArray *)getallDrivingLicenseData:(id)responseObject;

/** 获取所有名言的数组 */
+ (NSArray *)getWisdomData:(id)responseObject;


/** 获得所有城市组的数组 */
+ (NSArray *) getAllCityGroups;

+(NSArray *) getAllDailyData:(id)responseObject;

+(NSArray *) getAllHourlyData:(id)responseObject;

@end
