//
//  LSPeriodBillModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSPeriodBillModel : NSObject

/** 总金额 */
@property (nonatomic, copy) NSString *allAmount;
/** tab栏目数量 */
@property (nonatomic, assign) NSInteger tableNum;
/** 是否使用过分期【1:使用过；0:没有使用】 */
@property (nonatomic, assign) NSInteger isMallNper;
/** 文案描述 */
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, strong) NSArray *billList;

@end

@interface PeriodBillListModel : NSObject

/** 账单ID */
@property (nonatomic, assign) long rid;
/** 商品名称 */
@property (nonatomic, copy) NSString *name;
/** 账单金额 */
@property (nonatomic, assign) CGFloat amount;
/** 第几期 */
@property (nonatomic, assign) NSInteger billNper;
/** 总共几期 */
@property (nonatomic, assign) NSInteger nper;
/** 借款时间 */
@property (nonatomic, assign) long long gmtBorrow;
/** 计划应还时间 */
@property (nonatomic, assign) long long gmtPlanRepay;
/** 逾期状态 */
@property (nonatomic, assign) NSInteger overdueStatus;
/** 借款ID */
@property (nonatomic, assign) long borrowId;
/** 订单ID */
@property (nonatomic, copy) NSString *orderId;

@end
