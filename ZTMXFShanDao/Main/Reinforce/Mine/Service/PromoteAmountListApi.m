//
//  PromoteAmountListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "PromoteAmountListApi.h"

@implementation PromoteAmountListApi

- (NSString *)requestUrl{
    return @"/user/getAuthAmountRecord";
}

- (id)requestArgument{
    return @{};
}

@end
