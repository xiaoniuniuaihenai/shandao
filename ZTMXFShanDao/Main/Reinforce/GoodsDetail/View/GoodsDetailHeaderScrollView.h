//
//  GoodsDetailHeaderScrollView.h
//  ALAFanBei
//
//  Created by yangpenghua on 2017/9/2.
//  Copyright © 2017年 阿拉丁. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDCycleScrollView;
@class ALATitleValueCellView;
@class GoodsDetailModel;

@protocol GoodsDetailHeaderScrollViewDelegate <NSObject>

/** 点击选择规格框 */
- (void)goodsDetailHeaderScrollViewClickChoiseProperty;

@end

@interface GoodsDetailHeaderScrollView : UIScrollView

/** 商品详情数据model */
@property (nonatomic, strong) GoodsDetailModel  *goodsDetailModel;

@property (nonatomic, weak) id<GoodsDetailHeaderScrollViewDelegate> headerDelegate;

/** 配置选择规格属性 */
- (void)configGoodsPropertyName:(NSString *)propertyName;

@end
