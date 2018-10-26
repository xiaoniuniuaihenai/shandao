//
//  LSAuthSupplyCertifyModel.h
//  ALAFanBei
//
//  Created by Try on 2017/7/10.
//  Copyright © 2017年 讯秒. All rights reserved.
//  提示额度  公积金  社保 信用卡  V3.7.0

#import <Foundation/Foundation.h>

@interface LSAuthSupplyCertifyModel : NSObject

/**公积金认证状态*/
@property (nonatomic,assign)  NSInteger fundStatus;
/**社保认证状态*/
@property (nonatomic,assign) NSInteger  socialSecurityStatus;
/**信用卡认证状态*/
@property (nonatomic,assign) NSInteger  creditStatus;
/*额度提示信息*/
@property (nonatomic,copy  ) NSString * reminder;
/** 支付宝认证状态【0:A未认证，-1:n认证失败，2:W认证中，1:Y已通过认证 */
@property (nonatomic, assign) NSInteger alipayStatus;
/** 当前额度*/
@property (nonatomic,assign) double currentAmount;
/** 最高可提升到的额度 */
@property (nonatomic,assign) double highestAmount;


/** 用户是否已发起过公积金认证，如果为Y，且fundStatus的状态为A，则显示“认证失败”，可重新认证；如果fundStatus的状态为N，则显示“认证未通过”，不可重新认证	【1：已经发起过，0：未发起过】*/
@property (nonatomic, assign) NSInteger gmtFundExist;

/**
 用户是否已发起过社保认证，如果为Y，且socialSecurityStatus的状态为A，则显示“认证失败”，可重新认证；如果socialSecurityStatus的状态为N，则显示“认证未通过”，不可重新认证	【1：已经发起过，0：未发起过】
 */
@property (nonatomic, assign) NSInteger gmtSocialSecurityExist;

/**
 用户是否已发起过信用卡认证，如果为Y，且creditStatus的状态为A，则显示“认证失败”，可重新认证；如果creditStatus的状态为N，则显示“认证未通过”，不可重新认证	【1：已经发起过，0：未发起过】
 */
@property (nonatomic, assign) NSInteger gmtCreditExist;

/**
 用户是否已发起过支付宝认证，如果为Y，且alipayStatus的状态为A，则显示“认证失败”，可重新认证；如果alipayStatus的状态为N，则显示“认证未通过”，不可重新认证	【1：已经发起过，0：未发起过】
 */
@property (nonatomic, assign) NSInteger gmtAlipayExist;

/** 公司电话号码 */
@property (nonatomic, copy) NSString *phoneAuth;

/** 白领贷认证状态 0:未审核，-1:未通过审核，2: 审核中，1:已通过审核 */
@property (nonatomic, assign) NSInteger whiteRisk;
/** 白领贷审核没有通过提示 */
@property (nonatomic, copy) NSString *whiteRiskRemind;

/** 1.6.0版本*/
/**
 公司认证状态 【0：未认证，1：已经认证， -1：认证失败, 2:认证中】
 */
@property (nonatomic, assign) NSInteger companyStatus;

@end
