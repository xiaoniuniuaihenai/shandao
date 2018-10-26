//
//  LSRepaymentPageInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/26.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CounponModel;

@interface LSRepaymentPageInfoModel : NSObject

/** 账户余额 */
@property (nonatomic, assign) CGFloat rebateAmount;
/** 可用优惠券 */
@property (nonatomic, strong) CounponModel *userCouponInfo;
/** 银行卡列表 */
@property (nonatomic, strong) NSArray *bankList;
/** 最低还款金额 */
@property (nonatomic, assign) double minPayAmount;

@end
