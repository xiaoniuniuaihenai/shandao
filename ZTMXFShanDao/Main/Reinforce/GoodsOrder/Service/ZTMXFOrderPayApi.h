//
//  OrderPayApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  商城订单支付

#import "BaseRequestSerivce.h"

@interface ZTMXFOrderPayApi : BaseRequestSerivce

- (instancetype)initWithOrderId:(NSString *)orderId password:(NSString *)password cardId:(NSString *)cardId nper:(NSString *)nper latitude:(NSString*)latitude longitude:(NSString*)longitude province:(NSString*)province city:(NSString*)city county:(NSString*)county;

@end
