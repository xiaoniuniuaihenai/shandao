//
//  LogoutApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LogoutApi.h"

@implementation LogoutApi

- (NSString *)requestUrl{
    return @"/user/logout";
}

- (id)requestArgument{
    return @{};
}

@end
