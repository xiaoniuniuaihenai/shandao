//
//  GoodsSubmitOrderApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "GoodsSubmitOrderApi.h"
@interface GoodsSubmitOrderApi ()

/** 商品Id */
@property (nonatomic, copy) NSString *goodsId;
/** skuId */
@property (nonatomic, copy) NSString *skuId;
/** 商品个数 */
@property (nonatomic, copy) NSString *goodsCount;
/** 地址Id */
@property (nonatomic, copy) NSString *addressId;

@end

@implementation GoodsSubmitOrderApi

- (instancetype)initWithGoodsId:(NSString*)goodsId skuId:(NSString *)skuId goodsCount:(NSString *)goodsCount addressId:(NSString *)addressId{
    if (self = [super init]) {
        _goodsId = goodsId;
        _skuId = skuId;
        _goodsCount = goodsCount;
        _addressId = addressId;
    }
    return self;
}

- (NSString * )requestUrl{
    return @"/mall/generateOrder";
}

- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.goodsId forKey:@"goodsId"];
    [paramDict setValue:self.skuId forKey:@"skuId"];
    [paramDict setValue:self.goodsCount forKey:@"num"];
    [paramDict setValue:self.addressId forKey:@"addressId"];
    return paramDict;
}

@end
