//
//  LSBorrowHomeInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  借钱模型
#import <Foundation/Foundation.h>
#import "LSBorrowGoodsScrollBarModel.h"
#import "LSBorrowBannerModel.h"
#import "LSHornBarModel.h"
@class WhiteLoanStatusInfo;
@class ConsumeLoanStatusInfo;

@interface LSBorrowHomeInfoModel : NSObject

@property (nonatomic, strong) NSArray    *bannerList;
/** 头部 弹幕*/
@property (nonatomic, strong) NSArray    *scrollbarList;
/** 是否可借款  【U 未完成认证， N 不可借钱 ，C 可借款， I 打款中，T 待还款】*/
@property (nonatomic, copy)   NSString   *canBorrow;
/** 是否可借款  【U 未完成认证， N 不可借钱 ，C 可借款， I 打款中，T 待还款】*/
@property (nonatomic, copy)   NSString   *canWhiteBorrow;
/** 出借人  V1.1.0 之后统一放在外部 V1.7.0 抛弃*/
@property (nonatomic, copy)   NSString   *lender;

/**
 底部提示文案 V1.7.0 添加
 */
@property (nonatomic, copy)   NSString   *underReminder;
/** 强风控重新认证提示信息  canBorrow == U */
@property (nonatomic, copy)   NSString   *riskRetrialRemind;
/** 是否有活动：1是，0否 */
@property (nonatomic, assign) int        isActivityQuota;
/** 温馨提示信息 */
@property (nonatomic, copy) NSString    *warmPrompt;

/** 消费贷信息 */
@property (nonatomic, strong) ConsumeLoanStatusInfo *statusInfo;
/** 白领贷信息 */
@property (nonatomic, strong) WhiteLoanStatusInfo   *whiteStatusInfo;

@end


@interface ConsumeLoanStatusInfo : NSObject

#pragma mark - 可借款 C状态
/** 最小金额    */
@property (nonatomic, assign) CGFloat minAmount;
/** 最大金额*/
@property (nonatomic, assign) CGFloat maxAmount;
/** 央行基准费率率（日）*最高倍数    */
@property (nonatomic, copy) NSString  *bankRate;
/** 手续费率*/
@property (nonatomic, copy) NSString  *poundageRate;
/** 7,14*/
@property (nonatomic, copy) NSString *canBorrowDays;
/** 合规后的手续费率（可配）【名字区分是为了版本兼容】
 前段展示的消费金额=借款金额*手续费率*天数-借款金额*新手续费率*天数 */
@property (nonatomic, assign) CGFloat newPoundageRate;
/** 消费贷可借钱天数 */
@property (nonatomic, copy) NSString *borrowMoneyDays;

#pragma mark - 打款中
/** 预计XX时间后到账中的“XX” */
@property (nonatomic, copy) NSString *arrivalDesc;

#pragma  mark - 打款中  待打款
/** 到账金额*/
@property (nonatomic, assign) double arrivalAmount;

#pragma mark - 待还款
/** 逾期状态：1：逾期；0：未逾期    */
@property (nonatomic, assign) NSInteger overdueStatus;
/** 借款金额*/
@property (nonatomic, assign) double amount;
/** 应还金额    */
@property (nonatomic, assign) double returnAmount;
/** 未还本金 （v1.0.3添加 逾期时展示） */
@property (nonatomic, assign) double noReturnAmount;
/** 已还金额  待定*/
@property (nonatomic, assign) double paidAmount;
/** 逾期金额*/
@property (nonatomic, assign) double overdueAmount;
/** 逾期天数*/
@property (nonatomic, copy) NSString *overdueDay;
/** 借款id    */
@property (nonatomic, copy) NSString *rid;
/** 还款日 时间戳*/
@property (nonatomic, assign) long long repaymentDay;

