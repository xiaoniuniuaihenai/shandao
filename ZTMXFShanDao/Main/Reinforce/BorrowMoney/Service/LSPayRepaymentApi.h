//
//  LSPayRepaymentApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  支付还款接口

#import "BaseRequestSerivce.h"

@interface LSPayRepaymentApi : BaseRequestSerivce

- (instancetype)initWithBorrowId:(NSString *)borrowId actualAmount:(NSString *)actualAmount repaymentAmount:(NSString *)repaymentAmount couponId:(NSString *)couponId rebateAmount:(NSString *)rebateAmount password:(NSString *)password cardId:(NSString *)cardId loanType:(NSString *)loanType;

@end
