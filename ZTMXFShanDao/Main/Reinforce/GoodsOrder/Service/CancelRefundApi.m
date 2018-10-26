//
//  CancelRefundApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/15.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "CancelRefundApi.h"

@interface CancelRefundApi ()

@property (nonatomic, copy) NSString *refundId;

@end

@implementation CancelRefundApi

- (instancetype)initWithRefundId:(NSString *)refundId{
    if (self = [super init]) {
        _refundId = refundId;
    }
    return self;
}



- (NSString * )requestUrl{
    return @"/mall/cancelOrderRefund";
}

- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.refundId forKey:@"refundId"];
    return paramDict;
}

@end
