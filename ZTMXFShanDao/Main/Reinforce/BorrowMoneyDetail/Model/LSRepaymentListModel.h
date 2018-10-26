//
//  LSRepaymentListModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/24.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSRepaymentListModel : NSObject

/** 还款Id */
@property (nonatomic, assign) long rid;
/** 还款描述 */
@property (nonatomic, copy) NSString *repayDec;
/** 还款时间 */
@property (nonatomic, assign) long long gmtRepay;
/** 还款金额 */
@property (nonatomic, assign) CGFloat amount;
/** 还款状态【’0’-新建状态,'1'-还款成功,'2':处理中, -1：”还款失败” */
@property (nonatomic, assign) NSInteger status;
/** 状态描述 */
@property (nonatomic, copy) NSString *statusDesc;

@end
