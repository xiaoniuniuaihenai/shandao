//
//  GoodsConfirmOrderInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSAddressModel;
@class OrderGoodsInfoModel;

@interface GoodsConfirmOrderInfoModel : NSObject

/** 商品信息Model */
@property (nonatomic, strong) OrderGoodsInfoModel *goodsInfo;

/** 地址Model */
@property (nonatomic, strong) LSAddressModel *address;

/** 购买数量 */
@property (nonatomic, assign) NSInteger num;
/** 订单总额 */
@property (nonatomic, assign) double totalAmount;

@end
