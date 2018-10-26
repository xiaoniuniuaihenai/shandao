//
//  RefundDetailInfoApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface RefundDetailInfoApi : BaseRequestSerivce

- (instancetype)initWithOrderId:(NSString *)orderId;

@end
