//
//  OrderGoodsInfoModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderGoodsInfoModel : NSObject

/** 商品Id */
@property (nonatomic, assign) long goodsId;
/** 商品名称 */
@property (nonatomic, copy) NSString *title;
/** 商品个数 */
@property (nonatomic, assign) NSInteger count;
/** 商品原价 */
@property (nonatomic, assign) double priceAmount;
/** 商品售价 */
@property (nonatomic, assign) double actualAmount;
/** 商品图片 */
@property (nonatomic, copy) NSString *goodsIcon;
/** 商品规格属性名称 */
@property (nonatomic, copy) NSString *propertyValueNames;

@end
