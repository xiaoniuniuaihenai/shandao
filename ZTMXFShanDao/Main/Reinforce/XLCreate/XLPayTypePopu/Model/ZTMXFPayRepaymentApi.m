//
//  ZTMXFPayRepaymentApi.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/5/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFPayRepaymentApi.h"
@interface ZTMXFPayRepaymentApi ()

@property(nonatomic, copy)NSDictionary * payInfoDic;

@end
@implementation ZTMXFPayRepaymentApi

- (instancetype)initWithPayInfoDic:(NSDictionary *)payInfoDic
{
    self = [super init];
    if (self) {
        _payInfoDic = payInfoDic;
    }
    return self;
}
-(NSString * )requestUrl{
    return @"/pay/payRepayV2";
}

-(id)requestArgument
{
    return _payInfoDic;
}
@end
