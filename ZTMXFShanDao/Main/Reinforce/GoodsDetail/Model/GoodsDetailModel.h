//
//  GoodsDetailModel.h
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/8.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsDetailInfoModel;

@interface GoodsDetailModel : NSObject

/** 商品详情 */
@property (nonatomic, strong) GoodsDetailInfoModel *goodsInfo;

/** 月供 */
@property (nonatomic, assign) double monthPay;
/** 默认属性值组合id */
@property (nonatomic, assign) long skuId;
/** 属性数组 */
@property (nonatomic, strong) NSArray *propertyValues;
/** 默认库存 */
@property (nonatomic, assign) NSInteger stock;
/** 默认商品价格 */
@property (nonatomic, assign) double price;
/** 活动提示 */
@property (nonatomic, copy) NSString *activityRemind;

@end

@interface GoodsDetailInfoModel : NSObject

/** 商品名称 */
@property (nonatomic, copy) NSString *name;
/** 商品id */
@property (nonatomic, assign) long goodsId;
/** 商品轮播图数组 */
@property (nonatomic, strong) NSArray *bannerImages;
/** 商品详情图片数组 */
@property (nonatomic, strong) NSArray *detailImages;

@end

@interface GoodsDetailImageInfoModel : NSObject

/** 详情图片 */
@property (nonatomic, copy) NSString *picUrl;
/** 图片宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片高度 */
@property (nonatomic, assign) CGFloat height;

@end

@interface GoodsDetailBannerImageModel : NSObject

/** 图片大图 */
@property (nonatomic, copy) NSString *goodsMainImg;
/** 商品缩略图 */
@property (nonatomic, copy) NSString *goodsDeputyImg;

@end
