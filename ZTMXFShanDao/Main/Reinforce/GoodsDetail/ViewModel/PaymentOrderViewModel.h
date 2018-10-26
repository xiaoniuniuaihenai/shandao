//
//  PaymentOrderViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderPayDetailModel;

@protocol PaymentOrderViewModelDelegate <NSObject>

/** 获取订单付款详情信息成功 */
- (void)requestPaymentOrderViewInfoSuccess:(OrderPayDetailModel *)orderPayDetailModel;

@end

@interface PaymentOrderViewModel : NSObject

/** 获取支付订单页面信息 */
- (void)requestPaymentOrderViewInfoWithOrderId:(NSString *)orderId;

@property (nonatomic, weak) id<PaymentOrderViewModelDelegate> delegate;

@end
