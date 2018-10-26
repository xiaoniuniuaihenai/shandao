//
//  OrderDetailInfoManager.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/12.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFOrderDetailInfoManager.h"
#import "OrderDetailInfoModel.h"
#import "MyOrderModel.h"

@implementation ZTMXFOrderDetailInfoManager

/** 获取商城订单详情展示数据数组 */
+ (NSArray *)orderDetailArrayFromDetailInfoModel:(OrderDetailInfoModel *)orderDetailInfoModel{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    //  第一个数组
    NSMutableArray *firstArray = [NSMutableArray array];
    
    //  商品总额
    NSMutableDictionary *goodsAmountDict = [NSMutableDictionary dictionary];
    [goodsAmountDict setValue:kOrderGoodsTotalAmount forKey:kTitleValueCellManagerKey];
    [goodsAmountDict setValue:[NSString stringWithFormat:@"￥%.2f", orderDetailInfoModel.totalGoodsAmount] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:goodsAmountDict];
    
    //  商品优惠
    NSMutableDictionary *goodsDiscountDict = [NSMutableDictionary dictionary];
    [goodsDiscountDict setValue:kOrderGoodsDiscountAmount forKey:kTitleValueCellManagerKey];
    [goodsDiscountDict setValue:[NSString stringWithFormat:@"￥%.2f", orderDetailInfoModel.couponAmount] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:goodsDiscountDict];

    //  运费
    if (orderDetailInfoModel.freight > 0) {
        NSMutableDictionary *expressCostDict = [NSMutableDictionary dictionary];
        [expressCostDict setValue:kOrderExpressCost forKey:kTitleValueCellManagerKey];
        [expressCostDict setValue:[NSString stringWithFormat:@"￥%.2f", orderDetailInfoModel.freight] forKey:kTitleValueCellManagerValue];
        [firstArray addObject:expressCostDict];
    }
    
    //  分期数
    if (!kStringIsEmpty(orderDetailInfoModel.stageTitle)) {
        NSMutableDictionary *nperDict = [NSMutableDictionary dictionary];
        [nperDict setValue:kOrderNperCount forKey:kTitleValueCellManagerKey];
        [nperDict setValue:orderDetailInfoModel.stageTitle forKey:kTitleValueCellManagerValue];
        [firstArray addObject:nperDict];
    }
    
    //  应还金额
    NSMutableDictionary *orderAmountDict = [NSMutableDictionary dictionary];
    [orderAmountDict setValue:kOrderTotalAmount forKey:kTitleValueCellManagerKey];
    [orderAmountDict setValue:[NSString stringWithFormat:@"￥%.2f", orderDetailInfoModel.totalAmount] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:orderAmountDict];

    [resultArray addObject:firstArray];


    //  第二个数组
    NSMutableArray *secondArray = [NSMutableArray array];

    //  订单编号
    NSMutableDictionary *orderNumberDict = [NSMutableDictionary dictionary];
    [orderNumberDict setValue:kOrderNumber forKey:kTitleValueCellManagerKey];
    [orderNumberDict setValue:orderDetailInfoModel.orderNo forKey:kTitleValueCellManagerValue];
    [secondArray addObject:orderNumberDict];

    //  下单时间
    NSMutableDictionary *orderStartTimeDict = [NSMutableDictionary dictionary];
    [orderStartTimeDict setValue:kOrderStartTime forKey:kTitleValueCellManagerKey];
    [orderStartTimeDict setValue:[NSDate dateStringFromLongDate:orderDetailInfoModel.gmtCreate] forKey:kTitleValueCellManagerValue];
    [secondArray addObject:orderStartTimeDict];

    //  付款时间
    if (orderDetailInfoModel.gmtPay > 0) {
        NSMutableDictionary *orderPayTimeDict = [NSMutableDictionary dictionary];
        [orderPayTimeDict setValue:kOrderPayTime forKey:kTitleValueCellManagerKey];
        [orderPayTimeDict setValue:[NSDate dateStringFromLongDate:orderDetailInfoModel.gmtPay] forKey:kTitleValueCellManagerValue];
        [secondArray addObject:orderPayTimeDict];
    }

    //  发货时间
    if (orderDetailInfoModel.gmtDeliver > 0) {
        NSMutableDictionary *orderPayTimeDict = [NSMutableDictionary dictionary];
        [orderPayTimeDict setValue:kOrderDeliverTime forKey:kTitleValueCellManagerKey];
        [orderPayTimeDict setValue:[NSDate dateStringFromLongDate:orderDetailInfoModel.gmtDeliver] forKey:kTitleValueCellManagerValue];
        [secondArray addObject:orderPayTimeDict];
    }

    //  成交时间
    if (orderDetailInfoModel.gmtTakeOver > 0) {
        NSMutableDictionary *orderPayTimeDict = [NSMutableDictionary dictionary];
        [orderPayTimeDict setValue:kOrderSuccessTime forKey:kTitleValueCellManagerKey];
        [orderPayTimeDict setValue:[NSDate dateStringFromLongDate:orderDetailInfoModel.gmtTakeOver] forKey:kTitleValueCellManagerValue];
        [secondArray addObject:orderPayTimeDict];
    }

    
    //  关闭时间
    if (orderDetailInfoModel.gmtClose > 0) {
        NSMutableDictionary *orderPayTimeDict = [NSMutableDictionary dictionary];
        [orderPayTimeDict setValue:kOrderCloseTime forKey:kTitleValueCellManagerKey];
        [orderPayTimeDict setValue:[NSDate dateStringFromLongDate:orderDetailInfoModel.gmtClose] forKey:kTitleValueCellManagerValue];
        [secondArray addObject:orderPayTimeDict];
    }

    
    [resultArray addObject:secondArray];
    return resultArray;
}

