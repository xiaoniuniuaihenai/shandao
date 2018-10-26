//
//  LSLoanListViewController.h
//  YWLTMeiQiiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  借钱记录/还款明细(使用同一个页面)

#import "BaseViewController.h"
#import "ZTMXFTableViewController.h"
typedef enum : NSUInteger {
    LoanListViewControllerType,         //  借钱记录
    RepaymentListViewControllerType,    //  还款记录
} viewControllerType;

@interface LSLoanListViewController : ZTMXFTableViewController

@property (nonatomic, assign) viewControllerType controllerType;

/** 借款id (如果是还款记录页面需要这个参数用作获取还款记录接口参数) */
@property (nonatomic, copy) NSString *borrowId;

@end
