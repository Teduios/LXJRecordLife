//
//  AppDelegate+LXJLocation.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "AppDelegate+LXJLocation.h"
#import <objc/runtime.h>
#import "BlocksKit.h"
#import "BlocksKit+UIKit.h"


@implementation AppDelegate (LXJLocation)
- (void)setLocationManager:(CLLocationManager *)locationManager
{
    return objc_setAssociatedObject(self, @selector(locationManager), locationManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CLLocationManager *)locationManager
{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setupLocation
{
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (![[NSUserDefaults standardUserDefaults] valueForKey:kCurrentCityName]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"北京" forKey:kCurrentCityName];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *currentCity = [[NSUserDefaults standardUserDefaults] valueForKey:kCurrentCityName];
            [[NSNotificationCenter defaultCenter] postNotificationName:kChangeCity object:self userInfo:@{@"cityName":currentCity}];
        });
    });
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = locations.lastObject;
    if (location) {
        manager.delegate = nil;
        [manager stopUpdatingLocation];
        [[CLGeocoder new] reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *placemark = placemarks.firstObject;
            NSString *locationCityChinese = placemark.locality;
            locationCityChinese = [locationCityChinese substringToIndex:(locationCityChinese.length - 1)];
            NSString *preCityName = [[NSUserDefaults standardUserDefaults] valueForKey:kCurrentCityName];
            NSLog(@"之前所在城市拼汉语:%@", preCityName);
            if (![preCityName isEqualToString:locationCityChinese] && locationCityChinese != nil) {
                
                NSString *message = @"";
                if (![preCityName isEqualToString:locationCityChinese]) {
                    message = [NSString stringWithFormat:@"当前城市发生改变,是否要切换到'%@'?", locationCityChinese];
                    NSLog(@"定位到的城市与当前城市不符合");
                    [UIAlertView bk_showAlertViewWithTitle:@"切换城市" message:message cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                        if (buttonIndex == 1) {
                            [[NSUserDefaults standardUserDefaults] setObject:locationCityChinese forKey:kCurrentCityName];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            [[NSNotificationCenter defaultCenter] postNotificationName:kChangeCity object:self userInfo:@{@"cityName":locationCityChinese}];
                        }
                    }];
                }
            }
        }];
    }
}

@end
