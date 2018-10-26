//
//  LSPaymentOrderViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"

@interface LSPaymentOrderViewController : BaseViewController
/** 订单Id */
@property (nonatomic, copy) NSString *orderId;
/** 订单总额 */
@property (nonatomic, copy) NSString *totalAmount;

@end
