//
//  RefundDetailInfoManager.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZTMXFRefundDetailInfoModel;

#define kRefundReason   @"退款原因"
#define kRefundAmount   @"退款金额(含运费)"
#define kRefundDescription  @"退款说明"
#define kRefundApplyDate    @"申请时间"

#define kRefundOrderNumber  @"订单编号"

@interface ZTMXFRefundDetailInfoManager : NSObject

/** 获取退款详情展示数据数组 */
+ (NSArray *)refundDetailArrayFromRefundInfoModel:(ZTMXFRefundDetailInfoModel *)refundDetailInfoModel;

@end
