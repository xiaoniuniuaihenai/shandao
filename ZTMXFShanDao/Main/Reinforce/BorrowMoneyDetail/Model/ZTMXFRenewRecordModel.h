//
//  LSRenewRecordModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2017/9/23.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTMXFRenewRecordModel : NSObject

/** 续期ID */
@property (nonatomic, assign) long  rid;
/** 延期还款金额 */
@property (nonatomic, assign) CGFloat renewalAmount;
/** 续期天数 */
@property (nonatomic, assign) NSInteger renewalDay;
/** 续期状态【A:新建状态，P:处理中, Y:续期成功 , N:续期失败】 */
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *statusDesc;
/** 续期应缴费用(利息+手续费+滞纳金) */
@property (nonatomic, assign) CGFloat renewalPayAmount;
/** 申请时间 */
@property (nonatomic, assign) long long gmtCreate;
/** 延期还款方式 */
@property (nonatomic, copy) NSString *repayDesc;

@end
