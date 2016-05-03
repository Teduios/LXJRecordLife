//
//  LXJAlertViewController.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/27.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJAlertViewController.h"

@interface LXJAlertViewController ()<UIPopoverPresentationControllerDelegate>

@end

@implementation LXJAlertViewController

//要让弹出效果在iPhone下生效(默认是在iPad上生效)，需要实现以下代理
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection
{
    return UIModalPresentationNone;
}


- (instancetype)initWithSourceView:(UIView *)sourceView sourceRect:(CGRect)sourceRect contentSize:(CGSize)contentSize
{
    self = [super init];
    if (self) {
        _sourceRect = sourceRect;
        _sourceView = sourceView;
        _contentSize = contentSize;
        //设置当前控制器的弹出方式是popover
        self.modalPresentationStyle = UIModalPresentationPopover;
        self.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
        self.popoverPresentationController.delegate = self;
        self.popoverPresentationController.sourceView = _sourceView;
        self.popoverPresentationController.sourceRect = _sourceRect;
        
    }
    return self;
}
#pragma mark - 声明周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置self.view弹出后的大小
    self.preferredContentSize = _contentSize;
}

@end
