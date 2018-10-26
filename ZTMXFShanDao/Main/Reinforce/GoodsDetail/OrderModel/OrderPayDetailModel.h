//
//  OrderPayDetailModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/11.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BankCardModel;
@class GoodsNperInfoModel;

@interface OrderPayDetailModel : NSObject

/** 人脸状态 */
@property (nonatomic, assign) NSInteger faceStatus;
/** 绑卡状态 */
@property (nonatomic, assign) NSInteger bankStatus;
/** 芝麻认证状态 */
@property (nonatomic, assign) NSInteger zmStatus;
/** 认证状态 */
@property (nonatomic, assign) NSInteger weakRiskStatus;
/** 商城分期认证状态 */
@property (nonatomic, assign) NSInteger mallStatus;
/** 可用额度 */
@property (nonatomic, assign) double effectiveAmount;
/** 授信额度 */
@property (nonatomic, assign) double auAmount;

/** 银行卡信息 */
@property (nonatomic, strong) BankCardModel *bankInfo;

/** 最小分期信息 */
@property (nonatomic, strong) GoodsNperInfoModel *minNperInfo;

/** 分期数组 */
@property (nonatomic, strong) NSArray *nperList;

/** 账单总额 */
@property (nonatomic, copy) NSString *totalAmount;

/**实际支付金额 V2.0.1*/
@property (nonatomic, copy) NSString * orderActual;

/**充值金额／订单金额 V2.0.1*/
@property (nonatomic, copy) NSString * orderAmount;

/**充值手机号 V2.0.1*/
@property (nonatomic, copy) NSString * orderMobile;


@end
