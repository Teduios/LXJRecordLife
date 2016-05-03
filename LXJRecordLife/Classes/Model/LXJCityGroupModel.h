//
//  LXJCityGroupModel.h
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/22.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXJCityGroupModel : NSObject

/** 城市名称列表 NSArray<NSString>**/
@property (nonatomic, strong)NSArray *cities;
/** 城市组名称  **/
@property (nonatomic, copy)NSString *title;

@end
