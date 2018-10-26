//
//  ZTMXFBankCardSigningApi.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFBankCardSigningApi.h"



@interface ZTMXFBankCardSigningApi ()

@property(nonatomic, copy)NSString * bankCardId;
@property(nonatomic, copy)NSString * amount;
@property(nonatomic, copy)NSString * bizCode;
@property(nonatomic, copy)NSString * borrowId;



@end
@implementation ZTMXFBankCardSigningApi


- (instancetype)initWithBankCardId:(NSString *)bankCardId amount:(NSString *)amount bizCode:(NSString *)bizCode borrowId:(NSString *)borrowId
{
    self = [super init];
    if (self) {
        _bankCardId = bankCardId;
        _amount = amount;
        _bizCode = bizCode;
        _borrowId = borrowId;
    }
    return self;
}
- (NSString *)requestUrl{
    return @"/repayCash/getRepayBankCardSigningState";
}

- (id)requestArgument
{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_bankCardId forKey:@"bankId"];
    [paramDict setValue:_amount forKey:@"amount"];
    [paramDict setValue:_bizCode forKey:@"bizCode"];
    [paramDict setValue:_borrowId forKey:@"borrowId"];

    return paramDict;
}


@end