/** 获取商城订单详情展示数据数组 */
+ (NSArray *)consumeLoanOrderDetailArrayFromDetailInfoModel:(MyOrderDetailModel *)loanOrderDetailModel{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    //  第一个数组
    NSMutableArray *firstArray = [NSMutableArray array];
    
    //  商品总额
    NSMutableDictionary *goodsAmountDict = [NSMutableDictionary dictionary];
    [goodsAmountDict setValue:kOrderGoodsTotalAmount forKey:kTitleValueCellManagerKey];
    [goodsAmountDict setValue:[NSString stringWithFormat:@"￥%@", loanOrderDetailModel.price] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:goodsAmountDict];
    
    //  商品优惠
    NSMutableDictionary *goodsDiscountDict = [NSMutableDictionary dictionary];
    [goodsDiscountDict setValue:kOrderGoodsDiscountAmount forKey:kTitleValueCellManagerKey];
    [goodsDiscountDict setValue:[NSString stringWithFormat:@"￥0.0"] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:goodsDiscountDict];
    
    //  订单金额
    NSMutableDictionary *orderAmountDict = [NSMutableDictionary dictionary];
    [orderAmountDict setValue:kOrderTotalAmount forKey:kTitleValueCellManagerKey];
    [orderAmountDict setValue:[NSString stringWithFormat:@"￥%@", loanOrderDetailModel.price] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:orderAmountDict];
    [resultArray addObject:firstArray];

    //  第二个数组
    NSMutableArray *secondArray = [NSMutableArray array];

    //  订单编号
    NSMutableDictionary *orderNumberDict = [NSMutableDictionary dictionary];
    [orderNumberDict setValue:kOrderNumber forKey:kTitleValueCellManagerKey];
    [orderNumberDict setValue:loanOrderDetailModel.orderNo forKey:kTitleValueCellManagerValue];
    [secondArray addObject:orderNumberDict];
    
    //  下单时间
    NSMutableDictionary *orderStartTimeDict = [NSMutableDictionary dictionary];
    [orderStartTimeDict setValue:kOrderStartTime forKey:kTitleValueCellManagerKey];
    [orderStartTimeDict setValue:loanOrderDetailModel.purchaseTime forKey:kTitleValueCellManagerValue];
    [secondArray addObject:orderStartTimeDict];
    
    
    //  发货时间
    if (!kStringIsEmpty(loanOrderDetailModel.gmtDeliverStr)) {
        NSMutableDictionary *orderPayTimeDict = [NSMutableDictionary dictionary];
        [orderPayTimeDict setValue:kOrderDeliverTime forKey:kTitleValueCellManagerKey];
        [orderPayTimeDict setValue:loanOrderDetailModel.gmtDeliverStr forKey:kTitleValueCellManagerValue];
        [secondArray addObject:orderPayTimeDict];
    }
    
    //  成功时间
    if (!kStringIsEmpty(loanOrderDetailModel.gmtDeliverStr)) {
        NSMutableDictionary *orderPayTimeDict = [NSMutableDictionary dictionary];
        [orderPayTimeDict setValue:kOrderSuccessTime forKey:kTitleValueCellManagerKey];
        [orderPayTimeDict setValue:loanOrderDetailModel.transactionTime forKey:kTitleValueCellManagerValue];
        [secondArray addObject:orderPayTimeDict];
    }
    
    [resultArray addObject:secondArray];
    return resultArray;

}

