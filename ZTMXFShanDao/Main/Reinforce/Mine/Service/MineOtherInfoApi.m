//
//  MineOtherInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/10.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "MineOtherInfoApi.h"

@implementation MineOtherInfoApi

- (NSString *)requestUrl{
    return @"/system/getServeAndFinanc";
}

- (id)requestArgument{
    return @{};
}

@end
