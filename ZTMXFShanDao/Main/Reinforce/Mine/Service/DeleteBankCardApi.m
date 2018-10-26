//
//  DeleteBankCardApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "DeleteBankCardApi.h"

@interface DeleteBankCardApi ()

@property (nonatomic, copy) NSString *bankId;
@property (nonatomic, copy) NSString *password;

@end

@implementation DeleteBankCardApi

- (instancetype)initWithBankId:(NSString *)bankId password:(NSString *)password{
    self = [super init];
    if (self) {
        _bankId = bankId;
        _password = password;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/user/deleteBankCard";
}

- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_bankId forKey:@"bankId"];
    [paramDict setValue:_password forKey:@"payPwd"];
    return paramDict;
}

@end