/** 借钱天数【7/14】*/
@property (nonatomic, copy) NSString *borrowDays;
/** 倒计时天数 */
@property (nonatomic, assign) NSInteger deadlineDay;
/**  续期状态（1可延期还款，2延期还款中，0不可延期还款）*/
@property (nonatomic, assign) NSInteger renewalStatus;
/** 是否存在还款处理中金额（1 是  0否） */
@property (nonatomic, assign) NSInteger existRepayingMoney;
/** 还款处理中金额，默认为0 */
@property (nonatomic, assign) double repayingMoney;
/** 借款类型【1现金借；2消费贷；】 */
@property (nonatomic, assign) NSInteger borrowType;
/** 还款类型：1：线上还款，2：线下还款，0：默认 V1.1.5 */
@property (nonatomic, assign) NSInteger repayType;
/** 温馨提示(只有在待还款的时候有, 还款中文案写死) */
@property (nonatomic, strong) NSArray *repayTypeDesc;

#pragma mark - 未完成认证 U
/** 是否活体认证 */
@property (nonatomic, assign) NSInteger faceStatus;
/** 是否绑卡 */
@property (nonatomic, assign) NSInteger bankStatus;

@end


@interface WhiteLoanStatusInfo : NSObject

#pragma mark - 可借钱状态 C 和未完成认证状态 U
/** 白领贷最小额度 */
@property (nonatomic, assign) CGFloat whiteMinAmount;
/** 白领贷最高额度 */
@property (nonatomic, assign) CGFloat whiteMaxAmount;
/** 白领贷可借钱天数 30,60,90 */
@property (nonatomic, copy) NSString *whiteBorrowDays;
/** 白领贷手续费率 */
@property (nonatomic, assign) double whitePoundageRate;
/** 央行基准费率率（日）*最高倍数 */
@property (nonatomic, assign) double bankRate;

#pragma mark - 打款中
/** 到账金额 */
@property (nonatomic, assign) CGFloat arrivalAmount;
/** 预计XX时间后到账中的“XX” */
@property (nonatomic, copy) NSString *arrivalDesc;

#pragma mark - 待还款
/** 是否有逾期的账单：0：没有; 1：有 */
@property (nonatomic, assign) NSInteger overdueStatus;
/** 待还金额 */
@property (nonatomic, assign) CGFloat needPayAmount;
/** 借款id    */
@property (nonatomic, copy) NSString *rid;
/** 当前期数 */
@property (nonatomic, assign) NSInteger currentPeriods;
/** 总期数 */
@property (nonatomic, assign) NSInteger totalPeriods;
/** 当前期的预计还款日 */
@property (nonatomic, assign) long long gmtCurrentPlanRepay;
/** 当前期的待还金额 */
@property (nonatomic, assign) CGFloat currentPayAmount;
/** 当前期还款倒计时天数 */
@property (nonatomic, assign) NSInteger deadlineDay;
/** 是否存在还款处理中金额（1 是  0否) */
@property (nonatomic, assign) NSInteger existRepayingMoney;
/** 还款处理中金额 */
@property (nonatomic, assign) CGFloat repayingMoney;
/** 温馨提示(只有在待还款的时候有, 还款中文案写死) */
@property (nonatomic, strong) NSArray *repayTypeDesc;

#pragma mark - 未完成认证
/** 逾期费率 */
@property (nonatomic, copy) NSString *overdueRate;
/** 人脸识别状态 1 认证过 0 未认证 */
@property (nonatomic, assign) NSInteger faceStatus;
/** 绑卡状态 1 认证过 0 未认证 */
@property (nonatomic, assign) NSInteger bankStatus;

/** 白领嗲认证审核中 (状态为审核中时,有该字段) */
@property (nonatomic, copy) NSString *whiteAuthInfo;

/** 白领贷重新认证提示 */
@property (nonatomic, copy) NSString *whiteRiskRetrialRemind;
/** 重新认证提示天数(白领贷) */
@property (nonatomic, copy) NSString *whiteRiskRetrialRemindDay;

@end
