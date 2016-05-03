//
//  LXJDrivingLicenseViewController.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/25.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJDrivingLicenseViewController.h"
#import "LXJObjectOneTableViewController.h"
#import "LXJObjectFourTableViewController.h"
#import "LXJTypeViewController.h"

#define SCREEN_MAIN [UIScreen mainScreen].bounds
#define SCROLL_HEIGHT self.view.bounds.size.height - 42 - 64


@interface LXJDrivingLicenseViewController ()<UIScrollViewDelegate>
/** 科目1按钮 */
@property (weak, nonatomic) IBOutlet UIButton *objectOneBtn;
/** 科目4按钮 */
@property (weak, nonatomic) IBOutlet UIButton *objectFourBtn;
/** 科目1点击事件 */
- (IBAction)objectOneAction:(id)sender;
/** 科目4按钮 */
- (IBAction)objectFourAction:(id)sender;
/** 滑动条左边的约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayoutConstraint;
/** 滚动视图 */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *type;


@end

@implementation LXJDrivingLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"type"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"c1" forKey:@"type"];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change) name:@"change" object:nil];
    
    LXJObjectOneTableViewController *one = [self.storyboard instantiateViewControllerWithIdentifier:@"LXJObjectOneTableViewController"];
    LXJObjectFourTableViewController *four = [self.storyboard instantiateViewControllerWithIdentifier:@"LXJObjectFourTableViewController"];
    [self addChildViewController:one];
    [self addChildViewController:four];
    
    CGRect frame = CGRectZero;
    frame.origin.y = 42;
    frame.size.width = self.view.bounds.size.width;
    frame.size.height = SCROLL_HEIGHT;
    self.scrollView.frame = frame;
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_MAIN.size.width*2, SCROLL_HEIGHT);
    
//    NSLog(@"%lf,%lf",self.scrollView.bounds.size.width,self.scrollView.bounds.size.height);
//    NSLog(@"%lf", self.view.bounds.size.height);
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
//    self.scrollView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_MAIN.size.width, SCROLL_HEIGHT)];
    [view1 addSubview:one.tableView];
    
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(1 * self.view.bounds.size.width, 0, SCREEN_MAIN.size.width, SCROLL_HEIGHT)];
    [view4 addSubview:four.tableView];

    [self.scrollView addSubview:view1];
    [self.scrollView addSubview:view4];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self viewDidLayoutSubviews:scrollView];
}
-(void)viewDidLayoutSubviews:(UIScrollView *)scrollView
{
    
    [super viewDidLayoutSubviews];
    self.leftLayoutConstraint.constant = scrollView.contentOffset.x/2.0;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
    
    
}
- (IBAction)objectOneAction:(UIButton *)sender {
    CGPoint point = self.scrollView.contentOffset;
    point.x = SCREEN_MAIN.size.width * sender.tag;
    self.scrollView.contentOffset = point;

}

- (IBAction)objectFourAction:(UIButton *)sender {
    CGPoint point = self.scrollView.contentOffset;
    point.x = SCREEN_MAIN.size.width * sender.tag;
    self.scrollView.contentOffset = point;

}
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//弹出选择驾照类型控制器
- (IBAction)chooseTypeAction:(UIBarButtonItem *)sender {
    LXJTypeViewController *typeVc = [[LXJTypeViewController alloc]initWithSourceView:self.view sourceRect:CGRectMake(self.view.bounds.size.width-80, 0, 70, 44) contentSize:CGSizeMake(70, 200)];
    [self presentViewController:typeVc animated:YES completion:nil];
}

- (void)change
{
    self.type.title = [[NSUserDefaults standardUserDefaults] valueForKey:@"type"];
}
@end
