//
//  GoodsDetailViewModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsScanEventApi.h"
@class GoodsDetailModel;
@class GoodsSkuPropertyModel;

@protocol GoodsDetailViewModelDelegate <NSObject>

/** 获取商品详情信息成功 */
- (void)requestGoodsDetailInfoSuccess:(GoodsDetailModel *)goodsDetailModel;

/** 获取商品规格属性列表成功 */
- (void)requestGoodsSkuPropertyListSuccess:(GoodsSkuPropertyModel *)goodsSkuPropertyModel;

@end

@interface GoodsDetailViewModel : NSObject

/** 获取商品详情信息 */
- (void)requestGoodsDetailInfoWithGoodsId:(NSString *)goodsId;

/** 获取商品规格属性列表 */
- (void)requestGoodsSkuPropertyListWithGoodsId:(NSString *)goodsId;

/** 获取消费贷商品详情 */
- (void)requestConsumeGoodsDetailInfoWithGoodsId:(NSString *)goodsId;

/** 商品详情添加事件 */
- (void)goodsDetailAddScanEventWithGoodsId:(NSString *)goodsId outType:(GoodsDetailOutType)outType;

@property (nonatomic, weak) id<GoodsDetailViewModelDelegate> delegate;

@end
