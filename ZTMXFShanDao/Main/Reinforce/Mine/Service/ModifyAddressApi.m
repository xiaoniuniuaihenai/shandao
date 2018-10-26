//
//  ModifyAddressApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/11.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "ModifyAddressApi.h"

@interface ModifyAddressApi ()

@property (nonatomic, strong) NSDictionary *paramsDict;

@end

@implementation ModifyAddressApi

- (instancetype)initWithParamsDict:(NSDictionary *)paramsDict{
    self = [super init];
    if (self) {
        _paramsDict = paramsDict;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/operatorUserAddress";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc] initWithDictionary:_paramsDict];
    
    return paramDict;
}

@end
