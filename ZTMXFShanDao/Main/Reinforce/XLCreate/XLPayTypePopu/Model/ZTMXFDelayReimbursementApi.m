//
//  ZTMXFDelayReimbursementApi.m
//  YWLTMeiQiiOS
//
//  Created by 陈传亮 on 2018/6/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFDelayReimbursementApi.h"
@interface ZTMXFDelayReimbursementApi ()

@property(nonatomic, copy)NSDictionary * payInfoDic;

@end
@implementation ZTMXFDelayReimbursementApi


- (instancetype)initWithPayInfoDic:(NSDictionary *)payInfoDic
{
    self = [super init];
    if (self) {
        _payInfoDic = payInfoDic;
    }
    return self;
}
-(NSString * )requestUrl
{
    return @"/pay/payRenewal";
}

-(id)requestArgument
{
    return _payInfoDic;
}
@end
