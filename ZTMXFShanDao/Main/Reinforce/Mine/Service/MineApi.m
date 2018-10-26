//
//  MineApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "MineApi.h"

@implementation MineApi

- (NSString *)requestUrl{
    return @"/user/getMineInfo";
}

- (id)requestArgument{
    return @{};
}

//- (NSInteger)cacheTimeInSeconds{
//    return  6000;
//}


@end
