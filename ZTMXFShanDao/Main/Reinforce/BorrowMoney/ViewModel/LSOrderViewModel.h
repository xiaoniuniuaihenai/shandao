//
//  LSOrderViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/12.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyOrderDetailModel;

@protocol LSOrderViewModelDelegate <NSObject>

@optional
/** 成功获取个人订单列表 */
- (void)requestOrderListDataSuccess:(NSArray *)orderArray;

/** 成功获取订单详情 */
- (void)requestOrderDetailSuccess:(MyOrderDetailModel *)orderDetailModel;

/** 获取数据失败*/
- (void)requestOrderDataFailure;

@end

@interface LSOrderViewModel : NSObject

@property (nonatomic, weak) id <LSOrderViewModelDelegate> delegete;

/** 请求订单列表 */
- (void)requestOrderListDataWithPageNum:(NSInteger)page;
/** 请求订单详情 */
- (void)requestOrderDetailWithOrderId:(NSString *)orderId;

@end
