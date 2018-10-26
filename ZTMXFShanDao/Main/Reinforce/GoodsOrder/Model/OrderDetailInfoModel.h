//
//  OrderDetailInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderGoodsInfoModel;

@interface OrderDetailInfoModel : NSObject

/** 订单Id */
@property (nonatomic, assign) long orderId;
/** 分期商城：【0：待付款；1:交易成功；2:支付中；3:待发货；4：待收货；5、审核中(针对分期人工审核)；6:关闭订单 7.审核被驳回】 */
/** 消费贷：【1:交易成功；2:待发货；3:已发货；4订单关闭；-1：填写收货地址】 */
@property (nonatomic, assign) NSInteger status;
/** 订单状态文案 */
@property (nonatomic, copy) NSString *statusDesc;
/** 状态提示 */
@property (nonatomic, copy) NSString *statusPrompt;
/** 售后状态：分期商城 退款状态： 1:退款成功 2: 退款失败 3:退款中 5:审核中 默认为0 */
@property (nonatomic, assign) NSInteger afterSaleStatus;
/** 收货人 */
@property (nonatomic, copy) NSString *consignee;
/** 收货人手机号 */
@property (nonatomic, copy) NSString *mobile;
/** 收货地址 */
@property (nonatomic, copy) NSString *address;
/** 商品总额 */
@property (nonatomic, assign) double totalGoodsAmount;
/** 订单总额 */
@property (nonatomic, assign) double totalAmount;
/** 商品优惠金额 */
@property (nonatomic, assign) double couponAmount;

/** 商品分期信息 */
@property (nonatomic, copy) NSString *stageTitle;
/** 分期信息数组 */
@property (nonatomic, strong) NSArray *stageList;
/** 关闭时间 */
@property (nonatomic, assign) long long gmtClose;

/** 订单编号 */
@property (nonatomic, copy) NSString *orderNo;
/** 下单时间 */
@property (nonatomic, assign) long long gmtCreate;
/** 发货时间 */
@property (nonatomic, assign) long long gmtDeliver;
/** 成功时间 */
@property (nonatomic, assign) long long gmtPay;
/** 成交(到货)时间 */
@property (nonatomic, assign) long long gmtTakeOver;
/** 总个数 */
@property (nonatomic, assign) NSInteger totalCount;

/** 运费 */
@property (nonatomic, assign) double freight;

/** 商品信息 */
@property (nonatomic, strong) OrderGoodsInfoModel *goodsInfo;

@end

@interface OrderGoodsNperInfoModel : NSObject

/** 第几期 */
@property (nonatomic, copy) NSString *stageNum;
/** 分期金额 */
@property (nonatomic, assign) double stageAmount;
/** 分期明细 */
@property (nonatomic, copy) NSString *stageDetail;

@end



