//
//  GoodsConfirmOrderApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/10.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface GoodsConfirmOrderApi : BaseRequestSerivce

- (instancetype)initWithGoodsId:(NSString*)goodsId skuId:(NSString *)skuId goodsCount:(NSString *)goodsCount;

@end
