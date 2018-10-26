//
//  GoodsSkuPropertyModel.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsSkuPropertyModel : NSObject
/** 商品属性数组 */
@property (nonatomic, strong) NSArray *propertyList;
/** 商品规格SKU数组 */
@property (nonatomic, strong) NSArray *skuList;

@end

@interface GoodsPropertyValueModel : NSObject

/** 规格id */
@property (nonatomic, copy) NSString  *pid;
/** 规格名字 */
@property (nonatomic, copy) NSString  *value;

@end


//  商品属性Model
@interface GoodsPropertyModel : NSObject
/** 属性名 */
@property (nonatomic, copy) NSString  *name;
/** 属性值数组 */
@property (nonatomic, strong) NSArray<GoodsPropertyValueModel *>  *valueList;

@end

@interface GoodsPriceInfoModel : NSObject

/** 商品规格id */
@property (nonatomic, assign) long   skuId;
/** 规格id组合 */
@property (nonatomic, copy) NSString *propertyValueIds;
/** 库存 */
@property (nonatomic, assign) NSInteger stock;
/** 价格 */
@property (nonatomic, assign) double actualAmount;
/** 对应图片 */
@property (nonatomic, copy) NSString *picUrl;
/** 月供 */
@property (nonatomic, assign) double monthPay;
@end

