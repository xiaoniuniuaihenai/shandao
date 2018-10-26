//
//  LSBrwGetConfirmRenewalApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  获取延期还款信息

#import "BaseRequestSerivce.h"

@interface LSBrwGetConfirmRenewalApi : BaseRequestSerivce
-(instancetype)initWithBorrowId:(NSString*)borrowId loanType:(LoanType)loanType;
@end
