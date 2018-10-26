//
//  OrderListViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OrderListViewModelDelegate <NSObject>

@optional
/** 获取订单列表成功 */
- (void)requestOrderListSuccessWithPageNumber:(NSInteger)pageNumber orderArray:(NSArray *)orderArray;
/** 获取订单列表失败 */
- (void)requestOrderListFailure;

/** 取消订单成功 */
- (void)requestCancelOrderSuccess;
/** 确认收货成功 */
- (void)requestOrderConfirmReceiveSuccess;

@end

@interface ZTMXFOrderListViewModel : NSObject

@property (nonatomic, weak) id<OrderListViewModelDelegate> delegate;

/** 根据页面获取订单列表 */
- (void)requestOrderListWithPageNumber:(NSInteger)pageNumber showLoading:(BOOL)showLoad;

/** 取消订单 */
- (void)requestCancelOrderWithOrderId:(NSString *)orderId;
/** 确认收货 */
- (void)requestOrderConfirmReceiveWithOrderId:(NSString *)orderId;

@end
