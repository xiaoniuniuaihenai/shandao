//
//  LSRenewDetailModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSRenewDetailModel : NSObject
/** 续期应缴费用(利息+手续费+滞纳金)  从延期还款记录传入*/
@property (nonatomic, assign) CGFloat renewalPayAmount;

/** 续期本金 */
@property (nonatomic, assign) CGFloat renewalAmount;
/** 上期利息 */
@property (nonatomic, assign) CGFloat priorInterest;
/** 上期滞纳金 */
@property (nonatomic, assign) CGFloat priorOverdue;
/** 下期手续费 */
@property (nonatomic, assign) CGFloat nextPoundage;
/** 支付方式 */
@property (nonatomic, copy) NSString *cardName;
/** 支付编号 */
@property (nonatomic, copy) NSString *tradeNo;
/** 创建时间 */
@property (nonatomic, assign) long long  gmtCreate;
/** 延期还款编号 */
@property (nonatomic, copy) NSString *renewalNo;
/** 延期还款支付本金 */
@property (nonatomic, assign) CGFloat capital;
/** 状态描述 */
@property (nonatomic, copy) NSString *statusDesc;
/** 借款id */
@property (nonatomic, assign) long borrowId;
/** 延期还款天数 */
@property (nonatomic, assign) NSInteger renewalDays;

/** 失败原因  134版本增加 */
@property (nonatomic, copy) NSString *failReason;


@end
