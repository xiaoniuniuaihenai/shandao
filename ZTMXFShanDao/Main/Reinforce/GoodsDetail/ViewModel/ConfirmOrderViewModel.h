//
//  ConfirmOrderViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsConfirmOrderInfoModel;

@protocol ConfirmOrderViewModelDelegate <NSObject>

/** 获取确认订单页面信息成功 */
- (void)requestConfirmOrderInfoSuccess:(GoodsConfirmOrderInfoModel *)confirmOrderInfoModel;
/** 提交订单成功 */
- (void)requestSubmitOrderSuccess:(NSString *)orderId;

@end

@interface ConfirmOrderViewModel : NSObject

/** 获取确认订单信息 */
- (void)requestConfirmOrderInfoWithGoodsId:(NSString *)goodsId skuId:(NSString *)skuId goodsCount:(NSString *)goodsCount;

/** 订单下单 */
- (void)requestSubmitOrderWithGoodsId:(NSString *)goodsId skuId:(NSString *)skuId goodsCount:(NSString *)goodsCount addressId:(NSString *)addressId;


@property (nonatomic, weak) id<ConfirmOrderViewModelDelegate> delegate;

@end
