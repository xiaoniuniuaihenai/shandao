//
//  BalanceWithdrawApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BalanceWithdrawApi.h"

@interface BalanceWithdrawApi ()

@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *password;

@end

@implementation BalanceWithdrawApi

- (instancetype)initWithAmount:(NSString *)amount password:(NSString *)password{
    self = [super init];
    if (self) {
        _amount = amount;
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/applyWithdrawCash";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_amount forKey:@"amount"];
    [paramDict setValue:_password forKey:@"payPwd"];
    return paramDict;
}

@end
