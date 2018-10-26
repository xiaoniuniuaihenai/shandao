//
//  LSOrderPaySuccessViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/6.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"

@interface LSOrderPaySuccessViewController : BaseViewController

/** 订单Id */
@property (nonatomic, copy) NSString *orderId;
/** 支付金额 */
@property (nonatomic, copy) NSString *payAmount;
/** 状态描述 */
@property (nonatomic, copy) NSString *statusDesc;
/** 描述详情 */
@property (nonatomic, copy) NSString *finishDesc;

@end
