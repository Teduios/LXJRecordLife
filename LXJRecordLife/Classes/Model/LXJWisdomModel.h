//
//  LXJWisdomModel.h
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/23.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXJWisdomModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *saying;

+ (instancetype)parseWisdomWithJSON:(NSDictionary *)dic;

@end
