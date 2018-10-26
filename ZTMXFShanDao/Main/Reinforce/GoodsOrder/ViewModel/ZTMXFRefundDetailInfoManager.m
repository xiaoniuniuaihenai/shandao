//
//  RefundDetailInfoManager.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "ZTMXFRefundDetailInfoManager.h"
#import "ZTMXFRefundDetailInfoModel.h"

@implementation ZTMXFRefundDetailInfoManager

/** 获取退款详情展示数据数组 */
+ (NSArray *)refundDetailArrayFromRefundInfoModel:(ZTMXFRefundDetailInfoModel *)refundDetailInfoModel{
    NSMutableArray *resultArray = [NSMutableArray array];
    
    //  第一个数组
    NSMutableArray *firstArray = [NSMutableArray array];
    
    //  退款原因
    NSMutableDictionary *refundReasonDict = [NSMutableDictionary dictionary];
    [refundReasonDict setValue:kRefundReason forKey:kTitleValueCellManagerKey];
    [refundReasonDict setValue:refundDetailInfoModel.reason forKey:kTitleValueCellManagerValue];
    [firstArray addObject:refundReasonDict];

    //  退款金额
    NSMutableDictionary *refundAmountDict = [NSMutableDictionary dictionary];
    [refundAmountDict setValue:kRefundAmount forKey:kTitleValueCellManagerKey];
    [refundAmountDict setValue:[NSString stringWithFormat:@"￥%.2f", refundDetailInfoModel.amount] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:refundAmountDict];

    //  退款说明
    NSMutableDictionary *refundDescDict = [NSMutableDictionary dictionary];
    [refundDescDict setValue:kRefundDescription forKey:kTitleValueCellManagerKey];
    [refundDescDict setValue:refundDetailInfoModel.reasonDesc forKey:kTitleValueCellManagerValue];
    [firstArray addObject:refundDescDict];

    //  申请时间
    NSMutableDictionary *refundDateDict = [NSMutableDictionary dictionary];
    [refundDateDict setValue:kRefundApplyDate forKey:kTitleValueCellManagerKey];
    [refundDateDict setValue:[NSDate dateStringFromLongDate:refundDetailInfoModel.gmtCreate] forKey:kTitleValueCellManagerValue];
    [firstArray addObject:refundDateDict];

    
    
    //  第二个数组
    NSMutableArray *secondArray = [NSMutableArray array];

    //  订单编号
    NSMutableDictionary *refundOrderNumberDict = [NSMutableDictionary dictionary];
    [refundOrderNumberDict setValue:kRefundOrderNumber forKey:kTitleValueCellManagerKey];
    [refundOrderNumberDict setValue:refundDetailInfoModel.orderNo forKey:kTitleValueCellManagerValue];
    [secondArray addObject:refundOrderNumberDict];

    [resultArray addObject:firstArray];
    [resultArray addObject:secondArray];
    
    return resultArray;
}

@end
