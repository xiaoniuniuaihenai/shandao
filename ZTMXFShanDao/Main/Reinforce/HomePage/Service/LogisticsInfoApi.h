//
//  LogisticsInfoApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  获取物流信息

#import "BaseRequestSerivce.h"

@interface LogisticsInfoApi : BaseRequestSerivce
-(instancetype)initWithOrderId:(NSString *)orderId type:(NSString *)type;
@end
