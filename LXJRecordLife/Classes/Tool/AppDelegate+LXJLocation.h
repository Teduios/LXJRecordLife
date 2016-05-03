//
//  AppDelegate+LXJLocation.h
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>



@interface AppDelegate (LXJLocation)<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

- (void)setupLocation;


@end