/** 获取该状态下显示的按钮 */
+ (NSArray *)buttonTitleArrayFromeStatus:(NSInteger)status refundStatus:(NSInteger)refundStatus orderType:(OrderType)orderType{
    /** 分期商城：【0：待付款；1:交易成功；2:支付中；3:待发货；4：待收货；5、审核中(针对分期人工审核)；6:关闭订单 7.审核被驳回】 */
    /** 售后状态：分期商城 退款状态： 1:退款成功 2: 退款失败 3:退款中 5:审核中 默认为0 */
    if (orderType == MallOrderType) {
        //  商城订单
        NSMutableArray *titleArray = [NSMutableArray array];
        if (status == 0) {
            //  待支付
            [titleArray addObject:kOrderButtonPay];
            [titleArray addObject:kOrderButtonCancelOrder];
        } else if (status == 3) {
            //  待发货
            if (refundStatus == 1 || refundStatus == 2 || refundStatus == 3 || refundStatus == 5) {
                //  退款状态下不显示按钮
                [titleArray addObject:kOrderButtonCheckRefundDetail];
            } else {
                [titleArray addObject:kOrderButtonApplyRefund];
            }
        } else if (status == 4) {
            //  待收货
            [titleArray addObject:kOrderButtonConfirmReceive];
            [titleArray addObject:kOrderButtonViewLogistics];
        } else if (status == 1) {
            //  交易成功
            [titleArray addObject:kOrderButtonViewLogistics];
        } else if (status == 7) {
            //  审核被驳回
            [titleArray addObject:kOrderButtonPay];
            [titleArray addObject:kOrderButtonCancelOrder];
        }
        
        return titleArray;
    } else if (orderType == ConsumeLoanOrderType) {
        /** 消费贷：【1:交易成功；2:待发货；3:已发货；4订单关闭；-1：填写收货地址】 */
        //  消费贷订单
        NSMutableArray *titleArray = [NSMutableArray array];
        if (status == -1) {
            //  填写地址
            [titleArray addObject:kOrderButtonWriteAddress];
        } else if (status == 1 || status == 3) {
            //  交易已完成、已发货 可查看物流
            [titleArray addObject:kOrderButtonViewLogistics];
        }
        
        return titleArray;
    } else if (orderType == MobileOrderType) {
        /** 手机充值：【0：待付款；1:交易成功；6:关闭订单 】 */
        NSMutableArray *titleArray = [NSMutableArray array];
        if (status == 0) {
            //  待支付
            [titleArray addObject:kOrderButtonPay];
            [titleArray addObject:kOrderButtonCancelOrder];
        } else if (status == 6) {
            //  订单关闭
            [titleArray addObject:kOrderButtonRepayOrder];
        }
        return titleArray;
    }
    
    return nil;
}






@end
