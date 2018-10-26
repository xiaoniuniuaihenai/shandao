//
//  ZTMXFGoodsBillRepayApi.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFGoodsBillRepayApi.h"

@interface ZTMXFGoodsBillRepayApi ()

@property(nonatomic, copy)NSDictionary * payInfoDic;

@end
@implementation ZTMXFGoodsBillRepayApi


- (instancetype)initWithPayInfoDic:(NSDictionary *)payInfoDic
{
    self = [super init];
    if (self) {
        _payInfoDic = payInfoDic;
    }
    return self;
}
- (NSString *)requestUrl{
    return @"/pay/payGoodsBillRepay";
}

//- (id)requestArgument
//{
//    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
//    [paramDict setValue:_billIds forKey:@"billIds"];
//    [paramDict setValue:_repaymentAmount forKey:@"repaymentAmount"];
//    [paramDict setValue:_password forKey:@"payPwd"];
//    [paramDict setValue:_cardId forKey:@"cardId"];
//    [paramDict setValue:_latitude forKey:@"latitude"];
//    [paramDict setValue:_longitude forKey:@"longitude"];
//    return paramDict;
//}

-(id)requestArgument
{
    return _payInfoDic;
}
@end
