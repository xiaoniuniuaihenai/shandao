//
//  LSLoanDetailModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSLoanDetailModel : NSObject

/** 借款金额 */
@property (nonatomic, assign) CGFloat amount;
/** 到账金额 */
@property (nonatomic, assign) CGFloat arrivalAmount;
/** 【0:申请/未审核,1:已结清（已结清）,2:打款中,3:打款失败,4:关闭,5:已经打款/待还款,6:还款中7已逾期 */
@property (nonatomic, assign) NSInteger status;
/** 借款天数 */
@property (nonatomic, assign) NSInteger borrowDays;
/** 申请时间 */
@property (nonatomic, assign) long long gmtCreate;
/** 服务费 */
@property (nonatomic, assign) CGFloat serviceAmount;
/** 打款时间 */
@property (nonatomic, assign) long long gmtArrival;
/** 借款编号 */
@property (nonatomic, copy) NSString *borrowNo;
/** 银行卡号 */
@property (nonatomic, copy) NSString *bankCard;
/** 银行名称 */
@property (nonatomic, copy) NSString *bankName;
/** 关闭时间 */
@property (nonatomic, assign) long long gmtClose;
/** 关闭原因 */
@property (nonatomic, copy) NSString *closeReason;
/** 应还金额 */
@property (nonatomic, assign) CGFloat returnAmount;
/** 已还金额 */
@property (nonatomic, assign) CGFloat paidAmount;
/** 最后还款时间 */
@property (nonatomic, assign) long long gmtLastRepay;
/** 逾期天数 */
@property (nonatomic, assign) NSInteger overdueDay;
/** 滞纳金 */
@property (nonatomic, assign) CGFloat overdueAmount;
/** 逾期状态(0没有逾期, 1表示逾期) */
@property (nonatomic, assign) NSInteger overdueStatus;
/** 借款id */
@property (nonatomic, copy) NSString *rid;
/** 返利金额 */
@property (nonatomic, assign) CGFloat rebateAmount;
/** 是否显示续期入口【1.显示（申请延期还款）；0不显示；2显示（延期还款处理中） */
@property (nonatomic, assign) NSInteger renewalStatus;
/** 续期天数 */
@property (nonatomic, assign) NSInteger renewalDay;
/** 可延期还款金额 */
@property (nonatomic, assign) CGFloat renewalAmount;
/** 累计续期次数 */
@property (nonatomic, assign) NSInteger renewalNum;

/** 状态描述 */
@property (nonatomic, copy) NSString *statusDesc;
/** 状态描述下面的文案提示 */
@property (nonatomic, copy) NSString *remindInfo;

/** 未还本金 */
@property (nonatomic, assign) CGFloat noReturnAmount;

/** 借钱类型   （1：现金贷；2：消费贷；） */
@property (nonatomic, assign) NSInteger borrowType;

/** 商品金额 */
@property (nonatomic, assign) double goodsSaleAmount;
/** 利息 */
@property (nonatomic, assign) double rateAmount;

@end
