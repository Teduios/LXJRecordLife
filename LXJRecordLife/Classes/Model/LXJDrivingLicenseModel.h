//
//  LXJDrivingLicenseModel.h
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/25.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXJDrivingLicenseModel : NSObject


@property (nonatomic, copy) NSString *answer;

@property (nonatomic, copy) NSString *item4;

@property (nonatomic, copy) NSString *questionUrl;

@property (nonatomic, assign) NSInteger drivingLicenseId;

@property (nonatomic, copy) NSString *item1;

@property (nonatomic, copy) NSString *question;

@property (nonatomic, copy) NSString *item3;

@property (nonatomic, copy) NSString *explains;

@property (nonatomic, copy) NSString *item2;

+ (instancetype)parseDrivingLicenseWithJSON:(NSDictionary *)dict;


@end
