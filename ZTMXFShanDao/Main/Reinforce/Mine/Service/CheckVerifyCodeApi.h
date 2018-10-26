//
//  CheckVerifyCodeApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  校验验证码

#import "BaseRequestSerivce.h"

@interface CheckVerifyCodeApi : BaseRequestSerivce

- (instancetype)initWithCode:(NSString *)code type:(NSString *)type;

@end
