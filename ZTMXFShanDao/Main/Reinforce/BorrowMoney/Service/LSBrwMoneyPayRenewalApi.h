//
//  LSBrwMoneyPayRenewalApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  续期支付

#import "BaseRequestSerivce.h"

@interface LSBrwMoneyPayRenewalApi : BaseRequestSerivce

/**
 续期支付

 @param borrowId 借钱id
 @param payPwd 支付密码
 @param cardId 银行卡id， -1:微信支付， -2:余额支付 -3：支付宝
 @param renewalAmount 延期还款金额
 @param capital 延期还款还款本金
 */
-(instancetype)initWithBorrowId:(NSString*)borrowId andPayPwd:(NSString*)payPwd andCardId:(NSString*)cardId renewalAmount:(NSString *)renewalAmount repaymentCapital:(NSString *)capital loanType:(NSString *)loanType renewalPoundageRate:(NSString *)poundageRate;
@end
