//
//  CreateMobileRechargeOrderApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2018/1/31.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  创建充值订单

#import <Foundation/Foundation.h>
#import "BaseRequestSerivce.h"
@class CreateRechargeOrderInfoModel;
@interface CreateMobileRechargeOrderApi : BaseRequestSerivce
-(instancetype)initWithOrderInfo:(CreateRechargeOrderInfoModel *)orderModel;
@end
