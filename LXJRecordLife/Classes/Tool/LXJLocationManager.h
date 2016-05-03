//
//  LXJLocationManager.h
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXJLocationManager : NSObject
+ (void)getUserLocation:(void(^)(double latitude,double longitude))locationBlock;

@end
