//
//  LXJNetworkManager.h
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/21.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import <Foundation/Foundation.h>
//把发送网络请求的方法封装起来

@interface LXJNetworkManager : NSObject

+ (void)sendRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
