//
//  LSAuthSupplyVerifyingApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  提交补充认证  结果
//公积金认证  0  社保认证 1  信用卡认证2 支付宝 3

#import "BaseRequestSerivce.h"
@interface LSAuthSupplyVerifyingApi : BaseRequestSerivce
-(instancetype)initWithVerifyingType:(AuthSupplyType)verfyingType;
@end
