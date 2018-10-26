//
//  MallBorrowInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "MallBorrowInfoApi.h"

@interface MallBorrowInfoApi ()

@property (nonatomic, copy) NSString *orderId;

@end

@implementation MallBorrowInfoApi

- (instancetype)initWithOrderId:(NSString *)orderId{
    self = [super init];
    if (self) {
        _orderId = orderId;
    }
    return self;
}



- (id)requestArgument{
    
    return @{@"orderId":self.orderId};
}
- (NSString *)requestUrl{
    return @"/mall/getMallBorrowInfo";
}
@end
