//
//  LSLoanRecordModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/19.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSLoanRecordModel : NSObject

/** 借款id */
@property (nonatomic, copy) NSString *rid;
/** 借款金额 */
@property (nonatomic, assign) CGFloat amount;
/** 借款时间 */
@property (nonatomic, assign) long long gmtCreate;
/** 借款状态【0:申请/未审核,1:已结清,2:打款中,3:打款失败,4:关闭,5:已经打款/待还款】 */
@property (nonatomic, copy) NSString *status;
/** 状态描述 */
@property (nonatomic, copy) NSString *statusDesc;
/** 借款类型：1:现金贷；2:消费贷：3:白领贷 */
@property (nonatomic, assign) NSInteger type;
/** 借款类型描述：现金贷;消费贷;白领贷 */
@property (nonatomic, copy) NSString *typeDesc;

@end
