//
//  CounponModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/22.
//  Copyright © 2017年 LSCredit. All rights reserved.
//  优惠券Model

#import <Foundation/Foundation.h>

@interface CounponModel : NSObject

/** 优惠券名称 */
@property (nonatomic, copy) NSString *name;
/** 优惠金额 */
@property (nonatomic, assign) CGFloat amount;
/** 限制启用金额 */
@property (nonatomic, assign) CGFloat limitAmount;
/** 使用须知 */
@property (nonatomic, copy) NSString *useRule;
/** 开始时间 */
@property (nonatomic, assign) long long gmtStart;
/** 截止时间 */
@property (nonatomic, assign) long long gmtEnd;
/** 状态 【 2:过期 ; 0:未使用 ， 1:已使 */
@property (nonatomic, assign) NSInteger status;
/** 优惠券id */
@property (nonatomic, copy) NSString *rid;

/** 0:还款券 6:借款券 */
@property (nonatomic, copy) NSString *type;
@end
