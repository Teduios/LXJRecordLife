//
//  LXJWisdomModel.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/23.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJWisdomModel.h"

@implementation LXJWisdomModel

+ (instancetype)parseWisdomWithJSON:(NSDictionary *)dic
{
    LXJWisdomModel *model = [self new];
    model.name = dic[@"famous_name"];
    model.saying = dic[@"famous_saying"];
    return model;
}

@end
