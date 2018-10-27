//
//  LSPayFailureViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
// 还款失败

#import "BaseViewController.h"
typedef enum : NSUInteger {
    PayFailureResultNotOpenUnionpayType,                //  未开通银行联支付
    PayFailureResultBankCardInsufficientBalanceType,    //  银行卡余额不足
    PayFailureResultBankCardNumberLimitedType,          //    银行卡次数超限制
    PayFailureResultAmountLimitedType,                  //    金额超限
    PayFailureResultRenewalPayType,                  //    延期还款支付失败

} PayFailureResultType;

@interface LSPayFailureViewController : BaseViewController

@property (nonatomic, assign) PayFailureResultType failureResultType;

/** 未开通银联无卡支付功能 */
@property (nonatomic, copy) NSString *payName;
/** 你的银行开未开通银联无卡支付功能 */
@property (nonatomic, copy) NSString *payDesc;

@end
