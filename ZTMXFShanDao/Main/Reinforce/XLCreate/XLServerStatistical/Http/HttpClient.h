//
//  HttpClient.h
//  ZhongCaoMei
//
//  Created by 陈传亮 on 16/7/21.
//  Copyright © 2016年 古乐. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
