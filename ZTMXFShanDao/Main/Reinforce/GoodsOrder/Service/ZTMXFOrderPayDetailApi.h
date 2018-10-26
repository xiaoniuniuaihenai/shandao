//
//  OrderPayDetailApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface ZTMXFOrderPayDetailApi : BaseRequestSerivce

- (instancetype)initWithOrderId:(NSString *)orderId;

@end
