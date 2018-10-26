//
//  OrderListFrame.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFOrderListFrame.h"
#import "OrderListModel.h"

@implementation ZTMXFOrderListFrame

- (void)setOrderListModel:(OrderListModel *)orderListModel{
    _orderListModel = orderListModel;
    
    /** 订单类型 1 消费贷 2 分期商城 3 手机充值 */
    if (_orderListModel.orderType == 2) {
        //  分期商城订单
        NSInteger orderStatus = _orderListModel.status;
        /** 分期商城：【0：待付款；1:交易成功；2:支付中；3:待发货；4：待收货；5、审核中(针对分期人工审核)；6:关闭订单 7.审核被驳回】 */
        if (orderStatus == 0 || orderStatus == 3 || orderStatus == 4 || orderStatus == 1 || orderStatus == 7) {
            //  显示按钮的高度
            if (orderStatus == 3) {
                NSInteger refundStatus = _orderListModel.afterSaleStatus;
                /** 售后状态：分期商城 退款状态： 1:退款成功 2: 退款失败 3:退款中 5:审核中 默认为0 */
                if (refundStatus == 1 || refundStatus == 2 || refundStatus == 3 || refundStatus == 5) {
                    _cellHeight = AdaptedHeight(235.0);
                    _buttonBgViewHeight = AdaptedHeight(50.0);
                } else {
                    _cellHeight = AdaptedHeight(235.0);
                    _buttonBgViewHeight = AdaptedHeight(50.0);
                }
            } else {
                _cellHeight = AdaptedHeight(235.0);
                _buttonBgViewHeight = AdaptedHeight(50.0);
            }
        } else {
            //  没有按钮的高度
            _cellHeight = AdaptedHeight(185.0);
            _buttonBgViewHeight = 0.0;
        }
    } else if (_orderListModel.orderType == 1){
        //  消费贷订单
        NSInteger orderStatus = _orderListModel.status;
        /** 消费贷：【1:交易成功；2:待发货；3:已发货；4订单关闭；-1：填写收货地址】 */
        if (orderStatus == -1) {
            _cellHeight = AdaptedHeight(235.0);
            _buttonBgViewHeight = AdaptedHeight(50.0);
        } else {
            _cellHeight = AdaptedHeight(185.0);
            _buttonBgViewHeight = 0.0;
        }
    } else if (_orderListModel.orderType == 3) {
        //  手机充值订单
        /** 手机充值：【0：待付款；1:交易成功；6:关闭订单  */
        NSInteger orderStatus = _orderListModel.status;
        if (orderStatus == 0 || orderStatus == 6) {
            _cellHeight = AdaptedHeight(235.0);
            _buttonBgViewHeight = AdaptedHeight(50.0);
        } else {
            //  没有按钮的高度
            _cellHeight = AdaptedHeight(185.0);
            _buttonBgViewHeight = 0.0;
        }
    }
}

@end
