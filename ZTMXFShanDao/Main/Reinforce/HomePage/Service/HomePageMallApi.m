//
//  HomePageMallApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "HomePageMallApi.h"

@implementation HomePageMallApi

- (NSString * )requestUrl{
    return @"/mall/getMallHomePage";
}


- (id)requestArgument{
    return @{};
}

@end
