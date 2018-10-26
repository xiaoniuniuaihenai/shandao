//
//  GoodsSkuPropertyModel.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "GoodsSkuPropertyModel.h"

@implementation GoodsSkuPropertyModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"propertyList":[GoodsPropertyModel class], @"skuList":[GoodsPriceInfoModel class]};
}

@end


@implementation GoodsPropertyModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"valueList":[GoodsPropertyValueModel class]};
}
@end

@implementation GoodsPropertyValueModel

@end

@implementation GoodsPriceInfoModel

@end
