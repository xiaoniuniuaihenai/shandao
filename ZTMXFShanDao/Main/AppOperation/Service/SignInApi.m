//
//  SignInApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "SignInApi.h"

@implementation SignInApi

- (NSString *)requestUrl{
    return @"/user/signin";
}



- (id)requestArgument{
    return @{};
}


@end
