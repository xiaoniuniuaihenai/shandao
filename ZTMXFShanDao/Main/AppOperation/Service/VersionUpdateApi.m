//
//  VersionUpdateApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "VersionUpdateApi.h"

@implementation VersionUpdateApi

- (NSString *)requestUrl{
    return @"/system/appUpgrade";
}



- (id)requestArgument{
    return @{};
}


@end
