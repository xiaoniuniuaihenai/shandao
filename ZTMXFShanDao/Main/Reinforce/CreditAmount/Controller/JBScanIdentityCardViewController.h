//
//  JBScanIdentityCardViewController.h
//  JiBeiCreditConsume
//
//  Created by yangpenghua on 2017/11/22.
//  Copyright © 2017年 jibei. All rights reserved.
//  证件认证

#import "BaseViewController.h"

@interface JBScanIdentityCardViewController : BaseViewController

/** 认证类型 */
@property (nonatomic, assign) RealNameAuthenticationType authType;

/** 借款类型 */
@property (nonatomic, assign) LoanType loanType;

/** 是否我的页面进入 */
@property (nonatomic, assign) BOOL isAddBankCard;

@end
