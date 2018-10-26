//
//  LSRenewDetailViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  延期还款详情/ 还款详情 共用同一个页面

#import "BaseViewController.h"

typedef enum : NSUInteger {
    RenewDetailControllerType,          //  延期还款详情
    RepaymentDetailControllerType,      //  还款详情
} controllerType;

@interface LSRenewDetailViewController : BaseViewController

/** 页面类型 */
@property (nonatomic, assign) controllerType controllerType;

/** 延期还款ID */
@property (nonatomic, copy) NSString *renewId;

/**
 延期还款支付的费用
 */
@property (nonatomic, assign) CGFloat  renewalPayAmount;

/** 还款ID */
@property (nonatomic, copy) NSString *repaymentId;

@end
