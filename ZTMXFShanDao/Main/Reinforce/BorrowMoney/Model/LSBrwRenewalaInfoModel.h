//
//  LSBrwRenewalaInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  申请续期内容

#import <Foundation/Foundation.h>

@interface LSBrwRenewalaInfoModel : NSObject

/** 借款id*/
@property (nonatomic,copy) NSString * rid;
/** 央行基准利率对应利息*/
@property (nonatomic,assign) double rateAmount;
/** 手续费*/
@property (nonatomic,assign) double poundage;
/** 滞纳金*/
@property (nonatomic,assign) double  overdueAmount;
/** 续期应缴费用(利息+手续费+滞纳金)*/
@property (nonatomic,assign) double  renewalPayAmount;
/** 续期金额*/
@property (nonatomic,assign) double  renewalAmount;
/** 延期还款天数 */
@property (nonatomic, copy) NSString* renewalDay;
/** 上期最低还款本金  有值显示*/
@property (nonatomic,assign) double  capital;

#pragma mark - V-1.3.0 添加
/** 最低还款本金金额 */
@property (nonatomic, assign) double lowestRenewalAmount;
/** 最高还款本金金额 */
@property (nonatomic, assign) double highestRenewalAmount;
/** 手续费率 */
@property (nonatomic, assign) double poundageRate;
/** 下期还款日期 */
@property (nonatomic, assign) long long nextGmtPlanRepayment;
/** 银行卡列表 */
@property (nonatomic, strong) NSArray *bankList;

/** 延期还款本金区间 不同服务费率 */
@property (nonatomic, strong) NSArray *renewalList;
/** 顶部还款百分比 */
@property (nonatomic, strong) NSString *msgTig;

@end

@interface RenewalAmountModel : NSObject

/** 最低还款本金金额 */
@property (nonatomic, assign) double lowsetPayAmount;
/** 最高还款本金金额 */
@property (nonatomic, assign) double highestPayAmount;
/** 手续费率 */
@property (nonatomic, assign) double regionPoundageRate;

@end
