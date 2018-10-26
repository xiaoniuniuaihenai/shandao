//
//  GoodsConfirmOrderApi.m
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "GoodsConfirmOrderApi.h"

@interface GoodsConfirmOrderApi ()

/** 商品Id */
@property (nonatomic, copy) NSString *goodsId;
/** skuId */
@property (nonatomic, copy) NSString *skuId;
/** 商品个数 */
@property (nonatomic, copy) NSString *goodsCount;

@end

@implementation GoodsConfirmOrderApi

- (instancetype)initWithGoodsId:(NSString*)goodsId skuId:(NSString *)skuId goodsCount:(NSString *)goodsCount{
    if (self = [super init]) {
        _goodsId = goodsId;
        _skuId = skuId;
        _goodsCount = goodsCount;
    }
    return self;
}

- (NSString * )requestUrl{
    return @"/mall/getConfirmOrderInfo";
}

- (id)requestArgument{
    NSMutableDictionary * paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:self.goodsId forKey:@"goodsId"];
    [paramDict setValue:self.skuId forKey:@"skuId"];
    [paramDict setValue:self.goodsCount forKey:@"num"];
    return paramDict;
}


@end
