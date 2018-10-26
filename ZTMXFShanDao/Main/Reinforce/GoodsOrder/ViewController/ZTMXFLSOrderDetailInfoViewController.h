//
//  LSOrderDetailInfoViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    MallOrderDetailType,// 商城分期订单详情
    ConsumeLoanOrderDetailType,// 消费贷订单详情
    MobileLoanOrderDetailType,// 手机充值订单详情
} OrderDetailType;

@interface ZTMXFLSOrderDetailInfoViewController : BaseViewController
/** 订单id */
@property (nonatomic, copy) NSString *orderId;
/** 订单类型 */
@property (nonatomic, assign) OrderDetailType orderDetailType;

@end
