//
//  ForgetPasswordApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface ForgetPasswordApi : BaseRequestSerivce

- (instancetype)initWithPassword:(NSString *)password securityCode:(NSString *)code;

@end
