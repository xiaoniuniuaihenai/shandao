//
//  LSGetAuthInfoApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface LSGetAuthInfoApi : BaseRequestSerivce

- (instancetype)initWithAuthType:(NSString *)authType;

@end