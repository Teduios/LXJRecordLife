//
//  LXJDrivingLicenseModel.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/25.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJDrivingLicenseModel.h"

@implementation LXJDrivingLicenseModel

+ (instancetype)parseDrivingLicenseWithJSON:(NSDictionary *)dict
{
    LXJDrivingLicenseModel *model = [self new];
    model.drivingLicenseId = [dict[@"id"] integerValue];
    model.question = dict[@"question"];
    model.answer = dict[@"answer"];
    model.item1 = dict[@"item1"];
    model.item2 = dict[@"item2"];
    model.item3 = dict[@"item3"];
    model.item4 = dict[@"item4"];
    model.explains = dict[@"explains"];
    model.questionUrl = dict[@"url"];
    return model;
}

@end
