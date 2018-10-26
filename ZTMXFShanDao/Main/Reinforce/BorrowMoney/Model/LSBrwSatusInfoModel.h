//
//  LSBrwSatusInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by 朱吉达 on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSBrwSatusInfoModel : NSObject
#pragma mark - 可借款 C状态
/** 最小金额	*/
@property (nonatomic, assign) CGFloat minAmount;
/** 最大金额*/
@property (nonatomic, assign) CGFloat maxAmount;
/** 央行基准费率率（日）*最高倍数    */
@property (nonatomic,copy) NSString * bankRate;
/** 手续费率*/
@property (nonatomic,copy) NSString * poundageRate;
/** 7,14*/
@property (nonatomic, copy) NSString *canBorrowDays;
/**是否显示手续费率降低的提示弹窗，1表示弹窗，0表示不弹窗 */
@property (nonatomic,assign  ) NSInteger showRatePopup;
/** 合规后的手续费率（可配）【名字区分是为了版本兼容】
 前段展示的消费金额=借款金额*手续费率*天数-借款金额*新手续费率*天数 */
@property (nonatomic, assign) CGFloat newPoundageRate;
/** 消费贷可借钱天数 */
//@property (nonatomic, copy) NSString *newBorrowDays;

#pragma mark - 打款中
/** 预计XX时间后到账中的“XX” */
@property (nonatomic,copy) NSString *arrivalDesc;
#pragma  mark - 打款中  待打款
/** 到账金额*/
@property (nonatomic, assign) double arrivalAmount;

#pragma mark - 待打款
/** 逾期状态：1：逾期；0：未逾期	*/
@property (nonatomic,assign) NSInteger overdueStatus;
/** 借款金额*/
@property (nonatomic,assign) double amount;
/** 应还金额	*/
@property (nonatomic,assign) double returnAmount;
/** 未还本金 （v1.0.3添加 逾期时展示） */
@property (nonatomic,assign) double noReturnAmount;
/**已还金额  待定*/
@property (nonatomic,assign) double paidAmount;
/** 逾期金额*/
@property (nonatomic,assign) double overdueAmount;
/** 逾期天数*/
@property (nonatomic,copy) NSString *overdueDay;
/** 借款id	*/
@property (nonatomic,copy) NSString *rid;
/** 还款日 时间戳*/
@property (nonatomic,copy) NSString *repaymentDay;

/** 借钱天数【7/14】*/
@property (nonatomic,copy) NSString * borrowDays;
/** 倒计时天数 */
@property (nonatomic,copy) NSString * deadlineDay;
/**  续期状态（1可延期还款，2延期还款中，0不可延期还款）*/
@property (nonatomic,assign) NSInteger renewalStatus;
/** 是否存在还款处理中金额（1 是  0否） */
@property (nonatomic,assign)  NSInteger existRepayingMoney;
/** 还款处理中金额，默认为0 */
@property (nonatomic,assign) double repayingMoney;
/** 借款类型【1现金借；2消费贷；】 */
@property (nonatomic, assign) NSInteger borrowType;
/** 还款类型：1：线上还款，2：线下还款，0：默认 V1.1.5 */
@property (nonatomic,assign) NSInteger repayType;


#pragma mark - 未完成认证 U
/** 是否活体认证 */
@property (nonatomic,assign) NSInteger faceStatus;
/** 是否绑卡 */
@property (nonatomic,assign) NSInteger bankStatus;

/** 1.3版本 借贷超市发现 */
@property (nonatomic,copy) NSString * findUrl;


@end
