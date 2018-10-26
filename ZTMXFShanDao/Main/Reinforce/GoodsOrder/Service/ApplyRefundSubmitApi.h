//
//  ApplyRefundSubmitApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface ApplyRefundSubmitApi : BaseRequestSerivce

- (instancetype)initWithOrderId:(NSString *)orderId refundReason:(NSString *)reason refundDesc:(NSString *)refundDesc refundAmount:(NSString *)refundAmount latitude:(NSString *)latitudeString longitude:(NSString *)longitudeString;

@end
