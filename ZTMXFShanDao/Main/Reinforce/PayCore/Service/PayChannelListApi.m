//
//  PayChannelListApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "PayChannelListApi.h"

@interface PayChannelListApi ()

/** 来源 */
@property (nonatomic, copy) NSString *sourceType;

@end

@implementation PayChannelListApi

- (instancetype)initWithSourceType:(NSString *)sourceType{
    self = [super init];
    if (self) {
        _sourceType = sourceType;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/pay/getPayChannelList";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_sourceType forKey:@"sceneType"];
    return paramDict;
}


@end
