//
//  ConfirmOrderView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsConfirmOrderInfoModel;
@class LSAddressModel;
@class OrderGoodsInfoModel;

@protocol ConfirmOrderViewDelegate <NSObject>
/** 选择地址 */
- (void)confirmOrderViewChoiseAddress;
/** 添加地址 */
- (void)confirmOrderViewAddAddress;
/** 点击提交订单 */
- (void)confirmOrderViewClickSubmitOrder;
/** 点击优惠券 */
- (void)confirmOrderViewChoiseCoupon;

@end

@interface ConfirmOrderView : UIView

@property (nonatomic, weak) id<ConfirmOrderViewDelegate> delegate;

/** 确认订单信息Model */
@property (nonatomic, strong) GoodsConfirmOrderInfoModel *confirmOrderInfoModel;

/** 显示地址还是显示添加地址 */
- (void)configShowAddressView:(BOOL)showAddress;
/** 配置地址 */
- (void)configAddressInfo:(LSAddressModel *)addressModel;
/** 配置商品信息 */
- (void)configGoodsInfo:(OrderGoodsInfoModel *)orderGoodsInfoModel;

@end
