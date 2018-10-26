//
//  ConsumeGoodsInfoApi.h
//  ZTMXFXunMiaoiOS
//
//  Created by panfei mao on 2018/1/29.
//  Copyright © 2018年 LSCredit. All rights reserved.
//

#import "BaseRequestSerivce.h"

@interface ZTMXFConsumeGoodsInfoApi : BaseRequestSerivce

- (instancetype)initWithGoodsId:(NSString *)goodsId;

@end
