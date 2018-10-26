//
//  ApplyRefundDataInfoApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ApplyRefundDataInfoApi.h"
@interface ApplyRefundDataInfoApi ()

@property (nonatomic, copy) NSString *orderId;

@end

@implementation ApplyRefundDataInfoApi

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
- (NSString * )requestUrl{
    return @"/mall/getApplyRefundConfirm";
}
@end
