//
//  CancelOrderApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/15.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface CancelOrderApi : BaseRequestSerivce

- (instancetype)initWithOrderId:(NSString *)orderId;

@end
