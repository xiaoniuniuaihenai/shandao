//
//  BannerGoodsFrame.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/13.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MallBannerGoodsModel;

@interface ZTMXFBannerGoodsFrame : NSObject

/** 数据模型 */
@property (nonatomic, strong) MallBannerGoodsModel *bannerGoodsModel;

/** title */
@property (nonatomic, assign) CGRect titleCellViewFrame;
/** 轮播图 */
@property (nonatomic, assign) CGRect cycleScrollViewFrame;
/** 商品CollectionView */
@property (nonatomic, assign) CGRect goodsCollectionViewFrame;
/** 间隔view */
@property (nonatomic, assign) CGRect gapViewFrame;

/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
