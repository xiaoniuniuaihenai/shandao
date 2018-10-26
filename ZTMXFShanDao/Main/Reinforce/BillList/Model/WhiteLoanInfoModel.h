//
//  WhiteLoanInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WhiteLoanInfoModel : NSObject

/** 借款ID */
@property (nonatomic, assign) long rid;
/** 应还款总额 */
@property (nonatomic, assign) CGFloat amount;
/** 借款本金 */
@property (nonatomic, assign) CGFloat borrowAmount;
/** 总共几期 */
@property (nonatomic, assign) NSInteger nper;
/** 逾期费 */
@property (nonatomic, assign) CGFloat overdueAmount;
/** 利息 */
@property (nonatomic, assign) CGFloat interest;
/** 手续费 */
@property (nonatomic, assign) CGFloat poundageAmount;
/** 借款编号 */
@property (nonatomic, copy) NSString *borrowNo;
/** 借款时间 */
@property (nonatomic, assign) long long gmtBorrow;

/** 账单列表 */
@property (nonatomic, strong) NSArray *billList;

@end
