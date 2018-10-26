//
//  LSRepaymentDetailModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSRepaymentDetailModel : NSObject


/** 还款失败原因  134版本新增 */
@property (nonatomic, copy) NSString * failReason;
/** 还款本金 */
@property (nonatomic, assign) CGFloat amount;
/** 还款状态【’0’-新建状态,'1'-还款成功,'2':处理中, -1：”还款失败”】 */
@property (nonatomic, assign) NSInteger status;
/** 还款状态描述 */
@property (nonatomic, copy) NSString *statusDesc;
/** 优惠金额 */
@property (nonatomic, assign) CGFloat couponAmount;
/** 账户余额使用余额 */
@property (nonatomic, assign) CGFloat userAmount;
/** 实际支付金额 */
@property (nonatomic, assign) CGFloat cashAmount;
/** 支付银行卡号 */
@property (nonatomic, copy) NSString *cardNumber;
/** 银行名称 */
@property (nonatomic, copy) NSString *cardName;
/** 还款编号 */
@property (nonatomic, copy) NSString *repayNo;
/** 还款时间 */
@property (nonatomic, assign) long long gmtCreate;

@end
