//
//  LSPaySuccessViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/10/27.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  还款成功

#import "BaseViewController.h"

typedef enum : NSUInteger {
    PaySuccessResultRepaymentType,    //  还款成功
    PaySuccessResultRenewalType,    //  延期还款成功

} PaySuccessResultType;

@interface LSPaySuccessViewController : BaseViewController

@property (nonatomic, assign) PaySuccessResultType successResultType;

/** 支付成功，您的还款申请已经提交 */
@property (nonatomic, copy) NSString *submitName;
/** 还款金额500元 */
@property (nonatomic, copy) NSString *submitDesc;
/** 完成还款 */
@property (nonatomic, copy) NSString *finishName;
/** 您的账单状态 */
@property (nonatomic, copy) NSString *finishDesc;

@end
