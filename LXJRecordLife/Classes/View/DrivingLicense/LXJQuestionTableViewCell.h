//
//  LXJQuestionTableViewCell.h
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/25.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LXJQuestionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *currentQuestionNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *questionImageView;



@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *chooseBtns;
@property (weak, nonatomic) IBOutlet UILabel *chooseAContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseBContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseCContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseDContentLabel;


@property (weak, nonatomic) IBOutlet UILabel *explainContentLabel;






@end
