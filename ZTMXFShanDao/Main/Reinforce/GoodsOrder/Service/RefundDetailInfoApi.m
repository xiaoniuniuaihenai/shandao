//
//  RefundDetailInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "RefundDetailInfoApi.h"

@interface RefundDetailInfoApi ()

@property (nonatomic, copy) NSString *orderId;

@end

@implementation RefundDetailInfoApi



- (NSString * )requestUrl{
    return @"/mall/getOrderRefundDetail";
}
- (instancetype)initWithOrderId:(NSString *)orderId{
    if (self = [super init]) {
        _orderId = orderId;
    }
    return self;
}
- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.orderId forKey:@"orderId"];
    return paramDict;
}
@end
