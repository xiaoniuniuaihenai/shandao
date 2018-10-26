//
//  OrderDetailInfoManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderDetailInfoModel;
@class MyOrderDetailModel;

#define kOrderGoodsTotalAmount       @"商品总额"
#define kOrderGoodsDiscountAmount    @"商品优惠"
#define kOrderExpressCost            @"运费"
#define kOrderNperCount              @"分期数"

#define kOrderTotalAmount            @"订单总额"
#define kOrderNumber                 @"订单编号"
#define kOrderStartTime              @"下单时间"
#define kOrderPayTime                @"付款时间"
#define kOrderDeliverTime            @"发货时间"
#define kOrderSuccessTime            @"成交时间"
#define kOrderCloseTime              @"关闭时间"


typedef enum : NSUInteger {
    MallOrderType,          //  商城订单
    ConsumeLoanOrderType,   //  消费贷订单
    MobileOrderType,        //  手机充值订单
} OrderType;

@interface ZTMXFOrderDetailInfoManager : NSObject

/** 获取商城订单详情展示数据数组 */
+ (NSArray *)orderDetailArrayFromDetailInfoModel:(OrderDetailInfoModel *)orderDetailInfoModel;

/** 获取商城订单详情展示数据数组 */
+ (NSArray *)consumeLoanOrderDetailArrayFromDetailInfoModel:(MyOrderDetailModel *)loanOrderDetailModel;

/** 获取该状态下显示的按钮 */
+ (NSArray *)buttonTitleArrayFromeStatus:(NSInteger)status refundStatus:(NSInteger)refundStatus orderType:(OrderType)orderType;

@end
