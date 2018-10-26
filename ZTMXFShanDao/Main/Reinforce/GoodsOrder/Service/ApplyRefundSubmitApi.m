//
//  ApplyRefundSubmitApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ApplyRefundSubmitApi.h"
@interface ApplyRefundSubmitApi ()
/** 订单id */
@property (nonatomic, copy) NSString *orderId;
/** 退款原因 */
@property (nonatomic, copy) NSString *reason;
/** 退款说明 */
@property (nonatomic, copy) NSString *refundDesc;
/** 退款金额 */
@property (nonatomic, copy) NSString *refundAmount;
/** 经纬度 */
@property (nonatomic, copy) NSString *latitudeString;
@property (nonatomic, copy) NSString *longitudeString;

@end

@implementation ApplyRefundSubmitApi

- (instancetype)initWithOrderId:(NSString *)orderId refundReason:(NSString *)reason refundDesc:(NSString *)refundDesc refundAmount:(NSString *)refundAmount latitude:(NSString *)latitudeString longitude:(NSString *)longitudeString{
    if (self = [super init]) {
        _orderId = orderId;
        _reason = reason;
        _refundDesc = refundDesc;
        _refundAmount = refundAmount;
        _latitudeString = latitudeString;
        _longitudeString = longitudeString;
    }
    return self;
}



- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.orderId forKey:@"orderId"];
    [paramDict setValue:self.reason forKey:@"reason"];
    [paramDict setValue:self.refundDesc forKey:@"desctiption"];
    [paramDict setValue:self.refundAmount forKey:@"amount"];
    [paramDict setValue:self.latitudeString forKey:@"latitude"];
    [paramDict setValue:self.longitudeString forKey:@"longitude"];
    return paramDict;
}
- (NSString * )requestUrl{
    return @"/mall/applyOrderRefund";
}
@end
