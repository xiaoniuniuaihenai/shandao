//
//  BankCardListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BankCardListApi.h"

@implementation BankCardListApi

- (NSString *)requestUrl{
    return @"/user/getBankCardList";
}

- (id)requestArgument{
    return @{};
}


@end
