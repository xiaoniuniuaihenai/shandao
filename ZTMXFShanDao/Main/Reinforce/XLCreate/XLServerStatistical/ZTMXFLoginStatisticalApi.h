//
//  ZTMXFLoginStatisticalApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/5/23.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface ZTMXFLoginStatisticalApi : BaseRequestSerivce
/**
 1、统计渠道注册主页面PV/UV
 2、统计图形验证码弹窗PV、UV
 3、统计老用户弹窗PV、UV
 4、记录注册成功页PV/UV
 */
- (instancetype)initWithStepType:(int)stepType;

@end
