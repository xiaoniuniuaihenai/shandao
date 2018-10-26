//
//  BalanceWithdrawPageInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BalanceWithdrawPageInfoApi.h"

@implementation BalanceWithdrawPageInfoApi

- (NSString *)requestUrl{
    return @"/user/getWithdrawCashInfo";
}

- (id)requestArgument{
    return @{};
}

@end
