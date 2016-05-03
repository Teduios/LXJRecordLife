//
//  LXJHeaderView.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/20.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJHeaderView.h"
#import "UILabel+LXJLabel.h"

//声明三个常量
const CGFloat inset = 20;//左右边距
const CGFloat labelHeight = 40;
const CGFloat tempLabelHeight = 110;


@implementation LXJHeaderView

/**
 *  重写父类的initWithFrame方法，保证以创建这个头视图
 *  则其中包含的所有子视图也被创建出来
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {
        //背景图
        self.backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.backImageView.image = [UIImage imageNamed:@"bg_sunny.jpg"];
        [self addSubview:self.backImageView];

        // 依次创建5个子视图，设定位置，并添加到view中
        // 依次创建6个子视图，设定位置，并添加到view中
        self.cityList = [[UIButton alloc]init];
        [self.cityList setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        self.cityList.frame = CGRectMake(SCREEN_WIDTH-40, 25, 40, 40);
        [self addSubview:self.cityList];

        //高低温度标签
        self.hiloLabel = [UILabel labelWithFrame:CGRectMake(inset, SCREEN_HEIGHT-labelHeight, SCREEN_WIDTH-2*inset, labelHeight)];
        self.hiloLabel.text = @"15˚C/23˚C";
        [self addSubview:self.hiloLabel];
        //当前温度
        self.temperatureLabel = [UILabel labelWithFrame:CGRectMake(inset, SCREEN_HEIGHT-labelHeight-tempLabelHeight, SCREEN_WIDTH-2*inset, tempLabelHeight)];
        self.temperatureLabel.text = @"16˚C";
        self.temperatureLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:55];
        [self addSubview:self.temperatureLabel];
        //图片
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(inset, SCREEN_HEIGHT-labelHeight*2-tempLabelHeight, 40, labelHeight)];
        self.iconImageView.image = [UIImage imageNamed:@"wsymbol_0056_dust_sand"];
        [self addSubview:self.iconImageView];
        //天气
        self.conditionsLabel = [UILabel labelWithFrame:CGRectMake(inset+40, SCREEN_HEIGHT-2*labelHeight-tempLabelHeight, SCREEN_WIDTH-inset*2-40, labelHeight)];
        self.conditionsLabel.text = @"多云";
        [self addSubview:self.conditionsLabel];
        //城市
        self.cityLable = [UILabel labelWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, 40)];
        self.cityLable.textAlignment = NSTextAlignmentCenter;
        self.cityLable.text = @"Loading...";
        [self addSubview:self.cityLable];
        
        
    }
    return  self;
}


@end
