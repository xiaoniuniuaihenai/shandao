//
//  LSAuthStrongRiskApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  提交强风控

#import "BaseRequestSerivce.h"

@interface LSAuthStrongRiskApi : BaseRequestSerivce
- (instancetype)initWithAuthType:(LoanType)authType entranceType:(NSString *)entrance Latitude:(NSString *)latitude Longitude:(NSString *)longitude;
@end
