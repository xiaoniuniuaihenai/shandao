//
//  OrderDetailHeaderView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderDetailInfoModel;
@class MyOrderDetailModel;

@protocol OrderDetailHeaderViewDelegate <NSObject>

/** 查看退款详情 */
- (void)orderDetailHeaderViewRefundDetail;
/** 添加地址 */
- (void)orderDetailHeaderViewAddAddress;
/** 查看商品详情 */
- (void)orderDetailHeaderViewGoodsDetail;

@end

@interface ZTMXFOrderDetailHeaderView : UIView

@property (nonatomic, weak) id<OrderDetailHeaderViewDelegate> delegate;

/** 商城订单详情Model */
@property (nonatomic, strong) OrderDetailInfoModel *orderDetailInfoModel;

/** 消费贷订单详情Model */
@property (nonatomic, strong) MyOrderDetailModel *loanOrderDetailModel;

@property (nonatomic, assign) BOOL isHiddenAddressView;

@end
