//
//  LSLoanRepayViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/25.
//  Copyright © 2017年 LSCredit. All rights reserved.
// 立即还款

#import "BaseViewController.h"

@interface LSLoanRepayViewController : BaseViewController
/** 借款类型 */
@property (nonatomic, assign) LoanType loanType;

/** 还款金额 */
@property (nonatomic, assign) CGFloat repayAmount;
/** 借款ID */
@property (nonatomic, copy) NSString *borrowId;

@end
