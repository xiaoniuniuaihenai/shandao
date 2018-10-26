//
//  LogisticsInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "LogisticsInfoApi.h"
@interface LogisticsInfoApi()
@property (nonatomic,copy) NSString * orderId;
@property (nonatomic,copy) NSString * type;
@end
@implementation LogisticsInfoApi
-(instancetype)initWithOrderId:(NSString *)orderId type:(NSString *)type{
    if (self=[super init]) {
        _orderId = orderId;
        _type = type;
    }
    return self;
}


-(id)requestArgument{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:_orderId forKey:@"orderId"];
    [dic setValue:_type forKey:@"type"];
    return dic;
}

-(NSString *)requestUrl{
    return @"/mall/getOrderLogistics";
}
@end
