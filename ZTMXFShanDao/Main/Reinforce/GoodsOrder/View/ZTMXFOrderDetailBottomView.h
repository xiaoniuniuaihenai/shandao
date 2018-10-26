//
//  OrderDetailBottomView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/9.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderDetailBottomViewDelegate <NSObject>

/** 去付款 */
- (void)orderDetailBottomViewClickPay;
/** 取消订单 */
- (void)orderDetailBottomViewClickCancelOrder;
/** 申请退款 */
- (void)orderDetailBottomViewClickApplyRefund;
/** 确认收货 */
- (void)orderDetailBottomViewClickConfirmReceive;
/** 查看物流 */
- (void)orderDetailBottomViewClickViewLogistics;
/** 重新购买 */
- (void)orderDetailBottomViewClickViewRepay;

@end

@interface ZTMXFOrderDetailBottomView : UIView

/** 显示的按钮数组 */
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, weak) id<OrderDetailBottomViewDelegate> delegate;

@end
