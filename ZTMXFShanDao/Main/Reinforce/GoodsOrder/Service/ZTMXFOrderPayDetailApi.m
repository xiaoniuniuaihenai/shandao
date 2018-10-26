//
//  OrderPayDetailApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFOrderPayDetailApi.h"

@interface ZTMXFOrderPayDetailApi ()

@property (nonatomic, copy) NSString *orderId;

@end

@implementation ZTMXFOrderPayDetailApi



- (NSString * )requestUrl{
    return @"/pay/getOrderPayInfo";
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
