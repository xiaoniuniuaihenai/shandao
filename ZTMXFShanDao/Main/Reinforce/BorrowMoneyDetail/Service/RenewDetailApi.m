//
//  RenewDetailApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "RenewDetailApi.h"

@interface RenewDetailApi ()

@property (nonatomic, copy) NSString *renewId;

@end

@implementation RenewDetailApi

- (instancetype)initWithRenewId:(NSString *)renewId{
    self = [super init];
    if (self) {
        _renewId = renewId;
    }
    return self;
}



- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_renewId forKey:@"renewalId"];
    return paramDict;
}
- (NSString *)requestUrl{
    return @"/borrowCash/getRenewalDetail";
}
@end
