//
//  LSLoanRenewalViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/11/16.
//  Copyright © 2017年 LSCredit. All rights reserved.
// 延期还款

#import "BaseViewController.h"
#import "ZTMXFTableViewController.h"
@interface LSLoanRenewalViewController : ZTMXFTableViewController

/** 借款id */
@property (nonatomic, copy) NSString *borrowId;
/** 还款金额 */
@property (nonatomic, assign) CGFloat repaymentAmount;
/** 借款类型 */
@property (nonatomic, assign) LoanType loanType;

@end
