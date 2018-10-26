//
//  CancelOrderApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/15.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "CancelOrderApi.h"

@interface CancelOrderApi ()

@property (nonatomic, copy) NSString *orderId;

@end

@implementation CancelOrderApi

- (instancetype)initWithOrderId:(NSString *)orderId{
    if (self = [super init]) {
        _orderId = orderId;
    }
    return self;
}

- (NSString * )requestUrl{
    return @"/mall/cancelMallOrder";
}



- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.orderId forKey:@"orderId"];
    return paramDict;
}
@end
