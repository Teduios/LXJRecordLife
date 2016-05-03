//
//  LXJWeatherTModel.h
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXJWeatherTModel : NSObject
/** 最高温度 **/
@property (nonatomic, copy)NSString *maxtempC;
/** 最低温度 **/
@property (nonatomic, copy)NSString *mintempC;
+(instancetype)parseDailyJSON:(NSDictionary *)dict;

@end
