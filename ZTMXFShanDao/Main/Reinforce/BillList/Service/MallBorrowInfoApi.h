//
//  MallBorrowInfoApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface MallBorrowInfoApi : BaseRequestSerivce

- (instancetype)initWithOrderId:(NSString *)orderId;

@end
