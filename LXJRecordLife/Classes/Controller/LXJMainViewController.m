//
//  LXJMainViewController.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/20.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJMainViewController.h"
#import "LXJHeaderView.h"
#import "LXJNetworkManager.h"
#import "LXJDataManager.h"
#import "LXJLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "MJRefresh.h"
#import "LXJCityListTableViewController.h"

@interface LXJMainViewController ()
/** 表视图 **/
@property (nonatomic, weak)UITableView *tableView;
/** 数据存储：存储日天气预报信息 **/
@property (nonatomic, strong) NSArray  *dailyArray;
/** 记录存储每小时的数组 **/
@property (nonatomic, strong) NSArray *hourlyArray;
/** 记录用户位置的属性 **/
@property (nonatomic, strong) CLLocation *userLocation;
/** 地理编码 **/
@property(nonatomic,strong)CLGeocoder *geocoder;

/** 头部视图 **/
@property(nonatomic,strong)LXJHeaderView *headerView;

@end

@implementation LXJMainViewController
- (CLGeocoder *)geocoder {
    if(_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //0.监听城市的选择
    [self listenNotification];
    // 2.创建表头视图
    [self createTableHeaderView];
    //3.创建添加刷新控件
    [self createRefreshControl];
    //4.获取用户的位置，然后发送位置请求
    [self getLocationAndSendRequest];
}
#pragma mark - 通知相关的方法
- (void)listenNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didCityChange:) name:kChangeCity object:nil];
    
}
- (void)didCityChange:(NSNotification *)noti
{

    //获取城市的名字
    NSString *cityName = noti.userInfo[@"cityName"];
    //    NSString *cityName = [city substringToIndex:(city.length - 1)];
    self.headerView.cityLable.text = cityName;
    
    
    MYLog(@"城市名字:%@", cityName);
    //使用地理编码把中文的城市名字改成对应的经纬度
    [self.geocoder geocodeAddressString:cityName completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            //获取城市的经纬度
            self.userLocation = [placemarks lastObject].location;
            //重新发送对应城市的请求
            [self sendRequest];
            
        }else{
            MYLog(@"无法获取选择城市的经纬度:%@",error.userInfo);
        }
    }];
    
    
}

#pragma mark - 发送网络请求，加载数据
- (void)getLocationAndSendRequest
{
    [LXJLocationManager getUserLocation:^(double latitude, double longitude) {
        self.userLocation = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
        //发送网络请求
        [self sendRequest];
    }];
}
-(void)sendRequest
{
    NSString *urlStr = BASE_URL;
    //拼接q对应的参数
    NSString *qParamStr = [NSString stringWithFormat:@"%f,%f",self.userLocation.coordinate.latitude, self.userLocation.coordinate.longitude];
    NSDictionary *param = @{
                            @"lang":@"zh",
                            @"q":qParamStr,
                            @"num_of_days":@"5",
                            @"format":@"json",
                            @"tp":@"3",
                            @"key":KEY
                            };
    [LXJNetworkManager sendRequestWithUrl:urlStr parameters:param success:^(id responseObject) {
        MYLog(@"成功返回,%@",[NSThread currentThread]);
        //调用数据管理类的方法，解析网络流
        self.dailyArray = [LXJDataManager getAllDailyData:responseObject];
        self.hourlyArray = [LXJDataManager getAllHourlyData:responseObject];
        //更新头部视图上的5个控件的值（self.dailyArray/self.hourlyArray）
        [self updateHeaderViewWithHourly:self.hourlyArray[0] andDaily:self.dailyArray[0]];
        
        //刷新表格(网络请求是异步的Async...)
        [self.tableView reloadData];
        //停止刷新的动画
        [self.tableView.mj_header endRefreshing];
        //        MYLog(@"%@",self.hourlyArray);
        
    } failure:^(NSError *error) {
        MYLog(@"失败:%@",error);
        //停止刷新的动画
        [self.tableView.mj_header endRefreshing];
        
    }];


}
#pragma mark - 更新头部视图
- (void)updateHeaderViewWithHourly:(LXJWeatherModel *)hourly andDaily:(LXJWeatherTModel *)daily
{
    if (self.userLocation) {
        [self.geocoder reverseGeocodeLocation:self.userLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            //获取城市名字
            CLPlacemark *placemark = [placemarks firstObject];
            NSLog(@"%@", placemark.addressDictionary[@"City"]);
            NSString *city = placemark.addressDictionary[@"City"];
            NSLog(@"去掉市%@", [city substringToIndex:city.length - 1]);
            self.headerView.cityLable.text = [city substringToIndex:city.length - 1];
        }];
    }
    self.headerView.iconImageView.image = [UIImage imageNamed:[hourly.iconURLStr lastPathComponent]];
    self.headerView.conditionsLabel.text = hourly.value;
    self.headerView.temperatureLabel.text = hourly.tempStr;
    self.headerView.hiloLabel.text = [NSString stringWithFormat:@"%@/%@", daily.mintempC, daily.maxtempC];
    
}


#pragma mark - 创建界面视图
- (void)createRefreshControl
{
    //前提：必须已经定位到用户的位置
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendRequest)];
    //设置属性
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    //添加
    self.tableView.mj_header = header;
}
-(void)createTableHeaderView
{
    self.headerView = [[LXJHeaderView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.headerView.backgroundColor = [UIColor cyanColor];
    [self.headerView.cityList addTarget:self action:@selector(chooseCity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.headerView];
}
- (void)chooseCity
{
    LXJCityListTableViewController *vc = [[LXJCityListTableViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navi animated:YES completion:nil];
}

@end
