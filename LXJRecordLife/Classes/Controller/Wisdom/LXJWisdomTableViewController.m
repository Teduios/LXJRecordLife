//
//  LXJWisdomTableViewController.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/23.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJWisdomTableViewController.h"
#import "LXJWisdomCell.h"
#import "LXJNetworkManager.h"
#import "LXJWisdomModel.h"
#import "LXJDataManager.h"
#import "MJRefresh.h"

@interface LXJWisdomTableViewController ()<UITextFieldDelegate>
/** 名人名言数据模型数组 */
@property (nonatomic, strong) NSArray *allWisdoms;
@property (weak, nonatomic) IBOutlet UITextField *keyWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *seekBtn;

@end

@implementation LXJWisdomTableViewController
- (IBAction)searchAction:(id)sender {
    [self sendRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.seekBtn.layer.cornerRadius = 5;
//    self.seekBtn.layer.borderColor = [UIColor cyanColor].CGColor;
//    self.seekBtn.layer.borderWidth = 2;
//    [self.seekBtn.layer masksToBounds];
    self.keyWordTextField.delegate = self;
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendRequest)];
    [header beginRefreshing];
    self.tableView.mj_header = header;

    [self sendRequest];
}
- (void)sendRequest
{
    NSString *url = @"http://apis.baidu.com/avatardata/mingrenmingyan/lookup";
    NSDictionary *para = @{
                           @"dtype":@"JSON",
                           @"keyword":self.keyWordTextField.text.length ? self.keyWordTextField.text : @"天才",
                           @"page":@(1),
                           @"rows":@(50)
                           };
    [LXJNetworkManager sendRequestWithUrl:url parameters:para success:^(id responseObject) {
//        MYLog(@"%@", responseObject);
        self.allWisdoms = [LXJDataManager getWisdomData:responseObject];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        MYLog(@"%@", error);
        [self.tableView.mj_header endRefreshing];
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allWisdoms.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXJWisdomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WisdomCell" forIndexPath:indexPath];
    //此三行代码去掉cell左侧的空隙
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    LXJWisdomModel *wisdom = self.allWisdoms[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"--- %@", wisdom.name];
    cell.sayingLabel.text = wisdom.saying;
    return cell;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [self sendRequest];
    return YES;
}
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
