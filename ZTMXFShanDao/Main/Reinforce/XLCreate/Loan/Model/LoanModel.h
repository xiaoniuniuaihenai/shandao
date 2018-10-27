//
//  LoanModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by 陈传亮 on 2018/3/8.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WhiteStatusInfo :NSObject 
@property (nonatomic , copy) NSString              * bankStatus;
@property (nonatomic , copy) NSString              * overdueRate;
@property (nonatomic , copy) NSString              * bankRate;
@property (nonatomic , copy) NSString              * faceStatus;

@end

@interface ScrollbarList :NSObject

@property (nonatomic , copy) NSString              * content;
@property (nonatomic , assign) BOOL               isNeedLogin;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * wordUrl;

@end

@interface BannerList :NSObject

@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * sort;
@property (nonatomic , assign) BOOL               isNeedLogin;
@property (nonatomic , copy) NSString              * imageUrl;
@property (nonatomic , copy) NSString              * titleName;
@property (nonatomic , copy) NSString              * background;
@property (nonatomic , copy) NSString              * type;

@end

@interface StatusInfo :NSObject
@property (nonatomic , copy) NSString              * lender;
@property (nonatomic , copy) NSString              * bankStatus;
/**
 贷款服务费率
 */
@property (nonatomic , copy) NSString              * xlPoundageRate;
@property (nonatomic , copy) NSString              * faceStatus;
@property (nonatomic , copy) NSString              * maxAmount;
@property (nonatomic , copy) NSString              * poundageRate;
@property (nonatomic , copy) NSString              * minAmount;
@property (nonatomic , copy) NSString              * canBorrowDays;
@property (nonatomic , copy) NSString              * overdueRate;
@property (nonatomic , copy) NSString              * bankRate;
/**
 贷款天数
 */
@property (nonatomic , copy) NSString              * xlBorrowDays;
/**
 借钱页文案  1.1.1之后新增
 */
@property (nonatomic , copy) NSString              * msgTig;



/** 最小金额    */
//@property (nonatomic, assign) CGFloat minAmount;
/** 最大金额*/
//@property (nonatomic, assign) CGFloat maxAmount;
/** 央行基准费率率（日）*最高倍数    */
//@property (nonatomic, copy) NSString  *bankRate;
/** 手续费率*/
//@property (nonatomic, copy) NSString  *poundageRate;
/** 7,14*/
//@property (nonatomic, copy) NSString *canBorrowDays;
/** 合规后的手续费率（可配）【名字区分是为了版本兼容】
 前段展示的消费金额=借款金额*手续费率*天数-借款金额*新手续费率*天数 */
//@property (nonatomic, assign) CGFloat newPoundageRate;
/** 消费贷可借钱天数 */
@property (nonatomic, copy) NSString *borrowMoneyDays;

#pragma mark - 打款中
/** 预计XX时间后到账中的“XX” */
@property (nonatomic, copy) NSString *arrivalDesc;

#pragma  mark - 打款中  待打款
/** 到账金额*/
@property (nonatomic, copy) NSString * arrivalAmount;

#pragma mark - 待还款
/** 逾期状态：1：逾期；0：未逾期    */
@property (nonatomic, assign) NSInteger overdueStatus;
/** 借款金额*/
@property (nonatomic, copy) NSString *amount;
/** 应还金额    */
@property (nonatomic, copy) NSString *returnAmount;
/** 未还本金 （v1.0.3添加 逾期时展示） */
@property (nonatomic, copy) NSString *noReturnAmount;
/** 已还金额  待定*/
@property (nonatomic, copy) NSString *paidAmount;
/** 逾期金额*/
@property (nonatomic, copy) NSString *overdueAmount;
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
@property (nonatomic, copy) NSString * repayingMoney;
/** 借款类型【1现金借；2消费贷；】 */
@property (nonatomic, assign) NSInteger borrowType;
/** 还款类型：1：线上还款，2：线下还款，0：默认 V1.1.5 */
@property (nonatomic, assign) NSInteger repayType;
/** 温馨提示(只有在待还款的时候有, 还款中文案写死) */
@property (nonatomic, strong) NSArray *repayTypeDesc;

#pragma mark - 未完成认证 U
/** 是否活体认证 */
//@property (nonatomic, assign) NSInteger faceStatus;
/** 是否绑卡 */
//@property (nonatomic, assign) NSInteger bankStatus;








@end

@interface LoanModel :NSObject

//周转不过来,借贷超市来帮你的链接--160新增
@property (nonatomic, strong)  NSString                     *otherLoanShopH5Url;

@property (nonatomic , strong) WhiteStatusInfo              * whiteStatusInfo;
@property (nonatomic , strong) NSArray<ScrollbarList *>     * scrollbarList;
@property (nonatomic , strong) NSArray<BannerList *>        * bannerList;
@property (nonatomic , strong) NSArray<BannerList *>        * botBannerList;
@property (nonatomic , strong) StatusInfo              * statusInfo;

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


@property (nonatomic , copy) NSArray              * bannerImgs;
@property (nonatomic , copy) NSArray              * titles;
@property (nonatomic , copy) NSArray              * days;







//自＋ 借钱参数
@property (nonatomic , copy) NSString              * timeParameter;
@property (nonatomic , copy) NSString              * amountParameter;




- (void)updateData;

@end

