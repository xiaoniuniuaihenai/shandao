//
//  HttpClient.m
//  ZhongCaoMei
//
//  Created by 陈传亮 on 16/7/21.
//  Copyright © 2016年 古乐. All rights reserved.
//

#import "HttpClient.h"

@implementation HttpClient

+ (instancetype)sharedClient {
    static HttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [HttpClient manager];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", nil];

//        [_sharedClient.requestSerializer setValue:[USER_DEFAULT objectForKey:@"version"] forHTTPHeaderField:@"app-version"];
//        [_sharedClient.requestSerializer setValue:@"zhongcaomei" forHTTPHeaderField:@"app"];
//        [_sharedClient.requestSerializer setValue:[USER_DEFAULT objectForKey:UserInfo_UserToken] forHTTPHeaderField:@"Authorization"];
        
       
        
        });
    
    return _sharedClient;
}



@end
