//
//  ZTMXFRefundDetailInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/14.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApplyRefundGoodsInfoModel.h"

@interface ZTMXFRefundDetailInfoModel : NSObject

/** 退款Id */
@property (nonatomic, copy) NSString *rid;
/** 售后状态：0:申请退款 1:退款成功 2.退款中 3:同意退款 -1:拒绝退货退款 */
@property (nonatomic, assign) NSInteger status;
/** 状态描述 */
@property (nonatomic, copy) NSString *label;
/** 退款申请时间 */
@property (nonatomic, assign) long long gmtCreate;
/** 退款金额 */
@property (nonatomic, assign) double amount;
/** 退款原因 */
@property (nonatomic, copy) NSString *reason;
/** 退款说明 */
@property (nonatomic, copy) NSString *reasonDesc;
/** 审核拒绝原因 */
@property (nonatomic, copy) NSString *checkReason;
/** 订单编号 */
@property (nonatomic, copy) NSString *orderNo;

/** 商品信息 */
@property (nonatomic, strong) ApplyRefundGoodsInfoModel *goodsInfo;

@end
