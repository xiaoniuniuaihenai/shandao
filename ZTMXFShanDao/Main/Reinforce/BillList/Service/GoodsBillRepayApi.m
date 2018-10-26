//
//  GoodsBillRepayApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "GoodsBillRepayApi.h"

@interface GoodsBillRepayApi ()

@property (nonatomic, copy) NSString *billIds;

@property (nonatomic, copy) NSString *repaymentAmount;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *cardId;

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *longitude;

@end

@implementation GoodsBillRepayApi

- (instancetype)initWithBillId:(NSString *)billIds repaymentAmount:(NSString *)repaymentAmount password:(NSString *)password cardId:(NSString *)cardId latitude:(NSString*)latitude longitude:(NSString*)longitude
{
    self = [super init];
    if (self) {
        _billIds = billIds;
        _repaymentAmount = repaymentAmount;
        _password = password;
        _cardId = cardId;
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/pay/payGoodsBillRepay";
}



- (id)requestArgument{
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    [paramDict setValue:_billIds forKey:@"billIds"];
    [paramDict setValue:_repaymentAmount forKey:@"repaymentAmount"];
    [paramDict setValue:_password forKey:@"payPwd"];
    [paramDict setValue:_cardId forKey:@"cardId"];
    [paramDict setValue:_latitude forKey:@"latitude"];
    [paramDict setValue:_longitude forKey:@"longitude"];
    return paramDict;
}

@end
