//
//  LXJNetworkManager.m
//  LXJRecordLife
//
//  Created by lixiaojuan on 16/4/21.
//  Copyright © 2016年 lixiaojuan. All rights reserved.
//

#import "LXJNetworkManager.h"
#import "AFNetworking.h"

@implementation LXJNetworkManager

+ (void)sendRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/json", @"text/javascript", @"application/json", @"application/x-javascript", @"application/javascript", nil];
    [manager.requestSerializer setValue:@"03135b49d4380d3793c57ea91fcc9a48" forHTTPHeaderField:@"apikey"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [manager GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //        NSLog(@"net:%@",responseObject);
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];

    });
    
}

@end
