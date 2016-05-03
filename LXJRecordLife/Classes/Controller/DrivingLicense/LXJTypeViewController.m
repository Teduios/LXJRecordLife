//
//  LXJTypeViewController.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJTypeViewController.h"
#import "Masonry.h"

#define kScreenW self.view.bounds.size.width


@interface LXJTypeViewController ()
@property (nonatomic, strong) NSArray *arr;


@property (nonatomic, strong) UILabel *labelc1;
@property (nonatomic, strong) UILabel *labelc2;
@property (nonatomic, strong) UILabel *labela1;
@property (nonatomic, strong) UILabel *labela2;
@property (nonatomic, strong) UILabel *labelb1;
@property (nonatomic, strong) UILabel *labelb2;

@end

@implementation LXJTypeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *a1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 70, 30)];
    self.labela1 = a1;
    a1.textAlignment = NSTextAlignmentCenter;
    a1.text = @"a1";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc
                                    ]initWithTarget:self action:@selector(chooseActiona1)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    a1.userInteractionEnabled = YES;
    [a1 addGestureRecognizer:tap];
    [self.view addSubview:a1];
    
    UILabel *a2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 70, 30)];
    self.labela2 = a2;
    a2.textAlignment = NSTextAlignmentCenter;
    a2.text = @"a2";
    UITapGestureRecognizer *tapa2 = [[UITapGestureRecognizer alloc
                                    ]initWithTarget:self action:@selector(chooseActiona2)];
    tapa2.numberOfTapsRequired = 1;
    tapa2.numberOfTouchesRequired = 1;
    a2.userInteractionEnabled = YES;
    [a2 addGestureRecognizer:tapa2];
    [self.view addSubview:a2];

    UILabel *b1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, 70, 30)];
    self.labelb1 = b1;
    b1.textAlignment = NSTextAlignmentCenter;
    b1.text = @"b1";
    UITapGestureRecognizer *tapb1 = [[UITapGestureRecognizer alloc
                                    ]initWithTarget:self action:@selector(chooseActionb1)];
    tapb1.numberOfTapsRequired = 1;
    tapb1.numberOfTouchesRequired = 1;
    b1.userInteractionEnabled = YES;
    [b1 addGestureRecognizer:tapb1];
    [self.view addSubview:b1];

    UILabel *b2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 70, 30)];
    self.labelb2 = b2;
    b2.textAlignment = NSTextAlignmentCenter;
    b2.text = @"b2";
    UITapGestureRecognizer *tapb2 = [[UITapGestureRecognizer alloc
                                    ]initWithTarget:self action:@selector(chooseActionb2)];
    tapb2.numberOfTapsRequired = 1;
    tapb2.numberOfTouchesRequired = 1;
    b2.userInteractionEnabled = YES;
    [b2 addGestureRecognizer:tapb2];
    [self.view addSubview:b2];

    UILabel *c1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, 70, 30)];
    self.labela1 = c1;
    c1.textAlignment = NSTextAlignmentCenter;
    c1.text = @"c1";
    UITapGestureRecognizer *tapc1 = [[UITapGestureRecognizer alloc
                                    ]initWithTarget:self action:@selector(chooseActionc1)];
    tapc1.numberOfTapsRequired = 1;
    tapc1.numberOfTouchesRequired = 1;
    c1.userInteractionEnabled = YES;
    [c1 addGestureRecognizer:tapc1];
    [self.view addSubview:c1];

    UILabel *c2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 160, 70, 30)];
    self.labelc2 = c2;
    c2.textAlignment = NSTextAlignmentCenter;
    c2.text = @"c2";
    UITapGestureRecognizer *tapc2 = [[UITapGestureRecognizer alloc
                                    ]initWithTarget:self action:@selector(chooseActionc2)];
    tapc2.numberOfTapsRequired = 1;
    tapc2.numberOfTouchesRequired = 1;
    c2.userInteractionEnabled = YES;
    [c2 addGestureRecognizer:tapc2];
    [self.view addSubview:c2];

}
- (void)chooseActionc1
{
    [[NSUserDefaults standardUserDefaults] setObject:@"c1" forKey:@"type"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"c1");
}
- (void)chooseActionc2
{
    [[NSUserDefaults standardUserDefaults] setObject:@"c2" forKey:@"type"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"c2");
}
- (void)chooseActiona1
{
    [[NSUserDefaults standardUserDefaults] setObject:@"a1" forKey:@"type"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"a1");
}
- (void)chooseActiona2
{
    [[NSUserDefaults standardUserDefaults] setObject:@"a2" forKey:@"type"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"a2");
}
- (void)chooseActionb1
{
    [[NSUserDefaults standardUserDefaults] setObject:@"b1" forKey:@"type"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
     NSLog(@"b1");
}
- (void)chooseActionb2
{
    [[NSUserDefaults standardUserDefaults] setObject:@"b2" forKey:@"type"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
     NSLog(@"b2");
}

@end
