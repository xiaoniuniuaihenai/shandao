//
//  LSOrderDetailApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/13.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "LSOrderDetailApi.h"

@interface LSOrderDetailApi ()

@property (nonatomic, copy) NSString *orderId;

@end

@implementation LSOrderDetailApi

- (instancetype)initWithOrderId:(NSString *)orderId{
    self = [super init];
    if (self) {
        _orderId = orderId;
    }
    return self;
}

-(NSString * )requestUrl{
    return @"/user/getConsumdebtOrderDetail";
}

-(id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:_orderId forKey:@"orderId"];
    
    return paramDict;
}

@end
