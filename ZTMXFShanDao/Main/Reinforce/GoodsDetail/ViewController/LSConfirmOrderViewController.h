//
//  LSConfirmOrderViewController.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/5.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseViewController.h"
@class GoodsPriceInfoModel;

@interface LSConfirmOrderViewController : BaseViewController

/** 商品Id */
@property (nonatomic, copy) NSString *goodsId;
/** 所选商品skuModel */
@property (nonatomic, assign) long  skuId;
/** 所选商品规格属性名 */
@property (nonatomic, copy) NSString *selectGoodsProperty;
/** 商品数量 */
@property (nonatomic, copy) NSString *goodsCount;

@end
