//
//  OrderDetailInfoViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderDetailInfoModel;
@class MyOrderDetailModel;

@protocol OrderDetailInfoViewModelDelegate <NSObject>

/** 获取商城订单信息成功 */
- (void)requestMallOrderDetailInfoSuccess:(OrderDetailInfoModel *)orderDetailInfoModel;

/** 获取消费贷订单信息成功 */
- (void)requestConsumeLoanOrderDetailInfoSuccess:(MyOrderDetailModel *)orderDetailInfoModel;

@end

@interface ZTMXFOrderDetailInfoViewModel : NSObject

/** 获取商城订单详情信息 */
- (void)requestMallOrderDetailInfoWithOrderId:(NSString *)orderId showLoading:(BOOL)showLoad;

/** 获取消费贷订单详情信息 */
- (void)requestConsumeLoanOrderDetailInfoWithOrderId:(NSString *)orderId showLoading:(BOOL)showLoad;

@property (nonatomic, weak) id<OrderDetailInfoViewModelDelegate> delegate;

@end
