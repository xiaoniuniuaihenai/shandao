//
//  HomePageApi.m
//  CoreFrame
//
//  Created by yangpenghua on 2017/8/24.
//  Copyright © 2017年 yangpenghua. All rights reserved.
//

#import "HomePageApi.h"

@implementation HomePageApi

- (NSString *)requestUrl{
    return @"/goods/getHomeInfo";
}

- (id)requestArgument{
    return @{};
}

- (NSInteger)cacheTimeInSeconds{
    return  6000;
}

@end
