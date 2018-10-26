//
//  GoodsCategoryCollectionViewCell.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/4.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryGoodsInfoModel;
@class MallGoodsModel;

@interface GoodsCategoryCollectionViewCell : UICollectionViewCell

/** 分区页面Model */
@property (nonatomic, strong) CategoryGoodsInfoModel *categoryGoodsInfoModel;

/** 商城首页model */
@property (nonatomic, strong) MallGoodsModel *mallGoodsModel;

@end
