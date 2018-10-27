//
//  XLNewLoanRenewalViewController.h
//  YWLTMeiQiiOS
//
//  Created by 余金超 on 2018/5/2.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  延期还款

#import "BaseViewController.h"

@interface XLLoanRenewalViewController : BaseViewController

/** 借款id */
@property (nonatomic, copy) NSString *borrowId;
/** 还款金额 */
@property (nonatomic, assign) CGFloat repaymentAmount;
/** 借款类型 */
@property (nonatomic, assign) LoanType loanType;

@end
