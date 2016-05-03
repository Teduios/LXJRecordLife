
//
//  LXJCityListTableViewController.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJCityListTableViewController.h"
#import "LXJCityGroupModel.h"
#import "LXJDataManager.h"

@interface LXJCityListTableViewController ()
/** 存储城市组的数据  **/
@property (nonatomic, strong)NSArray *allCityGroups;
@end

@implementation LXJCityListTableViewController
- (NSArray *)allCityGroups
{
    if (!_allCityGroups) {
        _allCityGroups  = [LXJDataManager getAllCityGroups];
    }
    return _allCityGroups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"城市列表";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.allCityGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LXJCityGroupModel *cityGroup = self.allCityGroups[section];
    return cityGroup.cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identity = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    LXJCityGroupModel *cityGroup =self.allCityGroups[indexPath.section];
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    cell.accessoryType = [[[NSUserDefaults standardUserDefaults] valueForKey:kCurrentCityName] isEqualToString:cityGroup.cities[indexPath.row]] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    LXJCityGroupModel *cityGroup = self.allCityGroups[section];
    return cityGroup.title;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //样式：NSArray[@"热门",@"A",@"B","C"...@"Z"]
    NSMutableArray *titles = [NSMutableArray array];
    for (LXJCityGroupModel *cityGroup in self.allCityGroups) {
        [titles addObject:cityGroup.title];
    }
    return titles;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //数据源
    LXJCityGroupModel *cityGroup = self.allCityGroups[indexPath.section];
    NSString *cityName = cityGroup.cities[indexPath.row];
    //把当前城市寸入到plist中
    [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:kCurrentCityName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangeCity object:self userInfo:@{@"cityName":cityName}];
    //收回控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
