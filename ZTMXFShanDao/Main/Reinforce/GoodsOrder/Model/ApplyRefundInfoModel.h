//
//  ApplyRefundInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ApplyRefundGoodsInfoModel;

@interface ApplyRefundInfoModel : NSObject

/** 能够退款最大金额 */
@property (nonatomic, assign) double amount;
/** 退款原因数组 */
@property (nonatomic, strong) NSArray *reasonList;
/** 商品信息 */
@property (nonatomic, strong) ApplyRefundGoodsInfoModel *goodsInfo;

@end

@interface ApplyRefundReasonModel : NSObject

/** 退款原因code */
@property (nonatomic, copy) NSString *code;
/** 退款描述 */
@property (nonatomic, copy) NSString *label;

@end

