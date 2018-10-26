//
//  GoodsBillRepayApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface GoodsBillRepayApi : BaseRequestSerivce

- (instancetype)initWithBillId:(NSString *)billIds repaymentAmount:(NSString *)repaymentAmount password:(NSString *)password cardId:(NSString *)cardId latitude:(NSString*)latitude longitude:(NSString*)longitude;

@end
