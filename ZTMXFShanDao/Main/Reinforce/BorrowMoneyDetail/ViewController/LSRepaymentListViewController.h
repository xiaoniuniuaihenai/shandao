//
//  LSRepaymentListViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/18.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  还款明细

#import "BaseViewController.h"

@interface LSRepaymentListViewController : BaseViewController

/** 借款id (如果是还款记录页面需要这个参数用作获取还款记录接口参数) */
@property (nonatomic, copy) NSString *borrowId;

@end
