
//
//  LXJObjectOneTableViewController.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/25.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJObjectOneTableViewController.h"
#import "LXJDrivingLicenseModel.h"
#import "LXJDataManager.h"
#import "LXJNetworkManager.h"
#import "LXJQuestionTableViewCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIScrollView+LXJRefresh.h"
#import "LXJAnswerTableViewCell.h"
#import "LXJFourItemNoImageTableViewCell.h"
#import "LXJTwoItemNoImageTableViewCell.h"

@interface LXJObjectOneTableViewController ()

@property (nonatomic, strong) NSArray *allQuestions;


@end

@implementation LXJObjectOneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"type"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"c1" forKey:@"type"];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change) name:@"change" object:nil];
    

    
    [self.tableView registerNib:[UINib nibWithNibName:@"LXJQuestionTableViewCell" bundle:nil] forCellReuseIdentifier:@"objectOneCellQ"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXJAnswerTableViewCell" bundle:nil] forCellReuseIdentifier:@"objectOneCellA"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXJFourItemNoImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"FourNOImageCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"LXJTwoItemNoImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"TwoItemNoImageCell"];
    
    
    __weak __typeof(self)weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        [weakSelf sendRequest];
    }];
    [self.tableView beginHeaderRefresh];
    
//    [self.tableView addfooterRefresh:^{
//        [weakSelf sendRequest];
//    }];
//
}

- (void)change
{
    __weak __typeof(self)weakSelf = self;
    [self.tableView addHeaderRefresh:^{
        [weakSelf sendRequest];
    }];
    [self.tableView beginHeaderRefresh];
}
#pragma mark - 发送网络请求
- (void)sendRequest
{
    NSString *url = @"http://apis.baidu.com/bbtapi/jztk/jztk_query";
    NSDictionary *para = @{@"subject":@1,
                           @"model":[[NSUserDefaults standardUserDefaults] valueForKey:@"type"],
                           @"testType":@"rand"
                           };
    [LXJNetworkManager sendRequestWithUrl:url parameters:para success:^(id responseObject) {
//        MYLog(@"解析成功%@", responseObject);
        self.allQuestions = [LXJDataManager getallDrivingLicenseData:responseObject];
        [self.tableView reloadData];
        [self.tableView endHeaderRefresh];
        [self.tableView endFooterRefresh];
    } failure:^(NSError *error) {
        MYLog(@"%@", error);
        [self.tableView endHeaderRefresh];
        [self.tableView endFooterRefresh];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allQuestions.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LXJDrivingLicenseModel *driv = self.allQuestions[indexPath.row];
    
    if (driv.item3.length) {
        if (driv.questionUrl.length) {
            LXJQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"objectOneCellQ" forIndexPath:indexPath];
            //题号
            cell.currentQuestionNumLabel.text = [NSString stringWithFormat:@"%ld:", driv.drivingLicenseId];
            //问题
            cell.questionContentLabel.text = driv.question;
            
            //问题图片
            [cell.questionImageView sd_setImageWithURL:[NSURL URLWithString:driv.questionUrl] placeholderImage:[UIImage imageNamed:@"wsymbol_0007_fog"]];
            
            //A选项
            cell.chooseAContentLabel.text = driv.item1;
            //B选项
            cell.chooseBContentLabel.text = driv.item2;
            //C选项
            cell.chooseCContentLabel.text = driv.item3;
            //D选项
            cell.chooseDContentLabel.text = driv.item4;
            //解析
            NSString *answer = nil;
            switch ([driv.answer integerValue]) {
                case 1:
                    answer = @"A";
                    break;
                case 2:
                    answer = @"B";
                    break;
                case 3:
                    answer = @"C";
                    break;
                case 4:
                    answer = @"D";
                    break;
                default:
                    break;
            }
            cell.explainContentLabel.text = [NSString stringWithFormat:@"%@  答案为:%@", driv.explains, answer];
            return cell;

        }
        else{
            LXJFourItemNoImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FourNOImageCell" forIndexPath:indexPath];
            //题号
            cell.currentQuestionNumLabel.text = [NSString stringWithFormat:@"%ld:", driv.drivingLicenseId];
            //问题
            cell.questionContentLabel.text = driv.question;
            //A选项
            cell.chooseAContentLabel.text = driv.item1;
            //B选项
            cell.chooseBContentLabel.text = driv.item2;
            //C选项
            cell.chooseCContentLabel.text = driv.item3;
            //D选项
            cell.chooseDContentLabel.text = driv.item4;
            //解析
            NSString *answer = nil;
            switch ([driv.answer integerValue]) {
                case 1:
                    answer = @"A";
                    break;
                case 2:
                    answer = @"B";
                    break;
                case 3:
                    answer = @"C";
                    break;
                case 4:
                    answer = @"D";
                    break;
                default:
                    break;
            }
            cell.explainContentLabel.text = [NSString stringWithFormat:@"%@  答案为:%@", driv.explains, answer];
            return cell;
        }
        
        
    }else{
        if (driv.questionUrl.length) {
            LXJAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"objectOneCellA" forIndexPath:indexPath];
            //题号
            cell.currentQuestionNumLabel.text = [NSString stringWithFormat:@"%ld:", driv.drivingLicenseId];
            //问题
            cell.questionContentLabel.text = driv.question;
            //问题图片
            [cell.questionImageView sd_setImageWithURL:[NSURL URLWithString:driv.questionUrl] placeholderImage:[UIImage imageNamed:@"wsymbol_0007_fog"]];
            //解析
            NSString *answer = nil;
            switch ([driv.answer integerValue]) {
                case 1:
                    answer = @"A";
                    break;
                case 2:
                    answer = @"B";
                    break;
                default:
                    break;
            }
            cell.explainContentLabel.text = [NSString stringWithFormat:@"%@  答案为:%@", driv.explains, answer];
            return cell;

        }else{
            LXJTwoItemNoImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoItemNoImageCell" forIndexPath:indexPath];
            //题号
            cell.currentQuestionNumLabel.text = [NSString stringWithFormat:@"%ld:", driv.drivingLicenseId];
            //问题
            cell.questionContentLabel.text = driv.question;
            //解析
            NSString *answer = nil;
            switch ([driv.answer integerValue]) {
                case 1:
                    answer = @"A";
                    break;
                case 2:
                    answer = @"B";
                    break;
                default:
                    break;
            }
            cell.explainContentLabel.text = [NSString stringWithFormat:@"%@  答案为:%@", driv.explains, answer];
            return cell;

        }
        
            }
    return nil;
    
}

@end
