//
//  LXJLocationManager.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface LXJLocationManager ()<CLLocationManagerDelegate>

/** 声明一个定位CLLocationManager对象，用单例模式 */
@property(nonatomic,strong)CLLocationManager *manager;

/** 声明一个block存储用户的位置 */
@property (nonatomic, copy) void(^saveLocation)(double latitude, double longitude);

@end

@implementation LXJLocationManager
+ (instancetype)sharedLocationManager
{
    static LXJLocationManager *locationManager = nil;
    if (!locationManager) {
        locationManager = [[LXJLocationManager alloc]init];
    }
    return locationManager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //创建/初始化CLLocationManager对象
        self.manager = [CLLocationManager new];
        //征求用户的同意(>=iOS8.0需要征求用户同意，否则不需要)
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
            [self.manager requestWhenInUseAuthorization];
        }else{
            [self.manager startUpdatingLocation];
        }
        //设置代理
        self.manager.delegate = self;
    }
    return self;
}


+ (void)getUserLocation:(void (^)(double,  double))locationBlock
{
    //类方法可以调用自己的实例方法，在实例方法中可以用self，类方法中不可以用self
    //执行上面的逻辑
    LXJLocationManager *locationManager = [LXJLocationManager sharedLocationManager];
    [locationManager getUserLocation:locationBlock];
}
- (void)getUserLocation:(void (^)(double, double))locationBlock
{
    //用户没有同意
    if (![CLLocationManager locationServicesEnabled]) {
        //告诉用户去设置中的隐私开启定位
        return;
    }
    _saveLocation = locationBlock;
    self.manager.distanceFilter = 1000;//米
    //用户已经同意，开始定位
    [self.manager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //已经获取用户的位置
    CLLocation *userLocation = [locations lastObject];
    //赋值给saveLocationBlock
    _saveLocation(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    //设置manager为空(只需要定位一次)
    self.manager = nil;
}

@end
