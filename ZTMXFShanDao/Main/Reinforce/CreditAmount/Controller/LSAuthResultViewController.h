//
//  LSAuthResultViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//  审核结果

#import "BaseViewController.h"
@class LSAuthInfoModel;

@interface LSAuthResultViewController : BaseViewController

/** 借款类型 */
@property (nonatomic, assign) LoanType loanType;
/** 认证详情model */
@property (nonatomic, strong) LSAuthInfoModel *authInfoModel;

@end
