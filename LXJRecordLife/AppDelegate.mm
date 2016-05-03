//
//  AppDelegate.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/20.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "AppDelegate.h"
#import "LXJMainViewController.h"
#import "LXJLeftListViewController.h"
#import "MMDrawerController.h"
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import "AppDelegate+LXJLocation.h"

@interface AppDelegate ()<BMKGeneralDelegate>
@property(nonatomic,strong)BMKMapManager *manager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.manager = [BMKMapManager new];
    [self.manager start:@"xrFH4XW1yKo7S8YxdXiQ7gwyKo5sUebI" generalDelegate:self];
    
    LXJMainViewController *mainVc = [[LXJMainViewController alloc]init];
    LXJLeftListViewController *leftVc = [[LXJLeftListViewController alloc]init];
    UINavigationController *leftNav = [[UINavigationController alloc]initWithRootViewController:leftVc];
    MMDrawerController *Drawer = [[MMDrawerController alloc]initWithCenterViewController:mainVc leftDrawerViewController:leftNav];
    Drawer.maximumLeftDrawerWidth = 200;
    [Drawer setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [Drawer setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self setupLocation];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = Drawer;
    [self.window makeKeyWindow];
    
    [self configNav];
    
    return YES;
}
- (void)configNav
{
    [[UINavigationBar appearance] setTintColor:[UIColor cyanColor]];//左右字体颜色
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName:[UIColor cyanColor],
                           NSFontAttributeName:[UIFont systemFontOfSize:18]
                           };
    [[UINavigationBar appearance] setTitleTextAttributes:dict];//中间字体颜色
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:49/255.0 green:94/255.0 blue:153/255.0 alpha:1.0]];
}
#pragma mark - BMKGeneralDelegate
//联网状态
- (void)onGetNetworkState:(int)iError
{
    if (iError) {
        MYLog(@"联网失败: %d", iError);
    }
    else{
        MYLog(@"联网成功");
    }
}
//授权状态
- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        MYLog(@"授权成功");
    }else{
        MYLog(@"授权失败:%d", iError);
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
