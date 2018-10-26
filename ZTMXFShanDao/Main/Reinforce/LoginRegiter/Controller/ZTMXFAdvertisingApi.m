//
//  ZTMXFAdvertisingApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 余金超 on 2018/5/4.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFAdvertisingApi.h"

@interface ZTMXFAdvertisingApi()
@property (nonatomic, copy) NSString *adsenseType;
@end

@implementation ZTMXFAdvertisingApi

- (instancetype)initWithAdsenseType:(NSString *)adsenseType{
    self = [super init];
    if (self) {
        _adsenseType = adsenseType;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/getAdsense";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_adsenseType forKey:@"adsenseType"];
    return paramDict;
}

@end
