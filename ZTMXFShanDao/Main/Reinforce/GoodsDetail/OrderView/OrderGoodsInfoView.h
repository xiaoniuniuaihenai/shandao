//
//  OrderGoodsInfoView.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderGoodsInfoModel;
@class ApplyRefundGoodsInfoModel;

@protocol OrderGoodsInfoViewDelegate <NSObject>
/** 查看商品详情 */
- (void)orderGoodsInfoViewClickGoodsDetail;

@end

@interface OrderGoodsInfoView : UIView

/** 设置商品信息Model */
@property (nonatomic, strong) OrderGoodsInfoModel *orderGoodInfoModel;

/** 设置申请退款页面商品信息Model */
@property (nonatomic, strong) ApplyRefundGoodsInfoModel *applyRefundGoodsInfoModel;

@property (nonatomic, weak) id<OrderGoodsInfoViewDelegate> delegate;

@end
