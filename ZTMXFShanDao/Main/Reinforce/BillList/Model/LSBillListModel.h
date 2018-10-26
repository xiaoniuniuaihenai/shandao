//
//  LSBillListModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/9.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSBillListModel : NSObject

/** 借款类型 */
@property (nonatomic, copy) NSString *name;
/** 第几期 */
@property (nonatomic, assign) NSInteger billNper;
/** 总共几期 */
@property (nonatomic, assign) NSInteger nper;
/** 应还日期 */
@property (nonatomic, assign) long long gmtPlanRepayment;
/** 账单金额 */
@property (nonatomic, assign) CGFloat billAmount;
/** 订单状态 */
@property (nonatomic, copy) NSString *status;
/** 订单状态描述 */
@property (nonatomic, copy) NSString *statusDesc;
/** 账单ID */
@property (nonatomic, assign) long billId;
/** 逾期状态 */
@property (nonatomic, assign) NSInteger overdueStatus;
/** 借款ID */
@property (nonatomic, assign) long borrowId;

@end

@interface LSBillDetailModel : NSObject

/** 账单本金 */
@property (nonatomic, assign) CGFloat capitalAmount;
/** 账单状态【0-未还款 1-已还款 2-还款处理中 4-关闭】*/
@property (nonatomic, assign) NSInteger status;
/** 账单状态描述 */
@property (nonatomic, copy) NSString *statusDesc;
/** 应还金额 */
@property (nonatomic, assign) CGFloat billAmount;
/** 还款期数 */
@property (nonatomic, assign) NSInteger billNper;
/** 分期数 */
@property (nonatomic, assign) NSInteger nper;
/** 还款时间 */
@property (nonatomic, assign) long long gmtPlanRepayment;
/** 逾期天数 */
@property (nonatomic, assign) long overdueDays;
/** 逾期费 */
@property (nonatomic, assign) CGFloat overdueAmount;
/** 借款时间 */
@property (nonatomic, assign) long long gmtBorrow;
/** 支付银行卡号 */
@property (nonatomic, copy) NSString *cardNumber;
/** 银行名称 */
@property (nonatomic, copy) NSString *cardName;
/** 借款编号 */
@property (nonatomic, copy) NSString *borrowNo;
/** 借款天数 */
@property (nonatomic, assign) long borrowDays;
/** 借款ID */
@property (nonatomic, assign) long borrowId;

@end
