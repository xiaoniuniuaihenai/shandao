//
//  CheckPayPasswordApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "CheckPayPasswordApi.h"

@interface CheckPayPasswordApi ()

@property (nonatomic, copy) NSString *password;

@end

@implementation CheckPayPasswordApi

- (instancetype)initWithPassword:(NSString *)password{
    self = [super init];
    if (self) {
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/checkPayPwd";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_password forKey:@"payPwd"];
    return paramDict;
}

@end
