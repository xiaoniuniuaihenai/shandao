//
//  ZTMXFuthZmStatusApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/4/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFuthZmStatusApi.h"

@interface ZTMXFuthZmStatusApi ()

@property (nonatomic, copy)NSString * zmUrl;

@end
@implementation ZTMXFuthZmStatusApi

- (id)initWithZmUrl:(NSString *)zmUrl
{
    self = [super init];
    if (self) {
        _zmUrl = zmUrl;
    }
    return self;
}



- (id)requestArgument{
    return @{@"url":_zmUrl};
}
- (NSString *)requestUrl{
    return @"/auth/getAuthZmStatus";
}

@end
