//
//  OrderStatusView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderDetailInfoModel;
@class ZTMXFRefundDetailInfoModel;
@class MyOrderDetailModel;

@protocol OrderStatusViewDelegate <NSObject>

/** 查看退款详情 */
- (void)orderStatusViewRefundDetail;

@end

@interface OrderStatusView : UIView

@property (nonatomic, weak) id<OrderStatusViewDelegate> delegate;

/** 商城订单详情Model */
@property (nonatomic, strong) OrderDetailInfoModel *orderDetailInfoModel;

/** 退款详情Model */
@property (nonatomic, strong) ZTMXFRefundDetailInfoModel *refundDetailInfoModel;

/** 消费贷订单详情Model */
@property (nonatomic, strong) MyOrderDetailModel *loanOrderDetailModel;

@end
