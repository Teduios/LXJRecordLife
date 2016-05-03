//
//  LXJLeftListViewController.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/20.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJLeftListViewController.h"
#import "Masonry.h"
#import "LXJDrivingLicenseViewController.h"
#import "LXJWisdomTableViewController.h"

@interface LXJLeftListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation LXJLeftListViewController
#pragma mark - 懒加载
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:49/255.0 green:94/255.0 blue:153/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = @"向导";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor cyanColor];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"驾照题库";
            break;
        case 1:
            cell.textLabel.text = @"休息片刻";
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LXJDrivingLicenseViewController *driVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LXJDrivingLicenseViewController"];
    UINavigationController *busNav = [[UINavigationController alloc]initWithRootViewController:driVc];
    LXJWisdomTableViewController *wisdomVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"LXJWisdomTableViewController"];
    UINavigationController *wisdomNav = [[UINavigationController alloc]initWithRootViewController:wisdomVc];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self presentViewController:busNav animated:YES completion:nil];
            break;
        case 1:
            [self presentViewController:wisdomNav animated:YES completion:nil];
            break;
        default:
            break;
    }
}


@end
