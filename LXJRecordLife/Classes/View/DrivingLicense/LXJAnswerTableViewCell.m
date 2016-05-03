//
//  LXJAnswerTableViewCell.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/25.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJAnswerTableViewCell.h"

@implementation LXJAnswerTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //此三行代码用于去掉cell左侧的空隙
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
