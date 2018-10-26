//
//  GoodsScanEventApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by yangpenghua on 2018/1/19.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"
typedef enum : NSUInteger {
    GoodsDetailBuyNow,          //  去购买
    GoodsDetailReturnBack,      //  点击返回
} GoodsDetailOutType;


@interface GoodsScanEventApi : BaseRequestSerivce

- (instancetype)initWithGoodsId:(NSString *)goodsId goodsDetailEvent:(GoodsDetailOutType)outType;

@end
