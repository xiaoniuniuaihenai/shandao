//
//  MyOrderModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2017/12/10.
//  Copyright © 2017年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderModel : NSObject

@property (nonatomic, copy) NSString *url;// 商品图片url

@property (nonatomic, copy) NSString *name;// 商品名

@property (nonatomic, copy) NSString *price;// 商品价格

@property (nonatomic, copy) NSString *purchaseTime;// 购买时间

@property (nonatomic, assign) int orderStatus;// 订单状态

@property (nonatomic, copy) NSString *orderStatusStr;// 

@property (nonatomic, copy) NSString *orderId;// 订单id

@end

@interface MyOrderDetailModel : NSObject

/* 商品图片url*/
@property (nonatomic, copy) NSString *url;
/* 商品名*/
@property (nonatomic, copy) NSString *name;
/* 订单状态*/
@property (nonatomic, assign) NSInteger orderStatus;
/* 订单状态描述*/
@property (nonatomic, copy) NSString *orderStatusStr;
/** 状态提示 */
@property (nonatomic, copy) NSString *orderStatusPrompt;
/* 商品价格*/
@property (nonatomic, copy) NSString *price;
/* 下单时间*/
@property (nonatomic, copy) NSString *purchaseTime;
/* 收货地址*/
@property (nonatomic, copy) NSString *address;
/* 收货人*/
@property (nonatomic, copy) NSString *consignee;
/* 手机号*/
@property (nonatomic, copy) NSString *consigneeMobile;
/* 发货时间*/
@property (nonatomic, copy) NSString *gmtDeliverStr;
/**物流公司号 */
@property (nonatomic, copy) NSString *logisticsCompany;
/* 物流订单号*/
@property (nonatomic, copy) NSString *logisticsNo;
/* 交易订单号*/
@property (nonatomic, copy) NSString *orderNo;
/* 成交时间*/
@property (nonatomic, copy) NSString *transactionTime;
/* 商品原价*/
@property (nonatomic, copy) NSString *originPrice;

/** descUrl(商品详情) */
@property (nonatomic, copy) NSString *descUrl;

@end


