//
//  ApplyRefundDataInfoApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface ApplyRefundDataInfoApi : BaseRequestSerivce

- (instancetype)initWithOrderId:(NSString *)orderId;

@end
