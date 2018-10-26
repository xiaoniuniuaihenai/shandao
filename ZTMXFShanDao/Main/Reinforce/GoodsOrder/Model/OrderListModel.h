//
//  OrderListModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OrderGoodsInfoModel;

@interface OrderListModel : NSObject

/** 订单Id */
@property (nonatomic, assign) long orderId;
/** 订单类型 1 消费贷 2 分期商城 3 手机充值*/
@property (nonatomic, assign) NSInteger orderType;
/** 购买时间 */
@property (nonatomic, assign) long long gmtCreate;
/** 分期商城：【0：待付款；1:交易成功；2:支付中；3:待发货；4：待收货；5、审核中(针对分期人工审核)；6:关闭订单 7.审核被驳回】 */
/** 消费贷：【1:交易成功；2:待发货；3:已发货；4订单关闭；-1：填写收货地址】 */
@property (nonatomic, assign) NSInteger status;
/** 订单状态文案 */
@property (nonatomic, copy) NSString *statusDesc;
/** 售后状态：分期商城 退款状态： 1:退款成功 2: 退款失败 3:退款中 5:审核中 默认为0 */
@property (nonatomic, assign) NSInteger afterSaleStatus;
/** 订单合计金额 */
@property (nonatomic, assign) double totalAmount;
/** 总计个数 */
@property (nonatomic, assign) NSInteger totalCount;

/** 商品信息 */
@property (nonatomic, strong) OrderGoodsInfoModel *goodsInfo;

@end


